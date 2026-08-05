#import "../../common/preamble.typ": *
#import "/src/common/vec-figures.typ": *
#show: chapter-template.with(title: "Where Things Meet")
#let ex = exercise.with(chapter: "Where Things Meet")

#let V = cube-pts(a: 4)

= Where Things Meet

#only-theory[
  Lines and planes are now both described by equations, which means
  every question about how they meet becomes a question about solving
  equations simultaneously. That is the whole content of this chapter,
  and it is short on new ideas and long on payoff.

  At the end of it, the polygon you drew by eye on a cube in the very
  first chapter of Part A gets computed exactly, with twelve small
  calculations and no imagination at all.
]

#objectives(
  bfkm[find the intersection of a line and a plane, and recognize the
    two degenerate cases],
  [find the line of intersection of two planes],
  [find the common point of three planes],
  [say, before calculating, how many solutions a given configuration
    should be expected to have],
  [compute the polygon a plane cuts from a cube],
)

== A Line and a Plane

#only-theory[
  There are three possibilities, and the arithmetic tells them apart
  without any drawing.

  #auto-parts(
    1,
    [The line pierces the plane at *one point*.],
    [The line *lies in* the plane — infinitely many common points.],
    [The line is *parallel* to the plane — no common point at all.],
  )

  #fig(
    space3d(
      ..plane-patch((2, 2.5, 1.5), (2, 0, 0), (0, 2, 0), lo: -1, hi: 1),
      s-seg(
        from: (0.4, 0.9, 3.6), to: (3.6, 4.1, -0.6),
        color: def-col, width: 1.2pt,
      ),
      s-pt((2, 2.5, 1.5), label: $S$, color: warn-col, r: 2.4pt),
      axis-len: (4.5, 5.5, 4.5),
      unit: 0.6cm,
    ),
    caption: [The ordinary case: one piercing point.],
  )
]

#keybox(title: "Line meets plane, plane in Cartesian form")[
  Substitute the line's three component equations into the plane's
  equation. The result is *one* equation in the single unknown $t$.

  - *One solution for $t$* — the line pierces the plane. Put $t$ back
    into the line to get the point.
  - *An identity* such as $0 = 0$ — every $t$ works, so the line lies
    in the plane.
  - *A contradiction* such as $4 = 0$ — no $t$ works, so the line is
    parallel to the plane.
]

#only-theory[
  *Example.* Find where
  $l: arrow(r) = vec(7, 6, 3) + p dot vec(2, -1, -2)$ meets
  $E: 2x - 2y - z + 17 = 0$.

  The component equations are $x = 7 + 2p$, $y = 6 - p$ and
  $z = 3 - 2p$. Substituting all three at once:
  $ 2(7 + 2p) - 2(6 - p) - (3 - 2p) + 17 = 0. $
  Expanding,
  $ 14 + 4p - 12 + 2p - 3 + 2p + 17 = 16 + 8p = 0
    quad arrow.r.double quad p = -2. $
  Feeding $p = -2$ back into the line gives the point
  $ S = (7 - 4, ; 6 + 2, ; 3 + 4) = (3, 8, 7). $

  *Check.* $S$ must satisfy the plane's equation:
  $6 - 16 - 7 + 17 = 0$. ✓
]

#only-theory[
  === Spotting the degenerate cases early

  You can often tell which case you are in before substituting
  anything, and it is worth the ten seconds.

  A line is parallel to a plane — or lies in it — exactly when its
  direction is perpendicular to the plane's normal, that is when
  $arrow(n) dot arrow(v) = 0$. If that holds, one point test then
  separates the two: substitute the anchor point into the plane's
  equation. If it satisfies the equation, the line lies in the plane;
  if not, the line is parallel to it.

  *Example.* Take $l: arrow(r) = vec(1, -3, -2) + u dot vec(2, 1, -1)$
  against two planes with the same normal $arrow(n) = vec(2, -1, 3)$:
  $ E_1: 2x - y + 3z + 1 = 0, quad quad E_2: 2x - y + 3z + 5 = 0. $

  In both cases $arrow(n) dot arrow(v) = 4 - 1 - 3 = 0$, so the line
  is parallel to both planes and pierces neither. Now the point test
  with $(1, -3, -2)$:
  $ E_1: 2 + 3 - 6 + 1 = 0 quad arrow.r.double quad l "lies in" E_1, $
  $ E_2: 2 + 3 - 6 + 5 = 4 eq.not 0 quad arrow.r.double quad
    l "is parallel to" E_2. $

  Two planes differing only in their constant term, one containing the
  line and one missing it entirely. The constant is what slides a
  plane along its normal, and here it slides it just off the line.
]

#warning[
  When both the line and the plane are given in *parametric* form,
  there is no shortcut: set the two right-hand sides equal and solve
  three equations in three unknowns — the line's parameter and the
  plane's two.

  Use three *different* letters. This is the same discipline as with
  two lines in Part A, and for the same reason.
]

== Two Planes

#only-theory[
  Two planes are parallel, identical, or they meet in a line. There is
  no fourth case and, in particular, two planes never meet in a single
  point — a fact worth holding onto, because it is the first thing
  students expect and it never happens.

  #fig(
    space3d(
      ..plane-patch((2, 2, 2), (2, 0, 0), (0, 2, 0), lo: -1, hi: 1),
      ..plane-patch((2, 2, 2), (2, 0, 0), (0, 0, 2), lo: -1, hi: 1),
      s-seg(from: (0, 2, 2), to: (4, 2, 2), color: warn-col, width: 1.6pt),
      axis-len: (4.5, 4.5, 4.5),
      unit: 0.62cm,
    ),
    caption: [Two planes and their line of intersection.],
  )

  Telling the cases apart is a question about the normals. If
  $arrow(n)_1$ and $arrow(n)_2$ are parallel, the planes are parallel
  or identical — and a single point test separates those. If the
  normals are not parallel, the planes meet in a line, and finding it
  takes two steps.
]

#keybox(title: "Line of intersection of two planes")[
  + *Direction.* The line lies in both planes, so it is perpendicular
    to both normals:
    $ arrow(v) = arrow(n)_1 times arrow(n)_2. $
  + *A point.* Two equations in three unknowns leave one free choice.
    Set one coordinate to a convenient value — usually $x = 0$ — and
    solve the remaining $2 times 2$ system.
]

#only-theory[
  *Example.* Find the line of intersection of
  $ E_1: 2x - y + z - 1 = 0, quad quad E_2: x + 2y - z = 0. $

  The normals are $vec(2, -1, 1)$ and $vec(1, 2, -1)$, giving
  $ arrow(v) = vec(2, -1, 1) times vec(1, 2, -1) = vec(-1, 3, 5). $

  For a point, set $x = 0$:
  $ -y + z - 1 = 0, quad quad 2y - z = 0. $
  The second gives $z = 2y$; substituting, $-y + 2y - 1 = 0$, so
  $y = 1$ and $z = 2$. The point $(0, 1, 2)$ lies on both planes.

  $ l: arrow(r) = vec(0, 1, 2) + t dot vec(-1, 3, 5). $

  *Check.* $(0, 1, 2)$ in $E_1$: $0 - 1 + 2 - 1 = 0$ ✓; in $E_2$:
  $0 + 2 - 2 = 0$ ✓. And the direction must be perpendicular to both
  normals: $vec(-1, 3, 5) dot vec(2, -1, 1) = -2 - 3 + 5 = 0$ ✓.
]

#warning[
  Setting $x = 0$ does not always work. If the line of intersection
  happens to be parallel to the $y z$#"‑"plane, it never reaches
  $x = 0$, and the $2 times 2$ system you get will be contradictory.

  This is not a disaster and it is not a mistake in your working. Set
  $y = 0$ instead, or $z = 0$. At least one of the three choices
  always succeeds, because a line cannot be parallel to all three
  coordinate planes at once.

  You have met this before under another name: it is the same fact as
  a line failing to have all three trace points.
]

== Three Planes

#only-theory[
  Three planes in general position meet at exactly one point — three
  equations, three unknowns, one solution. Finding it is ordinary
  elimination, with no vector machinery required at all.

  *Example.* Solve
  $ 4x + 3y + z - 13 = 0, quad
    2x - 5y + 3z - 1 = 0, quad
    7x - y - 2z + 1 = 0. $

  Eliminating $z$ between the first and second, and again between the
  first and third, reduces this to two equations in $x$ and $y$, and
  the answer is $(1, 2, 3)$.

  *Check.* $4 + 6 + 3 - 13 = 0$ ✓, $2 - 10 + 9 - 1 = 0$ ✓,
  $7 - 2 - 6 + 1 = 0$ ✓. Three checks, each one line — always worth
  doing, since three-variable elimination is where arithmetic slips
  hide.

  Special configurations exist — three planes sharing a common line,
  or forming a triangular prism with no common point — and the
  algebra reports them as infinitely many solutions or none, exactly
  as it should.
]

== How Many Solutions Should You Expect?

#only-theory[
  Every problem in this chapter and the last is a system of linear
  equations, and counting equations against unknowns predicts the
  answer before you start.

  #auto-parts(
    1,
    [*Two lines*: three equations, two unknowns. *Overdetermined* —
      more constraints than freedom, so generically no solution. Two
      lines in space usually miss, and skew is the ordinary case.],
    [*A line and a plane*: three equations, three unknowns.
      *Determined* — generically exactly one solution, which is why a
      line usually pierces a plane at a single point.],
    [*Two planes*: two equations, three unknowns. *Underdetermined* —
      one degree of freedom left over, so generically a
      one-dimensional solution set. That is the line of intersection.],
    [*Three planes*: three equations, three unknowns. Determined
      again, so generically one point.],
  )

  The word *generically* is doing the work. Each case has exceptions,
  and the exceptions are exactly the geometrically special
  configurations: parallel, contained, coincident. What the count
  tells you is what to expect, and therefore when to be suspicious of
  your own answer.

  If you solve a two-plane problem and arrive at a single point, you
  have made a mistake — that outcome is not available.
]

== Cutting the Cube

#only-theory[
  In the first chapter of Part A you were given three points on the
  edges of a cube and asked to draw the polygon cut out by the plane
  through them. You did it with two construction rules and a good deal
  of care. Here is the same problem, done by calculation.

  Take the cube with $D$ at the origin and edge $4$, and the three
  points
  $ W = (4, 0, 2), quad Y = (0, 4, 2), quad T = (4, 3, 0) $
  — the midpoints of $A E$ and $C G$, and the point on $A B$ with
  $A T = 3$.

  *Step 1: find the plane.* With
  $arrow(W Y) = vec(-4, 4, 0)$ and $arrow(W T) = vec(0, 3, -2)$,
  $ arrow(n) = vec(-4, 4, 0) times vec(0, 3, -2) = vec(-8, -8, -12), $
  which tidies to $vec(2, 2, 3)$. Substituting $W$:
  $8 + 0 + 6 = 14$, so
  $ E: 2x + 2y + 3z = 14. $

  *Step 2: test all twelve edges.* Each edge holds two coordinates
  fixed and lets the third run from $0$ to $4$, so each one gives a
  single linear equation. The edge $A B$ has $x = 4$ and $z = 0$:
  $ 8 + 2y = 14 quad arrow.r.double quad y = 3, $
  which lies between $0$ and $4$, so the plane cuts $A B$ at
  $(4, 3, 0)$ — the point $T$ we started from. The edge $C D$ has
  $x = 0$ and $z = 0$:
  $ 2y = 14 quad arrow.r.double quad y = 7, $
  which is *outside* the range $0$ to $4$. The plane crosses the line
  containing $C D$, but beyond the end of the actual edge, so this
  edge contributes no vertex.

  Working through all twelve the same way gives six hits:
  $ (4, 3, 0), quad (3, 4, 0), quad (0, 4, 2), quad
    (0, 1, 4), quad (1, 0, 4), quad (4, 0, 2). $
]

#only-theory[
  #fig(
    cube(
      a: 4,
      s-poly(
        ((4, 3, 0), (3, 4, 0), (0, 4, 2), (0, 1, 4), (1, 0, 4), (4, 0, 2)),
        fill: rgb("#f1eff9"),
        stroke-color: ai-col,
        width: 1.1pt,
      ),
      s-pt((4, 0, 2), label: [*W*], off: (-13pt, 0pt), color: ai-col, r: 2pt),
      s-pt((0, 4, 2), label: [*Y*], off: (13pt, 0pt), color: ai-col, r: 2pt),
      s-pt((4, 3, 0), label: [*T*], off: (4pt, 12pt), color: ai-col, r: 2pt),
      unit: 0.72cm,
      labels: false,
    ),
    caption: [The hexagon, now computed rather than constructed. Every
      vertex is an exact triple of integers.],
  )

  Compare the two methods honestly. The construction in Chapter 0 was
  faster, needed no algebra, and taught you something about how planes
  meet solids. The calculation is slower, entirely mechanical, and
  will produce the right answer on a cube you cannot picture, in a
  solid with forty faces, at three in the morning.

  Neither replaces the other. The calculation is what you trust; the
  picture is what tells you the answer is plausible before you trust
  it.
]

#look-ahead(preview: [distances])[
  Every question in this chapter has been *whether* and *where* things
  meet. The obvious next question is *how far apart* they are when
  they do not — from a point to a plane, between two parallel planes,
  between two skew lines.

  All three have short answers, and all three come from the same idea:
  divide by the length of the normal vector.
]

#ex(difficulty: 2, time: "15 min", calculator: false)[
  Find the point of intersection of the line $l$ and the plane $E$, or
  explain why there is none.

  #auto-parts(
    1,
    [$E: 2x - y + 3z + 1 = 0$, #h(4pt)
      $l: arrow(r) = vec(3, -4, -1) + u dot vec(2, -1, 1)$],
    [$E: x + 2y - 5z + 9 = 0$, #h(4pt)
      $l: arrow(r) = vec(-2, -1, 4) + u dot vec(3, 1, -2)$],
    [$E: 2x - y + 3z + 5 = 0$, #h(4pt)
      $l: arrow(r) = vec(3, 5, 0) + u dot vec(2, 1, -1)$],
  )
][
  #auto-parts(
    1,
    [Substituting: $2(3 + 2u) - (-4 - u) + 3(-1 + u) + 1 = 8 + 8u = 0$,
      so $u = -1$ and the point is $(1, -3, -2)$.],
    [$(-2 + 3u) + 2(-1 + u) - 5(4 - 2u) + 9 = -15 + 15u = 0$, so
      $u = 1$ and the point is $(1, 0, 2)$.],
    [Here $arrow(n) dot arrow(v) = 4 - 1 - 3 = 0$, so no piercing
      point exists. The point test with $(3, 5, 0)$ gives
      $6 - 5 + 0 + 5 = 6 eq.not 0$, so the line is *parallel* to the
      plane rather than lying in it.],
  )

  In (c), doing the perpendicularity test first would have saved the
  substitution entirely.
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  Find the point of intersection of the line and the plane, both given
  parametrically.

  #auto-parts(
    1,
    [$E: arrow(r) = vec(-2, 0, -5) + t dot vec(1, 0, 0)
      + s dot vec(1, 1, 0)$, #h(4pt)
      $l: arrow(r) = vec(1, 5, -2) + u dot vec(0, 1, 1)$],
    [$E: arrow(r) = vec(1, 2, 6) + t dot vec(3, 7, 4)
      + s dot vec(-5, 2, 3)$, #h(4pt)
      $l: arrow(r) = vec(6, 4, -5) + u dot vec(-4, 3, 7)$],
  )
][
  #auto-parts(
    1,
    [Both of $E$'s directions have zero third component and the
      anchor has $z = -5$, so $E$ is simply the plane $z = -5$. The
      line reaches it when $-2 + u = -5$, that is $u = -3$, giving
      $(1, 2, -5)$.

      Recognizing the plane before solving turned a $3 times 3$
      system into one equation.],
    [Setting the two right-hand sides equal gives three equations in
      $t$, $s$ and $u$. Solving yields $u = 3$, and the line then
      gives
      $ (6 - 12, ; 4 + 9, ; -5 + 21) = (-6, 13, 16). $

      *Check* that this lies in $E$: subtracting the anchor gives
      $vec(-7, 11, 10)$, and
      $1 dot vec(3, 7, 4) + 2 dot vec(-5, 2, 3) = vec(-7, 11, 10)$ ✓.],
  )
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  Determine the line of intersection of
  $ E_1: 2x - y + z - 1 = 0 quad quad "and" quad quad
    E_2: x + 2y - z = 0. $

  Then verify your answer in two independent ways.
][
  $ arrow(v) = vec(2, -1, 1) times vec(1, 2, -1) = vec(-1, 3, 5). $
  Setting $x = 0$ leaves $-y + z = 1$ and $2y - z = 0$, so $z = 2y$
  and $y = 1$, $z = 2$. Hence
  $ l: arrow(r) = vec(0, 1, 2) + t dot vec(-1, 3, 5). $

  *Check 1 — the point.* $(0, 1, 2)$ satisfies both equations:
  $-1 + 2 - 1 = 0$ and $2 - 2 = 0$. ✓

  *Check 2 — the direction.* It must be perpendicular to both
  normals: $-2 - 3 + 5 = 0$ and $-1 + 6 - 5 = 0$. ✓

  Two checks that use different parts of the answer are worth more
  than the same check done twice.
]

#ex(difficulty: 3, time: "14 min", calculator: false, hints: (
  "Both planes are given parametrically. Convert them to Cartesian form first — the cross-product route is quick.",
))[
  Find a vector equation of the line of intersection of
  $ E: arrow(r) = vec(3, 1, 2) + t dot vec(1, 0, 0)
    + s dot vec(0, 1, 1) $
  and
  $ F: arrow(r) = vec(4, 2, 0) + u dot vec(0, 2, -1)
    + v dot vec(0, 0, -1). $
][
  *Convert $F$ first*, since both its directions have zero first
  component: every point of $F$ has $x = 4$, so $F$ is the plane
  $x = 4$.

  *Convert $E$.* Its normal is
  $vec(1, 0, 0) times vec(0, 1, 1) = vec(0, -1, 1)$, and substituting
  the anchor $(3, 1, 2)$ gives $-1 + 2 + d = 0$, so $d = -1$ and
  $E: -y + z - 1 = 0$, that is $z = y + 1$.

  Intersecting: $x = 4$ and $z = y + 1$, with $y$ free. Taking
  $y = -1$ gives the point $(4, -1, 0)$, and the direction is
  $vec(0, 1, 1)$:
  $ l: arrow(r) = vec(4, -1, 0) + t dot vec(0, 1, 1). $

  Recognizing $F$ as $x = 4$ saved most of the work. Whenever both
  direction vectors share a zero component, check for that before
  reaching for the cross product.
]

#ex(difficulty: 3, time: "12 min", calculator: false)[
  Find the common point of the three planes
  $ 4x + 3y + z - 13 = 0, quad
    2x - 5y + 3z - 1 = 0, quad
    7x - y - 2z + 1 = 0. $

  Before solving, say how many solutions you expect and why.
][
  Three equations in three unknowns, so generically exactly one
  solution — a single point.

  Eliminating $z$ between the first two (multiply the first by $3$ and
  subtract the second) and between the first and third (multiply the
  first by $2$ and add the third) reduces the system to two equations
  in $x$ and $y$, and solving gives
  $ (x, y, z) = (1, 2, 3). $

  *Check* in all three: $4 + 6 + 3 - 13 = 0$ ✓,
  $2 - 10 + 9 - 1 = 0$ ✓, $7 - 2 - 6 + 1 = 0$ ✓.
]

#ex(difficulty: 3, time: "25 min", calculator: false, hints: (
  "First find the plane through the three points, exactly as in the previous chapter.",
  "Each edge of the cube fixes two coordinates and lets the third run from 0 to 4. Substituting gives one linear equation per edge.",
  "A solution outside the range 0 to 4 means the plane misses that edge — the crossing happens on the extended line, past the corner.",
))[
  A cube has $D$ at the origin and edge length $4$, lettered as in
  Part A. Three points are marked:
  $R$ on $A B$ with $A R = 1$, $S$ the midpoint of $B F$, and
  $U$ the midpoint of $G H$.

  #auto-parts(
    1,
    [Find the Cartesian equation of the plane through $R$, $S$ and
      $U$.],
    [By testing all twelve edges, find every vertex of the section
      polygon.],
    [How many sides does the section have? Sketch it on a cube.],
  )
][
  The three points are $R = (4, 1, 0)$, $S = (4, 4, 2)$ and
  $U = (0, 2, 4)$.

  #auto-parts(
    1,
    [$arrow(R S) = vec(0, 3, 2)$ and $arrow(R U) = vec(-4, 1, 4)$,
      so
      $ arrow(n) = vec(0, 3, 2) times vec(-4, 1, 4)
        = vec(10, -8, 12), $
      which tidies to $vec(5, -4, 6)$. Substituting $R$:
      $20 - 4 + 0 + d = 0$, so $d = -16$ and
      $ E: 5x - 4y + 6z - 16 = 0. $
      *Check:* $S$ gives $20 - 16 + 12 - 16 = 0$ ✓ and $U$ gives
      $0 - 8 + 24 - 16 = 0$ ✓.],
    [Testing each edge in turn — two coordinates fixed, the third
      running from $0$ to $4$ — the plane meets
      $ A B "at" (4, 1, 0), quad
        B F "at" (4, 4, 2), quad
        F G "at" (8 slash 5, 4, 4), $
      $ G H "at" (0, 2, 4), quad
        D H "at" (0, 0, 8 slash 3), quad
        D A "at" (16 slash 5, 0, 0). $
      The remaining six edges give values outside $[0, 4]$ and
      contribute nothing.],
    [Six vertices, so the section is a *hexagon*. Three of them have
      fractional coordinates, which is perfectly normal — this plane
      was not chosen to be tidy, and most are not.

      Note also which edges were *missed*: the plane crosses the lines
      containing the other six edges, but always outside the range
      $0$ to $4$, that is beyond a corner of the cube. "No
      intersection" and "intersection past the end of the edge" are
      the same thing here.],
  )
]

#only-high[
  #ex(difficulty: 3, time: "14 min", calculator: false, hints: (
    "Parallel means the line's direction is perpendicular to the plane's normal. Write that as a dot product and set it to zero.",
    "You will get a quadratic in k. Both roots need checking: parallel also requires that the line does NOT lie in the plane.",
  ))[
    For which values of $k$ are the line and the plane parallel?
    $ l: arrow(r) = vec(0, 0, k) + t dot vec(-2k, -1, k),
      quad quad
      E: (2k - 1) x - k y + z - (5 + k) = 0. $
  ][
    The normal is $arrow(n) = vec(2k - 1, -k, 1)$, and parallelism
    requires $arrow(n) dot arrow(v) = 0$:
    $ -2k (2k - 1) + k + k = -4k^2 + 2k + 2k = -4k^2 + 4k = 0, $
    so $-4k (k - 1) = 0$ and $k = 0$ or $k = 1$.

    *Both must still be checked*, because $arrow(n) dot arrow(v) = 0$
    also holds when the line *lies in* the plane, which is not what
    "parallel" means.

    For $k = 0$: the plane is $-x + z - 5 = 0$ and the line's anchor
    is $(0, 0, 0)$, giving $-5 eq.not 0$. Genuinely parallel.

    For $k = 1$: the plane is $x - y + z - 6 = 0$ and the anchor is
    $(0, 0, 1)$, giving $1 - 6 = -5 eq.not 0$. Genuinely parallel.

    So both values work. Had one of them put the anchor on the plane,
    that value would have had to be discarded.
  ]
]

#print-hints()
#print-vocab()
