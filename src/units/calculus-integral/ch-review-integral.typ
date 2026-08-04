#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Review and Synthesis")
#let ex = exercise.with(chapter: "Review and Synthesis")

// ── TEACHER'S NOTE ───────────────────────────────────────────
// §5 finally poses the three examination questions COMPLETE. Last
// year's review chapter took only their differentiation parts (old
// Ex 100(a), 101(a), 102(a)) and deferred the rest; the area, ratio
// and volume parts appear here, with the differentiation results
// quoted rather than re-derived so the questions read as they
// originally did. If your class did the differential unit from these
// notes, they have already seen the first part of each and should be
// told so — recognizing a question you have half-solved before is a
// useful experience and a rare one.
//
// §6 is the four-part parameter set (old Ex 95-98) that was pulled
// out of the differential unit's ch-inverse-problems because every
// one of them asks for a parameter making an AREA maximal or equal to
// a given value. They belong here and they are the best available
// practice at combining the two years: an integral produces a
// function of the parameter, and a derivative then optimizes it.
//
// §4 is INTERLEAVED and its value depends on the technique not being
// announced — see the same note in the differential unit's review.
// Do not sort by type. Note that the basic and high versions of that
// exercise differ: parts (g)-(i) are level: "high" because they need
// substitution notation or parts.

= Review and Synthesis

#only-theory[
  This unit began with a question about recovering a quantity from its
  rate of change, and a second, apparently unrelated question about
  the area of a region with a curved boundary. It turned out that
  these were the same question.

  That is the whole content of the year, and everything else —
  antiderivatives, Riemann sums, substitution, volumes — is either
  preparation for that statement or a consequence of it.
]

#objectives(
  [state the fundamental theorem and explain in your own words why it
    is true],
  [find antiderivatives of the elementary functions and of the
    combinations you can integrate],
  [evaluate definite integrals and use them to compute areas and
    volumes],
  [set up an integral from a verbal or geometric description],
  [determine a parameter from a condition on an area or a volume],
)

== The Shape of the Unit

#only-theory[
  Three movements.

  *The two halves of the problem* (chapters 1–2). Antiderivatives, by
  running differentiation backwards; and the definite integral, by
  chopping a region into rectangles and taking a limit. Deliberately
  presented as unrelated, sharing only a symbol whose resemblance was
  flagged as unexplained.

  *The bridge* (chapter 3). The area function $A(x) = integral_a^x f$
  has derivative $f$ — so accumulating area undoes differentiation, and
  every definite integral can be evaluated by finding one
  antiderivative and subtracting. This is the fundamental theorem, and
  it is why the two halves share a symbol.

  *The consequences* (chapters 4–7). Areas between curves; techniques
  for finding antiderivatives, since the theorem reduced everything to
  that; volumes of solids of revolution; and — for the advanced course
  — integrals over infinite regions.
]

== One Page

#keybox(title: "The two definitions")[
  $ integral f(x) dif x = F(x) + C
    quad "where" quad F' = f $
  — a *family of functions*, the antiderivatives of $f$.

  $ integral_a^b f(x) dif x
    = lim_(n -> oo) sum_(k = 1)^n f(x_k^*) dot Delta x $
  — a *number*, the signed area between the graph and the axis.
]

#keybox(title: "The fundamental theorem")[
  $ (dif)/(dif x) integral_a^x f(t) dif t = f(x) $
  and, for any antiderivative $F$ of $f$,
  $ integral_a^b f(x) dif x = F(b) - F(a) = [F(x)]_a^b. $
  No $+ C$ is needed in the second: the constants cancel.
]

#keybox(title: "The basic antiderivatives")[
  #align(center, table(
    columns: 4,
    align: (center, center, center, center),
    stroke: 0.5pt + luma(180),
    inset: 7pt,
    [$f(x)$], [$integral f dif x$], [$f(x)$], [$integral f dif x$],
    [$x^n$, $n eq.not -1$], [$x^(n+1)/(n+1)$],
    [$sin(x)$], [$-cos(x)$],
    [$1 slash x$], [$ln(abs(x))$], [$cos(x)$], [$sin(x)$],
    [$e^x$], [$e^x$], [$1 slash cos^2(x)$], [$tan(x)$],
    [$b^x$], [$b^x slash ln(b)$], [$(f'(x)) slash (f(x))$],
    [$ln(abs(f(x)))$],
  ))
  Every entry needs $+ C$. Sums and constant multiples split as you
  would expect; products, quotients and compositions do not.
]

#keybox(title: "Applications")[
  - Area between graph and axis: split at the zeros, add the absolute
    values.
  - Area between two curves:
    $integral_a^b ("upper" - "lower") dif x$, with $a$, $b$ the
    intersection points.
  - Net change: $integral_a^b F'(x) dif x = F(b) - F(a)$. Velocity
    integrates to displacement; $abs("velocity")$ to distance.
  - Volume of revolution about the $x$\u{2011}axis:
    $V = pi integral_a^b (f(x))^2 dif x$; with a cavity,
    $pi integral (f^2 - g^2) dif x$.
]

== The Thread: Chop, Approximate, Sum, Take the Limit

#only-theory[
  One argument has appeared three times in this unit, and it is the
  argument worth carrying away.

  To find a quantity that accumulates continuously: cut the region or
  interval into many small pieces; approximate the contribution of
  each piece by something you can compute; add them up; and take the
  limit as the pieces shrink.

  In chapter 2 the pieces were rectangles and the quantity was an
  area. In chapter 6 the pieces were discs and the quantity was a
  volume. In chapter 3, read as net change, the pieces were small
  increments and the quantity was the total change in a function. The
  same four steps, three times.

  This is what an integral *is*. "The opposite of a derivative" is a
  theorem about integrals, not their meaning — and it is worth
  knowing which of those two statements is the definition, because
  every new application you meet (arc length, work, centre of mass,
  probability) will be built by the four steps and not by
  antidifferentiation.
]

#keybox(title: "Translating both ways")[
  #align(center, table(
    columns: 2,
    align: (left, left),
    stroke: 0.5pt + luma(180),
    inset: 6pt,
    [*Analytically*], [*Geometrically*],

    [$integral_a^b f(x) dif x > 0$],
    [more of the region lies above the axis than below],

    [$integral_a^b f(x) dif x = 0$],
    [the parts above and below cancel exactly],

    [$F' = f$ and $F$ is increasing],
    [$f$ is positive there],

    [$integral_a^b (f - g) dif x$],
    [the area trapped between two curves],

    [$pi integral_a^b f^2 dif x$],
    [the volume swept out by rotating the region],

    [$integral_1^(oo) f$ converges],
    [an unbounded region with finite area],
  ))
]

== Mixed Practice

#only-theory[
  Every exercise set in this unit has appeared under a heading naming
  the technique. Real problems do not arrive labelled, and choosing a
  method is a separate skill from executing one.

  Before touching any of these, decide what kind of problem it is and
  write that down.
]

#ex(
  difficulty: 2,
  time: "35 min",
  calculator: false,
  hints: (
    [Ask the same question every time: is the integrand a standard
      form, or is it a composite with the derivative of its inner
      function present?],
    [Two of these are quicker after rewriting than by any technique.],
  ),
)[
  Integrate. The methods are not in any particular order.
  #auto-parts(
    3,
    [$integral (3 x^2 - 4 x + 1) dif x$],
    [$integral e^(3 x) dif x$],
    [$integral x dot sqrt(x^2 + 4) dif x$],
    [$integral (x^3 + 2)/x dif x$],
    [$integral (2 x) / (x^2 + 7) dif x$],
    [$integral sin(2 x) dif x$],
    [$integral (ln(x))^2 / x dif x$],
    [$integral x dot ln(x) dif x$],
    [$integral (x) / sqrt(4 - x^2) dif x$],
  )
][
  #auto-parts(
    3,
    [$x^3 - 2 x^2 + x + C$],
    [Linear inner function: $1/3 e^(3 x) + C$],
    [Guess $(x^2 + 4)^(3/2)$, adjust:
      $1/3 (x^2 + 4)^(3/2) + C$],
    [Split first: $x^2 + 2/x$, so
      $1/3 x^3 + 2 ln(abs(x)) + C$],
    [Derivative over function: $ln(x^2 + 7) + C$],
    [Linear inner function: $-1/2 cos(2 x) + C$],
    [$u = ln(x)$: #h(0.4em) $1/3 (ln(x))^3 + C$],
    [Parts, $u = ln(x)$, $v' = x$: #h(0.4em)
      $1/2 x^2 ln(x) - 1/4 x^2 + C$],
    [$u = 4 - x^2$: #h(0.4em) $-sqrt(4 - x^2) + C$],
  )

  Parts (d) and (a) need no technique at all — (d) only wants the
  fraction split term by term, which is the single most
  under-used simplification in this unit.
]

#ex(
  difficulty: 3,
  time: "40 min",
  calculator: true,
  hints: (
    [Each part belongs to a different chapter. Name the chapter before
      starting.],
  ),
)[
  Four unrelated problems.
  #auto-parts(
    1,
    [Calculate the area enclosed between the graph of
      $f(x) = x^3 - 4 x$ and the $x$\u{2011}axis.],
    [The velocity of an object is $v(t) = 3 t^2 - 12$ m/s. Find its
      displacement and the total distance travelled between $t = 0$
      and $t = 3$ seconds.],
    [The region bounded by $y = sqrt(x)$, the $x$\u{2011}axis and
      $x = 4$ is rotated about the $x$\u{2011}axis. Find the volume of
      the resulting solid.],
    [Find the area enclosed between $y = x^2$ and $y = 4 - x^2$.],
  )
][
  #auto-parts(
    1,
    [*Areas, ch. 4.* Zeros at $-2$, $0$, $2$. The two pieces give
      $+4$ and $-4$, so the area is $8$ — not $0$, which is what a
      single integral from $-2$ to $2$ would return.],
    [*Net change, ch. 3.* Displacement is
      $integral_0^3 (3 t^2 - 12) dif t = [t^3 - 12 t]_0^3 = -9$ m.
      For distance, $v = 0$ at $t = 2$, so split:
      $integral_0^2 v = -16$ and $integral_2^3 v = 7$, giving
      $16 + 7 = 23$ m.],
    [*Solids, ch. 6.*
      $V = pi integral_0^4 x dif x = pi [1/2 x^2]_0^4 = 8 pi$.],
    [*Areas, ch. 4.* They meet where $x^2 = 4 - x^2$, i.e.
      $x = plus.minus sqrt(2)$; between them $4 - x^2$ is upper:
      $ integral_(-sqrt(2))^(sqrt(2)) (4 - 2 x^2) dif x
        = (16 sqrt(2))/3 approx 7.54. $],
  )

  Part (b) makes the year's most examinable distinction concrete: the
  object ends up $9$ m *behind* where it started, having travelled
  $23$ m to get there.
]

== Examination Questions

#only-theory[
  The three questions below were begun in last year's review chapter,
  where only their differentiation parts could be answered. Here they
  appear complete, as they were originally set.
]

#ex(
  difficulty: 3,
  time: "25 min",
  calculator: true,
  hints: (
    [For (c), let the stripe run from $t$ to $t + 1$ and write the
      area as a function of $t$. Then differentiate it.],
    [Differentiating $integral_t^(t+1) f(x) dif x$ with respect to $t$
      gives $f(t + 1) - f(t)$, by the fundamental theorem.],
  ),
)[
  #emph[(Final examination, 1986.)] Given
  $ f: y = x^2 - 1/6 x^3. $
  #auto-parts(
    1,
    [Determine the zeros, extrema and points of inflection of the
      graph of $f$. #emph[(Answered last year: zeros at $0$ (double)
      and $6$; minimum $(0, 0)$; maximum $(4, 16/3)$; inflection
      $(2, 8/3)$.)]],
    [Calculate the area enclosed by the graph of $f$ and the
      $x$\u{2011}axis in the first quadrant.],
    [A vertical stripe of width $1$ is placed somewhere between the
      zeros so that the area enclosed by the sides of the stripe, the
      graph of $f$ and the $x$\u{2011}axis is maximal. Determine the
      position of the stripe and the maximal area.],
  )
][
  #auto-parts(
    1,
    [Quoted in the question.],
    [The graph is above the axis between $0$ and $6$:
      $ integral_0^6 (x^2 - 1/6 x^3) dif x
        = [1/3 x^3 - 1/24 x^4]_0^6 = 72 - 54 = 18. $],
    [Let the stripe run from $t$ to $t + 1$, so
      $ A(t) = integral_t^(t + 1) f(x) dif x. $
      By the fundamental theorem, $A'(t) = f(t + 1) - f(t)$, and
      setting this to zero:
      $ (2 t + 1) - ((3 t^2 + 3 t + 1)) / 6 = 0
        quad ==> quad 3 t^2 - 9 t - 5 = 0, $
      giving $t = (9 + sqrt(141)) slash 6 approx 3.479$ (the other
      root is negative and lies outside the interval). So the stripe
      runs from $x approx 3.479$ to $x approx 4.479$, with maximal
      area
      $ A approx 5.25. $],
  )

  #heuristic("introduce notation")

  Part (c) is the most elegant question in the old examination papers,
  and the reason is that it needs the *first* part of the fundamental
  theorem — the one about differentiating an integral — which is
  rarely examined directly. Computing $A(t)$ explicitly and then
  differentiating a quartic also works, and takes three times as long.
]

#ex(
  difficulty: 3,
  time: "25 min",
  calculator: false,
  hints: (
    [Find the point of inflection and the tangent there first.],
    [Sketch the triangle. Where does the curve enter it, and where
      does it leave?],
  ),
)[
  #emph[(Final examination, 1987.)] Consider the curve
  $ f: y = x dot (x - 3)^2. $
  #auto-parts(
    1,
    [Determine every tangent to the curve passing through
      $P = (1, 9)$. #emph[(Answered last year: exactly one, namely
      $y = 9 x$.)]],
    [The triangle formed by the coordinate axes and the tangent to $f$
      at its point of inflection is divided into two parts by the
      curve. Calculate the ratio of those two parts.],
  )
][
  #auto-parts(
    1,
    [Quoted in the question.],
    [Since $f(x) = x^3 - 6 x^2 + 9 x$, we get $f''(x) = 6 x - 12$, so
      the point of inflection is at $x = 2$, where $f(2) = 2$ and
      $f'(2) = -3$. The tangent is
      $ y = 2 - 3 dot (x - 2) = -3 x + 8, $
      meeting the axes at $(8/3, 0)$ and $(0, 8)$, so the triangle has
      area $1/2 dot 8/3 dot 8 = 32/3$.

      The curve enters the triangle at the origin and meets the
      tangent where $x^3 - 6 x^2 + 9 x = -3 x + 8$, i.e.
      $(x - 2)^3 = 0$ — a triple root at $x = 2$, as it must be at a
      point of tangency at an inflection point.

      The lower part is bounded by the curve up to $x = 2$ and by the
      tangent from there to $8/3$:
      $ integral_0^2 (x^3 - 6 x^2 + 9 x) dif x
        + integral_2^(8/3) (-3 x + 8) dif x
        = 6 + 2/3 = 20/3. $
      The upper part is $32/3 - 20/3 = 4$, so the ratio is
      $ 20/3 : 4 = 5 : 3. $],
  )
]

#ex(difficulty: 2, time: "20 min", calculator: true)[
  #emph[(Adapted from Calculus AP, 2011.)] Let $R$ be the region in
  the first quadrant enclosed by the graphs of $f(x) = 8 x^3$ and
  $g(x) = sin(pi dot x)$.
  #auto-parts(
    1,
    [Write an equation for the line tangent to the graph of $f$ at
      $x = 1/2$. #emph[(Answered last year: $y = 6 x - 2$.)]],
    [Calculate the area of $R$.],
    [Calculate the volume of the solid generated when $R$ is rotated
      about the $x$\u{2011}axis.],
  )
][
  #auto-parts(
    1,
    [Quoted in the question.],
    [The curves meet where $8 x^3 = sin(pi x)$: at $x = 0$ and at
      $x = 1/2$, since $8 dot 1/8 = 1$ and $sin(pi/2) = 1$. Between
      them the sine is above:
      $ A = integral_0^(1/2) (sin(pi x) - 8 x^3) dif x
        = [-(cos(pi x))/pi - 2 x^4]_0^(1/2)
        = 1/pi - 1/8 approx 0.193. $],
    [The washer formula, with the sine outer:
      $ V = pi integral_0^(1/2) (sin^2(pi x) - 64 x^6) dif x
        = pi dot (1/4 - 1/14) = (5 pi)/28 approx 0.561. $],
  )
]

== Parameters and Areas

#only-theory[
  Four problems combining both years: an integral produces a function
  of a parameter, and a derivative then optimizes it, or an equation
  pins it down.
]

#ex(
  difficulty: 3,
  time: "45 min",
  calculator: true,
  hints: (
    [In each case find the limits of integration in terms of the
      parameter first. They are usually the zeros or the intersection
      points.],
    [The area will come out as a function of the parameter alone.
      Then the problem is either an equation to solve or an
      optimization from last year.],
  ),
)[
  #auto-parts(
    1,
    [Given $f: y = x dot (x - a)^2$ with $a > 0$. Determine $a$ so
      that the area enclosed by the graph of $f$ and the
      $x$\u{2011}axis is $108$.],
    [Given $f: y = x^2/a - a$ and $g: y = x^2 - a^2$, for
      $0 < a < 1$. Determine the value of $a$ for which the area
      enclosed by the two graphs is maximal.],
    [Given $f: y = 1/(a - 3) dot (a dot x - x^3)$ with $a > 3$.
      Determine $a$ so that the area enclosed by the graph of $f$ and
      the $x$\u{2011}axis in the first quadrant is minimal.],
    [For which value of $a$ is the area enclosed by
      $f: y = a dot x^2 - x$ and $g: y = a dot x$ minimal?],
  )
][
  #auto-parts(
    1,
    [Zeros at $x = 0$ and $x = a$ (double), with $f gt.eq 0$ between
      them. Expanding and integrating,
      $ A(a) = integral_0^a (x^3 - 2 a x^2 + a^2 x) dif x
        = a^4 dot (1/4 - 2/3 + 1/2) = a^4/12. $
      Setting $a^4 slash 12 = 108$ gives $a^4 = 1296$, so
      $a = 6$.],
    [Subtracting gives
      $f - g = (1 - a) dot (x^2 slash a - a)$, which vanishes
      at $x = plus.minus a$ and is negative between them. So
      $ A(a) = (1 - a) integral_(-a)^a (a - x^2/a) dif x
        = 4/3 a^2 dot (1 - a). $
      Maximizing $a^2 - a^3$ gives $2 a - 3 a^2 = 0$, so
      $a = 2/3$ — which lies in the permitted range.],
    [The zeros in the first quadrant are $x = 0$ and $x = sqrt(a)$:
      $ A(a) = 1/(a - 3) integral_0^(sqrt(a)) (a x - x^3) dif x
        = a^2 / (4 dot (a - 3)). $
      Differentiating, the numerator of $A'$ is $a^2 - 6 a$, which
      vanishes at $a = 6$ (the root $a = 0$ is outside the domain).
      So $a = 6$.],
    [The curves meet where $a x^2 - x = a x$, i.e. at $x = 0$ and
      $x = (1 + a) slash a$. Integrating the difference,
      $ A(a) = ((1 + a)^3) / (6 a^2). $
      Differentiating and factoring, $A'$ has numerator
      $(1 + a)^2 dot (a - 2)$, so the only positive critical value is
      $a = 2$.],
  )

  #heuristic("work backwards from the goal")

  The shape is the same in all four: integrate with the parameter
  carried through, obtain $A(a)$, and then either solve $A(a) = c$ or
  minimize. Part (b) is the one where the algebra rewards being tidy —
  factoring $(1 - a)$ out before integrating saves a page.
]

#look-ahead(
  title: "Where this goes",
  preview: "beyond the Gymnasium",
)[
  You now have the two operations that most of quantitative science is
  written in, and it is worth knowing what sits immediately beyond
  them.

  *Differential equations.* An equation relating a function to its own
  derivatives — $y' = k y$ for growth, $y'' = -k y$ for oscillation.
  Almost every physical law is one of these, and solving them is what
  integration is really for.

  *Several variables.* A function of two variables has a graph that is
  a surface, two partial derivatives, and integrals over regions in
  the plane. The definitions are the ones you have, with one extra
  letter.

  *Numerical analysis.* Since most integrals have no elementary
  answer, a great deal of effort goes into computing them well. The
  midpoint rule you met in chapter 2 is the first step on a long
  road.

  None of these requires an idea you do not already have. They require
  the ideas you have, applied where the objects are more complicated.
]

#ai-box(role: "Tutor")[
  Ask an AI assistant to set you a twenty-question mixed review of
  this unit, with instructions not to group by topic and not to reveal
  which technique each question needs. Work them, mark yourself, and
  then — for each one you got wrong — ask only *"what was the earliest
  step at which I went wrong?"*

  One thing to test deliberately: include a question of your own where
  the region crosses the $x$\u{2011}axis, and see whether the
  assistant splits at the zeros or integrates straight through. That
  single error accounts for more wrong answers in this unit than every
  integration technique combined.
]

#print-hints()
#print-vocab()
