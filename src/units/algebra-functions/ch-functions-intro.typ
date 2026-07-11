#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Introduction to Functions")
#let ex = exercise.with(chapter: "Introduction to Functions")

= Introduction to Functions

A *relation* is a set of ordered pairs of numbers, usually written
$(x, y)$. The *domain* $X$ is the set of all the first numbers
($x$-values) of the ordered pairs; the *range* $Y$ is the set of the
second numbers ($y$-values). Many mathematical relationships concern how
two sets of numbers relate to one another, and the best way to express
this is often an algebraic equation in two variables. Besides an
equation, other useful ways to represent a relation include a graph on a
*Cartesian coordinate system*, a table, or a set of ordered pairs.

#definition[
  A *function* is a rule that maps every number in its domain to exactly
  one number in its range. The input is called the *independent
  variable* (or *argument*); the output is called the *dependent
  variable*.
]

#keybox(title: "Function Notation")[
  $f(x)$ is read "$f$ of $x$" and means "the value of function $f$ at
  $x$."
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
table* gives a first approximation: pick some $x$-values from the
domain, calculate the corresponding $y$-values, then plot the resulting
points.

#example[
  Given $f : y = sqrt(4 - x^2)$, the domain is $X = [-2, 2]$ (since we
  need $4 - x^2 >= 0$). A value table:

  #data-table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    row-height: auto,
    [$x$], [$-2$], [$-1.5$], [$-1$], [$0$], [$1$], [$1.5$], [$2$],
    [$y$], [$0$], [$1.32$], [$1.73$], [$2$], [$1.73$], [$1.32$], [$0$],
  )

  Plotting these points reveals the graph -- in fact, a semicircle:

#align(center)[
#let r = 2
#plot(
  xmin: -r - 0.5, xmax: r + 0.5,
  ymin: -r - 0.5, ymax: r + 0.5,     // same span as x: 2(r+1) either way
  width: 6cm, height: 6cm,        // same physical size — this is the part that actually matters
  show-grid: "major",
  unit-label-only: true,
  (fn: x => if calc.abs(x) > r { none } else { calc.sqrt(r * r - x * x) }, stroke: accent + 1.3pt, domain: (-r,r)),
  scatter(
    ((-2, 0), (-1.5, 1.32), (-1, 1.73), (0, 2), (1, 1.73), (1.5, 1.32), (2, 0)),
    mark: "*",
    mark-fill: blue,
    mark-size: 0.15,
  )
  // (fn: x => if calc.abs(x) > r { none } else { -calc.sqrt(r * r - x * x) }, stroke: accent + 1.3pt),
)]

]

#example[
  There are different scales for measuring temperature. The Celsius
  scale ($C$) and Fahrenheit scale ($F$) are related by
  $ F = 9/5 C + 32. $

  #plot(
    xmin: -20, xmax: 40, ymin: -10, ymax: 110, size: 6,
    x-label: $C$, y-label: $F$,
    x-tick-label-step: 10,
    show-grid: none,
    (fn: x => 9 / 5 * x + 32)
    
  )
]

=== The Vertical Line Test

#keybox[
  A relation is a function if and only if every vertical line intersects
  its graph *at most once*. This is the *vertical line test*.
]

#example[
  #image-grid(2,
    [
      #plot-graph(x => 0.4 * x * x - 1, xmin: -3, xmax: 3, ymin: -2, ymax: 3, size: 5.5)
      Every vertical line crosses this graph at most once - it *is* a
      function.
    ],
    [
      #align(center, box(width: 5.5cm, height: 5.5cm, {
        place(circle(radius: 2.2cm, fill: accent-bg, stroke: 1pt + accent))
        place(dx: 2.75cm - 0.4pt, dy: 0.55cm, line(
          start: (0pt, 0pt), end: (0pt, 4.4cm), stroke: (paint: warn-col, dash: "dashed"),
        ))
      }))
      A vertical line through the middle of a circle crosses it *twice*
      - a circle is *not* the graph of a function.
    ],
  )
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
    gives two different $y$-values)
  + domain ${-2,-1,0,1,2}$, range ${1,2,4,6}$ -- function
]

#ex(difficulty: 2, time: "20 min", keep-together: true)[
  Which of the following graphs represent functions?
  #image-grid(3,
    plot-graph(x => 2 * x - 1, xmin: -3, xmax: 3, ymin: -5, ymax: 5, size: 4),
    plot-graph(x => -0.5 * x * x + 2, xmin: -3, xmax: 3, ymin: -3, ymax: 3, size: 4),
    align(center, box(width: 4cm, height: 4cm,
      place(ellipse(width: 3.5cm, height: 2.2cm, fill: accent-bg, stroke: 1pt + accent)))),
  )
][
  The line and the parabola are functions (every vertical line meets
  each graph once); the ellipse is not (a vertical line through its
  middle meets it twice).
]

#ex(difficulty: 2, time: "25 min")[
  For each function below, sketch the graph (a value table may help for
  the unfamiliar ones). State the domain and range, and note anything
  else you notice.
  #parts(3,
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
  #image-grid(4, gutter: 8pt,
    plot-graph(x => 2 * x - 3, xmin: -4, xmax: 4, ymin: -6, ymax: 6, size: 3.3, grid-step: 2),
    plot-graph(x => calc.abs(x), xmin: -4, xmax: 4, ymin: -1, ymax: 5, size: 3.3, grid-step: 2),
    plot-graph(x => calc.abs(2 * x - 1), xmin: -4, xmax: 4, ymin: -1, ymax: 6, size: 3.3, grid-step: 2),
    plot-graph(x => calc.abs(calc.abs(x - 1) - 1), xmin: -4, xmax: 4, ymin: -1, ymax: 3, size: 3.3, grid-step: 2),
    plot-graph(x => x * x, xmin: -3, xmax: 3, ymin: -1, ymax: 8, size: 3.3, grid-step: 2),
    plot-graph(x => 0.5 * x * x - 2 * x, xmin: -3, xmax: 6, ymin: -3, ymax: 8, size: 3.3, grid-step: 2),
    plot-graph(x => if x < 0 { none } else { calc.sqrt(x) }, xmin: -1, xmax: 6, ymin: -1, ymax: 3, size: 3.3, grid-step: 2),
    plot-graph(x => if x > 2 { none } else { calc.sqrt(2 - x) }, xmin: -4, xmax: 3, ymin: -1, ymax: 3, size: 3.3, grid-step: 2),
    plot-graph(x => if calc.abs(x) < 0.1 { none } else { 1 / x }, xmin: -4, xmax: 4, ymin: -4, ymax: 4, size: 3.3, grid-step: 2),
    plot-graph(x => if calc.abs(x - 3) < 0.1 { none } else { 1 / (x - 3) }, xmin: -2, xmax: 8, ymin: -4, ymax: 4, size: 3.3, grid-step: 2),
    plot-graph(x => x * x * x, xmin: -2, xmax: 2, ymin: -6, ymax: 6, size: 3.3, grid-step: 1),
    plot-graph(x => if 9 - x * x < 0 { none } else { calc.sqrt(9 - x * x) }, xmin: -4, xmax: 4, ymin: -1, ymax: 4, size: 3.3, grid-step: 2),
  )

  Domains: (a) $RR$ (b) $RR$ (c) $RR$ (d) $RR$ (e) $RR$ (f) $RR$
  (g) $[0, infinity)$ (h) $(-infinity, 2]$ (i) $RR without {0}$
  (j) $RR without {3}$ (k) $RR$ (l) $[-3, 3]$.

  Ranges: (a) $RR$ (b) $[0, infinity)$ (c) $[0, infinity)$
  (d) $[0, 1]$ (e) $[0, infinity)$ (f) $[-2, infinity)$
  (g) $[0, infinity)$ (h) $[0, infinity)$ (i) $RR without {0}$
  (j) $RR without {0}$ (k) $RR$ (l) $[0, 3]$.
]

#exploration(title: "Sketch From a Story")[
  Below are containers of different shapes. Imagine each one filling
  with water at a steady rate.

  #only-theory[_(Photos to be added: a beaker, a conical flask, a test
  tube, a round-bottom flask, a pint glass, a volumetric flask.)_]

  For each container, sketch a graph of the *height* of the water level
  against the *volume* of water poured in. Which parts of each graph
  will be straight, and which curved? What units and scales make sense
  for the axes?
]

== Some Notation: Intervals

Intervals are special subsets of the real numbers -- they can be
pictured as a section of the number line. Formally, they can be written
in set notation, e.g.
$ I = {x in RR med | med 1 <= x < 4}. $
Here the square bracket would indicate that $1$ is included in the
interval, and the round bracket that $4$ is not.

As intervals come up constantly, they have their own shorthand notation:

#keybox(title: "Interval Notation")[
  #data-table(
    columns: (auto, 1fr),
    row-height: auto,
    [Notation], [Set Notation],
    [$[a,b]$], [${x in RR med | med a <= x <= b}$],
    [$[a,b)$], [${x in RR med | med a <= x < b}$],
    [$(a,b]$], [${x in RR med | med a < x <= b}$],
    [$(a,b)$], [${x in RR med | med a < x < b}$],
  )
]

There are also *unbounded* intervals, where one boundary is $plus.minus infinity$.
These are written the same way, with $infinity$ standing in for the
missing boundary. For example $I = {x in RR med | med x >= 4}$ is written
$[4, infinity)$. Remember that infinity is a concept, not a number -- so
that side of the interval always gets a *round* bracket, since infinity
itself can never actually be included.

#ex(difficulty: 1, time: "10 min")[
  Write each inequality as an interval.
  #parts(3,
    [(a) $x > 6$],
    [(b) $x <= -8$],
    [(c) $2 < x < 9$],
    [(d) $0 <= x < 12$],
    [(e) $x > -5$],
    [(f) $-3 <= x <= 3$],
  )
][
  #parts(3,
    [(a) $(6, infinity)$],
    [(b) $(-infinity, -8]$],
    [(c) $(2, 9)$],
    [(d) $[0, 12)$],
    [(e) $(-5, infinity)$],
    [(f) $[-3, 3]$],
  )
]

#ex(difficulty: 2, time: "15 min")[
  Write the intersection or union of the following sets as an interval.
  #parts(2,
    [(a) $[1,3) inter (2,7)$],
    [(b) $(-infinity,0) inter (-2,5)$],
    [(c) $[-7,-2] union (-infinity,-1)$],
    [(d) $(2,5) union (4,infinity)$],
  )
][
  #parts(2,
    [(a) $(2,3)$],
    [(b) $(-2,0)$],
    [(c) $(-infinity,-1)$],
    [(d) $(2,infinity)$],
  )
]

== Inverse Functions

Solving an equation like $2x + 3 = 11$ is really a process of *peeling
away layers* to get to $x$ on its own: first undo the $+3$ (subtract 3
from both sides), then undo the $times 2$ (divide both sides by 2). Each
step *reverses* one operation. An *inverse function* is exactly this
idea, formalized: it's a function that undoes another function.

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
  #parts(2,
    [(a) $f(x) = x + 7$],
    [(b) $f(x) = x - 4$],
    [(c) $f(x) = 5x$],
    [(d) $f(x) = x/3$],
  )
][
  #parts(2,
    [(a) subtract 7: $f^(-1)(x) = x - 7$],
    [(b) add 4: $f^(-1)(x) = x + 4$],
    [(c) divide by 5: $f^(-1)(x) = x/5$],
    [(d) multiply by 3: $f^(-1)(x) = 3x$],
  )
]

#ex(level: "high", difficulty: 2, time: "15 min")[
  For each function, find $f^(-1)(x)$ by reversing the steps of $f$ in
  order, peeling off the outermost operation first.
  #parts(2,
    [(a) $f(x) = 3x + 5$],
    [(b) $f(x) = (x-2)/4$],
    [(c) $f(x) = 2(x+1)$],
    [(d) $f(x) = -x + 6$],
  )
][
  #parts(2,
    [(a) $f^(-1)(x) = (x-5)/3$],
    [(b) $f^(-1)(x) = 4x+2$],
    [(c) $f^(-1)(x) = x/2 - 1$],
    [(d) $f^(-1)(x) = -x + 6$ (its own inverse!)],
  )
]

#print-hints()
