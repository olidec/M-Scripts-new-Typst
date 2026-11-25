// ch-eq-exp-log.typ — Power, Exponential, and Logarithmic Equations (equations booklet)
//
// COMPLETE (Turn 5). Three stages: checkpoint, theory, exercises
// (ramped, with error analysis), calculator block, stage check.
//
// TARGET MISCONCEPTIONS (see stage notes)
//   Power and Root Equations: M3 x²=9 ⇒ only 3 (even powers)
//   Logarithmic Equations: M7 log(a+b)=log a+log b; M6 domain
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
#show: chapter-template.with(title: "Power, Exponential, and Logarithmic Equations")
#let ex = exercise.with(chapter: "Equations")
#let check = check.with(ex: ex)

= Power, Exponential, and Logarithmic Equations

#only-theory[
  In the equations so far the unknown sat in the base: $x^3 = 8$. Now
  we meet two new situations. The unknown can still be in the base but
  with other exponents (powers and roots), or it can sit in the
  *exponent*, as in $2^x = 8$, or inside a *logarithm*. Each situation
  has its own inverse operation: roots, and logarithms. The two
  exponent-and-logarithm families undo each other, and that is the whole
  idea of this chapter.
]

#objectives(
  [Solve power and root equations, including both signs for even exponents],
  [Solve exponential equations by taking logarithms],
  [Solve logarithmic equations and check the domain],
)

// ════════════════════════════════════════════════════════
== Power and Root Equations <st-power>

#check(
  "Power and Root Equations",
  (
    [Solve $x^3 = 27$.],
    [Solve $x^4 = 16$.],
    [Solve $x^3 = -8$.],
    [Solve $x^(3/2) = 8$.],
  ),
  (
    [$x = 3$],
    [$x = -2$ or $x = 2$],
    [$x = -2$],
    [$x = 4$],
  ),
  pass: [Skip to the checkpoint in #goto-first(<st-exp>).],
  fail: [Work through this section.],
)

#only-theory[
  A #vocab("power", "Potenz") equation has the form $x^n = c$. The
  unknown is the #vocab("base", "Basis"), and you undo the
  #vocab("exponent", "Exponent") $n$ with an #vocab("n-th root",
  "n-te Wurzel"). The sign of the solutions depends on whether $n$ is
  odd or even.
]

#keybox(title: [The equation $x^n = c$])[
  - *$n$ odd:* exactly *one* real solution for every $c$,
    $x = root(n, c)$. For example $x^3 = -8$ gives $x = -2$.
  - *$n$ even, $c > 0$:* *two* solutions, $x = plus.minus root(n, c)$.
  - *$n$ even, $c = 0$:* one solution, $x = 0$.
  - *$n$ even, $c < 0$:* *no* real solution.

  For a rational exponent, raise both sides to the reciprocal power:
  $x^(p/q) = c$ gives $x = c^(q/p)$, where $x >= 0$.
]

#example(title: "Odd and even exponents")[
  $x^3 = 27$ gives $x = 3$. $x^4 = 16$ gives $x = 2$ or $x = -2$.
  $x^3 = -8$ gives $x = -2$. And $x^6 = -1$ has no real solution.
]

#example(title: "Isolate the power first")[
  Solve $3x^4 = 48$. Divide by $3$: $x^4 = 16$, so $x = plus.minus 2$.
  Solve $(2x + 1)^2 = 25$. Take the square root of both sides:
  $2x + 1 = 5$ or $2x + 1 = -5$, so $x = 2$ or $x = -3$.
]

#example(title: "A fractional exponent")[
  Solve $x^(3/2) = 8$. Raise both sides to the power $2/3$:
  $x = 8^(2/3) = (root(3, 8))^2 = 4$. Check: $4^(3/2) = (sqrt(4))^3 = 8$.
]

#warning[
  *Even powers have two solutions.* $x^2 = 9$ gives $x = 3$ *or*
  $x = -3$. Do not confuse the _equation_ $x^2 = 9$ (two solutions)
  with the _number_ $sqrt(9) = 3$ (one value). On the other hand, an
  odd power never loses a solution: $x^3 = -8$ has the solution $-2$,
  even though $-8$ is negative.
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Solve. Say how many solutions there are.
  #auto-parts(
    3,
    [$x^3 = 64$],
    [$x^4 = 81$],
    [$x^5 = -32$],
    [$2x^3 = 54$],
    [$x^2 = 0.25$],
    [$x^6 = -1$],
  )
][
  #auto-parts(
    3,
    [$x = 4$ (one solution)],
    [$x = 3$ or $x = -3$],
    [$x = -2$ (one solution)],
    [$x^3 = 27$, so $x = 3$],
    [$x = 0.5$ or $x = -0.5$],
    [No real solution (an even power is never negative).],
  )
]

#ex(
  difficulty: 2,
  time: "12 min",
  calculator: false,
  hints: ([For a fractional exponent, raise both sides to the
    reciprocal power. For a negative exponent, write it as a fraction.],),
)[
  Solve.
  #auto-parts(
    2,
    [$(x - 1)^3 = 8$],
    [$(2x + 1)^2 = 25$],
    [$(x + 2)^4 = 16$],
    [$x^(2/3) = 9$ #h(0.5em) (with $x >= 0$)],
    [$x^(-2) = 1/9$],
    [$x^(-1/2) = 1/3$],
  )
][
  #auto-parts(
    2,
    [$x - 1 = 2$, so $x = 3$],
    [$2x + 1 = plus.minus 5$, so $x = 2$ or $x = -3$],
    [$x + 2 = plus.minus 2$, so $x = 0$ or $x = -4$],
    [$x = 9^(3/2) = 27$],
    [$x^2 = 9$, so $x = 3$ or $x = -3$],
    [$sqrt(x) = 3$, so $x = 9$],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Three students solved an equation. For each one, decide whether the
  work is correct. If it is wrong, name the mistake and give the correct
  solution set.
  #auto-parts(
    1,
    [Pia: $x^2 = 16 #h(0.5em) arrow.r.double #h(0.5em) x = 4$],
    [Omar: $x^4 = 81 #h(0.5em) arrow.r.double #h(0.5em)
      x = 3 " or " x = -3$],
    [Nina: $x^3 = -8 #h(0.5em) arrow.r.double #h(0.5em)$ "no solution,
      because a power cannot be negative"],
  )
][
  #auto-parts(
    1,
    [Wrong. Pia forgot $x = -4$. Correct: $x = 4$ or $x = -4$.],
    [Correct.],
    [Wrong. Only an _even_ power is never negative. $(-2)^3 = -8$, so
      $x = -2$.],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Set up an equation and solve it.
  #auto-parts(
    1,
    [A cube has volume $125 " cm"^3$. How long is its edge?],
    [A square has area $49 " cm"^2$. How long is its side?],
    [A stone falls $20 " m"$. With $s = 5 t^2$ (in meters and seconds),
      how long does the fall take?],
  )
][
  #auto-parts(
    1,
    [$a^3 = 125$, so $a = 5$ cm.],
    [$a^2 = 49$, so $a = 7$ cm (the solution $-7$ makes no sense for a
      length).],
    [$5 t^2 = 20$, so $t^2 = 4$ and $t = 2$ s (not $-2$ s).],
  )
]

#ex(difficulty: 3, time: "10 min", calculator: false)[
  #auto-parts(
    1,
    [Solve $(x^2 - 1)^3 = 27$.],
    [Solve $(x - 3)^(3/2) = 27$.],
    [For which values of $c$ does $x^4 = c$ have two, one, or no real
      solutions?],
  )
][
  #auto-parts(
    1,
    [$x^2 - 1 = 3$, so $x^2 = 4$ and $x = plus.minus 2$.],
    [$x - 3 = 27^(2/3) = 9$, so $x = 12$.],
    [Two solutions for $c > 0$, one ($x = 0$) for $c = 0$, none for
      $c < 0$.],
  )
]

#keybox(title: "Check with your calculator")[
  #only-basic[
    *TI-30X Pro MathPrint.* Use the calculator's power and root
    functions (your teacher shows you where they are) to compute things
    like $8^(2/3)$ or $root(5, 100)$. The calculator gives only the
    *positive* root of an even power. The second solution you must add
    yourself. To check, raise your answer to the power and compare.
    // VERIFY on device: where the x-th root and power functions are
  ]
  #only-high[
    *TI-Nspire CAS.* `solve(x^4=81,x)` returns the real solutions
    $x = -3$ and $x = 3$. `cSolve(x^4=81,x)` adds the complex ones.
    Read it critically: for an even power with $c < 0$, `solve` says
    `false`, and `cSolve` gives complex solutions.
    // VERIFY on device
  ]
]

#ex(level: "basic", difficulty: 1, time: "8 min", calculator: true)[
  Use your calculator.
  #auto-parts(
    1,
    [Compute $8^(2/3)$ and $4^(3/2)$.],
    [Solve $x^5 = 100$. Round to $3$ decimals, then check by raising to
      the $5$th power.],
    [Solve $x^4 = 81$. How many solutions are there? How many does your
      calculator show?],
  )
][
  #auto-parts(
    1,
    [$8^(2/3) = 4$ and $4^(3/2) = 8$.],
    [$x = 100^(1/5) approx 2.512$. Check: $2.512^5 approx 100$.],
    [Two solutions, $x = 3$ and $x = -3$. A root key gives only $3$.],
  )
]

#ex(level: "high", difficulty: 1, time: "8 min", calculator: true)[
  Use your TI-Nspire CAS.
  #auto-parts(
    1,
    [Solve $x^4 = 81$ with `solve` and with `cSolve`. Compare.],
    [Solve $x^(3/2) = 8$ with `solve`.],
    [Solve $x^6 = -1$ with `solve` and `cSolve`. What does each say?],
  )
][
  #auto-parts(
    1,
    [`solve` gives $x = 3$ and $x = -3$. `cSolve` also gives
      $x = 3i$ and $x = -3i$.],
    [$x = 4$.],
    [`solve` says `false` (no real solution). `cSolve` gives six
      complex solutions.],
  )
]

#check(
  kind: "Stage check",
  "Power and Root Equations",
  (
    [Solve $x^5 = 32$.],
    [Solve $x^6 = 64$.],
    [Solve $x^3 = -125$.],
    [Solve $x^(3/2) = 27$.],
  ),
  (
    [$x = 2$],
    [$x = -2$ or $x = 2$],
    [$x = -5$],
    [$x = 9$],
  ),
  pass: [Continue with #goto-first(<st-exp>).],
  fail: [Find the example or exercise that matches your mistake and redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════
== Exponential Equations <st-exp>

#check(
  "Exponential Equations",
  (
    [Solve $2^x = 32$.],
    [Solve $3^(x + 1) = 81$.],
    [Solve $5^x = 7$ (exact answer and 2 decimals).],
    [Solve $2^x = -4$.],
  ),
  (
    [$x = 5$],
    [$x = 3$],
    [$x = ln(7)/ln(5) approx 1.21$],
    [No real solution],
  ),
  pass: [Skip to the checkpoint in #goto-first(<st-log>).],
  fail: [Work through this section.],
)

#only-theory[
  In an #vocab("exponential equation", "Exponentialgleichung") the
  unknown is in the exponent, as in $2^x = 32$. There are three
  situations. Use the first one when you can, and the second one
  otherwise.
]

#keybox(title: "Exponential equations")[
  + *Same base:* write both sides as powers of the same base and compare
    the exponents. $2^x = 32 = 2^5$ gives $x = 5$.
  + *Take the logarithm:* isolate the power, then take $log$ or $ln$ of
    both sides. $a^x = b$ gives $x = log(b)/log(a) = ln(b)/ln(a)$.
  + *Substitution:* if you see $a^(2x)$ and $a^x$, let $u = a^x$ and
    solve the quadratic in $u$.

  A power with a positive base is always *positive*: $a^x > 0$. So an
  equation like $2^x = -4$ has *no* solution.
]

#example(title: "Same base")[
  Solve $3^(x + 1) = 81$. Since $81 = 3^4$, we get $x + 1 = 4$, so
  $x = 3$. Solve $4^x = 8$: both are powers of $2$, so $2^(2x) = 2^3$,
  $2x = 3$, and $x = 3/2$.
]

#example(title: "Take the logarithm")[
  Solve $5^x = 7$. Taking $ln$ on both sides, $x dot ln(5) = ln(7)$, so
  $x = ln(7)/ln(5) approx 1.21$. Check: $5^1.21 approx 7$.
  First isolate the power if there is a factor: $3 dot 2^x = 48$ gives
  $2^x = 16$, so $x = 4$.
]

#example(title: "Substitution")[
  Solve $4^x - 6 dot 2^x + 8 = 0$. Since $4^x = (2^x)^2$, let $u = 2^x$:
  $u^2 - 6u + 8 = 0$, so $u = 2$ or $u = 4$. Then $2^x = 2$ gives
  $x = 1$, and $2^x = 4$ gives $x = 2$.
]

#example(title: "A real-world question")[
  An account grows by $3 %$ per year. After how many years does the
  money double? Solve $1.03^n = 2$: $n = ln(2)/ln(1.03) approx 23.4$
  years.
]

#warning[
  *Three traps.* First, $5^x = 7$ does *not* give $x = 7/5$. The unknown
  is in the exponent, so you need a logarithm. Second, $3 dot 2^x$ is
  *not* $6^x$: only the $2$ has the exponent. Third, an exponential is
  never negative, so $2^x = -4$ has no solution. Do not let the
  calculator's error message be your only clue.
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Solve by writing both sides with the same base.
  #auto-parts(
    3,
    [$2^x = 64$],
    [$3^x = 1/9$],
    [$5^(x - 2) = 125$],
    [$4^x = 8$],
    [$9^x = 27$],
    [$(1/2)^x = 16$],
  )
][
  #auto-parts(
    3,
    [$x = 6$],
    [$3^x = 3^(-2)$, so $x = -2$],
    [$x - 2 = 3$, so $x = 5$],
    [$2^(2x) = 2^3$, so $x = 3/2$],
    [$3^(2x) = 3^3$, so $x = 3/2$],
    [$2^(-x) = 2^4$, so $x = -4$],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: true)[
  Solve. Give the exact form and a decimal to $2$ places.
  #auto-parts(
    2,
    [$5^x = 30$],
    [$2^x = 0.3$],
    [$3 dot 2^x = 48$],
    [$7 dot 3^(x - 1) = 63$],
    [$e^(2x) = 7$],
    [$10^x = 250$],
  )
][
  #auto-parts(
    2,
    [$x = ln(30)/ln(5) approx 2.11$],
    [$x = ln(0.3)/ln(2) approx -1.74$],
    [$2^x = 16$, so $x = 4$],
    [$3^(x - 1) = 9$, so $x - 1 = 2$ and $x = 3$],
    [$2x = ln(7)$, so $x = ln(7)/2 approx 0.97$],
    [$x = log(250) approx 2.40$],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Three students solved an equation. For each one, decide whether the
  work is correct. If it is wrong, name the mistake and give the correct
  result.
  #auto-parts(
    1,
    [Pia: $5^x = 7 #h(0.5em) arrow.r.double #h(0.5em) x = 7/5$],
    [Omar: $3 dot 2^x = 48 #h(0.5em) arrow.r.double #h(0.5em)
      6^x = 48 #h(0.5em) arrow.r.double #h(0.5em) x = ln(48)/ln(6)$],
    [Nina: $2^x = -4$ has no solution, because $2^x > 0$ for every $x$.],
  )
][
  #auto-parts(
    1,
    [Wrong. The unknown is in the exponent. Correct:
      $x = ln(7)/ln(5) approx 1.21$.],
    [Wrong. $3 dot 2^x != 6^x$. Divide by $3$ first: $2^x = 16$, so
      $x = 4$.],
    [Correct.],
  )
]

#ex(
  difficulty: 2,
  time: "12 min",
  calculator: false,
  hints: ([Let $u = 2^x$ (or $u = 3^x$, $u = e^x$), so that $2^(2x) = u^2$.
    Remember $u > 0$.],),
)[
  Use a substitution.
  #auto-parts(
    2,
    [$4^x - 6 dot 2^x + 8 = 0$],
    [$2^(2x) - 5 dot 2^x - 24 = 0$],
    [$e^(2x) - 3 e^x + 2 = 0$],
    [$2^(x + 1) + 2^x = 12$],
  )
][
  #auto-parts(
    2,
    [$u = 2$ or $u = 4$: $x = 1$ or $x = 2$],
    [$u = 8$ or $u = -3$. Only $u = 8$ works ($u > 0$): $x = 3$],
    [$u = 1$ or $u = 2$: $x = 0$ or $x = ln(2)$],
    [$2 dot 2^x + 2^x = 3 dot 2^x = 12$, so $2^x = 4$ and $x = 2$],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: true)[
  Set up an equation and solve it.
  #auto-parts(
    1,
    [Money grows by $3 %$ per year. After how many years has it doubled?],
    [A bacteria culture follows $N = 100 dot 2^(t/3)$ ($t$ in hours).
      When are there $1600$ bacteria?],
    [A substance has a half-life of $5$ days. After how many days is
      $12.5 %$ left? Use $(1/2)^(t/5) = 0.125$.],
    [A population grows by $4 %$ per year. After how many years is it
      $50 %$ larger?],
  )
][
  #auto-parts(
    1,
    [$1.03^n = 2$, so $n = ln(2)/ln(1.03) approx 23.4$ years.],
    [$2^(t/3) = 16 = 2^4$, so $t/3 = 4$ and $t = 12$ hours.],
    [$0.125 = (1/2)^3$, so $t/5 = 3$ and $t = 15$ days.],
    [$1.04^t = 1.5$, so $t = ln(1.5)/ln(1.04) approx 10.3$ years.],
  )
]

#ex(difficulty: 3, time: "10 min", calculator: true)[
  #auto-parts(
    1,
    [Solve $2^x = 3^(x - 1)$. Give the exact and a decimal value.],
    [Solve $2^(x + 1) = 5^x$. Give a decimal value.],
    [For which values of $c$ does $2^x = c$ have a solution?],
  )
][
  #auto-parts(
    1,
    [Take $ln$: $x dot ln(2) = (x - 1) dot ln(3)$. Collect $x$:
      $x dot (ln(3) - ln(2)) = ln(3)$, so
      $x = ln(3)/(ln(3) - ln(2)) approx 2.71$.],
    [$(x + 1) dot ln(2) = x dot ln(5)$, so
      $x = ln(2)/(ln(5) - ln(2)) approx 0.76$.],
    [Only for $c > 0$.],
  )
]

#keybox(title: "Check with your calculator")[
  #only-basic[
    *TI-30X Pro MathPrint.* You can rewrite $a^x = b$ as
    $x = ln(b)/ln(a)$ and compute it with the *ln* (or *log*) key.
    Check by computing $a^x$ with your result. *num-solv* also works
    (it needs a start value, and for an increasing function like $2^x$ it
    finds the only solution), but it cannot tell you when there is *no*
    solution, as for $2^x = -4$. // VERIFY on device
  ]
  #only-high[
    *TI-Nspire CAS.* `solve(5^x=30,x)` returns
    $x = ln(30)/ln(5)$. `nSolve(5^x=30,x)` gives a decimal. For
    `solve(2^x=-4,x)` the answer is `false`. Equations of the form
    $4^x - 6 dot 2^x + 8 = 0$ work too. Always check that the number of
    solutions matches your hand work. // VERIFY on device
  ]
]

#ex(level: "basic", difficulty: 1, time: "8 min", calculator: true)[
  Use your calculator.
  #auto-parts(
    1,
    [Compute $x = ln(30)/ln(5)$ for $5^x = 30$. Check by computing
      $5^x$.],
    [Try $2^x = -4$ with *num-solv*. What happens? Why?],
  )
][
  #auto-parts(
    1,
    [$x approx 2.113$. Then $5^(2.113) approx 30$.],
    [The calculator finds no solution (or shows an error). Correct: $2^x$
      is never negative.],  // VERIFY on device
  )
]

#ex(level: "high", difficulty: 1, time: "8 min", calculator: true)[
  Use your TI-Nspire CAS.
  #auto-parts(
    1,
    [Solve $5^x = 30$ with `solve`, then with `nSolve`.],
    [Solve $2^x = -4$ with `solve`. What does it say?],
    [Solve $4^x - 6 dot 2^x + 8 = 0$ with `solve`.],
  )
][
  #auto-parts(
    1,
    [$x = ln(30)/ln(5)$ and $x approx 2.113$.],
    [`false`: no real solution.],
    [$x = 1$ or $x = 2$.],
  )
]

#check(
  kind: "Stage check",
  "Exponential Equations",
  (
    [Solve $4^x = 64$.],
    [Solve $2^(2x - 1) = 8$.],
    [Solve $3^x = 20$ (exact answer and 2 decimals).],
    [Solve $5^x + 2 = 1$.],
  ),
  (
    [$x = 3$],
    [$x = 2$],
    [$x = ln(20)/ln(3) approx 2.73$],
    [No real solution],
  ),
  pass: [Continue with #goto-first(<st-log>).],
  fail: [Find the example or exercise that matches your mistake and redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════
== Logarithmic Equations <st-log>

#check(
  "Logarithmic Equations",
  (
    [Solve $log(x) = 2$.],
    [Solve $ln(x) = 3$ (exact answer and 2 decimals).],
    [Solve $log_2 (x) = 5$.],
    [Solve $log(x) + log(x - 3) = 1$.],
  ),
  (
    [$x = 100$],
    [$x = e^3 approx 20.09$],
    [$x = 32$],
    [$x = 5$],
  ),
  pass: [Skip to the checkpoint in #goto-first(<st-trig>).],
  fail: [Work through this section.],
)

#only-theory[
  The #vocab("logarithm", "Logarithmus") $log_b (x)$ is the exponent to
  which you raise $b$ to get $x$. So $log_2 (8) = 3$, because
  $2^3 = 8$. A logarithm equation asks for the number _inside_ the
  logarithm. The domain matters: you can only take the logarithm of a
  *positive* number.
]

#keybox(title: "Logarithm equations")[
  + *Domain first.* Every argument of a logarithm must be $> 0$.
  + *One logarithm:* combine with the laws
    $ log(a dot b) = log(a) + log(b), quad
      log(a/b) = log(a) - log(b), quad
      log(a^n) = n dot log(a). $
  + *Undo the logarithm:* $log_b (x) = c$ means $x = b^c$. If both sides
    are one logarithm of the same base, set the arguments equal.
  + *Check the domain.* Throw away solutions that make an argument
    $<= 0$.
]

#example(title: "Rewrite as a power")[
  $log(x) = 2$ gives $x = 10^2 = 100$. $ln(x) = 3$ gives $x = e^3
  approx 20.09$. $log_3 (x + 2) = 2$ gives $x + 2 = 9$, so $x = 7$.
]

#example(title: "Combine, then check the domain")[
  Solve $log(x) + log(x - 3) = 1$. The domain: $x > 3$. Combine:
  $log(x dot (x - 3)) = 1$, so $x dot (x - 3) = 10$ and
  $x^2 - 3x - 10 = 0$. Then $x = 5$ or $x = -2$. Only $x = 5$ is in the
  domain. Check: $log(5) + log(2) = log(10) = 1$.
]

#example(title: "Two ways to write the same thing")[
  $2 dot log(x) = log(36)$ requires $x > 0$, so $x = 6$ only. But
  $log(x^2) = log(36)$ only requires $x^2 > 0$, so $x = 6$ *or*
  $x = -6$. The two equations look alike and have different solution
  sets.
]

#warning[
  *$log(a + b)$ is not $log(a) + log(b)$.* Test it: $log(10 + 90) = 2$,
  but $log(10) + log(90) approx 2.95$. The law is for a _product_:
  $log(a dot b) = log(a) + log(b)$. There is no rule for a sum inside
  a logarithm. And never skip the domain: a "solution" with a
  negative argument is not a solution.
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Solve. Give exact answers.
  #auto-parts(
    3,
    [$log(x) = 3$],
    [$log_2 (x) = 6$],
    [$ln(x) = 1$],
    [$log_5 (x) = -2$],
    [$log(x + 4) = 1$],
    [$log_3 (2x - 1) = 2$],
  )
][
  #auto-parts(
    3,
    [$x = 1000$],
    [$x = 2^6 = 64$],
    [$x = e$],
    [$x = 5^(-2) = 1/25$],
    [$x + 4 = 10$, so $x = 6$],
    [$2x - 1 = 9$, so $x = 5$],
  )
]

#ex(
  difficulty: 2,
  time: "14 min",
  calculator: false,
  hints: ([First write the domain. Then combine the logarithms.],),
)[
  State the domain, solve, and check.
  #auto-parts(
    2,
    [$log(x) + log(x - 2) = log(8)$],
    [$log_2 (x + 1) + log_2 (x - 1) = 3$],
    [$2 dot log(x) = log(36)$],
    [$log(x^2) = log(36)$],
    [$ln(x) - ln(x - 1) = ln(2)$],
    [$log_3 (x) + log_3 (x + 6) = 3$],
  )
][
  #auto-parts(
    2,
    [$x > 2$. $x dot (x - 2) = 8$, so $x = 4$ or $x = -2$. Only
      $x = 4$.],
    [$x > 1$. $x^2 - 1 = 8$, so $x = 3$ or $x = -3$. Only $x = 3$.],
    [$x > 0$. $x^2 = 36$, so only $x = 6$.],
    [$x != 0$. $x^2 = 36$, so $x = 6$ *or* $x = -6$.],
    [$x > 1$. $x/(x - 1) = 2$, so $x = 2$.],
    [$x > 0$. $x^2 + 6x = 27$, so $x = 3$ or $x = -9$. Only $x = 3$.],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Three students solved an equation. For each one, decide whether the
  work is correct. If it is wrong, name the mistake and give the correct
  result.
  #auto-parts(
    1,
    [Pia: $log(x + 3) = 1 #h(0.5em) arrow.r.double #h(0.5em)
      log(x) + log(3) = 1 #h(0.5em) arrow.r.double #h(0.5em)
      x = 10/3$],
    [Omar: $log(x) + log(x - 3) = 1$ gives $x^2 - 3x - 10 = 0$, so
      $x = 5$ or $x = -2$. Answer: $x = 5$, because $log(-2)$ does not
      exist.],
    [Nina: $log(x^2) = log(36) #h(0.5em) arrow.r.double #h(0.5em)
      x = 6$],
  )
][
  #auto-parts(
    1,
    [Wrong. $log(x + 3) != log(x) + log(3)$. Correct: $x + 3 = 10$, so
      $x = 7$.],
    [Correct.],
    [Wrong. $x^2 = 36$ also has $x = -6$, and $log((-6)^2)$ is fine.
      Correct: $x = 6$ or $x = -6$.],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  The unknown is in the argument or in the base. Solve.
  #auto-parts(
    1,
    [$ln(2x - 1) = 0$],
    [$log_x (81) = 4$ (with $x > 0$, $x != 1$)],
    [$log_x (1/8) = -3$ (with $x > 0$, $x != 1$)],
  )
][
  #auto-parts(
    1,
    [$2x - 1 = e^0 = 1$, so $x = 1$.],
    [$x^4 = 81$, so $x = 3$ (the base must be positive).],
    [$x^(-3) = 1/8$, so $x = 2$.],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: true)[
  Apply it.
  #auto-parts(
    1,
    [The sound level in decibel is $L = 10 dot log(I/I_0)$. For which
      ratio $I/I_0$ is $L = 60$?],
    [The pH value is $"pH" = -log(c)$, where $c$ is the concentration in
      mol/L. Find $c$ for $"pH" = 4.2$.],
  )
][
  #auto-parts(
    1,
    [$log(I/I_0) = 6$, so $I/I_0 = 10^6$.],
    [$log(c) = -4.2$, so $c = 10^(-4.2) approx 6.3 dot 10^(-5)$ mol/L.],
  )
]

#ex(difficulty: 3, time: "10 min", calculator: false)[
  Use a substitution.
  #auto-parts(
    1,
    [$log_2 (x) = log_x (2)$ (with $x > 0$, $x != 1$). Hint: let
      $t = log_2 (x)$, so $log_x (2) = 1/t$.],
    [$(log(x))^2 - 3 dot log(x) + 2 = 0$],
  )
][
  #auto-parts(
    1,
    [$t = 1/t$, so $t^2 = 1$ and $t = 1$ or $t = -1$. Then $x = 2$ or
      $x = 1/2$.],
    [Let $t = log(x)$: $t^2 - 3t + 2 = 0$, so $t = 1$ or $t = 2$. Then
      $x = 10$ or $x = 100$.],
  )
]

#keybox(title: "Check with your calculator")[
  #only-basic[
    *TI-30X Pro MathPrint.* Use the *log* and *ln* keys to check a
    candidate: evaluate the left side of the _original_ equation for
    your solution. For a rejected candidate such as $x = -2$ in
    $log(x) + log(x - 3) = 1$, the calculator reports an error, which
    confirms that it is outside the domain. // VERIFY on device
  ]
  #only-high[
    *TI-Nspire CAS.* `solve(log(x)+log(x-3)=1,x)` should return only
    $x = 5$, since the calculator knows $log$ needs a positive argument.
    Compare `solve(ln(x^2)=ln(36),x)` (two solutions) with
    `solve(2·ln(x)=ln(36),x)` (one solution). Read the output
    critically. // VERIFY on device
  ]
]

#ex(level: "basic", difficulty: 1, time: "8 min", calculator: true)[
  Consider $log(x) + log(x - 3) = 1$, which has the candidates $x = 5$
  and $x = -2$.
  #auto-parts(
    1,
    [Evaluate $log(5) + log(5 - 3)$ on your calculator.],
    [Try to evaluate $log(-2) + log(-2 - 3)$. What happens?],
    [Which candidate is the solution?],
  )
][
  #auto-parts(
    1,
    [$0.699 + 0.301 = 1$.],
    [The calculator reports an error, because $log$ of a negative
      number is not defined.],  // VERIFY on device
    [Only $x = 5$.],
  )
]

#ex(level: "high", difficulty: 1, time: "8 min", calculator: true)[
  Use your TI-Nspire CAS.
  #auto-parts(
    1,
    [Solve $log(x) + log(x - 3) = 1$ with `solve`.],
    [Solve $ln(x^2) = ln(36)$ and $2 dot ln(x) = ln(36)$. Compare.],
  )
][
  #auto-parts(
    1,
    [$x = 5$ (the candidate $-2$ is not in the domain).],
    [The first gives $x = 6$ and $x = -6$, the second only $x = 6$.],
  )
]

#check(
  kind: "Stage check",
  "Logarithmic Equations",
  (
    [Solve $log(x) = -1$.],
    [Solve $ln(x) = -2$ (exact answer and 3 decimals).],
    [Solve $log_3 (x) = 4$.],
    [Solve $log(x) + log(x + 9) = 1$.],
  ),
  (
    [$x = 1/10$],
    [$x = e^(-2) approx 0.135$],
    [$x = 81$],
    [$x = 1$],
  ),
  pass: [Continue with #goto-first(<st-trig>).],
  fail: [Find the example or exercise that matches your mistake and redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════
#print-check-key()

#print-hints()
#print-vocab()
