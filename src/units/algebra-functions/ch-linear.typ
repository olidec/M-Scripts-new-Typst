#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Linear Functions")
#let ex = exercise.with(chapter: "Linear Functions")

= Linear Functions

#objectives(
  bfkm[recognize and apply linear functions as one of the standard
    types of function],
  bfkm[explain the connection between a linear function's equation and
    its graph -- the effect of the slope $m$ and the
    $y$\u{2011}intercept $q$],
  bfkm[graph functions and use these representations to solve
    problems],
  [write the equation of a line given two points, or a point and a
    slope, in slope-intercept, point-slope, or standard form],
  [apply transformations -- shifts and reflections -- to linear
    functions],
  [model a real-world situation with a linear function],
)

#exploration(title: "Investigation -- Linear Functions")[
  + Sketch the graphs of the following functions in the same Cartesian
    coordinate system. Compare and contrast your functions. What effect
    does the constant term $q$ have on the graphs $y = x + q$?
    #parts(5, [$y=x$], [$y=x+1$], [$y=x-1$], [$y=x-4$], [$y=x+4$])
  + Sketch the graphs of the following functions in the same Cartesian
    coordinate system. Compare and contrast your functions. What effect
    does the coefficient of the linear term $m$ have on the graphs
    $y = m dot x + q$?
    #parts(5, [$y=x+3$], [$y=2x+3$], [$y=3x+3$], [$y=-2x+3$], [$y=0.5x+3$])
]

#definition[
  The equation of a straight line (also called a *linear function*) is
  given by
  $ y = m x + q, $
  where $m$ is the #vocab("slope", "Steigung") and $q$ is the
  #vocab("y-intercept", "y-Achsenabschnitt") (the intersection with the
  $y$\u{2011}axis).
]

This equation gives a relationship between the $x$- and $y$\u{2011}coordinates
in a Cartesian coordinate system. If we draw all the points that satisfy
this relation in a coordinate system, we get the graph of a straight
line.

#keybox[
  The slope $m$ is defined by $m = (Delta y)/(Delta x)$.
]

There are some shortcuts when drawing these graphs.
- First mark the $y$\u{2011}intercept -- the point with coordinates $(0, q)$.
- From there, mark the slope by moving one unit in the $x$\u{2011}direction and
  $m$ units in the $y$\u{2011}direction. If the slope is given as a fraction,
  it's sometimes easier to move $Delta x$ units in the $x$\u{2011}direction and
  $Delta y$ units in the $y$\u{2011}direction.

#remark[
  Two special cases are easy to mix up. A *horizontal* line, $y = c$,
  has slope $0$ -- moving along it changes $x$ but never $y$. A
  *vertical* line, $x = c$, has *undefined* slope -- every point has the
  same $x$\u{2011}coordinate, so $Delta x = 0$ and $(Delta y)/(Delta x)$ is a
  division by zero. A vertical line also isn't the graph of a function
  at all (it fails the vertical line test), which is exactly why the
  standard form $a x + b y + c = 0$ from earlier is useful: unlike
  slope-intercept form, it can still describe one.
]

Just as the $y$\u{2011}intercept is where a line crosses the $y$\u{2011}axis, the
*$x$\u{2011}intercept* is where it crosses the $x$\u{2011}axis -- the point where
$y = 0$.

#example[
  For $y = 2x - 6$: the $y$\u{2011}intercept is $(0, -6)$. Setting $y = 0$ gives
  $0 = 2x - 6$, so $x = 3$ -- the $x$\u{2011}intercept is $(3, 0)$.
]

#ex(difficulty: 1, time: "10 min")[
  For each line, state whether the slope is positive, negative, zero,
  or undefined, then find the $x$\u{2011}intercept (if there is one).
  #parts(
    2,
    [(a) $y = -3x + 9$],
    [(b) $y = 5$],
    [(c) $x = 4$],
    [(d) $y = 1/4 x - 2$],
  )
][
  #parts(
    2,
    [(a) negative; $x$\u{2011}intercept $(3, 0)$],
    [(b) zero; no $x$\u{2011}intercept (the line never crosses the $x$\u{2011}axis)],
    [(c) undefined; $x$\u{2011}intercept $(4, 0)$ -- a vertical line still
      crosses the $x$\u{2011}axis at exactly one ordinary point],
    [(d) positive; $x$\u{2011}intercept $(8, 0)$],
  )
]

#ex(difficulty: 1, time: "20 min", keep-together: true)[
  Draw the following lines in a coordinate system.
  #parts(
    2,
    [(a) $y = 3/2 x - 2$],
    [(b) $y = -1/2 x + 3/2$],
    [(c) $y = 2$],
    [(d) $2x - y = 3$],
    [(e) $x = -1$],
    [(f) $4 dot (x - y) = 3 - 2 dot (5 + 2x)$],
  )
][
  #image-grid(
    3,
    gutter: 8pt,
    [ #plot-graph(x => 1.5 * x - 2, xmin: -3, xmax: 4, ymin: -5, ymax: 4, size: 3.6, grid-step: 1) (a) ],
    [ #plot-graph(x => -0.5 * x + 1.5, xmin: -4, xmax: 4, ymin: -2, ymax: 4, size: 3.6, grid-step: 1) (b) ],
    [ #plot-graph(x => 2, xmin: -4, xmax: 4, ymin: -1, ymax: 4, size: 3.6, grid-step: 1) (c) ],
    [ #plot-graph(x => 2 * x - 3, xmin: -2, xmax: 4, ymin: -5, ymax: 4, size: 3.6, grid-step: 1) (d) ],
    [
      #align(center, plot(
        xmin: -4,
        xmax: 4,
        ymin: -4,
        ymax: 4,
        width: 3.6,
        height: 3.6,
        show-grid: "major",
        vline(-1, stroke: accent + 1.3pt),
      ))
      (e)
    ],
    [ #plot-graph(x => 2 * x + 7 / 4, xmin: -3, xmax: 3, ymin: -3, ymax: 6, size: 3.6, grid-step: 1) (f) ],
  )
]

#keybox(title: "Slope Through Two Points")[
  Given two points $A = (x_A, y_A)$ and $B = (x_B, y_B)$ on a line, the
  slope is
  $ m = (y_B - y_A)/(x_B - x_A), quad x_A != x_B. $
  This is the same $(Delta y)/(Delta x)$ idea from before -- just
  written out for two named points instead of a picture.
]

#ex(difficulty: 1, time: "10 min")[
  Find the equation of the line passing through $A$ and $B$.
  #parts(2, [(a) $A = (0,3)$, $B = (1,5)$], [(b) $A = (-3,0)$, $B = (3, 2.5)$])
][
  #parts(2, [(a) $y = 2x + 3$], [(b) $y = 5/12 x + 5/4$])
]

#ex(difficulty: 2, time: "15 min", keep-together: true)[
  Determine the equations of the following lines.
  #align(center, plot(
    xmin: -8,
    xmax: 8,
    ymin: -4,
    ymax: 6,
    width: 8cm,
    height: 6cm,
    show-grid: "major",
    (fn: x => -5 / 4 * x + 9 / 4, stroke: accent + 1.3pt),
    vline(-2, stroke: warn-col + 1.3pt),
    (fn: x => 2 / 3 * x - 2 / 3, stroke: def-col + 1.3pt),
    (fn: x => -1 / 5 * x + 9 / 5, stroke: ex-col + 1.3pt),
  ))
  Line (a) is the steep one through roughly $(1, 1)$; (b) is the
  vertical line; (c) and (d) are the two shallower lines.
][
  #parts(
    2,
    [(a) $y = -5/4 x + 9/4$],
    [(b) $x = -2$],
    [(c) $y = 2/3 x - 2/3$],
    [(d) $y = -1/5 x + 9/5$],
  )
]

== Alternative Forms for Linear Functions

The most common way of writing a linear function uses the so-called
*slope-intercept form*, since it directly contains the slope and the
$y$\u{2011}intercept. There are two other commonly used forms: the *standard
form* and the *point-slope form*.

#definition(title: "Standard Form")[
  The standard form of a line is written as
  $ a x + b y + c = 0, $
  where the coefficients $a$, $b$, and $c$ are real numbers. The
  standard form is not itself a function, and it can also describe
  vertical lines (which slope-intercept form can't).
]

#definition(title: "Point-Slope Form")[
  The #vocab("point-slope form", "Punkt-Steigungs-Form") is useful when
  we know the slope of a line and a point on it that isn't the
  $y$\u{2011}intercept. Given the slope $m$ and a point $P = (x_P, y_P)$,
  the line has the equation
  $ y - y_P = m dot (x - x_P). $
  Solving for $y$ writes this directly as a function:
  $ y = m dot (x - x_P) + y_P. $
]

#example[
  A line has slope $m = -1/2$ and passes through $P = (3, -1)$. What is
  its equation in standard form?

  We plug the information into the point-slope form:
  $ y - (-1) = -1/2 dot (x - 3). $
  Expanding the brackets and rearranging:
  $
         y + 1 & = -1/2 x + 3/2 \
        2y + 2 & = -x + 3 \
    x + 2y - 1 & = 0.
  $
  This is the standard form, with $a = 1$, $b = 2$, $c = -1$.
]

#ex(difficulty: 2, time: "15 min")[
  Write the following lines in standard form.
  #parts(
    2,
    [(a) $y = 2x - 1$],
    [(b) $y + 3 = 2 dot (x - 1)$],
    [(c) $y = 5/7 x - 2/7$],
    [(d) $2 dot (y - 1) = 3 dot (x - 3) + 7$],
  )
][
  #parts(
    2,
    [(a) $-2x + y + 1 = 0$],
    [(b) $2x - y - 5 = 0$],
    [(c) $5x - 7y - 2 = 0$],
    [(d) $3x - 2y = 0$],
  )
]

#keybox(title: "Parallel Lines")[
  Two lines are *parallel* if and only if they have the *same slope*
  (and different $y$\u{2011}intercepts -- otherwise they're the same line).
]

#look-ahead(preview: [systems of equations])[
  Parallel lines never meet, no matter how far you extend them. But two
  lines that *aren't* parallel always meet at exactly one point --
  finding that point is exactly what "solving a system of equations"
  means, which is the topic of the next chapter.
]

#ex(difficulty: 2, time: "10 min")[
  Give the equation (in slope-intercept form) of the line *parallel* to
  $l : y = -3/2 x + 4$ and passing through
  #parts(2, [(a) $P = (4, 7)$], [(b) $P = (-1, -1)$])
][
  #parts(2, [(a) $y = -3/2 x + 13$], [(b) $y = -3/2 x - 5/2$])
]

== Transforming Lines

Just like other graphs, a line can be shifted and reflected. The order
of transformations matters -- doing the same two transformations in a
different order can give a different result.

#ex(difficulty: 2, time: "10 min")[
  The line $y = 2x - 1$ is shifted three units to the left and then
  reflected across the $y$\u{2011}axis. What is the equation of the resulting
  line? What happens if you reverse the order of the two
  transformations?
][
  Shift first, then reflect: $y = -2x + 5$. Reflect first, then shift:
  $y = -2x - 7$. Same two transformations, different order, different
  result.
]

#ex(difficulty: 2, time: "15 min")[
  Given the line $y = -1/2 x + 4$. Perform the following operations and
  give the equation of the resulting line.
  #parts(
    2,
    [(a) Shift 2 units up.],
    [(b) Shift 1 unit down and 3 units left.],
    [(c) Reflect across the $x$\u{2011}axis.],
    [(d) Shift 1 unit left and reflect across the $y$\u{2011}axis.],
  )
][
  #parts(
    2,
    [(a) $y = -1/2 x + 6$],
    [(b) $y = -1/2 dot (x+3) + 3$],
    [(c) $y = 1/2 x - 4$],
    [(d) $y = 1/2 x + 7/2$],
  )
]

#exploration(title: "Perpendicular Lines")[
  Draw three pairs of straight lines that are
  #vocab("perpendicular", "senkrecht") to each other. Determine their
  equations. Can you spot a regularity between each pair of slopes?
]

#keybox(title: "Perpendicular Lines")[
  Two lines with slopes $m_1$ and $m_2$ (neither one vertical) are
  perpendicular if and only if
  $ m_1 dot m_2 = -1, quad "i.e." quad m_2 = -1/m_1. $
  In words: perpendicular slopes are *negative reciprocals* of each
  other -- flip the fraction and change the sign.
]

#ex(difficulty: 2, time: "10 min")[
  Give the equation (in slope-intercept form) of the line
  *perpendicular* to $l : y = -3/2 x + 4$ and passing through
  #parts(2, [(a) $P = (4, 7)$], [(b) $P = (-1, -1)$])
][
  #parts(2, [(a) $y = 2/3 x + 13/3$], [(b) $y = 2/3 x - 1/3$])
]

#ex(difficulty: 3, time: "20 min", keep-together: true)[
  Given the following two graphs:
  #align(center, plot(
    xmin: -3.5,
    xmax: 5.5,
    ymin: -2.5,
    ymax: 5.5,
    width: 7cm,
    height: 6cm,
    show-grid: "major",
    (fn: x => 0.5 * x + 2, stroke: accent + 1.3pt),
    (fn: x => -0.5 * x - 1, stroke: warn-col + 1.3pt),
  ))
  Call the graph in teal $f$ and the graph in orange $g$.
  + Determine the equation of the graph of $f$ in standard form.
  + Does $P = (2024, 1012)$ lie on the graph of $f$?
  + Apply the following transformation to $f$: reflect across the
    origin, then shift three units up. Determine the equation of the
    transformed graph (in any form).
  + Find at least two different transformations (reflections and/or
    translations) that turn the graph of $f$ into the graph of $g$.
  + Find the equation of a line perpendicular to $f$ that passes
    through the point $P = (7, -3)$.
][
  + $2y - x - 4 = 0$
  + No: $f(2024) = 0.5 dot 2024 + 2 = 1014 != 1012$.
  + $y = 1/2 x + 1$
  + Two options: reflect across the $y$\u{2011}axis, then shift 3 units down;
    or reflect across the $x$\u{2011}axis, then shift 1 unit up.
  + $y + 3 = -2 dot (x - 7)$, i.e. $y = -2x + 11$.
]

#exploration(title: "The Surprising Cards")[
  I took the graph $y = 4x + 7$ and performed the four transformations
  shown below, in some order:
  // #keybox[
  //   "Translate down by three units" -- "Reflect in the vertical axis"
  //   -- "Translate left by two units" -- "Reflect in the horizontal
  //   axis"
  // ]
  #align(center)[#image("images/surprising-cards.jpg", width: 85%)]
  Unfortunately, I can't remember the order in which I carried out the
  four transformations, but I know I ended up with the graph of
  $y = 4x - 2$.

  Find an order in which I could have carried out the transformations.
  There is more than one way of doing this -- can you find them all?
  Try to explain why different orders can lead to the same outcome.

  What other lines could I have ended up with, if I had performed the
  four transformations in a different order?
]

== Modeling with Linear Functions

#ex(difficulty: 2, time: "15 min")[
  An energy company offers an electricity tariff with a fixed charge of
  CHF 30 per year and a price of CHF 22.90 per 100 kWh.
  + Write a term for the electricity price and represent the tariff
    graphically. What is the rate of change?
  + What does a customer pay if they consumed 800 kWh in the last year?
    How much was consumed if the customer paid CHF 108.25?
][
  + $c(e) = 22.9 e + 30$, where $c$ is the total cost (CHF) and $e$ is
    the energy used (in units of 100 kWh). This is a linear function;
    the rate of change is CHF 22.90 per 100 kWh.
  + 800 kWh is $e = 8$: $c(8) = 213.2$, so CHF 213.20. If they paid CHF
    108.25, then $22.9 e + 30 = 108.25 => e approx 3.42$, i.e.
    approximately 342 kWh.
]

#ex(difficulty: 2, time: "15 min", keep-together: true)[
  Create a scatter plot for the following points and sketch a line of
  best fit. Determine its slope $m$, its $y$\u{2011}intercept $q$, and the
  function equation.
  #align(center, plot(
    xmin: -1,
    xmax: 8,
    ymin: 0,
    ymax: 6,
    width: 7cm,
    height: 5cm,
    show-grid: "major",
    data(
      (
        (0, 2.0),
        (1, 2.4),
        (2, 2.9),
        (3, 3.5),
        (4, 4.2),
        (5, 4.6),
        (6, 4.9),
        (7, 5.5),
      ),
      mark: "*",
      mark-fill: accent,
      mark-stroke: accent,
      mark-size: 0.1,
    ),
  ))
][
  A reasonable line of best fit gives approximately $m approx 0.51$,
  $q approx 1.97$, i.e. $y approx 0.51 x + 1.97$. (Since this is
  estimated by eye, small variations from these values are expected and
  fine.)
]

#ex(difficulty: 2, time: "15 min", keep-together: true)[
  Create a scatter plot for the following points and sketch a line of
  best fit. Determine its slope $m$, its $y$\u{2011}intercept $q$, and the
  function equation.
  #align(center, plot(
    xmin: -1,
    xmax: 20,
    ymin: 0,
    ymax: 16,
    width: 7cm,
    height: 5cm,
    show-grid: "major",
    data(
      (
        (2, 3.5),
        (5, 5),
        (6.5, 4.5),
        (8, 7.2),
        (10, 11.2),
        (15, 13.6),
        (18, 15),
      ),
      mark: "*",
      mark-fill: accent,
      mark-stroke: accent,
      mark-size: 0.1,
    ),
  ))
][
  A reasonable line of best fit gives approximately $m approx 0.80$,
  $q approx 1.20$, i.e. $y approx 0.80 x + 1.20$.
]

== Extra Bits

#ex(difficulty: 3, time: "15 min")[
  A group of 10 students are on a field trip when their bus breaks down
  40 miles from school. A teacher takes 5 of them back to school in her
  car, travelling at a steady 40 mph. The other 5 start walking towards
  school at a steady 4 mph. The teacher drops the first 5 off, then
  immediately turns around and comes back for the others, again at 40
  mph.

  How far have the walking students walked by the time the car reaches
  them?
][
  Measuring position from the breakdown point ($0$) to school ($40$):
  the car reaches school at $t=1$ h and immediately heads back, so for
  $t >= 1$ its position is $40 - 40(t-1)$. The walkers' position is
  $4t$ throughout. Setting these equal:
  $ 4t = 40 - 40(t-1) quad => quad t = 20/11 approx 1.82 "h." $
  Distance walked: $4t = 80/11 approx 7.27$ miles.
]

#ex(difficulty: 3, time: "20 min", keep-together: true)[
  When I park my car in Mathstown, there are two car parks to choose
  from. In car park A, it costs 80p to park for the first hour, and an
  extra 50p for each hour after that. In car park B, it costs £1.50 to
  park for the first hour, and an extra 30p for each hour after that.

  Which car park should I use?

  There is a Park and Ride service where it costs 40p per hour to park,
  but you also have to pay 60p for the bus fare into town. Alternatively
  I could park for free at the railway station and get the train into
  town -- a return ticket costs £3.50.

  What advice would you give me if I was trying to decide whether to use
  one of the car parks, the Park and Ride, or the train?
][
  Modeling each option as a linear function of the parking duration $h$
  (in hours, for $h >= 1$):
  $
    A(h) = 0.50h + 0.30, quad B(h) = 0.30h + 1.20, quad "PR"(h) = 0.40h + 0.60, quad T = 3.50.
  $
  Comparing them pairwise gives four crossover points: $A = "PR"$ at
  $h=3$, $"PR" = B$ at $h=6$, $B = T$ at $h = 23/3 approx 7.67$. Putting
  these in order, the *cheapest* option changes as the stay gets longer:
  - Up to 3 hours: car park *A*.
  - 3 to 6 hours: *Park and Ride*.
  - 6 to about 7 h 40 min: car park *B*.
  - Longer than that: the *train*.
]

#print-hints()
#print-vocab()
