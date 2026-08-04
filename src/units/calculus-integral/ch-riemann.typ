#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Riemann Sums and the Definite Integral")
#let ex = exercise.with(chapter: "Riemann Sums and the Definite Integral")

// ── TEACHER'S NOTE ───────────────────────────────────────────
// This chapter has no counterpart in the old LaTeX notes at all. The
// old §9.2 goes straight from "distance travelled = area under the
// velocity graph" to the notation ∫ f(x) dx, with nothing in
// between — but GLF Y4 1.1 asks that the definite integral be
// defined "als Riemannsche Summe" and SPF Y4 1.1 "als Grenzwert einer
// Summe", so the sums have to be built.
//
// PRESERVING THE SURPRISE. The whole unit is arranged so that the
// fundamental theorem lands as a genuine shock, which means this
// chapter must not hint at it. Two consequences:
//   * §4 introduces the notation ∫_a^b BUT explicitly flags that the
//     resemblance to the indefinite integral is at this stage an
//     unexplained coincidence of notation. Say that out loud. It is
//     honest, it names the puzzle, and it is much better than either
//     spoiling the theorem or pretending the students have not
//     noticed.
//   * No exercise in this chapter is solvable by antidifferentiation.
//     Every area asked for here is either computable by elementary
//     geometry or estimable numerically. That constraint is the point
//     — students should end this chapter able to DEFINE the object
//     and barely able to COMPUTE it, which is exactly the appetite
//     the next chapter satisfies.
//
// LEVEL SPLIT. The sum formulas are the pinch point. Both tracks can
// do the linear case, since Σk is an arithmetic series (GLF Y3 2.1 /
// SPF Y2 1.1). For the quadratic case Σk² is simply STATED for GLF
// and PROVED BY INDUCTION for SPF (§3), which is one of the few
// places where SPF Y2 1.2 "einfache Beweise mit vollständiger
// Induktion" pays a visible dividend in analysis. If the induction
// unit is not yet behind them, the block degrades gracefully to the
// GLF version.

= Riemann Sums and the Definite Integral

#only-theory[
  Here is a question that looks like it belongs in a different
  subject.

  What is the area of a region with a curved boundary? For a rectangle
  the answer is a definition; for a triangle it is half a rectangle;
  for a circle it is a formula you were handed years ago and have
  probably never seen justified. But for the region under an arbitrary
  curve there is no formula, and — more troubling — there is not even
  an agreed definition of what "area" *means* there.

  This chapter answers both questions at once, using the only
  technique available: approximate the region by shapes whose area we
  do know, and then take a limit. That is the same move that produced
  the derivative, applied to a completely different problem, and it
  will produce a completely unrelated-looking object.
]

#epigraph(by: "Bernhard Riemann, 1854")[
  What are we to understand by the sum, when the number of parts
  increases beyond all bounds?
]

#objectives(
  [explain why the area under a curve requires a definition rather
    than merely a formula],
  [construct lower and upper sums for a function on an interval, and
    compute them for a given number of strips],
  bfkm[define the definite integral as the limit of a sum, and explain
    what the limit is doing],
  [evaluate a definite integral exactly in cases where the region is a
    familiar geometric shape],
  [estimate a definite integral numerically, and say whether the
    estimate is too large or too small],
  [apply the sign convention for regions below the
    $x$\u{2011}axis, and the additivity and linearity properties],
  obj(level: "high")[prove the formula for the sum of the first $n$
    squares by induction, and use it to evaluate a limit of sums
    exactly],
)

== A Question About Distance

#exploration(title: "How far did it go?")[
  An object moves with velocity $v(t)$, measured in m/s. For each of
  the following, calculate the total distance travelled in the first
  five seconds.

  + $v(t) = 2$
  + $v(t) = 2 t$
  + $v(t) = 3/5 dot t$
  + $v(t) = t^2$
  + $v(t) = sqrt(t)$

  Then:

  + Sketch each velocity-time graph and mark on it a region whose area
    equals the distance you calculated. What do you notice?
  + Two of the five you could do; three you could not. What exactly is
    the obstacle?
  + For $v(t) = t^2$, produce *any* number you can defend as an
    estimate of the distance, and say whether it is too big or too
    small.
]

#only-theory[
  The first two are elementary. A constant velocity of $2$ m/s for
  five seconds covers $10$ m — and on the graph that is a *rectangle*,
  $5$ wide and $2$ high. A velocity of $2 t$ reaches $10$ m/s at
  $t = 5$, and averages $5$ m/s over the interval, so it covers
  $25$ m — and on the graph that is a *triangle*, with area
  $1/2 dot 5 dot 10 = 25$.

  In both cases the distance is the area between the velocity graph
  and the $t$\u{2011}axis. That is not a coincidence of these two
  examples: distance is velocity accumulated over time, and area is
  height accumulated over width.

  For $v(t) = t^2$ the same statement must still be true. The obstacle
  is not conceptual — it is that we have no way to compute the area of
  a region bounded by a parabola.
]

== Rectangles, and Rather a Lot of Them

#only-theory[
  Since rectangles are the one shape whose area we are certain of, we
  will use nothing else.

  Take a function $f$ on an interval $[a, b]$ and cut the interval into
  $n$ strips of equal width
  $ Delta x = (b - a) / n. $
  On each strip, replace the curve by a horizontal line — a rectangle.
  #align(center)[
    #plot(
      xmin: -0.2,
      xmax: 3.5,
      ymin: 0,
      ymax: 9.8,
      width: 11,
      height: 6.5,
      axis-x-pos: "bottom",
      axis-y-pos: "left",
      xlabel: $x$,
      ylabel: $y$,
      xtick: (1, 2, 3),
      ytick: (2, 4, 6, 8),
      show-origin: false,
      riemann-sum(
        x => x * x,
        domain: (0.0, 3.0),
        n: 6,
        method: "right",
        color: blue.lighten(80%),
        stroke: blue.darken(10%) + 0.6pt,
        show-points: true,
        point-color: rgb("#c94a00"),
        point-size: 0.07,
        point-label: none,
        show-dx: true,
        dx-rect: 2,
        dx-label: $Delta x$,
        show-xi: true,
      ),
      (
        fn: x => x * x,
        domain: (0.0, 3.1),
        stroke: blue + 1.5pt,
        label: $f(x) = x^2$,
        label-pos: 1.0,
        label-side: "left",
      ),
    )
  ]


  There is a choice about how high to make each rectangle, and two
  choices are especially useful:

  - the *lower sum* $L_n$ takes each rectangle's height to be the
    smallest value of $f$ on that strip, so the rectangles all fit
    underneath the curve;
  - the *upper sum* $U_n$ takes the largest value, so the rectangles
    all contain the curve.

  Whatever the area under the curve turns out to mean, it must lie
  between them:
  $ L_n lt.eq "area" lt.eq U_n. $
  And if we can make $U_n - L_n$ as small as we please by taking $n$
  large enough, then the two sums close in on a single number — and
  that number has no choice but to be the area.
]

#definition(title: "Riemann sum")[
  Let $f$ be a function on $[a, b]$, cut into $n$ strips of width
  $Delta x = (b - a) slash n$. Choosing one point $x_k^*$ in each
  strip, the corresponding #vocab("Riemann sum", "Riemannsche Summe")
  is
  $ sum_(k = 1)^n f(x_k^*) dot Delta x. $
  Taking $x_k^*$ where $f$ is smallest on the strip gives the
  #vocab("lower sum", "Untersumme") $L_n$; taking it where $f$ is
  largest gives the #vocab("upper sum", "Obersumme") $U_n$.
]

#example(title: "Four strips under a parabola")[
  Estimate the area under $f(x) = x^2$ from $0$ to $1$ using four
  strips.
  #image-grid(
    2,
    plot(
      xmin: 0,
      xmax: 1.1,
      ymin: 0,
      ymax: 1.1,
      width: 5,
      height: 5,
      axis-x-pos: "bottom",
      axis-y-pos: "left",
      xlabel: $x$,
      ylabel: $y$,
      xtick: (1 / 4, 1 / 2, 3 / 4, 1),
      ytick: (1 / 2, 1),
      show-origin: false,
      riemann-sum(
        x => x * x,
        domain: (0.0, 1.0),
        n: 4,
        method: "left",
        color: green.lighten(80%),
        stroke: green.darken(10%) + 0.6pt,
        show-points: true,
        point-color: rgb("#c94a00"),
        point-size: 0.07,
        point-label: none,
        // show-dx: true,
        dx-rect: 2,
        dx-label: $Delta x$,
        // show-xi: true,
      ),
      (
        fn: x => x * x,
        domain: (0.0, 3.1),
        stroke: blue + 1.5pt,
        label: $f(x) = x^2$,
        label-pos: 1.0,
        label-side: "left",
      ),
    ),
    plot(
      xmin: 0,
      xmax: 1.1,
      ymin: 0,
      ymax: 1.1,
      width: 5,
      height: 5,
      axis-x-pos: "bottom",
      axis-y-pos: "left",
      xlabel: $x$,
      ylabel: $y$,
      xtick: (1 / 4, 1 / 2, 3 / 4, 1),
      ytick: (1 / 2, 1),
      show-origin: false,
      riemann-sum(
        x => x * x,
        domain: (0.0, 1.0),
        n: 4,
        method: "right",
        color: blue.lighten(80%),
        stroke: blue.darken(10%) + 0.6pt,
        show-points: true,
        point-color: rgb("#c94a00"),
        point-size: 0.07,
        point-label: none,
        // show-dx: true,
        dx-rect: 2,
        dx-label: $Delta x$,
        // show-xi: true,
      ),
      (
        fn: x => x * x,
        domain: (0.0, 3.1),
        stroke: blue + 1.5pt,
        label: $f(x) = x^2$,
        label-pos: 1.0,
        label-side: "left",
      ),
    ),
  )



  Here $Delta x = 1/4$, and the strips are
  $[0, 1/4]$, $[1/4, 1/2]$, $[1/2, 3/4]$, $[3/4, 1]$. Since $f$ is
  increasing, its smallest value on each strip is at the left end and
  its largest at the right end:
  $
    L_4 & = 1/4 dot (0^2 + (1/4)^2 + (1/2)^2 + (3/4)^2)
          = 7/32 = 0.21875, \
    U_4 & = 1/4 dot ((1/4)^2 + (1/2)^2 + (3/4)^2 + 1^2)
          = 15/32 = 0.46875.
  $
  So the area is somewhere between $0.219$ and $0.469$. That is a
  wide bracket and not yet worth much — but it is a *guarantee*,
  which no single estimate would be.

  Note also that
  $ U_4 - L_4 = 1/4 dot (1^2 - 0^2) = 1/4. $
  Every interior term cancelled: the rectangles telescope, and only
  the first and last survive. That observation is what makes the whole
  method work.
]

#keybox(title: "The gap closes")[
  For a function that is increasing (or decreasing) on $[a, b]$,
  $
    U_n - L_n = abs(f(b) - f(a)) dot Delta x
    = abs(f(b) - f(a)) dot (b - a) / n.
  $
  The right-hand side tends to $0$ as $n -> oo$, whatever the
  function. So the lower and upper sums are squeezed together, and any
  number trapped between them for every $n$ is unique.
]

== The Exact Value

#only-theory[
  Estimates are one thing; the limit is another. To compute it we need
  to add up $n$ rectangles for general $n$, which means we need
  formulas for sums.
]

#keybox(title: "Two sum formulas")[
  $
    sum_(k = 1)^n k = (n dot (n + 1)) / 2, quad
    sum_(k = 1)^n k^2 = (n dot (n + 1) dot (2 n + 1)) / 6.
  $
  The first is the arithmetic series you met in the sequences unit.
]

#example(title: "The area under a line, exactly")[
  Take $f(x) = x$ on $[0, 1]$, where we already know the answer — a
  triangle of area $1/2$ — so that the method can be checked.

  With $Delta x = 1/n$, the right end of strip $k$ is at $x = k slash n$,
  and $f$ is increasing, so
  $
    U_n = sum_(k = 1)^n (k/n) dot 1/n
    = 1/n^2 sum_(k = 1)^n k
    = 1/n^2 dot (n dot (n + 1)) / 2
    = (n + 1) / (2 n).
  $
  Now let $n -> oo$:
  $ lim_(n -> oo) (n + 1) / (2 n) = 1/2. $
  The same computation with left endpoints gives
  $L_n = (n - 1) slash (2 n)$, which also tends to $1/2$. The two sums
  squeeze the answer, and the answer is the one the triangle formula
  gave.
]

#example(title: "The area under a parabola, exactly")[
  Now $f(x) = x^2$ on $[0, 1]$, where no elementary formula exists.
  $
    U_n = sum_(k = 1)^n (k/n)^2 dot 1/n
    = 1/n^3 sum_(k = 1)^n k^2
    = 1/n^3 dot (n (n + 1) (2 n + 1)) / 6.
  $
  Multiplying out and dividing through by $n^3$:
  $ U_n = 1/3 + 1/(2 n) + 1/(6 n^2). $
  The corresponding lower sum comes out as
  $ L_n = 1/3 - 1/(2 n) + 1/(6 n^2), $
  and indeed $U_n - L_n = 1 slash n$, exactly as the gap formula
  predicted. Both tend to the same limit:
  $ lim_(n -> oo) U_n = lim_(n -> oo) L_n = 1/3. $

  So the area under the parabola $y = x^2$ from $0$ to $1$ is exactly
  $1/3$ — a result Archimedes obtained, by a related argument, some
  nineteen centuries before calculus existed.
]

#only-high[
  === Proving the Sum of Squares

  The formula $sum k^2 = n (n+1) (2 n + 1) slash 6$ was stated
  without proof above. It is a natural candidate for induction, which
  you met in the proof-techniques unit.

  *Base case.* For $n = 1$ the left side is $1^2 = 1$, and the right
  side is $1 dot 2 dot 3 slash 6 = 1$. They agree.

  *Induction step.* Assume the formula holds for some $n$. Then
  $
    sum_(k = 1)^(n + 1) k^2 & = (n (n + 1) (2 n + 1)) / 6 + (n + 1)^2 \
                            & = (n + 1) dot ((n (2 n + 1)) / 6 + (n + 1)) \
                            & = (n + 1) dot (2 n^2 + n + 6 n + 6) / 6 \
                            & = ((n + 1) (n + 2) (2 n + 3)) / 6,
  $
  where the last step factors $2 n^2 + 7 n + 6$. And
  $(n + 1)(n + 2)(2 n + 3)$ is exactly the original formula with $n$
  replaced by $n + 1$, since $2(n + 1) + 1 = 2 n + 3$. So the formula
  holds for $n + 1$, and therefore for every $n$.

  #heuristic("work backwards from the goal")

  The step worth noticing is the third: rather than expanding
  everything and hoping, we *aimed* at the factored form we wanted and
  arranged the algebra to reach it.
]

== The Definite Integral

#definition(title: "The definite integral")[
  Let $f$ be continuous on $[a, b]$. The
  #vocab("definite integral", "bestimmtes Integral") of $f$ from $a$
  to $b$ is the common limit of the lower and upper sums:
  $
    integral_a^b f(x) dif x
    = lim_(n -> oo) sum_(k = 1)^n f(x_k^*) dot Delta x.
  $
  For a continuous function this limit always exists, and does not
  depend on which point $x_k^*$ is chosen in each strip.

  The numbers $a$ and $b$ are the *limits of integration*. Unlike the
  indefinite integral, this object is a *number*, not a family of
  functions — and there is no $+ C$.
]

#warning[
  You have every right to be suspicious of that symbol.

  The indefinite integral $integral f(x) dif x$ is a family of
  antiderivatives. The definite integral $integral_a^b f(x) dif x$ is
  the limit of a sum of rectangle areas. These are different objects,
  arrived at by different routes, and nothing so far connects them.

  Leibniz used the same elongated S for both, and he had a reason. We
  do not yet. For this chapter, treat $integral_a^b$ as a new symbol
  that happens to resemble one you have seen — and keep the question
  in mind, because the answer is the most surprising result in the
  subject and it arrives in the next chapter.
]

== Signed Area

#only-theory[
  One consequence of the definition needs stating immediately. The
  rectangle heights are values $f(x_k^*)$, not distances — so where
  the graph lies *below* the axis, those values are negative, and the
  corresponding contributions are subtracted.

  So $integral_a^b f(x) dif x$ is not the area of the region. It is
  the #vocab("signed area", "orientierter Flächeninhalt"): area above
  the axis counts positively, area below counts negatively, and the
  integral reports the difference.

  For a function that dips below the axis and comes back, the integral
  can therefore be small, or zero, over a region that is manifestly not
  empty. If you want the *total* area, you must break the interval at
  the zeros and handle each piece separately — which is the subject of
  a later chapter.
]

#keybox(title: "Properties of the definite integral")[
  For continuous $f$ and $g$ and constants $k$:
  $
    integral_a^b (f(x) + g(x)) dif x
    &= integral_a^b f(x) dif x + integral_a^b g(x) dif x, \
    integral_a^b k dot f(x) dif x
    &= k dot integral_a^b f(x) dif x, \
    integral_a^b f(x) dif x + integral_b^c f(x) dif x
    &= integral_a^c f(x) dif x, \
    integral_a^a f(x) dif x &= 0, \
    integral_b^a f(x) dif x &= - integral_a^b f(x) dif x.
  $
  The third is additivity: two adjacent regions make one region. The
  last is a convention, and a sensible one — reversing the direction
  of travel reverses the sign.
]

=== Exercises

#ex(
  difficulty: 1,
  time: "12 min",
  calculator: false,
  hints: (
    [Use additivity for (a), and split the integrand into two pieces
      for (b).],
    [In (b), what is the integral of the constant function $2$ from
      $2$ to $5$? Draw the rectangle.],
  ),
)[
  Given that
  $
    integral_0^2 h(x) dif x = -2 quad "and" quad
    integral_2^5 h(x) dif x = 6,
  $
  deduce the value of
  #auto-parts(
    2,
    [$integral_0^5 h(x) dif x$],
    [$integral_2^5 (h(x) + 2) dif x$],
  )
][
  #auto-parts(
    1,
    [By additivity, $-2 + 6 = 4$.],
    [By linearity,
      $integral_2^5 h(x) dif x + integral_2^5 2 dif x$. The second
      integral is the area of a rectangle $3$ wide and $2$ high, so
      $6 + 6 = 12$.],
  )

  Note that the first integral being *negative* is not an error: on
  $[0, 2]$ the graph of $h$ spends more of its extent below the axis
  than above it.
]

#ex(
  difficulty: 2,
  time: "20 min",
  calculator: true,
  hints: (
    [Sketch each region first. Four of the six are a rectangle, two
      triangles, or a piece of a circle.],
    [For the two that are not, use the numerical integration function
      on your calculator — and say which of the six those are.],
  ),
)[
  For each of the following, write down a definite integral giving the
  area of the region bounded by the graph, the $x$\u{2011}axis, and the
  two given vertical lines. Evaluate it. Where the region is a
  familiar shape, check your answer with a geometric formula.
  #auto-parts(
    2,
    [$f(x) = 1/2 x + 1$, from $x = -2$ to $x = 6$],
    [$f(x) = 3$, from $x = -1$ to $x = 3$],
    [$f(x) = 1/3 x + 2$, from $x = 0$ to $x = 6$],
    [$f(x) = sqrt(9 - x^2)$, from $x = 0$ to $x = 3$],
    [$f(x) = 1/x$, from $x = 1$ to $x = 3$],
    [$f(x) = x^3 - 4 x$, from $x = -2$ to $x = 0$],
  )
][
  #auto-parts(
    1,
    [$integral_(-2)^6 (1/2 x + 1) dif x = 16$. The region is a
      triangle with base $8$ and height $4$ — the graph crosses the
      axis exactly at $x = -2$ — so $1/2 dot 8 dot 4 = 16$. #sym.checkmark],
    [$integral_(-1)^3 3 dif x = 12$: a rectangle $4$ wide and $3$
      high. #sym.checkmark],
    [$integral_0^6 (1/3 x + 2) dif x = 18$: a trapezoid with parallel
      sides $2$ and $4$ and width $6$, so
      $(2 + 4) slash 2 dot 6 = 18$. #sym.checkmark],
    [$integral_0^3 sqrt(9 - x^2) dif x = (9 pi) slash 4 approx 7.07$.
      The graph is the upper half of the circle $x^2 + y^2 = 9$, so
      the region is a quarter disc of radius $3$:
      $1/4 dot pi dot 9$. #sym.checkmark],
    [$integral_1^3 1/x dif x approx 1.10$. No elementary geometric
      formula applies — this one has to be done numerically.],
    [$integral_(-2)^0 (x^3 - 4 x) dif x = 4$. No geometric formula
      either. On this interval the graph lies *above* the axis, so the
      answer is positive.],
  )

  Parts (e) and (f) are the two that geometry cannot reach, and they
  are the reason the rest of this unit exists. Notice how
  unsatisfactory it is to be told that (e) is "about $1.10$" — that
  number is $ln(3)$, and nothing in this chapter could have told you
  so.
]

#ex(
  difficulty: 2,
  time: "18 min",
  calculator: true,
  hints: (
    [Draw the four rectangles in each case before computing anything.
      Whether you are over- or under-estimating should be visible from
      the picture, not deduced from the numbers.],
  ),
)[
  Consider $integral_0^2 (1 + x^2) dif x$.
  #auto-parts(
    1,
    [Compute the lower sum $L_4$ and the upper sum $U_4$.],
    [Compute the midpoint sum $M_4$ — the Riemann sum taking
      $x_k^*$ at the *centre* of each strip.],
    [The exact value is $14/3 approx 4.667$. Which of your three
      estimates is best, and can you say why from the picture?],
    [How large must $n$ be to guarantee $U_n - L_n < 0.01$?],
  )
][
  With $Delta x = 0.5$ and $f(x) = 1 + x^2$ increasing on $[0, 2]$:

  #auto-parts(
    1,
    [$L_4 = 0.5 dot (f(0) + f(0.5) + f(1) + f(1.5))
      = 0.5 dot (1 + 1.25 + 2 + 3.25) = 3.75$; #h(0.4em)
      $U_4 = 0.5 dot (f(0.5) + f(1) + f(1.5) + f(2))
      = 0.5 dot (1.25 + 2 + 3.25 + 5) = 5.75$.],
    [$M_4 = 0.5 dot (f(0.25) + f(0.75) + f(1.25) + f(1.75))
      = 0.5 dot (1.0625 + 1.5625 + 2.5625 + 4.0625) = 4.625$.],
    [$M_4$ is much the best, out by only $0.042$ against $0.917$ and
      $1.083$. From the picture: a midpoint rectangle cuts the curve,
      so the piece it misses on one side is largely compensated by the
      piece it adds on the other — whereas a lower rectangle misses on
      both sides and an upper one over-counts on both.],
    [The gap formula gives
      $U_n - L_n = abs(f(2) - f(0)) dot 2 slash n = 8 slash n$, so
      $8 slash n < 0.01$ requires $n > 800$. Guaranteed accuracy is
      expensive — which is a further reason to want an exact method.],
  )
]

#ex(difficulty: 3, time: "20 min", calculator: false, level: "high")[
  Use lower and upper sums to show that
  $ integral_0^1 x^3 dif x = 1/4, $
  given the formula
  $ sum_(k = 1)^n k^3 = (n^2 dot (n + 1)^2) / 4. $
][
  With $Delta x = 1 slash n$ and $f$ increasing on $[0, 1]$, the
  upper sum takes right endpoints:
  $
    U_n = sum_(k = 1)^n (k/n)^3 dot 1/n
    = 1/n^4 sum_(k = 1)^n k^3
    = 1/n^4 dot (n^2 (n + 1)^2) / 4
    = ((n + 1)^2) / (4 n^2).
  $
  Expanding,
  $
    U_n = (n^2 + 2 n + 1) / (4 n^2)
    = 1/4 + 1/(2 n) + 1/(4 n^2) --> 1/4.
  $
  The lower sum uses left endpoints, which is the same computation
  with the index running from $0$ to $n - 1$:
  $
    L_n = ((n - 1)^2) / (4 n^2)
    = 1/4 - 1/(2 n) + 1/(4 n^2) --> 1/4.
  $
  Both limits are $1/4$, and the gap $U_n - L_n = 1 slash n$ closes,
  so the integral is $1/4$.

  #heuristic("look for what stays the same")

  Collect the three results so far: $integral_0^1 x dif x = 1/2$,
  $integral_0^1 x^2 dif x = 1/3$, $integral_0^1 x^3 dif x = 1/4$.
  Conjecture the pattern. Then notice — and this is worth sitting with
  — that the answers look exactly like something from the previous
  chapter.
]

#ai-box(role: "Explainer")[
  Ask an AI assistant to explain why the lower and upper sums for a
  continuous function must converge to the same limit, *without*
  mentioning antiderivatives or the fundamental theorem. Then ask it
  for an example of a function for which they do *not* converge to the
  same limit, and what goes wrong there.

  The second question is the interesting one. Such functions exist —
  they are wildly discontinuous, and one of them is the reason
  mathematicians eventually replaced Riemann's definition with a more
  general one. You are not expected to follow the details; the point
  is that "every function has an area under it" is a claim, not an
  obvious truth, and that Riemann's definition earns its name by being
  one careful answer among several possible ones.
]

#print-hints()
#print-vocab()
