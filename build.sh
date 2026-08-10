#!/usr/bin/env bash
# ============================================================
#  build.sh — build script for the Typst course materials
#
#  Assumed layout:
#    src/common/preamble.typ
#    src/units/<unit>/
#        ch-*.typ
#        main-basic.typ        main-high.typ
#        exercises-basic.typ   exercises-high.typ
#        solutions-basic.typ   solutions-high.typ
#        notebooks/            (optional — Jupyter notebooks)
#        data/                 (optional — CSV and other data files)
#    src/years/<name>.typ       (e.g. glf-y1.typ, spf-y1.typ)
#    tools/split-chapters.py    (used by "chapters" mode)
#    .venv/                     (optional — auto-detected, see Notes)
#
#  Outputs:
#    dist/<unit>/main-basic.pdf, main-high.pdf
#    dist/<unit>/exercises-basic.pdf, exercises-high.pdf
#    dist/<unit>/solutions-basic.pdf, solutions-high.pdf
#    dist/<unit>/<chapter>-basic.pdf, <chapter>-high.pdf  (standalone)
#    dist/<unit>/notebooks/, dist/<unit>/data/   (copied verbatim)
#    dist/years/<name>.pdf
#
#  Usage:
#    ./build.sh unit <unit-name> \
#        <full|exercises|solutions|assets|all|chapters>
#    ./build.sh year <year-name|all>
#    ./build.sh all                # "all" mode for every unit — NEVER
#                                   # touches src/years/ or splits
#                                   # chapters; both are opt-in
#    ./build.sh list                # show available units and year files
#
#  Examples:
#    ./build.sh unit algebra-functions all
#    ./build.sh unit sequences-series chapters   # opt-in, not part of "all"
#    ./build.sh unit distributions assets
#    ./build.sh year glf-y1
#    ./build.sh year all
#
#  Notes:
#    * "chapters" is opt-in and is NOT part of "all", for the same
#      reason year files are not: it is a convenience artefact, and a
#      failure in it must never cost you the lecture notes, exercise
#      sheets and solutions booklets that "all" exists to produce.
#    * "chapters" mode builds the level's full book and then CUTS it
#      into one PDF per chapter, rather than compiling each chapter on
#      its own. Every chapter file is therefore a literal excerpt: page
#      numbers, heading numbers and exercise numbers are exactly what
#      the full document produced, and nothing restarts at 1. It builds
#      main-<level>.pdf itself, so it still works as a standalone mode.
#    * Chapter starts are found in the PDF outline that Typst writes
#      from the document headings — no markers in the source, no
#      recompilation. Filenames come from the register_chapters(...)
#      list in that level's main-*.typ, matched to outline entries BY
#      TITLE, so a preface or appendix heading that is not a registered
#      chapter is skipped rather than shifting every filename by one.
#      That parsing no longer depends on how register_chapters(...) is
#      formatted: entries are matched across newlines inside the call,
#      so typstyle reflowing a long entry onto four lines is fine. It
#      does still require each entry to be a literal ("Title", "/root/
#      absolute/path") pair — a #let shortcut for the directory is not
#      evaluated and will not be seen.
#    * The splitter needs Python with pypdf. If a .venv/ exists at the
#      project root it is used automatically; otherwise python3 from
#      PATH. Set PYTHON_BIN to override either.
#          python3 -m venv .venv
#          .venv/bin/python -m pip install pypdf
#    * A cross-reference pointing OUT of a chapter still renders, but
#      its internal link target is no longer in the file — expected for
#      an excerpt, and the reason the full book stays the primary
#      artefact.
#    * "assets" mode copies a unit's notebooks/ and data/ folders into
#      dist/<unit>/ verbatim, so each built unit is one self-contained
#      folder that can be dropped on a server as it stands. A data file
#      used by a notebook therefore exists in two places (src and dist,
#      and possibly twice within src if the notebook keeps its own
#      copy so it runs standalone). That duplication is deliberate:
#      dist/ is a build artefact and src/ is the source of truth, so
#      the copies are never edited in dist/. Units with neither folder
#      skip the step silently, which is why "assets" is safe to run as
#      part of "all" for every unit.
#    * Year-file builds are always opt-in (`./build.sh year ...`) and
#      are never included in `./build.sh all`, since a full-year
#      binder's exercise numbering will not match the numbering in
#      that unit's own exercises-*.typ / solutions-*.typ — the two are
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
SPLITTER="$PROJECT_ROOT/tools/split-chapters.py"

# "chapters" mode cuts the built book rather than recompiling, and the
# splitter needs Python with pypdf.
#
# Prefer a project-local virtualenv if there is one. VS Code's
# interpreter picker only affects its debugger and newly-opened
# integrated terminals — it does NOT change which python3 is on PATH
# for a script launched from tasks.json. Resolving .venv here means the
# build behaves identically from a plain shell, from VS Code's
# terminal, and from a task, activated or not.
#
# An explicit PYTHON_BIN in the environment always wins.
if [[ -z "${PYTHON_BIN:-}" ]]; then
  if [[ -x "$PROJECT_ROOT/.venv/bin/python" ]]; then
    PYTHON_BIN="$PROJECT_ROOT/.venv/bin/python"          # macOS / Linux
  elif [[ -x "$PROJECT_ROOT/.venv/Scripts/python.exe" ]]; then
    PYTHON_BIN="$PROJECT_ROOT/.venv/Scripts/python.exe"   # Windows
  else
    PYTHON_BIN="python3"
  fi
fi

# ---- small helpers ------------------------------------------------

err() { echo "error: $*" >&2; exit 1; }

check_typst() {
  command -v typst >/dev/null 2>&1 || err "typst not found on PATH"
}

# Only called by modes that actually split, so a missing pypdf never
# blocks a plain `full` or `exercises` build.
check_splitter() {
  [[ -f "$SPLITTER" ]] || err "chapter splitter not found at $SPLITTER"
  command -v "$PYTHON_BIN" >/dev/null 2>&1 \
    || err "$PYTHON_BIN not found on PATH (set PYTHON_BIN to override)"
  "$PYTHON_BIN" -c "import pypdf" 2>/dev/null || err \
    "pypdf not available to $PYTHON_BIN
       install it with:  $PYTHON_BIN -m pip install pypdf
       or create a project venv:
           python3 -m venv .venv && .venv/bin/python -m pip install pypdf
       (build.sh picks up ./.venv automatically)"
}

usage() {
  cat <<'USAGE' >&2
Usage:
  ./build.sh unit <unit-name> <full|exercises|solutions|assets|all|chapters>
  ./build.sh year <year-name|all>
  ./build.sh all
  ./build.sh list

Examples:
  ./build.sh unit algebra-functions all
  ./build.sh unit sequences-series chapters   # opt-in, not part of "all"
  ./build.sh unit distributions assets
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
  # Per-level sheets, mirroring build_solutions below — the old single
  # exercises.typ is gone (sheet mode now respects level, so each
  # sheet's numbering matches its level's solutions booklet; see
  # STYLE_GUIDE.md §5). If a legacy exercises.typ is still present,
  # warn rather than silently build it — with the new preamble it
  # would compile as an Advanced-only sheet, which is never what a
  # file with that name was meant to be.
  local unit="$1"
  local dir="$UNITS_DIR/$unit"
  local level src
  if [[ -f "$dir/exercises.typ" ]]; then
    echo "  (warning: legacy $dir/exercises.typ found — rename to" \
      "exercises-high.typ and add exercises-basic.typ; skipping it)"
  fi
  for level in basic high; do
    src="$dir/exercises-$level.typ"
    if [[ ! -f "$src" ]]; then
      echo "  (skip: $src not found)"
      continue
    fi
    compile "$src" "$DIST_DIR/$unit/exercises-$level.pdf"
  done
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
  # Every chapter as an excerpt of the finished book.
  #
  # This used to compile each chapter standalone from a generated
  # wrapper that reset the heading counter. The numbering came out
  # right, but each chapter was compiled in isolation: cross-references
  # to other chapters dangled, and page numbers restarted at 1. Cutting
  # the built PDF instead means each chapter file IS the real document,
  # so every number in it — page, heading, exercise — is whatever the
  # full compilation produced.
  #
  # Chapter starts are located from the PDF outline that Typst writes
  # from the headings; see tools/split-chapters.py. Because the printed
  # page numbers live in the page content, extracting a page range
  # preserves them with no extra work.
  local unit="$1"
  local dir="$UNITS_DIR/$unit"
  local level main pdf
  local split_failed=0

  check_splitter

  for level in basic high; do
    main="$dir/main-$level.typ"
    if [[ ! -f "$main" ]]; then
      echo "  (skip: no main-$level.typ, so no chapter list for $level)"
      continue
    fi

    # Splitting needs the book, so build it if it is missing or stale.
    # Doing that here rather than requiring `full` first keeps
    # `chapters` usable on its own, exactly as it was before — while
    # the staleness check stops `all` from compiling the same book
    # twice. "Stale" means any .typ in the unit or in common/ is newer
    # than the PDF; -newer needs an existing reference file, hence the
    # -f guard, and `head -n 1` stands in for GNU find's -quit, which
    # BSD find on macOS does not have.
    pdf="$DIST_DIR/$unit/main-$level.pdf"
    if [[ -f "$pdf" ]] \
      && [[ -z "$(find "$dir" "$SRC_DIR/common" -name '*.typ' \
                    -newer "$pdf" -print 2>/dev/null | head -n 1)" ]]; then
      echo "  (up to date: $pdf)"
    else
      compile "$main" "$pdf"
    fi

    # `set -e` would otherwise abandon the whole build the moment the
    # splitter reports a problem for ONE level -- so a mismatched
    # heading in main-basic.typ would silently cost you the Advanced
    # chapter PDFs as well. The splitter exits non-zero when any
    # registered chapter could not be located in the PDF outline (it
    # prints an outline-vs-sources table saying which), so surface that
    # loudly and carry on to the next level.
    if ! "$PYTHON_BIN" "$SPLITTER" "$main" "$pdf" "$DIST_DIR/$unit" \
      "$level"; then
      echo "  (warning: chapter split incomplete for $level — see above)"
      split_failed=1
    fi
  done

  if [[ "$split_failed" -eq 1 ]]; then
    echo "  (chapter split finished with errors; the full books in" \
      "$DIST_DIR/$unit are unaffected)"
  fi
}

build_assets() {
  # Copy a unit's notebooks/ and data/ folders into dist/<unit>/ so the
  # built unit is self-contained. Nothing is compiled here.
  local unit="$1"
  local dir="$UNITS_DIR/$unit"
  local sub count
  for sub in notebooks data; do
    [[ -d "$dir/$sub" ]] || continue
    # Count real entries first. Globbing an empty directory would leave
    # the pattern unexpanded and hand cp a nonexistent path, which under
    # `set -e` aborts the whole build over an empty folder. -mindepth /
    # -maxdepth and the tr are for BSD find and BSD wc on macOS.
    count=$(find "$dir/$sub" -mindepth 1 -maxdepth 1 | wc -l | tr -d " ")
    if [[ "$count" -eq 0 ]]; then
      echo "  (skip: $dir/$sub is empty)"
      continue
    fi
    mkdir -p "$DIST_DIR/$unit/$sub"
    # The trailing "/." copies the *contents* of the folder, including
    # dotfiles, rather than nesting the folder inside itself on a second
    # run. -R rather than -r so a notebooks/ folder may hold subfolders;
    # both flags exist on BSD and GNU cp.
    cp -R "$dir/$sub/." "$DIST_DIR/$unit/$sub/"
    echo "  assets: $sub/ -> $DIST_DIR/$unit/$sub/ ($count item(s))"
  done
}

build_unit_all() {
  # Deliberately does NOT include build_chapters. Per-chapter PDFs are
  # excerpts of the book, useful now and then but never the thing you
  # actually hand out — and because "all" runs under `set -e`, having
  # them here meant any hiccup in the split (a missing pypdf, an
  # unexpected outline) aborted the run before the exercises and
  # solutions were built. The essential artefacts should not depend on
  # an optional convenience. Run `./build.sh unit <name> chapters`
  # when you want them.
  local unit="$1"
  echo "== unit: $unit =="
  build_full "$unit"
  build_exercises "$unit"
  build_solutions "$unit"
  build_assets "$unit"
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
      assets)    build_assets "$unit" ;;
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