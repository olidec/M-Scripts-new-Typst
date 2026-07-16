// ============================================================
//  ch-trig-functions.typ — Chapter: The Trigonometric Functions
//  Trigonometry unit, chapter 5 (shared GLF/SPF, year 1).
//  Rebuilt from trigonometry_lecture.tex §5 (old Ex 53–55) in the
//  style of the IB "Circular functions" chapter, with new content.
//
//  LEVEL SPLIT (the biggest one in this unit):
//    shared — graphs of sin/cos/tan, simple equations (unit circle,
//             graphical, arcsin+symmetry), transformations and the
//             generalized sine function, simple applications,
//             intuitive data fitting (optional extension for GLF)
//    high   — quadratic-type and multiple-angle equations, CAS
//             solve with domain restriction, sine regression
//  Double-angle identities are deliberately OMITTED (not used
//  anywhere else in either track's curriculum).
//
//  No image files needed — all graphs are plot-graph() natives.
// ============================================================

#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "The Trigonometric Functions")
#let ex = exercise.with(chapter: "Trig Functions")

// gap-aware tangent for plotting (undefined near odd multiples of pi/2)
#let tan-fn(x) = if calc.abs(calc.cos(x)) < 0.03 { none } else {
  calc.tan(x)
}

= The Trigonometric Functions

#only-theory[
  Until now, $sin$, $cos$, and $tan$ have answered questions about one
  angle at a time. In this chapter we change the question: instead of
  asking what $sin(phi.alt)$ _is_ for a particular angle, we watch what
  it _does_ as the angle runs -- we treat the sine as a *function* and
  study its graph, exactly as we did for linear and quadratic
  functions. The template is the one you know: investigate the basic
  graph, classify its features, transform it, and use it to model.
  Only the algebra inside is new.
]

#objectives(
  bfkm[graph the functions $y = sin(x)$, $y = cos(x)$, and
    $y = tan(x)$, and describe their key features],
  bfkm[explain the connection between a trigonometric function's
    equation and its graph],
  obj(level: "basic")[solve simple trigonometric equations using the
    unit circle and graphs],
  bfkm(level: "high")[solve simple trigonometric equations, both
    graphically and analytically],
  [sketch and interpret transformations of the sine and cosine curves,
    and work with the generalized sine function
    $y = a dot sin(b dot (x - c)) + d$],
  bfkm[use trigonometric functions to describe real situations],
  bfkm(level: "high")[use the generalized sine function to model
    periodic phenomena such as oscillations, and fit a sine model to
    data -- by hand and with the CAS's sine regression],
  obj(level: "high")[use the CAS solve command with a restricted
    domain to obtain a finite list of solutions],
)

== The Graphs of Sine and Cosine

#exploration(title: "From Circle to Curve")[
  Take the table of exact values from the last chapter (and your
  calculator for the angles in between). For
  $x = 0, 30 degree, 60 degree, ..., 720 degree$, plot the points
  $(x, sin(x))$ on grid paper -- angle on the horizontal axis, sine
  value on the vertical. Connect them with a smooth curve. Before you
  plot: predict what the curve must do after $360 degree$, and say why
  the unit circle forces that answer. Then repeat for cosine on the
  same axes. What single transformation seems to map one curve onto
  the other?
]

#only-theory[
  The result is the most famous wave in mathematics. Reading its
  features straight off the unit circle: the point $P$ travels round
  and round, so its $y$\u{2011}coordinate rises to $1$, falls to $-1$,
  and repeats forever.
]

#fig(
  plot-graph(
    (fn: x => calc.sin(x), color: accent),
    (fn: x => calc.cos(x), color: warn-col),
    xmin: -6.9,
    xmax: 6.9,
    ymin: -1.5,
    ymax: 1.5,
    width: 12,
    height: 4.5,
  ),
  caption: [$y = sin(x)$ (teal) and $y = cos(x)$ (orange), $x$ in
    radians. One full period is $2 pi approx 6.28$.],
)

#keybox(title: "Features of the sine and cosine curves")[
  - Both functions are #vocab("periodic", "periodisch"): they repeat
    the same cycle of values over and over. The
    #vocab("period", "Periode") -- the length of one cycle -- is
    $360 degree$, i.e. $2 pi$.
  - Both have maximum value $1$ and minimum value $-1$. The
    #vocab("amplitude", "Amplitude") is the distance from the
    #vocab("midline", "Mittellinie") of the wave (here $y = 0$) to a
    maximum -- equivalently, half the vertical distance from a maximum
    to a minimum. For both basic curves the amplitude is $1$.
  - The two curves are congruent: the cosine curve is the sine curve
    shifted $90 degree$ (that is, $pi\/2$) to the left. This is the
    complementary-angle identity $cos(x) = sin(90 degree - x)$ from
    the last chapter, now visible as geometry.
]

#look-ahead(
  title: "The slope of the sine curve",
  preview: [differential calculus (the derivative)],
)[
  Look at the teal curve and eyeball its slope, the way you did for
  parabolas: at $x = 0$ the sine curve climbs at its steepest; at the
  top of the wave the slope is $0$; descending through $x = pi$ it
  falls at its steepest; at the bottom, $0$ again. Now sketch these
  slope values as a new curve above the same axis -- steepest positive,
  zero, steepest negative, zero, ... The curve you have just drawn
  freehand is, remarkably, the orange one. What that means, and why it
  is exactly true, is a story for the calculus unit -- but you have
  just discovered its shape by eye.
]

== The Graph of Tangent

#exploration(title: "Graphing Tangent")[
  For sine and cosine we started from values we already knew; do the
  same for $y = tan(x)$.
  + List the tangent values for
    $0 degree, plus.minus 30 degree, plus.minus 45 degree,
    plus.minus 60 degree, 120 degree, 135 degree, 150 degree,
    180 degree, 210 degree, 225 degree, 240 degree$.
  + Plot the points on grid paper and connect what can be connected.
  + Why are there no tangent values at $plus.minus 90 degree$ or
    $270 degree$? Think back to $tan = sin\/cos$ -- what happens to the
    fraction there? What feature does a graph show at inputs where a
    function blows up? You have met one before, on the graph of
    $y = 1\/x$.
]

#fig(
  plot-graph(
    (fn: tan-fn, color: accent),
    xmin: -6.9,
    xmax: 6.9,
    ymin: -3.5,
    ymax: 3.5,
    width: 12,
    height: 5,
    samples: 400,
  ),
  caption: [$y = tan(x)$, $x$ in radians. The branches repeat with
    period $pi$; the gaps sit at odd multiples of $pi\/2$.],
)

#keybox(title: "Features of the tangent curve")[
  - The tangent function is periodic with period $180 degree$, i.e.
    $pi$ -- _half_ that of sine and cosine.
  - It has #vocab("vertical asymptotes", "senkrechte Asymptoten")
    wherever $cos(x) = 0$, that is at
    $x = plus.minus 90 degree, plus.minus 270 degree, ...$ -- the same
    cycle repeats between each pair of asymptotes.
  - It has no amplitude: there are no maximum or minimum values.
]

== Solving Trigonometric Equations

#only-theory[
  Suppose we want to solve $sin(x) = 1/2$. We know
  $sin(30 degree) = 1/2$ -- but the last chapter taught us that
  $sin(150 degree) = 1/2$ too, and going around the circle again,
  $sin(390 degree)$, $sin(510 degree)$, ... In fact infinitely many
  angles work. So the bare equation is not yet a well-posed question.
  Two more pieces of information are needed:
  - Is $x$ measured in degrees or radians?
  - What is the #vocab("domain", "Definitionsbereich") -- in which
    interval are solutions wanted?
]

#example(title: "Solving with the unit circle")[
  Solve $sin(x) = 1/2$ for $-360 degree <= x <= 360 degree$.

  There are two _positions_ on the unit circle with
  $y$\u{2011}coordinate $1/2$: at $30 degree$ and, by symmetry, at
  $180 degree - 30 degree = 150 degree$. Every solution is one of
  these two positions, reached after some number of full turns.
  Within the domain, each position is hit twice -- once turning
  counterclockwise, once clockwise:
  $ x = 30 degree, quad 150 degree, quad -210 degree, quad
    -330 degree. $
]

#keybox(title: "The strategy")[
  + Find *one* solution (an exact value you know, or $arcsin$ /
    $arccos$ / $arctan$ on the calculator).
  + Use the unit circle to find the *second position*: the mirror
    angle $180 degree - x$ for sine, $-x$ (equivalently $360 degree -
    x$) for cosine, $x + 180 degree$ for tangent.
  + Add or subtract full turns of $360 degree$ (for tangent:
    $180 degree$) until you leave the domain. A quick sketch of the
    graph with the horizontal line $y = c$ shows how many solutions
    the domain must contain -- if your list has a different length,
    something is missing.
]

#fig(
  plot-graph(
    (fn: x => calc.sin(x), color: accent),
    (fn: x => 0.5, color: warn-col),
    xmin: -6.9,
    xmax: 6.9,
    ymin: -1.5,
    ymax: 1.5,
    width: 12,
    height: 4,
  ),
  caption: [Solving $sin(x) = 1/2$ graphically: four intersection
    points in $[-2 pi, 2 pi]$ -- so the algebra must deliver exactly
    four solutions.],
)

#ex(difficulty: 1, time: "15 min")[
  Solve each equation for $-360 degree <= x <= 360 degree$, using
  exact values and the unit circle.
  #auto-parts(
    4,
    [$sin(x) = sqrt(3)/2$],
    [$cos(x) = -1/2$],
    [$tan(x) = 1$],
    [$sin(x) = 0$],
  )
][
  #auto-parts(
    2,
    [$x = 60 degree, 120 degree, -240 degree, -300 degree$],
    [$x = plus.minus 120 degree, plus.minus 240 degree$],
    [$x = 45 degree, 225 degree, -135 degree, -315 degree$],
    [$x = 0 degree, plus.minus 180 degree, plus.minus 360 degree$],
  )
]

#ex(difficulty: 2, time: "15 min")[
  Solve each equation for $-2 pi <= x <= 2 pi$, giving exact answers
  in radians.
  #auto-parts(
    3,
    [$sin(x) = 1/2$],
    [$cos(x) = sqrt(3)/2$],
    [$sin(x) = -1$],
  )
][
  #auto-parts(
    3,
    [$x = pi/6, (5 pi)/6, -(7 pi)/6, -(11 pi)/6$],
    [$x = plus.minus pi/6, plus.minus (11 pi)/6$],
    [$x = -pi/2, (3 pi)/2$],
  )
]

#ex(difficulty: 2, time: "10 min", hints: (
  [The calculator's $sin^(-1)$, $cos^(-1)$, $tan^(-1)$ give one
    solution each. The unit circle gives the other position; sketch
    it.],
))[
  Solve each equation for $0 degree <= x <= 360 degree$, to the
  nearest degree.
  #auto-parts(
    3,
    [$sin(x) = 0.9$],
    [$cos(x) = -0.63$],
    [$tan(x) = -2.8$],
  )
][
  #auto-parts(
    3,
    [$x approx 64 degree$ or $116 degree$],
    [$x approx 129 degree$ or $231 degree$],
    [$x approx 110 degree$ or $290 degree$],
  )
]

#warning[
  The calculator's inverse functions return exactly *one* angle --
  $sin^(-1)$ and $tan^(-1)$ from $[-90 degree, 90 degree]$,
  $cos^(-1)$ from $[0 degree, 180 degree]$ -- because a function must.
  The other solutions are your job, every time. Before accepting an
  answer, sketch the graph and count the intersections in the domain:
  the count is a contract your solution list has to fulfill.
]

#only-high[
  === Equations That Hide a Quadratic

  Some trigonometric equations are quadratic equations wearing a
  costume. In $2 sin^2 (x) + 5 sin(x) - 3 = 0$, the unknown angle only
  ever appears inside $sin(x)$ -- so substitute $u = sin(x)$ and the
  costume falls away: $2 u^2 + 5 u - 3 = 0$. Solve the quadratic with
  the techniques you know, then translate each root for $u$ back into
  a trigonometric equation. One extra check appears at that final
  step: since $-1 <= sin(x) <= 1$, a root outside $[-1, 1]$ simply
  contributes no angles at all.
]

#only-high[
  #example(title: "A quadratic in disguise")[
    Solve $2 sin^2 (x) + 5 sin(x) - 3 = 0$ for $0 <= x <= 2 pi$.

    With $u = sin(x)$: $2 u^2 + 5 u - 3 = 0$, which factors as
    $(2 u - 1) dot (u + 3) = 0$, so $u = 1/2$ or $u = -3$. The second
    root is impossible for a sine, so it is discarded -- not an error,
    just an empty case. From $sin(x) = 1/2$:
    $ x = pi/6 quad "or" quad x = (5 pi)/6. $
  ]
]

#ex(level: "high", difficulty: 2, time: "20 min")[
  Solve each equation for $0 <= x <= 2 pi$, exactly.
  #auto-parts(
    3,
    [$2 cos^2 (x) - 5 cos(x) - 3 = 0$],
    [$2 sin^2 (x) + 3 sin(x) + 1 = 0$],
    [$tan^2 (x) + 2 tan(x) + 1 = 0$],
  )
][
  #auto-parts(
    1,
    [$cos(x) = -1/2$ (the root $cos(x) = 3$ is impossible), so
      $x = (2 pi)/3$ or $(4 pi)/3$.],
    [$sin(x) = -1$ or $sin(x) = -1/2$, so
      $x = (7 pi)/6, (3 pi)/2, (11 pi)/6$.],
    [$(tan(x) + 1)^2 = 0$, so $tan(x) = -1$ and
      $x = (3 pi)/4$ or $(7 pi)/4$.],
  )
]

#ex(level: "high", difficulty: 3, time: "15 min", hints: (
  [Substitute $u = 2x$ and solve $sin(u) = sqrt(2)\/2$ first -- but
    note which domain $u$ lives in! If $0 degree <= x <= 360 degree$,
    then $0 degree <= u <= 720 degree$: two full turns, twice as many
    solutions.],
))[
  Solve $sin(2x) = sqrt(2)/2$ for $0 degree <= x <= 360 degree$.
][
  With $u = 2x$ and $0 degree <= u <= 720 degree$:
  $u = 45 degree, 135 degree, 405 degree, 495 degree$. Halving each,
  $ x = 22.5 degree, quad 67.5 degree, quad 202.5 degree, quad
    247.5 degree. $
  The angles found in the first step are values of $2x$, not of $x$ --
  forgetting to halve them (or to double the domain) are the two
  classic mistakes here.
]

#ai-box(role: "Checker")[
  Solve $tan(x) = sin(x)$ for $0 <= x <= pi$ on paper first. (Write
  $tan$ as $sin\/cos$ and factor -- resist the urge to divide both
  sides by $sin(x)$.) Then ask an AI to solve the same equation and
  compare line by line. Watch for one specific move: does the AI at
  any point divide both sides by $sin(x)$? Dividing by something that
  can be zero silently deletes solutions -- check whether its final
  answer is missing one of yours, and decide who is right.
]

#only-high[
  === Solving with the CAS: Restricting the Domain

  Your CAS solves trigonometric equations symbolically -- but ask it
  to solve $sin(x) = 1/2$ over all real numbers and it must describe
  infinitely many solutions, which it does with a whole-number
  parameter (typically shown as $n 1$ or $k$):
  `solve(sin(x)=1/2, x)` $->$
  $x = 2 pi dot n 1 + (5 pi)/6 quad "or" quad x = 2 pi dot n 1 + pi/6$.
  That answer is correct and worth being able to read -- each value of
  the parameter is one more trip around the circle. But in a concrete
  problem you almost always want a finite list, and for that you tell
  the CAS the domain, with the "with" operator (the vertical bar):
  ```
  solve(sin(x)=1/2, x) | 0 <= x <= 4*pi
  ```
  which returns exactly the four solutions in that interval. The same
  restriction syntax works for equations with no symbolic solution at
  all -- `solve(cos(x)=-x, x)` -- where the CAS answers numerically.
  Two things remain your job, not the machine's: setting the
  angle mode (degree vs. radian) to match the problem, and choosing
  the domain -- the CAS answers the question exactly as posed, and a
  wrong mode poses the wrong question without any warning.
]

#ex(level: "high", difficulty: 2, time: "20 min")[
  Use your CAS with a domain restriction to solve each equation. Give
  answers to three significant figures (or exactly, where the CAS
  offers exact values). Sketch each pair of graphs first and predict
  the number of solutions before you solve.
  #auto-parts(
    2,
    [$sin(x) = cos(x - 20 degree)$, $quad 0 degree <= x <= 540 degree$],
    [$cos(x) = -x$, $quad -pi <= x <= 2 pi$],
    [$sin(x) = x^2 - 1$, $quad -2 pi <= x <= 2 pi$],
    [$tan(x) = 2x - 3$, $quad 0 <= x <= 2 pi$],
  )
][
  #auto-parts(
    2,
    [$x = 55 degree, 235 degree, 415 degree$],
    [$x approx -0.739$ (one solution only)],
    [$x approx -0.637$ or $x approx 1.41$],
    [$x approx 4.55$],
  )
]

#only-high[
  #remark[
    Part (b) deserves a pause: $cos(x) = -x$ mixes a trigonometric
    function with a plain polynomial, and no amount of unit-circle
    cleverness produces an exact solution -- none exists in any form
    you could write down. Numerical solving is not the lazy option
    here; it is the _only_ option. Knowing which equations have exact
    solutions and which do not is itself mathematical knowledge.
  ]
]

== Transformations and the Generalized Sine Function

#exploration(title: "Transformations of sin and cos")[
  Using a graphing tool in radian mode (CAS, GeoGebra, or Desmos),
  graph each pair on the same axes. For each pair: what stayed the
  same, what changed, and _why does the algebra force exactly that
  change?_
  + $y = sin(x)$ and $y = sin(x) + 3$
  + $y = cos(x)$ and $y = 2 cos(x)$
  + $y = cos(x)$ and $y = cos(2x)$
  + $y = sin(x)$ and $y = sin(x + pi/3)$
  + $y = sin(x)$ and $y = cos(x - pi/2)$
  The punchline of the last pair: it is a single curve drawn twice.
]

#only-theory[
  Nothing here is specific to trigonometry -- these are the same four
  transformations you studied for parabolas, applied to a new parent
  function. What _is_ new is that each transformation now has a
  physical name, because sine curves describe oscillations: the
  vertical stretch sets the amplitude, the horizontal stretch sets the
  period, and the shifts position the wave.
]

#keybox(title: "The generalized sine function")[
  $ y = a dot sin(b dot (x - c)) + d $
  - $a$ -- vertical stretch: the *amplitude* is $abs(a)$; negative $a$
    additionally flips the curve.
  - $b$ -- horizontal stretch: the *period* becomes
    $ "period" = (2 pi) / abs(b) quad "(or " (360 degree) / abs(b)
      " in degrees)". $
  - $c$ -- horizontal shift: the curve moves $c$ to the right
    ($c > 0$) or left ($c < 0$).
  - $d$ -- vertical shift: the *midline* becomes $y = d$; the maximum
    is $d + abs(a)$ and the minimum $d - abs(a)$.
  Everything works identically for
  $y = a dot cos(b dot (x - c)) + d$; the cosine version is often more
  convenient for modeling, because its "starting point" $x = c$ is a
  _maximum_ -- easy to spot in data.
]

#warning[
  The formula above has $b$ multiplying the _bracket_
  $(x - c)$. In the frequently-seen form $y = sin(b x - e)$ the shift
  is *not* $e$ but $e\/b$ -- factor out $b$ first:
  $sin(2x - pi/3) = sin(2 dot (x - pi/6))$, a shift of $pi\/6$, not
  $pi\/3$. Always bring the expression to the factored form before
  reading off $c$.
]

#ex(difficulty: 1, time: "10 min")[
  Without graphing, state the amplitude, period, midline, maximum, and
  minimum of each function.
  #auto-parts(
    3,
    [$y = 3 sin(x)$],
    [$y = 1/2 cos(x) - 2$],
    [$y = -4 sin(2x) + 1$],
  )
][
  #auto-parts(
    1,
    [amplitude $3$, period $2 pi$, midline $y = 0$, max $3$, min
      $-3$],
    [amplitude $1/2$, period $2 pi$, midline $y = -2$, max $-1.5$,
      min $-2.5$],
    [amplitude $4$, period $pi$, midline $y = 1$, max $5$, min $-3$
      (the minus sign flips the curve but does not change the
      amplitude)],
  )
]

#ex(difficulty: 2, time: "25 min", hints: (
  [Sketch in layers, in this order: midline first, then the maximum
    and minimum guide lines, then mark where one period starts and
    ends, then draw the wave through the guides.
    #heuristic("solve a simpler version first")],
))[
  Sketch each function over at least one full period, for
  $-2 pi <= x <= 2 pi$. Label the midline, the extremes, and the
  period.
  #auto-parts(
    3,
    [$y = sin(x) + 2$],
    [$y = 2 sin(x) - 1$],
    [$y = cos(x - pi/4)$],
    [$y = cos(2x)$],
    [$y = sin(x + pi/3) - 1$],
    [$y = tan(x + pi/6)$],
  )
][
  #image-grid(
    2,
    plot-graph(
      x => calc.sin(x) + 2,
      xmin: -6.9, xmax: 6.9, ymin: -3.5, ymax: 3.5,
      size: 5.5,
    ),
    plot-graph(
      x => 2 * calc.sin(x) - 1,
      xmin: -6.9, xmax: 6.9, ymin: -3.5, ymax: 3.5,
      size: 5.5,
    ),
    plot-graph(
      x => calc.cos(x - calc.pi / 4),
      xmin: -6.9, xmax: 6.9, ymin: -3.5, ymax: 3.5,
      size: 5.5,
    ),
    plot-graph(
      x => calc.cos(2 * x),
      xmin: -6.9, xmax: 6.9, ymin: -3.5, ymax: 3.5,
      size: 5.5,
    ),
    plot-graph(
      x => calc.sin(x + calc.pi / 3) - 1,
      xmin: -6.9, xmax: 6.9, ymin: -3.5, ymax: 3.5,
      size: 5.5,
    ),
    plot-graph(
      (fn: x => tan-fn(x + calc.pi / 6), samples: 400),
      xmin: -6.9, xmax: 6.9, ymin: -3.5, ymax: 3.5,
      size: 5.5,
    ),
  )
  Reading order: (a), (b) in the first row, then (c), (d), then (e),
  (f). Checkpoints: (a) midline $y = 2$; (b) amplitude $2$, midline
  $y = -1$; (c) maximum at $x = pi/4$; (d) period $pi$ -- two full
  waves fit where one used to; (e) maximum $0$, minimum $-2$; (f)
  asymptotes shifted to $x = pi/3 + k dot pi$.
]

#ex(difficulty: 2, time: "15 min", hints: (
  [Read the features in this order: midline (average of max and min),
    amplitude (max minus midline), period (peak to peak), then a
    convenient starting point for sine (midline, going up) or cosine
    (a maximum).],
))[
  Write an equation for each function shown. (Many correct answers
  exist -- give one.)
  #auto-parts(
    2,
    [#plot-graph(
      x => 2 * calc.sin(calc.pi / 2 * x) + 1,
      xmin: -4.5, xmax: 4.5, ymin: -2.5, ymax: 3.5,
      size: 5.5,
    )],
    [#plot-graph(
      x => 3 * calc.cos(calc.pi / 3 * x) - 1,
      xmin: -6.5, xmax: 6.5, ymin: -4.5, ymax: 3.5,
      size: 5.5,
    )],
  )
][
  #auto-parts(
    1,
    [Midline $y = 1$, amplitude $2$, period $4$, so
      $b = (2 pi)\/4 = pi\/2$; rising through the midline at $x = 0$:
      $ y = 2 sin(pi/2 dot x) + 1. $],
    [Midline $y = -1$, amplitude $3$, period $6$, so $b = pi\/3$;
      maximum at $x = 0$ makes cosine the natural choice:
      $ y = 3 cos(pi/3 dot x) - 1. $],
  )
]

#ex(level: "high", difficulty: 3, time: "10 min")[
  Write *one sine and one cosine* equation for the function shown.
  #plot-graph(
    x => -1.5 * calc.sin(calc.pi / 4 * (x - 1)) + 2,
    xmin: -8.5, xmax: 8.5, ymin: -0.5, ymax: 4.5,
    width: 11, height: 5,
  )
][
  Midline $y = 2$, amplitude $1.5$, period $8$, so $b = pi\/4$. The
  curve _falls_ through the midline at $x = 1$, so as a sine it is
  flipped: $y = -1.5 sin(pi/4 dot (x - 1)) + 2$. A maximum sits at
  $x = -1$, so as a cosine: $y = 1.5 cos(pi/4 dot (x + 1)) + 2$. Both
  describe the same curve -- for sine and cosine versions of one
  curve, the horizontal shifts always differ by a quarter period.
]

== Applications and Modeling

#only-theory[
  Sine curves earn their keep describing anything that repeats: a
  Ferris wheel cabin, the tide in a harbor, daylight over a year, a
  swinging pendulum, alternating current. The generalized sine
  function is the dictionary between the situation and the formula --
  amplitude, period, midline, and shift each answer one concrete
  question about the situation.
]

#abstraction-ladder(
  l0: [A Ferris wheel, 45 m tall, boards its passengers 3 m above the
    ground and turns once every 10 minutes.],
  l1: [height oscillates between 3 m and 45 m; one cycle = 10 min;
    boarding happens at the _minimum_],
  l2: [midline $(45 + 3)\/2 = 24$; amplitude $21$; period $10$, so
    $b = (2 pi)\/10 = pi\/5$; a flipped cosine starts at its minimum],
  l3: [$h(t) = -21 dot cos(pi/5 dot t) + 24$],
)

#example(title: "Riding the model")[
  For the Ferris wheel above, with $t$ in minutes after boarding:
  $h(3) = -21 dot cos(3 pi \/ 5) + 24 approx 30.5$ m. And the
  passenger first reaches $40$ m when
  $-21 cos(pi/5 dot t) + 24 = 40$, i.e.
  $cos(pi/5 dot t) = -16/21$, giving
  $t = 5/pi dot arccos(-16\/21) approx 3.88$ minutes.
]

#ex(difficulty: 1, time: "15 min")[
  The water depth at the end of a North Sea pier is modeled by
  $ d(t) = 1.9 dot sin(pi/6 dot (t - 3)) + 5.1, $
  where $d$ is the depth in meters and $t$ the time in hours after
  midnight.
  + What is the period of this function, and what does it mean
    physically?
  + Estimate the depth at midnight and at 14:00.
  + At what time does the water first reach its greatest depth, and
    what is that depth?
][
  + Period $= (2 pi) \/ (pi\/6) = 12$ hours: high tide returns twice
    a day.
  + $d(0) = 5.1 - 1.9 = 3.2$ m;
    $d(14) = 1.9 dot sin((11 pi)/6) + 5.1 = 5.1 - 0.95 approx 4.15$
    m.
  + The sine is maximal when $pi/6 dot (t - 3) = pi/2$, i.e. at
    $t = 6$ (06:00), with depth $5.1 + 1.9 = 7.0$ m.
]

#ex(difficulty: 2, time: "15 min")[
  The number of daylight hours in Basel is modeled by
  $ h(x) = A dot sin(0.0172 dot (x - 80)) + B, $
  where $x$ is the day of the year ($x = 1$ on January 1). The longest
  day (June 21) has about $16$ hours of daylight; the shortest
  (December 21) has about $8.5$.
  + Find $A$ and $B$.
  + Where does the strange-looking number $0.0172$ come from?
  + How many daylight hours does the model predict for February 1
    ($x = 32$)?
][
  + $A = (16 - 8.5)\/2 = 3.75$ and $B = (16 + 8.5)\/2 = 12.25$.
  + It is $b = (2 pi)\/365 approx 0.0172$ -- the period of the model
    is one year.
  + $h(32) = 3.75 dot sin(0.0172 dot (-48)) + 12.25 approx 9.5$
    hours.
]

#ex(level: "high", difficulty: 3, time: "20 min", hints: (
  [Minimum on January 1 and maximum on July 1 fix everything: the
    midline is halfway, the amplitude is half the difference, the
    period is 12 months, and a _flipped_ cosine has its minimum at
    the start.],
))[
  An open-air swimming pool counts a minimum of $200$ visitors per day
  around January 1 and a maximum of $#num(3800)$ around July 1, with a
  yearly rhythm.
  + Model the daily visitor count with a generalized cosine function
    $V(m)$, where $m$ is the month ($m = 1$ on January 1).
  + What does the model predict for April 1?
  + Between which months does the model predict $#num(3000)$ or more
    visitors per day? (Use your CAS with a domain restriction.)
][
  + Midline $#num(2000)$, amplitude $#num(1800)$, period $12$,
    minimum at $m = 1$:
    $ V(m) = -#num(1800) dot cos(pi/6 dot (m - 1)) + #num(2000). $
  + $V(4) = -#num(1800) dot cos(pi/2) + #num(2000) = #num(2000)$
    visitors.
  + Solving $V(m) = #num(3000)$ for $1 <= m <= 13$ gives
    $m approx 5.12$ and $m approx 8.88$: from early May to late
    August.
]

== Fitting a Sine Function to Data

#only-basic[
  #remark[
    This closing section is an *optional extension* for the
    Foundations course -- nothing later depends on it. It is included
    because estimating a sine model from data is a genuinely useful
    skill, and because it uses everything from this chapter at once.
    If you enjoyed the modeling exercises, read on.
  ]
]

#only-theory[
  So far the model was handed to you. The more honest situation is the
  reverse: you have _measurements_, you suspect a periodic pattern,
  and you want the function. The four parameters can be estimated
  straight from the data, in this order:
  + *Midline* $d$: halfway between the largest and smallest values.
  + *Amplitude* $a$: from the midline up to the maximum.
  + *Period*: the horizontal distance from one maximum to the next
    (or minimum to minimum); then $b = (2 pi) \/ "period"$.
  + *Shift* $c$: for a cosine model, read off where a maximum sits --
    that is $c$.
]

#example(title: "Average daytime temperature in Basel")[
  Rounded long-term averages of the daytime high in Basel, by month
  ($m = 1$ is January):
  #data-table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr,
      1fr, 1fr),
    row-height: auto,
    [$m$], [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11],
    [12],
    [$T$ (°C)], [4], [6], [11], [15], [19], [23], [25], [25], [20],
    [15], [8], [5],
  )
  Maximum $approx 25$ (July), minimum $approx 4$ (January). So:
  midline $d = (25 + 4)\/2 = 14.5$, amplitude $a = 10.5$, period
  $12$ months so $b = pi\/6$, and the maximum sits at $m = 7$:
  $ T(m) = 10.5 dot cos(pi/6 dot (m - 7)) + 14.5. $
  Spot-checking: the model gives $T(1) = 4$ (data: $4$),
  $T(4) = 14.5$ (data: $15$), $T(3) = 9.3$ (data: $11$). The fit is
  good but not perfect -- real data never lies exactly on a formula,
  and March in Basel is a little warmer than a pure cosine says it
  should be. A model that captures the pattern while missing the
  points by a degree is doing its job.
]

#ex(difficulty: 2, time: "20 min")[
  The water depth at a buoy, measured every two hours from midnight:
  #data-table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    row-height: auto,
    [$t$ (h)], [0], [2], [4], [6], [8], [10], [12], [14], [16], [18],
    [$d$ (m)], [6.7], [8.3], [9.1], [8.1], [6.4], [5.6], [6.7],
    [8.4], [9.2], [8.2],
  )
  + Plot the points and convince yourself the pattern is periodic.
  + Estimate the amplitude, midline, period, and the location of a
    maximum from the data.
  + Write a cosine model for the depth, and check it against at least
    three of the data points.
][
  + Maximum $approx 9.2$ m near $t = 4$ and again near $t = 16$;
    minimum $approx 5.6$ m near $t = 10$.
  + Midline $(9.2 + 5.6)\/2 = 7.4$; amplitude $1.8$; period
    $16 - 4 = 12$ h, so $b = pi\/6$; maximum at $t = 4$.
  + $d(t) = 1.8 dot cos(pi/6 dot (t - 4)) + 7.4$. Checks:
    $d(0) = 1.8 dot cos(-(2 pi)/3) + 7.4 = 6.5$ (data: $6.7$),
    $d(4) = 9.2$ (data: $9.1$), $d(10) = 5.6$ (data: $5.6$). Small
    estimation differences in the parameters are expected -- the test
    is whether the curve runs through the middle of the data, not
    whether it hits every point.
]

#only-high[
  === Sine Regression on the CAS

  Estimating parameters by eye is the skill; the CAS automates it.
  Enter the months and the temperatures from the Basel example as two
  lists, then run the *sine regression* (`SinReg`, in the statistics
  menu) on them, telling it which lists hold $x$ and $y$. The CAS
  fits $y = a dot sin(b x + c) + d$ by minimizing the total
  disagreement with the data. For the Basel temperatures it returns
  approximately
  $ y approx 10.6 dot sin(0.515 x - 2.01) + 14.5. $
  Two readings of this output matter more than the digits:
  - The regression's $b approx 0.515$ corresponds to a period of
    $(2 pi)\/0.515 approx 12.2$ months. The CAS does not know that a
    year has 12 months -- it found the periodicity _in the data_. That
    the two nearly agree is genuine evidence the pattern is annual.
  - The CAS fits the _sine_ form with the shift inside as $+c$;
    converting to our cosine form recovers essentially the hand-built
    model. Same curve, different clothes -- the same lesson as writing
    one graph two ways earlier in this chapter.
]

#ex(level: "high", difficulty: 2, time: "20 min")[
  Run a sine regression on the buoy data from the previous exercise.
  + Write down the CAS's model and its parameters.
  + Convert the regression's parameters into amplitude, period, and
    midline, and compare them with your hand-fitted values.
  + Which of the two models do you trust more, and what would you
    want to know about the data before deciding?
][
  + Approximately
    $d approx 1.79 dot sin(0.522 t - 1.05) + 7.40$ (parameters vary
    slightly with the CAS model used).
  + Amplitude $approx 1.79$ (hand: $1.8$), period
    $(2 pi)\/0.522 approx 12.0$ h (hand: $12$), midline $approx 7.40$
    (hand: $7.4$) -- the two models nearly coincide.
  + There is no single right answer, but the honest considerations
    are: the regression uses _all_ the points instead of just the
    extremes, which is a genuine advantage; on the other hand, ten
    measurements with reading errors of $plus.minus 0.1$ m cannot
    distinguish between the two models at all. What you would want to
    know: how the depths were measured, and whether the physical
    situation (tides!) fixes the period at exactly $12$ hours -- if it
    does, building that knowledge into the model by hand beats letting
    the regression estimate it.
]

#look-ahead(
  title: "Where the waves go from here",
  preview: [physics (oscillations and waves) and the calculus unit],
)[
  Everything periodic you will meet from now on speaks this chapter's
  language: a pendulum in physics is a sine function of time, a sound
  wave is one of position, alternating current one of both. And the
  slope-sketching you did by eye at the start of this chapter -- the
  sine curve's slope tracing out the cosine curve -- returns as an
  exact theorem in the calculus unit, where it is the reason radians
  were the right choice all along.
]

#print-hints()
#print-vocab()
