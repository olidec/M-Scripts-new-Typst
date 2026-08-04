#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Curve Analysis")
#let ex = exercise.with(chapter: "Curve Analysis")

// ── TEACHER'S NOTE ───────────────────────────────────────────
// Two deliberate departures from the old LaTeX notes.
//
// 1. The FIRST derivative test is presented as the primary tool and
//    the second derivative test as a shortcut, rather than the other
//    way round. The old notes' three-row table (f'=0 with f''<0, >0,
//    =0) ends its third row with "we cannot determine the nature of f
//    at x_0 — more work is necessary", which leaves students with a
//    method that fails on x^3, x^4 and on three of the five parts of
//    old Exercise 36. The sign-change test never fails, costs no more
//    work, and explains WHY the second derivative test works.
//
// 2. Concavity is given its own section rather than appearing only as
//    a max/min criterion. The SPF Lehrplan (Y4 1.2) asks explicitly
//    that curves be analyzed "bezüglich Steigung UND Krümmungssinn",
//    and the old notes never name the second idea at all.
//
// The smiley/frowny mnemonic from the old notes is kept in §3 as text
// rather than as the scanned image (old img/ "Remember" box). If you
// want the drawn faces back, the file is worth renaming to
// concavity-smiley-mnemonic.png and dropping into images/.
//
// MOVED IN from the old §8: Exercises 66, 67 and 68 (global extrema
// of x^2 cos(x); stationary values of e^x cos(x); stationary points
// of e^(2x) sin(x)/(x+1)). They sat in the special-derivatives
// section there but need the machinery of this chapter. They form the
// applied set in §6.
//
// CORRECTION carried over from the old notes: in the worked solution
// to Exercise 36(c), the body computes f(3) = (1/3)(81 - 216 + 162)
// = 18, while the summary table on the same page gives 9. The table
// is right: 81 - 216 + 162 = 27, and 27/3 = 9.

= Curve Analysis

#only-theory[
  We now have everything needed to close the gap left open three
  chapters ago.

  By the end of the asymptotes chapter you could determine a
  function's domain, zeros, symmetry and asymptotes, and sketch a
  graph consistent with all of them. What you could not do was say
  where the graph turns around, how high it goes, or which way it
  bends between the features you had found. The derivative answers all
  three, and answering them is what German-speaking mathematicians
  call a #vocab("curve discussion", "Kurvendiskussion") — the
  systematic interrogation of a function until its graph is fully
  determined.
]

#epigraph(by: "Pierre de Fermat, 1636")[
  At the point of a maximum or a minimum, the quantity neither
  increases nor decreases.
]

#objectives(
  bfkm[determine the intervals on which a function is increasing or
    decreasing, using the sign of $f'$],
  bfkm[find and classify the stationary points of a function using the
    first or the second derivative test],
  [explain why $f'(x_0) = 0$ does not by itself guarantee an
    extremum],
  bfkm[determine where a function is concave up or concave down, and
    locate its points of inflection],
  [carry out a complete curve discussion and produce an accurate
    sketch from it],
  [find the global maximum and minimum of a continuous function on a
    closed interval],
  obj(level: "high")[analyze curves built from exponential and
    trigonometric functions, where stationary points must be located
    numerically],
)

== Increasing and Decreasing

#only-theory[
  The first connection is the one you have been using informally since
  the rate-of-change chapter, and it is worth stating once, precisely.
]

#keybox(title: "Monotonicity")[
  Let $f$ be differentiable on an interval $(a, b)$.

  - If $f'(x) > 0$ for all $x in (a, b)$, then $f$ is
    #vocab("increasing", "streng monoton wachsend") on $(a, b)$.
  - If $f'(x) < 0$ for all $x in (a, b)$, then $f$ is
    #vocab("decreasing", "streng monoton fallend") on $(a, b)$.
]

#only-theory[
  So the shape of a graph is read off the *sign* of the derivative,
  and the practical method is a sign chart: factor $f'$, find its
  zeros and any points where it is undefined, mark them on a number
  line, and determine the sign of $f'$ on each resulting interval by
  testing one convenient value.
]

#example(title: "A sign chart")[
  For $f(x) = 2 x^3 - 3 x^2 - 12 x$:
  $ f'(x) = 6 x^2 - 6 x - 12 = 6 dot (x - 2) dot (x + 1). $
  The zeros of $f'$ are $-1$ and $2$, splitting the line into three
  intervals. Testing $x = -2$, $x = 0$ and $x = 3$ gives $f'$ positive,
  negative, positive in turn. So $f$ increases on $(-oo, -1)$,
  decreases on $(-1, 2)$, and increases again on $(2, oo)$.

  Note that only the *sign* of each factor was needed, never its
  value — testing $x = -2$ gives $6 dot (-4) dot (-1)$, and one glance
  at the signs settles it.
]

#warning[
  The zeros of $f'$ break the line, but so does anything that puts $f'$
  out of action: a point where $f$ is undefined, or where $f$ is not
  differentiable. For $f(x) = 1/x$ the derivative $-1 slash x^2$ is
  negative everywhere it exists, but $f$ is *not* decreasing on
  $RR without {0}$ — the value at $x = 1$ exceeds the value at
  $x = -1$. Monotonicity statements always name an interval, and the
  interval may never straddle a hole.
]

=== Exercises

#ex(difficulty: 1, time: "15 min", calculator: false)[
  Use $f'$ to find the intervals on which $f$ is increasing or
  decreasing.
  #auto-parts(
    1,
    [$f(x) = 2 x^3 - 3 x^2 - 12 x$],
    [$f(x) = (x^2 - 4) / (x^2 - 1)$],
    [$f(x) = x^3$],
  )
][
  #auto-parts(
    1,
    [Increasing on $(-oo, -1)$ and $(2, oo)$; decreasing on
      $(-1, 2)$.],
    [The quotient rule gives a pleasant simplification:
      $ f'(x) = (2 x dot (x^2 - 1) - (x^2 - 4) dot 2 x) / (x^2 - 1)^2
        = (6 x) / (x^2 - 1)^2. $
      The denominator is positive wherever it is defined, so the sign
      of $f'$ is the sign of $x$. Decreasing on $(-oo, -1)$ and
      $(-1, 0)$; increasing on $(0, 1)$ and $(1, oo)$ — the vertical
      asymptotes at $plus.minus 1$ split the intervals even though
      $f'$ does not change sign there.],
    [$f'(x) = 3 x^2 gt.eq 0$, with equality only at $x = 0$. So $f$ is
      increasing on all of $RR$: the single horizontal tangent at the
      origin does not interrupt it, since the graph does not turn
      around there.],
  )

  Part (c) is worth arguing about in class. A horizontal tangent is
  not a place where a function stops increasing — it is a place where
  it increases *momentarily* at zero rate, which is different. The
  next section makes this precise.
]

== Stationary Points

#definition(title: "Stationary point")[
  A point $x_0$ with $f'(x_0) = 0$ is called a #vocab("stationary
  point", "stationäre Stelle") of $f$. Geometrically, the tangent at
  $x_0$ is horizontal.
]

#warning[
  A stationary point need not be a maximum or a minimum. The function
  $f(x) = x^3$ has $f'(0) = 0$ and is increasing on both sides of the
  origin; the graph flattens, thinks better of it, and carries on
  upwards. Such a point is called a #vocab("saddle point",
  "Sattelpunkt") — or, more descriptively in German, a
  _Terrassenpunkt_.

  So $f'(x_0) = 0$ is a *necessary* condition for a local extremum at a
  differentiable point, never a sufficient one. Finding the stationary
  points is step one; classifying them is step two, and skipping step
  two is the most common error in this material.
]

#keybox(title: "First derivative test")[
  Let $x_0$ be a stationary point of $f$. Look at the sign of $f'$
  immediately to the left and to the right of $x_0$:

  - $+$ then $-$: #h(0.5em) the function rises then falls — a
    #vocab("local maximum", "lokales Maximum") at $x_0$.
  - $-$ then $+$: #h(0.5em) the function falls then rises — a
    #vocab("local minimum", "lokales Minimum") at $x_0$.
  - no sign change: #h(0.5em) a saddle point.

  This test never fails and needs nothing beyond the sign chart you
  have already drawn.
]

#example(title: "Classifying with a sign chart")[
  For $f(x) = 2 x^3 - 3 x^2 - 12 x$ we found $f'$ positive, negative,
  positive across $x = -1$ and $x = 2$.

  At $x = -1$ the sign goes $+ -> -$: a local maximum, at
  $f(-1) = -2 - 3 + 12 = 7$, so the point $(-1, 7)$.

  At $x = 2$ the sign goes $- -> +$: a local minimum, at
  $f(2) = 16 - 12 - 24 = -20$, so the point $(2, -20)$.
]

=== Exercises

#ex(difficulty: 2, time: "18 min", calculator: false)[
  Use $f'$ to find and classify every point on the graph of $f$ with a
  horizontal tangent.
  #auto-parts(
    1,
    [$f(x) = 2 x^3 - 3 x^2 - 12 x$],
    [$f(x) = (x^2 - 4) / (x^2 - 1)$],
    [$f(x) = x^3$],
  )
][
  #auto-parts(
    1,
    [Local maximum at $(-1, 7)$, local minimum at $(2, -20)$.],
    [$f'(x) = 6 x slash (x^2 - 1)^2 = 0$ only at $x = 0$, where the
      sign changes from $-$ to $+$: a local minimum at
      $f(0) = (-4) slash (-1) = 4$, so the point $(0, 4)$.],
    [$f'(x) = 3 x^2 = 0$ at $x = 0$, with no sign change: a saddle
      point at the origin.],
  )
]

== Concavity and the Second Derivative

#only-theory[
  Slope is not the only thing a graph does. Two functions can both be
  increasing over an interval and look nothing alike: one may bend
  upwards, accelerating away, while the other bends downwards and
  levels off. That distinction is the
  #vocab("concavity", "Krümmungssinn"), and it is governed by $f''$ in
  exactly the way the slope is governed by $f'$.

  The reasoning is one step of the same argument. $f''$ is the
  derivative of $f'$, so where $f'' > 0$ the *slope* is increasing:
  the graph gets steadily steeper, which is what bending upwards
  means.
]

#keybox(title: "Concavity")[
  - $f''(x) > 0$ on an interval: $f$ is
    #vocab("concave up", "linksgekrümmt") there. The slope is
    increasing; the graph curves like a valley.
  - $f''(x) < 0$ on an interval: $f$ is
    #vocab("concave down", "rechtsgekrümmt") there. The slope is
    decreasing; the graph curves like a hill.

  A mnemonic that survives exam pressure: draw the two faces. Concave
  up is a smile — and a smile is where a *minimum* sits. Concave down
  is a frown, and that is where a *maximum* sits.
]

#keybox(title: "Second derivative test")[
  Let $x_0$ be a stationary point of $f$, so $f'(x_0) = 0$.

  - $f''(x_0) < 0$: #h(0.5em) local maximum at $x_0$.
  - $f''(x_0) > 0$: #h(0.5em) local minimum at $x_0$.
  - $f''(x_0) = 0$: #h(0.5em) *the test says nothing.* Fall back on
    the first derivative test.

  This is a shortcut, not a replacement: it usually saves work, and
  when it fails it fails silently.
]

#remark[
  Why the shortcut works is worth seeing rather than memorizing. If
  $f'(x_0) = 0$ and $f''(x_0) < 0$, then $f'$ is decreasing at $x_0$
  — so $f'$ passes through zero from above, going $+ -> -$, which is
  precisely the first derivative test's condition for a maximum. The
  second derivative test is the first derivative test, with the sign
  change detected by a derivative instead of by inspection.

  And now the third case is no longer mysterious. If $f''(x_0) = 0$,
  nothing has been learned about whether $f'$ changes sign — it may
  ($f(x) = x^4$ at the origin, a minimum) or it may not
  ($f(x) = x^3$, a saddle). The two functions are indistinguishable to
  this test and completely different in fact.
]

== Points of Inflection

#definition(title: "Point of inflection")[
  A #vocab("point of inflection", "Wendepunkt") is a point at which the
  concavity of the graph changes — from concave up to concave down, or
  the reverse. It is the point at which the graph stops bending one way
  and starts bending the other.
]

#keybox(title: "Finding points of inflection")[
  + Solve $f''(x) = 0$. These are the *candidates*.
  + For each candidate, check that $f''$ actually *changes sign*
    there. If it does, the point is an inflection point; if not, it is
    not.

  The second step is not optional. For $f(x) = x^4$ we have
  $f''(x) = 12 x^2$, which vanishes at $x = 0$ but is positive on both
  sides — the graph is concave up throughout and has no inflection
  point at all.
]

#remark[
  A point that is *both* stationary and an inflection point — where
  $f'(x_0) = 0$ and the concavity changes — is exactly the saddle
  point of §2. The tangent there is horizontal and the graph crosses
  it. $f(x) = x^3$ at the origin is the standard example, and this is
  why the second derivative test could say nothing about it: at a
  saddle, $f''(x_0) = 0$ necessarily.
]

#example(title: "All three ideas at once")[
  Let $f(x) = 1/3 dot (4 x^3 - x^4)$.

  *Derivatives.*
  $ f'(x) = 1/3 dot (12 x^2 - 4 x^3) = (4 x^2 dot (3 - x)) / 3, quad
    f''(x) = 1/3 dot (24 x - 12 x^2) = 4 x dot (2 - x). $

  *Zeros of $f$.* $1/3 dot x^3 dot (4 - x) = 0$ gives $x = 0$ (triple)
  and $x = 4$.

  *Stationary points.* $f'(x) = 0$ at $x = 0$ and $x = 3$.

  At $x = 3$: $f''(3) = 4 dot 3 dot (-1) = -12 < 0$, so a local
  maximum at $(3, 9)$.

  At $x = 0$: $f''(0) = 0$, so the second derivative test is silent.
  Fall back on the first: $f'(x) = 4 x^2 (3 - x) slash 3$ is
  non-negative on both sides of $0$, so $f'$ does not change sign — a
  saddle point at the origin.

  *Inflection points.* $f''(x) = 0$ at $x = 0$ and $x = 2$, and
  $f'' = 4 x (2 - x)$ changes sign at both. So $(0, 0)$ and
  $(2, 16/3)$ are inflection points — and $(0,0)$ is the saddle,
  appearing in both lists as it must.
]

#ex(difficulty: 2, time: "15 min", calculator: false, level: "high")[
  For polynomials $p$ of degree $1$ to $5$, answer the following. Give
  the largest and the smallest possible number in each case, and an
  example achieving each.
  #auto-parts(
    1,
    [How many zeros can $p$ have at most? At least?],
    [How many local maxima can $p$ have at most? At least?],
    [How many points of inflection can $p$ have at most? At least?],
  )
][
  Let $n = deg p$.

  *Zeros.* At most $n$, since $p$ has at most $n$ factors. At least
  $1$ if $n$ is odd (the end behavior forces a sign change) and at
  least $0$ if $n$ is even — $p(x) = x^2 + 1$ has none.

  *Local maxima.* $p'$ has degree $n - 1$, so at most $n - 1$
  stationary points, of which at most $floor(n slash 2)$ can be
  maxima — maxima and minima must alternate. At least $0$: $x^n$ for
  odd $n$, or $x^2$, have none.

  *Inflection points.* $p''$ has degree $n - 2$, so at most $n - 2$
  candidates and at most $n - 2$ inflection points. At least $1$ if
  $n$ is odd and $n gt.eq 3$ (the concavity must reverse, since
  $p''$ has odd degree and therefore a sign change), and at least $0$
  otherwise.

  #heuristic("try small cases")

  The pattern to draw out: each derivative costs one degree, so each
  question about $p^((k))$ is the same question one degree down. Fill
  in the table for $n = 1, dots.h, 5$ before generalizing.
]

== The Full Curve Discussion

#keybox(title: "A complete curve discussion")[
  + *Domain*, and any points of discontinuity.
  + *Symmetry*: even, odd, or neither.
  + *Zeros* of $f$, and the $y$\u{2011}intercept.
  + *Asymptotes*: vertical, then horizontal or oblique.
  + *First derivative*: sign chart, monotonic intervals, stationary
    points, classified.
  + *Second derivative*: concavity, points of inflection.
  + *Range*, which usually follows from steps 5 and 6.
  + *Sketch*, consistent with everything above.

  Work in this order. Each step constrains the sketch further, and by
  step 8 there is usually only one curve that fits.
]

=== Exercises

#ex(
  difficulty: 2,
  time: "60 min",
  calculator: false,
  hints: (
    [Factor $f'$ and $f''$ completely before doing anything with them.
      An unfactored quadratic tells you nothing about signs.],
    [When the second derivative test returns $0$, do not guess. Go
      back to the sign of $f'$ on either side.],
  ),
)[
  Determine the zeros, stationary points (classified), and points of
  inflection of each function, and use them to draw its graph.
  #auto-parts(
    1,
    [$f: y = 1/3 dot (4 x^3 - x^4)$],
    [$f: y = 1/5 dot (x^3 - 3 x^2 - 9 x + 2)$],
    [$f: y = 1/3 dot (x^4 - 8 x^3 + 18 x^2)$],
    [$f: y = (6 x^2 - x^4) / 2$],
    [$f: y = (12 x - x^3) / 4$],
  )
][
  #auto-parts(
    1,
    [Worked in the example above. Zeros $0$ (triple) and $4$; saddle
      and inflection at $(0, 0)$; inflection at $(2, 16/3)$; local
      maximum at $(3, 9)$.],
    [$f' = 3 dot (x - 3) dot (x + 1) slash 5$ and
      $f'' = 6 dot (x - 1) slash 5$.
      Zeros: $x = -2$ is a root, and dividing out gives
      $x^2 - 5 x + 1$, so also $x = (5 plus.minus sqrt(21)) slash 2$.
      Local maximum at $(-1, 7/5)$; local minimum at $(3, -5)$;
      inflection at $(1, -9/5)$.],
    [$f' = 4 x dot (x - 3)^2 slash 3$ and
      $f'' = 4 dot (x - 1) dot (x - 3)$.
      Zeros: $x^2 dot (x^2 - 8 x + 18) slash 3$, and the quadratic has
      discriminant $64 - 72 < 0$, so the only real zero is $x = 0$
      (double). Local minimum at $(0, 0)$ by the second derivative
      test, since $f''(0) = 12 > 0$. At $x = 3$ we get $f''(3) = 0$
      and $f'$ does not change sign, so a saddle point at $(3, 9)$.
      Inflection points at $(1, 11/3)$ and $(3, 9)$.],
    [$f' = 2 x dot (3 - x^2)$ and
      $f'' = 6 dot (1 - x) dot (1 + x)$.
      Zeros $0$ (double) and $plus.minus sqrt(6)$. Local minimum at
      $(0, 0)$; local maxima at $(plus.minus sqrt(3), 9/2)$;
      inflection points at $(plus.minus 1, 5/2)$. The function is
      even, which halves the work.],
    [$f' = 3 dot (2 - x) dot (2 + x) slash 4$ and $f'' = -3 x slash 2$.
      Zeros $0$ and $plus.minus 2 sqrt(3)$. Local maximum at
      $(2, 4)$; local minimum at $(-2, -4)$; inflection at the origin.
      The function is odd.],
  )

  Part (c) is the one that punishes the second derivative test twice
  over: it succeeds at $x = 0$ and fails at $x = 3$, and the point it
  fails at is the interesting one. Note also that $(3, 9)$ appears in
  two lists — it is a saddle, so it is both stationary and an
  inflection point.
]

#ex(difficulty: 2, time: "40 min", calculator: true)[
  Sketch the graph of each function and determine the domain and
  range, the zeros, the equations of all asymptotes, the local extrema,
  and the points of inflection.
  #auto-parts(
    2,
    [$f(x) = 3 x^2 + 10 x - 8$],
    [$f(x) = x^3 + x^2 - 5 x - 5$],
    [$f(x) = (x + 2) / (x - 4)$],
    [$f(x) = (3 - x)^4$],
  )
][
  #auto-parts(
    1,
    [Domain $RR$, range $[-49/3, oo)$; zeros $x = -4$ and
      $x = 2/3$; no asymptotes; local minimum at $(-5/3, -49/3)$; no
      inflection points, since $f'' = 6$ never changes sign.],
    [Domain $RR$, range $RR$; the polynomial factors as
      $(x + 1) dot (x^2 - 5)$, so the zeros are $-1$ and
      $plus.minus sqrt(5)$; no asymptotes; local maximum at
      $(-5/3, 40/27)$, local minimum at $(1, -8)$; inflection at
      $(-1/3, -88/27)$.],
    [Domain $RR without {4}$, range $RR without {1}$; zero at
      $x = -2$; vertical asymptote $x = 4$ and horizontal asymptote
      $y = 1$. Since $f'(x) = -6 slash (x - 4)^2 < 0$ everywhere, there
      are no stationary points and no extrema, and $f''$ never
      vanishes, so no inflection points either.],
    [Domain $RR$, range $[0, oo)$; a single zero at $x = 3$ with
      multiplicity $4$; no asymptotes; local minimum at $(3, 0)$. No
      inflection points: $f'' = 12 dot (3 - x)^2 gt.eq 0$ vanishes at
      $x = 3$ but does not change sign there.],
  )

  Parts (a), (c) and (d) each contain a candidate that fails the
  sign-change test, in three different ways. Collect them.
]

#ex(
  difficulty: 3,
  time: "25 min",
  calculator: false,
  hints: (
    [Restricting to $x gt.eq 0$ removes half the algebra. Do that part
      first and use the symmetry afterwards.],
    [For the inflection points you will need $f''$; the quotient rule
      applied to $f'$ is unpleasant but the result factors.],
  ),
)[
  Consider
  $ y = x / (1 + x^2). $
  #auto-parts(
    1,
    [For $x gt.eq 0$, find the coordinates of the stationary point,
      the points of inflection, and all asymptotes.],
    [Show that the function is odd.],
    [Hence sketch the graph for all real $x$, and state the range.],
  )
][
  #auto-parts(
    1,
    [The quotient rule gives
      $ y' = (1 - x^2) / (1 + x^2)^2, $
      which vanishes at $x = 1$ and changes from $+$ to $-$ there: a
      local maximum at $(1, 1/2)$. Differentiating again and factoring,
      $ y'' = (2 x dot (x^2 - 3)) / (1 + x^2)^3, $
      which vanishes at $x = 0$ and $x = sqrt(3)$ on this range, with a
      sign change at each: inflection points at $(0, 0)$ and at
      $(sqrt(3), sqrt(3)/4)$. Since the degree of the numerator is
      less than that of the denominator, the horizontal asymptote is
      $y = 0$; the denominator never vanishes, so there is no vertical
      asymptote.],
    [$f(-x) = (-x) slash (1 + x^2) = -f(x)$, since the denominator is
      unchanged by the substitution. So $f$ is odd.],
    [Reflect the right half through the origin: a local minimum at
      $(-1, -1/2)$, a third inflection point at
      $(-sqrt(3), -sqrt(3)/4)$, and the same asymptote $y = 0$ on the
      left. The range is $[-1/2, 1/2]$ — the two extrema are global,
      which the asymptote makes plausible and the sign chart
      confirms.],
  )

  #heuristic("look for what stays the same")

  Part (b) is the labour-saving step, and doing it *first* would have
  been smarter than doing it second. Odd symmetry means every feature
  found on the right has a mirror image on the left, so half the
  computation was never necessary.
]

== Global Extrema on a Closed Interval

#only-theory[
  Everything so far has been *local*: a local maximum is higher than
  its immediate neighbours and need not be the highest point anywhere.
  For applications — and for the optimization problems of the next
  chapter — what is usually wanted is the global maximum or minimum
  over some interval.

  On a *closed* interval $[a, b]$ and for a *continuous* function, the
  answer is guaranteed to exist and is easy to find, because there are
  only two kinds of place it can be.
]

#keybox(title: [Finding global extrema on $[a, b]$])[
  A continuous function on a closed interval attains a global maximum
  and a global minimum. Each occurs either

  - at a stationary point inside the interval, or
  - at one of the two endpoints $a$, $b$.

  So: list every stationary point in $(a, b)$, add $a$ and $b$,
  evaluate $f$ at all of them, and compare the values. No
  classification is needed — the comparison does the work.
]

#warning[
  Both hypotheses are doing real work. Drop *closed* and there may be
  no maximum at all: $f(x) = x$ on $(0, 1)$ gets arbitrarily close to
  $1$ and never attains it. Drop *continuous* and the same thing can
  happen at an interior point.

  Note also that the endpoints are not stationary points and will
  never be found by solving $f'(x) = 0$. Forgetting to check them is
  the standard way to lose marks on this kind of question, and the
  first exercise below is built to make that happen once, cheaply.
]

#ex(
  difficulty: 2,
  time: "20 min",
  calculator: true,
  hints: (
    [Solve $f'(x) = 0$ numerically — these equations have no closed
      form. Then evaluate $f$ at every solution *and* at both
      endpoints.],
  ),
)[
  #auto-parts(
    1,
    [Let $f(x) = x^2 dot cos(x)$. Find the global maximum and minimum
      of $f$ on $[0, 5]$.],
    [Find and classify all stationary points of
      $y = e^x dot cos(x)$ on $0 lt.eq x lt.eq 2 pi$.],
    [Find the stationary points of
      $ y = (e^(2 x) dot sin(x)) / (x + 1) $
      for $0 < x < pi$.],
  )
][
  #auto-parts(
    1,
    [$f'(x) = 2 x cos(x) - x^2 sin(x)$, whose zeros in $[0, 5]$ are
      $x = 0$, $x approx 1.077$ and $x approx 3.644$. Evaluating there
      and at both endpoints:
      $f(0) = 0$, $f(1.077) approx 0.55$,
      $f(3.644) approx -11.64$, $f(5) approx 7.09$.

      So the global minimum is about $-11.64$ and the global maximum
      is about $7.09$ — *at the endpoint $x = 5$*, which is not a
      stationary point at all.],
    [$y' = e^x dot (cos(x) - sin(x))$, and since $e^x eq.not 0$ this
      vanishes where $tan(x) = 1$, i.e. at $x = pi/4$ and
      $x = (5 pi)/4$. The first is a maximum, with
      $y = e^(pi/4) slash sqrt(2) approx 1.55$; the second is a
      minimum, with $y = -e^((5 pi)/4) slash sqrt(2) approx -35.9$.],
    [Setting the numerator of $y'$ to zero and solving numerically
      gives a single stationary point at $x approx 2.62$.],
  )

  Part (a) is the point of the exercise. Its largest value on the
  interval is at an endpoint, so a solution that lists only the
  stationary points misses it entirely — and misses it in a way that
  looks completely reasonable on the page.
]

#exploration(title: "A catalog of curves")[
  Sketch as many *essentially different* examples as you can of each of
  the following. Continuous curves with

  + exactly one stationary point and exactly two zeros;
  + exactly two stationary points and exactly two zeros;
  + exactly one stationary point and exactly one zero;
  + exactly two stationary points and exactly one zero.

  Once you have a feel for it, turn your sketches into a *catalog*:
  for each case, describe the distinct types you found in clear
  mathematical language, and argue that your list is complete. Which
  of the four cases has the most types, and why?
]

#ai-box(role: "Checker")[
  Work one part of the long curve-discussion exercise completely on
  paper — all eight steps, including the sketch. Then give an AI
  assistant the same function and ask for a full curve discussion, and
  compare step by step.

  The specific thing to test: hand it part (c) of that exercise,
  $f(x) = 1/3 (x^4 - 8 x^3 + 18 x^2)$, whose stationary point at
  $x = 3$ has $f''(3) = 0$. Does the assistant notice that the second
  derivative test fails there and fall back on the sign of $f'$, or
  does it quietly report an extremum? This is a good diagnostic
  because the correct answer requires noticing that a method has
  broken down, which is a different skill from applying the method.
]

#print-hints()
#print-vocab()
