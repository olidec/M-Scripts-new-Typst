#!/usr/bin/env python3
"""
check-leaks.py -- find content that will leak onto the exercise sheets
and into the solutions booklets.

Companion to validate-typst.py. That script checks whether a chapter is
syntactically sound; this one checks whether it is *mode*-sound.

Background
----------
preamble.typ suppresses theory content in sheet mode (_ex-mode) and
solutions mode (_sol-mode) in two ways:

  * automatically, inside an environment that calls _hide-aux():
    definition/theorem/example/remark/warning/proof/keybox/quotebox/
    exploration/look-ahead/toolbox/known-techniques/objectives/
    abstraction-ladder/only-theory/only-high/only-basic
  * automatically for headings, via the show rule in apply-base-style()

Everything else -- plain prose paragraphs, bullet lists, bold labels
like "*Method 1: Common Factor*", and the deliberately un-wrapped
figure helpers fig() / plot-graph() / image-grid() / bar-chart() /
histogram() / boxplot() / dotplot() -- renders in ALL THREE modes. A
bare #pagebreak() likewise fires on the sheet, producing a blank page.

So the rule this script enforces is:

    at chapter top level, the only things allowed are a suppressing
    environment, a heading, or an #ex(...) call.

Point it at CHAPTER files. Running it over preamble.typ is meaningless
-- that file is all definitions, and a definition is not content.

Usage
-----
    python3 check-leaks.py src/units/*/ch-*.typ
    python3 check-leaks.py --quiet src/units/**/*.typ   # only failures

Exit status is 1 if anything leaks, so it can gate a commit hook.
"""

import re
import sys

# Calls that render identically in notes, sheet and solutions, and so
# must be wrapped in #only-theory[...] when they are theory content.
NON_SUPPRESSING = (
    "#pagebreak", "#v(", "#h(", "#linebreak",
    "#image", "#fig(", "#plot-graph", "#image-grid",
    "#bar-chart", "#histogram", "#boxplot", "#dotplot",
    "#data-table", "#table(", "#grid(", "#parts(", "#auto-parts",
    "#align(", "#block(",
)

# Top-level code that is legitimately mode-agnostic.
ALLOWED_PREFIXES = (
    "#import", "#show", "#let", "#set",
    "#ex(", "#exercise(", "#print-hints", "#print-vocab",
    "#register_chapters", "#include_chapters", "#set-level",
    "#set-subject-name",
)


def top_level_lines(text):
    """Yield (lineno, line, at_top_level) tracking [], () and {} nesting.

    String, math ($...$), escape and line-comment regions are handled so
    that a URL containing '//' or an interval like $[a,b)$ does not throw
    the depth counter off -- both were false-positive sources in naive
    versions of this check.
    """
    bracket = paren = brace = 0
    in_math = in_str = False
    for lineno, line in enumerate(text.split("\n"), start=1):
        start_depth = bracket + paren + brace
        i = 0
        while i < len(line):
            c = line[i]
            if c == "\\":
                i += 2
                continue
            if in_str:
                if c == '"':
                    in_str = False
                i += 1
                continue
            if line[i:i + 2] == "//" and not in_math:
                break
            if c == '"' and not in_math:
                in_str = True
                i += 1
                continue
            if c == "$":
                in_math = not in_math
            elif not in_math:
                if c == "[":
                    bracket += 1
                elif c == "]":
                    bracket -= 1
                elif c == "(":
                    paren += 1
                elif c == ")":
                    paren -= 1
                elif c == "{":
                    brace += 1
                elif c == "}":
                    brace -= 1
            i += 1
        yield lineno, line, start_depth == 0


def scan(path):
    findings = []
    with open(path, encoding="utf-8") as fh:
        text = fh.read()
    for lineno, line, at_top in top_level_lines(text):
        if not at_top:
            continue
        s = line.strip()
        if not s or s.startswith("//"):
            continue
        if s.startswith("="):                     # headings self-suppress
            continue
        if s.startswith("#"):
            if s.startswith(ALLOWED_PREFIXES):
                continue
            if s.startswith(NON_SUPPRESSING):
                findings.append((lineno, "figure/layout", s))
            continue
        findings.append((lineno, "bare prose", s))
    return findings


def main(argv):
    quiet = "--quiet" in argv
    paths = [a for a in argv if not a.startswith("-")]
    if not paths:
        print(__doc__.strip())
        return 2

    total = 0
    for path in paths:
        found = scan(path)
        total += len(found)
        if found:
            print(f"\n{path}: {len(found)} leaking line(s)")
            for lineno, kind, s in found:
                print(f"  {lineno:5d}  {kind:14s} {s[:78]}")
        elif not quiet:
            print(f"{path}: clean")

    print(f"\n{total} leaking line(s) total")
    print("Fix by wrapping each in #only-theory[...] "
          "(or, for a figure that belongs to an exercise, "
          "by moving it inside that exercise's question body).")
    return 1 if total else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
