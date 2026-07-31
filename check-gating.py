#!/usr/bin/env python3
"""Find figures/tables/charts that will leak onto exercise sheets and
into solutions booklets because nothing gates them, and optionally fix
the mechanical case automatically.

WHY THIS CHECK EXISTS
    Most preamble environments (only-theory, definition, example,
    remark, warning, keybox, exploration, ...) self-gate: they check
    _ex-mode / _sol-mode internally and render nothing in those modes.
    A handful of primitives do NOT, by design -- data-table, bar-chart,
    fig, image, plot and friends are pure rendering calls, used BOTH
    inside theory (where the caller must gate them) and inside
    #ex(...)[...][...]  (where a table can be legitimate exercise
    content and must NOT be gated). There is no way to make these
    primitives self-gating without breaking every exercise that
    legitimately contains a table, so the leak has to be caught at the
    call site instead.

    The commonest way it happens: a block of #only-theory[...] prose
    introduces a table or chart, the block is closed right before the
    visual (because a table doesn't read as "prose"), and the visual
    is left bare immediately afterward.

HOW THE CHECK WORKS
    A single left-to-right scan tracks a stack of "scopes": every
    markup [...] group, tagged with whichever #identifier(...) or
    #identifier immediately opened it (or untagged, for a bare [...]
    used as a content block). A dangerous primitive is flagged unless
    SOME ancestor scope, at any depth, is tagged with a name that
    self-gates, or is #ex(...)/#exercise(...) -- whose TWO bracket
    groups (question, solution) are both treated as safe. Neutral
    layout wrappers (#align[...], #box[...], ...) are transparent: if
    a gate sits two levels further out, that still protects everything
    inside. Math regions ($...$) are skipped without touching the
    scope stack, so interval notation like $[a, b)$ is never mistaken
    for a scope.

    This is a heuristic, not a Typst parser. It has been tuned against
    real chapter files until it produced zero false positives on
    legitimate uses; treat findings as "look at this", not as
    certainly-a-bug.

HOW --fix WORKS
    Only for findings whose nearest enclosing NAMED scope is truly
    none (the "top level of file" case, the one this project has
    exclusively produced in practice). Each is fixed by wrapping the
    exact call -- from its leading # to the matching closing
    parenthesis -- in a fresh #only-theory[ ... ]. This never touches
    surrounding prose and is safe to apply without reading the rest of
    the file: it does not try to guess where an existing block
    "should" have been extended to, it just wraps the dangling call.

    Findings whose nearest scope is some OTHER non-gating name (a
    custom wrapper this script doesn't know about) are left for manual
    review; --fix does not touch them.

USAGE
    python3 check-gating.py ch-*.typ                 # report only
    python3 check-gating.py --fix ch-*.typ            # fix in place
    python3 check-gating.py --fix --dry-run ch-*.typ  # show diffs only
"""
import re, sys, difflib

DANGEROUS = {
    "data-table", "bar-chart", "fig", "image", "plot",
    "histogram", "boxplot", "dotplot", "scatter", "venn2", "prob-tree",
}
GATES = {
    "only-theory", "only-high", "only-basic", "definition", "example",
    "remark", "warning", "keybox", "exploration", "quotebox",
    "look-ahead", "ai-box", "toolbox", "abstraction-ladder", "sim-box",
}
EX_NAMES = {"ex", "exercise"}
IDENT = r"[A-Za-z_][A-Za-z0-9_-]*"


def strip_strings_and_comments(src):
    blank = lambda m: re.sub(r"[^\n]", " ", m.group(0))
    src = re.sub(r"```.*?```", blank, src, flags=re.S)
    src = re.sub(r"`[^`\n]*`", blank, src)
    src = re.sub(r"//[^\n]*", blank, src)
    src = re.sub(r'"(?:\\.|[^"\\])*"', blank, src)
    return src


def scan(raw):
    src = strip_strings_and_comments(raw)
    n = len(src)

    def line_of(pos):
        return src.count("\n", 0, pos) + 1

    stack = []
    findings = []
    i = 0
    in_math = False

    while i < n:
        c = src[i]

        if c == "\\":
            i += 2
            continue
        if c == "$":
            in_math = not in_math
            i += 1
            continue
        if in_math:
            i += 1
            continue

        if c == "#":
            m = re.match(IDENT, src[i + 1:])
            if not m:
                i += 1
                continue
            name = m.group(0)
            j = i + 1 + len(name)
            if j < n and src[j] == "(":
                depth, k = 1, j + 1
                while k < n and depth:
                    if src[k] == "(":
                        depth += 1
                    elif src[k] == ")":
                        depth -= 1
                    k += 1
                j = k
            call_end = j

            if name in DANGEROUS:
                safe = any(f["owner"] in GATES or f["owner"] in EX_NAMES
                           for f in stack)
                if not safe:
                    nearest = next((f["owner"] for f in reversed(stack)
                                     if f["owner"]), None)
                    findings.append(dict(line=line_of(i), name=name,
                                          nearest=nearest,
                                          start=i, end=call_end))

            k = j
            while k < n and src[k] in " \t\n":
                k += 1
            if k < n and src[k] == "[":
                stack.append({"owner": name})
                i = k + 1
                continue
            i = j
            continue

        if c == "[":
            stack.append({"owner": None})
            i += 1
            continue

        if c == "]":
            if stack:
                closed = stack.pop()
                if closed["owner"] in EX_NAMES:
                    k = i + 1
                    while k < n and src[k] in " \t\n":
                        k += 1
                    if k < n and src[k] == "[":
                        stack.append({"owner": closed["owner"]})
                        i = k + 1
                        continue
            i += 1
            continue

        i += 1

    return findings


def apply_fix(raw, findings):
    fixable = [f for f in findings if f["nearest"] is None]
    out = raw
    for f in sorted(fixable, key=lambda f: -f["start"]):
        call = out[f["start"]:f["end"]]
        replacement = "#only-theory[\n  " + call + "\n]"
        out = out[:f["start"]] + replacement + out[f["end"]:]
    return out, fixable


def main(argv):
    fix = "--fix" in argv
    dry_run = "--dry-run" in argv
    paths = [a for a in argv if not a.startswith("--")]
    if not paths:
        sys.exit(__doc__)

    total, total_fixed, total_manual = 0, 0, 0
    for path in paths:
        raw = open(path, encoding="utf-8").read()
        findings = scan(raw)
        if not findings:
            continue

        print(f"\n=== {path}")
        manual = [f for f in findings if f["nearest"] is not None]
        auto = [f for f in findings if f["nearest"] is None]
        for f in sorted(findings, key=lambda f: f["line"]):
            tag = "auto-fixable" if f["nearest"] is None else "MANUAL REVIEW"
            owner = f["nearest"] or "top level of file"
            print(f"  line {f['line']}: #{f['name']}(...) not gated "
                  f"(enclosing: {owner})  [{tag}]")
        total += len(findings)
        total_manual += len(manual)

        if fix and auto:
            fixed_src, fixed = apply_fix(raw, findings)
            if dry_run:
                diff = difflib.unified_diff(
                    raw.splitlines(keepends=True),
                    fixed_src.splitlines(keepends=True),
                    fromfile=path, tofile=path + " (fixed)")
                print("".join(diff))
            else:
                open(path, "w", encoding="utf-8").write(fixed_src)
                print(f"  -> wrote {len(fixed)} fix(es) to {path}")
            total_fixed += len(fixed)

    print(f"\n{total} finding(s) total "
          f"({total_fixed if fix else total - total_manual} "
          f"auto-fixable, {total_manual} need manual review)")


if __name__ == "__main__":
    main(sys.argv[1:])
