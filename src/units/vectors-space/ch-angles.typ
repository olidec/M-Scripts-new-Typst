#import "../../common/preamble.typ": *
#import "/src/common/vec-figures.typ": *
#show: chapter-template.with(title: "How Things Lean")
#let ex = exercise.with(chapter: "How Things Lean")

= How Things Lean

#only-theory[
  Three kinds of angle remain: between two planes, between a line and
  a plane, and — already met in Part A — between two lines. All three
  are computed from a single dot product, and two of the three use the
  same formula.

  The third one does not, and the reason it does not is the most
  worthwhile thing in this chapter. A plane is represented by a vector
  that is *perpendicular* to it, so any angle involving a plane is
  computed from a direction the plane does not actually contain. Get
  that bookkeeping right and everything follows; get it wrong and your
  answer is off by exactly $90degree$, which is far too large a
  mistake to notice by feel.
]

#objectives(
  bfkm[calculate the angle between two planes, and between a line and
    a plane],
  [explain why the line-plane case uses $arcsin$ rather than
    $arccos$],
  [decide when a line is perpendicular to a plane, and when two planes
    are perpendicular],
  [use the acute-angle convention consistently],
)

== The Convention, Once More

#only-theory[
  Any two intersecting lines enclose two angles adding to $180degree$;
  the same is true of two planes. By convention, *the* angle between
  two geometric objects is the acute one, and the way to enforce that
  is an absolute value in the numerator.

  In Part A this appeared for two lines:
  $ cos phi.alt = abs(arrow(v)_1 dot arrow(v)_2) /
    (abs(arrow(v)_1) dot abs(arrow(v)_2)). $

  The reason was that a line has no preferred direction, so reversing
  a direction vector must not change the answer. Exactly the same
  reasoning applies to planes: a plane has two normal directions,
  pointing to either side, and nothing distinguishes them. Every
  formula in this chapter therefore carries an absolute value.
]

== Two Planes

#only-theory[
  The angle between two planes — the
  #vocab("dihedral angle", "Neigungswinkel") — is the angle you would
  measure by standing on their line of intersection and looking along
  it, as at the ridge of a roof.

  It equals the angle between the two normal vectors. To see why: pick
  the point where the two planes meet and turn the whole picture
  through $90degree$ about their common line. Each plane maps onto a
  plane perpendicular to it, and each normal maps onto a direction
  lying in its own plane and perpendicular to the ridge — which is
  precisely the pair of directions whose angle you were measuring. The
  rotation preserves angles, so the two are equal.
]

#keybox(title: "Angle between two planes")[
  $ cos phi.alt = abs(arrow(n)_1 dot arrow(n)_2) /
    (abs(arrow(n)_1) dot abs(arrow(n)_2)),
    quad quad 0degree <= phi.alt <= 90degree. $

  In particular, $E_1 perp E_2$ exactly when
  $arrow(n)_1 dot arrow(n)_2 = 0$, and $E_1 parallel E_2$ exactly when
  the normals are parallel.
]

#only-theory[
  #fig(
    space3d(
      ..plane-patch((2, 2, 2), (2, 0, 0), (0, 2, 0), lo: -1, hi: 1),
      ..plane-patch((2, 2, 2), (2, 0, 0), (0, 1.4, 1.4), lo: -1, hi: 1),
      s-seg(from: (0, 2, 2), to: (4, 2, 2), color: warn-col, width: 1.5pt),
      s-vec(from: (3, 2, 2), to: (3, 2, 3.6), color: def-col, label: $arrow(n)_1$),
      s-vec(from: (3, 2, 2), to: (3, 0.9, 3.1), color: accent, label: $arrow(n)_2$),
      s-arc(
        vertex: (3, 2, 2), from: (3, 2, 3.6), to: (3, 0.9, 3.1),
        r: 22pt, label: $phi.alt$,
      ),
      axis-len: (4.5, 4.5, 4.5),
      unit: 0.62cm,
    ),
    caption: [The dihedral angle, read off the two normals.],
  )

  *Example.* Find the angle between
  $ E_1: x - y + 3z - 1 = 0 quad "and" quad
    E_2: -3x - 4y + 6z + 4 = 0. $

  Read the normals straight off the coefficients:
  $arrow(n)_1 = vec(1, -1, 3)$ and $arrow(n)_2 = vec(-3, -4, 6)$.
  $ arrow(n)_1 dot arrow(n)_2 = -3 + 4 + 18 = 19, quad
    abs(arrow(n)_1) = sqrt(11), quad abs(arrow(n)_2) = sqrt(61), $
  $ cos phi.alt = 19 / sqrt(671) approx 0.7335
    quad arrow.r.double quad phi.alt approx 42.8degree. $

  Note how little work the Cartesian form made this: no cross
  products, no direction vectors, nothing but the coefficients.
]

== A Line and a Plane

#only-theory[
  Here is the case that behaves differently.

  Let $arrow(v)$ be the line's direction and $arrow(n)$ the plane's
  normal. The dot product gives you the angle $alpha$ between
  $arrow(v)$ and $arrow(n)$ — but $arrow(n)$ sticks *out* of the
  plane, so $alpha$ is not the angle you want.

  The angle $phi.alt$ between the line and the plane is measured
  between the line and its own shadow in the plane. Since the normal
  is perpendicular to that shadow,
  $ phi.alt = 90degree - alpha. $

  #fig(
    space3d(
      ..plane-patch((2, 2.5, 1), (2, 0, 0), (0, 2, 0), lo: -1, hi: 1),
      s-seg(
        from: (0.5, 1, -1), to: (3.5, 4, 3),
        color: def-col, width: 1.2pt,
      ),
      s-seg(from: (3.5, 4, 3), to: (3.5, 4, 1), color: luma(150), dashed: true),
      s-seg(from: (2, 2.5, 1), to: (3.5, 4, 1), color: luma(150), dashed: true),
      s-vec(from: (2, 2.5, 1), to: (2, 2.5, 3.5), color: warn-col, label: $arrow(n)$),
      s-arc(
        vertex: (2, 2.5, 1), from: (2, 2.5, 3.5), to: (3.5, 4, 3),
        r: 20pt, label: $alpha$, color: warn-col,
      ),
      s-arc(
        vertex: (2, 2.5, 1), from: (3.5, 4, 3), to: (3.5, 4, 1),
        r: 32pt, label: $phi.alt$, color: def-col,
      ),
      s-pt((2, 2.5, 1), r: 2pt),
      axis-len: (4.5, 5.5, 4.5),
      unit: 0.62cm,
    ),
    caption: [$alpha$ is what the dot product gives you; $phi.alt$ is
      what the question asks for. They are complementary.],
  )

  Rather than computing $alpha$ and subtracting, use the identity
  $cos(90degree - phi.alt) = sin phi.alt$ and go straight there.
]

#keybox(title: "Angle between a line and a plane")[
  $ sin phi.alt = abs(arrow(n) dot arrow(v)) /
    (abs(arrow(n)) dot abs(arrow(v))),
    quad quad 0degree <= phi.alt <= 90degree. $

  Same expression as before — but $arcsin$, not $arccos$.
]

#warning[
  This is the one formula in the unit where using the right expression
  with the wrong inverse function produces a plausible-looking answer.

  If you write $arccos$ instead of $arcsin$ here, you get
  $90degree - phi.alt$: a perfectly reasonable angle, in the right
  range, with no arithmetic error anywhere. Nothing about the number
  looks wrong.

  Two habits guard against it. First, remember *why* the sine appears
  — the normal points out of the plane, so the dot product measures
  the wrong angle of a complementary pair. Second, sanity-check
  against the extremes: a line lying *in* a plane makes an angle of
  $0degree$ with it, and a line perpendicular to a plane makes
  $90degree$. If your formula gives $90degree$ for a line lying in the
  plane, you have used the wrong one.
]

#keybox(title: "The two extreme cases")[
  $ l perp E quad arrow.l.r.double quad
    arrow(v) parallel arrow(n) $
  $ l parallel E quad "or" quad l subset E
    quad arrow.l.r.double quad
    arrow(v) perp arrow(n) quad "i.e." quad arrow(n) dot arrow(v) = 0 $

  The second line should look familiar: it is the test from the
  previous chapter for a line failing to pierce a plane. A line
  parallel to a plane makes an angle of $0degree$ with it, which is
  the same statement.
]

#only-theory[
  *Example.* Find the angle between
  $ l: arrow(r) = vec(1, 1, -2) + t dot vec(-2, -1, 1)
    quad "and" quad E: 2x - y + z - 5 = 0. $

  $ arrow(n) dot arrow(v) = -4 + 1 + 1 = -2, quad
    abs(arrow(n)) = sqrt(6), quad abs(arrow(v)) = sqrt(6), $
  $ sin phi.alt = abs(-2) / 6 = 1/3
    quad arrow.r.double quad phi.alt approx 19.5degree. $

  A shallow angle: the line runs close to flat along the plane. That
  is consistent with the dot product being small compared with the
  product of the magnitudes, which is worth noticing as a rough check
  before pressing any buttons.
]

#exploration(title: "One number, two angles")[
  Take the cube with $D$ at the origin and edge $4$, so that the space
  diagonal $arrow(D F)$ has direction $vec(1, 1, 1)$.

  + Find the angle between $arrow(D F)$ and the edge $arrow(D A)$,
    which has direction $vec(1, 0, 0)$.

  + Find the angle between $arrow(D F)$ and the bottom face of the
    cube, which is the plane $z = 0$.

  + Both answers come from the same number, $1 slash sqrt(3)$. One
    uses $arccos$ and the other $arcsin$. Add your two answers
    together. What do you get, and why must that happen?

  + The edge $D A$ lies *in* the bottom face. Explain in one sentence
    why the two angles you found are nevertheless different.
]

#only-theory[
  The first is $arccos(1 slash sqrt(3)) approx 54.7degree$ and the
  second is $arcsin(1 slash sqrt(3)) approx 35.3degree$. They add to
  $90degree$, and they must, because the space diagonal, the edge and
  the vertical through $D$ sit in one plane with a right angle in it.

  The last question is the point of the exploration. The edge lies in
  the face, so you might expect the angle to the edge and the angle to
  the face to agree — but the angle to a *plane* is measured to the
  nearest direction in that plane, and the edge $D A$ is not the
  nearest. The diagonal's shadow on the bottom face runs along the
  face diagonal $D C$, not along the edge, and it is *that* direction
  the $35.3degree$ is measured to.

  An angle to a plane is a minimum over all directions in it. An
  angle to a line is not a minimum over anything.
]

#look-ahead(preview: [distances])[
  Every angle formula in this chapter divided a dot product by two
  magnitudes. The next chapter divides a dot product by *one*
  magnitude — the normal's — and what comes out is a distance rather
  than an angle.

  That is the whole content of the Hesse normal form, and it is
  nearer than it looks.
]

#ex(difficulty: 2, time: "10 min", calculator: true)[
  Find the angle between each pair of planes.

  #auto-parts(
    1,
    [$E_1: x - y + 3z - 1 = 0$ and $E_2: -3x - 4y + 6z + 4 = 0$],
    [$E_1: 2x + y - 2z = 0$ and $E_2: x - 2y + 5 = 0$],
    [$E_1: x + y + z = 3$ and $E_2: z = 0$],
  )
][
  #auto-parts(
    1,
    [Normals $vec(1, -1, 3)$ and $vec(-3, -4, 6)$; dot product $19$;
      magnitudes $sqrt(11)$ and $sqrt(61)$. So
      $cos phi.alt = 19 slash sqrt(671) approx 0.7335$ and
      $phi.alt approx 42.8degree$.],
    [Normals $vec(2, 1, -2)$ and $vec(1, -2, 0)$; dot product
      $2 - 2 + 0 = 0$. The planes are *perpendicular*,
      $phi.alt = 90degree$, and no calculator was needed.],
    [Normals $vec(1, 1, 1)$ and $vec(0, 0, 1)$; dot product $1$;
      magnitudes $sqrt(3)$ and $1$. So
      $cos phi.alt = 1 slash sqrt(3)$ and
      $phi.alt approx 54.7degree$ — the space-diagonal angle again,
      which is no accident: $vec(1, 1, 1)$ is the space diagonal
      direction.],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: true)[
  Find the angle between the line and the plane.

  #auto-parts(
    1,
    [$l: arrow(r) = vec(1, 1, -2) + t dot vec(-2, -1, 1)$ and
      $E: 2x - y + z - 5 = 0$],
    [$l: arrow(r) = vec(0, 0, 0) + t dot vec(1, 1, 1)$ and
      $E: z = 0$],
    [$l: arrow(r) = vec(3, 1, 0) + t dot vec(1, 2, -1)$ and
      $E: 2x + 4y - 2z + 7 = 0$],
  )
][
  #auto-parts(
    1,
    [$arrow(n) dot arrow(v) = -2$, both magnitudes $sqrt(6)$, so
      $sin phi.alt = 2 slash 6 = 1 slash 3$ and
      $phi.alt approx 19.5degree$.],
    [$arrow(n) dot arrow(v) = 1$, magnitudes $1$ and $sqrt(3)$, so
      $sin phi.alt = 1 slash sqrt(3)$ and
      $phi.alt approx 35.3degree$.],
    [Here $arrow(n) = vec(2, 4, -2) = 2 dot vec(1, 2, -1)$, which is
      parallel to the direction $arrow(v)$. So the line is
      *perpendicular* to the plane and $phi.alt = 90degree$.

      Check it against the formula:
      $sin phi.alt = 12 slash (sqrt(24) dot sqrt(6)) = 12 slash 12 = 1$,
      giving $90degree$ as it should.],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Decide each of these without computing any angle.

  #auto-parts(
    1,
    [Is the line with direction $vec(3, -1, 2)$ parallel to the plane
      $x + y - z + 4 = 0$?],
    [Are the planes $2x - y + 4z = 1$ and $x + 6y + 2z = 0$
      perpendicular?],
    [Is the line with direction $vec(2, -4, 6)$ perpendicular to the
      plane $x - 2y + 3z = 7$?],
  )
][
  #auto-parts(
    1,
    [$arrow(n) dot arrow(v) = 3 - 1 - 2 = 0$, so yes — the direction
      is perpendicular to the normal, which means the line is parallel
      to the plane (or lies in it; deciding which needs a point).],
    [$vec(2, -1, 4) dot vec(1, 6, 2) = 2 - 6 + 8 = 4 eq.not 0$, so
      no.],
    [$vec(2, -4, 6) = 2 dot vec(1, -2, 3)$, which is the normal, so
      yes — the direction is parallel to the normal.],
  )

  All three took one line. Perpendicularity and parallelism are always
  cheaper to test than a general angle is to compute, so test for them
  first.
]

#ex(difficulty: 3, time: "14 min", calculator: true, hints: (
  "Find the plane through the three points first, exactly as in the chapter on planes.",
  "The bottom face of the cube is the plane z = 0. What is its normal?",
))[
  A cube has $D$ at the origin and edge $4$. A plane cuts it through
  $W = (4, 0, 2)$, $Y = (0, 4, 2)$ and $T = (4, 3, 0)$ — the hexagonal
  section from the previous chapter, whose equation is
  $E: 2x + 2y + 3z = 14$.

  #auto-parts(
    1,
    [Find the angle between $E$ and the bottom face of the cube.],
    [Find the angle between $E$ and the front face $x = 4$.],
    [Find the angle between $E$ and the space diagonal
      $arrow(D F)$.],
  )
][
  The normal of $E$ is $arrow(n) = vec(2, 2, 3)$, with
  $abs(arrow(n)) = sqrt(17)$.

  #auto-parts(
    1,
    [Bottom face $z = 0$ has normal $vec(0, 0, 1)$. So
      $ cos phi.alt = 3 / sqrt(17) approx 0.7276
        quad arrow.r.double quad phi.alt approx 43.3degree. $],
    [Front face $x = 4$ has normal $vec(1, 0, 0)$, giving
      $ cos phi.alt = 2 / sqrt(17) approx 0.4851
        quad arrow.r.double quad phi.alt approx 61.0degree. $],
    [Now a line and a plane, so $arcsin$:
      $arrow(D F)$ has direction $vec(1, 1, 1)$ and
      $ sin phi.alt = abs(2 + 2 + 3) / (sqrt(17) dot sqrt(3))
        = 7 / sqrt(51) approx 0.9803, $
      giving $phi.alt approx 78.6degree$ — the section plane is
      close to perpendicular to the space diagonal.],
  )

  Part (c) is the one to watch: the same normal, the same style of
  calculation, and a different inverse function because the second
  object is a line rather than a plane.
]

#only-high[
  #ex(difficulty: 3, time: "16 min", calculator: false, hints: (
    "Perpendicular to a plane means the line's direction is PARALLEL to the normal — one is a scalar multiple of the other.",
    "Compare components one at a time to find the scale factor, then solve for k.",
  ))[
    Consider the plane $E: 3x - y + z - 3 = 0$ and the line
    $ l: arrow(r) = vec(3, 2k - 1, -1)
      + t dot vec(k - 2, 1, k). $

    #auto-parts(
      1,
      [Find $k$ so that $l$ is perpendicular to $E$.],
      [For that value of $k$, find the point where $l$ meets $E$.],
    )
  ][
    #auto-parts(
      1,
      [Perpendicularity to the plane means
        $arrow(v) = m dot arrow(n)$ for some $m$, that is
        $ vec(k - 2, 1, k) = m dot vec(3, -1, 1). $
        The second component gives $1 = -m$, so $m = -1$. The third
        then gives $k = -1$, and the first checks:
        $k - 2 = -3 = 3m$. ✓

        So $k = -1$, and the line is
        $ l: arrow(r) = vec(3, -3, -1) + t dot vec(-3, 1, -1). $],
      [Substituting the component equations into the plane:
        $ 3(3 - 3t) - (-3 + t) + (-1 - t) - 3
          = 8 - 11t = 0 quad arrow.r.double quad t = 8/11. $
        Hence
        $ S = (3 - 24/11, ; -3 + 8/11, ; -1 - 8/11)
          = (9/11, ; -25/11, ; -19/11). $

        *Check.* $3 dot 9/11 + 25/11 - 19/11 - 3
        = (27 + 25 - 19 - 33) slash 11 = 0$. ✓

        Because the line is perpendicular to the plane, this point is
        also the closest point of $E$ to any point of $l$ — which is
        the construction the next chapter is built on.],
    )
  ]
]

#print-hints()
#print-vocab()
