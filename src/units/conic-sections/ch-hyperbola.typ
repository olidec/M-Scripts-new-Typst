#import "../../common/preamble.typ": *
#import "../../common/cplane.typ": *
#import "../../common/conic-figures.typ": *
#show: chapter-template.with(title: "Hyperbola")
#let ex = exercise.with(chapter: "Hyperbola")

// ── NOTE ON THE OLD DEFINITION ───────────────────────────────
// The LaTeX source defined the hyperbola by
//     PF1 - PF2 = 2a
// with no absolute value. That locus is ONE branch, while every
// figure and every later statement in those notes assumed two.
// Corrected here to |PF1 - PF2| = 2a, matching the booklet, and
// the sign is then used pedagogically rather than swept up: the
// derivation shows that the + sign selects the right branch and
// the - sign the left, which is exactly why the absolute value
// belongs in the definition.
//
// ── NOTE ON THE DERIVATION ───────────────────────────────────
// The old notes made this Exercise 10, "show, analogously to the
// ellipse". It is done in the text here instead, briskly, because
// the second time through the same algebra is where the pattern
// becomes visible rather than where practice is needed -- and
// because the sign discussion has nowhere to live if the whole
// derivation is deferred. Exercise 1 asks students to redo the two
// squaring steps unaided, which is the part actually worth
// practising.
//
// ── FIGURE NOTE ──────────────────────────────────────────────
// All the main figures use a = 4, b = 3, c = 5, and the point
// P = (5, 9/4) with focal radii 41/4 and 9/4 differing by 8 = 2a.
//
// This chapter is the one that needed the cp-line clipping fix in
// cplane.typ. In a 9.5-by-6.5 box an asymptote of slope 3/4 leaves
// through the TOP, not through the corner, and the old clamp drew
// it with slope 0.684 instead of 0.75 -- visibly wrong against the
// asymptote rectangle sitting right next to it.

= The Hyperbola

#only-theory[
  The ellipse came from a constant *sum* of distances to two points.
  Ask instead for a constant *difference* and you get the third conic
  -- and almost everything changes. The curve is unbounded, it comes
  in two pieces, and it acquires something neither of the others has:
  a pair of straight lines it approaches forever without ever
  reaching.

  You have already met one hyperbola without being told. The graph of
  $y = 1 slash x$ is one, tilted at $45 degree$, and by the end of
  this chapter you will be able to say where its foci are.
]

#look-back(title: "The same machine", recalls: [the ellipse chapter])[
  The derivation is the ellipse derivation with one sign changed.
  Isolate a root, square, watch almost everything cancel, isolate the
  remaining root, square again. If you found that grind hard the first
  time, this is the chance to see that it was a method and not a
  trick.

  Everything in the anatomy has a counterpart too, with one systematic
  swap: $b^2 = a^2 - c^2$ becomes $b^2 = c^2 - a^2$, because now
  $c > a$ instead of $a > c$.
]

#objectives(
  [define a hyperbola as the locus of points whose distances to two
    foci have a constant absolute difference $2a$],
  [derive the equation $x^2 / a^2 - y^2 / b^2 = 1$ and the relation
    $c^2 = a^2 + b^2$, and explain which branch each sign produces],
  [find the asymptotes of a hyperbola, and prove that the curve
    approaches them],
  [sketch a hyperbola using its asymptote rectangle],
  [decide the orientation of a hyperbola from the *signs* of its
    terms, not from the sizes of its denominators],
  [recognize a rectangular hyperbola, and identify $x y = k$ as one
    rotated through $45 degree$],
  [use hyperbolas in navigation problems of LORAN type],
)

== The Locus Definition

#definition(title: "Hyperbola")[
  Let $F_1$ and $F_2$ be two points and let
  $0 < 2a < overline(F_1 F_2)$. The
  #vocab("hyperbola", "Hyperbel") with foci $F_1$, $F_2$ is the set of
  all points $P$ for which
  $ abs(overline(P F_1) - overline(P F_2)) = 2 a . $
]

#warning[
  The absolute value is not optional. Dropping it, and asking only for
  $overline(P F_1) - overline(P F_2) = 2a$, gives a perfectly good
  curve -- but only *one branch*, the one nearer $F_2$. The
  two-branch curve, which is what the equation
  $x^2 / a^2 - y^2 / b^2 = 1$ describes and what a plane actually cuts
  from a double cone, needs both signs.
]

#only-theory[
  The condition $2a < overline(F_1 F_2)$ is the mirror image of the
  ellipse's. By the triangle inequality the *difference* of two sides
  of a triangle is always less than the third, so
  $abs(overline(P F_1) - overline(P F_2)) < overline(F_1 F_2)$ for any
  $P$ off the line $F_1 F_2$. Demanding more than the separation of
  the foci would give nothing; demanding exactly it gives the two rays
  of the line $F_1 F_2$ outside the segment. So this time it is
  $a < c$ that is forced, where $2c = overline(F_1 F_2)$ as before.
]

#exploration(title: "Folding a hyperbola")[
  On a sheet of tracing paper or greaseproof paper, draw a circle of
  moderate size, somewhat off centre. Mark a second point $G$
  *outside* the circle. Fold points of the circle's circumference onto
  $G$ and crease, a dozen times or more.

  + Both branches of a hyperbola appear. Where are its foci?
  + Compare with the ellipse construction of the previous chapter,
    which was identical except that $G$ was *inside* the circle. What
    single feature of the picture decides which conic you get?
  + What happens as $G$ moves onto the circle itself?
  + What are the creases? (Same answer as the last two chapters, and
    the tangents chapter will finally prove it.)
]

== Deriving the Equation

#only-theory[
  Place the foci as before at $F_1 = (-c, 0)$ and $F_2 = (c, 0)$, and
  take the $+$ sign in the definition:
  $
    sqrt((x + c)^2 + y^2) - sqrt((x - c)^2 + y^2) = 2 a .
  $
  Isolate one root and square:
  $
    (x + c)^2 + y^2 & = 4 a^2 + 4 a sqrt((x - c)^2 + y^2) + (x - c)^2 + y^2 \
    4 c x - 4 a^2 & = 4 a sqrt((x - c)^2 + y^2) \
    c x - a^2 & = a sqrt((x - c)^2 + y^2) .
  $
  Pause here, because this line says something the ellipse's
  counterpart did not. The right-hand side is non-negative, so
  $c x >= a^2$, that is $x >= a^2 slash c > 0$: with the $+$ sign
  every solution lies to the right of the $y$-axis. The $+$ sign
  produces the right branch, and by symmetry the $-$ sign produces the
  left one. Squaring again,
  $
    c^2 x^2 - 2 a^2 c x + a^4 & = a^2 (x^2 - 2 c x + c^2 + y^2) \
    c^2 x^2 + a^4 & = a^2 x^2 + a^2 c^2 + a^2 y^2 \
    (c^2 - a^2) x^2 - a^2 y^2 & = a^2 (c^2 - a^2) ,
  $
  and $c^2 - a^2 > 0$ because $c > a$.
]

#keybox(title: "Equation of the hyperbola")[
  Set $b^2 = c^2 - a^2$, that is
  $ c^2 = a^2 + b^2 . $
  Then $b^2 x^2 - a^2 y^2 = a^2 b^2$, and dividing by $a^2 b^2$,
  $ x^2 / a^2 - y^2 / b^2 = 1 . $
  The squaring steps discarded the distinction between the two signs,
  so this single equation describes *both* branches.
]

#only-theory[
  #xyplane(
    xmin: -9.5,
    xmax: 9.5,
    ymin: -6.5,
    ymax: 6.5,
    length: 0.62cm,
    caption: [The hyperbola $x^2 / 16 - y^2 / 9 = 1$, with $a = 4$,
      $b = 3$, $c = 5$. Here $overline(P F_1) = 41 slash 4$ and
      $overline(P F_2) = 9 slash 4$, differing by $8 = 2a$.],
    {
      cn-asymptotes(4, 3, xmin: -9.5, xmax: 9.5, ymin: -6.5, ymax: 6.5)
      cn-hyperbola(4, 3, extent: 6.0)
      cp-segment((5.0, 2.25), (-5.0, 0.0), color: def-col)
      cp-segment((5.0, 2.25), (5.0, 0.0), color: def-col)
      cn-focus(-5, 0, label: $F_1$, anchor: "north-east")
      cn-focus(5, 0, label: $F_2$, anchor: "north-west")
      cn-vertex(4, 0, label: none)
      cn-vertex(-4, 0, label: none)
      cp-point(5.0, 2.25, label: $P$, anchor: "south-west", color: def-col)
    },
  )
]

#remark[
  Setting $y = 0$ gives $x = plus.minus a$: the
  #vocab("vertices", "Scheitel") are $(plus.minus a, 0)$, the two
  points where the branches turn. Setting $x = 0$ gives
  $-y^2 slash b^2 = 1$, which has no real solution -- a hyperbola in
  this position never crosses the $y$-axis. That is not a defect of
  the equation; it is the statement that the two branches are
  separated by a gap, and $b$ is a length that measures something
  other than a point of the curve. What it measures is the subject of
  the next section.
]

#only-theory[
  The remaining vocabulary transfers unchanged. The
  #vocab("linear eccentricity", "lineare Exzentrizität") is $c$, the
  distance from the centre to a focus. The
  #vocab("numerical eccentricity", "numerische Exzentrizität") is
  $epsilon = c slash a$, and since $c > a$ it now satisfies
  $epsilon > 1$ -- the ellipse had $epsilon < 1$ and the parabola, as
  the eccentricity chapter will show, has $epsilon = 1$ exactly. The
  semi-latus rectum is again
  $ p = b^2 / a, $
  obtained the same way: substitute $x = c$ and simplify. The same
  letter, the same formula, the third conic in a row.
]

== Asymptotes

#only-theory[
  Solve the equation for $y$ on the right-hand branch:
  $
    y = plus.minus b / a sqrt(x^2 - a^2), quad quad x >= a .
  $
  For large $x$ the $a^2$ matters less and less, and the curve should
  look like $y = plus.minus (b slash a) x$. That is a plausible story
  rather than a proof, and the proof is three lines of the conjugate
  trick you have used since year 1. Take the upper half and measure
  the vertical gap between line and curve:
  $
    d(x) & = b / a x - b / a sqrt(x^2 - a^2)
    = b / a (x - sqrt(x^2 - a^2)) \
    & = b / a dot (x^2 - (x^2 - a^2)) / (x + sqrt(x^2 - a^2))
    = (a b) / (x + sqrt(x^2 - a^2)) .
  $
  The numerator is a constant and the denominator grows without
  bound, so $d(x) -> 0$ as $x -> infinity$. And $d(x) > 0$ throughout,
  so the curve stays strictly below the line while closing in on it:
  it approaches from the inside and never touches.
]

#definition(title: "Asymptote")[
  A line is an #vocab("asymptote", "Asymptote") of a curve if the
  distance between them tends to zero as the curve runs to infinity.
  The hyperbola $x^2 / a^2 - y^2 / b^2 = 1$ has the two asymptotes
  $ y = plus.minus b / a x . $
]

#keybox(title: "Finding asymptotes: replace 1 by 0")[
  Whatever the orientation and wherever the centre, the asymptotes are
  found by putting $0$ on the right-hand side and factoring:
  $
    (x - u)^2 / a^2 - (y - v)^2 / b^2 = 0
    quad ==> quad
    (y - v) = plus.minus b / a (x - u) .
  $
  This rule never needs adapting -- not for the vertical orientation,
  not after a translation -- because it is the same equation with the
  constant removed.
]

#only-theory[
  Geometrically the asymptotes are the diagonals of a rectangle, and
  that rectangle is the fastest way to draw a hyperbola by hand.
  Centre it at $M$, and give it half-width $a$ along the axis carrying
  the vertices and half-height $b$ along the other. Its corners are
  $(plus.minus a, plus.minus b)$; extending the diagonals gives the
  asymptotes, and the vertices sit at the midpoints of two of its
  sides. One further gift: the half-diagonal of the rectangle is
  $sqrt(a^2 + b^2) = c$, so the circle centred at $M$ through the four
  corners passes through both foci.
]

#only-theory[
  #xyplane(
    xmin: -9.5,
    xmax: 9.5,
    ymin: -6.5,
    ymax: 6.5,
    length: 0.62cm,
    caption: [The asymptote rectangle. Its diagonals are the
      asymptotes, its half-diagonal is $c$, and the circle through its
      corners meets the axis at the foci. Draw the rectangle first and
      the hyperbola almost draws itself.],
    {
      cn-asymptotes(4, 3, xmin: -9.5, xmax: 9.5, ymin: -6.5, ymax: 6.5)
      cp-segment((-4.0, -3.0), (4.0, -3.0), color: expl-col)
      cp-segment((4.0, -3.0), (4.0, 3.0), color: expl-col)
      cp-segment((4.0, 3.0), (-4.0, 3.0), color: expl-col)
      cp-segment((-4.0, 3.0), (-4.0, -3.0), color: expl-col)
      cn-ellipse(5, 5, color: luma(165), dashed: true)
      cn-hyperbola(4, 3, extent: 6.0)
      cp-segment((0.0, 0.0), (4.0, 3.0), color: def-col)
      cn-center(0, 0, label: $M$, anchor: "north-east")
      cn-focus(-5, 0, label: none)
      cn-focus(5, 0, label: none)
      cn-vertex(4, 0, label: none)
      cn-vertex(-4, 0, label: none)
      cp-label(2.0, 1.9, $c$, color: def-col)
      cp-label(4.55, -1.5, $b$, color: expl-col)
      cp-label(2.0, -3.45, $a$, color: expl-col)
    },
  )
]

== Orientation and Position

#only-theory[
  Swapping $x$ and $y$ turns the equation into
  $y^2 / a^2 - x^2 / b^2 = 1$, a hyperbola opening upward and
  downward, and translating the centre to $(u, v)$ works exactly as
  always.
]

#keybox(title: "The general axis-parallel hyperbola")[
  With centre $(u, v)$ and $a, b > 0$:

  #table(
    columns: 4,
    stroke: none,
    align: left,
    [*Equation*], [*Opens*], [*Vertices*], [*Foci*],
    [$(x-u)^2 / a^2 - (y-v)^2 / b^2 = 1$],
    [left/right],
    [$(u plus.minus a, v)$],
    [$(u plus.minus c, v)$],

    [$(y-v)^2 / a^2 - (x-u)^2 / b^2 = 1$],
    [up/down],
    [$(u, v plus.minus a)$],
    [$(u, v plus.minus c)$],
  )

  In both rows $c^2 = a^2 + b^2$, and $a$ is always the denominator of
  the *positive* term.
]

#warning[
  For an ellipse you compare the two denominators and the larger one
  wins. *That rule is wrong for a hyperbola.* Here the orientation is
  decided entirely by which term carries the $+$ sign, and the
  denominators may be in any size relation whatever. In
  $y^2 / 16 - x^2 / 36 = 1$ the larger denominator is under $x$, and
  the hyperbola nonetheless opens up and down, with $a = 4$ and
  $b = 6$ -- one of the few conics where the conjugate axis is longer
  than the transverse one.

  Sizes for ellipses, signs for hyperbolas.
]

#example(title: "Reading off a hyperbola")[
  Describe $2 y^2 - 3 x^2 - 4 y + 12 x + 8 = 0$.

  Group and complete both squares, keeping the coefficients outside:
  $
    2(y^2 - 2 y) - 3(x^2 - 4 x) + 8 & = 0 \
    2(y - 1)^2 - 2 - 3(x - 2)^2 + 12 + 8 & = 0 \
    2(y - 1)^2 - 3(x - 2)^2 & = -18 .
  $
  The right-hand side is negative, so multiply through by $-1$ to put
  the $+$ on the correct term, then divide by $18$:
  $
    3(x - 2)^2 - 2(y - 1)^2 = 18
    quad ==> quad
    (x - 2)^2 / 6 - (y - 1)^2 / 9 = 1 .
  $
  Now $a^2 = 6$ and $b^2 = 9$, so $a = sqrt(6)$, $b = 3$ and
  $c = sqrt(6 + 9) = sqrt(15)$. Hence
  $
    M = (2, 1), quad
    V_(1,2) = (2 plus.minus sqrt(6), 1), quad
    F_(1,2) = (2 plus.minus sqrt(15), 1) ,
  $
  and the asymptotes, by the replace-1-by-0 rule,
  $ y - 1 = plus.minus 3 / sqrt(6) (x - 2)
    = plus.minus sqrt(6) / 2 (x - 2) . $
  Note that $b > a$ here and the hyperbola still opens sideways: the
  sign decided it, not the size.
]

== Rectangular Hyperbolas and $x y = k$

#only-theory[
  A hyperbola with $a = b$ is called
  #vocab("rectangular", "gleichseitig"), because its asymptote
  rectangle is a square and its asymptotes therefore meet at a right
  angle. Its equation reduces to $x^2 - y^2 = a^2$, and its
  eccentricity is $c slash a = sqrt(2 a^2) slash a = sqrt(2)$ for
  every such curve -- one number for the whole family, exactly as
  $epsilon = 1$ describes every parabola.
]

#only-theory[
  Now rotate that curve through $45 degree$. Writing the old
  coordinates in terms of the new ones as
  $x = (X + Y) slash sqrt(2)$ and $y = (Y - X) slash sqrt(2)$,
  $
    x^2 - y^2 = (X + Y)^2 / 2 - (Y - X)^2 / 2 = (4 X Y) / 2 = 2 X Y ,
  $
  so $x^2 - y^2 = a^2$ becomes
  $ X Y = a^2 / 2 . $
  The reciprocal graphs of year 1 were hyperbolas all along. For
  $y = 1 slash x$ we get $a^2 slash 2 = 1$, so $a = sqrt(2)$ and
  $c = sqrt(2) a = 2$: the vertices are $(1, 1)$ and $(-1, -1)$, the
  foci are $(sqrt(2), sqrt(2))$ and $(-sqrt(2), -sqrt(2))$, and the
  asymptotes are the coordinate axes themselves.
]

#only-theory[
  #xyplane(
    xmin: -5.0,
    xmax: 5.0,
    ymin: -5.0,
    ymax: 5.0,
    length: 0.62cm,
    caption: [$y = 1 slash x$ is a rectangular hyperbola with
      $a = sqrt(2)$, rotated through $45 degree$. Its asymptotes are
      the coordinate axes.],
    {
      cp-curve(t => t, t => 1 / t, domain: (0.2, 5.0), samples: 140)
      cp-curve(t => t, t => 1 / t, domain: (-5.0, -0.2), samples: 140)
      cp-line(
        through: (0, 0),
        direction: (1, 1),
        xmin: -5.0,
        xmax: 5.0,
        ymin: -5.0,
        ymax: 5.0,
        color: luma(150),
        dashed: true,
      )
      cn-vertex(1, 1, label: none)
      cn-vertex(-1, -1, label: none)
      cn-focus(1.41421, 1.41421, label: $F_2$, anchor: "north-west")
      cn-focus(-1.41421, -1.41421, label: $F_1$, anchor: "south-east")
    },
  )
]

== Hyperbolas in the World

#only-theory[
  The defining property is a *difference* of distances, and a
  difference of distances is what you measure when you compare arrival
  times of a signal travelling at a known speed. That is the whole
  idea behind hyperbolic navigation. In the LORAN system, developed
  during the Second World War and in service into the 2010s, two
  ground stations transmit simultaneously; a ship measures the delay
  between the two arrivals, converts it to a difference of distances,
  and thereby knows it lies on one branch of one hyperbola with the
  stations as foci. A second pair of stations gives a second
  hyperbola, and the intersection is the ship. GPS does something
  closely related with satellites and clocks.

  Hyperbolas also arise wherever a quantity is inversely proportional
  to another -- Boyle's law $p V = "const"$, the lens equation,
  supply-and-demand curves -- all of them $x y = k$ and so, as the
  previous section showed, rectangular hyperbolas. And the cooling
  towers of power stations are hyperboloids: a shape made entirely of
  straight lines, hence cheap to build from straight scaffolding,
  while giving the chimney profile the airflow requires.
]

// ── Exercises ────────────────────────────────────────────────

#ex(difficulty: 2, time: "20 min", calculator: false, hints: (
  [Isolate the root that appears with a minus sign in front of it
    first, so that squaring produces a $+$ cross-term.],
))[
  Redo the derivation of the previous section without looking at it,
  starting from
  $ sqrt((x + c)^2 + y^2) - sqrt((x - c)^2 + y^2) = 2 a $
  and reaching $x^2 / a^2 - y^2 / b^2 = 1$. Then answer:
  #auto-parts(
    1,
    [At which line does the argument use $c > a$?],
    [At which line does the argument reveal that this sign gives only
      the right branch, and how?],
  )
][
  The two squarings are as in the text.
  #auto-parts(
    1,
    [At the very last step, where $b^2 = c^2 - a^2$ is named. That
      definition requires $c^2 - a^2 > 0$; without $c > a$ there is no
      real $b$ and the division that produces the standard form is
      illegitimate.],
    [At the intermediate line $c x - a^2 = a sqrt((x-c)^2 + y^2)$. The
      right-hand side is a distance and so is non-negative, forcing
      $c x >= a^2$ and hence $x >= a^2 slash c > 0$. Every solution
      lies to the right of the $y$-axis, which is the right branch.
      The final squaring destroys this information, which is why the
      standard equation describes both branches and the definition
      needs the absolute value.],
  )
]

#ex(difficulty: 1, time: "10 min", calculator: false)[
  Find the foci and asymptotes of $9 x^2 - 16 y^2 = 144$ and sketch
  its graph.
][
  Dividing by $144$ gives $x^2 / 16 - y^2 / 9 = 1$, so $a = 4$,
  $b = 3$ and $c = sqrt(16 + 9) = 5$. Hence
  $ F_(1,2) = (plus.minus 5, 0), quad quad
    y = plus.minus 3 / 4 x . $
  To sketch: draw the rectangle with corners $(plus.minus 4,
  plus.minus 3)$, extend its diagonals, mark the vertices at
  $(plus.minus 4, 0)$ and draw each branch from its vertex out towards
  the diagonals.
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  Find the equation and the foci of the hyperbola with vertices
  $(0, plus.minus 1)$ and asymptote $y = 2 x$.
][
  The vertices are on the $y$-axis, so the curve opens up and down and
  $a = 1$ with the equation $y^2 / 1 - x^2 / b^2 = 1$. Its asymptotes
  are $y = plus.minus (a slash b) x$, so $a slash b = 2$ gives
  $b = 1 slash 2$. Then
  $ y^2 - 4 x^2 = 1, quad quad
    c = sqrt(1 + 1 / 4) = sqrt(5) / 2, quad quad
    F_(1,2) = (0, plus.minus sqrt(5) / 2) . $
  Note the slope is $a slash b$ and not $b slash a$ in this
  orientation -- or, avoiding the issue entirely, set the right-hand
  side to $0$: $y^2 - x^2 slash b^2 = 0$ gives $y = plus.minus x
  slash b$, and matching $1 slash b = 2$ gives the same $b$.
]

#ex(difficulty: 2, time: "40 min", calculator: false)[
  Find the vertices, foci and asymptotes of each hyperbola, and sketch
  its graph using the asymptote rectangle.
  #auto-parts(
    2,
    [$x^2 / 144 - y^2 / 25 = 1$],
    [$y^2 / 16 - x^2 / 36 = 1$],
    [$y^2 - x^2 = 4$],
    [$9 x^2 - 4 y^2 = 36$],
    [$16 x^2 - 9 y^2 + 64 x - 90 y = 305$],
    [$2 y^2 - 3 x^2 - 4 y + 12 x + 8 = 0$ #h(0.3em) (worked in the
      text -- do it again from scratch and compare)],
  )
][
  #auto-parts(
    1,
    [$a = 12$, $b = 5$, $c = 13$: vertices $(plus.minus 12, 0)$, foci
      $(plus.minus 13, 0)$, asymptotes
      $y = plus.minus 5 / 12 x$.],
    [$a = 4$, $b = 6$, $c = 2 sqrt(13)$: vertices
      $(0, plus.minus 4)$, foci $(0, plus.minus 2 sqrt(13))$,
      asymptotes $y = plus.minus 2 / 3 x$. Opens vertically even
      though $36 > 16$.],
    [$y^2 / 4 - x^2 / 4 = 1$, so $a = b = 2$ and $c = 2 sqrt(2)$:
      vertices $(0, plus.minus 2)$, foci $(0, plus.minus 2 sqrt(2))$,
      asymptotes $y = plus.minus x$. This one is rectangular.],
    [$x^2 / 4 - y^2 / 9 = 1$, so $a = 2$, $b = 3$, $c = sqrt(13)$:
      vertices $(plus.minus 2, 0)$, foci
      $(plus.minus sqrt(13), 0)$, asymptotes
      $y = plus.minus 3 / 2 x$.],
    [$(x + 2)^2 / 9 - (y + 5)^2 / 16 = 1$, centre $(-2, -5)$,
      $a = 3$, $b = 4$, $c = 5$: vertices $(1, -5)$ and $(-5, -5)$,
      foci $(3, -5)$ and $(-7, -5)$, asymptotes
      $y + 5 = plus.minus 4 / 3 (x + 2)$.],
    [$(x - 2)^2 / 6 - (y - 1)^2 / 9 = 1$, centre $(2, 1)$,
      $a = sqrt(6)$, $b = 3$, $c = sqrt(15)$: vertices
      $(2 plus.minus sqrt(6), 1)$, foci
      $(2 plus.minus sqrt(15), 1)$, asymptotes
      $y - 1 = plus.minus sqrt(6) / 2 (x - 2)$.],
  )
]

#ex(difficulty: 2, time: "18 min", calculator: false, hints: (
  [Where do $x y = k$ and the line $y = x$ meet?],
))[
  #auto-parts(
    1,
    [Show that every curve $x y = k$ with $k > 0$ is a rectangular
      hyperbola, and find its $a$ in terms of $k$.],
    [Find the vertices and foci of $x y = 6$.],
    [What changes when $k < 0$?],
  )
][
  #auto-parts(
    1,
    [By the computation in the text, $x^2 - y^2 = a^2$ becomes
      $X Y = a^2 slash 2$ under a rotation through $45 degree$. So
      $x y = k$ is the rotated image of $x^2 - y^2 = 2 k$, a
      rectangular hyperbola with
      $ a = sqrt(2 k) . $
      Rotation changes neither lengths nor the property $a = b$, so
      the rotated curve is rectangular too.],
    [Here $k = 6$, so $a = sqrt(12) = 2 sqrt(3)$ and
      $c = sqrt(2) a = 2 sqrt(6)$. The transverse axis is the line
      $y = x$; intersecting it with $x y = 6$ gives $x^2 = 6$, so the
      vertices are
      $ V_(1,2) = (plus.minus sqrt(6), plus.minus sqrt(6)) $
      (both coordinates taking the same sign), at distance
      $sqrt(12) = a$ from the origin. #sym.checkmark The foci lie on
      the same line at distance $c = 2 sqrt(6)$, namely
      $(plus.minus 2 sqrt(3), plus.minus 2 sqrt(3))$.],
    [The branches move to the second and fourth quadrants: the curve
      is the reflection in either axis, equivalently the rotation of
      $x^2 - y^2 = 2 abs(k)$ through $-45 degree$. Everything else --
      $a$, $c$, rectangularity, $epsilon = sqrt(2)$ -- is unchanged
      with $abs(k)$ in place of $k$.],
  )
]

#ex(difficulty: 3, time: "30 min", calculator: true, hints: (
  [Convert the time difference into a distance difference first. That
    distance difference is $2a$, by the definition of the curve.],
  [Work in miles throughout, and keep $a$ as an exact fraction until
    the very end.],
))[
  In the LORAN navigation system two radio stations at $A$ and $B$
  transmit simultaneous signals to a ship at $P$. The on-board
  computer converts the difference in arrival times into a distance
  difference $abs(overline(P A) - overline(P B))$, which by the
  definition of a hyperbola places the ship on one branch of a
  hyperbola with foci $A$ and $B$.

  Station $B$ is $400$ mi due east of station $A$ on a coastline. A
  ship receives the signal from $B$ exactly $1200$ microseconds before
  the signal from $A$. Radio signals travel at $980$ ft per
  microsecond, and $1$ mi $= 5280$ ft.
  #auto-parts(
    1,
    [Find an equation of the hyperbola on which the ship lies, taking
      the origin midway between the stations and the $x$-axis along
      the coastline.],
    [The ship is due north of $B$. How far off the coastline is it?],
    [Which branch is the ship on, and how did the sign of the time
      difference tell you?],
  )
][
  #auto-parts(
    1,
    [The extra distance travelled by $A$'s signal is
      $980 dot 1200 = 1'176'000$ ft, which is the distance difference
      and therefore equals $2a$. In miles,
      $ 2 a = (1'176'000) / 5280 " mi"
        quad ==> quad
        a = 588'000 / 5280 = 1225 / 11 " mi" . $
      The stations are the foci, so $2c = 400$ and $c = 200$. Then
      $
        a^2 = 1'500'625 / 121,
        quad quad
        b^2 = c^2 - a^2 = 40'000 - 1'500'625 / 121
        = 3'339'375 / 121 ,
      $
      giving
      $ (121 x^2) / 1'500'625 - (121 y^2) / 3'339'375 = 1 . $],
    [Due north of $B$ means $x = c = 200$. Then
      $
        y^2 = b^2 (c^2 / a^2 - 1) = b^2 dot b^2 / a^2
        quad ==> quad
        y = b^2 / a = 133'575 / 539 approx 248 " mi" .
      $
      (The middle step is the semi-latus rectum again: a point of a
      hyperbola directly "above" a focus is at height $p = b^2 slash
      a$. Recognising it saves the whole computation.)],
    [The signal from $B$ arrived *first*, so the ship is nearer to $B$
      than to $A$: $overline(P A) - overline(P B) = +2a > 0$. By the
      analysis in the derivation, the positive sign selects the branch
      nearer $B$ -- the eastern branch, the one that opens towards
      $B$. Had the ship been nearer $A$ the same equation would still
      hold, but the ship would be on the other branch and the answer
      to part (b) would be a different point.],
  )
]

#ex(difficulty: 2, time: "20 min", calculator: true, hints: (
  [Put the origin at the centre of the hyperbola, which is at the
    height of the narrowest point.],
))[
  The cross-section of a power-station cooling tower is a hyperbola
  opening left and right, with the narrowest point of the tower -- the
  *throat* -- at the centre of the hyperbola. A tower has a throat
  diameter of $60$ m, and at $80$ m below the throat its diameter is
  $100$ m.
  #auto-parts(
    1,
    [Find an equation of the cross-section.],
    [The tower rises $40$ m above the throat. Find the diameter of its
      rim, to the nearest tenth of a metre.],
    [Why are these towers built as hyperboloids rather than as
      cylinders or cones? Give the geometric reason, not the
      engineering one.],
  )
][
  #auto-parts(
    1,
    [Take the centre at the origin, so $a$ is the throat radius:
      $a = 30$. The point $(50, -80)$ lies on the curve, so
      $
        50^2 / 30^2 - 80^2 / b^2 = 1
        quad ==> quad
        6400 / b^2 = 2500 / 900 - 1 = 1600 / 900 ,
      $
      hence $b^2 = 6400 dot 900 slash 1600 = 3600$ and $b = 60$:
      $ x^2 / 900 - y^2 / 3600 = 1 . $],
    [At $y = 40$,
      $
        x^2 = 900 (1 + 1600 / 3600) = 900 dot 13 / 9 = 1300,
      $
      so $x = 10 sqrt(13)$ and the diameter is
      $20 sqrt(13) approx 72.1$ m.],
    [A hyperboloid of one sheet is a *ruled* surface: it is swept out
      by a family of straight lines, even though every cross-section
      through the axis is a curve. So the whole shell can be built
      from straight members. A cone is ruled too but has no throat; a
      cylinder is ruled but has no variation in width. The
      hyperboloid is the only one of the three that combines straight
      construction with a narrowing waist.],
  )
]

#ex(difficulty: 3, time: "20 min", calculator: false, hints: (
  [For the first part, write down the vertical gap between the line
    and the curve and rationalise the numerator.],
))[
  #auto-parts(
    1,
    [Prove that the hyperbola $x^2 / a^2 - y^2 / b^2 = 1$ approaches
      the line $y = (b slash a) x$, and that it stays strictly below
      it throughout.],
    [Deduce that the hyperbola has no point in common with either
      asymptote.],
    [An ellipse also runs off to... nowhere: it is bounded. A parabola
      is unbounded but has no asymptote. Explain, using the cone,
      why exactly one of the three conics has asymptotes.],
  )
][
  #auto-parts(
    1,
    [As in the text: on the upper right, the vertical gap is
      $
        d(x) = b / a (x - sqrt(x^2 - a^2))
        = (a b) / (x + sqrt(x^2 - a^2)) ,
      $
      after multiplying numerator and denominator by
      $x + sqrt(x^2 - a^2)$. The final expression is a positive
      constant over a quantity that grows without bound, so
      $d(x) > 0$ for all $x >= a$ and $d(x) -> 0$ as
      $x -> infinity$.],
    [Since $d(x) > 0$ everywhere on the branch, the curve is never
      equal to the line, so the two never meet. (Algebraically:
      substituting $y = (b slash a) x$ into the equation gives
      $x^2 / a^2 - x^2 / a^2 = 1$, that is $0 = 1$.)],
    [A conic's behaviour far from the centre is governed by the
      directions in which the cutting plane runs parallel to a
      generator. The ellipse's plane is parallel to *no* generator, so
      the section closes up and is bounded. The parabola's plane is
      parallel to *exactly one*, so the curve escapes to infinity in
      one direction -- but with only one such direction there is no
      second line for it to be squeezed against, and it opens out
      forever instead of straightening. The hyperbola's plane is
      parallel to *two* generators, and the asymptotes are precisely
      the directions of those two: the branches run off parallel to
      them. Two escape directions, two asymptotes.],
  )
]

#ai-box(role: "Tutor")[
  Sketching hyperbolas by hand is the skill this chapter is most
  likely to leave half-formed, because the asymptote rectangle is easy
  to follow and easy to forget.

  + Ask an AI assistant to give you six hyperbola equations in
    expanded form, of mixed orientation, *without* their solutions.
  + Sketch all six, rectangle first. Then ask the assistant for the
    centres, vertices, foci and asymptotes, and check.
  + For every one you got wrong, ask yourself which of the two traps
    it was: comparing denominators instead of signs, or using
    $b slash a$ when the orientation called for $a slash b$. If you
    cannot classify your own error, ask the assistant to explain your
    specific mistake rather than to re-solve the problem -- the
    re-solution teaches you nothing you did not already have.
]

#print-vocab()
