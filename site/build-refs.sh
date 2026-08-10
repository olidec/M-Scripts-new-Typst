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

# chapter splitting needs pypdf; build.sh honours PYTHON_BIN over
# any .venv, which a fresh worktree will not have anyway.
export PYTHON_BIN="${PYTHON_BIN:-$(command -v python3)}"

ensure_typst() {
  local v="$1" dir="$TYPST_CACHE/$v"
  if [[ ! -x "$dir/typst" ]]; then
    echo "  fetching typst $v"
    mkdir -p "$dir"
    curl -fsSL \
      "https://github.com/typst/typst/releases/download/v${v}/typst-x86_64-unknown-linux-musl.tar.xz" \
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
    for unit in "${list[@]}"; do
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
done < <(python3 site/build_site.py --plan)

echo "Refs built."
