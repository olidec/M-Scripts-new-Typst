// ============================================================
//  ch-proofs.typ — Mathematical Proofs and Induction
//  (Advanced document only — registered solely in main-high.typ)
// ============================================================
#import "preamble.typ": *
#show: chapter-template.with(title: "Mathematical Proofs and Induction")

#let ex = exercise.with(chapter: "Proofs")

= Mathematical Proofs and Induction

== Axioms, Conjectures and Proofs

#only-theory[
Mathematics is built by proving conjectures. We begin with a few _unprovable_
starting statements, called *axioms*, and from them establish ever more complex
*theorems*. A *conjecture* is a statement we believe is true but have not (yet)
proved.
]

#keybox(title: "The Axiom of Archimedes")[
For any two positive real numbers $x$ and $y$ there is a natural number $n$ with
$ n dot x > y. $
This seems obvious, yet it cannot be derived from anything simpler — so we
accept it as an axiom and build on it.
]

#definition(title: "Proof")[
A *proof* is a logical sequence of steps that establishes the truth of a
statement. Many proof techniques exist; an overview is collected at
#link("https://en.wikipedia.org/wiki/Mathematical_proof")[en.wikipedia.org/wiki/Mathematical_proof].
]

#remark[
A proof traditionally ends with _q.e.d._ (Latin _quod erat demonstrandum_,
"what was to be shown"), or with a small square $square$.
]

== Some Examples of Proof Techniques

#example(title: "Direct proof")[
*Claim.* The sum of two odd integers is even. \
Let $a = 2 n + 1$ and $b = 2 m + 1$ with $n, m in ZZ$. Then
$ a + b = 2 n + 2 m + 2 = 2 dot (n + m + 1), $
a multiple of $2$. $square$
]

#example(title: "Proof by contradiction")[
*Claim.* There are infinitely many primes. \
Suppose instead there were finitely many, $p_1, dots, p_n$. The number
$N = p_1 dot p_2 dot dots.c dot p_n + 1$ leaves remainder $1$ when divided by each $p_i$, so
it has a prime factor outside the list — contradicting that the list was
complete. $square$
]

#example(title: "Pigeonhole principle")[
*Claim.* In any group of $13$ people, two share a birth month. \
There are only $12$ months ("pigeonholes") but $13$ people ("pigeons"), so some
month must hold at least two people. $square$
]

#example(title: "Invariant argument")[
*Claim.* A chessboard with two opposite corners removed cannot be tiled by
dominoes. \
Each domino covers one black and one white square. The two removed corners share
a color, leaving $32$ of one color and $30$ of the other — an imbalance no set of
dominoes can cover. The color balance is the _invariant_. $square$ \
(The move behind every invariant argument:
#heuristic("look for what stays the same").)
]

== Mathematical Induction

#only-theory[
To prove a statement $P(n)$ for every natural number $n$, it suffices to topple
an infinite row of dominoes: knock over the first, and guarantee each one knocks
over the next.
]

#domino-row(n: 8)

#keybox(title: "Principle of induction")[
To prove $P(n)$ for all $n >= n_0$:
+ *Base case:* show $P(n_0)$ holds.
+ *Inductive step:* assume $P(k)$ (the _induction hypothesis_) and use it to
  show $P(k + 1)$.
Then $P(n)$ holds for all $n >= n_0$.
]

#example(title: "A first induction")[
*Claim.* $sum_(k=1)^n k = (n dot (n + 1))/2$ for all $n >= 1$. \
*Base:* for $n = 1$ both sides equal $1$. \
*Step:* assume $sum_(k=1)^n k = (n dot (n+1))/2$. Then
$ sum_(k=1)^(n+1) k = (n dot (n + 1))/2 + (n + 1) = ((n + 1) dot (n + 2))/2, $
which is the formula with $n + 1$ in place of $n$. $square$
]

== Exercises

#ex(difficulty: 1)[
A school has $400$ students. Explain why at least two of them must share a
birthday.
][
There are at most $366$ possible birthdays but $400$ students; by the
pigeonhole principle some birthday is shared. (In fact at least
$400 - 366 = 34$ extra collisions are forced.)
]

#ex(difficulty: 1)[
Prove that the product of two odd integers is odd.
][
With $a = 2 n + 1$, $b = 2 m + 1$, $a dot b = 2 dot (2 n dot m + n + m) + 1$, which is odd.
]

#ex(difficulty: 1)[
Prove that the sum of any three consecutive even integers is divisible by $6$.
][
Write them as $2 k, 2 k + 2, 2 k + 4$. Their sum is $6 k + 6 = 6 dot (k + 1)$.
]

#ex(difficulty: 2)[
Prove that $sqrt(5)$ is irrational.
][
Suppose $sqrt(5) = p\/q$ in lowest terms. Then $p^2 = 5 q^2$, so $5 | p$; writing
$p = 5 r$ gives $5 r^2 = q^2$, so $5 | q$ too — contradicting "lowest terms."
]

#ex(difficulty: 2)[
Let $d, a, b$ be integers. Show that if $d | (a + b)$ and $d | a$, then $d | b$.
][
$d | (a + b)$ and $d | a$ mean $a + b = d dot s$ and $a = d dot t$. Subtracting,
$b = d dot (s - t)$, so $d | b$.
]

#ex(difficulty: 2)[
Can a $6 times 6$ board be tiled by L-shaped trominoes (three squares each)?
What about the $10 times 10$ board with straight $4 times 1$ tetrominoes?
][
The $6 times 6$ board has $36 = 12 dot 3$ squares and _can_ be tiled by L-trominoes
(tile it in $2 times 3$ blocks). The $10 times 10$ board has $100$ squares but
$100$ is not divisible by $4$, so it _cannot_ be covered by $4 times 1$ tiles.
]

#ex(difficulty: 2, hints: (
  [#heuristic("look for what stays the same") — color the seats like a
   checkerboard and watch what a single move does to the color.],
))[
Twenty-five students sit in a $5 times 5$ grid. Can every student move to an
orthogonally adjacent seat simultaneously (each moving up, down, left or right
by one)?
][
Color the grid like a checkerboard: $13$ squares of one color, $12$ of the
other. Every move switches color, so the $13$ students on the majority color
would need $13$ destination seats of the minority color — but only $12$ exist.
Impossible. (Invariant: the color count.)
]

#ex(difficulty: 2)[
Prove by induction, for all $n >= 1$:
#parts(2,
  [(a) $sum_(k=1)^n (2 k - 1) = n^2$],
  [(b) $sum_(k=1)^n k^2 = (n dot (n + 1) dot (2 n + 1))/6$],
  [(c) $sum_(k=1)^n k^3 = ((n dot (n + 1))/2)^2$],
  [(d) $sum_(k=1)^n 1/(k dot (k + 1)) = n/(n + 1)$],
)
][
Each follows the same pattern: verify $n = 1$, then add the $(n+1)$-th term to
the assumed formula and simplify. For (d), the new term $1/((n+1) dot (n+2))$ added to
$n/(n+1)$ gives $(n+1)/(n+2)$. (Parts (a)–(c) are the conjectures from the
explorations and exercises of the previous chapters — now they are theorems.)
]

#ex(difficulty: 2, hints: (
  [In the inductive step, split the expression for $n + 1$ into (something
   the hypothesis makes divisible) $+$ (a visibly divisible remainder) —
   #heuristic("work backwards from the goal").],
))[
Prove by induction, for all $n >= 1$:
#parts(1,
  [(a) $3 | (n^3 - n)$],
  [(b) $6 | (n^3 + 5 n)$],
  [(c) $9 | (4^n + 6 n - 1)$],
)
][
In each, the base case is direct; for the step, expand the $(n+1)$-th expression,
split off the assumed-divisible part, and check the remainder is divisible. E.g.
(c): $4^(n+1) + 6 dot (n+1) - 1 = 4 dot (4^n + 6 n - 1) - 18 n + 9$, and both $4 dot 9 m$
and $-18 n + 9 = 9 dot (1 - 2 n)$ are multiples of $9$.
]

#ex(
  difficulty: 3,
  time: "20 min",
  hints: (
    [Which starting value $a$ would make the sequence *constant*?
     #heuristic("check an extreme or special case")],
    [Track the deviation $b_n = a_n + 1$ instead of $a_n$ itself: what
     happens to $b_n$ at each step of the recursion?],
  ),
)[
A sequence is defined recursively by $a_1 = 1$ and $a_(n+1) = (2 a_n - 1)/3$.
Find a closed-form expression for $a_n$ and prove it by induction.
][
Solving the fixed point $a = (2 a - 1)/3$ gives $a = -1$; tracking the deviation
$a_n + 1$ (which is multiplied by $2/3$ each step) yields
$ a_n = -1 + 2 dot (2/3)^(n-1). $
Check: $a_1 = -1 + 2 = 1$. ✓ Inductive step: if $a_n = -1 + 2 dot (2/3)^(n-1)$ then
$a_(n+1) = (2 a_n - 1)/3 = -1 + 2 dot (2/3)^n$. ✓
]

#ai-box(role: "Generator")[
Ask an AI to "prove by induction that $3^n > n^3$ for all $n >= 2$." The
statement is *false* for $n = 2$ and $n = 3$ — does the AI notice, or does
it produce a confident proof anyway? Grade its answer: check the base case
yourself, then scrutinize every step of its inductive argument. Then do the
exercise below, where the claim actually holds.
]

#ex(difficulty: 2)[
Prove that $3^n > n^3$ for all integers $n >= 4$.
][
Base $n = 4$: $81 > 64$. ✓ Step: assume $3^n > n^3$. Then
$3^(n+1) = 3 dot 3^n > 3 n^3$, and for $n >= 4$ one checks $3 n^3 >= (n + 1)^3$
(equivalently $3 >= (1 + 1\/n)^3$, true since $(1 + 1\/n)^3 <= (5\/4)^3 < 2$).
]

#ex(difficulty: 2)[
Prove that $n^2 > 7 n + 1$ for all integers $n >= 8$.
][
Base $n = 8$: $64 > 57$. ✓ Step: assume $n^2 > 7 n + 1$. Then
$(n + 1)^2 = n^2 + 2 n + 1 > 7 n + 1 + 2 n + 1 = 7 dot (n + 1) + (2 n - 5) > 7 dot (n + 1) + 1$
for $n >= 8$.
]

#ex(difficulty: 2)[
Each of the following "proofs" reaches a false conclusion. Find the flaw.
(Fluent, confident, *wrong* arguments are exactly what a careless AI — or a
careless human — produces; grading them is a transferable skill.)
#parts(1,
  [(a) A derivation that concludes $0 = 1$ by dividing an equation through by
   $(a - b)$ after assuming $a = b$.],
  [(b) A derivation that concludes $2 = 1$ from $a = b$ by a similar hidden
   division.],
  [(c) An induction "proving" that all horses in any group have the same color.],
)
][
#parts(1,
  [(a) and (b) both divide by $a - b = 0$, which is undefined.],
  [(c) The inductive step fails for the base size $n = 1 -> 2$: two groups of one
   horse need not overlap, so the colors are never linked. The chain of equalities
   breaks at the very first step.],
)
]

#ex(
  difficulty: 3,
  time: "30 min",
  hints: (
    [Ordinary induction is not enough here: the recursion reaches back *two*
     steps, so you need the statement for both $n$ and $n + 1$ to get
     $n + 2$. Start by checking $n = 1$ and $n = 2$ by hand —
     #heuristic("try small cases").],
    [Use that $phi$ and $psi$ are the two roots of $x^2 = x + 1$, so
     $x^(n+2) = x^(n+1) + x^n$ holds for each of them.],
  ),
)[
(For specialists.) The Fibonacci numbers satisfy $F_1 = F_2 = 1$ and
$F_(n+2) = F_(n+1) + F_n$. Prove Binet's formula by induction:
$ F_n = 1/sqrt(5) dot (phi^n - psi^n), quad phi = (1 + sqrt(5))/2, #h(0.4em) psi = (1 - sqrt(5))/2. $
][
Use _strong_ induction. Base: check $n = 1, 2$. Step: assume the formula for
$n$ and $n + 1$. Since $phi$ and $psi$ are the two roots of $x^2 = x + 1$, we
have $phi^(n+2) = phi^(n+1) + phi^n$ and likewise for $psi$. Adding the two
hypotheses then gives the formula for $F_(n+2)$.
]

#print-hints()
