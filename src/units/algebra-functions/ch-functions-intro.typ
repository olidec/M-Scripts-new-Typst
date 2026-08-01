#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Introduction to Functions")
#let ex = exercise.with(chapter: "Introduction to Functions")

= Introduction to Functions

#only-theory[
  A #vocab("relation", "Relation") is a set of ordered pairs of numbers,
  usually written $(x, y)$. Besides a set of ordered pairs, other useful
  ways to represent a relation include an algebraic equation in two
  variables, a graph on a *Cartesian coordinate system*, or a table.
]

#objectives(
  bfkm[describe the elementary properties of a function, including its
    domain and range],
  bfkm[formally describe a functional relationship given in a
    real-world context],
  [determine whether a graph represents a function, using the vertical
    line test],
  [read the domain and range of a function directly from its graph],
  bfkm[explain the connection between a function's equation and its
    graph, by describing shifts, reflections, and stretches in both
    directions],
  bfkm[write the equation of a transformed graph, and describe the
    transformation behind a given equation],
  [recognize even and odd functions, and state what each says about
    the graph],
  obj(level: "high")[read a shift as a change of coordinates
    $x' = x - h$, rather than as a movement of the curve],
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

#only-theory[
  Given a function $f : y = f(x)$, we consider the set of points
  $ S = {(x, y) med | med x in X, med y = f(x)}, $
  where $X$ is the domain of $f$. Plotting every point of $S$ in a
  coordinate system gives the *graph* of $f$.
]

#example[
  The graph of a linear function $f : y = a dot x + b$ is a straight line.
]

#only-theory[
  Many graphs have special names -- parabolas, hyperbolas, and so on --
  and we'll meet several of these as we continue.
]

#remark[
  By convention, the independent variable goes on the horizontal axis
  and the dependent variable on the vertical axis. When asked to
  determine the domain and range of a function, it's wise to check both
  algebraically and graphically -- they should agree.
]

=== Finding the Graph of a Function

#only-theory[
  If we have no idea what the graph of a function looks like, a *value
  table* gives a first approximation: pick some $x$\u{2011}values from the
  domain, calculate the corresponding $y$\u{2011}values, then plot the
  resulting points.
]

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

#only-theory[
  #pagebreak()
]
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

#only-theory[
  When a graph doesn't extend forever in some direction, its endpoints
  need to be marked clearly, so there's no ambiguity about exactly which
  points belong to the graph and which don't.
]

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
#only-theory[
  #pagebreak()
]
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

== Transforming Graphs

#only-theory[
  So far we have gone in one direction: given a formula, find the
  picture. This section goes both ways at once. Every change you can
  make to a formula shows up as a specific movement of its graph, and
  every movement of a graph can be written as a specific change to its
  formula. Algebra and geometry are two descriptions of the same
  object -- and once you can translate between them, a graph you have
  never seen before becomes a graph you already know, moved.

  The function you start from is called the
  #vocab("parent function", "Grundfunktion"). Everything else in this
  section is that one curve, relocated.
]

#warning[
  In German, a parent function is a *Grundfunktion*. It is #emph[not] a
  _Stammfunktion_ -- that word means *antiderivative*, an entirely
  different idea you will meet in the fourth year. The two are easy to
  confuse precisely because "parent" suggests "Stamm."
]

=== Shifting a Graph

#only-theory[
  Adding a constant to the *output* of a function moves the whole
  picture vertically -- every height changes by the same amount:
]

#keybox(title: "Vertical Shift")[
  $ y = f(x) + k quad "shifts the graph" k "units UP" quad (k < 0:
    "down)." $
]

#only-theory[
  Changing the *input* moves the picture horizontally -- and here
  something surprising happens.
]

#example[
  Let $f$ be the parent function, and consider $y = f(x - 3)$.

  You might expect the graph to move 3 units *left*, since we
  subtracted. It moves 3 units *right*.
]

#only-theory[
  This is worth slowing down for, because the reason is the whole point
  of this section. There are two ways to describe the same shift, and
  they are the two sides of the coin.

  *The geometric description -- move the points.* Every point $(x, y)$
  of the graph is picked up and put down at $(x + 3, med y)$.

  *The algebraic description -- substitute into the formula.* Replace
  every $x$ by $x - 3$.

  These agree, and the minus sign is exactly where they meet. Ask what
  the new graph does at $x = 5$. That point came from $x = 2$, three
  units to its left. So to find its height you have to ask the *old*
  function about $2$ -- that is, about $5 - 3$. The formula subtracts
  because it is looking *backwards* to where the point came from, while
  the picture moves forwards.
]

#abstraction-ladder(
  l0: [The whole curve slides three units to the right.],
  l1: [The point that was at $x = 2$ is now at $x = 5$.],
  l2: [To get the new height at $x$, ask the old function about
    $x - 3$.],
  l3: [$y = f(x - 3)$],
)

#keybox(title: "Horizontal Shift")[
  $ y = f(x - h) quad "shifts the graph" h "units RIGHT" quad (h < 0:
    "left)." $
  The sign inside the bracket is *opposite* to the direction of travel.
]

#only-high[
  There is a second way to read the same equation, and it is worth
  having, because it removes the surprise entirely instead of just
  explaining it.

  Nothing about the curve actually changed. What if the *axes* moved
  instead? Introduce new coordinates
  $ x' = x - h, quad y' = y - k. $
  In these coordinates the transformed graph is described by
  $y' = f(x')$ -- the original equation, untouched. Shifting the curve
  three units right and shifting the coordinate system three units left
  produce exactly the same drawing on the page.

  So $y = f(x - h) + k$ can be read two ways: *this is a new curve in
  the old coordinates*, or *this is the old curve in new coordinates*.
  The minus signs that look backwards from the first point of view are
  the natural ones from the second. #heuristic("introduce notation")
]

#look-ahead(preview: [vectors])[
  The pair $(h, k)$ that describes a shift behaves exactly like a
  #vocab("vector", "Vektor") -- it has a direction and a length, and
  performing two shifts one after another adds them component by
  component. When we study vectors properly, "translation" will be one
  of the first meanings we give to the word.
]

#ex(difficulty: 1, time: "10 min", calculator: false)[
  The graph of a function $f$ is given. Write the equation of the graph
  after each transformation.
  #parts(
    2,
    [(a) shift 4 units up],
    [(b) shift 2 units down],
    [(c) shift 5 units right],
    [(d) shift 1 unit left],
    [(e) shift 3 units left and 2 units up],
    [(f) shift 1 unit right and 6 units down],
  )
][
  #parts(
    2,
    [(a) $y = f(x) + 4$],
    [(b) $y = f(x) - 2$],
    [(c) $y = f(x - 5)$],
    [(d) $y = f(x + 1)$],
    [(e) $y = f(x + 3) + 2$],
    [(f) $y = f(x - 1) - 6$],
  )
]

#ex(
  difficulty: 2,
  time: "10 min",
  calculator: false,
  hints: ([Work on one point at a time. A shift right by $h$ adds $h$
    to the $x$\u{2011}coordinate -- the *point* moves the way the words
    say, even though the formula subtracts.],),
)[
  The point $P = (1, 4)$ lies on the graph of $f$. Give the coordinates
  of the corresponding point on the graph of
  #parts(
    2,
    [(a) $y = f(x) + 3$],
    [(b) $y = f(x - 2)$],
    [(c) $y = f(x + 5) - 1$],
    [(d) $y = f(x - 2) + 3$],
  )
][
  #parts(
    2,
    [(a) $(1, 7)$],
    [(b) $(3, 4)$],
    [(c) $(-4, 3)$],
    [(d) $(3, 7)$],
  )

  Only the $y$\u{2011}coordinate responds to what happens *outside* $f$,
  and only the $x$\u{2011}coordinate to what happens *inside* it.
]

=== Reflecting a Graph

#only-theory[
  The same inside/outside rule tells you everything about reflections.
  A minus sign *outside* $f$ negates the heights; a minus sign *inside*
  negates the inputs.
]

#keybox(title: "Reflections")[
  - $y = -f(x)$: reflect across the $x$\u{2011}axis (heights flip).
  - $y = f(-x)$: reflect across the $y$\u{2011}axis (left and right swap).
  - $y = -f(-x)$: both at once -- a reflection across the *origin*,
    which is the same as rotating the graph by $180 degree$.
]

#ex(difficulty: 1, time: "10 min", calculator: false)[
  Let $f(x) = x^2 - 4x$. Give the equation, simplified, of the graph
  reflected across
  #parts(
    3,
    [(a) the $x$\u{2011}axis],
    [(b) the $y$\u{2011}axis],
    [(c) the origin],
  )
][
  #parts(
    1,
    [(a) $y = -f(x) = -x^2 + 4x$],
    [(b) $y = f(-x) = (-x)^2 - 4(-x) = x^2 + 4x$],
    [(c) $y = -f(-x) = -x^2 - 4x$],
  )
]

=== Stretching a Graph

#only-theory[
  Multiplying, rather than adding, changes the *size* of the picture
  instead of its position. Outside and inside behave differently again
  -- and this time the inside behaves in a way that catches almost
  everyone out.
]

#keybox(title: "Stretches")[
  - $y = a dot f(x)$: stretch *vertically* by the factor $a$. Heights
    are multiplied by $a$; the $x$\u{2011}axis stays put.
  - $y = f(b dot x)$: stretch *horizontally* by the factor $1/b$.
    Widths are *divided* by $b$; the $y$\u{2011}axis stays put.
]

#warning[
  Read the second rule again: $f(2x)$ makes the graph *narrower*, not
  wider. Same backwards-looking logic as the horizontal shift -- the
  input is doubled before $f$ sees it, so $f$ reaches any given value
  in half the distance.
]

#only-theory[
  A concrete case, using the semicircle $f(x) = sqrt(4 - x^2)$ from
  earlier in this chapter. Its domain is $[-2, 2]$ and its greatest
  height is $2$.
]

#example[
  - $2 dot f(x) = 2 sqrt(4 - x^2)$: domain still $[-2, 2]$, greatest
    height now $4$. *Same width, twice as tall.*
  - $f(2x) = sqrt(4 - 4x^2)$: domain now $[-1, 1]$, greatest height
    still $2$. *Same height, half as wide.*
]

#remark[
  If you try the same experiment on $f(x) = x^2$, the two stretches
  become impossible to tell apart: $f(2x) = (2x)^2 = 4x^2 = 4 dot
  f(x)$. Squashing a parabola horizontally looks exactly like
  stretching it vertically. That is not a coincidence -- it happens for
  every power function -- and it is why the vertex form
  $a dot (x - h)^2 + k$ needs only *one* stretch parameter. For most
  other functions, including the semicircle above and the sine curve
  later on, the two are genuinely different.
]

#only-high[
  Why $1/b$ and not $b$? Run the same argument as for the shift. The
  new graph at position $x$ has height $f(b x)$, so it is showing you
  what the old graph did at $b x$. A feature the old graph had at
  $x_0$ therefore appears on the new graph where $b x = x_0$, that is
  at $x = x_0\/b$. Every horizontal distance is divided by $b$.
]

#ex(
  difficulty: 2,
  time: "10 min",
  calculator: false,
  hints: ([Decide first whether the number acts *inside* or *outside*
    $f$; that alone tells you horizontal or vertical.],),
)[
  Describe in words what each equation does to the graph of $f$.
  #parts(
    2,
    [(a) $y = 3 f(x)$],
    [(b) $y = f(3x)$],
    [(c) $y = 1/2 f(x)$],
    [(d) $y = f(x/2)$],
    [(e) $y = -2 f(x)$],
    [(f) $y = f(-2x)$],
  )
][
  #parts(
    1,
    [(a) stretch vertically by $3$ (three times as tall)],
    [(b) squash horizontally to $1/3$ of the width],
    [(c) squash vertically to half the height],
    [(d) stretch horizontally to twice the width],
    [(e) stretch vertically by $2$ *and* reflect across the
      $x$\u{2011}axis],
    [(f) squash horizontally to half the width *and* reflect across the
      $y$\u{2011}axis],
  )
]

=== Putting It All Together

#keybox(title: "The General Transformation")[
  $ y = a dot f(b dot (x - h)) + k $
  - $a$ -- vertical stretch (and reflection in the $x$\u{2011}axis if
    $a < 0$)
  - $b$ -- horizontal stretch by $1/b$ (and reflection in the
    $y$\u{2011}axis if $b < 0$)
  - $h$ -- horizontal shift, *right* if $h > 0$
  - $k$ -- vertical shift, *up* if $k > 0$
]

#warning[
  Note that $b$ multiplies the *whole bracket* $(x - h)$. If you meet
  something like $f(2x - 6)$, the shift is *not* $6$: factor first,
  $ f(2x - 6) = f(2 dot (x - 3)), $
  so it is a horizontal squash to half width *and* a shift of $3$ to
  the right. Always factor $b$ out before reading off $h$.
]

#only-theory[
  Order matters. Applying the same two transformations in the opposite
  order will generally land you somewhere else.
]

#example[
  Take $f(x) = x^2$, and apply a shift $3$ to the right and a
  reflection across the $y$\u{2011}axis.
  - Shift first, then reflect: $(x-3)^2 arrow.r (-x-3)^2 = (x+3)^2$.
  - Reflect first, then shift: $(-x)^2 = x^2 arrow.r (x-3)^2$.

  Two different parabolas, from the same two instructions.
]

#ex(
  difficulty: 3,
  time: "15 min",
  calculator: false,
  hints: (
    [Write each step as a substitution and carry it out one at a time,
      rather than trying to see the answer whole.],
    [For the second part, ask which pairs of transformations touch
      *different* variables. Those cannot interfere with each other.],
  ),
)[
  Let $f(x) = sqrt(x)$.
  + Shift $2$ units left, then reflect across the $y$\u{2011}axis. Give
    the equation.
  + Reflect across the $y$\u{2011}axis, then shift $2$ units left. Give
    the equation.
  + Find a pair of transformations from this section whose order does
    *not* matter, and explain why.
][
  + $f(x + 2) = sqrt(x+2)$, then replace $x$ by $-x$:
    $y = sqrt(-x + 2)$.
  + $f(-x) = sqrt(-x)$, then replace $x$ by $x + 2$:
    $y = sqrt(-x - 2)$.
  + Any vertical transformation commutes with any horizontal one -- for
    example a vertical shift and a horizontal shift. They act on
    different variables, so neither can disturb the other. Two
    transformations of the *same* kind generally do interfere.
    #heuristic("look for what stays the same")
]

=== The Letters Are Not the Point

#only-theory[
  A warning that has nothing to do with transformations and everything
  to do with reading mathematics. In the box above we called the four
  parameters $a$, $b$, $h$, $k$. Those letters are *placeholders*. Open
  another textbook and you will find the same four numbers called
  $a$, $b$, $c$, $d$, or $A$, $omega$, $t_0$, $M$, or something else
  again. Nothing mathematical changes. The chapter on trigonometric
  functions in this very course writes the horizontal and vertical
  shifts as $c$ and $d$ -- deliberately, because that is what most
  sources use there.

  What matters is the *role* a symbol plays -- inside or outside $f$,
  multiplying or added -- never the letter chosen for it. A function is
  a machine: it does the same thing to whatever you feed it, and it
  does not care what the input is called.
]

#example[
  Let $f(t) = 3t^2 - 2$. Then
  $
       f(x) & = 3x^2 - 2 \
    f(square) & = 3 dot square^2 - 2 \
    f(x + h) & = 3(x+h)^2 - 2 = 3x^2 + 6 x dot h + 3h^2 - 2
  $
  The third line is no harder than the second. If you can do
  $f(square)$, you can do $f(x+h)$ -- and $f(x+h)$ is the whole content
  of a horizontal shift.
]

#heuristic("introduce notation")

#ex(
  difficulty: 2,
  time: "10 min",
  calculator: false,
  hints: ([Substitute mechanically: wherever the definition has its
    input variable, write the new expression in brackets. Simplify only
    afterwards.],),
)[
  Let $g(u) = u^2 - 4u + 1$. Evaluate and simplify:
  #parts(
    2,
    [(a) $g(3)$],
    [(b) $g(star)$],
    [(c) $g(-x)$],
    [(d) $g(2x)$],
    [(e) $g(x - 1)$],
    [(f) $g(x) - 1$],
  )
  Which two of these are *not* the same, and what does the difference
  look like on the graph?
][
  #parts(
    2,
    [(a) $-2$],
    [(b) $star^2 - 4 dot star + 1$],
    [(c) $x^2 + 4x + 1$],
    [(d) $4x^2 - 8x + 1$],
    [(e) $x^2 - 6x + 6$],
    [(f) $x^2 - 4x$],
  )

  Parts (e) and (f) differ: $g(x-1)$ shifts the graph one unit *right*
  (the change happens inside $g$), while $g(x) - 1$ shifts it one unit
  *down* (outside $g$). Inside versus outside is the whole distinction.
]

#ex(
  difficulty: 2,
  time: "10 min",
  calculator: false,
  keep-together: true,
  hints: ([For the third form, factor the coefficient of $x$ out of the
    bracket first -- the same move as in the warning above.],),
)[
  Three sources write the same family of wave functions differently:
  $
    "(i)" quad & y = a dot sin(b dot (x - c)) + d \
   "(ii)" quad & y = A dot sin(omega dot (t - t_0)) + M \
  "(iii)" quad & y = a dot sin(k dot x + phi) + d
  $
  + Match the symbols in (ii) to those in (i).
  + In (iii), which symbol plays the role of $b$? Express $phi$ in
    terms of the symbols of (i).
  + Which form makes the horizontal shift hardest to read off, and why?
][
  + $A ~ a$, $omega ~ b$, $t_0 ~ c$, $M ~ d$. The variable $t$ replaces
    $x$ -- these sources are describing motion in time.
  + $k ~ b$. Expanding (i) gives
    $b dot (x - c) = b dot x - b dot c$, so $phi = -b dot c$.
  + Form (iii): the shift is not $phi$ but $-phi\/k$, because the
    bracket has not been factored. The shift is only readable at a
    glance once the horizontal stretch has been pulled out front.
]

#remark[
  This is a skill, not a nuisance. Being able to recognize a structure
  you know underneath unfamiliar symbols is most of what "understanding"
  means in mathematics -- and it is exactly what lets you read a physics
  formula, a source in another language, or a paper written fifty years
  ago.
]

=== Symmetry: When a Transformation Changes Nothing

#only-theory[
  Some graphs come back to themselves after a reflection. That is a
  geometric statement -- and, like every geometric statement in this
  section, it has an exact algebraic twin.
]

#definition[
  A function $f$ is
  - #vocab("even", "gerade") if $f(-x) = f(x)$ for every $x$ in the
    domain;
  - #vocab("odd", "ungerade") if $f(-x) = -f(x)$ for every $x$ in the
    domain.
]

#keybox(title: "The Two Sides of Symmetry")[
  #data-table(
    columns: (1fr, 1fr, 1fr),
    row-height: auto,
    [Name], [Algebra], [Geometry],
    [even], [$f(-x) = f(x)$], [unchanged by reflection in the
      $y$\u{2011}axis],
    [odd], [$f(-x) = -f(x)$], [unchanged by rotation of $180 degree$
      about the origin],
  )
]

#example[
  - $f(x) = x^2$ is even: $(-x)^2 = x^2$.
  - $f(x) = x^3$ is odd: $(-x)^3 = -x^3$.
  - $f(x) = x^2 + x$ is *neither*: $(-x)^2 + (-x) = x^2 - x$, which is
    equal to neither $f(x)$ nor $-f(x)$.

  "Neither" is the normal case. Symmetry is special.
]

#remark[
  This is where the names come from. $x^n$ is an even function exactly
  when $n$ is an even number, and an odd function exactly when $n$ is
  odd. The words are not a coincidence -- they were chosen to match.
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Decide whether each function is even, odd, or neither. Show the
  computation of $f(-x)$ in each case.
  #parts(
    3,
    [(a) $f(x) = x^4$],
    [(b) $f(x) = 1/x$],
    [(c) $f(x) = x^2 + 1$],
    [(d) $f(x) = x^3 - x$],
    [(e) $f(x) = abs(x)$],
    [(f) $f(x) = x + 1$],
  )
][
  #parts(
    2,
    [(a) even: $(-x)^4 = x^4$],
    [(b) odd: $1/(-x) = -1/x$],
    [(c) even: $(-x)^2 + 1 = x^2 + 1$],
    [(d) odd: $(-x)^3 - (-x) = -x^3 + x = -(x^3 - x)$],
    [(e) even: $abs(-x) = abs(x)$],
    [(f) neither: $-x + 1$ is neither $x + 1$ nor $-(x+1)$],
  )
]

#only-high[
  #exploration(title: "Splitting a Function in Two")[
    Every function defined on all of $RR$ can be written as a sum of an
    even function and an odd one, in exactly one way. Given $f$,
    consider
    $ g(x) = (f(x) + f(-x))/2, quad quad u(x) = (f(x) - f(-x))/2 . $
    + Check that $g$ is even and $u$ is odd.
    + Check that $g(x) + u(x) = f(x)$.
    + Try it on $f(x) = x^2 + x$ and on $f(x) = 2^x$.
  ]
]

#ai-box(role: "Checker")[
  Ask an AI: "Does $f(2x)$ stretch a graph horizontally or compress
  it?" Then ask the same question about $f(x/2)$. Models get this
  backwards surprisingly often, because the wording invites the
  intuitive answer rather than the correct one. Test each answer you
  get against the semicircle example above -- one concrete function
  settles it -- and write down one sentence explaining the error to
  someone who believed it.
]

#look-ahead(preview: [quadratic, power, and trigonometric functions])[
  Every function family from here on gets its own version of this same
  table, and none of them will be new. The vertex form
  $y = a dot (x - h)^2 + k$ is this section applied to $y = x^2$. The
  generalized sine, which the trigonometry chapter writes as
  $ y = a dot sin(b dot (x - c)) + d, $
  is this section applied to $y = sin(x)$ -- with $c$ and $d$ in the
  roles that $h$ and $k$ play here, and with the four parameters
  acquiring the physical names *amplitude*, *period*, *phase shift*,
  and *midline*. Learn the pattern once, here, and those chapters
  become bookkeeping in a different alphabet.
]

== Inverse Functions

#only-theory[
  Solving an equation like $2x + 3 = 11$ is really a process of *peeling
  away layers* to get to $x$ on its own: first undo the $+3$ (subtract 3
  from both sides), then undo the $times 2$ (divide both sides by 2).
  Each step *reverses* one operation. An
  #vocab("inverse function", "Umkehrfunktion") is exactly this idea,
  formalized: it's a function that undoes another function.
]

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
