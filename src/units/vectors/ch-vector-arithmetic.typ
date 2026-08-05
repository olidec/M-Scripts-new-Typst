#import "../../common/preamble.typ": *
#import "/src/common/vec-figures.typ": *
#show: chapter-template.with(title: "Arithmetic with Arrows")
#let ex = exercise.with(chapter: "Arithmetic with Arrows")

= Arithmetic with Arrows

#only-theory[
  In the previous chapter a vector was something you could *describe*.
  In this one it becomes something you can *calculate with*.

  That is a larger step than it sounds. There is no obvious reason why
  arrows should have an arithmetic at all — you cannot add two colours
  or multiply two smells. What makes it work is that vectors describe
  journeys, and journeys can be performed one after another. The whole
  chapter grows out of that single observation.
]

#objectives(
  bfkm[add, subtract and scale vectors both geometrically and in
    components, and say which picture goes with which calculation],
  [use the triangle rule and the parallelogram rule, and explain why
    they agree],
  [calculate the vector between two points as $arrow(r)_B - arrow(r)_A$],
  [decide whether two vectors are parallel, and whether three points
    are collinear],
  [write a vector as a linear combination of the basis vectors],
  [find the midpoint of a segment, and divide a segment in a given
    ratio],
)

== Adding Vectors

#only-theory[
  Suppose you walk two blocks east and three blocks north, and then
  from wherever you have arrived you walk one block east and two
  blocks south. Where do you end up, relative to where you started?

  Both legs of the walk are displacements, so both are vectors. The
  combined effect is a single displacement — a single vector — and
  finding it is what "adding" means here.

  The picture is the obvious one. Draw the first vector. Then draw the
  second one starting where the first one finished. The sum is the
  arrow from the very beginning to the very end.
]

#definition(title: "Adding vectors: the triangle rule")[
  To add $arrow(u)$ and $arrow(v)$, place the tail of $arrow(v)$ at
  the head of $arrow(u)$. The sum $arrow(u) + arrow(v)$ is the vector
  from the tail of $arrow(u)$ to the head of $arrow(v)$.

  This is legitimate precisely because a vector may be shifted
  parallel to itself: moving $arrow(v)$ so that it begins where
  $arrow(u)$ ends does not change $arrow(v)$.
]

#only-theory[
  #fig(
    vplane(
      s-vec(to: (2, 3), label: $arrow(u)$),
      s-vec(from: (2, 3), to: (3, 1), label: $arrow(v)$, color: warn-col),
      s-vec(
        to: (3, 1),
        label: $arrow(u) + arrow(v)$,
        color: def-col,
        anchor: 0.55,
      ),
      xmin: -0.5,
      xmax: 4.5,
      ymin: -0.5,
      ymax: 3.5,
      unit: 0.8cm,
    ),
    caption: [Two legs of a journey and the single displacement that
      replaces them.],
  )

  In components nothing surprising happens. Going $2$ east then $1$
  east puts you $3$ east; going $3$ north then $2$ south puts you $1$
  north. You add the components separately:
  $ vec(2, 3) + vec(1, -2) = vec(3, 1). $
]

#keybox(title: "Adding in components")[
  $
    vec(a_x, a_y) + vec(b_x, b_y) = vec(a_x + b_x, a_y + b_y),
    quad
    vec(a_x, a_y, a_z) + vec(b_x, b_y, b_z)
    = vec(a_x + b_x, a_y + b_y, a_z + b_z).
  $

  Each coordinate direction is handled on its own and never mixes with
  the others. This is why components are worth having.
]

#exploration(title: "Does the order matter?")[
  Take $arrow(u) = vec(3, 1)$ and $arrow(v) = vec(1, 3)$.

  + On squared paper, draw $arrow(u)$ from the origin, then $arrow(v)$
    from its head. Mark where you finish.

  + On the *same* diagram, draw $arrow(v)$ from the origin, then
    $arrow(u)$ from its head. Mark where you finish.

  + What shape have you drawn? What does it tell you about
    $arrow(u) + arrow(v)$ compared with $arrow(v) + arrow(u)$?

  + Now try to answer the same question for two vectors in space,
    without drawing anything. Is your reasoning the same?
]

#only-theory[
  The two routes end at the same point, and the figure you have drawn
  is a parallelogram: the two copies of $arrow(u)$ are parallel and
  equal, as are the two copies of $arrow(v)$. This gives the second
  standard picture for the same operation.

  #fig(
    vplane(
      s-poly(
        ((0, 0), (3, 1), (4, 4), (1, 3)),
        fill: rgb("#eef0fa"),
        stroke-color: luma(185),
        dashed: true,
      ),
      s-vec(to: (3, 1), label: $arrow(u)$),
      s-vec(to: (1, 3), label: $arrow(v)$, color: warn-col),
      s-vec(
        to: (4, 4),
        label: $arrow(u) + arrow(v)$,
        color: def-col,
        anchor: 0.55,
      ),
      xmin: -0.5,
      xmax: 5.5,
      ymin: -0.5,
      ymax: 4.5,
      unit: 0.75cm,
    ),
    caption: [The parallelogram rule. Both vectors start at the same
      point and the sum is the diagonal.],
  )

  The triangle rule and the parallelogram rule are not two different
  operations. They are the same operation drawn with the second vector
  moved, and which one you reach for is a matter of what the problem
  hands you. If you are given a chain of journeys, use triangles. If
  you are given two forces acting at a single point, use the
  parallelogram — that is exactly how forces were first combined, and
  where this whole subject came from.
]

#keybox(title: "The rules of vector arithmetic")[
  For all vectors $arrow(u)$, $arrow(v)$, $arrow(w)$:
  $ arrow(u) + arrow(v) = arrow(v) + arrow(u) $
  $ (arrow(u) + arrow(v)) + arrow(w) = arrow(u) + (arrow(v) + arrow(w)) $
  $ arrow(u) + arrow(0) = arrow(u) $
  $ arrow(u) + (-arrow(u)) = arrow(0) $
]

#only-theory[
  These look too obvious to be worth writing down, and in components
  they are: each one is an ordinary fact about numbers, applied one
  coordinate at a time.

  They are worth writing down anyway, because they are what *makes*
  something a vector. In the previous chapter it was claimed that a
  rotation of a solid body is not a vector, despite having a size and
  a direction. The reason is the first line above: two rotations
  performed in the opposite order give a different result, so whatever
  a rotation is, it is not something you can add like this. "Magnitude
  and direction" describes vectors; the rules above are what *define*
  them.
]

== Subtracting Vectors

#only-theory[
  Subtraction needs no new machinery. To subtract a vector, add its
  opposite:
  $ arrow(u) - arrow(v) = arrow(u) + (-arrow(v)). $

  In components, subtract entry by entry. Geometrically there is a
  second picture that is more useful than the first, and it is worth
  having in your head.

  Draw $arrow(u)$ and $arrow(v)$ from the same starting point. Then
  $arrow(u) - arrow(v)$ is the arrow running *from the head of
  $arrow(v)$ to the head of $arrow(u)$*.

  #fig(
    vplane(
      s-vec(to: (1, 4), label: $arrow(u)$),
      s-vec(to: (5, 2), label: $arrow(v)$, color: warn-col),
      s-vec(
        from: (5, 2),
        to: (1, 4),
        label: $arrow(u) - arrow(v)$,
        color: def-col,
        anchor: 0.5,
      ),
      xmin: -0.5,
      xmax: 6.5,
      ymin: -0.5,
      ymax: 4.5,
      unit: 0.72cm,
    ),
    caption: [From the head of $arrow(v)$ to the head of $arrow(u)$.
      Check it with the triangle rule: $arrow(v) + (arrow(u) -
        arrow(v)) = arrow(u)$.],
  )

  The check in that caption is the whole justification. Whatever
  arrow runs from the head of $arrow(v)$ to the head of $arrow(u)$
  must be the vector you add to $arrow(v)$ to obtain $arrow(u)$ — and
  that vector is $arrow(u) - arrow(v)$ by definition.
]

#only-theory[
  === The vector between two points

  This is the formula promised at the end of the previous chapter, and
  it is now simply a special case of what you have just done.

  Take two points $A$ and $B$. Their position vectors $arrow(r)_A$ and
  $arrow(r)_B$ both start at the origin, so the picture above applies
  directly: the arrow from the head of $arrow(r)_A$ to the head of
  $arrow(r)_B$ is $arrow(r)_B - arrow(r)_A$. But the head of
  $arrow(r)_A$ is $A$, and the head of $arrow(r)_B$ is $B$.

  #fig(
    vplane(
      s-vec(to: (1, 1), label: $arrow(r)_A$, color: ex-col),
      s-vec(to: (5, 3), label: $arrow(r)_B$, color: ex-col, anchor: 0.55),
      s-vec(from: (1, 1), to: (5, 3), label: $arrow(A B)$, color: def-col),
      s-pt((1, 1), label: $A$),
      s-pt((5, 3), label: $B$),
      xmin: -0.5,
      xmax: 6.5,
      ymin: -0.5,
      ymax: 4.5,
      unit: 0.72cm,
    ),
  )
]

#keybox(title: "Endpoint minus starting point")[
  For any two points $A$ and $B$,
  $
    arrow(A B) = arrow(r)_B - arrow(r)_A
    = vec(b_x - a_x, b_y - a_y, b_z - a_z).
  $
]

#warning[
  Two mistakes, both common enough to be worth naming.

  *The order.* $arrow(A B)$ is $B$ minus $A$, not $A$ minus $B$.
  Getting it backwards gives you $arrow(B A)$, which points the wrong
  way. The phrase to memorise is *endpoint minus starting point*.

  *The type.* $arrow(A B)$ is a vector, not a point. It tells you the
  journey from $A$ to $B$; it does not tell you where you end up. If a
  question asks for a point and your answer has an arrow on it,
  something has gone wrong.
]

== Stretching Vectors

#only-theory[
  The remaining operation is multiplication by a plain number. In this
  context an ordinary number is called a
  #vocab("scalar", "Skalar", show-de: false) — the word comes from
  *scaling*, which is exactly what it does.

  Walking a journey twice over gets you twice as far in the same
  direction, so $2 arrow(v)$ should be a vector twice as long as
  $arrow(v)$ pointing the same way. Walking it backwards should
  reverse it. Both are captured by one rule.
]

#definition(title: "Scalar multiplication")[
  For a scalar $k$ and a vector $arrow(v)$, the vector
  $k dot arrow(v)$ has magnitude $abs(k) dot abs(arrow(v))$, and

  - the same direction as $arrow(v)$ if $k > 0$,
  - the opposite direction if $k < 0$,
  - it is the null vector if $k = 0$.

  In components, every entry is multiplied by $k$:
  $ k dot vec(v_x, v_y, v_z) = vec(k dot v_x, k dot v_y, k dot v_z). $
]

#only-theory[
  #fig(
    vplane(
      s-vec(to: (4, 2), label: $2 arrow(v)$, color: def-col),
      s-vec(to: (2, 1), label: $arrow(v)$),
      s-vec(to: (-3, -1.5), label: $-1.5 arrow(v)$, color: warn-col),
      xmin: -4.5,
      xmax: 5.5,
      ymin: -2.5,
      ymax: 3.5,
      unit: 0.62cm,
    ),
    caption: [All three lie on one line through the origin. Scaling
      never changes the line a vector lies along.],
  )

  Note the magnitude carefully: it is $abs(k) dot abs(arrow(v))$, with
  the absolute value. A vector cannot have negative length. The sign
  of $k$ is spent entirely on the direction.

  The distributive rules hold, and again they are one-coordinate-at-a-time
  facts about numbers:
  $
    k dot (arrow(u) + arrow(v)) = k dot arrow(u) + k dot arrow(v),
    quad
    (k + l) dot arrow(v) = k dot arrow(v) + l dot arrow(v).
  $
]

#remark[
  This is the second meaning the raised dot has acquired. In
  $k dot arrow(v)$ it joins a *number* to a *vector* and the result is
  a vector.

  In a later chapter you will meet $arrow(a) dot arrow(b)$, joining
  two *vectors*, and the result there will be a number. They are
  genuinely different operations that share a symbol, and the way to
  keep them apart is to look at what is on either side of the dot
  rather than at the dot itself.
]

== Parallel Vectors and Collinear Points

#only-theory[
  The figure above contains a complete criterion, if you read it the
  right way. Every scalar multiple of $arrow(v)$ points along the same
  line as $arrow(v)$ — and conversely, any vector pointing along that
  line is some multiple of $arrow(v)$. So being parallel and being a
  scalar multiple are the same condition.
]

#keybox(title: "Parallel vectors")[
  Two non-zero vectors $arrow(u)$ and $arrow(v)$ are
  #vocab("parallel", "parallel") — also called
  #vocab("collinear", "kollinear") — exactly when one is a scalar
  multiple of the other:
  $
    arrow(u) parallel arrow(v)
    quad arrow.l.r.double quad
    arrow(u) = k dot arrow(v) "for some" k in RR.
  $

  In practice: divide the components of one by the components of the
  other. If you get the same number every time, they are parallel. If
  not, they are not.
]

#only-theory[
  A worked case. Are $arrow(u) = vec(3, -2, 8)$ and
  $arrow(v) = vec(-6, 4, -16)$ parallel?

  Dividing entry by entry: $(-6) / 3 = -2$, $4 / (-2) = -2$,
  $(-16) / 8 = -2$. The same factor three times, so
  $arrow(v) = -2 dot arrow(u)$ and the two are parallel — pointing in
  opposite directions, since the factor is negative.

  Now a second case: $arrow(u) = vec(3, -2, 8)$ and
  $arrow(w) = vec(-6, 4, -15)$. The first two ratios are $-2$ again,
  but the third is $-15 / 8$, which is not $-2$. Not parallel. One
  disagreement is enough.
]

#warning[
  Watch for zeros. If a component of $arrow(v)$ is zero, you cannot
  divide by it — and the corresponding component of $arrow(u)$ must
  then be zero too, or the vectors are certainly not parallel.

  $vec(0, 5)$ and $vec(2, 5)$ are not parallel, even though their
  second entries match. Compare the components you *can* compare, and
  check the rest by hand.
]

#only-theory[
  === Three points on a line

  Points $A$, $B$ and $C$ are #vocab("collinear", "kollinear", show-de: false)
  when they all lie on one straight line. Turning that into a
  calculation takes one step: build two vectors from the three points
  and ask whether they are parallel.

  #fig(
    vplane(
      s-vec(from: (1, 1), to: (3, 2), label: $arrow(A B)$, color: def-col),
      s-vec(
        from: (1, 1),
        to: (7, 4),
        label: $arrow(A C)$,
        color: warn-col,
        anchor: 0.85,
      ),
      s-pt((1, 1), label: $A$),
      s-pt((3, 2), label: $B$),
      s-pt((7, 4), label: $C$),
      xmin: -0.5,
      xmax: 8.5,
      ymin: -0.5,
      ymax: 5.5,
      unit: 0.6cm,
    ),
    caption: [$arrow(A C) = 3 dot arrow(A B)$, so the three points lie
      on one line.],
  )
]

#keybox(title: "Collinear points")[
  Three points $A$, $B$, $C$ are collinear exactly when
  $ arrow(A C) = k dot arrow(A B) "for some" k in RR. $

  Both vectors must start at the *same* point. $arrow(A B)$ and
  $arrow(B C)$ would work equally well; $arrow(A B)$ and $arrow(A C)$
  is the usual choice.
]

#ai-box(role: "Generator")[
  Ask an AI assistant to produce five collinearity problems: three
  points in space each time, some sets collinear and some not, with
  small whole-number coordinates.

  Then work them yourself — and check the assistant's own answers
  against yours. Checking is cheap here: one subtraction and one
  division per problem, which is exactly why this is a reasonable
  thing to hand over.

  Two things to watch for, because generated problems fail in
  predictable ways. Ask yourself whether the "collinear" sets really
  are, and whether the coordinates stayed as small as you asked. If a
  problem turns out to be wrong, you have lost nothing — you have
  gained a worked example of why the answer key is *your* job.

  The general rule this illustrates is worth stating: delegating a
  task is sensible in proportion to how cheaply you can check the
  result. Practice problems on a criterion you can verify in two lines
  are near the safe end. Answers you would have to take on trust are
  at the other.
]

== Basis Vectors and Linear Combinations

#only-theory[
  Three particular vectors deserve names. In space, let
  $
    arrow(e)_x = vec(1, 0, 0), quad
    arrow(e)_y = vec(0, 1, 0), quad
    arrow(e)_z = vec(0, 0, 1)
  $
  be the steps of length one along the three axes. They are called the
  #vocab("basis vectors", "Basisvektoren").

  Every vector is built out of them, and the recipe is the components:
  $ vec(3, -2, 5) = 3 arrow(e)_x - 2 arrow(e)_y + 5 arrow(e)_z. $

  This is the staircase from the previous chapter, written
  algebraically: go three steps along $x$, two steps backwards along
  $y$, five steps up. An expression of this shape — vectors scaled and
  added — is called a #vocab("linear combination", "Linearkombination").
]

#remark[
  Read the sentence "the components tell you the recipe" in both
  directions and you have the whole point of components.

  Left to right: given the vector, the components are the amounts of
  each basis vector. Right to left: given the amounts, you have the
  vector. Nothing is lost either way, which is why calculating with
  columns of numbers is as good as calculating with arrows — and much
  faster.
]

#only-high[
  #only-theory[
    === When two vectors are enough

    In the plane, two vectors that are *not* parallel can be combined
    to reach anywhere. Given any $arrow(w)$, there are numbers $s$ and
    $t$ with $arrow(w) = s dot arrow(u) + t dot arrow(v)$, and they are
    unique. If $arrow(u)$ and $arrow(v)$ *are* parallel, every
    combination of them stays on one line and most of the plane is
    unreachable.

    The condition separating the two cases has a name.
  ]

  #definition(title: "Linear independence")[
    Vectors $arrow(u)$ and $arrow(v)$ are
    #vocab("linearly independent", "linear unabhängig") when
    $ s dot arrow(u) + t dot arrow(v) = arrow(0) $
    forces $s = t = 0$.

    If some choice of $s$ and $t$ that are not both zero gives
    $arrow(0)$, the vectors are *dependent* — and then each is a
    multiple of the other, so they are parallel.
  ]

  #only-theory[
    The definition looks more abstract than the idea. It says: the only
    way to combine these vectors and get nowhere is to not move at all.
    If you could return to the start having taken a genuine amount of
    $arrow(u)$ and a genuine amount of $arrow(v)$, the two must have
    been undoing each other, which means they lay along the same line.

    This will matter when planes arrive. A plane is described by a
    point and *two* directions, and those two directions have to be
    independent — otherwise they span a line and not a plane, and the
    description collapses.
  ]
]

== Midpoints and Dividing a Segment

#only-theory[
  Here is the first place the arithmetic earns its keep on a problem
  that is not about vectors at all.

  Let $M$ be the midpoint of the segment from $A$ to $B$. To reach $M$
  from the origin, travel to $A$ and then go half of the way from $A$
  to $B$:
  $
    arrow(r)_M = arrow(r)_A + 1/2 dot arrow(A B)
    = arrow(r)_A + 1/2 dot (arrow(r)_B - arrow(r)_A).
  $
  Expanding and collecting,
  $ arrow(r)_M = 1/2 dot (arrow(r)_A + arrow(r)_B). $

  #fig(
    vplane(
      s-vec(to: (1, 1), label: $arrow(r)_A$, color: ex-col),
      s-vec(to: (7, 5), label: $arrow(r)_B$, color: ex-col, anchor: 0.5),
      s-vec(to: (4, 3), label: $arrow(r)_M$, color: def-col, anchor: 0.65),
      s-seg(from: (1, 1), to: (7, 5), color: luma(150)),
      s-pt((1, 1), label: $A$),
      s-pt((7, 5), label: $B$),
      s-pt((4, 3), label: $M$),
      xmin: -0.5,
      xmax: 8.5,
      ymin: -0.5,
      ymax: 6.5,
      unit: 0.58cm,
    ),
  )

  So the midpoint is the *average* of the two endpoints, coordinate by
  coordinate — which is what you would have guessed, and now know.
]

#keybox(title: "Midpoint")[
  $
    arrow(r)_M = 1/2 dot (arrow(r)_A + arrow(r)_B),
    quad "so" quad
    M = ((a_x + b_x)/2, (a_y + b_y)/2, (a_z + b_z)/2).
  $
]

#only-theory[
  The same argument divides a segment in any ratio. The point $P$ that
  lies a fraction $t$ of the way from $A$ to $B$ is
  $ arrow(r)_P = arrow(r)_A + t dot arrow(A B), $
  with $t = 1/2$ giving the midpoint, $t = 1/3$ and $t = 2/3$ giving
  the two points that cut the segment into three equal parts, and
  $t = 0$ and $t = 1$ giving $A$ and $B$ themselves.
]

#look-ahead(preview: [the equation of a line])[
  Look at that last formula again with $t$ left free:
  $ arrow(r)_P = arrow(r)_A + t dot arrow(A B). $

  For $t$ between $0$ and $1$ it sweeps out the segment from $A$ to
  $B$. There is nothing stopping you from taking $t = 2$, or
  $t = -1.5$ — and then the point runs off beyond $B$, or backwards
  past $A$, but always along the same straight line.

  That single expression, with $t$ allowed to be any real number, is
  the equation of a line in space. You have just written it down while
  looking for a midpoint, and it is the object the next several
  chapters are built on.
]

#ex(difficulty: 1, time: "10 min", calculator: false)[
  Let $arrow(u) = vec(2, -3)$ and $arrow(w) = vec(1, 3)$.

  #auto-parts(
    1,
    [Write down the components of $2 arrow(u)$, of
      $arrow(u) + arrow(w)$, and of $arrow(u) - arrow(w)$.],
    [Find $abs(arrow(u))$ and $abs(2 arrow(u))$, exactly. What is the
      relationship, and why?],
    [On squared paper, draw $arrow(u)$, $arrow(w)$, $arrow(u) +
      arrow(w)$ and $arrow(u) - arrow(w)$, all starting at the origin,
      and check your answers to (a) against the picture.],
  )
][
  #auto-parts(
    1,
    [$2 arrow(u) = vec(4, -6)$, $arrow(u) + arrow(w) = vec(3, 0)$,
      $arrow(u) - arrow(w) = vec(1, -6)$.],
    [$abs(arrow(u)) = sqrt(4 + 9) = sqrt(13)$ and
      $abs(2 arrow(u)) = sqrt(16 + 36) = sqrt(52) = 2 sqrt(13)$.
      Exactly twice as long, because scaling by $2$ multiplies the
      length by $abs(2) = 2$ — visible in the algebra as
      $sqrt(4 dot 13) = 2 sqrt(13)$.],
    [The sum should land on the $x$‑axis, since the $y$‑components
      cancel. If it does not, check the signs.],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Find the vector $arrow(x)$ satisfying
  $ 2 arrow(u) - 3 arrow(x) + arrow(v) = 5 arrow(x) - 2 arrow(v), $
  where $arrow(u) = vec(1, 5)$ and $arrow(v) = vec(3, -4)$.
][
  Treat it exactly as you would an equation with numbers — the rules
  of vector arithmetic permit every step. Collect the $arrow(x)$ terms
  on one side:
  $
    2 arrow(u) + 3 arrow(v) = 8 arrow(x), quad "so" quad
    arrow(x) = 1/8 dot (2 arrow(u) + 3 arrow(v)).
  $
  Now substitute:
  $
    2 arrow(u) = vec(2, 10), quad 3 arrow(v) = vec(9, -12), quad
    2 arrow(u) + 3 arrow(v) = vec(11, -2),
  $
  $ arrow(x) = 1/8 dot vec(11, -2) = vec(11 slash 8, -1 slash 4). $
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Which of these vectors are parallel to $arrow(u) = vec(1, 7)$?

  #auto-parts(
    3,
    [$vec(0.1, 0.7)$],
    [$vec(-1, -7)$],
    [$vec(60, 420)$],
    [$vec(6, 42)$],
    [$vec(-1, 7)$],
    [$vec(7, 1)$],
  )
][
  Parallel: (a) with $k = 0.1$, (b) with $k = -1$, (c) with $k = 60$,
  (d) with $k = 6$.

  Not parallel: (e), where the ratios are $-1$ and $7$; and (f), where
  they are $7$ and $1 slash 7$.

  Both failures are worth noticing. In (e) only one sign was flipped —
  the opposite vector would be $vec(-1, -7)$, which is (b). In (f) the
  components were swapped, which produces a genuinely different
  direction, not a multiple.
]

#ex(difficulty: 2, time: "10 min", calculator: false, hints: (
  "If the vectors are parallel there is a single number k with v = k·u. Find k from the components that contain no unknowns.",
))[
  For which values of $t$ and $s$ are these two vectors parallel?
  $ arrow(u) = vec(3, t, -6), quad arrow(v) = vec(9, -12, s) $
][
  The first components give the factor immediately:
  $9 = k dot 3$, so $k = 3$ and $arrow(v) = 3 arrow(u)$.

  The remaining components must obey the same factor:
  $
    -12 = 3 t arrow.r.double t = -4, quad
    s = 3 dot (-6) = -18.
  $

  So $t = -4$ and $s = -18$. Always take $k$ from a component pair
  with no unknown in it — starting anywhere else means solving two
  equations at once for no reason.
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  Decide in each case whether $C$ lies on the line through $A$ and
  $B$.

  #auto-parts(
    1,
    [$A = (-2, 5, -4)$, $B = (10, -1, 0)$, $C = (-8, 8, -6)$],
    [$A = (6, -3, 4)$, $B = (2, 7, -6)$, $C = (-4, 22, -18)$],
  )
][
  #auto-parts(
    1,
    [$arrow(A B) = vec(12, -6, 4)$ and
      $arrow(A C) = vec(-6, 3, -2)$. Every ratio is
      $-1 slash 2$, so $arrow(A C) = -1/2 dot arrow(A B)$ and the
      three points *are* collinear — with $C$ on the far side of $A$
      from $B$, since the factor is negative.],
    [$arrow(A B) = vec(-4, 10, -10)$ and
      $arrow(A C) = vec(-10, 25, -22)$. The first two ratios are
      $2.5$ and $2.5$, but the third is $2.2$. *Not* collinear.

      This is the case worth being careful about: two matching ratios
      prove nothing. A candidate factor has to survive every
      component.],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Divide the segment $A B$ into three equal parts, where
  $A = (-9, 15, -2)$ and $B = (-12, -6, 4)$. Give the coordinates of
  the two dividing points.
][
  First the direction:
  $arrow(A B) = vec(-3, -21, 6)$, so
  $1/3 dot arrow(A B) = vec(-1, -7, 2)$.

  Then step along from $A$:
  $
    P_1 = A + vec(-1, -7, 2) = (-10, 8, 0), quad
    P_2 = P_1 + vec(-1, -7, 2) = (-11, 1, 2).
  $

  *Check.* One more step gives $(-12, -6, 4) = B$, as it must.
  Building in a check like this costs one line and catches sign
  errors immediately.
]

#ex(difficulty: 3, time: "12 min", calculator: false, hints: (
  "Collinearity of A, B and C means AC is a multiple of AB. Write both vectors down first, leaving x where it stands.",
  "One component pair contains no unknown. Use it to find the factor k.",
))[
  Determine $x$ so that $A = (5, -6)$, $B = (-7, -3)$ and
  $C = (x, 5)$ lie on one straight line.
][
  $ arrow(A B) = vec(-12, 3), quad arrow(A C) = vec(x - 5, 11). $

  Collinearity requires $arrow(A C) = k dot arrow(A B)$. The second
  components have no unknown, so they fix the factor:
  $ 11 = 3 k arrow.r.double k = 11/3. $
  Then the first components give
  $ x - 5 = 11/3 dot (-12) = -44 arrow.r.double x = -39. $

  *Check.* With $C = (-39, 5)$, $arrow(A C) = vec(-44, 11)$, and
  $-44 slash -12 = 11 slash 3 = 11 slash 3$. Consistent.
]

#ex(difficulty: 3, time: "18 min", calculator: false, hints: (
  "For (b), calculate the vector joining the two midpoints and compare it with the vector along the third side.",
  "For (c), do not use coordinates at all. Write the midpoints as position vectors using the midpoint formula, then subtract.",
))[
  The points $A = (1, 1)$, $B = (5, 3)$ and $C = (3, 7)$ form a
  triangle.

  #auto-parts(
    1,
    [Calculate the midpoints $M_(A B)$, $M_(B C)$ and $M_(A C)$ of the
      three sides.],
    [Show that the segment joining $M_(A B)$ and $M_(A C)$ is parallel
      to the side $B C$ and half as long.],
    [Prove that this happens in *every* triangle, using vectors and no
      coordinates.],
  )
][
  #auto-parts(
    1,
    [$M_(A B) = (3, 2)$, $M_(B C) = (4, 5)$, $M_(A C) = (2, 4)$.],
    [The joining vector is
      $arrow(M_(A B) M_(A C)) = vec(2 - 3, 4 - 2) = vec(-1, 2)$, while
      $arrow(B C) = vec(-2, 4)$. So
      $arrow(M_(A B) M_(A C)) = 1/2 dot arrow(B C)$: parallel, and half
      the length.],
    [Let the three vertices have position vectors $arrow(r)_A$,
      $arrow(r)_B$, $arrow(r)_C$. By the midpoint formula,
      $
        arrow(r)_(M_(A B)) = 1/2 dot (arrow(r)_A + arrow(r)_B), quad
        arrow(r)_(M_(A C)) = 1/2 dot (arrow(r)_A + arrow(r)_C).
      $
      Subtracting, endpoint minus starting point:
      $
        arrow(M_(A B) M_(A C))
        = 1/2 dot (arrow(r)_A + arrow(r)_C)
        - 1/2 dot (arrow(r)_A + arrow(r)_B)
        = 1/2 dot (arrow(r)_C - arrow(r)_B)
        = 1/2 dot arrow(B C).
      $
      One vector is half of another, so they are parallel and the
      length ratio is $1 : 2$. No coordinates were used, so the result
      holds for every triangle — including triangles in space.],
  )

  Part (c) is the first real *proof* in this unit, and it is worth
  seeing what made it short. The coordinate version in (b) settles one
  triangle. The vector version settles all of them, in three lines,
  because nothing in it depended on where the triangle was or which
  way it faced.
]

#only-high[
  #ex(difficulty: 3, time: "12 min", calculator: false)[
    #auto-parts(
      1,
      [Show that $arrow(u) = vec(2, 1)$ and $arrow(v) = vec(-1, 3)$
        are linearly independent.],
      [Write $arrow(w) = vec(4, 9)$ as a linear combination of
        $arrow(u)$ and $arrow(v)$.],
      [The #vocab("centroid", "Schwerpunkt") $S$ of a triangle
        $A B C$ is the point where the three medians meet, and it lies
        two thirds of the way along each median from the vertex. Use
        this to derive a formula for $arrow(r)_S$, then apply it to
        $A = (3, -2, 5)$, $B = (7, 5, 10)$, $C = (5, 9, 3)$.],
    )
  ][
    #auto-parts(
      1,
      [Neither is a multiple of the other: from the first components a
        factor would have to be $-1 slash 2$, but
        $-1/2 dot 1 = -1/2 eq.not 3$. So they are not parallel, hence
        independent.],
      [Solve $s dot arrow(u) + t dot arrow(v) = arrow(w)$
        componentwise:
        $ 2s - t = 4, quad quad s + 3t = 9. $
        From the first, $t = 2s - 4$; substituting,
        $s + 6s - 12 = 9$, so $s = 3$ and $t = 2$. Hence
        $arrow(w) = 3 arrow(u) + 2 arrow(v)$.],
      [The median from $A$ runs to $M_(B C)$, the midpoint of the
        opposite side, and $S$ is two thirds of the way along it:
        $
          arrow(r)_S = arrow(r)_A + 2/3 dot
          (arrow(r)_(M_(B C)) - arrow(r)_A).
        $
        Substituting
        $arrow(r)_(M_(B C)) = 1/2 dot (arrow(r)_B + arrow(r)_C)$ and
        simplifying,
        $
          arrow(r)_S = 1/3 dot
          (arrow(r)_A + arrow(r)_B + arrow(r)_C).
        $
        The formula is symmetric in $A$, $B$ and $C$ — which it had
        to be, since starting from $B$ or $C$ would have given the
        same point. That symmetry is itself a proof that the three
        medians meet.

        For the given triangle:
        $
          arrow(r)_S = 1/3 dot vec(3 + 7 + 5, -2 + 5 + 9, 5 + 10 + 3)
          = 1/3 dot vec(15, 12, 18) = vec(5, 4, 6),
        $
        so $S = (5, 4, 6)$.],
    )
  ]
]

#print-hints()
#print-vocab()
