#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "The Antiderivative")
#let ex = exercise.with(chapter: "The Antiderivative")

// ── TEACHER'S NOTE ───────────────────────────────────────────
// CHAPTER ORDER. This unit opens with antiderivatives and only then
// turns to areas (ch-riemann) and the theorem joining them (ch-ftc).
// The reverse order is defensible, but this one buys a genuine
// surprise: students spend a chapter running differentiation
// backwards, a second chapter chopping regions into rectangles, and
// have no reason at all to expect the two to meet. Do not spoil it —
// in particular, resist writing the integral sign on the board during
// ch-riemann until the FTC arrives.
//
// The notation is introduced here anyway (§2) because the Lehrplan
// asks for antiderivatives to be NAMED as such, and because the
// exercise sets need a symbol. That is a notational loan, not the
// theorem.
//
// TWO ADDITIONS to the old LaTeX §9.1, which was a single definition
// box followed by exercises:
//   * §4 states plainly that there is no product rule, no quotient
//     rule and no chain rule for antiderivatives, and shows a
//     counterexample. The old notes leave students to discover this
//     by getting an exercise wrong, and many conclude they have
//     misremembered a rule rather than that no rule exists.
//   * §5 is linear substitution. The old notes never teach it, yet
//     old Exercise 78 asks for the integrals of sqrt(6x+4) and
//     e^(-x+1) — both of which need exactly this and nothing more.
//
// NOTATION CHANGE: the old notes write the antiderivative of 1/x as
// ln(x). It is ln|x|, and the absolute value costs one remark (§3).
// The distinction bites in ch-areas, where a region below the axis on
// the negative side of a hyperbola is a perfectly ordinary exercise.

= The Antiderivative

#only-theory[
  Last year you learned to run one way: from a function to its rate of
  change. This year runs the other way.

  The reason is that the world usually hands us the rate. A
  speedometer reports velocity, not position. A thermometer reads
  temperature, but what a climate model produces is the *rate* at
  which it is changing. A population's growth rate is measurable in a
  season; the population in fifty years is not. In each case the
  question is the same: given how fast something is changing, can we
  recover the thing itself?

  Mathematically the question is disarmingly simple to state. Given
  $f$, find a function $F$ whose derivative is $f$. Answering it turns
  out to be much harder than differentiating — and, for reasons nobody
  could have predicted, it turns out to be the same problem as
  computing an area.
]

#epigraph(by: "Richard Courant")[
  Differentiation is a craft; integration is an art.
]

#objectives(
  bfkm[state the antiderivatives of the elementary functions],
  bfkm[apply the sum and constant-multiple rules for antiderivatives],
  [explain why an antiderivative is only determined up to an additive
    constant, and what that means for the graph],
  [determine the particular antiderivative satisfying a given
    condition],
  [recognize that there is no product, quotient or chain rule for
    antiderivatives],
  [integrate a function of the form $f(a dot x + b)$ using linear
    substitution],
  [recover position from velocity, and velocity from acceleration],
)

== Running Differentiation Backwards

#definition(title: "Antiderivative")[
  Given a function $f$, an #vocab("antiderivative", "Stammfunktion")
  of $f$ is a function $F$ with
  $ F'(x) = f(x) $
  for every $x$ in the interval under consideration.
]

#example(title: "Guess and check")[
  Find an antiderivative of $f(x) = x^2$.

  We want something whose derivative is $x^2$. The power rule lowers
  an exponent by one, so we should start one higher, with $x^3$ — but
  $(x^3)' = 3 x^2$, three times too big. Divide by $3$:
  $ F(x) = 1/3 dot x^3, quad "since" quad F'(x) = x^2. $

  Every antiderivative in this chapter is found the same way: guess a
  form, differentiate it, and adjust the constant until it matches.
  Checking is free, so there is never an excuse for a wrong
  antiderivative.
]

#warning[
  $F$ is *an* antiderivative, not *the* antiderivative. So are
  $ 1/3 x^3 + 1, quad 1/3 x^3 - 7, quad 1/3 x^3 + sqrt(2), $
  since a constant differentiates to zero and is therefore invisible
  to $F'$.
]

#keybox(title: "All the antiderivatives")[
  If $F$ is an antiderivative of $f$ on an interval, then so is
  $ F(x) + C $
  for every constant $C in RR$ — and these are *all* of them.

  So a function has either no antiderivative or infinitely many, and
  the infinitely many differ only by a vertical shift.
]

#remark[
  Why "all of them"? Suppose $F$ and $G$ are both antiderivatives of
  $f$. Then $(G - F)' = f - f = 0$ everywhere on the interval, and a
  function whose derivative is zero throughout an interval is
  constant — its graph never rises and never falls. So $G - F = C$.

  Geometrically this says the antiderivatives of $f$ form a
  #vocab("family of curves", "Kurvenschar") of exactly the kind you
  met last year: one curve, shifted up and down. Every member has the
  same slope at any given $x$, because the slope is $f(x)$ and $f$
  does not know about $C$. Sketching an antiderivative from the graph
  of $f$ — which you did in the rate-of-change chapter — produces one
  member of this family, and which one you drew was never determined.
]

== Notation

#only-theory[
  The set of all antiderivatives of $f$ has a symbol of its own:
  $ integral f(x) dif x = F(x) + C, $
  read "the integral of $f$ of $x$, $dif x$". The name for this object
  is the #vocab("indefinite integral", "unbestimmtes Integral") — the
  word *indefinite* distinguishing it from the definite integral of
  the next chapter, which is a number rather than a family of
  functions.

  Three pieces of the notation, and one warning.

  The elongated S, $integral$, is Leibniz's, and it stands for
  *summa*. That is a strange choice for an antiderivative — nothing is
  being summed here — and the reason will not become clear for two
  more chapters.

  The $dif x$ says which letter is the variable. In
  $integral 2 a t dif t$ the $a$ is a constant and $t$ is not, and
  without the $dif t$ there would be no way to tell.

  The $+ C$ is part of the answer. Leaving it off is not a minor
  omission — it converts a correct statement about a family of
  functions into a false statement about one of them.
]

#warning[
  The word "integral" is about to do double duty, and the two jobs are
  genuinely different. An *indefinite* integral is a family of
  functions. A *definite* integral, written
  $integral_a^b f(x) dif x$, is a single number. They are written
  almost identically and are connected by a theorem — not by
  definition, and not obviously.
]

== The Basic Antiderivatives

#only-theory[
  Every entry in the table below is a line from last year's derivative
  table, read from right to left. Nothing here is new information; it
  is the same information, reversed.
]

#keybox(title: "Antiderivatives of the elementary functions")[
  #align(center, table(
    columns: 2,
    align: (center, center),
    stroke: 0.5pt + luma(180),
    inset: 8pt,
    [$f(x)$], [$integral f(x) dif x$],
    [$x^n$, #h(0.3em) $n eq.not -1$], [$x^(n+1) / (n + 1) + C$],
    [$1 slash x$], [$ln(abs(x)) + C$],
    [$e^x$], [$e^x + C$],
    [$b^x$], [$b^x / ln(b) + C$],
    [$sin(x)$], [$-cos(x) + C$],
    [$cos(x)$], [$sin(x) + C$],
    [$1 slash cos^2(x)$], [$tan(x) + C$],
  ))

  Together with the two structural rules
  $ integral (f(x) + g(x)) dif x
      &= integral f(x) dif x + integral g(x) dif x, \
    integral k dot f(x) dif x &= k dot integral f(x) dif x, $
  this table handles every function you can currently integrate.
]

#remark[
  The power rule entry carries an exclusion, and it is the one you
  were warned about last year. The formula
  $x^(n+1) slash (n+1)$ is undefined when $n = -1$, because it asks
  you to divide by zero — and there is genuinely no power of $x$ whose
  derivative is $1 slash x$. The gap is filled from outside the
  family, by the logarithm.

  Every integral table ever printed has this one line that looks like
  an exception. It is not an exception; it is a hole in the power
  rule, plugged.
]

#remark[
  Why $ln(abs(x))$ rather than $ln(x)$? Because $1 slash x$ is defined
  for negative $x$ too, while $ln(x)$ is not. For $x < 0$,
  differentiating $ln(-x)$ with the chain rule gives
  $ (1/(-x)) dot (-1) = 1/x, $
  so $ln(-x)$ works on the negative side and $ln(x)$ on the positive
  side. Writing $ln(abs(x))$ covers both at once.
]

=== Exercises

#ex(difficulty: 1, time: "12 min", calculator: false)[
  Find the following indefinite integrals.
  #auto-parts(
    3,
    [$integral x^3 dif x$],
    [$integral 1/t^2 dif t$],
    [$integral root(5, x^4) dif x$],
    [$integral 2 dif u$],
    [$integral (3 x^2 + 2 x + 1) dif x$],
    [$integral dif x$],
  )
][
  #auto-parts(
    3,
    [$1/4 x^4 + C$],
    [$t^(-2)$ integrates to $-t^(-1)$, so $-1/t + C$.],
    [$x^(4/5)$ integrates to $5/9 x^(9/5) + C$.],
    [$2 u + C$],
    [$x^3 + x^2 + x + C$],
    [$x + C$ — the integrand is the constant function $1$.],
  )

  Parts (b), (d) and (f) are all reminders to read the $dif$ carefully.
  In (d) the variable is $u$, and the answer must be a function of $u$.
]

#ex(difficulty: 1, time: "12 min", calculator: false)[
  Find the following indefinite integrals.
  #auto-parts(
    3,
    [$integral 2/x dif x$],
    [$integral 3 e^x dif x$],
    [$integral 1/(4 t) dif t$],
    [$integral sin(x) dif x$],
    [$integral (e^x + 1)/2 dif x$],
    [$integral cos(x) dif x$],
  )
][
  #auto-parts(
    3,
    [$2 ln(abs(x)) + C$],
    [$3 e^x + C$],
    [$1/4 ln(abs(t)) + C$],
    [$-cos(x) + C$],
    [Split the fraction: $1/2 e^x + x/2 + C$.],
    [$sin(x) + C$],
  )

  The minus sign in (d) is the single most-forgotten sign in this
  unit. Check it the way you check everything here: differentiate
  $-cos(x)$ and confirm you get $sin(x)$ back.
]

== What Has No Rule

#only-theory[
  Differentiation has four rules and they cover every combination.
  Integration does not, and it is worth being blunt about this at the
  start rather than letting you discover it one exercise at a time.

  There is *no product rule* for antiderivatives:
  $ integral f(x) dot g(x) dif x
    eq.not integral f(x) dif x dot integral g(x) dif x. $
  There is no quotient rule and no chain rule either.
]

#example(title: "A counterexample, so the claim is not merely asserted")[
  Take $f(x) = x$ and $g(x) = x$, so that
  $f(x) dot g(x) = x^2$. The left-hand side is
  $ integral x^2 dif x = 1/3 x^3 + C. $
  The right-hand side would be
  $ (1/2 x^2) dot (1/2 x^2) = 1/4 x^4, $
  and these are not the same function — not even close, since one is
  cubic and the other quartic. Differentiating $1/4 x^4$ gives $x^3$,
  not $x^2$.
]

#remark[
  This asymmetry has a real consequence: many perfectly ordinary
  functions have no antiderivative expressible in the usual symbols at
  all. The famous case is
  $ f(x) = e^(-x^2), $
  the bell curve you met in the distributions unit. It is continuous
  and well behaved and has antiderivatives — infinitely many of them —
  but none of them can be written down using powers, roots,
  exponentials, logarithms and trigonometric functions. This is a
  theorem, not a confession of ignorance.

  It is also why statistical tables of the normal distribution exist.
  The areas in them were computed numerically, one at a time, because
  no formula was available.
]

#look-ahead(
  title: "One thing does survive",
  preview: "integration rules",
)[
  The chain rule, alone among the four, does have a reverse — read
  backwards it becomes *substitution*, which is the main technique for
  computing integrals and which gets a chapter of its own later in
  this unit. The next section is the simplest case of it, and for many
  purposes it is the only case you will need.
]

== Linear Substitution

#only-theory[
  One pattern is common enough, and easy enough, to deal with now.
  Suppose you know an antiderivative $F$ of $f$, and you meet
  $f(a dot x + b)$ — the same function with a linear expression
  plugged in.

  Try the obvious guess, $F(a dot x + b)$, and differentiate it with
  the chain rule:
  $ (F(a dot x + b))' = f(a dot x + b) dot a. $
  Too big by a factor of $a$ — which is a constant, so we simply
  divide it out.
]

#keybox(title: "Linear substitution")[
  If $F$ is an antiderivative of $f$, then for constants $a eq.not 0$
  and $b$:
  $ integral f(a dot x + b) dif x = 1/a dot F(a dot x + b) + C. $

  This works *only* when the inner function is linear. For
  $integral e^(x^2) dif x$ the same manoeuvre fails, because the
  correction factor would be $2 x$, which is not a constant and cannot
  be moved outside the integral.
]

#example(title: "Three linear substitutions")[
  $ integral sqrt(6 x + 4) dif x
    = 1/6 dot 2/3 dot (6 x + 4)^(3/2) + C
    = 1/9 dot (6 x + 4)^(3/2) + C. $

  $ integral e^(-x + 1) dif x = 1/(-1) dot e^(-x + 1) + C
    = -e^(-x + 1) + C. $

  $ integral 1/(t + 2) dif t = ln(abs(t + 2)) + C, $
  where $a = 1$, so no correction is needed at all.

  Differentiate each result to check. It takes ten seconds and it is
  the only verification you will ever need.
]

=== Exercises

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: false,
  hints: (
    [Identify $f$ and the linear inner function separately, exactly as
      you did for the chain rule. Then write $F$ and divide by the
      coefficient of $x$.],
    [One of these is not a linear substitution at all. Find it before
      you start.],
  ),
)[
  Find the following indefinite integrals.
  #auto-parts(
    3,
    [$integral (3 x - 1)^4 dif x$],
    [$integral e^(2 x) dif x$],
    [$integral cos(5 x) dif x$],
    [$integral 1/(2 x + 7) dif x$],
    [$integral sqrt(1 - 4 x) dif x$],
    [$integral x dot e^(x^2) dif x$],
  )
][
  #auto-parts(
    3,
    [$1/3 dot 1/5 (3 x - 1)^5 + C = 1/15 (3 x - 1)^5 + C$],
    [$1/2 e^(2 x) + C$],
    [$1/5 sin(5 x) + C$],
    [$1/2 ln(abs(2 x + 7)) + C$],
    [$-1/4 dot 2/3 (1 - 4 x)^(3/2) + C
      = -1/6 (1 - 4 x)^(3/2) + C$],
    [Not a linear substitution — the inner function $x^2$ is not
      linear. Leave it; the general substitution rule later in this
      unit handles it, and the answer is
      $1/2 e^(x^2) + C$.],
  )

  Part (f) is the one to have noticed in advance. The presence of the
  factor $x$ outside is exactly what makes it tractable by the general
  method and exactly what a linear substitution cannot supply.
]

== Choosing the Constant

#only-theory[
  Usually we do not want the whole family — we want the one member
  passing through a particular point. One condition picks it out.
]

#example(title: "Pinning down C")[
  The derivative of $f$ is $f'(x) = 4 x^5 + 8 x$, and the graph of $f$
  passes through $(0, 8)$. Find $f$.

  Integrating,
  $ f(x) = 2/3 x^6 + 4 x^2 + C. $
  Substituting the point: $f(0) = C = 8$. So
  $ f(x) = 2/3 x^6 + 4 x^2 + 8. $

  Conditions at $x = 0$ are the pleasant ones, since every other term
  vanishes and $C$ is read off directly. A condition anywhere else
  works just as well and takes one more line.
]

=== Exercises

#ex(difficulty: 2, time: "20 min", calculator: false)[
  #auto-parts(
    1,
    [It is given that $(dif y)/(dif x) = x^4 + root(4, x)$ and that
      $y = 10$ when $x = 1$. Find $y$ in terms of $x$.],
    [If $f'(x) = 3 x^2 + 2 x$ and $f(2) = -3$, find $f(x)$.],
    [The curve $y = f(x)$ passes through $(32, 30)$, and its gradient
      is $f'(x) = 1 slash root(5, x^3)$. Find the equation of the
      curve.],
  )
][
  #auto-parts(
    1,
    [$y = 1/5 x^5 + 4/5 x^(5/4) + C$, and $1/5 + 4/5 + C = 10$ gives
      $C = 9$:
      $ y = 1/5 x^5 + 4/5 x^(5/4) + 9. $],
    [$f(x) = x^3 + x^2 + C$, and $8 + 4 + C = -3$ gives $C = -15$:
      $ f(x) = x^3 + x^2 - 15. $],
    [The gradient is $x^(-3/5)$, which integrates to
      $5/2 x^(2/5) + C$. Since
      $32^(2/5) = (2^5)^(2/5) = 2^2 = 4$, the condition reads
      $5/2 dot 4 + C = 30$, so $C = 20$:
      $ f(x) = 5/2 x^(2/5) + 20. $],
  )

  Part (c) was designed so that $32$ gives a whole number — a fifth
  root and a fifth power meeting is not an accident. Watch for that
  kind of gift; it usually means you have read the exponent
  correctly.
]

== Motion, Recovered

#only-theory[
  The most natural use of an antiderivative is the one the chapter
  opened with. If $s(t)$ is position, then $s' = v$ is velocity and
  $v' = a$ is acceleration. Reading upwards instead:
  $ a(t) --> v(t) --> s(t), $
  each step an integration, and each step needing one condition to fix
  its constant. Physically those conditions are the *initial* velocity
  and the *initial* position — which is exactly the information you
  cannot get from the acceleration alone. A car and a rocket may share
  an acceleration and be nowhere near each other.
]

#ex(difficulty: 2, time: "15 min", calculator: false)[
  The velocity of a moving object, in m/s, is
  $ v(t) = 20 - 5 t. $
  #auto-parts(
    1,
    [Find its acceleration, in m/s#super[2].],
    [The initial displacement is $5$ metres. Find an expression for
      the displacement $s$ in terms of $t$.],
    [At what time does the object reverse direction, and how far from
      the start is it then?],
  )
][
  #auto-parts(
    1,
    [$a(t) = v'(t) = -5$ m/s#super[2] — a constant deceleration.],
    [$s(t) = 20 t - 5/2 t^2 + C$, and $s(0) = 5$ gives $C = 5$:
      $ s(t) = 5 + 20 t - 5/2 t^2. $],
    [The direction reverses where the velocity changes sign, i.e.
      $20 - 5 t = 0$, so $t = 4$ s. Then
      $s(4) = 5 + 80 - 40 = 45$ m, which is $40$ m from the starting
      point.],
  )

  Part (c) is a small joint exercise in both years of calculus: the
  velocity is the derivative, so its zero is where the position is
  stationary — and here it is a maximum, since the acceleration is
  negative throughout.
]

#ex(
  difficulty: 2,
  time: "12 min",
  calculator: true,
  hints: (
    [Integrate the rate to get the population, then use the initial
      value to fix the constant.],
  ),
)[
  The rate of growth of a population of fish is
  $ (dif P)/(dif t) = 150 sqrt(t) quad "for" 0 lt.eq t lt.eq 5, $
  where $t$ is measured in years. The initial population was $200$
  fish. How many fish are there after $4$ years?
][
  Integrating $150 t^(1/2)$ gives $150 dot 2/3 dot t^(3/2) = 100
  t^(3/2)$, so
  $ P(t) = 100 t^(3/2) + C, $
  and $P(0) = 200$ gives $C = 200$. After four years,
  $ P(4) = 100 dot 8 + 200 = #num(1000) " fish". $

  Note what the model does and does not claim. It is stated only for
  $0 lt.eq t lt.eq 5$, and for good reason: $150 sqrt(t)$ grows
  without bound, so extrapolating it gives an infinite lake. Every
  growth model has a range of validity, and reading past it is the
  commonest way to get a confidently wrong answer.
]

#ai-box(role: "Checker")[
  Integration is the one topic in this course where checking your own
  work is completely reliable — differentiate the answer and see
  whether you get the integrand back. Do that for every exercise in
  this chapter before looking at any solution.

  Then try this on an AI assistant: ask it for
  $integral x dot cos(x) dif x$, which needs a technique you have not
  met. Whatever it returns, *differentiate the answer yourself* and
  check. Then ask it for
  $integral e^(-x^2) dif x$ and do the same. The second has no
  answer in elementary functions at all, and how the assistant handles
  a question with no answer is worth seeing — some say so, and some
  produce something confident and wrong.
]

#print-hints()
#print-vocab()
