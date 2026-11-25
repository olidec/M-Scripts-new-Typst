// ch-eq-systems.typ — Systems of Equations (equations booklet)
//
// COMPLETE (Turn 4). Two stages: checkpoint, theory, exercises
// (ramped, with error analysis), calculator block, stage check.
//
// TARGET MISCONCEPTIONS (see stage notes)
//   (none specific to this chapter)
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
#show: chapter-template.with(title: "Systems of Equations")
#let ex = exercise.with(chapter: "Equations")
#let check = check.with(ex: ex)

= Systems of Equations

#only-theory[
  A single equation with two unknowns has many solutions. A _system_
  asks for the pairs that satisfy several equations at the same time.
  Geometrically, each equation is a graph, and the solutions are the
  points where the graphs meet. This picture tells you in advance how
  many solutions to expect, and it is the best check you have.
]

#objectives(
  [Solve linear systems with 2 and 3 unknowns, and recognize 0 or infinitely many solutions],
  [Solve a line–parabola or product system by substitution],
)

// ════════════════════════════════════════════════════════
== Linear Systems <st-linsys>

#check(
  "Linear Systems",
  (
    [Solve: $#system(($2x + y$, $7$), ($x - y$, $2$))$],
    [Solve: $#system(($3x - 2y$, $4$), ($6x - 4y$, $8$))$],
    [Solve: $#system(($x + 2y$, $3$), ($2x + 4y$, $7$))$],
    [Solve: $#system(($x + y + z$, $6$), ($x - y + z$, $2$), ($2x + y - z$, $1$))$],
  ),
  (
    [$x = 3$, $y = 1$],
    [Infinitely many solutions (same line)],
    [No solution (parallel lines)],
    [$x = 1$, $y = 2$, $z = 3$],
  ),
  pass: [Skip to the checkpoint in #goto-first(<st-nonlin>).],
  fail: [Work through this section.],
)

#only-theory[
  A #vocab("system of equations", "Gleichungssystem") is *linear* if
  every unknown appears only to the first power. For two unknowns, each
  equation is a line, so there are exactly three possibilities.
]

#keybox(title: [Linear $2 times 2$ systems: three cases])[
  - The lines *intersect* in one point: *one* solution.
  - The lines are *parallel*: *no* solution. The equations contradict
    each other (for example $0 = 5$).
  - The lines are *the same*: *infinitely many* solutions. One equation
    is a multiple of the other (you get $0 = 0$).
]

#keybox(title: "Two methods")[
  - #vocab("Substitution", "Einsetzungsverfahren"): solve one equation
    for one unknown and put it into the other. Best if an equation is
    already solved, like $y = 2x - 1$.
  - #vocab("Elimination", "Additionsverfahren"): multiply the equations
    (the *whole* equation, both sides) so that one unknown has opposite
    coefficients, then add. Best if both equations are in the form
    $a x + b y = c$.
]

#example(title: "Elimination")[
  Solve $ #system(($2x + 3y$, $12$), ($4x - y$, $10$)) $
  Multiply the second equation by $3$: $12x - 3y = 30$. Adding it to the
  first equation removes $y$: $14x = 42$, so $x = 3$. From the first
  equation, $6 + 3y = 12$, so $y = 2$. Check in *both* equations:
  $2 dot 3 + 3 dot 2 = 12$ and $4 dot 3 - 2 = 10$.
]

#example(title: "Substitution")[
  Solve $ #system(($y$, $2x - 1$), ($3x + 2y$, $12$)) $
  Put $y = 2x - 1$ into the second equation:
  $3x + 2 dot (2x - 1) = 12$, so $7x = 14$ and $x = 2$. Then
  $y = 2 dot 2 - 1 = 3$.
]

#example(title: "No solution, and infinitely many")[
  For $ #system(($x + 2y$, $3$), ($2x + 4y$, $7$)) $ double the first
  equation: $2x + 4y = 6$. That contradicts $2x + 4y = 7$, so there is
  no solution. The lines are parallel.

  For $ #system(($3x - 2y$, $4$), ($6x - 4y$, $8$)) $ the second equation
  is twice the first. Both are the same line, so every point of that
  line is a solution.
]

#example(title: "Three unknowns")[
  Solve $ #system(($x + y + z$, $6$), ($2x - y + z$, $6$), ($x + 3y - z$, $2$)) $
  Eliminate $z$ from two pairs. Adding the first and the third equation
  gives $2x + 4y = 8$, so $x + 2y = 4$. Subtracting the second from the
  first gives $-x + 2y = 0$, so $x = 2y$. Now there are two equations in
  two unknowns: $2y + 2y = 4$, so $y = 1$, $x = 2$, and from the first
  equation $z = 3$. Check in all three equations.
]

#warning[
  *Multiply the whole equation.* If you multiply $x + 2y = 5$ by $2$, the
  right side becomes $10$. Forgetting to multiply the right side is the
  most common elimination mistake. Also, do not stop when one unknown is
  found: you need the other one, and the check must use *every*
  equation.
]

#ex(difficulty: 1, time: "12 min", calculator: false)[
  Solve. Check your answer in both equations.
  #auto-parts(
    2,
    [$ #system(($x + y$, $7$), ($x - y$, $3$)) $],
    [$ #system(($2x + y$, $11$), ($x - y$, $1$)) $],
    [$ #system(($y$, $3x - 4$), ($2x + y$, $11$)) $],
    [$ #system(($4x - 3y$, $-1$), ($2x + y$, $7$)) $],
    [$ #system(($5x + 2y$, $1$), ($3x - 4y$, $11$)) $],
    [$ #system(($x/2 + y/3$, $2$), ($x - y$, $-1$)) $],
  )
][
  #auto-parts(
    2,
    [$x = 5$, $y = 2$],
    [$x = 4$, $y = 3$],
    [$x = 3$, $y = 5$],
    [$x = 2$, $y = 3$],
    [$x = 1$, $y = -2$],
    [Multiply the first equation by $6$: $3x + 2y = 12$. Then
      $x = 2$, $y = 3$.],
  )
]

#ex(
  difficulty: 2,
  time: "8 min",
  calculator: false,
  hints: ([Write both equations in the form $a x + b y = c$ and compare
    their coefficients.],),
)[
  How many solutions does each system have? Decide first, then
  describe the two lines.
  #auto-parts(
    2,
    [$ #system(($2x - y$, $3$), ($6x - 3y$, $9$)) $],
    [$ #system(($x + y$, $4$), ($2x + 2y$, $9$)) $],
    [$ #system(($x - y$, $1$), ($x + y$, $5$)) $],
    [$ #system(($y$, $2x + 1$), ($y$, $2x - 3$)) $],
  )
][
  #auto-parts(
    2,
    [Infinitely many: the second equation is $3$ times the first (same
      line).],
    [None: doubling the first gives $2x + 2y = 8 != 9$ (parallel
      lines).],
    [One solution, $x = 3$, $y = 2$ (the lines intersect).],
    [None: the lines have the same slope $2$ but different
      intercepts (parallel).],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Three students solved a system. For each one, decide whether the work
  is correct. If it is wrong, name the mistake and give the correct
  result.
  #auto-parts(
    1,
    [Pia: $x + y = 5$ and $2x + y = 8$. Subtracting the first from the
      second gives $x = 3$, then $y = 2$.],
    [Omar: $x + 2y = 5$ and $3x - y = 8$. Multiply the second by $2$:
      $6x - 2y = 8$. Adding gives $7x = 13$.],
    [Nina: $2x + 4y = 6$ and $x + 2y = 3$. Subtracting twice the second
      from the first gives $0 = 0$, so there is no solution.],
  )
][
  #auto-parts(
    1,
    [Correct. Check: $3 + 2 = 5$ and $6 + 2 = 8$.],
    [Wrong. Omar did not multiply the right side: it must be $16$, not
      $8$. Then $7x = 21$, so $x = 3$ and $y = 1$.],
    [Wrong. $0 = 0$ is always true, so the equations describe the same
      line. There are infinitely many solutions.],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Set up a system and solve it.
  #auto-parts(
    1,
    [Two numbers have the sum $25$ and the difference $7$. Find them.],
    [A theater sells $20$ tickets for CHF $205$. Adult tickets cost
      CHF $12$, child tickets CHF $7$. How many of each were sold?],
  )
][
  #auto-parts(
    1,
    [$x + y = 25$ and $x - y = 7$ give $x = 16$ and $y = 9$.],
    [With $a$ adults and $c$ children: $a + c = 20$ and
      $12a + 7c = 205$. Substituting $c = 20 - a$ gives $5a + 140 = 205$,
      so $a = 13$ and $c = 7$. Check: $156 + 49 = 205$.],
  )
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  Solve. Check in all three equations.
  #auto-parts(
    1,
    [$ #system(($x + y + z$, $9$), ($x - y + z$, $3$), ($x + y - z$, $5$)) $],
    [$ #system(($2x + y - z$, $0$), ($x - y + 2z$, $9$), ($3x + 2y + z$, $7$)) $],
  )
][
  #auto-parts(
    1,
    [The first minus the second gives $2y = 6$, so $y = 3$. The first
      minus the third gives $2z = 4$, so $z = 2$. Then $x = 4$.],
    [$x = 2$, $y = -1$, $z = 3$. Check: $4 - 1 - 3 = 0$,
      $2 + 1 + 6 = 9$, $6 - 2 + 3 = 7$.],
  )
]

#ex(difficulty: 3, time: "10 min", calculator: false)[
  A parameter decides the number of solutions.
  #auto-parts(
    1,
    [For which $a$ does $ #system(($x + y$, $2$), ($2x + a dot y$, $4$)) $
      have one solution, none, or infinitely many?],
    [For which $a$ does $ #system(($2x - y$, $3$), ($4x - 2y$, $a$)) $
      have none, or infinitely many?],
  )
][
  #auto-parts(
    1,
    [Subtract twice the first equation from the second:
      $(a - 2) dot y = 0$. If $a != 2$: $y = 0$, $x = 2$, exactly one
      solution. If $a = 2$: the equations are identical, infinitely
      many. There is never "no solution" here.],
    [The second equation minus twice the first gives $0 = a - 6$. If
      $a = 6$: infinitely many solutions. If $a != 6$: no solution.],
  )
]

#keybox(title: "Check with your calculator")[
  #only-basic[
    *TI-30X Pro MathPrint.* *sys-solv* solves systems of $2$ or $3$
    linear equations. You choose the size, then enter the coefficients
    of each equation, including the right-hand sides. Write each
    equation in the form $a x + b y = c$ first. If there is no unique
    solution, the calculator does not give one: it shows a message
    instead. Then you decide by hand whether the system has no
    solution or infinitely many. // VERIFY on device: menu path and message
  ]
  #only-high[
    *TI-Nspire CAS.* `solve({2·x+3·y=12,4·x-y=10},{x,y})` solves a
    system. `linSolve` and `rref` of the augmented matrix work too.
    For infinitely many solutions, CAS typically answers with a free
    parameter (such as `c1`). Read it critically: it describes a whole
    line of solutions. For no solution it answers `false`.
    // VERIFY on device: output forms and parameter names
  ]
]

#ex(level: "basic", difficulty: 1, time: "8 min", calculator: true)[
  Use *sys-solv*.
  #auto-parts(
    1,
    [Solve $2x + 3y = 12$, $4x - y = 10$.],
    [Solve $x + y + z = 9$, $x - y + z = 3$, $x + y - z = 5$.],
    [Enter $x + 2y = 3$, $2x + 4y = 7$. What does the calculator do?
      What does that mean?],
  )
][
  #auto-parts(
    1,
    [$x = 3$, $y = 2$.],
    [$x = 4$, $y = 3$, $z = 2$.],
    [It does not return a solution (a message appears). The lines are
      parallel: no solution.],  // VERIFY on device
  )
]

#ex(level: "high", difficulty: 1, time: "8 min", calculator: true)[
  Use your TI-Nspire CAS.
  #auto-parts(
    1,
    [Solve $2x + 3y = 12$, $4x - y = 10$ with `solve`.],
    [Solve $x + y + z = 9$, $x - y + z = 3$, $x + y - z = 5$.],
    [Solve $3x - 2y = 4$, $6x - 4y = 8$. What does the output mean?],
  )
][
  #auto-parts(
    1,
    [$x = 3$ and $y = 2$.],
    [$x = 4$, $y = 3$, $z = 2$.],
    [The answer contains a free parameter: every point of the line
      $3x - 2y = 4$ is a solution (infinitely many).
],  // VERIFY on device
  )
]

#check(
  kind: "Stage check",
  "Linear Systems",
  (
    [Solve: $#system(($x + 2y$, $8$), ($3x - y$, $3$))$],
    [Solve: $#system(($2x - y$, $1$), ($4x - 2y$, $5$))$],
    [Solve: $#system(($2x + 4y$, $6$), ($x + 2y$, $3$))$],
    [Solve: $#system(($x + y + z$, $3$), ($2x - y + z$, $6$), ($x + 2y - z$, $-4$))$],
  ),
  (
    [$x = 2$, $y = 3$],
    [No solution (parallel lines)],
    [Infinitely many solutions (same line)],
    [$x = 1$, $y = -1$, $z = 3$],
  ),
  pass: [Continue with #goto-first(<st-nonlin>).],
  fail: [Find the example or exercise that matches your mistake and redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════
== Nonlinear Systems <st-nonlin>

#check(
  "Nonlinear Systems",
  (
    [Solve: $#system(($y$, $x + 1$), ($y$, $x^2 - 1$))$],
    [Solve: $#system(($x + y$, $5$), ($x dot y$, $6$))$],
    [Solve: $#system(($y$, $x^2$), ($y$, $-1$))$],
    [Solve: $#system(($y$, $x - 3$), ($y$, $x^2 - 2x - 3$))$],
  ),
  (
    [$(2, 3)$ and $(-1, 0)$],
    [$(2, 3)$ and $(3, 2)$],
    [No solution],
    [$(0, -3)$ and $(3, 0)$],
  ),
  pass: [Skip to the checkpoint in #goto-first(<st-power>).],
  fail: [Work through this section.],
)

#only-theory[
  When at least one equation is not linear, the system is
  #vocab("nonlinear", "nichtlinear"). The graphs are no longer two lines.
  A line and a parabola can meet in $0$, $1$, or $2$ points. The
  strategy is the one you know: get down to one equation in one
  unknown.
]

#keybox(title: "Solving a nonlinear system")[
  + *Solve one equation for one unknown* (or find one that is already
    solved, like $y = x^2$).
  + *Substitute* it into the other equation. You get one equation in
    one unknown, often a quadratic.
  + *Solve it.* Then get the *other* unknown for every solution, using
    the simplest equation.
  + *Write each solution as a pair* $(x, y)$ and check it in *both*
    original equations.
]

#example(title: "Line and parabola")[
  Solve $ #system(($y$, $x + 1$), ($y$, $x^2 - 1$)) $
  Equate: $x + 1 = x^2 - 1$, so $x^2 - x - 2 = 0$ and $x = 2$ or
  $x = -1$. Then $y = x + 1$ gives the points $(2, 3)$ and $(-1, 0)$.
]

#example(title: "Sum and product")[
  Solve $ #system(($x + y$, $5$), ($x dot y$, $6$)) $
  From the first equation, $y = 5 - x$. Then $x dot (5 - x) = 6$, so
  $x^2 - 5x + 6 = 0$ and $x = 2$ or $x = 3$. The pairs are $(2, 3)$ and
  $(3, 2)$.
]

#example(title: "One solution, or none")[
  For $y = x^2 + 1$ and $y = 2x$: $x^2 - 2x + 1 = 0$, so $x = 1$ and the
  only common point is $(1, 2)$. The line *touches* the parabola.

  For $y = x^2 + 2$ and $y = x - 1$: $x^2 - x + 3 = 0$ has
  $D = 1 - 12 < 0$. The graphs do not meet: no solution.
]

#warning[
  *A solution is a pair, not a single number.* After finding the
  $x$-values, you are only half done. Compute the $y$-value for _each_
  $x$, using the simplest equation, and write the pairs. Do not mix up
  the pairs: $x = 2$ goes with $y = 3$ in the sum-and-product example,
  not with $y = 2$.
]

#ex(difficulty: 1, time: "10 min", calculator: false)[
  Find the intersection points of the line and the parabola.
  #auto-parts(
    2,
    [$y = x + 2$ and $y = x^2$],
    [$y = 2x + 3$ and $y = x^2$],
    [$y = x^2 - 4$ and $y = 0$],
    [$y = x^2 + 1$ and $y = 2$],
  )
][
  #auto-parts(
    2,
    [$x^2 - x - 2 = 0$: points $(2, 4)$ and $(-1, 1)$],
    [$x^2 - 2x - 3 = 0$: points $(3, 9)$ and $(-1, 1)$],
    [$x^2 = 4$: points $(2, 0)$ and $(-2, 0)$],
    [$x^2 = 1$: points $(1, 2)$ and $(-1, 2)$],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Solve. Write the solutions as pairs.
  #auto-parts(
    1,
    [$ #system(($x + y$, $7$), ($x dot y$, $12$)) $],
    [$ #system(($x - y$, $2$), ($x dot y$, $15$)) $],
    [$ #system(($x + y$, $1$), ($x dot y$, $-6$)) $],
  )
][
  #auto-parts(
    1,
    [$x^2 - 7x + 12 = 0$: $(3, 4)$ and $(4, 3)$],
    [$y = x - 2$, so $x^2 - 2x - 15 = 0$: $(5, 3)$ and $(-3, -5)$],
    [$y = 1 - x$, so $x^2 - x - 6 = 0$: $(3, -2)$ and $(-2, 3)$],
  )
]

#ex(
  difficulty: 2,
  time: "6 min",
  calculator: false,
  hints: ([Equate the two expressions for $y$ and look at the
    discriminant of the quadratic.],),
)[
  How many common points do the graphs have? Do not find the points.
  #auto-parts(
    2,
    [$y = x^2$ and $y = 2x - 1$],
    [$y = x^2 - 1$ and $y = x + 5$],
    [$y = x^2 + 1$ and $y = x - 2$],
    [$y = x^2$ and $y = -4$],
  )
][
  #auto-parts(
    2,
    [$x^2 - 2x + 1 = 0$, $D = 0$: one point (the line touches the
      parabola)],
    [$x^2 - x - 6 = 0$, $D = 25 > 0$: two points],
    [$x^2 - x + 3 = 0$, $D = -11 < 0$: no point],
    [$x^2 = -4$ has no real solution: no point],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Three students solved a system. For each one, decide whether the work
  is correct. If it is wrong, name the mistake and give the correct
  result.
  #auto-parts(
    1,
    [Pia: $y = x + 1$ and $y = x^2 - 1$. Then $x^2 - x - 2 = 0$, so
      $x = 2$ or $x = -1$. Answer: $x = 2$ or $x = -1$.],
    [Omar: $x + y = 5$ and $x dot y = 6$. Then $x^2 - 5x + 6 = 0$, so
      $x = 2$ and $y = 3$. Answer: $(2, 3)$.],
    [Nina: $y = x^2$ and $y = 2x - 1$. Then $x^2 - 2x + 1 = 0$, so
      $x = 1$ and $y = 1$. The line touches the parabola at $(1, 1)$.],
  )
][
  #auto-parts(
    1,
    [Incomplete. Pia gave only the $x$-values. The solutions are pairs:
      $(2, 3)$ and $(-1, 0)$.],
    [Wrong. Omar stopped at one solution. The quadratic also gives
      $x = 3$, so $(3, 2)$ is a solution too.],
    [Correct. The discriminant is $0$, so there is exactly one common
      point.],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Set up a system and solve it.
  #auto-parts(
    1,
    [A rectangle has perimeter $18$ cm and area $20 " cm"^2$. Find its
      sides.],
    [Are there two numbers with sum $10$ and product $30$? Explain.],
  )
][
  #auto-parts(
    1,
    [$x + y = 9$ and $x dot y = 20$ give $x^2 - 9x + 20 = 0$, so the
      sides are $4$ cm and $5$ cm.],
    [$x + y = 10$ and $x dot y = 30$ give $x^2 - 10x + 30 = 0$ with
      $D = 100 - 120 < 0$. No such real numbers exist.],
  )
]

#ex(difficulty: 3, time: "12 min", calculator: false)[
  Find all common points.
  #auto-parts(
    1,
    [$y = x^3$ and $y = x$],
    [$y = x^2 - 2x - 3$ and $y = -x^2 + 4x + 5$],
    [$y = 1/x$ and $y = x$],
  )
][
  #auto-parts(
    1,
    [$x^3 - x = x dot (x - 1) dot (x + 1) = 0$: points $(0, 0)$,
      $(1, 1)$, $(-1, -1)$.],
    [$x^2 - 2x - 3 = -x^2 + 4x + 5$ gives $2x^2 - 6x - 8 = 0$, so
      $x^2 - 3x - 4 = 0$ and $x = 4$ or $x = -1$. Points: $(4, 5)$ and
      $(-1, 0)$.],
    [$1/x = x$ with $x != 0$ gives $x^2 = 1$: points $(1, 1)$ and
      $(-1, -1)$.],
  )
]

#keybox(title: "Check with your calculator")[
  #only-basic[
    *TI-30X Pro MathPrint.* *sys-solv* works only for linear systems.
    For a nonlinear system, substitute by hand to get one equation, solve
    that with *poly-solv*, and then find the second unknown for each
    solution by hand. // VERIFY on device
  ]
  #only-high[
    *TI-Nspire CAS.* `solve({y=x+2,y=x^2},{x,y})` returns both pairs.
    Check that every pair is listed with both coordinates. If CAS does
    not find a solution, try `nSolve` with a start value, which returns
    one numerical pair near it. For a system without a real solution,
    `solve` answers `false`. // VERIFY on device
  ]
]

#ex(level: "basic", difficulty: 2, time: "8 min", calculator: true)[
  Solve $y = x + 2$, $y = x^2$.
  #auto-parts(
    1,
    [Substitute and use *poly-solv* on the quadratic in $x$.],
    [Compute $y$ for each $x$. Write the two points.],
  )
][
  #auto-parts(
    1,
    [$x^2 - x - 2 = 0$ has the solutions $x = 2$ and $x = -1$.],
    [$y = x + 2$ gives $(2, 4)$ and $(-1, 1)$.],
  )
]

#ex(level: "high", difficulty: 2, time: "8 min", calculator: true)[
  Use your TI-Nspire CAS.
  #auto-parts(
    1,
    [Solve $y = x + 2$, $y = x^2$ with `solve`. How is each solution
      written?],
    [Solve $y = x^2$, $y = 2x - 1$. How many solutions are there?],
    [Solve $y = x^2 + 2$, $y = x - 1$. What does CAS answer?],
  )
][
  #auto-parts(
    1,
    [Two solutions: $x = -1$ and $y = 1$, or $x = 2$ and $y = 4$.],
    [One solution, $x = 1$ and $y = 1$ (the line touches the parabola).],
    [`false`: there is no real solution.],  // VERIFY on device
  )
]

#check(
  kind: "Stage check",
  "Nonlinear Systems",
  (
    [Solve: $#system(($y$, $2x - 1$), ($y$, $x^2 - 4$))$],
    [Solve: $#system(($x - y$, $1$), ($x dot y$, $12$))$],
    [Solve: $#system(($y$, $x^2 + 1$), ($y$, $2x$))$],
    [Solve: $#system(($y$, $x^2 + 2$), ($y$, $x - 1$))$],
  ),
  (
    [$(-1, -3)$ and $(3, 5)$],
    [$(-3, -4)$ and $(4, 3)$],
    [$(1, 2)$],
    [No solution],
  ),
  pass: [Continue with #goto-first(<st-power>).],
  fail: [Find the example or exercise that matches your mistake and redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════
#print-check-key()

#print-hints()
#print-vocab()
