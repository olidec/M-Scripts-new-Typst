#import "../../common/preamble.typ": *
#import "/src/common/vec-figures.typ": *
#show: chapter-template.with(title: "Angles from Arithmetic")
#let ex = exercise.with(chapter: "Angles from Arithmetic")

= Angles from Arithmetic

#only-theory[
  So far every operation on vectors has produced another vector. Add
  two arrows, get an arrow. Scale an arrow, get an arrow. This chapter
  introduces an operation that behaves differently: it takes two
  vectors and returns a plain number.

  That sounds like a step backwards, and it is worth saying at the
  outset what the number is for. It answers a question none of the
  previous machinery could touch — *what is the angle between these
  two directions?* — and it answers it by arithmetic alone, with no
  drawing, no protractor, and no restriction to two dimensions.

  Everything in this chapter comes out of one calculation, which is
  where we start.
]

#objectives(
  bfkm[calculate the dot product of two vectors and use it to find the
    angle between them],
  [explain why the component formula and the cosine formula describe
    the same number],
  [test two vectors for perpendicularity, and read the sign of a dot
    product as acute, right or obtuse],
  [find a vector perpendicular to given vectors by solving
    $arrow(a) dot arrow(x) = 0$],
  [resolve a vector into components parallel and perpendicular to a
    given direction],
)

== A Calculation Worth Doing

#only-theory[
  Two vectors $arrow(a)$ and $arrow(b)$ start at the same point, with
  an angle $phi.alt$ between them. Together with the vector
  $arrow(b) - arrow(a)$ joining their heads, they form a triangle.

  #fig(
    vplane(
      s-vec(to: (5, 1), label: $arrow(a)$),
      s-vec(to: (2, 4), label: $arrow(b)$, color: warn-col),
      s-vec(
        from: (5, 1),
        to: (2, 4),
        label: $arrow(b) - arrow(a)$,
        color: def-col,
        anchor: 0.5,
      ),
      s-arc(
        vertex: (0, 0),
        from: (5, 1),
        to: (2, 4),
        r: 30pt,
        label: $phi.alt$,
      ),
      xmin: -0.5,
      xmax: 6.5,
      ymin: -0.5,
      ymax: 4.5,
      unit: 0.7cm,
      grid: false,
      axes: false,
    ),
  )

  A triangle with two known sides and the angle between them is
  exactly the situation the law of cosines was built for. Applied
  here, with $abs(arrow(b) - arrow(a))$ as the side opposite
  $phi.alt$:
  $
    abs(arrow(b) - arrow(a))^2
    = abs(arrow(a))^2 + abs(arrow(b))^2
    - 2 dot abs(arrow(a)) dot abs(arrow(b)) cos phi.alt.
  $

  Now write the left-hand side out in components. In space,
  $
    abs(arrow(b) - arrow(a))^2
    = (b_x - a_x)^2 + (b_y - a_y)^2 + (b_z - a_z)^2.
  $
  Expanding each bracket and regrouping,
  $
    abs(arrow(b) - arrow(a))^2
    = underbrace((a_x^2 + a_y^2 + a_z^2), abs(arrow(a))^2)
    + underbrace((b_x^2 + b_y^2 + b_z^2), abs(arrow(b))^2)
    - 2 (a_x dot b_x + a_y dot b_y + a_z dot b_z).
  $

  Two expressions for the same quantity. The $abs(arrow(a))^2$ and
  $abs(arrow(b))^2$ terms appear in both and cancel, and dividing by
  $-2$ leaves something remarkable:
  $
    a_x dot b_x + a_y dot b_y + a_z dot b_z
    = abs(arrow(a)) dot abs(arrow(b)) cos phi.alt.
  $
]

#only-theory[
  Read that line slowly, because it is the entire chapter.

  On the left is a combination of the six components — pure
  arithmetic, no geometry, computable by anyone who can multiply and
  add. On the right is a statement about *lengths and an angle* —
  pure geometry, and in particular it contains $phi.alt$, the quantity
  you actually wanted.

  Nothing in the derivation assumed anything about the two vectors. So
  this holds always, and the number on the left is worth a name.
]

#definition(title: "The dot product")[
  The #vocab("dot product", "Skalarprodukt") of two vectors is the
  number
  $
    arrow(a) dot arrow(b)
    = a_x dot b_x + a_y dot b_y + a_z dot b_z,
  $
  and equivalently
  $
    arrow(a) dot arrow(b)
    = abs(arrow(a)) dot abs(arrow(b)) cos phi.alt,
  $
  where $phi.alt$ is the angle between $arrow(a)$ and $arrow(b)$.

  In the plane the same holds with the $z$#"‑"terms omitted.
]

#remark[
  The dot product is also called the *scalar product*, because the
  result is a scalar — an ordinary number, not a vector. The German
  name *Skalarprodukt* keeps that front and centre.

  Both names are in use and your formula booklet uses the second. In
  this course we mostly say "dot product", because there is another
  product coming later whose result *is* a vector, and it is helpful
  if the two are named after their symbols rather than after a
  distinction you have to remember.
]

#warning[
  This is the third job the raised dot has been given, and the three
  are genuinely different operations.

  - $2 dot 5$: number times number, gives a number.
  - $3 dot arrow(a)$: number times vector, gives a vector.
  - $arrow(a) dot arrow(b)$: vector times vector, gives a *number*.

  Read what stands on either side of the dot and the ambiguity
  disappears. What you must never do is mix them: the expression
  $arrow(a) dot arrow(b) dot arrow(c)$ is meaningless, because
  $arrow(a) dot arrow(b)$ is a number and a number cannot be dotted
  with a vector. The best you can write is
  $(arrow(a) dot arrow(b)) dot arrow(c)$, which is a *scalar multiple*
  of $arrow(c)$ — a completely different beast.
]

== Angles

#keybox(title: "The angle between two vectors")[
  $
    cos phi.alt
    = (arrow(a) dot arrow(b)) / (abs(arrow(a)) dot abs(arrow(b))),
    quad quad 0degree <= phi.alt <= 180degree.
  $
]

#only-theory[
  The recipe: compute the dot product from the components, compute the
  two magnitudes, divide, take the inverse cosine.

  Note the range. Two vectors drawn from a common point enclose two
  angles that add to $360degree$; by convention the angle *between*
  them is the smaller one, so it never exceeds $180degree$. That is
  exactly the range $arccos$ returns, so unlike the direction angle of
  the previous chapter there is no quadrant trap here. The formula
  gives the right answer directly.

  *Example.* Find the angle between
  $arrow(a) = vec(1, -2, 2)$ and $arrow(b) = vec(-3, 0, -3)$.

  $ arrow(a) dot arrow(b) = 1 dot (-3) + (-2) dot 0 + 2 dot (-3) = -9. $
  $
    abs(arrow(a)) = sqrt(1 + 4 + 4) = 3, quad
    abs(arrow(b)) = sqrt(9 + 0 + 9) = sqrt(18) = 3 sqrt(2).
  $
  $
    cos phi.alt = (-9) / (3 dot 3 sqrt(2)) = -1/sqrt(2)
    quad arrow.r.double quad phi.alt = 135degree.
  $

  Exact, and no calculator was needed — because the numbers were
  chosen so that the cosine came out standard. Most of the time it
  will not, and then you round at the end.
]

== What the Sign Tells You

#only-theory[
  Before computing any angle, the *sign* of the dot product already
  says a good deal. Since $abs(arrow(a))$ and $abs(arrow(b))$ are
  never negative, the sign of $arrow(a) dot arrow(b)$ is the sign of
  $cos phi.alt$.
]

#keybox(title: "Reading the sign")[
  $
    arrow(a) dot arrow(b) > 0 quad arrow.l.r.double quad
    phi.alt < 90degree quad "(acute)"
  $
  $
    arrow(a) dot arrow(b) = 0 quad arrow.l.r.double quad
    phi.alt = 90degree quad "(right angle)"
  $
  $
    arrow(a) dot arrow(b) < 0 quad arrow.l.r.double quad
    phi.alt > 90degree quad "(obtuse)"
  $
]

#only-theory[
  The middle line is the one you will use most, and it deserves its
  own statement.
]

#keybox(title: "Perpendicularity test")[
  For non-zero vectors,
  $
    arrow(a) perp arrow(b) quad arrow.l.r.double quad
    arrow(a) dot arrow(b) = 0.
  $
]

#only-theory[
  This is the single most useful fact in the unit. It converts a
  geometric condition — *these two directions meet at a right angle* —
  into one linear equation in the components. Every perpendicularity
  question from here on, in any number of dimensions, is solved by
  setting a dot product to zero.

  A quick check: $vec(2, 3)$ and $vec(3, -2)$ give
  $2 dot 3 + 3 dot (-2) = 0$, so they are perpendicular. In the plane
  you can see the trick — swap the components and flip one sign. In
  space there is no such trick, and the equation is all you have.
]

#warning[
  $arrow(a) dot arrow(b) = 0$ does *not* mean that one of the vectors
  is the null vector.

  This breaks a rule you have relied on since primary school: if a
  product of two ordinary numbers is zero, one of them must be zero.
  For dot products that is simply false —
  $vec(2, 3) dot vec(3, -2) = 0$ with neither vector anywhere near
  zero.

  A related casualty: you cannot cancel. From
  $arrow(a) dot arrow(b) = arrow(a) dot arrow(c)$ it does *not*
  follow that $arrow(b) = arrow(c)$. All you may conclude is that
  $arrow(a) dot (arrow(b) - arrow(c)) = 0$, meaning $arrow(a)$ is
  perpendicular to the difference — which leaves infinitely many
  possibilities.

  And there is no division. $arrow(a) slash arrow(b)$ is not
  defined and never will be.
]

#only-theory[
  === The rules that do survive

  $ arrow(a) dot arrow(b) = arrow(b) dot arrow(a) $
  $
    arrow(a) dot (arrow(b) + arrow(c))
    = arrow(a) dot arrow(b) + arrow(a) dot arrow(c)
  $
  $ (k dot arrow(a)) dot arrow(b) = k dot (arrow(a) dot arrow(b)) $
  $ arrow(a) dot arrow(a) = abs(arrow(a))^2 $

  The last one is worth a second look. Setting $arrow(b) = arrow(a)$
  makes $phi.alt = 0degree$ and $cos phi.alt = 1$, so
  $arrow(a) dot arrow(a) = abs(arrow(a))^2$ — and in components that
  reads $a_x^2 + a_y^2 + a_z^2$, which is the magnitude formula from
  two chapters ago. The dot product contains Pythagoras as a special
  case.
]

== Resolving Along a Direction

#only-theory[
  The previous chapter ended with a promise: the dot product would
  generalize the ramp calculation, where a weight was split into a
  part along a slope and a part pressing into it. Here is the general
  version.

  Given a vector $arrow(b)$ and a direction $arrow(a)$, how much of
  $arrow(b)$ points along $arrow(a)$?

  #fig(
    vplane(
      s-vec(to: (6, 0), label: $arrow(a)$, anchor: 0.88),
      s-vec(to: (3.5, 3), label: $arrow(b)$, color: warn-col),
      s-vec(to: (3.5, 0), label: $arrow(b)_(∥)$, color: def-col, anchor: 0.5),
      s-seg(from: (3.5, 0), to: (3.5, 3), color: luma(160), dashed: true),
      s-arc(
        vertex: (3.5, 0),
        from: (3.5, 3),
        to: (6, 0),
        r: 12pt,
        right: true,
        color: luma(120),
      ),
      s-arc(
        vertex: (0, 0),
        from: (6, 0),
        to: (3.5, 3),
        r: 26pt,
        label: $phi.alt$,
      ),
      xmin: -0.5,
      xmax: 7.5,
      ymin: -0.5,
      ymax: 4.5,
      unit: 0.62cm,
      grid: false,
      axes: false,
    ),
    caption: [Dropping a perpendicular from the head of $arrow(b)$ onto
      the line of $arrow(a)$ gives the parallel component
      $arrow(b)_(∥)$.],
  )

  From the right triangle, the length of that component is
  $abs(arrow(b)) cos phi.alt$ — and the dot product hands you exactly
  that combination. Rearranging the cosine formula,
  $
    abs(arrow(b)) cos phi.alt
    = (arrow(a) dot arrow(b)) / abs(arrow(a))
    = arrow(b) dot arrow(e)_a.
  $

  So *dotting with a unit vector measures how far you get in that
  direction*. That sentence is worth memorising; it is what the dot
  product is for.
]

#keybox(title: "Components along and across a direction")[
  The #vocab("scalar projection", "Skalarprojektion") of $arrow(b)$ onto
  $arrow(a)$ is
  $
    b_a = arrow(b) dot arrow(e)_a
    = (arrow(a) dot arrow(b)) / abs(arrow(a)).
  $

  The corresponding vector is
  $
    arrow(b)_(∥)
    = (arrow(a) dot arrow(b)) / abs(arrow(a))^2 dot arrow(a),
    quad quad
    arrow(b)_(⊥) = arrow(b) - arrow(b)_(∥).
  $
]

#only-theory[
  *Example.* Resolve $arrow(b) = vec(3, 3, 0)$ along and across
  $arrow(a) = vec(1, 2, 2)$.

  $
    arrow(a) dot arrow(b) = 3 + 6 + 0 = 9, quad
    abs(arrow(a))^2 = 1 + 4 + 4 = 9,
  $
  $
    arrow(b)_(∥) = 9/9 dot vec(1, 2, 2) = vec(1, 2, 2), quad
    arrow(b)_(⊥) = vec(3, 3, 0) - vec(1, 2, 2) = vec(2, 1, -2).
  $

  Two checks, both one line. The parts must add back to $arrow(b)$:
  $vec(1, 2, 2) + vec(2, 1, -2) = vec(3, 3, 0)$. And they must be
  perpendicular: $1 dot 2 + 2 dot 1 + 2 dot (-2) = 0$. Both hold.

  Look back at the ramp now. There, $arrow(b)$ was the weight pointing
  straight down and $arrow(a)$ was the direction of the slope, and the
  answer was $G sin alpha$. The angle between "straight down" and "up
  the slope" is $90degree + alpha$, whose cosine is $-sin alpha$ — the
  minus sign saying the weight pulls *down* the slope rather than up
  it. Same calculation, stated generally.
]

#only-theory[
  === Work

  In physics, the work done by a constant force $arrow(F)$ moving an
  object through a displacement $arrow(s)$ is
  $ W = arrow(F) dot arrow(s). $

  This is not a coincidence or an analogy. Only the part of the force
  along the direction of motion does any work; a force perpendicular
  to the motion does none at all. That is precisely what
  $abs(arrow(F)) abs(arrow(s)) cos phi.alt$ says, and it explains why
  carrying a heavy suitcase horizontally at constant speed does no
  work in the physicist's sense, however tired you get.
]

#look-ahead(preview: [normal vectors and planes])[
  The perpendicularity test is about to become the definition of a
  plane.

  Fix a point $A$ and a direction $arrow(n)$. Ask for every point $P$
  such that $arrow(A P)$ is perpendicular to $arrow(n)$ — that is,
  every $P$ with
  $ arrow(n) dot arrow(A P) = 0. $
  The set of such points is a plane, $arrow(n)$ is called its *normal
  vector*, and multiplying that equation out in components produces
  the familiar $a x + b y + c z + d = 0$.

  One dot product set to zero, and the entire theory of planes follows.
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Calculate each dot product.

  #auto-parts(
    3,
    [$vec(-1, -4) dot vec(12, -6)$],
    [$vec(2, 3) dot vec(3, -2)$],
    [$vec(1, 3, 5) dot vec(-1, -1, 2)$],
    [$vec(4, -1, 7) dot vec(5, 1, 3)$],
    [$vec(1, -2, 2) dot vec(2, 2, 1)$],
    [$vec(3, 0, -1) dot vec(3, 0, -1)$],
  )

  Two of your answers are $0$. What does that mean geometrically? And
  what is special about (f)?
][
  #auto-parts(
    3,
    [$-12 + 24 = 12$],
    [$6 - 6 = 0$],
    [$-1 - 3 + 10 = 6$],
    [$20 - 1 + 21 = 40$],
    [$2 - 4 + 2 = 0$],
    [$9 + 0 + 1 = 10$],
  )

  Parts (b) and (e) give $0$, so those pairs are perpendicular. Note
  that neither vector is small or special-looking — the right angle is
  invisible in the numbers until you do the multiplication.

  Part (f) is a vector dotted with itself, which gives
  $abs(arrow(a))^2$. So $abs(vec(3, 0, -1)) = sqrt(10)$.
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  Find the angle between each pair. All four come out exactly.

  #auto-parts(
    2,
    [$vec(1, 1, 0)$ and $vec(1, 0, 1)$],
    [$vec(1, 1, 0)$ and $vec(-1, 0, 1)$],
    [$vec(3, 4)$ and $vec(4, -3)$],
    [$vec(2, 0, 0)$ and $vec(-5, 0, 0)$],
  )
][
  #auto-parts(
    1,
    [Dot product $1$; both magnitudes $sqrt(2)$; so
      $cos phi.alt = 1 slash 2$ and $phi.alt = 60degree$.],
    [Dot product $-1$; magnitudes $sqrt(2)$ again;
      $cos phi.alt = -1 slash 2$ and $phi.alt = 120degree$.],
    [Dot product $12 - 12 = 0$, so $phi.alt = 90degree$.],
    [Dot product $-10$; magnitudes $2$ and $5$;
      $cos phi.alt = -1$ and $phi.alt = 180degree$. The vectors are
      antiparallel — opposite directions along one line.],
  )

  Parts (a) and (b) are worth remembering. Those vectors are diagonals
  of two faces of a unit cube meeting at an edge, so you have just
  shown that two face diagonals meeting at a vertex enclose $60degree$
  — which means the triangle formed by three such diagonals is
  equilateral. That is the corner-cut triangle you drew by eye in the
  first chapter, now proved.
]

#ex(difficulty: 2, time: "10 min", calculator: true)[
  Find the angle between each pair, to one decimal place.

  #auto-parts(
    2,
    [$vec(2, -3)$ and $vec(1, 2)$],
    [$vec(1, -2, 1)$ and $vec(2, -1, 1)$],
  )
][
  #auto-parts(
    1,
    [Dot product $2 - 6 = -4$; magnitudes $sqrt(13)$ and $sqrt(5)$. So
      $
        cos phi.alt = (-4) / sqrt(65) approx -0.4961
        arrow.r.double phi.alt approx 119.7degree.
      $
      The negative dot product told you it would be obtuse before any
      inverse cosine was taken.],
    [Dot product $2 + 2 + 1 = 5$; both magnitudes $sqrt(6)$. So
      $
        cos phi.alt = 5/6 approx 0.8333
        arrow.r.double phi.alt approx 33.6degree.
      $],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Without calculating any angles, decide for each pair whether the
  angle between them is acute, right or obtuse.

  #auto-parts(
    2,
    [$vec(5, 1, -2)$ and $vec(1, 3, 4)$],
    [$vec(-2, 6, 1)$ and $vec(3, 1, 2)$],
    [$vec(4, -1, 2)$ and $vec(1, 2, -1)$],
    [$vec(0, 7, -3)$ and $vec(9, 3, 8)$],
  )
][
  #auto-parts(
    2,
    [$5 + 3 - 8 = 0$: right angle.],
    [$-6 + 6 + 2 = 2 > 0$: acute.],
    [$4 - 2 - 2 = 0$: right angle.],
    [$0 + 21 - 24 = -3 < 0$: obtuse.],
  )

  Compare (a) with (b), and (c) with (d). In each pair the vectors
  look much alike and the answers differ, which is the point: there is
  no way to tell from the shape of the components. The arithmetic is
  not optional.

  Note also how little of it was needed. Nobody computed a magnitude,
  a quotient or an inverse cosine — the sign of one sum settles the
  question, and that sum takes about five seconds.
]

#ex(difficulty: 2, time: "12 min", calculator: false, hints: (
  "Perpendicular to both means two separate dot-product equations, each equal to zero.",
  "That gives you two linear equations in the two unknowns a and b. Solve them as you would any system.",
))[
  The vector $vec(7, a, b)$ is perpendicular to both $vec(4, 3, 8)$
  and $vec(-5, 20, 9)$. Find $a$ and $b$.
][
  Each perpendicularity gives one equation:
  $ 28 + 3a + 8b = 0, quad quad -35 + 20a + 9b = 0. $

  From the first, $3a + 8b = -28$; from the second,
  $20a + 9b = 35$. Multiply the first by $20$ and the second by $3$,
  then subtract:
  $
    160b - 27b = -560 - 105 quad arrow.r.double quad 133b = -665
    quad arrow.r.double quad b = -5,
  $
  and substituting back, $3a - 40 = -28$, so $a = 4$.

  *Check.* $vec(7, 4, -5) dot vec(4, 3, 8) = 28 + 12 - 40 = 0$ and
  $vec(7, 4, -5) dot vec(-5, 20, 9) = -35 + 80 - 45 = 0$. Both hold.

  Finding a vector perpendicular to two given vectors is a task that
  will come up constantly. Here it took a system of two equations;
  later a single formula will do it in one line.
]

#ex(difficulty: 3, time: "15 min", calculator: false, hints: (
  "Build the three side vectors first. A right angle at a vertex means the two sides leaving that vertex are perpendicular.",
  "Test all three vertices — do not assume which one it is.",
  "For the area, the two perpendicular sides are the base and the height.",
))[
  The points $A = (1, 2, 3)$, $B = (-3, 2, 4)$ and $C = (1, -4, 3)$
  are the vertices of a triangle.

  #auto-parts(
    1,
    [Show that the triangle is right-angled, and say at which vertex.],
    [Find its area, exactly.],
  )
][
  #auto-parts(
    1,
    [The sides leaving $A$ are
      $ arrow(A B) = vec(-4, 0, 1), quad arrow(A C) = vec(0, -6, 0). $
      Their dot product is $0 + 0 + 0 = 0$, so the right angle is at
      $A$.

      For completeness, at $B$: $arrow(B A) = vec(4, 0, -1)$ and
      $arrow(B C) = vec(4, -6, -1)$ give $16 + 0 + 1 = 17 eq.not 0$,
      so that vertex is not the right angle either.],
    [With the right angle at $A$, the two legs are the base and the
      height:
      $
        abs(arrow(A B)) = sqrt(16 + 0 + 1) = sqrt(17), quad
        abs(arrow(A C)) = sqrt(0 + 36 + 0) = 6,
      $
      $ "Area" = 1/2 dot sqrt(17) dot 6 = 3 sqrt(17). $],
  )

  Notice how little work part (a) was. Deciding whether three points in
  space form a right triangle by drawing them would be hopeless; here
  it is three dot products, and two of them were not even needed.
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  A crate is dragged $12$ m along a level floor by a rope. The rope
  pulls with a force of $200$ N at an angle of $60degree$ above the
  horizontal.

  #auto-parts(
    1,
    [How much work does the rope do?],
    [The floor pushes up on the crate with a normal force
      perpendicular to the floor. How much work does *that* force do?],
    [At what rope angle would the same $200$ N do the most work? What
      does the formula say happens at $90degree$?],
  )
][
  #auto-parts(
    1,
    [$W = abs(arrow(F)) abs(arrow(s)) cos phi.alt
      = 200 dot 12 dot cos 60degree = 200 dot 12 dot 1/2 = 1200$ J.],
    [None. The normal force is perpendicular to the displacement, so
      the dot product is $0$ regardless of how large the force is.],
    [At $phi.alt = 0degree$, pulling horizontally, where
      $cos phi.alt = 1$ and $W = 2400$ J. At $90degree$ the rope is
      vertical, $cos 90degree = 0$, and the work is zero — the rope
      would be lifting rather than dragging, and the crate would not
      move along the floor at all.],
  )
]

#only-high[
  #ex(difficulty: 3, time: "16 min", calculator: false)[
    #auto-parts(
      1,
      [Resolve $arrow(b) = vec(5, 4, 1)$ into a component parallel to
        $arrow(a) = vec(2, 2, -1)$ and a component perpendicular to
        it. Verify both of the standard checks.],
      [Show that $abs(arrow(b))^2 = abs(arrow(b)_(∥))^2
        + abs(arrow(b)_(⊥))^2$ for your answer, and explain why this
        must always hold.],
      [In the cube of edge $4$ from the first chapter, find the angle
        between the space diagonal $arrow(D F)$ and the edge
        $arrow(D A)$, and the angle between the two space diagonals
        $arrow(D F)$ and $arrow(A G)$. Give exact cosines, then
        decimal angles.],
    )
  ][
    #auto-parts(
      1,
      [$arrow(a) dot arrow(b) = 10 + 8 - 1 = 17$ and
        $abs(arrow(a))^2 = 4 + 4 + 1 = 9$, so
        $
          arrow(b)_(∥) = 17/9 dot vec(2, 2, -1)
          = vec(34 slash 9, 34 slash 9, -17 slash 9),
        $
        $
          arrow(b)_(⊥) = vec(5, 4, 1) - arrow(b)_(∥)
          = vec(11 slash 9, 2 slash 9, 26 slash 9).
        $
        *Checks.* The two parts add back to $arrow(b)$ by
        construction. Perpendicularity:
        $arrow(a) dot arrow(b)_(⊥) = 22 slash 9 + 4 slash 9
        - 26 slash 9 = 0$.],
      [$abs(arrow(b))^2 = 25 + 16 + 1 = 42$. For the parts,
        $abs(arrow(b)_(∥))^2 = (17 slash 9)^2 dot 9 = 289 slash 9$ and
        $abs(arrow(b)_(⊥))^2 = (121 + 4 + 676) slash 81
        = 801 slash 81 = 89 slash 9$. Their sum is
        $378 slash 9 = 42$. ✓

        It must always hold because $arrow(b)_(∥)$ and
        $arrow(b)_(⊥)$ are perpendicular and add to $arrow(b)$ — so
        they are the two legs of a right triangle with $arrow(b)$ as
        hypotenuse, and this is Pythagoras. Algebraically:
        $abs(arrow(b))^2 = (arrow(b)_(∥) + arrow(b)_(⊥))
        dot (arrow(b)_(∥) + arrow(b)_(⊥))$, and the two cross terms
        vanish.],
      [With $D$ at the origin, $arrow(D F) = vec(4, 4, 4)$,
        $arrow(D A) = vec(4, 0, 0)$ and
        $arrow(A G) = vec(-4, 4, 4)$.

        *Diagonal and edge.* Dot product $16$; magnitudes $4 sqrt(3)$
        and $4$. So $cos phi.alt = 16 slash (16 sqrt(3))
        = 1 slash sqrt(3)$, giving
        $phi.alt approx 54.7degree$.

        *Two diagonals.* Dot product $-16 + 16 + 16 = 16$; both
        magnitudes $4 sqrt(3)$. So
        $cos phi.alt = 16 slash 48 = 1 slash 3$, giving
        $phi.alt approx 70.5degree$.

        The first answer is one you have met twice already: it is the
        angle whose cosine is $1 slash sqrt(3)$, the largest angle a
        vector can make with all three axes at once. The space
        diagonal is the direction that treats the three axes equally,
        which is exactly why that number keeps appearing.],
    )
  ]
]

#print-hints()
#print-vocab()
