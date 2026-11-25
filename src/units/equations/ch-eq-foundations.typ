// ch-eq-foundations.typ — Foundations (equations booklet)
//
// COMPLETE (Turn 2). Both stages: checkpoint, theory, exercises
// (ramped, with error analysis), calculator block, stage check.
// Misconception work: dividing by x, equivalence, domain, reciprocal.
//
// TARGET MISCONCEPTIONS (see stage notes)
//   What “Solve” Means: equivalence; solution count; x²=4 vs x=2
// STATUS
//   done:  skeleton, checkpoints, stage checks; THIS FILE COMPLETE (answers verified
//          numerically; SymPy could not be installed in the drafting
//          sandbox, so a numeric root scan + substitution was used)
//   to do: visual check; calculator menu paths marked VERIFY on device.
//
// NEEDS A VISUAL CHECK — not compiled (no Typst in the drafting
// environment): route boxes, goto-first links, yr() cells in checks.

#import "../../common/preamble.typ": *
#import "config.typ": *
#show: chapter-template.with(title: "Foundations")
#let ex = exercise.with(chapter: "Equations")
#let check = check.with(ex: ex)

= Foundations

#only-theory[
  Before you learn any method, ask two questions. What does it mean to
  _solve_ an equation? And how do you know your answer is right? Most
  mistakes in this booklet come from an unclear answer to one of them.
  This chapter settles both, and it also covers rearranging formulas,
  which is solving an equation in which the "numbers" are letters.
]

#objectives(
  [What “solve” means and how to check a solution],
  [Rearrange a formula for any variable],
)

// ════════════════════════════════════════════════════════
== What “Solve” Means <st-solve>

#check(
  "What “Solve” Means",
  (
    [Is $x = 3$ a solution of $2x^2 - 5x - 3 = 0$?],
    [How many real solutions does $x^2 + 4 = 0$ have?],
    [Solve $3 dot (x - 2) = 2x + 5$.],
    [Are the equations $x = 2$ and $x^2 = 4$ equivalent? Explain briefly.],
  ),
  (
    [Yes: $2 dot 9 - 15 - 3 = 0$],
    [None],
    [$x = 11$],
    [No: $x = -2$ also solves the second one],
  ),
  pass: [Skip to the checkpoint in #goto-first(<st-rearr>).],
  fail: [Work through this section.],
)

#exploration(title: "Which steps are safe?")[
  Start with the equation $x = 2$. It has exactly one solution. Now
  change it step by step. After each step, find _all_ solutions of the
  new equation.

  + Add $3$ to both sides: $x + 3 = 5$.
  + Multiply both sides by $4$: $4x = 8$.
  + Square both sides: $x^2 = 4$.
  + Multiply both sides by $x$: $x^2 = 2x$.

  Which steps kept the solution set the same? Which steps added a
  solution? Can you say why?
]

#definition(title: "Solution and solution set")[
  A #vocab("solution", "Lösung") of an #vocab("equation", "Gleichung")
  is a value of the #vocab("unknown", "Unbekannte") that makes both
  sides equal. The #vocab("solution set", "Lösungsmenge") $L$ contains
  _all_ solutions. It can contain one number, several numbers, or no
  number at all. For example, $L = \{2\}$ for $x + 1 = 3$, and
  $L = \{ \}$ for $x^2 = -4$ (no real solution).

  To #vocab("solve", "lösen") an equation means to find its solution
  set. One solution is not enough if there are more.
]

#only-theory[
  The exploration shows the key idea. Steps 1 and 2 are
  #vocab("equivalent transformations", "Äquivalenzumformungen"). They
  keep the solution set exactly as it was. Step 3 added the solution
  $-2$, and step 4 added the solution $0$. Both steps are fine to
  _use_, but afterwards you must check every solution you found.
]

#keybox(title: "Equivalent transformations")[
  These steps never change the solution set:
  - add or subtract the *same term* on both sides,
  - multiply or divide both sides by the *same number that is not zero*.

  These steps can change the solution set. Use them carefully:
  - squaring both sides (can add solutions),
  - multiplying by an expression that contains $x$ (can add solutions),
  - dividing by an expression that contains $x$ (can _lose_ solutions).
]

#example(title: "Solve and check")[
  Solve $3 dot (x - 2) = 2x + 5$.
  $ 3 dot (x - 2) &= 2x + 5 \
    3x - 6 &= 2x + 5 \
    x &= 11 $
  *Check by substituting.* Left side: $3 dot (11 - 2) = 27$. Right side:
  $2 dot 11 + 5 = 27$. Both sides agree, so $L = \{11\}$.
]

#warning[
  *Never divide by an expression that contains the unknown.* Look at
  $x^2 = 3x$. Dividing both sides by $x$ gives $x = 3$, and the
  solution $x = 0$ is gone. Instead, move everything to one side and
  factor: $x^2 - 3x = 0$, so $x dot (x - 3) = 0$. Now both solutions,
  $0$ and $3$, are visible. You will practice this in
  #goto-first(<st-product>).
]

#keybox(title: "Three ways to check an answer")[
  + *Substitute.* Put each solution back into the _original_ equation.
  + *Estimate.* Is the size of the answer reasonable?
  + *Sketch.* Draw the left side and the right side as graphs. The
    number of intersection points is the number of solutions. Decide
    "how many solutions?" _before_ you calculate.
]

#ex(difficulty: 1, time: "6 min", calculator: false)[
  Which of the numbers is a solution of the equation? Decide by
  substituting.
  #auto-parts(
    3,
    [$x = 2$ in $2x^2 - x - 6 = 0$],
    [$x = -3/2$ in $2x^2 - x - 6 = 0$],
    [$x = 3$ in $2x^2 - x - 6 = 0$],
    [$x = -1$ in $x^3 + x^2 - x - 1 = 0$],
    [$x = 1/2$ in $4x^2 - 1 = 0$],
    [$x = 2$ in $sqrt(x + 2) = x$],
  )
][
  #auto-parts(
    3,
    [Yes: $2 dot 4 - 2 - 6 = 0$.],
    [Yes: $2 dot 9/4 + 3/2 - 6 = 0$.],
    [No: $2 dot 9 - 3 - 6 = 9 != 0$.],
    [Yes: $-1 + 1 + 1 - 1 = 0$.],
    [Yes: $4 dot 1/4 - 1 = 0$.],
    [Yes: $sqrt(4) = 2$.],
  )
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Solve each equation and check your answer by substituting.
  #auto-parts(
    2,
    [$5x - 7 = 3x + 9$],
    [$4 dot (x - 1) = 2x + 10$],
    [$3 - 2 dot (x - 4) = x + 5$],
    [$x/3 + 1 = x/2$],
  )
][
  #auto-parts(
    2,
    [$x = 8$. Check: $5 dot 8 - 7 = 33 = 3 dot 8 + 9$.],
    [$x = 7$. Check: $4 dot 6 = 24 = 2 dot 7 + 10$.],
    [$x = 2$. Check: $3 - 2 dot (-2) = 7 = 2 + 5$.],
    [$x = 6$ (multiply by $6$: $2x + 6 = 3x$). Check: $2 + 1 = 3 = 6/2$.],
  )
]

#ex(
  difficulty: 2,
  time: "8 min",
  calculator: false,
  hints: (
    [Substitute each equation's solutions back into the other one, or
      compare the solution sets.],
  ),
)[
  Are the two equations equivalent, that is, do they have the same
  solution set? If not, say which solutions differ.
  #auto-parts(
    2,
    [$x - 3 = 0$ and $x^2 - 3x = 0$],
    [$2x + 1 = 7$ and $x = 3$],
    [$x = -3$ and $x^2 = 9$],
    [$1/x = 1/2$ and $x = 2$],
    [$sqrt(x) = 3$ and $x = 9$],
    [$sqrt(x) = -3$ and $x = 9$],
  )
][
  #auto-parts(
    2,
    [No. The second also has $x = 0$.],
    [Yes. Both have $L = \{3\}$.],
    [No. The second also has $x = 3$.],
    [Yes. Both have $L = \{2\}$.],
    [Yes. Both have $L = \{9\}$.],
    [No. The first has no solution, the second has $x = 9$. A square
      root is never negative.],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Three students solved an equation. For each one, decide whether the
  work is correct. If it is wrong, name the mistake and give the correct
  solution set.
  #auto-parts(
    1,
    [Pia: $3 dot (x - 2) = 2x + 5 #h(0.5em) arrow.r.double #h(0.5em)
      3x - 2 = 2x + 5 #h(0.5em) arrow.r.double #h(0.5em) x = 7$],
    [Omar: $x^2 = 3x #h(0.5em) arrow.r.double #h(0.5em) x = 3$],
    [Nina: $x - 1 = 4 - x #h(0.5em) arrow.r.double #h(0.5em) 2x = 5
      #h(0.5em) arrow.r.double #h(0.5em) x = 5/2$],
  )
][
  #auto-parts(
    1,
    [Wrong. Pia multiplied only the first term in the bracket. Correct:
      $3x - 6 = 2x + 5$, so $x = 11$.],
    [Wrong. Omar divided by $x$ and lost the solution $x = 0$. Correct:
      $x dot (x - 3) = 0$, so $L = \{0, 3\}$.],
    [Correct. Check: $5/2 - 1 = 3/2$ and $4 - 5/2 = 3/2$.],
  )
]

#ex(difficulty: 2, time: "6 min", calculator: false)[
  Before you solve, state for which values of $x$ each equation makes
  sense (the #vocab("domain", "Definitionsmenge")). Do not solve.
  #auto-parts(
    3,
    [$1/x + 1/(x - 1) = 2$],
    [$sqrt(2x - 4) = 3$],
    [$3/(x^2 - 9) = 1$],
  )
][
  #auto-parts(
    3,
    [$x != 0$ and $x != 1$],
    [$x >= 2$, because $2x - 4 >= 0$],
    [$x != 3$ and $x != -3$],
  )
]

#ex(difficulty: 3, time: "10 min", calculator: false)[
  Here is a "proof" that $2 = 1$. Find the step that is not allowed, and
  explain why it is not allowed.
  #auto-parts(
    1,
    [Let $a = b$, with $a != 0$.],
    [Multiply by $a$: $a^2 = a dot b$.],
    [Subtract $b^2$: $a^2 - b^2 = a dot b - b^2$.],
    [Factor: $(a + b) dot (a - b) = b dot (a - b)$.],
    [Divide by $(a - b)$: $a + b = b$.],
    [Since $a = b$, this says $2b = b$, so $2 = 1$.],
  )
][
  The step "divide by $(a - b)$" is not allowed. Since $a = b$, we have
  $a - b = 0$, and dividing by zero is not defined. Hiding a zero in an
  expression with letters is the same danger as dividing by $x$ in
  $x^2 = 3x$: the divisor can be zero.
]

#keybox(title: "Check with your calculator")[
  #only-basic[
    *TI-30X Pro MathPrint.* The *num-solv* function solves an equation
    numerically. You enter the equation and a *start value*, and it
    returns *one* solution, the one near the start value. A different
    start value can give a different solution, and the calculator does
    not tell you that more solutions exist. For $x^2 = 9$, one start
    value can give $3$ and another can give $-3$. // VERIFY on device
    So always ask yourself: _are there more?_ To check a candidate, put
    it into both sides of the original equation and compare.
    // VERIFY on device: exact menu path to num-solv
  ]
  #only-high[
    *TI-Nspire CAS.* Use *solve* (Menu, Algebra, Solve) to get exact
    solutions, for example `solve(x^2=3·x,x)`. With the *"with"
    operator* `|` you can test a candidate: `3·(x-2)=2·x+5 | x=11`
    should return `true`. Read the output critically. The answer
    `false` from `solve` means "no real solution", not an error. For
    the complex solutions, use *cSolve* (Menu, Algebra, Complex).
    // VERIFY on device: menu names, true/false output of the | operator
  ]
]

#ex(level: "basic", difficulty: 1, time: "8 min", calculator: true)[
  Use *num-solv* on your calculator.
  #auto-parts(
    2,
    [Solve $5x - 7 = 3x + 9$.],
    [Solve $x^2 = 9$. Find _both_ solutions by changing the start value.],
    [Evaluate $2x^2 - x - 6$ for $x = 2$. What does the result tell you?],
    [Try $x^2 + 4 = 0$. What does the calculator do? What does that mean?],
  )
][
  #auto-parts(
    2,
    [$x = 8$.],
    [$x = 3$ and $x = -3$ (for example start values $1$ and $-1$).],
    [The value is $0$, so $x = 2$ is a solution.],
    [No solution is found (an error message, or a meaningless number).
      Check the result with a sketch: $x^2 + 4 = 0$ has no real
      solution. // VERIFY on device
    ],
  )
]

#ex(level: "high", difficulty: 1, time: "8 min", calculator: true)[
  Use your TI-Nspire CAS.
  #auto-parts(
    2,
    [Solve $5x - 7 = 3x + 9$ with `solve`.],
    [Solve $x^2 = 3x$ with `solve`. How many solutions do you get?],
    [Use the `|` operator to test $x = 3$ in $2x^2 - x - 6 = 0$.],
    [Compare `solve(x^2+4=0,x)` with `cSolve(x^2+4=0,x)`. What does each
      one say?],
  )
][
  #auto-parts(
    2,
    [$x = 8$.],
    [Two solutions: $x = 0$ or $x = 3$.],
    [The result is `false`: $x = 3$ is not a solution. (Check by hand:
      $2 dot 9 - 3 - 6 = 9$.)],
    [`solve` says `false`: no real solution. `cSolve` gives
      $x = 2i$ or $x = -2i$.],
  )
]

#check(
  kind: "Stage check",
  "What “Solve” Means",
  (
    [Is $x = -2$ a solution of $x^3 + 3x^2 - 4 = 0$?],
    [How many real solutions does $(x - 1)^2 + 3 = 0$ have?],
    [Solve $5 - 2 dot (x + 1) = x - 9$.],
    [Is $x dot (x - 5) = 0$ equivalent to $x = 5$? Explain briefly.],
  ),
  (
    [Yes: $-8 + 12 - 4 = 0$],
    [None],
    [$x = 4$],
    [No: $x = 0$ also solves it],
  ),
  pass: [Continue with #goto-first(<st-rearr>).],
  fail: [Find the example or exercise that matches your mistake and redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════
== Rearranging Formulas <st-rearr>

#check(
  "Rearranging Formulas",
  (
    [Solve $A = 1/2 dot g dot h$ for $h$.],
    [Solve $v = v_0 + a dot t$ for $t$.],
    [Solve $1/R = 1/R_1 + 1/R_2$ for $R_2$.],
    [Solve $V = pi dot r^2 dot h$ for $r$ (with $r > 0$).],
  ),
  (
    [$h = (2A)/g$],
    [$t = (v - v_0)/a$],
    [$R_2 = (R dot R_1)/(R_1 - R)$],
    [$r = sqrt(V/(pi dot h))$],
  ),
  pass: [Skip to the checkpoint in #goto-first(<st-product>).],
  fail: [Work through this section.],
)

#only-theory[
  A formula such as $A = 1/2 dot g dot h$ is an equation with several
  letters. To #vocab("solve a formula for a variable",
    "eine Formel nach einer Variablen auflösen") means to get that variable alone on one
  side. You do exactly what you do with numbers. The other letters just
  behave like numbers that you do not know yet.
]

#keybox(title: "Rearranging a formula")[
  + Find the variable you want, and see what is done to it.
  + Undo those operations in the _reverse_ order, doing the same to
    both sides.
  + If the variable appears more than once, collect those terms on one
    side and *factor* it out.
  + Check with numbers: pick values that fit the original formula and
    test the result.
]

#example(title: "Undo the operations in reverse order")[
  Solve $v = v_0 + a dot t$ for $t$. First $a dot t$ is added to
  $v_0$. Then it is multiplied. So undo the addition first, then the
  multiplication:
  $ v - v_0 &= a dot t \
    (v - v_0)/a &= t $
  This needs $a != 0$.
]

#example(title: "A root: keep the positive solution")[
  Solve $V = pi dot r^2 dot h$ for $r$, where $r > 0$ is a radius.
  $ V/(pi dot h) = r^2 quad arrow.r.double quad
    r = sqrt(V/(pi dot h)). $
  The equation $r^2 = c$ has two solutions, $plus.minus sqrt(c)$, but
  a radius cannot be negative.
]

#example(title: "The variable appears on both sides")[
  Solve $a dot x + b = c dot x + d$ for $x$. Collect all the terms with
  $x$ on one side, then factor $x$ out:
  $ a dot x - c dot x &= d - b \
    x dot (a - c) &= d - b \
    x &= (d - b)/(a - c). $
  This needs $a != c$. If $a = c$, the $x$-terms cancel and the formula
  breaks down.
]

#example(title: "A formula with fractions")[
  Solve $1/R = 1/R_1 + 1/R_2$ for $R_2$. First isolate $1/R_2$:
  $ 1/R_2 = 1/R - 1/R_1 = (R_1 - R)/(R dot R_1). $
  Now take the reciprocal of _both_ sides:
  $ R_2 = (R dot R_1)/(R_1 - R). $
  Check with $R_1 = 6$ and $R = 4$: then $R_2 = (4 dot 6)/(6 - 4) = 12$,
  and indeed $1/6 + 1/12 = 1/4$.
]

#warning[
  *A reciprocal turns the whole side upside down, not each term.* From
  $1/R_2 = 1/R - 1/R_1$ you cannot write $R_2 = R - R_1$. First combine
  the right side into one fraction, then flip that fraction.
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Solve each formula for the variable in brackets.
  #auto-parts(
    3,
    [$F = m dot a$ #h(0.5em) $[a]$],
    [$P = 2a + 2b$ #h(0.5em) $[b]$],
    [$C = 2 pi dot r$ #h(0.5em) $[r]$],
    [$s = v dot t$ #h(0.5em) $[t]$],
    [$y = m dot x + q$ #h(0.5em) $[x]$],
    [$U = R dot I$ #h(0.5em) $[R]$],
  )
][
  #auto-parts(
    3,
    [$a = F/m$],
    [$b = (P - 2a)/2 = P/2 - a$],
    [$r = C/(2 pi)$],
    [$t = s/v$],
    [$x = (y - q)/m$],
    [$R = U/I$],
  )
]

#ex(
  difficulty: 2,
  time: "12 min",
  calculator: false,
  hints: (
    [In (f), collect the terms with $x$ on one side first.],
    [For a square, remember the sign: the variable is positive.],
  ),
)[
  Solve each formula for the variable in brackets. All variables are
  positive.
  #auto-parts(
    2,
    [$A = (a + b)/2 dot h$ #h(0.5em) $[h]$],
    [$A = (a + b)/2 dot h$ #h(0.5em) $[b]$],
    [$E = 1/2 dot m dot v^2$ #h(0.5em) $[v]$],
    [$c^2 = a^2 + b^2$ #h(0.5em) $[a]$],
    [$T = 2 pi dot sqrt(l/g)$ #h(0.5em) $[l]$],
    [$a dot x + b = c dot x + d$ #h(0.5em) $[x]$],
  )
][
  #auto-parts(
    2,
    [$h = (2A)/(a + b)$],
    [$b = (2A)/h - a$],
    [$v = sqrt((2E)/m)$],
    [$a = sqrt(c^2 - b^2)$],
    [$l = (g dot T^2)/(4 pi^2)$],
    [$x = (d - b)/(a - c)$, for $a != c$],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: true)[
  Rearrange first, then insert the numbers.
  #auto-parts(
    1,
    [Resistors in parallel: $1/R = 1/R_1 + 1/R_2$. With $R = 4 " " Omega$
      and $R_1 = 6 " " Omega$, find $R_2$.],
    [A car accelerates uniformly from rest: $s = 1/2 dot a dot t^2$. For
      $s = 100 " m"$ and $a = 2 " m/s"^2$, find the time $t$.],
    [Kinetic energy: $E = 1/2 dot m dot v^2$. For $E = 400 " J"$ and
      $m = 2 " kg"$, find the speed $v$.],
  )
][
  #auto-parts(
    1,
    [$R_2 = (R dot R_1)/(R_1 - R) = 24/2 = 12 " " Omega$.],
    [$t = sqrt((2s)/a) = sqrt(100) = 10 " s"$.],
    [$v = sqrt((2E)/m) = sqrt(400) = 20 " m/s"$.],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Three students solved a formula. For each one, decide whether the
  work is correct. If it is wrong, name the mistake and give the correct
  result.
  #auto-parts(
    1,
    [Pia: $v = v_0 + a dot t$ #h(0.5em) $arrow.r.double$ #h(0.5em)
      $t = v - v_0 + a$],
    [Omar: $v = v_0 + a dot t$ #h(0.5em) $arrow.r.double$ #h(0.5em)
      $t = (v - v_0)/a$],
    [Nina: $1/R = 1/R_1 + 1/R_2$ #h(0.5em) $arrow.r.double$ #h(0.5em)
      $R_2 = 1/R - 1/R_1$],
  )
][
  #auto-parts(
    1,
    [Wrong. Pia moved $a$ across as a term, but $a$ is a _factor_ of
      $t$. Correct: $t = (v - v_0)/a$.],
    [Correct. The addition is undone first, then the multiplication.],
    [Wrong. Nina forgot to flip the fraction: she found $1/R_2$, not
      $R_2$. Test with $R = 4$, $R_1 = 6$: her formula gives $1/12$, but
      $R_2 = 12$. Correct: $R_2 = (R dot R_1)/(R_1 - R)$.],
  )
]

#ex(difficulty: 3, time: "12 min", calculator: false)[
  Solve for the variable in brackets. State what the letters must
  satisfy.
  #auto-parts(
    1,
    [$(x + a)/(x - a) = b$ #h(0.5em) $[x]$],
    [$x/a + y/b = 1$ #h(0.5em) $[b]$],
  )
][
  #auto-parts(
    1,
    [Multiply by $(x - a)$: $x + a = b dot x - a dot b$. Collect $x$:
      $x dot (1 - b) = -a dot b - a$, so
      $x = (a dot (b + 1))/(b - 1)$, for $b != 1$ and $x != a$.],
    [$y/b = 1 - x/a = (a - x)/a$. Take the reciprocal of both sides:
      $b/y = a/(a - x)$, so $b = (a dot y)/(a - x)$, for $x != a$ and
      $y != 0$.],
  )
]

#keybox(title: "Check with your calculator")[
  #only-basic[
    *TI-30X Pro MathPrint.* The calculator cannot rearrange formulas.
    Use it to *test* your result: choose numbers for the known letters,
    compute the unknown with the original formula and with your
    rearranged formula, and compare. If the two results differ, the
    rearranged formula is wrong. Do not use *num-solv* for this unless
    all but one letter have numbers.
  ]
  #only-high[
    *TI-Nspire CAS.* `solve(V=π·r^2·h,r)` rearranges a formula. Read the
    output critically. For a square, CAS gives _both_ signs, and you
    choose the one that fits the situation. The form of the answer can
    also differ from yours, for example `-R·R1/(R-R1)` instead of
    `R·R1/(R1-R)`. Such answers are equal. Test with numbers to be sure.
    // VERIFY on device: how CAS orders and signs the output
  ]
]

#ex(level: "basic", difficulty: 2, time: "8 min", calculator: true)[
  A cylinder has volume $V = pi dot r^2 dot h$.
  #auto-parts(
    1,
    [For $r = 3$ and $h = 5$, compute $V$ (to $2$ decimals).],
    [Now put that $V$ and $h = 5$ into $r = sqrt(V/(pi dot h))$. What do
      you get? What does this tell you about the formula?],
  )
][
  #auto-parts(
    1,
    [$V = 45 pi approx 141.37$.],
    [$r = 3$ again. The rearranged formula undoes the original one, so
      it passes the test. (If you used the rounded $V$, you may see a
      tiny difference in the last digits.)],
  )
]

#ex(level: "high", difficulty: 2, time: "8 min", calculator: true)[
  Use your TI-Nspire CAS.
  #auto-parts(
    1,
    [Solve $V = pi dot r^2 dot h$ for $r$ with `solve`. Which of the
      answers is the radius?],
    [Solve $1/R = 1/R_1 + 1/R_2$ for $R_2$ with `solve`. Insert
      $R = 4$ and $R_1 = 6$ into the CAS answer and into your own formula
      from this section. Do they agree?],
  )
][
  #auto-parts(
    1,
    [CAS gives $r = plus.minus sqrt(V/(pi dot h))$. The radius is the
      positive one.],
    [Both give $R_2 = 12$, even if the formulas look different.],
  )
]

#check(
  kind: "Stage check",
  "Rearranging Formulas",
  (
    [Solve $s = 1/2 dot a dot t^2$ for $a$.],
    [Solve $U = R dot I + U_0$ for $I$.],
    [Solve $1/f = 1/g + 1/b$ for $b$.],
    [Solve $O = 2 pi dot r dot (r + h)$ for $h$.],
  ),
  (
    [$a = (2s)/t^2$],
    [$I = (U - U_0)/R$],
    [$b = (f dot g)/(g - f)$],
    [$h = O/(2 pi dot r) - r$],
  ),
  pass: [Continue with #goto-first(<st-product>).],
  fail: [Find the example or exercise that matches your mistake and redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════
#print-check-key()

#print-hints()
#print-vocab()
