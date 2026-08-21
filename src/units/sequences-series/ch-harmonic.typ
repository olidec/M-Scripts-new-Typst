// ============================================================
//  ch-harmonic.typ — The Harmonic Series
//  (Enrichment chapter, deliberately short. Same status as
//  ch-fibonacci.typ: not tied to any Lehrplan competency, no exam
//  relevance, level: "all" throughout so nothing is hidden
//  depending on which document compiles it.)
//
// ── WHO THIS IS FOR ──────────────────────────────────────────
//  Same audience and same mechanism as ch-fibonacci.typ: a fast-
//  finishing GLF class, or a bonus SPF chapter if there is time.
//  Pairs naturally right after Fibonacci (both are "a sequence
//  that looks tame turns out to hide something surprising"), but
//  reads perfectly well on its own too.
//
// ── REGISTRATION SNIPPET (paste into sequences-series/main-high.typ,
//    as the last entry inside register_chapters(...), after the
//    Fibonacci entry if both are used) ─────────────────────────
//    ("Harmonic", "/src/units/sequences-series/ch-harmonic"),
//
// ── WHY THIS IS SHORTER THAN ch-fibonacci.typ ────────────────
//  No new native-drawn figure is introduced here — deliberately.
//  Every visual is either a data-table() (already proven safe in
//  ch-fibonacci.typ) or plain prose. The chapter leans on ONE
//  genuinely elegant proof (Oresme's grouping argument, both as
//  theory and as a formal induction exercise) and TWO worked
//  "wow" puzzles, rather than a long identity collection.
//
// ── ALL NUMBERS BELOW VERIFIED NUMERICALLY BEFORE WRITING ────
//  H_n partial sums, the (1/2) H_n book-overhang values, and the
//  worm's e^100 - 1 second travel time were all checked against a
//  direct summation / closed-form computation, not typed from
//  memory. See teacher-facing chat for the verification script.
// ============================================================

#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "The Harmonic Series")

#let ex = exercise.with(chapter: "Harmonic")

= The Harmonic Series

#epigraph[
  A sequence can shrink to nothing, term by term, and its sum can
  still swallow the world.
]

#only-theory[
  This chapter is a short extra, in the same spirit as the
  Fibonacci chapter — nothing here is needed for an exam. It earns
  its place because the harmonic series is the cleanest possible
  counterexample to a very natural guess, and because two
  genuinely astonishing physical puzzles fall directly out of it.
]

#objectives(
  [state the definition of the harmonic series and explain why its
    terms shrinking to zero does not, by itself, guarantee
    convergence],
  [reproduce Nicole Oresme's medieval grouping argument for
    divergence, and prove the bound it implies by induction],
  [use the divergence of the harmonic series to explain two
    counter-intuitive real puzzles],
  [state, without proof, the connection between the harmonic
    partial sums and the natural logarithm],
)

== Terms Shrinking to Zero Is Not Enough

#look-back(
  title: "A natural guess, and why it fails here",
  recalls: [infinite geometric series in the Geometric Sequences
    and Series chapter],
)[
  An infinite geometric series with $abs(q) < 1$ converges because
  its terms shrink to $0$ *fast enough* — geometrically, by a fixed
  factor every step. It is tempting to conclude that ANY series
  whose terms shrink to $0$ must converge. The
  #vocab("harmonic series", "harmonische Reihe") is the standard
  example showing that guess is false.
]

#definition(title: "Harmonic series")[
  The harmonic series is
  $ sum_(k=1)^(oo) 1/k = 1 + 1/2 + 1/3 + 1/4 + dots.c $
  Its $n$-th partial sum is written $H_n = sum_(k=1)^n 1/k$.
]

#example(title: [Computing $H_4$ exactly])[
  $
    H_4 = 1 + 1/2 + 1/3 + 1/4 = 12/12 + 6/12 + 4/12 + 3/12 = 25/12
    approx 2.083.
  $
  The terms $1, 1/2, 1/3, 1/4, dots$ do shrink to $0$ — the
  question this chapter answers is whether the running total
  settles down as well, or keeps climbing forever.
]

#ex(difficulty: 1, time: "6 min", calculator: false)[
  Compute $H_1, H_2, dots, H_8$ as exact fractions.
][
  $
    H_1 = 1, quad H_2 = 3/2, quad H_3 = 11/6, quad
    H_4 = 25/12, quad H_5 = 137/60, quad H_6 = 49/20,
  $
  $
    H_7 = 363/140, quad H_8 = 761/280 approx 2.718.
  $
  Nothing here looks alarming yet — each new term adds less than
  the one before. The next section shows why that impression is
  misleading.
]

== Nicole Oresme's Proof of Divergence

#quotebox[
  The result that the harmonic series has no finite sum is
  commonly credited to Nicole Oresme (c. 1320–1382), a French
  philosopher, mathematician, and bishop, in a work usually dated
  to around 1350 — roughly three centuries before calculus gave
  mathematicians a formal notion of a limit at all. Oresme's
  argument needs none of that machinery. It needs only one idea:
  grouping the terms cleverly and comparing each group to a fixed
  fraction.
]

#only-theory[
  Group the terms of the harmonic series in blocks whose length
  doubles each time:
  $
    1 + 1/2 + (1/3 + 1/4) + (1/5 + 1/6 + 1/7 + 1/8) + dots.c
  $
  In the block from $1\/(2^(k-1) + 1)$ to $1\/2^k$ there are
  $2^(k-1)$ terms, and every one of them is at least as large as
  the smallest term in that block, $1\/2^k$. So the whole block
  sums to at least
  $ 2^(k-1) dot 1/2^k = 1/2. $
  There are infinitely many such blocks — so the harmonic series is
  an infinite sum of pieces each worth at least $1\/2$, and no
  finite total can absorb infinitely many halves.
]

#theorem(title: [Oresme's bound])[
  For every integer $n >= 0$,
  $ H_(2^n) >= 1 + n/2. $
  In particular $H_(2^n) -> oo$ as $n -> oo$, so the harmonic
  series diverges.
]

#proof[
  Induction on $n$. *Base case* $n = 0$: $H_1 = 1 = 1 + 0\/2$. ✓ \
  *Inductive step:* assume $H_(2^n) >= 1 + n\/2$. The next
  $2^n$ terms of the series, from $1\/(2^n + 1)$ up to
  $1\/2^(n+1)$, are each at least $1\/2^(n+1)$ (the smallest term
  in that range), so together they sum to at least
  $ 2^n dot 1/2^(n+1) = 1/2. $
  Adding at least $1\/2$ to the inductive hypothesis,
  $ H_(2^(n+1)) >= H_(2^n) + 1/2 >= (1 + n/2) + 1/2 = 1 + (n+1)/2, $
  which is the bound with $n + 1$ in place of $n$.
]

#warning[
  The divergence is real, but the growth is agonizingly slow —
  Oresme's bound only guarantees $H_(2^n) >= 1 + n\/2$, so doubling
  $n$ adds a mere $1\/2$ to the guaranteed total. Reaching a
  guaranteed value of $10$, for instance, needs $n = 18$, i.e.
  $2^(18) = #num(262144)$ terms. "Diverges" does not mean "grows
  quickly" — the two puzzles below are built entirely out of this
  contrast between certain-but-glacial growth.
]

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: false,
  hints: (
    [Follow the same grouping idea as the theorem, but for a single
      doubling step: how many new terms appear between $H_(2^n)$
      and $H_(2^(n+1))$, and what is the smallest of them?],
  ),
)[
  Without quoting the theorem above, prove directly by induction
  that $H_(2^n) >= 1 + n\/2$ for all integers $n >= 0$. Then use
  your bound to find a value of $n$ for which $H_(2^n)$ is
  guaranteed to exceed $100$.
][
  The induction is exactly the proof given above (repeat it in your
  own words for full marks — the point of this exercise is
  producing that argument yourself, not just reading it). For the
  second part, $1 + n\/2 > 100$ requires $n > 198$, so $n = 199$
  guarantees $H_(2^(199)) > 100$ — a genuinely enormous number of
  terms, $2^(199)$, for a "mere" guaranteed value of $100$.
]

== Two Places This Fact Refuses to Stay Abstract

#only-theory[
  Divergence of the harmonic series is not just a fact about an
  infinite sum on paper. It has two well-known physical
  consequences, both genuinely surprising the first time you meet
  them.
]

=== The Leaning Tower of Books

#exploration(title: [How far can a stack of books overhang a table?])[
  Stack identical books on a table, each shifted a little further
  out than the one below it, so the whole tower stays balanced
  (nothing tips over). Before reading on: with $2$ books, can the
  top book's far edge reach beyond the table's edge by more than
  half a book's length? With $10$ books, could the top book stick
  out *entirely* past the table's edge — supported by nothing
  directly underneath it at all?
]

#only-theory[
  Balancing a group of books on the one beneath it is a
  center-of-mass argument: the $k$-th book from the top can be
  shifted at most $1\/(2k)$ of a book-length further out than the
  book below it, without the stack above it tipping. (The
  bottommost book gets the same treatment relative to the table
  edge itself — think of the table as an infinitely heavy "book"
  underneath everything.) Adding up every one of these shifts, the
  maximum overhang $D(n)$ achievable with $n$ books, measured in
  book-lengths beyond the table's edge, is
]

#keybox(title: [Maximum overhang with $n$ books])[
  $ D(n) = 1/2 dot H_n. $
]

#data-table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  row-height: 0.9cm,
  [$n$], [1], [2], [3], [4], [5], [6],
  [$D(n)$], [0.5], [0.75], [0.917], [1.042], [1.142], [1.225],
)

#only-theory[
  Since $H_n -> oo$, so does $D(n)$ — with enough books, the top
  book can be pushed out by *any* distance you like, including
  entirely clear of the table. The table above shows exactly where
  that first happens: at $n = 4$ books, $D(n)$ already passes $1$
  full book-length, so the top book is completely beyond the
  table's edge, held up only by the chain of balanced books
  beneath it.
]

#ex(difficulty: 1, time: "8 min", calculator: true)[
  Use the formula $D(n) = 1/2 dot H_n$ to confirm that $3$ books
  are not enough for the top book to clear the table's edge, but
  $4$ books are.
][
  $ D(3) = 1/2 dot 11/6 = 11/12 approx 0.917 < 1, $
  $ D(4) = 1/2 dot 25/12 = 25/24 approx 1.042 > 1. $
  So $3$ books fall just short and $4$ books already clear the
  table entirely — matching the table above.
]

=== The Worm on the Rubber Band

#quotebox[
  A worm starts at one end of a $1$-meter rubber band and crawls
  toward the other end at a steady $1$ centimeter per second,
  relative to the rubber under its feet. But the band is also being
  stretched, uniformly along its whole length, growing by $1$ meter
  every second. Does the worm ever reach the far end?
]

#exploration(title: [First instincts])[
  Before doing any calculation: does it feel like the worm should
  reach the end? The band's growth rate ($1$ m/s) massively
  outpaces the worm's crawling speed ($1$ cm/s) — every single
  second, the band gains a full meter while the worm gains a
  single centimeter. State a guess, then read on.
]

#only-theory[
  The honest answer is: yes, the worm reaches the end — eventually.
  Here is an argument using nothing more than the harmonic series
  already proven divergent above.

  Track the worm's position as a *fraction* of the band's current
  length (rather than in meters). Stretching the band does not, by
  itself, change that fraction — every point of the band keeps its
  relative position as the whole thing scales up. Only the worm's
  own crawling changes its fractional position. During the $n$-th
  second, the band's length is roughly $n$ meters, and the worm
  crawls about $0.01$ m of actual rubber during that second — a
  fraction of roughly
  $ 0.01/n $
  of the band's current length. Adding this up over $N$ seconds,
  the worm's total fractional progress is approximately
  $ 0.01 dot (1 + 1/2 + 1/3 + dots.c + 1/N) = 0.01 dot H_N. $
  Since $H_N -> oo$, this quantity eventually exceeds $1$ — meaning
  the worm's cumulative fractional progress eventually covers the
  *entire* band, however slowly. If the band instead stretched in a
  way that made the worm's fractional gain shrink like $1\/n^2$
  (a *convergent* series) instead of $1\/n$, the worm would *never*
  reach the end, no matter how long it crawled. The entire outcome
  hinges on which of these two series the situation reduces to.
]

#look-ahead(
  title: [The exact arrival time — a preview of integral calculus],
  preview: [integral calculus],
)[
  The rough per-second argument above only shows the worm reaches
  the end *eventually*. The exact time needs calculus: writing
  $L(t) = 1 + t$ for the band's length at time $t$ (in meters and
  seconds) and $u = 0.01$ m/s for the worm's crawling speed, the
  same reasoning above becomes, in the continuous limit, the
  differential equation $f'(t) = u \/ L(t)$ for the worm's
  fractional position $f(t)$. Solving it is a direct integral,
  $
    integral_0^T u/(1+t) dif t = u dot ln(1 + T),
  $
  and setting this equal to $1$ (the worm reaching the far end,
  $f(T) = 1$) gives
  $ T = e^(1\/u) - 1 = e^(100) - 1 approx 2.69 times 10^(43)
    "seconds." $
  That number is almost incomprehensibly large — roughly
  $6 times 10^(25)$ times the current age of the universe — but it
  is *finite*, and its finiteness traces back to exactly the same
  fact proven earlier in this chapter: the harmonic series
  diverges. A geometric series in the denominator here (say, a band
  that stretched exponentially instead of linearly) would have
  given a genuinely infinite time instead.
]

== Where Else the Harmonic Series Shows Up

#only-theory[
  A few more places worth knowing about, briefly:

  - *The name itself.* A vibrating string produces overtones at
    frequencies proportional to $1, 1\/2, 1\/3, 1\/4, dots$ of its
    fundamental wavelength — musicians call these
    #vocab("overtones", "Obertöne") the *harmonics* of the note.
    That is literally where the series gets its name.
  - *The coupon collector's problem.* If you draw uniformly at
    random, with replacement, from $n$ distinct items, the expected
    number of draws needed to collect all $n$ of them is *exactly*
    $n dot H_n$ — a genuine appearance of the harmonic series inside
    a probability calculation, connecting back to the
    Probabilities & Combinatorics unit.
  - *A close cousin that behaves completely differently.* The
    series $sum_(k=1)^(oo) 1\/k^2$ — replacing every exponent $1$ with
    a $2$ — converges, to $pi^2\/6$ (the *Basel problem*, solved by
    Euler in 1735). Two series that look almost identical, one
    diverges and one converges to a value involving $pi$: this is
    the seed of the *comparison test* for series, met formally
    later.
]

== A Numerical Preview: $H_n$ and $ln n$

#exploration(title: [How fast, exactly?])[
  Compute $H_n - ln(n)$ (using your calculator's $ln$ button) for
  $n = 10$, $n = 100$ and $n = 1000$. The values of $H_n$ and
  $ln(n)$ both grow without bound individually — what happens to
  their *difference*?
]

#data-table(
  columns: (1fr, 1fr, 1fr, 1fr),
  row-height: 0.9cm,
  [$n$], [$H_n$], [$ln(n)$], [$H_n - ln(n)$],
  [$10$], [2.929], [2.303], [0.626],
  [$1000$], [7.485], [6.908], [0.578],
  [#num(10000)], [9.788], [9.210], [0.577],
)

#keybox(title: [$H_n$ and the natural logarithm])[
  $ H_n approx ln(n) + gamma, quad gamma approx 0.5772156649. $
  The constant $gamma$ is the *Euler–Mascheroni constant*. The
  approximation gets better and better as $n$ grows — and the
  underlying reason is a picture, not a coincidence: $H_n$ is a sum
  of rectangle areas of width $1$ and height $1\/k$, while
  $ln(n) = integral_1^n 1/x dif x$ is the area actually under the
  curve $y = 1\/x$ between the same rectangles. Comparing a sum to
  the area under a curve this way is exactly the idea behind
  #vocab("Riemann sums", "Riemannsche Summen") and the integral
  test for series — both met properly in the calculus unit.
]

#remark[
  Whether $gamma$ itself is rational or irrational is, remarkably,
  an *unsolved problem* in mathematics — nobody has ever proven
  either way, despite $gamma$ being known to over a trillion decimal
  digits. It is a rare example of a question a school student can
  fully understand that no mathematician on Earth can currently
  answer.
]

#print-hints()

#print-vocab()
