#import "../../common/preamble.typ": *
#import "/src/common/vec-figures.typ": *
#show: chapter-template.with(title: "Arrows in Space")
#let ex = exercise.with(chapter: "Arrows in Space")

#let V = cube-pts(a: 4)

= Arrows in Space

#epigraph(by: [Vector, in _Despicable Me_ (2010)])[
  It's a mathematical term, represented by an arrow with both
  direction and magnitude.
]

#only-theory[
  The character goes on to explain that he chose the name because he
  commits crimes with both direction and magnitude, which is the only
  joke in this unit that has already been made for us. It is also a
  surprisingly serviceable definition, and this chapter is largely
  about what has to be added to it before it becomes usable.

  In the previous chapter you located points in space by describing
  them in sentences, found that clumsy, and replaced the sentences
  with triples of numbers. This chapter does the same thing for
  *movements*: how far, and in what direction. It turns out that once
  you can say that precisely, a great deal else follows.
]

#objectives(
  bfkm[represent a vector as an arrow, as a pair of points, and as a
    column of components, and move between the three],
  [decide whether a given quantity is a scalar or a vector],
  [recognize when two arrows drawn in different places represent the
    same vector],
  [distinguish a point from a position vector, and say why they look
    alike],
  [write down the opposite of a vector and the null vector],
  [calculate the magnitude of a vector in two and in three dimensions,
    and leave the answer exact],
)

== What Needs a Direction

#only-theory[
  Some quantities are completely described by a single number,
  together with a unit. The temperature in this room, the mass of a
  book, the area of a field, the price of a train ticket: one number
  each, and nothing is missing. Such a quantity is called a
  #vocab("scalar", "Skalar").

  Other quantities are not. Suppose you are told that a force of
  $500$ newtons is being applied to a truck stuck on a $10degree$
  slope. That is not enough to know what happens to the truck. Applied
  up the slope it may move it; applied down the slope it will
  certainly not; applied sideways it does something else again. The
  number is the same in all three cases and the outcomes are
  different, so the number cannot be the whole story. The missing
  ingredient is *direction*.

  A quantity that needs both a size and a direction is a
  #vocab("vector", "Vektor") quantity. Force, displacement, velocity,
  acceleration, and the lift and drag on an aircraft wing are all
  vectors.
]

#warning[
  Watch the pairs of words that are casually treated as synonyms in
  everyday speech but not here.

  *Distance* is a scalar: you walked $180$ metres.
  *Displacement* is a vector: you ended up $60$ metres east of where
  you started. You can walk a long distance and have zero
  displacement, as anyone who has walked around a park knows.

  *Speed* is a scalar: $50$ km/h. *Velocity* is a vector: $50$ km/h
  due north. A car going round a roundabout at a steady $50$ km/h has
  constant speed and continuously changing velocity — which is exactly
  why you feel yourself pushed sideways.
]

#only-high[
  #remark[
    "Magnitude plus direction" is a good working description, but it is
    not quite a definition, and it is worth knowing where it leaks.

    A rotation of a solid body has a size (the angle) and a direction
    (the axis), yet rotations are not vectors. The reason is that
    vectors can be combined in either order and give the same result,
    and rotations cannot: take a book, turn it $90degree$ about a
    vertical axis and then $90degree$ about a horizontal one, then
    repeat in the opposite order. The book ends up in two different
    positions. Try it — the effect is more convincing done than read.

    What actually makes something a vector is how it *combines*, not
    how it is described. That is the subject of the next chapter.
  ]
]

== Arrows

#only-theory[
  A vector is drawn as an arrow. The length of the arrow shows the
  magnitude and the way it points shows the direction. So far, so
  much like the film.

  #fig(
    vplane(
      s-vec(to: (4, 2), label: $arrow(v)$),
      xmin: -0.5,
      xmax: 5.5,
      ymin: -0.5,
      ymax: 3.5,
      grid: false,
      axes: false,
      unit: 0.75cm,
    ),
    caption: [Length is magnitude, orientation is direction. Nothing
      else about the picture carries information.],
  )

  Notice the last sentence of that caption, because it is the whole
  content of this section. The arrow is *drawn* somewhere on the page,
  but where it is drawn is not part of what it says.
]

#exploration(title: "Which of these are the same?")[
  Four arrows are drawn below.

  #fig(vplane(
    s-vec(from: (0, 0), to: (3, 1), label: $arrow(a)$, color: accent),
    s-vec(from: (4, 3), to: (7, 4), label: $arrow(b)$, color: warn-col),
    s-vec(from: (1, 4), to: (4, 5), label: $arrow(c)$, color: def-col),
    s-vec(from: (5, 1), to: (8, 2), label: $arrow(d)$, color: ex-col),
    xmin: -0.5,
    xmax: 8.5,
    ymin: -0.5,
    ymax: 5.5,
    unit: 0.62cm,
  ))

  + Measure or count squares. Which of the four have the same length?
    Which point the same way?

  + Two of these arrows are drawn in completely different places on
    the page. Is there any question you could ask about a *force*, or
    a *displacement*, whose answer would distinguish them?

  + Decide, and be ready to defend it: how many *different vectors*
    are drawn in that picture?
]

#only-theory[
  All four arrows have the same length and the same direction, so all
  four are the same vector, drawn four times. The picture shows one
  vector, not four.

  If that feels like cheating, test it against the physics. A
  displacement of "three steps east and one step north" is the same
  displacement whether you start from your front door or from the
  other side of town. The starting point is information about *you*,
  not about the displacement.

  This gives the sharper version of the definition.
]

#definition(title: "Vector")[
  A #vocab("vector", "Vektor", show-de: false) is a quantity with a
  magnitude and a direction. It is drawn as an arrow, but it *is* the
  displacement the arrow describes, not the arrow itself.

  A vector may be shifted parallel to itself anywhere in the plane or
  in space without changing it. It therefore has no fixed starting
  point.

  Two arrows represent the same vector exactly when they have the same
  length and the same direction.
]

#warning[
  A point and a vector are not the same kind of object, even when they
  are written with the same three numbers.

  A point is a *place*. A vector is a *move*. Asking "where is this
  vector?" is like asking where the instruction "go three blocks
  north" is — the instruction is not anywhere.

  This distinction seems pedantic for about a week and then starts
  saving you from errors. Keep the words straight: points get capital
  letters, $A$, $B$, $P$; vectors get arrows over lower-case letters,
  $arrow(u)$, $arrow(v)$.
]

== Three Ways to Write the Same Thing

#only-theory[
  A vector can be recorded in three different ways, and a good deal of
  this unit is the skill of moving between them without losing your
  footing.

  *As an arrow.* Draw it. Good for seeing what is going on, useless
  for calculating.

  *By two points.* If an arrow runs from a point $A$ to a point $B$,
  the vector is written $arrow(A B)$ — read "the vector from $A$ to
  $B$". Good when the situation gives you points to begin with, which
  it usually does.

  *By components.* Ask how far the arrow travels in each coordinate
  direction, and stack those numbers in a
  #vocab("column vector", "Spaltenvektor"). Good for calculating, and
  the only one of the three a machine can use.
]

#definition(title: "Components")[
  In the plane, a vector $arrow(a)$ that moves $a_x$ in the
  $x$‑direction and $a_y$ in the $y$‑direction is written
  $ arrow(a) = vec(a_x, a_y). $

  In space a third entry is added:
  $ arrow(a) = vec(a_x, a_y, a_z). $

  The numbers $a_x$, $a_y$, $a_z$ are the
  #vocab("components", "Komponenten") of $arrow(a)$. A component may be
  negative, which simply means the arrow travels backwards along that
  axis.
]

#only-theory[
  #fig(
    vplane(
      s-vec(to: (4, 3), label: $arrow(a)$),
      s-seg(
        from: (0, 0),
        to: (4, 0),
        dashed: true,
        color: luma(150),
        label: [$a_x = 4$],
        anchor: 0.5,
      ),
      s-seg(
        from: (4, 0),
        to: (4, 3),
        dashed: true,
        color: luma(150),
        label: [$a_y = 3$],
        anchor: 0.5,
      ),
      xmin: -0.5,
      xmax: 5.5,
      ymin: -0.5,
      ymax: 4.5,
      unit: 0.75cm,
    ),
    caption: [The components are the two legs of the right triangle the
      arrow closes.],
  )

  In space the same picture becomes a staircase with three steps
  instead of two.

  #fig(
    space3d(
      s-vec(to: (3, 4, 3), label: $arrow(a)$, anchor: 0.55),
      s-seg(
        from: (0, 0, 0),
        to: (3, 0, 0),
        dashed: true,
        color: luma(150),
        label: [$a_x$],
      ),
      s-seg(
        from: (3, 0, 0),
        to: (3, 4, 0),
        dashed: true,
        color: luma(150),
        label: [$a_y$],
      ),
      s-seg(
        from: (3, 4, 0),
        to: (3, 4, 3),
        dashed: true,
        color: luma(150),
        label: [$a_z$],
      ),
      s-pt((3, 4, 3), label: $P$),
      axis-len: (4.2, 5.2, 4),
    ),
    caption: [Go $a_x$ into the page, then $a_y$ across, then $a_z$ up.
      The order does not matter; you arrive at the same place.],
  )
]

#remark[
  The subscripts are a convention, not a fact. Your formula booklet
  writes $a_x$, $a_y$, $a_z$; many textbooks write $a_1$, $a_2$,
  $a_3$; a physicist may well write $arrow(a) = (a, b, c)$ and expect
  you to keep up.

  None of this changes anything. What matters is that a vector in
  space is three numbers in a fixed order, and that the first one
  always means the same thing as the first one. If the day comes when
  a book writes the components as three smiley faces, the mathematics
  will be identical, and being unbothered by that is a genuine skill.
]

== Position Vectors

#only-theory[
  Vectors have no fixed starting point — but there is one starting
  point worth singling out.

  Take any point $P$ and draw the arrow from the origin $O$ to $P$.
  That vector is called the #vocab("position vector", "Ortsvektor") of
  $P$, and it is written $arrow(r)_P$, or as $arrow(O P)$ when the
  endpoints need emphasising.
]

#definition(title: "Position vector")[
  For a point $P$, the position vector of $P$ is
  $ arrow(r)_P = arrow(O P), $
  the vector from the origin to $P$.

  Its components are precisely the coordinates of $P$. If
  $P = (3, -1, 5)$ then
  $ arrow(r)_P = vec(3, -1, 5). $
]

#only-theory[
  This is the reason a point and a vector can look identical on paper,
  and it is worth being clear about what has happened. The position
  vector is the one vector that *has* been pinned to a starting point,
  by a choice we made — putting the tail at $O$. Every point has
  exactly one position vector and every vector is the position vector
  of exactly one point, so the two lists match up perfectly.

  What has not happened is that points and vectors became the same
  thing. They are still a place and a move; it is just that once an
  origin is fixed, naming a place and naming the move that gets you
  there from $O$ amount to the same information.

  #fig(
    vplane(
      s-vec(to: (5, 3), label: $arrow(r)_P$, color: ex-col),
      s-vec(
        from: (1, 4),
        to: (6, 7),
        label: $arrow(r)_P$,
        color: ex-col,
        dashed: true,
      ),
      s-pt((5, 3), label: $P$),
      xmin: -0.5,
      xmax: 7.5,
      ymin: -0.5,
      ymax: 7.5,
      unit: 0.55cm,
    ),
    caption: [The same vector drawn twice. Only the copy starting at the
      origin has an endpoint that reads off the coordinates of $P$.],
  )
]

== Equal, Opposite, and Nothing At All

#only-theory[
  Three small definitions, all of which follow from what a vector is.

  Two vectors are *equal* when they have the same length and the same
  direction — equivalently, when all of their components agree. There
  is no third condition about where they are drawn.

  If a vector's starting point and ending point are the same, it has
  gone nowhere. This is the
  #vocab("null vector", "Nullvektor") $arrow(0)$, with all components
  zero. It has magnitude $0$ and no direction at all — not a direction
  of zero, but no direction, in the same way that a point has no
  slope.
]

#warning[
  $arrow(0)$ is not the origin $O$. The origin is a point, chosen by
  us; the null vector is a displacement that displaces nothing. They
  are written differently on purpose.
]

#only-theory[
  Finally, for every vector $arrow(v)$ there is a vector of the same
  length pointing the opposite way. It is called the
  #vocab("opposite vector", "Gegenvektor") and written $-arrow(v)$. Its
  components are the negatives of the components of $arrow(v)$:
  $ arrow(v) = vec(3, -2) quad arrow.r.long quad -arrow(v) = vec(-3, 2). $

  In two-point notation the opposite of $arrow(A B)$ is $arrow(B A)$,
  which is the same statement said in a different language: walking
  from $A$ to $B$ and walking from $B$ to $A$ are opposite journeys.

  #fig(
    vplane(
      s-vec(to: (3, -2), label: $arrow(v)$),
      s-vec(to: (-3, 2), label: $-arrow(v)$, color: warn-col),
      xmin: -4.5,
      xmax: 4.5,
      ymin: -3.5,
      ymax: 3.5,
      unit: 0.62cm,
    ),
  )
]

== How Long Is It?

#only-theory[
  The magnitude of a vector is its length, written $abs(arrow(a))$.
  Since the components of a vector are the legs of a right triangle
  that the vector itself closes, the length comes straight from
  Pythagoras.
]

#look-back(recalls: [the Pythagorean theorem])[
  You have already done this calculation in space, in the last
  exercise of the previous chapter, without anybody calling it a
  formula. There you found the length of a segment running from
  $(4, 1, 1)$ to $(0, 3, 3)$ by applying Pythagoras twice: once in the
  base plane, once with the height. What follows is that calculation
  written down in general.
]

#keybox(title: "Magnitude of a vector")[
  In the plane:
  $ abs(arrow(a)) = sqrt(a_x^2 + a_y^2). $

  In space:
  $ abs(arrow(a)) = sqrt(a_x^2 + a_y^2 + a_z^2). $
]

#only-theory[
  The three-dimensional version is not a new idea, only Pythagoras
  used twice. The first application happens flat on the base plane:
  the diagonal of the shaded rectangle has length
  $sqrt(a_x^2 + a_y^2)$. The second application stands that diagonal
  up as one leg of a new right triangle whose other leg is the height
  $a_z$, giving
  $
    abs(arrow(a))^2 = (sqrt(a_x^2 + a_y^2))^2 + a_z^2
    = a_x^2 + a_y^2 + a_z^2.
  $

  #fig(
    space3d(
      s-poly(
        ((0, 0, 0), (2, 0, 0), (2, 3, 0), (0, 3, 0)),
        fill: rgb("#eef0fa"),
        stroke-color: luma(180),
      ),
      s-seg(
        from: (0, 0, 0),
        to: (2, 3, 0),
        dashed: true,
        color: def-col,
        width: 1pt,
      ),
      s-seg(from: (2, 3, 0), to: (2, 3, 6), dashed: true, color: luma(150)),
      s-vec(to: (2, 3, 6), label: $arrow(a)$, anchor: 0.6),
      s-pt((2, 3, 6), label: $P$),
      s-pt((2, 3, 0), label: $P'$, r: 1.8pt),
      axis-len: (3.5, 4.5, 7),
      unit: 0.5cm,
    ),
    caption: [Two right triangles, stacked. The base diagonal $O P'$ is
      the hypotenuse of the first and a leg of the second.],
  )
]

#keybox(title: "Leave it exact")[
  A magnitude is almost never a whole number, and it is almost never
  improved by being turned into a decimal.

  $sqrt(24) = 2 sqrt(6)$ is a *finished answer*. So is
  $abs(arrow(a)) = sqrt(35)$. Writing $4.899$ instead throws away
  precision and gains nothing, and in this unit you will often be
  working without a calculator anyway.

  Simplify the surd if it simplifies — $sqrt(24) = sqrt(4 dot 6)
  = 2 sqrt(6)$ — and then stop.
]

#look-ahead(preview: [vector arithmetic])[
  One formula belongs in the next chapter, because it is a
  subtraction and subtraction has not been defined yet. It is worth
  meeting now anyway, because it is the single most used formula in
  the unit and because you can already see why it is true.

  Given two points $A$ and $B$, the vector from one to the other is
  $ arrow(A B) = arrow(r)_B - arrow(r)_A, $
  or in words: *endpoint minus starting point*.

  The reason is a journey. To get from $A$ to $B$ you may travel back
  to the origin first — that is $-arrow(r)_A$ — and then out to $B$,
  which is $arrow(r)_B$. In components, with
  $A = (a_x, a_y, a_z)$ and $B = (b_x, b_y, b_z)$:
  $ arrow(A B) = vec(b_x - a_x, b_y - a_y, b_z - a_z). $

  Two warnings, both of which cost marks every year. The subtraction
  goes in that order and not the other one. And $arrow(A B)$ is a
  vector, not a point — it tells you the journey from $A$ to $B$, not
  where you end up.
]

#ex(difficulty: 1, time: "6 min", calculator: false)[
  Classify each of the following as a scalar or a vector quantity.

  #auto-parts(
    2,
    [the mass of a parcel],
    [the wind at an airport, reported as "$25$ knots from the
      south-west"],
    [the area of a lake],
    [the distance you cycled today],
    [where you ended up, compared with where you started],
    [the temperature of the sea],
    [the force a magnet exerts on a nail],
    [the reading on a car's speedometer],
  )

  For the last one: what would have to be added to make it a vector?
][
  Scalars: mass, area, distance cycled, temperature, speedometer
  reading.

  Vectors: the wind (a speed *and* a direction), the displacement from
  start to finish, the magnetic force.

  The speedometer gives *speed*. To turn it into *velocity* you would
  have to add the direction of travel — which is why a car's
  speedometer alone cannot tell you where the car will be in an hour.
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Five arrows are drawn on the grid.

  #fig(vplane(
    s-vec(from: (0, 1), to: (2, 4), label: $arrow(a)$, color: accent),
    s-vec(from: (3, 0), to: (5, 3), label: $arrow(b)$, color: warn-col),
    s-vec(from: (6, 4), to: (8, 1), label: $arrow(c)$, color: def-col),
    s-vec(from: (1, 6), to: (3, 9), label: $arrow(d)$, color: ex-col),
    s-vec(from: (5, 6), to: (8, 8), label: $arrow(e)$, color: ai-col),
    xmin: -0.5,
    xmax: 9.5,
    ymin: -0.5,
    ymax: 9.5,
    unit: 0.52cm,
  ))

  + Write down the components of each.
  + Which of them represent the same vector?
  + Which pair are opposites of each other?
][
  #auto-parts(
    1,
    [$arrow(a) = vec(2, 3)$, $arrow(b) = vec(2, 3)$,
      $arrow(c) = vec(2, -3)$, $arrow(d) = vec(2, 3)$,
      $arrow(e) = vec(3, 2)$.],
    [$arrow(a)$, $arrow(b)$ and $arrow(d)$ are the same vector, drawn
      in three places.],
    [None. $arrow(c) = vec(2, -3)$ is *not* the opposite of
      $vec(2, 3)$ — the opposite would be $vec(-2, -3)$. $arrow(c)$ is
      the mirror image, which is a different thing.],
  )

  The trap in part (c) is worth dwelling on: $arrow(e) = vec(3, 2)$
  also has "a $2$ and a $3$ in it" and is a different vector again.
  Components are an ordered list; swapping two of them or flipping one
  sign produces something new.
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Calculate the magnitude of each vector. Leave every answer exact.

  #auto-parts(
    3,
    [$vec(-2, 4)$],
    [$vec(6, 8)$],
    [$vec(1, -2, 2)$],
    [$vec(2, 3, 6)$],
    [$vec(5, -1, 3)$],
    [$vec(4, -3, 12)$],
  )

  Three of these six come out as whole numbers. Is that a coincidence?
][
  #auto-parts(
    3,
    [$sqrt(4 + 16) = sqrt(20) = 2 sqrt(5)$],
    [$sqrt(36 + 64) = sqrt(100) = 10$],
    [$sqrt(1 + 4 + 4) = sqrt(9) = 3$],
    [$sqrt(4 + 9 + 36) = sqrt(49) = 7$],
    [$sqrt(25 + 1 + 9) = sqrt(35)$],
    [$sqrt(16 + 9 + 144) = sqrt(169) = 13$],
  )

  Not a coincidence — they were chosen. Component triples whose
  squares add to a perfect square are rare, and the ones above
  ($1, 2, 2$; $2, 3, 6$; $4, 3, 12$) are the small examples that get
  reused in every textbook, exactly so that a magnitude can be asked
  for without a calculator. Recognising them saves time.

  Note also that $(e)$ is a perfectly good final answer. $sqrt(35)$ is
  a number; $5.916$ is a rounded version of it.
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  Set up the cube from the previous chapter with $D$ at the origin and
  edge length $4$, so that $A = (4, 0, 0)$, $F = (4, 4, 4)$, and so on.

  #fig(space3d(
    ..cube-edges(a: 4, labels: true),
    axis-len: (5.5, 6, 5.5),
    unit: 0.55cm,
  ))

  + Write $arrow(D F)$, $arrow(A G)$ and $arrow(E C)$ as column
    vectors.
  + Find the magnitude of each.
  + What do these three vectors have in common, and what does that
    tell you about the cube?
][
  #auto-parts(
    1,
    [$arrow(D F) = vec(4, 4, 4)$, $arrow(A G) = vec(-4, 4, 4)$,
      $arrow(E C) = vec(-4, 4, -4)$.],
    [All three have magnitude
      $sqrt(16 + 16 + 16) = sqrt(48) = 4 sqrt(3)$.],
    [These are three of the four *space diagonals* of the cube — the
      segments joining opposite corners through the interior. They all
      have the same length, $4 sqrt(3)$, which is not obvious from the
      drawing, where the projection distorts depth. The fourth is
      $arrow(B H) = vec(-4, -4, 4)$, with the same magnitude again.],
  )

  This is the first result in the unit that the picture could not have
  given you. In oblique projection the four diagonals are drawn with
  four different lengths on the page.
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  A path around a rectangular park runs $60$ m east, then $30$ m
  south, then $60$ m west, then $30$ m north, ending where it started.

  + How much distance has been covered?
  + What is the displacement at the end of the walk?
  + Answer (a) and (b) again for someone who stops after the first
    two sides.
][
  #auto-parts(
    1,
    [$60 + 30 + 60 + 30 = 180$ m of distance.],
    [The displacement is the null vector $arrow(0)$, with magnitude
      $0$ m. The walker is back where they began.],
    [Distance $90$ m. Taking east as the $x$‑direction and north as
      the $y$‑direction, the displacement is
      $vec(60, -30)$, with magnitude
      $sqrt(3600 + 900) = sqrt(4500) = 30 sqrt(5) approx 67.1$ m.],
  )

  Part (b) is the clearest demonstration there is that distance and
  displacement are different quantities: one of them is $180$ and the
  other is $0$, for the same walk.
]

#ex(difficulty: 3, time: "14 min", calculator: false, hints: (
  "A point on the y-axis has the form P = (0, y). That is one unknown, not two.",
  "Write down |AP| and |BP| in terms of y. Square both sides before doing anything else — squaring first avoids the roots entirely.",
  "You should reach a quadratic in y. Expect two answers, and check both.",
))[
  Given $A = (-6, 0)$ and $B = (3, 3)$, find every point $P$ on the
  $y$‑axis whose distance from $A$ is twice its distance from $B$.
][
  Write $P = (0, y)$. Then
  $
    abs(arrow(A P))^2 = 36 + y^2, quad
    abs(arrow(B P))^2 = 9 + (y - 3)^2.
  $

  The condition $abs(arrow(A P)) = 2 abs(arrow(B P))$ squares to
  $abs(arrow(A P))^2 = 4 abs(arrow(B P))^2$:
  $ 36 + y^2 = 4 (9 + y^2 - 6y + 9) = 4y^2 - 24y + 72. $
  Collecting terms,
  $ 3y^2 - 24y + 36 = 0 quad arrow.l.r.double quad y^2 - 8y + 12 = 0, $
  so $y = 2$ or $y = 6$, giving
  $ P_1 = (0, 2) quad "and" quad P_2 = (0, 6). $

  *Check.* For $P_1$: $abs(arrow(A P_1)) = sqrt(40) = 2 sqrt(10)$ and
  $abs(arrow(B P_1)) = sqrt(10)$ — a ratio of exactly $2$. For $P_2$:
  $abs(arrow(A P_2)) = sqrt(72) = 6 sqrt(2)$ and
  $abs(arrow(B P_2)) = sqrt(18) = 3 sqrt(2)$, again a ratio of $2$.

  Squaring the condition before expanding is what keeps this
  calculation short. Squaring a condition can introduce false
  solutions, which is why both answers were checked — here both
  survive.
]

#only-high[
  #ex(difficulty: 3, time: "10 min", calculator: false)[
    Which points on the $z$‑axis are exactly $7$ units from
    $P = (-6, 3, 7)$?

    Before calculating: predict how many such points there are, and
    say what would have to change for the answer to be one, or none.
  ][
    A point on the $z$‑axis is $Q = (0, 0, z)$, so
    $ abs(arrow(P Q))^2 = 36 + 9 + (z - 7)^2 = 49, $
    giving $(z - 7)^2 = 4$ and therefore $z = 9$ or $z = 5$:
    $ Q_1 = (0, 0, 9), quad Q_2 = (0, 0, 5). $

    *The prediction.* The set of points exactly $7$ from $P$ is a
    sphere of radius $7$ centred at $P$; the question asks where that
    sphere meets a line. A line meets a sphere twice, once, or not at
    all — the same three cases as a line and a circle in the plane.

    Which case you are in depends only on the distance from $P$ to the
    $z$‑axis, which is $sqrt(36 + 9) = sqrt(45) approx 6.7$, just
    under the radius $7$. Had $P$ been $7$ units from the axis there
    would be exactly one point, and further than $7$ units, none.
  ]
]

#print-hints()
#print-vocab()
