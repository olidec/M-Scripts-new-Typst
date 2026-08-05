#import "../../common/preamble.typ": *
#import "/src/common/vec-figures.typ": *
#show: chapter-template.with(title: "A Product That Points")
#let ex = exercise.with(chapter: "A Product That Points")

= A Product That Points

#only-theory[
  Part A left one debt outstanding. Twice you needed a vector
  perpendicular to two given vectors — once to find $a$ and $b$ in a
  dot-product exercise, once when the question of how close two skew
  lines get was raised and then postponed. Both times the answer came
  from solving a system of two equations, or did not come at all.

  It turns out that system can be solved once and for all, in general,
  and the answer written down as a formula. That formula is the
  subject of this chapter, and it is the last of the three ways of
  multiplying vectors: a number times a vector gives a vector, a
  vector dotted with a vector gives a number, and now a vector crossed
  with a vector gives *a vector again*.
]

#objectives(
  bfkm[calculate the cross product of two vectors and use it to find a
    vector perpendicular to both],
  [state and use the geometric description of $arrow(a) times arrow(b)$
    — direction by the right-hand rule, magnitude equal to the area of
    the spanned parallelogram],
  [find the area of a parallelogram or a triangle in space],
  [calculate the distance from a point to a line],
  [explain why the cross product is not commutative, and why it has no
    two-dimensional counterpart],
)

== Solving the Problem Once

#exploration(title: "Perpendicular to both")[
  Let $arrow(a) = vec(1, 2, 3)$ and $arrow(b) = vec(4, 5, 6)$.

  + Write down the two conditions that a vector
    $arrow(n) = vec(n_x, n_y, n_z)$ must satisfy in order to be
    perpendicular to both $arrow(a)$ and $arrow(b)$.

  + You now have two equations and three unknowns. Solve them as far
    as you can. How much freedom is left?

  + Find one specific vector that works, with whole-number components
    if you can.

  + Sketch the situation. Is your answer the *only* direction
    perpendicular to both, or are there others?
]

#only-theory[
  Two equations in three unknowns leave one degree of freedom, and
  geometrically that is exactly right: the vectors perpendicular to
  both $arrow(a)$ and $arrow(b)$ all lie on a single line through the
  origin. There is one *direction* (two, if you count forwards and
  backwards), and any length you like along it.

  So the problem has essentially one answer, which means it is worth
  solving in general rather than case by case. Writing the two
  conditions out,
  $ n_x a_x + n_y a_y + n_z a_z = 0, quad quad
    n_x b_x + n_y b_y + n_z b_z = 0, $
  and eliminating $n_z$ — multiply the first by $b_z$, the second by
  $a_z$, and subtract — gives
  $ n_x (a_x b_z - a_z b_x) + n_y (a_y b_z - a_z b_y) = 0. $

  That is satisfied by
  $ n_x = a_y b_z - a_z b_y, quad quad n_y = a_z b_x - a_x b_z, $
  and feeding these back into either original equation gives
  $ n_z = a_x b_y - a_y b_x. $

  Nothing here depended on the particular vectors, so this triple
  works every time. It has a name.
]

#definition(title: "The cross product")[
  The #vocab("cross product", "Vektorprodukt") of
  $arrow(a)$ and $arrow(b)$ is the vector
  $ arrow(a) times arrow(b) = vec(
      a_y dot b_z - a_z dot b_y,
      a_z dot b_x - a_x dot b_z,
      a_x dot b_y - a_y dot b_x
    ). $

  It is perpendicular to both $arrow(a)$ and $arrow(b)$.
]

#only-theory[
  The perpendicularity is worth verifying rather than trusting, and it
  takes one line. Dotting the formula with $arrow(a)$:
  $ a_x (a_y b_z - a_z b_y) + a_y (a_z b_x - a_x b_z)
    + a_z (a_x b_y - a_y b_x). $
  Expand and the six terms cancel in pairs — $a_x a_y b_z$ against
  $- a_x a_y b_z$, and so on — leaving $0$. The same happens with
  $arrow(b)$.

  *Example.* $vec(2, -1, 3) times vec(-1, 0, 5)$:
  $ vec(
      (-1) dot 5 - 3 dot 0,
      3 dot (-1) - 2 dot 5,
      2 dot 0 - (-1) dot (-1)
    ) = vec(-5, -13, -1). $
  Check: $vec(-5, -13, -1) dot vec(2, -1, 3) = -10 + 13 - 3 = 0$ and
  $vec(-5, -13, -1) dot vec(-1, 0, 5) = 5 + 0 - 5 = 0$.

  That check costs two dot products and catches almost every slip.
  Do it every time.
]

#remark[
  The cross product is also called the *vector product*, because
  unlike the dot product its result is a vector. The German
  *Vektorprodukt* says so directly, and sits alongside
  *Skalarprodukt* as a matched pair of names.

  It exists only in three dimensions. In the plane there is no
  direction left over to point in — given two vectors in a plane, a
  vector perpendicular to both would have to stick out of it, and
  there is no "out of it" available. This is the first piece of
  mathematics in this course that genuinely does not work in two
  dimensions.
]

== Remembering the Formula

#only-theory[
  The formula has a pattern, and there is a standard trick for
  reconstructing it without a reference.

  Write the two vectors as columns side by side, and repeat the first
  entry of each underneath:
  $ mat(a_x; a_y; a_z; a_x) quad quad mat(b_x; b_y; b_z; b_x) $

  Now cover up the *first* row. The four numbers left in the top two
  rows are $a_y, a_z$ and $b_y, b_z$, and multiplying crosswise and
  subtracting — down-right minus down-left — gives
  $a_y b_z - a_z b_y$, the first component of the answer.

  Cover the *second* row instead and repeat with the two rows below
  it: $a_z b_x - a_x b_z$, the second component. Cover the *third*,
  and the remaining rows give $a_x b_y - a_y b_x$.

  Each component of the answer is computed from the two rows that are
  *not* its own, which is the pattern worth remembering. The repeated
  entries at the bottom exist only so that the third component has two
  rows to work with.
]

#warning[
  The middle component has its subtraction the other way round from
  what the pattern suggests, and this is where the formula is most
  often got wrong.

  Read the three components as
  $ a_y b_z - a_z b_y, quad quad
    a_z b_x - a_x b_z, quad quad
    a_x b_y - a_y b_x $
  and notice that the subscripts cycle $x arrow.r y arrow.r z arrow.r x$
  in every one of them. If your middle component reads
  $a_x b_z - a_z b_x$, you have broken the cycle and picked up a sign
  error.

  The two-dot-product check will catch it.
]

== Direction and Length

#only-theory[
  The formula produces one particular vector out of the whole
  perpendicular line. Which one, and why that one?

  *Direction.* There are two ways to point perpendicular to a plane,
  and the formula picks one of them by the
  #vocab("right-hand rule", "Rechte-Hand-Regel"): if the index finger
  of your right hand points along $arrow(a)$ and the middle finger
  along $arrow(b)$, the thumb points along
  $arrow(a) times arrow(b)$.

  // #fig(image("/assets/vectors-space/right-hand-rule.png", width: 45%),
  //   caption: [The right-hand rule. Index along $arrow(a)$, middle
  //     along $arrow(b)$, thumb along $arrow(a) times arrow(b)$.])

  Try it with the basis vectors. Index along $arrow(e)_x$, middle
  along $arrow(e)_y$, and the thumb points along $arrow(e)_z$ — which
  matches the formula, since
  $vec(1, 0, 0) times vec(0, 1, 0) = vec(0, 0, 1)$.

  *Length.* The magnitude turns out to be the area of the
  parallelogram spanned by the two vectors, and this is not obvious at
  all. It follows from an identity connecting the two products.
]

#keybox(title: "Magnitude of the cross product")[
  $ abs(arrow(a) times arrow(b))
    = abs(arrow(a)) dot abs(arrow(b)) sin phi.alt, $
  where $phi.alt$ is the angle between $arrow(a)$ and $arrow(b)$.

  This is the area of the parallelogram spanned by $arrow(a)$ and
  $arrow(b)$, and half of it is the area of the triangle.
]

#only-theory[
  The proof is a computation you can follow. Expanding both sides of
  $ abs(arrow(a) times arrow(b))^2 + (arrow(a) dot arrow(b))^2
    = abs(arrow(a))^2 dot abs(arrow(b))^2 $
  in components gives the same nine-term expression on each side; this
  is called *Lagrange's identity*. Granting it, and using
  $arrow(a) dot arrow(b) = abs(arrow(a)) abs(arrow(b)) cos phi.alt$,
  $ abs(arrow(a) times arrow(b))^2
    = abs(arrow(a))^2 abs(arrow(b))^2 (1 - cos^2 phi.alt)
    = abs(arrow(a))^2 abs(arrow(b))^2 sin^2 phi.alt. $
  Taking square roots — and $sin phi.alt >= 0$ for
  $0degree <= phi.alt <= 180degree$, so no absolute value is needed —
  gives the formula.

  That it is the area is then just the parallelogram's base times its
  height:

  #fig(
    vplane(
      s-poly(
        ((0, 0), (5, 0), (7, 3), (2, 3)),
        fill: rgb("#eef0fa"),
        stroke-color: luma(175),
      ),
      s-vec(to: (5, 0), label: $arrow(a)$, anchor: 0.6),
      s-vec(to: (2, 3), label: $arrow(b)$, color: warn-col),
      s-seg(from: (2, 3), to: (2, 0), dashed: true, color: luma(140)),
      s-arc(
        vertex: (2, 0), from: (2, 3), to: (5, 0),
        r: 12pt, right: true, color: luma(130),
      ),
      s-arc(vertex: (0, 0), from: (5, 0), to: (2, 3), r: 24pt, label: $phi.alt$),
      s-txt((1.1, 1.6), text(size: 9pt)[$h$], off: (-9pt, 0pt)),
      xmin: -0.5, xmax: 7.5, ymin: -0.5, ymax: 3.5,
      unit: 0.62cm, grid: false, axes: false,
    ),
    caption: [Base $abs(arrow(a))$, height
      $h = abs(arrow(b)) sin phi.alt$. Their product is the area.],
  )

  *Example.* The parallelogram spanned by $vec(3, -3, 1)$ and
  $vec(4, 9, 2)$. Their cross product is $vec(-15, -2, 39)$, so the
  area is
  $ sqrt(225 + 4 + 1521) = sqrt(1750) = 5 sqrt(70) approx 41.8. $
]

== What the Cross Product Does Not Do

#keybox(title: "Rules")[
  $ arrow(a) times arrow(b) = -(arrow(b) times arrow(a)) $
  $ arrow(a) times arrow(a) = arrow(0) $
  $ arrow(a) times (arrow(b) + arrow(c))
    = arrow(a) times arrow(b) + arrow(a) times arrow(c) $
  $ (k dot arrow(a)) times arrow(b)
    = k dot (arrow(a) times arrow(b)) $
]

#only-theory[
  The first line says the cross product is
  #vocab("anticommutative", "antikommutativ"): swapping the two
  vectors reverses the answer. This is forced by the right-hand rule —
  exchange your index and middle fingers and the thumb ends up
  pointing the other way — and it is visible in the formula, where
  every term changes sign.

  The second line follows from the first, or from the area picture: a
  vector spans no parallelogram with itself.

  More generally, if $arrow(a)$ and $arrow(b)$ are *parallel* the
  angle between them is $0degree$ or $180degree$, the sine is zero,
  and the cross product is the null vector. That gives a second test
  for parallelism, alongside the scalar-multiple test from Part A.
]

#warning[
  Two habits from ordinary arithmetic that do not survive.

  *Order matters.* $arrow(a) times arrow(b)$ and
  $arrow(b) times arrow(a)$ are different vectors. Writing the two
  factors in the wrong order does not give a wrong-by-a-bit answer; it
  gives an answer pointing the opposite way.

  *Brackets matter.* The cross product is not associative:
  $ (arrow(a) times arrow(b)) times arrow(c)
    eq.not arrow(a) times (arrow(b) times arrow(c)) $
  in general. Take
  $arrow(a) = arrow(b) = arrow(e)_x$ and $arrow(c) = arrow(e)_y$: the
  left side is $arrow(0) times arrow(e)_y = arrow(0)$, while the right
  side is $arrow(e)_x times arrow(e)_z eq.not arrow(0)$. So an
  expression like $arrow(a) times arrow(b) times arrow(c)$ is
  meaningless without brackets.
]

== Distance from a Point to a Line

#only-theory[
  Here is the first thing the area interpretation buys you.

  Let $g$ be the line through $A$ and $B$, and let $P$ be a point not
  on it. The vectors $arrow(A B)$ and $arrow(A P)$ span a
  parallelogram whose area is $abs(arrow(A B) times arrow(A P))$. But
  the same parallelogram has base $abs(arrow(A B))$ and height equal
  to the perpendicular distance $d$ from $P$ to the line — which is
  exactly what we want.

  #fig(
    vplane(
      s-poly(
        ((0, 0), (6, 0), (8.5, 3), (2.5, 3)),
        fill: rgb("#eef0fa"),
        stroke-color: luma(180),
        dashed: true,
      ),
      s-seg(from: (-1, 0), to: (7.5, 0), color: def-col, width: 1.1pt, label: [$g$], anchor: 0.04),
      s-vec(to: (6, 0), label: $arrow(A B)$, anchor: 0.55),
      s-vec(to: (2.5, 3), label: $arrow(A P)$, color: warn-col),
      s-seg(from: (2.5, 3), to: (2.5, 0), color: accent, width: 1.1pt, label: [$d$], anchor: 0.5),
      s-arc(
        vertex: (2.5, 0), from: (2.5, 3), to: (6, 0),
        r: 12pt, right: true, color: luma(130),
      ),
      s-pt((0, 0), label: $A$),
      s-pt((6, 0), label: $B$),
      s-pt((2.5, 3), label: $P$),
      xmin: -1.5, xmax: 9.5, ymin: -0.5, ymax: 3.5,
      unit: 0.55cm, grid: false, axes: false,
    ),
  )

  Setting area $=$ base $times$ height and solving for the height:
]

#keybox(title: "Distance from a point to a line")[
  For the line $g$ through $A$ and $B$, and any point $P$,
  $ d(P, g) = abs(arrow(A B) times arrow(A P)) / abs(arrow(A B)). $
]

#only-theory[
  *Example.* The distance from $P = (5, 8, 4)$ to the line through
  $A = (2, 3, 0)$ and $B = (1, -3, -2)$.

  $ arrow(A B) = vec(-1, -6, -2), quad arrow(A P) = vec(3, 5, 4), $
  $ arrow(A B) times arrow(A P) = vec(-14, -2, 13), $
  $ d = sqrt(196 + 4 + 169) / sqrt(1 + 36 + 4)
    = sqrt(369) / sqrt(41) = sqrt(9) = 3. $

  Notice the last step. Rather than evaluating two square roots and
  dividing, combine them first: $369 slash 41 = 9$, and the answer is
  exact. Dividing $19.209$ by $6.403$ gives $3.0000$ and leaves you
  wondering whether it is really $3$.
]

#only-high[
  == Volumes

  #only-theory[
    One more product is available, and it needs no new machinery: dot
    the cross product of two vectors with a third.
  ]

  #definition(title: "Scalar triple product")[
    For three vectors,
    $ (arrow(a) times arrow(b)) dot arrow(c) $
    is a number, called the
    #vocab("scalar triple product", "Spatprodukt").

    Its absolute value is the volume of the
    #vocab("parallelepiped", "Spat") spanned by the three vectors.
  ]

  #only-theory[
    The reason is the same base-times-height argument, one dimension
    up. The parallelepiped has the parallelogram of $arrow(a)$ and
    $arrow(b)$ as its base, with area
    $abs(arrow(a) times arrow(b))$. Its height is the component of
    $arrow(c)$ perpendicular to that base — which is the component of
    $arrow(c)$ along the direction of $arrow(a) times arrow(b)$, and
    dotting with a vector is precisely how you measure that.

    Two consequences follow immediately.

    *Volume of a tetrahedron.* A tetrahedron on the same three edges
    occupies one sixth of the parallelepiped, so
    $ V = 1/6 dot abs((arrow(a) times arrow(b)) dot arrow(c)). $

    *A coplanarity test.* If the three vectors lie in one plane the
    parallelepiped is flat, so its volume is zero. Hence four points
    $A$, $B$, $C$, $D$ lie in a common plane exactly when
    $ (arrow(A B) times arrow(A C)) dot arrow(A D) = 0. $

    That second one is worth pausing over. Deciding whether four points
    in space are coplanar sounds like a hard question and it is
    genuinely hard to see. It costs one cross product and one dot
    product.
  ]
]

#look-ahead(preview: [planes])[
  You now have a machine that turns two directions into a
  perpendicular. The next chapter turns that into the definition of a
  plane.

  A plane is fixed by a point and two directions in it — but also, and
  much more usefully, by a point and one direction *perpendicular* to
  it. Getting from the first description to the second was impossible
  in Part A and is now a single cross product, which is why planes
  had to wait until this chapter was finished.
]

#ex(difficulty: 1, time: "10 min", calculator: false)[
  Calculate each cross product, and verify each answer with two dot
  products.

  #auto-parts(
    2,
    [$vec(2, -1, 3) times vec(-1, 0, 5)$],
    [$vec(2, -1, 1) times vec(1, 2, 5)$],
    [$vec(1, 2, 3) times vec(4, 5, 6)$],
    [$vec(4, 5, 6) times vec(1, 2, 3)$],
  )

  What is the relationship between your answers to (c) and (d)?
][
  #auto-parts(
    2,
    [$vec(-5, -13, -1)$],
    [$vec(-7, -9, 5)$],
    [$vec(-3, 6, -3)$],
    [$vec(3, -6, 3)$],
  )

  (d) is the negative of (c), as anticommutativity requires. The two
  answers are perpendicular to the same plane and point in opposite
  directions — one obeys the right-hand rule for the pair in one
  order, the other for the pair in the other order.
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Without calculating anything, predict the nine cross products of the
  basis vectors $arrow(e)_x$, $arrow(e)_y$, $arrow(e)_z$ with one
  another. Then check three of your predictions with the formula.
][
  The three "diagonal" cases give the null vector, since a vector
  crossed with itself is $arrow(0)$:
  $ arrow(e)_x times arrow(e)_x = arrow(e)_y times arrow(e)_y
    = arrow(e)_z times arrow(e)_z = arrow(0). $

  The others cycle:
  $ arrow(e)_x times arrow(e)_y = arrow(e)_z, quad
    arrow(e)_y times arrow(e)_z = arrow(e)_x, quad
    arrow(e)_z times arrow(e)_x = arrow(e)_y, $
  and the three reversed products are the negatives of these.

  The cycle $x arrow.r y arrow.r z arrow.r x$ is the same one that
  appears in the subscripts of the general formula — the formula is
  built so that these nine cases come out right.
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Given $A = (2, 1, 1)$, $B = (4, 2, -1)$ and $C = (1, 1, -2)$, use
  the cross product to find the area of triangle $A B C$. Give the
  answer exactly.
][
  $ arrow(A B) = vec(2, 1, -2), quad arrow(A C) = vec(-1, 0, -3), $
  $ arrow(A B) times arrow(A C) = vec(-3, 8, 1), $
  $ "Area" = 1/2 dot sqrt(9 + 64 + 1) = sqrt(74)/2 approx 4.30. $

  The cross product gives the area of the *parallelogram*; the
  triangle is half of it. Forgetting the factor $1 slash 2$ is the
  standard error here.
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Find the area of triangle $A B C$ with $A = (-1, 3, 4)$,
  $B = (5, 7, 5)$ and $C = (3, 9, 6)$, exactly and then as a decimal.
][
  $ arrow(A B) = vec(6, 4, 1), quad arrow(A C) = vec(4, 6, 2), $
  $ arrow(A B) times arrow(A C) = vec(2, -8, 20), $
  $ "Area" = 1/2 dot sqrt(4 + 64 + 400) = 1/2 dot sqrt(468). $

  Simplify before evaluating: $468 = 4 dot 117 = 4 dot 9 dot 13$, so
  $sqrt(468) = 6 sqrt(13)$ and the area is
  $ 3 sqrt(13) approx 10.82. $
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Show that if $arrow(a)$ and $arrow(b)$ are parallel, then
  $arrow(a) times arrow(b) = arrow(0)$.

  Give both an algebraic argument from the formula and a geometric
  one.
][
  *Algebraic.* Parallel means $arrow(b) = k dot arrow(a)$ for some
  $k$. Substituting into the first component,
  $ a_y (k a_z) - a_z (k a_y) = k (a_y a_z - a_z a_y) = 0, $
  and the same cancellation happens in the other two components.

  *Geometric.* The magnitude is
  $abs(arrow(a)) abs(arrow(b)) sin phi.alt$, and parallel vectors have
  $phi.alt = 0degree$ or $180degree$, so $sin phi.alt = 0$.
  Equivalently: two parallel vectors span a parallelogram of zero
  area, because it is squashed flat.

  Note that this gives a second parallelism test. Rather than
  comparing three ratios and worrying about zero components, compute
  one cross product and see whether it vanishes.
]

#ex(difficulty: 3, time: "12 min", calculator: false, hints: (
  "The two vectors AB and AP span a parallelogram. What is its area, and what is its base?",
  "Combine the two square roots into one before evaluating anything.",
))[
  Find the distance from $P = (5, 8, 4)$ to the line through
  $A = (2, 3, 0)$ and $B = (1, -3, -2)$.
][
  $ arrow(A B) = vec(-1, -6, -2), quad arrow(A P) = vec(3, 5, 4), $
  $ arrow(A B) times arrow(A P) = vec(-24 + 10, -6 + 4, -5 + 18)
    = vec(-14, -2, 13). $

  Then
  $ d = abs(arrow(A B) times arrow(A P)) / abs(arrow(A B))
    = sqrt(196 + 4 + 169) / sqrt(1 + 36 + 4)
    = sqrt(369 / 41) = sqrt(9) = 3. $

  Combining the roots first turns an ugly-looking quotient into an
  exact whole number.
]

#only-high[
  #ex(difficulty: 3, time: "18 min", calculator: false)[
    #auto-parts(
      1,
      [Do the four points $A = (2, 1, 0)$, $B = (0, 4, -3)$,
        $C = (-1, 0, 5)$ and $D = (3, 5, 2)$ lie in one plane?],
      [Find the volume of the tetrahedron $A B C D$.],
      [The three edges of a parallelepiped meeting at one vertex are
        $vec(2, 0, 0)$, $vec(1, 3, 0)$ and $vec(1, 1, 4)$. Find its
        volume, and explain why the answer is what it is without doing
        the full calculation.],
    )
  ][
    #auto-parts(
      1,
      [$ arrow(A B) = vec(-2, 3, -3), quad
         arrow(A C) = vec(-3, -1, 5), quad
         arrow(A D) = vec(1, 4, 2), $
       $ arrow(A B) times arrow(A C) = vec(12, 19, 11), $
       $ (arrow(A B) times arrow(A C)) dot arrow(A D)
         = 12 + 76 + 22 = 110. $
       Not zero, so the four points are *not* coplanar.],
      [The parallelepiped has volume $110$, so the tetrahedron has
        $ V = 110/6 = 55/3 approx 18.3. $],
      [The three vectors form a "staircase": each one introduces a new
        coordinate direction that the previous ones did not reach. The
        volume is
        $ abs((vec(2, 0, 0) times vec(1, 3, 0)) dot vec(1, 1, 4))
          = abs(vec(0, 0, 6) dot vec(1, 1, 4)) = 24, $
        which is $2 dot 3 dot 4$ — the product of the three "new"
        components.

        The reason is that the solid can be sheared into a rectangular
        box of those dimensions without changing its volume. Shearing
        slides layers sideways, which changes the shape but not the
        base area or the height, and the triple product is blind to
        exactly that kind of change.],
    )
  ]
]

#print-hints()
#print-vocab()
