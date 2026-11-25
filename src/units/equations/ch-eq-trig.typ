// ch-eq-trig.typ — Trigonometric Equations (equations booklet)
//
// COMPLETE (Turn 6). Theory with three unit-circle figures, worked
// examples, exercises (GLF + SPF), error-analysis tasks, warnings,
// calculator block. Checkpoint and stage check from the skeleton.
//
// TARGET MISCONCEPTIONS (see stage notes)
//   Trigonometric Equations: M4 one trig solution only; M10 DEG/RAD mode
// STATUS
//   done:  checkpoint, stage check, theory, three unit-circle figures,
//          examples, exercises (GLF and SPF), two error-analysis
//          tasks for M4 and M10 (plus one for dividing by sin(x)),
//          calculator block. All answers verified numerically (root
//          scan + substitution; SymPy is not installable here).
//   to do: nothing in this file.
//
// NEEDS A VISUAL CHECK — not compiled (no Typst in the drafting
// environment): unit-circle figures (label positions), route boxes,
// goto-first links, yr() cells in checks.

#import "../../common/preamble.typ": *
#import "config.typ": *
#show: chapter-template.with(title: "Trigonometric Equations")
#let ex = exercise.with(chapter: "Equations")
#let check = check.with(ex: ex)

// ── Unit-circle figure ───────────────────────────────────
// Native Typst (no packages). kind: "sin", "cos" or "tan"; a: the
// first solution x₁ as an angle (e.g. 30deg); value: content shown
// next to the axis. Shows the two solutions x₁ and x₂ of one turn.
#let uc-fig(kind, a, value, R: 1.5cm) = {
  let W = 2 * R + 1.5cm
  let cx = W / 2
  let cy = W / 2
  let pt(t, r: 1.0) = (cx + R * r * calc.cos(t), cy - R * r * calc.sin(t))
  let seg(p, q, stroke: 0.8pt + black) = place(
    top + left,
    dx: p.at(0),
    dy: p.at(1),
    line(
      start: (0pt, 0pt),
      end: (q.at(0) - p.at(0), q.at(1) - p.at(1)),
      stroke: stroke,
    ),
  )
  let mark(p) = place(
    top + left,
    dx: p.at(0) - 2pt,
    dy: p.at(1) - 2pt,
    circle(radius: 2pt, fill: accent, stroke: none),
  )
  let lab(p, body, dx: 0pt, dy: 0pt) = place(
    top + left,
    dx: p.at(0) + dx,
    dy: p.at(1) + dy,
    text(size: 8pt, body),
  )
  let axis = 0.5pt + luma(150)
  let guide = (paint: accent, thickness: 1pt, dash: "dashed")
  let radius = 0.9pt + accent
  box(width: W, height: W, {
    place(
      top + left,
      dx: cx - R,
      dy: cy - R,
      circle(radius: R, stroke: 0.8pt + luma(110)),
    )
    seg((cx - 1.2 * R, cy), (cx + 1.2 * R, cy), stroke: axis)
    seg((cx, cy - 1.2 * R), (cx, cy + 1.2 * R), stroke: axis)
    let o = (cx, cy)
    if kind == "sin" {
      let p1 = pt(a)
      let p2 = pt(180deg - a)
      seg(p2, p1, stroke: guide)
      seg(o, p1, stroke: radius)
      seg(o, p2, stroke: radius)
      mark(p1)
      mark(p2)
      lab(p1, $x_1$, dx: 4pt, dy: -12pt)
      lab(p2, $x_2$, dx: -14pt, dy: -12pt)
      lab((cx, p1.at(1)), value, dx: 4pt, dy: -11pt)
    } else if kind == "cos" {
      let p1 = pt(a)
      let p2 = pt(-a)
      seg(p2, p1, stroke: guide)
      seg(o, p1, stroke: radius)
      seg(o, p2, stroke: radius)
      mark(p1)
      mark(p2)
      lab(p1, $x_1$, dx: 4pt, dy: -12pt)
      lab(p2, $x_2$, dx: 4pt, dy: 2pt)
      lab((p1.at(0), cy), value, dx: -3pt, dy: 4pt)
    } else {
      let p1 = pt(a)
      let p2 = pt(a + 180deg)
      let t = (cx + R, cy - R * calc.tan(a))
      seg((cx + R, cy - 1.4 * R), (cx + R, cy + 1.4 * R), stroke: axis)
      seg(p2, t, stroke: radius)
      mark(p1)
      mark(p2)
      mark(t)
      lab(p1, $x_1$, dx: -16pt, dy: -12pt)
      lab(p2, $x_2$, dx: -14pt, dy: 2pt)
      lab(t, value, dx: 4pt, dy: -10pt)
    }
  })
}

= Trigonometric Equations

#only-theory[
  Anything that repeats can be described with sine and cosine: the
  height of a seat on a Ferris wheel, the tides, a sound wave, the
  alternating current in a wall socket. To ask _when_ such a quantity
  takes a given value, you must solve a
  #vocab("trigonometric equation", "trigonometrische Gleichung"), for
  example $sin(x) = 1/2$.

  These equations have a feature that none of the earlier ones had.
  Because the functions repeat, they usually have *several* solutions
  in an interval, and over all real numbers even infinitely many. So
  the question "in which interval?" is part of the problem. A calculator
  does not help much here: it returns exactly one solution. This chapter
  shows how to find the others.
]

#objectives(
  [Find all solutions in an interval, using the calculator first value and the unit circle],
  [Choose degrees or radians correctly and set the calculator mode],
)

// ════════════════════════════════════════════════════════
== Trigonometric Equations <st-trig>

#check(
  "Trigonometric Equations",
  (
    [Solve $sin(x) = 1/2$ for $0 degree <= x < 360 degree$.],
    [Solve $cos(x) = -1/2$ for $0 degree <= x < 360 degree$.],
    [Solve $tan(x) = 1$ for $0 degree <= x < 360 degree$.],
    [Solve $sin(x) = 2$.],
  ),
  (
    [$x = 30 degree$ or $x = 150 degree$],
    [$x = 120 degree$ or $x = 240 degree$],
    [$x = 45 degree$ or $x = 225 degree$],
    [No real solution],
  ),
  pass: [Skip to the checkpoint in #goto-first(<st-poly>).],
  fail: [Work through this section.],
)

#only-theory[
  Take $sin(x) = 1/2$. Your calculator answers $sin^(-1)(1/2) = 30 degree$.
  But $150 degree$ is also a solution, because $sin(150 degree) = 1/2$.
  And so is $390 degree$. The calculator's answer is called the
  #vocab("principal value", "Hauptwert"). It is only the _first_
  solution, and finding the rest is your job.
]

#keybox(title: "What the calculator gives you")[
  The inverse functions return one angle from a fixed range:
  - $sin^(-1)(c)$ lies between $-90 degree$ and $90 degree$
    (between $-pi/2$ and $pi/2$),
  - $cos^(-1)(c)$ lies between $0 degree$ and $180 degree$
    (between $0$ and $pi$),
  - $tan^(-1)(c)$ lies between $-90 degree$ and $90 degree$
    (between $-pi/2$ and $pi/2$, not including the ends).

  All other solutions must come from the unit circle.
]

#only-theory[
  On the #vocab("unit circle", "Einheitskreis") (radius $1$), the point
  at angle $x$ has the coordinates $(cos(x), sin(x))$. So $sin(x)$ is
  the *height* of that point, and $cos(x)$ is its *horizontal position*.
  And $tan(x)$ is the height at which the line through the center and
  the point crosses the vertical line $x = 1$. Each figure shows one
  equation. The dashed line or the line through the center meets the
  circle in exactly two points, and those are the two solutions
  $x_1$ and $x_2$ of one turn.

  #grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: 8pt,
    fig(
      uc-fig("sin", 30deg, $1/2$),
      caption: [$sin(x) = 1/2$: the horizontal line meets the circle at
        $x_1 = 30 degree$ and $x_2 = 180 degree - x_1$.],
    ),
    fig(
      uc-fig("cos", 60deg, $1/2$),
      caption: [$cos(x) = 1/2$: the vertical line meets the circle at
        $x_1 = 60 degree$ and $x_2 = -x_1$, which is $360 degree - x_1$.],
    ),
    fig(
      uc-fig("tan", 45deg, $1$),
      caption: [$tan(x) = 1$: the line through the center meets the circle
        at $x_1 = 45 degree$ and $x_2 = x_1 + 180 degree$.],
    ),
  )
]

#keybox(title: "Solving sin(x) = c, cos(x) = c and tan(x) = c")[
  + *Can there be a solution?* For sine and cosine you need
    $-1 <= c <= 1$. For tangent, every $c$ works.
  + *First solution $x_1$:* use the inverse function on your calculator,
    in the angle mode that matches the problem.
  + *Second solution $x_2$ in the same turn,* from the symmetry of the
    unit circle:
    - sine: $x_2 = pi - x_1$ (in degrees: $180 degree - x_1$),
    - cosine: $x_2 = -x_1$ (in degrees: $-x_1$, which is the same as
      $360 degree - x_1$),
    - tangent: $x_2 = x_1 + pi$ (in degrees: $x_1 + 180 degree$).
  + *All solutions in the interval:* add or subtract full periods
    ($2 pi$ or $360 degree$ for sine and cosine, $pi$ or $180 degree$
    for tangent) until you leave the interval. Keep only the values
    inside it.
]

#keybox(title: "Degrees or radians?")[
  Use *degrees* when the angle is part of a figure, for example in a
  triangle. Use *radians* when $x$ is a real number, for example when
  $x$ is the input of a function, a time or a number on an axis.
  The interval in the problem tells you which one to use, and your
  calculator must be in the same mode. Useful conversions:
  $180 degree = pi$, $90 degree = pi/2$, $60 degree = pi/3$,
  $45 degree = pi/4$, $30 degree = pi/6$.
]

#example(title: "Exact values, in radians")[
  Solve $sin(x) = 1/2$ for $0 <= x < 2 pi$. You know that
  $sin(pi/6) = 1/2$, so $x_1 = pi/6$. The second solution is
  $x_2 = pi - pi/6 = (5 pi)/6$. Both are in the interval, and adding
  $2 pi$ would leave it. So $x = pi/6$ or $x = (5 pi)/6$.
]

#example(title: "With the calculator, in degrees")[
  Solve $cos(x) = 0.3$ for $0 degree <= x < 360 degree$. Set DEG mode.
  Then $x_1 = cos^(-1)(0.3) approx 72.54 degree$. For cosine,
  $x_2 = 360 degree - x_1 approx 287.46 degree$. So
  $x approx 72.54 degree$ or $x approx 287.46 degree$.
]

#example(title: "A negative value")[
  Solve $sin(x) = -0.6$ for $0 degree <= x < 360 degree$. The calculator
  gives $x_1 = sin^(-1)(-0.6) approx -36.87 degree$. That is outside the
  interval, but it is still a valid solution. Use it in the formula:
  $x_2 = 180 degree - x_1 approx 216.87 degree$. Then move $x_1$ into the
  interval by adding $360 degree$: $-36.87 degree + 360 degree = 323.13 degree$.
  So $x approx 216.87 degree$ or $x approx 323.13 degree$.
]

#example(title: "Tangent has period π")[
  Solve $tan(x) = 2$ for $0 <= x < 2 pi$. Set RAD mode.
  $x_1 = tan^(-1)(2) approx 1.107$ and $x_2 = x_1 + pi approx 4.249$.
  Adding another $pi$ would give $7.39$, which is more than $2 pi$.
  So $x approx 1.107$ or $x approx 4.249$.
]

#example(title: "A longer interval")[
  Solve $cos(x) = 1/2$ for $0 <= x < 4 pi$. In the first turn,
  $x_1 = pi/3$ and $x_2 = 2 pi - pi/3 = (5 pi)/3$. The interval is two
  turns long, so add $2 pi$ to both:
  $pi/3 + 2 pi = (7 pi)/3$ and $(5 pi)/3 + 2 pi = (11 pi)/3$.
  There are four solutions: $x = pi/3, (5 pi)/3, (7 pi)/3, (11 pi)/3$.
]

#example(title: "Rearrange first, and a doubled angle")[
  Solve $2 sin(x) + 1 = 0$ for $0 <= x < 2 pi$. Isolate:
  $sin(x) = -1/2$. Then $x_1 = -pi/6$, $x_2 = pi - (-pi/6) = (7 pi)/6$,
  and $x_1 + 2 pi = (11 pi)/6$. So $x = (7 pi)/6$ or $x = (11 pi)/6$.

  Now solve $sin(2x) = 1/2$ for $0 <= x < 2 pi$. If $x$ runs from $0$ to
  $2 pi$, then $2x$ runs from $0$ to $4 pi$, two full turns. So solve for
  $2x$ in that longer interval:
  $2x = pi/6, (5 pi)/6, (13 pi)/6, (17 pi)/6$.
  Then divide by $2$:
  $x = pi/12, (5 pi)/12, (13 pi)/12, (17 pi)/12$.
]

#example(title: "No solution")[
  $sin(x) = 1.5$ has no solution, since the sine is never greater than
  $1$. Your calculator shows an error for $sin^(-1)(1.5)$.
]

#warning[
  *One value from the calculator is not the whole answer.* Take
  $cos(x) = 0.5$ for $0 degree <= x < 360 degree$. The calculator says
  $60 degree$, and that is correct, but $300 degree$ is a solution too.
  Whenever the interval covers a whole turn, expect *two* solutions for
  sine, cosine and tangent, and more when the interval is longer or when
  the angle is $2x$. Also do not mix up the three symmetries: $180 degree - x_1$
  belongs to the *sine*. For the cosine it gives a wrong value, since
  $cos(120 degree) = -0.5$.
]

#warning[
  *Check the angle mode before you press anything.* In DEG mode,
  $sin(30) = 0.5$. In RAD mode, the same key presses give
  $sin(30) approx -0.988$, because the calculator reads $30$ as
  $30$ radians. The same happens in the other direction: in RAD mode,
  $cos^(-1)(0.5)$ gives $1.047$, not $60$. If the interval of the problem
  is in radians, such as $0 <= x < 2 pi$, your answers must be in radians
  as well. Numbers like $30$ and $150$ are not even in that interval.
]

#only-high[
  #keybox(title: "General solution")[
    Without an interval, every solution is wanted. Add all full periods,
    with $k in ZZ$ ($k$ is any integer):
    - $sin(x) = c$: $x = x_1 + k dot 2 pi$ or $x = pi - x_1 + k dot 2 pi$,
    - $cos(x) = c$: $x = plus.minus x_1 + k dot 2 pi$,
    - $tan(x) = c$: $x = x_1 + k dot pi$.

    A given interval then selects the values of $k$ that fit.
  ]

  #example(title: "General solution")[
    Solve $sin(x) = 1/2$ for all real $x$. With $x_1 = pi/6$:
    $x = pi/6 + k dot 2 pi$ or $x = (5 pi)/6 + k dot 2 pi$, with $k in ZZ$.
    For $k = 0$ these are the two solutions in $[0, 2 pi)$. For $k = 1$
    you get the two solutions in $[2 pi, 4 pi)$.
  ]

  #example(title: "Shifted and stretched argument")[
    Solve $2 sin(3x - pi/3) = sqrt(3)$ for $0 <= x < pi$. First
    isolate: $sin(3x - pi/3) = sqrt(3)/2$. Substitute $u = 3x - pi/3$.
    If $0 <= x < pi$, then $-pi/3 <= u < (8 pi)/3$. Now $sin(u) = sqrt(3)/2$ has
    the solutions $u = pi/3 + k dot 2 pi$ and $u = (2 pi)/3 + k dot 2 pi$.
    In the interval these are $u = pi/3, (2 pi)/3, (7 pi)/3$. The value
    $(8 pi)/3$ is excluded. Solve $x = (u + pi/3) / 3$:
    $x = (2 pi)/9, pi/3, (8 pi)/9$.
    Check: for $x = pi/3$, $3x - pi/3 = (2 pi)/3$, and
    $2 sin((2 pi)/3) = sqrt(3)$. #sym.checkmark
  ]

  #example(title: "Quadratic in the sine")[
    Solve $2 sin^2(x) - sin(x) - 1 = 0$ for $0 <= x < 2 pi$. Let
    $u = sin(x)$. Then $2u^2 - u - 1 = 0$, so $u = 1$ or $u = -1/2$.
    Now solve two basic equations. $sin(x) = 1$ gives $x = pi/2$.
    $sin(x) = -1/2$ gives $x = (7 pi)/6$ or $x = (11 pi)/6$. Three
    solutions in total.
  ]

  #example(title: "Use an identity to get one function")[
    Solve $2 cos^2(x) - 1 = sin(x)$ for $0 <= x < 2 pi$. Two different
    functions appear. Use $cos^2(x) = 1 - sin^2(x)$:
    $2 dot (1 - sin^2(x)) - 1 = sin(x)$, which simplifies to
    $2 sin^2(x) + sin(x) - 1 = 0$. Then $sin(x) = 1/2$ or $sin(x) = -1$,
    so $x = pi/6, (5 pi)/6, (3 pi)/2$.
    The identities are in your formula booklet.
  ]

  #example(title: "Factor, do not divide")[
    Solve $sin(2x) = sin(x)$ for $0 <= x < 2 pi$. Use
    $sin(2x) = 2 sin(x) cos(x)$:
    $2 sin(x) cos(x) - sin(x) = 0$, so $sin(x) dot (2 cos(x) - 1) = 0$.
    Either $sin(x) = 0$, which gives $x = 0$ or $x = pi$, or
    $cos(x) = 1/2$, which gives $x = pi/3$ or $x = (5 pi)/3$.
    Four solutions. If you divide by $sin(x)$ instead, you lose the first two.
  ]
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Solve for $0 <= x < 2 pi$. Use exact values, no calculator.
  #auto-parts(
    2,
    [$sin(x) = sqrt(2)/2$],
    [$cos(x) = sqrt(3)/2$],
    [$tan(x) = sqrt(3)$],
    [$cos(x) = -sqrt(2)/2$],
    [$sin(x) = -sqrt(3)/2$],
    [$sin(x) = 0$],
  )
][
  #auto-parts(
    2,
    [$x = pi/4$ or $x = (3 pi)/4$],
    [$x = pi/6$ or $x = (11 pi)/6$],
    [$x = pi/3$ or $x = (4 pi)/3$],
    [$x = (3 pi)/4$ or $x = (5 pi)/4$],
    [$x = (4 pi)/3$ or $x = (5 pi)/3$],
    [$x = 0$ or $x = pi$ (the value $2 pi$ is not in the interval)],
  )
]

#ex(difficulty: 1, time: "6 min", calculator: false)[
  How many solutions does each equation have for
  $0 degree <= x < 360 degree$? Think of the unit circle. You do not
  need to solve.
  #auto-parts(
    3,
    [$sin(x) = 0.3$],
    [$cos(x) = 1$],
    [$tan(x) = -5$],
    [$sin(x) = -1$],
    [$cos(x) = 1.2$],
    [$sin(x) = 0$],
  )
][
  #auto-parts(
    3,
    [Two],
    [One ($x = 0 degree$)],
    [Two],
    [One ($x = 270 degree$)],
    [None, since $1.2 > 1$],
    [Two ($0 degree$ and $180 degree$)],
  )
]

#ex(
  difficulty: 2,
  time: "12 min",
  calculator: true,
  hints: ([Set the calculator to DEG first. Then use the symmetry that
    belongs to the function: $180 degree - x_1$ for sine, $360 degree - x_1$
    for cosine, $x_1 + 180 degree$ for tangent.],),
)[
  Solve for $0 degree <= x < 360 degree$. Round to two decimals.
  #auto-parts(
    2,
    [$sin(x) = 0.35$],
    [$cos(x) = -0.8$],
    [$tan(x) = 3$],
    [$sin(x) = -0.25$],
    [$3 cos(x) = 1$],
    [$5 tan(x) + 2 = 0$],
  )
][
  #auto-parts(
    2,
    [$x approx 20.49 degree$ or $x approx 159.51 degree$],
    [$x approx 143.13 degree$ or $x approx 216.87 degree$],
    [$x approx 71.57 degree$ or $x approx 251.57 degree$],
    [$x approx 194.48 degree$ or $x approx 345.52 degree$],
    [$cos(x) = 1/3$, so $x approx 70.53 degree$ or $x approx 289.47 degree$],
    [$tan(x) = -0.4$, so $x approx 158.20 degree$ or $x approx 338.20 degree$],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Solve for $0 <= x < 4 pi$. The interval is two turns long.
  #auto-parts(
    3,
    [$sin(x) = 1/2$],
    [$cos(x) = -1/2$],
    [$tan(x) = -1$],
  )
][
  #auto-parts(
    1,
    [$x = pi/6, (5 pi)/6, (13 pi)/6, (17 pi)/6$],
    [$x = (2 pi)/3, (4 pi)/3, (8 pi)/3, (10 pi)/3$],
    [$x = (3 pi)/4, (7 pi)/4, (11 pi)/4, (15 pi)/4$. For tangent, the
      solutions are $pi$ apart.],
  )
]

#ex(
  difficulty: 2,
  time: "12 min",
  calculator: true,
  hints: ([Isolate the cosine first. Time is a real number, so use
    radians.],),
)[
  The height of a seat on a Ferris wheel is
  $h(t) = 10 - 8 cos((pi t)/30)$, with $h$ in meters and $t$ in seconds.
  One turn takes $60$ seconds. Set your calculator to RAD.
  #auto-parts(
    1,
    [At which times in the first turn ($0 <= t < 60$) is the seat exactly
      $14$ m high? Use exact values.],
    [At which times in the first turn is the seat $3$ m high? Round to
      two decimals.],
    [Explain why the seat is never $1$ m high.],
  )
][
  #auto-parts(
    1,
    [$10 - 8 cos((pi t)/30) = 14$ gives $cos((pi t)/30) = -1/2$, so
      $(pi t)/30 = (2 pi)/3$ or $(4 pi)/3$. Therefore $t = 20$ s or
      $t = 40$ s.],
    [$cos((pi t)/30) = 7/8$. Then $(pi t)/30 approx 0.5054$ or
      $2 pi - 0.5054 approx 5.7778$, so $t approx 4.83$ s or
      $t approx 55.17$ s.],
    [The lowest point is $10 - 8 = 2$ m. Solving $h(t) = 1$ gives
      $cos((pi t)/30) = 9/8$, which is greater than $1$, so there is no
      solution.],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  *Find the error.* Solve $cos(x) = 0.5$ for
  $0 degree <= x < 360 degree$. Three students answer:
  #align(center)[
    Anna: $x = 60 degree$ #h(2em)
    Ben: $x = 60 degree$ or $x = 120 degree$ #h(2em)
    Chris: $x = 60 degree$ or $x = 300 degree$
  ]
  #auto-parts(
    1,
    [Who is correct?],
    [What is the mistake in each of the other two answers?],
    [Check Ben's second value by computing $cos(120 degree)$.],
  )
][
  #auto-parts(
    1,
    [Chris.],
    [Anna took only the calculator's value and missed the second
      solution. Ben used $180 degree - x_1$, which is the rule for the
      *sine*. For the cosine, the second solution is $360 degree - x_1 = 300 degree$.],
    [$cos(120 degree) = -0.5$, not $0.5$. So $120 degree$ is not a solution.],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: true)[
  *Find the error.* Two students make a mistake with the angle mode.
  #auto-parts(
    1,
    [Leo must solve $sin(x) = 0.5$ for $0 <= x < 2 pi$. His calculator is in
      DEG mode. He types $sin^(-1)(0.5)$, gets $30$, and writes
      $x = 30$ or $x = 150$. Explain what is wrong, and give the correct
      answer.],
    [Sam wants to check whether $x = 30 degree$ solves $sin(x) = 0.5$. His
      calculator is in RAD mode and shows $-0.988$. He concludes that
      $30 degree$ is not a solution. What went wrong, and what should
      Sam do?],
  )
][
  #auto-parts(
    1,
    [$30$ and $150$ are values in degrees, but the interval is in radians:
      both numbers are larger than $2 pi approx 6.28$, so they are outside
      the interval. In RAD mode, or by exact values, the answer is
      $x = pi/6 approx 0.524$ or $x = (5 pi)/6 approx 2.618$.],
    [The calculator read $30$ as $30$ radians, and $sin(30 "rad") approx -0.988$.
      Sam must switch to DEG mode (or enter $sin(pi/6)$ in RAD mode). Then he
      gets $0.5$.],
  )
]

#ex(
  difficulty: 3,
  time: "15 min",
  calculator: false,
  hints: ([For $sin(2x)$ and $cos(x slash 2)$, first find out how long the
    interval for the whole argument is, and solve for the argument.],),
)[
  Solve by hand.
  #auto-parts(
    1,
    [$2 sin(x) + 1 = 0$ for $0 <= x < 2 pi$],
    [$sin(2x) = sqrt(3)/2$ for $0 <= x < 2 pi$],
    [$cos(x/2) = -1/2$ for $0 <= x < 4 pi$],
  )
][
  #auto-parts(
    1,
    [$sin(x) = -1/2$, so $x = (7 pi)/6$ or $x = (11 pi)/6$.],
    [$2x$ runs through $[0, 4 pi)$ and $sin(2x) = sqrt(3)/2$ gives
      $2x = pi/3, (2 pi)/3, (7 pi)/3, (8 pi)/3$. So
      $x = pi/6, pi/3, (7 pi)/6, (4 pi)/3$.],
    [$x/2$ runs through $[0, 2 pi)$ and $cos(x/2) = -1/2$ gives
      $x/2 = (2 pi)/3$ or $(4 pi)/3$. So $x = (4 pi)/3$ or $x = (8 pi)/3$.],
  )
]

#ex(difficulty: 3, time: "12 min", calculator: true)[
  In triangle $A B C$, the side $b = 8$ cm lies opposite the angle
  $beta = 40 degree$. The sine rule gives
  $sin(alpha) = (a dot sin(40 degree)) / b$. Angles in a triangle are in
  degrees, so use DEG mode.
  #auto-parts(
    1,
    [For $a = 10$ cm, find *all* angles $alpha$ between $0 degree$ and
      $180 degree$ that satisfy the equation. Can both be angles of a
      triangle with $beta = 40 degree$?],
    [Now use $b = 10$ cm and $a = 8$ cm. Find all angles $alpha$ between
      $0 degree$ and $180 degree$ and decide which one gives a triangle.],
  )
][
  #auto-parts(
    1,
    [$sin(alpha) = (10 dot sin(40 degree))/8 approx 0.8035$, so
      $alpha approx 53.46 degree$ or $alpha approx 126.54 degree$. Both work:
      $53.46 degree + 40 degree = 93.46 degree < 180 degree$ and
      $126.54 degree + 40 degree = 166.54 degree < 180 degree$. There are
      two different triangles.],
    [$sin(alpha) = (8 dot sin(40 degree))/10 approx 0.5142$, so
      $alpha approx 30.95 degree$ or $alpha approx 149.05 degree$. The second
      angle is too big, since $149.05 degree + 40 degree > 180 degree$.
      Only $alpha approx 30.95 degree$ gives a triangle.],
  )
]

#ex(level: "high", difficulty: 2, time: "10 min", calculator: false)[
  Give the general solution (all real $x$, with $k in ZZ$).
  #auto-parts(
    2,
    [$sin(x) = sqrt(3)/2$],
    [$cos(x) = -sqrt(2)/2$],
    [$tan(x) = sqrt(3)/3$],
    [$2 cos(x) = 1$],
    [$sin(x) = -1$],
  )
][
  #auto-parts(
    2,
    [$x = pi/3 + k dot 2 pi$ or $x = (2 pi)/3 + k dot 2 pi$],
    [$x = plus.minus (3 pi)/4 + k dot 2 pi$],
    [$x = pi/6 + k dot pi$],
    [$x = plus.minus pi/3 + k dot 2 pi$],
    [$x = (3 pi)/2 + k dot 2 pi$ (one family only)],
  )
]

#ex(
  level: "high",
  difficulty: 3,
  time: "18 min",
  calculator: false,
  hints: ([Substitute $u$ for the whole argument. Work out the interval for $u$
    before you solve, and convert back at the end.],),
)[
  Solve. Give exact values.
  #auto-parts(
    1,
    [$2 sin(3x - pi/3) = sqrt(3)$ for $0 <= x < pi$],
    [$sin(2x - pi/4) = sqrt(2)/2$ for $0 <= x < pi$],
    [$2 cos(2x + pi/6) = -1$ for $0 <= x < 2 pi$],
  )
][
  #auto-parts(
    1,
    [$u = 3x - pi/3$ runs through $[-pi/3, (8 pi)/3)$. The solutions
      $u = pi/3, (2 pi)/3, (7 pi)/3$ give $x = (2 pi)/9, pi/3, (8 pi)/9$.],
    [$u = 2x - pi/4$ runs through $[-pi/4, (7 pi)/4)$. The solutions
      $u = pi/4, (3 pi)/4$ give $x = pi/4$ and $x = pi/2$.],
    [$u = 2x + pi/6$ runs through $[pi/6, (25 pi)/6)$, and
      $cos(u) = -1/2$ gives $u = (2 pi)/3, (4 pi)/3, (8 pi)/3, (10 pi)/3$. So
      $x = pi/4, (7 pi)/12, (5 pi)/4, (19 pi)/12$.],
  )
]

#ex(level: "high", difficulty: 3, time: "20 min", calculator: false)[
  Solve for $0 <= x < 2 pi$. Give exact values.
  #auto-parts(
    1,
    [$2 sin^2(x) - sin(x) - 1 = 0$],
    [$2 cos^2(x) + 3 cos(x) + 1 = 0$],
    [$2 cos^2(x) - 1 = sin(x)$],
    [$sin(2x) = sin(x)$],
    [$3 tan^2(x) = 1$],
  )
][
  #auto-parts(
    1,
    [$sin(x) = 1$ or $sin(x) = -1/2$, so $x = pi/2, (7 pi)/6, (11 pi)/6$.],
    [$cos(x) = -1/2$ or $cos(x) = -1$, so $x = (2 pi)/3, pi, (4 pi)/3$.],
    [With $cos^2(x) = 1 - sin^2(x)$ the equation becomes
      $2 sin^2(x) + sin(x) - 1 = 0$, so $sin(x) = 1/2$ or $sin(x) = -1$.
      Therefore $x = pi/6, (5 pi)/6, (3 pi)/2$.],
    [$sin(x) dot (2 cos(x) - 1) = 0$, so $x = 0, pi/3, pi, (5 pi)/3$.],
    [$tan(x) = plus.minus sqrt(3)/3$, so $x = pi/6, (5 pi)/6, (7 pi)/6, (11 pi)/6$.],
  )
]

#ex(level: "high", difficulty: 3, time: "10 min", calculator: false)[
  *Find the error.* A student solves $sin(2x) = sin(x)$ for $0 <= x < 2 pi$.
  #align(center)[
    $2 sin(x) cos(x) = sin(x)$ #h(1em) $->$ #h(1em) $2 cos(x) = 1$
    #h(1em) $->$ #h(1em) $x = pi/3$ or $x = (5 pi)/3$.
  ]
  #auto-parts(
    1,
    [Which step is not an equivalent transformation, and why?],
    [Which solutions were lost? Give the complete solution.],
  )
][
  #auto-parts(
    1,
    [Dividing by $sin(x)$. This is only allowed when $sin(x) != 0$, so the
      cases with $sin(x) = 0$ disappeared.],
    [$x = 0$ and $x = pi$ were lost. The complete solution is
      $x = 0, pi/3, pi, (5 pi)/3$.],
  )
]

#keybox(title: "Check with your calculator")[
  #only-basic[
    *TI-30X Pro MathPrint.* First look at the angle mode: *DEG* for
    degrees, *RAD* for radians (it is set in the mode menu). Then use the
    inverse functions $sin^(-1)$, $cos^(-1)$ and $tan^(-1)$. Each gives
    only the *principal value*, so you must add the second solution
    yourself. *num-solv* can show you both solutions: enter the equation,
    give a *start value*, and you get the one solution near it. A different
    start value (in RAD mode, try $1$ and $3$ for $sin(x) = 0.3$) can lead
    to the other solution. To check an answer, put it back into the
    original equation, in the same angle mode.
    // VERIFY on device: where the mode menu is and how DEG/RAD is shown
    // VERIFY on device: where sin^-1, cos^-1, tan^-1 are on the keys
    // VERIFY on device: num-solv on sin(x)=0.3 with start values 1 and 3
  ]
  #only-high[
    *TI-Nspire CAS.* The angle mode is a setting of the document (radian
    or degree) and decides how `solve` reads $sin(x)$. With the interval
    given by the `|` operator, `solve(2·sin(x)=1,x) | 0≤x<2·π` returns the
    solutions in that interval. Without it, `solve(2·sin(x)=1,x)` returns
    the *general solution* with a free integer parameter (shown by a
    symbol such as `@n1`). Compare the two outputs with your own work.
    `nSolve(sin(x)=0.8,x)` gives one decimal solution near its start value.
    Read the output critically: `solve(sin(x)=2,x)` returns `false`, and
    `cSolve` gives complex solutions that you do not use here.
    // VERIFY on device: where the angle mode is set (document settings)
    // VERIFY on device: the exact form of the general solution output (@n1)
    // VERIFY on device: the | operator with an interval in radians and in degrees
  ]
]

#ex(level: "basic", difficulty: 1, time: "10 min", calculator: true)[
  Use your calculator.
  #auto-parts(
    1,
    [In DEG mode compute $sin(30)$ and $cos(60)$. Then switch to RAD mode and
      compute $sin(30)$ again. Write down all three results.],
    [In RAD mode use *num-solv* for $sin(x) = 0.3$ with the start values
      $0.5$ and $3$. Which solutions do you get? Check that the second one is
      $pi - x_1$.],
    [In DEG mode solve $cos(x) = -0.2$ for $0 degree <= x < 360 degree$.
      Use the inverse function and the symmetry.],
  )
][
  #auto-parts(
    1,
    [$sin(30) = 0.5$ and $cos(60) = 0.5$ in DEG mode. In RAD mode
      $sin(30) approx -0.988$.],
    [$x_1 approx 0.305$ and $x_2 approx 2.837$. Indeed
      $pi - 0.305 approx 2.837$.],
    [$cos^(-1)(-0.2) approx 101.54 degree$. The second solution is
      $360 degree - 101.54 degree = 258.46 degree$.],
  )
]

#ex(level: "high", difficulty: 1, time: "10 min", calculator: true)[
  Use your TI-Nspire CAS.
  #auto-parts(
    1,
    [In radian mode, solve $2 cos(x) = 1$ for $0 <= x < 2 pi$ with `solve` and
      the `|` operator.],
    [Solve $2 cos(x) = 1$ without the `|` operator. How does the output
      differ? Write the result as a formula.],
    [Solve $sin(x) = 2$ with `solve`. What does the answer mean?],
    [Switch the document to degrees. What does
      `solve(sin(x)=1/2,x) | 0≤x<360` return?],
  )
][
  #auto-parts(
    1,
    [$x = pi/3$ or $x = (5 pi)/3$.],
    [The output contains a free integer, so it is the general solution:
      $x = plus.minus pi/3 + k dot 2 pi$, $k in ZZ$. The CAS may write the
      second family as $(5 pi)/3 + k dot 2 pi$, which is the same set.],
    [`false`: there is no real solution, because $sin(x) <= 1$.],
    [$x = 30$ or $x = 150$ (in degrees).],
  )
]

#check(
  kind: "Stage check",
  "Trigonometric Equations",
  (
    [Solve $sin(x) = sqrt(3)/2$ for $0 <= x < 2 pi$ (radians).],
    [Solve $cos(x) = 0$ for $0 <= x < 2 pi$ (radians).],
    [Solve $tan(x) = -1$ for $0 <= x < 2 pi$ (radians).],
    yr([Your calculator is in DEG mode and gives $sin^(-1)(0.8) approx 53.13 degree$. Give all solutions of $sin(x) = 0.8$ for $0 degree <= x < 360 degree$.], [Give all real solutions of $sin(x) = 1/2$ (general solution, with $k in ZZ$).]),
  ),
  (
    [$x = pi/3$ or $x = (2 pi)/3$],
    [$x = pi/2$ or $x = (3 pi)/2$],
    [$x = (3 pi)/4$ or $x = (7 pi)/4$],
    yr([$x approx 53.13 degree$ or $x approx 126.87 degree$], [$x = pi/6 + k dot 2 pi$ or $x = (5 pi)/6 + k dot 2 pi$]),
  ),
  pass: [Continue with #goto-first(<st-poly>).],
  fail: [Find the example or exercise that matches your mistake and redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════
#print-check-key()

#print-hints()
#print-vocab()
