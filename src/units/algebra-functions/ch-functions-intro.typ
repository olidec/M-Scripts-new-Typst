#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Introduction to Functions")
#let ex = exercise.with(chapter: "Introduction to Functions")

= Introduction to Functions

A #vocab("relation", "Relation") is a set of ordered pairs of numbers,
usually written $(x, y)$. Besides a set of ordered pairs, other useful
ways to represent a relation include an algebraic equation in two
variables, a graph on a *Cartesian coordinate system*, or a table.

#objectives(
  bfkm[describe the elementary properties of a function, including its
    domain and range],
  bfkm[formally describe a functional relationship given in a
    real-world context],
  [determine whether a graph represents a function, using the vertical
    line test],
  [read the domain and range of a function directly from its graph],
  obj(level: "high", bfkm: true)[explain what an inverse function is,
    and use it to solve problems],
)

#definition[
  The #vocab("domain", "Definitionsbereich") of a relation is the set
  of all first numbers ($x$\u{2011}values) of its ordered pairs. The
  #vocab("range", "Wertebereich") is the set of all second numbers
  ($y$\u{2011}values).
]

#remark[
  For a domain or range that's a whole stretch of the number line
  rather than a handful of points, we'll describe it with *interval
  notation* -- e.g. $[1, infinity)$ means "every number from $1$ upward,
  $1$ included." See the Algebra Foundations chapter for the full
  reference.
]

#example[
  For the relation ${(1,3), (2,5), (3,5), (4,7)}$, the domain is
  ${1, 2, 3, 4}$ and the range is ${3, 5, 7}$ -- note that $5$ is listed
  only once, even though it occurs twice as a $y$\u{2011}value.
]

#example[
  For $f : y = sqrt(x - 1)$: since we can't take the square root of a
  negative number, we need $x - 1 >= 0$, i.e. $x >= 1$. The domain is
  $[1, infinity)$. Since a square root is never negative, the range is
  $[0, infinity)$.
]

#definition[
  A #vocab("function", "Funktion") is a rule that maps every number in
  its domain to exactly one number in its range. The input is called
  the *independent variable* (or *argument*); the output is called the
  *dependent variable*.
]

#keybox(title: "Function Notation")[
  $f(x)$ is read "$f$ of $x$" and means "the value of function $f$ at
  $x$."
]

#ex(difficulty: 1, time: "10 min")[
  Find the domain and range of each set of ordered pairs. Which of these
  relations are functions?
  + ${(1,4), (2,7), (3,10), (4,13)}$
  + ${(-2,4), (-1,1), (0,0), (1,1), (2,4)}$
  + ${(1,4), (2,6), (3,8), (3,9), (4,10)}$
  + ${(-2,1), (-1,1), (0,2), (1,4), (2,6)}$
][
  + domain ${1,2,3,4}$, range ${4,7,10,13}$ -- function
  + domain ${-2,-1,0,1,2}$, range ${0,1,4}$ -- function
  + domain ${1,2,3,4}$, range ${4,6,8,9,10}$ -- *not* a function ($x=3$
    gives two different $y$\u{2011}values)
  + domain ${-2,-1,0,1,2}$, range ${1,2,4,6}$ -- function
]

== Graphs of Functions

Given a function $f : y = f(x)$, we consider the set of points
$ S = {(x, y) med | med x in X, med y = f(x)}, $
where $X$ is the domain of $f$. Plotting every point of $S$ in a
coordinate system gives the *graph* of $f$.

#example[
  The graph of a linear function $f : y = a dot x + b$ is a straight line.
]

Many graphs have special names - parabolas, hyperbolas, and so on - and
we'll meet several of these as we continue.

#remark[
  By convention, the independent variable goes on the horizontal axis
  and the dependent variable on the vertical axis. When asked to
  determine the domain and range of a function, it's wise to check both
  algebraically and graphically -- they should agree.
]

=== Finding the Graph of a Function

If we have no idea what the graph of a function looks like, a *value
table* gives a first approximation: pick some $x$\u{2011}values from the
domain, calculate the corresponding $y$\u{2011}values, then plot the resulting
points.

#example[
  Given $f : y = sqrt(4 - x^2)$, the domain is $X = [-2, 2]$ (since we
  need $4 - x^2 >= 0$). A value table:

  #data-table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    row-height: auto,
    [$x$],
    [$-2$],
    [$-1.5$],
    [$-1$],
    [$0$],
    [$1$],
    [$1.5$],
    [$2$],
    [$y$],
    [$0$],
    [$1.32$],
    [$1.73$],
    [$2$],
    [$1.73$],
    [$1.32$],
    [$0$],
  )

  #block(breakable: false)[

    Plotting these points reveals the graph -- in fact, a semicircle:

    #align(center)[
      #let r = 2
      #plot(
        xmin: -r - 0.5,
        xmax: r + 0.5,
        ymin: -0.5,
        ymax: r + 0.5, // same span as x: 2(r+1) either way
        width: 6cm,
        height: 3.5cm, // same physical size — this is the part that actually matters
        show-grid: "major",
        unit-label-only: true,
        (
          fn: x => if calc.abs(x) > r { none } else {
            calc.sqrt(r * r - x * x)
          },
          stroke: accent + 1.3pt,
          domain: (-r, r),
        ),
        scatter(
          (
            (-2, 0),
            (-1.5, 1.32),
            (-1, 1.73),
            (0, 2),
            (1, 1.73),
            (1.5, 1.32),
            (2, 0),
          ),
          mark: "*",
          mark-fill: blue,
          mark-size: 0.15,
        ),
        // (fn: x => if calc.abs(x) > r { none } else { -calc.sqrt(r * r - x * x) }, stroke: accent + 1.3pt),
      )]
  ]

]

#example[
  There are different scales for measuring temperature. The Celsius
  scale ($C$) and Fahrenheit scale ($F$) are related by
  $ F = 9/5 C + 32. $

  #align(center)[
    #plot(
      xmin: -40,
      xmax: 80,
      ymin: -10,
      ymax: 110,
      xlabel: $C$,
      ylabel: $F$,
      xtick-step: 10.0,
      ytick-step: 10.0,
      show-grid: "major",
      unit-label-only: true,
      (fn: x => 9 / 5 * x + 32, stroke: accent + 1.3pt),
    )
  ]
]

=== The Vertical Line Test

#keybox[
  A relation is a function if and only if every vertical line intersects
  its graph *at most once*. This is the *vertical line test*.
]

#pagebreak()
#example[
  #image-grid(
    2,
    [
      #let f(x) = 0.4 * x * x - 1
      #let x0 = 1.0
      #let y0 = f(x0)   // the intersection point, computed exactly, no solving needed

      #plot(
        xmin: -3,
        xmax: 3,
        ymin: -2,
        ymax: 4,
        show-grid: "major",
        (fn: f, stroke: accent + 1.3pt),
        vline(x0, stroke: (paint: red, thickness: 0.8pt, dash: "dashed")),
        data(
          ((x0, y0),),
          mark: "*",
          mark-stroke: red,
          mark-fill: red,
          mark-size: 0.12,
        ),
      )

      Every vertical line crosses this graph at most once - it *is* a
      function.
    ],
    [
      #plot(
        xmin: -2,
        xmax: 4,
        ymin: -1,
        ymax: 5,
        show-grid: "major",
        parametric(
          t => 2 * calc.cos(t) + 1,
          t => 2 * calc.sin(t) + 2,
          domain: (0, 2 * calc.pi),
          stroke: accent + 1.3pt,
        ),
        vline(1.0, stroke: (paint: red, thickness: 0.8pt, dash: "dashed")),
        data(
          ((1, 0), (1, 4)),
          mark: "*",
          mark-stroke: red,
          mark-fill: red,
          mark-size: 0.12,
        ),
      )
      A vertical line through the middle of a circle crosses it *twice* - a circle is *not* the graph of a function.
    ],
  )
]

=== Reading Domain and Range from a Graph

When a graph doesn't extend forever in some direction, its endpoints
need to be marked clearly, so there's no ambiguity about exactly which
points belong to the graph and which don't.

#keybox(title: "Filled vs. Open Circles")[
  - A *filled* (solid) circle means that point *is* part of the graph --
    it's included in the domain and range.
  - An *open* (hollow) circle means that point is *not* part of the
    graph -- it's excluded, even though the graph approaches it.
]

#example[
  #align(center, plot(
    xmin: -1,
    xmax: 6,
    ymin: -1,
    ymax: 5,
    width: 6cm,
    height: 6cm,
    show-grid: "major",
    (fn: x => 0.5 * x + 1, domain: (0, 5), stroke: accent + 1.3pt),
    data(((0, 1),), mark: "o", mark-stroke: accent, mark-size: 0.2),
    data(
      ((5, 3.5),),
      mark: "*",
      mark-fill: accent,
      mark-stroke: accent,
      mark-size: 0.2,
    ),
  ))

  The graph starts with an *open* circle at $(0, 1)$ and ends with a
  *filled* circle at $(5, 3.5)$. Reading left to right, the $x$\u{2011}values
  covered run from $0$ (excluded) to $5$ (included), so the domain is
  $(0, 5]$. Reading bottom to top, the $y$\u{2011}values covered run from $1$
  (excluded) to $3.5$ (included), so the range is $(1, 3.5]$.
]

#ex(difficulty: 1, time: "10 min", keep-together: true)[
  State the domain and range of each graph below.
  #image-grid(
    2,
    [
      #align(center, plot(
        xmin: -1,
        xmax: 5,
        ymin: -1,
        ymax: 4,
        width: 4.5cm,
        height: 4.5cm,
        show-grid: "major",
        (fn: x => -0.5 * x + 3, domain: (0, 4), stroke: accent + 1.3pt),
        data(
          ((0, 3),),
          mark: "*",
          mark-fill: accent,
          mark-stroke: accent,
          mark-size: 0.12,
        ),
        data(((4, 1),), mark: "o", mark-stroke: accent, mark-size: 0.12),
      ))
      (a)
    ],
    [
      #align(center, plot(
        xmin: -1,
        xmax: 5,
        ymin: -1,
        ymax: 5,
        width: 4.5cm,
        height: 4.5cm,
        show-grid: "major",
        (
          fn: x => 0.3 * (x - 2) * (x - 2),
          domain: (0, 4),
          stroke: accent + 1.3pt,
        ),
        data(
          ((0, 1.2), (4, 1.2)),
          mark: "o",
          mark-stroke: accent,
          mark-size: 0.12,
        ),
      ))
      (b)
    ],
  )
][
  + domain $[0, 4)$, range $(1, 3]$
  + domain $(0, 4)$, range $[0, 1.2)$ -- the minimum $y = 0$ *is*
    reached (at $x = 2$, which is inside the open domain), but the
    top value $1.2$ is only ever approached, never reached.
]

#ex(difficulty: 2, time: "20 min", keep-together: false)[
  Which of the following relations are functions? For each one that is
  *not* a function, explain why, using the vertical line test.
  #image-grid(
    3,
    gutter: 10pt,
    [ #plot-graph(x => calc.cos(x), xmin: -6, xmax: 6, ymin: -1.5, ymax: 1.5, size: 3.8, show-unit-ticks: false) (a) ],
    [ #plot-graph(x => 0.4 * x, xmin: -5, xmax: 5, ymin: -2, ymax: 2, size: 3.8, show-unit-ticks: false) (b) ],
    [
      #align(center, plot(
        xmin: -1,
        xmax: 3,
        ymin: -1,
        ymax: 3.5,
        width: 3.8,
        height: 3.8,
        show-grid: "major",
        unit-label-only: true,
        parametric(
          t => 1 + 1.5 * calc.cos(t),
          t => 1.5 + 1.5 * calc.sin(t),
          domain: (0, 2 * calc.pi),
          stroke: accent + 1.3pt,
        ),
      ))
      (c)
    ],
    [ #plot-graph(x => -0.4 * x * x + 1, xmin: -3, xmax: 3, ymin: -3, ymax: 2, size: 3.8, show-unit-ticks: false) (d) ],
    [ #plot-graph(x => if x >= 0 { calc.pow(x, 1 / 3) } else { -calc.pow(-x, 1 / 3) }, xmin: -2, xmax: 2, ymin: -2, ymax: 2, size: 3.8, show-unit-ticks: false) (e) ],
    [
      #let steps = range(-3, 3)
      #align(center, plot(
        xmin: -4,
        xmax: 4,
        ymin: -4,
        ymax: 4,
        width: 3.8,
        height: 3.8,
        show-grid: "major",
        unit-label-only: true,
        ..steps.map(n => (
          fn: x => n,
          domain: (n, n + 1),
          stroke: accent + 1.3pt,
        )),
        data(
          steps.map(n => (n, n)),
          mark: "*",
          mark-fill: accent,
          mark-stroke: accent,
          mark-size: 0.15,
        ),
        data(
          steps.map(n => (n + 1, n)),
          mark: "o",
          mark-stroke: accent,
          mark-size: 0.15,
        ),
      ))
      (f)
    ],
    [
      #align(center, plot(
        xmin: -0.5,
        xmax: 5,
        ymin: -3.5,
        ymax: 3.5,
        width: 3.8,
        height: 3.8,
        show-grid: "major",
        unit-label-only: true,
        parametric(
          t => 0.5 * t * t,
          t => t,
          domain: (-3.5, 3.5),
          stroke: accent + 1.3pt,
        ),
      ))
      (g)
    ],
    [ #plot-graph(x => calc.pow(2, x) - 2, xmin: -4, xmax: 3, ymin: -3, ymax: 6, size: 3.8, show-unit-ticks: false) (h) ],
    [ #plot-graph(x => 0.3 * calc.pow(x, 3), xmin: -2.5, xmax: 2.5, ymin: -3, ymax: 3, size: 3.8, show-unit-ticks: false) (i) ],
  )
][
  (a), (b), (d), (e), (h), (i) are functions -- every vertical line
  meets each graph at most once. (f), the staircase, is *also* a
  function, even though it looks unusual: each $x$\u{2011}value still has
  exactly one $y$\u{2011}value. (c) and (g) are *not* functions -- both are
  circles/sideways parabolas, so a vertical line through the middle
  meets the graph twice.
]


#ex(difficulty: 2, time: "25 min")[
  For each function below, sketch the graph (a value table may help for
  the unfamiliar ones). State the domain and range, and note anything
  else you notice.
  #parts(
    3,
    [(a) $f : y = 2x - 3$],
    [(b) $f : y = abs(x)$],
    [(c) $f : y = abs(2x - 1)$],
    [(d) $f : y = abs(abs(x-1) - 1)$],
    [(e) $f : y = x^2$],
    [(f) $f : y = 1/2 x^2 - 2x$],
    [(g) $f : y = sqrt(x)$],
    [(h) $f : y = sqrt(2-x)$],
    [(i) $f : y = 1/x$],
    [(j) $f : y = 1/(x-3)$],
    [(k) $f : y = x^3$],
    [(l) $f : y = sqrt(9-x^2)$],
  )
][
  #image-grid(
    4,
    gutter: 8pt,
    plot-graph(
      x => 2 * x - 3,
      xmin: -4,
      xmax: 4,
      ymin: -6,
      ymax: 6,
      size: 3.3,
      grid-step: 2,
    ),
    plot-graph(
      x => calc.abs(x),
      xmin: -4,
      xmax: 4,
      ymin: -1,
      ymax: 5,
      size: 3.3,
      grid-step: 2,
    ),
    plot-graph(
      x => calc.abs(2 * x - 1),
      xmin: -4,
      xmax: 4,
      ymin: -1,
      ymax: 6,
      size: 3.3,
      grid-step: 2,
    ),
    plot-graph(
      x => calc.abs(calc.abs(x - 1) - 1),
      xmin: -4,
      xmax: 4,
      ymin: -1,
      ymax: 3,
      size: 3.3,
      grid-step: 2,
    ),
    plot-graph(
      x => x * x,
      xmin: -3,
      xmax: 3,
      ymin: -1,
      ymax: 8,
      size: 3.3,
      grid-step: 2,
    ),
    plot-graph(
      x => 0.5 * x * x - 2 * x,
      xmin: -3,
      xmax: 6,
      ymin: -3,
      ymax: 8,
      size: 3.3,
      grid-step: 2,
    ),
    plot-graph(
      x => if x < 0 { none } else { calc.sqrt(x) },
      xmin: -1,
      xmax: 6,
      ymin: -1,
      ymax: 3,
      size: 3.3,
      grid-step: 2,
    ),
    plot-graph(
      x => if x > 2 { none } else { calc.sqrt(2 - x) },
      xmin: -4,
      xmax: 3,
      ymin: -1,
      ymax: 3,
      size: 3.3,
      grid-step: 2,
    ),
    plot-graph(
      x => if calc.abs(x) < 0.1 { none } else { 1 / x },
      xmin: -4,
      xmax: 4,
      ymin: -4,
      ymax: 4,
      size: 3.3,
      grid-step: 2,
    ),
    plot-graph(
      x => if calc.abs(x - 3) < 0.1 { none } else { 1 / (x - 3) },
      xmin: -2,
      xmax: 8,
      ymin: -4,
      ymax: 4,
      size: 3.3,
      grid-step: 2,
    ),
    plot-graph(
      x => x * x * x,
      xmin: -2,
      xmax: 2,
      ymin: -6,
      ymax: 6,
      size: 3.3,
      grid-step: 1,
    ),
    plot-graph(
      x => if 9 - x * x < 0 { none } else { calc.sqrt(9 - x * x) },
      xmin: -4,
      xmax: 4,
      ymin: -1,
      ymax: 4,
      size: 3.3,
      grid-step: 2,
    ),
  )

  Domains: (a) $RR$ (b) $RR$ (c) $RR$ (d) $RR$ (e) $RR$ (f) $RR$
  (g) $[0, infinity)$ (h) $(-infinity, 2]$ (i) $RR without {0}$
  (j) $RR without {3}$ (k) $RR$ (l) $[-3, 3]$.

  Ranges: (a) $RR$ (b) $[0, infinity)$ (c) $[0, infinity)$
  (d) $[0, 1]$ (e) $[0, infinity)$ (f) $[-2, infinity)$
  (g) $[0, infinity)$ (h) $[0, infinity)$ (i) $RR without {0}$
  (j) $RR without {0}$ (k) $RR$ (l) $[0, 3]$.
]
#pagebreak()
#exploration(title: "Sketch From a Story")[
  Below are containers of different shapes. Imagine each one filling
  with water at a steady rate.
  #align(center, image-grid(
    3,
    image("images/volumetric-flask.jpg", height: 4.5cm),
    image("images/beaker.jpg", height: 4.5cm),
    image("images/pint-glass.jpg", height: 4.5cm),
  ))

  For each container, sketch a graph of the *height* of the water level
  against the *volume* of water poured in. Which parts of each graph
  will be straight, and which curved? What units and scales make sense
  for the axes?
]

#ex(difficulty: 2, time: "25 min", keep-together: false)[
  State the domain and range of each relation below. A filled dot means
  the point *is* included; an open circle means it is *not*.
  #image-grid(
    3,
    gutter: 10pt,
    [
      #align(center, plot(
        xmin: -5,
        xmax: 5,
        ymin: -1,
        ymax: 5,
        width: 3.8,
        height: 3.8,
        show-grid: "major",
        (fn: x => calc.abs(x), domain: (-4, 4), stroke: accent + 1.3pt),
        data(((-4, 4),), mark: "o", mark-stroke: accent, mark-size: 0.12),
        data(
          ((4, 4),),
          mark: "*",
          mark-fill: accent,
          mark-stroke: accent,
          mark-size: 0.12,
        ),
      ))
      (a)
    ],
    [
      #align(center, plot(
        xmin: -2,
        xmax: 6,
        ymin: -1,
        ymax: 5,
        width: 3.8,
        height: 3.8,
        show-grid: "major",
        (fn: x => 2 / 3 * x + 2 / 3, domain: (-1, 5), stroke: accent + 1.3pt),
        data(
          ((-1, 0), (5, 4)),
          mark: "*",
          mark-fill: accent,
          mark-stroke: accent,
          mark-size: 0.12,
        ),
      ))
      (b) -- points $F(-1,0)$ and $E(5,4)$
    ],
    [ #plot-graph(x => x * x, xmin: -2, xmax: 2, ymin: -0.3, ymax: 4, size: 3.8, show-unit-ticks: false) (c) ],
    [
      #align(center, plot(
        xmin: -7,
        xmax: 5,
        ymin: -7,
        ymax: 8,
        width: 3.8,
        height: 3.8,
        show-grid: "major",
        (
          fn: x => 0.5 * (x + 6) * (x + 6) - 6,
          domain: (-6, -2),
          stroke: accent + 1.3pt,
        ),
        (
          fn: x => 0.75 * (x - 2) * (x - 2) + 4,
          domain: (2, 4.5),
          stroke: accent + 1.3pt,
        ),
        data(
          ((-2, 2),),
          mark: "*",
          mark-fill: accent,
          mark-stroke: accent,
          mark-size: 0.12,
        ),
        data(((2, 4),), mark: "o", mark-stroke: accent, mark-size: 0.12),
      ))
      (d)
    ],
    [
      #align(center, plot(
        xmin: -6,
        xmax: 6,
        ymin: -3,
        ymax: 6,
        width: 3.8,
        height: 3.8,
        show-grid: "major",
        (fn: x => -x, domain: (-5, 2), stroke: accent + 1.3pt),
        (fn: x => 2 * x - 6, domain: (2, 5), stroke: accent + 1.3pt),
        data(
          ((-5, 5), (2, -2), (5, 4)),
          mark: "*",
          mark-fill: accent,
          mark-stroke: accent,
          mark-size: 0.1,
        ),
      ))
      (e)
    ],
    [ #plot-graph(x => calc.cos(x), xmin: -6, xmax: 6, ymin: -1.5, ymax: 1.5, size: 3.8, show-unit-ticks: false) (f) ],
    [
      #align(center, plot(
        xmin: -2.5,
        xmax: 2.5,
        ymin: -2.5,
        ymax: 2.5,
        width: 3.8,
        height: 3.8,
        show-grid: "major",
        unit-label-only: true,
        parametric(
          t => 2 * calc.cos(t),
          t => 2 * calc.sin(t),
          domain: (0, 2 * calc.pi),
        ),
      ))
      (g)
    ],
    [ #plot-graph(x => 0.3 * calc.pow(x, 3) + 1, xmin: -2.5, xmax: 2.5, ymin: -3, ymax: 3, size: 3.8, show-unit-ticks: false) (h) ],
    [ #plot-graph(x => if calc.abs(x) < 0.15 { none } else { 1 / x }, xmin: -6, xmax: 5, ymin: -4, ymax: 5, size: 3.8, show-unit-ticks: false) (i) ],
  )
][
  + domain $(-4, 4]$, range $[0, 4]$
  + domain $[-1, 5]$, range $[0, 4]$
  + domain $RR$ (shown: $[-2,2]$), range $[0, infinity)$ (shown: $[0,4]$)
  + domain $[-6,-2] union (2, 4.5]$, range $[-6, 2] union (4, 8.6875]$
  + domain $[-5, 5]$, range $[-2, 5]$
  + domain $RR$, range $[-1, 1]$
  + domain $RR$ (this is a *relation*, not a function), range $[-2, 2]$
  + domain $RR$, range $RR$
  + domain $RR without {0}$, range $RR without {0}$
]

#only-theory[
  _Note: as with the previous exercise, (c) through (i) are
  reconstructions from scanned originals — treat the exact numbers in
  the solution as illustrative rather than a guaranteed match to your
  source material, and double check against the scans once compiled._
]

== Inverse Functions

Solving an equation like $2x + 3 = 11$ is really a process of *peeling
away layers* to get to $x$ on its own: first undo the $+3$ (subtract 3
from both sides), then undo the $times 2$ (divide both sides by 2). Each
step *reverses* one operation. An
#vocab("inverse function", "Umkehrfunktion") is exactly this idea,
formalized: it's a function that undoes another function.

#look-ahead(preview: [power functions])[
  Once we study power functions properly, we'll use the *graphical*
  version of this same idea to compare graphs like $y = x^3$ and
  $y = x^(1/3)$ -- one undoes the other, and their graphs turn out to be
  mirror images of each other across the line $y = x$.
]

#example[
  If $f(x) = x + 3$, the function that undoes $f$ is $g(x) = x - 3$: it
  peels the $+3$ back off. Check: $g(f(x)) = (x+3) - 3 = x$.
]

#example[
  If $f(x) = 2x$, the function that undoes $f$ is $g(x) = x/2$. Check:
  $g(f(x)) = (2x)/2 = x$.
]

#only-high[
  More formally: the *inverse* of a function $f$, written $f^(-1)$, is
  the function satisfying
  $ f^(-1)(f(x)) = x quad "for every " x "in the domain of " f. $
  Not every function has an inverse that is itself a function -- $f$
  needs to be *one-to-one* (never sending two different inputs to the
  same output), or the "undo" step wouldn't know which input to send you
  back to. Graphically, the graph of $f^(-1)$ is the reflection of the
  graph of $f$ across the line $y = x$: swapping which axis is which is
  exactly swapping the roles of input and output.
]

#ex(difficulty: 1, time: "10 min")[
  Each function below undoes an everyday operation. Write the inverse
  operation in words, then as a function.
  #parts(
    2,
    [(a) $f(x) = x + 7$],
    [(b) $f(x) = x - 4$],
    [(c) $f(x) = 5x$],
    [(d) $f(x) = x/3$],
  )
][
  #parts(
    2,
    [(a) subtract 7: $f^(-1)(x) = x - 7$],
    [(b) add 4: $f^(-1)(x) = x + 4$],
    [(c) divide by 5: $f^(-1)(x) = x/5$],
    [(d) multiply by 3: $f^(-1)(x) = 3x$],
  )
]

#ex(level: "high", difficulty: 2, time: "15 min")[
  For each function, find $f^(-1)(x)$ by reversing the steps of $f$ in
  order, peeling off the outermost operation first.
  #parts(
    2,
    [(a) $f(x) = 3x + 5$],
    [(b) $f(x) = (x-2)/4$],
    [(c) $f(x) = 2(x+1)$],
    [(d) $f(x) = -x + 6$],
  )
][
  #parts(
    2,
    [(a) $f^(-1)(x) = (x-5)/3$],
    [(b) $f^(-1)(x) = 4x+2$],
    [(c) $f^(-1)(x) = x/2 - 1$],
    [(d) $f^(-1)(x) = -x + 6$ (its own inverse!)],
  )
]

#print-hints()
#print-vocab()
