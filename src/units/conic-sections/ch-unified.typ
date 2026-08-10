#import "../../common/preamble.typ": *
#import "../../common/cplane.typ": *
#import "../../common/conic-figures.typ": *
#show: chapter-template.with(title: "Eccentricity")
#let ex = exercise.with(chapter: "Eccentricity")

// ── WHAT THIS CHAPTER IS FOR ─────────────────────────────────
// The unit has run up two debts and this chapter pays both.
//
//   (1) ch-slicing defined the conics on a cone; ch-parabola,
//       ch-ellipse and ch-hyperbola defined them as loci in the
//       plane, with no argument that the two agree. Dandelin's
//       spheres settle it.
//   (2) The parabola has no shape parameter, the ellipse has
//       eps < 1 and the hyperbola eps > 1, and eps was defined as
//       c/a with no motivation beyond "it turns out to be useful".
//       The focus-directrix definition supplies the motivation:
//       eps is a RATIO OF DISTANCES, and it is the same
//       definition for all three curves.
//
// The chapter therefore comes AFTER all three loci and before the
// classification chapter. It is the keystone, not a coda -- if
// something has to be cut for time, cut the polar section (which
// is flagged as optional in the text), not the Dandelin section.
//
// ── FIGURE NOTE ──────────────────────────────────────────────
// The Dandelin figure is an edge-on profile, not a 3D rendering.
// alpha = 60deg, cut at phi = 20deg through (0, 1.5). The circles
// are the incircle and the S-excircle of the triangle formed by
// the two generators and the cutting line; all coordinates below
// were computed numerically and verified: |AB| = |P1P2| = 1.9284
// = 2a, |F1F2| = 0.7616 = 2c, and c/a = 0.3949 = sin 20 / sin 60.
//
// The profile is honest here for a reason worth keeping: the two
// Dandelin spheres touch the cutting plane at points ON the axis
// of symmetry of the section, so BOTH foci lie in the profile
// plane. Only the general point P does not, and the figure is
// drawn for the P that does.

= One Definition, Three Curves

#only-theory[
  Three chapters, three definitions. A parabola balances a distance to
  a point against a distance to a line; an ellipse holds a sum of two
  distances fixed; a hyperbola holds a difference fixed. They produce
  three different-looking equations and they were derived
  independently.

  Yet the first chapter claimed all three are slices of one cone, and
  the number $p = b^2 slash a$ has now turned up in all three with the
  same meaning. Something is holding them together, and this chapter
  is about what.

  There are two things to prove and they are separate. First, that
  there is a *single* locus definition covering all three curves, with
  one number deciding which you get. Second, that the curves so
  defined really are the sections of a cone. The first is algebra; the
  second needs an idea, and the idea is due to a Belgian
  mathematician, Germinal Dandelin, in 1822.
]

#objectives(
  [state the focus--directrix definition of a conic with eccentricity
    $epsilon$, and derive the standard equation from it],
  [prove that this $epsilon$ is the same as the $c slash a$ defined in
    the ellipse and hyperbola chapters],
  [classify a conic by its eccentricity, and explain why the parabola
    sits exactly at $epsilon = 1$],
  [locate the directrices of an ellipse or a hyperbola at distance
    $a slash epsilon = a^2 slash c$ from the centre],
  [use the polar equation $r = p slash (1 + epsilon cos phi.alt)$ for
    orbits],
  [explain Dandelin's argument, and use it to prove that a plane
    section of a cone satisfies the two-focus definition],
  [relate the eccentricity of a section to the two angles of the first
    chapter through $epsilon = sin(phi.alt) slash sin(alpha)$],
)

== The Focus--Directrix Definition

#only-theory[
  The parabola's definition asked for a distance to a point and a
  distance to a line to be *equal*. There is an obvious weakening:
  ask for them to be in a fixed ratio.
]

#definition(title: "Conic by focus, directrix and eccentricity")[
  Let $F$ be a point, $d$ a line not through $F$, and
  $epsilon > 0$. The set of points $P$ satisfying
  $
    overline(P F) = epsilon dot overline(P d)
  $
  is a conic with focus $F$, #vocab("directrix", "Leitlinie") $d$ and
  #vocab("eccentricity", "Exzentrizität") $epsilon$. Here
  $overline(P d)$ denotes the perpendicular distance from $P$ to $d$.
]

#only-theory[
  Everything follows from grinding this out once. Put the focus at the
  origin and the directrix at $x = -k$ with $k > 0$, so that
  $overline(P d) = x + k$ for points to the right of the directrix.
  The condition becomes
  $
    sqrt(x^2 + y^2) = epsilon (x + k) ,
  $
  and squaring gives
  $
    (1 - epsilon^2) x^2 - 2 epsilon^2 k x + y^2 = epsilon^2 k^2 .
  $
  Now everything depends on the coefficient $1 - epsilon^2$, and there
  are exactly three cases.
]

#only-theory[
  *Case $epsilon = 1$.* The $x^2$ term vanishes and the equation is
  linear in $x$:
  $
    y^2 = 2 k x + k^2 = 2 k (x + k / 2) ,
  $
  a parabola with vertex $(-k slash 2, 0)$ and, in the booklet's
  notation, $p = k$. So the semi-latus rectum of a parabola *is* the
  focus--directrix distance, which is what the parabola chapter
  claimed and can now be seen as a special case rather than a
  coincidence.

  *Cases $epsilon != 1$.* Complete the square in $x$. Writing
  $x_0 = epsilon^2 k slash (1 - epsilon^2)$ for the resulting centre,
  the equation becomes
  $
    (x - x_0)^2 / a^2 plus.minus y^2 / b^2 = 1,
    quad quad
    a = (epsilon k) / abs(1 - epsilon^2),
    quad quad
    b^2 = (epsilon^2 k^2) / abs(1 - epsilon^2) ,
  $
  with a plus sign when $epsilon < 1$ and a minus sign when
  $epsilon > 1$ -- because $1 - epsilon^2$ changes sign and takes the
  $y^2$ term with it. So $epsilon < 1$ gives an ellipse and
  $epsilon > 1$ gives a hyperbola, with no further work.
]

#theorem(title: "The two eccentricities agree")[
  For the conic just constructed, the distance from the centre to the
  focus is
  $ c = epsilon a . $
  In particular the $epsilon$ of the focus--directrix definition is
  exactly the ratio $c slash a$ defined in the ellipse and hyperbola
  chapters.
]

#proof[
  The focus is at the origin and the centre at $x_0$, so the distance
  between them is
  $
    abs(x_0) = (epsilon^2 k) / abs(1 - epsilon^2)
    = epsilon dot (epsilon k) / abs(1 - epsilon^2)
    = epsilon a .
  $
  For $epsilon < 1$ this gives $c^2 = a^2 - b^2 = epsilon^2 a^2$
  directly, since $b^2 = a^2 (1 - epsilon^2)$; for $epsilon > 1$ it
  gives $c^2 = a^2 + b^2 = epsilon^2 a^2$ in the same way.
]

#keybox(title: "One family")[
  All three conics are the loci $overline(P F) = epsilon dot
  overline(P d)$, and $epsilon$ alone decides which:

  #table(
    columns: 4,
    stroke: none,
    align: left,
    [*Eccentricity*], [*Curve*], [*Relation*], [*Shape*],
    [$epsilon = 0$], [circle], [$c = 0$], [foci coincide],
    [$0 < epsilon < 1$], [ellipse], [$b^2 = a^2(1 - epsilon^2)$],
    [bounded],
    [$epsilon = 1$], [parabola], [no centre], [one branch],
    [$epsilon > 1$], [hyperbola], [$b^2 = a^2(epsilon^2 - 1)$],
    [two branches],
  )

  In every case $c = epsilon a$ and $p = b^2 slash a$.
]

#remark[
  The circle is the awkward member. As $epsilon -> 0$ with $k$ fixed
  the curve shrinks to a point, so a circle is obtained only by
  letting $k -> infinity$ at the same time -- the directrix runs off
  to infinity as the two foci merge. A circle has no directrix, in the
  same way and for the same reason that a parabola has no second
  focus.
]

#only-theory[
  #xyplane(
    xmin: -3.8,
    xmax: 4.4,
    ymin: -4.3,
    ymax: 4.3,
    length: 0.68cm,
    caption: [One focus at the origin, one directrix $d: x = 3$, three
      values of $epsilon$. Left to right at the axis:
      $epsilon = 0.5$ (ellipse), $epsilon = 1$ (parabola),
      $epsilon = 1.5$ (hyperbola, near branch only). Nothing changes
      between the pictures except one number.],
    {
      cn-directrix(3, axis: "x", ymin: -4.3, ymax: 4.3)
      cn-ellipse(2, 1.7321, center: (-1, 0))
      cn-parabola(-3.0, vertex: (1.5, 0), axis: "x", extent: 4.1)
      cn-hyperbola(
        3.6,
        4.0249,
        center: (5.4, 0),
        extent: 4.1,
        branches: "negative",
      )
      cn-focus(0, 0, label: $F$, anchor: "north-east")
    },
  )
]

== Directrices of the Ellipse and the Hyperbola

#only-theory[
  The ellipse and hyperbola chapters never mentioned a directrix. They
  now have one -- in fact two, one for each focus, by symmetry. Where
  are they?

  From the derivation, the distance from the centre $x_0$ to the
  directrix $x = -k$ is
  $
    abs(x_0 + k) = k / abs(1 - epsilon^2) = a / epsilon ,
  $
  using $a = epsilon k slash abs(1 - epsilon^2)$.
]

#keybox(title: "Directrices")[
  A conic with centre $M$, semi-transverse axis $a$ and eccentricity
  $epsilon$ has two directrices, perpendicular to the major (or
  transverse) axis at distance
  $ a / epsilon = a^2 / c $
  from the centre, one on each side.
]

#remark[
  The formula $a^2 slash c$ makes both positions easy to check
  against intuition. For an ellipse $c < a$, so $a^2 slash c > a$: the
  directrices lie *outside* the curve, which they must, since every
  point of the ellipse has $overline(P F) = epsilon overline(P d)$
  with $epsilon < 1$ and so is closer to the focus than to the line.
  For a hyperbola $c > a$, so $a^2 slash c < a$: the directrices lie
  *between* the centre and the vertices, inside the gap where the
  curve is not.
]

#example(title: "Finding directrices")[
  The ellipse $x^2 / 25 + y^2 / 16 = 1$ has $a = 5$, $b = 4$, so
  $c = 3$ and $epsilon = 3 slash 5$. Its directrices are the vertical
  lines
  $ x = plus.minus 25 / 3 approx plus.minus 8.33 , $
  comfortably outside the vertices at $plus.minus 5$.

  The hyperbola $x^2 / 16 - y^2 / 9 = 1$ has $a = 4$, $b = 3$, so
  $c = 5$ and $epsilon = 5 slash 4$. Its directrices are
  $ x = plus.minus 16 / 5 = plus.minus 3.2 , $
  inside the vertices at $plus.minus 4$.
]

== The Polar Equation

#only-theory[
  There is a reason astronomers write conics in polar coordinates, and
  it is that the focus--directrix definition is almost already polar.
  Put the focus at the pole and the directrix at $x = k$, to the
  right. A point at polar coordinates $(r, phi.alt)$ has
  $overline(P F) = r$ and $overline(P d) = k - r cos(phi.alt)$, so the
  defining condition reads
  $
    r = epsilon (k - r cos(phi.alt))
    quad ==> quad
    r (1 + epsilon cos(phi.alt)) = epsilon k = p .
  $
]

#keybox(title: "Polar equation of a conic")[
  With a focus at the origin,
  $ r = p / (1 + epsilon cos(phi.alt)) , $
  where $p$ is the semi-latus rectum. One equation covers all three
  conics; only $epsilon$ changes.
]

#only-theory[
  Setting $phi.alt = 0$ and $phi.alt = pi$ gives the two extreme
  distances from the focus, for $epsilon < 1$:
  $
    r_"min" = p / (1 + epsilon) = a (1 - epsilon),
    quad quad
    r_"max" = p / (1 - epsilon) = a (1 + epsilon) ,
  $
  using $p = a(1 - epsilon^2)$. In an orbit these are the
  *perihelion* and *aphelion* distances, and their sum is $2a$ -- the
  fact used without comment in the Apollo 11 problem two chapters
  ago. For $epsilon >= 1$ the denominator reaches zero and $r$ runs to
  infinity: the orbit is not closed, which is what distinguishes a
  comet that returns from one that does not.
]

== Dandelin's Spheres

#only-theory[
  The second debt. The first chapter said a plane section of a cone is
  an ellipse; the ellipse chapter defined an ellipse by a sum of
  distances. Nothing so far connects them, and the connection is not
  obvious: one statement is about a surface in space, the other about
  two special points in a plane that the cone knows nothing about.

  Dandelin's idea is to make the cone produce the two points. Take a
  plane cutting one nappe in a closed curve, and slide a sphere down
  inside the cone from above until it is wedged between the cone and
  the plane; slide another up from below. Each sphere touches the cone
  along a full circle, and each touches the plane at a single point.

  Those two points are the foci. Here is why.
]

#theorem(title: "Dandelin, 1822")[
  Let a plane cut one nappe of a cone in a closed curve, and let the
  two inscribed spheres touch the plane at $F_1$ and $F_2$. Then every
  point $P$ of the section satisfies
  $
    overline(P F_1) + overline(P F_2) = "constant" ,
  $
  so the section is an ellipse with foci $F_1$ and $F_2$.
]

#proof[
  Let $P$ be a point of the section, and consider the generator of the
  cone through $P$. It meets the first sphere's circle of tangency at
  a point $A$ and the second sphere's at a point $B$.

  Now use the one fact about spheres this argument needs: *all tangent
  segments from an external point to a sphere have the same length.*
  From $P$, the segment $P F_1$ is tangent to the first sphere,
  because $F_1$ is where that sphere touches the cutting plane and
  $P$ lies in that plane. The segment $P A$ is also tangent to it,
  because $A$ is where the sphere touches the cone and $P$ lies on the
  cone. Hence
  $ overline(P F_1) = overline(P A), $
  and by the same argument on the second sphere,
  $ overline(P F_2) = overline(P B) . $
  Adding,
  $
    overline(P F_1) + overline(P F_2)
    = overline(P A) + overline(P B) = overline(A B) ,
  $
  since $A$ and $B$ lie on the same generator on opposite sides of
  $P$. But $overline(A B)$ is the distance along a generator between
  two fixed parallel circles, and by the rotational symmetry of the
  cone that distance is the same for every generator. So the sum is
  constant, independent of $P$.
]

#only-theory[
  #cn-blank(
    xmin: -3.4,
    xmax: 3.4,
    ymin: -0.7,
    ymax: 5.6,
    length: 0.78cm,
    caption: [Dandelin's construction, seen edge-on. The two spheres
      appear as circles inscribed between the generators and the
      cutting line; they touch the cutting plane at $F_1$ and $F_2$,
      and the cone along the two circles shown edge-on as dashed
      chords. Along the generator through $P$,
      $overline(P F_1) + overline(P F_2)
      = overline(P A) + overline(P B) = overline(A B)$.],
    {
      // upper nappe, alpha = 60 deg
      cp-segment((0.0, 0.0), (3.0, 5.196), color: luma(70), thickness: 1.2pt)
      cp-segment((0.0, 0.0), (-3.0, 5.196), color: luma(70), thickness: 1.2pt)
      cp-segment(
        (0.0, 0.0),
        (0.0, 5.4),
        color: luma(180),
        dashed: true,
        thickness: 0.8pt,
      )
      // the two tangency circles, seen edge-on
      cp-segment(
        (-0.4239, 0.7343),
        (0.4239, 0.7343),
        color: luma(150),
        dashed: true,
      )
      cp-segment(
        (-1.3881, 2.4043),
        (1.3881, 2.4043),
        color: luma(150),
        dashed: true,
      )
      // Dandelin spheres
      cp-circle(0.0, 0.9791, 0.4895, color: expl-col)
      cp-circle(0.0, 3.2057, 1.6029, color: expl-col)
      // cutting plane, edge-on
      cp-segment((-1.4, 0.9904), (1.6, 2.0824), color: accent)
      cp-point(-0.7156, 1.2395, color: accent, size: 0.06)
      cn-focus(-0.1674, 1.4391, label: $F_1$, anchor: "north-east")
      cn-focus(0.5482, 1.6995, label: $F_2$, anchor: "north-west")
      cp-point(0.4239, 0.7343, label: $A$, anchor: "north-west", color: def-col)
      cp-point(1.3881, 2.4043, label: $B$, anchor: "south-east", color: def-col)
      cp-point(1.0964, 1.8991, label: $P$, anchor: "south-west", color: def-col)
    },
  )
]

#warning[
  Read the figure carefully: it is a *cross-section*, not the
  construction itself. The spheres are spheres and the cutting plane
  is a plane; both appear reduced by one dimension because the page is
  the plane through the axis perpendicular to the cutting plane.

  Both foci genuinely lie in that plane, by symmetry, so nothing is
  lost there. What the figure cannot show is a general point $P$: the
  one drawn happens to lie in the page, which is why $A$, $P$ and $B$
  are collinear on a visible generator. Every other point of the
  section gives the identical picture rotated about the axis, and the
  proof never used anything else.
]

#remark[
  The same construction handles the other two conics with almost no
  change. For a hyperbola the plane cuts both nappes, so one sphere
  goes in each nappe, and the two tangent lengths are *subtracted*
  rather than added -- because $P$ now lies outside the segment $A B$
  instead of between $A$ and $B$. For a parabola only one sphere fits,
  which is precisely why a parabola has only one focus.

  Dandelin's construction also delivers the directrix: the plane
  containing a sphere's circle of tangency meets the cutting plane in
  a line, and that line is the corresponding directrix. Chasing the
  angles through gives the eccentricity in terms of the two angles of
  the first chapter,
  $ epsilon = sin(phi.alt) / sin(alpha) , $
  where $alpha$ is the angle of a generator to the base plane and
  $phi.alt$ that of the cutting plane. Every classification of the
  first chapter is a special case: $phi.alt = 0$ gives
  $epsilon = 0$, a circle; $phi.alt < alpha$ gives $epsilon < 1$;
  $phi.alt = alpha$ gives $epsilon = 1$ exactly; and
  $phi.alt > alpha$ gives $epsilon > 1$.
]

#look-back(title: "The unit so far", recalls: [all four previous chapters])[
  Both debts are now paid. A conic is a plane section of a cone
  (Chapter 1), a locus defined by distances (Chapters 2--4), and the
  same object either way (this chapter). The single number $epsilon$
  fixes the shape and tells you which of the three you have, and the
  single number $p$ measures the size in a way that is uniform across
  the family.

  What remains is mechanical by comparison. The classification chapter
  goes from an arbitrary second-degree equation back to the curve;
  the tangents chapter finally pays the reflection-property debt from
  Chapter 2; and the parametric chapter writes all three curves as
  paths rather than as equations.
]

// ── Exercises ────────────────────────────────────────────────

#ex(difficulty: 1, time: "12 min", calculator: false)[
  Find the eccentricity and the directrices of each conic.
  #auto-parts(
    2,
    [$x^2 / 100 + y^2 / 64 = 1$],
    [$x^2 / 9 - y^2 / 16 = 1$],
    [$y^2 = 8 x$],
    [$x^2 / 4 + y^2 / 4 = 1$],
  )
][
  #auto-parts(
    1,
    [$a = 10$, $b = 8$, $c = 6$, so $epsilon = 3 slash 5$ and the
      directrices are $x = plus.minus a^2 slash c = plus.minus 50
      slash 3 approx plus.minus 16.7$ -- outside the vertices, as an
      ellipse requires.],
    [$a = 3$, $b = 4$, $c = 5$, so $epsilon = 5 slash 3$ and the
      directrices are $x = plus.minus 9 slash 5 = plus.minus 1.8$ --
      inside the vertices at $plus.minus 3$.],
    [$epsilon = 1$. Here $2 p = 8$, so $p = 4$, the focus is $(2, 0)$
      and the single directrix is $x = -2$. The formula
      $a^2 slash c$ does not apply: a parabola has no centre and no
      $a$.],
    [A circle of radius $2$: $epsilon = 0$, and there is no
      directrix.],
  )
]

#ex(difficulty: 2, time: "18 min", calculator: false)[
  Find an equation of the conic with focus $F = (0,0)$, directrix
  $d: x = -4$, and
  #auto-parts(
    3,
    [$epsilon = 1 slash 2$,],
    [$epsilon = 1$,],
    [$epsilon = 2$.],
  )
  In each case identify the curve and give its centre (if it has
  one), $a$, $b$ and $c$.
][
  Use the derivation of the chapter with $k = 4$, or substitute
  directly into $sqrt(x^2 + y^2) = epsilon (x + 4)$ and square.

  #auto-parts(
    1,
    [$x^2 + y^2 = 1/4 (x+4)^2$ gives
      $3 x^2 slash 4 - 2 x + y^2 = 4$, and completing the square,
      $
        (x - 4 / 3)^2 / (64 slash 9) + y^2 / (16 slash 3) = 1 .
      $
      An ellipse with centre $(4 slash 3, 0)$,
      $a = 8 slash 3$, $b = 4 slash sqrt(3)$,
      $c = epsilon a = 4 slash 3$. The focus is at the origin, at
      distance $c$ from the centre. #sym.checkmark],
    [$x^2 + y^2 = (x+4)^2$ gives $y^2 = 8 x + 16 = 8(x + 2)$, a
      parabola with vertex $(-2, 0)$ and $p = 4 = k$. No centre.],
    [$x^2 + y^2 = 4(x+4)^2$ gives $-3x^2 - 32 x + y^2 = 64$, and
      completing the square,
      $
        (x + 16 / 3)^2 / (64 slash 9) - y^2 / (64 slash 3) = 1 .
      $
      A hyperbola with centre $(-16 slash 3, 0)$,
      $a = 8 slash 3$, $b = 8 slash sqrt(3)$,
      $c = epsilon a = 16 slash 3$. #sym.checkmark],
  )

  Note that $a$ came out the same in (a) and (c). That is the formula
  $a = epsilon k slash abs(1 - epsilon^2)$ at work: $epsilon = 1
  slash 2$ and $epsilon = 2$ give the same value of that expression.
]

#ex(difficulty: 2, time: "22 min", calculator: false, hints: (
  [Look at the sign of each denominator before doing anything else.],
  [For the last part, compute $c^2$ rather than $c$.],
))[
  Determine the type of curve represented by
  $ x^2 / k + y^2 / (k - 16) = 1 $
  in each case, and find its foci.
  #auto-parts(
    3,
    [$k > 16$],
    [$0 < k < 16$],
    [$k < 0$],
  )
  #auto-parts(
    1,
    [Show that all the curves in parts (a) and (b) have the *same*
      foci, whatever the value of $k$. What is such a family called?],
    [Describe what happens as $k -> 16$ from each side.],
  )
][
  #auto-parts(
    1,
    [Both denominators are positive and $k > k - 16$, so this is an
      ellipse with major axis horizontal, $a^2 = k$ and
      $b^2 = k - 16$. Then $c^2 = k - (k - 16) = 16$, so the foci are
      $(plus.minus 4, 0)$.],
    [The second denominator is negative. Rewriting,
      $
        x^2 / k - y^2 / (16 - k) = 1,
      $
      a hyperbola with $a^2 = k$ and $b^2 = 16 - k$. Then
      $c^2 = k + (16 - k) = 16$, so the foci are again
      $(plus.minus 4, 0)$.],
    [Both denominators are negative, so the left-hand side is
      negative for every real $x$ and $y$ and can never equal $1$.
      There is no curve.],
    [In (a), $c^2 = k - (k-16) = 16$; in (b), $c^2 = k + (16-k) = 16$.
      The $k$ cancels in both, so every curve of the family has
      $c = 4$ and foci $(plus.minus 4, 0)$. A family of conics sharing
      their foci is called *confocal*.

      Note that $k$ cancelling is the whole content of the result: the
      foci are pinned while the shape varies from a nearly circular
      ellipse (large $k$) through steadily flatter ellipses, to
      hyperbolas of every eccentricity as $k$ decreases towards $0$.
      The eccentricity is $epsilon = 4 slash sqrt(k)$ throughout, in
      both cases.],
    [As $k -> 16^(+)$ we have $b -> 0$, and the ellipse flattens onto
      the segment joining the foci, $-4 <= x <= 4$. As
      $k -> 16^(-)$ we have $b -> 0$ again, and the hyperbola
      flattens onto the two rays $x <= -4$ and $x >= 4$. Together
      these are the two degenerate limits: $epsilon -> 1$ from below
      and from above. At $k = 16$ the equation itself is undefined --
      division by zero -- which is the algebra's way of saying that
      the family has no member there.],
  )
]

#ex(difficulty: 2, time: "18 min", calculator: true, hints: (
  [Perihelion and aphelion are $a(1 - epsilon)$ and
    $a(1 + epsilon)$.],
))[
  Halley's Comet moves on an ellipse with the Sun at one focus. Its
  semi-major axis is $a = 17.83$ AU and its eccentricity is
  $epsilon = 0.967$.
  #auto-parts(
    1,
    [Find its perihelion and aphelion distances.],
    [Find the semi-latus rectum $p$ and write the polar equation of
      the orbit with the Sun at the pole.],
    [Neptune orbits at about $30$ AU. Does Halley's Comet travel
      beyond Neptune's orbit?],
    [Its eccentricity is close to $1$. What would happen if it
      exceeded $1$?],
  )
][
  #auto-parts(
    1,
    [$
        r_"min" = a(1 - epsilon) = 17.83 dot 0.033 approx 0.588 " AU",
        quad
        r_"max" = a(1 + epsilon) = 17.83 dot 1.967 approx 35.1 " AU" .
      $
      The perihelion is inside Earth's orbit, which is why the comet
      is visible from Earth at all.],
    [$p = a(1 - epsilon^2) = 17.83 (1 - 0.935) approx 1.16$ AU, so
      $ r = 1.16 / (1 + 0.967 cos(phi.alt)) " AU" . $],
    [Yes: the aphelion of about $35.1$ AU exceeds Neptune's $30$ AU.
      The comet spends the overwhelming majority of its $76$-year
      period out there, moving slowly, and only a few months near
      perihelion.],
    [With $epsilon > 1$ the orbit would be a hyperbola: the comet
      would pass the Sun once and leave the solar system for ever,
      never returning. The polar equation makes this visible -- the
      denominator $1 + epsilon cos(phi.alt)$ reaches zero for some
      $phi.alt$, and $r$ runs to infinity there. Objects on such
      orbits do exist; two interstellar visitors have been observed
      passing through the solar system.],
  )
]

#ex(difficulty: 2, time: "15 min", calculator: true)[
  A cone has generators making $alpha = 50 degree$ with its base
  plane. Using $epsilon = sin(phi.alt) slash sin(alpha)$:
  #auto-parts(
    1,
    [Find the eccentricity of the section cut at
      $phi.alt = 30 degree$.],
    [At what angle $phi.alt$ must a plane cut this cone to produce an
      ellipse of eccentricity $0.5$?],
    [What is the largest eccentricity obtainable from this cone, and
      which cut achieves it?],
    [Show that a rectangular hyperbola ($epsilon = sqrt(2)$) can be
      cut from this cone, and find $phi.alt$.],
  )
][
  #auto-parts(
    1,
    [$epsilon = sin(30 degree) slash sin(50 degree)
      = 0.5 slash 0.766 approx 0.653$: an ellipse, as expected since
      $30 degree < 50 degree$.],
    [$sin(phi.alt) = 0.5 sin(50 degree) approx 0.383$, so
      $phi.alt approx 22.5 degree$.],
    [$sin(phi.alt)$ is largest at $phi.alt = 90 degree$, a cut
      parallel to the axis, giving
      $epsilon = 1 slash sin(50 degree) approx 1.305$. No cut of
      *this* cone produces a more eccentric hyperbola.],
    [$sin(phi.alt) = sqrt(2) sin(50 degree) approx 1.083 > 1$, which
      has no solution -- so a rectangular hyperbola *cannot* be cut
      from this cone. By part (c) the maximum is $1.305 < sqrt(2)$.

      This is the first chapter's warning in quantitative form: a
      rectangular hyperbola needs $1 slash sin(alpha) >= sqrt(2)$,
      that is $sin(alpha) <= 1 slash sqrt(2)$, so $alpha <= 45
      degree$ -- with equality exactly when the cut is parallel to the
      axis. A cone with $alpha = 50 degree$ is too narrow.],
  )
]

#ex(difficulty: 3, time: "25 min", calculator: false, hints: (
  [The proof for the ellipse used that $P$ lies *between* $A$ and $B$
    on its generator. Where does $P$ lie now?],
))[
  Adapt Dandelin's argument to the hyperbola. A plane cuts both nappes
  of a cone, and a sphere is inscribed in each nappe, tangent to the
  cone and to the plane, touching the plane at $F_1$ and $F_2$.
  #auto-parts(
    1,
    [Let $P$ be a point of the section, on the branch nearer $F_2$,
      and let its generator touch the two spheres' circles of tangency
      at $A$ and $B$. Show that
      $overline(P F_1) - overline(P F_2) = overline(A B)$.],
    [Deduce that the section is a hyperbola, and say what
      $overline(A B)$ is in the notation of the hyperbola chapter.],
    [Explain, using this construction, why a parabola has exactly one
      focus.],
  )
][
  #auto-parts(
    1,
    [Exactly as before, tangent segments from $P$ to each sphere are
      equal in length, so $overline(P F_1) = overline(P A)$ and
      $overline(P F_2) = overline(P B)$. The difference is what
      changes: the generator through $P$ now passes through the apex,
      with $A$ on one nappe and $B$ on the other, so $P$ lies
      *outside* the segment $A B$ rather than inside it. Hence
      $
        overline(P F_1) - overline(P F_2)
        = overline(P A) - overline(P B) = overline(A B) .
      $],
    [As before, $overline(A B)$ is a distance measured along a
      generator between two fixed circles, so the rotational symmetry
      of the cone makes it the same for every generator. The
      difference of the focal distances is therefore constant, which
      is the definition of a hyperbola. Comparing,
      $overline(A B) = 2a$. (For a point on the other branch the
      difference comes out as $-overline(A B)$, which is why the
      definition needs the absolute value.)],
    [A parabola's cutting plane is parallel to a generator, so it
      never closes off either nappe. A sphere can still be wedged on
      one side of the plane, but on the other side the plane runs
      parallel to the cone forever and there is no wedge for a second
      sphere to sit in. One sphere, one tangency point, one focus.],
  )
]

#ex(difficulty: 3, time: "20 min", calculator: false, hints: (
  [Write $overline(P F)$ and $overline(P d)$ for a point of
    $x^2 slash a^2 + y^2 slash b^2 = 1$ with $F = (c, 0)$ and
    $d: x = a^2 slash c$, and compute the ratio.],
))[
  The ellipse chapter defined an ellipse by two foci; this chapter
  defines it by a focus and a directrix. Close the loop directly.

  Let $P = (x, y)$ lie on $x^2 / a^2 + y^2 / b^2 = 1$, take
  $F = (c, 0)$ with $c = sqrt(a^2 - b^2)$, and take
  $d: x = a^2 slash c$.
  #auto-parts(
    1,
    [Show that $overline(P F) = a - epsilon x$, where
      $epsilon = c slash a$. (This is the *focal radius* formula, the
      ellipse's version of $x + p slash 2$.)],
    [Show that $overline(P d) = a slash epsilon - x$ for every point
      of the ellipse.],
    [Conclude that $overline(P F) = epsilon dot overline(P d)$.],
  )
][
  #auto-parts(
    1,
    [From the equation, $y^2 = b^2 (1 - x^2 slash a^2)$, so
      $
        overline(P F)^2 & = (x - c)^2 + b^2 (1 - x^2 / a^2) \
        & = x^2 - 2 c x + c^2 + b^2 - (b^2 x^2) / a^2 \
        & = (a^2 - b^2) / a^2 x^2 - 2 c x + a^2
        = epsilon^2 x^2 - 2 epsilon a x + a^2 ,
      $
      using $a^2 - b^2 = c^2$ and $c = epsilon a$. The right-hand side
      is the perfect square $(a - epsilon x)^2$, and since
      $abs(x) <= a$ and $epsilon < 1$ we have
      $a - epsilon x > 0$, so
      $overline(P F) = a - epsilon x$.],
    [Every point of the ellipse has $x <= a < a slash epsilon$, so it
      lies to the left of the directrix and the perpendicular
      distance is $a slash epsilon - x$ with no absolute value
      needed.],
    [Dividing,
      $
        overline(P F) / overline(P d)
        = (a - epsilon x) / (a slash epsilon - x)
        = (epsilon (a - epsilon x)) / (a - epsilon x)
        = epsilon ,
      $
      which is the focus--directrix condition. The two definitions
      describe the same curve.],
  )
]

#ai-box(role: "Checker")[
  Dandelin's proof is short, and short proofs are where an argument
  can be plausible and wrong at the same time.

  + Write out the ellipse proof from memory, without looking.
  + Give your write-up to an AI assistant and ask it to identify any
    step that is asserted rather than justified. Do not ask "is this
    correct" -- that question invites agreement.
  + Two steps carry the whole argument: that all tangent segments from
    a point to a sphere have equal length, and that
    $overline(A B)$ does not depend on which generator you use. Did
    your write-up justify both? Did the assistant notice if it
    didn't?
]

#print-vocab()
