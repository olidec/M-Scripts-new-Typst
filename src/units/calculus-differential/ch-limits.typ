#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Limits")
#let ex = exercise.with(chapter: "Limits")

// ── TEACHER'S NOTE ───────────────────────────────────────────
// Level split. The GLF Lehrplan (Y3 2.2) asks only that students
// "den Grenzwert einer Funktion intuitiv erklären" — no laws, no
// epsilon. The SPF Lehrplan (Y2 1.3) additionally wants "die Regeln
// für die Berechnung von Grenzwerten anwenden". So §5 (limit laws and
// indeterminate forms) and the intermediate value theorem in §4 are
// only-high; everything before that is shared.
//
// Deliberately NOT here: the epsilon-delta definition, for either
// track. Neither Lehrplan asks for it, and it costs a fortnight.
//
// Two exercises in the old LaTeX notes are answered numerically here
// via a table of values. If you are on the newer preamble (the one
// with sim-box and the notebooks/ asset pipeline), the sin(x)/x
// exploration in §3 is the natural place to swap in a Python notebook
// instead: a loop over h = 10^-1 ... 10^-15 shows both the limit AND
// the point where floating-point subtraction destroys it, which is a
// genuinely useful thing to have seen before we start dividing by h
// in the next chapter.
//
// CORRECTION carried over from the old notes: Exercise 8(d),
// lim (1-x)(x+4)/(3-x)^2, is answered 0 there. The correct value is
// -1 (both numerator and denominator have degree 2, with leading
// coefficients -1 and 1). It appears here as Exercise 3(d) with the
// corrected answer.

= Limits

#only-theory[
  Every idea in this unit is built on one word, and the word is
  *approaches*.

  You have met it before. An infinite geometric series does not reach
  its sum; the partial sums approach it. That was a statement about a
  sequence — a list of numbers indexed by $1, 2, 3, dots.h$ — and it
  was the first time in your mathematical career that an infinite
  process was given a finite answer.

  This chapter does the same thing for functions, where the input can
  slide continuously rather than stepping through the integers. The
  payoff is not the limits themselves. It is that two of the central
  objects of the rest of the course — the derivative and the definite
  integral — are *defined* as limits, and neither definition will mean
  anything until this word does.
]

#epigraph(by: "attributed to Isaac Newton")[
  These quantities I call the ultimate ratios of vanishing quantities.
]

#only-theory[
  Newton and Leibniz built calculus in the 17th century on exactly this
  intuition, and were roundly attacked for it — Bishop Berkeley called
  their vanishing quantities "the ghosts of departed quantities", which
  is both funny and fair. It took another 150 years for mathematicians
  to make the idea airtight. We will use the intuitive version, as
  Newton did, but it is worth knowing that "obvious" here was hard-won.
]

#objectives(
  [explain in your own words what
    $lim_(x -> x_0) f(x) = L$ asserts, and what it does *not* assert
    about $f(x_0)$],
  bfkm(level: "basic")[describe the asymptotic behavior of a function
    qualitatively — what happens to $f(x)$ as $x$ grows without bound],
  obj(level: "high")[describe the asymptotic behavior of a function
    qualitatively — what happens to $f(x)$ as $x$ grows without bound],
  [compute the limit of a rational function as $x -> plus.minus oo$ by
    comparing the degrees of numerator and denominator],
  [evaluate a limit at a point, including the case where direct
    substitution gives $0 slash 0$],
  [distinguish a two-sided limit from the two one-sided limits, and
    recognize when the two-sided limit fails to exist],
  [decide whether a function is continuous at a point, and classify the
    ways continuity can fail],
  obj(level: "high")[apply the limit laws, and recognize the
    indeterminate forms in which they do not apply],
  obj(level: "high")[use the intermediate value theorem to establish
    that an equation has a solution],
)

== What a Limit Is

#only-theory[
  Suppose we want to know how a function behaves *near* some value of
  $x$, without asking what it does *at* that value. That distinction
  sounds like hair-splitting. It is the whole point.
]

#definition(title: "Limit of a function")[
  Let $f$ be a function and $L$ a number. We write
  $ lim_(x -> x_0) f(x) = L $
  and say that $L$ is the #vocab("limit", "Grenzwert") of $f$ as $x$
  approaches $x_0$, if the values $f(x)$ get and stay arbitrarily close
  to $L$ whenever $x$ is close enough to $x_0$ — but not equal to it.

  If no such number $L$ exists, we say the limit *does not exist*.
]

#warning[
  Read the last four words of the definition again: *but not equal to
  it*. The limit as $x -> x_0$ is computed from the values of $f$
  near $x_0$ and never from $f(x_0)$ itself. The function need not
  even be defined at $x_0$.

  This is not a technicality to be tolerated. It is the feature that
  makes limits useful, because every derivative in this course will be
  the limit of a quotient that is $0 slash 0$ at the point of interest
  and therefore has no value there at all.
]

#example(title: "A function that never visits its own limit")[
  Let
  $ f(x) = (x^2 + 3 x) / x. $
  At $x = 0$ this is $0 slash 0$, which is not a number: $f$ is not
  defined at $0$. But for every *other* $x$ we may cancel:
  $ f(x) = (x dot (x + 3)) / x = x + 3, quad x eq.not 0. $
  So as $x$ approaches $0$, the values approach $3$:
  $ lim_(x -> 0) (x^2 + 3 x) / x = 3. $
  The graph is the line $y = x + 3$ with a single point punched out of
  it at $(0, 3)$ — and the limit tells us exactly where the missing
  point ought to go.
]

== Limits as $x$ Grows Without Bound

#only-theory[
  The first kind of limit we need is not at a point at all, but far
  away from every point. Asking what $f(x)$ does as $x$ grows without
  bound is asking for the function's #vocab("asymptotic behavior",
  "asymptotisches Verhalten") — the same question the end-behavior rule
  answered for polynomials in the previous chapter, now asked for
  every function.

  Notation: $lim_(x -> oo) f(x) = L$ means the values settle down to
  $L$ as $x$ is taken larger and larger. There is a matching statement
  for $x -> -oo$, and the two answers need not agree.
]

#exploration(title: "Reading the end behavior off a table")[
  For each function, use the table feature of your calculator to
  evaluate it at $x = 10$, $100$, $1000$, $10^6$.

  $ a(x) = (3 x^2 - 2 x) / (x^2 + 5), quad
    b(x) = (2 x - 3) / (x^2 - 1), quad
    c(x) = (x^3 - 1) / (x^2 + 1), quad
    d(x) = sin(x). $

  + Which of the four settle down to a number? Which one grows without
    bound? Which one does neither?
  + For the three rational functions, compare the *degree* of the
    numerator with the degree of the denominator in each case. Can you
    state a rule that predicts all three outcomes without computing
    anything?
  + A table can only ever be evidence, never proof. Construct a
    function whose table at $x = 10, 100, 1000, 10^6$ would fool you.
]

#keybox(title: "Limits of rational functions at infinity")[
  Let $f(x) = P(x) slash Q(x)$ with $P$ of degree $p$ and $Q$ of degree
  $q$. Divide numerator and denominator by $x^q$. Every term of the
  form $1 slash x^k$ then tends to $0$, and what survives is:

  - $p < q$: #h(0.6em) $lim_(x -> oo) f(x) = 0$.
  - $p = q$: #h(0.6em) $lim_(x -> oo) f(x) = a_p slash b_q$, the
    quotient of the two *leading* coefficients.
  - $p > q$: #h(0.6em) no limit — the values grow without bound.

  In every case, only the leading terms matter. Everything else is
  eventually negligible, exactly as in the end-behavior rule for
  polynomials.
]

#example(title: "Dividing by the highest power")[
  $ lim_(x -> oo) (2 x^2 - 5 x + 1) / (3 x^2 + 7)
    = lim_(x -> oo) (2 - 5/x + 1/x^2) / (3 + 7/x^2)
    = (2 - 0 + 0) / (3 + 0) = 2/3. $
  Dividing top and bottom by $x^2$ costs one line and turns an
  intimidating expression into an obvious one. It is worth doing
  explicitly the first few times, before trusting the shortcut.
]

#remark[
  Not every function has a limit at infinity, and "no limit" splits
  into two quite different situations. The values may grow without
  bound, as for $c(x) = (x^3 - 1) slash (x^2 + 1)$ above — we write
  $lim_(x -> oo) c(x) = oo$, which is an *abbreviation for a
  description*, not a number. Or they may simply refuse to settle, as
  $sin(x)$ does forever. Only the first case gets a symbol.
]

=== Exercises

#ex(difficulty: 1, time: "10 min", calculator: false)[
  Determine $lim_(x -> oo) f(x)$ for each function by comparing
  degrees. State which of the three cases applies.
  #auto-parts(
    3,
    [$f(x) = (x^2 + 1) / (x^2 + 2)$],
    [$f(x) = (2 x - 3) / (x^2 - 1)$],
    [$f(x) = (x^3 + x) / (2 x^2 - 1)$],
  )
][
  #auto-parts(
    3,
    [Equal degrees, so the quotient of leading coefficients:
      $1 slash 1 = 1$.],
    [Numerator of lower degree: the limit is $0$.],
    [Numerator of higher degree: no limit, the values grow without
      bound.],
  )
]

#ex(
  difficulty: 2,
  time: "20 min",
  calculator: false,
  hints: (
    [Expand or estimate the numerator and denominator first — you only
      ever need their leading terms.],
    [For (h) and (i), remember that $"sgn"(x) = 1$ for every $x > 0$,
      so as $x -> oo$ the sign function is simply the constant $1$.],
  ),
)[
  Determine $lim_(x -> oo) f(x)$, or explain why it does not exist.
  #auto-parts(
    3,
    [$f(x) = (x^2 + 1) / (x^2 + 2)$],
    [$f(x) = (2 x - 3) / (x^2 - 1)$],
    [$f(x) = (2 x - 1)^2 / (2 x^2 + 1)$],
    [$f(x) = ((1 - x) dot (x + 4)) / (3 - x)^2$],
    [$f(x) = sqrt(x^2 - 4)$],
    [$f(x) = sin(x)$],
    [$f(x) = 3^(-x)$],
    [$f(x) = x / "sgn"(x)$],
    [$f(x) = "sgn"(x) / x$],
  )
][
  #auto-parts(
    3,
    [$1$],
    [$0$],
    [$2$],
    [$-1$],
    [no limit; grows without bound],
    [no limit; the values keep oscillating between $-1$ and $1$],
    [$0$],
    [no limit; grows without bound],
    [$0$],
  )

  Part (c): expanding the numerator gives $4 x^2 - 4 x + 1$, so the
  degrees match and the answer is $4 slash 2 = 2$.

  Part (d) is the one to be careful with. The numerator expands to
  $-x^2 - 3 x + 4$ and the denominator to $x^2 - 6 x + 9$: equal
  degrees, leading coefficients $-1$ and $1$, so the limit is $-1$.
  The minus sign is easy to lose, and losing it changes the answer
  from $-1$ to $1$ without changing how plausible it looks — check the
  sign against a single large value of $x$ if you are unsure.

  Parts (f) and (i) make a useful pair: $sin(x)$ has no limit, but
  $sin(x) slash x$ does, because the numerator stays bounded while the
  denominator does not. The same argument works for
  $"sgn"(x) slash x$.
]

== Limits at a Point

#only-theory[
  Now back to a finite $x_0$. There are exactly three things that can
  happen, and knowing which one you are in tells you what to do.

  *Direct substitution works.* For every function built from
  polynomials, roots, exponentials, logarithms and sines by the usual
  operations, if $f(x_0)$ is defined then the limit is simply
  $f(x_0)$. This is not a triviality — it is precisely the statement
  that such functions are *continuous*, which is §4 — but in practice
  it means: try substituting first.

  *Substitution gives $0 slash 0$.* Then the limit may still exist,
  and the standard move is to factor the numerator and the denominator
  and cancel the offending factor. Cancelling is legitimate because
  the limit never looks at $x = x_0$ itself.

  *Substitution gives $c slash 0$ with $c eq.not 0$.* Then the values
  blow up, and the interesting question is in which direction — which
  requires looking at the two sides separately.
]

#example(title: "Factor and cancel")[
  $ lim_(x -> 1) (x^2 + 4 x - 5) / (x^2 - 1). $
  Substituting $x = 1$ gives $0 slash 0$, so both numerator and
  denominator vanish at $x = 1$ and both therefore contain the factor
  $(x - 1)$:
  $ (x^2 + 4 x - 5) / (x^2 - 1)
    = ((x + 5) dot (x - 1)) / ((x + 1) dot (x - 1))
    = (x + 5) / (x + 1), quad x eq.not 1. $
  The reduced expression is harmless at $x = 1$, so
  $ lim_(x -> 1) (x^2 + 4 x - 5) / (x^2 - 1) = 6/2 = 3. $
]

#remark[
  Notice what the $0 slash 0$ told us: not "the limit does not exist",
  but "you do not have enough information yet". A form like
  $0 slash 0$ is called #vocab("indeterminate", "unbestimmt") for
  exactly that reason — it is a signal to do more algebra, not a
  verdict.
]

=== One-Sided Limits

#definition(title: "One-sided limits")[
  The #vocab("left-hand limit", "linksseitiger Grenzwert")
  $ lim_(x -> x_0^-) f(x) $
  is the value approached when $x_0$ is approached from below only, and
  the #vocab("right-hand limit", "rechtsseitiger Grenzwert")
  $lim_(x -> x_0^+) f(x)$ likewise from above.

  The two-sided limit exists exactly when both one-sided limits exist
  *and agree*, and then all three are equal.
]

#example(title: "Two sides that disagree")[
  Let $floor(x)$ denote the greatest integer not exceeding $x$, and
  consider $f(x) = x + floor(x)$ near $x_0 = 2$.

  Just below $2$ we have $floor(x) = 1$, so $f(x)$ approaches
  $2 + 1 = 3$. Just above $2$ we have $floor(x) = 2$, so $f(x)$
  approaches $2 + 2 = 4$:
  $ lim_(x -> 2^-) f(x) = 3, quad lim_(x -> 2^+) f(x) = 4. $
  The one-sided limits both exist, and they differ. So
  $lim_(x -> 2) f(x)$ does not exist — even though $f(2) = 4$ is
  perfectly well defined. A function can have a value at a point and
  no limit there.
]

#exploration(title: "The limit that makes trigonometry differentiable")[
  Set your calculator to *radians* — this exploration is meaningless in
  degrees — and tabulate
  $ s(x) = sin(x) / x $
  at $x = 1, 0.5, 0.1, 0.01, 0.001$ and at the corresponding negative
  values.

  + What is $s(0)$? What does the table suggest about
    $lim_(x -> 0) s(x)$?
  + The answer is suspiciously clean. Look at the unit circle: for a
    small angle $x$, what are the arc length and the vertical
    coordinate, and why should their ratio approach what it does?
  + Repeat the table in degree mode. What happens to the limit, and
    what does that tell you about *why* calculus insists on radians?
  + Now push further: $x = 10^(-9)$, then $10^(-12)$, then
    $10^(-15)$. The calculator eventually stops cooperating. Explain
    what has gone wrong — and note that the same failure is waiting for
    us the moment we start dividing small differences by small numbers.
]

=== Exercises

#ex(difficulty: 1, time: "12 min", calculator: false)[
  Determine each limit. Say in each case whether direct substitution
  worked or whether more was needed.
  #auto-parts(
    3,
    [$lim_(x -> 5) (2 x - 1)$],
    [$lim_(x -> 3) x^2 / (x - 2)$],
    [$lim_(x -> 0) (x^2 + 3 x) / x$],
    [$lim_(x -> 4) (x - 4) / (x^2 - 16)$],
    [$lim_(x -> 1) (x^2 + 4 x - 5) / (x^2 - 1)$],
    [$lim_(x -> 2) (x + floor(x))$],
  )
][
  #auto-parts(
    3,
    [$9$, by substitution.],
    [$9 slash 1 = 9$, by substitution.],
    [$0 slash 0$; cancel $x$ to get $x + 3$, so the limit is $3$.],
    [$0 slash 0$; cancel $(x - 4)$ to get $1 slash (x + 4)$, so the
      limit is $1 slash 8$.],
    [$0 slash 0$; cancel $(x - 1)$ to get $(x + 5) slash (x + 1)$, so
      the limit is $3$.],
    [Does not exist: the left-hand limit is $3$ and the right-hand
      limit is $4$.],
  )
]

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: false,
  hints: (
    [In (c) and (d) the offending factor is hidden by a root or by a
      sum of fractions. Put the expression over a common denominator,
      or multiply by the conjugate.],
  ),
)[
  Determine each limit, or explain why it does not exist.
  #auto-parts(
    2,
    [$lim_(x -> -1) (x^3 + 1) / (x + 1)$],
    [$lim_(x -> 2) (x^2 - 4) / (x - 2)$],
    [$lim_(x -> 9) (sqrt(x) - 3) / (x - 9)$],
    [$lim_(x -> 0) (1/x - 1/(x^2 + x))$],
  )
][
  #auto-parts(
    2,
    [$x^3 + 1 = (x + 1) dot (x^2 - x + 1)$, so after cancelling the
      limit is $1 + 1 + 1 = 3$.],
    [$x^2 - 4 = (x - 2) dot (x + 2)$, so the limit is $4$.],
    [Write $x - 9 = (sqrt(x) - 3) dot (sqrt(x) + 3)$. Cancelling gives
      $1 slash (sqrt(x) + 3)$, so the limit is $1 slash 6$.],
    [Over a common denominator,
      $ 1/x - 1/(x^2 + x) = ((x + 1) - 1) / (x dot (x + 1))
        = x / (x dot (x + 1)) = 1 / (x + 1), $
      so the limit is $1$.],
  )

  #heuristic("introduce notation")

  Part (d) is worth a second look. Each of the two terms grows without
  bound as $x -> 0$, so the expression has the form $oo - oo$ — and
  the answer is a perfectly ordinary $1$. Two quantities can both
  explode and still have a tame difference.
]

== Continuity

#only-theory[
  We have been circling this idea since §3. A function is continuous
  at a point if nothing surprising happens there: the function has a
  value, the values nearby approach something, and the two agree.
]

#definition(title: "Continuity at a point")[
  A function $f$ is #vocab("continuous", "stetig") at $x_0$ if all
  three of the following hold:

  + $f(x_0)$ is defined;
  + $lim_(x -> x_0) f(x)$ exists;
  + the two are equal: $lim_(x -> x_0) f(x) = f(x_0)$.

  A function is continuous *on an interval* if it is continuous at
  every point of that interval.
]

#keybox(title: "The three ways continuity fails")[
  Each numbered condition can fail on its own, and each failure has a
  recognizable picture.

  #align(center, table(
    columns: 3,
    align: (left, left, left),
    stroke: 0.5pt + luma(180),
    inset: 6pt,
    [*Failure*], [*Example at $x_0 = 0$*], [*Picture*],
    [no value, but a limit],
    [$f(x) = (x^2 + 3 x) slash x$],
    [a hole (removable)],

    [one-sided limits disagree],
    [$f(x) = "sgn"(x)$],
    [a jump],

    [values grow without bound],
    [$f(x) = 1 slash x$],
    [a pole],
  ))

  Only the first is repairable: redefining $f(0) = 3$ makes the first
  example continuous, and no redefinition of a single value can fix
  either of the others.
]

#remark[
  The informal version — "you can draw the graph without lifting your
  pencil" — is a decent picture and a bad definition. It describes an
  interval, not a point, and it quietly assumes you can draw the graph
  at all. Use it to remember; use the three conditions to decide.
]

#only-high[
  === Why Continuity Earns Its Keep

  Continuity looks like a bookkeeping condition. It is in fact what
  makes a whole family of arguments legal, and the most useful of them
  is this one.

  #theorem(title: "Intermediate value theorem")[
    Let $f$ be continuous on the closed interval $[a, b]$, and let $c$
    be any number between $f(a)$ and $f(b)$. Then there is at least one
    $x_0 in [a, b]$ with $f(x_0) = c$.
  ]

  In words: a continuous function cannot get from one value to another
  without passing through everything in between. The theorem asserts
  that a solution *exists*; it says nothing about where it is or how to
  find it.

  That is still enough to be useful. To show that
  $ x^3 - x - 1 = 0 $
  has a solution, set $f(x) = x^3 - x - 1$, which is a polynomial and
  therefore continuous everywhere. Then $f(1) = -1 < 0$ and
  $f(2) = 5 > 0$, so $0$ lies between them and the theorem hands us a
  zero somewhere in $(1, 2)$. Halving the interval repeatedly —
  $f(1.5) = 0.875 > 0$, so the zero is in $(1, 1.5)$, and so on —
  narrows it as far as patience allows.

  This is the honest justification for a habit you have already used:
  hunting for a value by trying numbers and closing in. It works
  because the function is continuous, and for a discontinuous function
  it can fail outright.
]

=== Exercises

#ex(difficulty: 1, time: "10 min", calculator: false)[
  For each function, decide whether it is continuous at the given
  point. If not, say which of the three conditions fails and name the
  type of discontinuity.
  #auto-parts(
    1,
    [$f(x) = (x^2 - 1) slash (x - 1)$ at $x_0 = 1$],
    [$f(x) = 1 slash (x - 3)$ at $x_0 = 3$],
    [$f(x) = floor(x)$ at $x_0 = 2$, and at $x_0 = 2.5$],
    [$f(x) = x dot sin(x)$ at $x_0 = 0$],
  )
][
  #auto-parts(
    1,
    [Not continuous: $f(1)$ is undefined, though the limit exists and
      equals $2$. A removable discontinuity — a hole.],
    [Not continuous: $f(3)$ is undefined and the values grow without
      bound on both sides. A pole.],
    [At $x_0 = 2$: not continuous, since the left-hand limit is $1$
      and the right-hand limit is $2$ — a jump. At $x_0 = 2.5$:
      continuous, since $floor(x) = 2$ throughout a small interval
      around $2.5$.],
    [Continuous: both factors are continuous everywhere, and
      $f(0) = 0$ agrees with the limit.],
  )
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  The function $f$ is given by
  $ f(x) = cases(
    x^2 quad "for" x < 1,
    a dot x + 1 quad "for" x gt.eq 1,
  ) $
  #auto-parts(
    1,
    [Determine $a$ so that $f$ is continuous at $x_0 = 1$.],
    [For every other value of $a$, what kind of discontinuity does $f$
      have at $x_0 = 1$?],
  )
][
  #auto-parts(
    1,
    [The left-hand limit is $1^2 = 1$ and the right-hand limit — which
      is also $f(1)$ — is $a + 1$. Continuity requires $a + 1 = 1$,
      so $a = 0$.],
    [A jump: both one-sided limits exist for every $a$, but they differ
      by $a$. The size of the jump is exactly $|a|$, which is a
      pleasant way to see that $a = 0$ is the only repair.],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: true, level: "high")[
  Show that each equation has at least one solution in the given
  interval, and then locate it to one decimal place.
  #auto-parts(
    1,
    [$x^3 - x - 1 = 0$ on $[1, 2]$],
    [$cos(x) = x$ on $[0, 1]$],
    [$e^x = 3 - x$ on $[0, 2]$],
  )
][
  In each case build a continuous function, check that it changes sign
  across the interval, and invoke the intermediate value theorem.

  #auto-parts(
    1,
    [$f(x) = x^3 - x - 1$: $f(1) = -1$, $f(2) = 5$. A zero lies in
      $(1, 2)$; halving gives $x_0 approx 1.3$.],
    [$g(x) = cos(x) - x$: $g(0) = 1 > 0$, $g(1) approx -0.46 < 0$.
      A zero lies in $(0, 1)$; $x_0 approx 0.7$.],
    [$h(x) = e^x + x - 3$: $h(0) = -2 < 0$, $h(2) approx 6.39 > 0$.
      A zero lies in $(0, 2)$; $x_0 approx 0.8$.],
  )

  #heuristic("check an extreme or special case")

  The theorem guarantees *at least* one solution. In (a) there is
  exactly one, but nothing in the argument said so — that takes a
  separate argument, and the tool for it is the derivative.
]

#only-high[
  == The Limit Laws

  Everything so far has been computed by inspection. The laws below say
  when that inspection is justified: they let a limit be broken into
  the limits of its parts.

  #keybox(title: "Limit laws")[
    Suppose $lim_(x -> x_0) f(x) = A$ and $lim_(x -> x_0) g(x) = B$,
    with $A$ and $B$ both *finite*. Then

    $ lim_(x -> x_0) (f(x) + g(x)) &= A + B, \
      lim_(x -> x_0) (c dot f(x)) &= c dot A quad "for any constant" c, \
      lim_(x -> x_0) (f(x) dot g(x)) &= A dot B, \
      lim_(x -> x_0) f(x) / g(x) &= A / B quad "provided" B eq.not 0. $
  ]

  The hypothesis is what matters. Every law above requires both limits
  to exist and be finite, and the last one requires more. Applied
  outside those conditions the laws produce nonsense, and the classic
  way to produce it is to reach one of the #vocab("indeterminate forms", "unbestimmte Ausdrücke"):

  $ 0/0, quad oo/oo, quad oo - oo, quad 0 dot oo, quad 1^(oo). $

  Each of these is a *symptom*, not an answer. You have already seen
  $0 slash 0$ resolve to $3$, to $4$, and to $1 slash 6$, and
  $oo - oo$ resolve to $1$. The form alone determines nothing; the
  algebra does.

  #warning[
    A tempting piece of reasoning that is simply wrong:
    $ lim_(x -> 0) (sin(x)) / x
      = (lim_(x -> 0) sin(x)) / (lim_(x -> 0) x) = 0/0. $
    The quotient law does not apply, because its hypothesis
    $B eq.not 0$ fails. The correct value is $1$, and no rearrangement
    of the laws will produce it — that limit has to be established by
    a geometric argument about the unit circle instead.
  ]
]

#ex(
  difficulty: 3,
  time: "15 min",
  calculator: false,
  level: "high",
  hints: (
    [Multiply by $(sqrt(x^2 + x) + x) slash (sqrt(x^2 + x) + x)$ — the
      conjugate — and use $(u - v) dot (u + v) = u^2 - v^2$.],
    [After the conjugate step, divide numerator and denominator by
      $x$, remembering that $sqrt(x^2) = x$ for positive $x$.],
  ),
)[
  Determine
  $ lim_(x -> oo) (sqrt(x^2 + x) - x). $
  Before computing: which indeterminate form is this, and what would
  you have guessed the answer to be?
][
  The form is $oo - oo$. A common guess is $0$ — the two terms look
  more and more alike — and another is $oo$. Both are wrong.

  Multiplying by the conjugate:
  $ sqrt(x^2 + x) - x
    = ((x^2 + x) - x^2) / (sqrt(x^2 + x) + x)
    = x / (sqrt(x^2 + x) + x). $
  Now divide numerator and denominator by $x$, which is positive:
  $ = 1 / (sqrt(1 + 1/x) + 1) -> 1 / (1 + 1) = 1/2. $

  #heuristic("look for what stays the same")

  So $sqrt(x^2 + x)$ exceeds $x$ by an amount that neither vanishes nor
  grows: it settles at $1 slash 2$. This also says something useful
  about the graph — $y = sqrt(x^2 + x)$ has the line
  $y = x + 1 slash 2$ as an asymptote, which is exactly the kind of
  statement the next chapter is about.
]

#ai-box(role: "Tutor")[
  Instruct an AI assistant as follows: *"I am learning limits. Do not
  give me any answers. Ask me one question at a time about why
  $lim_(x -> x_0) f(x)$ does not depend on $f(x_0)$, and tell me only
  whether my answer is right or wrong."* Keep going until you can state
  the reason in one sentence without help.

  Then, separately, ask it to *evaluate* three limits of your own
  choosing that give $0 slash 0$. Check every cancellation it performs
  by hand. Models are strong at this particular manipulation, which is
  what makes an unflagged sign error in the middle of it easy to accept
  without reading.
]

#print-hints()
#print-vocab()
