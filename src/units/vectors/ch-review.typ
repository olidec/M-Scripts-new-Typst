#import "../../common/preamble.typ": *
#import "/src/common/vec-figures.typ": *
#show: chapter-template.with(title: "Looking Back")
#let ex = exercise.with(chapter: "Looking Back")

= Looking Back

#only-theory[
  This chapter contains no new mathematics. It contains a map of what
  you now have, and a set of exercises that deliberately refuse to tell
  you which tool to use.

  That second part matters more than it sounds. Every exercise so far
  arrived in a chapter about one topic, so the method was half given
  away by the page it was printed on. Real problems — and exam
  problems — do not announce themselves. The exercises at the end of
  this chapter are shuffled on purpose, and the first question for each
  is always the same: *what kind of question is this?*
]

#objectives(
  [recognize, from the wording of a problem, which of the tools from
    Part A applies],
  [move fluently between the arrow picture, the two-point form and the
    component form of a vector],
  [combine several techniques in one multi-step problem],
  [identify the standard errors and say what makes each one wrong],
)

== One Object, Several Descriptions

#only-theory[
  The thread running through Part A has been that a single geometric
  object can be written down in more than one way, and that the skill
  is not knowing one description but moving between them.

  It began before any vectors existed. In the first chapter you
  located points on a cube by describing them in sentences — "the
  midpoint of the back vertical edge on the left" — found that clumsy,
  and replaced the sentences with triples of numbers. Every chapter
  since has repeated that move at a larger scale.
]

#keybox(title: "The same thing, written differently")[
  #auto-parts(
    1,
    [*A vector*: an arrow on a page, a pair of points $arrow(A B)$, or
      a column of components. The arrow shows you what is happening;
      the components let you calculate.],
    [*A direction*: a vector of any length, a unit vector, or an
      angle. The unit vector is the direction with the length
      divided out.],
    [*A line in the plane*: vector form, Cartesian form, point-slope
      form, intercept form. Four descriptions, one line.],
    [*A line in space*: vector form only. The parametric description
      is the one that survives, which is why it is the one everything
      later is built on.],
  )
]

#only-theory[
  Notice what happened to the *number of descriptions* as the objects
  got more complicated. A vector has three, a line in the plane has
  four, a line in space has one. That is not an accident of
  presentation. A single equation in $x$ and $y$ pins down a curve in
  the plane, but a single equation in $x$, $y$ and $z$ pins down a
  *surface* in space — and a line is not a surface. One equation
  always costs one dimension, and in space a line is one dimension too
  thin to be caught by one equation.
]

== Which Tool?

#only-theory[
  Almost every question in Part A is one of about a dozen kinds. The
  table below is worth learning as a table, because recognising the
  kind of question is most of the work.
]

#keybox(title: "Question, and the tool that answers it")[
  #auto-parts(
    1,
    [*How long is it? How far apart are they?* — magnitude,
      $abs(arrow(a)) = sqrt(a_x^2 + a_y^2 + a_z^2)$.],
    [*Which way does it point?* — the unit vector
      $arrow(e)_a = arrow(a) slash abs(arrow(a))$, or a direction
      angle in the plane.],
    [*Are these two directions the same?* — is one a scalar multiple
      of the other?],
    [*Do these three points lie on a line?* — is
      $arrow(A C)$ a multiple of $arrow(A B)$?],
    [*What angle do they make?* — the dot product, divided by the two
      magnitudes. Absolute value for lines, no absolute value for
      vectors.],
    [*Are they perpendicular?* — is the dot product zero?],
    [*Where is the midpoint? What divides this segment?* —
      $arrow(r)_P = arrow(r)_A + t dot arrow(A B)$.],
    [*Is this point on this line?* — substitute, solve one component
      equation for $t$, test the others.],
    [*Where does the line cross a coordinate plane?* — set the
      matching component to zero.],
    [*How do these two lines relate?* — directions parallel first,
      then a system of three equations in two unknowns.],
  )
]

#remark[
  Two of those entries look nearly identical and are not.

  "Are these two directions the same?" is a question about *scalar
  multiples*, and it is answered by division. "Are they
  perpendicular?" is a question about *dot products*, and it is
  answered by one multiplication and addition. Parallel and
  perpendicular are opposite conditions and they are tested by
  opposite operations — a fact worth holding onto, because reaching
  for the wrong one is the single most common error in this material.
]

== The Standard Errors

#warning[
  Collected from the warnings in Part A. Each one has cost somebody
  marks.

  #auto-parts(
    1,
    [*Two matching ratios do not prove parallel.* A candidate factor
      must survive *every* component.],
    [*$arrow(A B)$ is endpoint minus starting point*, in that order,
      and the answer is a vector, not a point.],
    [*A point and a vector are different objects*, even when written
      with the same three numbers.],
    [*$arctan$ only covers the right half of the plane.* Sketch first,
      then check the calculator's answer against the quadrant.],
    [*$arrow(a) dot arrow(b) = 0$ does not mean one of them is
      $arrow(0)$*, and you cannot cancel a dot product.],
    [*Two lines need two different parameters.* Using $t$ for both
      asks a different question.],
    [*Check the third equation.* Two lines agreeing in two coordinates
      is exactly what skew lines do.],
    [*A line has infinitely many correct vector equations.* Different
      from the answer key is not the same as wrong.],
  )
]

#ai-box(role: "Checker")[
  Take three exercises you have already solved from earlier chapters —
  ideally ones you found hard — and present only your *solutions* to an
  AI assistant, without the original questions. Ask it to reconstruct
  what each question must have been.

  This is an unusual direction to run the tool in, and it tests
  something specific: whether your written solution actually contains
  its own reasoning. If the assistant can recover the question, your
  work states what it is doing. If it cannot, your solution is probably
  a column of numbers with the thinking left in your head — which is
  exactly what loses method marks, since a marker is in much the same
  position as the assistant.

  As always, you are the judge. The assistant's guess being wrong may
  mean your solution was unclear, or may mean the assistant erred.
  Decide which, and say why.
]

#look-ahead(preview: [Part B: planes and space])[
  Part A gave you points, directions and lines. Part B adds one object
  — the *plane* — and it turns out that almost everything gets easier
  rather than harder once it arrives.

  Three specific debts will be paid. The cross product will produce a
  vector perpendicular to two given vectors in one line, replacing the
  system of two equations you solved in the dot product chapter. The
  question left hanging at the end of the last chapter — *how close do
  two skew lines get?* — will get an answer. And the cube sections you
  drew by eye in the very first chapter will be computed exactly, by
  intersecting a plane's equation with each of the twelve edges.
]

#ex(difficulty: 2, time: "18 min", calculator: false)[
  Let $A = (-3, 4)$ and $B = (5, -2)$, and let
  $arrow(v) = vec(3, 2)$.

  #auto-parts(
    1,
    [Find the components and the magnitude of $arrow(A B)$.],
    [Find $arrow(A B) - arrow(v)$ and
      $arrow(w) = arrow(A B) + arrow(v)$.],
    [Find $3 arrow(v) + arrow(w)$.],
    [How does $arrow(s) = vec(-1.5, -1)$ relate to $arrow(v)$?],
    [Calculate the angle between $arrow(v)$ and $arrow(w)$, to one
      decimal place. (This part needs a calculator.)],
  )
][
  #auto-parts(
    1,
    [$arrow(A B) = vec(8, -6)$ and
      $abs(arrow(A B)) = sqrt(64 + 36) = 10$.],
    [$arrow(A B) - arrow(v) = vec(5, -8)$ and
      $arrow(w) = vec(11, -4)$.],
    [$3 arrow(v) = vec(9, 6)$, so
      $3 arrow(v) + arrow(w) = vec(20, 2)$.],
    [$arrow(s) = -1/2 dot arrow(v)$: half as long, opposite
      direction. So the two are parallel.],
    [$arrow(v) dot arrow(w) = 33 - 8 = 25$, with
      $abs(arrow(v)) = sqrt(13)$ and $abs(arrow(w)) = sqrt(137)$. So
      $
        cos phi.alt = 25 / sqrt(1781) approx 0.5924
        quad arrow.r.double quad phi.alt approx 53.7degree.
      $],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  For each question below, say *which tool* you would use and *why*.
  Do not carry out any of the calculations.

  #auto-parts(
    1,
    [Do the points $(1, 0, 2)$, $(3, 4, 6)$ and $(-2, -6, -4)$ lie on
      one line?],
    [What is the shortest distance from $(4, 1, 0)$ to
      $(2, -3, 6)$?],
    [Is the triangle with vertices $P$, $Q$, $R$ right-angled?],
    [Where does the line
      $arrow(r) = vec(1, 2, 5) + t dot vec(2, -1, -1)$ cross the
      $x y$#"‑"plane?],
    [Find a vector of length $7$ pointing the same way as
      $vec(2, 3, 6)$.],
  )
][
  #auto-parts(
    1,
    [Collinearity: build $arrow(A B)$ and $arrow(A C)$ and test
      whether one is a scalar multiple of the other.],
    [Magnitude: the distance between two points is
      $abs(arrow(P Q))$.],
    [Dot products: form the three side vectors and test each vertex,
      since a right angle at a vertex means the two sides leaving it
      have dot product zero.],
    [A trace point, specifically $S_z$: set the third component
      equation to zero and solve for $t$.],
    [Normalize, then scale: $7 dot arrow(e)_a$. Here
      $abs(arrow(a)) = 7$ already, so the answer is the vector
      itself.],
  )

  Part (e) is a reminder to look before calculating. The magnitude was
  already $7$, so the "scaling" multiplies by $1$.
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  $A B C D$ is a parallelogram with $A = (3, -2)$ and $B = (7, 5)$.
  Its two diagonals meet at $E = (5, 4)$.

  Find $C$ and $D$.
][
  In a parallelogram the diagonals bisect each other, so $E$ is the
  midpoint of both $A C$ and $B D$. Reading the midpoint formula
  backwards,
  $
    arrow(r)_C = 2 arrow(r)_E - arrow(r)_A = vec(10 - 3, 8 + 2)
    = vec(7, 10),
  $
  $
    arrow(r)_D = 2 arrow(r)_E - arrow(r)_B = vec(10 - 7, 8 - 5)
    = vec(3, 3).
  $

  So $C = (7, 10)$ and $D = (3, 3)$.

  *Check.* In a parallelogram $arrow(A B) = arrow(D C)$. Indeed
  $arrow(A B) = vec(4, 7)$ and $arrow(D C) = vec(4, 7)$.
]

#ex(difficulty: 3, time: "15 min", calculator: false, hints: (
  "A point on the x-axis has the form (x, 0, 0) — one unknown, not three.",
  "Write both distances as squares before doing anything else. Squaring first removes the roots.",
  "Expect a quadratic, and therefore expect two answers.",
))[
  Find every point on the $x$#"‑"axis that is twice as far from
  $A = (12, 12, -6)$ as from $B = (15, 6, 3)$.
][
  Write $P = (x, 0, 0)$. Then
  $
    abs(arrow(A P))^2 = (x - 12)^2 + 144 + 36, quad
    abs(arrow(B P))^2 = (x - 15)^2 + 36 + 9.
  $

  The condition $abs(arrow(A P)) = 2 abs(arrow(B P))$ squares to
  $ (x - 12)^2 + 180 = 4 dot ((x - 15)^2 + 45). $
  Expanding both sides,
  $ x^2 - 24x + 324 = 4x^2 - 120x + 1080, $
  so $3x^2 - 96x + 756 = 0$, that is $x^2 - 32x + 252 = 0$, giving
  $x = 14$ or $x = 18$.

  The two points are $P_1 = (14, 0, 0)$ and $P_2 = (18, 0, 0)$.

  *Check* for $P_1$: $abs(arrow(A P_1))^2 = 4 + 180 = 184$ and
  $abs(arrow(B P_1))^2 = 1 + 45 = 46$, and $184 = 4 dot 46$. ✓
]

#ex(difficulty: 3, time: "20 min", calculator: false)[
  Three points are given: $A = (1, 2, 2)$, $B = (4, 8, 8)$ and
  $C = (5, -2, 4)$.

  #auto-parts(
    1,
    [Show that the three points do *not* lie on one line.],
    [Show that the triangle $A B C$ is right-angled, and find its
      area.],
    [Find the point $P$ that divides $A B$ in the ratio $1 : 2$,
      measured from $A$.],
    [Find a vector equation of the line through $P$ parallel to
      $A C$.],
    [Does the point $(6, 0, 6)$ lie on that line?],
  )
][
  #auto-parts(
    1,
    [$arrow(A B) = vec(3, 6, 6)$ and $arrow(A C) = vec(4, -4, 2)$.
      The first ratio is $4 slash 3$ and the second is $-2 slash 3$,
      so no single factor works and the points are not collinear.],
    [$arrow(A B) dot arrow(A C) = 12 - 24 + 12 = 0$, so the right
      angle is at $A$. The legs have lengths
      $abs(arrow(A B)) = sqrt(9 + 36 + 36) = 9$ and
      $abs(arrow(A C)) = sqrt(16 + 16 + 4) = 6$, so
      $ "Area" = 1/2 dot 9 dot 6 = 27. $],
    [Ratio $1 : 2$ from $A$ means one third of the way along, so
      $
        arrow(r)_P = arrow(r)_A + 1/3 dot arrow(A B)
        = vec(1, 2, 2) + vec(1, 2, 2) = vec(2, 4, 4),
      $
      giving $P = (2, 4, 4)$.],
    [The direction is $arrow(A C) = vec(4, -4, 2)$, which simplifies
      to $vec(2, -2, 1)$:
      $ g: arrow(r) = vec(2, 4, 4) + t dot vec(2, -2, 1). $],
    [The first component gives $2 + 2t = 6$, so $t = 2$. Testing:
      $y = 4 - 4 = 0$ ✓ and $z = 4 + 2 = 6$ ✓. Yes, the point lies on
      the line.],
  )
]

#ex(difficulty: 3, time: "18 min", calculator: true)[
  Two lines are given by
  $
    g: arrow(r) = vec(2, -1, 1) + t dot vec(-1, 2, -1), quad quad
    h: arrow(r) = vec(0, 2, 3) + s dot vec(0, 1, 1).
  $

  #auto-parts(
    1,
    [Classify the pair.],
    [Find the angle between them.],
    [Give a vector equation of the line through $(3, 3, 3)$ parallel
      to $g$.],
    [Does your new line from (c) meet $h$? Justify the answer without
      solving a system.],
  )
][
  #auto-parts(
    1,
    [The directions are not parallel. The component equations are
      $2 - t = 0$, $-1 + 2t = 2 + s$ and $1 - t = 3 + s$. The first
      gives $t = 2$; the second then gives $s = 1$; and the third
      reads $-1$ against $4$. It fails, so the lines are *skew*.],
    [$arrow(v)_1 dot arrow(v)_2 = 0 + 2 - 1 = 1$, with magnitudes
      $sqrt(6)$ and $sqrt(2)$:
      $
        cos phi.alt = abs(1) / sqrt(12) approx 0.2887
        quad arrow.r.double quad phi.alt approx 73.2degree.
      $],
    [$k: arrow(r) = vec(3, 3, 3) + u dot vec(-1, 2, -1)$.],
    [No. $k$ is parallel to $g$, and $g$ is skew to $h$ — so $k$ has
      the same direction as $g$ and therefore is not parallel to $h$
      either. If $k$ met $h$, the two would span a plane containing
      the direction of $g$ and the direction of $h$; but $g$ is
      parallel to $k$ and would then either lie in that plane or be
      parallel to it, and in the first case $g$ would meet $h$,
      contradicting (a).

      A shorter route: $k$ and $h$ do meet or they do not, and the
      quickest honest answer is to solve the system. Accept the longer
      argument only if you followed every step of it — an argument you
      cannot reconstruct is worth less than a calculation you can.],
  )
]

#only-high[
  #ex(difficulty: 3, time: "20 min", calculator: false)[
    Three students hand in the work below. Each answer is wrong. For
    each one, say what the error is, why it is wrong, and give the
    correct answer.

    #auto-parts(
      1,
      [*"$vec(2, 6, 5)$ and $vec(4, 12, 9)$ are parallel, because
      $4 = 2 dot 2$ and $12 = 2 dot 6$."*],
      [*"The angle between the lines with directions $vec(1, 0, 1)$
      and $vec(-1, 0, 0)$ is $135degree$."*],
      [*"The lines $arrow(r) = vec(1, 0, 0) + t dot vec(1, 1, 0)$ and
      $arrow(r) = vec(0, 1, 0) + t dot vec(0, 1, 1)$ meet where
      $1 + t = 0$ and $t = 1 + t$ — and since the second equation
      has no solution, the lines are skew."*],
    )
  ][
    #auto-parts(
      1,
      [*Error:* only two of the three ratios were checked. The third
        is $9 slash 5$, which is not $2$.

        *Correct:* the vectors are *not* parallel. Two matching
        ratios prove nothing; a candidate factor must survive every
        component.],
      [*Error:* the absolute value was omitted. The dot product is
        $-1$ and both magnitudes are $sqrt(2)$ and $1$, giving
        $cos phi.alt = -1 slash sqrt(2)$ and $135degree$ — which is
        the angle between those two particular *vectors*, not between
        the two *lines*.

        *Correct:* $cos phi.alt = abs(-1) slash sqrt(2)$, so
        $phi.alt = 45degree$. A line has no preferred direction, so
        the answer must not depend on which way the direction vectors
        happened to be written.],
      [*Error:* the same parameter $t$ was used for both lines. That
        asks whether the two lines pass through a common point *at the
        same parameter value*, which is a much stronger and quite
        different condition.

        *Correct:* use $t$ and $s$. The equations become
        $1 + t = 0$, $t = 1 + s$ and $0 = s$. From the first, $t = -1$;
        from the third, $s = 0$; and the second then reads $-1 = 1$,
        which fails. So the lines *are* skew — but the student's
        reasoning did not establish that, and on a different pair of
        lines the same reasoning would have given the wrong answer.],
    )

    Part (c) is the uncomfortable one: the conclusion was right and
    the method was wrong. Getting the right answer is not evidence
    that the reasoning was sound, which is the whole argument for
    writing arguments down rather than just answers.
  ]
]

#print-hints()
#print-vocab()
