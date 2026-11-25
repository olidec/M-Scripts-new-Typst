// ch-eq-numeric.typ — Numerical Solutions (equations booklet)
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
#show: chapter-template.with(title: "Numerical Solutions")
#let ex = exercise.with(chapter: "Equations")
#let check = check.with(ex: ex)

= Numerical Solutions

#only-theory[
  So far every equation could be solved exactly. Many equations that
  come from real problems cannot. You cannot isolate $x$ in
  $cos(x) = x$ or in $e^x = 3x$, however you rearrange. In
  applications this is no disaster: one rarely needs the exact value,
  but a number accurate to a few decimals. This chapter shows how that
  number is found, and it is what your calculator does when you press
  the solve key. Knowing the method lets you judge what the calculator
  tells you, and in particular which solutions it does not tell you.
]

#objectives(
  [Show by a sign change that a solution exists],
  [Use bisection and Newton steps],
  [Count solutions with a sketch],
)

// ════════════════════════════════════════════════════════
== When There Is No Algebraic Solution <st-numeric>

#check(
  "When There Is No Algebraic Solution",
  (
    [Does $x^3 + x - 1 = 0$ have a solution between $0$ and $1$? Why?],
    [Bisection for $f(x) = x^2 - 2$ on $[1, 2]$: which interval is next?],
    [Newton's method for $f(x) = x^2 - 2$ with $x_0 = 1$: find $x_1$.],
    [How many real solutions does $e^x = 3x$ have? (Sketch both graphs.)],
  ),
  (
    [Yes: $f(0) = -1 < 0$ and $f(1) = 1 > 0$ (sign change)],
    [$[1, 1.5]$, since $f(1.5) = 0.25 > 0$],
    [$x_1 = 1.5$],
    [Two ($x approx 0.62$ and $x approx 1.51$)],
  ),
  pass: [Skip to the checkpoint in #goto-first(<st-cplx>, <st-which>).],
  fail: [Work through this section.],
)

#only-theory[
  The first step is always the same: move everything to one side and
  call the result $f$. To solve $e^x = 3x$, work with
  $f(x) = e^x - 3x$ and look for the places where $f(x) = 0$.
]

#keybox(title: "Sign change (intermediate value theorem)")[
  Let $f$ be continuous on $[a, b]$ (its graph has no jumps or gaps). If
  $f(a)$ and $f(b)$ have *opposite signs*, that is
  $f(a) dot f(b) < 0$, then $f$ has at least one zero between $a$ and
  $b$.
]

#only-theory[
  The statement is about existence. It does not give the zero, but it
  encloses it in an interval, and the next method shrinks that interval.
]

#keybox(title: "Bisection")[
  Start with an interval $[a, b]$ with a sign change.
  + Compute the midpoint $m = (a + b)/2$ and the value $f(m)$.
  + Keep the half that still has a sign change: $[a, m]$ if
    $f(a) dot f(m) < 0$, otherwise $[m, b]$.
  + Repeat.

  Each step halves the interval. After $n$ steps its length is
  $(b - a)/2^n$. The method always works, but it is slow: about
  $3$ steps for each additional decimal place.
]

#keybox(title: "Newton's method")[
  Start with a guess $x_0$. Follow the tangent line at $x_0$ to where it
  crosses the $x$-axis. That point is the next guess:
  $ x_(n+1) = x_n - f(x_n) / (f'(x_n)). $
  Repeat. Near a solution the number of correct digits roughly *doubles*
  with each step, so Newton's method is much faster than bisection. It
  needs the derivative $f'$, and it needs a good start value.
]

#example(title: "Bisection")[
  Solve $x^2 = 2$, that is $f(x) = x^2 - 2 = 0$ on $[1, 2]$. Here
  $f(1) = -1 < 0$ and $f(2) = 2 > 0$.

  #align(center, table(
    columns: 5,
    align: center,
    [*Step*], [*Interval*], [*Midpoint $m$*], [*$f(m)$*], [*Next interval*],
    [1], [$[1, 2]$], [$1.5$], [$0.25$], [$[1, 1.5]$],
    [2], [$[1, 1.5]$], [$1.25$], [$-0.4375$], [$[1.25, 1.5]$],
    [3], [$[1.25, 1.5]$], [$1.375$], [$-0.1094$], [$[1.375, 1.5]$],
  ))

  After three steps the solution is known to lie in $[1.375, 1.5]$, an
  interval of length $0.125$. (Indeed $sqrt(2) approx 1.4142$.)
]

#example(title: "Newton")[
  Solve $x^3 + x - 1 = 0$. Here $f'(x) = 3x^2 + 1$. Start with
  $x_0 = 1$:
  $ x_1 = 1 - 1/4 = 0.75, quad
    x_2 = 0.75 - 0.171875 / 2.6875 approx 0.6860, quad
    x_3 approx 0.6823. $
  The next steps no longer change the first four decimals, so
  $x approx 0.6823$.
]

#example(title: "How many solutions? Draw both sides")[
  How many solutions does $e^x = 3x$ have? Sketch the graphs of $y = e^x$
  and $y = 3x$. The line starts below the curve, rises above it, and the
  exponential then overtakes it again. So there are *two* intersection
  points, near $x approx 0.62$ and $x approx 1.51$. Bisection or Newton
  with a start value near each one finds both. A start value near $0.5$
  leads to the first, and a start value near $2$ leads to the second.
]

#warning[
  *No sign change does not mean no solution.* Take $f(x) = x^2$ on
  $[-1, 1]$. Then $f(-1) = 1$ and $f(1) = 1$ have the same sign, yet
  $x = 0$ is a zero. Two zeros inside the interval also cancel out: the
  sign at the ends is the same. The sign-change test can prove that a
  solution exists. It cannot prove that there is none, and it does not
  count solutions. For counting, use a sketch.
]

#warning[
  *Newton's method can fail.* If $f'(x_n) = 0$ the formula divides by
  zero. And a start value that is far from a solution can lead to another
  solution, or into a loop. For $f(x) = x^3 - 2x + 2$ and $x_0 = 0$ the
  steps are $0, 1, 0, 1, dots$ and never get closer to the solution
  near $-1.77$. Always check the result by substituting it, and do not
  trust a single run.
]

#ex(difficulty: 1, time: "10 min", calculator: true)[
  Show by a sign change that each equation has a solution in the given
  interval. For (b), set the calculator to RAD.
  #auto-parts(
    2,
    [$x^3 + 2x - 5 = 0$ in $[1, 2]$],
    [$cos(x) = x$ in $[0, 1]$],
    [$e^x = 4 - x$ in $[1, 2]$],
    [$ln(x) = x - 2$ in $[3, 4]$],
  )
][
  #auto-parts(
    1,
    [$f(1) = -2 < 0$ and $f(2) = 7 > 0$.],
    [Let $f(x) = cos(x) - x$. $f(0) = 1 > 0$ and $f(1) approx -0.46 < 0$.],
    [Let $f(x) = e^x + x - 4$. $f(1) approx -0.28 < 0$ and
      $f(2) approx 5.39 > 0$.],
    [Let $f(x) = ln(x) - x + 2$. $f(3) approx 0.10 > 0$ and
      $f(4) approx -0.61 < 0$.],
  )
]

#ex(difficulty: 2, time: "12 min", calculator: true)[
  Use bisection for $f(x) = x^3 + 2x - 5$ on $[1, 2]$.
  #auto-parts(
    1,
    [Do three steps. Give the interval after each step.],
    [Give an estimate for the solution after the third step, and say how
      large the error can be at most.],
    [How many steps are needed until the interval is shorter than
      $0.001$?],
  )
][
  #auto-parts(
    1,
    [Step 1: $m = 1.5$, $f(m) = 1.375 > 0$, new interval $[1, 1.5]$.
      Step 2: $m = 1.25$, $f(m) approx -0.547 < 0$, new interval
      $[1.25, 1.5]$. Step 3: $m = 1.375$, $f(m) approx 0.350 > 0$, new
      interval $[1.25, 1.375]$.],
    [The midpoint $1.3125$ is an estimate. The solution lies in an
      interval of length $0.125$, so the error is at most $0.0625$.
      (The solution is $x approx 1.3283$.)],
    [After $n$ steps the length is $1/2^n$. We need $1/2^n < 0.001$, that
      is $2^n > 1000$, so $n = 10$ steps.],
  )
]

#ex(difficulty: 2, time: "12 min", calculator: true)[
  Use Newton's method. Write down each step.
  #auto-parts(
    1,
    [$f(x) = x^3 + 2x - 5$ with $x_0 = 1.5$. Compute $x_1$ and $x_2$.],
    [Compute $sqrt(7)$ by solving $f(x) = x^2 - 7 = 0$ with
      $x_0 = 3$. Compute $x_1$ and $x_2$ and compare with your
      calculator's $sqrt(7)$.],
  )
][
  #auto-parts(
    1,
    [$f'(x) = 3x^2 + 2$. $x_1 = 1.5 - 1.375/8.75 approx 1.3429$ and
      $x_2 approx 1.3284$. (The solution is $1.32827 dots$.)],
    [$f'(x) = 2x$. $x_1 = 3 - 2/6 approx 2.6667$ and
      $x_2 approx 2.64583$. The calculator gives $sqrt(7) approx 2.64575$,
      so two steps already agree to four decimals.],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  How many real solutions does each equation have? Sketch the graphs of
  both sides, and give the approximate position of each solution.
  #auto-parts(
    2,
    [$x^2 = 2^x$],
    [$sin(x) = x/2$],
    [$e^x = x$],
    [$ln(x) = 1/x$],
  )
][
  #auto-parts(
    2,
    [Three: near $x approx -0.77$, and $x = 2$ and $x = 4$],
    [Three: $x = 0$ and $x approx plus.minus 1.90$],
    [None: the curve $e^x$ always lies above the line $y = x$],
    [One: near $x approx 1.76$ (a rising curve and a falling one cross
      once)],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  *Find the error.* Use bisection for $f(x) = x^3 + x - 1$ on $[0, 1]$.
  Here $f(0) = -1$, $f(1) = 1$ and the midpoint is $m = 0.5$ with
  $f(0.5) = -0.375$. Three students decide how to continue:
  #align(center)[
    Anna: $[0, 0.5]$ #h(2em) Ben: $[0.5, 1]$ #h(2em) Chris: "$x = 0.5$ is the solution"
  ]
  #auto-parts(
    1,
    [Who is correct?],
    [What is wrong with the other two answers?],
  )
][
  #auto-parts(
    1,
    [Ben.],
    [The new interval must still contain the sign change. $f(0) < 0$ and
      $f(0.5) < 0$ have the same sign, so $[0, 0.5]$ (Anna) has no sign
      change and the solution is not guaranteed to be there. Chris
      treats the midpoint as the solution. But $f(0.5) = -0.375 != 0$:
      the midpoint is only the next test point, and the solution is
      still somewhere in the kept half.],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: true)[
  *Find the error.* For $f(x) = x^2 - 2$ and $x_0 = 1$, three students
  compute $x_1$:
  #align(center)[
    Anna: $x_1 = 1 - (-1)/2 = 1.5$ #h(2em)
    Ben: $x_1 = 1 - (-1)/1 = 2$ #h(2em)
    Chris: $x_1 = 1 + (-1)/2 = 0.5$
  ]
  #auto-parts(
    1,
    [Who is correct?],
    [Find the mistake in each of the other two answers.],
    [Compute $f(x_1)$ for all three values. Which one is closest to $0$?],
  )
][
  #auto-parts(
    1,
    [Anna.],
    [Ben used $f'(x_0) = x_0 = 1$, but the derivative of $x^2 - 2$ is
      $2x$, which is $2$ at $x_0 = 1$. Chris used the wrong sign: the
      formula has a *minus*, $x_0 - f(x_0)/f'(x_0)$.],
    [$f(1.5) = 0.25$, $f(2) = 2$ and $f(0.5) = -1.75$. Anna's value is the
      closest to $0$.],
  )
]

#ex(
  difficulty: 3,
  time: "15 min",
  calculator: true,
  hints: ([Compute $f'(x)$ first. Watch the values you get in the first
    two steps.],),
)[
  Let $f(x) = x^3 - 2x + 2$.
  #auto-parts(
    1,
    [Apply Newton's method with $x_0 = 0$. What happens?],
    [Apply it with $x_0 = -2$. Compute three steps.],
    [Use the sign-change test on $[-2, -1]$ to confirm that the solution
      exists.],
  )
][
  #auto-parts(
    1,
    [$f'(x) = 3x^2 - 2$. $x_1 = 0 - 2/(-2) = 1$ and
      $x_2 = 1 - 1/1 = 0$. The values jump between $0$ and $1$ forever, and
      Newton's method never finds the solution.],
    [$x_1 = -1.8$, $x_2 approx -1.76995$, $x_3 approx -1.76929$. This
      converges to $x approx -1.7693$.],
    [$f(-2) = -2 < 0$ and $f(-1) = 3 > 0$, a sign change.],
  )
]

#ex(difficulty: 3, time: "15 min", calculator: true)[
  Solve $cos(x) = x$ with Newton's method. Set the calculator to RAD.
  #auto-parts(
    1,
    [Write the equation as $f(x) = 0$ and find $f'(x)$.],
    [Start with $x_0 = 1$ and compute $x_1$, $x_2$ and $x_3$ to five
      decimals.],
    [Substitute your result into $cos(x) - x$ to check it.],
  )
][
  #auto-parts(
    1,
    [$f(x) = cos(x) - x$ and $f'(x) = -sin(x) - 1$.],
    [$x_1 approx 0.75036$, $x_2 approx 0.73911$, $x_3 approx 0.73909$.],
    [$cos(0.73909) approx 0.73909$, so $cos(x) - x approx 0$. #sym.checkmark],
  )
]

#ex(level: "high", difficulty: 3, time: "15 min", calculator: true)[
  Apply Newton's method to $f(x) = x^2 - 2$ with $x_0 = 1$.
  #auto-parts(
    1,
    [Show that the step becomes $x_(n+1) = (x_n + 2/x_n)/2$.],
    [Compute $x_1$, $x_2$ and $x_3$ exactly, as fractions.],
    [Compute the errors $x_n - sqrt(2)$ for $n = 1, 2, 3$. What do you
      notice?],
  )
][
  #auto-parts(
    1,
    [$x_n - (x_n^2 - 2)/(2 x_n) = (2 x_n^2 - x_n^2 + 2)/(2 x_n)
      = (x_n^2 + 2)/(2 x_n) = (x_n + 2/x_n)/2$.],
    [$x_1 = 3/2$, $x_2 = 17/12$, $x_3 = 577/408$.],
    [The errors are about $0.0858$, $0.00245$ and $0.0000021$. Each error
      is roughly the square of the previous one (times a constant), so
      the number of correct decimals about doubles.],
  )
]

#ex(level: "high", difficulty: 3, time: "15 min", calculator: true)[
  Let $f(x) = e^x - 3x$.
  #auto-parts(
    1,
    [Find $f'(x)$ and write the Newton step.],
    [Compute with $x_0 = 0.5$, then with $x_0 = 2$. Which solution does each
      start value approach? Do five steps each.],
    [Explain why the two runs end at different solutions, using a sketch
      of $y = e^x$ and $y = 3x$.],
  )
][
  #auto-parts(
    1,
    [$f'(x) = e^x - 3$ and $x_(n+1) = x_n - (e^(x_n) - 3 x_n)/(e^(x_n) - 3)$.],
    [With $x_0 = 0.5$ the iteration converges to $x approx 0.6191$. With
      $x_0 = 2$ it converges to $x approx 1.5121$.],
    [There are two intersection points. Each start value is closer to one of them, and the tangent
      lines lead to the nearer solution. Note that $f'(x) = 0$ at
      $x = ln(3) approx 1.10$ between the solutions, and a start value
      near that point would fail.],
  )
]

#keybox(title: "Check with your calculator")[
  #only-basic[
    *TI-30X Pro MathPrint.* *num-solv* does what this chapter describes,
    automatically. You enter the equation, with $x$ as the unknown, and a
    *start value*. It returns *one* solution near the start value. To find
    another solution, change the start value. For $e^x = 3x$ try start
    values $0$ and $2$. The calculator does not tell you how many
    solutions exist: for that you need a sketch or a table of values
    (look for sign changes). To check a result, substitute it back into
    the equation.
    // VERIFY on device: num-solv menu path and how the start value is entered
    // VERIFY on device: whether the calculator has a table of values and how it is used
  ]
  #only-high[
    *TI-Nspire CAS.* `nSolve(e^x=3·x,x=2)` needs a start value and
    returns one decimal solution near it. `nSolve(e^x=3·x,x)|x<1`
    restricts the search with the `|` operator. Use the Graphs
    application to see all intersection points, and its intersection
    tool to read them. `solve(e^x=3·x,x)` may return an exact form with
    a special function or no result. Treat that as a signal to switch to
    `nSolve`, and do not assume that "no answer" means "no solution".
    // VERIFY on device: nSolve syntax with a start value and with |
    // VERIFY on device: what solve returns for e^x=3·x
    // VERIFY on device: intersection tool in the Graphs application
  ]
]

#ex(level: "basic", difficulty: 1, time: "10 min", calculator: true)[
  Use *num-solv*.
  #auto-parts(
    1,
    [Solve $e^x = 3x$ with the start values $0$ and $2$. What do you get?],
    [Set RAD mode and solve $cos(x) = x$ with the start value $1$.],
    [Solve $x^3 + 2x - 5 = 0$ and compare with your bisection estimate
      from the exercises.],
  )
][
  #auto-parts(
    1,
    [$x approx 0.619$ with start $0$ and $x approx 1.512$ with start $2$.],
    [$x approx 0.7391$.],
    [$x approx 1.3283$. The bisection estimate $1.3125$ is within the error
      of $0.0625$.],
  )
]

#ex(level: "high", difficulty: 1, time: "10 min", calculator: true)[
  Use your TI-Nspire CAS.
  #auto-parts(
    1,
    [Solve $e^x = 3x$ with `nSolve` and the start values $0$ and $2$.],
    [Try `solve` on the same equation. Describe the output.],
    [Draw $y = x^2$ and $y = 2^x$ in the Graphs application. How many
      intersection points are there? Find all of them.],
  )
][
  #auto-parts(
    1,
    [$x approx 0.6191$ and $x approx 1.5121$.],
    [The output is an exact form with a special function, or an
      unsolved equation. Either way `nSolve` is the tool for this equation.],
    [Three: $x approx -0.7667$, $x = 2$ and $x = 4$.],
  )
]

#check(
  kind: "Stage check",
  "When There Is No Algebraic Solution",
  (
    [Does $x^3 - x - 1 = 0$ have a solution between $1$ and $2$? Why?],
    [Bisection for $f(x) = x^3 - 5$ on $[1, 2]$: which interval is next?],
    [Newton's method for $f(x) = x^2 - 5$ with $x_0 = 2$: find $x_1$.],
    [How many real solutions does $ln(x) = 2 - x$ have? (Sketch both graphs.)],
  ),
  (
    [Yes: $f(1) = -1 < 0$ and $f(2) = 5 > 0$ (sign change)],
    [$[1.5, 2]$, since $f(1.5) = -1.625 < 0$],
    [$x_1 = 2.25$],
    [One ($x approx 1.56$)],
  ),
  pass: [Continue with #goto-first(<st-cplx>, <st-which>).],
  fail: [Find the example or exercise that matches your mistake and redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════
#print-check-key()

#print-hints()
#print-vocab()
