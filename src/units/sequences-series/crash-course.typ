// ============================================================
//  crash-course.typ — Sequences & Series: Crash Course
//  Four 45-minute lessons.  Compile: typst compile crash-course.typ
//  Self-contained — no other files required.
// ============================================================

// ── Page & typography ────────────────────────────────────────
#set page(
  paper:  "a4",
  margin: (top: 2.2cm, bottom: 2.2cm, left: 2.5cm, right: 2.5cm),
  header: context {
    let l = counter("lesson").get().at(0)
    if l > 0 {
      set text(size: 8.5pt, fill: luma(140))
      grid(
        columns: (1fr, auto),
        [Sequences & Series — Crash Course],
        [Lesson #l],
      )
      v(-4pt)
      line(length: 100%, stroke: 0.4pt + luma(210))
    }
  },
)
#set text(font: "New Computer Modern", size: 11pt, lang: "en")
#set par(justify: true, leading: 0.72em, spacing: 0.9em)
#set heading(numbering: none)

// ── Accent palette ───────────────────────────────────────────
#let accent      = rgb("#0097a7")
#let accent-light = rgb("#e0f7fa")
#let ex-bg       = luma(251)
#let rule-col    = luma(190)

// ── Lesson title band ────────────────────────────────────────
#let lesson-num = counter("lesson")
#let lesson(title, subtitle) = {
  lesson-num.step()
  v(0.3cm)
  block(
    width:  100%,
    radius: 4pt,
    fill:   accent,
    inset:  (x: 1.1em, y: 0.75em),
    grid(
      columns: (auto, 1fr),
      column-gutter: 1em,
      align: (center + horizon, left + horizon),
      // Lesson number badge
      block(
        fill:   white.transparentize(80%),
        radius: 3pt,
        inset:  (x: 0.55em, y: 0.3em),
        // Add "context" right before the text block:
        context text(weight: "bold", fill: white, size: 9pt)[
          LESSON #lesson-num.display()
        ],
      ),
      // Title + subtitle
      [
        #text(weight: "bold", fill: white, size: 13.5pt)[#title]
        #if subtitle != none [
          #h(0.6em)
          #text(fill: white.transparentize(30%), size: 10pt)[#subtitle]
        ]
      ],
    ),
  )
  v(0.5em)
}

// ── Theory block (accent left bar) ───────────────────────────
#let theory(body) = block(
  width:  100%,
  fill:   accent-light,
  radius: (right: 4pt),
  stroke: (left: 3pt + accent),
  inset:  (left: 1em, right: 1em, top: 0.65em, bottom: 0.65em),
  body,
)

// ── Worked example ───────────────────────────────────────────
#let worked(title, body) = block(
  width:  100%,
  fill:   luma(246),
  radius: 4pt,
  stroke: 0.5pt + luma(200),
  inset:  (x: 1em, y: 0.65em),
  [
    #text(weight: "bold", fill: accent)[Example: #title]
    #v(0.35em)
    #body
  ],
)

// ── Numbered exercises with writing space ────────────────────
#let ex-count = counter("crash-ex")

// FIXED: Placed positional argument (body) before named argument (space)
#let exercise(body, space: 10cm) = block(
  breakable: false,        // ← keep prompt + answer space together
  width: 100%,
  above: 0.55em,
  below: 0.45em,
  {
    ex-count.step()
    // prompt
    block(
      width:  100%,
      fill:   ex-bg,
      radius: 3pt,
      stroke: (left: 1.5pt + accent.lighten(40%)),
      inset:  (x: 0.9em, y: 0.6em),
      below:  0em,
      grid(
        columns: (auto, 1fr),
        column-gutter: 0.6em,
        context text(weight: "bold", fill: accent)[#ex-count.display().],
        body,
      ),
    )
  },
)

// ── Thin section rule ────────────────────────────────────────
#let section-rule = {
  v(0.2em)
  line(length: 100%, stroke: 0.4pt + luma(210))
  v(0.2em)
}

// ── Sub-parts inside an exercise ────────────────────────────
#let parts(cols, ..items) = {
  let labeled = items.pos().enumerate().map(pair => {
    let i = pair.at(0)
    let body = pair.at(1)
    [#text(weight: "bold")[#numbering("(a)", i + 1)] #body]
  })
  grid(
    columns: range(cols).map(_ => 1fr),
    column-gutter: 1.2em,
    row-gutter:    0.45em,
    ..labeled,
  )
}


// ╔══════════════════════════════════════════════════════════╗
//  LESSON 1 — Basics of Sequences
// ╚══════════════════════════════════════════════════════════╝

#lesson("Basics of Sequences", [what is a sequence?])

#theory[
A *sequence* is an ordered list of numbers: $a_1, a_2, a_3, dots$ Each
number is a *term*; $a_n$ denotes the $n$-th term.

There are two standard ways to describe a sequence:
- *Explicit formula* — gives $a_n$ directly in terms of $n$. \
  Example: $a_n = 3n - 1$ produces $2, 5, 8, 11, 14, dots$
- *Recursive formula* — gives $a_(n+1)$ in terms of the previous term(s). \
  Example: $a_1 = 2, quad a_(n+1) = a_n + 3$ produces the same sequence.
]

#worked("listing terms from a formula")[
  $a_n = n^2 - 1$: substitute $n = 1, 2, 3, 4, 5$: \
  $a_1 = 0, quad a_2 = 3, quad a_3 = 8, quad a_4 = 15, quad a_5 = 24.$
]

#section-rule

// Reset exercise counter at the start of each lesson.
#ex-count.update(0)

#exercise[
  List the first five terms of each sequence.
  #parts(2,
    [$a_n = 4n - 3$],
    [$a_n = n^2 + 2$],
    [$a_n = (-1)^n dot n$],
    [$a_n = 2^(n-1)$],
  )
]

#exercise[
  List the first five terms of each recursively defined sequence.
  #parts(2,
    [$a_1 = 5, quad a_(n+1) = a_n + 4$],
    [$a_1 = 1, quad a_(n+1) = 3 a_n$],
    [$a_1 = 10, quad a_(n+1) = a_n - 3$],
    [$a_1 = 1, quad a_(n+1) = n dot a_n$],
  )
]

#exercise(space: 12cm)[
  For the explicit formula $a_n = 5n + 1$, calculate:
  #parts(3,
    [$a_7$],
    [$a_(20)$],
    [$a_(100)$],
  )
]

#exercise[
  Find an explicit formula for each sequence. _(Hint: look at how each term
  relates to its position $n$.)_
  #parts(2,
    [$4, 7, 10, 13, 16, dots$],
    [$1, 4, 9, 16, 25, dots$],
    [$1/2, 1/4, 1/6, 1/8, dots$],
    [$3, 9, 27, 81, dots$],
  )
]

#exercise[
  Write a recursive formula for each sequence.
  #parts(2,
    [$6, 11, 16, 21, dots$],
    [$1, 2, 6, 24, 120, dots$],
  )
]

#exercise(space: 3.5cm)[
  The sequence $1, 1, 2, 3, 5, 8, 13, dots$ is the *Fibonacci sequence*.
  #parts(1,
    [State its recursive formula.],
    [Write the next four terms.],
    [Compute the ratio $a_(n+1) / a_n$ for $n = 2, 3, 4, 5, 6$. What do you
        notice?],
  )
]


// ╔══════════════════════════════════════════════════════════╗
//  LESSON 2 — Arithmetic Sequences
// ╚══════════════════════════════════════════════════════════╝

#pagebreak()
#lesson("Arithmetic Sequences", [constant difference])

#theory[
An *arithmetic sequence* has a constant difference $d$ between consecutive
terms:
$ a_(n+1) - a_n = d quad "for all" n. $
Its general term (derived by adding $d$ repeatedly from $a_1$) is

// FIXED: Cleaned up nested code/math mode layout
#align(center, rect(stroke: 1pt + accent, inset: 0.5em)[
  $a_n = a_1 + (n-1) d$
])

// FIXED: Removed invalid math escape backslash
Given any two terms $a_j$ and $a_k$ you can recover $d = (a_k - a_j) / (k - j)$.
]

#worked("finding the formula and a specific term")[
  Sequence: $7, 11, 15, 19, dots$ \
  Common difference: $d = 11 - 7 = 4$.  First term: $a_1 = 7$. \
  General term: $a_n = 7 + (n - 1) dot 4 = 4 n + 3$. \
  50th term: $a_(50) = 4 dot 50 + 3 = 203.$
]

#section-rule
#ex-count.update(0)

#exercise[
  Identify whether each sequence is arithmetic. If it is, state the common
  difference $d$.
  #parts(2,
    [$3, 7, 11, 15, dots$],
    [$1, 2, 4, 8, dots$],
    [$20, 17, 14, 11, dots$],
    [$1, 1.5, 2, 2.5, dots$],
  )
]

#exercise[
  Find the general term $a_n$ for each arithmetic sequence.
  #parts(2,
    [$5, 9, 13, 17, dots$],
    [$-3, 1, 5, 9, dots$],
    [$a_1 = 12, quad d = -4$],
    [$a_1 = 0, quad d = 1.5$],
  )
]

#exercise[
  Calculate the required term.
  #parts(2,
    [30th term of $4, 7, 10, dots$],
    [45th term of $100, 97, 94, dots$],
    [100th term of $-5, -3, -1, 1, dots$],
    [15th term of $3.2, 3.6, 4.0, dots$],
  )
]

#exercise(space: 3.2cm)[
  The 5th term of an arithmetic sequence is $17$ and the 9th term is $33$.
  #parts(1,
    [Find the common difference $d$ and the first term $a_1$.],
    [Write the general term $a_n$.],
    [Find the 20th term.],
  )
]

#exercise[
  Which term of the sequence $3, 8, 13, 18, dots$ first exceeds $200$?
]

#exercise(space: 3.5cm)[
  Three numbers in arithmetic progression add up to $21$ and the largest is
  $3$ times the smallest. Find the three numbers.
]


// ╔══════════════════════════════════════════════════════════╗
//  LESSON 3 — Geometric Sequences
// ╚══════════════════════════════════════════════════════════╝

#pagebreak()
#lesson("Geometric Sequences", [constant ratio])

#theory[
A *geometric sequence* has a constant ratio $q$ between consecutive terms:
$ a_(n+1) / a_n = q quad "for all" n. $
Its general term (derived by multiplying $a_1$ by $q$ repeatedly) is

// FIXED: Cleaned up nested code/math mode layout
#align(center, rect(stroke: 1pt + accent, inset: 0.5em)[
  $a_n = a_1 dot q^(n-1)$
])

// FIXED: Removed invalid math escape backslash
Given two terms: $a_j dot q^(k - j) = a_k$, so $q = (a_k / a_j)^(1 / (k-j))$.
]

#worked("finding the formula and a specific term")[
  Sequence: $2, 6, 18, 54, dots$ \
  Common ratio: $q = 6 / 2 = 3$.  First term: $a_1 = 2$. \
  General term: $a_n = 2 dot 3^(n-1)$. \
  6th term: $a_6 = 2 dot 3^5 = 2 dot 243 = 486.$
]

#section-rule
#ex-count.update(0)

#exercise[
  Identify whether each sequence is geometric. If it is, state the common ratio
  $q$.
  #parts(2,
    [$4, 12, 36, 108, dots$],
    [$5, 10, 15, 20, dots$],
    [$8, -4, 2, -1, dots$],
    [$1, 1, 1, 1, dots$],
  )
]

#exercise[
  Find the general term $a_n$ for each geometric sequence.
  #parts(2,
    [$5, 10, 20, 40, dots$],
    [$-2, 6, -18, 54, dots$],
    [$a_1 = 3, quad q = 4$],
    [$a_1 = 100, quad q = 0.1$],
  )
]

#exercise[
  Calculate the required term.
  #parts(2,
    [8th term of $3, 6, 12, dots$],
    [6th term of $1, -2, 4, dots$],
    [10th term of $81, 27, 9, 3, dots$],
    [5th term of $1.5, 3, 6, dots$],
  )
]

#exercise(space: 3.2cm)[
  The 3rd term of a geometric sequence is $12$ and the 6th term is $96$.
  #parts(1,
    [Find the common ratio $q$ and the first term $a_1$.],
    [Write the general term $a_n$.],
    [Which term first exceeds $1000$?],
  )
]

#exercise(space: 3cm)[
  Classify each sequence as *arithmetic*, *geometric*, or *neither*. For
  arithmetic/geometric sequences, state $d$ or $q$ and find $a_n$.
  #parts(2,
    [$2, 5, 8, 11, dots$],
    [$3, 6, 12, 24, dots$],
    [$1, 4, 9, 16, dots$],
    [$50, 25, 12.5, 6.25, dots$],
  )
]

#exercise(space: 3.5cm)[
  A bacteria culture starts with $200$ cells and doubles every hour.
  #parts(1,
    [Write the number of cells $a_n$ after $n$ hours as a geometric sequence.],
    [How many cells are there after 8 hours?],
    [After how many complete hours does the count first exceed $10\,000$?],
  )
]


// ╔══════════════════════════════════════════════════════════╗
//  LESSON 4 — Arithmetic and Geometric Series
// ╚══════════════════════════════════════════════════════════╝

#pagebreak()
#lesson("Series", [summing sequences])

#theory[
A *series* is the sum of the terms of a sequence. The $n$-th *partial sum* is
$S_n = a_1 + a_2 + dots.c + a_n = sum_(k=1)^n a_k.$

#v(0.4em)
*Arithmetic series* (Gauss's trick: pair first and last terms):
// FIXED: Cleaned up nested code/math mode layout
#align(center, rect(stroke: 1pt + accent, inset: 0.5em)[
  $S_n = n/2 (a_1 + a_n) = n/2 (2a_1 + (n-1) d)$
])

*Geometric series* (multiply by $q$ and subtract):
// FIXED: Cleaned up nested code/math mode layout
#align(center, rect(stroke: 1pt + accent, inset: 0.5em)[
  $S_n = a_1 dot (q^n - 1)/(q - 1), quad q eq.not 1$
])
]

#worked("one of each")[
  *Arithmetic:* Sum the first 20 terms of $3, 7, 11, dots$ ($d = 4, a_(20) = 79$):
  $S_(20) = 20/2 (3 + 79) = 10 dot 82 = 820.$ \
  *Geometric:* Sum the first 6 terms of $2, 6, 18, dots$ ($q = 3$):
  $S_6 = 2 dot (3^6 - 1)/(3 - 1) = 2 dot 364 = 728.$
]

#section-rule
#ex-count.update(0)

#exercise[
  Sum the first $n$ terms of each arithmetic sequence.
  #parts(2,
    [$5, 9, 13, dots; quad n = 15$],
    [$100, 97, 94, dots; quad n = 30$],
    [$-3, 0, 3, 6, dots; quad n = 20$],
    [$a_1 = 4, d = 7; quad n = 12$],
  )
]

#exercise(space: 3cm)[
  *Gauss's formula in disguise.*
  #parts(1,
    [Find $1 + 2 + 3 + dots.c + 100$ (the sum of the first 100 natural
        numbers).],
    [Find the sum of all odd numbers from $1$ to $99$.],
    [Find the sum of all even numbers from $2$ to $200$.],
  )
]

#exercise[
  Sum the first $n$ terms of each geometric sequence.
  #parts(2,
    [$3, 6, 12, dots; quad n = 8$],
    [$1, -2, 4, -8, dots; quad n = 10$],
    [$a_1 = 5, q = 3; quad n = 6$],
    [$a_1 = 100, q = 0.5; quad n = 5$],
  )
]

#exercise(space: 3.2cm)[
  The sum of an arithmetic series is $S_(10) = 155$ and the first term is
  $a_1 = 2$.
  #parts(1,
    [Find the common difference $d$.],
    [Find the 10th term $a_(10)$.],
  )
]

#exercise(space: 3.5cm)[
  A tennis player completes a training program: on day 1 she runs $1$ km, on
  day 2 she runs $1.5$ km, increasing by $0.5$ km each day for $20$ days.
  #parts(1,
    [How far does she run on day 20?],
    [What is the total distance over all 20 days?],
  )
]

#exercise(space: 3.5cm)[
  A ball is dropped from $8$ m and bounces to $3/4$ of its previous height on
  each bounce.
  #parts(1,
    [How high does it rise after the 5th bounce?],
    [What is the total distance traveled (down and up) over the first
        6 bounces? _(Hint: track the initial drop and each up-down pair
        separately.)_],
  )
]