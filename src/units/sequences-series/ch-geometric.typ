// ============================================================
//  ch-geometric.typ — Geometric Sequences and Series
// ============================================================
#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Geometric Sequences and Series")

#let ex = exercise.with(chapter: "Geometric")

= Geometric Sequences and Series

== Geometric Sequences

#definition(title: "Geometric sequence")[
A *geometric sequence* (or *progression*) $(a_n)_(n in NN)$ is a sequence in
which the ratio between consecutive terms is constant:
$ a_(n+1) / a_n = q quad "for all" n in NN. $
The number $q$ is the *common ratio*, and the general term is
$ a_n = a_1 dot q^(n-1). $
]

#only-high[
Where an arithmetic sequence grows by repeated _addition_, a geometric sequence
grows by repeated _multiplication_. Plotting $a_n$ against $n$ now traces an
exponential curve rather than a straight line.
]

=== Exercises

#ex(difficulty: 1)[
Given the following information about a geometric sequence, find a general
expression for $a_n$ and list the first five terms.
#parts(1,
  [(a) $7, 14, dots$],
  [(b) $a_1 = -6, #h(0.3em) q = 1/2$],
  [(c) $a_4 = 9, #h(0.3em) q = 1/3$],
  [(d) $a_2 = 10, #h(0.3em) a_3 = -5$],
  [(e) $a_2 = 1.5, #h(0.3em) q = -2$],
)
][
#parts(1,
  [(a) $a_n = 7 dot 2^(n-1)$],
  [(b) $a_n = -6 dot (1/2)^(n-1)$],
  [(c) $a_n = 243 dot (1/3)^(n-1)$],
  [(d) $a_n = -20 dot (-1/2)^(n-1)$],
  [(e) $a_n = -0.75 dot (-2)^(n-1)$],
)
]

#ex(difficulty: 2)[
Determine the next three terms of each geometric sequence.
#parts(2,
  [(a) $3/4, #h(0.2em) 1, #h(0.2em) dots$],
  [(b) $sqrt(2), #h(0.2em) 2, #h(0.2em) dots$],
  [(c) $a^2, #h(0.2em) a dot b, #h(0.2em) dots$],
  [(d) $1/x, #h(0.2em) x, #h(0.2em) dots$],
)
][
#parts(2,
  [(a) $4/3, #h(0.2em) 16/9, #h(0.2em) 64/27$],
  [(b) $2 sqrt(2), #h(0.2em) 4, #h(0.2em) 4 sqrt(2)$],
  [(c) $b^2, #h(0.2em) b^3 / a, #h(0.2em) b^4 / a^2$],
  [(d) $x^3, #h(0.2em) x^5, #h(0.2em) x^7$],
)
]

#ex(level: "high", difficulty: 2)[
The numbers $a - 4$, $a + 2$ and $3 a + 1$ are three consecutive terms of a
geometric sequence. Find the two possible values of the common ratio $q$.
][
The geometric condition $(a + 2)^2 = (a - 4) dot (3 a + 1)$ gives $a = 9$ or $a = 0$,
leading to $q = 8$ or $q = -1/2$.
]

#ex(level: "high", difficulty: 2)[
Let $a_1, a_2, a_3$ be terms of a geometric sequence with positive terms. What
can you say about $log(a_1), log(a_2), log(a_3)$?
][
They form an *arithmetic* sequence: taking $log$ of $a_n = a_1 dot q^(n-1)$ gives
$log a_n = log a_1 + (n - 1) log q$, which is linear in $n$ with common
difference $log q$.
]

#ex(level: "high", difficulty: 2, hints: (
  [#heuristic("introduce notation") — and use the arithmetic condition
   together with the given sum to pin down $b$ before anything else.],
))[
Three numbers $a, b, c$ form an arithmetic sequence in this order and add up to
$3$. Reordered as $b, a, c$ they form a geometric sequence. Find $a$, $b$ and
$c$.
][
From the arithmetic condition $a + c = 2 b$ and the sum $a + b + c = 3$ we get
$b = 1$. The geometric condition $a^2 = b dot c$ then yields $-2, 1, 4$ or the
trivial $1, 1, 1$.
]

#ex(level: "high", difficulty: 3, time: "20 min")[
The numbers $z_1, z_2, z_3, z_4$ form an arithmetic sequence. The numbers
$z_2, z_3, z_1, z_4 + 3$ form a geometric sequence. Find $z_1, z_2, z_3, z_4$.
][
Writing $z_k = z_1 + (k - 1) dot d$ and imposing the geometric ratios gives
$z_1, z_2, z_3, z_4 = -4, -1, 2, 5$.
]

== The Geometric Series

#definition(title: "Geometric series")[
Let $(a_n)$ be a geometric sequence. The sequence of partial sums
$ s_n = sum_(k=1)^n a_k $
is the *geometric series* associated with $(a_n)$.
]

#only-theory[=== The Legend of the Chessboard]

#quotebox[
When the inventor of chess showed the game to his ruler, he was offered any
reward he chose. He asked, modestly, for one grain of wheat on the first square
of the board, two on the second, four on the third, and so on — doubling each
time. The ruler agreed at once, only to discover that all the granaries of the
kingdom could not supply the total. (Adapted from a tale recounted on
Wikipedia.)
]

#abstraction-ladder(
  l0: [One grain on the first square, two on the second, four on the third —
       doubling on each of the 64 squares of the board.],
  l1: [Grains per square: #h(0.4em) 1, 2, 4, 8, 16, ...],
  l2: [Each square holds twice the previous one:
       #h(0.4em) $cases(a_1 = 1, a_(n+1) = 2 a_n)$.],
  l3: [$a_n = 2^(n-1)$, so the ruler owes $S = sum_(k=1)^64 2^(k-1)$ grains.],
)

#only-theory[
The number of grains is
$ S = 1 + 2 + 2^2 + 2^3 + dots.c + 2^63. $
Multiplying by $2$ and subtracting the original sum, almost everything cancels:
$ 2 S - S = 2^64 - 1, quad "so" quad S = 2^64 - 1 approx 1.8 times 10^19. $

This trick works for any geometric series. With $a_n = a_1 dot q^(n-1)$,
$ s_n = a_1 + a_1 dot q + dots.c + a_1 dot q^(n-1). $
Multiplying by $q$ and subtracting gives $(q - 1) s_n = a_1 dot (q^n - 1)$, hence:
]

#theorem(title: "Sum of a finite geometric series")[
For a geometric sequence with common ratio $q != 1$,
$ s_n = a_1 dot (q^n - 1)/(q - 1) = a_1 dot (1 - q^n)/(1 - q). $
]

#remark[
Both forms are equal; the second is tidier when $abs(q) < 1$, since then both
numerator and denominator are positive.
]

=== Exercises

#ex(difficulty: 2)[
Calculate the missing parts of these geometric sequences and series.
#data-table(
  columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  [], [(a)], [(b)], [(c)], [(d)], [(e)], [(f)],
  [$a_1$], [$1$], [$6$], [], [$4$], [$40$], [],
  [$a_n$], [], [$13122$], [], [$5.8564$], [$-625$], [$0.16$],
  [$n$],   [$8$], [], [$12$], [$5$], [$4$], [$6$],
  [$q$],   [$2$], [$3$], [$-3$], [], [], [$0.2$],
  [$s_n$], [], [], [$398580$], [], [], [],
)
][
#parts(3,
  [(a) $a_n = 128, #h(0.2em) s_n = 255$],
  [(b) $n = 8, #h(0.2em) s_n = 19'680$],
  [(c) $a_1 = -3, #h(0.2em) a_n = 531'441$],
  [(d) $q = 1.1, #h(0.2em) s_n = 24.4204$ (or $q = -1.1, #h(0.2em) s_n = 4.9724$)],
  [(e) $q = -2.5, #h(0.2em) s_n = -435$],
  [(f) $a_1 = 500, #h(0.2em) s_n = 624.96$],
)
]

#ex(difficulty: 2, hints: (
  [In a geometric triple $a, b, c$, the product $a dot b dot c$ equals $b^3$ — why?
   #heuristic("look for what stays the same")],
))[
Three consecutive terms of a geometric sequence add up to $14$ and have product
$-1728$. Find the three terms.
][
The middle term satisfies $b^3 = -1728$, so $b = -12$; the outer terms then sum
to $26$ with product $144$, giving $8, -12, 18$ (or reversed).
]

== Convergent and Divergent Series

#only-theory[=== Introductory Example: Zeno's Paradox]

#quotebox[
"That which is in locomotion must arrive at the half-way stage before it
arrives at the goal." — as recounted by Aristotle.
]

#only-theory[
To reach a bus, Homer must first cover half the distance, then half of what
remains, then half of _that_, forever. The steps form the sequence
$1/2, 1/4, 1/8, dots$ Zeno argued that completing infinitely many tasks is
impossible — yet Homer plainly catches the bus. The resolution is that the
infinitely many steps add to a _finite_ total:
$ S = 1/2 + 1/4 + 1/8 + dots.c, quad 2 S = 1 + 1/2 + 1/4 + dots.c, quad
  2 S - S = S = 1. $
Since each step also takes half the time of the one before, the whole journey
finishes in finite time.

A finite value approached by a sequence or series is called a *limit*.
]

#only-high[
#definition(title: "Limit")[
A sequence $(a_n)$ tends to the *limit* $a$ if for every $epsilon > 0$ there is
an index $N in NN$ such that
$ abs(a_n - a) < epsilon quad "for all" n >= N. $
We write $limn a_n = a$.
]
]

#keybox(title: "Geometric limits")[
If $abs(q) < 1$, then the terms of a geometric sequence vanish,
$ limn a_1 dot q^(n-1) = 0, $
and the geometric series converges to
$ limn s_n = limn a_1 dot (1 - q^n)/(1 - q) = a_1 / (1 - q). $
]

#example(title: "An infinite geometric series")[
For $1 + 1/2 + 1/4 + 1/8 + dots.c$ we have $a_1 = 1$ and $q = 1/2$, so the value
is $ 1 / (1 - 1/2) = 2. $
]

=== Exercises

#ex(difficulty: 1)[
Calculate the value of each infinite geometric series.
#parts(3,
  [(a) $1 + 1/4 + 1/16 + dots.c$],
  [(b) $5 + 3/2 + 9/20 + dots.c$],
  [(c) $3 - 3/2 + 3/4 - dots.c$],
  [(d) $1 - 2/3 + 4/9 - dots.c$],
  [(e) $2 + sqrt(2) + 1 + dots.c$],
  [(f) $8 + 4 sqrt(3) + 6 + dots.c$],
)
][
#parts(3,
  [(a) $4/3$],
  [(b) $50/7$],
  [(c) $2$],
  [(d) $3/5$],
  [(e) $2 dot (2 + sqrt(2)) approx 6.83$],
  [(f) $16 dot (2 + sqrt(3)) approx 59.71$],
)
]

#ex(difficulty: 2)[
A student asked an AI chatbot for the value of the infinite series
$ 2 + 3 + 4.5 + 6.75 + dots.c $
and received this answer: "This is a geometric series with $a_1 = 2$ and
$q = 1.5$. Using the formula $s = a_1 / (1 - q)$, the value is
$s = 2 / (1 - 1.5) = -4$." \
The arithmetic is carried out correctly — and yet the answer is absurd.
Explain what went wrong, and state the condition that was ignored.
][
Every term is positive and growing, so no sum of them can equal $-4$ — or
any finite number: the series *diverges*. The formula $s = a_1 \/ (1 - q)$
is valid only for $abs(q) < 1$; the AI (like a careless human) applied it
outside its region of validity. Moral: a fluent, correctly computed answer
can still be wrong. Checking the *hypotheses* of a formula is part of using
it — and you can only do that check if you know the mathematics yourself.
]

#ex(difficulty: 2)[
An infinite geometric series has a value that is $2.4$ larger than its first
term. Find $a_1$, given that $q = 1/6$.
][
The tail beyond $a_1$ sums to $a_1 q / (1 - q) = a_1 / 5 = 2.4$, so $a_1 = 12$.
]

#ai-box(role: "Checker")[
Do the next exercise on paper first. Then have an AI convert the same
decimals and compare your answers, fraction by fraction. Wherever you
disagree, settle the dispute with an independent check: divide your fraction
back out — by hand or with a calculator — and watch which digits appear.
]

#ex(difficulty: 2)[
Write each repeating decimal as a fraction.
#parts(3,
  [(a) $0.overline(5)$],
  [(b) $0.overline(54)$],
  [(c) $0.overline(543)$],
  [(d) $0.1overline(3)$],
  [(e) $0.25overline(7)$],
  [(f) $0.4overline(81)$],
)
][
#parts(3,
  [(a) $5/9$],
  [(b) $6/11$],
  [(c) $181/333$],
  [(d) $2/15$],
  [(e) $58/225$],
  [(f) $53/110$],
)
]

== Geometric Applications

#only-theory[=== The Koch Snowflake]

#koch-star(R: 1.7cm)

#exploration(title: "The Koch snowflake")[
At each step, every edge of the figure is cut into thirds and an outward
equilateral bump is added on the middle third. Before reading on, work out
for yourself: by what factor does the *number of edges* grow at each step?
The *length of one edge*? So what happens to the total perimeter? And
roughly how much *area* is added at each step, compared with the step
before? Conjecture what happens to perimeter and area "at infinity."
]

#only-theory[
The *Koch snowflake* starts from an equilateral triangle; at each step every
edge is trisected and an outward equilateral bump is added to the middle third.
(The figure above shows the first iteration.) The construction is a *fractal*.

The perimeter grows by a factor of $4/3$ at every step, so it _diverges_ — the
boundary has infinite length. The enclosed area, by contrast, _converges_: the
area added at step $n$ is $(a_0)/3 dot (4/9)^(n-1)$, a geometric sequence with
$abs(q) < 1$. Summing and adding the original triangle,
$ a_0 + (a_0 \/ 3)/(1 - 4/9) = a_0 + (3 a_0)/5 = (8 a_0)/5, $
so the snowflake's area is $8/5$ times that of the starting triangle, even
though its perimeter is infinite.
]

=== Exercises

#ex(difficulty: 2, hints: (
  [What is the ratio of *areas* between one square and the next? And the
   ratio of *lengths*? #heuristic("look for what stays the same")],
))[
The largest possible circle is inscribed in a square of side $a = 10$ cm; the
largest possible square is inscribed in that circle; and so on indefinitely.
Calculate
#parts(1,
  [(a) the sum of the perimeters of all the squares,],
  [(b) the sum of the areas of all the circles.],
)
][
Each square has half the area of the previous one (ratio $q = 1/2$ for areas,
$1/sqrt(2)$ for lengths).
#parts(1,
  [(a) $40 dot (2 + sqrt(2)) approx 136.57$ cm,],
  [(b) $50 pi approx 157.08$ cm². ],
)
]

#ex(difficulty: 2)[
A new square is formed by joining the midpoints of the sides of a square of
side $a = 8$ cm, and the process is repeated infinitely (see figure). The shaded
regions are the alternating triangular corners.
#nested-squares(side: 3cm, levels: 6)
#parts(1,
  [(a) Calculate the total shaded area.],
  [(b) Calculate the total perimeter of the shaded area.],
)
][
Each midpoint square has half the area of its parent.
#parts(1,
  [(a) Shaded area $= 16$ cm².],
  [(b) Perimeter $approx 27.3$ cm.],
)
]

#ex(
  level: "high",
  difficulty: 3,
  time: "25 min",
  hints: (
    [#heuristic("draw a picture") of two consecutive plumb lines and the
     right triangles they form: each plumb line is the previous one
     multiplied by the same factor. Which factor?],
  ),
)[
From a point $A$, a segment $A S$ of length $a$ is drawn at an acute angle
$alpha < 90 degree$ to a base line; from $S$ a perpendicular (plumb line) drops
to the line, from whose foot a new plumb line is raised to the segment, and so
on inward. Calculate the total length of all the plumb lines.
][
The plumb lines form a geometric sequence with ratio $cos alpha$, giving total
length
$ (a sin alpha)/(1 - cos alpha). $
]

#ex(
  level: "high",
  difficulty: 3,
  time: "25 min",
  hints: (
    [The total length is the easy half. For the center,
     #heuristic("introduce notation"): describe each edge as a displacement
     vector.],
    [Each edge vector is the previous one rotated by $90 degree$ and scaled
     by $3\/4$. Sum the $x$- and $y$-components separately — two geometric
     series.],
  ),
)[
A spiral $P_0 P_1 P_2 dots$ has $P_0 = (0, 0)$, $P_1 = (4, 0)$, $P_2 = (4, 3)$,
and each successive edge is shorter than the last by a constant factor (the edge
lengths form a geometric sequence).
#parts(1,
  [(a) What is the total length of the spiral?],
  [(b) What are the coordinates of its center point $C$?],
)
][
The first edge has length $4$, the second $3$, so $q = 3/4$ and the turns rotate
by $90 degree$ each time.
#parts(1,
  [(a) Total length $= 4 / (1 - 3/4) = 16$.],
  [(b) Summing the turning displacement vectors gives $C = (2.56, 1.92)$.],
)
]

#print-hints()
