#import "../../common/preamble.typ": *
#import "/src/common/vec-figures.typ": *
#show: chapter-template.with(title: "Old Problems, New Tools")
#let ex = exercise.with(chapter: "Old Problems, New Tools")

= Old Problems, New Tools

#only-theory[
  Nothing new is introduced in this chapter. Everything in it is
  already in your hands: dot products, cross products, normal vectors,
  the Hesse form.

  What is new is the *kind* of question. The problems here are the
  ones classical geometry has been asking since antiquity — where do
  the perpendicular bisectors of a triangle meet, how does light
  bounce off a mirror, what is the volume of this solid — and the
  point is to watch how little work they take once the machinery is
  assembled.
]

#objectives(
  bfkm[solve a multi-step geometric problem by choosing the right tool
    at each stage],
  [find the perpendicular bisector of a segment in the plane, and the
    bisector plane in space],
  [locate the circumcentre and the orthocentre of a triangle],
  [reflect a direction in a line or a plane, and follow a light beam
    through a reflection],
  [calculate areas and volumes of triangles, pyramids and tetrahedra],
)

== Equidistant Points

#only-theory[
  Which points are the same distance from $A$ as from $B$?

  In the plane the answer is the
  #vocab("perpendicular bisector", "Mittelsenkrechte") of $A B$; in
  space it is a whole plane. Both come out of one observation: the
  set is perpendicular to $A B$ and passes through the midpoint, so
  $arrow(A B)$ serves as its normal vector and the midpoint as its
  point.
]

#keybox(title: "Perpendicular bisector")[
  The set of points equidistant from $A$ and $B$ is
  $
    arrow(A B) dot (arrow(r) - arrow(r)_M) = 0,
    quad quad M = "midpoint of" A B.
  $

  In the plane this is a line; in space it is a plane.
]

#only-theory[
  *Example.* The perpendicular bisector of $A B$ with $A = (4, -3)$
  and $B = (2, 1)$.

  The midpoint is $M = (3, -1)$ and $arrow(A B) = vec(-2, 4)$, so
  $ vec(-2, 4) dot vec(x - 3, y + 1) = 0, $
  $
    -2(x - 3) + 4(y + 1) = 0
    quad arrow.r.double quad -2x + 4y + 10 = 0,
  $
  or more tidily $x - 2y - 5 = 0$.

  *Check.* Take any point on it, say $(5, 0)$: the distances to $A$
  and $B$ are $abs(vec(-1, 3)) = sqrt(10)$ and
  $abs(vec(-3, -1)) = sqrt(10)$. Equal ✓.

  In space nothing changes but the number of components. The points
  equidistant from $A = (2, 3, -1)$ and $B = (4, -3, 7)$ form the
  plane through $(3, 0, 3)$ with normal $vec(2, -6, 8)$, that is
  $x - 3y + 4z - 15 = 0$.
]

== The Special Points of a Triangle

#only-theory[
  A triangle has several centres, each defined by three lines meeting
  at a point. That they *do* meet is a theorem in each case; with
  vectors, the meeting point is found by intersecting two of the three
  and then checking the third — which also proves the concurrency for
  that particular triangle.

  === The circumcentre

  The #vocab("circumcentre", "Umkreismittelpunkt") is the point
  equidistant from all three vertices, hence the intersection of the
  three perpendicular bisectors. It is the centre of the circle
  through all three vertices.

  *Example.* For $A = (5, 7)$, $B = (-1, -1)$ and $C = (6, 0)$:

  The bisector of $B C$ has midpoint $(2.5, -0.5)$ and normal
  $arrow(B C) = vec(7, 1)$:
  $
    7(x - 2.5) + (y + 0.5) = 0
    quad arrow.r.double quad 7x + y - 17 = 0.
  $

  The bisector of $A C$ has midpoint $(5.5, 3.5)$ and normal
  $arrow(A C) = vec(1, -7)$:
  $
    (x - 5.5) - 7(y - 3.5) = 0
    quad arrow.r.double quad x - 7y + 19 = 0.
  $

  Solving the two: from the second $x = 7y - 19$, and substituting,
  $50y = 150$, so $y = 3$ and $x = 2$. The circumcentre is
  $M = (2, 3)$.

  The radius is the distance to any vertex:
  $r = abs(arrow(M A)) = abs(vec(3, 4)) = 5$. As a check, the other
  two should give the same: $abs(vec(-3, -4)) = 5$ and
  $abs(vec(4, -3)) = 5$ ✓.
]

#only-theory[
  === The orthocentre

  The #vocab("altitude", "Höhe") from a vertex is the line through it
  perpendicular to the opposite side. In the plane that is again a
  normal-vector construction: the altitude from $A$ has normal
  $arrow(B C)$.

  The three altitudes meet at the
  #vocab("orthocentre", "Höhenschnittpunkt").

  *Example.* For $A = (0, 0)$, $B = (6, 0)$, $C = (2, 4)$:

  $
    h_a: arrow(B C) dot vec(x - 0, y - 0) = 0
    quad "with" quad arrow(B C) = vec(-4, 4),
  $
  which simplifies to $x - y = 0$. Similarly
  $h_b: x + 2y - 6 = 0$ and $h_c: x - 2 = 0$.

  The first two meet where $x = y$ and $3y = 6$, that is at
  $(2, 2)$ — and $h_c$ passes through it too. The orthocentre is
  $H = (2, 2)$.
]

#remark[
  Notice the shape of both calculations. Each of the six lines above
  was written down directly from a normal vector and a point, with no
  slopes, no rearranging, and no special cases for vertical lines.

  In coordinate geometry without vectors, "the altitude from $A$" is a
  slope calculation involving the negative reciprocal of the slope of
  $B C$ — which fails outright when $B C$ is vertical. The vector
  version has no such gap, because a normal vector exists in every
  direction equally.
]

== Reflections

#only-theory[
  A mirror reverses the component of a direction perpendicular to it
  and leaves the parallel component alone. Since you can already split
  a vector into those two parts, reflecting is one line of algebra.
]

#keybox(title: "Reflecting a direction")[
  In a line (in the plane) or a plane (in space) with normal
  $arrow(n)$, the direction $arrow(v)$ reflects to
  $
    arrow(v)' = arrow(v)
    - 2 dot (arrow(v) dot arrow(n)) / abs(arrow(n))^2 dot arrow(n).
  $

  The subtracted term is twice the perpendicular component — once to
  remove it, once more to send it back the other way.
]

#only-theory[
  A light beam therefore takes two steps: find where it hits the
  mirror, then reflect its direction there.

  *Example.* A beam starts at $Q = (11, -6)$ travelling in the
  direction $arrow(v) = vec(-4, 1)$ and reflects off the line
  $l: 3x - 5y + 5 = 0$. Find the reflected beam.

  *Hit point.* The beam is $(11 - 4t, ; -6 + t)$; substituting,
  $
    3(11 - 4t) - 5(-6 + t) + 5 = 68 - 17t = 0
    quad arrow.r.double quad t = 4,
  $
  so the beam meets the mirror at $S = (-5, -2)$.

  *Reflected direction.* With $arrow(n) = vec(3, -5)$ and
  $abs(arrow(n))^2 = 34$:
  $ arrow(v) dot arrow(n) = -12 - 5 = -17, $
  $
    arrow(v)' = vec(-4, 1) - 2 dot (-17)/34 dot vec(3, -5)
    = vec(-4, 1) + vec(3, -5) = vec(-1, -4).
  $

  So the reflected beam is
  $ I^*: arrow(r) = vec(-5, -2) + t dot vec(-1, -4). $

  *Check.* The angle of incidence must equal the angle of reflection,
  so $arrow(v)$ and $arrow(v)'$ must make equal angles with
  $arrow(n)$. Both have magnitude $sqrt(17)$, and both dot products
  with $arrow(n)$ have magnitude $17$ — equal ✓.

  #fig(
    vplane(
      s-seg(
        from: (-8, -3.8),
        to: (2, 2.2),
        color: def-col,
        width: 1.2pt,
        label: [$l$],
        anchor: 0.06,
      ),
      s-vec(
        from: (7, -6),
        to: (-5, -2),
        label: $arrow(v)$,
        color: accent,
        anchor: 0.6,
      ),
      s-vec(
        from: (-5, -2),
        to: (-8, -14),
        label: $arrow(v)'$,
        color: warn-col,
        anchor: 0.4,
      ),
      s-seg(
        from: (-5, -2),
        to: (-2, -7),
        color: luma(150),
        dashed: true,
        label: [$arrow(n)$],
        anchor: 0.7,
      ),
      s-pt((-5, -2), label: $S$),
      xmin: -9.5,
      xmax: 8.5,
      ymin: -14.5,
      ymax: 3.5,
      unit: 0.28cm,
      grid: false,
      axes: false,
    ),
  )
]

#warning[
  Reflecting a *direction* and reflecting a *point* are different
  calculations, and the difference is easy to blur.

  A direction has no location, so only the normal matters — the
  formula above. A point has a location, so where the mirror *is*
  matters too, and you need the signed distance: $P' = P + 2 t_0 dot
  arrow(n)$, with $t_0$ found by substituting into the mirror's
  equation, as in the chapter on distances.

  A light beam needs both: the point of impact and the new direction.
]

== Areas and Volumes

#keybox(title: "The standard formulas")[
  $
    "parallelogram on" arrow(u), arrow(v): quad
    A = abs(arrow(u) times arrow(v))
  $
  $
    "triangle on" arrow(u), arrow(v): quad
    A = 1/2 dot abs(arrow(u) times arrow(v))
  $
  $ "pyramid": quad V = 1/3 dot B dot h $

  For a pyramid, $B$ is the base area and $h$ the perpendicular
  distance from the apex to the base plane — a Hesse-form calculation.
]

#only-theory[
  *Example.* The plane $E: 6x - 5y + 3z - 30 = 0$ and the three
  coordinate planes bound a pyramid with one vertex at the origin.
  Find its volume.

  The intercepts are $x = 5$, $y = -6$ and $z = 10$. Two of them lie
  along the base in the $x y$#"‑"plane, where the triangle is
  right-angled at the origin with legs $5$ and $6$, so
  $ B = 1/2 dot 5 dot 6 = 15. $
  The third intercept is the apex height, $h = 10$, measured along the
  $z$#"‑"axis which is perpendicular to the base. Hence
  $ V = 1/3 dot 15 dot 10 = 50. $

  The negative $y$#"‑"intercept is not a problem: it only means the
  solid sits in a different octant. Lengths are taken positive.
]

#look-ahead(preview: [computer graphics])[
  The reflection calculation in this chapter is the whole of how
  mirrors work in a rendered image, and the line-plane intersection
  from earlier is how a computer decides what a camera can see.

  The final chapter assembles them: a program that traces light rays
  backwards from the eye, finds what they hit, and works out how
  bright it looks. Every ingredient is already on this page.
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  #auto-parts(
    1,
    [Find the perpendicular bisector of $A B$ in the plane, with
      $A = (4, -3)$ and $B = (2, 1)$, and verify your answer with one
      test point.],
    [Find the plane of points equidistant from $A = (2, 3, -1)$ and
      $B = (4, -3, 7)$.],
    [Show that the midpoint of $A B$ in part (b) does lie on your
      plane, and explain why it had to.],
  )
][
  #auto-parts(
    1,
    [Midpoint $(3, -1)$, normal $vec(-2, 4)$, giving
      $-2x + 4y + 10 = 0$, or $x - 2y - 5 = 0$.
      Test $(5, 0)$: distances $sqrt(10)$ to both ✓.],
    [Midpoint $(3, 0, 3)$, normal $arrow(A B) = vec(2, -6, 8)$, which
      tidies to $vec(1, -3, 4)$:
      $
        (x - 3) - 3y + 4(z - 3) = 0
        quad arrow.r.double quad x - 3y + 4z - 15 = 0.
      $],
    [$3 - 0 + 12 - 15 = 0$ ✓. It had to, because the midpoint is
      equidistant from $A$ and $B$ by definition, and the plane
      consists of exactly the equidistant points.],
  )
]

#ex(difficulty: 2, time: "15 min", calculator: false, hints: (
  "The perpendicular bisector of a side has that side's vector as its normal, and passes through the side's midpoint.",
  "Two bisectors are enough to locate the centre. Use the third as a check.",
))[
  Find the circumcentre $M$ and the circumradius $r$ of the triangle
  with $A = (5, 7)$, $B = (-1, -1)$ and $C = (6, 0)$.
][
  Bisector of $B C$: midpoint $(2.5, -0.5)$, normal
  $arrow(B C) = vec(7, 1)$, giving $7x + y - 17 = 0$.

  Bisector of $A C$: midpoint $(5.5, 3.5)$, normal
  $arrow(A C) = vec(1, -7)$, giving $x - 7y + 19 = 0$.

  Solving: $x = 7y - 19$, so $7(7y - 19) + y = 17$, hence $50y = 150$,
  $y = 3$ and $x = 2$. So $M = (2, 3)$.

  $r = abs(arrow(M A)) = abs(vec(3, 4)) = 5$.

  *Check.* $abs(arrow(M B)) = abs(vec(-3, -4)) = 5$ and
  $abs(arrow(M C)) = abs(vec(4, -3)) = 5$ ✓. All three equal, which
  simultaneously confirms the answer and shows that the third
  perpendicular bisector passes through $M$ as well.
]

#ex(difficulty: 2, time: "15 min", calculator: false)[
  The triangle $A B C$ has $A = (3, -2)$, $B = (-4, 3)$ and
  $C = (-3, -5)$.

  #auto-parts(
    1,
    [Find the Cartesian equations of all three altitudes.],
    [Show that the three lines are concurrent.],
  )
][
  #auto-parts(
    1,
    [$h_a$ passes through $A$ with normal
      $arrow(B C) = vec(1, -8)$:
      $ (x - 3) - 8(y + 2) = 0 arrow.r.double x - 8y - 19 = 0. $
      $h_b$ passes through $B$ with normal
      $arrow(A C) = vec(-6, -3)$, which tidies to $vec(2, 1)$:
      $ 2(x + 4) + (y - 3) = 0 arrow.r.double 2x + y + 5 = 0. $
      $h_c$ passes through $C$ with normal
      $arrow(A B) = vec(-7, 5)$:
      $ -7(x + 3) + 5(y + 5) = 0 arrow.r.double 7x - 5y - 4 = 0. $],
    [Solve $h_a$ and $h_b$: from $h_a$, $x = 8y + 19$, and
      substituting into $h_b$ gives $17y = -43$, so
      $y = -43 slash 17$ and $x = -21 slash 17$.

      Testing in $h_c$:
      $
        7 dot (-21)/17 - 5 dot (-43)/17 - 4
        = (-147 + 215 - 68)/17 = 0. ✓
      $
      The third altitude passes through the same point, so all three
      are concurrent.],
  )

  The fractions here are ugly and that is normal: an orthocentre has
  no reason to land on a lattice point. Carry them as fractions rather
  than rounding, or the final check will not come out to exactly zero.
]

#ex(difficulty: 3, time: "16 min", calculator: false, hints: (
  "Two steps: find where the beam hits the mirror, then reflect its direction there.",
  "For the hit point, substitute the beam's parametric form into the mirror's equation.",
))[
  A light beam starts at $Q = (11, -6)$ and travels in the direction
  $arrow(v) = vec(-4, 1)$. It reflects off the mirror
  $l: 3x - 5y + 5 = 0$.

  #auto-parts(
    1,
    [Find the point where the beam strikes the mirror.],
    [Find the parametric equation of the reflected beam.],
    [Verify that the angle of incidence equals the angle of
      reflection.],
  )
][
  #auto-parts(
    1,
    [Substituting $(11 - 4t, -6 + t)$ into the mirror's equation gives
      $68 - 17t = 0$, so $t = 4$ and $S = (-5, -2)$. Check:
      $-15 + 10 + 5 = 0$ ✓.],
    [$arrow(n) = vec(3, -5)$, $abs(arrow(n))^2 = 34$ and
      $arrow(v) dot arrow(n) = -17$, so
      $ arrow(v)' = vec(-4, 1) + vec(3, -5) = vec(-1, -4), $
      $ I^*: arrow(r) = vec(-5, -2) + t dot vec(-1, -4). $],
    [Both directions have magnitude $sqrt(17)$, and both have dot
      product with $arrow(n)$ of magnitude $17$. Since the angle
      depends only on those two quantities, the two angles are
      equal ✓.

      Note that reflection preserves length: $abs(arrow(v)')
      = abs(arrow(v))$ always, because only the *sign* of the
      perpendicular component changes.],
  )
]

#ex(difficulty: 3, time: "20 min", calculator: true, hints: (
  "For (a), S lies on the given line — write it with one parameter, then impose the equidistance condition.",
  "For (b), the height is the distance from S to the plane through A, B and C.",
))[
  The points $A = (6, 2, 2)$, $B = (2, -4, -2)$ and $C = (8, 0, -6)$
  form the base of a pyramid. Its apex $S$ is equidistant from $A$ and
  $B$, and lies on the line through $P = (-2, -13, 23)$ and
  $Q = (1, -7, 14)$.

  #auto-parts(
    1,
    [Find the coordinates of $S$.],
    [Find the height $h$ of the pyramid.],
    [Find the angle $beta = angle A B C$.],
    [Find the volume of the pyramid.],
  )
][
  #auto-parts(
    1,
    [$arrow(P Q) = vec(3, 6, -9)$, so
      $S = (-2 + 3t, ; -13 + 6t, ; 23 - 9t)$. Imposing
      $abs(arrow(S A))^2 = abs(arrow(S B))^2$ and expanding, all the
      quadratic terms cancel and the condition reduces to
      $8t = 8$, so $t = 1$ and
      $ S = (-1, -11, 20). $
      *Check:* $abs(arrow(S A))^2 = abs(arrow(S B))^2 = 542$ ✓.],
    [The base plane through $A$, $B$, $C$ has normal
      $arrow(A B) times arrow(A C) = vec(40, -40, 20)$, tidying to
      $vec(2, -2, 1)$ with $abs(arrow(n)) = 3$, and equation
      $2x - 2y + z - 10 = 0$. Then
      $ h = (2 dot (-1) + 22 + 20 - 10)/3 = 30/3 = 10. $],
    [$arrow(B A) = vec(4, 6, 4)$ and $arrow(B C) = vec(6, 4, -4)$,
      both of magnitude $sqrt(68)$, with dot product
      $24 + 24 - 16 = 32$. So
      $
        cos beta = 32/68 approx 0.4706
        quad arrow.r.double quad beta approx 61.9degree.
      $],
    [The base area is
      $1/2 dot abs(vec(40, -40, 20)) = 1/2 dot 60 = 30$, so
      $ V = 1/3 dot 30 dot 10 = 100. $],
  )
]

#ex(difficulty: 3, time: "25 min", calculator: false)[
  Three points are given: $A = (2, 2, 0)$, $B = (4, 0, 1)$ and
  $C = (0, 1, 2)$.

  #auto-parts(
    1,
    [$A$ and $B$ lie on the plane $E: x + 2y + 2z - 6 = 0$. Show by
      calculation that $C$ does too.],
    [Find the distance from $D = (1, 1, 1)$ to $E$.],
    [Write down a normal vector of $E$ and show that it is
      perpendicular to $arrow(A B)$.],
    [A light ray starts at $P = (7, 2, 2)$ and reflects at
      $S = (2, 1, 1)$ on $E$. Find the parametric equation of the
      reflected ray.],
    [$E$ and the three coordinate planes bound a pyramid. Find its
      volume.],
  )
][
  #auto-parts(
    1,
    [$0 + 2 + 4 - 6 = 0$ ✓.],
    [$d = (1 + 2 + 2 - 6) slash 3 = -1 slash 3$, so the distance is
      $1 slash 3$ — and the sign says $D$ lies on the opposite side
      of $E$ from the direction $arrow(n)$ points.],
    [$arrow(n) = vec(1, 2, 2)$, and
      $arrow(A B) = vec(2, -2, 1)$ gives
      $2 - 4 + 2 = 0$ ✓.],
    [First confirm $S$ is on $E$: $2 + 2 + 2 - 6 = 0$ ✓. The incoming
      direction is $arrow(P S) = vec(-5, -1, -1)$, with
      $arrow(P S) dot arrow(n) = -9$ and
      $abs(arrow(n))^2 = 9$, so
      $
        arrow(v)' = vec(-5, -1, -1) + 2 dot vec(1, 2, 2)
        = vec(-3, 3, 3),
      $
      which tidies to $vec(-1, 1, 1)$. Hence
      $ g: arrow(r) = vec(2, 1, 1) + t dot vec(-1, 1, 1). $],
    [The intercepts of $E$ are $x = 6$, $y = 3$ and $z = 3$. The base
      is the right triangle in the $x y$#"‑"plane with legs $6$ and
      $3$, of area $9$, and the height is $3$:
      $ V = 1/3 dot 9 dot 3 = 9. $],
  )
]

#only-high[
  #ex(difficulty: 3, time: "20 min", calculator: false, hints: (
    "Compute all three centres for the same triangle before looking for a pattern.",
    "Compare the vectors from the circumcentre to the other two points.",
  ))[
    For the triangle $A = (0, 0)$, $B = (6, 0)$, $C = (2, 4)$:

    #auto-parts(
      1,
      [Find the centroid $S$, the circumcentre $O$ and the
        orthocentre $H$.],
      [Show that the three points are collinear.],
      [Find the exact ratio in which $S$ divides the segment $O H$.],
    )

    The line through these three points is called the *Euler line* of
    the triangle, and it exists for every triangle that is not
    equilateral.
  ][
    #auto-parts(
      1,
      [*Centroid:* the average of the vertices,
        $S = (8 slash 3, ; 4 slash 3)$.

        *Circumcentre:* the perpendicular bisector of $A B$ is
        $x = 3$; that of $A C$ has midpoint $(1, 2)$ and normal
        $vec(2, 4)$, giving $x + 2y - 5 = 0$. At $x = 3$ this yields
        $y = 1$, so $O = (3, 1)$. Check:
        $abs(arrow(O A))^2 = abs(arrow(O B))^2
        = abs(arrow(O C))^2 = 10$ ✓.

        *Orthocentre:* the altitudes are $x - y = 0$,
        $x + 2y - 6 = 0$ and $x - 2 = 0$, all passing through
        $H = (2, 2)$.],
      [$arrow(O S) = vec(-1/3, 1/3)$ and

        $arrow(O H) = vec(-1, 1)$. Since
        $arrow(O H) = 3 dot arrow(O S)$, the two vectors are
        parallel and share the point $O$, so $O$, $S$ and $H$ lie on
        one line.],
      [From $arrow(O H) = 3 dot arrow(O S)$, the point $S$ is one
        third of the way from $O$ to $H$, so
        $ O S : S H = 1 : 2. $

        This ratio is the same for every triangle — it does not
        depend on the one chosen here, though showing that in general
        needs a little more work than this exercise asks for.],
    )
  ]
]

#print-hints()
#print-vocab()
