// ============================================================
//  review-sheet.typ — Sequences, Series & Proofs
//  Retention review (high-level course), ~6 months on.
//  Self-contained: compile directly with
//      typst compile review-sheet.typ
//
//  Toggle the answer key with the `solutions` flag below.
// ============================================================

#let solutions = false          // ← set to `true` for the teacher's copy

// ── Style ────────────────────────────────────────────────────
#let accent = rgb("#0097a7")    // teal

#set page(
  paper: "a4",
  margin: (top: 2cm, bottom: 2cm, left: 2.2cm, right: 2.2cm),
  numbering: "1",
  footer: context [
    #set text(size: 9pt, fill: luma(130))
    #line(length: 100%, stroke: 0.3pt + luma(190))
    #v(-4pt)
    #grid(
      columns: (1fr, 1fr),
      align(left)[Sequences, Series & Proofs — Review],
      align(right)[#counter(page).display("1")],
    )
  ],
)
#set text(font: "New Computer Modern", size: 11pt, lang: "en")
#set par(justify: true, leading: 0.65em)

// ── Helpers ──────────────────────────────────────────────────
#let seclet = state("seclet", "A")
#let qc     = counter("question")

// faint ruled writing space
#let space(n: 2, gap: 0.85cm) = {
  v(1cm)
  for i in range(n) {
    line(length: 100%, stroke: 0.4pt + luma(200))
    if i < n - 1 { v(gap) }
  }
  v(0.3cm)
}

// section header
#let part(letter, title) = {
  seclet.update(letter)
  qc.update(0)
  v(0.5cm)
  text(size: 13pt, weight: "bold", fill: accent)[Part #letter — #title]
  v(-3pt)
  line(length: 100%, stroke: 1pt + accent)
  v(0.25cm)
}

// numbered question (label e.g. "A1.")
#let q(body) = {
  qc.step()
  context block(width: 100%, breakable: true)[
    #grid(
      columns: (1.1cm, 1fr),
      column-gutter: 0.2cm,
      text(weight: "bold", fill: accent)[#seclet.get()#qc.display().]
      , body,
    )
  ]
  v(0.28cm)
}

// true/false line
#let tf(body) = {
  qc.step()
  context block(width: 100%, breakable: false)[
    #grid(
      columns: (1.1cm, 1fr, 2cm),
      column-gutter: 0.2cm,
      text(weight: "bold", fill: accent)[#seclet.get()#qc.display().],
      body,
      align(right)[#text(fill: luma(120), tracking: 0.12em)[T  /  F]],
    )
  ]
  v(0.18cm)
}

// multiple choice; pass the stem then 4 options as content
#let mc(stem, a, b, c, d) = {
  qc.step()
  context block(width: 100%, breakable: false)[
    #grid(
      columns: (1.1cm, 1fr),
      column-gutter: 0.2cm,
      text(weight: "bold", fill: accent)[#seclet.get()#qc.display().],
      [
        #stem
        #v(0.12cm)
        #grid(
          columns: (1fr, 1fr),
          row-gutter: 0.4em,
          [(a)#h(0.4em)#a], [(b)#h(0.4em)#b],
          [(c)#h(0.4em)#c], [(d)#h(0.4em)#d],
        )
      ],
    )
  ]
  v(0.2cm)
}

// ── Title block ──────────────────────────────────────────────
#align(center)[
  #text(size: 22pt, weight: "bold")[Sequences, Series & Proofs]
  #v(0.3em)
  #text(size: 13pt, fill: accent)[Review — what's still with you?]
]
#v(0.4cm)
#grid(
  columns: (auto, 5cm, 1fr, auto, 3cm),
  gutter: 0.7em,
  align(horizon)[#text(size: 11pt)[Name:]],
  align(horizon)[#line(length: 100%, stroke: 0.5pt + luma(120))],
  [],
  align(horizon)[#text(size: 11pt)[Class:]],
  align(horizon)[#line(length: 100%, stroke: 0.5pt + luma(120))],
)
#v(0.2cm)
#block(
  width: 100%, fill: rgb("#e0f7fa"), radius: 3pt,
  inset: (x: 12pt, y: 8pt), stroke: (left: 4pt + accent),
)[
  #text(size: 10pt)[
    This sheet revisits the chapter on sequences, series and proofs from earlier
    this year. Work through it without your notes first — the point is to see
    what's stuck. Show your reasoning where space is provided.
  ]
]

// ════════════════════════════════════════════════════════════
//  PART A — Concepts & Knowledge
// ════════════════════════════════════════════════════════════
#part("A", "Concepts & Knowledge")

#q[
  Define an *arithmetic sequence* and write down its explicit (general) formula
  for the $n$-th term.
  #space(n: 2)
]

#q[
  Define a *geometric sequence* and write down its explicit formula for the
  $n$-th term.
  #space(n: 2)
]

#q[
  State the formula for the sum $s_n = sum_(k=1)^n a_k$ of the first $n$ terms of
  (a) an *arithmetic* series, and (b) a *geometric* series.
  #space(n: 2)
]

#q[
  Under what condition does an *infinite* geometric series converge, and what is
  its limit?
  #space(n: 2)
]

#q[
  In your own words, explain the difference between an *explicit* and a
  *recursive* definition of a sequence.
  #space(n: 2)
]

#q[
  A sequence is said to be a *higher-order arithmetic sequence of order $k$*.
  What is special about its differences, and what kind of formula describes
  $a_n$?
  #space(n: 2)
]

#q[
  Name the two steps of a proof by *mathematical induction*.
  #space(n: 2)
]

// ════════════════════════════════════════════════════════════
//  PART B — True / False & Multiple Choice
// ════════════════════════════════════════════════════════════
#part("B", "True / False & Multiple Choice")

#text(weight: "bold")[True or false?] #h(0.5em) #text(fill: luma(110), size: 10pt)[(circle one)]
#v(0.25cm)

#tf[The sequence $2, 4, 8, 16, dots$ is arithmetic.]
#tf[If $|q| > 1$, the infinite geometric series $sum a_1 q^(n-1)$ converges.]
#tf[$display(sum_(k=1)^n k) = (n(n+1)) / 2$ for every natural number $n$.]
#tf[Taking the logarithm of every term of a geometric sequence of positive terms produces an arithmetic sequence.]
#tf[A sequence whose *second* differences are constant can always be described by a quadratic polynomial.]
#tf[Proof by contradiction and proof by induction are two names for the same method.]

#v(0.3cm)
#text(weight: "bold")[Multiple choice] #h(0.5em) #text(fill: luma(110), size: 10pt)[(one answer each)]
#v(0.25cm)

#mc(
  [The 10th term of the arithmetic sequence $3, 7, 11, dots$ is:],
  [$37$], [$39$], [$40$], [$43$],
)

#mc(
  [The common ratio of the geometric sequence $3/4, 1, 4/3, dots$ is:],
  [$1/4$], [$3/4$], [$4/3$], [$1/3$],
)

#mc(
  [The value of the infinite series $1 + 1/3 + 1/9 + dots$ is:],
  [$4/3$], [$3/2$], [$2$], [it diverges],
)

#mc(
  [Which sigma expression equals $3 + 5 + 7 + 9 + 11$?],
  [$display(sum_(k=1)^5 (2k-1))$], [$display(sum_(k=1)^5 (2k+1))$],
  [$display(sum_(k=2)^5 (2k-1))$], [$display(sum_(k=0)^5 (2k+1))$],
)

#mc(
  [The expression $3^(2n) + 7$ is divisible, for every $n in bb(N)$, by:],
  [$7$], [$8$], [$9$], [$16$],
)

// ════════════════════════════════════════════════════════════
//  PART C — Calculations
// ════════════════════════════════════════════════════════════
#part("C", "Calculations")

#q[
  For the arithmetic sequence with $a_1 = 5$ and $d = 4$, find $a_20$ and
  $s_20$.
  #space(n: 2)
]

#q[
  For the geometric sequence with $a_1 = 2$ and $q = 3$, find $a_6$ and $s_6$.
  #space(n: 2)
]

#q[
  Evaluate $display(sum_(k=1)^5 (2k + 1))$.
  #space(n: 2)
]

#q[
  Find the sum of all multiples of $3$ between $1$ and $100$.
  #space(n: 2)
]

#q[
  Evaluate the infinite geometric series $9 + 3 + 1 + 1/3 + dots$
  #space(n: 2)
]

#q[
  Write the repeating decimal $0.overline(27)$ as a fraction in lowest terms.
  #space(n: 2)
]

#q[
  The triangular numbers begin $1, 3, 6, 10, dots$ Give an explicit formula for
  the $n$-th term $T_n$, and use it to find $T_20$.
  #space(n: 2)
]

// ════════════════════════════════════════════════════════════
//  PART D — Advanced Applications
// ════════════════════════════════════════════════════════════
#part("D", "Advanced Applications")

#q[
  Three numbers form a geometric sequence. Their sum is $14$ and their product
  is $-1728$. Find the three numbers.
  #space(n: 3)
]

#q[
  Determine the *order* of the sequence $2, 5, 10, 17, 26, dots$ and find an
  explicit formula for $a_n$.
  #space(n: 3)
]

#q[
  A square has side $8 "cm"$. A new square is formed by joining the midpoints of
  its sides, and the process is repeated infinitely. Find the *total area* of all
  the squares (including the first).
  #space(n: 3)
]

#q[
  Prove that the sum of any three consecutive *even* integers is a multiple of
  $6$.
  #space(n: 3)
]

#q[
  Use mathematical induction to prove that
  $ sum_(k=1)^n (2k - 1) = n^2 quad "for all " n >= 1. $
  #space(n: 4)
]

#q[
  *Spot the flaw.* Find the error in the following "proof" that $2 = 1$.
  Assume $a = b$. Then
  $ a^2 = a b, quad a^2 - b^2 = a b - b^2, quad (a+b)(a-b) = b(a-b), $
  $ a + b = b, quad b + b = b, quad 2b = b, quad 2 = 1. $
  #space(n: 2)
]

#q[
  #text(fill: accent, weight: "bold")[★ Challenge.]
  Prove that no single arithmetic sequence can contain all three of $sqrt(2)$,
  $sqrt(3)$ and $sqrt(5)$ as terms.
  #space(n: 4)
]

// ════════════════════════════════════════════════════════════
//  SOLUTIONS  (teacher copy only)
// ════════════════════════════════════════════════════════════
#if solutions {
  pagebreak()
  text(size: 15pt, weight: "bold", fill: accent)[Answer Key]
  line(length: 100%, stroke: 1pt + accent)
  v(0.3cm)
  set enum(numbering: "1.")
  set par(leading: 0.6em)

  text(weight: "bold", fill: accent)[Part A — Concepts]
  list(
    [Difference between consecutive terms is constant, $a_(n+1) - a_n = d$;
     $a_n = a_1 + (n-1) d$.],
    [Ratio between consecutive terms is constant, $a_(n+1) \/ a_n = q$;
     $a_n = a_1 dot q^(n-1)$.],
    [(a) $s_n = n/2 (a_1 + a_n)$. #h(1em)
     (b) $s_n = a_1 dot (q^n - 1)/(q - 1)$ (for $q != 1$).],
    [Converges iff $|q| < 1$; the limit is $a_1 / (1 - q)$.],
    [Explicit: any term computed directly from $n$. Recursive: a starting value
     plus a rule giving the next term from previous one(s).],
    [The $k$-th differences are constant; $a_n$ is a polynomial in $n$ of
     degree $k$.],
    [Base case (true for $n = 1$ or $n_0$); inductive step
     ($P(n) => P(n+1)$).],
  )
  v(0.2cm)

  text(weight: "bold", fill: accent)[Part B — True/False & MC]
  v(0.1cm)
  [T/F: 1 *F* (geometric) · 2 *F* · 3 *T* · 4 *T* · 5 *T* · 6 *F*. \
   MC: 1 *(b)* $39$ · 2 *(c)* $4/3$ · 3 *(b)* $3/2$ ·
   4 *(b)* · 5 *(b)* $8$.]
  v(0.2cm)

  text(weight: "bold", fill: accent)[Part C — Calculations]
  list(
    [$a_20 = 5 + 19 dot 4 = 81$, #h(0.4em) $s_20 = 10(5 + 81) = 860$.],
    [$a_6 = 2 dot 3^5 = 486$, #h(0.4em)
     $s_6 = 2 dot (3^6 - 1)/(3 - 1) = 728$.],
    [$3 + 5 + 7 + 9 + 11 = 35$.],
    [Terms $3, 6, dots, 99$: $n = 33$, $s = 33/2 (3 + 99) = 1683$.],
    [$a_1 = 9$, $q = 1/3$: $S = 9 / (1 - 1/3) = 27/2 = 13.5$.],
    [$0.overline(27) = 27/99 = 3/11$.],
    [$T_n = (n(n+1))/2$; #h(0.4em) $T_20 = 210$.],
  )
  v(0.2cm)

  text(weight: "bold", fill: accent)[Part D — Advanced]
  list(
    [$8, -12, 18$ (or reversed). Ratio $q = -3/2$; check
     $8 - 12 + 18 = 14$, product $= -1728$.],
    [First differences $3, 5, 7, 9, dots$; second differences constant $= 2$,
     so *order 2*. Fitting a quadratic gives $a_n = n^2 + 1$.],
    [Each midpoint square has half the area of the previous, so areas are
     $64, 32, 16, dots$ The total is $64 / (1 - 1/2) = 128 "cm"^2$.],
    [Write them as $2n, 2n+2, 2n+4$. Sum $= 6n + 6 = 6(n+1)$, a multiple
     of $6$.],
    [Base $n = 1$: $1 = 1^2$. Step: assume $sum_(k=1)^n (2k-1) = n^2$; then
     adding the next term gives $n^2 + (2(n+1) - 1) = n^2 + 2n + 1 = (n+1)^2$.],
    [The step "$(a+b)(a-b) = b(a-b) => a + b = b$" divides by $a - b$. Since
     $a = b$, that factor is $0$ — division by zero.],
    [If all three were terms, then $sqrt(3) - sqrt(2) = p dot d$ and
     $sqrt(5) - sqrt(3) = r dot d$ for integers $p, r$ and common difference
     $d$. Then $(sqrt(5) - sqrt(3))/(sqrt(3) - sqrt(2)) = r/p$ would be
     rational, but the left side is irrational — a contradiction.],
  )
}
