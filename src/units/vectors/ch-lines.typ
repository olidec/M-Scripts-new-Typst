#import "../../common/preamble.typ": *
#import "/src/common/vec-figures.typ": *
#show: chapter-template.with(title: "A Point and a Direction")
#let ex = exercise.with(chapter: "A Point and a Direction")

= A Point and a Direction

#only-theory[
  Everything so far has been about individual vectors. This chapter
  uses them to describe something with infinitely many points in it —
  a straight line — and it does so with a single equation containing
  one adjustable number.

  The idea arrived already, at the end of the chapter on vector
  arithmetic, while we were looking for a midpoint. It is worth
  starting somewhere else entirely and watching it appear again.
]

#objectives(
  bfkm[write down the vector equation of a line through two given
    points, or through a point in a given direction],
  [decide whether a given point lies on a given line],
  [find the trace points of a line in space, and recognize when one
    does not exist],
  [convert between the vector, Cartesian, point-slope and intercept
    forms of a line in the plane],
  [explain why a line has infinitely many different vector equations],
)

== An Aeroplane

#exploration(title: "Where is it now?")[
  An aeroplane takes off at time $t = 0$ from the point
  $P = (12, -4, 0)$. One minute later, at $t = 1$, it is at
  $Q = (8, 2, 3)$. Assume it continues in a straight line at constant
  speed, and that distances are in kilometres.

  + Sketch the situation.

  + Where is the aeroplane at $t = 2$? At $t = 3$?

  + Find an expression for its position at an arbitrary time $t$.
    Check it against your answers to (b).

  + When does it reach its cruising altitude of $12$ km, and where
    is it at that moment?

  + The $y z$#"‑"plane marks a national border. When does the aeroplane
    cross it, and at what point?
]

#only-theory[
  In one minute the aeroplane moves from $P$ to $Q$, so its
  displacement per minute is
  $ arrow(v) = arrow(P Q) = vec(8 - 12, 2 + 4, 3 - 0) = vec(-4, 6, 3). $

  After $t$ minutes it has done that $t$ times over, so its position is
  $
    arrow(r)(t) = arrow(r)_P + t dot arrow(v)
    = vec(12, -4, 0) + t dot vec(-4, 6, 3).
  $

  At $t = 2$ that gives $(4, 8, 6)$ and at $t = 3$ it gives
  $(0, 14, 9)$, matching what you found by stepping forward one minute
  at a time.

  The last two questions are answered by reading off *one* coordinate.
  Altitude $12$ means $z = 12$, and the third component says
  $3t = 12$, so $t = 4$ and the aeroplane is at $(-4, 20, 12)$.
  Crossing the $y z$#"‑"plane means $x = 0$, so $12 - 4t = 0$, giving
  $t = 3$ and the crossing point $(0, 14, 9)$.

  Nothing in that calculation used the fact that $t$ was a time.
  Allow $t$ to be any real number — including negative ones, which
  describe where the aeroplane *would have been* before take-off — and
  the expression sweeps out an entire straight line.
]

== The Vector Equation of a Line

#definition(title: "Vector equation of a line")[
  A line $g$ is determined by one point on it and one direction along
  it. If $A$ is a point of $g$ and $arrow(v) eq.not arrow(0)$ is
  parallel to $g$, then
  $ g: arrow(r) = arrow(r)_A + t dot arrow(v), quad t in RR. $

  $arrow(r)_A$ is called the #vocab("anchor point", "Aufpunkt") and
  $arrow(v)$ the #vocab("direction vector", "Richtungsvektor"). This is
  the #vocab("vector equation", "Vektorgleichung") of the line, also
  called its *parametric equation*, and $t$ is the
  #vocab("parameter", "Parameter").
]

#only-theory[
  Written out coordinate by coordinate, with
  $arrow(r) = vec(x, y, z)$:
  $
    x = a_x + t dot v_x, quad
    y = a_y + t dot v_y, quad
    z = a_z + t dot v_z.
  $
  These are the #vocab("component equations", "Komponentengleichungen"),
  and they are what you actually work with. Each of them involves the
  same $t$, which is the whole reason the three coordinates are tied
  together into a line instead of drifting independently.

  #fig(
    space3d(
      ..line3((1, 1, 1), (1, 3, 2), tmin: -0.45, tmax: 1.2, color: luma(120)),
      s-vec(to: (1, 1, 1), label: $arrow(r)_A$, color: ex-col, anchor: 0.55),
      s-vec(from: (1, 1, 1), to: (2, 4, 3), label: $arrow(v)$, color: warn-col),
      s-pt((1, 1, 1), label: $A$),
      s-txt(
        (2.2, 4.6, 3.4),
        text(style: "italic", weight: "bold")[g],
        off: (12pt, 2pt),
      ),
      axis-len: (4, 5.5, 4.5),
    ),
    caption: [To reach any point of $g$: travel to $A$, then go some
      multiple of $arrow(v)$.],
  )

  *Example.* Find a vector equation of the line through
  $A = (1, -2, 3)$ and $B = (2, 4, -2)$.

  The direction is $arrow(A B) = vec(1, 6, -5)$, and $A$ is on the
  line, so
  $ g: arrow(r) = vec(1, -2, 3) + t dot vec(1, 6, -5). $
]

#warning[
  A line has *infinitely many* vector equations, and they are all
  correct.

  You may use any point of the line as the anchor, and any non-zero
  multiple of the direction as the direction vector. For the example
  above, all of these describe the same line:
  $
    vec(1, -2, 3) + t dot vec(1, 6, -5), quad
    vec(2, 4, -2) + t dot vec(1, 6, -5), quad
    vec(1, -2, 3) + t dot vec(-2, -12, 10).
  $

  So "my answer looks different from the one in the back of the book"
  is not evidence of a mistake. It is the normal situation. What you
  must be able to do instead is *check* two equations against each
  other, and the test has two parts: the direction vectors must be
  parallel, and the anchor point of one must lie on the other line.
]

#ai-box(role: "Explainer")[
  Ask an AI assistant to explain why a line has more than one vector
  equation, and to produce three different equations for the line
  through $(2, -1, 4)$ and $(5, 5, 0)$.

  Then check its three answers yourself, using the two-part test in
  the warning above. This is a good task to hand over precisely
  because the checking is mechanical: one parallelism test and one
  point-on-line test per equation, both of which you can now do in
  under a minute.

  If an explanation sounds convincing but one of the equations fails
  your check, that is the most useful outcome available — it is a
  concrete reminder that fluent prose and correct mathematics are
  different things, and that only one of them is your responsibility
  to verify.
]

== Is This Point on That Line?

#only-theory[
  A point $P$ lies on $g$ exactly when there is *one* value of $t$
  that produces $P$ in all three component equations. One value, for
  all three — a different $t$ for each coordinate proves nothing.

  The procedure: substitute $P$, solve one component equation for $t$,
  then test that $t$ in the remaining two.

  *Example.* Do $Q = (20, 1, -6)$ and $P = (5, 3, 18)$ lie on
  $ g: arrow(r) = vec(5, 4, -15) + t dot vec(5, -1, 3) ? $

  For $Q$, the first component gives $5 + 5t = 20$, so $t = 3$.
  Testing this in the other two:
  $ y: 4 - 3 = 1 checkmark, quad quad z: -15 + 9 = -6 checkmark. $
  Both agree, so $Q$ lies on $g$.

  For $P$, the first component gives $5 + 5t = 5$, so $t = 0$. Testing:
  $ y: 4 - 0 = 4 eq.not 3. $
  One failure is enough. $P$ does not lie on $g$, and there is no need
  to check $z$.
]

== Trace Points

#only-theory[
  Where does a line meet the coordinate planes? In the aeroplane
  problem this was the border-crossing question, and it is worth a
  name.
]

#definition(title: "Trace points")[
  The #vocab("trace points", "Spurpunkte") of a line are its
  intersections with the three coordinate planes. They are written
  $S_x$, $S_y$ and $S_z$, where *the subscript names the coordinate
  that vanishes*:
  $ S_x "lies in the" y z "-plane" (x = 0), $
  $ S_y "lies in the" x z "-plane" (y = 0), $
  $ S_z "lies in the" x y "-plane" (z = 0). $
]

#only-theory[
  Each one costs a single equation. To find $S_z$, set the third
  component equation to zero, solve for $t$, and substitute that $t$
  back into the other two.

  *Example.* Find the trace points of
  $ g: arrow(r) = vec(1, -3, 3) + t dot vec(1, 1, -3). $

  For $S_z$ set $z = 0$: $3 - 3t = 0$, so $t = 1$, giving
  $S_z = (2, -2, 0)$.

  For $S_x$ set $x = 0$: $1 + t = 0$, so $t = -1$, giving
  $S_x = (0, -4, 6)$.

  For $S_y$ set $y = 0$: $-3 + t = 0$, so $t = 3$, giving
  $S_y = (4, 0, -6)$.

  #fig(
    space3d(
      ..line3((1, -3, 3), (1, 1, -3), tmin: -1.4, tmax: 3.4, color: def-col),
      s-pt((2, -2, 0), label: $S_z$, color: warn-col, r: 2pt),
      s-pt((0, -4, 6), label: $S_x$, color: warn-col, r: 2pt),
      s-pt((4, 0, -6), label: $S_y$, color: warn-col, r: 2pt),
      grid: true,
      axis-len: (4.5, 4.5, 6.5),
      unit: 0.52cm,
    ),
    caption: [The three trace points of $g$. Only one of them has all
      coordinates positive.],
  )
]

#remark[
  Look at that figure and notice how the three trace points are
  scattered — one in front, two behind, none of them tidy.

  This is not bad luck. The first octant, where all three coordinates
  are positive, is a *convex* region, and a straight line meets the
  boundary of a convex region in at most two points. So *at most two*
  of a line's three trace points can have all coordinates
  non-negative, and expecting three tidy answers is expecting
  something impossible.

  You met the same fact in the very first chapter, about a line
  crossing a cube: at most two piercing points, never three. It is
  the same statement, with the cube's six faces replaced by three
  infinite planes.
]

#warning[
  A line does not always have three trace points.

  If a direction vector has a zero component, the corresponding
  coordinate never changes along the line. Take
  $arrow(r) = vec(2, 5, 9) + t dot vec(0, 5, 3)$: the first component
  is $x = 2$ for every $t$, so the line never reaches $x = 0$ and
  $S_x$ does not exist. The line runs parallel to the
  $y z$#"‑"plane.

  Write "$S_x$: none" rather than leaving a blank. It is an answer,
  not a gap.
]

== Lines in the Plane

#only-theory[
  Everything so far works in two dimensions as well, and there
  something extra becomes available: in the plane a line can also be
  written as a single equation in $x$ and $y$, with no parameter at
  all.

  You already know the school form $y = m x + q$. The point of this
  section is that it is one of four descriptions of the same object,
  and that moving between them is routine. We will take one line and
  write it four ways.

  Throughout: $g: arrow(r) = vec(-6, 6) + t dot vec(3, 2)$.
]

#only-theory[
  === Cartesian form: eliminate the parameter

  The component equations are $x = -6 + 3t$ and $y = 6 + 2t$. Solve
  the first for $t$ and substitute into the second:
  $
    t = (x + 6)/3
    quad arrow.r.double quad
    y = 6 + 2 dot (x + 6)/3.
  $
  Multiplying by $3$ and tidying,
  $
    3y = 18 + 2x + 12
    quad arrow.r.double quad
    g: 2x - 3y + 30 = 0.
  $

  This is the #vocab("Cartesian form", "Koordinatenform")
  $A x + B y + C = 0$.
]

#only-theory[
  === The same thing with a normal vector

  There is a second route to that equation which uses no elimination
  at all, and it is the one that generalizes to planes.

  A point $P = (x, y)$ lies on $g$ exactly when $arrow(A P)$ points
  along the line — equivalently, when $arrow(A P)$ is *perpendicular*
  to any vector $arrow(n)$ perpendicular to the line. Such an
  $arrow(n)$ is called a #vocab("normal vector", "Normalenvektor").

  In the plane a normal vector is easy: swap the components of the
  direction and flip one sign. From $arrow(v) = vec(3, 2)$ we get
  $arrow(n) = vec(2, -3)$, and indeed
  $vec(2, -3) dot vec(3, 2) = 6 - 6 = 0$.

  Now the condition $arrow(n) dot arrow(A P) = 0$ reads
  $
    vec(2, -3) dot vec(x + 6, y - 6)
    = 2 (x + 6) - 3 (y - 6) = 2x - 3y + 30 = 0,
  $
  which is the same equation as before.

  #fig(
    vplane(
      s-seg(
        from: (-6.5, 3.5),
        to: (0.5, 8),
        color: def-col,
        width: 1.1pt,
        label: [$g$],
        anchor: 0.15,
      ),
      s-pt((-3, 8), label: $A$),
      s-vec(from: (-3, 8), to: (0, 10), label: $arrow(v)$, color: warn-col),
      s-vec(from: (-3, 8), to: (-1, 5), label: $arrow(n)$, color: accent),
      s-arc(
        vertex: (-3, 8),
        from: (0, 10),
        to: (-1, 5),
        r: 13pt,
        right: true,
        color: luma(120),
      ),
      xmin: -7.5,
      xmax: 2.5,
      ymin: 3.5,
      ymax: 11.5,
      unit: 0.55cm,
      grid: false,
      axes: false,
    ),
    caption: [Direction and normal. The coefficients of $x$ and $y$ in
      the Cartesian form *are* the components of $arrow(n)$.],
  )

  That last observation is worth stating on its own, because it will
  be used constantly: in $A x + B y + C = 0$, the vector
  $vec(A, B)$ is a normal vector of the line.
]

#only-theory[
  === Point-slope form and $y = m x + q$

  The slope of the line is rise over run, which for a direction vector
  is
  $ m = v_y / v_x = 2/3. $
  Through the known point $A = (-6, 6)$ this gives the
  #vocab("point-slope form", "Punkt-Steigungs-Form")
  $ y - 6 = 2/3 dot (x + 6), $
  and expanding returns $y = 2/3 x + 10$ — the familiar form, with
  $q = 10$ the $y$#"‑"intercept.

  This route exists only in the plane. In space $v_y slash v_x$ means
  nothing, because there is no single number that captures a direction
  in three dimensions. That is precisely why the parametric form is
  the one that survives into space.
]

#only-theory[
  === Intercept form

  Setting $y = 0$ in $2x - 3y + 30 = 0$ gives $x = -15$; setting
  $x = 0$ gives $y = 10$. Those two numbers are the axis intercepts
  $p$ and $q$, and the line can be written
  $ x/p + y/q = 1, quad "here" quad x/(-15) + y/10 = 1. $

  Check it: substituting $(-15, 0)$ gives $1 + 0 = 1$, and $(0, 10)$
  gives $0 + 1 = 1$. The form requires $p dot q eq.not 0$, so a line
  through the origin cannot be written this way.

  The #vocab("intercept form", "Achsenabschnittsform") is the least
  used of the four, but it is by far the fastest way to *sketch* a
  line: mark the two intercepts and join them.
]

#keybox(title: "Four descriptions of one line in the plane")[
  $ "vector:" quad arrow(r) = vec(-6, 6) + t dot vec(3, 2) $
  $ "Cartesian:" quad 2x - 3y + 30 = 0 $
  $ "point-slope:" quad y - 6 = 2/3 dot (x + 6) $
  $ "intercept:" quad x/(-15) + y/10 = 1 $

  Only the first survives into three dimensions.
]

#look-ahead(preview: [planes])[
  The normal-vector argument above never used the fact that we were in
  the plane. Repeat it in space — fix a point $A$ and a normal
  $arrow(n)$, and collect every $P$ with
  $arrow(n) dot arrow(A P) = 0$ — and you get
  $ A x + B y + C z + D = 0. $

  That is not a line. A single equation in three variables describes a
  *plane*, and a line in space needs the parametric form or two
  equations at once. The pattern is worth naming now: one equation
  always costs you one dimension.
]

#ex(difficulty: 1, time: "10 min", calculator: false)[
  Give *two different* vector equations for each line.

  #auto-parts(
    1,
    [The line through $P = (1, -2, 2)$ and $Q = (3, -1, 2)$.],
    [The line through the origin and $P = (2, -3, 5)$.],
    [The line through $P = (-0.5, 2, -1)$ parallel to the
      $x$#"‑"axis.],
    [The $y$#"‑"axis.],
  )
][
  Many answers are correct; these are the natural ones.

  #auto-parts(
    1,
    [$arrow(r) = vec(1, -2, 2) + t dot vec(2, 1, 0)$ and
      $arrow(r) = vec(3, -1, 2) + t dot vec(-4, -2, 0)$. Note the
      zero third component: the line stays at height $2$.],
    [$arrow(r) = t dot vec(2, -3, 5)$ and
      $arrow(r) = t dot vec(-2, 3, -5)$. No anchor term is needed when
      the line passes through the origin.],
    [$arrow(r) = vec(-0.5, 2, -1) + t dot vec(1, 0, 0)$ and
      $arrow(r) = vec(0, 2, -1) + t dot vec(-1, 0, 0)$.],
    [$arrow(r) = t dot vec(0, 1, 0)$, or $t dot vec(0, -1, 0)$.],
  )

  In (c) and (d) the direction vector is a basis vector, which is what
  "parallel to an axis" means. Any non-zero multiple would do equally
  well.
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  A line has the equation
  $ g: arrow(r) = vec(1, 1, -1) + t dot vec(-1, 0, 3). $

  #auto-parts(
    1,
    [Write down the coordinates of three distinct points on $g$.],
    [Show that $P = (0, 3, 2)$ does not lie on $g$.],
    [Give the vector equation of the line through $P$ parallel to $g$.],
  )
][
  #auto-parts(
    1,
    [Take $t = 0, 1, -1$: the points $(1, 1, -1)$, $(0, 1, 2)$ and
      $(2, 1, -4)$. Every point of $g$ has $y = 1$, since the
      direction has zero $y$#"‑"component.],
    [The first component gives $1 - t = 0$, so $t = 1$. But then
      $y = 1 eq.not 3$, so no single $t$ works and $P$ is not on $g$.

      The $y$#"‑"observation in (a) settles it even faster: every point
      of $g$ has $y = 1$, and $P$ has $y = 3$.],
    [Same direction, new anchor:
      $arrow(r) = vec(0, 3, 2) + t dot vec(-1, 0, 3)$.],
  )
]

#ex(difficulty: 2, time: "14 min", calculator: false)[
  Find all trace points of each line. Where one does not exist, say so
  and say why.

  #auto-parts(
    1,
    [$arrow(r) = vec(1, -3, 3) + t dot vec(1, 1, -3)$],
    [$arrow(r) = vec(2, 5, 9) + t dot vec(0, 5, 3)$],
    [$arrow(r) = vec(-5, 6, -2) + t dot vec(5, 0, 1)$],
  )
][
  #auto-parts(
    1,
    [$S_z = (2, -2, 0)$ at $t = 1$; $S_x = (0, -4, 6)$ at $t = -1$;
      $S_y = (4, 0, -6)$ at $t = 3$.],
    [$S_z = (2, -10, 0)$ at $t = -3$; $S_y = (2, 0, 6)$ at $t = -1$;
      $S_x$ does not exist — the direction has $v_x = 0$, so $x = 2$
      always and the line is parallel to the $y z$#"‑"plane.],
    [$S_z = (5, 6, 0)$ at $t = 2$; $S_x = (0, 6, -1)$ at $t = -1$;
      $S_y$ does not exist — here $v_y = 0$, so $y = 6$ always and the
      line is parallel to the $x z$#"‑"plane.],
  )

  A quick sanity check on any trace point: the coordinate named in the
  subscript must come out as $0$. If it does not, you solved the wrong
  component equation.
]

#ex(difficulty: 3, time: "12 min", calculator: false, hints: (
  "Two points determine the line. You have been given two points — they just happen to be trace points.",
  "Find the direction vector from the two given points, then treat the third trace point as an ordinary trace-point calculation.",
))[
  A line has trace points $S_z = (2, -3, 0)$ and $S_x = (0, -2, 1)$.
  Find its third trace point.
][
  The two given points lie on the line, so
  $ arrow(v) = arrow(S_z S_x) = vec(-2, 1, 1), $
  and using $S_z$ as anchor,
  $ g: arrow(r) = vec(2, -3, 0) + t dot vec(-2, 1, 1). $

  For $S_y$ set $y = 0$: $-3 + t = 0$, so $t = 3$, giving
  $ S_y = (2 - 6, 0, 3) = (-4, 0, 3). $

  *Check.* $S_y$ must have $y = 0$: it does. And the three trace
  points should be collinear, which they are by construction.
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  For the line $g: arrow(r) = vec(5, 4) + t dot vec(1, 2)$ in the
  plane:

  #auto-parts(
    1,
    [find the Cartesian form,],
    [find a normal vector, and verify it is perpendicular to the
      direction,],
    [find the slope and write the equation as $y = m x + q$,],
    [find both axis intercepts and write the intercept form.],
  )
][
  #auto-parts(
    1,
    [$x = 5 + t$ and $y = 4 + 2t$, so $t = x - 5$ and
      $y = 4 + 2(x - 5)$, giving $g: 2x - y - 6 = 0$.],
    [Read the coefficients: $arrow(n) = vec(2, -1)$. Check:
      $vec(2, -1) dot vec(1, 2) = 2 - 2 = 0$.],
    [$m = 2 slash 1 = 2$, so $y = 2x - 6$.],
    [$y = 0$ gives $x = 3$; $x = 0$ gives $y = -6$. So $p = 3$,
      $q = -6$ and the intercept form is
      $ x/3 + y/(-6) = 1. $],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  A line $g$ has slope $m = 5 slash 3$ and passes through
  $A = (3, 10)$.

  #auto-parts(
    1,
    [Find its Cartesian equation.],
    [Find its axis intercepts.],
    [Write down a vector equation for $g$.],
  )
][
  #auto-parts(
    1,
    [$y - 10 = 5/3 dot (x - 3)$, so $y = 5/3 x + 5$, or in Cartesian
      form $5x - 3y + 15 = 0$.],
    [$x = 0$ gives $(0, 5)$; $y = 0$ gives $(-3, 0)$.],
    [A slope of $5 slash 3$ means a direction of $vec(3, 5)$, so
      $arrow(r) = vec(3, 10) + t dot vec(3, 5)$ — or use either
      intercept as the anchor.],
  )
]

#ex(difficulty: 3, time: "12 min", calculator: false)[
  A line passes through $A = (-4, -2, 6)$ and $B = (2, 1, -3)$.

  #auto-parts(
    1,
    [Show that the line passes through the origin.],
    [What are its trace points? Explain the answer in one sentence.],
  )
][
  #auto-parts(
    1,
    [$arrow(A B) = vec(6, 3, -9)$, so
      $g: arrow(r) = vec(-4, -2, 6) + t dot vec(6, 3, -9)$. The first
      component vanishes when $-4 + 6t = 0$, that is $t = 2 slash 3$.
      Testing that value in the others:
      $
        y: -2 + 3 dot 2/3 = 0 checkmark, quad
        z: 6 - 9 dot 2/3 = 0 checkmark.
      $
      All three coordinates vanish together, so the origin lies on
      $g$.],
    [All three trace points are the origin,
      $S_x = S_y = S_z = (0, 0, 0)$. A trace point is where one
      coordinate vanishes, and on this line all three vanish at the
      same moment.],
  )

  Since $arrow(A B) = 3 dot vec(2, 1, -3)$ and
  $arrow(O B) = vec(2, 1, -3)$, the tidiest equation for this line is
  simply $arrow(r) = t dot vec(2, 1, -3)$.
]

#only-high[
  #ex(difficulty: 3, time: "14 min", calculator: false, hints: (
    "Perpendicular to AB is a dot-product condition on the direction vector.",
    "How many vectors in space are perpendicular to a given vector? That tells you how many answers to expect.",
  ))[
    Find a vector equation of a line that passes through the midpoint
    of $A = (2, 3, -1)$ and $B = (4, -3, 7)$ and is perpendicular to
    $A B$.

    How many such lines are there? Describe the set of all of them.
  ][
    The midpoint is
    $ M = ((2 + 4)/2, (3 - 3)/2, (-1 + 7)/2) = (3, 0, 3), $
    and $arrow(A B) = vec(2, -6, 8)$, which simplifies to the
    direction $vec(1, -3, 4)$.

    A direction $arrow(v)$ works precisely when
    $arrow(v) dot vec(1, -3, 4) = 0$, that is
    $v_x - 3 v_y + 4 v_z = 0$. Choosing $v_z = 0$ and $v_y = 1$ gives
    $v_x = 3$, so one answer is
    $ arrow(r) = vec(3, 0, 3) + t dot vec(3, 1, 0). $

    *How many.* Infinitely many. The condition
    $arrow(v) dot arrow(A B) = 0$ is one linear equation in the three
    components of $arrow(v)$, which leaves two degrees of freedom —
    one of which is only the length of $arrow(v)$ and changes nothing.
    So there is a one-parameter family of distinct directions.

    Together, all these lines fill out the *plane* through $M$
    perpendicular to $A B$. Every point of that plane is equidistant
    from $A$ and $B$, so it is the perpendicular bisector plane of the
    segment — the three-dimensional version of the perpendicular
    bisector of a segment in the plane.
  ]
]

#print-hints()
#print-vocab()
