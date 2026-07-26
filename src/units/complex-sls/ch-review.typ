#import "../../common/preamble.typ": *
#import "../../common/cplane.typ": *
#show: chapter-template.with(title: "Review")
#let ex = exercise.with(chapter: "Review")

= Review and Exam Preparation

#only-theory[
  This chapter is a place to consolidate, not to learn something new.
  The most useful way to work through it is *backwards*: start with the
  self-check, find out what you cannot yet do, and only then reread the
  relevant summary and the chapter behind it. Reading a summary you
  already understand feels productive and teaches nothing; wrestling
  with the one problem you get stuck on teaches almost everything. Spend
  your time where you are stuck.
]

== The Unit in One Page

#only-theory[
  The whole unit is one long answer to a single question: *what happens
  if we allow $sqrt(-1)$ to exist?* Each chapter is one consequence.

  We *invented* $i$ to solve $x^2 = -1$, and checked that ordinary
  algebra survives the addition (Introduction). That algebra --
  add, multiply, conjugate, divide -- turned out to need exactly one new
  rule, $i^2 = -1$ (Arithmetic). With it, *every* polynomial equation
  became solvable, and the non-real roots of real polynomials paired up
  as conjugates (Equations). Drawing complex numbers as points gave them
  a *geometry*: a distance $|z|$ and a direction $Arg(z)$ (Gaussian
  Plane). Writing them by distance and direction exposed the deepest
  fact of all -- *multiplication is rotation and scaling* -- and with it
  De Moivre's theorem, the roots of unity, and Euler's formula (Polar
  Form). Because multiplication moves the plane, complex arithmetic
  *transforms whole curves* with a single "multiply and add" (Transformations).
  And reading conditions on $z$ backwards *carves curves out of the
  plane* -- lines, circles, rays, regions (Loci).

  One invented symbol; a closed number system, a geometry, and a
  transformation calculus fall out. That arc is the exam: almost every
  question lives at the seam between two of these chapters.
]

== Key Results at a Glance

#only-theory[
  === Forms of a complex number

  For $z = a + b dot i$ with $a, b in RR$:
  $
    overline(z) = a - b dot i, quad
    |z| = sqrt(a^2 + b^2), quad
    z dot overline(z) = a^2 + b^2 = |z|^2, quad
    Arg(z) = "angle from the positive real axis" .
  $
  Polar (exponential) form, with $r = |z|$ and $phi.alt = Arg(z)$:
  $
    z = r dot (cos(phi.alt) + i sin(phi.alt)) = r dot e^(i dot phi.alt),
    quad
    a = r cos(phi.alt), quad b = r sin(phi.alt).
  $

  === Arithmetic and the conjugate

  Multiply by expanding and using $i^2 = -1$; divide by multiplying
  through by the conjugate of the denominator. The conjugate respects
  everything:
  $
    overline(z + w) = overline(z) + overline(w), quad
    overline(z dot w) = overline(z) dot overline(w), quad
    z + overline(z) = 2 Re(z), quad z - overline(z) = 2 Im(z) dot i.
  $

  === Equations

  A real quadratic with $Delta = b^2 - 4 a dot c < 0$ has the conjugate
  pair $x = (-b plus.minus sqrt(|Delta|) dot i) \/ (2 a)$. Every
  degree-$n$ polynomial has exactly $n$ roots in $CC$ (with
  multiplicity); if its coefficients are *real*, the non-real roots come
  in conjugate pairs. From one root, reconstruct via
  $x^2 - ("sum") x + ("product")$.

  === Polar form, powers, and roots

  Multiply moduli and add arguments; divide moduli and subtract:
  $
    |z_1 dot z_2| = |z_1| dot |z_2|, quad
    Arg(z_1 dot z_2) = Arg(z_1) + Arg(z_2).
  $
  De Moivre and the $n$-th roots of $w = rho dot e^(i dot theta)$:
  $
    (r dot e^(i dot phi.alt))^n = r^n dot e^(i dot n dot phi.alt), quad
    z_k = rho^(1 \/ n) dot e^(i dot (theta + 2 pi dot k) \/ n),
    quad k = 0, dots, n - 1.
  $
  The $n$ roots are a regular $n$-gon; the roots of unity ($w = 1$) sum
  to $0$. Euler: $e^(i dot phi.alt) = cos(phi.alt) + i sin(phi.alt)$,
  and $e^(i dot pi) + 1 = 0$.

  === Transformations of a curve $z(t) = x(t) + i dot y(t)$

  $
    "translate by " c: & quad w(t) = z(t) + c, \
    "rotate/scale about " 0: & quad w(t) = r dot e^(i dot alpha) dot z(t), \
    "rotate about " z_0: & quad w(t) = e^(i dot alpha) dot (z(t) - z_0) + z_0.
  $
  Every one has the form $w(t) = a dot z(t) + b$.

  === Loci ${z in CC | dots}$

  $
    |z - z_0| = r & quad "circle, center " z_0", radius " r, \
    |z - z_1| = |z - z_2| & quad "perpendicular bisector of " [z_1, z_2], \
    arg(z - z_0) = phi.alt & quad "ray from " z_0 " (excluded) at " phi.alt, \
    |z - A| = k dot |z - B| & quad "Apollonius circle " (k eq.not 1).
  $
  Combine conditions with "and" by intersecting; mark each boundary
  included (solid) or excluded (dashed).
]

== Self-Check

#only-theory[
  Cover the right-hand column. For each skill, can you do it *cold*,
  without notes? If not, that chapter is where your revision time
  should go.

  #data-table(
    columns: (1fr, auto),
    row-height: auto,
    [Can you\...], [Review],
    [add, multiply, and divide in Cartesian form, and form
      $overline(z)$], [Arithmetic],
    [solve a quadratic with negative discriminant, and build a real
      polynomial from one complex root], [Equations],
    [solve an equation in $z$ and $overline(z)$ by comparing real and
      imaginary parts], [Equations],
    [convert between Cartesian and polar form, getting the quadrant of
      $Arg(z)$ right], [Gaussian Plane, Polar Form],
    [compute a high power with De Moivre, and find all $n$-th roots of a
      number], [Polar Form],
    [rotate a curve about a given point and read off the image in
      Cartesian form], [Transformations],
    [identify and sketch a locus -- line, circle, ray, Apollonius
      circle, region], [Loci],
  )
]

== Common Traps

#warning[
  These are the mistakes that cost marks even when the method is right.
  - *$sqrt(a) dot sqrt(b) = sqrt(a dot b)$ fails for negatives.* Never
    manipulate $sqrt(-1)$; use $i^2 = -1$.
  - *The argument depends on the quadrant.* $Arg(-1 - i)$ is
    $-(3 pi) \/ 4$, not $pi \/ 4$ -- always place $z$ before reading the
    angle.
  - *Conjugate pairs need real coefficients.* If any coefficient is
    non-real, a root's conjugate need not be a root.
  - *The imaginary part is a real number.* $Im(3 + 5 dot i) = 5$, not
    $5 dot i$.
  - *A ray excludes its start point.* $arg(z - z_0) = phi.alt$ never
    includes $z_0$ -- open circle.
  - *$<=$ versus $<$ is part of the answer.* State every locus boundary
    as included (solid) or excluded (dashed).
  - *Radians, not degrees, inside $e^(i dot phi.alt)$.* Keep angles in
    radians unless a diagram is labeled in degrees.
]

== Mock Exam

#only-theory[
  A full paper in the Matura style. Work under time pressure -- about
  ninety minutes -- with only the tools your exam allows, then check
  against the solutions. Marks are shown in brackets.
]

#ex(difficulty: 2, time: "12 min")[
  Let $z = 3 - 2 dot i$ and $w = -1 + 4 dot i$.
  #auto-parts(
    1,
    [Find $z + w$, $z dot w$, and $z \/ w$ in Cartesian form. *[4]*],
    [Verify that $|z dot w| = |z| dot |w|$. *[2]*],
  )
][
  #auto-parts(
    1,
    [$z + w = 2 + 2 dot i$; $z dot w = 5 + 14 dot i$;
      $z \/ w = -11 / 17 - 10 / 17 dot i$ (multiply by
      $overline(w) = -1 - 4 dot i$).],
    [$|z dot w| = |5 + 14 dot i| = sqrt(221)$, and
      $|z| dot |w| = sqrt(13) dot sqrt(17) = sqrt(221)$. Equal. $square$],
  )
]

#ex(difficulty: 2, time: "16 min")[
  #auto-parts(
    1,
    [Solve $z^2 + 2 z + 5 = 0$. *[2]*],
    [A polynomial with real coefficients has $1 - 2 dot i$ as a root.
      Write down the monic real quadratic with this root. *[2]*],
    [Find all $z in CC$ with $z^2 = -8 + 6 dot i$, by comparing real and
      imaginary parts. *[4]*],
  )
][
  #auto-parts(
    1,
    [$z = -1 plus.minus 2 dot i$.],
    [The other root is $1 + 2 dot i$; sum $2$, product $5$, so
      $z^2 - 2 z + 5$.],
    [Let $z = a + b dot i$: $a^2 - b^2 = -8$ and $2 a dot b = 6$, so
      $a dot b = 3$. Then $a = 3 \/ b$ gives $b^4 - 8 b^2 - 9 = 0$,
      i.e. $(b^2 - 9) dot (b^2 + 1) = 0$, so $b = plus.minus 3$. Since
      $a dot b = 3 > 0$, $a$ and $b$ share a sign:
      $z = 1 + 3 dot i$ or $z = -1 - 3 dot i$.],
  )
]

#ex(difficulty: 3, time: "18 min")[
  Let $z = -sqrt(3) + i$.
  #auto-parts(
    1,
    [Write $z$ in polar form. *[2]*],
    [Compute $z^6$, giving the answer in Cartesian form. *[3]*],
    [Find all solutions of $w^3 = z$, in polar form. *[3]*],
  )
][
  #auto-parts(
    1,
    [$|z| = 2$ and, since $z$ is in the second quadrant,
      $Arg(z) = (5 pi) / 6$. So $z = 2 dot e^(i dot 5 pi \/ 6)$.],
    [$z^6 = 2^6 dot e^(i dot 5 pi) = 64 dot e^(i dot pi) = -64$.],
    [$w_k = 2^(1 \/ 3) dot e^(i dot (5 pi \/ 6 + 2 pi k) \/ 3)$ for
      $k = 0, 1, 2$: arguments $(5 pi) / 18$, $(17 pi) / 18$,
      $(29 pi) / 18$, each with modulus $2^(1 \/ 3)$.],
  )
]

#ex(difficulty: 3, time: "16 min")[
  The graph of $y = x^2$ is rotated by $90 degree$ about the point
  $z_0 = 2 dot i$.
  #auto-parts(
    1,
    [Write the original curve and the rotated curve as complex-valued
      functions. *[4]*],
    [Find the image of the vertex. *[2]*],
  )
][
  #auto-parts(
    1,
    [Original $z(t) = t + i dot t^2$. With $e^(i dot pi \/ 2) = i$,
      $w(t) = i dot (z(t) - 2 dot i) + 2 dot i
      = (2 - t^2) + i dot (t + 2)$.],
    [At $t = 0$: $w(0) = 2 + 2 dot i$, so the vertex maps to
      $(2, 2)$.],
  )
]

#ex(difficulty: 3, time: "18 min")[
  #auto-parts(
    1,
    [Find the Cartesian equation of the perpendicular bisector
      ${z in CC | |z - 2| = |z - 4 dot i|}$. *[3]*],
    [Show that ${z in CC | |z - 4| = 2 dot |z - 1|}$ is a circle, and
      state its center and radius. *[4]*],
  )
][
  #auto-parts(
    1,
    [With $z = a + b dot i$: $(a - 2)^2 + b^2 = a^2 + (b - 4)^2$ gives
      $-4 a + 4 = -8 b + 16$, so $b = 1 / 2 a + 3 / 2$.],
    [Squaring, $(a - 4)^2 + b^2 = 4 dot ((a - 1)^2 + b^2)$ expands to
      $3 a^2 + 3 b^2 - 12 = 0$, i.e. $a^2 + b^2 = 4$: the circle with
      center $0$ and radius $2$.],
  )
]

#ex(difficulty: 3, time: "18 min")[
  #auto-parts(
    1,
    [Find all three cube roots of $8 dot i$, in Cartesian form. *[4]*],
    [The three roots are the vertices of a triangle. Show it is
      equilateral and find its area. *[3]*],
  )
][
  #auto-parts(
    1,
    [$8 dot i = 8 dot e^(i dot pi \/ 2)$, so
      $z_k = 2 dot e^(i dot (pi \/ 2 + 2 pi k) \/ 3)$:
      $z_0 = 2 dot e^(i dot pi \/ 6) = sqrt(3) + i$,
      $z_1 = 2 dot e^(i dot 5 pi \/ 6) = -sqrt(3) + i$,
      $z_2 = 2 dot e^(i dot 3 pi \/ 2) = -2 dot i$.],
    [All three have modulus $2$ and arguments $120 degree$ apart, so
      they are equally spaced on the circle of radius $2$ -- an
      equilateral triangle. Side $= 2 dot 2 sin(60 degree) = 2 sqrt(3)$,
      so area $= sqrt(3) / 4 dot (2 sqrt(3))^2 = 3 sqrt(3) approx 5.20$.],
  )
]

#only-theory[
#cplane(
  xmin: -3.0,
  xmax: 3.0,
  ymin: -3.0,
  ymax: 2.0,
  show-ticks: false,
  caption: [Mock exam, final question: the cube roots of $8 dot i$
    form an equilateral triangle on the circle of radius $2$.],
  {
    cp-unit-circle(r: 2)
    cp-segment((1.732, 1), (-1.732, 1), color: accent)
    cp-segment((-1.732, 1), (0, -2), color: accent)
    cp-segment((0, -2), (1.732, 1), color: accent)
    cp-point(1.732, 1, label: $z_0$, anchor: "south-west")
    cp-point(-1.732, 1, label: $z_1$, anchor: "south-east")
    cp-point(0, -2, label: $z_2$, anchor: "north")
  },
)
]

