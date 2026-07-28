#!/usr/bin/env python3
"""Three-part validation pass for Typst chapter sources.

1. Bracket / dollar balance, via a single-pass state machine that knows
   about string literals, math mode, escaped dollars and line comments
   (a naive counter reports false positives on interval notation such
   as $[a, b)$, so intervals are only balanced *within* math regions).
2. Multi-letter identifier collisions in math mode -- bare runs of two
   or more letters that Typst will render as a product of italic
   variables unless they are a known symbol/operator name.
3. Unparenthesized multi-character exponents and subscripts.
"""

import re
import sys

KNOWN = set(
    """
    alpha beta gamma delta epsilon zeta eta theta iota kappa lambda mu nu xi
    omicron pi rho sigma tau upsilon phi chi psi omega Gamma Delta Theta Lambda
    Xi Pi Sigma Upsilon Phi Psi Omega
    sin cos tan cot sec csc sinh cosh tanh arcsin arccos arctan exp ln log lg
    lim liminf limsup max min sup inf det dim ker deg gcd lcm mod arg im id hom
    Pr tr sqrt root frac abs norm floor ceil round
    sum prod integral
    quad wide qquad space thin med thick
    dot dots dot.c dots.c dot.v dot.h times div plus minus pm mp
    in notin subset supset subseteq union sect inter empty
    emptyset nothing without setminus degree
    eq not neq approx equiv sim prop leq geq less gt lt
    arrow arrows mapsto to gets implies iff
    forall exists partial nabla infinity oo
    cases mat vec binom cal bb frak sans serif upright italic bold
    text op display inline script sscript
    star square checkmark circle bullet degree angle perp parallel
    left right lr mid slash
    NN ZZ QQ RR CC Re Im Arg conj cis num system
    underbrace overbrace overline underline hat bar tilde vec dot.double
    """.split()
)


def strip_line_comments(src: str) -> str:
    out, i, n = [], 0, len(src)
    in_str = False
    while i < n:
        c = src[i]
        if in_str:
            if c == "\\":
                out.append(src[i : i + 2])
                i += 2
                continue
            if c == '"':
                in_str = False
            out.append(c)
            i += 1
            continue
        if c == '"':
            in_str = True
            out.append(c)
            i += 1
            continue
        if c == "\\":
            out.append(src[i : i + 2])
            i += 2
            continue
        if src.startswith("//", i):
            j = src.find("\n", i)
            if j == -1:
                break
            out.append(" " * (j - i))
            i = j
            continue
        out.append(c)
        i += 1
    return "".join(out)


def scan(src: str):
    """Yield (kind, start, end, text) regions: 'math' or 'markup'."""
    src = strip_line_comments(src)
    i, n = 0, len(src)
    in_math = False
    start = 0
    in_str = False
    while i < n:
        c = src[i]
        if c == "\\":
            i += 2
            continue
        if in_str:
            if c == '"':
                in_str = False
            i += 1
            continue
        if c == '"' and not in_math:
            in_str = True
            i += 1
            continue
        if c == "$":
            yield ("math" if in_math else "markup", start, i, src[start:i])
            in_math = not in_math
            start = i + 1
        i += 1
    yield ("math" if in_math else "markup", start, n, src[start:n])
    if in_math:
        yield ("UNCLOSED", start, n, "")


def check(path: str) -> int:
    src = open(path, encoding="utf-8").read()
    errs = []
    regions = list(scan(src))

    if any(r[0] == "UNCLOSED" for r in regions):
        errs.append("unbalanced $ ... $ (odd number of dollar signs)")

    def line_of(pos):
        return src.count("\n", 0, pos) + 1

    def blank_strings(t):
        # Brackets inside a string literal are data, not syntax --
        # t.starts-with("(\"") in preamble.typ is the canonical case.
        return re.sub(r'"(?:\\.|[^"\\])*"', lambda m: " " * len(m.group(0)), t)

    # 1. bracket balance, per region
    clean = strip_line_comments(src)
    pairs = {")": "(", "]": "[", "}": "{"}
    # Inside math, () and [] are interchangeable: half-open interval
    # notation such as $(-pi, pi]$ and $[0, 2 pi)$ is correct Typst and
    # correct mathematics, and a strict pairing check flags every one of
    # them. Counts still have to balance, and {} stays strict.
    lax = {")": "(", "]": "(", "}": "{"}
    stack = []
    for kind, s, e, text in regions:
        if kind == "UNCLOSED":
            continue
        text = blank_strings(text) if kind == "markup" else text
        table = lax if kind == "math" else pairs
        norm = (lambda c: "(" if c == "[" else c) if kind == "math" else (
            lambda c: c
        )
        for k, ch in enumerate(text):
            if ch in "([{":
                stack.append((norm(ch), s + k))
            elif ch in ")]}":
                if not stack:
                    errs.append(f"line {line_of(s + k)}: stray '{ch}'")
                elif stack[-1][0] != table[ch]:
                    o, op = stack.pop()
                    errs.append(
                        f"line {line_of(s + k)}: '{ch}' closes '{o}' "
                        f"opened line {line_of(op)}"
                    )
                else:
                    stack.pop()
    for ch, pos in stack:
        errs.append(f"line {line_of(pos)}: unclosed '{ch}'")

    # 2. multi-letter runs in math mode
    for kind, s, e, text in regions:
        if kind != "math":
            continue
        # drop string literals and #-calls inside math
        t = re.sub(r'"[^"]*"', " ", text)
        t = re.sub(r"#[A-Za-z-]+", " ", t)
        for m in re.finditer(r"[A-Za-z][A-Za-z.]*[A-Za-z]", t):
            word = m.group(0)
            if word in KNOWN:
                continue
            if word.split(".")[0] in KNOWN:
                continue
            errs.append(
                f"line {line_of(s + m.start())}: multi-letter '{word}' "
                "in math mode"
            )

    # 3. unparenthesized multi-char sub/superscripts
    for kind, s, e, text in regions:
        if kind != "math":
            continue
        for m in re.finditer(r"[\^_]\s*([A-Za-z0-9]{2,})", text):
            errs.append(
                f"line {line_of(s + m.start())}: "
                f"unparenthesized '{m.group(0).strip()}'"
            )
        for m in re.finditer(r"[\^_]\s*-\s*[A-Za-z0-9]", text):
            errs.append(
                f"line {line_of(s + m.start())}: "
                f"unparenthesized negative '{m.group(0).strip()}'"
            )

    # 4. term-list items missing their colon
    #
    # Typst term lists are `/ Term: description`. Omit the colon and
    # the compiler reports "expected colon" -- a real syntax error
    # that nothing else here catches, because the line is perfectly
    # well-formed markup right up until Typst looks for the colon.
    # Easy to write by accident when the "term" is a whole sentence.
    for i, raw in enumerate(strip_line_comments(src).split("\n"), 1):
        t = raw.strip()
        if t.startswith("/ ") and ":" not in t:
            errs.append(
                f"line {i}: term-list item has no colon "
                f"(Typst needs '/ Term: description')"
            )

    print(f"=== {path}")
    if errs:
        for x in errs:
            print("  " + x)
    else:
        print("  clean")
    return len(errs)


if __name__ == "__main__":
    total = sum(check(p) for p in sys.argv[1:])
    print(f"\n{total} finding(s)")
