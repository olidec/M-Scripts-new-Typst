// ============================================================
//  ch-arithmetic.typ — Arithmetic Sequences and Series
// ============================================================
#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Arithmetic Sequences and Series")

#let ex = exercise.with(chapter: "Arithmetic")

= Arithmetic Sequences and Series

== Arithmetic Sequences

#definition(title: "Arithmetic sequence")[
An *arithmetic sequence* (or *progression*) $(a_n)_(n in NN)$ is a sequence in
which the difference between consecutive terms is constant:
$ a_(n+1) - a_n = d quad "for all" n in NN. $
The number $d$ is the *common difference*, and the general term is
$ a_n = a_1 + (n - 1) dot d. $
]

#only-high[
The common difference $d$ plays the role of a slope: plotting $a_n$ against
$n$ gives points lying on a straight line of slope $d$. This is the simplest
non-trivial kind of sequence, and almost every later idea is a variation on it.
]

=== Exercises

#ex(difficulty: 1)[
Given the following information about an arithmetic sequence, find a general
expression for $a_n$ and list the first five terms.
#parts(1,
  [(a) $3, 11, dots$],
  [(b) $a_1 = 5, #h(0.3em) d = 4$],
  [(c) $a_2 = 4, #h(0.3em) d = -1/5$],
  [(d) $a_3 = -5, #h(0.3em) a_6 = 5$],
  [(e) $a_(20) = 11.11, #h(0.3em) d = -0.77$],
)
][
#parts(1,
  [(a) $a_n = 3 + (n - 1) dot 8$],
  [(b) $a_n = 5 + (n - 1) dot 4$],
  [(c) $a_n = 21/5 - (n - 1) dot 1/5$],
  [(d) $a_n = -35/3 + (n - 1) dot 10/3$],
  [(e) $a_n = 25.74 - (n - 1) dot 0.77$],
)
]

#ex(difficulty: 1)[
A job advertisement offers a starting salary of CHF~48'000 per year,
rising annually by CHF~500. What would the salary be in the 15th year?
How many years must a person hold this position to reach a 50% increase over
the starting salary? \
_Climb the ladder: story $->$ data $->$ pattern $->$ formula — then answer._
][
In the 15th year: CHF~55'500. The salary first exceeds the starting
salary by 50% (i.e. reaches CHF~72'000) in the 49th year, after
$n = 48$ raises.
]

#ex(
  level: "high",
  difficulty: 3,
  time: "30 min",
  hints: (
    [The three roots need not be *consecutive* terms. If all three belong to
     one progression, then each pairwise difference is an integer multiple
     of $d$ — #heuristic("introduce notation") for those multiples.],
    [Form the ratio of two of the differences: it must be *rational*. What
     goes wrong when you clear denominators and square?],
  ),
)[
Prove that no arithmetic progression can contain all three of $sqrt(2)$,
$sqrt(3)$ and $sqrt(5)$.
][
Suppose $sqrt(2), sqrt(3), sqrt(5)$ were terms of one arithmetic progression
with common difference $d$. Then $sqrt(3) - sqrt(2)$ and $sqrt(5) - sqrt(3)$
are both integer multiples of $d$, so their ratio
$(sqrt(3) - sqrt(2)) \/ (sqrt(5) - sqrt(3))$ is rational. Clearing the
denominators and squaring leads to a relation forcing $sqrt(6)$, $sqrt(10)$
and $sqrt(15)$ to be rationally dependent — impossible, since they are
linearly independent over $QQ$. Hence no such progression exists.
(See also #link("https://nrich.maths.org/261/solution")[nrich.maths.org/261].)
]

== The Arithmetic Series

#definition(title: "Arithmetic series")[
Let $(a_n)$ be an arithmetic sequence. The sequence of partial sums
$ s_n = sum_(k=1)^n a_k $
is the *arithmetic series* associated with $(a_n)$.
]

#theorem(title: "Sum of an arithmetic series")[
If $(a_k)$ is an arithmetic sequence, then its $n$-th partial sum is
$ s_n = a_1 + dots.c + a_n = sum_(k=1)^n a_k = n/2 dot (a_1 + a_n). $
]

#proof[
We use Gauss's trick: write the sum forwards and backwards, one below the
other, and add column by column.
$ s_n &= a_1 &&+ (a_1 + d) &&+ dots.c &&+ (a_1 + (n-1) dot d) \
  s_n &= (a_1 + (n-1) dot d) &&+ (a_1 + (n-2) dot d) &&+ dots.c &&+ a_1 $
Each of the $n$ columns sums to $2 a_1 + (n-1) dot d = a_1 + a_n$. Therefore
$2 s_n = n dot (a_1 + a_n)$, and dividing by $2$ gives the result.
(The move here: #heuristic("look for what stays the same") — every column
has the same sum.)
]

=== Exercises

#ex(difficulty: 2)[
Find the missing entries of these arithmetic sequences and series.
#data-table(
  columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  [], [(a)], [(b)], [(c)], [(d)], [(e)], [(f)],
  [$a_1$], [$1.2$], [$404$], [], [], [$1.8$], [$207$],
  [$a_n$], [], [$-9$], [$107$], [$0$], [], [],
  [$n$],   [$20$], [], [], [$61$], [], [$46$],
  [$d$],   [$2.1$], [$-7$], [$5.2$], [], [$0.05$], [],
  [$s_n$], [], [], [$123$], [$2196$], [$4059$], [],
)
][
#parts(3,
  [(a) $a_n = 41.1, #h(0.2em) s_n = 423$],
  [(b) $n = 60, #h(0.2em) s_n = 11850$],
  [(c) $a_1 = -101, #h(0.2em) n = 41$],
  [(d) $a_1 = 72, #h(0.2em) d = -1.2$],
  [(e) $a_n = 20.2, #h(0.2em) n = 369$],
  [(f) $a_n = -198, #h(0.2em) d = -9$],
)
]

#ex(difficulty: 2)[
Calculate the sum of all three-digit numbers that are divisible by seven.
][
$70'336$
]

#ex(difficulty: 2, hints: (
  [List the first few four-digit multiples of $17$: they alternate even,
   odd, even, odd. What is the common difference of the *odd* ones alone?],
))[
Calculate the sum of all odd four-digit numbers that are divisible by $17$.
][
$1'455'115$
]

#ex(
  difficulty: 3,
  time: "25 min",
  hints: (
    [What single term of the sequence is $s_(133) - s_(132)$?
     #heuristic("work backwards from the goal")],
    [For (b): a partial sum keeps growing exactly as long as the terms being
     added are positive. When does that stop?],
  ),
)[
An arithmetic sequence $(a_n)$ has $s_(132) = 330$ and $s_(133) = 133$, where
$(s_n)$ is the associated series.
#parts(1,
  [(a) Find an expression for $a_n$.],
  [(b) For which $n$ is $s_n$ largest? Why does a maximum exist at all?],
)
][
#parts(1,
  [(a) $a_1 = 199, #h(0.2em) d = -3$, so $a_n = 202 - 3n$.],
  [(b) The terms are positive up to $n = 67$ and negative afterward, so $s_n$ is largest at $n = 67$, with $s_(67) = 6'700$.],
)
]

#ex(difficulty: 2, hints: (
  [How many integers are used up before block 17 begins? That count is
   itself a sum you already know how to compute.],
))[
Let $s_1 = 1$, $s_2 = 2 + 3$, $s_3 = 4 + 5 + 6$, and so on (the $k$-th block has
$k$ consecutive integers). Calculate $s_(17)$.
][
The 17th block runs from $137$ to $153$, so $s_(17) = 17/2 dot (137 + 153) = 2465$.
]

#ex(level: "high", difficulty: 2)[
Prove the following identities for every arithmetic sequence $(a_n)$.
#parts(2,
  [(a) $a_1 - 2 a_2 + a_3 = 0$],
  [(b) $a_1 - 3 a_2 + 3 a_3 - a_4 = 0$],
)
][
Write $a_k = a_1 + (k - 1) dot d$ and substitute — #heuristic("introduce notation").
#parts(1,
  [(a) $a_1 - 2 dot (a_1 + d) + (a_1 + 2 d) = 0$.],
  [(b) $a_1 - 3 dot (a_1 + d) + 3 dot (a_1 + 2 d) - (a_1 + 3 d) = 0$. (These are the second and third *finite differences* of a linear sequence, which always vanish.)],
)
]

#ex(
  level: "high",
  difficulty: 3,
  time: "20 min",
  hints: (
    [Rationalize each denominator. Then #heuristic("look for what stays the same")
     in the differences that appear: set $b - a = c - b = t$.],
  ),
)[
Show that if $a$, $b$ and $c$ are consecutive terms of an arithmetic sequence,
then so are
$ 1/(sqrt(b) + sqrt(c)), quad 1/(sqrt(c) + sqrt(a)), quad 1/(sqrt(a) + sqrt(b)) $
(in this order).
][
Rationalize each term and use $b - a = c - b = t$ and $c - a = 2 t$:
$ 1/(sqrt(b) + sqrt(c)) = (sqrt(c) - sqrt(b))/t, quad
  1/(sqrt(a) + sqrt(b)) = (sqrt(b) - sqrt(a))/t, quad
  1/(sqrt(c) + sqrt(a)) = (sqrt(c) - sqrt(a))/(2 t). $
The sum of the outer terms is $(sqrt(c) - sqrt(a)) \/ t$, exactly twice the
middle term, so the three are in arithmetic progression.
]

#print-hints()
