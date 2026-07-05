// ============================================================
//  review-sheet.typ — Sequences, Series & Proofs
//  Retention review (high-level course), ~6 months on.
//  Questions are NEW — not drawn from the lecture notes.
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
  v(0.15cm)
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
  Consider the sequence given by $a_n = 5 - 2n$. Is it arithmetic, geometric,
  both, or neither? State the relevant constant ($d$ or $q$) and justify briefly.
  #space(n: 2)
]

#q[
  A sequence is a *higher-order arithmetic sequence of order $k$*. What is special
  about its differences, and what kind of formula describes $a_n$?
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

#tf[The sequence $81, 27, 9, 3, dots$ is geometric with ratio $q = 1/3$.]
#tf[Every infinite arithmetic series with $d != 0$ diverges.]
#tf[If the first differences of a sequence are $4, 6, 8, 10, dots$, the sequence can be modeled by a quadratic polynomial in $n$.]
#tf[The infinite series $1 - 1 + 1 - 1 + dots$ has the value $0$.]
#tf[In a proof by contradiction you begin by assuming that the statement you wish to prove is false.]
#tf[A recursive definition lets you write down the 100th term without computing any earlier terms.]

#v(0.3cm)
#text(weight: "bold")[Multiple choice] #h(0.5em) #text(fill: luma(110), size: 10pt)[(one answer each)]
#v(0.25cm)

#mc(
  [The 12th term of the arithmetic sequence $7, 4, 1, dots$ is:],
  [$-20$], [$-23$], [$-26$], [$-29$],
)

#mc(
  [In a geometric sequence $a_2 = 6$ and $a_5 = 162$. The common ratio $q$ is:],
  [$2$], [$3$], [$9$], [$27$],
)

#mc(
  [The value of the infinite series $4 - 2 + 1 - 1/2 + dots$ is:],
  [$2$], [$8/3$], [$8$], [it diverges],
)

#mc(
  [Which sigma expression equals $4 + 7 + 10 + 13$?],
  [$display(sum_(k=1)^4 (3k + 1))$], [$display(sum_(k=1)^4 (3k - 1))$],
  [$display(sum_(k=0)^3 (3k + 1))$], [$display(sum_(k=1)^5 (3k + 1))$],
)

#mc(
  [For every natural number $n$, the quantity $n^2 + n$ is always:],
  [even], [odd], [prime], [a perfect square],
)

// ════════════════════════════════════════════════════════════
//  PART C — Calculations
// ════════════════════════════════════════════════════════════
#part("C", "Calculations")

#q[
  For the arithmetic sequence with $a_1 = -3$ and $d = 7$, find $a_15$ and
  $s_15$.
  #space(n: 2)
]

#q[
  For the geometric sequence with $a_1 = 5$ and $q = 2$, find $a_8$ and $s_8$.
  #space(n: 2)
]

#q[
  Evaluate $display(sum_(k=1)^6 (3k - 2))$.
  #space(n: 2)
]

#q[
  Find the sum of all even numbers from $2$ to $200$ inclusive.
  #space(n: 2)
]

#q[
  Evaluate the infinite geometric series $12 + 8 + 16/3 + dots$
  #space(n: 2)
]

#q[
  Write the repeating decimal $0.overline(45)$ as a fraction in lowest terms.
  #space(n: 2)
]

#q[
  A geometric sequence satisfies $a_3 = 12$ and $a_6 = 96$. Find $a_1$ and the
  common ratio $q$.
  #space(n: 2)
]

// ════════════════════════════════════════════════════════════
//  PART D — Advanced Applications
// ════════════════════════════════════════════════════════════
#part("D", "Advanced Applications")

#q[
  A ball is dropped from a height of $2 "m"$. After each bounce it returns to
  $3/5$ of its previous height. Find the *total vertical distance* the ball
  travels before coming to rest.
  #space(n: 3)
]

#q[
  Determine the *order* of the sequence $3, 8, 15, 24, 35, dots$ and find an
  explicit formula for $a_n$.
  #space(n: 3)
]

#q[
  An equilateral triangle has side $9 "cm"$. A second triangle is formed by
  joining the midpoints of its sides, then a third inside that, and so on
  infinitely. Find (a) the total perimeter and (b) the total area of *all* the
  triangles.
  #space(n: 3)
]

#q[
  Prove that the sum of any two *consecutive* triangular numbers,
  $T_n + T_(n+1)$, is a perfect square. (Recall $T_n = (n(n+1))/2$.)
  #space(n: 3)
]

#q[
  Use mathematical induction to prove that
  $ sum_(k=1)^n k(k+1) = (n(n+1)(n+2))/3 quad "for all " n >= 1. $
  #space(n: 4)
]

#q[
  A student claims: "$n^2 + n + 41$ is prime for every natural number $n$,
  because it gives a prime for $n = 1, 2, 3, dots, 10$." Explain why this
  reasoning is *not* a valid proof. (Challenge: find a value of $n$ for which the
  claim fails.)
  #space(n: 3)
]

#q[
  #text(fill: accent, weight: "bold")[★ Challenge.]
  Find a closed-form expression for
  $ S_n = sum_(k=1)^n k dot 2^k = 1 dot 2 + 2 dot 4 + 3 dot 8 + dots + n dot 2^n. $
  #text(size: 9pt, fill: luma(110))[Hint: compute $2 S_n - S_n$, as in the chessboard derivation.]
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
    [Arithmetic, with $d = -2$ (terms $3, 1, -1, -3, dots$). Not geometric, since
     the ratio is not constant.],
    [The $k$-th differences are constant; $a_n$ is a polynomial in $n$ of
     degree $k$.],
    [Base case (true for $n = 1$ or some $n_0$); inductive step
     ($P(n) => P(n+1)$).],
  )
  v(0.2cm)

  text(weight: "bold", fill: accent)[Part B — True/False & MC]
  v(0.1cm)
  [T/F: 1 *T* · 2 *T* · 3 *T* · 4 *F* (partial sums are $1, 0, 1, 0, dots$ —
   no limit) · 5 *T* · 6 *F*. \
   MC: 1 *(c)* $-26$ · 2 *(b)* $3$ · 3 *(b)* $8/3$ · 4 *(a)* · 5 *(a)* even
   (since $n^2 + n = n(n+1)$).]
  v(0.2cm)

  text(weight: "bold", fill: accent)[Part C — Calculations]
  list(
    [$a_15 = -3 + 14 dot 7 = 95$, #h(0.4em)
     $s_15 = 15/2(-3 + 95) = 690$.],
    [$a_8 = 5 dot 2^7 = 640$, #h(0.4em)
     $s_8 = 5 dot (2^8 - 1)/(2 - 1) = 1275$.],
    [$1 + 4 + 7 + 10 + 13 + 16 = 51$.],
    [Terms $2, 4, dots, 200$: $n = 100$, $s = 100/2(2 + 200) = 10100$.],
    [$a_1 = 12$, $q = 2/3$: $S = 12 / (1 - 2/3) = 36$.],
    [$0.overline(45) = 45/99 = 5/11$.],
    [$q^3 = a_6 \/ a_3 = 96/12 = 8$, so $q = 2$; then
     $a_1 = a_3 \/ q^2 = 12/4 = 3$.],
  )
  v(0.2cm)

  text(weight: "bold", fill: accent)[Part D — Advanced]
  list(
    [Drop $= 2$. Bounce heights $1.2, 0.72, dots$ sum to
     $1.2 / (1 - 0.6) = 3$. Total $= 2 + 2 dot 3 = 8 "m"$.],
    [First differences $5, 7, 9, 11$; second differences constant $= 2$, so
     *order 2*. Fitting a quadratic gives $a_n = n^2 + 2n = n(n+2)$.],
    [Side ratio $1/2$ each step. (a) Perimeters $27, 13.5, dots$ sum to
     $27 / (1 - 1/2) = 54 "cm"$. (b) Areas shrink by $1/4$ each step; with
     $A_1 = (sqrt(3)/4) dot 81$, total $= A_1 /(1 - 1/4) = 27 sqrt(3) approx
     46.8 "cm"^2$.],
    [$T_n + T_(n+1) = (n(n+1))/2 + ((n+1)(n+2))/2
     = ((n+1)(n + n + 2))/2 = (n+1)^2$, a perfect square.],
    [Base $n = 1$: $1 dot 2 = 2 = (1 dot 2 dot 3)/3$. Step: assume the formula
     for $n$; then $S_(n+1) = S_n + (n+1)(n+2)
     = (n+1)(n+2)(n/3 + 1) = ((n+1)(n+2)(n+3))/3$.],
    [Checking finitely many cases never proves a statement for *all* $n$ —
     induction requires the implication $P(n) => P(n+1)$, not a list of examples.
     The claim fails first at $n = 40$: $40^2 + 40 + 41 = 1681 = 41^2$
     (it also fails at $n = 41$).],
    [$2 S_n - S_n = S_n$. Writing the two sums shifted gives
     $S_n = n dot 2^(n+1) - (2^(n+1) - 2) = (n - 1) dot 2^(n+1) + 2$.],
  )
}
