#!/usr/bin/env bash
# ============================================================
#  build-refs.sh — compile every git ref the manifest pins.
#
#  For each distinct `ref:` in site/classes.yml this script
#  checks the repository out at that ref into a git worktree,
#  builds only the units that ref actually needs, and copies the
#  result to <site>/v/<ref-slug>/.
#
#  Usage:  ./site/build-refs.sh [site-dir] [refs-dir]
#  Default: _site  .refs
#
#  The worktrees are left in place on purpose — build_site.py
#  reads main-<level>.typ from them to recover chapter order and
#  chapter titles.
#
#  Typst version: each ref may carry its own .typst-version file.
#  That is what keeps an old snapshot rendering the way it did
#  when it was frozen, rather than the way today's Typst happens
#  to render it.  Refs with no such file fall back to
#  DEFAULT_TYPST_VERSION.
# ============================================================

set -euo pipefail

SITE="${1:-_site}"
REFS="${2:-.refs}"
DEFAULT_TYPST_VERSION="${DEFAULT_TYPST_VERSION:-0.13.1}"
TYPST_CACHE="${TYPST_CACHE:-$HOME/.cache/typst-bin}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$ROOT"
mkdir -p "$SITE" "$REFS" "$TYPST_CACHE"

# Prefer the project virtualenv, exactly as build.sh does, so these
# scripts behave the same whether or not the venv happens to be active
# in the shell you launched them from. CI has no .venv and falls through
# to the runner's python3.
if [[ -x "$ROOT/.venv/bin/python3" ]]; then
  PY="$ROOT/.venv/bin/python3"
else
  PY="$(command -v python3)"
fi

"$PY" -c 'import jinja2, yaml, markdown' 2>/dev/null || {
  echo "error: site dependencies missing for $PY" >&2
  echo "       $PY -m pip install -r site/requirements.txt" >&2
  exit 1
}

# build.sh looks at PYTHON_BIN before anything else, and a fresh git
# worktree has no .venv of its own.
export PYTHON_BIN="${PYTHON_BIN:-$PY}"

ensure_typst() {
  # Resolve the exact Typst a ref asks for. Three cases, in order:
  # the one already on PATH if it happens to match (the normal case on
  # your laptop), a previously cached download, or a fresh download.
  #
  # These are three separate `local` statements on purpose. Bash expands
  # every word of a `local` command BEFORE the builtin runs, so writing
  # `local v="$1" dir="$TYPST_CACHE/$v"` expands $v while it is still
  # unset — which under `set -u` aborts the script.
  local v="$1"
  local dir="$TYPST_CACHE/$v"
  local target=""

  if command -v typst >/dev/null 2>&1 \
    && [[ "$(typst --version 2>/dev/null | awk '{print $2}')" == "$v" ]]; then
    TYPST_BIN_DIR="$(cd "$(dirname "$(command -v typst)")" && pwd)"
    return
  fi

  if [[ ! -x "$dir/typst" ]]; then
    case "$(uname -s)-$(uname -m)" in
      Linux-x86_64) target=x86_64-unknown-linux-musl ;;
      Linux-aarch64 | Linux-arm64) target=aarch64-unknown-linux-musl ;;
      Darwin-arm64) target=aarch64-apple-darwin ;;
      Darwin-x86_64) target=x86_64-apple-darwin ;;
      *)
        echo "error: no Typst build known for $(uname -s)-$(uname -m);" >&2
        echo "       install typst $v yourself and put it on PATH" >&2
        exit 1
        ;;
    esac
    echo "  fetching typst $v ($target)"
    mkdir -p "$dir"
    curl -fsSL \
      "https://github.com/typst/typst/releases/download/v${v}/typst-${target}.tar.xz" \
      | tar -xJ -C "$dir" --strip-components=1
  fi
  TYPST_BIN_DIR="$dir"
}

while IFS=$'\t' read -r slug ref units; do
  [[ -n "$slug" ]] || continue
  echo "== ref: $ref  ->  /v/$slug =="

  tree="$REFS/$slug"
  if [[ ! -d "$tree" ]]; then
    git worktree add --detach --force "$tree" "$ref"
  fi

  version="$DEFAULT_TYPST_VERSION"
  [[ -f "$tree/.typst-version" ]] && \
    version="$(tr -d '[:space:]' < "$tree/.typst-version")"
  ensure_typst "$version"

  (
    cd "$tree"
    export PATH="$TYPST_BIN_DIR:$PATH"
    # Picked up by build.sh only if you add the --input line described in
    # site/README.md; harmless otherwise.
    export BUILD_VERSION="$ref"
    IFS=',' read -ra list <<< "$units"
    # ${list[@]+"${list[@]}"} rather than "${list[@]}": bash 3.2, which
    # is what macOS still ships, treats an empty array as unset under
    # `set -u`. A class with no units listed would abort the run.
    for unit in ${list[@]+"${list[@]}"}; do
      [[ -n "$unit" ]] || continue
      [[ -d "src/units/$unit" ]] || {
        echo "  (skip: $unit does not exist at $ref)"
        continue
      }
      ./build.sh unit "$unit" all
      # Per-chapter PDFs are a convenience; a failure here must not
      # cost us the notes, sheets and solutions already built.
      ./build.sh unit "$unit" chapters \
        || echo "  (warning: chapter split failed for $unit at $ref)"
    done
  )

  mkdir -p "$SITE/v/$slug"
  if [[ -d "$tree/dist" ]]; then
    cp -R "$tree/dist/." "$SITE/v/$slug/"
  else
    echo "  (warning: no dist/ produced at $ref)"
  fi
done < <("$PY" site/build_site.py --plan)

echo "Refs built."