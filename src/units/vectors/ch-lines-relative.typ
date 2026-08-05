#import "../../common/preamble.typ": *
#import "/src/common/vec-figures.typ": *
#show: chapter-template.with(title: "When Lines Miss")
#let ex = exercise.with(chapter: "When Lines Miss")

#let V = cube-pts(a: 4)

= When Lines Miss

#only-theory[
  Two lines in a plane do one of two things: they cross, or they are
  parallel. There is no third option, and after years of working in
  two dimensions it is easy to assume the same is true in space.

  It is not. Space is roomy enough for two lines to avoid each other
  without being parallel — to pass by, at different heights, heading
  in different directions, never meeting. This chapter is mostly about
  that third case, how to recognize it, and how to tell it apart from
  the others by calculation rather than by squinting at a drawing.
]

#objectives(
  bfkm[classify two lines in space as identical, parallel,
    intersecting or skew, and justify the classification],
  [find the point of intersection of two lines when it exists],
  [recognize that a system of three equations in two unknowns usually
    has no solution, and why that is the expected outcome],
  [calculate the angle between two lines, including skew ones],
  [explain why the angle formula needs an absolute value],
)

== A Third Possibility

#exploration(title: "Two edges of a cube")[
  Take the cube from the first chapter, with vertices lettered as
  before.

  #fig(cube(a: 4, unit: SHEET-UNIT, grid: true))

  + Find a pair of edges that are parallel. How many such pairs are
    there in total?

  + Find a pair of edges that meet. Where do they meet?

  + Now find a pair of edges that are *neither* parallel *nor*
    meeting. Convince a neighbour that your pair really never meets,
    even if both edges are extended into full infinite lines.

  + How many edges is a given edge in this third relationship with?
    Does the answer depend on which edge you start from?
]

#only-theory[
  Take the edges $A B$ and $C G$. Their directions are
  $vec(0, 4, 0)$ and $vec(0, 0, 4)$, which are not multiples of one
  another, so the two are not parallel. But every point of $A B$ has
  $x = 4$ and every point of $C G$ has $x = 0$, so they cannot
  possibly share a point — not even when extended forever.

  #fig(
    cube(
      a: 4,
      s-seg(from: V.A, to: V.B, color: warn-col, width: 2pt),
      s-seg(from: V.C, to: V.G, color: def-col, width: 2pt),
      unit: 0.7cm,
    ),
    caption: [$A B$ and $C G$ are skew: not parallel, and with no point
      in common.],
  )

  Lines like this are called #vocab("skew", "windschief"). Each edge of
  a cube is parallel to three others, meets four others, and is skew to
  the remaining four.
]

#definition(title: "The four relative positions")[
  Two lines in space are exactly one of the following.

  #auto-parts(
    1,
    [*Identical* — every point of one is a point of the other.],
    [*Parallel* — same direction, no common point.],
    [*Intersecting* — different directions, exactly one common point.],
    [*Skew* — different directions, no common point.],
  )

  In the plane the fourth case cannot occur.
]

#only-theory[
  #fig(
    grid(
      columns: (1fr, 1fr, 1fr, 1fr),
      column-gutter: 3pt,
      align(center)[
        #vplane(
          s-seg(
            from: (0.5, 0.5),
            to: (3.5, 3.5),
            color: warn-col,
            width: 1.6pt,
          ),
          xmin: -0.5,
          xmax: 4.5,
          ymin: -0.5,
          ymax: 4.5,
          unit: 0.36cm,
          grid: false,
          axes: false,
        )
        #text(size: 8pt)[identical]
      ],
      align(center)[
        #vplane(
          s-seg(from: (0.2, 1), to: (3.2, 4), color: warn-col, width: 1.6pt),
          s-seg(from: (1.3, 0.3), to: (4.3, 3.3), color: def-col, width: 1.6pt),
          xmin: -0.5,
          xmax: 4.5,
          ymin: -0.5,
          ymax: 4.5,
          unit: 0.36cm,
          grid: false,
          axes: false,
        )
        #text(size: 8pt)[parallel]
      ],
      align(center)[
        #vplane(
          s-seg(
            from: (0.5, 0.5),
            to: (3.5, 3.5),
            color: warn-col,
            width: 1.6pt,
          ),
          s-seg(from: (0.5, 3.5), to: (3.5, 0.5), color: def-col, width: 1.6pt),
          xmin: -0.5,
          xmax: 4.5,
          ymin: -0.5,
          ymax: 4.5,
          unit: 0.36cm,
          grid: false,
          axes: false,
        )
        #text(size: 8pt)[intersecting]
      ],
      align(center)[
        #vplane(
          s-seg(
            from: (0.5, 0.5),
            to: (3.5, 3.5),
            color: warn-col,
            width: 1.6pt,
          ),
          s-seg(from: (0.5, 3.5), to: (1.6, 2.4), color: def-col, width: 1.6pt),
          s-seg(from: (2.4, 1.6), to: (3.5, 0.5), color: def-col, width: 1.6pt),
          xmin: -0.5,
          xmax: 4.5,
          ymin: -0.5,
          ymax: 4.5,
          unit: 0.36cm,
          grid: false,
          axes: false,
        )
        #text(size: 8pt)[skew]
      ],
    ),
    caption: [The four cases. Note how little separates the last two on
      paper — a break in one line is the only thing distinguishing
      them.],
  )
]

#warning[
  In a two-dimensional drawing, skew lines *look* as though they
  cross. The apparent crossing is a coincidence of the projection: two
  points at different depths landing on the same spot on the page.

  This is the same phenomenon you met with the cube in the first
  chapter, where a marked point could appear to sit on an edge it had
  nothing to do with. A drawing cannot settle whether two lines in
  space meet. Only the calculation can.
]

== The Classification Algorithm

#only-theory[
  Two questions, asked in this order, separate all four cases.
]

#keybox(title: "Classifying two lines")[
  *Question 1. Are the direction vectors parallel?*

  - *Yes* — the lines are identical or parallel. Test whether the
    anchor point of one lies on the other.
    - It does: *identical*.
    - It does not: *parallel*.

  - *No* — the lines are intersecting or skew. Solve the system of
    component equations.
    - A solution exists: *intersecting*.
    - No solution: *skew*.
]

#only-theory[
  Question 1 is cheap — one glance at whether one direction vector is
  a multiple of the other — and it is worth asking first because
  answering "yes" saves you from solving a system entirely.

  In the "yes" branch, note that testing *one* point is enough. If a
  single point of $h$ lies on $g$ and the directions already agree,
  then every point of $h$ lies on $g$: the two lines share a point and
  a direction, and that is all a line is.
]

#warning[
  When you write down two lines together, give them *different*
  parameters:
  $
    g: arrow(r) = arrow(r)_A + t dot arrow(v), quad quad
    h: arrow(r) = arrow(r)_B + s dot arrow(w).
  $

  Using $t$ for both is one of the most reliable ways to get a wrong
  answer in this chapter. The two lines are travelled independently,
  and forcing them to share a parameter asks a different and much
  more restrictive question — you would be looking for points reached
  at the *same moment*, rather than points that coincide at all.
]

#only-theory[
  *Example 1.* Classify
  $
    g: arrow(r) = vec(7, -3, 0) + t dot vec(0, 6, -1), quad quad
    h: arrow(r) = vec(5, 2, 3) + s dot vec(0, -3, 0.5).
  $

  The direction vectors satisfy
  $vec(0, 6, -1) = -2 dot vec(0, -3, 0.5)$, so they are parallel and
  we are in the first branch. Is $(5, 2, 3)$ a point of $g$? The first
  component of $g$ is $7$ for every $t$, and $5 eq.not 7$, so no.

  The lines are *parallel*.

  *Example 2.* Classify
  $
    g: arrow(r) = vec(-3, 6, 0) + t dot vec(-1, 2, 1), quad quad
    h: arrow(r) = vec(4, 0, -3) + s dot vec(1, 0, 0).
  $

  The directions are not parallel, so we solve. Setting the two
  right-hand sides equal, component by component:
  $ -3 - t = 4 + s, quad quad 6 + 2t = 0, quad quad t = -3. $

  The second and third equations each involve only $t$, and both give
  $t = -3$ — consistent. Substituting into the first,
  $-3 + 3 = 4 + s$, so $s = -4$.

  A solution exists, so the lines *intersect*. The point is found by
  putting $t = -3$ into $g$:
  $ arrow(r) = vec(-3, 6, 0) - 3 dot vec(-1, 2, 1) = vec(0, 0, -3), $
  so the intersection point is $(0, 0, -3)$. Substituting $s = -4$
  into $h$ gives the same point, which is the check.
]

== Three Equations, Two Unknowns

#only-theory[
  Setting two lines equal produces three equations — one per
  coordinate — but only two unknowns, $t$ and $s$. Such a system is
  called #vocab("overdetermined", "überbestimmt"), and the important
  thing to understand is that it usually has *no* solution.

  That is not a defect. It is the honest reflection of the geometry:
  two randomly chosen lines in space do not meet. Intersecting is the
  special case, skew is the ordinary one, and the extra equation is
  what detects the difference.
]

#keybox(title: "Method for the intersecting-or-skew branch")[
  + Set the two vector equations equal and write the three component
    equations.
  + Pick *two* of them and solve for $t$ and $s$.
  + Substitute both values into the *third*, unused equation.
    - If it holds, the lines intersect. Put $t$ back into $g$ to get
      the point.
    - If it fails, the lines are skew.

  Step 3 is not optional. Skipping it means you have checked only that
  the two lines agree in two coordinates, which any pair of skew lines
  will happily do.
]

#only-theory[
  *Example 3.* Classify
  $
    g: arrow(r) = vec(5, 4, 5) + t dot vec(2, 1, -3), quad quad
    h: arrow(r) = vec(0, 0, -1) + s dot vec(1, 1, 1).
  $

  The directions are not parallel. The three component equations are
  $ 5 + 2t = s, quad quad 4 + t = s, quad quad 5 - 3t = -1 + s. $

  Take the first two: $5 + 2t = 4 + t$, so $t = -1$ and then $s = 3$.

  Now the third equation, which has not been used:
  $ "left side": 5 + 3 = 8, quad quad "right side": -1 + 3 = 2. $

  These disagree, so no pair $(t, s)$ satisfies all three. The lines
  are *skew*.

  Had we stopped after two equations we would have reported an
  intersection at $t = -1$, which is simply false — the two lines pass
  each other at those parameter values without touching.
]

== The Angle Between Two Lines

#only-theory[
  The angle between two lines is the angle between their direction
  vectors, and the dot product delivers it. But there is a subtlety
  that needs settling first.

  A line has no preferred direction. The line
  $arrow(r) = arrow(r)_A + t dot vec(2, 1, -3)$ and the line
  $arrow(r) = arrow(r)_A + t dot vec(-2, -1, 3)$ are the *same line*,
  written with opposite direction vectors. Reversing one direction
  vector flips the sign of the dot product and replaces the angle
  $phi.alt$ by $180degree - phi.alt$.

  So the angle "between two lines" is only well defined if we agree
  which of the two supplementary angles we mean. The convention is the
  #emph[acute] one, and the way to enforce it is an absolute value.
]

#keybox(title: "Angle between two lines")[
  $
    cos phi.alt = abs(arrow(v)_1 dot arrow(v)_2) /
    (abs(arrow(v)_1) dot abs(arrow(v)_2)),
    quad quad 0degree <= phi.alt <= 90degree.
  $

  The absolute value in the numerator forces an acute answer,
  independently of how the two direction vectors happened to be
  written down.
]

#warning[
  Compare this with the formula from the dot product chapter, where
  the angle between two *vectors* ran from $0degree$ to $180degree$
  and there was no absolute value.

  Both are correct, for different questions. Two *vectors* have a
  genuine direction, so an obtuse angle between them is meaningful.
  Two *lines* do not, so it is not. Read the question and use the
  matching formula.
]

#only-theory[
  *Example.* Find the angle between
  $
    g: arrow(r) = vec(2, -1, 1) + t dot vec(-1, 2, -1), quad quad
    h: arrow(r) = vec(0, 2, 3) + s dot vec(0, 1, 1).
  $

  $
    arrow(v)_1 dot arrow(v)_2 = 0 + 2 - 1 = 1, quad
    abs(arrow(v)_1) = sqrt(6), quad abs(arrow(v)_2) = sqrt(2),
  $
  $
    cos phi.alt = abs(1) / sqrt(12) approx 0.2887
    quad arrow.r.double quad phi.alt approx 73.2degree.
  $

  #fig(
    vplane(
      s-seg(
        from: (-3, -1.5),
        to: (3, 1.5),
        color: warn-col,
        width: 1.2pt,
        label: [$g$],
        anchor: 0.06,
      ),
      s-seg(
        from: (-1.5, 3),
        to: (1.5, -3),
        color: def-col,
        width: 1.2pt,
        label: [$h$],
        anchor: 0.06,
      ),
      s-arc(
        vertex: (0, 0),
        from: (3, 1.5),
        to: (-1.5, 3),
        r: 24pt,
        label: $phi.alt$,
      ),
      s-arc(
        vertex: (0, 0),
        from: (-3, -1.5),
        to: (-1.5, 3),
        r: 38pt,
        label: $180degree - phi.alt$,
        color: luma(140),
      ),
      xmin: -4.5,
      xmax: 4.5,
      ymin: -3.5,
      ymax: 3.5,
      unit: 0.5cm,
      grid: false,
      axes: false,
    ),
    caption: [Two lines enclose two supplementary angles. By convention
      the angle between them is the acute one.],
  )
]

#remark[
  Skew lines have an angle too, even though they never meet.

  The angle is a property of the two *directions*, and directions do
  not care where the lines are. Slide one of the two skew lines
  parallel to itself until it meets the other, and you have an
  honest angle between two intersecting lines — the same number the
  formula gives. This is worth knowing because questions often ask for
  the angle between two lines without first asking whether they meet.
]

#look-ahead(preview: [distances])[
  One question about skew lines is conspicuously missing from this
  chapter: if two lines never meet, *how close do they get?*

  There is a shortest distance between them, achieved along the one
  line segment perpendicular to both. Finding that segment needs a
  vector perpendicular to two given vectors at once — which is exactly
  the problem you solved with a system of two equations in the dot
  product chapter, and exactly the problem the *cross product* will
  solve with a single formula.
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Three lines in the plane are given by
  $
    g: arrow(r) = vec(1, 7) + s dot vec(-2, 3), quad
    h: arrow(r) = vec(0, -2) + t dot vec(1, 2), quad
    k: arrow(r) = vec(3, -3) + u dot vec(4, 1).
  $

  Find the three points of intersection.
][
  *$g inter h$.* From $1 - 2s = t$ and $7 + 3s = -2 + 2t$: substituting
  the first into the second gives $7 + 3s = -2 + 2 - 4s$, so
  $7s = -7$ and $s = -1$. The point is
  $vec(1, 7) - vec(-2, 3) = vec(3, 4)$, that is $(3, 4)$.

  *$g inter k$.* From $1 - 2s = 3 + 4u$ and $7 + 3s = -3 + u$: the
  second gives $u = 10 + 3s$, and substituting,
  $1 - 2s = 43 + 12s$, so $s = -3$ and the point is $(7, -2)$.

  *$h inter k$.* From $t = 3 + 4u$ and $-2 + 2t = -3 + u$: substituting,
  $-2 + 6 + 8u = -3 + u$, so $7u = -7$, $u = -1$ and the point is
  $(-1, -4)$.

  In the plane, two lines with different directions always meet — the
  third question of the algorithm never arises. That is exactly what
  changes in space.
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  Find the point of intersection of each pair, if it exists.

  #auto-parts(
    1,
    [$l_1: arrow(r) = vec(0, 1, 0) + t dot vec(2, 1, 1)$ and
      $l_2: arrow(r) = vec(0, -4, 3) + s dot vec(-1, -3, 1)$],
    [$l_1: arrow(r) = vec(5, 4, 5) + t dot vec(2, 1, -3)$ and
      $l_2: arrow(r) = vec(0, 0, -1) + s dot vec(1, 1, 1)$],
  )
][
  #auto-parts(
    1,
    [The component equations are
      $2t = -s$, $1 + t = -4 - 3s$ and $t = 3 + s$. From the first,
      $s = -2t$; substituting into the second,
      $1 + t = -4 + 6t$, so $t = 1$ and $s = -2$.

      *Check in the third:* $t = 1$ and $3 + s = 1$. Consistent, so the
      lines intersect, at
      $vec(0, 1, 0) + vec(2, 1, 1) = vec(2, 2, 1)$, that is
      $S = (2, 2, 1)$.],
    [As worked in the chapter: the first two equations give $t = -1$
      and $s = 3$, but the third then reads $8 = 2$. No intersection —
      the lines are skew.],
  )
]

#ex(difficulty: 3, time: "25 min", calculator: false, hints: (
  "Always start with the direction vectors. If they are parallel you never need to solve a system at all.",
  "In the parallel branch, test one anchor point against the other line — one point settles it.",
  "In the other branch, solve two equations and then TEST the third. That test is the whole exercise.",
))[
  Classify each pair of lines as identical, parallel, intersecting or
  skew.

  #auto-parts(
    1,
    [$g: vec(14, -1, 15) + s dot vec(-6, 4.5, -9)$, #h(6pt)
      $h: vec(4, 6.5, 0) + t dot vec(4, -3, 6)$],
    [$g: vec(3, -6, 10) + s dot vec(-6, 1, 8)$, #h(6pt)
      $h: vec(6, 9, 4) + t dot vec(-3, 0, 4)$],
    [$g: vec(2, 5, 0) + s dot vec(0, 0.4, -1)$, #h(6pt)
      $h: vec(3, 9, 0) + t dot vec(0, -2, 5)$],
    [$g: vec(9, 5, 0) + s dot vec(2, 1, -2)$, #h(6pt)
      $h: vec(6, 3, 1) + t dot vec(1, 0, -3)$],
    [$g: vec(9, 3, 8) + s dot vec(3, 1, 5)$, #h(6pt)
      $h: vec(4, 6, 5) + t dot vec(4, 6, 4)$],
    [$g: vec(6, 1, 3) + s dot vec(4, 0, 5)$, #h(6pt)
      $h: vec(2, 1, 9) + t dot vec(2, 0, -3)$],
  )
][
  #auto-parts(
    1,
    [*Identical.* The directions are parallel, since
      $vec(-6, 4.5, -9) = -1.5 dot vec(4, -3, 6)$. And $(4, 6.5, 0)$
      lies on $g$: it is reached at $s = 5 slash 3$.],
    [*Skew.* Directions not parallel. The second component equation is
      $-6 + s = 9$, so $s = 15$; the first then gives $t = 31$. The
      third reads $10 + 120 = 130$ against $4 + 124 = 128$. Fails.],
    [*Parallel.* The directions satisfy
      $vec(0, -2, 5) = -5 dot vec(0, 0.4, -1)$. But every point of $g$
      has $x = 2$ and every point of $h$ has $x = 3$, so they share no
      point.],
    [*Intersecting*, at $(5, 3, 4)$. From the second equation
      $5 + s = 3$, so $s = -2$; the first then gives $t = -1$; and the
      third checks out, $4 = 4$.],
    [*Skew.* Solving the first two gives $t = -1$ and $s = -3$, but the
      third reads $-7$ against $1$.],
    [*Intersecting*, at $(6, 1, 3)$. Note that the second component
      equation is $1 = 1$, which is true for all $s$ and $t$ and so
      tells you nothing — you must use the first and third. They give
      $s = 0$ and $t = 2$, and the point is the anchor of $g$ itself.],
  )

  Part (f) is worth a second look. An equation that reduces to
  $1 = 1$ has not been "satisfied" in any useful sense; it has simply
  dropped out, leaving two equations in two unknowns and therefore no
  third equation to check with. When that happens, the lines both lie
  in the plane $y = 1$, and inside a plane two non-parallel lines
  always meet.
]

#ex(difficulty: 2, time: "10 min", calculator: true)[
  Find the point of intersection *and* the angle between
  $
    l_1: arrow(r) = vec(2, -1, 1) + t dot vec(-1, 2, -1), quad quad
    l_2: arrow(r) = vec(0, 2, 3) + s dot vec(0, 1, -4).
  $
][
  *Intersection.* The first component gives $2 - t = 0$, so $t = 2$,
  and $l_1$ then yields the point $(0, 3, -1)$. On $l_2$: the second
  component gives $2 + s = 3$, so $s = 1$, and the third checks,
  $3 - 4 = -1$. The lines meet at $S = (0, 3, -1)$.

  *Angle.*
  $
    arrow(v)_1 dot arrow(v)_2 = 0 + 2 + 4 = 6, quad
    abs(arrow(v)_1) = sqrt(6), quad abs(arrow(v)_2) = sqrt(17),
  $
  $
    cos phi.alt = 6 / sqrt(102) approx 0.5941
    quad arrow.r.double quad phi.alt approx 53.6degree.
  $
]

#ex(difficulty: 2, time: "12 min", calculator: true)[
  Find the angle of intersection of each pair of lines.

  #auto-parts(
    1,
    [$g: y = 4x - 7$ and $h: y = 7x - 4$],
    [$g: 2x - 3y - 3 = 0$ and $h: 3x + 2y - 24 = 0$],
    [$g: arrow(r) = vec(-3, 5, -2) + t dot vec(3, -5, 9)$ and
      $h: arrow(r) = vec(-16, -6, 9) + s dot vec(8, 3, -1)$],
    [$g: arrow(r) = vec(6, -10, 24) + t dot vec(2, -6, 3)$ and
      $h: arrow(r) = vec(14, -4, 3) + s dot vec(-7, 6, 6)$],
  )
][
  #auto-parts(
    1,
    [Directions $vec(1, 4)$ and $vec(1, 7)$. Dot product $29$,
      magnitudes $sqrt(17)$ and $sqrt(50)$, so
      $cos phi.alt = 29 slash sqrt(850) approx 0.9947$ and
      $phi.alt approx 5.9degree$.],
    [Normal vectors $vec(2, -3)$ and $vec(3, 2)$ have dot product
      $6 - 6 = 0$, so the lines are perpendicular:
      $phi.alt = 90degree$. (The angle between two lines equals the
      angle between their normals — reversing both roles changes
      nothing.)],
    [Dot product $24 - 15 - 9 = 0$, so $phi.alt = 90degree$.],
    [Dot product $-14 - 36 + 18 = -32$; magnitudes $7$ and $11$. The
      absolute value matters here:
      $cos phi.alt = abs(-32) slash 77 approx 0.4156$, giving
      $phi.alt approx 65.4degree$.

      Without the absolute value you would have obtained
      $114.6degree$, the obtuse partner — a correct angle between
      those two particular direction *vectors*, but not the angle
      between the two *lines*.],
  )
]

#only-high[
  #ex(difficulty: 3, time: "18 min", calculator: true)[
    #auto-parts(
      1,
      [Write down the equations of two lines that intersect at
        $60degree$. Verify your answer.],
      [Do the same for $45degree$, and then for $37degree$.],
      [Which of the three was hardest, and why? Was it easier to work
        in two dimensions or in three?],
    )
  ][
    #auto-parts(
      1,
      [Work backwards from the formula. In the plane, take
        $arrow(v)_1 = vec(1, 0)$; then
        $cos 60degree = 1 slash 2$ needs $arrow(v)_2$ with
        $v_x slash abs(arrow(v)_2) = 1 slash 2$, and
        $arrow(v)_2 = vec(1, sqrt(3))$ works, since
        $abs(arrow(v)_2) = 2$. So
        $
          g: arrow(r) = t dot vec(1, 0), quad
          h: arrow(r) = s dot vec(1, sqrt(3)).
        $
        Both pass through the origin, so they certainly intersect.],
      [For $45degree$: $arrow(v)_2 = vec(1, 1)$ gives
        $cos phi.alt = 1 slash sqrt(2)$ exactly.

        For $37degree$ there is no exact construction of this kind,
        because $cos 37degree$ is not a nice surd. You must choose
        $arrow(v)_2 = vec(cos 37degree, sin 37degree) approx
        vec(0.7986, 0.6018)$ and accept a decimal answer — or, more
        honestly, produce a line whose angle is $37degree$ to the
        precision you are willing to write down.],
      [The third is hardest, and the reason is worth stating: the
        angles that come out exactly are the ones whose cosine is a
        surd you can construct, and $37degree$ is not among them. The
        difficulty is not geometric but arithmetic.

        Two dimensions is easier, and this is the interesting part.
        In space, one direction vector still fixes almost nothing:
        the set of directions making a given angle with
        $arrow(v)_1$ forms an entire *cone* around it, so there are
        infinitely many essentially different answers rather than
        the two mirror-image ones you get in the plane. More freedom
        makes the search harder to organize, not easier.],
    )
  ]
]

#print-hints()
#print-vocab()
