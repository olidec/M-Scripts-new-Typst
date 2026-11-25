// ch-eq-polynomial.typ — Polynomial Equations (equations booklet)
//
// COMPLETE. Theory, worked examples, exercises (both tracks), warnings,
// error-analysis task, calculator block. Checkpoint and stage check
// from the skeleton.
//
// TARGET MISCONCEPTIONS (see stage notes)
//   (none specific to this chapter)
// STATUS
//   done:  everything. All numeric answers verified by root scan +
//          substitution (SymPy is not installable here).
//
// NEEDS A VISUAL CHECK — not compiled (no Typst in the drafting
// environment): route boxes, goto-first links, yr() cells in checks.

#import "../../common/preamble.typ": *
#import "config.typ": *
#show: chapter-template.with(title: "Polynomial Equations")
#let ex = exercise.with(chapter: "Equations")
#let check = check.with(ex: ex)

= Polynomial Equations

#only-theory[
  Linear and quadratic equations have formulas. For degree $3$ and
  higher there is no formula you can use by hand, but you rarely need
  one. In school problems the polynomial is built so that it can be
  *factored*, and once it is a product the zero-product rule from the
  quadratic chapter does the rest. This chapter is about turning a
  polynomial into a product. The same equations show up when you look
  for extreme points (where $f'(x) = 0$) or for the intersection of two
  graphs.
]

#objectives(
  [Solve degree-3 and higher equations by factoring],
  [Use a known solution to reduce the degree],
  [Say how many real solutions are possible],
)

// ════════════════════════════════════════════════════════
== Equations of Degree 3 and Higher <st-poly>

#check(
  "Equations of Degree 3 and Higher",
  (
    [Solve $x^3 - 3x^2 - 4x + 12 = 0$.],
    [$x = 1$ is a solution of $x^3 - 6x^2 + 11x - 6 = 0$. Find all solutions.],
    [Solve $x^3 = 4x^2$.],
    [How many real solutions can an equation of degree $3$ have? Name all possibilities.],
  ),
  (
    [$x = -2$, $x = 2$, or $x = 3$],
    [$x = 1$, $x = 2$, or $x = 3$],
    [$x = 0$ or $x = 4$],
    [$1$, $2$, or $3$ (never $0$)],
  ),
  pass: [Skip to the checkpoint in #goto-first(<st-numeric>).],
  fail: [Work through this section.],
)

#only-theory[
  A #vocab("polynomial equation", "Polynomgleichung") of
  #vocab("degree", "Grad") $n$ can be written
  $a_n x^n + dots + a_1 x + a_0 = 0$ with $a_n != 0$. A solution is also
  called a #vocab("root", "Nullstelle") of the polynomial.
]

#keybox(title: "How many real solutions?")[
  - An equation of degree $n$ has *at most* $n$ real solutions.
  - If $n$ is *odd* (3, 5, ...), there is *at least one* real solution.
    A cubic has $1$, $2$ or $3$.
  - If $n$ is *even* (4, 6, ...), there can be *none*. Example:
    $x^4 + 1 = 0$.
  - A solution can appear twice, as in $(x - 1)^2 dot (x + 2) = 0$. It is
    then called a #vocab("double root", "doppelte Nullstelle"). It still
    counts as *one* solution when you list the solutions.
]

#keybox(title: "Four ways to factor")[
  + *Common factor:* take out the lowest power of $x$.
    $x^3 - 9x = x dot (x^2 - 9) = x dot (x - 3) dot (x + 3)$.
  + *Grouping:* if four terms pair up, factor each pair.
    $x^3 + 2x^2 - x - 2 = x^2 dot (x + 2) - (x + 2) = (x + 2) dot (x^2 - 1)$.
  + *Substitution:* if only $x^4$, $x^2$ and a constant appear, let
    $u = x^2$.
  + *A known solution:* if $x = a$ is a solution, then $(x - a)$ is a
    factor. Divide it out to reduce the degree by one.
]

#keybox(title: "Finding a first solution")[
  If the polynomial has integer coefficients and the leading coefficient
  is $1$, every integer solution divides the constant term. For
  $x^3 - 4x^2 + x + 6$, try the divisors of $6$:
  $plus.minus 1, plus.minus 2, plus.minus 3, plus.minus 6$. Substitute
  until one gives $0$. Then divide.

  #only-high[
    For leading coefficient $a_n != 1$, a rational solution $p/q$ (in
    lowest terms) must have $p$ dividing $a_0$ and $q$ dividing $a_n$.
  ]
]

#example(title: "Common factor and difference of squares")[
  Solve $x^4 - 16x^2 = 0$. Factor out $x^2$: $x^2 dot (x^2 - 16) = 0$, so
  $x^2 dot (x - 4) dot (x + 4) = 0$. The solutions are $x = 0$, $x = 4$ and
  $x = -4$. The solution $x = 0$ is a double root.
]

#example(title: "Grouping")[
  Solve $x^3 - 4x^2 - 9x + 36 = 0$. Group the terms:
  $x^2 dot (x - 4) - 9 dot (x - 4) = (x - 4) dot (x^2 - 9) = (x - 4) dot (x - 3) dot (x + 3)$.
  So $x = 4$, $x = 3$ or $x = -3$.
]

#example(title: "Use a known solution, with the Horner scheme")[
  Solve $x^3 - 4x^2 + x + 6 = 0$. Try $x = 2$: $8 - 16 + 2 + 6 = 0$. So
  $x = 2$ is a solution and $(x - 2)$ is a factor. To find the other
  factor, use the #vocab("Horner scheme", "Horner-Schema"). Write the
  coefficients in the top row. Bring down the first one. Then repeat:
  multiply by $2$ and add to the next coefficient.

  #align(center, table(
    columns: 5,
    stroke: none,
    align: center,
    [], [$1$], [$-4$], [$1$], [$6$],
    [$2$], [], [$2$], [$-4$], [$-6$],
    table.hline(),
    [], [$1$], [$-2$], [$-3$], [$0$],
  ))

  The last number is the remainder. It is $0$, which confirms that
  $x = 2$ is a solution. The other numbers are the coefficients of the
  quotient: $x^3 - 4x^2 + x + 6 = (x - 2) dot (x^2 - 2x - 3)$. Now solve the
  quadratic: $x^2 - 2x - 3 = (x - 3) dot (x + 1)$. The solutions are
  $x = 2$, $x = 3$ and $x = -1$.
]

#example(title: "A double root and an irrational solution")[
  $x^3 - 3x - 2 = 0$ has the solution $x = 2$. Division gives
  $(x - 2) dot (x^2 + 2x + 1) = (x - 2) dot (x + 1)^2$. So $x = 2$ or $x = -1$. The
  solution $-1$ is a double root, and the equation has only two
  *different* solutions.

  $x^3 + 2x^2 - 5x - 10 = 0$ has the solution $x = -2$. Division gives
  $(x + 2) dot (x^2 - 5)$, so $x = -2$ or $x = plus.minus sqrt(5)$.
]

#only-high[
  #example(title: "Leading coefficient not 1")[
    Solve $3x^3 - 8x^2 + 3x + 2 = 0$. The possible rational solutions
    $p/q$ have $p in {plus.minus 1, plus.minus 2}$ and
    $q in {1, 3}$. Try $x = 1$: $3 - 8 + 3 + 2 = 0$. Dividing by $(x - 1)$
    gives $3x^2 - 5x - 2 = (3x + 1) dot (x - 2)$. So $x = 1$, $x = 2$ or
    $x = -1/3$.
  ]

  #example(title: "Real solutions only")[
    $x^3 - 2x^2 - 2x - 3 = 0$ has the solution $x = 3$. Division gives
    $(x - 3) dot (x^2 + x + 1)$. The discriminant of $x^2 + x + 1$ is
    $1 - 4 = -3 < 0$, so there are no further *real* solutions. The only
    real solution is $x = 3$. (In the chapter on complex numbers you will
    find the other two.)
  ]
]

#warning[
  *Never divide by $x$.* From $x^3 = 4x^2$ it is tempting to divide by
  $x^2$ and write $x = 4$. But $x = 0$ is a solution too, and you have
  just lost it. Divide only by something that you know is not zero.
  Instead, bring everything to one side and factor:
  $x^3 - 4x^2 = x^2 dot (x - 4) = 0$, so $x = 0$ or $x = 4$.
]

#warning[
  *One solution is not the end.* After you have found $x = 2$ for a cubic,
  the work is only half done. Divide, and then solve the quadratic that
  is left. Also check the other direction: the quadratic may have *no*
  real solutions, and then your first solution is the only one.
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Solve by factoring out the lowest power of $x$.
  #auto-parts(
    2,
    [$x^3 - 9x = 0$],
    [$2x^3 + 8x^2 = 0$],
    [$x^4 - 16x^2 = 0$],
    [$x^3 + 4x = 0$],
    [$x^4 = x^2$],
    [$3x^3 - 12x = 0$],
  )
][
  #auto-parts(
    2,
    [$x dot (x - 3) dot (x + 3) = 0$, so $x = 0, 3, -3$],
    [$2x^2 dot (x + 4) = 0$, so $x = 0$ or $x = -4$],
    [$x^2 dot (x - 4) dot (x + 4) = 0$, so $x = 0, 4, -4$],
    [$x dot (x^2 + 4) = 0$, so $x = 0$ only],
    [$x^2 dot (x - 1) dot (x + 1) = 0$, so $x = 0, 1, -1$],
    [$3x dot (x - 2) dot (x + 2) = 0$, so $x = 0, 2, -2$],
  )
]

#ex(difficulty: 1, time: "10 min", calculator: false)[
  Solve by grouping.
  #auto-parts(
    2,
    [$x^3 + 2x^2 - x - 2 = 0$],
    [$x^3 + 5x^2 - 4x - 20 = 0$],
    [$x^3 - 4x^2 - 9x + 36 = 0$],
    [$2x^3 - x^2 - 8x + 4 = 0$],
  )
][
  #auto-parts(
    2,
    [$x^2 dot (x + 2) - (x + 2) = (x + 2) dot (x - 1) dot (x + 1)$, so $x = -2, 1, -1$],
    [$(x + 5) dot (x - 2) dot (x + 2) = 0$, so $x = -5, 2, -2$],
    [$(x - 4) dot (x - 3) dot (x + 3) = 0$, so $x = 4, 3, -3$],
    [$(2x - 1) dot (x - 2) dot (x + 2) = 0$, so $x = 1/2, 2, -2$],
  )
]

#ex(
  difficulty: 2,
  time: "12 min",
  calculator: false,
  hints: ([Divide the known factor out, with the Horner scheme or by long
    division. Then solve the quadratic that is left.],),
)[
  A solution is given. Find all real solutions.
  #auto-parts(
    2,
    [$x^3 - 2x^2 - 5x + 6 = 0$ #h(0.5em) dot ($x = 1$)],
    [$x^3 + 2x^2 - 5x - 10 = 0$ #h(0.5em) dot ($x = -2$)],
    [$2x^3 - 3x^2 - 11x + 6 = 0$ #h(0.5em) dot ($x = 3$)],
    [$x^3 - 3x - 2 = 0$ #h(0.5em) dot ($x = 2$)],
  )
][
  #auto-parts(
    2,
    [$(x - 1) dot (x^2 - x - 6) = (x - 1) dot (x - 3) dot (x + 2)$, so $x = 1, 3, -2$],
    [$(x + 2) dot (x^2 - 5) = 0$, so $x = -2$ or $x = plus.minus sqrt(5)$],
    [$(x - 3) dot (2x^2 + 3x - 2) = (x - 3) dot (2x - 1) dot (x + 2)$, so
      $x = 3, 1/2, -2$],
    [$(x - 2) dot (x + 1)^2 = 0$, so $x = 2$ or $x = -1$ (a double root)],
  )
]

#ex(
  difficulty: 2,
  time: "12 min",
  calculator: false,
  hints: ([The solutions you try are divisors of the constant term, with
    both signs.],),
)[
  No solution is given. Find one by trial, then reduce the degree.
  #auto-parts(
    1,
    [$x^3 - 4x^2 + x + 6 = 0$],
    [$x^3 + 3x^2 - 6x - 8 = 0$],
    [$x^4 - 5x^2 + 4 = 0$ #h(0.5em) dot (use a substitution instead)],
  )
][
  #auto-parts(
    1,
    [$x = 2$ works, and $(x - 2) dot (x^2 - 2x - 3) = (x - 2) dot (x - 3) dot (x + 1)$.
      So $x = 2, 3, -1$.],
    [$x = 2$ works ($8 + 12 - 12 - 8 = 0$), and
      $(x - 2) dot (x^2 + 5x + 4) = (x - 2) dot (x + 1) dot (x + 4)$. So $x = 2, -1, -4$.],
    [Let $u = x^2$: $u^2 - 5u + 4 = 0$, so $u = 1$ or $u = 4$. Therefore
      $x = plus.minus 1$ or $x = plus.minus 2$.],
  )
]

#ex(difficulty: 2, time: "6 min", calculator: false)[
  How many different real solutions does each equation have? Give a
  reason. You do not need to find them all.
  #auto-parts(
    3,
    [$x^3 + x = 0$],
    [$x^4 + 1 = 0$],
    [$x^4 - 1 = 0$],
    [$x^3 - x = 0$],
    [$(x - 1)^2 dot (x + 2) = 0$],
    [$x^5 + x^3 + x = 0$],
  )
][
  #auto-parts(
    3,
    [One: $x dot (x^2 + 1) = 0$, and $x^2 + 1 > 0$],
    [None: $x^4 + 1 >= 1$],
    [Two: $x = plus.minus 1$ (since $x^2 + 1 > 0$)],
    [Three: $x dot (x - 1) dot (x + 1) = 0$],
    [Two: $x = 1$ and $x = -2$. The solution $1$ is a double root.],
    [One: $x dot (x^4 + x^2 + 1) = 0$, and the bracket is always positive],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  *Find the error.* Solve $x^3 = 4x^2$. Three students answer:
  #align(center)[
    Anna: $x = 4$ #h(2em)
    Ben: $x = 0$ or $x = 4$ #h(2em)
    Chris: $x^2 dot (x - 4) = 0$, so $x = 4$
  ]
  #auto-parts(
    1,
    [Who is correct?],
    [Find the mistake in each of the other two answers.],
    [Check $x = 0$ in the original equation.],
  )
][
  #auto-parts(
    1,
    [Ben.],
    [Anna divided both sides by $x^2$. This is not allowed, because
      $x = 0$ makes $x^2 = 0$, and the solution $x = 0$ is lost. Chris
      factored correctly but forgot the factor $x^2$: from $x^2 = 0$ you
      get $x = 0$, which he left out.],
    [$0^3 = 0$ and $4 dot 0^2 = 0$, so $x = 0$ is a solution.],
  )
]

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: true,
  hints: ([Write the volume as $V = x dot (30 - 2x) dot (20 - 2x)$. The height $x$
    must be positive, and the sides must stay positive too.],),
)[
  An open box is made from a sheet of $30$ cm by $20$ cm. A square with side
  $x$ is cut from each corner, and the sides are folded up.
  #auto-parts(
    1,
    [Show that the volume is $1000$ cm#super[3] when
      $x^3 - 25x^2 + 150x - 250 = 0$.],
    [Find all real solutions of the equation. You can use $x = 5$.],
    [Which solutions make sense for the box? Give the dimensions.],
  )
][
  #auto-parts(
    1,
    [$x dot (30 - 2x) dot (20 - 2x) = 4x^3 - 100x^2 + 600x$. Setting this equal to
      $1000$ and dividing by $4$ gives the equation.],
    [$(x - 5) dot (x^2 - 20x + 50) = 0$, so $x = 5$ or
      $x = 10 plus.minus sqrt(50)$, which is $x approx 2.93$ or
      $x approx 17.07$.],
    [The sides $30 - 2x$ and $20 - 2x$ must be positive, so $0 < x < 10$.
      The value $17.07$ is not possible. For $x = 5$ the box is
      $20 times 10 times 5$ cm. For $x approx 2.93$ it is about
      $24.14 times 14.14 times 2.93$ cm.],
  )
]

#ex(difficulty: 3, time: "15 min", calculator: false)[
  Solve. Give all real solutions.
  #auto-parts(
    1,
    [$x^4 - 13x^2 + 36 = 0$],
    [$x^3 - 2x^2 - 8x = 0$],
    [$x^4 + x^3 - 6x^2 = 0$],
  )
][
  #auto-parts(
    1,
    [$u = x^2$: $u^2 - 13u + 36 = 0$, so $u = 4$ or $u = 9$. Therefore
      $x = plus.minus 2$ or $x = plus.minus 3$.],
    [$x dot (x^2 - 2x - 8) = x dot (x - 4) dot (x + 2) = 0$, so $x = 0, 4, -2$.],
    [$x^2 dot (x^2 + x - 6) = x^2 dot (x + 3) dot (x - 2) = 0$, so $x = 0, -3, 2$.],
  )
]

#ex(
  difficulty: 3,
  time: "15 min",
  calculator: false,
  hints: ([Try $x = 1$, $-1$, $2$, $-2$, ... Each solution you find lowers the
    degree by one.],),
)[
  Solve $x^4 - x^3 - 7x^2 + x + 6 = 0$.
][
  $x = 1$ works: $1 - 1 - 7 + 1 + 6 = 0$. Dividing gives
  $(x - 1) dot (x^3 - 7x - 6)$. Now $x = -1$ works in the cubic:
  $-1 + 7 - 6 = 0$. Dividing gives $(x - 1) dot (x + 1) dot (x^2 - x - 6)
  = (x - 1) dot (x + 1) dot (x - 3) dot (x + 2)$. So $x = 1, -1, 3, -2$.
]

#ex(level: "high", difficulty: 3, time: "15 min", calculator: false)[
  Solve. Give all *real* solutions.
  #auto-parts(
    1,
    [$3x^3 - 8x^2 + 3x + 2 = 0$],
    [$x^3 - 3x^2 + 4 = 0$],
    [$x^3 - 2x^2 - 2x - 3 = 0$],
  )
][
  #auto-parts(
    1,
    [$x = 1$ works. $(x - 1) dot (3x^2 - 5x - 2) = (x - 1) dot (3x + 1) dot (x - 2)$, so
      $x = 1, 2, -1/3$.],
    [$x = -1$ works. $(x + 1) dot (x^2 - 4x + 4) = (x + 1) dot (x - 2)^2$, so
      $x = -1$ or $x = 2$ (a double root).],
    [$x = 3$ works. $(x - 3) dot (x^2 + x + 1) = 0$, and $x^2 + x + 1$ has
      discriminant $-3$. The only real solution is $x = 3$.],
  )
]

#ex(level: "high", difficulty: 3, time: "12 min", calculator: false)[
  Find $k$ so that $x = 2$ is a solution of $x^3 + k x^2 - 5x - 6 = 0$.
  Then find all solutions for this value of $k$.
][
  Substituting $x = 2$: $8 + 4k - 10 - 6 = 0$, so $k = 2$. Then
  $x^3 + 2x^2 - 5x - 6 = (x - 2) dot (x^2 + 4x + 3) = (x - 2) dot (x + 1) dot (x + 3)$.
  So $x = 2, -1, -3$.
]

#keybox(title: "Check with your calculator")[
  #only-basic[
    *TI-30X Pro MathPrint.* The *poly-solv* function solves polynomial
    equations. You tell it the degree and enter the coefficients, with a
    $0$ for every missing power, for example $1, 0, -9, 0$ for
    $x^3 - 9x = 0$. It lists the solutions. Use it to *check* your
    factoring. Remember that you are asked for *real* solutions: if the
    display also shows other kinds of solutions, only the real ones count.
    // VERIFY on device: poly-solv menu path, maximum degree (2 or 3?)
    // VERIFY on device: how complex solutions are displayed
  ]
  #only-high[
    *TI-Nspire CAS.* `solve(x^3-6x^2+11x-6=0,x)` gives the real
    solutions. `factor(x^3-6x^2+11x-6)` shows the factored form
    $(x - 1) dot (x - 2) dot (x - 3)$, which is a good way to check your division.
    `zeros(x^3-6x^2+11x-6,x)` returns the roots of the polynomial.
    Read critically: `solve` lists only *real* solutions, and
    `cSolve` adds the complex ones. For $x^3 + x = 0$ the first returns
    $x = 0$, the second also gives $x = i$ and $x = -i$.
    // VERIFY on device: exact output format of solve, zeros, factor and cSolve
  ]
]

#ex(level: "basic", difficulty: 1, time: "10 min", calculator: true)[
  Use *poly-solv* to check your work.
  #auto-parts(
    1,
    [Enter $x^3 - 2x^2 - 5x + 6 = 0$. Do the solutions agree with your
      factoring $(x - 1) dot (x - 3) dot (x + 2)$?],
    [Enter $x^3 + 3x^2 - 6x - 8 = 0$. Write the solutions, and check one
      of them by substituting.],
    [Enter $x^3 + x = 0$. Which of the solutions shown are real?],
  )
][
  #auto-parts(
    1,
    [Yes: $x = 1$, $x = 3$ and $x = -2$.],
    [$x = 2$, $x = -1$ and $x = -4$. For $x = 2$: $8 + 12 - 12 - 8 = 0$.],
    [Only $x = 0$ is real. Any other solutions shown are not real.],
  )
]

#ex(level: "high", difficulty: 1, time: "10 min", calculator: true)[
  Use your TI-Nspire CAS.
  #auto-parts(
    1,
    [Use `factor` on $x^3 + 2x^2 - 5x - 6$. Then solve the equation.],
    [Solve $x^4 - 13x^2 + 36 = 0$ with `solve`. How many solutions are
      there?],
    [Solve $x^3 - 2x^2 - 2x - 3 = 0$ with `solve` and with `cSolve`. Explain
      the difference.],
  )
][
  #auto-parts(
    1,
    [$(x - 2) dot (x + 1) dot (x + 3)$, so $x = 2, -1, -3$.],
    [Four: $x = -3, -2, 2, 3$.],
    [`solve` gives only the real solution $x = 3$. `cSolve` also gives the
      two complex solutions $x = (-1 plus.minus i sqrt(3))/2$, the roots of
      $x^2 + x + 1 = 0$.],
  )
]

#check(
  kind: "Stage check",
  "Equations of Degree 3 and Higher",
  (
    [Solve $x^3 + x^2 - 9x - 9 = 0$.],
    [$x = 3$ is a solution of $x^3 - 7x - 6 = 0$. Find all solutions.],
    [Solve $x^3 - 5x^2 + 6x = 0$.],
    [How many real solutions does $x^3 + x = 0$ have?],
  ),
  (
    [$x = -3$, $x = -1$, or $x = 3$],
    [$x = -2$, $x = -1$, or $x = 3$],
    [$x = 0$, $x = 2$, or $x = 3$],
    [One: $x = 0$],
  ),
  pass: [Continue with #goto-first(<st-numeric>).],
  fail: [Find the example or exercise that matches your mistake and redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════
#print-check-key()

#print-hints()
#print-vocab()
