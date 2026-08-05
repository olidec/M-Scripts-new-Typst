#import "../../common/preamble.typ": *
#import "/src/common/vec-figures.typ": *
#show: chapter-template.with(title: "A Point and a Normal")
#let ex = exercise.with(chapter: "A Point and a Normal")

= A Point and a Normal

#only-theory[
  A line in space was a point and a direction. A plane is a point and
  *two* directions — which is the obvious generalization, and it works,
  and it is not the description you will end up using most.

  The useful description of a plane is a point and one direction
  *perpendicular* to it. That was unavailable in Part A, because
  producing a perpendicular to two given directions took a system of
  equations rather than a formula. With the cross product in hand, the
  two descriptions are a single calculation apart, and this chapter is
  largely about travelling between them.
]

#objectives(
  bfkm[write down the parametric and the Cartesian equation of a plane,
    and convert between them],
  [find the equation of a plane through three points, through a point
    and a line, or through a point parallel to a given plane],
  [decide whether a point lies on a plane],
  [read a plane's normal vector off its Cartesian equation],
  [find a plane's axis intercepts and sketch it],
  [recognize from its equation when a plane is parallel to an axis or
    to a coordinate plane],
)

== Two Directions

#only-theory[
  To reach any point of a plane from a fixed point $A$ in it, travel
  some amount along one direction in the plane and some amount along
  another. Two independent directions and two independent amounts —
  hence two parameters.
]

#definition(title: "Parametric equation of a plane")[
  If $A$ lies in the plane $E$, and $arrow(u)$ and $arrow(v)$ are two
  non-parallel vectors parallel to $E$, then
  $ E: arrow(r) = arrow(r)_A + t dot arrow(u) + s dot arrow(v),
    quad t, s in RR. $

  This is the #vocab("parametric equation", "Parametergleichung") of
  the plane.
]

#only-theory[
  #fig(
    space3d(
      ..plane-patch((1, 2, 1), (2, 0, 1), (0, 2, 1), lo: -1, hi: 2.2),
      s-vec(from: (1, 2, 1), to: (3, 2, 2), color: warn-col, label: $arrow(u)$),
      s-vec(from: (1, 2, 1), to: (1, 4, 2), color: def-col, label: $arrow(v)$),
      s-pt((1, 2, 1), label: $A$),
      axis-len: (4, 6, 4.5),
      unit: 0.6cm,
    ),
    caption: [One point and two independent directions. Every point of
      the plane is $A$ plus some combination of $arrow(u)$ and
      $arrow(v)$.],
  )

  The word *non-parallel* is doing real work. If $arrow(u)$ and
  $arrow(v)$ were parallel, every combination of them would lie along
  a single line, and the equation would describe a line rather than a
  plane. In the language of Part A, the two directions must be
  linearly independent.

  Count the parameters and you can read off the dimension. One
  parameter sweeps out a line; two sweep out a plane; and if you ever
  meet an equation with three, it describes all of space.
]

#only-theory[
  *Example.* Find a parametric equation of the plane through
  $A = (1, 1, 1)$, $B = (3, 1, 0)$ and $C = (5, 0, 0)$.

  Any two of the six vectors joining these points will do as
  directions, provided they are not parallel. Taking
  $ arrow(A B) = vec(2, 0, -1), quad arrow(A C) = vec(4, -1, -1), $
  which are not multiples of one another, gives
  $ E: arrow(r) = vec(1, 1, 1) + t dot vec(2, 0, -1)
    + s dot vec(4, -1, -1). $
]

#warning[
  A plane has infinitely many parametric equations — even more freely
  than a line did, since both the anchor point *and* both directions
  can be changed.

  Using $B$ as the anchor with directions $arrow(B A)$ and
  $arrow(B C)$ gives an equally correct answer that looks nothing
  like the one above. As with lines, a different-looking answer is not
  evidence of an error.
]

== One Direction, Perpendicular

#only-theory[
  Now the other description. Fix a point $A$ and a vector $arrow(n)$
  perpendicular to the plane — a
  #vocab("normal vector", "Normalenvektor"). A point $P$ lies in the
  plane exactly when the journey from $A$ to $P$ stays in the plane,
  which is to say exactly when $arrow(A P)$ is perpendicular to
  $arrow(n)$.

  That is one dot product set to zero.
]

#definition(title: "Normal form of a plane")[
  $ E: arrow(n) dot (arrow(r) - arrow(r)_A) = 0, $
  equivalently $arrow(n) dot arrow(A P) = 0$ for every point $P$ of
  $E$.
]

#only-theory[
  #fig(
    space3d(
      ..plane-patch((2, 2.5, 1), (2, 0, 0), (0, 2, 0), lo: -1, hi: 1),
      s-vec(
        from: (2, 2.5, 1), to: (2, 2.5, 3.5),
        color: warn-col, label: $arrow(n)$,
      ),
      s-vec(from: (2, 2.5, 1), to: (3.6, 4.1, 1), color: def-col, label: $arrow(A P)$),
      s-pt((2, 2.5, 1), label: $A$),
      s-pt((3.6, 4.1, 1), label: $P$),
      s-arc(
        vertex: (2, 2.5, 1), from: (2, 2.5, 3.5), to: (2, 4.5, 1),
        r: 13pt, right: true, color: warn-col,
      ),
      axis-len: (4.5, 5.5, 4.5),
      unit: 0.6cm,
    ),
    caption: [$arrow(n)$ is perpendicular to *every* vector lying in the
      plane, so it is perpendicular to the whole plane at once.],
  )

  Multiplying the normal form out is where the familiar equation comes
  from. Write $arrow(n) = vec(a, b, c)$ and $P = (x, y, z)$:
  $ vec(a, b, c) dot vec(x - a_x, y - a_y, z - a_z) = 0, $
  $ a x + b y + c z - (a a_x + b a_y + c a_z) = 0. $
  The bracket is a fixed number determined by $arrow(n)$ and $A$; call
  it $-d$.
]

#definition(title: "Cartesian equation of a plane")[
  $ E: a x + b y + c z + d = 0, $
  where $vec(a, b, c) = arrow(n)$ is a normal vector of $E$.

  This is the #vocab("Cartesian equation", "Koordinatengleichung"),
  also called the coordinate equation.
]

#keybox(title: "Read the normal off the equation")[
  The coefficients of $x$, $y$ and $z$ *are* the components of a
  normal vector. From $2x - 3y + 6z - 5 = 0$ you can write down
  $arrow(n) = vec(2, -3, 6)$ without any calculation at all.
]

#only-theory[
  This is the single most useful fact in Part B, and it is worth
  noticing how cheaply it arrived: the coefficients are the normal
  because the equation *is* a dot product with the normal, rearranged.

  Deciding whether a point lies on a plane in this form is also
  trivial — substitute and see whether the equation holds. Compare
  that with the parametric form, where you must solve for $t$ and $s$
  first. That asymmetry is why the Cartesian form is preferred for
  almost every calculation in the rest of this unit.
]

== Converting Between the Two Forms

#only-theory[
  === Parametric to Cartesian, the slow way

  Eliminate the parameters. With
  $E: arrow(r) = vec(1, 0, 0) + t dot vec(1, 1, 0)
  + s dot vec(0, 1, 1)$, the component equations are
  $ x = 1 + t, quad y = t + s, quad z = s. $
  The first gives $t = x - 1$ and the third gives $s = z$.
  Substituting both into the second,
  $ y = (x - 1) + z quad arrow.r.double quad x - y + z - 1 = 0. $

  This always works, and on a bad day it is a long slog through a
  system of three equations.
]

#only-theory[
  === Parametric to Cartesian, the fast way

  The two direction vectors both lie in the plane, so anything
  perpendicular to both is a normal vector — and the cross product
  produces one immediately.

  Check it on the same example:
  $ vec(1, 1, 0) times vec(0, 1, 1) = vec(1, -1, 1), $
  which is the coefficient triple we ground out above. Then $d$ comes
  from substituting the known point $(1, 0, 0)$:
  $ 1 - 0 + 0 + d = 0 quad arrow.r.double quad d = -1, $
  giving $x - y + z - 1 = 0$ again, in two lines instead of six.
]

#keybox(title: "Parametric to Cartesian")[
  + $arrow(n) = arrow(u) times arrow(v)$ gives the coefficients.
  + Substitute the anchor point to find $d$.
]

#only-theory[
  *Worked example.* Convert
  $ E: arrow(r) = vec(2, -5, 3) + t dot vec(1, -1, 2)
    + s dot vec(3, 1, 1) $
  to Cartesian form.

  $ arrow(n) = vec(1, -1, 2) times vec(3, 1, 1) = vec(-3, 5, 4), $
  so the equation is $-3x + 5y + 4z + d = 0$. Substituting
  $(2, -5, 3)$:
  $ -6 - 25 + 12 + d = 0 quad arrow.r.double quad d = 19, $
  $ E: -3x + 5y + 4z + 19 = 0. $

  *Check.* The anchor must satisfy it, and it does. Better still,
  check one of the direction vectors: it must be perpendicular to the
  normal, and $vec(-3, 5, 4) dot vec(1, -1, 2) = -3 - 5 + 8 = 0$. Two
  independent checks, four multiplications each.
]

#only-theory[
  === Cartesian to parametric

  Going back is a matter of finding one point and two independent
  directions perpendicular to the normal.

  For $E: 2x + 3y + 6z - 12 = 0$, the point $(6, 0, 0)$ works, since
  $12 - 12 = 0$. For directions, any two independent vectors with
  $arrow(n) dot arrow(u) = 0$ — solve $2u_x + 3u_y + 6u_z = 0$ twice
  with different free choices. Taking $u_z = 0$ gives
  $vec(-3, 2, 0)$; taking $u_y = 0$ gives $vec(-3, 0, 1)$. So
  $ E: arrow(r) = vec(6, 0, 0) + t dot vec(-3, 2, 0)
    + s dot vec(-3, 0, 1). $

  A quicker route when the intercepts are convenient: find three
  points on the plane and build the directions as differences. Here
  the three intercepts $(6, 0, 0)$, $(0, 4, 0)$ and $(0, 0, 2)$ are
  the obvious candidates.
]

== Intercepts and Sketching

#only-theory[
  Setting two of the three variables to zero gives an axis intercept,
  and three intercepts are enough to draw the plane — as the triangle
  they cut out in the first octant.

  For $E: 2x + 3y + 6z - 12 = 0$: setting $y = z = 0$ gives $x = 6$,
  and similarly $y = 4$ and $z = 2$.

  #fig(
    space3d(
      ..plane-intercepts(6, 4, 2),
      s-pt((6, 0, 0), label: $S_x$, off: (13pt, 9pt), r: 1.8pt),
      s-pt((0, 4, 0), label: $S_y$, off: (6pt, 12pt), r: 1.8pt),
      s-pt((0, 0, 2), label: $S_z$, off: (-14pt, -4pt), r: 1.8pt),
      axis-len: (7.5, 5.5, 3.5),
      unit: 0.5cm,
    ),
    caption: [The intercept triangle of $2x + 3y + 6z - 12 = 0$. The
      plane continues past it in every direction; the triangle is only
      the part in the first octant.],
  )

  Remember that the triangle is *not* the plane. A plane is unbounded;
  the triangle is the piece of it visible in one octant, and it is
  drawn because it is the piece that can be drawn.
]

#warning[
  A plane need not have three intercepts.

  If a variable is missing from the equation, its coefficient is zero,
  and setting the other two variables to zero gives an impossible
  equation — there is no intercept on that axis. What has happened
  geometrically is that the plane runs *parallel* to that axis.

  - $5x - 6y + 30 = 0$ has no $z$ term, so it is parallel to the
    $z$#"‑"axis. It cuts the $x$#"‑"axis at $-6$ and the $y$#"‑"axis at
    $5$, and rises vertically forever.
  - $z - 3 = 0$ has neither $x$ nor $y$, so it is parallel to both
    those axes — that is, parallel to the $x y$#"‑"plane, three units
    above it.

  A missing variable is information, not an omission.
]

#remark[
  Here is the pattern promised at the end of the chapter on lines.

  A single equation in two variables, $a x + b y + c = 0$, describes a
  line — a one-dimensional object in a two-dimensional world. A single
  equation in three variables, $a x + b y + c z + d = 0$, describes a
  plane — a two-dimensional object in a three-dimensional world.

  In both cases the equation costs exactly one dimension. This is why
  a line in space cannot be written as one equation: a line is *two*
  dimensions short of space, so it needs two equations, or the
  parametric form with its one free parameter. The number of
  parameters counts up from nothing; the number of equations counts
  down from everything.
]

#look-ahead(preview: [intersections and distances])[
  With planes described in both forms, the questions that occupied
  Chapter 0 become computable.

  *Where does a line pierce a plane?* Substitute the line's component
  equations into the plane's Cartesian equation. One equation, one
  unknown.

  *What polygon does a plane cut from a cube?* Intersect the plane's
  equation with each of the twelve edges in turn. Twelve short
  calculations and no imagination required — and the hexagon you drew
  by eye in the first chapter comes out exactly.
]

#ex(difficulty: 1, time: "10 min", calculator: false)[
  Find a parametric equation of the plane through
  $A = (1, -2, 4)$, $B = (3, -2, 2)$ and $C = (2, 5, -2)$.

  Then write down a second, different-looking parametric equation for
  the same plane, and explain why both are correct.
][
  $ arrow(A B) = vec(2, 0, -2), quad arrow(A C) = vec(1, 7, -6), $
  which are not parallel, so
  $ E: arrow(r) = vec(1, -2, 4) + t dot vec(2, 0, -2)
    + s dot vec(1, 7, -6). $

  A second version, anchored at $C$ and using
  $arrow(C A)$ and $arrow(C B)$:
  $ E: arrow(r) = vec(2, 5, -2) + t dot vec(-1, -7, 6)
    + s dot vec(1, -7, 4). $

  Both are correct because a parametric equation records a point of
  the plane and two independent directions in it — and nothing else.
  Any valid choice of those three ingredients describes the same set
  of points.
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  Find the Cartesian equation of each plane.

  #auto-parts(
    1,
    [$E: arrow(r) = vec(2, 5, -3) + t dot vec(-1, 4, 0)
      + s dot vec(0, -2, 6)$],
    [The plane through $A = (1, 1, 1)$, $B = (3, 1, 0)$ and
      $C = (5, 0, 0)$.],
  )

  In each case, verify your answer with the direction-perpendicularity
  check.
][
  #auto-parts(
    1,
    [$vec(-1, 4, 0) times vec(0, -2, 6) = vec(24, 6, 2)$, which
      simplifies to $vec(12, 3, 1)$. Substituting $(2, 5, -3)$:
      $24 + 15 - 3 + d = 0$, so $d = -36$ and
      $ E: 12x + 3y + z - 36 = 0. $
      *Check:* $vec(12, 3, 1) dot vec(-1, 4, 0) = -12 + 12 = 0$. ✓],
    [$arrow(A B) = vec(2, 0, -1)$ and $arrow(A C) = vec(4, -1, -1)$,
      with
      $arrow(A B) times arrow(A C) = vec(-1, -2, -2)$, which we may
      replace by $vec(1, 2, 2)$. Substituting $A$:
      $1 + 2 + 2 + d = 0$, so $d = -5$ and
      $ E: x + 2y + 2z - 5 = 0. $
      *Check:* $B$ gives $3 + 2 + 0 - 5 = 0$ ✓ and $C$ gives
      $5 + 0 + 0 - 5 = 0$ ✓.],
  )

  In (b) the normal was multiplied by $-1$ to tidy it. This is always
  allowed: any non-zero multiple of a normal vector is also a normal
  vector, and multiplying the whole equation by a constant does not
  change the plane.
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Consider the plane $E: x + 2y + 2z - 5 = 0$.

  #auto-parts(
    1,
    [Which of the points $P = (1, 0, 2)$, $Q = (2, 1, 2)$ and
      $R = (-1, 3, 0)$ lie on $E$?],
    [Write down a normal vector of $E$, and give its magnitude.],
    [Find a parametric equation for $E$.],
  )
][
  #auto-parts(
    1,
    [$P$: $1 + 0 + 4 - 5 = 0$ ✓ on the plane.
      $Q$: $2 + 2 + 4 - 5 = 3 eq.not 0$, not on the plane.
      $R$: $-1 + 6 + 0 - 5 = 0$ ✓ on the plane.],
    [$arrow(n) = vec(1, 2, 2)$, with
      $abs(arrow(n)) = sqrt(1 + 4 + 4) = 3$. A normal of magnitude
      exactly $3$ is a small gift; it will matter in the chapter on
      distances.],
    [Use two of the points found in (a) with a third point of the
      plane. Taking $P$ as anchor,
      $arrow(P R) = vec(-2, 3, -2)$ and, from the point
      $(5, 0, 0)$ which also satisfies the equation,
      $arrow(P S) = vec(4, 0, -2)$:
      $ E: arrow(r) = vec(1, 0, 2) + t dot vec(-2, 3, -2)
        + s dot vec(4, 0, -2). $
      *Check:* both directions must be perpendicular to
      $vec(1, 2, 2)$: $-2 + 6 - 4 = 0$ ✓ and $4 + 0 - 4 = 0$ ✓.],
  )
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  Find the axis intercepts of each plane. Say clearly when one does
  not exist and what that means geometrically.

  #auto-parts(
    2,
    [$4x + 2y + 6z - 24 = 0$],
    [$2x + 5y - 4z - 20 = 0$],
    [$2x + 4y - 3z - 18 = 0$],
    [$5x - 6y + 30 = 0$],
  )
][
  #auto-parts(
    2,
    [$p = 6$, $q = 12$, $r = 4$.],
    [$p = 10$, $q = 4$, $r = -5$.],
    [$p = 9$, $q = 9 slash 2$, $r = -6$.],
    [$p = -6$, $q = 5$, and *no* $z$#"‑"intercept: the $z$ term is
      missing, so the plane is parallel to the $z$#"‑"axis and never
      meets it.],
  )

  Negative intercepts, as in (b) and (c), are perfectly ordinary —
  they simply mean the plane crosses that axis on the negative side of
  the origin. They cannot be drawn inside the first-octant triangle,
  which is one reason that triangle is a partial picture.
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  #auto-parts(
    1,
    [Find the Cartesian equation of the plane through
      $Q = (2, 2, -2)$ parallel to $E: x - 2y - 3z = 0$.],
    [Find the Cartesian equation of the plane through
      $Q = (2, -3, -1)$ with normal vector $arrow(n) = vec(1, -2, 4)$.],
    [What do the two planes in (a) have in common, and what
      distinguishes them?],
  )
][
  #auto-parts(
    1,
    [Parallel planes share a normal, so the equation is
      $x - 2y - 3z + d = 0$. Substituting $Q$:
      $2 - 4 + 6 + d = 0$, so $d = -4$ and the plane is
      $x - 2y - 3z - 4 = 0$.],
    [$x - 2y + 4z + d = 0$ with $2 + 6 - 4 + d = 0$, so $d = -4$ and
      the plane is $x - 2y + 4z - 4 = 0$.],
    [The two planes in (a) have the same normal vector and therefore
      the same orientation in space; they differ only in the constant
      $d$, which slides the plane back and forth along the normal
      direction without turning it.

      This is worth remembering: in $a x + b y + c z + d = 0$, the
      first three coefficients fix the *direction* the plane faces and
      $d$ fixes *which* of the parallel family it is.],
  )
]

#ex(difficulty: 3, time: "14 min", calculator: false, hints: (
  "A plane containing a line contains the line's direction vector — that is one of the two directions you need.",
  "For the second direction, join the given point to any point of the line.",
))[
  Find the Cartesian equation of the plane $E$ that passes through
  $P = (4, 2, 1)$ and contains the line
  $ g: arrow(r) = vec(2, 1, 3) + t dot vec(1, -3, 1). $
][
  The plane contains $g$, so it contains both the direction
  $vec(1, -3, 1)$ and the anchor point $A = (2, 1, 3)$. It also
  contains $P$, so a second direction is
  $ arrow(A P) = vec(2, 1, -2). $
  These two are not parallel, so
  $ arrow(n) = vec(2, 1, -2) times vec(1, -3, 1)
    = vec(-5, -4, -7), $
  which we tidy to $vec(5, 4, 7)$. Substituting $A = (2, 1, 3)$:
  $ 10 + 4 + 21 + d = 0 quad arrow.r.double quad d = -35, $
  $ E: 5x + 4y + 7z - 35 = 0. $

  *Check.* $P$ must lie on it: $20 + 8 + 7 - 35 = 0$ ✓. And a second
  point of $g$, say $t = 1$ giving $(3, -2, 4)$:
  $15 - 8 + 28 - 35 = 0$ ✓.
]

#ex(difficulty: 3, time: "10 min", calculator: false)[
  Does the origin lie on the plane through $A = (-2, 0, 1)$,
  $B = (4, 0, -2)$ and $C = (-1, -4, 3)$?

  Answer the question twice: once by finding the plane's equation,
  and once by a shorter argument.
][
  *The long way.* $arrow(A B) = vec(6, 0, -3)$ and
  $arrow(A C) = vec(1, -4, 2)$, so
  $ arrow(n) = arrow(A B) times arrow(A C) = vec(-12, -15, -24), $
  which tidies to $vec(4, 5, 8)$. Substituting $A$:
  $-8 + 0 + 8 + d = 0$, so $d = 0$ and the plane is
  $4x + 5y + 8z = 0$. A plane whose constant term is zero passes
  through the origin, so the answer is *yes*.

  *The short way.* The origin lies in the plane through $A$, $B$, $C$
  exactly when the three position vectors $arrow(r)_A$,
  $arrow(r)_B$, $arrow(r)_C$ all lie in one plane through the origin —
  that is, when the four points $O$, $A$, $B$, $C$ are coplanar. That
  is one scalar triple product:
  $ (arrow(A B) times arrow(A C)) dot arrow(A O)
    = vec(-12, -15, -24) dot vec(2, 0, -1) = -24 + 0 + 24 = 0. $
  Zero, so yes.

  The short way is shorter only if you already needed the cross
  product; here you did. Notice that it also answers a question the
  long way does not: *how far* the origin is from the plane would come
  from the same numbers, and that is the next chapter but one.
]

#only-high[
  #ex(difficulty: 3, time: "16 min", calculator: false, hints: (
    "Find the three intercepts in terms of c first.",
    "The solid is a pyramid with a right-angled triangle as its base and one edge along an axis as its height.",
  ))[
    The plane $E: 9x + 16y + c dot z - 144 = 0$ meets the $x$#"‑",
    $y$#"‑" and $z$#"‑"axes at $A$, $B$ and $C$ respectively.

    Determine $c$ so that the pyramid $O A B C$, where $O$ is the
    origin, has volume $V = 384$.
  ][
    The intercepts are
    $ A = (16, 0, 0), quad B = (0, 9, 0), quad
      C = (0, 0, 144/c), $
    which requires $c eq.not 0$.

    The pyramid has the right triangle $O A B$ in the
    $x y$#"‑"plane as its base, with area
    $1/2 dot 16 dot 9 = 72$, and height $abs(144 slash c)$. So
    $ V = 1/3 dot 72 dot abs(144/c) = 3456/abs(c). $

    Setting this equal to $384$ gives $abs(c) = 3456 slash 384 = 9$,
    so
    $ c = plus.minus 9. $

    Both signs are genuine answers. $c = 9$ puts $C$ at $(0, 0, 16)$
    and $c = -9$ puts it at $(0, 0, -16)$; the two pyramids are
    mirror images in the $x y$#"‑"plane and have equal volume.
    Reporting only the positive one loses half the answer.
  ]
]

#print-hints()
#print-vocab()
