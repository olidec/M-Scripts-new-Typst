// ch-eq-quadratic.typ — Quadratic and Reducible Equations (equations booklet)
//
// COMPLETE (Turn 3). Six stages: checkpoint, theory, exercises
// (ramped, with error analysis), calculator block, stage check.
//
// TARGET MISCONCEPTIONS (see stage notes)
//   Product Equals Zero: M2 (x−2)(x−3)=6 ⇒ x−2=6; M1 dividing by x loses x=0
//   Quadratic Equations: M3 x²=9 ⇒ only 3
//   Substitution: forgetting to substitute back
//   Rational Equations: M6 forgetting the domain; extraneous roots
//   Radical Equations: M8 √(x²)=x; extraneous roots
//   Equations with a Parameter: case distinction
// STATUS
//   done:  skeleton, checkpoints, stage checks (answers verified
//          numerically; SymPy could not be installed in the drafting
//          sandbox, so a numeric root scan + substitution was used)
//   to do: theory, worked examples, exercises, warnings, error-analysis
//          tasks, "Check with your calculator" blocks, challenges.
//
// NEEDS A VISUAL CHECK — not compiled (no Typst in the drafting
// environment): route boxes, goto-first links, yr() cells in checks.

#import "../../common/preamble.typ": *
#import "config.typ": *
#show: chapter-template.with(title: "Quadratic and Reducible Equations")
#let ex = exercise.with(chapter: "Equations")
#let check = check.with(ex: ex)

= Quadratic and Reducible Equations

#only-theory[
  These six sections have one thing in common: each turns a harder
  equation into a form you can solve with one idea. The idea behind
  almost all of them is a product that equals zero. You will learn why
  it works, then use it for quadratics, for equations that only _look_
  harder (substitution, fractions, roots), and for equations with a
  parameter. In every section, checking your answer is part of the
  method, not an extra.
]

#objectives(
  [Solve products, quadratics, and equations reducible to them],
  [Handle fractions and roots, and reject extraneous solutions],
  [Solve equations with a parameter and use the discriminant],
)

// ════════════════════════════════════════════════════════
== Product Equals Zero <st-product>

#check(
  "Product Equals Zero",
  (
    [Solve $x dot (x - 3) = 0$.],
    [Solve $(2x + 1) dot (x - 4) = 0$.],
    [Solve $x^2 - 5x = 0$.],
    [Solve $(x - 2) dot (x - 3) = 2$.],
  ),
  (
    [$x = 0$ or $x = 3$],
    [$x = -1/2$ or $x = 4$],
    [$x = 0$ or $x = 5$],
    [$x = 1$ or $x = 4$],
  ),
  pass: [Skip to the checkpoint in #goto-first(<st-quad>).],
  fail: [Work through this section.],
)

#only-theory[
  Multiply two numbers and get $0$. What do you know about the
  numbers? At least one of them must be $0$. This is the single most
  useful fact about solving equations, because it turns one hard
  equation into two easy ones.
]

#keybox(title: "Zero-product property")[
  A #vocab("product", "Produkt") of #vocab("factors", "Faktoren") is
  zero exactly when at least one factor is zero:
  $ A dot B = 0 quad arrow.l.r.double quad A = 0 " or " B = 0. $
  This works *only if the right side is $0$*. The property says
  nothing about a product that equals $6$ or any other number.
]

#example(title: "Factors given")[
  Solve $(2x + 1) dot (x - 4) = 0$. Either $2x + 1 = 0$, which gives
  $x = -1/2$, or $x - 4 = 0$, which gives $x = 4$. So
  $L = \{-1/2, 4\}$.
]

#example(title: "Take out a common factor")[
  Solve $x^2 - 5x = 0$. Both terms contain $x$, so
  $x dot (x - 5) = 0$. Hence $x = 0$ or $x = 5$.
  The same idea works for higher powers:
  $ x^3 - 4x = x dot (x^2 - 4) = x dot (x - 2) dot (x + 2) = 0, $
  so $L = \{-2, 0, 2\}$.
]

#example(title: "The right side is not zero")[
  Solve $(x - 2) dot (x - 3) = 6$. First multiply out and move
  everything to one side, so that the right side is $0$:
  $ x^2 - 5x + 6 = 6 quad arrow.r.double quad x^2 - 5x = 0
    quad arrow.r.double quad x dot (x - 5) = 0. $
  So $L = \{0, 5\}$. Check $x = 5$: $(5 - 2) dot (5 - 3) = 3 dot 2 = 6$.
]

#warning[
  *A product equal to $6$ does not mean that a factor equals $6$.*
  From $(x - 2) dot (x - 3) = 6$ you may _not_ conclude $x - 2 = 6$ or
  $x - 3 = 6$. Test it: $x = 8$ gives $6 dot 5 = 30$, not $6$. Many
  pairs of numbers have the product $6$ ($1 dot 6$, $2 dot 3$, and so
  on), so the factors can be anything. Always move to $0 = ...$ first.
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Solve.
  #auto-parts(
    3,
    [$x dot (x + 4) = 0$],
    [$(x - 1) dot (x + 7) = 0$],
    [$(3x - 6) dot (x + 2) = 0$],
    [$x^2 - 7x = 0$],
    [$5x^2 = 15x$],
    [$(2x - 1) dot (3x + 2) = 0$],
  )
][
  #auto-parts(
    3,
    [$x = -4$ or $x = 0$],
    [$x = -7$ or $x = 1$],
    [$x = 2$ or $x = -2$],
    [$x dot (x - 7) = 0$, so $x = 0$ or $x = 7$],
    [$5x dot (x - 3) = 0$, so $x = 0$ or $x = 3$],
    [$x = 1/2$ or $x = -2/3$],
  )
]

#ex(
  difficulty: 2,
  time: "10 min",
  calculator: false,
  hints: ([Multiply out, then move everything to the left side.],),
)[
  The right side is not $0$. Rewrite first, then solve and check.
  #auto-parts(
    2,
    [$(x + 2) dot (x + 3) = 12$],
    [$(x - 4) dot (x + 1) = -6$],
    [$x dot (x - 5) = -4$],
    [$(2x - 1) dot (x + 3) = -3$],
  )
][
  #auto-parts(
    2,
    [$x^2 + 5x - 6 = 0$, so $(x + 6) dot (x - 1) = 0$ and
      $x = -6$ or $x = 1$],
    [$x^2 - 3x + 2 = 0$, so $(x - 1) dot (x - 2) = 0$ and
      $x = 1$ or $x = 2$],
    [$x^2 - 5x + 4 = 0$, so $(x - 1) dot (x - 4) = 0$ and
      $x = 1$ or $x = 4$],
    [$2x^2 + 5x = 0$, so $x dot (2x + 5) = 0$ and
      $x = 0$ or $x = -5/2$],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Three students solved $(x - 2) dot (x - 3) = 6$ or a similar
  equation. For each one, decide whether the work is correct. If it is
  wrong, name the mistake and give the correct solution set.
  #auto-parts(
    1,
    [Pia: $(x - 2) dot (x - 3) = 6 #h(0.5em) arrow.r.double #h(0.5em)
      x - 2 = 6 " or " x - 3 = 6 #h(0.5em) arrow.r.double #h(0.5em)
      x = 8 " or " x = 9$],
    [Omar: $(x - 2) dot (x - 3) = 6 #h(0.5em) arrow.r.double #h(0.5em)
      x^2 - 5x + 6 = 6 #h(0.5em) arrow.r.double #h(0.5em)
      x dot (x - 5) = 0 #h(0.5em) arrow.r.double #h(0.5em)
      x = 0 " or " x = 5$],
    [Nina: $x dot (x + 1) = 0 #h(0.5em) arrow.r.double #h(0.5em)
      x = 0 " or " x = 1$],
  )
][
  #auto-parts(
    1,
    [Wrong. Pia used the zero-product property for a product equal to
      $6$. Test $x = 8$: $6 dot 5 = 30 != 6$. Correct: $L = \{0, 5\}$.],
    [Correct.],
    [Wrong. $x + 1 = 0$ gives $x = -1$, not $x = 1$. Correct:
      $L = \{-1, 0\}$.],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Factor completely, then solve.
  #auto-parts(
    2,
    [$x^3 - 4x = 0$],
    [$x^3 - 9x^2 = 0$],
    [$x^4 - x^2 = 0$],
    [$x^3 + 2x^2 - 3x = 0$],
  )
][
  #auto-parts(
    2,
    [$x dot (x - 2) dot (x + 2) = 0$, so $x = -2$, $x = 0$, or $x = 2$],
    [$x^2 dot (x - 9) = 0$, so $x = 0$ or $x = 9$],
    [$x^2 dot (x - 1) dot (x + 1) = 0$, so $x = -1$, $x = 0$, or
      $x = 1$],
    [$x dot (x^2 + 2x - 3) = x dot (x + 3) dot (x - 1) = 0$, so
      $x = -3$, $x = 0$, or $x = 1$],
  )
]

#ex(difficulty: 3, time: "10 min", calculator: false)[
  Build equations backwards.
  #auto-parts(
    1,
    [Write an equation of the form "product $= 0$" whose solutions are
      exactly $-2$ and $5$. Then multiply it out.],
    [Write an equation of the form "product $= 0$" whose solutions are
      exactly $0$, $1$, and $4$.],
    [How many different solutions can "product of three linear factors
      $= 0$" have? Give an example for each possibility.],
  )
][
  #auto-parts(
    1,
    [$(x + 2) dot (x - 5) = 0$, which is $x^2 - 3x - 10 = 0$.],
    [$x dot (x - 1) dot (x - 4) = 0$.],
    [One, two, or three. For example $(x - 1)^3 = 0$ has $1$ solution,
      $(x - 1)^2 dot (x - 2) = 0$ has $2$, and
      $(x - 1) dot (x - 2) dot (x - 3) = 0$ has $3$.],
  )
]

#keybox(title: "Check with your calculator")[
  #only-basic[
    *TI-30X Pro MathPrint.* *poly-solv* solves equations of degree $2$
    and $3$. You must first bring the equation to the form
    $a x^2 + b x + c = 0$ (or $a x^3 + b x^2 + c x + d = 0$) and enter
    the coefficients, including zeros. So $x^3 - 4x = 0$ has the
    coefficients $1, 0, -4, 0$. Rewriting the equation correctly is
    still your job. // VERIFY on device: menu path and input order
  ]
  #only-high[
    *TI-Nspire CAS.* `solve((x-2)·(x-3)=6,x)` handles the right side
    for you. `factor(x^3-4·x)` shows the product form, and
    `zeros(x^3-4·x,x)` lists the solutions of "expression $= 0$".
    Compare the result with your factored form.
    // VERIFY on device: factor and zeros syntax
  ]
]

#ex(level: "basic", difficulty: 1, time: "8 min", calculator: true)[
  Use *poly-solv*.
  #auto-parts(
    1,
    [Solve $x^2 - 7x = 0$. Which coefficients do you enter?],
    [Solve $x^3 - 4x = 0$. Which coefficients do you enter?],
    [Solve $(x - 2) dot (x - 3) = 6$. First rewrite it in the form
      $a x^2 + b x + c = 0$.],
  )
][
  #auto-parts(
    1,
    [Coefficients $1, -7, 0$. Solutions $x = 0$ and $x = 7$.],
    [Coefficients $1, 0, -4, 0$. Solutions $x = -2$, $x = 0$, $x = 2$.],
    [$x^2 - 5x + 0 = 0$, coefficients $1, -5, 0$. Solutions $x = 0$ and
      $x = 5$.],
  )
]

#ex(level: "high", difficulty: 1, time: "8 min", calculator: true)[
  Use your TI-Nspire CAS.
  #auto-parts(
    1,
    [Use `factor` on $x^3 - 4x$. Then solve $x^3 - 4x = 0$ by hand and
      compare.],
    [Solve $(x + 2) dot (x + 3) = 12$ with `solve`.],
    [Use `zeros` on $x^3 + 2x^2 - 3x$.],
  )
][
  #auto-parts(
    1,
    [`factor` returns $x dot (x - 2) dot (x + 2)$, so
      $x = -2$, $0$, or $2$.],
    [$x = -6$ or $x = 1$.],
    [$x = -3$, $x = 0$, $x = 1$.],
  )
]

#check(
  kind: "Stage check",
  "Product Equals Zero",
  (
    [Solve $(x + 5) dot (3x - 2) = 0$.],
    [Solve $x^3 - 4x = 0$.],
    [Solve $4x^2 = 12x$.],
    [Solve $(x - 1) dot (x + 4) = 6$.],
  ),
  (
    [$x = -5$ or $x = 2/3$],
    [$x = -2$, $x = 0$, or $x = 2$],
    [$x = 0$ or $x = 3$],
    [$x = -5$ or $x = 2$],
  ),
  pass: [Continue with #goto-first(<st-quad>).],
  fail: [Find the example or exercise that matches your mistake and redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════
== Quadratic Equations <st-quad>

#check(
  "Quadratic Equations",
  (
    [Solve $x^2 - 49 = 0$.],
    [Solve $x^2 - 6x + 8 = 0$.],
    [Solve $2x^2 + 3x - 2 = 0$.],
    [Solve $x^2 + 2x + 5 = 0$.],
  ),
  (
    [$x = -7$ or $x = 7$],
    [$x = 2$ or $x = 4$],
    [$x = -2$ or $x = 1/2$],
    [No real solution],
  ),
  pass: [Skip to the checkpoint in #goto-first(<st-subst>).],
  fail: [Work through this section.],
)

#only-theory[
  A #vocab("quadratic equation", "quadratische Gleichung") can be
  written in the standard form $a x^2 + b x + c = 0$ with $a != 0$.
  There are four methods. Look at the equation and pick the fastest one.
]

#keybox(title: "Four methods for quadratic equations")[
  + *No $x$-term* ($a x^2 + c = 0$): solve for $x^2$, then take the
    square root, with *both* signs.
  + *No constant* ($a x^2 + b x = 0$): take out the factor $x$, then
    use the zero-product property.
  + *Factoring* ($x^2 + b x + c = 0$): find two numbers with product
    $c$ and sum $b$. Then $x^2 + b x + c = (x - x_1) dot (x - x_2)$.
  + *Quadratic formula* (always works):
    $ x = (-b plus.minus sqrt(b^2 - 4 a c))/(2 a). $
    The #vocab("discriminant", "Diskriminante") $D = b^2 - 4 a c$
    tells you the number of real solutions: $D > 0$ gives two,
    $D = 0$ gives one (a #vocab("double solution", "doppelte Lösung")),
    and $D < 0$ gives none.
]

#warning[
  *Bring the equation to the form $a x^2 + b x + c = 0$ first.* You can
  only read $a$, $b$, and $c$ when the right side is $0$. For
  $2x^2 = 3x + 5$ the coefficients are $a = 2$, $b = -3$, $c = -5$,
  not $3$ and $5$.
]

#example(title: "Factoring")[
  Solve $x^2 - 6x + 8 = 0$. We need two numbers with product $8$ and
  sum $-6$. They are $-2$ and $-4$. So $(x - 2) dot (x - 4) = 0$ and
  $L = \{2, 4\}$.
]

#example(title: "Quadratic formula")[
  Solve $2x^2 + 3x - 2 = 0$. Here $a = 2$, $b = 3$, $c = -2$, so
  $D = 9 + 16 = 25$ and
  $ x = (-3 plus.minus 5)/4, quad "so" quad x = 1/2 " or " x = -2. $
]

#example(title: "Discriminant negative")[
  Solve $x^2 + 2x + 5 = 0$. We get $D = 4 - 20 = -16 < 0$. The square
  root of a negative number is not real, so there is *no real
  solution*: $L = \{ \}$. The graph of $y = x^2 + 2x + 5$ lies entirely
  above the $x$-axis.
]

#warning[
  *$x^2 = 9$ has two solutions.* Both $3^2 = 9$ and $(-3)^2 = 9$. Write
  $x = 3$ or $x = -3$. Forgetting the negative solution is one of the
  most common mistakes in this chapter.
]

#only-high[
  #keybox(title: "Vieta's formulas")[
    If $x^2 + p x + q = 0$ has the solutions $x_1$ and $x_2$, then
    $ x_1 + x_2 = -p quad "and" quad x_1 dot x_2 = q. $
    For $a x^2 + b x + c = 0$: $x_1 + x_2 = -b/a$ and
    $x_1 dot x_2 = c/a$. This lets you find a second solution when one is
    known, find the equation from its solutions, and check your answers
    quickly.
  ]

  #example(title: "Using Vieta")[
    The equation $x^2 - 7x + k = 0$ has the solution $x_1 = 3$. Then
    $x_1 + x_2 = 7$ gives $x_2 = 4$, and $k = x_1 dot x_2 = 12$.
  ]
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Solve. Give exact answers.
  #auto-parts(
    3,
    [$x^2 = 16$],
    [$3x^2 = 75$],
    [$x^2 - 5 = 0$],
    [$2x^2 + 8 = 0$],
    [$x^2 + 6x = 0$],
    [$(x - 2)^2 = 9$],
  )
][
  #auto-parts(
    3,
    [$x = 4$ or $x = -4$],
    [$x^2 = 25$, so $x = 5$ or $x = -5$],
    [$x = sqrt(5)$ or $x = -sqrt(5)$],
    [$x^2 = -4$: no real solution],
    [$x dot (x + 6) = 0$, so $x = 0$ or $x = -6$],
    [$x - 2 = 3$ or $x - 2 = -3$, so $x = 5$ or $x = -1$],
  )
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Solve by factoring.
  #auto-parts(
    3,
    [$x^2 - 7x + 12 = 0$],
    [$x^2 + x - 12 = 0$],
    [$x^2 - 2x - 15 = 0$],
    [$x^2 + 8x + 15 = 0$],
    [$x^2 - 10x + 25 = 0$],
    [$x^2 - x - 42 = 0$],
  )
][
  #auto-parts(
    3,
    [$(x - 3) dot (x - 4) = 0$: $x = 3$ or $x = 4$],
    [$(x + 4) dot (x - 3) = 0$: $x = -4$ or $x = 3$],
    [$(x + 3) dot (x - 5) = 0$: $x = -3$ or $x = 5$],
    [$(x + 3) dot (x + 5) = 0$: $x = -3$ or $x = -5$],
    [$(x - 5)^2 = 0$: $x = 5$ (double solution)],
    [$(x + 6) dot (x - 7) = 0$: $x = -6$ or $x = 7$],
  )
]

#ex(
  difficulty: 2,
  time: "12 min",
  calculator: false,
  hints: ([Rewrite as $a x^2 + b x + c = 0$ before you read $a$, $b$, $c$.],),
)[
  Solve with the quadratic formula.
  #auto-parts(
    2,
    [$2x^2 - 5x - 3 = 0$],
    [$3x^2 + 4x - 4 = 0$],
    [$x^2 - 2x - 1 = 0$],
    [$4x^2 - 12x + 9 = 0$],
    [$x^2 + x + 1 = 0$],
    [$2x^2 = 3x + 5$],
  )
][
  #auto-parts(
    2,
    [$D = 49$: $x = 3$ or $x = -1/2$],
    [$D = 64$: $x = 2/3$ or $x = -2$],
    [$D = 8$: $x = 1 + sqrt(2)$ or $x = 1 - sqrt(2)$],
    [$D = 0$: $x = 3/2$ (double solution)],
    [$D = -3 < 0$: no real solution],
    [$2x^2 - 3x - 5 = 0$, $D = 49$: $x = 5/2$ or $x = -1$],
  )
]

#ex(difficulty: 2, time: "6 min", calculator: false)[
  How many real solutions does each equation have? Use the
  discriminant. Do not solve.
  #auto-parts(
    2,
    [$x^2 - 6x + 9 = 0$],
    [$2x^2 + x + 3 = 0$],
    [$x^2 - 3x - 1 = 0$],
    [$-x^2 + 4x - 5 = 0$],
  )
][
  #auto-parts(
    2,
    [$D = 0$: one solution],
    [$D = 1 - 24 = -23$: none],
    [$D = 9 + 4 = 13$: two solutions],
    [$D = 16 - 20 = -4$: none],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Three students solved an equation. For each one, decide whether the
  work is correct. If it is wrong, name the mistake and give the correct
  solution set.
  #auto-parts(
    1,
    [Pia: $x^2 = 9 #h(0.5em) arrow.r.double #h(0.5em) x = 3$],
    [Omar: $x^2 - 4x = 5 #h(0.5em) arrow.r.double #h(0.5em)
      x dot (x - 4) = 5 #h(0.5em) arrow.r.double #h(0.5em)
      x = 5 " or " x - 4 = 5 #h(0.5em) arrow.r.double #h(0.5em)
      x = 5 " or " x = 9$],
    [Nina: $2x^2 - 8 = 0 #h(0.5em) arrow.r.double #h(0.5em) x^2 = 4
      #h(0.5em) arrow.r.double #h(0.5em) x = 2 " or " x = -2$],
  )
][
  #auto-parts(
    1,
    [Wrong. Pia forgot the negative solution. Correct: $x = 3$ or
      $x = -3$.],
    [Wrong. Omar used the zero-product property for a product equal to
      $5$. Correct: $x^2 - 4x - 5 = 0$, so
      $(x - 5) dot (x + 1) = 0$ and $L = \{-1, 5\}$.],
    [Correct.],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Set up an equation and solve it. Check that your answer makes sense.
  #auto-parts(
    1,
    [A rectangle is $3$ cm longer than it is wide. Its area is
      $40 " cm"^2$. Find its sides.],
    [Two consecutive positive integers have the product $156$. Find
      them.],
  )
][
  #auto-parts(
    1,
    [Width $w$: $w dot (w + 3) = 40$, so $w^2 + 3w - 40 = 0$ and
      $(w + 8) dot (w - 5) = 0$. A width cannot be negative, so
      $w = 5$ cm and the length is $8$ cm. Check: $5 dot 8 = 40$.],
    [$n dot (n + 1) = 156$, so $n^2 + n - 156 = 0$ and
      $(n + 13) dot (n - 12) = 0$. Since $n > 0$: $n = 12$. The numbers
      are $12$ and $13$.],
  )
]

#ex(difficulty: 3, time: "10 min", calculator: false)[
  The product of two consecutive odd integers is $143$. Find them. How
  many answers are there?
][
  The integers are $n$ and $n + 2$: $n dot (n + 2) = 143$, so
  $n^2 + 2n - 143 = 0$ and $(n + 13) dot (n - 11) = 0$. Then $n = 11$
  or $n = -13$. There are *two* answers: $11$ and $13$, or $-13$ and
  $-11$. Check: $11 dot 13 = 143$ and $(-13) dot (-11) = 143$.
]

#ex(level: "high", difficulty: 2, time: "10 min", calculator: false)[
  Use Vieta's formulas. Do not use the quadratic formula.
  #auto-parts(
    1,
    [The equation $x^2 - 7x + k = 0$ has the solution $x_1 = 3$. Find
      $x_2$ and $k$.],
    [Find $b$ and $c$ so that $x^2 + b x + c = 0$ has the solutions $-2$
      and $5$.],
    [Guess the solutions of $x^2 - 5x + 6 = 0$ from sum and product.],
    [Without solving, find the sum and the product of the solutions of
      $2x^2 - 5x + 1 = 0$.],
  )
][
  #auto-parts(
    1,
    [$x_2 = 7 - 3 = 4$ and $k = 3 dot 4 = 12$.],
    [$b = -(-2 + 5) = -3$ and $c = (-2) dot 5 = -10$.],
    [Sum $5$ and product $6$: $x = 2$ and $x = 3$.],
    [Sum $5/2$ and product $1/2$. (Here $D = 17 > 0$, so the two
      solutions really exist.)],
  )
]

#keybox(title: "Check with your calculator")[
  #only-basic[
    *TI-30X Pro MathPrint.* Use *poly-solv* (degree $2$) and enter
    $a$, $b$, $c$. Always compare with your hand solution. If the
    discriminant is negative, the calculator reports no real solution,
    or it may show complex numbers, which are not solutions in this
    course. // VERIFY on device: output when D is negative
  ]
  #only-high[
    *TI-Nspire CAS.* `solve(a·x^2+b·x+c=0,x)` returns the quadratic
    formula, and `solve(2·x^2-5·x-3=0,x)` returns exact solutions.
    For $D < 0$, `solve` returns `false` and `cSolve` gives the
    complex solutions. Use `nSolve` (needs a start value) for a decimal
    approximation. // VERIFY on device: output form of solve with general a, b, c
  ]
]

#ex(level: "basic", difficulty: 1, time: "8 min", calculator: true)[
  Use *poly-solv*. Round to $2$ decimals where needed.
  #auto-parts(
    1,
    [$2x^2 - 5x - 3 = 0$],
    [$x^2 - 2x - 1 = 0$],
    [$x^2 + x + 1 = 0$. What does the calculator show, and what is the
      correct answer in the real numbers?],
  )
][
  #auto-parts(
    1,
    [$x = 3$ and $x = -0.5$],
    [$x approx 2.41$ and $x approx -0.41$ (exactly $1 plus.minus sqrt(2)$)],
    [The discriminant is $-3$, so there is no real solution. If the
      calculator shows complex numbers, they are not solutions in the
      real numbers.],  // VERIFY on device
  )
]

#ex(level: "high", difficulty: 1, time: "8 min", calculator: true)[
  Use your TI-Nspire CAS.
  #auto-parts(
    1,
    [Solve $x^2 - 2x - 1 = 0$ with `solve`. Give the exact answer and a
      decimal approximation.],
    [Solve $x^2 + x + 1 = 0$ with `solve` and with `cSolve`. What does
      each say?],
    [Solve $a x^2 + b x + c = 0$ for $x$. What do you recognize?],
  )
][
  #auto-parts(
    1,
    [$x = 1 + sqrt(2) approx 2.41$ or $x = 1 - sqrt(2) approx -0.41$.],
    [`solve` says `false` (no real solution). `cSolve` gives
      $x = -1/2 + (sqrt(3))/2 i$ or $x = -1/2 - (sqrt(3))/2 i$.],
    [The quadratic formula, with $plus.minus$ written as two solutions.],
  )
]

#check(
  kind: "Stage check",
  "Quadratic Equations",
  (
    [Solve $(x + 3)^2 = 16$.],
    [Solve $x^2 - 3x - 10 = 0$.],
    [Solve $3x^2 - 5x - 2 = 0$.],
    yr([Solve $x^2 - 4x + 4 = 0$. How many solutions does it have?], [The equation $x^2 + p dot x + 18 = 0$ has the solution $x_1 = 3$. Use Vieta's formulas to find $x_2$ and $p$.]),
  ),
  (
    [$x = -7$ or $x = 1$],
    [$x = -2$ or $x = 5$],
    [$x = -1/3$ or $x = 2$],
    yr([$x = 2$ (one solution, a double root)], [$x_2 = 6$ and $p = -9$]),
  ),
  pass: [Continue with #goto-first(<st-subst>).],
  fail: [Find the example or exercise that matches your mistake and redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════
== Substitution <st-subst>

#check(
  "Substitution",
  (
    [Solve $x^4 - 5x^2 + 4 = 0$.],
    [Solve $x^4 + x^2 + 1 = 0$.],
    [Solve $x - 5 sqrt(x) + 6 = 0$.],
    [Solve $(x + 1)^2 - 3 dot (x + 1) - 10 = 0$.],
  ),
  (
    [$x = -2$, $x = -1$, $x = 1$, or $x = 2$],
    [No real solution],
    [$x = 4$ or $x = 9$],
    [$x = -3$ or $x = 4$],
  ),
  pass: [Skip to the checkpoint in #goto-first(<st-rational>).],
  fail: [Work through this section.],
)

#only-theory[
  Some equations look harder than a quadratic, but hide one. Look for
  the same expression appearing twice, once as itself and once squared.
  Replace that expression by a new letter, solve the quadratic, and then
  go back.
]

#keybox(title: "Substitution")[
  + *Spot* an expression $u$ that appears in two powers, such as $x^2$
    and $x^4$, or $sqrt(x)$ and $x$.
  + *Substitute* a new letter for it and solve the resulting quadratic
    in $u$.
  + *Substitute back* for _every_ solution $u$ and solve for $x$.
  + *Check the range:* if $u = x^2$ or $u = sqrt(x)$, a negative $u$
    gives no real $x$.
]

#example(title: "A biquadratic equation")[
  Solve $x^4 - 5x^2 + 4 = 0$. Let $u = x^2$. Then
  $u^2 - 5u + 4 = 0$, so $u = 1$ or $u = 4$. Now go back:
  $x^2 = 1$ gives $x = plus.minus 1$, and $x^2 = 4$ gives
  $x = plus.minus 2$. So $L = \{-2, -1, 1, 2\}$.
]

#example(title: "A root as the new variable")[
  Solve $x - 5 sqrt(x) + 6 = 0$. Let $u = sqrt(x)$, so $x = u^2$ and
  $u^2 - 5u + 6 = 0$. Then $u = 2$ or $u = 3$, so $x = 4$ or $x = 9$.
  Check $x = 9$: $9 - 5 dot 3 + 6 = 0$.
]

#example(title: "A bracket as the new variable")[
  Solve $(x + 1)^2 - 3 dot (x + 1) - 10 = 0$. Let $u = x + 1$:
  $u^2 - 3u - 10 = 0$, so $u = 5$ or $u = -2$. Then $x = 4$ or $x = -3$.
]

#warning[
  *The solutions for $u$ are not yet solutions for $x$.* In
  $x^4 - 5x^2 + 4 = 0$, the answers $u = 1$ and $u = 4$ are _not_ the
  answers $x = 1$ and $x = 4$. And when $u = x^2$ is negative, as in
  $u = -3$, there is no real $x$ at all: $x^2 = -3$ has no solution.
]

#ex(difficulty: 1, time: "10 min", calculator: false)[
  Solve using $u = x^2$ (or $u = x^3$ in part (d)).
  #auto-parts(
    2,
    [$x^4 - 10x^2 + 9 = 0$],
    [$x^4 - 20x^2 + 64 = 0$],
    [$x^4 - 5x^2 - 36 = 0$],
    [$x^6 - 9x^3 + 8 = 0$],
  )
][
  #auto-parts(
    2,
    [$u = 1$ or $u = 9$: $x = plus.minus 1$ or $x = plus.minus 3$],
    [$u = 4$ or $u = 16$: $x = plus.minus 2$ or $x = plus.minus 4$],
    [$u = 9$ or $u = -4$. Only $u = 9$ works: $x = plus.minus 3$],
    [$u = x^3 = 1$ or $8$: $x = 1$ or $x = 2$],
  )
]

#ex(
  difficulty: 2,
  time: "12 min",
  calculator: false,
  hints: ([Let $u = sqrt(x)$, so $x = u^2$. Remember $u >= 0$.],),
)[
  Choose a substitution and solve. Check your answers.
  #auto-parts(
    2,
    [$x - 3 sqrt(x) - 10 = 0$],
    [$x - 4 sqrt(x) + 3 = 0$],
    [$2x - 5 sqrt(x) - 3 = 0$],
    [$(x - 2)^2 - 5 dot (x - 2) + 6 = 0$],
  )
][
  #auto-parts(
    2,
    [$u = 5$ or $u = -2$. Only $u = 5$ works ($sqrt(x) >= 0$): $x = 25$],
    [$u = 1$ or $u = 3$: $x = 1$ or $x = 9$],
    [$u = 3$ or $u = -1/2$. Only $u = 3$ works: $x = 9$],
    [$u = 2$ or $u = 3$: $x = 4$ or $x = 5$],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Three students solved an equation. For each one, decide whether the
  work is correct. If it is wrong, name the mistake and give the correct
  solution set.
  #auto-parts(
    1,
    [Pia: $x^4 - 5x^2 + 4 = 0$, $u = x^2$: $u^2 - 5u + 4 = 0$, so
      $u = 1$ or $u = 4$. Answer: $x = 1$ or $x = 4$.],
    [Omar: $x^4 - 5x^2 + 4 = 0$, $u = x^2$: $u = 1$ or $u = 4$. Answer:
      $x = plus.minus 1$ or $x = plus.minus 2$.],
    [Nina: $x^4 - x^2 - 6 = 0$, $u = x^2$: $u = 3$ or $u = -2$.
      Answer: $x = plus.minus sqrt(3)$ (and $u = -2$ gives nothing).],
  )
][
  #auto-parts(
    1,
    [Wrong. Pia forgot to substitute back. Correct:
      $L = \{-2, -1, 1, 2\}$.],
    [Correct.],
    [Correct. $x^2 = -2$ has no real solution.],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  How many real solutions does the equation have? Decide before you
  solve it completely.
  #auto-parts(
    3,
    [$x^4 + x^2 - 6 = 0$],
    [$x^4 - 6x^2 + 5 = 0$],
    [$x^4 + 2x^2 + 5 = 0$],
  )
][
  #auto-parts(
    3,
    [$u = 2$ or $u = -3$: only $u = 2$ works, so $2$ solutions
      ($x = plus.minus sqrt(2)$)],
    [$u = 1$ or $u = 5$: both positive, so $4$ solutions],
    [$D = 4 - 20 < 0$: no real $u$, so $0$ solutions],
  )
]

#ex(difficulty: 3, time: "12 min", calculator: false)[
  Find the substitution yourself and solve.
  #auto-parts(
    1,
    [$(x^2 - 3)^2 - (x^2 - 3) - 2 = 0$],
    [$1/x^2 - 3/x + 2 = 0$],
  )
][
  #auto-parts(
    1,
    [Let $u = x^2 - 3$: $u^2 - u - 2 = 0$, so $u = 2$ or $u = -1$. Then
      $x^2 = 5$ or $x^2 = 2$, so
      $x = plus.minus sqrt(5)$ or $x = plus.minus sqrt(2)$.],
    [Let $u = 1/x$: $u^2 - 3u + 2 = 0$, so $u = 1$ or $u = 2$. Then
      $x = 1$ or $x = 1/2$.],
  )
]

#keybox(title: "Check with your calculator")[
  #only-basic[
    *TI-30X Pro MathPrint.* Solve the equation in $u$ with *poly-solv*,
    then substitute back by hand. You can also use *num-solv* directly on
    the original equation, but it returns *one* solution near your start
    value. Try several start values, and do not trust that you have all
    of them. // VERIFY on device
  ]
  #only-high[
    *TI-Nspire CAS.* `solve(x^4-5·x^2+4=0,x)` returns all four real
    solutions. Check it against your substitution. For an equation such as
    `x-5·√(x)+6=0`, compare CAS with your hand solution, and test
    whether it keeps only solutions with $sqrt(x) >= 0$.
    // VERIFY on device
  ]
]

#ex(level: "basic", difficulty: 2, time: "8 min", calculator: true)[
  Consider $x^4 - 7x^2 + 12 = 0$.
  #auto-parts(
    1,
    [Use *poly-solv* on the equation in $u = x^2$.],
    [Go back to $x$ by hand. Give all solutions, exact and to $2$
      decimals.],
    [Use *num-solv* with the start value $1$. Which solution do you
      find? Is it all of them?],
  )
][
  #auto-parts(
    1,
    [$u^2 - 7u + 12 = 0$ gives $u = 3$ and $u = 4$.],
    [$x = plus.minus sqrt(3) approx plus.minus 1.73$ and
      $x = plus.minus 2$.],
    [It finds only one of the four solutions (the one near the start
      value).],  // VERIFY on device
  )
]

#ex(level: "high", difficulty: 2, time: "8 min", calculator: true)[
  Use your TI-Nspire CAS.
  #auto-parts(
    1,
    [Solve $x^4 - 7x^2 + 12 = 0$ with `solve`. Compare with your
      substitution.],
    [Solve $x - 5 sqrt(x) + 6 = 0$ with `solve`. How many solutions does
      it show? Why is $x = 4$ or $x = 9$ right, but $x = 0.0$ is not?],
  )
][
  #auto-parts(
    1,
    [$x = -2$, $-sqrt(3)$, $sqrt(3)$, $2$ (four real solutions).],
    [Two solutions, $x = 4$ and $x = 9$. Because $u = sqrt(x)$ must be
      $>= 0$, and both $u = 2$ and $u = 3$ are.],
  )
]

#check(
  kind: "Stage check",
  "Substitution",
  (
    [Solve $x^4 - 13x^2 + 36 = 0$.],
    [Solve $x^4 - 3x^2 - 4 = 0$.],
    [Solve $x^6 - 7x^3 - 8 = 0$.],
    [Solve $2x - 7 sqrt(x) + 3 = 0$.],
  ),
  (
    [$x = -3$, $x = -2$, $x = 2$, or $x = 3$],
    [$x = -2$ or $x = 2$],
    [$x = -1$ or $x = 2$],
    [$x = 1/4$ or $x = 9$],
  ),
  pass: [Continue with #goto-first(<st-rational>).],
  fail: [Find the example or exercise that matches your mistake and redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════
== Rational Equations <st-rational>

#check(
  "Rational Equations",
  (
    [Solve $3/x = 6/(x + 2)$.],
    [Solve $1/x + 1/(x + 1) = 5/6$.],
    [Solve $(x^2 - 4)/(x - 2) = 0$.],
    [State the domain of $2/(x - 1) + 3/(x + 4) = 1$. (Do not solve.)],
  ),
  (
    [$x = 2$],
    [$x = -3/5$ or $x = 2$],
    [$x = -2$],
    [$x != 1$ and $x != -4$],
  ),
  pass: [Skip to the checkpoint in #goto-first(<st-radical>).],
  fail: [Work through this section.],
)

#only-theory[
  In a #vocab("rational equation", "Bruchgleichung") the unknown
  appears in a denominator. Two things must be handled with care. First,
  some values of $x$ are not allowed, because they make a denominator
  zero. Second, multiplying by an expression that contains $x$ can
  produce a false solution, an #vocab("extraneous solution",
  "Scheinlösung").
]

#keybox(title: "Solving a rational equation")[
  + *Domain first.* Write down the values that make a denominator zero.
    They are not allowed.
  + *Multiply* both sides by the
    #vocab("common denominator", "Hauptnenner") to remove all fractions.
  + *Solve* the equation you get.
  + *Check against the domain.* Throw away every solution that is not
    allowed. Then substitute the rest into the original equation.
]

#example(title: "A simple case")[
  Solve $3/x = 6/(x + 2)$. The domain: $x != 0$, $x != -2$. Multiply by
  $x dot (x + 2)$: $3 dot (x + 2) = 6x$, so $3x = 6$ and $x = 2$. This
  is allowed. Check: $3/2 = 6/4$.
]

#example(title: "The equation turns into a quadratic")[
  Solve $1/x + 1/(x + 1) = 5/6$. The domain: $x != 0$, $x != -1$.
  Multiply by $6x dot (x + 1)$:
  $6 dot (x + 1) + 6x = 5x dot (x + 1)$, so $5x^2 - 7x - 6 = 0$. Then
  $x = 2$ or $x = -3/5$. Both are allowed, so $L = \{-3/5, 2\}$.
]

#example(title: "A false solution")[
  Solve $x/(x - 2) = 2/(x - 2)$. The domain: $x != 2$. Multiply by
  $x - 2$: we get $x = 2$. But $x = 2$ is not allowed. So there is *no
  solution*: $L = \{ \}$.
]

#example(title: "A fraction equal to zero")[
  Solve $(x^2 - 4)/(x - 2) = 0$. A fraction is $0$ only if its
  *numerator* is $0$ and its denominator is not. The numerator is
  $(x - 2) dot (x + 2)$, so $x = 2$ or $x = -2$. But $x = 2$ is not in
  the domain. So $L = \{-2\}$.
]

#warning[
  *Forgetting the domain.* The algebra after step 2 does not know about
  the forbidden values. Only your check does. A solution that makes a
  denominator zero is never a solution of the original equation, however
  neat the calculation looked.
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  State the domain, then solve.
  #auto-parts(
    2,
    [$4/x = 2/3$],
    [$5/(x + 1) = 1$],
    [$3/(x - 2) = 6/(x + 1)$],
    [$x/(x + 3) = 1/2$],
  )
][
  #auto-parts(
    2,
    [$x != 0$. Then $4 dot 3 = 2x$, so $x = 6$.],
    [$x != -1$. Then $5 = x + 1$, so $x = 4$.],
    [$x != 2$, $x != -1$. Then $3x + 3 = 6x - 12$, so $x = 5$.],
    [$x != -3$. Then $2x = x + 3$, so $x = 3$.],
  )
]

#ex(
  difficulty: 2,
  time: "12 min",
  calculator: false,
  hints: ([Multiply by the common denominator, then solve what remains.],),
)[
  State the domain, solve, and check.
  #auto-parts(
    2,
    [$2/x + 3 = 5/x$],
    [$1/x - 1/(x + 2) = 1/4$],
    [$(x + 1)/(x - 1) = 3$],
    [$1/(x - 1) + 1/(x + 1) = 1$],
  )
][
  #auto-parts(
    2,
    [$x != 0$. Multiply by $x$: $2 + 3x = 5$, so $x = 1$.],
    [$x != 0$, $x != -2$. Multiply by $4x dot (x + 2)$:
      $4 dot (x + 2) - 4x = x dot (x + 2)$, so $x^2 + 2x - 8 = 0$ and
      $x = -4$ or $x = 2$.],
    [$x != 1$. Then $x + 1 = 3x - 3$, so $x = 2$.],
    [$x != plus.minus 1$. Multiply by $(x - 1) dot (x + 1)$:
      $2x = x^2 - 1$, so $x^2 - 2x - 1 = 0$ and
      $x = 1 plus.minus sqrt(2)$.],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Each equation has a trap. Solve it and say what happens.
  #auto-parts(
    2,
    [$x/(x - 3) = 3/(x - 3)$],
    [$(x^2 - 5x + 6)/(x - 2) = 0$],
    [$1/(x - 1) = 2/(x^2 - 1)$],
    [$(2x)/(x - 1) = 2/(x - 1) + 3$],
  )
][
  #auto-parts(
    2,
    [$x = 3$ is not allowed. No solution.],
    [Numerator $(x - 2) dot (x - 3)$: $x = 2$ is not allowed, so
      $L = \{3\}$.],
    [Multiply by $x^2 - 1$: $x + 1 = 2$, so $x = 1$. Not allowed. No
      solution.],
    [Multiply by $x - 1$: $2x = 2 + 3x - 3$, so $x = 1$. Not allowed.
      No solution.],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Three students solved an equation. For each one, decide whether the
  work is correct. If it is wrong, name the mistake and give the correct
  solution set.
  #auto-parts(
    1,
    [Pia: $1/x + 1/(x + 1) = 2/(2x + 1)$],
    [Omar: $x/(x - 2) = 2/(x - 2) #h(0.5em) arrow.r.double #h(0.5em)
      x = 2$],
    [Nina: $3/(x - 1) = 6/(x + 1) #h(0.5em) arrow.r.double #h(0.5em)
      3x + 3 = 6x - 6 #h(0.5em) arrow.r.double #h(0.5em) x = 3$. Check:
      $3/2 = 6/4$.],
  )
][
  #auto-parts(
    1,
    [Wrong. Pia added numerators and denominators. Fractions are added
      over a common denominator:
      $1/x + 1/(x + 1) = (2x + 1)/(x dot (x + 1))$.],
    [Wrong. $x = 2$ makes the denominator zero. Correct: $L = \{ \}$.],
    [Correct.],
  )
]

#ex(difficulty: 3, time: "12 min", calculator: false)[
  Set up an equation and solve it.
  #auto-parts(
    1,
    [Pipe A fills a tank in $6$ h, pipe B in $12$ h. How long do they
      take together?],
    [Worker A needs $3$ hours longer than worker B alone. Together they
      need $2$ hours. How long does each need alone?],
    [Solve $(x + 3)/(x - 1) - (x - 1)/(x + 3) = 2$.],
  )
][
  #auto-parts(
    1,
    [In one hour they fill $1/6 + 1/12 = 1/4$ of the tank, so they need
      $4$ h.],
    [B needs $t$ hours, A needs $t + 3$: $1/t + 1/(t + 3) = 1/2$. Multiply
      by $2t dot (t + 3)$: $2 dot (2t + 3) = t dot (t + 3)$, so
      $t^2 - t - 6 = 0$ and $t = 3$ (since $t > 0$). B needs $3$ h, A
      needs $6$ h. Check: $1/3 + 1/6 = 1/2$.],
    [Domain: $x != 1$, $x != -3$. Multiplying out gives
      $x^2 - 2x - 7 = 0$, so $x = 1 plus.minus 2 sqrt(2)$. Both are
      allowed.],
  )
]

#keybox(title: "Check with your calculator")[
  #only-basic[
    *TI-30X Pro MathPrint.* *num-solv* needs a *start value* and
    returns *one* solution. For a rational equation, different start
    values can give different solutions, and the calculator does not
    know your domain. So: find all solutions by hand, then use the
    calculator to check them. // VERIFY on device
  ]
  #only-high[
    *TI-Nspire CAS.* `solve(1/x+1/(x+1)=5/6,x)` returns both solutions.
    For `x/(x-2)=2/(x-2)`, the correct answer is `false`. Read the
    output critically: CAS may simplify the fractions before solving,
    so you must check whether it really respects the domain.
    // VERIFY on device: output for the false-solution and zero-numerator cases
  ]
]

#ex(level: "basic", difficulty: 2, time: "8 min", calculator: true)[
  Consider $1/x + 1/(x + 1) = 5/6$.
  #auto-parts(
    1,
    [Use *num-solv* with the start value $1$, then with the start value
      $-1$. What do you find?],
    [Check both solutions by substituting into the original equation.],
  )
][
  #auto-parts(
    1,
    [Different start values can lead to the two solutions $x = 2$ and
      $x = -0.6$.],  // VERIFY on device
    [For $x = 2$: $1/2 + 1/3 = 5/6$. For $x = -3/5$:
      $-5/3 + 5/2 = 5/6$.],
  )
]

#ex(level: "high", difficulty: 2, time: "8 min", calculator: true)[
  Use your TI-Nspire CAS.
  #auto-parts(
    1,
    [Solve $x/(x - 2) = 2/(x - 2)$ with `solve`. What does the
      calculator say, and what does it mean?],
    [Solve $(x^2 - 4)/(x - 2) = 0$ with `solve`. Does the result
      agree with your hand solution?],
  )
][
  #auto-parts(
    1,
    [`false`: there is no solution (the only candidate $x = 2$ is not
      in the domain).],  // VERIFY on device
    [$x = -2$. The calculator should not list $x = 2$.
],  // VERIFY on device
  )
]

#check(
  kind: "Stage check",
  "Rational Equations",
  (
    [Solve $5/(x - 1) = 3/(x + 1)$.],
    [Solve $2/x - 1/(x + 3) = 1/2$.],
    [Solve $(x^2 - 9)/(x - 3) = 0$.],
    [Solve $1/(x - 3) + 2 = 4/(x - 3)$.],
  ),
  (
    [$x = -4$],
    [$x = -4$ or $x = 3$],
    [$x = -3$],
    [$x = 9/2$],
  ),
  pass: [Continue with #goto-first(<st-radical>).],
  fail: [Find the example or exercise that matches your mistake and redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════
== Radical Equations <st-radical>

#check(
  "Radical Equations",
  (
    [Solve $sqrt(x + 3) = 5$.],
    [Solve $sqrt(2x - 1) = x - 2$.],
    [Solve $sqrt(x) = -2$.],
    [Solve $sqrt(5x - 4) = x$.],
  ),
  (
    [$x = 22$],
    [$x = 5$],
    [No real solution],
    [$x = 1$ or $x = 4$],
  ),
  pass: [Skip to the checkpoint in #goto-first(<st-param>).],
  fail: [Work through this section.],
)

#only-theory[
  In a #vocab("radical equation", "Wurzelgleichung") the unknown is
  under a square root. To remove the root, you square both sides. But
  squaring is not an equivalent transformation. It can add solutions,
  so *checking is not optional here*.
]

#keybox(title: "Solving a radical equation")[
  + *Isolate* the square root on one side.
  + *Square* both sides. Careful: $(a + b)^2 != a^2 + b^2$.
  + *Solve* the equation you get.
  + *Check every solution in the original equation.* Throw away the
    extraneous ones.
]

#example(title: "Isolate, square, check")[
  Solve $sqrt(2x - 1) = x - 2$. Squaring gives
  $2x - 1 = x^2 - 4x + 4$, so $x^2 - 6x + 5 = 0$ and $x = 1$ or
  $x = 5$. Now check:
  - $x = 1$: left $sqrt(1) = 1$, right $1 - 2 = -1$. *Not equal.*
  - $x = 5$: left $sqrt(9) = 3$, right $5 - 2 = 3$. *Equal.*

  So $L = \{5\}$. The false solution $x = 1$ appeared because
  $1^2 = (-1)^2$: squaring cannot tell $1$ from $-1$.
]

#example(title: "Both solutions can be fine")[
  Solve $sqrt(5x - 4) = x$. Squaring: $5x - 4 = x^2$, so
  $x^2 - 5x + 4 = 0$ and $x = 1$ or $x = 4$. Check: $sqrt(1) = 1$ and
  $sqrt(16) = 4$. Both work, so $L = \{1, 4\}$. This is why you must
  check, and not simply discard one of them.
]

#example(title: "Two roots")[
  Solve $sqrt(x + 7) - sqrt(x) = 1$. Isolate one root first:
  $sqrt(x + 7) = 1 + sqrt(x)$. Squaring gives
  $x + 7 = 1 + 2 sqrt(x) + x$, so $6 = 2 sqrt(x)$ and $x = 9$. Check:
  $sqrt(16) - sqrt(9) = 1$.
]

#warning[
  *$sqrt(x^2) = abs(x)$, not $x$.* For $x = -3$ we get
  $sqrt((-3)^2) = sqrt(9) = 3$, not $-3$. So $sqrt(x^2) = 3$ has the two
  solutions $x = 3$ and $x = -3$. Also remember that a square root is
  never negative: $sqrt(x) = -2$ has no solution at all.
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Solve and check.
  #auto-parts(
    3,
    [$sqrt(x - 1) = 4$],
    [$sqrt(3x + 1) = 5$],
    [$sqrt(x) + 2 = 7$],
    [$3 sqrt(x + 1) = 12$],
    [$sqrt(x^2) = 7$],
    [$sqrt(x) = -5$],
  )
][
  #auto-parts(
    3,
    [$x - 1 = 16$, so $x = 17$],
    [$3x + 1 = 25$, so $x = 8$],
    [$sqrt(x) = 5$, so $x = 25$],
    [$sqrt(x + 1) = 4$, so $x = 15$],
    [$x = 7$ or $x = -7$],
    [No solution, since a root is never negative.],
  )
]

#ex(
  difficulty: 2,
  time: "12 min",
  calculator: false,
  hints: ([A solution is only valid if the right side is not negative.],),
)[
  Solve. Check every candidate in the original equation.
  #auto-parts(
    2,
    [$sqrt(x + 6) = x$],
    [$sqrt(2x + 8) = x$],
    [$x - 1 = sqrt(x + 5)$],
    [$sqrt(6 - x) = x$],
  )
][
  #auto-parts(
    2,
    [$x^2 - x - 6 = 0$: $x = 3$ or $x = -2$. Only $x = 3$ works.],
    [$x^2 - 2x - 8 = 0$: $x = 4$ or $x = -2$. Only $x = 4$ works.],
    [$x^2 - 3x - 4 = 0$: $x = 4$ or $x = -1$. Only $x = 4$ works.],
    [$x^2 + x - 6 = 0$: $x = 2$ or $x = -3$. Only $x = 2$ works.],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Three students solved an equation. For each one, decide whether the
  work is correct. If it is wrong, name the mistake and give the correct
  solution set.
  #auto-parts(
    1,
    [Pia: $sqrt(x + 2) = x #h(0.5em) arrow.r.double #h(0.5em)
      x + 2 = x^2 #h(0.5em) arrow.r.double #h(0.5em)
      x = 2 " or " x = -1$],
    [Omar: $sqrt(x^2) = 4 #h(0.5em) arrow.r.double #h(0.5em) x = 4$],
    [Nina: $sqrt(x - 3) = -1 #h(0.5em) arrow.r.double #h(0.5em)
      x - 3 = 1 #h(0.5em) arrow.r.double #h(0.5em) x = 4$. Check:
      $sqrt(1) = 1 != -1$, so there is no solution.],
  )
][
  #auto-parts(
    1,
    [Wrong. Pia did not check. For $x = -1$: $sqrt(1) = 1 != -1$. Only
      $x = 2$ works: $L = \{2\}$.],
    [Wrong. $sqrt(x^2) = abs(x)$, so $x = 4$ or $x = -4$.],
    [Correct. The check shows $x = 4$ is extraneous.],
  )
]

#ex(difficulty: 3, time: "12 min", calculator: false)[
  Isolate a root first. Solve and check.
  #auto-parts(
    1,
    [$sqrt(x + 3) + 3 = x$],
    [$sqrt(x + 1) + sqrt(x - 4) = 5$],
    [A number $x$ satisfies $x - 6 = sqrt(x)$. Find $x$.],
  )
][
  #auto-parts(
    1,
    [$sqrt(x + 3) = x - 3$, so $x + 3 = x^2 - 6x + 9$ and
      $x^2 - 7x + 6 = 0$. Then $x = 6$ or $x = 1$. Check: $x = 6$:
      $3 + 3 = 6$. $x = 1$: $2 + 3 = 5 != 1$. So $L = \{6\}$.],
    [$sqrt(x + 1) = 5 - sqrt(x - 4)$. Squaring:
      $x + 1 = 25 - 10 sqrt(x - 4) + x - 4$, so
      $10 sqrt(x - 4) = 20$ and $x - 4 = 4$, $x = 8$. Check:
      $sqrt(9) + sqrt(4) = 5$.],
    [Squaring: $x^2 - 13x + 36 = 0$, so $x = 4$ or $x = 9$. Check
      $x = 4$: $4 - 6 = -2 != 2$. Check $x = 9$: $9 - 6 = 3 = sqrt(9)$.
      So $x = 9$.],
  )
]

#keybox(title: "Check with your calculator")[
  #only-basic[
    *TI-30X Pro MathPrint.* The calculator is a good *checker* for
    radical equations. After you have squared and solved, evaluate the
    left side and the right side of the _original_ equation for each
    candidate, and compare the two numbers. *num-solv* may help to find a
    solution, but it returns only one, and it does not tell you about
    extraneous ones. // VERIFY on device
  ]
  #only-high[
    *TI-Nspire CAS.* `solve(√(2·x-1)=x-2,x)` should return only the
    valid solution. Compare with your hand work, where you found the
    extraneous solution $x = 1$ yourself. Be careful with
    `solve(√(x^2)=3,x)`: the answer has two solutions.
    // VERIFY on device: whether CAS drops extraneous solutions
  ]
]

#ex(level: "basic", difficulty: 1, time: "8 min", calculator: true)[
  Solve $sqrt(2x - 1) = x - 2$ by hand. You get two candidates.
  #auto-parts(
    1,
    [Evaluate the left side and the right side for each candidate with
      your calculator.],
    [Which candidate is a solution? Why does the other one appear?],
  )
][
  #auto-parts(
    1,
    [$x = 1$: left $= 1$, right $= -1$. $x = 5$: left $= 3$, right
      $= 3$.],
    [Only $x = 5$. Squaring turns $-1$ and $1$ into the same number,
      so $x = 1$ is extraneous.],
  )
]

#ex(level: "high", difficulty: 1, time: "8 min", calculator: true)[
  Use your TI-Nspire CAS.
  #auto-parts(
    1,
    [Solve $sqrt(2x - 1) = x - 2$ with `solve`. How many solutions does
      it show?],
    [Solve $sqrt(x^2) = 3$ with `solve`. Explain the answer.],
    [Solve $sqrt(x) = -2$ with `solve`. Explain the answer.],
  )
][
  #auto-parts(
    1,
    [One solution, $x = 5$. The extraneous $x = 1$ is not shown.
],  // VERIFY on device
    [$x = -3$ or $x = 3$, because $sqrt(x^2) = abs(x)$.],
    [`false`: a square root is never negative.],
  )
]

#check(
  kind: "Stage check",
  "Radical Equations",
  (
    [Solve $sqrt(2x + 1) = 7$.],
    [Solve $sqrt(x + 10) = x - 2$.],
    [Solve $sqrt(x + 5) + 1 = 0$.],
    [Solve $sqrt(7x - 10) = x$.],
  ),
  (
    [$x = 24$],
    [$x = 6$],
    [No real solution],
    [$x = 2$ or $x = 5$],
  ),
  pass: [Continue with #goto-first(<st-param>).],
  fail: [Find the example or exercise that matches your mistake and redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════
== Equations with a Parameter <st-param>

#check(
  "Equations with a Parameter",
  (
    [Solve $a dot x + 3 = 2x + 7$ for $x$ (with $a != 2$).],
    [For which $k$ does $x^2 - 4x + k = 0$ have exactly one solution?],
    [For which $k$ does $x^2 + 2x + k = 0$ have no real solution?],
    [For which $a$ does $a dot x = 5$ have no solution?],
  ),
  (
    [$x = 4/(a - 2)$],
    [$k = 4$],
    [$k > 1$],
    [$a = 0$],
  ),
  pass: [Skip to the checkpoint in #goto-first(<st-linsys>).],
  fail: [Work through this section.],
)

#only-theory[
  Sometimes an equation contains a letter that stands for a number you
  are not told: a #vocab("parameter", "Parameter"). You then solve for
  $x$ in terms of the parameter. The new difficulty is that the answer
  can depend on the parameter, and for special values it can change
  completely.
]

#keybox(title: "Equations with a parameter")[
  + Solve as usual, treating the parameter like a number.
  + Before you *divide* by an expression with the parameter, ask: can
    it be zero? If yes, make a
    #vocab("case distinction", "Fallunterscheidung") and treat that
    value separately.
  + For a quadratic, the *discriminant* decides the number of solutions
    for each value of the parameter.
]

#example(title: "Dividing by the parameter")[
  Solve $a dot x = 5$. If $a != 0$, divide: $x = 5/a$. If $a = 0$, the
  equation reads $0 = 5$, which is false: *no solution*.
]

#example(title: "Infinitely many solutions")[
  Solve $a dot x = a$. If $a != 0$, then $x = 1$. If $a = 0$, the
  equation reads $0 = 0$, which is true for *every* $x$.
]

#example(title: "Number of solutions of a quadratic")[
  For which $k$ does $x^2 - 4x + k = 0$ have exactly one solution?
  $D = 16 - 4k$. Exactly one solution means $D = 0$, so $k = 4$. For
  $k < 4$ there are two solutions, for $k > 4$ there are none.
]

#warning[
  *Do not divide by the parameter without checking whether it can be
  $0$.* Dividing both sides of $a dot x = a$ by $a$ gives $x = 1$ and
  hides the case $a = 0$, where _every_ $x$ is a solution.
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Solve for $x$. State any restriction on the parameter.
  #auto-parts(
    2,
    [$2x + a = 7$],
    [$a dot x - 3 = 2x + 5$ (with $a != 2$)],
    [$b dot x = 6$],
    [$(m - 1) dot x = m - 1$],
  )
][
  #auto-parts(
    2,
    [$x = (7 - a)/2$],
    [$(a - 2) dot x = 8$, so $x = 8/(a - 2)$],
    [If $b != 0$: $x = 6/b$. If $b = 0$: no solution.],
    [If $m != 1$: $x = 1$. If $m = 1$: every $x$ is a solution.],
  )
]

#ex(
  difficulty: 2,
  time: "12 min",
  calculator: false,
  hints: ([Use the discriminant $D = b^2 - 4 a c$ and decide when $D = 0$,
    $D > 0$, or $D < 0$.],),
)[
  For which values of the parameter does the equation have...
  #auto-parts(
    1,
    [exactly one solution: $x^2 + 6x + k = 0$],
    [two different solutions: $x^2 - 4x + k = 0$],
    [exactly one solution: $x^2 + k x + 9 = 0$],
    [no real solution: $x^2 + k x + 1 = 0$],
  )
][
  #auto-parts(
    1,
    [$D = 36 - 4k = 0$, so $k = 9$.],
    [$D = 16 - 4k > 0$, so $k < 4$.],
    [$D = k^2 - 36 = 0$, so $k = 6$ or $k = -6$.],
    [$D = k^2 - 4 < 0$, so $-2 < k < 2$.],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Three students solved an equation with a parameter. For each one,
  decide whether the work is correct. If it is wrong, name the mistake
  and give the correct result.
  #auto-parts(
    1,
    [Pia: $a dot x = a #h(0.5em) arrow.r.double #h(0.5em) x = 1$],
    [Omar: $a dot x = a$. If $a != 0$ then $x = 1$. If $a = 0$ then every
      $x$ is a solution.],
    [Nina: $x^2 - 4x + k = 0$ has exactly one solution when
      $16 - 4k = 0$, that is, for $k = 4$.],
  )
][
  #auto-parts(
    1,
    [Wrong. Pia divided by $a$ without asking whether $a = 0$. For
      $a = 0$ every $x$ is a solution.],
    [Correct.],
    [Correct. Then $x^2 - 4x + 4 = (x - 2)^2 = 0$, so $x = 2$.],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Use the known solution to find the parameter.
  #auto-parts(
    1,
    [$x = 2$ is a solution of $x^2 + k x - 10 = 0$. Find $k$ and the
      other solution.],
    [$x = 1$ is a solution of $x^2 - 5x + k = 0$. Find $k$ and the other
      solution.],
  )
][
  #auto-parts(
    1,
    [$4 + 2k - 10 = 0$, so $k = 3$. Then $x^2 + 3x - 10 = 0$ gives
      $(x + 5) dot (x - 2) = 0$, so the other solution is $x = -5$.],
    [$1 - 5 + k = 0$, so $k = 4$. Then $x^2 - 5x + 4 = 0$ gives
      $(x - 1) dot (x - 4) = 0$, so the other solution is $x = 4$.],
  )
]

#ex(difficulty: 3, time: "12 min", calculator: false)[
  Careful with the special case.
  #auto-parts(
    1,
    [For which $m$ does $m x^2 - 2x + 1 = 0$ have exactly one solution?
      Two solutions? None?],
    [For which $c$ is the line $y = 2x + c$ tangent to the parabola
      $y = x^2$? (Tangent means exactly one common point.)],
  )
][
  #auto-parts(
    1,
    [If $m = 0$ the equation is linear, $-2x + 1 = 0$, with exactly one
      solution $x = 1/2$. If $m != 0$: $D = 4 - 4m$. So $m = 1$ gives one
      solution, $m < 1$ with $m != 0$ gives two, and $m > 1$ gives none.
      Exactly one solution for $m = 0$ or $m = 1$.],
    [$x^2 = 2x + c$ gives $x^2 - 2x - c = 0$ with $D = 4 + 4c$. One
      common point means $D = 0$, so $c = -1$. Then $(x - 1)^2 = 0$: the
      point of tangency is at $x = 1$.],
  )
]

#keybox(title: "Check with your calculator")[
  #only-basic[
    *TI-30X Pro MathPrint.* The calculator cannot work with a letter as
    parameter. Use it to *test* your formula: choose a value for the
    parameter, solve the specific equation with *poly-solv* or by hand,
    and compare with your formula. // VERIFY on device
  ]
  #only-high[
    *TI-Nspire CAS.* `solve(a·x-3=2·x+5,x)` returns $x = 8/(a - 2)$.
    Read it critically: CAS may not mention the case $a = 2$. For a
    quadratic, `solve(x^2-4·x+k=0,x)` returns a formula with
    $sqrt(4 - k)$, and you read off the cases yourself.
    // VERIFY on device: whether the case a = 2 is mentioned
  ]
]

#ex(level: "basic", difficulty: 2, time: "8 min", calculator: true)[
  Test your formula $x = 8/(a - 2)$ for $a x - 3 = 2x + 5$.
  #auto-parts(
    1,
    [Choose $a = 4$. What does the formula give?],
    [Put that $x$ into both sides of $4x - 3 = 2x + 5$.],
    [Use *poly-solv* on $x^2 - 4x + k = 0$ for $k = 3$, $k = 4$, and
      $k = 5$. What do you see? Which discriminant case is each?],
  )
][
  #auto-parts(
    1,
    [$x = 8/2 = 4$.],
    [Left: $4 dot 4 - 3 = 13$. Right: $2 dot 4 + 5 = 13$.],
    [$k = 3$: $x = 1$ and $x = 3$ ($D > 0$). $k = 4$: $x = 2$ only
      ($D = 0$). $k = 5$: no real solution ($D < 0$).
],  // VERIFY on device
  )
]

#ex(level: "high", difficulty: 2, time: "8 min", calculator: true)[
  Use your TI-Nspire CAS.
  #auto-parts(
    1,
    [Solve $a dot x - 3 = 2x + 5$ for $x$. What happens at $a = 2$, and
      does CAS tell you?],
    [Solve $x^2 - 4x + k = 0$ for $x$. For which $k$ is the square root
      real?],
  )
][
  #auto-parts(
    1,
    [$x = 8/(a - 2)$. For $a = 2$ the equation reads $0 = 8$, which has
      no solution. CAS may not say so.],  // VERIFY on device
    [$x = 2 plus.minus sqrt(4 - k)$. The root is real for $k <= 4$.],
  )
]

#check(
  kind: "Stage check",
  "Equations with a Parameter",
  (
    [Solve $m dot x + 5 = 3x - 1$ for $x$ (with $m != 3$).],
    [For which $k$ does $x^2 + 6x + k = 0$ have exactly one solution?],
    [For which $k$ does $x^2 - 2x + k = 0$ have two different solutions?],
    [For which $a$ does $a dot x = a$ have infinitely many solutions?],
  ),
  (
    [$x = 6/(3 - m)$],
    [$k = 9$],
    [$k < 1$],
    [$a = 0$ (every $x$ is a solution)],
  ),
  pass: [Continue with #goto-first(<st-linsys>).],
  fail: [Find the example or exercise that matches your mistake and redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════
#print-check-key()

#print-hints()
#print-vocab()
