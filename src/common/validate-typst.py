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
    quad wide qquad space thin med thick
    dot dots dot.c dots.c dot.v dot.h times div plus minus pm mp
    in notin subset supset subseteq union sect inter empty
    eq not neq approx equiv sim prop leq geq less gt lt
    arrow arrows mapsto to gets implies iff
    forall exists partial nabla infinity oo
    cases mat vec binom cal bb frak sans serif upright italic bold
    text op display inline script sscript
    star square checkmark circle bullet degree angle perp parallel
    left right lr mid
    NN ZZ QQ RR CC Re Im Arg conj cis num system sum prod
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


# Operator/spacing words that may legitimately follow a ")" in math.
_POST_PAREN_OK = set("""
dot quad wide qquad space thin med thick plus minus times div pm mp cdot
in notin subset supset union sect inter eq neq approx equiv sim prop
leq geq less gt lt and or mod dots dot.c dots.c arrow to gets implies iff
in.not eq.not gt.not lt.not subset.eq supset.eq
""".split())

# Names whose trailing "(" is a function call / structural group, so no
# multiplication dot belongs before it. p/q/r/f/g/h/P/Q/R are treated as
# function-ish (polynomial evaluation p(x), p(z_0) etc.).
_FUNC_NAMES = set("""
sin cos tan cot sec csc sinh cosh tanh arcsin arccos arctan exp ln log lg
lim liminf limsup max min sup inf det dim ker deg gcd lcm sqrt root abs
norm floor ceil frac binom cases mat vec lr mid Re Im Arg arg conj overline
underline hat bar tilde bb frak cal op text upright bold sans serif italic
sum prod p q r f g h P Q R x y z w u v k l
system num auto-parts underbrace overbrace cancel box cancel.to
rect stroke grid table image cal round dot.op
""".split())


def _subscript_func_before(text, i):
    """True if text[:i] ends with  <funcname>_<sub>  (e.g. 'log_2 ',
    'log_(10)') — i.e. the "(" at i is a function argument, not a
    multiplicative factor after a numeric subscript base."""
    return re.search(
        r"(log|ln|lg|sin|cos|tan|cot|sec|csc|exp|sum|prod|int|integral|lim|max|min)"
        r"((_|\^)(\([^()]*\)|[A-Za-z0-9.]+))+\s*$",
        text[:i],
    ) is not None


def check_unwrapped_figures(src, line_of):
    """Flag full #cplane(...) figures in theory context that are NOT
    wrapped in #only-theory[...] — they leak onto the exercise sheet and
    into the solutions booklet. #cplane-small(...) is exempt: it is meant
    for use inside an exercise's solution block, where exercise() already
    scopes it. A full #cplane inside an #ex(...) block is also fine."""
    import re as _re
    # extents of #ex(...)[...][...] blocks
    ex=[]
    for m in _re.finditer(r'#ex\(', src):
        i=m.end()-1; d=0
        while i < len(src):
            if src[i]=='(': d+=1
            elif src[i]==')':
                d-=1
                if d==0: break
            i+=1
        i+=1; blocks=0
        while blocks<2 and i<len(src):
            while i<len(src) and src[i] in ' \n\t': i+=1
            if i<len(src) and src[i]=='[':
                d=0
                while i<len(src):
                    if src[i]=='[': d+=1
                    elif src[i]==']':
                        d-=1
                        if d==0: break
                    i+=1
                i+=1; blocks+=1
            else: break
        ex.append((m.start(), i))
    errs=[]
    for m in _re.finditer(r'#cplane\(', src):
        p=m.start()
        if any(a<=p<b for a,b in ex):
            continue  # inside an exercise — scoped correctly
        pre=src[max(0,p-16):p]
        if '#only-theory[' not in pre:
            errs.append(f"line {line_of(p)}: theory #cplane not wrapped "
                        "in #only-theory[...] — it will leak to the sheet "
                        "and solutions")
    return errs


def check_mult_dots(src, regions, line_of):
    """Report likely-missing multiplication dots (house style §6)."""
    errs = []
    for kind, s, e, text in regions:
        if kind != "math":
            continue
        # ")(" adjacent parens — skip frak(X)(z)-style operator application
        for m in re.finditer(r"\)\s*\(", text):
            pre = text[max(0, m.start() - 8):m.start() + 1]
            if re.search(r"(frak|bb|cal|op|upright|bold)\([A-Za-z]\)$", pre):
                continue
            if _subscript_func_before(text, m.end() - 1):
                continue  # log_(10)(a) — base subscript then argument
            errs.append(f"line {line_of(s + m.start())}: '){text[m.end()-1]}' "
                        "missing dot between parentheses")
        # number directly before "("
        for m in re.finditer(r"([0-9])\s*\(", text):
            if _subscript_func_before(text, m.end() - 1):
                continue  # log_2 (8) — the digit is the base subscript
            errs.append(f"line {line_of(s + m.start())}: "
                        f"'{m.group(1)}(' missing dot before parenthesis")
        # non-keyword name directly before "(" (variable * paren)
        for m in re.finditer(r"(?<![_^A-Za-z.])([A-Za-z][A-Za-z]*)\s*\(", text):
            if m.start() > 0 and text[m.start()-1] in "_^":
                continue
            if m.group(1) in _FUNC_NAMES or m.group(1) in _POST_PAREN_OK:
                continue  # "dot (", "quad (", "in (" etc. are operators
            errs.append(f"line {line_of(s + m.start())}: "
                        f"'{m.group(1)}(' missing dot before parenthesis")
        # number / closing paren directly before bare imaginary unit i
        for m in re.finditer(r"(?<![A-Za-z_.])([0-9)])\s+i(?![A-Za-z.])", text):
            errs.append(f"line {line_of(s + m.start())}: "
                        f"'{m.group(1)} i' missing dot before imaginary unit")
        # subscripted variable directly before a bare letter (var * var)
        for m in re.finditer(r"[A-Za-z]_[0-9(][0-9)]* +([a-z])(?![A-Za-z.])", text):
            errs.append(f"line {line_of(s + m.start())}: "
                        "adjacent variables missing dot")
        # two adjacent bare single lowercase letters (var * var), e.g. "i s"
        for m in re.finditer(r"(?<![A-Za-z_.\\])([a-z]) ([a-z])(?![A-Za-z.])", text):
            errs.append(f"line {line_of(s + m.start())}: "
                        f"'{m.group(1)} {m.group(2)}' adjacent variables "
                        "missing dot")
        # single letter before a multi-char Greek symbol (i pi, n theta)
        for m in re.finditer(r"(?<![A-Za-z_.\\])([a-z]) +(pi|psi|phi|theta|rho|omega|sigma|tau|mu|nu|lambda|alpha|beta|gamma|delta|chi|xi|eta|zeta|kappa)(?![A-Za-z])", text):
            errs.append(f"line {line_of(s + m.start())}: "
                        f"'{m.group(1)} {m.group(2)}' adjacent variables missing dot")
        # sub/superscripted letter before a bare letter or Greek (c^2 s, x^2 y)
        for m in re.finditer(r"([a-z][_^][0-9A-Za-z]) +([a-z]|(pi|psi|phi|theta|rho|omega|sigma|tau|mu|nu|lambda|alpha|beta|gamma|delta|chi|xi|eta|zeta|kappa))(?![A-Za-z.])", text):
            errs.append(f"line {line_of(s + m.start())}: "
                        f"'{m.group(1)} {m.group(2)}' adjacent variables missing dot")
        # extra dot BEFORE a function keyword: "2 dot Re(", "x dot sin("
        for m in re.finditer(r"(?<![A-Za-z_.])([0-9A-Za-z]) dot\s+"
                             r"(Re|Im|Arg|sin|cos|tan|cot|log|ln|lg|exp)\b", text):
            errs.append(f"line {line_of(s + m.start())}: "
                        f"'dot {m.group(2)}' — no dot before a function keyword")
    return errs


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

    errs += check_mult_dots(src, regions, line_of)
    errs += check_unwrapped_figures(src, line_of)

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
