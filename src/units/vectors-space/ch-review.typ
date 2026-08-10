#import "../../common/preamble.typ": *
#import "/src/common/vec-figures.typ": *
#show: chapter-template.with(title: "Looking Back Again")
#let ex = exercise.with(chapter: "Looking Back Again")

= Looking Back Again

#only-theory[
  Part A ended with a chapter that refused to tell you which tool to
  use. This one does the same, and then goes further: it ends with two
  questions of the length, shape and difficulty of the ones you will
  meet in an examination.

  Those two are worth treating seriously. Sit down with the formula
  booklet, no calculator, a clock, and no notes — and do not look at
  the solutions until you have finished or run out of time. A question
  you have half-solved and then read the answer to teaches you almost
  nothing; a question you have finished badly teaches you a great
  deal.
]

#objectives(
  [recognize which of the Part B techniques a problem is asking for],
  [carry a multi-step problem through without losing the thread],
  [check an answer independently of the method that produced it],
  [work under examination conditions: no calculator, formula booklet,
    exact answers],
)

== What Part B Added

#only-theory[
  Part A could describe points, directions and lines. Part B added one
  object, the plane — and with it, three tools that Part A lacked.

  #auto-parts(
    1,
    [*The cross product*, which manufactures a perpendicular to two
      given directions. Part A could only get one by solving a system.],
    [*The normal form*, which describes a plane by one perpendicular
      direction rather than two parallel ones — and which makes
      "is this point on it?" a substitution rather than a system.],
    [*The Hesse form*, which turns that same equation into a
      measuring instrument, so that the left-hand side evaluated at a
      point *is* its distance.],
  )

  Almost every question in Part B is one of those three doing its job,
  possibly twice.
]

#keybox(title: "Question, and the tool that answers it")[
  #auto-parts(
    1,
    [*A vector perpendicular to two others?* — cross product.],
    [*The plane through three points?* — cross product for the normal,
      then substitute one point for $d$.],
    [*Is this point on the plane?* — substitute into the Cartesian
      equation.],
    [*Where does the line pierce the plane?* — substitute the line's
      components into the plane's equation; one equation in $t$.],
    [*Where do two planes meet?* — cross product of the normals for
      the direction; set one coordinate to zero for a point.],
    [*The angle between two planes?* — the angle between the normals,
      with an absolute value.],
    [*The angle between a line and a plane?* — the same expression,
      but $arcsin$.],
    [*How far is this point from the plane?* — Hesse form.],
    [*How far apart are these parallel planes?* — a point on one,
      Hesse form against the other.],
    [*The nearest point of the plane, or the mirror image?* — travel
      from the point along the normal.],
    [*The area of a triangle in space?* — half the magnitude of a
      cross product.],
    [*The volume of a pyramid?* — one third of base times height, with
      the height from the Hesse form.],
  )
]

#toolbox()

== The Standard Errors of Part B

#warning[
  #auto-parts(
    1,
    [*$arcsin$ for a line and a plane, $arccos$ for two planes.* The
      wrong one gives $90degree - phi.alt$, which looks entirely
      reasonable.],
    [*Rescale before comparing constants.* Two parallel planes must
      have *identical* normals, not merely parallel ones, before their
      $d$ values may be compared.],
    [*A distance question has one answer; a "find the parallel plane"
      question has two*, one on each side, unless a side is specified.],
    [*Check the third equation.* Still true, and still the difference
      between intersecting and skew.],
    [*The cross product is not commutative.* Swapping the factors
      reverses the answer.],
    [*Two planes never meet in a point.* If your working produces one,
      the working is wrong — the equation count forbids it.],
    [*Keep fractions as fractions.* A final check that should give
      exactly zero will not, if you rounded on the way.],
  )
]

== Mixed Practice

#ex(difficulty: 2, time: "12 min", calculator: false)[
  For each question, name the tool you would use and say why. Do not
  carry out any calculation.

  #auto-parts(
    1,
    [Is the line
      $arrow(r) = vec(1, 0, 2) + t dot vec(3, -1, -1)$ parallel to the
      plane $x + y + 2z = 5$?],
    [What is the area of the triangle with vertices $P$, $Q$, $R$ in
      space?],
    [How far apart are $2x - y + 2z = 4$ and $4x - 2y + 4z = 30$?],
    [At what angle does the line $g$ meet the plane $E$?],
    [Which point of $E$ is nearest to $P$?],
  )
][
  #auto-parts(
    1,
    [Dot the direction with the normal. Zero means parallel *or*
      contained; a point test then separates the two.],
    [Half the magnitude of $arrow(P Q) times arrow(P R)$.],
    [Rescale the second equation to $2x - y + 2z = 15$ *first*, then
      take a point on one plane and apply the Hesse form to the other.],
    [$arcsin$ of the normalized dot product of $arrow(n)$ and
      $arrow(v)$ — not $arccos$.],
    [The foot of the perpendicular: travel from $P$ along $arrow(n)$
      until you reach $E$.],
  )
]

#ex(difficulty: 3, time: "15 min", calculator: false)[
  The plane $E$ passes through $A = (1, 1, 1)$, $B = (3, 1, 0)$ and
  $C = (5, 0, 0)$.

  #auto-parts(
    1,
    [Find the Cartesian equation of $E$.],
    [Find the area of triangle $A B C$.],
    [Find the distance from the origin to $E$.],
    [Find the volume of the tetrahedron $O A B C$ in two different
      ways, and check that they agree.],
  )
][
  #auto-parts(
    1,
    [$arrow(A B) = vec(2, 0, -1)$ and $arrow(A C) = vec(4, -1, -1)$
      give
      $arrow(A B) times arrow(A C) = vec(-1, -2, -2)$, tidied to
      $vec(1, 2, 2)$. With $A$: $1 + 2 + 2 + d = 0$, so
      $ E: x + 2y + 2z - 5 = 0. $],
    [$ "Area" = 1/2 dot abs(vec(-1, -2, -2))
        = 1/2 dot 3 = 3/2. $],
    [$abs(arrow(n)) = 3$, so
      $d(O, E) = (0 + 0 + 0 - 5) slash 3 = -5 slash 3$, a distance of
      $5 slash 3$.],
    [*First way:* base times height,
      $ V = 1/3 dot 3/2 dot 5/3 = 5/6. $
      *Second way:* one sixth of the scalar triple product of the
      three edges from $O$:
      $ V = 1/6 dot abs((arrow(O A) times arrow(O B)) dot arrow(O C)). $
      Here $arrow(O A) times arrow(O B) = vec(1, 1, 1) times
      vec(3, 1, 0) = vec(-1, 3, -2)$, and dotting with
      $arrow(O C) = vec(5, 0, 0)$ gives $-5$. So
      $V = 5 slash 6$ ✓.

      The two routes share no arithmetic, which is what makes the
      agreement worth something.],
  )
]

== Exam-Style Questions

#only-theory[
  The two questions below are of examination length and difficulty.
  Work them under the real conditions:

  #auto-parts(
    1,
    [*no calculator* — every answer comes out exactly, or as a surd,
      or as an inverse trigonometric expression;],
    [*formula booklet allowed* — you are not expected to have
      memorised the Hesse form;],
    [*about 35 minutes each*, and stop when the time is up;],
    [*show the working*, because a correct answer with no argument is
      worth very little and a wrong answer with a clear argument is
      worth a good deal.],
  )

  Both questions are built so that later parts lean on earlier ones.
  If a part defeats you, state what you would have done with the
  answer and carry on — that is how it is marked, and how it should
  be attempted.
]

#ex(difficulty: 3, time: "35 min", calculator: false)[
  *Exam question 1.* The points
  $ A = (6, 0, 0), quad B = (0, 6, 0), quad C = (0, 0, 12) $
  lie in a plane $E$, and $O$ is the origin.

  #auto-parts(
    1,
    [Find the Cartesian equation of $E$.],
    [Show that $P = (2, 2, 4)$ lies on $E$, and find the distance from
      $Q = (4, 5, 3)$ to $E$.],
    [Find the foot $F$ of the perpendicular from $Q$ to $E$, and the
      mirror image $Q'$ of $Q$ in $E$.],
    [Find the exact cosine of the angle between $E$ and the
      $x y$#"‑"plane.],
    [Find the volume of the pyramid $O A B C$.],
    [Find the equation of the plane $G$ through $Q$ parallel to $E$,
      and state the distance between $E$ and $G$. Comment on your
      answer.],
  )
][
  #auto-parts(
    1,
    [$arrow(A B) = vec(-6, 6, 0)$ and $arrow(A C) = vec(-6, 0, 12)$,
      so
      $ arrow(n) = arrow(A B) times arrow(A C) = vec(72, 72, 36), $
      which tidies to $vec(2, 2, 1)$. Substituting $A$ gives
      $12 + d = 0$, so
      $ E: 2x + 2y + z - 12 = 0. $
      *Check:* $B$ gives $12 - 12 = 0$ ✓ and $C$ gives
      $12 - 12 = 0$ ✓.],
    [$P$: $4 + 4 + 4 - 12 = 0$ ✓.

      $abs(arrow(n)) = sqrt(4 + 4 + 1) = 3$, so
      $ d(Q, E) = (8 + 10 + 3 - 12)/3 = 9/3 = 3. $],
    [The perpendicular is
      $arrow(r) = vec(4, 5, 3) + t dot vec(2, 2, 1)$. Substituting:
      $ 2(4 + 2t) + 2(5 + 2t) + (3 + t) - 12 = 9 + 9t = 0, $
      so $t_0 = -1$ and
      $ F = (4, 5, 3) - (2, 2, 1) = (2, 3, 2). $
      *Check:* $4 + 6 + 2 - 12 = 0$ ✓.

      The mirror image is one step further:
      $ Q' = (4, 5, 3) - 2 dot (2, 2, 1) = (0, 1, 1). $
      *Check:* $d(Q', E) = (0 + 2 + 1 - 12) slash 3 = -3$, the same
      distance on the opposite side ✓.],
    [The $x y$#"‑"plane has normal $vec(0, 0, 1)$, so
      $ cos phi.alt = abs(vec(2, 2, 1) dot vec(0, 0, 1)) /
        (3 dot 1) = 1/3. $],
    [The base $O A B$ is a right triangle in the $x y$#"‑"plane with
      legs $6$ and $6$, so its area is $18$; the height is the
      $z$#"‑"intercept, $12$. Hence
      $ V = 1/3 dot 18 dot 12 = 72. $],
    [Parallel planes share a normal, so $G: 2x + 2y + z + D = 0$ with
      $8 + 10 + 3 + D = 0$, giving $D = -21$:
      $ G: 2x + 2y + z - 21 = 0. $
      Taking $A = (6, 0, 0)$ on $E$,
      $ d(A, G) = (12 + 0 + 0 - 21)/3 = -3, $
      so the planes are $3$ apart.

      *Comment.* That is the same $3$ as in part (b), and it had to
      be: $Q$ lies on $G$, and every point of $G$ is the same distance
      from $E$. Part (f) is part (b) seen from the other side.],
  )
]

#ex(difficulty: 3, time: "35 min", calculator: false)[
  *Exam question 2.* Two lines are given by
  $ g: arrow(r) = vec(-1, 2, 6) + t dot vec(2, -1, -2), quad quad
    h: arrow(r) = vec(0, 0, 8) + s dot vec(1, 1, -4). $

  #auto-parts(
    1,
    [Show that $g$ and $h$ intersect, and find the point of
      intersection $S$.],
    [Find the exact angle between $g$ and $h$.],
    [Find the Cartesian equation of the plane $E$ containing both
      lines.],
    [Find the distance from $P = (3, 3, 5)$ to $E$.],
    [Find the point of $E$ nearest to $P$. Comment on your answer.],
    [$E$ and the three coordinate planes bound a pyramid. Find its
      volume.],
  )
][
  #auto-parts(
    1,
    [The directions are not parallel. Setting the two equations equal:
      $ -1 + 2t = s, quad 2 - t = s, quad 6 - 2t = 8 - 4s. $
      From the first two, $-1 + 2t = 2 - t$, so $t = 1$ and $s = 1$.

      *Test the third:* $6 - 2 = 4$ and $8 - 4 = 4$ ✓. The lines meet,
      at
      $ S = (-1, 2, 6) + (2, -1, -2) = (1, 1, 4). $],
    [$arrow(v)_1 dot arrow(v)_2 = 2 - 1 + 8 = 9$, with
      $abs(arrow(v)_1) = 3$ and
      $abs(arrow(v)_2) = sqrt(18) = 3 sqrt(2)$. So
      $ cos phi.alt = 9/(3 dot 3 sqrt(2)) = 1/sqrt(2)
        quad arrow.r.double quad phi.alt = 45degree. $],
    [Both directions lie in $E$, so
      $ arrow(n) = vec(2, -1, -2) times vec(1, 1, -4)
        = vec(6, 6, 3), $
      which tidies to $vec(2, 2, 1)$. Substituting $S = (1, 1, 4)$
      gives $2 + 2 + 4 + d = 0$, so
      $ E: 2x + 2y + z - 8 = 0. $
      *Check:* both anchor points must satisfy it —
      $(-1, 2, 6)$ gives $-2 + 4 + 6 - 8 = 0$ ✓ and $(0, 0, 8)$ gives
      $8 - 8 = 0$ ✓.],
    [$abs(arrow(n)) = 3$, so
      $ d(P, E) = (6 + 6 + 5 - 8)/3 = 9/3 = 3. $],
    [Travel from $P$ along the normal:
      $ arrow(r) = vec(3, 3, 5) + t dot vec(2, 2, 1), $
      and substituting gives $9 + 9t = 0$, so $t_0 = -1$ and the
      nearest point is
      $ (3, 3, 5) - (2, 2, 1) = (1, 1, 4). $

      *Comment.* That is $S$, the intersection point from part (a).
      The reason is visible in the arithmetic:
      $arrow(S P) = vec(2, 2, 1) = arrow(n)$, so $P$ was sitting
      directly above $S$ on the normal all along — which is also why
      the distance in (d) came out as exactly $abs(arrow(n)) = 3$.],
    [The intercepts of $E$ are $x = 4$, $y = 4$ and $z = 8$. The base
      in the $x y$#"‑"plane is a right triangle with legs $4$ and $4$,
      of area $8$, and the height is $8$:
      $ V = 1/3 dot 8 dot 8 = 64/3. $],
  )
]

#look-ahead(preview: [what comes next])[
  Two threads from this unit continue elsewhere.

  *Conic sections.* The circle was the first of a family. Tilt the
  cutting plane and the same construction gives an ellipse, a parabola
  and a hyperbola, all with equations of the general quadratic shape —
  and completing the square, which found a centre and a radius here,
  will find a centre and axes there.

  *Everything with a direction.* Forces, velocities, accelerations,
  fields. The physics course will assume without comment that you can
  add them, resolve them and dot them together, because that is what
  this unit was for.

  And the thread that does not continue, because it is finished: you
  began Part A unable to say where a point on a cube was without a
  sentence, and you end able to compute the polygon a plane cuts from
  it, the angle that plane makes with the floor, and how far any given
  corner sits from it. That is the whole distance travelled, and it is
  worth noticing.
]

#print-hints()
#print-vocab()
