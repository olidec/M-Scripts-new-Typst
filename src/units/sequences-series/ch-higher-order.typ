// ============================================================
//  ch-higher-order.typ — Higher-Order Arithmetic Sequences
//  (Advanced document only — registered solely in main-high.typ)
// ============================================================
#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Higher-Order Arithmetic Sequences")

#let ex = exercise.with(chapter: "Higher-Order")

= Higher-Order Arithmetic Sequences

== Introductory Example: Triangular Numbers

#only-theory[
Consider the *triangular numbers* $1, 3, 6, 10, 15, dots$, obtained by stacking
rows of dots:
]

#dot-triangle(rows: 4)

#only-theory[
This is _not_ an arithmetic sequence: the first differences are $2, 3, 4, 5,
dots$, which are not constant. The differences of those differences (the
*second differences*), however, are all equal to $1$. This observation
generalizes.
]

#theorem(title: "Order of an arithmetic sequence")[
Let $(a_n)$ be a sequence. If its $k$-th differences are constant (and no
lower-order differences are), we call $(a_n)$ an *arithmetic sequence of order
$k$*. Its general term is then a polynomial of degree $k$ in $n$:
$ a_n = c_k dot n^k + c_(k-1) dot n^(k-1) + dots.c + c_1 dot n + c_0. $
]

== Recovering the Formula

#only-theory[
The theorem turns "find the formula" into "solve a linear system." Since
$1, 3, 6, 10, dots$ has constant second differences, it is of order $2$, so
$ T_n = a dot n^2 + b dot n + c. $
Substituting the first three terms gives
$ cases(
  a + b + c = 1,
  4 a + 2 b + c = 3,
  9 a + 3 b + c = 6,
) $
with solution $a = 1/2$, $b = 1/2$, $c = 0$. Hence
$ T_n = 1/2 n^2 + 1/2 n = (n dot (n + 1))/2. $
]

#remark[
To find the order in practice, list the terms, take successive differences, and
count how many rows it takes to reach a constant row. A sequence of order $k$
needs $k + 1$ terms to pin down its $k + 1$ coefficients.
]

#exploration(title: "Sums of odd numbers")[
Compute $1$, then $1 + 3$, then $1 + 3 + 5$, then $1 + 3 + 5 + 7$, and keep
going. What do you notice? Now *draw* it: start with one dot, and wrap each
next odd number of dots around the previous figure as an L-shape. Formulate
a conjecture about $sum_(k=1)^n (2k - 1)$ — and hold on to it: we will prove
it by induction in the Proofs chapter.
]

== Exercises

#ex(difficulty: 2)[
Determine the order of each higher-order arithmetic sequence and find a general
expression for $a_n$.
#parts(2,
  [(a) $2, 5, 10, 17, 26, 37, 50, dots$],
  [(b) $-1, 6, 25, 62, 123, 214, 341, dots$],
)
][
#parts(2,
  [(a) Order $2$: $a_n = n^2 + 1$.],
  [(b) Order $3$: $a_n = n^3 - 2$.],
)
]

#ex(difficulty: 2, hints: (
  [Compute $s_1, s_2, s_3, s_4$ — #heuristic("try small cases").],
  [Determine the order of the sequence of sums from its rows of differences,
   then fit a polynomial of that degree.],
))[
Find a formula for the sum of the first $n$ square numbers,
$ s_n = 1^2 + 2^2 + dots.c + n^2 = sum_(k=1)^n k^2. $
][
The partial sums $1, 5, 14, 30, dots$ form a sequence of order $3$, giving
$ s_n = (n dot (n + 1) dot (2 n + 1))/6. $
]

#ex(difficulty: 2, hints: (
  [Same method as the previous exercise. Once you have the formula, compare
   it with the triangular numbers — do you recognize it?],
))[
Find a formula for the sum of the first $n$ cube numbers,
$ s_n = 1^3 + 2^3 + dots.c + n^3 = sum_(k=1)^n k^3. $
][
$ s_n = ((n dot (n + 1))/2)^2. $
(Remarkably, this is the square of the $n$-th triangular number.)
]

#ex(difficulty: 1)[
At a party with $n$ people, everyone clinks glasses with everyone else exactly
once. How many clinks are heard?
][
Each clink is a pair of people, so the count is the order-$2$ sequence
$ (n dot (n - 1))/2. $
]

#ex(difficulty: 2)[
Determine the number of diagonals in a convex $n$-gon.
][
From each of the $n$ vertices there are $n - 3$ diagonals; each is counted
twice, giving $ (n dot (n - 3))/2. $
]

#ex(difficulty: 2)[
Can you find a sequence that is _not_ an arithmetic sequence of any order?
Justify your answer.
][
For example $a_n = 2^n$. Taking differences of $2^n$ again gives a sequence of
the same exponential type ($2^(n+1) - 2^n = 2^n$), so no row of differences is
ever constant. A polynomial of finite degree can never reproduce exponential
growth, so $2^n$ has no finite order.
]

#ex(difficulty: 2)[
The *pentagonal numbers* $1, 5, 12, 22, 35, dots$ count the dots in nested
pentagons (each new pentagon shares two edges with the previous figure). Find a
general expression for the $n$-th pentagonal number.
][
The sequence has constant second differences (equal to $3$), so it is of order
$2$. Fitting $a dot n^2 + b dot n + c$ to $1, 5, 12$ gives
$ P_n = (n dot (3 n - 1))/2. $
]

#ex(difficulty: 3, time: "20 min")[
Let $p(n)$ be a polynomial of degree $r$. Show that $p(n + 1) - p(n)$ is a
polynomial of degree $r - 1$. Use this to explain why $a_n = p(n)$ is an
arithmetic sequence of order $r$.
][
Write $p(n) = c_r dot n^r + (text("lower order"))$. In $p(n + 1) - p(n)$ the
leading terms cancel: $c_r dot (n + 1)^r - c_r dot n^r = c_r dot r dot n^(r-1) + dots.c$, which
has degree $r - 1$. So taking one difference lowers the degree by exactly one.
Repeating $r$ times reaches a constant (degree $0$), and a further difference
gives $0$ — hence the $r$-th differences are constant and $(a_n)$ has order $r$.
]

#ex(
  difficulty: 3,
  time: "30 min",
  hints: (
    [#heuristic("draw a picture") — carefully. The apex of the $n$-th
     triangle must lie on $y = sqrt(x)$; express its height using the base
     endpoints $u_n$ and $u_(n+1)$.],
    [The base of triangle $n$ has length $u_(n+1) - u_n$, and an equilateral
     triangle of side $s$ has height $s sqrt(3)\/2$. Turn this into a
     relation between $u_n$ and $u_(n+1)$, then #heuristic("try small cases").],
  ),
)[
(Adapted from Problem 24, AMC 12B 2008.) The graph of $y = sqrt(x)$ carries a
sequence of points whose projections $u_1 = 0, u_2, u_3, dots$ on the $x$-axis
are chosen so that consecutive points, together with their feet on the axis,
form a chain of congruent equilateral triangles of growing size. Determine an
explicit formula for $u_n$.
][
Working through the geometry of the equilateral triangles leads to a
second-order sequence with
$ u_n = (n^2 - n)/3. $
]

#print-hints()
