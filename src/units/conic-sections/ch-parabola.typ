#import "../../common/preamble.typ": *
#import "../../common/cplane.typ": *
#import "../../common/conic-figures.typ": *
#show: chapter-template.with(title: "Parabola")
#let ex = exercise.with(chapter: "Parabola")

// ── CONVENTION NOTE ──────────────────────────────────────────
// This chapter uses the FORMULA BOOKLET's parabola:
//
//     y^2 = 2 p x,   F = (p/2, 0),   d: x = -p/2
//
// and NOT the x^2 = 4 p y of the old LaTeX notes. The algebra of
// the derivation is very slightly uglier (a p/2 survives to the
// second-to-last line), and that is a price worth paying, because
// in this convention p is the SAME quantity for all three conics:
// the semi-latus rectum, later b^2/a for the ellipse and the
// hyperbola. One letter carrying one meaning across the whole
// unit is the spine of the eccentricity chapter; a parabola-only
// p that means something else there would cost more than the two
// extra factors of 2 here.
//
// Bonus that shows up immediately: the reflector problem
// (Exercise 7) states the opening at the focus, which IS 2p, so
// the equation falls out in one line instead of via a
// substitute-and-solve.
//
// Students meet x^2 = 4 p y in English-language sources and
// y = a x^2 from year 1, so both dictionaries are stated
// explicitly in a warning(). Do not quietly drop them.

// ── FIGURE NOTE ──────────────────────────────────────────────
// Every parabola drawn in this chapter has p = 2, i.e. y^2 = 4x,
// F = (1, 0), d: x = -1. Keeping one curve throughout means the
// definition figure, the semi-latus-rectum figure and the four
// orientations are all the SAME parabola, so a student can carry
// numbers between them.

= The Parabola

#only-theory[
  You have known one parabola since the first year: the graph of
  $y = a x^2$. That description is a coincidence of coordinates. It
  tells you that a parabola is what a certain formula draws, and
  nothing about what a parabola *is* -- which is why nothing in it
  explains why headlight reflectors, satellite dishes and the path of
  a thrown ball all have the same shape.

  This chapter gives the definition that does explain it. The cone is
  put away for the whole chapter; everything comes from one condition
  on distances in the plane.
]

#look-back(
  title: "Two things to bring with you",
  recalls: [the cone chapter, and quadratic functions from year 1],
)[
  From the previous chapter: a parabola is the section of a cone by a
  plane at $phi.alt = alpha$, parallel to exactly one generator. That
  is why a parabola is unbounded and in one piece, and it will not be
  mentioned again until the eccentricity chapter.

  From year 1: completing the square. Half of the work in this chapter
  is turning $y^2 + 2y + 12x + 25 = 0$ into a form you can read
  geometrically, and that is completing the square with the roles of
  $x$ and $y$ occasionally swapped.
]

#objectives(
  [define a parabola as the locus of points equidistant from a focus
    and a directrix],
  [derive the equation $y^2 = 2 p x$ from that definition],
  [interpret $p$ in two ways: as the focus--directrix distance and as
    the semi-latus rectum],
  [convert between $y^2 = 2 p x$, the textbook form $y^2 = 4 p' x$ and
    the function form $y = a x^2$],
  [read off the vertex, focus and directrix of a parabola in any of
    the four axis-parallel orientations, completing the square where
    needed],
  [find the equation of a parabola from a focus and a directrix, or
    from a vertex, an orientation and one further point],
  [use the focal distance $overline(P F) = x + p/2$ in applications],
)

== The Locus Definition

#definition(title: "Parabola")[
  Let $F$ be a point and $d$ a line not through $F$. The
  #vocab("parabola", "Parabel") with
  #vocab("focus", "Brennpunkt") $F$ and
  #vocab("directrix", "Leitlinie") $d$ is the set of all points $P$
  whose distance to $F$ equals its distance to $d$:
  $ overline(P F) = overline(P B), $
  where $B$ is the foot of the perpendicular from $P$ to $d$.
]

#only-theory[
  The definition names no coordinates, so it describes a curve rather
  than a formula -- a set of points that would be the same set if you
  turned the page. Two features follow before any algebra at all. The
  midpoint of $F$ and its perpendicular foot on $d$ satisfies the
  condition, so every parabola has exactly one
  #vocab("vertex", "Scheitelpunkt") $V$. And the perpendicular from
  $F$ to $d$ is an axis of symmetry, because reflecting in it moves
  neither $F$ nor $d$ and so maps the whole locus to itself.
]

#exploration(title: "A parabola with no ruler and no formula")[
  Take a sheet of paper with the long side facing you. Mark a point
  $F$ in the middle, a few centimetres above the bottom edge. Now pick
  at least a dozen points along the bottom edge, and for each one fold
  the paper so that the chosen point lands exactly on $F$, and crease
  sharply. Unfold.

  + A curve appears where the creases crowd together. Convince
    yourself that it is a parabola with focus $F$ and the bottom edge
    as directrix. (One fold is enough to see it: what does folding a
    point of the edge onto $F$ do to distances?)
  + Move $F$ very close to the bottom edge and repeat. What happens to
    the curve?
  + Move $F$ far from the edge. What happens now?
  + The curve is not drawn by the creases -- it is drawn by the *gaps*
    between them. What is each crease to the curve?
  + Given your answer to 4, why is $F$ called a *focus*?
]

== Deriving the Equation

#only-theory[
  Now choose coordinates, and choose them to make the algebra as
  painless as possible. Put the vertex at the origin and the axis of
  symmetry along the $x$-axis, so that the focus and the directrix sit
  symmetrically on either side of the origin:
  $
    F = (p/2, 0), quad quad d: x = -p / 2, quad quad p > 0 .
  $
  Every other parabola in the plane is this one rotated and
  translated, so nothing is lost. The number $p$ is the distance from
  the focus to the directrix.
]

#only-theory[
  #xyplane(
    xmin: -2.2,
    xmax: 5.0,
    ymin: -4.4,
    ymax: 4.4,
    caption: [The parabola $y^2 = 4x$, with $p = 2$: focus $F = (1,0)$
      and directrix $d: x = -1$. The two marked segments are equal in
      length for every point $P$ of the curve -- that equality *is*
      the curve.],
    {
      cn-directrix(-1, axis: "x", ymin: -4.4, ymax: 4.4)
      cn-parabola(2.0, axis: "x", extent: 4.2)
      cp-segment((2.25, 3.0), (1.0, 0.0), color: def-col)
      cp-segment((2.25, 3.0), (-1.0, 3.0), color: def-col)
      cn-focus(1, 0, label: $F$, anchor: "north-west")
      cn-vertex(0, 0, label: $V$, anchor: "north-east")
      cp-point(2.25, 3.0, label: $P$, anchor: "south-west", color: def-col)
      cp-point(-1.0, 3.0, label: $B$, anchor: "south-east", color: def-col)
    },
  )
]

#only-theory[
  Let $P = (x, y)$. Its distance to the directrix is measured
  horizontally, so $B = (-p/2, y)$ and
  $ overline(P B) = x + p / 2 . $
  Note that this is $x + p/2$ and not $abs(x + p/2)$: a point of the
  parabola is never to the left of the directrix, so the quantity is
  never negative. The distance to the focus is the usual one, and
  setting the two equal gives
  $
    sqrt((x - p / 2)^2 + y^2) = x + p / 2 .
  $
  Both sides are non-negative, so squaring is reversible and no
  solutions are gained or lost:
  $
    (x - p / 2)^2 + y^2 & = (x + p / 2)^2 \
    x^2 - p x + p^2 / 4 + y^2 & = x^2 + p x + p^2 / 4 \
    y^2 & = 2 p x .
  $
  The $x^2$ and the $p^2/4$ cancel from both sides, which is the whole
  reason for centring the picture on the vertex.
]

#keybox(title: "Equation of the parabola")[
  The parabola with focus $F = (p/2, 0)$ and directrix
  $d: x = -p/2$ has the equation
  $ y^2 = 2 p x . $
  Its vertex is the origin and its axis of symmetry is the $x$-axis.
  This is the form given in the formula booklet.
]

== What $p$ Means

#only-theory[
  Two readings of $p$, and both get used.

  The first is the one built into the derivation: $p$ is the distance
  from the focus to the directrix. So a large $p$ means a focus far
  from the directrix and a wide, slowly-rising curve; a small $p$
  means a tight one.

  The second is less obvious and more useful. Cut the parabola with
  the vertical line through the focus, $x = p/2$. Then
  $y^2 = 2 p dot p/2 = p^2$, so $y = plus.minus p$: the chord through
  the focus perpendicular to the axis reaches exactly $p$ above and
  $p$ below.
]

#definition(title: "Latus rectum")[
  The chord of a conic through a focus and perpendicular to the axis
  is the #vocab("latus rectum", "Brennpunktsehne"). Half its length is
  the #vocab("semi-latus rectum", "Halbparameter"), written $p$.
]

#only-theory[
  #xyplane(
    xmin: -2.0,
    xmax: 3.2,
    ymin: -3.0,
    ymax: 3.0,
    caption: [Both readings of $p$ on the same picture: the distance
      from $F$ to $d$, and half the focal chord.],
    {
      cn-directrix(-1, axis: "x", ymin: -3.0, ymax: 3.0)
      cn-parabola(2.0, axis: "x", extent: 2.9)
      cp-segment((1.0, -2.0), (1.0, 2.0), color: def-col)
      cp-segment((-1.0, 0.0), (1.0, 0.0), color: expl-col, dashed: true)
      cn-focus(1, 0, label: none)
      cp-point(1.0, 2.0, color: def-col, size: 0.065)
      cp-point(1.0, -2.0, color: def-col, size: 0.065)
      cp-label(1.35, 1.1, $p$, color: def-col)
      cp-label(1.35, -1.1, $p$, color: def-col)
      cp-label(0.0, 0.45, $p$, color: expl-col)
    },
  )
]

#remark[
  The second reading is why the booklet uses $2p$ rather than $4p$.
  For the ellipse and the hyperbola the semi-latus rectum turns out to
  be $p = b^2 / a$, and the focus--directrix distance is *not* a
  natural quantity there at all. So of the two readings only the
  second one survives into the rest of the unit -- and it survives
  under the same letter, which is the point.
]

#warning[
  Three conventions are in circulation and they use the same letters
  for different things. Keep a dictionary:

  - *This course and the formula booklet:* $y^2 = 2 p x$, with
    $F = (p/2, 0)$ and $d: x = -p/2$. Here $p$ is the semi-latus
    rectum.
  - *Many English-language textbooks:* $y^2 = 4 p x$, with
    $F = (p, 0)$ and $d: x = -p$. Their $p$ is our $p slash 2$; it is
    the vertex--focus distance, not the semi-latus rectum.
  - *Function form from year 1:* $y = a x^2$, which is the same curve
    turned on its side. Rearranged, $x^2 = (1 slash a) y$, so
    comparing with $x^2 = 2 p y$ gives
    $ 2 p = 1 / a, quad quad "that is" quad quad a = 1 / (2 p) . $

  Read every source's own definition of $p$ before using its formula.
  A focus in the wrong place is the single most common error in this
  topic, and it never announces itself.
]

== Orientation and Position

#only-theory[
  The derivation used one particular position. Two moves generalize
  it, and neither needs new work.

  *Swapping $x$ and $y$* reflects the plane in the line $y = x$ and
  turns the equation into $x^2 = 2 p y$, a parabola opening upward
  with focus $(0, p/2)$ and directrix $y = -p/2$.

  *Allowing $p < 0$* reverses the direction of opening. Nothing in the
  derivation assumed the sign except the remark that $overline(P B)$
  is non-negative, and for $p < 0$ the points of the curve lie to the
  left of the directrix instead of to the right, so the same equation
  describes the mirrored curve. This is why there is no separate
  minus-sign case to memorize: the sign of $p$ carries it.
]

#only-theory[
  #image-grid(
    2,
    xyplane-small(
      xmin: -3.2,
      xmax: 3.2,
      ymin: -3.2,
      ymax: 3.2,
      caption: [$y^2 = 2 p x$, $p > 0$],
      {
        cn-directrix(-1, axis: "x", ymin: -3.2, ymax: 3.2, label: none)
        cn-parabola(2.0, axis: "x", extent: 3.0)
        cn-focus(1, 0, label: none)
      },
    ),
    xyplane-small(
      xmin: -3.2,
      xmax: 3.2,
      ymin: -3.2,
      ymax: 3.2,
      caption: [$y^2 = 2 p x$, $p < 0$],
      {
        cn-directrix(1, axis: "x", ymin: -3.2, ymax: 3.2, label: none)
        cn-parabola(-2.0, axis: "x", extent: 3.0)
        cn-focus(-1, 0, label: none)
      },
    ),
    xyplane-small(
      xmin: -3.2,
      xmax: 3.2,
      ymin: -3.2,
      ymax: 3.2,
      caption: [$x^2 = 2 p y$, $p > 0$],
      {
        cn-directrix(-1, axis: "y", xmin: -3.2, xmax: 3.2, label: none)
        cn-parabola(2.0, axis: "y", extent: 3.0)
        cn-focus(0, 1, label: none)
      },
    ),
    xyplane-small(
      xmin: -3.2,
      xmax: 3.2,
      ymin: -3.2,
      ymax: 3.2,
      caption: [$x^2 = 2 p y$, $p < 0$],
      {
        cn-directrix(1, axis: "y", xmin: -3.2, xmax: 3.2, label: none)
        cn-parabola(-2.0, axis: "y", extent: 3.0)
        cn-focus(0, -1, label: none)
      },
    ),
  )
]

#only-theory[
  Finally, moving the vertex to $V = (u, v)$ replaces $x$ by $x - u$
  and $y$ by $y - v$, exactly as it does for every graph you have
  shifted since year 1 -- the inside-outside rule, applied to an
  equation rather than to a function.
]

#keybox(title: "The four axis-parallel parabolas")[
  With vertex $V = (u, v)$ and $p != 0$:

  #table(
    columns: 4,
    stroke: none,
    align: left,
    [*Equation*], [*Opens*], [*Focus*], [*Directrix*],
    [$(y - v)^2 = 2 p (x - u)$],
    [right if $p > 0$],
    [$(u + p / 2, v)$],
    [$x = u - p / 2$],

    [$(x - u)^2 = 2 p (y - v)$],
    [up if $p > 0$],
    [$(u, v + p / 2)$],
    [$y = v - p / 2$],
  )

  Negative $p$ opens the other way and moves the focus and the
  directrix with it; the formulas need no change.
]

#example(title: "From equation to geometry")[
  Describe the parabola $y^2 + 2 y + 12 x + 25 = 0$.

  The square appears on $y$, so this is the first row of the table.
  Complete the square in $y$ and collect the rest on the right:
  $
    y^2 + 2 y & = -12 x - 25 \
    (y + 1)^2 - 1 & = -12 x - 25 \
    (y + 1)^2 & = -12 x - 24 = -12 (x + 2) .
  $
  Comparing with $(y - v)^2 = 2 p (x - u)$ gives $u = -2$, $v = -1$
  and $2 p = -12$, so $p = -6$. Hence
  $
    V = (-2, -1), quad
    F = (-2 + (-3), -1) = (-5, -1), quad
    d: x = -2 - (-3) = 1 .
  $
  The parabola opens to the left, since $p < 0$. A sanity check costs
  one line: the vertex must lie halfway between the focus and the
  directrix, and $(-5 + 1) slash 2 = -2$. #sym.checkmark
]

#example(title: "From geometry to equation")[
  Find the parabola with focus $F = (1, 4)$ and directrix $d: y = -2$.

  The directrix is horizontal, so the axis is vertical and the second
  row applies. The focus--directrix distance is $4 - (-2) = 6$, and
  the focus lies *above* the directrix, so the curve opens upward and
  $p = +6$. The vertex is the midpoint of $F$ and its foot $(1, -2)$
  on $d$, so $V = (1, 1)$. Therefore
  $ (x - 1)^2 = 12 (y - 1) . $
]

#remark[
  A parabola is the only conic with a single focus, and the only one
  with no centre. There is nothing to be the centre *of*: an ellipse
  and a hyperbola each have two foci and a midpoint between them, but
  a parabola's second focus has, in a sense made precise in the
  eccentricity chapter, run away to infinity.
]

== Why Parabolas Are Everywhere

#only-theory[
  Galileo showed in the early 17th century that a projectile thrown at
  an angle, with gravity constant and air resistance ignored, follows
  a parabola. That accounts for thrown balls and water from a
  fountain, but not for headlights or satellite dishes, which are
  parabolic for a completely different reason.

  A parabolic mirror takes every ray arriving parallel to its axis and
  reflects all of them through the focus -- and, run backwards, turns
  a source at the focus into a parallel beam. That is the whole design
  of a car headlight, a torch, a satellite dish, a solar cooker and a
  reflecting telescope, and it is the reason $F$ is called a focus at
  all. The paper folding at the start of this chapter is the same fact
  in disguise: each crease is a *tangent* to the parabola, and it
  bisects the angle between the ray to the focus and the perpendicular
  to the directrix.
]

#look-ahead(title: "The proof is owed", preview: [the tangents chapter])[
  Stating the reflection property is not proving it, and it cannot be
  proved with what is available here -- it is a statement about
  tangents, and there is not yet a tangent to a parabola in this unit.
  The tangents chapter supplies one, algebraically and with no
  calculus, and the reflection property falls out in a few lines.
  Until then, treat it as an announced debt rather than a result.
]

// ── Exercises ────────────────────────────────────────────────

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Find the focus and the directrix of the parabola $y^2 + 10 x = 0$
  and sketch it.
][
  Rearranged, $y^2 = -10 x$, so $2 p = -10$ and $p = -5$. The vertex
  is the origin and the axis is the $x$-axis, so
  $ F = (-5 / 2, 0), quad quad d: x = 5 / 2 . $
  The curve opens to the left. The sketch should show the vertex at
  the origin with the focus inside the curve and the directrix on the
  far side, the two at equal distances $5 slash 2$ from $V$.
]

#ex(difficulty: 2, time: "35 min", calculator: false)[
  Find the vertex, focus and directrix of each parabola, and sketch
  its graph.
  #auto-parts(
    2,
    [$x = 2 y^2$],
    [$4 y + x^2 = 0$],
    [$4 x^2 = -y$],
    [$y^2 = 12 x$],
    [$(x + 2)^2 = 8 (y - 3)$],
    [$x - 1 = (y + 5)^2$],
    [$y^2 + 2 y + 12 x + 25 = 0$],
    [$y + 12 x - 2 x^2 = 16$],
  )
][
  In each case: identify which variable is squared, complete the
  square in it if necessary, and read off $u$, $v$ and $2 p$.

  #auto-parts(
    2,
    [$y^2 = x slash 2$, so $p = 1 slash 4$. \
      $V = (0,0)$, $F = (1 / 8, 0)$, $d: x = -1 / 8$.],
    [$x^2 = -4 y$, so $p = -2$. \
      $V = (0,0)$, $F = (0, -1)$, $d: y = 1$.],
    [$x^2 = -y slash 4$, so $p = -1 / 8$. \
      $V = (0,0)$, $F = (0, -1 / 16)$, $d: y = 1 / 16$.],
    [$2 p = 12$, so $p = 6$. \
      $V = (0,0)$, $F = (3, 0)$, $d: x = -3$.],
    [$2 p = 8$, so $p = 4$. \
      $V = (-2, 3)$, $F = (-2, 5)$, $d: y = 1$.],
    [$(y + 5)^2 = x - 1$, so $p = 1 / 2$. \
      $V = (1, -5)$, $F = (5 / 4, -5)$, $d: x = 3 / 4$.],
    [$(y + 1)^2 = -12(x + 2)$, so $p = -6$. \
      $V = (-2, -1)$, $F = (-5, -1)$, $d: x = 1$.],
    [$(x - 3)^2 = 1 / 2 (y + 2)$, so $p = 1 / 4$. \
      $V = (3, -2)$, $F = (3, -15 / 8)$, $d: y = -17 / 8$.],
  )

  In every part the vertex is the midpoint of the focus and the foot
  of the perpendicular to the directrix. Checking that costs one
  subtraction and catches a sign error in $p$ immediately.
]

#ex(difficulty: 2, time: "15 min", calculator: false)[
  Find an equation for each parabola, then its focus and directrix.
  #auto-parts(
    1,
    [Vertex at the origin, opening to the left, passing through the
      point $(-4, 2)$.],
    [Vertex $(2, -2)$, opening upward, passing through $(4, 0)$.],
  )
][
  #auto-parts(
    1,
    [The axis is horizontal, so $y^2 = 2 p x$. Substituting the point,
      $4 = 2 p dot (-4)$, so $2 p = -1$ and
      $ y^2 = -x, quad quad F = (-1 / 4, 0), quad quad d: x = 1 / 4 . $],
    [The axis is vertical, so $(x - 2)^2 = 2 p (y + 2)$. Substituting
      $(4, 0)$ gives $4 = 2 p dot 2$, so $2 p = 2$ and
      $
        (x - 2)^2 = 2 (y + 2), quad quad
        F = (2, -3 / 2), quad quad d: y = -5 / 2 .
      $],
  )
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  Find the vertex, focus and directrix of $y = 3 x^2 - 12 x + 7$.
  State also the value of $a$ in the form $y = a(x - u)^2 + v$, and
  check that your $p$ and your $a$ agree with $a = 1 slash (2p)$.
][
  Completing the square,
  $
    y = 3(x^2 - 4 x) + 7 = 3(x - 2)^2 - 12 + 7 = 3(x - 2)^2 - 5,
  $
  so $a = 3$ and the vertex is $V = (2, -5)$. Rearranging into conic
  form, $(x - 2)^2 = 1 / 3 (y + 5)$, so $2 p = 1 slash 3$ and
  $p = 1 slash 6$. Then
  $ F = (2, -5 + 1 / 12) = (2, -59 / 12), quad quad d: y = -61 / 12 . $
  The check: $1 slash (2 p) = 1 slash (1 slash 3) = 3 = a$.
  #sym.checkmark

  Note how flat-looking the geometry is: with $a = 3$ the curve is
  narrow, and correspondingly the focus sits only $1 slash 12$ above
  the vertex. A narrow parabola is one whose focus is close in.
]

#ex(difficulty: 2, time: "25 min", calculator: false, hints: (
  [You do not need twelve separate sketches. Draw the three curves of
    one family carefully, then ask what the other nine are.],
))[
  Sketch all twelve parabolas
  $ y^2 = plus.minus 2 p x quad "and" quad x^2 = plus.minus 2 p y, $
  for $p = 1$, $p = 2$ and $p = 4$, in a single coordinate system. How
  efficiently can you produce all twelve?
][
  Draw only the three curves $y^2 = 2x$, $y^2 = 4x$ and $y^2 = 8x$,
  marking a few exact points on each. The remaining nine come from
  reflections of that one picture, and no further calculation:

  - reflecting in the $y$-axis, $x |-> -x$, gives the three
    $y^2 = -2 p x$;
  - reflecting in the line $y = x$, which swaps the variables, gives
    the three $x^2 = 2 p y$;
  - reflecting in the line $y = -x$ gives the three $x^2 = -2 p y$.

  So the honest count is three curves drawn and three reflections
  applied. The general point is worth keeping: an equation in which
  swapping or negating a variable produces another member of the same
  family is telling you about a symmetry of the whole family, and
  symmetries are cheaper than calculations.
]

#ex(difficulty: 2, time: "18 min", calculator: false, hints: (
  [For the first part, a point of the parabola satisfies
    $overline(P F) = overline(P B)$, and $overline(P B)$ is measured
    horizontally.],
))[
  Let $P = (x, y)$ lie on the parabola $y^2 = 2 p x$ with $p > 0$.
  #auto-parts(
    1,
    [Show that $overline(P F) = x + p / 2$. (This is the *focal
      distance* formula, and it turns a distance into an
      $x$-coordinate.)],
    [Use it to show that the latus rectum has length $2 p$, without
      substituting into the equation of the curve.],
    [A point of this parabola is $12$ units from the focus, and
      $p = 8$. Find its coordinates.],
  )
][
  #auto-parts(
    1,
    [By definition $overline(P F) = overline(P B)$, and $B$ is the
      foot of the perpendicular from $P$ to the vertical line
      $x = -p slash 2$, so $B = (-p slash 2, y)$ and
      $overline(P B) = x - (-p slash 2) = x + p slash 2$. (No
      absolute value is needed: points of the parabola have
      $x >= 0 > -p slash 2$.)],
    [The endpoints of the latus rectum have $x = p slash 2$, so each
      is at focal distance $p slash 2 + p slash 2 = p$ from $F$. The
      chord is perpendicular to the axis and $F$ lies on it, so its
      length is $p + p = 2 p$.],
    [With $p = 8$: $12 = x + 4$ gives $x = 8$, and then
      $y^2 = 2 dot 8 dot 8 = 128$, so $y = plus.minus 8 sqrt(2)$. The
      two points are $(8, plus.minus 8 sqrt(2))$.],
  )
]

#ex(difficulty: 2, time: "18 min", calculator: true, hints: (
  [The opening measured *at the focus* is a chord through the focus
    perpendicular to the axis. That chord has a name and a length in
    this chapter.],
))[
  A cross-section of a parabolic reflector is shown below. The bulb
  sits at the focus, and the opening of the reflector measured across
  the axis at the focus is $10$ cm.
  #auto-parts(
    1,
    [Find an equation for the parabola, taking the vertex at the
      origin and the axis along the positive $x$-axis.],
    [Find the diameter of the reflector $11$ cm from the vertex.],
  )
][
  #auto-parts(
    1,
    [The opening at the focus *is* the latus rectum, whose length is
      $2 p$. So $2 p = 10$, giving $p = 5$ and
      $ y^2 = 10 x . $
      (In the $y^2 = 4 p' x$ convention this same problem needs a
      substitution and a solve; here the given measurement is the
      coefficient.)],
    [At $x = 11$ we get $y^2 = 110$, so $y = plus.minus sqrt(110)$ and
      the diameter is
      $ 2 sqrt(110) approx 21.0 " cm" . $
      Leave the exact value $2 sqrt(110)$ as the answer and give the
      decimal only because this is a physical measurement.],
  )
]

#ex(difficulty: 3, time: "20 min", calculator: false, hints: (
  [Try the scaling $(x, y) |-> (x slash p, y slash p)$ and see what
    the equation becomes.],
  [A similarity is a scaling combined with a rigid motion. Ask
    yourself what the analogous question for ellipses would give.],
))[
  Everyone knows that $y = x^2$ and $y = 5 x^2$ "have different
  shapes" -- one is wide and one is narrow.
  #auto-parts(
    1,
    [Show that the map $(x, y) |-> (x slash p, y slash p)$ sends every
      point of $y^2 = 2 p x$ to a point of $y^2 = 2 x$.],
    [Conclude that *any two parabolas are similar*, and explain what
      is wrong with the sentence in italics above.],
    [Is the same true of ellipses? Give a reason.],
  )
][
  #auto-parts(
    1,
    [Write $X = x slash p$ and $Y = y slash p$, so $x = p X$ and
      $y = p Y$. Substituting into $y^2 = 2 p x$ gives
      $
        p^2 Y^2 = 2 p dot p X
        quad ==> quad
        Y^2 = 2 X .
      $],
    [The map is a scaling by the factor $1 slash p$ about the origin,
      which is a similarity. Every parabola in standard position is
      therefore similar to the single curve $y^2 = 2 x$, and every
      parabola whatsoever is a rigid motion of one in standard
      position -- so any two parabolas are similar.

      What is wrong with the italicized sentence is the word *shape*.
      The two curves have the same shape and different *sizes*: $p$ is
      a scale, not a form. They look different on a page only because
      the page fixes a unit of length. Zoom in far enough on $y = 5x^2$
      near its vertex and you cannot tell it from $y = x^2$.],
    [No. An ellipse carries a genuinely dimensionless number -- the
      ratio $b slash a$ of its semi-axes, which no scaling can change.
      A very elongated ellipse is not similar to a nearly circular
      one. A parabola has no such number available, since $p$ is its
      only parameter and $p$ is a length. This is exactly the
      distinction the eccentricity chapter is built on.],
  )
]

#ai-box(role: "Generator")[
  Ask an AI assistant to generate five parabola equations in expanded
  form -- things like $2y^2 - 8y + x + 3 = 0$ -- *together with* their
  vertices, foci and directrices.

  + Work out all five yourself first, on paper, before looking at its
    answers.
  + Compare. Where you disagree, do not assume either party is right:
    settle it with the midpoint check, that $V$ is halfway between $F$
    and $d$.
  + If the assistant used a different convention for $p$ than this
    course does, its foci will be wrong by a factor of two in a way
    that still passes a casual glance. Did you catch that, or did you
    catch only the arithmetic?
]

#print-vocab()
