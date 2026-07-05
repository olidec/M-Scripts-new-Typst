#!/usr/bin/env bash
# ============================================================
#  build.sh — build script for the Typst course materials
#
#  Assumed layout:
#    src/common/preamble.typ
#    src/units/<unit>/
#        ch-*.typ
#        main-basic.typ        main-high.typ
#        exercises.typ
#        solutions-basic.typ   solutions-high.typ
#    src/years/<name>.typ       (e.g. glf-y1.typ, spf-y1.typ)
#
#  Outputs:
#    dist/<unit>/main-basic.pdf, main-high.pdf
#    dist/<unit>/exercises.pdf
#    dist/<unit>/solutions-basic.pdf, solutions-high.pdf
#    dist/<unit>/<chapter>-basic.pdf, <chapter>-high.pdf  (standalone)
#    dist/years/<name>.pdf
#
#  Usage:
#    ./build.sh unit <unit-name> <full|chapters|exercises|solutions|all>
#    ./build.sh year <year-name|all>
#    ./build.sh all                # "all" mode for every unit — NEVER
#                                   # touches src/years/, which is opt-in
#    ./build.sh list                # show available units and year files
#
#  Examples:
#    ./build.sh unit algebra-functions all
#    ./build.sh unit sequences-series chapters
#    ./build.sh year glf-y1
#    ./build.sh year all
#
#  Notes:
#    * "chapters" mode compiles every chapter standalone, once per
#      level, with correct chapter-heading numbering. It does this by
#      generating a throwaway wrapper file next to the chapter (same
#      folder, so relative imports resolve exactly as they do for
#      main-basic.typ / main-high.typ), setting the heading counter
#      to that chapter's index in the level's chapter list, then
#      deleting the wrapper immediately after compiling.
#    * The chapter list for a level is read directly out of that
#      level's main-*.typ file, by looking for register_chapters(...)
#      entries. This assumes the project convention of one entry per
#      line, each trimmed line starting with ("  — exactly how every
#      main-*.typ file in this project is written. If you reformat an
#      entry onto multiple lines, this script won't see it.
#    * Year-file builds are always opt-in (`./build.sh year ...`) and
#      are never included in `./build.sh all`, since a full-year
#      binder's exercise numbering will not match the numbering in
#      that unit's own exercises.typ / solutions-*.typ — the two are
#      intentionally independent compilations. See STYLE_GUIDE.md.
# ============================================================

set -euo pipefail

SRC_DIR="src"
DIST_DIR="dist"
UNITS_DIR="$SRC_DIR/units"
YEARS_DIR="$SRC_DIR/years"

# Resolve the project root as the directory this script itself lives in,
# rather than assuming the caller's cwd — this is what gets passed to
# `typst --root`. Without an explicit --root, Typst defaults the project
# root to the directory of whichever file is being compiled, which then
# rejects any "../" import that climbs above that file's own folder with
# "failed to load file (access denied)" — not a real permissions issue,
# just Typst's sandbox refusing to resolve outside the assumed root.
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

TYPST_FLAGS=(--root "$PROJECT_ROOT" --diagnostic-format short)

# ---- small helpers ------------------------------------------------

err() { echo "error: $*" >&2; exit 1; }

check_typst() {
  command -v typst >/dev/null 2>&1 || err "typst not found on PATH"
}

usage() {
  cat <<'USAGE' >&2
Usage:
  ./build.sh unit <unit-name> <full|chapters|exercises|solutions|all>
  ./build.sh year <year-name|all>
  ./build.sh all
  ./build.sh list

Examples:
  ./build.sh unit algebra-functions all
  ./build.sh unit sequences-series chapters
  ./build.sh year glf-y1
  ./build.sh year all
USAGE
  exit 1
}

compile() {
  # compile <src.typ> <out.pdf>
  local src="$1" out="$2"
  mkdir -p "$(dirname "$out")"
  echo "  compiling $src -> $out"
  typst compile "${TYPST_FLAGS[@]}" "$src" "$out"
}

# extract_chapters <main-file.typ>
# Prints, one per line, the chapter filename (2nd element) of every
# register_chapters(...) entry, in the order they appear.
extract_chapters() {
  local main_file="$1"
  grep -oP '^\s*\(\s*"[^"]*"\s*,\s*"\K[^"]+' "$main_file" || true
}

unit_exists() {
  [[ -d "$UNITS_DIR/$1" ]] || err "no such unit: $1 (looked in $UNITS_DIR/$1)"
}

# ---- per-unit build modes -----------------------------------------

build_full() {
  # lecture notes: main-basic.typ + main-high.typ
  local unit="$1"
  local dir="$UNITS_DIR/$unit"
  local level main
  for level in basic high; do
    main="$dir/main-$level.typ"
    if [[ ! -f "$main" ]]; then
      echo "  (skip: $main not found)"
      continue
    fi
    compile "$main" "$DIST_DIR/$unit/main-$level.pdf"
  done
}

build_exercises() {
  local unit="$1"
  local dir="$UNITS_DIR/$unit"
  local src="$dir/exercises.typ"
  if [[ ! -f "$src" ]]; then
    echo "  (skip: $src not found)"
    return 0
  fi
  compile "$src" "$DIST_DIR/$unit/exercises.pdf"
}

build_solutions() {
  local unit="$1"
  local dir="$UNITS_DIR/$unit"
  local level src
  for level in basic high; do
    src="$dir/solutions-$level.typ"
    if [[ ! -f "$src" ]]; then
      echo "  (skip: $src not found)"
      continue
    fi
    compile "$src" "$DIST_DIR/$unit/solutions-$level.pdf"
  done
}

build_chapters() {
  # Every chapter, standalone, once per level, numbered correctly.
  local unit="$1"
  local dir="$UNITS_DIR/$unit"
  local level main chapters chapter wrapper idx

  for level in basic high; do
    main="$dir/main-$level.typ"
    if [[ ! -f "$main" ]]; then
      echo "  (skip: no main-$level.typ, so no chapter list for $level)"
      continue
    fi

    mapfile -t chapters < <(extract_chapters "$main")
    if [[ ${#chapters[@]} -eq 0 ]]; then
      echo "  (skip: no register_chapters entries found in $main)"
      continue
    fi

    idx=0
    for chapter in "${chapters[@]}"; do
      wrapper="$dir/_wrapper-${chapter}-${level}.typ"
      cat > "$wrapper" <<EOF
// auto-generated by build.sh — safe to delete, removed automatically
#import "../../common/preamble.typ": *
#set-level("$level")
#counter(heading).update($idx)
#include "${chapter}.typ"
EOF
      compile "$wrapper" "$DIST_DIR/$unit/${chapter}-${level}.pdf"
      rm -f "$wrapper"
      idx=$((idx + 1))
    done
  done
}

build_unit_all() {
  local unit="$1"
  echo "== unit: $unit =="
  build_full "$unit"
  build_chapters "$unit"
  build_exercises "$unit"
  build_solutions "$unit"
}

# ---- year builds (always opt-in) ----------------------------------

build_year() {
  local name="$1"
  local src="$YEARS_DIR/$name.typ"
  [[ -f "$src" ]] || err "no such year file: $src"
  compile "$src" "$DIST_DIR/years/$name.pdf"
}

build_year_all() {
  [[ -d "$YEARS_DIR" ]] || err "no $YEARS_DIR directory found"
  local f found=0
  for f in "$YEARS_DIR"/*.typ; do
    [[ -e "$f" ]] || continue
    found=1
    build_year "$(basename "${f%.typ}")"
  done
  [[ "$found" -eq 1 ]] || echo "  (no year files found in $YEARS_DIR)"
}

# ---- listing --------------------------------------------------------

list_all() {
  echo "Units (in $UNITS_DIR):"
  if [[ -d "$UNITS_DIR" ]]; then
    local d
    for d in "$UNITS_DIR"/*/; do
      [[ -d "$d" ]] || continue
      echo "  - $(basename "$d")"
    done
  else
    echo "  (none — $UNITS_DIR does not exist yet)"
  fi
  echo
  echo "Year files (in $YEARS_DIR):"
  if [[ -d "$YEARS_DIR" ]]; then
    local f
    for f in "$YEARS_DIR"/*.typ; do
      [[ -e "$f" ]] || continue
      echo "  - $(basename "${f%.typ}")"
    done
  else
    echo "  (none — $YEARS_DIR does not exist yet)"
  fi
}

# ---- entry point ------------------------------------------------------

check_typst

case "${1:-}" in
  unit)
    unit="${2:-}"
    mode="${3:-}"
    [[ -n "$unit" && -n "$mode" ]] || usage
    unit_exists "$unit"
    case "$mode" in
      full)      build_full "$unit" ;;
      chapters)  build_chapters "$unit" ;;
      exercises) build_exercises "$unit" ;;
      solutions) build_solutions "$unit" ;;
      all)       build_unit_all "$unit" ;;
      *) usage ;;
    esac
    ;;
  year)
    target="${2:-}"
    [[ -n "$target" ]] || usage
    if [[ "$target" == "all" ]]; then
      build_year_all
    else
      build_year "$target"
    fi
    ;;
  all)
    [[ -d "$UNITS_DIR" ]] || err "no $UNITS_DIR directory found"
    d=""
    for d in "$UNITS_DIR"/*/; do
      [[ -d "$d" ]] || continue
      build_unit_all "$(basename "$d")"
    done
    ;;
  list)
    list_all
    ;;
  *)
    usage
    ;;
esac

echo "Done."