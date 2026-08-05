#import "../../common/preamble.typ": *
#import "/src/common/vec-figures.typ": *
#show: chapter-template.with(title: "How Far Off")
#let ex = exercise.with(chapter: "How Far Off")

= How Far Off

#only-theory[
  Every angle formula so far divided a dot product by *two*
  magnitudes. This chapter divides one by a single magnitude — the
  normal's — and what comes out is a length.

  That is the whole idea, and it is worth stating before any notation
  arrives: dotting with a *unit* normal measures how far you have
  travelled perpendicular to a plane. Since the plane is exactly the
  set of points where that measurement is zero, the same number for
  any other point is its distance from the plane.
]

#objectives(
  bfkm[calculate the distance from a point to a plane, and from a
    point to a line],
  [put a plane or a line into Hesse normal form and use the sign of
    the result],
  [find the distance between two parallel planes or lines, and
    construct a plane parallel to a given one at a prescribed
    distance],
  [find the foot of the perpendicular from a point to a plane, and the
    reflection of the point in the plane],
)

== Dotting with a Unit Normal

#only-theory[
  Let $E$ be a plane with normal $arrow(n)$, let $A$ be a point of $E$
  and let $P$ be any point at all.

  Split $arrow(A P)$ into a part lying in the plane and a part
  perpendicular to it — the resolution you met in the chapter on the
  dot product. The perpendicular part is what carries $P$ off the
  plane, and its length is the distance we want. Its size is
  $ arrow(A P) dot arrow(e)_n
    = (arrow(n) dot arrow(A P)) / abs(arrow(n)). $

  #fig(
    vplane(
      s-seg(from: (-1, 0), to: (8, 0), color: def-col, width: 1.2pt, label: [$E$], anchor: 0.04),
      s-vec(from: (1.5, 0), to: (1.5, 2.2), color: warn-col, label: $arrow(e)_n$),
      s-vec(from: (1.5, 0), to: (6, 3), label: $arrow(A P)$, color: accent),
      s-seg(from: (6, 3), to: (6, 0), color: luma(150), dashed: true),
      s-seg(from: (1.5, 0), to: (1.5, 3), color: luma(210)),
      s-seg(from: (1.5, 3), to: (6, 3), color: luma(150), dashed: true),
      s-txt((1.5, 1.6), text(size: 9pt)[$d$], off: (-11pt, 0pt)),
      s-arc(
        vertex: (1.5, 0), from: (1.5, 2.2), to: (8, 0),
        r: 12pt, right: true, color: luma(130),
      ),
      s-pt((1.5, 0), label: $A$),
      s-pt((6, 3), label: $P$),
      xmin: -1.5, xmax: 9.5, ymin: -0.5, ymax: 3.5,
      unit: 0.55cm, grid: false, axes: false,
    ),
    caption: [Seen edge-on, the plane is a line. The distance is the
      component of $arrow(A P)$ along the unit normal.],
  )

  Now write it in coordinates. With $arrow(n) = vec(a, b, c)$ and the
  plane $a x + b y + c z + d = 0$, the constant satisfies
  $d = -arrow(n) dot arrow(r)_A$, so
  $ arrow(n) dot arrow(A P)
    = arrow(n) dot arrow(r)_P - arrow(n) dot arrow(r)_A
    = a x_P + b y_P + c z_P + d. $

  The left-hand side of the plane's own equation, evaluated at $P$ —
  divided by the length of the normal.
]

#definition(title: "Hesse normal form")[
  Dividing the Cartesian equation by the length of its normal gives
  the #vocab("Hesse normal form", "Hessesche Normalform")
  $ E_H: (a x + b y + c z + d) / sqrt(a^2 + b^2 + c^2) = 0. $

  It describes the same plane. What has changed is that the
  left-hand side now *measures* something.
]

#keybox(title: "Distance from a point to a plane")[
  $ d(P, E) = (a x_P + b y_P + c z_P + d) /
    sqrt(a^2 + b^2 + c^2). $

  The result is *signed*: positive on the side the normal points to,
  negative on the other, zero exactly on the plane.
]

#only-theory[
  *Example.* Take $E: x + 2y + 2z - 5 = 0$, whose normal
  $vec(1, 2, 2)$ has length $3$, so the Hesse form is
  $ (x + 2y + 2z - 5) / 3 = 0. $

  For $P = (1, 3, 2)$:
  $ d(P, E) = (1 + 6 + 4 - 5) / 3 = 6/3 = 2. $

  For the origin:
  $ d(O, E) = (0 + 0 + 0 - 5) / 3 = -5/3. $

  So $P$ is $2$ units from the plane and the origin is $5 slash 3$
  units from it — on *opposite* sides, since the signs differ. Reading
  that off costs nothing beyond the arithmetic you were doing anyway.
]

#warning[
  Two things go wrong with the sign.

  *Do not drop it by accident.* If a question asks for a distance, an
  answer of $-5 slash 3$ should be reported as $5 slash 3$. If a
  question asks which side of a plane a point lies on, the sign is the
  entire answer.

  *Do not read it as absolute.* "Positive side" means the side the
  normal happens to point to, and multiplying the plane's equation by
  $-1$ describes the same plane with every sign reversed. The sign is
  only meaningful when comparing two points against *the same written
  equation*.
]

#remark[
  The same construction works one dimension down. A line in the plane,
  written $A x + B y + C = 0$, has Hesse form
  $ (A x + B y + C) / sqrt(A^2 + B^2) = 0, $
  and the distance from a point $P = (x_P, y_P)$ to the line is that
  expression evaluated at $P$.

  Everything in this chapter about planes in space holds verbatim for
  lines in the plane, with one fewer coordinate.
]

== Parallel Objects

#only-theory[
  Two parallel planes are everywhere the same distance apart, so the
  distance between them can be measured wherever you like.

  #keybox(title: "Distance between parallel planes")[
    Pick any point on one plane and compute its distance to the other.
  ]

  *Example.* Find the distance between the parallel lines
  $ l: 3x - 4y + 3 = 0 quad "and" quad m: 3x - 4y - 7 = 0. $

  A convenient point on $l$ is $(-1, 0)$, since $-3 + 3 = 0$. Then
  $ d = (3 dot (-1) - 4 dot 0 - 7) / sqrt(9 + 16) = (-10)/5 = -2, $
  so the lines are $2$ apart.
]

#warning[
  Before comparing two equations this way, check that the normal
  vectors are *identical*, not merely parallel.

  The lines $3x + 4y - 12 = 0$ and $6x + 8y - 29 = 0$ are parallel,
  but their equations are scaled differently. Divide the second by $2$
  to get $3x + 4y - 14.5 = 0$ first; only then are the constants
  comparable. Skipping that step gives an answer too large by a factor
  of two.
]

#only-theory[
  === Building a plane at a prescribed distance

  Run the calculation backwards. A plane parallel to
  $E: a x + b y + c z + d = 0$ has the same normal, so it is
  $a x + b y + c z + D = 0$ for some new constant $D$ — and the
  distance condition fixes $D$.

  *Example.* Find the planes parallel to
  $E: 2x + 2y + z - 1 = 0$ at distance $3$.

  A point on $E$ is $(0, 0, 1)$. The unknown plane is
  $2x + 2y + z + D = 0$ with $sqrt(4 + 4 + 1) = 3$, so
  $ (0 + 0 + 1 + D) / 3 = plus.minus 3
    quad arrow.r.double quad 1 + D = plus.minus 9. $

  Both signs are genuine: one plane lies on each side. So
  $ F_1: 2x + 2y + z + 8 = 0 quad "and" quad
    F_2: 2x + 2y + z - 10 = 0. $

  Two answers, always, unless the question says which side.
]

== The Foot of the Perpendicular

#only-theory[
  The Hesse form gives the distance without ever locating the nearest
  point. Sometimes you want the point itself — to reflect something in
  a plane, or to construct the shortest path.

  The construction is short. From $P$, travel along the normal until
  you hit the plane. The line
  $ s: arrow(r) = arrow(r)_P + t dot arrow(n) $
  is called the #vocab("perpendicular line", "Lot"), and where it
  meets $E$ is the #vocab("foot of the perpendicular", "Lotfusspunkt")
  $B$ — the point of $E$ nearest to $P$.

  Travelling the same distance *again* lands you at the mirror image
  of $P$ in the plane.
]

#keybox(title: "Foot and reflection")[
  + Set up $s: arrow(r) = arrow(r)_P + t dot arrow(n)$.
  + Substitute into $E$ and solve for $t$. Call the solution $t_0$.
  + The foot is $B = P + t_0 dot arrow(n)$.
  + The distance is $abs(t_0) dot abs(arrow(n))$.
  + The reflection is $P' = P + 2 t_0 dot arrow(n)$.
]

#only-theory[
  #fig(
    vplane(
      s-seg(from: (-1, 0), to: (9, 0), color: def-col, width: 1.2pt, label: [$E$], anchor: 0.04),
      s-seg(from: (4, 3), to: (4, -3), color: warn-col, width: 1.1pt, dashed: true),
      s-pt((4, 3), label: $P$),
      s-pt((4, 0), label: $B$),
      s-pt((4, -3), label: $P'$),
      s-arc(
        vertex: (4, 0), from: (4, 3), to: (9, 0),
        r: 12pt, right: true, color: luma(130),
      ),
      xmin: -1.5, xmax: 10.5, ymin: -3.5, ymax: 3.5,
      unit: 0.5cm, grid: false, axes: false,
    ),
    caption: [Foot and mirror image. The same step, taken twice.],
  )

  *Example.* For $E: 4x - 3y + 2z - 12 = 0$ and
  $P_0 = (15, -11, 3)$, with $arrow(n) = vec(4, -3, 2)$:

  $ s: arrow(r) = vec(15, -11, 3) + t dot vec(4, -3, 2), $
  and substituting into $E$:
  $ 4(15 + 4t) - 3(-11 - 3t) + 2(3 + 2t) - 12 = 87 + 29t = 0, $
  so $t_0 = -3$. Hence
  $ B = (15 - 12, ; -11 + 9, ; 3 - 6) = (3, -2, -3), $
  $ d = abs(-3) dot sqrt(29) = 3 sqrt(29) approx 16.16, $
  $ P' = (15 - 24, ; -11 + 18, ; 3 - 12) = (-9, 7, -9). $

  *Cross-check with the Hesse form:*
  $ (60 + 33 + 6 - 12) / sqrt(29) = 87 / sqrt(29)
    = 3 sqrt(29). $
  The same number, obtained without finding $B$ at all — which is
  why the Hesse form is the tool of choice when only the distance is
  wanted.
]

#only-theory[
  === Point to line, revisited

  You already have this one, from the cross product chapter:
  $ d(P, g) = abs(arrow(A B) times arrow(A P)) / abs(arrow(A B)). $

  It is worth seeing that it belongs to the same family. There, the
  cross product's magnitude gave a parallelogram area and dividing by
  the base gave the height. Here, a dot product with a unit normal
  gives a height directly. Both compute a perpendicular component;
  they differ only in whether the perpendicular direction is handed to
  you in advance.

  For a plane it is — the normal comes with the equation. For a line
  in space it is not, because a line has infinitely many
  perpendicular directions, and the cross product is what manufactures
  the right one.
]

#only-high[
  == Two Skew Lines

  #only-theory[
    Part A ended with a question it could not answer: two skew lines
    never meet, so how close do they get?

    There is exactly one direction perpendicular to both — namely
    $arrow(v)_1 times arrow(v)_2$ — and the shortest path between the
    lines runs along it. Take any vector joining a point of one line
    to a point of the other and measure its component in that
    direction, and everything parallel to the lines cancels out,
    leaving only the gap.
  ]

  #keybox(title: "Distance between skew lines")[
    For $g_1$ through $A$ with direction $arrow(v)_1$, and $g_2$
    through $B$ with direction $arrow(v)_2$,
    $ d(g_1, g_2) = abs((arrow(v)_1 times arrow(v)_2) dot arrow(A B)) /
      abs(arrow(v)_1 times arrow(v)_2). $
  ]

  #only-theory[
    This is a Hesse-form calculation in disguise: the numerator dots
    with a normal direction and the denominator divides by its length.
    The "plane" being measured against is the one containing $g_1$ and
    parallel to $g_2$.

    *Example.* The skew pair from Part A:
    $ g_1: arrow(r) = vec(2, -1, 1) + t dot vec(-1, 2, -1), quad
      g_2: arrow(r) = vec(0, 2, 3) + s dot vec(0, 1, 1). $
    $ arrow(v)_1 times arrow(v)_2 = vec(3, 1, -1), quad
      arrow(A B) = vec(-2, 3, 2), $
    $ d = abs(-6 + 3 - 2) / sqrt(11) = 5/sqrt(11) approx 1.51. $

    Note what the formula does when the lines are *not* skew. If they
    intersect, $arrow(A B)$ lies in the plane of the two directions
    and the numerator vanishes, giving $d = 0$ — correct. If they are
    parallel, the cross product is the null vector and the formula
    breaks down, which is honest: parallel lines need the
    point-to-line formula instead.
  ]
]

#look-ahead(preview: [circles, spheres and applications])[
  A sphere is the set of points at a fixed distance from a centre, so
  everything in this chapter feeds directly into the next one. In
  particular, asking whether a plane cuts a sphere, touches it, or
  misses it entirely is a single Hesse-form calculation compared
  against the radius.
]

#ex(difficulty: 1, time: "10 min", calculator: false)[
  For the plane $E: x - 2y - 2z + 4 = 0$:

  #auto-parts(
    1,
    [Write down the Hesse normal form.],
    [Find the signed distances of $P = (1, 3, 2)$ and
      $Q = (2, -1, -2)$.],
    [Do $P$ and $Q$ lie on the same side of $E$?],
  )
][
  #auto-parts(
    1,
    [$abs(arrow(n)) = sqrt(1 + 4 + 4) = 3$, so
      $ E_H: (x - 2y - 2z + 4) / 3 = 0. $],
    [$d(P, E) = (1 - 6 - 4 + 4) slash 3 = -5 slash 3$ and
      $d(Q, E) = (2 + 2 + 4 + 4) slash 3 = 4$.],
    [No. The signs differ, so the points lie on opposite sides —
      $P$ at distance $5 slash 3$ on the negative side, $Q$ at
      distance $4$ on the positive side.],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: true)[
  #auto-parts(
    1,
    [Find the distance of $P = (1, 2, 3)$ from
      $E: 2x + y - 5z - 1 = 0$.],
    [Find the distance between the parallel lines
      $l: 3x + 4y - 12 = 0$ and $m: 6x + 8y - 29 = 0$.],
    [Find the distance between the parallel lines
      $y = 4/3 x - 5$ and $y = 4/3 x + 10$.],
  )
][
  #auto-parts(
    1,
    [$ d = (2 + 2 - 15 - 1) / sqrt(4 + 1 + 25)
       = (-12) / sqrt(30) approx -2.19, $
      so the distance is about $2.19$.],
    [Rescale $m$ first: dividing by $2$ gives
      $3x + 4y - 14.5 = 0$. A point on $l$ is $(4, 0)$, so
      $ d = (12 + 0 - 14.5) / 5 = -0.5, $
      and the distance is $0.5$.

      Without the rescaling you would have used $-29$ in place of
      $-14.5$ and obtained $3.4$ — wrong, and not obviously so.],
    [In Cartesian form these are $4x - 3y - 15 = 0$ and
      $4x - 3y + 30 = 0$, with the same normal already. Taking
      $(0, -5)$ on the first,
      $ d = (0 + 15 + 30) / 5 = 9. $],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  #auto-parts(
    1,
    [Find both planes parallel to $E: 2x + 2y + z - 1 = 0$ at
      distance $3$ from it.],
    [Find the plane parallel to $E: 2x + 2y + z - 8 = 0$ at distance
      $4$, lying on the same side of $E$ as the point
      $A = (-2, 3, 1)$.],
  )
][
  #auto-parts(
    1,
    [The normal has length $3$, and $(0, 0, 1)$ lies on $E$. With the
      unknown plane $2x + 2y + z + D = 0$,
      $ (1 + D) / 3 = plus.minus 3 quad arrow.r.double quad
        D = 8 "or" D = -10, $
      giving $2x + 2y + z + 8 = 0$ and $2x + 2y + z - 10 = 0$.],
    [First find which side $A$ is on:
      $d(A, E) = (-4 + 6 + 1 - 8) slash 3 = -5 slash 3$, so $A$ is on
      the negative side.

      The two candidates are $2x + 2y + z + 4 = 0$ and
      $2x + 2y + z - 20 = 0$. Testing $A$ against each:
      the first gives $+7 slash 3$ and the second $-17 slash 3$. Only
      the second has the same sign as before, so the answer is
      $ 2x + 2y + z - 20 = 0. $],
  )

  Part (b) is the standard trap. Two planes always satisfy the
  distance condition, and a question that names a side is asking you
  to discard one of them.
]

#ex(difficulty: 3, time: "16 min", calculator: false, hints: (
  "The perpendicular from P has the plane's normal as its direction vector.",
  "Solve for t first. Everything else — foot, distance, reflection — comes from that one number.",
))[
  Consider $E: 4x - 3y + 2z - 12 = 0$ and $P_0 = (15, -11, 3)$.

  #auto-parts(
    1,
    [Find the vector equation of the perpendicular $s$ from $P_0$ to
      $E$.],
    [Find the foot $B$ of that perpendicular.],
    [Find the distance from $P_0$ to $E$, and check it a second way.],
    [Find the reflection $P'$ of $P_0$ in $E$.],
  )
][
  #auto-parts(
    1,
    [$ s: arrow(r) = vec(15, -11, 3) + t dot vec(4, -3, 2). $],
    [Substituting into $E$:
      $ 4(15 + 4t) - 3(-11 - 3t) + 2(3 + 2t) - 12
        = 87 + 29t = 0, $
      so $t_0 = -3$ and $B = (3, -2, -3)$.

      *Check:* $12 + 6 - 6 - 12 = 0$ ✓, so $B$ lies on $E$.],
    [$d = abs(t_0) dot abs(arrow(n)) = 3 sqrt(29) approx 16.16$.

      *Second method*, via the Hesse form:
      $(60 + 33 + 6 - 12) slash sqrt(29) = 87 slash sqrt(29)
      = 3 sqrt(29)$. Same answer, and it needed neither $t_0$ nor
      $B$.],
    [$P' = P_0 + 2 t_0 dot arrow(n)
      = (15 - 24, ; -11 + 18, ; 3 - 12) = (-9, 7, -9)$.

      *Check:* $B$ should be the midpoint of $P_0 P'$, and
      $((15 - 9) slash 2, (-11 + 7) slash 2, (3 - 9) slash 2)
      = (3, -2, -3)$ ✓.],
  )
]

#ex(difficulty: 3, time: "12 min", calculator: false)[
  Reflect each point in the given plane.

  #auto-parts(
    1,
    [$P = (0, -5, 5)$ in $E: x + 4y - 3z + 9 = 0$],
    [$P = (2, -5, 8)$ in $E: x - 2y + 3z - 8 = 0$],
  )

  Verify each answer by checking that the midpoint of $P$ and $P'$
  lies on the plane.
][
  #auto-parts(
    1,
    [$abs(arrow(n))^2 = 1 + 16 + 9 = 26$ and
      $(0 - 20 - 15 + 9) = -26$, so $t_0 = 1$ and
      $ P' = (0, -5, 5) + 2 dot vec(1, 4, -3) = (2, 3, -1). $
      Midpoint $(1, -1, 2)$: $1 - 4 - 6 + 9 = 0$ ✓.],
    [$abs(arrow(n))^2 = 1 + 4 + 9 = 14$ and
      $(2 + 10 + 24 - 8) = 28$, so $t_0 = -2$ and
      $ P' = (2, -5, 8) - 4 dot vec(1, -2, 3) = (-2, 3, -4). $
      Midpoint $(0, -1, 2)$: $0 + 2 + 6 - 8 = 0$ ✓.],
  )
]

#only-high[
  #ex(difficulty: 3, time: "14 min", calculator: true)[
    #auto-parts(
      1,
      [Find the distance between the skew lines
        $ g_1: arrow(r) = vec(2, -1, 1) + t dot vec(-1, 2, -1),
          quad
          g_2: arrow(r) = vec(0, 2, 3) + s dot vec(0, 1, 1). $],
      [Apply the same formula to the *intersecting* pair
        $ h_1: arrow(r) = vec(2, -1, 1) + t dot vec(-1, 2, -1),
          quad
          h_2: arrow(r) = vec(0, 2, 3) + s dot vec(0, 1, -4), $
        and interpret the result.],
      [What happens if you apply the formula to two *parallel* lines?
        Why is this not a defect?],
    )
  ][
    #auto-parts(
      1,
      [$ arrow(v)_1 times arrow(v)_2 = vec(3, 1, -1), quad
         arrow(A B) = vec(-2, 3, 2), $
       $ d = abs(-6 + 3 - 2) / sqrt(11) = 5 / sqrt(11)
         approx 1.51. $],
      [Now $arrow(v)_1 times arrow(v)_2
        = vec(-1, 2, -1) times vec(0, 1, -4) = vec(-7, -4, -1)$ and
        $arrow(A B) = vec(-2, 3, 2)$, giving
        $14 - 12 - 2 = 0$ in the numerator, so $d = 0$.

        Correct, and informative: a distance of zero between two
        non-parallel lines means they meet. The formula doubles as an
        intersection test.],
      [The cross product of two parallel directions is the null
        vector, so the denominator is zero and the formula is
        undefined.

        This is not a defect but a signal. Parallel lines do have a
        distance, but the construction behind the formula — a *unique*
        common perpendicular direction — does not exist for them,
        since every direction perpendicular to one is perpendicular to
        the other. Use the point-to-line formula instead: pick any
        point on one line and measure to the other.],
    )
  ]
]

#print-hints()
#print-vocab()
