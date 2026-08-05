// ch-circles-spheres.typ — SPF ONLY.
//
// Registered in main-high.typ alone; ch-circles-spheres is absent from
// the GLF Lehrplan entirely. Because the exclusion happens at
// registration, nothing inside this file needs an only-high wrapper —
// the whole chapter is advanced-level material by construction.
// SPF Lehrplan 2.3 names Kreise und Kugeln together with
// Tangentenprobleme, which is why §5 and §6 are here rather than
// treated as enrichment.

#import "../../common/preamble.typ": *
#import "/src/common/vec-figures.typ": *
#show: chapter-template.with(title: "Everything at the Same Distance")
#let ex = exercise.with(chapter: "Everything at the Same Distance")

= Everything at the Same Distance

#only-theory[
  Lines and planes were built from directions. A circle has no
  direction anywhere on it, so it needs a different idea, and the idea
  is distance: a circle is every point at a fixed distance from a
  fixed centre.

  That definition translates into an equation with no work at all,
  because you already have a formula for distance. And since the
  distance formula in space differs from the one in the plane only by
  a third term, the sphere arrives at the same time and for free.
]

#objectives(
  bfkm[write down the equation of a circle or a sphere from its centre
    and radius, and recover the centre and radius from a general
    equation by completing the square],
  [decide whether a point lies inside, on, or outside a circle or
    sphere],
  [find the intersection of a line with a circle or a sphere, and
    recognize the tangent case],
  [decide whether a plane cuts, touches or misses a sphere, and find
    the circle of intersection],
  [find the tangent line to a circle or the tangent plane to a sphere
    at a given point],
)

== Circles

#definition(title: "Circle")[
  The circle with centre $M = (u, v)$ and radius $r > 0$ is the set of
  points $P = (x, y)$ with $abs(arrow(M P)) = r$, that is
  $ (x - u)^2 + (y - v)^2 = r^2. $
]

#only-theory[
  The equation is the distance formula with both sides squared —
  squaring being worth doing because it removes the root and loses
  nothing, distances being non-negative.

  *Example.* Centre $M = (3, -2)$, radius $r = 5$:
  $ (x - 3)^2 + (y + 2)^2 = 25. $
  Watch the signs. The centre coordinate $-2$ appears in the equation
  as $+2$, because the formula subtracts it.

  Reading backwards is just as direct. From
  $(x + 1)^2 + (y - 4)^2 = 49$ we get $M = (-1, 4)$ and $r = 7$.
]

#only-theory[
  === The general form

  Multiply the equation out and the squares of the centre coordinates
  join the constant:
  $ x^2 + y^2 + D x + E y + F = 0. $

  This is the #vocab("general form", "allgemeine Form"), and it is
  what a circle usually looks like when it turns up in the middle of a
  problem. To recover the centre and radius, complete the square in
  $x$ and in $y$.

  *Example.* $x^2 + y^2 - 6x + 4y - 3 = 0$.

  Group the variables and move the constant across:
  $ (x^2 - 6x) + (y^2 + 4y) = 3. $
  Complete each bracket, adding the same amounts to the right:
  $ (x^2 - 6x + 9) + (y^2 + 4y + 4) = 3 + 9 + 4, $
  $ (x - 3)^2 + (y + 2)^2 = 16. $
  So $M = (3, -2)$ and $r = 4$.
]

#warning[
  Not every equation of that shape is a circle.

  Completing the square leaves some number on the right, and only a
  *positive* number gives a circle:

  - right side $> 0$: a circle of radius $sqrt("that number")$;
  - right side $= 0$: a single point, the centre alone;
  - right side $< 0$: no points at all, since a sum of two squares
    cannot be negative.

  The middle case is easy to miss because the equation looks entirely
  ordinary. $x^2 + y^2 + 6x - 8y + 25 = 0$ completes to
  $(x + 3)^2 + (y - 4)^2 = 0$, which is satisfied only by
  $(-3, 4)$ — a circle of radius zero, if you like, but not a circle.
]

== Spheres

#only-theory[
  Nothing new happens in three dimensions except a third term.
]

#definition(title: "Sphere")[
  The sphere with centre $M = (u, v, w)$ and radius $R > 0$ is the set
  of points $P = (x, y, z)$ with $abs(arrow(M P)) = R$, that is
  $ (x - u)^2 + (y - v)^2 + (z - w)^2 = R^2. $

  Its general form is
  $ x^2 + y^2 + z^2 + D x + E y + F z + G = 0, $
  and completing the square in all three variables recovers $M$ and
  $R$.
]

#only-theory[
  *Example.* $x^2 + y^2 + z^2 - 4x + 6y - 2z - 11 = 0$.
  $ (x^2 - 4x + 4) + (y^2 + 6y + 9) + (z^2 - 2z + 1)
    = 11 + 4 + 9 + 1, $
  $ (x - 2)^2 + (y + 3)^2 + (z - 1)^2 = 25, $
  so $M = (2, -3, 1)$ and $R = 5$.

  The same three degenerate cases apply, with a single point or the
  empty set in place of a sphere.
]

#keybox(title: "Inside, on, or outside")[
  Compare $abs(arrow(M P))^2$ with $R^2$ — squared, so that no roots
  are needed:
  $ abs(arrow(M P))^2 < R^2: "inside", quad
    = R^2: "on", quad
    > R^2: "outside". $
]

#only-theory[
  *Example.* Does $P = (3, 1, 2)$ lie inside
  $(x - 1)^2 + (y + 2)^2 + (z - 2)^2 = 25$?

  The centre is $M = (1, -2, 2)$, and
  $ abs(arrow(M P))^2 = 2^2 + 3^2 + 0^2 = 13 < 25, $
  so $P$ is inside.
]

== A Line Meeting a Sphere

#only-theory[
  Substitute the line's component equations into the sphere's
  equation. Every term is at most quadratic in the parameter, so the
  result is a quadratic equation in $t$ — and a quadratic has two, one
  or no real solutions.

  #auto-parts(
    1,
    [*Two solutions*: the line is a
      #vocab("secant", "Sekante") and cuts the sphere twice.],
    [*One solution*: the line is a
      #vocab("tangent", "Tangente") and touches at a single point.],
    [*No solution*: the line misses the sphere entirely.],
  )

  The discriminant tells you which before you solve, though on a
  problem this size it is usually quicker to solve and look.
]

#only-theory[
  *Example.* Where does the line through $A = (5, 2, 1)$ and
  $B = (6, -1, 2)$ meet the sphere $x^2 + y^2 + z^2 = 41$?

  The direction is $arrow(A B) = vec(1, -3, 1)$, so the line is
  $(5 + t, ; 2 - 3t, ; 1 + t)$. Substituting:
  $ (5 + t)^2 + (2 - 3t)^2 + (1 + t)^2 = 41, $
  $ 25 + 10t + t^2 + 4 - 12t + 9t^2 + 1 + 2t + t^2 = 41, $
  $ 11t^2 + 30 = 41 quad arrow.r.double quad t^2 = 1
    quad arrow.r.double quad t = plus.minus 1. $

  The two points are $(6, -1, 2)$ and $(4, 5, 0)$.

  Notice that the linear term cancelled. That is not luck: it happens
  exactly when the anchor point $A$ is the midpoint of the chord, and
  here $A = (5, 2, 1)$ is indeed halfway between the two answers.
]

== A Plane Meeting a Sphere

#only-theory[
  For a plane there is a better tool than substitution, and it is the
  one from the previous chapter. Compare the distance from the centre
  to the plane with the radius.

  #auto-parts(
    1,
    [$d < R$: the plane cuts the sphere in a *circle*.],
    [$d = R$: the plane is a
      #vocab("tangent plane", "Tangentialebene") and touches at one
      point.],
    [$d > R$: no intersection.],
  )

  When the plane cuts, the circle's centre is the foot of the
  perpendicular from $M$, and its radius follows from Pythagoras:
  $ r = sqrt(R^2 - d^2). $

  #fig(
    vplane(
      s-seg(from: (-1, 1.4), to: (9, 1.4), color: def-col, width: 1.2pt, label: [$E$], anchor: 0.05),
      s-seg(from: (4, 4), to: (4, 1.4), color: warn-col, width: 1.1pt, dashed: true),
      s-seg(from: (4, 4), to: (6.6, 1.4), color: accent, width: 1.1pt),
      s-seg(from: (4, 1.4), to: (6.6, 1.4), color: luma(120), width: 1.1pt),
      s-arc(
        vertex: (4, 1.4), from: (4, 4), to: (6.6, 1.4),
        r: 12pt, right: true, color: luma(130),
      ),
      s-txt((4, 2.7), text(size: 9pt)[$d$], off: (-10pt, 0pt)),
      s-txt((5.3, 2.7), text(size: 9pt)[$R$], off: (8pt, -2pt)),
      s-txt((5.3, 1.4), text(size: 9pt)[$r$], off: (0pt, 11pt)),
      s-pt((4, 4), label: $M$),
      xmin: -1.5, xmax: 10.5, ymin: 0.5, ymax: 4.5,
      unit: 0.55cm, grid: false, axes: false,
    ),
    caption: [Seen edge-on. The radius $R$, the distance $d$ and the
      cut circle's radius $r$ form a right triangle.],
  )
]

#only-theory[
  *Example.* Take the plane $E: x + 2y + 2z + 4 = 0$, whose normal has
  length $3$, and three spheres all centred at $M = (1, 1, 1)$.

  The distance from the centre to the plane is the same in all three
  cases:
  $ d = (1 + 2 + 2 + 4)/3 = 3. $

  - *$R = 5$.* Since $3 < 5$, the plane cuts the sphere. The circle
    has radius $sqrt(25 - 9) = 4$, and its centre is the foot of the
    perpendicular,
    $ M - 3 dot arrow(e)_n = vec(1, 1, 1) - vec(1, 2, 2)
      = vec(0, -1, -1), $
    which does lie on $E$: $0 - 2 - 2 + 4 = 0$. ✓
  - *$R = 3$.* Now $d = R$, so $E$ is a tangent plane, touching at the
    single point $(0, -1, -1)$.
  - *$R = 2$.* Since $3 > 2$, the plane misses the sphere completely.

  One plane, one distance calculation, three different answers
  depending only on the radius.
]

== Tangents

#only-theory[
  A tangent touches without crossing, and the useful characterization
  is perpendicularity: *a tangent line or plane at a point $T$ is
  perpendicular to the radius $arrow(M T)$*.

  That turns every tangent problem into a normal-vector problem, which
  you can already solve.
]

#keybox(title: "Tangent at a point")[
  For a sphere with centre $M$ and a point $T$ *on* it, the tangent
  plane at $T$ is the plane through $T$ with normal
  $arrow(n) = arrow(M T)$.

  For a circle with centre $M$ and $T$ on it, the tangent line at $T$
  is the line through $T$ with normal $arrow(n) = arrow(M T)$.
]

#only-theory[
  *Example — circle.* Find the tangent to
  $(x - 3)^2 + (y + 2)^2 = 25$ at $T = (6, 2)$.

  First check that $T$ is on the circle: $3^2 + 4^2 = 25$ ✓. Then
  $arrow(M T) = vec(3, 4)$ is the normal, so the tangent is
  $ 3(x - 6) + 4(y - 2) = 0 quad arrow.r.double quad
    3x + 4y - 26 = 0. $

  *Example — sphere.* Find the tangent plane to
  $(x - 1)^2 + (y - 1)^2 + (z - 1)^2 = 9$ at $T = (0, -1, -1)$.

  Check: $1 + 4 + 4 = 9$ ✓. The normal is
  $arrow(M T) = vec(-1, -2, -2)$, so the plane is
  $ -(x - 0) - 2(y + 1) - 2(z + 1) = 0
    quad arrow.r.double quad x + 2y + 2z + 4 = 0, $
  which is exactly the tangent plane found in the previous section by
  the distance method. Two routes, one answer.
]

#look-ahead(preview: [conic sections])[
  A circle is the first of a family. Slice a cone with a plane and you
  get a circle when the cut is perpendicular to the axis — but tilt
  the plane and the same construction yields an ellipse, then a
  parabola, then a hyperbola.

  All four have equations of the general quadratic shape
  $ A x^2 + B x y + C y^2 + D x + E y + F = 0, $
  of which the circle's equation is the special case $A = C$ and
  $B = 0$. Completing the square, which you have just used to find a
  centre and radius, is the same technique that will find the centre
  and axes of an ellipse.
]

#ex(difficulty: 1, time: "10 min", calculator: false)[
  #auto-parts(
    1,
    [Write down the equation of the circle with centre
      $M = (-4, 3)$ and radius $r = 6$.],
    [Write down the equation of the sphere with centre
      $M = (2, -1, 4)$ and radius $R = 3$.],
    [Find the centre and radius of the sphere with
      $A = (1, -3, 0)$ and $B = (5, 1, 4)$ as endpoints of a
      diameter.],
    [Find the equation of the sphere with centre $M = (1, -2, 2)$
      passing through $A = (5, 1, 2)$.],
  )
][
  #auto-parts(
    1,
    [$(x + 4)^2 + (y - 3)^2 = 36$.],
    [$(x - 2)^2 + (y + 1)^2 + (z - 4)^2 = 9$.],
    [The centre is the midpoint, $M = (3, -1, 2)$, and the radius is
      half the diameter:
      $abs(arrow(A B)) = sqrt(16 + 16 + 16) = 4 sqrt(3)$, so
      $R = 2 sqrt(3)$ and $R^2 = 12$:
      $ (x - 3)^2 + (y + 1)^2 + (z - 2)^2 = 12. $],
    [$R = abs(arrow(M A)) = sqrt(16 + 9 + 0) = 5$, so
      $ (x - 1)^2 + (y + 2)^2 + (z - 2)^2 = 25. $],
  )
]

#ex(difficulty: 2, time: "14 min", calculator: false)[
  Find the centre and radius, or explain why the equation does not
  describe a circle or a sphere.

  #auto-parts(
    1,
    [$x^2 + y^2 + 8x - 10y + 5 = 0$],
    [$x^2 + y^2 - 8x + 6y = 0$],
    [$x^2 + y^2 + z^2 + 2x - 4y + 6z - 2 = 0$],
    [$x^2 + y^2 + z^2 + 12x - 6z + 9 = 0$],
    [$x^2 + y^2 + 6x - 8y + 25 = 0$],
  )
][
  #auto-parts(
    1,
    [$(x + 4)^2 + (y - 5)^2 = -5 + 16 + 25 = 36$, so $M = (-4, 5)$
      and $r = 6$.],
    [$(x - 4)^2 + (y + 3)^2 = 0 + 16 + 9 = 25$, so $M = (4, -3)$ and
      $r = 5$. The missing constant term simply means the circle
      passes through the origin — check: $0 + 0 - 0 + 0 = 0$ ✓.],
    [$(x + 1)^2 + (y - 2)^2 + (z + 3)^2 = 2 + 1 + 4 + 9 = 16$, so
      $M = (-1, 2, -3)$ and $R = 4$.],
    [$(x + 6)^2 + y^2 + (z - 3)^2 = -9 + 36 + 9 = 36$, so
      $M = (-6, 0, 3)$ and $R = 6$. The absent $y$ term means the
      centre has $y = 0$, not that anything is wrong.],
    [$(x + 3)^2 + (y - 4)^2 = -25 + 9 + 16 = 0$. *Not a circle* — the
      only solution is the single point $(-3, 4)$.],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  #auto-parts(
    1,
    [Does $P = (0, -1, 3)$ lie inside, on, or outside the sphere
      $(x + 1)^2 + (y - 2)^2 + (z - 3)^2 = 9$?],
    [Does $Q = (3, 1, 2)$ lie inside, on, or outside
      $(x - 1)^2 + (y + 2)^2 + (z - 2)^2 = 25$?],
  )
][
  #auto-parts(
    1,
    [$abs(arrow(M P))^2 = 1 + 9 + 0 = 10 > 9$, so $P$ is *outside* —
      but only just, at distance $sqrt(10) approx 3.16$ against a
      radius of $3$.],
    [$abs(arrow(M Q))^2 = 4 + 9 + 0 = 13 < 25$, so $Q$ is *inside*.],
  )

  Comparing squares avoids two square roots and any rounding. There is
  never a reason to take the roots in this kind of question.
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  Find the points of intersection of the circle and the line.

  #auto-parts(
    1,
    [$c: x^2 + y^2 = 100$ and $l: y = 2x + 10$],
    [$c: x^2 + y^2 + 6x - 8y + 25 = 0$ and $l: 3x + y + 5 = 0$],
  )
][
  #auto-parts(
    1,
    [Substituting, $x^2 + (2x + 10)^2 = 100$, so
      $5x^2 + 40x = 0$ and $x = 0$ or $x = -8$. The points are
      $(0, 10)$ and $(-8, -6)$.],
    [From the previous exercise, this "circle" is the single point
      $(-3, 4)$. The line passes through it, since
      $-9 + 4 + 5 = 0$, so the intersection is the one point
      $(-3, 4)$.

      Substituting blindly also works and produces a quadratic with a
      repeated root — but it looks like a tangent, which is a
      different situation. Recognising the degenerate circle first is
      what keeps the answer honest.],
  )
]

#ex(difficulty: 3, time: "14 min", calculator: false, hints: (
  "Write the line in parametric form first, then substitute all three components.",
  "You should reach a quadratic in t. Solve it, then convert each root back to a point.",
))[
  Find the points where the line through $A$ and $B$ meets the sphere
  $s$.

  #auto-parts(
    1,
    [$s: x^2 + y^2 + z^2 = 41$, #h(4pt) $A = (5, 2, 1)$,
      $B = (6, -1, 2)$],
    [$s: (x - 2)^2 + (y + 5)^2 + z^2 = 81$, #h(4pt)
      $A = (9, 5, 16)$, $B = (14, 7, 21)$],
  )
][
  #auto-parts(
    1,
    [Direction $vec(1, -3, 1)$, so the line is
      $(5 + t, 2 - 3t, 1 + t)$ and substitution gives
      $11t^2 + 30 = 41$, hence $t = plus.minus 1$ and the points
      $(6, -1, 2)$ and $(4, 5, 0)$.],
    [Direction $vec(5, 2, 5)$, so the line is
      $(9 + 5t, 5 + 2t, 16 + 5t)$ and substitution gives
      $ (7 + 5t)^2 + (10 + 2t)^2 + (16 + 5t)^2 = 81, $
      $ 54t^2 + 270t + 405 = 81 quad arrow.r.double quad
        t^2 + 5t + 6 = 0, $
      so $t = -2$ or $t = -3$, giving $(-1, 1, 6)$ and
      $(-6, -1, 1)$.

      Both roots are negative, meaning the sphere lies "behind" $A$
      relative to the direction $arrow(A B)$ — worth noticing, but not
      a problem: a line is infinite in both directions.],
  )
]

#ex(difficulty: 3, time: "16 min", calculator: false)[
  The plane $E: x + 2y + 2z + 4 = 0$ is tested against three spheres,
  all with centre $M = (1, 1, 1)$.

  #auto-parts(
    1,
    [Find the distance from $M$ to $E$.],
    [For $R = 5$, show that $E$ cuts the sphere and find the centre
      and radius of the circle of intersection.],
    [For $R = 3$, show that $E$ is a tangent plane and find the point
      of contact.],
    [For $R = 2$, show that $E$ misses the sphere.],
    [Verify your answer to (c) a second way, by computing the tangent
      plane to the $R = 3$ sphere at the point you found.],
  )
][
  #auto-parts(
    1,
    [$abs(arrow(n)) = 3$, so
      $d = (1 + 2 + 2 + 4) slash 3 = 3$.],
    [$d = 3 < 5 = R$, so the plane cuts. The circle's centre is the
      foot of the perpendicular from $M$:
      $ M - 3 dot arrow(e)_n = vec(1, 1, 1) - vec(1, 2, 2)
        = vec(0, -1, -1), $
      which lies on $E$ since $0 - 2 - 2 + 4 = 0$ ✓. Its radius is
      $sqrt(R^2 - d^2) = sqrt(25 - 9) = 4$.],
    [$d = 3 = R$, so $E$ touches. The point of contact is the same
      foot of the perpendicular, $(0, -1, -1)$.],
    [$d = 3 > 2 = R$, so every point of the plane is further from $M$
      than the radius, and there is no intersection.],
    [$T = (0, -1, -1)$ lies on the $R = 3$ sphere, since
      $1 + 4 + 4 = 9$ ✓. The tangent plane there has normal
      $arrow(M T) = vec(-1, -2, -2)$, giving
      $ -(x - 0) - 2(y + 1) - 2(z + 1) = 0
        quad arrow.r.double quad x + 2y + 2z + 4 = 0, $
      which is $E$ itself. ✓],
  )
]

#ex(difficulty: 3, time: "16 min", calculator: false, hints: (
  "Points equidistant from A and B lie on the perpendicular bisector of AB. Find its equation first.",
  "Then intersect that line with the circle.",
))[
  Which points of the circle $c: (x - 1)^2 + (y + 5)^2 = 65$ are
  equidistant from $A = (-4, 7)$ and $B = (2, 3)$?
][
  Points equidistant from $A$ and $B$ form the perpendicular bisector
  of $A B$. Its midpoint is $(-1, 5)$ and $arrow(A B) = vec(6, -4)$
  serves as normal, so
  $ 6(x + 1) - 4(y - 5) = 0 quad arrow.r.double quad
    3x - 2y + 13 = 0, $
  that is $y = (3x + 13) slash 2$.

  Substituting into the circle and multiplying by $4$:
  $ 4(x - 1)^2 + (3x + 23)^2 = 260, $
  $ 13x^2 + 130x + 273 = 0 quad arrow.r.double quad
    x^2 + 10x + 21 = 0, $
  so $x = -3$ or $x = -7$, giving
  $ P_1 = (-3, 2) quad "and" quad P_2 = (-7, -4). $

  *Check.* Both must lie on $c$: for $P_1$,
  $16 + 49 = 65$ ✓; for $P_2$, $64 + 1 = 65$ ✓.
]

#print-hints()
#print-vocab()
