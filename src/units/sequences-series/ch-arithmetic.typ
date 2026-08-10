// ============================================================
//  ch-arithmetic.typ — Arithmetic Sequences and Series
//
//  Lehrplan anchor
//    GLF 3. Klasse, 2.1 Folgen und Reihen
//      - Berechnungen mit arithmetischen und geometrischen
//        Folgen und Reihen durchführen
//    SPF 2. Klasse, 1.1 Folgen und Reihen
//      - arithmetische und geometrische Folgen und Reihen
//        erkennen und anwenden
//    No (BfKM) marker on either entry, so no bfkm[...] tags here.
//
// ── TEACHER'S NOTE: one error in the previous version ───────
//  * The salary exercise (start CHF 48'000, +500 per year) gave
//    the 15th-year salary as CHF 55'500. With a_1 = 48'000 in the
//    first year, a_(15) = 48'000 + 14 · 500 = CHF 55'000. The
//    printed answer counted 15 raises instead of 14 — while the
//    SECOND half of the same exercise ("49th year, after 48
//    raises") uses the correct convention. The two halves therefore
//    contradicted each other. Corrected to 55'000, and the exercise
//    now asks students to state their indexing convention, which is
//    exactly the off-by-one trap flagged in ch-basics.
//
// ── ONE PROOF REPLACED ──────────────────────────────────────
//  * The sqrt(2)/sqrt(3)/sqrt(5) exercise ended in "impossible,
//    since they are linearly independent over Q" — true, but it
//    appeals to machinery no Gymnasium student has, so as written
//    it is an assertion rather than a proof. Replaced with a fully
//    elementary argument that ends at "sqrt(10) is rational",
//    which students CAN close, having seen the irrationality of
//    sqrt(2) proved by contradiction. Same difficulty rating; the
//    hints now steer toward the new route.
//
// ── SMALLER CHANGES ─────────────────────────────────────────
//  * Exercises interleaved with the theory they test; each block
//    opens with a 1-dot problem.
//  * parts() with hand-typed letters -> auto-parts() (1:1 checked).
//  * time: and calculator: on every exercise. GLF sits the TI-30X
//    Pro, SPF the TI-Nspire CAS, but the badge is a policy flag,
//    not a machine flag.
//  * The "d is a slope" observation was only-high. Both tracks have
//    done linear functions, so it is now a shared look-back — it is
//    the single most useful sentence in the chapter.
//  * Second form of the sum formula, s_n = n/2 · (2a_1 + (n-1)d),
//    added: the first form is useless when a_n is the unknown.
// ============================================================

#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Arithmetic Sequences and Series")

#let ex = exercise.with(chapter: "Arithmetic")

= Arithmetic Sequences and Series

#epigraph[
  Add the same thing often enough and you have drawn a straight line.
]

#only-theory[
  The previous chapter described sequences in general. From here on
  we specialize, and the two families we single out are the two
  simplest imaginable: the sequences that grow by repeated
  *addition*, and the sequences that grow by repeated
  *multiplication*. This chapter is the first of the two.

  They are worth a chapter each not because they are hard, but
  because almost everything that is modeled with a sequence turns out
  to be one of them, or close enough to one of them to be useful.
]

#objectives(
  [recognize an arithmetic sequence from a list of terms, and find
    its common difference],
  [set up the general term $a_n$ of an arithmetic sequence from any
    two pieces of information about it],
  [compute a partial sum of an arithmetic sequence with either form
    of the sum formula, and choose the form that fits the data],
  [explain why Gauss's pairing argument works, and reproduce it],
  [translate a situation described in words into an arithmetic
    sequence, stating your indexing convention],
)

== Arithmetic Sequences

#definition(title: "Arithmetic sequence")[
  An #vocab("arithmetic sequence", "arithmetische Folge") (or
  #emph[progression]) $(a_n)_(n in NN)$ is a sequence in which the
  difference between consecutive terms is constant:
  $ a_(n+1) - a_n = d quad "for all" n in NN. $
  The number $d$ is the
  #vocab("common difference", "Differenz") of the sequence.
]

#only-theory[
  The definition is recursive: it says $a_(n+1) = a_n + d$, a rule
  for stepping forward. Stepping forward $n - 1$ times from $a_1$
  adds $d$ exactly $n - 1$ times, which gives the explicit form.
]

#keybox(title: "Arithmetic sequences")[
  $
    "recursive:" quad cases(a_1 "given", a_(n+1) = a_n + d)
    quad quad quad
    "explicit:" quad a_n = a_1 + (n - 1) dot d
  $
  Read the explicit formula as an instruction: start at $a_1$, then
  take $(n - 1)$ steps of size $d$. The commonest mistake in this
  whole unit is writing $n dot d$ instead of $(n - 1) dot d$.
]

#look-back(
  title: "An arithmetic sequence is a linear function",
  recalls: [linear functions and their slope],
)[
  Multiply out the explicit formula:
  $ a_n = a_1 + (n - 1) dot d = d n + (a_1 - d). $
  That is $y = m x + c$ with $m = d$ and $c = a_1 - d$. So plotting
  $a_n$ against $n$ gives points sitting exactly on a straight line
  of slope $d$ — not a continuous line, since only whole-number
  inputs are allowed, but a row of dots along one.

  Everything you know about linear functions transfers. A positive
  $d$ means the sequence increases forever, a negative $d$ that it
  decreases forever, and $d = 0$ gives a constant sequence. An
  arithmetic sequence never levels off and never turns around.
]

#example(title: "Finding a sequence from two of its terms")[
  An arithmetic sequence has $a_3 = -5$ and $a_6 = 5$. Find $a_n$.

  Going from $a_3$ to $a_6$ takes three steps, so $3 d = 5 - (-5)$
  and $d = 10/3$. Stepping back two steps from $a_3$ to $a_1$:
  $ a_1 = -5 - 2 dot 10/3 = -35/3. $
  Therefore $a_n = -35/3 + (n - 1) dot 10/3$.

  Note what was *not* done: no system of equations was set up. The
  gap between two known terms tells you $d$ directly, because $d$ is
  the size of one step and you can count the steps.
  #heuristic("draw a picture")
]

#ex(difficulty: 1, time: "12 min", calculator: false)[
  For each arithmetic sequence below, find an expression for $a_n$
  and list the first five terms.
  #auto-parts(
    1,
    [$3, 11, dots$],
    [$a_1 = 5, quad d = 4$],
    [$a_2 = 4, quad d = -1/5$],
    [$a_3 = -5, quad a_6 = 5$],
    [$a_(20) = 11.11, quad d = -0.77$],
  )
][
  #auto-parts(
    1,
    [$a_n = 3 + (n - 1) dot 8$; #h(0.4em) $3, 11, 19, 27, 35$],
    [$a_n = 5 + (n - 1) dot 4$; #h(0.4em) $5, 9, 13, 17, 21$],
    [$a_n = 21/5 - (n - 1) dot 1/5$; #h(0.4em)
      $21/5, 4, 19/5, 18/5, 17/5$],
    [$a_n = -35/3 + (n - 1) dot 10/3$; #h(0.4em)
      $-35/3, -25/3, -5, -5/3, 5/3$],
    [$a_n = 25.74 - (n - 1) dot 0.77$; #h(0.4em)
      $25.74, 24.97, 24.2, 23.43, 22.66$],
  )
  In (c), (d) and (e) the given term is not $a_1$, so step backwards
  to $a_1$ first — and count the steps rather than the terms.
]

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: true,
  hints: (
    [Decide first which year is $n = 1$, and write that decision
      down. Everything after that is one substitution.],
  ),
)[
  A job advertisement offers a starting salary of CHF #num(48000)
  per year, rising by CHF 500 each year thereafter.
  #auto-parts(
    1,
    [State your indexing convention: which year is year $n = 1$, and
      what is $a_1$?],
    [What is the salary in the 15th year?],
    [In which year does the salary first exceed the starting salary
      by 50%?],
  )
][
  #auto-parts(
    1,
    [Take $n = 1$ to be the first year on the job, so
      $a_1 = #num(48000)$ and $d = 500$, giving
      $a_n = #num(48000) + (n - 1) dot 500$. Starting at $n = 0$
      instead is equally defensible — but then every answer below
      shifts by one, which is exactly why the convention has to be
      stated.],
    [$a_(15) = #num(48000) + 14 dot 500 = "CHF" #num(55000)$.
      Fourteen raises have been paid by the 15th year, not fifteen.],
    [We need $a_n >= #num(72000)$, so
      $(n - 1) dot 500 >= #num(24000)$ and $n >= 49$: the salary
      first reaches CHF #num(72000) in the 49th year, after 48
      raises. Worth noticing that this is a long time — a fixed
      annual raise is a weak kind of growth, and the next chapter
      shows what the alternative looks like.],
  )
]

== The Arithmetic Series

#quotebox[
  The story goes that a schoolmaster, wanting quiet, told his class
  to add up all the whole numbers from 1 to 100. The
  nine-year-old Carl Friedrich Gauss put down his slate almost at
  once with the single number 5050 on it. He had not added
  a hundred numbers; he had noticed that the first and last add to
  101, and so do the second and second-last, and so on for fifty
  pairs.
]

#only-theory[
  The story may well be embroidered, but the idea is sound and it
  proves the general formula. Recall from the previous chapter that
  the #vocab("partial sums", "Teilsummen") of a sequence form a new
  sequence, and that this sequence of partial sums is the
  #vocab("series", "Reihe") belonging to it.
]

#definition(title: "Arithmetic series")[
  Let $(a_n)$ be an arithmetic sequence. The sequence of partial sums
  $ s_n = sum_(k=1)^n a_k $
  is the #vocab("arithmetic series", "arithmetische Reihe")
  associated with $(a_n)$.
]

#theorem(title: "Sum of an arithmetic series")[
  If $(a_k)$ is an arithmetic sequence with common difference $d$,
  then its $n$\u{2011}th partial sum is
  $
    s_n = sum_(k=1)^n a_k = n/2 dot (a_1 + a_n)
    = n/2 dot (2 a_1 + (n - 1) dot d).
  $
]

#proof[
  Write the sum forwards and backwards, one below the other, and add
  column by column:
  $
    s_n &= a_1 &&+ (a_1 + d) &&+ dots.c &&+ (a_1 + (n-1) dot d) \
    s_n &= (a_1 + (n-1) dot d) &&+ (a_1 + (n-2) dot d) &&+ dots.c
    &&+ a_1
  $
  Each of the $n$ columns sums to
  $2 a_1 + (n - 1) dot d = a_1 + a_n$: whatever one row loses moving
  right, the other row gains. Therefore
  $2 s_n = n dot (a_1 + a_n)$, and dividing by $2$ gives the first
  form. Substituting $a_n = a_1 + (n - 1) dot d$ gives the second.
  #heuristic("look for what stays the same")
]

#keybox(title: "Which form to use")[
  Both formulas are the same statement. Choose by what you are given:
  - $n/2 dot (a_1 + a_n)$ — when you know the first and last terms.
    Read it as "number of terms times the average of the ends".
  - $n/2 dot (2 a_1 + (n - 1) dot d)$ — when you know $d$ but not
    $a_n$, which is the usual case when $n$ itself is the unknown.
]

#look-back(
  title: "The odd numbers, revisited",
  recalls: [the dot-counting exploration in the previous chapter],
)[
  The odd numbers $1, 3, 5, dots$ are arithmetic with $a_1 = 1$ and
  $d = 2$, so $a_n = 2n - 1$ and
  $ 1 + 3 + 5 + dots.c + (2n - 1) = n/2 dot (1 + (2n - 1)) = n^2. $
  That is the L-shaped-layers picture from the previous chapter,
  now with a proof attached rather than a drawing. The picture told
  you the answer; the formula tells you why it holds for every $n$
  at once.
]

#look-ahead(
  title: "Adding up a straight line",
  preview: [the definite integral],
)[
  Plot the terms $a_1, a_2, dots, a_n$ as bars standing side by side.
  Their tops lie on a straight line, so the whole picture is a
  trapezoid, and $n/2 dot (a_1 + a_n)$ is exactly the trapezoid's
  area: width times average height.

  In two years' time you will meet the same move for shapes whose
  tops are *not* straight — chop the region into thin strips, add
  their areas, and let the strips get thinner. The sum formula you
  just proved is the one case where no limit is needed.
]

#ex(difficulty: 1, time: "10 min", calculator: false)[
  Calculate the following sums by hand.
  #auto-parts(
    1,
    [$1 + 2 + 3 + dots.c + 100$],
    [$1 + 2 + 3 + dots.c + n$, for a general $n in NN$],
    [$7 + 11 + 15 + dots.c + 43$],
  )
][
  #auto-parts(
    1,
    [$100/2 dot (1 + 100) = #num(5050)$.],
    [$n/2 dot (n + 1)$ — the triangular numbers again.],
    [Here $a_1 = 7$ and $d = 4$, and $43 = 7 + (n - 1) dot 4$ gives
      $n = 10$. So the sum is $10/2 dot (7 + 43) = 250$. Find the
      number of terms *before* reaching for the formula; it is the
      step people skip.],
  )
]

#ex(difficulty: 2, time: "25 min", calculator: true)[
  Find the missing entries of these arithmetic sequences and series.
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
    [$1.2$],
    [$404$],
    [],
    [],
    [$1.8$],
    [$207$],
    [$a_n$],
    [],
    [$-9$],
    [$107$],
    [$0$],
    [],
    [],
    [$n$],
    [$20$],
    [],
    [],
    [$61$],
    [],
    [$46$],
    [$d$],
    [$2.1$],
    [$-7$],
    [$5.2$],
    [],
    [$0.05$],
    [],
    [$s_n$],
    [],
    [],
    [$123$],
    [#num(2196)],
    [#num(4059)],
    [],
  )
][
  #auto-parts(
    3,
    [$a_n = 41.1$, #h(0.3em) $s_n = 423$],
    [$n = 60$, #h(0.3em) $s_n = #num(11850)$],
    [$a_1 = -101$, #h(0.3em) $n = 41$],
    [$a_1 = 72$, #h(0.3em) $d = -1.2$],
    [$a_n = 20.2$, #h(0.3em) $n = 369$],
    [$a_n = -198$, #h(0.3em) $d = -9$],
  )
  Each column is two equations in two unknowns; which two depends on
  which cells are blank. In (c) and (e), the second form of the sum
  formula is the one that works, because $a_n$ and $n$ are both
  unknown.
]

#ai-box(role: "Checker")[
  Complete two columns of the table above on paper. Then give the
  same two columns to an AI chatbot and compare, cell by cell.

  Where you disagree, do not simply adopt its answer. Settle it by
  substituting both candidate values back into $a_n = a_1 + (n-1)dot d$
  *and* into the sum formula — a correct column has to satisfy both.
  Note whether the chatbot's error, if it made one, was arithmetic
  or a wrong choice of formula.
]

#ex(difficulty: 2, time: "12 min", calculator: true)[
  Calculate the sum of all three-digit numbers that are divisible
  by seven.
][
  The numbers form an arithmetic sequence with $d = 7$, first term
  $105$ and last term $994$. From $994 = 105 + (n - 1) dot 7$ we get
  $n = 128$, so
  $ s_(128) = 128/2 dot (105 + 994) = #num(70336). $
]

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: true,
  hints: (
    [List the first few four-digit multiples of $17$: they alternate
      even, odd, even, odd. What is the common difference of the
      *odd* ones alone?],
  ),
)[
  Calculate the sum of all odd four-digit numbers that are divisible
  by $17$.
][
  The four-digit multiples of $17$ run from $1003$ to $9996$, and
  every second one is odd. The odd ones therefore form an arithmetic
  sequence with $d = 34$, from $1003$ to $9979$. From
  $9979 = 1003 + (n - 1) dot 34$ we get $n = 265$, so
  $ s_(265) = 265/2 dot (1003 + 9979) = #num(1455115). $
  #heuristic("solve a simpler version first")
]

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: true,
  hints: (
    [How many integers are used up before block 17 begins? That count
      is itself a sum you already know how to compute.],
  ),
)[
  Let $s_1 = 1$, $s_2 = 2 + 3$, $s_3 = 4 + 5 + 6$, and so on, so that
  the $k$\u{2011}th block holds $k$ consecutive integers. Calculate
  $s_(17)$.
][
  Blocks 1 to 16 use up $1 + 2 + dots.c + 16 = 136$ integers, so
  block 17 runs from $137$ to $153$. Hence
  $ s_(17) = 17/2 dot (137 + 153) = #num(2465). $
]

#ex(
  difficulty: 3,
  time: "25 min",
  calculator: true,
  hints: (
    [What single term of the sequence is $s_(133) - s_(132)$?
      #heuristic("work backwards from the goal")],
    [For (b): a partial sum keeps growing exactly as long as the
      terms being added are positive. When does that stop?],
  ),
)[
  An arithmetic sequence $(a_n)$ has $s_(132) = 330$ and
  $s_(133) = 133$, where $(s_n)$ is the associated series.
  #auto-parts(
    1,
    [Find an expression for $a_n$.],
    [For which $n$ is $s_n$ largest? Why does a maximum exist at
      all?],
  )
][
  #auto-parts(
    1,
    [$a_(133) = s_(133) - s_(132) = -197$. Together with
      $s_(132) = 66 dot (2 a_1 + 131 d) = 330$ this gives $d = -3$
      and $a_1 = 199$, so $a_n = 202 - 3n$.],
    [The terms are positive for $n <= 67$ and negative from
      $n = 68$ on, so the running total climbs up to $n = 67$ and
      falls thereafter: $s_(67) = #num(6700)$ is the largest. A
      maximum exists because $d < 0$ forces the terms to change sign
      exactly once — an arithmetic sequence can never turn back.],
  )
]

#ex(level: "high", difficulty: 2, time: "12 min", calculator: false)[
  Prove the following identities for every arithmetic sequence
  $(a_n)$.
  #auto-parts(
    2,
    [$a_1 - 2 a_2 + a_3 = 0$],
    [$a_1 - 3 a_2 + 3 a_3 - a_4 = 0$],
  )
][
  Write $a_k = a_1 + (k - 1) dot d$ and substitute.
  #heuristic("introduce notation")
  #auto-parts(
    2,
    [$a_1 - 2 dot (a_1 + d) + (a_1 + 2 d) = 0$.],
    [$a_1 - 3 dot (a_1 + d) + 3 dot (a_1 + 2 d) - (a_1 + 3 d) = 0$.],
  )
  The coefficients $1, -2, 1$ and $1, -3, 3, -1$ are the rows of
  Pascal's triangle with alternating signs: these are the second and
  third *finite differences* of a linear sequence, and a linear
  sequence has vanishing second differences by definition.
]

#ex(
  level: "high",
  difficulty: 3,
  time: "20 min",
  calculator: false,
  hints: (
    [Rationalize each denominator first. Then
      #heuristic("look for what stays the same") in the differences
      that appear: set $b - a = c - b = t$.],
  ),
)[
  Show that if $a$, $b$ and $c$ are consecutive terms of an
  arithmetic sequence of positive numbers, then so are
  $
    1/(sqrt(b) + sqrt(c)), quad 1/(sqrt(c) + sqrt(a)), quad
    1/(sqrt(a) + sqrt(b))
  $
  in this order.
][
  Rationalize each term, using $b - a = c - b = t$ and
  $c - a = 2 t$:
  $
    1/(sqrt(b) + sqrt(c)) = (sqrt(c) - sqrt(b))/t, quad
    1/(sqrt(c) + sqrt(a)) = (sqrt(c) - sqrt(a))/(2 t), quad
    1/(sqrt(a) + sqrt(b)) = (sqrt(b) - sqrt(a))/t.
  $
  Three numbers are in arithmetic progression exactly when the outer
  two sum to twice the middle one. Here the outer two sum to
  $(sqrt(c) - sqrt(a)) \/ t$, which is twice the middle term.
  (The degenerate case $t = 0$ is excluded, since then the
  denominators vanish.)
]

#ex(
  level: "high",
  difficulty: 3,
  time: "30 min",
  calculator: false,
  hints: (
    [The three roots need not be *consecutive* terms. If all three
      belong to one progression, each pairwise difference is a whole
      number of steps — #heuristic("introduce notation") for the two
      step counts, say $p$ and $q$.],
    [Clear the common difference $d$ out of the two equations, then
      square. Which square root survives?],
  ),
)[
  Prove that no arithmetic progression can contain all three of
  $sqrt(2)$, $sqrt(3)$ and $sqrt(5)$.
][
  Suppose all three are terms of one progression with common
  difference $d$. Since the terms increase in the order
  $sqrt(2) < sqrt(3) < sqrt(5)$, there are positive integers $p, q$
  with
  $ sqrt(3) - sqrt(2) = q d, quad sqrt(5) - sqrt(3) = p d. $
  Eliminating $d$ gives
  $ q dot (sqrt(5) - sqrt(3)) = p dot (sqrt(3) - sqrt(2)), $
  which rearranges to
  $ (p + q) sqrt(3) = q sqrt(2) + p sqrt(5). $
  Squaring both sides:
  $ 3 dot (p + q)^2 = 2 q^2 + 5 p^2 + 2 p q sqrt(10), $
  so
  $ sqrt(10) = (3 dot (p + q)^2 - 2 q^2 - 5 p^2)/(2 p q), $
  a quotient of integers — but $sqrt(10)$ is irrational, by the same
  argument that shows $sqrt(2)$ is. Contradiction, so no such
  progression exists.
  #heuristic("work backwards from the goal")
]

#exploration(title: "Sums that are not arithmetic")[
  Gauss's pairing trick worked because the terms sat on a straight
  line. Try to stretch it:

  - Compute $1^2 + 2^2 + 3^2 + dots.c + n^2$ for $n = 1, 2, 3, 4, 5$.
    Does pairing from both ends help here? Why not?
  - The five totals you get are $1, 5, 14, 30, 55$. Compare each with
    $n^3 \/ 3$. What do you notice, and what does that suggest the
    formula's leading behavior is?
  - The actual formula is $n dot (n + 1) dot (2n + 1) \/ 6$. Check it
    against your five totals. Can you find any argument for it, or is
    checking all you can do? (Being able to *verify* a formula you
    cannot yet *derive* is a normal and honest position to be in —
    and the technique that closes the gap is one of the SPF topics of
    this unit.)
]

#print-hints()

#print-vocab()
