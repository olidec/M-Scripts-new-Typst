#import "../../common/preamble.typ": *
#import "../../common/cplane.typ": *
#import "../../common/conic-figures.typ": *
#show: chapter-template.with(title: "Ellipse")
#let ex = exercise.with(chapter: "Ellipse")

// ── NOTE ON THE OLD DERIVATION ───────────────────────────────
// Three errors in the LaTeX source are corrected here rather than
// carried over. Worth knowing which, in case a student turns up
// with an old printout:
//   * "2a > 2c and so a < c" -- the conclusion is a > c. The
//     inequality is the triangle inequality and is now derived
//     rather than asserted, with the degenerate 2a = 2c case
//     named (the locus collapses to the segment F1F2).
//   * "we set x = 0 and get the y-intercepts (-b, 0) and (b, 0)"
//     -- those are (0, +-b).
//   * "a point P lies on the parabola if the sum ..." -- ellipse.
//
// ── NOTE ON "VERTEX" ─────────────────────────────────────────
// German "Scheitel" covers all FOUR extreme points of an ellipse;
// English usage reserves "vertex" for the two on the major axis
// and calls the other two "co-vertices". A Matura question
// translated from German asking for "all vertices" wants four
// points. This is flagged in the text -- it is exactly the kind
// of thing immersion students lose marks on, and it is invisible
// unless someone says it out loud.
//
// ── FIGURE NOTE ──────────────────────────────────────────────
// Every ellipse drawn here is a = 5, b = 4, c = 3, so the
// 3-4-5 triangle in the anatomy figure is exact and the point
// P = (3, 16/5) has focal radii 34/5 and 16/5 summing to 10.

= The Ellipse

#only-theory[
  The parabola came from balancing a distance to a point against a
  distance to a line. The ellipse comes from something simpler still:
  two points, and a total.

  It is also the conic you have never met. The circle you have known
  since primary school is a special case of it, the orbit of every
  planet is one, and the reason a lithotripter can shatter a kidney
  stone without an incision is a property of it.
]

#look-back(
  title: "What carries over",
  recalls: [the parabola chapter, and integration from earlier this year],
)[
  The method is the whole of the previous chapter: write down the
  defining condition on distances, put the figure in the friendliest
  possible position, and grind the square roots away. Only the
  condition changes.

  From integral calculus you will need one integral, and it is one you
  have already done: $integral sqrt(a^2 - x^2) dif x$ over a symmetric
  interval, which is where the area of the ellipse comes from.
]

#objectives(
  [define an ellipse as the locus of points whose distances to two
    foci have a constant sum $2a$],
  [derive the equation $x^2 / a^2 + y^2 / b^2 = 1$ and the relation
    $b^2 = a^2 - c^2$],
  [explain why $a > c$ is forced, and what happens when $a = c$],
  [name and locate the centre, the major and minor axes, the vertices
    and co-vertices, and the foci, in either orientation and after a
    translation],
  [compute the linear eccentricity $c$, the numerical eccentricity
    $epsilon = c slash a$ and the semi-latus rectum $p = b^2 slash a$],
  [describe an ellipse as a circle stretched in one direction, and use
    that to get its area $pi a b$],
  [find the equation of an ellipse from foci and vertices, from a
    string construction, or from physical data such as an orbit],
)

== The Locus Definition

#definition(title: "Ellipse")[
  Let $F_1$ and $F_2$ be two points and let $2a > overline(F_1 F_2)$.
  The #vocab("ellipse", "Ellipse") with
  #vocab("foci", "Brennpunkte") $F_1$, $F_2$ is the set of all points
  $P$ for which
  $ overline(P F_1) + overline(P F_2) = 2 a . $
]

#only-theory[
  The condition $2a > overline(F_1 F_2)$ is not decoration. By the
  triangle inequality any point $P$ satisfies
  $overline(P F_1) + overline(P F_2) >= overline(F_1 F_2)$, with
  equality exactly when $P$ lies on the segment $F_1 F_2$. So if
  $2a$ were smaller than $overline(F_1 F_2)$ there would be no points
  at all, and if it were equal the "ellipse" would be the segment
  itself. Only $2a > overline(F_1 F_2)$ gives a curve.
]

#exploration(title: "Two constructions, one curve")[
  *With string.* Push two pins into a board and loop a piece of string
  loosely around them, longer than the gap. Pull it taut with a pencil
  and draw all the way round, keeping it taut throughout.
  + Why is the result an ellipse, and what exactly is $2a$ in terms of
    the string?
  + Move the pins closer together without changing the string. Predict
    what happens *before* you draw it.
  + Push both pins into the same hole. What do you get, and what does
    that tell you about circles?

  *With paper.* Cut out a paper disc and mark its centre $M$. Mark a
  second point $G$ somewhere inside, not at the centre. Fold the disc
  so that a point of the rim lands exactly on $G$, and crease; repeat
  for at least a dozen rim points.
  + An ellipse appears. Where are its two foci?
  + What happens as $G$ moves towards the rim? As it moves towards
    $M$?
  + As in the parabola chapter, the creases are not the curve. What
    are they?
]

== Deriving the Equation

#only-theory[
  Put the foci symmetrically on the $x$-axis:
  $
    F_1 = (-c, 0), quad quad F_2 = (c, 0), quad quad c > 0,
  $
  so that $overline(F_1 F_2) = 2c$ and the condition of the definition
  reads $a > c$. Let $P = (x, y)$. Then
  $
    sqrt((x + c)^2 + y^2) + sqrt((x - c)^2 + y^2) = 2 a .
  $
]

#only-theory[
  #xyplane(
    xmin: -6.6,
    xmax: 6.6,
    ymin: -5.0,
    ymax: 5.0,
    caption: [The ellipse with $a = 5$, $b = 4$, $c = 3$. For every
      point $P$ of the curve the two focal radii add up to
      $2a = 10$; here they are $34 slash 5$ and $16 slash 5$.],
    {
      cn-ellipse(5, 4)
      cp-segment((3.0, 3.2), (-3.0, 0.0), color: def-col)
      cp-segment((3.0, 3.2), (3.0, 0.0), color: def-col)
      cn-focus(-3, 0, label: $F_1$, anchor: "north-east")
      cn-focus(3, 0, label: $F_2$, anchor: "north-west")
      cp-point(3.0, 3.2, label: $P$, anchor: "south-west", color: def-col)
    },
  )
]

#only-theory[
  Two square roots cannot be removed at once, so isolate one, square,
  and see what is left:
  $
      sqrt((x - c)^2 + y^2) & = 2 a - sqrt((x + c)^2 + y^2) \
            (x - c)^2 + y^2 & = 4 a^2 - 4 a sqrt((x + c)^2 + y^2) + (x + c)^2 + y^2 \
    x^2 - 2 c x + c^2 + y^2 & = 4 a^2 - 4 a sqrt((x + c)^2 + y^2) \
                            & quad + x^2 + 2 c x + c^2 + y^2 .
  $
  Almost everything cancels -- the $x^2$, the $c^2$ and the $y^2$ --
  and what survives rearranges to
  $ a sqrt((x + c)^2 + y^2) = a^2 + c x . $
  Squaring a second time,
  $
    a^2 (x^2 + 2 c x + c^2 + y^2) & = a^4 + 2 a^2 c x + c^2 x^2 \
      a^2 x^2 + a^2 c^2 + a^2 y^2 & = a^4 + c^2 x^2 \
        (a^2 - c^2) x^2 + a^2 y^2 & = a^2 (a^2 - c^2) .
  $
  Because $a > c$, the number $a^2 - c^2$ is positive and may be given
  a name of its own.
]

#keybox(title: "Equation of the ellipse")[
  Set $b^2 = a^2 - c^2$, that is
  $ a^2 = b^2 + c^2 . $
  Then dividing $b^2 x^2 + a^2 y^2 = a^2 b^2$ through by $a^2 b^2$
  gives
  $ x^2 / a^2 + y^2 / b^2 = 1 . $
  The ellipse with foci $(plus.minus c, 0)$ and focal sum $2a$ has
  this equation, with $a > b > 0$.
]

#remark[
  The relation $a^2 = b^2 + c^2$ is Pythagoras, and it is Pythagoras
  in a triangle you can point at. Take the co-vertex $(0, b)$. Its two
  focal radii are equal by symmetry, and they sum to $2a$, so each is
  $a$. The right triangle with legs $b$ and $c$ and hypotenuse $a$ is
  therefore sitting in the figure, drawn below. Remembering *that*
  picture is more reliable than remembering which of $a^2 = b^2 + c^2$
  and $b^2 = a^2 + c^2$ is the ellipse's.
]

== Anatomy

#only-theory[
  Setting $y = 0$ gives $x = plus.minus a$, and setting $x = 0$ gives
  $y = plus.minus b$ -- four points, and each has a name.
]

#only-theory[
  #xyplane(
    xmin: -6.6,
    xmax: 6.6,
    ymin: -5.0,
    ymax: 5.0,
    caption: [The parts of an ellipse. The shaded triangle has legs
      $b$ and $c$ and hypotenuse $a$, which is the relation
      $a^2 = b^2 + c^2$ made visible.],
    {
      cn-ellipse(5, 4)
      cp-segment((0.0, 0.0), (0.0, 4.0), color: expl-col)
      cp-segment((0.0, 0.0), (3.0, 0.0), color: expl-col)
      cp-segment((3.0, 0.0), (0.0, 4.0), color: def-col)
      cn-center(0, 0, label: $M$, anchor: "south-east")
      cn-focus(-3, 0, label: $F_1$, anchor: "north-east")
      cn-focus(3, 0, label: none)
      cn-vertex(5, 0, label: $A_1$, anchor: "north-west")
      cn-vertex(-5, 0, label: $A_2$, anchor: "north-east")
      cn-vertex(0, 4, label: $B_1$, anchor: "south-west")
      cn-vertex(0, -4, label: $B_2$, anchor: "north-west")
      cp-label(1.7, 0.45, $c$, color: expl-col)
      cp-label(-0.45, 2.1, $b$, color: expl-col)
      cp-label(1.9, 2.3, $a$, color: def-col)
    },
  )
]

#keybox(title: "Names and numbers")[
  For $x^2 / a^2 + y^2 / b^2 = 1$ with $a > b > 0$:

  - $M = (0,0)$ is the #vocab("centre", "Mittelpunkt");
  - $A_(1,2) = (plus.minus a, 0)$ are the
    #vocab("vertices", "Hauptscheitel"), and the segment between them
    is the #vocab("major axis", "Hauptachse"), of length $2a$;
  - $B_(1,2) = (0, plus.minus b)$ are the
    #vocab("co-vertices", "Nebenscheitel"), and the segment between
    them is the #vocab("minor axis", "Nebenachse"), of length $2b$;
  - $a$ and $b$ are the semi-major and semi-minor axes;
  - $c = sqrt(a^2 - b^2)$ is the
    #vocab("linear eccentricity", "lineare Exzentrizität"), the
    distance from the centre to a focus;
  - $epsilon = c / a in [0, 1)$ is the
    #vocab("numerical eccentricity", "numerische Exzentrizität");
  - $p = b^2 / a$ is the semi-latus rectum, half the focal chord
    perpendicular to the major axis.
]

#warning[
  In German, *Scheitel* covers all four of $A_1$, $A_2$, $B_1$, $B_2$.
  In English, *vertex* usually means only the two on the major axis,
  and the other two are called *co-vertices*.

  This matters in exactly one place and it matters a lot: a Matura
  question translated from German that asks for "all vertices of the
  ellipse" is asking for _four_ points. Give two and you have
  answered half the question. When a task says *all*, count the
  Scheitel.
]

#only-theory[
  The eccentricity $epsilon = c slash a$ is the shape number that the
  parabola did not have. It is a ratio of two lengths, so scaling the
  whole picture leaves it alone, and it measures how far the ellipse
  is from being a circle: $epsilon = 0$ means $c = 0$, both foci at
  the centre, $a = b$, a circle; and as $epsilon -> 1$ the foci run
  out towards the vertices and the ellipse becomes long and thin.
  Since $b slash a = sqrt(1 - epsilon^2)$, the eccentricity fixes the
  proportions of the ellipse completely.
]

#only-theory[
  #image-grid(
    3,
    xyplane-small(
      xmin: -5.2,
      xmax: 5.2,
      ymin: -5.2,
      ymax: 5.2,
      caption: [$epsilon = 0$: a circle.],
      {
        cn-ellipse(4, 4)
        cn-focus(0, 0, label: none)
      },
    ),
    xyplane-small(
      xmin: -5.2,
      xmax: 5.2,
      ymin: -5.2,
      ymax: 5.2,
      caption: [$epsilon = 0.6$.],
      {
        cn-ellipse(4, 3.2)
        cn-focus(-2.4, 0, label: none)
        cn-focus(2.4, 0, label: none)
      },
    ),
    xyplane-small(
      xmin: -5.2,
      xmax: 5.2,
      ymin: -5.2,
      ymax: 5.2,
      caption: [$epsilon = 0.9$.],
      {
        cn-ellipse(4, 1.744)
        cn-focus(-3.6, 0, label: none)
        cn-focus(3.6, 0, label: none)
      },
    ),
  )
]

#look-ahead(
  title: "What eccentricity really is",
  preview: [the eccentricity chapter],
)[
  Defined as $c slash a$, eccentricity looks like an arbitrary ratio
  that happens to be useful. It is not. In the eccentricity chapter
  the same number reappears as the ratio in a focus--directrix
  condition that describes *all three* conics at once -- with
  $epsilon < 1$ giving ellipses, $epsilon = 1$ the parabola, and
  $epsilon > 1$ hyperbolas. That is why the parabola sits exactly on
  the boundary, and why it has no shape parameter of its own.
]

== Orientation and Position

#only-theory[
  Nothing in the derivation forced the foci onto the $x$-axis.
  Swapping $x$ and $y$ puts them on the $y$-axis and swaps the roles
  of the two denominators, and translating the centre to $(u, v)$
  replaces $x$ by $x - u$ and $y$ by $y - v$ as always. That gives one
  general statement, and the useful thing about it is that you never
  have to decide in advance which case you are in -- the denominators
  tell you.
]

#keybox(title: "The general axis-parallel ellipse")[
  For $r, s > 0$ the equation
  $ (x - u)^2 / r^2 + (y - v)^2 / s^2 = 1 $
  describes an ellipse with centre $(u, v)$.

  - If $r > s$: the major axis is *horizontal*, $a = r$, $b = s$, and
    the foci are $(u plus.minus c, v)$ with $c^2 = r^2 - s^2$.
  - If $r < s$: the major axis is *vertical*, $a = s$, $b = r$, and
    the foci are $(u, v plus.minus c)$ with $c^2 = s^2 - r^2$.
  - If $r = s$: a circle of radius $r$; the foci coincide with the
    centre.

  The larger denominator always sits under the variable along which
  the ellipse is longer, and the foci always lie on the major axis.
]

#example(title: "Reading off an ellipse")[
  Describe $9 x^2 - 18 x + 4 y^2 = 27$.

  Complete the square in $x$; there is no linear term in $y$:
  $
      9(x^2 - 2 x) + 4 y^2 & = 27 \
    9(x - 1)^2 - 9 + 4 y^2 & = 27 \
        9(x - 1)^2 + 4 y^2 & = 36 .
  $
  Dividing by $36$,
  $ (x - 1)^2 / 4 + y^2 / 9 = 1 . $
  Here $s^2 = 9 > 4 = r^2$, so the major axis is vertical: $a = 3$,
  $b = 2$, $c = sqrt(9 - 4) = sqrt(5)$. Hence
  $
    M = (1, 0), quad
    A_(1,2) = (1, plus.minus 3), quad
    B_(1,2) = (1 plus.minus 2, 0), quad
    F_(1,2) = (1, plus.minus sqrt(5)) ,
  $
  with $epsilon = sqrt(5) slash 3 approx 0.745$ and
  $p = 4 slash 3$.
]

== An Ellipse Is a Stretched Circle

#only-theory[
  There is a second way to see an ellipse, and it explains more than
  the equation does. Take the circle $x^2 + y^2 = a^2$ and squash the
  plane vertically by the factor $b slash a$:
  $ (x, y) |-> (x, b / a y) . $
  A point of the circle has $y = plus.minus sqrt(a^2 - x^2)$, so its
  image has $Y = (b slash a) y$, that is $y = (a slash b) Y$, and
  substituting into the circle gives
  $
    x^2 + a^2 / b^2 Y^2 = a^2
    quad ==> quad
    x^2 / a^2 + Y^2 / b^2 = 1 .
  $
  Every ellipse is a circle that has been stretched in one direction.
]

#only-theory[
  #xyplane(
    xmin: -6.6,
    xmax: 6.6,
    ymin: -6.0,
    ymax: 6.0,
    caption: [The circle of radius $a = 5$ squashed vertically by
      $b slash a = 4 slash 5$. Horizontal distances are untouched;
      vertical ones shrink by the same factor everywhere.],
    {
      cn-ellipse(5, 5, color: luma(150), dashed: true)
      cn-ellipse(5, 4)
      cp-segment((3.0, 4.0), (3.0, 3.2), color: expl-col)
      cp-segment((-3.0, 4.0), (-3.0, 3.2), color: expl-col)
      cp-segment((0.0, 5.0), (0.0, 4.0), color: expl-col)
      cn-vertex(0, 5, label: none, color: luma(120))
      cn-vertex(0, 4, label: none)
      cn-vertex(5, 0, label: none)
    },
  )
]

#theorem(title: "Area of an ellipse")[
  The region bounded by $x^2 / a^2 + y^2 / b^2 = 1$ has area
  $ A = pi a b . $
]

#proof[
  A vertical squash by the factor $b slash a$ multiplies every area by
  $b slash a$: it leaves widths alone and scales all heights equally.
  The disc of radius $a$ has area $pi a^2$, so its image has area
  $ pi a^2 dot b / a = pi a b . $
]

#remark[
  Exercise 8 asks for the same result by integrating
  $y = (b slash a) sqrt(a^2 - x^2)$, which is worth doing once. But
  compare the two arguments. The integral computes the answer; the
  squash *explains* it, and it explains at the same time why the
  formula collapses to $pi r^2$ when $a = b$, and why no amount of
  cleverness will produce an equally tidy formula for the
  circumference -- squashing does not scale lengths by a single
  factor, because it treats horizontal and vertical differently.
]

#remark[
  The perimeter of an ellipse genuinely has no closed form in terms of
  the functions of this course. It is given by an *elliptic integral*,
  which is where that family of functions gets its name. Numerical
  values are easy and exact formulas are impossible, which is an
  unusual and instructive combination. Ramanujan's approximation
  $
    U approx pi [ 3(a + b) - sqrt((3 a + b)(a + 3 b)) ]
  $
  is accurate to better than one part in $10^5$ for the eccentricities
  of every planetary orbit, and it collapses correctly to $2 pi r$
  when $a = b$.
]

== Ellipses in the World

#only-theory[
  In 1609 Kepler announced that the planets travel on ellipses with
  the Sun at *one focus* -- not at the centre. This was the end of two
  thousand years of circles, and it was forced on him by Tycho
  Brahe's measurements of Mars, whose orbit deviated from a circle by
  eight minutes of arc. The eccentricity of Mars's orbit is about
  $0.093$; Earth's is $0.0167$, which by
  $b slash a = sqrt(1 - epsilon^2)$ makes the Earth's orbit round to
  within $0.014%$. Textbook diagrams of the solar system are drawn
  with wildly exaggerated eccentricity, which is why so many people
  believe the seasons are caused by the Earth's distance from the Sun.

  The second application is the reflection property, the analogue of
  the parabola's: anything emitted from one focus arrives at the
  other. Sound does this in the whispering galleries of St Paul's
  Cathedral and the Mormon Tabernacle. Shock waves do it in a
  *lithotripter*, where the patient is positioned so that the kidney
  stone sits at the second focus of a half-ellipsoidal reflector and
  the shock source at the first -- the energy converges on the stone
  and on nothing else. As with the parabola, the proof waits for the
  tangents chapter.
]

// ── Exercises ────────────────────────────────────────────────

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Sketch the graph of $9 x^2 + 16 y^2 = 144$ and determine its foci.
][
  Dividing by $144$ gives $x^2 / 16 + y^2 / 9 = 1$, so $a = 4$,
  $b = 3$ and $c = sqrt(16 - 9) = sqrt(7)$. The foci are
  $F_(1,2) = (plus.minus sqrt(7), 0)$, on the major axis, which is
  horizontal because $16 > 9$. Leave $sqrt(7)$ exact.
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Find an equation of the ellipse with foci $(0, plus.minus 2)$ and
  vertices $(0, plus.minus 3)$.
][
  Both foci and both vertices are on the $y$-axis, so the major axis
  is vertical with $a = 3$ and $c = 2$. Then
  $b^2 = a^2 - c^2 = 9 - 4 = 5$, and the larger denominator belongs
  under $y$:
  $ x^2 / 5 + y^2 / 9 = 1 . $
]

#ex(difficulty: 2, time: "35 min", calculator: false)[
  Find the vertices, co-vertices and foci of each ellipse, and sketch
  its graph.
  #auto-parts(
    2,
    [$x^2 / 9 + y^2 / 5 = 1$],
    [$x^2 / 64 + y^2 / 100 = 1$],
    [$4 x^2 + y^2 = 16$],
    [$4 x^2 + 25 y^2 = 25$],
    [$9 x^2 - 18 x + 4 y^2 = 27$],
    [$x^2 + 2 y^2 - 6 x + 4 y + 7 = 0$],
  )
][
  In each case divide through to get $1$ on the right, then compare
  denominators to find the orientation.

  #auto-parts(
    1,
    [$a = 3$, $b = sqrt(5)$, $c = 2$: vertices $(plus.minus 3, 0)$,
      co-vertices $(0, plus.minus sqrt(5))$, foci
      $(plus.minus 2, 0)$.],
    [$a = 10$, $b = 8$, $c = 6$: vertices $(0, plus.minus 10)$,
      co-vertices $(plus.minus 8, 0)$, foci $(0, plus.minus 6)$.],
    [$x^2 / 4 + y^2 / 16 = 1$, so $a = 4$, $b = 2$,
      $c = 2 sqrt(3)$: vertices $(0, plus.minus 4)$, co-vertices
      $(plus.minus 2, 0)$, foci $(0, plus.minus 2 sqrt(3))$.],
    [$x^2 / (25 slash 4) + y^2 = 1$, so $a = 5 slash 2$, $b = 1$,
      $c = sqrt(21) slash 2$: vertices
      $(plus.minus 5 / 2, 0)$, co-vertices $(0, plus.minus 1)$, foci
      $(plus.minus sqrt(21) / 2, 0)$.],
    [$(x-1)^2 / 4 + y^2 / 9 = 1$, centre $(1, 0)$, $a = 3$, $b = 2$,
      $c = sqrt(5)$: vertices $(1, plus.minus 3)$, co-vertices
      $(1 plus.minus 2, 0)$, foci $(1, plus.minus sqrt(5))$.],
    [$(x-3)^2 / 4 + (y+1)^2 / 2 = 1$, centre $(3, -1)$, $a = 2$,
      $b = sqrt(2)$, $c = sqrt(2)$: vertices $(1, -1)$ and $(5, -1)$,
      co-vertices $(3, -1 plus.minus sqrt(2))$, foci
      $(3 plus.minus sqrt(2), -1)$.],
  )

  Part (f) is worth a second look: here $b = c = sqrt(2)$, which is
  perfectly possible and happens exactly when $epsilon = 1 slash
  sqrt(2)$. Equal values do not signal a mistake.
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  Find an equation for each ellipse, then its foci.
  #auto-parts(
    1,
    [Centre at the origin, vertices $(0, plus.minus 3)$, co-vertices
      $(plus.minus 2, 0)$.],
    [Centre $(2, 1)$, horizontal semi-axis $3$, vertical semi-axis
      $2$.],
  )
][
  #auto-parts(
    1,
    [The major axis is vertical, so $a = 3$ goes under $y$ and
      $b = 2$ under $x$:
      $
        x^2 / 4 + y^2 / 9 = 1, quad c = sqrt(5), quad
        F_(1,2) = (0, plus.minus sqrt(5)) .
      $],
    [$
        (x - 2)^2 / 9 + (y - 1)^2 / 4 = 1, quad c = sqrt(5), quad
        F_(1,2) = (2 plus.minus sqrt(5), 1) .
      $
      The foci sit on the horizontal line through the centre, because
      $9 > 4$.],
  )
]

#ex(difficulty: 2, time: "15 min", calculator: false, hints: (
  [What length is the string, in terms of $a$? And what is the pin
    separation, in terms of $c$?],
))[
  A gardener marks out an elliptical flower bed by driving two stakes
  $6$ m apart and looping a rope of total length $16$ m around them,
  then walking round with the rope taut.
  #auto-parts(
    1,
    [Find an equation of the ellipse, with the centre at the origin
      and the stakes on the $x$-axis.],
    [How wide is the bed at its narrowest?],
    [The gardener wants a rounder bed with the same length. Should the
      stakes be moved closer together or further apart, and by how
      much for $epsilon = 0.5$?],
  )
][
  #auto-parts(
    1,
    [The rope runs from one stake to the pencil to the other stake and
      back along the segment between the stakes, so its total length
      is $2a + 2c$. Hence $2a + 2c = 16$ and $2c = 6$, giving $c = 3$
      and $a = 5$. Then $b^2 = 25 - 9 = 16$ and
      $ x^2 / 25 + y^2 / 16 = 1 . $],
    [The narrowest width is the minor axis, $2b = 8$ m.],
    ["Same length" fixes $a = 5$. Then $epsilon = 0.5$ means
      $c = epsilon a = 2.5$, so the stakes go to $5$ m apart --
      $1$ m closer. (The rope must be shortened to
      $2a + 2c = 15$ m to match.)],
  )

  A word on part (a): the pins-and-loop version is the practical one,
  but its arithmetic differs from the textbook two-ends-pinned
  version, where the string length is $2a$ exactly. Read the
  construction before writing the equation.
]

#ex(difficulty: 2, time: "18 min", calculator: false, hints: (
  [Put the centre of the moon at a focus, and write down the distance
    from that focus to each vertex.],
))[
  The point of a lunar orbit nearest the surface of the Moon is the
  *perilune* and the farthest is the *apolune*. Apollo 11 was placed
  in an elliptical lunar orbit with perilune altitude $110$ km and
  apolune altitude $314$ km above the surface. Taking the radius of
  the Moon as $1728$ km and the centre of the Moon at one focus, find
  an equation of this ellipse and its eccentricity.
][
  Altitudes are measured from the surface, so the distances from the
  centre of the Moon are
  $
    r_"min" = 1728 + 110 = 1838, quad quad
    r_"max" = 1728 + 314 = 2042 .
  $
  The centre of the Moon is a focus, and the nearest and farthest
  points of an ellipse from a focus are the two vertices, at distances
  $a - c$ and $a + c$. Adding,
  $
    2 a = r_"min" + r_"max" = 3880
    quad ==> quad a = 1940,
  $
  and then $c = a - r_"min" = 1940 - 1838 = 102$. Hence
  $
    b^2 = 1940^2 - 102^2 = 3'763'600 - 10'404 = 3'753'196,
  $
  and with the centre of the *ellipse* at the origin,
  $ x^2 / 3'763'600 + y^2 / 3'753'196 = 1 . $
  The eccentricity is $epsilon = 102 slash 1940 approx 0.0526$, so
  $b slash a approx 0.9986$: to the eye, a circle whose centre is
  $102$ km off the centre of the Moon.
]

#ex(difficulty: 2, time: "15 min", calculator: true)[
  A lithotripter's reflector is half an ellipsoid whose cross-section
  is an ellipse with semi-axes $13$ cm and $12$ cm.
  #auto-parts(
    1,
    [How far from the centre must the shock source be placed?],
    [How far is the source from the kidney stone?],
    [The technician mistakenly positions the stone at the *centre* of
      the ellipse instead of at the second focus. Roughly what happens
      to the shock waves, and why is this the failure mode the design
      is meant to prevent?],
  )
][
  #auto-parts(
    1,
    [The source sits at a focus, at distance
      $c = sqrt(13^2 - 12^2) = sqrt(169 - 144) = 5$ cm from the
      centre.],
    [The stone sits at the other focus, so the two are
      $2c = 10$ cm apart.],
    [Waves leaving the first focus still reconverge at the *second*
      focus, wherever the stone happens to be. Placed at the centre,
      the stone receives only the small fraction of the energy that
      passes through on its way elsewhere, while the full focused
      intensity lands $5$ cm away on whatever tissue is there. The
      whole point of the design is that the energy is concentrated at
      exactly one point that is not the source; putting the target
      anywhere else wastes the treatment and delivers it somewhere
      unintended.],
  )
]

#ex(difficulty: 2, time: "18 min", calculator: false, hints: (
  [Set up the integral for the upper half and double it.],
))[
  Derive the area of the ellipse $x^2 / a^2 + y^2 / b^2 = 1$ by
  integration, and compare the argument with the squashing argument in
  the text.
  #auto-parts(
    1,
    [Solve for $y$ on the upper half, and write down a definite
      integral for the area of the whole region.],
    [Evaluate it, using the fact that
      $integral_(-a)^(a) sqrt(a^2 - x^2) dif x = pi a^2 slash 2$,
      which is the area of a semicircle of radius $a$.],
    [Which of the two arguments would still work if the region had
      been squashed by a factor $k$ in the $x$-direction *and* a
      factor $m$ in the $y$-direction? Which would need redoing?],
  )
][
  #auto-parts(
    1,
    [On the upper half $y = (b slash a) sqrt(a^2 - x^2)$, and by
      symmetry about the $x$-axis
      $ A = 2 integral_(-a)^(a) b / a sqrt(a^2 - x^2) dif x . $],
    [Pulling the constant out and using the given value,
      $
        A = (2 b) / a dot (pi a^2) / 2 = pi a b .
      $
      Note that the "integral" step is really a geometric fact in
      disguise -- which is the first hint that the integral is not
      doing the essential work here.],
    [The squashing argument works unchanged: the two scalings multiply
      areas by $k$ and by $m$, so the new area is $k m pi a b$, and
      nothing needs recomputing. The integral would have to be set up
      and evaluated again from the start. An argument that survives a
      change of hypotheses is usually the one that identified the
      reason.],
  )
]

#ex(difficulty: 3, time: "20 min", calculator: false, hints: (
  [Where does a vertical line through a focus meet the ellipse?],
  [For the last part, write $b^2$ in terms of $a$ and $epsilon$.],
))[
  #auto-parts(
    1,
    [Show that the focal chord of $x^2 / a^2 + y^2 / b^2 = 1$
      perpendicular to the major axis has length $2 b^2 slash a$, so
      that the semi-latus rectum is $p = b^2 slash a$ as claimed.],
    [Show that $b slash a = sqrt(1 - epsilon^2)$, and hence that two
      ellipses are similar exactly when they have the same
      eccentricity.],
    [Earth's orbit has $epsilon approx 0.0167$. By what percentage do
      its semi-axes differ? Comment on the diagrams of the solar
      system you have seen.],
  )
][
  #auto-parts(
    1,
    [Substituting $x = c$ into the equation,
      $
        y^2 / b^2 = 1 - c^2 / a^2 = (a^2 - c^2) / a^2 = b^2 / a^2,
      $
      so $y = plus.minus b^2 slash a$. The chord runs from
      $(c, -b^2 slash a)$ to $(c, b^2 slash a)$ and has length
      $2 b^2 slash a$; half of it is $p = b^2 slash a$.],
    [From $b^2 = a^2 - c^2$ and $c = epsilon a$,
      $
        b^2 = a^2 - epsilon^2 a^2 = a^2 (1 - epsilon^2)
        quad ==> quad b / a = sqrt(1 - epsilon^2) .
      $
      Two ellipses are similar exactly when the ratio $b slash a$
      agrees, and by this identity that happens exactly when
      $epsilon$ agrees. (Contrast the parabola, which has no such
      number, and where *all* members of the family are similar.)],
    [$b slash a = sqrt(1 - 0.0167^2) approx 0.99986$, a difference of
      about $0.014%$ -- some $14$ parts in $100'000$. Drawn to scale
      on this page the Earth's orbit would be indistinguishable from a
      circle, and the Sun would sit visibly off-centre rather than the
      orbit being visibly oval. Diagrams that show a strongly oval
      orbit exaggerate $epsilon$ by a factor of twenty or more, which
      is the source of the widespread belief that the seasons are
      caused by the Earth's varying distance from the Sun. (They are
      caused by the tilt of its axis; the Earth is in fact closest to
      the Sun in early January.)],
  )
]

#ex(difficulty: 3, time: "20 min", calculator: false, hints: (
  [Use the triangle inequality on the triangle $F_1 P F_2$ -- but
    remember it may be degenerate.],
))[
  The definition of an ellipse requires $2a > overline(F_1 F_2)$.
  #auto-parts(
    1,
    [Prove that no point $P$ satisfies
      $overline(P F_1) + overline(P F_2) = 2a$ when
      $2a < overline(F_1 F_2)$.],
    [Describe the locus exactly when $2a = overline(F_1 F_2)$.],
    [In the derivation, where would the argument break down if
      $a = c$? Identify the specific step.],
  )
][
  #auto-parts(
    1,
    [For any point $P$ the triangle inequality gives
      $overline(P F_1) + overline(P F_2) >= overline(F_1 F_2)$. If
      $2a < overline(F_1 F_2)$ the required sum is smaller than a
      quantity the sum can never go below, so no such $P$ exists and
      the locus is empty.],
    [Equality in the triangle inequality holds exactly when $P$ lies
      *on* the segment $F_1 F_2$. So the locus is that closed segment
      -- a degenerate ellipse, flattened until the minor axis has
      length zero.],
    [At the very last step. With $a = c$ we get
      $b^2 = a^2 - c^2 = 0$, and the equation
      $b^2 x^2 + a^2 y^2 = a^2 b^2$ becomes $a^2 y^2 = 0$, i.e.
      $y = 0$ -- the whole $x$-axis, not the segment. The division by
      $a^2 b^2$ that produces the standard form is division by zero,
      and the squaring steps before it, no longer reversible in the
      degenerate case, have quietly added the rest of the axis. This
      is why $a > c$ is stated as part of the definition rather than
      discovered afterwards.],
  )
]

#ai-box(role: "Explainer")[
  Ask an AI assistant to explain why the seasons happen, and then ask
  it specifically whether the Earth is closer to the Sun in summer.

  + Before asking, write down what you expect it to say.
  + The eccentricity of Earth's orbit is $0.0167$. Ask the assistant
    for the ratio $b slash a$ and for the percentage difference
    between the semi-axes; check its arithmetic against Exercise 10.
  + Then ask it to describe a diagram of Earth's orbit that would be
    *correctly* drawn to scale. Does its description match the
    diagrams in the textbooks you have used? What does that tell you
    about where the misconception comes from -- the explanation, or
    the picture?
]

#print-vocab()
