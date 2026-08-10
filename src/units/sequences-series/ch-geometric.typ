// ============================================================
//  ch-geometric.typ — Geometric Sequences and Series
//
//  Lehrplan anchor
//    GLF 3. Klasse, 2.1 Folgen und Reihen
//      - Berechnungen mit arithmetischen und geometrischen
//        Folgen und Reihen durchführen
//      - Grenzwerte von unendlichen geometrischen Reihen berechnen
//    SPF 2. Klasse, 1.1 Folgen und Reihen / 1.3 Grenzwerte
//      - arithmetische und geometrische Folgen und Reihen
//        erkennen und anwenden
//      - den Zusammenhang zwischen unendlichen Folgen und Reihen
//        und ihren Grenzwerten erklären
//    No (BfKM) marker on either entry, so no bfkm[...] tags here.
//    NOTE the third GLF bullet: infinite geometric series and their
//    limits are a GLF requirement, not an SPF extra. Only the formal
//    epsilon-N definition of a limit is gated only-high.
//
// ── TEACHER'S NOTE: one error in the previous version ───────
//  * The exercise "a-4, a+2, 3a+1 are three consecutive terms of a
//    geometric sequence" was answered a = 9 or a = 0, giving
//    q = 8 or q = -1/2. All four numbers are wrong. The condition
//    (a+2)^2 = (a-4)(3a+1) expands to 2a^2 - 15a - 8 = 0, whose
//    roots are a = 8 and a = -1/2:
//      a = 8    ->  terms  4, 10, 25       ->  q =  5/2
//      a = -1/2 ->  terms -9/2, 3/2, -1/2  ->  q = -1/3
//    Both verified by division. Corrected below, and the solution
//    now shows the expansion so the arithmetic is checkable.
//
// ── ONE EXERCISE REPLACED ───────────────────────────────────
//  * The nested-midpoint-squares exercise ("the shaded regions are
//    the alternating triangular corners") was not well posed and
//    its two printed answers contradict each other: 16 cm^2 needs a
//    ratio of 1/2 between successive shaded areas, while 27.3 cm
//    needs a ratio of 1/2 between successive LENGTHS, i.e. 1/4
//    between areas. It also referred to shading the figure does not
//    have — nested-squares() fills alternate whole squares, not
//    corner triangles, and since the inner squares are drawn with
//    fill: none they do not mask what is underneath. Replaced with
//    a fully specified question on the same figure, including the
//    genuinely pretty fact that the corner triangles from all steps
//    together tile the original square exactly. Every value below
//    is verified.
//
// ── SMALLER CHANGES ─────────────────────────────────────────
//  * Exercises interleaved; each block opens with a 1-dot problem.
//  * parts() -> auto-parts() (1:1 checked); time: and calculator:
//    on every exercise.
//  * "geometric grows by multiplication where arithmetic grows by
//    addition" was only-high. It is the whole point of the chapter
//    and is now shared, as a look-back to the previous chapter.
//  * The Zeno passage is retold rather than quoted.
//  * The divergent-series AI exercise moved up to sit immediately
//    after the |q| < 1 condition it is about.
// ============================================================

#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Geometric Sequences and Series")

#let ex = exercise.with(chapter: "Geometric")

= Geometric Sequences and Series

#epigraph[
  Every quantity that doubles is small right up until it isn't.
]

#only-theory[
  An arithmetic sequence adds the same amount at every step. A
  geometric sequence multiplies by the same factor at every step.
  That is the entire difference between the two chapters — and it is
  responsible for the difference between a salary rising by
  CHF 500 a year and an epidemic, between simple interest
  and compound interest, and between a straight line and the curves
  that model growth and decay.

  This chapter also contains the one genuinely new idea of the unit:
  a sum with infinitely many terms can have a perfectly finite value.
]

#objectives(
  [recognize a geometric sequence from a list of terms, and find its
    common ratio],
  [set up the general term $a_n$ of a geometric sequence from any two
    pieces of information about it],
  [compute a partial sum of a geometric sequence, and explain the
    multiply-and-subtract argument that gives the formula],
  [decide whether an infinite geometric series converges, and
    compute its value when it does],
  [convert a repeating decimal into a fraction using an infinite
    geometric series],
  [model growth, decay and self-similar geometric figures with
    geometric sequences and series],
  obj(level: "high")[state the formal definition of the limit of a
    sequence and read it correctly],
)

== Geometric Sequences

#definition(title: "Geometric sequence")[
  A #vocab("geometric sequence", "geometrische Folge") (or
  #emph[progression]) $(a_n)_(n in NN)$ is a sequence in which the
  ratio between consecutive terms is constant:
  $ a_(n+1)/a_n = q quad "for all" n in NN. $
  The number $q$ is the
  #vocab("common ratio", "Quotient") of the sequence.
]

#keybox(title: "Geometric sequences")[
  $
    "recursive:" quad cases(a_1 "given", a_(n+1) = q dot a_n)
    quad quad quad
    "explicit:" quad a_n = a_1 dot q^(n-1)
  $
  Start at $a_1$, then take $(n - 1)$ steps, each a multiplication by
  $q$. The same off-by-one trap as last chapter: the exponent is
  $n - 1$, not $n$.
]

#look-back(
  title: "Addition and multiplication, side by side",
  recalls: [arithmetic sequences],
)[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.2em,
    [
      *Arithmetic*
      $ a_n = a_1 + (n - 1) dot d $
      Step: add $d$. \
      Graph: points on a line. \
      Model: constant amount per period.
    ],
    [
      *Geometric*
      $ a_n = a_1 dot q^(n-1) $
      Step: multiply by $q$. \
      Graph: points on an exponential curve. \
      Model: constant *percentage* per period.
    ],
  )
  A rise of $3%$ per year means $q = 1.03$; a fall of $3%$ per year
  means $q = 0.97$. Translating a percentage into a ratio is the
  single most useful skill in this chapter.
]

#warning[
  Neither $a_1$ nor $q$ may be zero: the definition divides by
  $a_n$, so a geometric sequence has no zero terms at all. This
  matters in exercises — a candidate solution that forces one of the
  three given terms to be $0$ must be discarded, not reported.

  A negative $q$ is perfectly allowed, and makes the signs alternate.
  A $q$ with $abs(q) < 1$ is also allowed, and makes the terms shrink
  toward zero; that case is the whole of the third section below.
]

#example(title: "Finding a sequence from two of its terms")[
  A geometric sequence has $a_2 = 10$ and $a_3 = -5$. Find $a_n$.

  One step separates the two terms, so
  $q = a_3 \/ a_2 = -1/2$ directly. Stepping back from $a_2$ to
  $a_1$ means dividing by $q$ once:
  $
    a_1 = 10 \/ (-1/2) = -20, quad "so" quad
    a_n = -20 dot (-1/2)^(n-1).
  $
  Check the first few terms: $-20, 10, -5, 2.5, dots$ — the signs
  alternate, as a negative $q$ requires.
]

#ex(difficulty: 1, time: "12 min", calculator: false)[
  For each geometric sequence below, find an expression for $a_n$ and
  list the first five terms.
  #auto-parts(
    1,
    [$7, 14, dots$],
    [$a_1 = -6, quad q = 1/2$],
    [$a_4 = 9, quad q = 1/3$],
    [$a_2 = 10, quad a_3 = -5$],
    [$a_2 = 1.5, quad q = -2$],
  )
][
  #auto-parts(
    1,
    [$a_n = 7 dot 2^(n-1)$; #h(0.4em) $7, 14, 28, 56, 112$],
    [$a_n = -6 dot (1/2)^(n-1)$; #h(0.4em)
      $-6, -3, -3/2, -3/4, -3/8$],
    [$a_n = 243 dot (1/3)^(n-1)$; #h(0.4em) $243, 81, 27, 9, 3$],
    [$a_n = -20 dot (-1/2)^(n-1)$; #h(0.4em)
      $-20, 10, -5, 5/2, -5/4$],
    [$a_n = -0.75 dot (-2)^(n-1)$; #h(0.4em)
      $-0.75, 1.5, -3, 6, -12$],
  )
  In (c), stepping back three times from $a_4$ means dividing by
  $q$ three times: $a_1 = 9 dot 3^3 = 243$.
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  Determine the next three terms of each geometric sequence.
  #auto-parts(
    2,
    [$3/4, quad 1, quad dots$],
    [$sqrt(2), quad 2, quad dots$],
    [$a^2, quad a dot b, quad dots$],
    [$1/x, quad x, quad dots$],
  )
][
  #auto-parts(
    2,
    [$q = 4/3$: #h(0.4em) $4/3, 16/9, 64/27$],
    [$q = sqrt(2)$: #h(0.4em) $2 sqrt(2), 4, 4 sqrt(2)$],
    [$q = b/a$: #h(0.4em) $b^2, b^3/a, b^4/a^2$],
    [$q = x^2$: #h(0.4em) $x^3, x^5, x^7$],
  )
  Parts (c) and (d) are the same problem as (a) and (b) — the ratio
  is found by dividing, whatever the terms happen to look like.
  #heuristic("look for what stays the same")
]

#ex(level: "high", difficulty: 2, time: "12 min", calculator: false)[
  The numbers $a - 4$, $a + 2$ and $3 a + 1$ are three consecutive
  terms of a geometric sequence. Find all possible values of the
  common ratio $q$.
][
  Three consecutive terms of a geometric sequence satisfy
  $a_2^2 = a_1 dot a_3$, so
  $
    (a + 2)^2 = (a - 4) dot (3 a + 1)
    quad <==> quad a^2 + 4 a + 4 = 3 a^2 - 11 a - 4,
  $
  that is $2 a^2 - 15 a - 8 = 0$, with roots $a = 8$ and
  $a = -1/2$.
  - $a = 8$ gives the terms $4, 10, 25$ and $q = 5/2$.
  - $a = -1/2$ gives the terms $-9/2, 3/2, -1/2$ and $q = -1/3$.

  Both are genuine: neither produces a zero term. Always divide the
  terms out at the end — it costs one line and catches sign errors.
]

#ex(level: "high", difficulty: 2, time: "10 min", calculator: false)[
  Let $a_1, a_2, a_3$ be terms of a geometric sequence with positive
  terms. What can you say about
  $log(a_1)$, $log(a_2)$, $log(a_3)$?
][
  They form an *arithmetic* sequence. Taking logarithms of
  $a_n = a_1 dot q^(n-1)$ gives
  $ log a_n = log a_1 + (n - 1) dot log q, $
  which is linear in $n$ with common difference $log q$.

  This is why growth data is so often plotted on a logarithmic
  scale: exponential growth becomes a straight line, and a straight
  line is something the eye can judge.
]

#ex(
  level: "high",
  difficulty: 2,
  time: "15 min",
  calculator: false,
  hints: (
    [#heuristic("introduce notation") — use the arithmetic condition
      together with the given sum to pin down $b$ before touching the
      geometric condition.],
  ),
)[
  Three numbers $a, b, c$ form an arithmetic sequence in this order
  and add up to $3$. Reordered as $b, a, c$ they form a geometric
  sequence. Find $a$, $b$ and $c$.
][
  The arithmetic condition gives $a + c = 2 b$, and with
  $a + b + c = 3$ this forces $3 b = 3$, so $b = 1$. The geometric
  condition on $b, a, c$ is $a^2 = b dot c = c$, and $a + c = 2$
  then gives $a^2 + a - 2 = 0$, so $a = 1$ or $a = -2$.

  The interesting solution is $a, b, c = -2, 1, 4$; the value
  $a = 1$ gives the trivial constant triple $1, 1, 1$, which
  technically satisfies both conditions.
]

#ex(
  level: "high",
  difficulty: 3,
  time: "20 min",
  calculator: true,
  hints: (
    [Write everything in terms of $z_1$ and $d$, then impose the two
      equal-ratio conditions as products:
      $z_3^2 = z_2 dot z_1$ and $z_1^2 = z_3 dot (z_4 + 3)$.],
  ),
)[
  The numbers $z_1, z_2, z_3, z_4$ form an arithmetic sequence. The
  numbers $z_2, z_3, z_1, z_4 + 3$ form a geometric sequence. Find
  $z_1, z_2, z_3, z_4$.
][
  Writing $z_k = z_1 + (k - 1) dot d$ and imposing both equal-ratio
  conditions gives two equations in $z_1$ and $d$, with solutions
  $(z_1, d) = (-4, 3)$ and the degenerate $(0, 0)$.

  The degenerate one must be discarded: it makes every $z_k$ zero,
  and a geometric sequence has no zero terms. So
  $ z_1, z_2, z_3, z_4 = -4, -1, 2, 5, $
  and the geometric sequence is $-1, 2, -4, 8$ with $q = -2$.
  Checking the answer against *both* original conditions is part of
  the exercise, not an optional extra.
]

== The Geometric Series

#definition(title: "Geometric series")[
  Let $(a_n)$ be a geometric sequence. The sequence of partial sums
  $ s_n = sum_(k=1)^n a_k $
  is the #vocab("geometric series", "geometrische Reihe")
  associated with $(a_n)$.
]

#only-theory[=== The Legend of the Chessboard]

#quotebox[
  The story is told that when the inventor of chess presented the
  game to his ruler, he was invited to name his own reward. He asked
  only for grain: one grain of wheat on the first square of the
  board, two on the second, four on the third, and so on, doubling
  on each of the sixty-four squares. The ruler, amused at so modest
  a request, agreed at once — and then discovered that the whole
  kingdom's harvest would not cover it.
]

#abstraction-ladder(
  l0: [One grain on the first square, two on the second, four on
    the third — doubling on each of the 64 squares.],
  l1: [Grains per square: #h(0.4em) 1, 2, 4, 8, 16, ...],
  l2: [Each square holds twice the previous one:
    #h(0.4em) $cases(a_1 = 1, a_(n+1) = 2 a_n)$.],
  l3: [$a_n = 2^(n-1)$, so the ruler owes
    $S = sum_(k=1)^(64) 2^(k-1)$ grains.],
)

#only-theory[
  The total is
  $ S = 1 + 2 + 2^2 + 2^3 + dots.c + 2^(63). $
  There is a trick, and it is the only trick in this section:
  multiply the whole sum by the common ratio and subtract. Doubling
  shifts every term one place along, so almost everything cancels:
  $
        2 S & = 2 + 2^2 + 2^3 + dots.c + 2^(63) + 2^(64) \
    2 S - S & = 2^(64) - 1.
  $
  So $S = 2^(64) - 1 approx 1.8 dot 10^(19)$ grains — several
  thousand times the world's current annual wheat production.

  The same manoeuvre works for any common ratio. With
  $a_n = a_1 dot q^(n-1)$,
  $ s_n = a_1 + a_1 q + a_1 q^2 + dots.c + a_1 q^(n-1), $
  and multiplying by $q$ shifts every term one place along again.
  Subtracting leaves only the two ends:
  $
    q s_n - s_n = a_1 dot q^n - a_1, quad "that is" quad
    (q - 1) dot s_n = a_1 dot (q^n - 1).
  $
]

#theorem(title: "Sum of a finite geometric series")[
  For a geometric sequence with common ratio $q != 1$,
  $ s_n = a_1 dot (q^n - 1)/(q - 1) = a_1 dot (1 - q^n)/(1 - q). $
]

#remark[
  The two forms are equal — the second is the first with numerator
  and denominator both negated. Use the second when $abs(q) < 1$, so
  that both parts stay positive. The excluded case $q = 1$ needs no
  formula: every term equals $a_1$, so $s_n = n dot a_1$.
]

#ex(difficulty: 1, time: "10 min", calculator: true)[
  Calculate the following partial sums.
  #auto-parts(
    1,
    [$1 + 2 + 4 + dots.c + 512$],
    [$3 + 6 + 12 + 24 + 48 + 96$],
    [$81 + 27 + 9 + 3 + 1$],
  )
][
  #auto-parts(
    1,
    [$a_1 = 1$, $q = 2$, and $512 = 2^9$ so $n = 10$:
      $s_(10) = (2^(10) - 1)/(2 - 1) = 1023$.],
    [$a_1 = 3$, $q = 2$, $n = 6$:
      $s_6 = 3 dot (2^6 - 1)/1 = 189$.],
    [$a_1 = 81$, $q = 1/3$, $n = 5$:
      $s_5 = 81 dot (1 - (1/3)^5)/(1 - 1/3) = 121$.],
  )
  As with arithmetic series, work out how many terms there are
  before using any formula.
]

#ex(difficulty: 2, time: "30 min", calculator: true)[
  Find the missing entries of these geometric sequences and series.
  #data-table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    [],
    [(a)],
    [(b)],
    [(c)],
    [(d)],
    [(e)],
    [(f)],
    [$a_1$],
    [$1$],
    [$6$],
    [],
    [$4$],
    [$40$],
    [],
    [$a_n$],
    [],
    [#num(13122)],
    [],
    [$5.8564$],
    [$-625$],
    [$0.16$],
    [$n$],
    [$8$],
    [],
    [$12$],
    [$5$],
    [$4$],
    [$6$],
    [$q$],
    [$2$],
    [$3$],
    [$-3$],
    [],
    [],
    [$0.2$],
    [$s_n$],
    [],
    [],
    [#num(398580)],
    [],
    [],
    [],
  )
][
  #auto-parts(
    3,
    [$a_n = 128$, #h(0.3em) $s_n = 255$],
    [$n = 8$, #h(0.3em) $s_n = #num(19680)$],
    [$a_1 = -3$, #h(0.3em) $a_n = #num(531441)$],
    [$q = 1.1$, #h(0.3em) $s_n = 24.4204$ #h(0.3em)
      (also $q = -1.1$, #h(0.3em) $s_n = 4.9724$)],
    [$q = -2.5$, #h(0.3em) $s_n = -435$],
    [$a_1 = 500$, #h(0.3em) $s_n = 624.96$],
  )
  Column (d) has *two* answers, because $q^4 = 1.4641$ has two real
  solutions. Reporting only the positive one is a genuine, common
  error: an even power always loses a sign.
  #heuristic("check an extreme or special case")
]

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: false,
  hints: (
    [In a geometric triple $a, b, c$ the product $a b c$ equals
      $b^3$ — why? #heuristic("look for what stays the same")],
  ),
)[
  Three consecutive terms of a geometric sequence add up to $14$ and
  have product $-1728$. Find the three terms.
][
  Writing the triple as $b/q, b, b q$ makes the product collapse to
  $b^3$, so $b^3 = -#num(1728)$ and $b = -12$. The outer terms then
  sum to $14 - (-12) = 26$ and multiply to
  $-#num(1728) \/ (-12) = 144$, so they are the roots of
  $x^2 - 26 x + 144 = 0$, namely $8$ and $18$.

  The terms are $8, -12, 18$ (with $q = -3/2$), or the same three
  in reverse order.
]

== Convergent and Divergent Series

#only-theory[=== Zeno's Paradox]

#only-theory[
  Zeno of Elea, as reported by Aristotle, argued that motion is
  impossible: anything traveling to a goal must first reach the
  halfway point, and before that the quarter point, and so on
  without end. Completing infinitely many tasks, he said, cannot be
  done.

  To catch a bus, then, Homer must cover half the distance, then
  half of what remains, then half of *that*, forever. The steps form
  the geometric sequence $1/2, 1/4, 1/8, dots$ — and yet Homer
  plainly catches the bus.

  The resolution is that the infinitely many steps add up to a
  *finite* total. Apply the multiply-and-subtract trick to the
  infinite sum directly:
  $
    S = 1/2 + 1/4 + 1/8 + dots.c, quad
    2 S = 1 + 1/2 + 1/4 + dots.c, quad
    2 S - S = S = 1.
  $
  Each step also takes half the time of the one before, so the total
  time is finite too, and the paradox dissolves. Zeno's error was
  not in the arithmetic — it was assuming that infinitely many
  positive quantities must add to something infinite.

  A finite value that a sequence or a series approaches in this way
  is called a #vocab("limit", "Grenzwert").
]

#only-high[
  #definition(title: "Limit of a sequence")[
    A sequence $(a_n)$ tends to the *limit* $a$ if for every
    $epsilon > 0$ there is an index $N in NN$ such that
    $ abs(a_n - a) < epsilon quad "for all" n >= N. $
    We write $#limn a_n = a$.

    Read it as a challenge and a response: whatever tolerance
    $epsilon$ someone demands — however small — you can name a point
    $N$ in the sequence beyond which every single term is inside
    that tolerance.
  ]
]

#keybox(title: "Infinite geometric series")[
  If $abs(q) < 1$, the terms of a geometric sequence shrink to
  nothing,
  $ #limn a_1 dot q^(n-1) = 0, $
  and the partial sums approach a finite value:
  $
    #limn s_n = #limn a_1 dot (1 - q^n)/(1 - q) = a_1/(1 - q).
  $
  If $abs(q) >= 1$ the series *diverges* and has no value at all.
]

#warning[
  The condition $abs(q) < 1$ is not decoration. Substituting
  $q >= 1$ into $a_1 \/ (1 - q)$ produces a number, and that number
  is meaningless — for $q > 1$ it is even negative while every term
  of the series is positive. Check the condition *before* you use
  the formula, every time.
]

#example(title: "An infinite geometric series")[
  For $1 + 1/2 + 1/4 + 1/8 + dots.c$ we have $a_1 = 1$ and
  $q = 1/2$. Since $abs(q) < 1$ the series converges, to
  $ 1/(1 - 1/2) = 2. $
]

#ex(difficulty: 2, time: "12 min")[
  A student asked an AI chatbot for the value of the infinite series
  $ 2 + 3 + 4.5 + 6.75 + dots.c $
  and received this answer: "This is a geometric series with
  $a_1 = 2$ and $q = 1.5$. Using the formula $s = a_1 \/ (1 - q)$,
  the value is $s = 2 \/ (1 - 1.5) = -4$." \
  Every arithmetical step is carried out correctly — and yet the
  answer is absurd. Explain what went wrong, and state the condition
  that was ignored.
][
  Every term is positive and each is larger than the last, so no
  finite total is possible, let alone a negative one: the partial
  sums grow without bound and the series *diverges*.

  The formula $s = a_1 \/ (1 - q)$ holds only for $abs(q) < 1$, and
  here $q = 1.5$. The chatbot applied a correct formula outside its
  region of validity — which is precisely the failure a fluent
  answer is best at hiding.

  The moral is worth stating plainly: checking the *hypotheses* of a
  formula is part of using it, and you can only perform that check
  if you know the mathematics yourself. A confident tone is not
  evidence.
]

#ex(difficulty: 1, time: "15 min", calculator: true)[
  Calculate the value of each infinite geometric series. In each
  case, state $q$ and check that the series converges.
  #auto-parts(
    3,
    [$1 + 1/4 + 1/16 + dots.c$],
    [$5 + 3/2 + 9/20 + dots.c$],
    [$3 - 3/2 + 3/4 - dots.c$],
    [$1 - 2/3 + 4/9 - dots.c$],
    [$2 + sqrt(2) + 1 + dots.c$],
    [$8 + 4 sqrt(3) + 6 + dots.c$],
  )
][
  #auto-parts(
    3,
    [$q = 1/4$: #h(0.4em) $4/3$],
    [$q = 3/10$: #h(0.4em) $50/7$],
    [$q = -1/2$: #h(0.4em) $2$],
    [$q = -2/3$: #h(0.4em) $3/5$],
    [$q = sqrt(2)/2$: #h(0.4em) $2 dot (2 + sqrt(2)) approx 6.83$],
    [$q = sqrt(3)/2$: #h(0.4em)
      $16 dot (2 + sqrt(3)) approx 59.71$],
  )
  In (e) and (f) the ratio is irrational but still smaller than $1$
  in absolute value, so the series converge; rationalize the
  denominator at the end.
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  An infinite geometric series has a value that is $2.4$ larger than
  its first term. Given that $q = 1/6$, find $a_1$.
][
  The value is $a_1 \/ (1 - q) = 6 a_1 \/ 5$, so
  $ 6/5 a_1 - a_1 = 1/5 a_1 = 2.4 quad ==> quad a_1 = 12. $
  Equivalently: everything after the first term is itself a
  geometric series with first term $a_1 q$, summing to
  $a_1 q \/ (1 - q) = a_1 \/ 5$.
]

#ai-box(role: "Checker")[
  Do the next exercise on paper first. Then have an AI convert the
  same six decimals and compare answers, fraction by fraction.

  Wherever you disagree, do not just take its word or yours. Settle
  the dispute independently: divide your fraction back out and watch
  which digits come up. Repeating decimals are one of the rare
  topics where you can verify every answer completely, so use that.
]

#ex(
  difficulty: 2,
  time: "20 min",
  calculator: false,
  hints: (
    [$0.overline(5)$ means $5/10 + 5/100 + 5/1000 + dots.c$ — a
      geometric series with $q = 1/10$. For (d)–(f), the digits
      before the repeating block are not part of the series; deal
      with them separately.],
  ),
)[
  Write each repeating decimal as a fraction in lowest terms.
  #auto-parts(
    3,
    [$0.overline(5)$],
    [$0.overline(54)$],
    [$0.overline(543)$],
    [$0.1overline(3)$],
    [$0.25overline(7)$],
    [$0.4overline(81)$],
  )
][
  #auto-parts(
    3,
    [$5/9$],
    [$6/11$],
    [$181/333$],
    [$2/15$],
    [$58/225$],
    [$53/110$],
  )
  For (b): $a_1 = 54/100$ and $q = 1/100$, so the value is
  $(54\/100)\/(99\/100) = 54/99 = 6/11$. For (d): the repeating
  part starts one place in, so
  $0.1overline(3) = 1/10 + (3\/100)\/(1 - 1\/10) = 1/10 + 1/30
  = 2/15$.
]

#look-ahead(
  title: "Every repeating decimal is a fraction",
  preview: [the structure of the real numbers],
)[
  The exercise above is not a collection of tricks — it is a proof
  that *every* repeating decimal is a rational number, since the
  argument never used anything special about the digits.

  The converse is true as well: every fraction has a decimal
  expansion that either terminates or eventually repeats, because
  long division has only finitely many possible remainders. Put the
  two together and you have a complete characterization: a real
  number is rational exactly when its decimal expansion eventually
  repeats. So $sqrt(2)$ and $pi$, being irrational, must have
  expansions that never settle into any pattern at all.
]

== Geometric Figures and Growth

#only-theory[=== The Koch Snowflake]

// #koch-star(R: 1.7cm)
#fig(
  image("images/koch-snowflake.png", width: 90%),
  caption: "The first four iterations of the Koch Curve",
)

#exploration(title: "The Koch snowflake")[
  Start from an equilateral triangle. At each step, every edge is cut
  into three equal parts and an outward equilateral bump is built on
  the middle third. The figure above shows the result of the first three
  steps (plus the initial triangle).

  Before reading on, work out for yourself:
  - By what factor does the *number of edges* grow at each step?
  - By what factor does the *length of one edge* shrink?
  - So what happens to the total perimeter after many steps?
  - Roughly how much *area* is added at each step, compared with the
    area added at the step before?

  Then make a conjecture about the perimeter and the area "at
  infinity". One of the two answers should surprise you.
]

#only-theory[
  The construction is a #vocab("fractal", "Fraktal"), and it settles
  the conjecture in a way that is worth stating carefully.

  At each step every edge becomes four edges of one third the
  length, so the perimeter is multiplied by $4/3$. Since
  $4/3 > 1$, the perimeter *diverges*: the boundary of the snowflake
  has infinite length.

  The area behaves completely differently. Writing $a_0$ for the
  area of the starting triangle, the area added at step $n$ is
  $ (a_0)/3 dot (4/9)^(n-1), $
  a geometric sequence with $abs(q) = 4/9 < 1$. Summing it and
  adding the original triangle:
  $ a_0 + (a_0 \/ 3)/(1 - 4/9) = a_0 + (3 a_0)/5 = (8 a_0)/5. $
  So the snowflake encloses exactly $8/5$ of the starting triangle's
  area, while its boundary is infinitely long. Infinite perimeter
  and finite area are not in conflict — the perimeter series has
  $q > 1$ and the area series has $q < 1$, and that is the whole
  explanation.
]

#ex(
  difficulty: 2,
  time: "20 min",
  calculator: true,
  hints: (
    [What is the ratio of *areas* between one square and the next?
      And the ratio of *lengths*?
      #heuristic("look for what stays the same")],
  ),
)[
  The largest possible circle is inscribed in a square of side
  $a = 10$ cm; the largest possible square is inscribed in that
  circle; the largest possible circle in that square; and so on
  indefinitely. Calculate
  #auto-parts(
    1,
    [the sum of the perimeters of all the squares,],
    [the sum of the areas of all the circles.],
  )
][
  A square inscribed in the circle inscribed in a square of side $a$
  has diagonal $a$, hence side $a \/ sqrt(2)$: lengths are
  multiplied by $1 \/ sqrt(2)$ each time, and areas by $1/2$.
  #auto-parts(
    1,
    [Perimeters: $a_1 = 40$ cm and $q = 1\/sqrt(2)$, so
      $
        s = 40/(1 - 1\/sqrt(2)) = 40 dot (2 + sqrt(2))
        approx 136.57 "cm".
      $],
    [Circle areas: the first circle has radius $5$, so
      $a_1 = 25 pi$, and $q = 1/2$, giving
      $ s = (25 pi)/(1 - 1/2) = 50 pi approx 157.08 "cm"^2. $],
  )
]

#ex(
  difficulty: 2,
  time: "20 min",
  calculator: true,
  hints: (
    [Both parts are geometric series. For the areas the ratio is
      $1/2$; for the perimeters it is $1\/sqrt(2)$, because
      perimeters scale with *length*, not with area.],
  ),
)[
  Joining the midpoints of the sides of a square of side $a = 8$ cm
  gives a second square inside it; joining the midpoints of that one
  gives a third, and so on forever.
  #nested-squares(side: 3cm, levels: 6)
  #auto-parts(
    1,
    [Show that each square has exactly half the area of the one
      before it.],
    [Find the total area of all the squares in the family.],
    [Each step leaves four corner triangles outside the new square.
      Find the total area of all these corner triangles, over all
      steps, and interpret the result.],
    [Find the total perimeter of all the squares.],
  )
][
  #auto-parts(
    1,
    [The new square's side is the hypotenuse of a right triangle with
      legs $a\/2$, so it measures $a \/ sqrt(2)$ and its area is
      $a^2 \/ 2$.],
    [Areas $64, 32, 16, dots$ with $q = 1/2$:
      $ s = 64/(1 - 1/2) = 128 "cm"^2. $],
    [The corner triangles at step $n$ make up half of square $n$, so
      their areas are $32, 16, 8, dots$ with $q = 1/2$, giving
      $ s = 32/(1 - 1/2) = 64 "cm"^2 $
      — exactly the area of the original square. That is the right
      answer for a reason worth seeing: every point of the original
      square except the single center point eventually falls outside
      one of the squares, so the corner triangles tile it completely.],
    [Perimeters $32, 32\/sqrt(2), 16, dots$ with
      $q = 1 \/ sqrt(2)$:
      $
        s = 32/(1 - 1\/sqrt(2)) = 32 dot (2 + sqrt(2))
        approx 109.25 "cm".
      $],
  )
]

#ex(
  level: "high",
  difficulty: 3,
  time: "25 min",
  calculator: false,
  hints: (
    [#heuristic("draw a picture") of two consecutive plumb lines and
      the right triangles they form. Each plumb line is the previous
      one multiplied by the same factor — which factor?],
  ),
)[
  #fig(
    image("images/plumb-lines.png", width: 50%),
  )
  From a point $A$, a segment $A S$ of length $a$ is drawn at an
  acute angle $alpha$ to a base line through $A$. From $S$ a
  perpendicular drops to the base line; from its foot a new
  perpendicular is raised to the segment $A S$; from that foot
  another perpendicular drops to the base line, and so on inward
  toward $A$. Calculate the total length of all these
  perpendiculars.
][
  The first perpendicular has length $a sin alpha$. In each right
  triangle the next perpendicular is the previous one multiplied by
  $cos alpha$, so the lengths form a geometric sequence with
  $q = cos alpha$, and $0 < cos alpha < 1$ for acute $alpha$. Hence
  $ s = (a sin alpha)/(1 - cos alpha). $
  Sanity check: as $alpha -> 90 degree$ this tends to $a$, which is
  right — the first perpendicular is then the segment itself and
  everything after it collapses.
]

#ex(
  level: "high",
  difficulty: 3,
  time: "25 min",
  calculator: true,
  hints: (
    [The total length is the easy half. For the center,
      #heuristic("introduce notation"): describe each edge as a
      displacement vector.],
    [Each edge vector is the previous one rotated by $90 degree$ and
      scaled by $3\/4$. Sum the $x$\u{2011} and
      $y$\u{2011}components separately — two geometric series.],
  ),
)[
  A spiral $P_0 P_1 P_2 dots$ has $P_0 = (0, 0)$, $P_1 = (4, 0)$ and
  $P_2 = (4, 3)$, and each successive edge is shorter than the last
  by a constant factor, turning through $90 degree$ each time.
  #auto-parts(
    1,
    [What is the total length of the spiral?],
    [What are the coordinates of the point $C$ the spiral winds in
      toward?],
  )
][
  The first edge has length $4$ and the second $3$, so $q = 3/4$.
  #auto-parts(
    1,
    [$s = 4/(1 - 3/4) = 16$.],
    [Let $arrow(v) = (x, y)$ be the sum of all the edge vectors.
      Every edge after the first is the previous one rotated by
      $90 degree$ and scaled by $3/4$, so
      $ (x, y) = (4, 0) + 3/4 dot (-y, x). $
      This gives $x = 4 - 3y\/4$ and $y = 3x\/4$, hence
      $x = 64/25 = 2.56$ and $y = 48/25 = 1.92$. Since
      $P_0$ is the origin, $C = (2.56, 1.92)$.],
  )
]

#print-hints()

#print-vocab()
