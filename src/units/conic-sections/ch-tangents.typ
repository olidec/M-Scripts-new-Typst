#import "../../common/preamble.typ": *
#import "../../common/cplane.typ": *
#import "../../common/conic-figures.typ": *
#show: chapter-template.with(title: "Tangents")
#let ex = exercise.with(chapter: "Tangents")

// ── WHY THIS CHAPTER EXISTS ──────────────────────────────────
// The old LaTeX notes have nothing on tangents at all, while the
// formula booklet gives tangent equations, tangent conditions and
// conjugate directions for all three conics -- so the Matura can
// ask for them and the notes could not answer. That gap is the
// first reason.
//
// The second is that three separate debts have been announced and
// not paid: the reflection property (stated in ch-parabola and
// ch-ellipse, used to justify headlights and lithotripsy), and the
// claim in all three folding investigations that the creases are
// tangents. All three are settled here.
//
// ── NO CALCULUS IS USED ──────────────────────────────────────
// Everything runs on the discriminant: substitute the line, demand
// a double root. This is deliberate. It needs nothing beyond year
// 1 algebra, it produces the tangent CONDITION and the tangent
// EQUATION from the same computation, and it continues the
// circle-tangent work of SPF year 3 (2.3) rather than opening a
// new front. Implicit differentiation gets a two-line remark for
// students who have met it, flagged as optional.
//
// ── FIGURE NOTE ──────────────────────────────────────────────
// The reflection figure uses y^2 = 4x (p = 2), P = (4, 4),
// tangent y = (x+4)/2, T = (-4, 0), F = (1, 0). Verified:
// TF = 5 = PF, and all three marked angles are
// arctan(1/2) = 26.565 deg.

= Tangents and Reflection

#only-theory[
  Three times now something has been promised and not delivered. The
  parabola chapter claimed that a parabolic mirror sends every ray
  parallel to its axis through the focus. The ellipse chapter claimed
  that a shock wave from one focus of a lithotripter arrives at the
  other. And all three folding investigations claimed, without
  argument, that the creases are tangents to the curve they trace.

  Every one of those is a statement about tangents, and there has been
  no tangent to a conic in this unit until now. This chapter builds
  one, algebraically and without calculus, and then all three claims
  fall in a few lines each.
]

#look-back(
  title: "Tangents you have already drawn",
  recalls: [circle tangent problems from year 3],
)[
  You have solved tangent problems on circles by vector methods: a
  tangent is the line perpendicular to the radius at the point of
  contact, and a line is tangent when its distance from the centre
  equals the radius.

  Neither idea survives. An ellipse has no radius and no centre that
  is equidistant from its points. What does survive is the algebraic
  test underneath: substitute the line into the curve, and ask when
  the resulting quadratic has a *repeated* root. That test needs no
  geometry at all, and it works on all three conics without
  modification.
]

#objectives(
  [define a tangent to a conic by the double-root condition, and
    explain why "meets the curve exactly once" is not the same thing],
  [derive and apply the tangent conditions
    $q^2 = a^2 m^2 plus.minus b^2$ and $q = p slash (2 m)$],
  [write down the tangent to a conic at a given point of it using the
    splitting rule, and prove that it is the tangent],
  [find the two tangents from an external point to a conic],
  [prove the reflection property of the parabola, and use the
    corresponding properties of the ellipse and hyperbola],
  [explain why the folded creases of the first three investigations
    are tangents],
)

== What a Tangent Is

#only-theory[
  The intuitive picture -- a line that touches the curve without
  crossing it -- is hard to turn into a calculation. The obvious
  repair, "a line meeting the curve exactly once", is easy to
  calculate with and *wrong*.
]

#warning[
  Two counterexamples, both of them lines that meet a conic exactly
  once and are certainly not tangents:

  - the line $y = 3$ meets the parabola $y^2 = 4 x$ only at
    $(9 slash 4, 3)$, because it runs parallel to the axis and
    catches the curve on the way past;
  - the line $y = (3 slash 4) x + 1$ meets the hyperbola
    $x^2 slash 16 - y^2 slash 9 = 1$ only once, because it is
    parallel to an asymptote and so escapes one branch entirely.

  In both cases the quadratic that should have two roots has
  *degenerated*: its leading coefficient vanished, so it is really a
  linear equation with one root. That is a different phenomenon from
  tangency, and any definition that cannot tell them apart is no use.
]

#definition(title: "Tangent to a conic")[
  A line is a #vocab("tangent", "Tangente") to a conic if substituting
  it into the equation of the conic produces a quadratic equation with
  a *repeated* root -- that is, a genuine quadratic whose
  discriminant is zero.

  The repeated root is the #vocab("point of contact",
  "Berührungspunkt").
]

#remark[
  Reading this definition takes some care, and the care is the point.
  A quadratic with a repeated root is not the same as an equation with
  one solution: $x^2 - 2x + 1 = 0$ has a repeated root, while
  $0 dot x^2 + 3 x - 1 = 0$ has a single root and is not a quadratic
  at all. Requiring a *genuine* quadratic excludes exactly the two
  counterexamples above.
]

== The Tangent Condition

#only-theory[
  Take the ellipse $x^2 slash a^2 + y^2 slash b^2 = 1$ and a line
  $y = m x + q$. Substituting and clearing denominators,
  $
    b^2 x^2 + a^2 (m x + q)^2 = a^2 b^2 ,
  $
  which sorts into
  $
    (b^2 + a^2 m^2) x^2 + 2 a^2 m q x + a^2 (q^2 - b^2) = 0 .
  $
  The leading coefficient $b^2 + a^2 m^2$ is never zero, so this is
  always a genuine quadratic -- an ellipse has no asymptotes and no
  axis to run parallel to, which is why the pathologies above cannot
  happen here. Its discriminant is
  $
    Delta = 4 a^2 b^2 (a^2 m^2 + b^2 - q^2) ,
  $
  and setting it to zero gives the condition.
]

#keybox(title: "Tangent conditions")[
  The line $y = m x + q$ is a tangent to

  #table(
    columns: 2,
    stroke: none,
    align: left,
    [$x^2 / a^2 + y^2 / b^2 = 1$], [when $q^2 = a^2 m^2 + b^2$],
    [$x^2 / a^2 - y^2 / b^2 = 1$], [when $q^2 = a^2 m^2 - b^2$],
    [$y^2 = 2 p x$], [when $q = p / (2 m)$, with $m != 0$],
  )

  All three are in the formula booklet. The ellipse and hyperbola
  differ only in the sign of $b^2$, exactly as their equations do.
]

#remark[
  Each condition contains a small piece of geometry. For the ellipse,
  $q^2 = a^2 m^2 + b^2 >= b^2$, so no tangent passes closer to the
  origin than $b$ -- the curve is convex and encloses the centre. For
  the hyperbola, $q^2 = a^2 m^2 - b^2$ needs
  $abs(m) >= b slash a$: there is *no* tangent flatter than the
  asymptotes, which is exactly what the asymptote picture says. And
  for the parabola, $m = 0$ is excluded, which is the first
  counterexample of the previous section appearing as an algebraic
  side condition rather than as a warning.
]

#example(title: "Tangents from an external point")[
  Find the tangents from $P = (4, 0)$ to the ellipse
  $x^2 slash 4 + y^2 slash 3 = 1$.

  A line through $P$ has the form $y = m(x - 4)$, so $q = -4 m$.
  Imposing the tangent condition with $a^2 = 4$, $b^2 = 3$:
  $
    16 m^2 = 4 m^2 + 3
    quad ==> quad
    12 m^2 = 3
    quad ==> quad
    m = plus.minus 1 / 2 .
  $
  The two tangents are
  $ y = 1 / 2 (x - 4) quad "and" quad y = -1 / 2 (x - 4) . $
  Two solutions, as expected: $P$ lies outside the ellipse, and from
  an external point there are always exactly two tangents. From a
  point *on* the conic there is one, and from a point inside, none --
  and the number of real solutions of the quadratic in $m$ tells you
  which case you are in without your having to check first.
]

== The Tangent at a Given Point

#only-theory[
  Finding the tangent at a known point of the conic could be done by
  the same route -- impose the condition and also demand that the line
  pass through the point -- but there is a shortcut so clean it looks
  like a trick.
]

#keybox(title: "The splitting rule")[
  To get the tangent at a point $P_0 = (x_0, y_0)$ *lying on* the
  conic, take the equation of the conic and replace
  $
    x^2 |-> x x_0, quad quad
    y^2 |-> y y_0, quad quad
    x |-> (x + x_0) / 2, quad quad
    y |-> (y + y_0) / 2 .
  $
  For the three standard conics this gives
  $
    x x_0 / a^2 + y y_0 / b^2 = 1, quad quad
    x x_0 / a^2 - y y_0 / b^2 = 1, quad quad
    y y_0 = p (x + x_0) .
  $
  All three are in the formula booklet.
]

#theorem(title: "The splitting rule gives the tangent")[
  If $P_0 = (x_0, y_0)$ lies on the ellipse
  $x^2 slash a^2 + y^2 slash b^2 = 1$, then the line
  $
    t: quad x x_0 / a^2 + y y_0 / b^2 = 1
  $
  meets the ellipse at $P_0$ and nowhere else.
]

#proof[
  Let $P = (x, y)$ lie on both $t$ and the ellipse. Then three
  statements hold at once:
  $
    x^2 / a^2 + y^2 / b^2 = 1, quad
    x_0^2 / a^2 + y_0^2 / b^2 = 1, quad
    (x x_0) / a^2 + (y y_0) / b^2 = 1 ,
  $
  the first because $P$ is on the ellipse, the second because $P_0$
  is, the third because $P$ is on $t$. Add the first two and subtract
  twice the third: the right-hand side gives $1 + 1 - 2 = 0$, and the
  left-hand side collects into
  $
    (x - x_0)^2 / a^2 + (y - y_0)^2 / b^2 = 0 .
  $
  A sum of two non-negative terms vanishes only when both do, so
  $x = x_0$ and $y = y_0$. #heuristic("work backwards from the goal")
]

#remark[
  That is the same "sum of squares equal to zero" move that produced a
  single point in the classification chapter, used here for something
  quite different. It is worth noticing when a technique reappears in
  an unrelated place; that is usually a sign it is a technique and not
  a trick.

  For the ellipse, meeting once really does settle it: the curve is
  closed and convex, so a line meeting it exactly once cannot cross
  it. For the hyperbola and parabola the same computation yields a
  double root rather than a unique point, which is what the definition
  actually requires.
]

#remark[
  If you have met *implicit differentiation*, there is a two-line
  route. Differentiating $x^2 slash a^2 + y^2 slash b^2 = 1$ with
  respect to $x$ gives
  $2 x slash a^2 + 2 y y' slash b^2 = 0$, so the slope at $P_0$ is
  $y' = -b^2 x_0 slash (a^2 y_0)$, and the point-slope form
  rearranges to the splitting rule. It is faster, and it explains
  nothing about why the rule looks the way it does. Both routes are
  worth having.
]

#example(title: "Using the splitting rule")[
  The point $P_0 = (3, 16 slash 5)$ lies on
  $x^2 slash 25 + y^2 slash 16 = 1$ -- the ellipse and the point from
  the ellipse chapter's first figure. Its tangent is
  $
    (3 x) / 25 + ((16 slash 5) y) / 16 = 1
    quad ==> quad
    (3 x) / 25 + y / 5 = 1
    quad ==> quad
    3 x + 5 y = 25 .
  $
  Similarly $P_0 = (5, 9 slash 4)$ on $x^2 slash 16 - y^2 slash 9 = 1$
  gives
  $
    (5 x) / 16 - ((9 slash 4) y) / 9 = 1
    quad ==> quad
    5 x - 4 y = 16 .
  $
]

#remark[
  The booklet also records the *conjugate directions* of an ellipse:
  if $m_1$ and $m_2$ are the slopes of two chords such that each
  bisects all chords parallel to the other, then
  $
    m_1 dot m_2 = -b^2 / a^2 .
  $
  The same relation, with $+b^2 slash a^2$, holds for the hyperbola.
  It is the tool for midpoint-of-chord problems, and it is worth
  knowing that it is in the booklet even if you never need it.
]

== The Reflection Property of the Parabola

#only-theory[
  Now the payoff. Everything needed is already available: the tangent
  at a point, and the focal distance formula
  $overline(P F) = x_0 + p slash 2$ from the parabola chapter.
]

#theorem(title: "Reflection property")[
  Let $P$ be a point of the parabola $y^2 = 2 p x$ with focus $F$. The
  tangent at $P$ makes equal angles with the segment $P F$ and with
  the ray from $P$ parallel to the axis.

  Consequently a ray arriving parallel to the axis is reflected
  through the focus, and a ray leaving the focus is reflected into a
  ray parallel to the axis.
]

#proof[
  Let $P = (x_0, y_0)$. By the splitting rule the tangent at $P$ is
  $y y_0 = p(x + x_0)$, and setting $y = 0$ shows that it crosses the
  axis of the parabola at
  $ T = (-x_0, 0) . $
  The focus is $F = (p slash 2, 0)$, so
  $
    overline(T F) = p / 2 + x_0 .
  $
  But the focal distance formula gives
  $overline(P F) = x_0 + p slash 2$ as well. Hence
  $
    overline(T F) = overline(P F) ,
  $
  and the triangle $T F P$ is isosceles with apex $F$. Its base angles
  are therefore equal:
  $
    angle F T P = angle F P T .
  $
  Finally, $angle F T P$ is the angle between the tangent and the axis
  of the parabola, and the ray from $P$ parallel to that axis makes
  the same angle with the tangent, by alternate angles on the
  transversal $T P$. So the angle between the tangent and $P F$ equals
  the angle between the tangent and the parallel ray, which is the
  law of reflection.
]

#only-theory[
  #xyplane(
    xmin: -5.4,
    xmax: 7.6,
    ymin: -3.4,
    ymax: 5.6,
    length: 0.62cm,
    caption: [The reflection property on $y^2 = 4x$. The tangent at
      $P = (4,4)$ meets the axis at $T = (-4, 0)$, and
      $overline(T F) = overline(P F) = 5$ makes the triangle
      isosceles. All three marked angles are equal, which is the law
      of reflection.],
    {
      cn-directrix(-1, axis: "x", ymin: -3.4, ymax: 5.6)
      cn-parabola(2.0, axis: "x", extent: 5.2)
      cp-line(
        through: (-4, 0),
        direction: (2, 1),
        xmin: -5.4,
        xmax: 7.6,
        ymin: -3.4,
        ymax: 5.6,
        color: def-col,
      )
      cp-segment((4.0, 4.0), (1.0, 0.0), color: def-col)
      cp-segment((4.0, 4.0), (7.4, 4.0), color: expl-col)
      cp-angle(-4, 0, 0deg, 26.565deg, radius: 1.1, color: def-col)
      cp-angle(4, 4, 206.565deg, 233.13deg, radius: 1.1, color: def-col)
      cp-angle(4, 4, 0deg, 26.565deg, radius: 1.1, color: def-col)
      cn-focus(1, 0, label: $F$, anchor: "north-west")
      cp-point(-4.0, 0.0, label: $T$, anchor: "north-east", color: def-col)
      cp-point(4.0, 4.0, label: $P$, anchor: "north-west", color: def-col)
    },
  )
]

#remark[
  The ellipse and the hyperbola have their own versions, and both
  follow from a shortest-path argument rather than from a computation:

  - *Ellipse.* The tangent at $P$ makes equal angles with $P F_1$ and
    $P F_2$. So everything leaving one focus arrives at the other --
    the whispering gallery, and the lithotripter.
  - *Hyperbola.* The tangent at $P$ *bisects* the angle
    $angle F_1 P F_2$. A ray aimed at the far focus is reflected as
    though it had come from the near one, which is how the secondary
    mirror of a Cassegrain telescope shortens the tube.

  Exercise 7 asks you to prove the ellipse case.
]

== Back to the Folding

#only-theory[
  The very first investigation of the unit asked you to fold points of
  a line onto a fixed point $F$ and observe a parabola emerging from
  the creases. The claim was that each crease is a tangent. It can now
  be proved, and the proof is three lines.
]

#theorem(title: "The creases are tangents")[
  Let $d$ be the directrix and $F$ the focus of a parabola, and let
  $B$ be any point of $d$. Then the perpendicular bisector of the
  segment $B F$ -- the crease produced by folding $B$ onto $F$ -- is
  tangent to the parabola, touching it at the point $P$ of the
  parabola whose foot on $d$ is $B$.
]

#proof[
  Let $P$ be the point of the parabola whose perpendicular foot on $d$
  is $B$. By the definition of the parabola,
  $overline(P F) = overline(P B)$, so $P$ is equidistant from $B$ and
  $F$ and therefore lies *on* the perpendicular bisector.

  Now let $Q$ be any other point of that bisector. Then
  $overline(Q F) = overline(Q B)$. But $overline(Q B)$ is a slanted
  segment from $Q$ to a point of $d$, so it is strictly longer than
  the perpendicular distance from $Q$ to $d$:
  $
    overline(Q F) = overline(Q B) > overline(Q d) .
  $
  A point with $overline(Q F) > overline(Q d)$ is not on the parabola.
  So the bisector meets the parabola at $P$ and nowhere else -- and
  since the parabola is convex, that makes it the tangent at $P$.
]

#only-theory[
  #xyplane(
    xmin: -2.2,
    xmax: 6.4,
    ymin: -5.4,
    ymax: 5.4,
    length: 0.55cm,
    caption: [Nine creases on $y^2 = 4x$: each is the perpendicular
      bisector of $B F$ for a point $B$ of the directrix. The parabola
      is not drawn by the creases but by the gaps between them -- it
      is their envelope.],
    {
      cn-directrix(-1, axis: "x", ymin: -5.4, ymax: 5.4)
      for bb in (-4.0, -3.0, -2.0, -1.0, 0.0, 1.0, 2.0, 3.0, 4.0) {
        cp-line(
          through: (0.0, bb / 2),
          direction: (bb, 2.0),
          xmin: -2.2,
          xmax: 6.4,
          ymin: -5.4,
          ymax: 5.4,
          color: luma(155),
        )
      }
      cn-parabola(2.0, axis: "x", extent: 5.0)
      cn-focus(1, 0, label: $F$, anchor: "north-west")
    },
  )
]

#remark[
  A family of lines that outlines a curve without any of them lying
  along it is called an #vocab("envelope", "Einhüllende") of that
  curve. This is why the folded curve looks sharper than any of the
  creases: your eye picks out the boundary of the region the creases
  leave uncovered, and that boundary is the parabola.

  The ellipse and hyperbola constructions work the same way, with the
  directrix replaced by a circle. Folding a point of a circle onto an
  interior point gives an ellipse; onto an exterior point, a
  hyperbola; and the crease is the perpendicular bisector in every
  case. Which conic you get is decided by one thing only: whether the
  fixed point is inside or outside the circle.
]

// ── Exercises ────────────────────────────────────────────────

#ex(difficulty: 1, time: "12 min", calculator: false)[
  Use the splitting rule to find the tangent at the given point of
  each conic. Check in each case that the point really does lie on the
  conic first.
  #auto-parts(
    2,
    [$x^2 / 9 + y^2 / 4 = 1$ at $(3 slash 2, sqrt(3))$],
    [$x^2 / 16 - y^2 / 9 = 1$ at $(5, 9 slash 4)$],
    [$y^2 = 10 x$ at $(10, 10)$],
    [$x^2 + y^2 = 25$ at $(3, 4)$],
  )
][
  #auto-parts(
    1,
    [Check: $(9 slash 4) slash 9 + 3 slash 4 = 1 slash 4 + 3 slash 4
      = 1$. #sym.checkmark Tangent:
      $ (3 slash 2) x / 9 + (sqrt(3) y) / 4 = 1
        quad ==> quad 2 x + 3 sqrt(3) y = 12 . $],
    [Check: $25 slash 16 - (81 slash 16) slash 9 = 25 slash 16 -
      9 slash 16 = 1$. #sym.checkmark Tangent:
      $ (5 x) / 16 - ((9 slash 4) y) / 9 = 1
        quad ==> quad 5 x - 4 y = 16 . $],
    [Check: $100 = 10 dot 10$. #sym.checkmark Here $2 p = 10$ so
      $p = 5$, and the tangent is
      $ 10 y = 5 (x + 10) quad ==> quad y = (x + 10) / 2 . $],
    [Check: $9 + 16 = 25$. #sym.checkmark The rule applies to circles
      too: $3 x + 4 y = 25$. Compare with the year-3 method -- the
      tangent is perpendicular to the radius $(3, 4)$, and
      $3 x + 4 y = 25$ is exactly the line with normal vector
      $(3, 4)$ through $(3, 4)$.],
  )
]

#ex(difficulty: 2, time: "18 min", calculator: false)[
  #auto-parts(
    1,
    [Find the values of $q$ for which $y = 2 x + q$ is tangent to
      $x^2 / 9 - y^2 / 16 = 1$.],
    [Find the tangent to $y^2 = 12 x$ with slope $3$, and its point of
      contact.],
    [Show that no line of slope $1$ is tangent to
      $x^2 / 9 - y^2 / 16 = 1$, and explain geometrically why not.],
  )
][
  #auto-parts(
    1,
    [$q^2 = a^2 m^2 - b^2 = 9 dot 4 - 16 = 20$, so
      $q = plus.minus 2 sqrt(5)$.],
    [Here $2 p = 12$, so $p = 6$ and
      $q = p slash (2 m) = 6 slash 6 = 1$: the tangent is
      $y = 3 x + 1$. For the contact point, substitute:
      $(3x+1)^2 = 12 x$ gives $9 x^2 - 6 x + 1 = (3x - 1)^2 = 0$, a
      double root at $x = 1 slash 3$, so the point is
      $(1 slash 3, 2)$. #sym.checkmark],
    [The condition needs $q^2 = 9 - 16 = -7 < 0$, which no real $q$
      satisfies. Geometrically, the asymptotes have slope
      $plus.minus b slash a = plus.minus 4 slash 3$, and every
      tangent to a hyperbola is steeper than the asymptotes: a line of
      slope $1 < 4 slash 3$ either misses the curve or cuts straight
      through both branches, and neither is tangency.],
  )
]

#ex(difficulty: 2, time: "20 min", calculator: false, hints: (
  [Write the line through the given point in point-slope form and
    read off $q$ in terms of $m$.],
))[
  Find the tangents from the given point to the given conic, and say
  in each case whether the point is inside, on, or outside the curve.
  #auto-parts(
    1,
    [From $(0, 4)$ to $x^2 / 4 + y^2 = 1$.],
    [From $(0, 1 slash 2)$ to $x^2 / 4 + y^2 = 1$.],
  )
][
  #auto-parts(
    1,
    [A line through $(0,4)$ has $q = 4$, so the tangent condition
      gives $16 = 4 m^2 + 1$, hence $m^2 = 15 slash 4$ and
      $m = plus.minus sqrt(15) slash 2$. Two tangents:
      $ y = plus.minus sqrt(15) / 2 x + 4 . $
      Two real solutions, so the point is *outside*.],
    [Now $q = 1 slash 2$ and the condition reads
      $1 slash 4 = 4 m^2 + 1$, that is $m^2 = -3 slash 16 < 0$. No
      real solution, so there is no tangent and the point is
      *inside* -- which is easy to confirm directly, since
      $0 + 1 slash 4 < 1$.

      The count of real solutions does the classification for you.
      This is the same discriminant idea one level up: the number of
      tangents from a point is itself decided by whether a quadratic
      has two roots, one, or none.],
  )
]

#ex(difficulty: 2, time: "15 min", calculator: true, hints: (
  [Set up the parabola with its vertex at the origin, opening
    upwards.],
))[
  A satellite dish is a paraboloid $1.2$ m across the rim and $0.2$ m
  deep at the centre. The receiver must sit at the focus.
  #auto-parts(
    1,
    [Find the equation of the cross-section, taking the vertex at the
      origin and the axis along the positive $y$-axis.],
    [How far from the vertex of the dish should the receiver be
      mounted?],
    [The installer mounts it $50$ cm from the vertex instead. Using
      the reflection property, describe qualitatively what happens to
      the signal.],
  )
][
  #auto-parts(
    1,
    [With the vertex at the origin the rim points are
      $(plus.minus 0.6, 0.2)$. Substituting into $x^2 = 2 p y$,
      $
        0.36 = 2 p dot 0.2
        quad ==> quad
        2 p = 1.8
        quad ==> quad
        x^2 = 1.8 y .
      $],
    [$p = 0.9$, so the focus is at $(0, p slash 2) = (0, 0.45)$: the
      receiver goes $45$ cm from the vertex, along the axis.],
    [Rays parallel to the axis are still reflected through the true
      focus at $45$ cm. A receiver at $50$ cm sits $5$ cm beyond the
      point where they cross, so instead of arriving at a point they
      arrive spread over a small disc -- the signal is defocused and
      the effective gain drops, the more so the further off the
      mounting is. Nothing is reflected *to* the receiver's position
      preferentially; it simply catches a blurred image of the
      focus.],
  )
]

#ex(difficulty: 3, time: "20 min", calculator: false, hints: (
  [Where does the tangent at $P$ meet the axis of the parabola?
    Compute it first, then compare two lengths.],
))[
  Let $P = (x_0, y_0)$ be a point of $y^2 = 2 p x$ with $y_0 != 0$,
  let $T$ be the point where the tangent at $P$ meets the axis, and
  let $N$ be the foot of the perpendicular from $P$ to the axis.
  #auto-parts(
    1,
    [Show that $T = (-x_0, 0)$, so that the vertex is the midpoint of
      $T N$.],
    [Deduce a ruler-and-compass construction of the tangent at a given
      point of a parabola, needing neither the focus nor any
      calculation.],
    [Verify your construction on $y^2 = 4 x$ at the point $(4, 4)$.],
  )
][
  #auto-parts(
    1,
    [The tangent at $P$ is $y y_0 = p(x + x_0)$. Setting $y = 0$ gives
      $p(x + x_0) = 0$, and since $p != 0$, $x = -x_0$. The foot is
      $N = (x_0, 0)$, so $T$ and $N$ are symmetric about the origin,
      which is the vertex.],
    [Drop the perpendicular from $P$ to the axis, meeting it at $N$.
      Measure off the same distance on the other side of the vertex to
      get $T$. The line $T P$ is the tangent. No focus, no directrix,
      no arithmetic -- only the vertex, the axis and a compass.],
    [Here $x_0 = 4$, so $N = (4, 0)$ and $T = (-4, 0)$. The line
      through $(-4, 0)$ and $(4, 4)$ has slope
      $4 slash 8 = 1 slash 2$ and equation $y = (x + 4) slash 2$. The
      splitting rule gives $4 y = 2(x + 4)$, the same line.
      #sym.checkmark],
  )
]

#ex(difficulty: 3, time: "25 min", calculator: false, hints: (
  [Every point $Q$ of the tangent other than the point of contact lies
    outside the ellipse. What does that say about
    $overline(Q F_1) + overline(Q F_2)$?],
  [If a point on a line minimises the sum of distances to two points
    on the same side of it, what do you know about the angles?],
))[
  Prove the reflection property of the ellipse: the tangent at a point
  $P$ makes equal angles with $P F_1$ and $P F_2$.
  #auto-parts(
    1,
    [Let $t$ be the tangent at $P$ and let $Q$ be any other point of
      $t$. Explain why
      $overline(Q F_1) + overline(Q F_2) > 2 a$.],
    [Deduce that among all points of $t$, the point $P$ minimises the
      sum of the distances to the two foci.],
    [Use the shortest-path (Heron) principle to conclude that
      $P F_1$ and $P F_2$ make equal angles with $t$.],
  )
][
  #auto-parts(
    1,
    [The tangent meets the ellipse only at $P$, and the ellipse is a
      closed convex curve, so every other point of $t$ lies outside
      it. For a point outside, the sum of the distances to the foci
      exceeds $2a$ -- that sum equals $2a$ exactly on the curve, is
      smaller inside and larger outside. Hence
      $overline(Q F_1) + overline(Q F_2) > 2a$ for $Q != P$.],
    [At $P$ itself the sum equals $2a$, and everywhere else on $t$ it
      is strictly greater. So $P$ is the unique minimiser of
      $overline(Q F_1) + overline(Q F_2)$ over $Q in t$.],
    [Heron's principle: given two points on the same side of a line,
      the point of the line minimising the sum of the distances is the
      one at which the two segments make equal angles with the line
      -- equivalently, the point found by reflecting one of the two
      points in the line and joining. Since $P$ is that minimiser,
      $P F_1$ and $P F_2$ make equal angles with $t$.

      Both foci are indeed on the same side of $t$, since the tangent
      does not cross the ellipse and the foci are inside it.],
  )
]

#ex(difficulty: 3, time: "20 min", calculator: false, hints: (
  [At a common point, what does the ellipse's reflection property say
    about its tangent? And the hyperbola's?],
))[
  In the eccentricity chapter you met the confocal family
  $x^2 slash k + y^2 slash (k - 16) = 1$, whose members all have foci
  $(plus.minus 4, 0)$ -- ellipses for $k > 16$ and hyperbolas for
  $0 < k < 16$.

  Prove that at every point where an ellipse of the family meets a
  hyperbola of the family, the two curves cross at right angles.
][
  Let $P$ be a common point, with $F_1$ and $F_2$ the shared foci.

  By the reflection property of the ellipse, the tangent to the
  ellipse at $P$ makes equal angles with $P F_1$ and $P F_2$ -- and
  since the two foci lie on the same side of it, that tangent is the
  *external* bisector of the angle $angle F_1 P F_2$.

  By the reflection property of the hyperbola, the tangent to the
  hyperbola at $P$ *bisects* the angle $angle F_1 P F_2$ -- the
  internal bisector.

  The internal and external bisectors of an angle are always
  perpendicular, since together they cut the straight angle into four
  parts totalling $180 degree$ in two equal pairs. Hence the two
  tangents at $P$ are perpendicular, which is what it means for the
  curves to cross at right angles.

  Two families of curves meeting everywhere at right angles are called
  *orthogonal trajectories*. Confocal conics are the standard example,
  and the picture -- ellipses and hyperbolas forming a curved grid
  around two fixed points -- is the field pattern of two equal point
  sources, which is not a coincidence.
]

#ai-box(role: "Explainer")[
  The reflection property is stated everywhere and proved almost
  nowhere.

  + Ask an AI assistant to prove that a parabolic mirror focuses
    parallel rays at the focus. Do not tell it which method to use.
  + Classify what you get. Is it a proof, or a restatement of the
    claim with the word "because" inserted? If it used calculus, can
    you follow every step, and does it ever use a property of the
    parabola that it has not established?
  + Then give it the isosceles-triangle proof from this chapter and
    ask it to find the one fact the proof depends on that is not
    proved *in* the proof. (It is the focal distance formula
    $overline(P F) = x_0 + p slash 2$.) Does it find it?
]

#print-vocab()
