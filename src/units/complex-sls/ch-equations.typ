#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Equations")
#let ex = exercise.with(chapter: "Equations")

= Equations over the Complex Numbers

#only-theory[
  In the introduction we made a promise. The quadratic formula, you
  were told, came with a rule -- "if the discriminant is negative,
  there is no solution" -- and that rule was never quite true. It was
  shorthand for "no solution *among the real numbers*", and the only
  thing standing in the way was the square root of a negative number.
  You can now take that square root.

  So nothing about the methods you know needs to change. The quadratic
  formula, factoring, Vieta's relations -- all of them keep working,
  and the case that used to be a dead end becomes the interesting one.
  This chapter collects the payoff.
]

#objectives(
  [solve quadratic equations with real coefficients over $CC$, including
    the case of a negative discriminant],
  [explain and use the fact that a real polynomial's non-real roots come
    in conjugate pairs],
  [reconstruct a real quadratic from one of its complex roots, using the
    sum and product of the roots],
  [solve equations involving $overline(z)$ by comparing real and
    imaginary parts],
  [factor a polynomial completely over $CC$ and state how many roots to
    expect],
)

#exploration(title: "How many solutions should there be?")[
  Before solving anything, *predict*. For each equation below, write
  down how many solutions you expect it to have in $CC$ -- and say what
  rule you are basing the guess on.

  #parts(
    2,
    [$x^2 + 1 = 0$],
    [$x^3 - 1 = 0$],
    [$x^4 - 1 = 0$],
    [$x^5 - 32 = 0$],
  )

  Then solve $x^2 + 1 = 0$ and $x^4 - 1 = 0$ by hand (both factor
  nicely) and check your count against your prediction. What does the
  Fundamental Theorem of Algebra, from the introduction, let you
  predict about all four *without solving them*?
]

== Quadratic Equations

#only-theory[
  The solutions of $a dot x^2 + b dot x + c = 0$ with $a eq.not 0$ are
  given by the formula you already know:
  $
    x_(1,2) = (-b plus.minus sqrt(b^2 - 4 a dot c)) / (2 a).
  $
  The expression under the root,
  $ Delta = b^2 - 4 a dot c, $
  is the #vocab("discriminant", "Diskriminante"). When $a, b, c$ are
  real and $Delta < 0$, there are no real solutions -- but the formula
  is unbothered, because $sqrt(Delta)$ is now a perfectly good complex
  number. Write $sqrt(Delta) = sqrt(|Delta|) dot i$ and finish as usual.
]

#example[
  Solve $x^2 - 2 x + 4 = 0$.

  The discriminant is $Delta = 4 - 16 = -12 < 0$, so there are no real
  solutions -- but there are two complex ones. With
  $sqrt(-12) = sqrt(12) dot i = 2 sqrt(3) dot i$:
  $
    x_(1,2) = (2 plus.minus 2 sqrt(3) dot i) / 2 = 1 plus.minus sqrt(3) dot i.
  $
  The solutions are $x_1 = 1 + sqrt(3) dot i$ and
  $x_2 = 1 - sqrt(3) dot i$.
]

#ex(difficulty: 2, time: "20 min")[
  Solve each equation, giving your answers in Cartesian form
  $a + b dot i$. By hand.
  #auto-parts(
    2,
    [$x^2 + 6 x + 10 = 0$],
    [$x^2 + x + 1 = 0$],
    [$3 x^2 + 6 x + 5 = 0$],
    [$2 dot (x + 4) dot (x - 1) = 3 dot (x - 7)$],
  )
][
  #auto-parts(
    2,
    [$x = -3 plus.minus i$],
    [$x = -1 / 2 plus.minus sqrt(3) / 2 dot i$],
    [$x = -1 plus.minus sqrt(6) / 3 dot i$],
    [Expand to $2 x^2 + 3 x + 13 = 0$, then
      $x = -3 / 4 plus.minus sqrt(95) / 4 dot i$.],
  )

  In (d) the equation does not start in standard form -- multiply out
  both sides and collect *before* reaching for the formula.
]

== Roots Come in Conjugate Pairs

#only-theory[
  Look back at every example so far: the two complex solutions were
  always conjugates of each other, $x_2 = overline(x_1)$. That is not a
  coincidence, and the reason is exactly the conjugate arithmetic you
  built in the previous chapter.
]

#theorem(title: "Conjugate roots")[
  Let $p$ be a polynomial with *real* coefficients. If $z_0 in CC$ is a
  #vocab("root", "Nullstelle") of $p$, then so is $overline(z_0)$. In
  words: the non-real roots of a real polynomial come in conjugate
  pairs.
]

#proof[
  Write $p(x) = a_n dot x^n + dots.c + a_1 dot x + a_0$ with every
  $a_k$ real. Suppose $p(z_0) = 0$. Conjugate the whole expression and
  push the bar inward, using
  $overline(z + w) = overline(z) + overline(w)$ and
  $overline(z dot w) = overline(z) dot overline(w)$ from the arithmetic
  chapter, together with $overline(a_k) = a_k$ (each coefficient is
  real):
  $
    overline(p(z_0))
    = overline(a_n dot z_0^n + dots.c + a_0)
    = a_n dot overline(z_0)^n + dots.c + a_0
    = p(overline(z_0)).
  $
  But $overline(p(z_0)) = overline(0) = 0$, so
  $p(overline(z_0)) = 0$: $overline(z_0)$ is a root too.
]

#warning[
  The theorem needs the coefficients to be *real*. Drop that and it
  fails: the equation $x^2 - 2 dot i dot x - 1 = 0$ is $(x - i)^2 = 0$, with
  the single repeated root $x = i$ -- and its conjugate $-i$ is *not* a
  root. Conjugate pairs are a gift from real coefficients, nothing less.
]

#ai-box(role: "Generator")[
  Ask an AI assistant to give you a *cubic* polynomial with real
  coefficients that has $2 + i$ as a root.

  + Before trusting it, check the two things the theorem forces: is
    $2 - i$ also a root of what it produced? And must a real cubic have
    at least one *real* root -- why? Verify the polynomial has one.
  + If the model handed you a cubic with non-real coefficients, or one
    where $2 - i$ is not a root, say precisely what it got wrong. A
    confident wrong answer is still wrong; your job is to catch it.
]

#ex(difficulty: 2, time: "10 min", hints: (
  [Non-real roots come in pairs, so they contribute an *even* number of
    roots. How many roots does a cubic have in total?],
))[
  Explain why every cubic polynomial with real coefficients has at
  least one real root. (You may use the Fundamental Theorem of Algebra
  and the conjugate-roots theorem.)
][
  A cubic has exactly three roots in $CC$, counted with multiplicity
  (Fundamental Theorem of Algebra). By the conjugate-roots theorem, its
  non-real roots come in conjugate pairs, so their number is *even* --
  $0$ or $2$. That leaves an *odd* number of real roots, either $3$ or
  $1$; either way at least one. More generally, every real polynomial
  of *odd* degree has at least one real root, by the same parity
  argument.
]

== Reconstructing a Quadratic from One Root

#only-theory[
  Conjugate pairs let us run the machinery *backwards*. If we know one
  non-real root of a real quadratic, the other root is free -- it is
  the conjugate -- and two roots determine the equation. The bridge is
  the relationship between the roots and the coefficients.

  For a monic quadratic (leading coefficient $1$) with roots
  $x_1, x_2$,
  $
    (x - x_1) dot (x - x_2) = x^2 - (x_1 + x_2) dot x + x_1 dot x_2.
  $
  So the sum of the roots is the negative of the $x$-coefficient, and
  the product is the constant term -- this is
  #vocab("Vieta's formulas", "Satz von Vieta"). The point of using a
  conjugate pair is that both the sum and the product come out *real*,
  so the reconstructed equation has real coefficients, as it must.
]

#example[
  One root of a real quadratic is $z_0 = 2 + i$. Find the equation.

  The other root is $overline(z_0) = 2 - i$. Their sum and product are
  $
    x_1 + x_2 = (2 + i) + (2 - i) = 4, quad
    x_1 dot x_2 = (2 + i) dot (2 - i) = 4 + 1 = 5.
  $
  Both real, as promised. The equation is $x^2 - 4 x + 5 = 0$.
]

#ex(difficulty: 2, time: "15 min")[
  One root of a real quadratic equation is given. Find the equation
  with integer coefficients.
  #auto-parts(
    2,
    [$3 - 2 dot i$],
    [$1 + 4 dot i$],
    [$-1 + sqrt(2) dot i$],
    [$5 dot i$],
  )
][
  In each case the other root is the conjugate; use
  $"sum" = -b / a$ and $"product" = c / a$.
  #auto-parts(
    2,
    [sum $= 6$, product $= 13$: $x^2 - 6 x + 13 = 0$],
    [sum $= 2$, product $= 17$: $x^2 - 2 x + 17 = 0$],
    [sum $= -2$, product $= 3$: $x^2 + 2 x + 3 = 0$],
    [sum $= 0$, product $= 25$: $x^2 + 25 = 0$],
  )
]

== One Complex Equation, Two Real Equations

#only-theory[
  Not every equation is a polynomial in $x$ with real coefficients.
  When an equation mixes $z$ with its conjugate $overline(z)$, or is
  otherwise not a plain polynomial, the quadratic formula has nothing
  to say -- but the technique from the introduction always does. Recall
  the key idea: *one complex equation is two real equations.* Write
  $z = a + b dot i$, compute both sides in Cartesian form, and match
  real part to real part and imaginary part to imaginary part.
]

#ex(difficulty: 3, time: "20 min", hints: (
  [Write $z = a + b dot i$, so $overline(z) = a - b dot i$. Compute
    $z^2$ and $i dot overline(z)$ separately, each in the form
    $(dots) + (dots) dot i$.],
  [Match real parts and imaginary parts. You should get
    $a^2 - b^2 = b$ and $2 a dot b = a$.],
  [Factor the second equation as $a dot (2 b - 1) = 0$. A product is
    zero when one factor is -- so split into the case $a = 0$ and the
    case $b = 1 / 2$, and solve each.],
))[
  Find all $z in CC$ with
  $ z^2 = i dot overline(z). $
][
  Let $z = a + b dot i$. Then
  $
    z^2 = a^2 - b^2 + 2 a dot b dot i, quad
    i dot overline(z) = i dot (a - b dot i) = b + a dot i.
  $
  Matching real and imaginary parts gives two real equations:
  $ a^2 - b^2 = b quad "and" quad 2 a dot b = a. $
  The second factors as $a dot (2 b - 1) = 0$, so $a = 0$ or
  $b = 1 / 2$.

  *Case $a = 0$.* The first equation becomes $-b^2 = b$, i.e.
  $b dot (b + 1) = 0$, so $b = 0$ or $b = -1$. This gives $z = 0$ and
  $z = -i$.

  *Case $b = 1 / 2$.* The first equation becomes
  $a^2 - 1 / 4 = 1 / 2$, so $a^2 = 3 / 4$ and
  $a = plus.minus sqrt(3) / 2$. This gives
  $z = sqrt(3) / 2 + 1 / 2 dot i$ and $z = -sqrt(3) / 2 + 1 / 2 dot i$.

  All four solutions:
  $ z in {0, -i, sqrt(3) / 2 + 1 / 2 dot i, -sqrt(3) / 2 + 1 / 2 dot i}. $
  Four solutions, and the equation is not a quadratic in $x$ -- the
  Fundamental Theorem of Algebra's "degree counts roots" does *not*
  apply to equations involving $overline(z)$, so counting here means
  actually finding them.
]

#ex(difficulty: 3, time: "20 min", calculator: true, hints: (
  [$z dot overline(z)$ is real and equals $a^2 + b^2$. Compute
    $z dot i$ separately.],
  [After matching parts, one of the two equations gives $a$ immediately;
    substitute it into the other to get a quadratic in $b$.],
))[
  A complex number $z$ satisfies
  $ z dot overline(z) + z dot i = 66 - 8 dot i. $
  Find all possible values of $z$. Check your answers with a CAS.
][
  Let $z = a + b dot i$. Then $z dot overline(z) = a^2 + b^2$ and
  $z dot i = (a + b dot i) dot i = -b + a dot i$, so the equation reads
  $
    (a^2 + b^2 - b) + a dot i = 66 - 8 dot i.
  $
  Matching parts: the imaginary part gives $a = -8$ at once, and the
  real part gives $a^2 + b^2 - b = 66$. Substituting $a = -8$:
  $
    64 + b^2 - b = 66 quad ==> quad b^2 - b - 2 = 0
    quad ==> quad (b - 2) dot (b + 1) = 0,
  $
  so $b = 2$ or $b = -1$. The two solutions are $z = -8 + 2 dot i$ and
  $z = -8 - i$.
]

== Factoring Completely over $CC$

#only-theory[
  The Fundamental Theorem of Algebra, stated in the introduction,
  guarantees that a non-constant polynomial has a root in $CC$. Divide
  that root out and repeat, and you reach a complete factorization --
  the algebraic reason $CC$ is where the search for roots ends.
]

#theorem(title: [Factorization over $CC$])[
  Every polynomial of degree $n$ with complex coefficients factors into
  linear factors,
  $
    p(x) = a dot (x - z_1) dot (x - z_2) dots.c (x - z_n),
  $
  where $a$ is the leading coefficient and $z_1, dots, z_n in CC$ are
  the roots. Counted with #vocab("multiplicity", "Vielfachheit") --
  a repeated factor counted as often as it appears -- a degree-$n$
  polynomial has *exactly* $n$ roots in $CC$.
]

#example[
  Factor $x^4 - 1$ completely over $CC$.

  Twice a difference of squares:
  $
    x^4 - 1 = (x^2 - 1) dot (x^2 + 1) = (x - 1) dot (x + 1) dot (x - i) dot (x + i).
  $
  The four roots are $1, -1, i, -i$ -- and $i, -i$ form a conjugate
  pair, as the coefficients are real.
]

#ex(difficulty: 2, time: "20 min")[
  Factor each polynomial completely over $CC$.
  #auto-parts(
    2,
    [$x^2 + 9$],
    [$x^4 + 4 x^2 + 3$],
    [$x^3 - 8$],
    [$x^4 - 16$],
  )
][
  #auto-parts(
    1,
    [$x^2 + 9 = (x - 3 dot i) dot (x + 3 dot i)$.],
    [Substitute $u = x^2$: $u^2 + 4 u + 3 = (u + 1) dot (u + 3)$, so
      $
        x^4 + 4 x^2 + 3 = (x - i) dot (x + i) dot (x - sqrt(3) dot i) dot (x + sqrt(3) dot i).
      $],
    [Known real root $x = 2$: $x^3 - 8 = (x - 2) dot (x^2 + 2 x + 4)$, and
      the quadratic factor has roots $-1 plus.minus sqrt(3) dot i$, so
      $
        x^3 - 8 = (x - 2) dot (x + 1 - sqrt(3) dot i) dot (x + 1 + sqrt(3) dot i).
      $],
    [$x^4 - 16 = (x - 2) dot (x + 2) dot (x - 2 dot i) dot (x + 2 dot i)$.],
  )
]

#look-ahead(
  title: "Why the roots line up so neatly",
  preview: [roots of unity, in polar form],
)[
  Look at where the four roots of $x^4 - 16$ sit: $2, -2, 2 dot i, -2 dot i$.
  Plotted as points they are the corners of a square, evenly spaced
  around a circle of radius $2$. The roots of $x^4 - 1$ do the same on
  the unit circle. That evenness is not luck, and it is very hard to
  see from the algebra -- but once we can write a complex number by its
  distance and angle, the equation $x^n = r$ will hand back $n$ roots
  spaced exactly $360 degree \/ n$ apart, every time. Solving
  high-degree "pure" equations like these is one of the things polar
  form does effortlessly.
]

== Techniques You Know So Far

#only-theory[
  This chapter added several distinct methods for solving equations in
  $CC$. Before the exercises mix them together, here is the running
  list -- when a problem does not immediately yield, run down it and
  ask which one fits.
]

#known-techniques(
  [*The quadratic formula* -- now valid over $CC$, because
    $sqrt(Delta)$ makes sense even when $Delta < 0$.],
  [*Comparing real and imaginary parts* -- turn one complex equation
    into two real ones. The tool of choice whenever $overline(z)$
    appears.],
  [*Factoring completely* -- difference of squares, the substitution
    $u = x^2$, or dividing out a known root to leave a quadratic.],
  [*Conjugate pairs and Vieta* -- from one non-real root of a real
    polynomial, recover the equation through the sum and product of the
    roots.],
)

#ex(difficulty: 3, time: "20 min", hints: (
  [The polynomial is real, and $1 - 2 dot i$ is a root. What is the second
    root, for free?],
  [You now know two of the three roots. The third must be real (odd
    degree) -- and you are told it. Build
    $(x - r_1) dot (x - r_2) dot (x - r_3)$ and expand.],
))[
  A cubic $x^3 + p dot x^2 + q dot x + r$ has *real* coefficients. Two
  of its roots are $1 - 2 dot i$ and $3$. Find $p$, $q$ and $r$.
][
  Since the coefficients are real and $1 - 2 dot i$ is a root, its conjugate
  $1 + 2 dot i$ is also a root. With the
  given real root $3$, all three roots are known, so
  $
    x^3 + p dot x^2 + q dot x + r = (x - 3) dot (x - (1 - 2 dot i)) dot (x - (1 + 2 dot i)).
  $
  The conjugate pair multiplies to a real quadratic:
  $
    (x - (1 - 2 dot i)) dot (x - (1 + 2 dot i)) = x^2 - 2 x + (1 + 4) = x^2 - 2 x + 5.
  $
  Then
  $
    (x - 3) dot (x^2 - 2 x + 5) = x^3 - 5 x^2 + 11 x - 15,
  $
  so $p = -5$, $q = 11$ and $r = -15$. (Check: the coefficients are
  real, as they had to be -- the imaginary parts canceled the moment
  the conjugate pair was multiplied out.)
]

#print-hints()
#print-vocab()
