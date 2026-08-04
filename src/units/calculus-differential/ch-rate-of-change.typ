#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Rates of Change and the Derivative")
#let ex = exercise.with(chapter: "Rates of Change and the Derivative")

// ── IMAGE NOTE ───────────────────────────────────────────────
// Four figures from the old LaTeX img/ folder are still needed. Every
// #image call below is commented out so the chapter compiles now;
// uncomment as the files arrive. Old name → suggested new name
// (STYLE_GUIDE.md §7: lowercase, hyphenated, descriptive, never named
// after an exercise number):
//   the six vt-diagrams (old Ex 15)  → vt-diagram-six-panel.png
//   sketch-the-derivative panels (old Ex 20/21)
//                                    → derivative-sketching-panels.png
//   the scanned a)–f) graph sheet (old Ex 22)
//                                    → derivative-matching-sheet.png
//   Dorchester speed activity (old Ex 25)
//                                    → dorchester-distance-time.png
//
// Three figures that the old notes needed are NOT needed any more —
// they are now generated natively, which also makes their answers
// exact rather than read off a scan:
//   * old Ex 23's parabola   → f(x) = x^2/2 - 2x  (§6 here)
//   * old Ex 24's cubic      → g(x) = (x^3 - 6x^2)/6  (§6 here)
//   * old Ex 26's sine pair  → trig-plot in §6 here
// The old Ex 24 answers were estimates read off the scan
// ({-0.5, 0.5, 3.5, 4.5}); the exact values are 2 ± sqrt(6) and
// 2 ± sqrt(2), which is what the solution now gives.
//
// ── TEACHER'S NOTE ───────────────────────────────────────────
// This chapter deliberately contains NO limit formula and NO
// differentiation rules. The derivative is defined here as a slope
// and a rate; the difference quotient arrives in the next chapter.
// That order is the point of the whole unit — students who meet
// f'(x) = lim (f(x+h)-f(x))/h before they have any picture of what
// it is FOR spend the rest of the year computing something they
// cannot interpret.
//
// The Leibniz/Newton/Lagrange notation discussion has been moved
// FORWARD from the old §4 to §3 here. dy/dx is the notation that
// makes the average-to-instantaneous transition legible — it is
// literally Delta y / Delta x with the deltas worn down — so it
// belongs at the moment of the transition, not two sections later.

= Rates of Change and the Derivative

#only-theory[
  Here is the question this chapter exists to answer.

  A car's speedometer reads $80$ km/h. What does that number mean? It
  cannot mean "the car travels $80$ km in the next hour" — the car may
  stop in five minutes. It cannot mean "the car travelled $80$ km in
  the last hour" — it may have set off two minutes ago. The
  speedometer is reporting something about *this instant*, and yet
  speed is a distance divided by a time, and no distance is covered in
  an instant, and no time passes.

  A rate at a single moment looks, on the face of it, like a
  contradiction. Resolving it is what calculus was invented for, and
  the resolution is the derivative. Everything else in this unit —
  every rule, every optimization problem — is machinery in service of
  this one idea.
]

#epigraph(by: "Richard Feynman")[
  Calculus is the language God talks.
]

#objectives(
  bfkm[compute the average rate of change of a function over an
    interval, and interpret it as the slope of a secant line],
  bfkm[explain the transition from an average rate of change to an
    instantaneous one, and say why the instantaneous rate cannot be
    computed by simply dividing],
  bfkm[interpret the derivative $f'(x_0)$ both as the slope of the
    tangent at $x_0$ and as an instantaneous rate of change, and state
    its units in an applied context],
  [estimate the value of a derivative from a graph, and from a table
    of values],
  [read a distance-time or velocity-time graph and describe the motion
    it represents, including what the second derivative says],
  [sketch the graph of $f'$ given the graph of $f$, and a graph of $f$
    given the graph of $f'$],
  [recognize the points at which a function fails to be
    differentiable, and name the reason],
)

== Average Rates of Change

#only-theory[
  Start with something uncontroversial. If a quantity $y$ depends on
  $x$, then over an interval from $x_0$ to $x_0 + h$ the quantity
  changes by
  $ Delta y = f(x_0 + h) - f(x_0) $
  while the input changes by $Delta x = h$. The ratio of the two is the
  average rate of change.
]

#definition(title: "Average rate of change")[
  The #vocab("average rate of change", "mittlere Änderungsrate") of $f$
  over the interval $[x_0, x_0 + h]$ is
  $ (Delta y) / (Delta x) = (f(x_0 + h) - f(x_0)) / h. $

  Geometrically this is the slope of the #vocab("secant", "Sekante") line through the two points $(x_0, f(x_0))$ and
  $(x_0 + h, f(x_0 + h))$ on the graph.
]

#only-theory[
  #fig(
    plot-graph(
      (fn: x => 0.35 * calc.pow(x, 2) + 0.5, color: accent),
      (fn: x => 1.05 * x - 0.2, color: warn-col),
      xmin: -0.5,
      xmax: 4.5,
      ymin: -0.5,
      ymax: 6.5,
      grid-step: 1,
      width: 9,
      height: 6,
    ),
    caption: [
      The secant through $(1, 0.85)$ and $(2, 1.9)$ on the graph of
      $f: y = 0.35 dot x^2 + 0.5$. Its slope, $1.05$, is the average
      rate of change over $[1, 2]$ — a genuine average, which the
      function need not attain at either endpoint.
    ],
  )
]

#remark[
  Two things this quantity is not.

  It is not the slope of the curve. It is the slope of a straight line
  drawn between two points of the curve, and it says nothing about what
  happened in between: the same average rate is consistent with steady
  progress, with a sprint followed by a stop, or with a detour
  backwards and a recovery.

  It is not unit-free. If $y$ is a distance in metres and $x$ a time in
  seconds, then $Delta y slash Delta x$ carries the unit m/s and is
  called an average *speed*. If $y$ is a cost in francs and $x$ a
  number of items, the unit is CHF per item. Always ask what the
  quotient is measured in — it is the fastest way to check that you
  have divided the right way round.
]

#example(title: "Average speed over shrinking intervals")[
  A ball is dropped and falls $s(t) = 5 t^2$ metres in $t$ seconds.
  What is its average speed over the first $2$ seconds, and over
  shorter intervals ending at $t = 2$?

  Over $[0, 2]$: #h(0.4em)
  $(s(2) - s(0)) slash 2 = (20 - 0) slash 2 = 10$ m/s.

  Over $[1, 2]$: #h(0.4em) $(20 - 5) slash 1 = 15$ m/s.

  Over $[1.9, 2]$: #h(0.4em)
  $(20 - 18.05) slash 0.1 = 19.5$ m/s.

  Over $[1.99, 2]$: #h(0.4em) $19.95$ m/s.

  The averages are not settling on nothing — they are closing in on
  $20$ m/s. That number is what the speedometer would read at the
  instant $t = 2$.
]

=== Exercises

#ex(difficulty: 1, time: "10 min", calculator: true)[
  A population of bacteria is modelled by $N(t) = 200 dot 2^t$, where
  $t$ is measured in hours.
  #auto-parts(
    1,
    [Find the average rate of growth over the first $3$ hours, and
      state its units.],
    [Find the average rate of growth over $[3, 6]$.],
    [The two answers differ by a factor of $8$. Explain why, without
      computing anything further.],
  )
][
  #auto-parts(
    1,
    [$(N(3) - N(0)) slash 3 = (1600 - 200) slash 3 approx 467$
      bacteria per hour.],
    [$(N(6) - N(3)) slash 3 = (#num(12800) - 1600) slash 3
      approx #num(3733)$ bacteria per hour.],
    [Over $[3, 6]$ every population figure is $2^3 = 8$ times the
      corresponding figure over $[0, 3]$, and the interval length is
      the same. Both numerator and denominator scale accordingly. This
      is the defining property of exponential growth: the *rate* is
      proportional to the amount present, which is a fact we will be
      able to state exactly once we can differentiate $2^t$.],
  )
]

#ex(difficulty: 2, time: "12 min", calculator: true)[
  For $f(x) = x^3$, compute the average rate of change over the
  intervals $[2, 3]$, $[2, 2.1]$, $[2, 2.01]$ and $[2, 2.001]$.
  #auto-parts(
    1,
    [What value do the results appear to be approaching?],
    [Repeat at $x_0 = 1$ and at $x_0 = 3$. Can you guess a formula for
      the value approached at a general $x_0$?],
  )
][
  #auto-parts(
    1,
    [$19$, then $12.61$, then $12.0601$, then $12.006001$ — closing in
      on $12$.],
    [At $x_0 = 1$ the values approach $3$; at $x_0 = 3$ they approach
      $27$. The pattern $3, 12, 27$ at $x_0 = 1, 2, 3$ is
      $3 dot x_0^2$, which suggests that the instantaneous rate of
      change of $x^3$ at $x_0$ is $3 dot x_0^2$.],
  )

  #heuristic("try small cases")

  This is exactly how the rules of the next two chapters were first
  found: compute, tabulate, conjecture, and only then prove.
]

== From Average to Instantaneous

#only-theory[
  The example above suggests the strategy. We cannot divide by zero, so
  we do the next best thing: shrink the interval and watch where the
  averages go.


  #fig(
    plot-graph(
      (fn: x => 0.35 * calc.pow(x, 2) + 0.5, color: accent),
      // All four lines pass through (1, 0.85), the fixed left-hand
      // point. Slopes 1.4, 1.05, 0.875 are the secants to x = 3, 2, 1.5;
      // 0.7 is the tangent, f'(1) for f(x) = 0.35 x^2 + 0.5.
      (fn: x => 1.4 * x - 0.55, color: ex-col),
      (fn: x => 1.05 * x - 0.2, color: ex-col),
      (fn: x => 0.875 * x - 0.025, color: ex-col),
      (fn: x => 0.7 * x + 0.15, color: warn-col),
      xmin: -0.5,
      xmax: 4.5,
      ymin: -0.5,
      ymax: 6.5,
      grid-step: 1,
      width: 9,
      height: 6,
    ),
    caption: [
      All four lines pass through the *same* point, $(1, 0.85)$. The
      three gray secants run from there to the points at $x = 3$,
      $x = 2$ and $x = 1.5$, with slopes $1.4$, $1.05$ and $0.875$. As
      the second point slides in, the slopes close in on $0.7$ — the
      slope of the red tangent.
    ],
  )
]

#exploration(title: "Zoom until it is straight")[
  Plot $f: y = 2 + 21 x - 5 x^2$ on your calculator or on GeoGebra, and
  zoom in repeatedly on the point $(1, 18)$.

  + What happens to the curve as you zoom? At what magnification does
    it become indistinguishable from a straight line?
  + Use the trace or table feature to find two points very close to
    $(1, 18)$ and estimate the slope between them. What do you think
    the exact slope is?
  + Repeat at the point $(2, 24)$.
  + Now zoom in on the graph of $y = |x|$ at the origin, as far as you
    like. What is different?
]

#only-theory[
  The first three parts of that exploration illustrate *local
  linearity*: a smooth curve, magnified enough, is indistinguishable
  from a line. That line is the tangent, and its slope is the number we
  are after. The fourth part is a warning that not every function has
  this property — a point we return to in §7.
]

#definition(title: "The derivative")[
  The #vocab("derivative", "Ableitung") of a function $f$ at a position
  $x_0$ is the slope of the graph of $f$ at the point $(x_0, f(x_0))$
  — equivalently, the slope of the #vocab("tangent", "Tangente") line
  there. It is written
  $ f'(x_0). $

  Read as a rate rather than a slope, $f'(x_0)$ is the
  #vocab("instantaneous rate of change", "lokale Änderungsrate") of $f$
  at $x_0$.

  If $f'(x_0)$ exists at every $x_0$ in the domain, $f$ is called
  #vocab("differentiable", "differenzierbar"), and the function
  $x |-> f'(x)$ is called *the derivative of $f$*.
]

#warning[
  This definition names the number but does not say how to compute it,
  and that is deliberate. "The slope of the graph at a point" is a
  perfectly good description and a useless recipe — two points are
  needed for a slope, and here we have one. Turning the description
  into a calculation is the entire content of the next chapter.

  Until then, we estimate. That is not a lesser activity: knowing what
  a derivative *is* well enough to estimate it from a graph is what
  makes the machinery worth having.
]

=== A Remark on Notation

#only-theory[
  Three notations are in common use, and you will meet all three.

  *Lagrange:* #h(0.4em) $f'$, $f''$, $dots.h$, $f^((n))$ — compact, and
  the one we use by default. Higher derivatives get inconvenient past
  the third prime, which is why the bracketed index takes over.

  *Leibniz:* #h(0.4em)
  $ (dif y) / (dif x), quad (dif^2 y) / (dif x^2), quad dots.h $
  Here $dif x$ stands for an infinitesimally small step in the
  $x$\u{2011}direction. This notation is worth more than it
  looks: it is $Delta y slash Delta x$ with the deltas worn down to
  nothing, so it records on the page exactly the transition we just
  made. It also carries the units with it, and $dif slash dif x$ can be
  read as an *operator* — a machine that eats a function and returns
  another — which is how the rules of the next chapter are most easily
  stated.

  *Newton:* #h(0.4em) $dot(f)$, $dot.double(f)$ — still standard in
  physics and mechanics, almost always for derivatives with respect to
  time. Hopeless beyond the second derivative.
]

== Reading Motion Off a Graph

#only-theory[
  The most vivid setting for all of this is motion, because there the
  derivative has a name you already use.

  If $s(t)$ is the position of an object at time $t$, then $s'(t)$ is
  its #vocab("velocity", "Geschwindigkeit") — the instantaneous rate at
  which position changes. Differentiating again, $s''(t)$ is the rate
  at which the velocity changes, the #vocab("acceleration", "Beschleunigung").

  Each derivative is a statement about the *slope* of the graph below
  it. On a distance-time graph, steep means fast. On a velocity-time
  graph, steep means hard acceleration, and a horizontal line means
  constant speed — which on a distance-time graph would have been a
  slanted line. Confusing the two is the single most common error in
  this material, and the cure is to say out loud which quantity is on
  the vertical axis before reading anything off.
]

// #fig(image("images/vt-diagram-six-panel.png", width: 85%))

#ex(difficulty: 1, time: "10 min")[
  Which of the six velocity-time diagrams above represents each
  situation?
  #auto-parts(
    2,
    [A car pulling away briskly from a stop sign.],
    [A car pulling away sedately from a stop sign.],
    [A student bouncing on a trampoline.],
    [A ball thrown straight up.],
    [A student walking to lunch.],
    [An unprepared student on the way to a calculus test.],
  )
][
  Discussed in the lesson. The two questions to ask of each panel are:
  where does it start, and is it periodic? A trampoline gives
  periodicity; a thrown ball gives a single straight descent through
  zero, since gravity supplies a constant acceleration.
]

#ex(difficulty: 2, time: "15 min")[
  Sketch a plausible velocity-time diagram for each situation, and
  label the axes with units.
  #auto-parts(
    2,
    [A velociraptor chasing a student down a corridor.],
    [Felix Baumgartner jumping from a balloon *with* a parachute.],
    [Felix Baumgartner jumping from a balloon *without* a parachute.],
    [A kangaroo hopping off a cliff.],
  )
][
  Discussed in the lesson. The pair (b), (c) is the interesting one:
  both start the same way, and the parachute shows up as an abrupt
  drop in speed followed by a new, much smaller constant velocity —
  the terminal velocity, where drag balances gravity. Without the
  parachute there is still a terminal velocity, just a far larger one.
]

#ex(difficulty: 2, time: "10 min")[
  Sketch three different velocity-time diagrams of your own and invent
  a story that fits each. Swap with a neighbour and see whether they
  can recover a story close to yours from the graph alone.
][
  Discussed in the lesson. A graph is a poor story-teller in one
  specific way worth drawing out: it fixes the *speeds* completely and
  the *distances* not at all until you accumulate them, which is a
  question we will only be able to answer in the integration unit.
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  A body moves according to a distance function $d(t)$. What does each
  statement say about the motion?
  #auto-parts(
    2,
    [$d'(t) = 1$],
    [$d'(t) = 2 t$],
    [$d''(t) = 0$],
    [$d''(t) > 0$],
  )
][
  #auto-parts(
    2,
    [The velocity is constant at $1$ unit per unit time: the body moves
      forward at a steady speed.],
    [The velocity grows in proportion to the elapsed time — the body
      starts at rest and speeds up steadily. This is constant
      acceleration, as in free fall.],
    [The acceleration is zero, so the velocity is constant. Note this
      does *not* say the body is at rest.],
    [The velocity is increasing. It does not follow that the body is
      moving forward: if $d'(t)$ is negative and increasing, the body
      is moving backwards and slowing down.],
  )

  Part (d) is the one worth arguing about. "Positive acceleration" and
  "speeding up" are not the same statement.
]

// #fig(image("images/dorchester-distance-time.png", width: 90%))
// source: http://www.cimt.plymouth.ac.uk/

#ex(difficulty: 2, time: "25 min", calculator: true)[
  The graph above shows the progress of a driver through the town of
  Dorchester: distance along the route, in metres, against time in
  seconds.
  #auto-parts(
    1,
    [Somewhere on this route there is a major roundabout. Where do you
      think it is, and how can you tell?],
    [Find the driver's average speed between Grey's Bridge and the
      Night Club, and between the Military Museum and St Thomas Road.],
    [A speed of $30$ mph is about $13.4$ m/s. On this graph that is a
      particular slope. Where along the route was the car exceeding
      it?],
    [If the speedometer was accurate, what would it have read as the
      car passed the Night Club?],
  )
][
  Discussed in the lesson; answers depend on readings off the graph, so
  a range is expected rather than a single number.

  Part (a) is the pedagogical heart of the activity: a roundabout
  forces the car to slow almost to a stop, which shows up as the
  flattest part of the graph — a feature of the *slope*, invisible if
  you only look at the heights.

  For (c), the practical method is to cut out a right triangle whose
  legs are in the ratio corresponding to $13.4$ m/s and slide it along
  the curve, comparing its hypotenuse to the local steepness. Part (d)
  is the same measurement done at one point: estimate the tangent's
  slope and read off the units, m/s.
]

== Estimating a Derivative

#only-theory[
  Two practical methods, and both are worth having.

  *From a graph.* Lay a ruler along the curve at the point of interest
  so that it touches without crossing, draw the tangent, pick two
  widely separated points *on the ruled line*, and compute rise over
  run. Widely separated matters: a small triangle magnifies your
  drawing error.

  *From a table or a formula.* Compute the average rate of change over
  a small interval straddling the point,
  $ f'(x_0) approx (f(x_0 + h) - f(x_0 - h)) / (2 h) $
  with $h$ small — say $0.01$. Straddling the point rather than
  starting at it turns out to be noticeably more accurate, for reasons
  that become visible once we can expand $f$ near $x_0$.


  #fig(
    plot-graph(
      x => calc.pow(x, 3) / 3 - x,
      xmin: -2.5,
      xmax: 2.5,
      ymin: -2.5,
      ymax: 2.5,
      grid-step: 1,
      width: 9,
      height: 7,
    ),
    caption: [The graph of $f: y = x^3 / 3 - x$.],
  )
]

#ex(
  difficulty: 1,
  time: "12 min",
  calculator: false,
  hints: (
    [Look first for the places where the tangent is horizontal — those
      are the easy ones, and they anchor the rest.],
  ),
)[
  Using the graph above, estimate $f'(x)$ at
  $x = -2, -1, 0, 1, 2$. At which of these points is the tangent
  horizontal, and what is the sign of $f'$ between them?
][
  Estimating from the graph should give roughly
  $3, 0, -1, 0, 3$.

  The tangent is horizontal at $x = -1$ and $x = 1$, which are the
  local maximum and local minimum. Between them $f'$ is negative — the
  graph falls — and outside them $f'$ is positive.

  For the record, the exact derivative is $f'(x) = x^2 - 1$, which
  matches every estimate above. You are not expected to be able to
  produce that yet.
]

#ex(difficulty: 2, time: "12 min", calculator: true)[
  The temperature of a cooling cup of coffee is recorded every two
  minutes:

  #align(center, table(
    columns: 7,
    align: center,
    stroke: 0.5pt + luma(180),
    inset: 6pt,
    [$t$ (min)], [$0$], [$2$], [$4$], [$6$], [$8$], [$10$],
    [$T$ (°C)], [$85$], [$76$], [$69$], [$63$], [$59$], [$55$],
  ))

  #auto-parts(
    1,
    [Estimate $T'(4)$, with units.],
    [Is $T''$ positive or negative over this interval? What does that
      mean physically?],
    [The room is at $20 degree$C. Sketch how you expect the graph to
      continue, and say what happens to $T'$ in the long run.],
  )
][
  #auto-parts(
    1,
    [Straddling $t = 4$:
      $T'(4) approx (63 - 76) slash 4 = -3.25$ °C per minute.],
    [$T'$ is negative throughout but getting *less* negative — the
      successive drops are $-9, -7, -6, -4, -4$ per two minutes. So
      $T''> 0$: the coffee is cooling, but ever more slowly. This is
      Newton's law of cooling, and the reason is that the rate of heat
      loss is proportional to the temperature *difference* with the
      room, which is shrinking.],
    [The graph flattens towards the horizontal asymptote $T = 20$, and
      $T'(t) -> 0$. The coffee never quite reaches room temperature,
      which is the same "approaches but does not attain" behavior the
      asymptote chapter was about.],
  )
]

== The Derivative as a Function

#only-theory[
  So far $f'(x_0)$ has been a number attached to a point. Computing it
  at every point produces a new function, and the graph of that
  function can be sketched from the graph of $f$ alone — no formulas
  required. Three observations do all the work:

  - where $f$ has a horizontal tangent, $f'$ has a *zero*;
  - where $f$ is increasing, $f'$ is *positive*; where $f$ is
    decreasing, $f'$ is *negative*;
  - the steeper $f$ is, the further $f'$ is from the axis.

  Reading in this direction is the skill that makes the rest of the
  unit interpretable rather than mechanical. Reading in the *other*
  direction — sketching $f$ from $f'$ — is harder, and is worth
  practising now because it is exactly what integration will ask of
  you next year.
]

// #fig(image("images/derivative-sketching-panels.png", width: 90%))

#ex(difficulty: 2, time: "15 min", calculator: false)[
  Sketch the derivative of each function shown above.
][
  Discussed in the lesson. Check every sketch against all three
  observations, especially the last: a sketch of $f'$ that has the
  right zeros but the wrong sizes is only half right.
]

#ex(difficulty: 3, time: "15 min", calculator: false)[
  Sketch an antiderivative of each function shown above — that is, a
  function whose derivative is the graph shown.
][
  Discussed in the lesson. Two points to draw out. First, the answer is
  never unique: shifting your curve up or down changes nothing about
  its slopes, so there is a whole family of correct answers. Second,
  where the given graph is *negative* the antiderivative must be
  *falling*, which is the observation students most often invert.
]

// #fig(image("images/derivative-matching-sheet.png", width: 90%))

#ex(difficulty: 2, time: "20 min", calculator: false)[
  #auto-parts(
    1,
    [The graphs on the upper sheet are functions $f$. Sketch $f'$ for
      each.],
    [The graphs on the lower sheet are derivatives $f'$. Sketch a
      possible $f$ for each.],
  )
][
  Discussed in the lesson.
]

=== Reading Conditions Off a Graph

#only-theory[
  #fig(
    plot-graph(
      x => calc.pow(x, 2) / 2 - 2 * x,
      xmin: -1.5,
      xmax: 5.5,
      ymin: -2.5,
      ymax: 4.5,
      grid-step: 1,
      width: 9,
      height: 6,
    ),
    caption: [The graph of $f$ for the next exercise.],
  )
]

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: false,
  hints: (
    [Answer (a) and (b) first and mark those $x$\u{2011}values
      on the axis. Every remaining part is about the intervals between
      them.],
    [For (f), a product is positive when both factors share a sign.
      Work out where $f > 0$, where $f < 0$, where $f' > 0$ and where
      $f' < 0$, then intersect.],
  ),
)[
  For the function $f$ graphed above, determine or estimate the values
  of $x$ for which:
  #auto-parts(
    3,
    [$f'(x) = 0$],
    [$f(x) = 0$],
    [$|f'(x)| = 1$],
    [$f(x) < 0$],
    [$f'(x) < 0$],
    [$f(x) dot f'(x) > 0$],
  )
][
  The function is $f(x) = x^2 / 2 - 2 x$, with $f'(x) = x - 2$.

  #auto-parts(
    3,
    [$x = 2$, the vertex.],
    [${0, 4}$],
    [${1, 3}$],
    [$(0, 4)$],
    [$(-oo, 2)$],
    [$(0, 2) union (4, oo)$],
  )

  For (f): $f > 0$ on $(-oo, 0) union (4, oo)$ and $f' > 0$ on
  $(2, oo)$, giving $(4, oo)$; and $f < 0$ on $(0, 4)$ with $f' < 0$
  on $(-oo, 2)$, giving $(0, 2)$.

  A remark worth making in the lesson: the condition
  $f dot f' > 0$ says the graph is moving *away* from the
  $x$\u{2011}axis — rising while above it, or falling while
  below it.
]

#only-theory[
  #fig(
    plot-graph(
      x => (calc.pow(x, 3) - 6 * calc.pow(x, 2)) / 6,
      xmin: -1.5,
      xmax: 7.5,
      ymin: -6.5,
      ymax: 3.5,
      grid-step: 1,
      width: 10,
      height: 6,
    ),
    caption: [The graph of $g$ for the next exercise.],
  )
]

#ex(difficulty: 3, time: "18 min", calculator: false)[
  Repeat the previous exercise for the function $g$ graphed above:
  determine or estimate the values of $x$ for which
  #auto-parts(
    3,
    [$g'(x) = 0$],
    [$g(x) = 0$],
    [$|g'(x)| = 1$],
    [$g(x) < 0$],
    [$g'(x) < 0$],
    [$g(x) dot g'(x) > 0$],
  )
][
  The function is $g(x) = (x^3 - 6 x^2) / 6$, with
  $g'(x) = (x^2 - 4 x) / 2$.

  #auto-parts(
    3,
    [${0, 4}$],
    [${0, 6}$],
    [$2 plus.minus sqrt(2)$ and $2 plus.minus sqrt(6)$, i.e.
      approximately ${-0.45, 0.59, 3.41, 4.45}$],
    [$(-oo, 0) union (0, 6)$],
    [$(0, 4)$],
    [$(0, 4) union (6, oo)$],
  )

  Part (c) is an estimation exercise, and estimates near
  ${-0.5, 0.5, 3.5, 4.5}$ are entirely acceptable — the exact values
  come from solving $x^2 - 4 x = plus.minus 2$.

  Part (d) is worth a comment: $x = 0$ is a zero of $g$ at which the
  graph does *not* cross the axis, so it is excluded from the
  interval while its neighbours on both sides are not. That is a
  double zero, as in the polynomials chapter, and here it is also a
  local maximum.
]

#only-theory[
  #fig(
    trig-plot(
      (fn: x => calc.sin(2 * x), color: accent),
      (fn: x => 2 * calc.cos(2 * x), color: def-col),
      xmin: -1.25,
      xmax: 1.25,
      ymin: -4.5,
      ymax: 4.5,
      tick: 1,
      width: 12,
      height: 5,
    ),
    caption: [Two curves: one is a function, the other is its derivative.],
  )
]


#ex(difficulty: 2, time: "12 min", calculator: false)[
  #auto-parts(
    1,
    [One of the two curves above is a function $f$, the other its
      derivative $f'$. Decide which is which, and justify your answer
      with at least two independent pieces of evidence.],
    [Sketch the graph of the second derivative $f''$ in the same
      coordinate system.],
  )
][
  #auto-parts(
    1,
    [The small-amplitude curve is $f$; the large-amplitude one is
      $f'$.

      *Evidence 1 — zeros against peaks.* Every peak and trough of the
      small curve lines up with a zero of the large one. That is the
      relationship "horizontal tangent gives derivative zero", and it
      only works in this direction: the peaks of the *large* curve do
      not sit above zeros of the small one.

      *Evidence 2 — signs.* Where the small curve is rising, the large
      curve is above the axis, and where it is falling, below.

      *Evidence 3 — amplitude.* The small curve is quite steep for its
      size, so its derivative should be comparatively large. A
      derivative is not obliged to be smaller than its function, and
      here it is not.],
    [$f''$ is the derivative of the large curve, so it has the same
      shape again, shifted by a further quarter period and scaled up
      by the same factor. Concretely it looks like the small curve
      turned upside down and stretched: $f'' = -k^2 dot f$ for the
      appropriate constant $k$ — every peak of $f$ sits below a trough
      of $f''$.],
  )

  The relationship in (b) — a function proportional to the negative of
  its own second derivative — describes every oscillation in physics,
  from a pendulum to an alternating current.
]

== Where the Derivative Fails to Exist

#only-theory[
  Not every function has a derivative at every point, and the exception
  is not exotic: $f(x) = |x|$ fails at $x = 0$.

  #fig(
    plot-graph(
      x => calc.abs(x),
      xmin: -2.5,
      xmax: 2.5,
      ymin: -0.5,
      ymax: 2.5,
      grid-step: 1,
      width: 7,
      height: 4,
    ),
    caption: [$y = |x|$: continuous everywhere, differentiable everywhere
      except at the origin.],
  )

  Approach the origin from the left and every secant has slope $-1$;
  approach from the right and every secant has slope $+1$. The two
  one-sided answers exist and disagree, so there is no single slope —
  exactly the situation the limits chapter called a failure of a
  two-sided limit. Zooming in does not help: the corner stays a corner
  at every magnification.
]

#keybox(title: [Four ways differentiability fails at $x_0$])[
  - *A corner*, as in $|x|$ at $0$: the one-sided slopes exist and
    differ.
  - *A cusp*, as in $root(3, x^2)$ at $0$: the one-sided slopes run off
    to $+oo$ and $-oo$.
  - *A vertical tangent*, as in $root(3, x)$ at $0$: the slope is
    infinite, so no number describes it.
  - *A discontinuity* of any kind: a jump, a hole or a pole leaves
    nothing to be tangent to.
]

#keybox(title: "Differentiable implies continuous")[
  If $f$ is differentiable at $x_0$, then $f$ is continuous at $x_0$.

  The converse is false — $|x|$ is the standard counterexample.
  Differentiability is the *stronger* condition: continuity asks the
  graph not to break, differentiability asks it not even to kink.
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  For each function, state where it fails to be differentiable and name
  the reason.
  #auto-parts(
    2,
    [$f(x) = |x - 3|$],
    [$f(x) = 1 slash x$],
    [$f(x) = floor(x)$],
    [$f(x) = |x^2 - 4|$],
  )
][
  #auto-parts(
    2,
    [At $x = 3$: a corner, with one-sided slopes $-1$ and $+1$.],
    [At $x = 0$: the function is not even defined there, so there is
      nothing to be tangent to — a pole.],
    [At every integer: a jump discontinuity at each one. Between
      integers the function is constant and its derivative is $0$.],
    [At $x = -2$ and $x = 2$. The absolute value reflects the part of
      the parabola below the axis, and the two zeros of $x^2 - 4$
      become corners — the graph arrives at each with slope
      $plus.minus 4$ and leaves with the opposite sign.],
  )
]

#ex(difficulty: 3, time: "15 min", calculator: false, level: "high")[
  Sketch a function that is continuous everywhere on $[0, 4]$,
  differentiable everywhere except at exactly two points, has exactly
  three zeros, and has a horizontal tangent at exactly one point.

  Then state precisely which of your four conditions would become
  impossible if "continuous" were dropped, and which would not.
][
  Many answers. One construction: start at $(0, 1)$, fall linearly to a
  corner at $(1, -1)$, rise linearly to a corner at $(2, 1)$, then run
  a smooth arc from $(2, 1)$ down through a single minimum and back up
  so that it crosses the axis twice more before $x = 4$. The zeros are
  the crossing on $[0,1]$, plus the two on the arc; the corners at
  $x = 1$ and $x = 2$ are the two non-differentiable points; the
  arc's minimum is the only horizontal tangent.

  #heuristic("draw a picture")

  On the second question: dropping continuity makes nothing
  impossible — it makes everything *easier*, since a jump can supply
  a sign change with no zero at all, and that is precisely what the
  intermediate value theorem forbids for continuous functions. This
  is why "continuous on a closed interval" is a hypothesis worth
  reading carefully rather than skipping.
]

#ai-box(role: "Explainer")[
  Ask an AI assistant to explain why a function can be continuous at a
  point without being differentiable there, *and* to give an example
  that is not $|x|$. Then ask whether the reverse can happen —
  differentiable but not continuous — and check its reasoning against
  the keybox above rather than against your intuition.

  This is a good place to test an assistant, because the wrong answer
  is fluent and short and the right answer needs a reason. If it
  simply asserts that differentiability implies continuity, ask it
  why.
]

#print-hints()
#print-vocab()
