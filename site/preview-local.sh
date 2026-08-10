#!/usr/bin/env bash
# ============================================================
#  preview-local.sh — fastest way to look at the site.
#
#  Unlike build-refs.sh, this does NOT use git worktrees, so it
#  shows your CURRENT WORKING TREE, uncommitted edits included.
#  It builds one unit at one level into a fake "main" ref and
#  generates the pages around it.
#
#  Usage:  ./site/preview-local.sh <unit-name> [more units...]
#  Then:   python3 -m http.server -d _site 8000
# ============================================================

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

[[ $# -ge 1 ]] || {
  echo "usage: ./site/preview-local.sh <unit-name> [more units...]" >&2
  exit 1
}

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

for unit in "$@"; do
  [[ -d "src/units/$unit" ]] || {
    echo "error: no such unit: src/units/$unit" >&2
    exit 1
  }
  ./build.sh unit "$unit" all
  ./build.sh unit "$unit" chapters \
    || echo "  (chapter split skipped — pypdf missing?)"
done

mkdir -p _site/v/main
cp -R dist/. _site/v/main/

# build_site.py reads main-<level>.typ from a worktree to recover chapter
# order and titles. Point it at the live source tree instead, via a
# symlink in a scratch directory — deliberately NOT inside the repo,
# since a link from the repo back to itself makes every recursive tool
# (grep -r, find, your editor's search) walk in circles.
REFS="$(mktemp -d)"
trap 'rm -rf "$REFS"' EXIT
ln -sfn "$ROOT" "$REFS/main"

"$PY" site/build_site.py --refs-dir "$REFS" --site _site

echo
echo "Preview ready. Run:  python3 -m http.server -d _site 8000"