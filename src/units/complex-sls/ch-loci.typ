#import "../../common/preamble.typ": *
#import "../../common/cplane.typ": *
#show: chapter-template.with(title: "Loci")
#let ex = exercise.with(chapter: "Loci")

= Loci and Further Applications

#only-theory[
  The previous chapter took a curve we already had and asked where it
  *goes*. This one turns the question around. Instead of the image of a
  known curve, we describe a set of points by a *condition* they must
  satisfy, and ask what shape that condition carves out of the plane.
  Such a set is a #vocab("locus", "geometrischer Ort") (plural
  *loci*), and we write it in the set-builder notation from the
  Gaussian-plane chapter,
  $
    { z in CC | "condition" },
  $
  read "the set of all $z$ in $CC$ such that the condition holds." We
  already know two loci from that chapter -- the circle
  ${z in CC | |z - z_0| = r}$ and simple half-planes. Here we build the
  full toolkit: lines, rays, ratio circles, and regions where several
  conditions hold at once.

  Throughout, sketch carefully and mark each boundary as *included*
  (solid) or *excluded* (dashed) -- the difference between $<=$ and $<$
  is a real part of the answer, not a detail.
]

#objectives(
  [recognize the line loci $Re(z) = c$, $Im(z) = c$, and the
    perpendicular bisector $|z - z_1| = |z - z_2|$],
  [describe an argument locus $arg(z - z_0) = phi.alt$ as a ray],
  [show algebraically that a ratio condition $|z - A| = k dot |z - B|$
    is a circle, and find its center and radius],
  [sketch a region defined by several conditions at once, with each
    boundary correctly included or excluded],
)

== Lines

#only-theory[
  Three conditions on the parts of $z = a + b dot i$ give straight
  lines directly, and a fourth -- equal distance from two points --
  gives the perpendicular bisector.
]

#theorem(title: "Line loci")[
  For $z = a + b dot i$ and a real constant $c$:
  - ${z in CC | Re(z) = c}$ is the *vertical* line $a = c$.
  - ${z in CC | Im(z) = c}$ is the *horizontal* line $b = c$.
  - ${z in CC | Re(z) + Im(z) = c}$ is the *diagonal* line
    $a + b = c$.
  - ${z in CC | |z - z_1| = |z - z_2|}$ is the
    #vocab("perpendicular bisector", "Mittelsenkrechte") of the
    segment from $z_1$ to $z_2$ -- every point equidistant from the two
    ends.
]

#only-theory[
  The perpendicular bisector is the one worth practicing, because the
  algebra is always the same: write $z = a + b dot i$, square both
  distances (the square roots vanish), and the quadratic terms
  $a^2 + b^2$ cancel, leaving a linear equation -- a line, as promised.
]

#example[
  Find ${z in CC | |z - 3| = |z + i|}$, the perpendicular bisector of
  the segment from $3$ to $-i$.

  With $z = a + b dot i$, square both sides:
  $
    (a - 3)^2 + b^2 = a^2 + (b + 1)^2.
  $
  The $a^2$ and $b^2$ cancel, leaving $-6 a + 9 = 2 b + 1$, so
  $b = -3 a + 4$. (Check: the midpoint $(3 / 2, -1 / 2)$ satisfies it,
  and the slope $-3$ is perpendicular to the segment's slope $1 / 3$.)
]

== Argument Loci

#only-theory[
  Fixing the *distance* from a point gives a circle. Fixing the
  *direction* instead gives a ray. Recall that $arg(z - z_0)$ is the
  angle the arrow from $z_0$ to $z$ makes with the positive real
  direction; holding that angle fixed forces $z$ onto a straight ray.
]

#definition(title: "Argument locus")[
  For a fixed point $z_0$ and angle $phi.alt$,
  $
    {z in CC | arg(z - z_0) = phi.alt}
      = {z_0 + r dot e^(i dot phi.alt) | r > 0}
  $
  is the #vocab("ray", "Strahl") starting at $z_0$ in the direction
  $phi.alt$. The starting point $z_0$ itself is *excluded* -- at
  $z = z_0$ the difference $z - z_0$ is $0$, and $arg(0)$ is undefined.
  Mark it with an open circle.
]

#example[
  ${z in CC | arg(z - 2) = pi / 3}$ is the ray from $2$ (excluded) in
  the direction $60 degree$.
]

#only-theory[
#cplane(
  xmin: -1.0,
  xmax: 5.0,
  ymin: -1.0,
  ymax: 4.0,
  caption: [The locus ${z in CC | arg(z - 2) = pi / 3}$: a ray from
    $2$ (excluded, open circle) at $60 degree$.],
  {
    cp-ray(2, 0, calc.pi / 3, length: 4, open: true)
    cp-angle(2, 0, 0deg, 60deg, radius: 0.7, label: $pi / 3$)
    cp-label(2, -0.4, $2$)
  },
)
]

== Ratio Loci: Apollonius Circles

#only-theory[
  Equal distances from two points gave a line. What about a fixed
  *ratio* of distances -- points twice as far from $A$ as from $B$?
  Remarkably, the answer is a circle (except in the balanced case
  $k = 1$, which is the bisector line). These are the
  #vocab("Apollonius circles", "Apollonius-Kreise"). The method is the
  same as for the bisector -- square, expand -- but now the $a^2 + b^2$
  terms survive, and completing the square reveals the circle.
]

#example[
  Show that ${z in CC | |z - 6| = 2 dot |z + 6 - 9 dot i|}$ is a
  circle, and find its center and radius.

  With $z = a + b dot i$, square both sides (the $2$ becomes a $4$):
  $
    (a - 6)^2 + b^2 = 4 dot ((a + 6)^2 + (b - 9)^2).
  $
  Expanding,
  $
    a^2 - 12 a + 36 + b^2
    &= 4 a^2 + 48 a + 144 + 4 b^2 - 72 b + 324, \
    0 &= 3 a^2 + 60 a + 3 b^2 - 72 b + 432.
  $
  Divide by $3$ and complete the square:
  $
    a^2 + 20 a + b^2 - 24 b + 144 = 0
    quad ==> quad
    (a + 10)^2 + (b - 12)^2 = 100.
  $
  A circle with center $-10 + 12 dot i$ and radius $10$.
]

== Compound Regions

#only-theory[
  Joining conditions with "and" intersects the loci: a point belongs to
  the region only if it satisfies *every* condition. The skill is to
  handle each boundary in turn -- identify its curve, decide included or
  excluded -- and then shade the overlap. An inequality $|z - z_0| <= r$
  fills a *disc*; an inequality on $Re$ or $Im$ fills a *half-plane*; a
  pair of argument bounds fills a *sector*.
]

#example[
  Shade ${z in CC | |z| <= 4 "and" 0 < arg(z) <= pi / 3}$: the part of
  the disc of radius $4$ lying in the sector between $arg = 0$
  (excluded) and $arg = pi / 3$ (included).
]

#only-theory[
#cplane(
  xmin: -1.0,
  xmax: 5.0,
  ymin: -1.0,
  ymax: 4.5,
  caption: [${z in CC | |z| <= 4 "and" 0 < arg(z) <= pi / 3}$: a
    sector of the disc. The lower edge and the tip are excluded
    (dashed / open); the arc and upper edge are included.],
  {
    cp-sector(0, 0, 4, 0deg, 60deg, color: accent)
    cp-ray(0, 0, 0, length: 4, open: true, dashed: true)
    cp-segment((0, 0), (2.0, 3.464), color: accent)
    cp-label(4.2, 0.0, $4$)
  },
)
]

// ── Exercises ────────────────────────────────────────────────

#ex(difficulty: 1, time: "12 min")[
  Sketch each locus, labeling the key points.
  #auto-parts(
    3,
    [${z in CC | Re(z) = 3}$],
    [${z in CC | Im(z) = 4}$],
    [${z in CC | Re(z) + Im(z) = 3}$],
  )
][
  #auto-parts(
    3,
    [Vertical line $a = 3$.
      #cplane-small(xmin: -1, xmax: 4.5, ymin: -3, ymax: 3, {
        cp-segment((3, -3), (3, 3), color: accent)
      })],
    [Horizontal line $b = 4$.
      #cplane-small(xmin: -3, xmax: 3, ymin: -1, ymax: 5, {
        cp-segment((-3, 4), (3, 4), color: accent)
      })],
    [Diagonal line $b = 3 - a$.
      #cplane-small(xmin: -1.5, xmax: 4.5, ymin: -1.5, ymax: 4.5, {
        cp-segment((-1, 4), (4, -1), color: accent)
      })],
  )
]

#ex(difficulty: 1, time: "12 min")[
  Sketch each circle, marking its center.
  #auto-parts(
    3,
    [${z in CC | |z| = 1}$],
    [${z in CC | |z - 3| = 2}$],
    [${z in CC | |z - i| = 1}$],
  )
][
  #auto-parts(
    3,
    [Unit circle, center $0$, radius $1$.
      #cplane-small(xmin: -2, xmax: 2, ymin: -2, ymax: 2, {
        cp-circle(0, 0, 1, center-dot: true)
      })],
    [Center $3$, radius $2$.
      #cplane-small(xmin: -1, xmax: 6, ymin: -3, ymax: 3, {
        cp-circle(3, 0, 2, center-dot: true, label: $3$, anchor: "north")
      })],
    [Center $i$, radius $1$.
      #cplane-small(xmin: -2, xmax: 2, ymin: -1, ymax: 3, {
        cp-circle(0, 1, 1, center-dot: true, label: $i$, anchor: "east")
      })],
  )
]

#ex(difficulty: 2, time: "18 min")[
  Find the equation of each perpendicular bisector, and sketch it.
  #auto-parts(
    2,
    [${z in CC | |z| = |z - 6 dot i|}$],
    [${z in CC | |z - 3| = |z + i|}$],
  )
][
  #auto-parts(
    2,
    [With $z = a + b dot i$: $a^2 + b^2 = a^2 + (b - 6)^2$ gives
      $12 b = 36$, so $b = 3$ -- the horizontal line $Im(z) = 3$, the
      bisector of $[0, 6 dot i]$.
      #cplane-small(xmin: -4, xmax: 4, ymin: -1, ymax: 7, {
        cp-point(0, 0, size: 0.09)
        cp-point(0, 6, label: $6 dot i$, anchor: "east", size: 0.09)
        cp-segment((-4, 3), (4, 3), color: accent)
      })],
    [$(a - 3)^2 + b^2 = a^2 + (b + 1)^2$ gives $-6 a + 9 = 2 b + 1$, so
      $b = -3 a + 4$.
      #cplane-small(xmin: -1, xmax: 4, ymin: -3, ymax: 4, {
        cp-point(3, 0, label: $3$, color: def-col, size: 0.09)
        cp-point(0, -1, label: $-i$, color: def-col, size: 0.09)
        cp-line(through: (0, 4), direction: (1, -3),
          xmin: -1, xmax: 4, ymin: -3, ymax: 4, color: accent)
      })],
  )
]

#ex(difficulty: 3, time: "20 min")[
  For the ratio locus ${z in CC | |z - 6| = 2 dot |z + 6 - 9 dot i|}$:
  show algebraically that it is a circle, state its center and radius,
  and sketch it.
][
  Squaring (the $2$ becomes a $4$) with $z = a + b dot i$:
  $
    (a - 6)^2 + b^2 = 4 dot ((a + 6)^2 + (b - 9)^2),
  $
  which expands to $3 a^2 + 60 a + 3 b^2 - 72 b + 432 = 0$. Dividing by
  $3$ and completing the square,
  $
    (a + 10)^2 + (b - 12)^2 = 100:
  $
  a circle with center $-10 + 12 dot i$ and radius $10$.
  #cplane-small(xmin: -21, xmax: 2, ymin: -1, ymax: 23, {
    cp-circle(-10, 12, 10, shade: true, center-dot: true,
      label: $-10 + 12 dot i$, anchor: "north")
  })
]

#ex(difficulty: 2, time: "15 min")[
  Sketch each argument locus, marking the excluded start point.
  #auto-parts(
    2,
    [${z in CC | arg(z - 2) = pi / 3}$],
    [${z in CC | arg(z + 3 + 2 dot i) = (3 pi) / 4}$],
  )
][
  #auto-parts(
    2,
    [Ray from $2$ (excluded) at $60 degree$.
      #cplane-small(xmin: -1, xmax: 5, ymin: -1, ymax: 4, {
        cp-ray(2, 0, calc.pi / 3, length: 3.5, open: true)
        cp-label(2, -0.5, $2$)
      })],
    [Since $z + 3 + 2 dot i = z - (-3 - 2 dot i)$, this is a ray from
      $-3 - 2 dot i$ (excluded) at $135 degree$.
      #cplane-small(xmin: -7, xmax: 2, ymin: -4, ymax: 4, {
        cp-ray(-3, -2, 3 * calc.pi / 4, length: 4, open: true)
        cp-label(-3, -2.6, $-3 - 2 dot i$)
      })],
  )
]

#ex(difficulty: 3, time: "22 min")[
  Shade the region where all three conditions hold, stating for each
  boundary whether it is included or excluded:
  $
    {z in CC | |z - 4 - 2 dot i| <= 2 "and" |z - 4| < |z - 6|
      "and" 0 <= arg(z - 2 - 2 dot i) <= pi / 4}.
  $
][
  The three conditions are:
  - $|z - 4 - 2 dot i| <= 2$: the closed disc, center $4 + 2 dot i$,
    radius $2$ (boundary *included*).
  - $|z - 4| < |z - 6|$: points closer to $4$ than to $6$, the open
    half-plane $Re(z) < 5$ (boundary $Re(z) = 5$ *excluded*).
  - $0 <= arg(z - 2 - 2 dot i) <= pi / 4$: the closed sector from
    $2 + 2 dot i$ between $0 degree$ and $45 degree$ (boundaries
    *included*).

  The locus is the intersection -- the part of the disc left of
  $Re(z) = 5$ and inside the sector.
  #cplane-small(xmin: -1, xmax: 8, ymin: -1, ymax: 6, {
    cp-region((-1, -1), (5, -1), (5, 6), (-1, 6), color: def-col, opacity: 92%)
    cp-circle(4, 2, 2, shade: true, center-dot: true,
      label: $4 + 2 dot i$, anchor: "north")
    cp-line(through: (5, 0), direction: (0, 1),
      xmin: -1, xmax: 8, ymin: -1, ymax: 6, color: def-col, dashed: true)
    cp-ray(2, 2, 0, length: 5, color: warn-col, open: false)
    cp-ray(2, 2, calc.pi / 4, length: 5, color: warn-col, open: false)
  })
]

#ex(difficulty: 3, time: "18 min")[
  The region $R$ is ${z in CC | |z| <= 5 "and" |z| <= |z - 6 dot i|}$.
  Describe each condition geometrically and shade $R$.
][
  - $|z| <= 5$: the closed disc of radius $5$ about the origin.
  - $|z| <= |z - 6 dot i|$: points at least as close to $0$ as to
    $6 dot i$ -- the side $Im(z) <= 3$ of the bisector $Im(z) = 3$.

  $R$ is the part of the disc on or below the line $Im(z) = 3$.
  #cplane-small(xmin: -6, xmax: 6, ymin: -6, ymax: 6, {
    cp-circle(0, 0, 5, shade: true, center-dot: true)
    cp-segment((-6, 3), (6, 3), color: def-col)
    cp-label(-4.5, 3.6, $Im = 3$, color: def-col)
    cp-label(0, -2, [$R$], color: accent, size: 11pt)
  })
]

== Exam-Style Questions

#only-theory[
  These problems are written in the style of Matura questions: longer,
  multi-part, and deliberately combining ideas from across the whole
  unit -- arithmetic, polar form, roots, and loci together. Read each
  part fully before starting; no single technique will finish one on
  its own.
]

#ex(difficulty: 3, time: "25 min")[
  Let $z = a + b dot i$ with $a, b in RR$.
  #auto-parts(
    1,
    [Show that $z^2 = (a^2 - b^2) + 2 a dot b dot i$.],
    [Find all $z$ with $z^2$ *real* and $|z| = 3$.],
    [Find all $z$ with $z^2$ *purely imaginary* and $|z| = 2$.],
    [Mark all solutions from the two previous parts on one diagram.
      What shape do they form?],
  )
][
  #auto-parts(
    1,
    [$(a + b dot i)^2 = a^2 + 2 a dot b dot i + b^2 dot i^2
      = (a^2 - b^2) + 2 a dot b dot i$. $square$],
    [$z^2$ real means $Im(z^2) = 2 a dot b = 0$, so $a = 0$ or $b = 0$.
      With $a^2 + b^2 = 9$: either gives $plus.minus 3$ on an axis.
      Four solutions: $3, -3, 3 dot i, -3 dot i$.],
    [$z^2$ purely imaginary means $Re(z^2) = a^2 - b^2 = 0$, so
      $b = plus.minus a$. With $a^2 + b^2 = 4$: $2 a^2 = 4$, giving
      $a = plus.minus sqrt(2)$, $b = plus.minus sqrt(2)$. Four
      solutions: $plus.minus sqrt(2) plus.minus sqrt(2) dot i$.],
    [The eight points sit on two circles (radii $2$ and $3$) at the
      axis and diagonal directions -- the vertices of two squares, one
      inscribed in each circle.],
  )
]

#ex(difficulty: 3, time: "25 min", cas: true)[
  Let $w = 1 + sqrt(3) dot i$.
  #auto-parts(
    1,
    [Write $w$ in polar form.],
    [Compute $w^6$ and $w^(-2)$ in Cartesian form.],
    [Find all $z$ with $z^3 = w$, in polar form.],
    [Show the three solutions form an equilateral triangle, and find
      its side length.],
  )
][
  #auto-parts(
    1,
    [$|w| = sqrt(1 + 3) = 2$ and $Arg(w) = pi / 3$, so
      $w = 2 dot e^(i dot pi \/ 3)$.],
    [$w^6 = 2^6 dot e^(i dot 2 pi) = 64$.
      $w^(-2) = 2^(-2) dot e^(-i dot 2 pi \/ 3)
      = 1 / 4 dot (-1 / 2 - sqrt(3) / 2 dot i)
      = -1 / 8 - sqrt(3) / 8 dot i$.],
    [$z_k = 2^(1 \/ 3) dot e^(i dot (pi \/ 3 + 2 pi k) \/ 3)$ for
      $k = 0, 1, 2$: arguments $pi \/ 9$, $7 pi \/ 9$, $13 pi \/ 9$,
      each with modulus $2^(1 \/ 3)$.],
    [All three share modulus $2^(1 \/ 3)$ and their arguments differ by
      $2 pi \/ 3$, so they are equally spaced on a circle of radius
      $2^(1 \/ 3)$ -- an equilateral triangle. Side length
      $= 2 dot 2^(1 \/ 3) dot sin(pi \/ 3) = 2^(1 \/ 3) dot sqrt(3)
      approx 2.18$.],
  )
]

#ex(difficulty: 3, time: "30 min", cas: true)[
  Let $z_1 = 2 + i$ and $z_2 = -1 + 3 dot i$.
  #auto-parts(
    1,
    [Find $z_1 \/ z_2$ in Cartesian form.],
    [Verify $|z_1 dot z_2| = |z_1| dot |z_2|$.],
    [Find and sketch $L_1 = {z in CC | |z - z_1| = |z - z_2|}$.],
    [Find and sketch $L_2 = {z in CC | |z - z_1| = 3}$ on the same
      diagram.],
    [Find the intersection points $L_1 inter L_2$.],
  )
][
  #auto-parts(
    1,
    [$(2 + i) / (-1 + 3 dot i) dot (-1 - 3 dot i) / (-1 - 3 dot i)
      = (1 - 7 dot i) / 10 = 1 / 10 - 7 / 10 dot i$.],
    [$z_1 dot z_2 = (2 + i) dot (-1 + 3 dot i) = -5 + 5 dot i$, so
      $|z_1 dot z_2| = sqrt(50) = 5 sqrt(2)$; and
      $|z_1| dot |z_2| = sqrt(5) dot sqrt(10) = sqrt(50)$. Equal.
      $square$],
    [Perpendicular bisector of $[z_1, z_2]$. With $z = a + b dot i$,
      $(a - 2)^2 + (b - 1)^2 = (a + 1)^2 + (b - 3)^2$ gives
      $-6 a + 4 b = 5$, i.e. $b = 3 / 2 a + 5 / 4$.],
    [Circle with center $z_1 = 2 + i$ and radius $3$.
      #cplane-small(xmin: -2, xmax: 6, ymin: -3, ymax: 6, {
        cp-circle(2, 1, 3, dashed: false, center-dot: true, color: ex-col)
        cp-line(through: (0, 1.25), direction: (2, 3),
          xmin: -2, xmax: 6, ymin: -3, ymax: 6, color: accent)
      })],
    [Substituting $b = 3 / 2 a + 5 / 4$ into $(a - 2)^2 + (b - 1)^2 = 9$
      and solving (with a CAS) gives $a approx -0.83$ or $a approx 1.83$,
      hence $z approx -0.83 + 0.00 dot i$ and
      $z approx 1.83 + 4.00 dot i$.],
  )
]

#ex(difficulty: 3, time: "30 min", cas: true)[
  Consider $z^2 + (2 - 4 dot i) dot z + c = 0$ with $c in RR$.
  #auto-parts(
    1,
    [Explain why the conjugate-roots theorem does *not* apply here.],
    [Find the value of $c$ for which the equation has a real root, and
      find that root.],
    [For $c = 5$, find both roots (you may use a CAS for the surds).],
    [For $c = 5$, verify Vieta: $z_1 + z_2 = -(2 - 4 dot i)$ and
      $z_1 dot z_2 = 5$.],
  )
][
  #auto-parts(
    1,
    [The conjugate-roots theorem needs *real* coefficients, but the
      coefficient of $z$ is $2 - 4 dot i in.not RR$. So a root's
      conjugate need not be a root.],
    [A real root $z = x$ needs the imaginary part of
      $x^2 + (2 - 4 dot i) x + c$ to vanish: $-4 x = 0$, so $x = 0$;
      then the real part gives $c = 0$. So $c = 0$, real root $z = 0$.],
    [For $c = 5$ the discriminant is $(2 - 4 dot i)^2 - 20 = -32 - 16 dot i$.
      A square root of it is about $1.37 - 5.82 dot i$, so
      $z_(1,2) = (-(2 - 4 dot i) plus.minus (1.37 - 5.82 dot i)) \/ 2$,
      giving $z_1 approx -0.31 - 0.91 dot i$ and
      $z_2 approx -1.69 + 4.91 dot i$.],
    [$z_1 + z_2 approx -2 + 4 dot i = -(2 - 4 dot i)$ ✓, and
      $z_1 dot z_2 approx 5 = c$ ✓ (leading coefficient $1$).],
  )
]

#ex(difficulty: 3, time: "25 min")[
  Let $omega = e^(2 pi dot i \/ n)$.
  #auto-parts(
    1,
    [For $n = 5$, list the five fifth roots of unity and plot them.],
    [Show that $1 + omega + omega^2 + dots.c + omega^(n - 1) = 0$ for
      every $n >= 2$.],
    [With $omega = e^(2 pi dot i \/ 5)$, evaluate
      $S = sum_(k=0)^(4) omega^(2 k)$ without a calculator, and explain.],
    [Find the exact side length of the regular pentagon formed by the
      fifth roots of unity.],
  )
][
  #auto-parts(
    1,
    [$z_k = e^(2 pi dot i dot k \/ 5)$, $k = 0, dots, 4$: $z_0 = 1$ and
      four more equally spaced, at arguments $72 degree$, $144 degree$,
      $216 degree$, $288 degree$.
      #cplane-small(xmin: -1.6, xmax: 1.6, ymin: -1.6, ymax: 1.6, {
        cp-unit-circle()
        cp-point(1, 0, size: 0.07)
        cp-point(0.309, 0.951, size: 0.07)
        cp-point(-0.809, 0.588, size: 0.07)
        cp-point(-0.809, -0.588, size: 0.07)
        cp-point(0.309, -0.951, size: 0.07)
      })],
    [Geometric series with ratio $omega eq.not 1$:
      $sum_(k=0)^(n-1) omega^k = (omega^n - 1) \/ (omega - 1)$, and
      $omega^n = e^(2 pi dot i) = 1$, so the sum is $0$. $square$],
    [$omega^2 = e^(4 pi dot i \/ 5)$ is itself a primitive fifth root
      of unity (as $gcd(2, 5) = 1$), so
      $S = sum_(k=0)^4 (omega^2)^k = 0$ by the previous part.],
    [Side $= |z_1 - z_0| = |e^(2 pi dot i \/ 5) - 1|
      = 2 sin(pi \/ 5) = 1 / 2 sqrt(10 - 2 sqrt(5)) approx 1.176$.],
  )
]

== Extra Bits -- Logarithmic Spirals

#only-theory[
  One last curve, to close the unit where the transformations chapter
  left off. The complex-valued function
  $
    z(t) = e^((a + i) dot t), quad a in RR, quad t in RR,
  $
  is a #vocab("logarithmic spiral", "logarithmische Spirale"). Split
  the exponent: $z(t) = e^(a dot t) dot e^(i dot t)$, so the modulus
  $|z(t)| = e^(a dot t)$ grows or shrinks *exponentially* while the
  argument $t$ turns *steadily*. Growing radius plus steady rotation is
  exactly a spiral. Setting $a = 0$ recovers the unit circle; $a > 0$
  spirals outward, $a < 0$ inward. Shells, galaxies, and the florets of
  a sunflower all approximate this one complex function.
]

#only-theory[
#cplane(
  xmin: -3.5,
  xmax: 3.5,
  ymin: -3.5,
  ymax: 3.5,
  show-ticks: false,
  caption: [A logarithmic spiral $z(t) = e^((0.15 + i) dot t)$ -- steady
    rotation with exponential growth.],
  {
    cp-complex-curve(
      t => {
        let r = calc.exp(0.15 * t)
        (r * calc.cos(t), r * calc.sin(t))
      },
      domain: (-12, 12),
      samples: 400,
      color: accent,
    )
  },
)
]

#print-hints()
#print-vocab()
