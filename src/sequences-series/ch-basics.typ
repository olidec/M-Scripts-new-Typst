// ============================================================
//  ch-basics.typ — Basics of Sequences and Series
// ============================================================
#import "preamble.typ": *
#show: chapter-template.with(title: "Basics of Sequences and Series")

#let ex = exercise.with(chapter: "Basics")

= Basics of Sequences and Series

== Number Patterns

#only-theory[
Patterns are everywhere, and mathematics is in large part the study of
patterns and the structures that lie underneath them. Many patterns occur
in nature — the spirals of a nautilus shell, the branching of a fern, the
self-similar florets of a Romanesco broccoli. Others live purely in the
world of numbers: the prime numbers $2, 3, 5, 7, dots$ underpin modern
cryptography, while still other sequences are valued for their geometric or
purely aesthetic appeal.

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 1em,
  align: center,
  image("figures/Fractal_Broccoli.jpg"),
  image("figures/nautilus.jpg"),
  image("figures/wave.png"),
)

In this chapter we make the idea of a "number pattern" precise. We introduce
*sequences* and the *series* built from them, and we learn two complementary
ways of describing a sequence: *explicitly* and *recursively*.
]

== Sequences

#definition(title: "Sequence")[
An ordered list of numbers is called a *sequence*, and each number in the
list is called a *term*.

Formally, a sequence is a function whose inputs are the natural numbers: the
input $n$ is fed in and the term $a_n$ comes out. The terms could in principle
be almost anything, but for us they will always be real numbers.
]

#only-theory[
*Notation.* We write a sequence using a name and an index,
$ (a_n)_(n in NN), $
where $a$ is the "name" of the sequence and the index $n$ records the
position of the term $a_n$. When the context is clear the brackets are often
dropped and we simply speak of "the sequence $a_n$".

Some sequences to keep in mind:
- $1, 2, 3, 4, dots$ — the counting numbers,
- $2, 3, 5, 7, dots$ — the prime numbers,
- $2, 7, 12, 17, dots$ — start at $2$ and keep adding $5$,
- $1, 1/2, 1/3, 1/4, dots$ — the reciprocals of the natural numbers.
]

#example(title: "Evaluating a sequence")[
Given the sequence $a_n = 3n + 7$, find $a_1$, $a_7$ and $a_(2018)$.
]
#only-theory[
We substitute the position of the term into the formula:
$ a_1 = 3 dot 1 + 7 = 10, quad a_7 = 3 dot 7 + 7 = 28, quad
  a_(2018) = 3 dot 2018 + 7 = 6061. $
]

== Series

#definition(title: "Series")[
The sequence of *partial sums* of a given sequence is called the associated
*series*. A series is usually denoted by $s_n$.
]

#only-theory[
The series associated with $a_n$ is written compactly with the *sigma*
notation,
$ s_n = sum_(k=1)^n a_k, $
where the symbol $sum$ (the Greek capital "S") denotes the sum of the terms
$a_k$ as the index $k$ runs from $1$ up to $n$.
]

#example[
$ sum_(k=1)^4 k^2 = 1^2 + 2^2 + 3^2 + 4^2 = 30. $
]

#example[
$ 3 + 5 + 7 + 9 = sum_(k=2)^5 (2k - 1). $
]

== Explicit and Recursive Definitions

#only-theory[
Many sequences can be described by a formula. An *explicit* formula lets us
compute any term directly from its position $n$. A *recursive*
(self-referencing) formula instead gives a starting value together with a rule
for getting from one term to the *next* — think of a line of dominoes, where
each one knocks over the one after it.
]

#only-theory[
*Examples.*
- The sequence $2, 7, 12, 17, dots$ has the explicit formula
  $ a_n = 5n - 3 quad "for" n in NN, $
  or the recursive description
  $ cases(a_1 = 2, a_(n+1) = a_n + 5). $
- The reciprocals are given explicitly by $a_n = 1/n$; there is no recursive
  formula for this sequence.
- The sequence $1, 2, 5, 10, 17, dots$ is easier to describe recursively:
  we add $1$, then $3$, then $5$, and so on — at each step we add the next odd
  number,
  $ cases(a_1 = 1, a_(n+1) = a_n + (2n - 1)). $
  It is less obvious, but there is also a tidy explicit formula,
  $ a_n = n^2 - 2n + 2. $
]

#only-theory[
Where do such formulas come from? Turning a situation into a formula is a
climb through *levels of abstraction*. This ladder will reappear in every
chapter — when you are stuck, first locate which rung you are standing on
and which rung the question is asking for.
]

#abstraction-ladder(
  l0: [A climbing gym opens with 2 founding members. Every week, 5 new
       members join.],
  l1: [Membership count, week by week: #h(0.4em) 2, 7, 12, 17, 22, ...],
  l2: [Each week's count is last week's plus 5:
       #h(0.4em) $cases(a_1 = 2, a_(n+1) = a_n + 5)$ #h(0.4em) (recursive).],
  l3: [$a_n = 5n - 3$ — week number in, member count out, no history
       needed (explicit).],
)

#only-high[
== When Is a Continuation "Correct"?

The word *sensible* below is in quotation marks for a reason: from a strictly
mathematical point of view there is *no* continuation that a sequence is
forced to take. This is the classic pitfall of so-called IQ tests — in
truth, *any* number could come next.

Take the sequence $1, 2, 3, 4, dots$. The obvious continuation is
$1, 2, 3, 4, 5, 6, dots$ with formula $a_n = n$. But suppose we *insist* that
the fifth term be $17$. We look for a polynomial $p$ with $a_n = p(n)$. Five
conditions
$ p(1) = 1, quad p(2) = 2, quad p(3) = 3, quad p(4) = 4, quad p(5) = 17 $
determine a polynomial of degree four,
$ p(n) = 1/2 n^4 - 5 n^3 + 35/2 n^2 - 24 n + 12, $
which continues the sequence as
$ 1, 2, 3, 4, 17, 66, 187, 428, dots $
— every bit as "valid" as the first continuation.

The lesson: mathematicians identify a sequence by its *definition*, not by the
first few terms. There is even an *On-Line Encyclopedia of Integer Sequences*
(#link("https://oeis.org/")[oeis.org]); searching for $1, 2, 3, 4$ returns
thousands of distinct, mathematically meaningful sequences that begin that way.

#ai-box(role: "Generator")[
  Ask an AI chatbot: "What is the next term of $1, 2, 3, 4$?" When it
  answers, reply: "No — the next term is $17$. Justify this continuation."
  Compare its justification with the polynomial above. What does this
  exchange tell you about (i) pattern-continuation questions in general,
  and (ii) how confidently an AI will defend whatever it is told?
]
]

#only-theory[
One more tool before the exercises. Nobody — teachers included — sees the
solution to a genuinely new problem instantly; what experienced
problem-solvers have is not magic but a repertoire of moves and the patience
to try several. From now on, whenever a solution uses one of these moves, we
name it with a badge like #heuristic("try small cases").
]

#toolbox()

== Exercises

#ex(difficulty: 2, hints: (
  [Parts (g) and (h) are famous sequences that follow no polynomial rule.
   For (g), #heuristic("look for what stays the same") between three
   consecutive terms; for (h), try reading each term *aloud*.],
))[
Find a "sensible" continuation of each sequence. Where possible, give both an
explicit and a recursive definition.
#parts(2,
  [(a) $1, 2, 3, 4, dots$],
  [(b) $1, 4, 9, 16, dots$],
  [(c) $2, 4, 8, 16, dots$],
  [(d) $-7, -3, 1, 5, dots$],
  [(e) $2, 6, 12, 20, dots$],
  [(f) $(-3)/5, 11/13, (-19)/21, 27/29, dots$],
  [(g) $1, 1, 2, 3, 5, 8, dots$],
  [(h) $1, 11, 21, 1211, 111221, dots$],
)
][
#parts(2,
  [(a) $a_n = n$; #h(0.3em) $cases(a_1 = 1, a_(n+1) = a_n + 1)$],
  [(b) $a_n = n^2$; #h(0.3em) $cases(a_1 = 1, a_(n+1) = a_n + 2n + 1)$],
  [(c) $a_n = 2^n$; #h(0.3em) $cases(a_1 = 2, a_(n+1) = 2 a_n)$],
  [(d) $a_n = 4n - 11$; #h(0.3em) $cases(a_1 = -7, a_(n+1) = a_n + 4)$],
  [(e) $a_n = n^2 + n$; #h(0.3em) $cases(a_1 = 2, a_(n+1) = a_n + 2 dot (n+1))$],
  [(f) $a_n = (-1)^n dot (8n - 5)/(8n - 3)$; no recursion],
  [(g) Fibonacci: $cases(a_1 = 1\, a_2 = 1, a_(n+2) = a_(n+1) + a_n)$],
  [(h) the "look-and-say" sequence (each term reads the previous one aloud); next term $13112221$. No elementary closed form.],
)
]

#ex(difficulty: 1)[
(Without a calculator.) Find formulas describing each sequence.
#parts(2,
  [(a) $4, 8, 12, dots$],
  [(b) $16, 21, 26, dots$],
  [(c) $2, 0, 2, 0, dots$],
  [(d) $3, -7, 11, -15, 19, dots$],
  [(e) $1, 19/21, 18/22, 17/23, dots$],
  [(f) $(-1)/8, (-4)/27, (-9)/64, (-16)/125, dots$],
)
][
#parts(2,
  [(a) $a_n = 4n$],
  [(b) $a_n = 11 + 5n$],
  [(c) $a_n = 1 + (-1)^(n+1)$],
  [(d) $a_n = (-1)^(n+1) dot (4n - 1)$],
  [(e) $a_n = (21 - n)/(19 + n)$],
  [(f) $a_n = (-n^2)/(n+1)^3$],
)
]

#ex(difficulty: 2, hints: (
  [Answer the first question first: just compute, and only then hunt for a
   formula — #heuristic("try small cases"). For (b) and (d), compare each
   term with the nearest power of $2$.],
))[
Calculate the first five terms of each sequence. Can you find a general
formula for $a_n$?
#parts(2,
  [(a) $a_1 = 1, #h(0.3em) a_(n+1) = 3 a_n$],
  [(b) $a_1 = 1, #h(0.3em) a_(n+1) = 2 a_n + 3$],
  [(c) $a_1 = 0, #h(0.3em) a_(n+1) = a_n + 2/((n+2) dot (n+3))$],
  [(d) $a_1 = 1, #h(0.3em) a_(n+1) = 2 a_n - 3$],
  [(e) $a_1 = 0, #h(0.3em) a_(n+1) = 3 a_n + 3^n$],
  [(f) $a_1 = 1, #h(0.3em) a_2 = 1, #h(0.3em) a_(n+2) = a_(n+1) + a_n$],
)
][
#parts(2,
  [(a) $1, 3, 9, 27, 81$; #h(0.3em) $a_n = 3^(n-1)$],
  [(b) $1, 5, 13, 29, 61$; #h(0.3em) $a_n = 2^(n+1) - 3$],
  [(c) $0, 1/6, 4/15, 1/3, 8/21$; #h(0.3em) $a_n = (2 dot (n-1))/(3 dot (n+2))$],
  [(d) $1, -1, -5, -13, -29$; #h(0.3em) $a_n = 3 - 2^n$],
  [(e) $0, 3, 18, 81, 324$; #h(0.3em) $a_n = (n-1) dot 3^(n-1)$],
  [(f) $1, 1, 2, 3, 5$; #h(0.3em) Fibonacci],
)
]

#ex(difficulty: 1)[
Calculate the following sums.
#parts(3,
  [(a) $sum_(k=1)^4 (4k - 7)$],
  [(b) $sum_(k=8)^11 (k^2 - 100)$],
  [(c) $sum_(k=2)^6 (2^k - 1)$],
)
][
#parts(3, [(a) $12$], [(b) $-34$], [(c) $119$])
]

#ex(difficulty: 2)[
Write each series using sigma notation.
#parts(1,
  [(a) $-1 + 3 + 7 + 11 + dots$],
  [(b) $-1 + 1 - 1 + 1 - 1 + 1 - 1 + 1 - 1 + 1$],
  [(c) $6 - 12 + 24 - 48 + 96 - 192$],
)
][
#parts(1,
  [(a) $sum_(n=1)^oo (4n - 5)$],
  [(b) $sum_(n=1)^10 (-1)^n$],
  [(c) $sum_(n=1)^6 6 dot (-2)^(n-1)$],
)
]

#print-hints()
