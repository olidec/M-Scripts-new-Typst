#import "../../common/preamble.typ": *
#import "../../common/cplane.typ": *
#show: chapter-template.with(title: "Polar Form")
#let ex = exercise.with(chapter: "Polar Form")

= Polar Form and Euler's Formula

#only-theory[
  In the Gaussian-plane chapter we split a complex number into two
  numbers that locate it: its distance from the origin, $r = |z|$, and
  its direction, $phi.alt = Arg(z)$. We noted then that this pair
  $(r, phi.alt)$ pins down $z$ just as well as the Cartesian pair
  $(a, b)$ does -- and hinted that, for multiplication, it does the job
  far better.

  This chapter cashes that in. Written by distance and direction, a
  complex number reveals that *multiplication is a rotation and a
  scaling of the plane* -- the geometric fact that the Cartesian form
  hides completely. Along the way we meet De Moivre's theorem, get
  trigonometric identities almost for free, solve $z^n = w$ in one
  stroke, and arrive at the most celebrated equation in mathematics.
]

#objectives(
  [convert a complex number between Cartesian, trigonometric, and
    exponential (polar) form],
  [multiply and divide in polar form, and describe multiplication by a
    fixed number as a rotation and scaling of the plane],
  [state and apply De Moivre's theorem to compute integer powers],
  [use De Moivre's theorem to derive trigonometric identities],
  [find all $n$ complex $n$-th roots of a number and describe them as a
    regular $n$-gon on a circle],
  [state Euler's formula and Euler's identity],
)

== Trigonometric Form

#only-theory[
  Take a complex number $z$ with modulus $r = |z|$ and argument
  $phi.alt$. Drop the perpendiculars to the axes and read off a
  right triangle: the horizontal leg is $a$, the vertical leg is $b$,
  the hypotenuse is $r$, and the angle at the origin is $phi.alt$.
  Basic trigonometry gives the two legs.
]

#only-theory[
  #cplane(
    xmin: -1.5,
    xmax: 4.5,
    ymin: -1.5,
    ymax: 3.5,
    caption: [Modulus $r$ and argument $phi.alt$ recover the Cartesian
      parts through $a = r cos(phi.alt)$, $b = r sin(phi.alt)$.],
    {
      cp-vector(3, 2, color: accent)
      cp-segment((3, 0), (3, 2), color: luma(150), dashed: true)
      cp-segment((0, 2), (3, 2), color: luma(150), dashed: true)
      cp-angle(0, 0, 0deg, 33.69deg, radius: 0.85, label: $phi.alt$)
      cp-point(3, 2, label: $z$, anchor: "south-west")
      cp-label(1.35, 1.4, $r$, color: accent, size: 10pt)
      cp-label(1.5, -0.4, $a$)
      cp-label(-0.4, 1.0, $b$)
    },
  )
]

#keybox(title: "Trigonometric form")[
  Every complex number can be written using its modulus and argument as
  $
    z = r cos(phi.alt) + r sin(phi.alt) dot i
    = r dot (cos(phi.alt) + i sin(phi.alt)),
  $
  where $r = |z| >= 0$ and $phi.alt = Arg(z)$. This is the
  #vocab("trigonometric form", "trigonometrische Form") of $z$.
]

#only-theory[
  Converting is now a two-way street. To go from Cartesian to
  trigonometric form, compute $r = sqrt(a^2 + b^2)$ and read
  $phi.alt = Arg(z)$ off a sketch (with the quadrant care from the
  previous chapter). To go back, expand: $a = r cos(phi.alt)$ and
  $b = r sin(phi.alt)$.
]

#example[
  *Cartesian $->$ trigonometric.* Take $z = -1 - i$. Then
  $r = sqrt(2)$, and since $z$ sits in the third quadrant on the
  diagonal, $Arg(z) = -(3 pi) / 4$. So
  $z = sqrt(2) dot (cos(-(3 pi) / 4) + i sin(-(3 pi) / 4))$.

  *Trigonometric $->$ Cartesian.* Take
  $z = 2 dot (cos((2 pi) / 3) + i sin((2 pi) / 3))$. Then
  $a = 2 cos((2 pi) / 3) = -1$ and $b = 2 sin((2 pi) / 3) = sqrt(3)$,
  so $z = -1 + sqrt(3) dot i$.
]

== Multiplication Is Rotation and Scaling

#only-theory[
  Here is the payoff. Multiply two numbers in trigonometric form and
  watch what the arguments do. With
  $z_1 = r_1 dot (cos(phi.alt_1) + i sin(phi.alt_1))$ and
  $z_2 = r_2 dot (cos(phi.alt_2) + i sin(phi.alt_2))$, expand the
  product and collect real and imaginary parts:
  $
    z_1 dot z_2 = r_1 dot r_2 dot [
      (cos(phi.alt_1) cos(phi.alt_2) - sin(phi.alt_1) sin(phi.alt_2))
      + i dot (sin(phi.alt_1) cos(phi.alt_2) + cos(phi.alt_1) sin(phi.alt_2))
    ].
  $
  The two bracketed expressions are exactly the right-hand sides of the
  *addition formulas* from trigonometry. They collapse:
  $
    z_1 dot z_2 = r_1 dot r_2 dot
    (cos(phi.alt_1 + phi.alt_2) + i sin(phi.alt_1 + phi.alt_2)).
  $
]

#keybox(title: "Multiply moduli, add arguments")[
  For $z_1, z_2 eq.not 0$,
  $
    |z_1 dot z_2| = |z_1| dot |z_2|, quad
    Arg(z_1 dot z_2) = Arg(z_1) + Arg(z_2),
  $
  and for division,
  $
    abs(z_1 / z_2) = (|z_1|) / (|z_2|), quad
    Arg(z_1 / z_2) = Arg(z_1) - Arg(z_2).
  $
  To multiply: *multiply the moduli and add the arguments*. To divide:
  *divide the moduli and subtract the arguments*. (Arguments may need a
  full turn added or removed to land back in $(-pi, pi]$.)
]

#only-theory[
  Read geometrically, this is a strong and beautiful statement.
  Multiplying $z_1$ by $z_2$ does two independent things at once: it
  *scales* $z_1$ by the factor $r_2 = |z_2|$, and it *rotates* $z_1$
  through the angle $phi.alt_2 = Arg(z_2)$. Multiplication in $CC$ is
  not a formula to be pushed through -- it is a motion of the plane.
]

#only-theory[
  #cplane(
    xmin: -0.5,
    xmax: 3.5,
    ymin: -0.5,
    ymax: 3.5,
    length: 0.9cm,
    caption: [Multiplication rotates and scales: the arrow for
      $z_1 dot z_2$ has length $|z_1| dot |z_2|$ and angle
      $Arg(z_1) + Arg(z_2)$.],
    {
      cp-vector(2.30, 0.98, color: accent, label: $z_1$, anchor: "north")
      cp-vector(1.07, 0.90, color: def-col, label: $z_2$, anchor: "east")
      cp-vector(
        1.59,
        3.12,
        color: warn-col,
        label: $z_1 dot z_2$,
        anchor: "south-west",
      )
      cp-angle(0, 0, 0deg, 23deg, radius: 0.55, color: accent)
      cp-angle(0, 0, 0deg, 40deg, radius: 0.8, color: def-col)
      cp-angle(0, 0, 0deg, 63deg, radius: 1.05, color: warn-col)
    },
  )
]

#look-back(
  title: "The quarter turn, at last",
)[
  Back in the introduction the powers of $i$ ran in a cycle of four --
  $1, i, -1, -i$ -- and I claimed, without proof, that multiplying by
  $i$ is a quarter turn. Now it is a one-line fact. The number $i$ has
  modulus $1$ and argument $pi / 2$, so multiplying by $i$ scales by
  $1$ (no scaling) and rotates by $pi / 2$ -- a quarter turn,
  counterclockwise. Four of them add to $2 pi$, a full circle, which is
  why $i^4 = 1$ and the cycle closes. The picture you were asked to
  hold in your head was exactly right.
]

#look-ahead(
  title: "A whole chapter hiding in one operation",
  preview: [geometric transformations],
)[
  If multiplying by a fixed $c = r dot (cos alpha + i sin alpha)$
  rotates every point by $alpha$ and scales it by $r$, then the single
  map $z |-> c dot z$ is a *rotation-and-scaling of the entire plane*
  about the origin. Add a constant and you can also *slide* the plane.
  These maps -- built entirely from complex arithmetic -- are the
  subject of the transformations chapter. Multiplication is not just an
  operation; it is a geometry.
]

== Euler's Formula

#only-theory[
  The trigonometric form is doing something suspicious. "Multiply the
  moduli, *add* the arguments" is precisely how *exponents* behave:
  $x^(m) dot x^(n) = x^(m + n)$ adds the
  exponents. If $cos(phi.alt) + i sin(phi.alt)$ were some base raised
  to the power $phi.alt$, the whole multiplication rule would be
  nothing but the law of exponents. It is -- and the base is $e$.
]

#theorem(title: "Euler's formula")[
  For every real number $phi.alt$,
  $
    e^(i dot phi.alt) = cos(phi.alt) + i sin(phi.alt).
  $
]

#only-theory[
  A full proof needs the Taylor series of $e^x$, $cos$ and $sin$, which
  belong to next year's analysis. But the plausibility is worth seeing:
  substitute $i dot phi.alt$ into the series for $e^x$, use the powers of
  $i$ to sort the terms, and the real terms assemble the cosine series
  while the imaginary terms assemble the sine series:
  $
    e^(i dot phi.alt) & = 1 + i dot phi.alt - (phi.alt^2) / 2! - i dot (phi.alt^3) / 3!
                        + (phi.alt^4) / 4! + i dot (phi.alt^5) / 5! - dots.c \
                      & = underbrace(
                          (1 - (phi.alt^2) / 2! + (phi.alt^4) / 4! - dots.c),
                          cos(phi.alt),
                        )
                        + i dot underbrace(
                          (phi.alt - (phi.alt^3) / 3! + (phi.alt^5) / 5! - dots.c),
                          sin(phi.alt),
                        ).
  $
]

#definition(title: "Polar (exponential) form")[
  Using Euler's formula, the trigonometric form compresses to the
  #vocab("polar form", "Polarform") (or exponential form):
  $
    z = r dot e^(i dot phi.alt), quad r = |z|, quad phi.alt = Arg(z).
  $
]

#remark[
  In this notation the multiplication rule is immediate and needs no
  addition formulas at all:
  $
    z_1 dot z_2 = r_1 dot e^(i dot phi.alt_1) dot r_2 dot e^(i dot phi.alt_2)
    = r_1 dot r_2 dot e^(i dot (phi.alt_1 + phi.alt_2)).
  $
  The moduli multiply and the arguments add because the exponents add.
  The addition formulas of trigonometry and the law of exponents turn
  out to be the *same fact*, seen from two sides.
]

// ─────────────────────────────────────────────────────────────
//  OPTIONAL chapter ornament (xkcd #179, "e to the pi times i"),
//  CC BY-NC 2.5 — attribution required, classroom use fine. Drop the
//  PNG in images/ and uncomment. Left out of the source so the chapter
//  compiles with no external asset.
//
//  #fig(
//    image("images/e_to_the_pi_times_i.png", width: 55%),
//    caption: [xkcd #179, by Randall Munroe (CC BY-NC 2.5).],
//  )
// ─────────────────────────────────────────────────────────────

#only-theory[
  Setting $phi.alt = pi$ in Euler's formula gives $e^(i dot pi) = -1$,
  which rearranges into the single most famous equation in mathematics.
]

#theorem(title: "Euler's identity")[
  $
    e^(i dot pi) + 1 = 0.
  $
  One equation ties together the five constants $e$, $i$, $pi$, $1$,
  $0$ and the operations of addition, multiplication and
  exponentiation -- each of which entered this course from a completely
  different direction.
]

== De Moivre's Theorem

#only-theory[
  "Multiply moduli, add arguments" applied to a number times *itself*,
  $n$ times over, multiplies the modulus by itself $n$ times and adds
  the argument to itself $n$ times. That is the whole content of De
  Moivre's theorem -- and in exponential form it is just the power law
  $(e^(i dot phi.alt))^n = e^(i dot n dot phi.alt)$.
]

#theorem(title: "De Moivre's theorem")[
  For any $r > 0$, any real $phi.alt$, and any integer $n$,
  $
    (r dot e^(i dot phi.alt))^n = r^n dot e^(i dot n dot phi.alt),
  $
  or, written out,
  $
    (r dot (cos(phi.alt) + i sin(phi.alt)))^n
    = r^n dot (cos(n dot phi.alt) + i sin(n dot phi.alt)).
  $
]

#look-back(
  title: "The hundredth power, for free",
)[
  In the arithmetic chapter I warned that $(1 + i)^(100)$ was hopeless
  by hand. It no longer is. Write $1 + i = sqrt(2) dot e^(i dot pi \/ 4)$;
  then De Moivre gives
  $(1 + i)^(100) = (sqrt(2))^(100) dot e^(i dot 100 pi \/ 4)
  = 2^(50) dot e^(i dot 25 pi)$, and since $25 pi$ is an odd multiple
  of $pi$, this is $2^(50) dot (-1) = -2^(50)$. A hundredth power in two
  lines.
]

#example[
  Compute $(1 + i)^8$.

  Convert: $|1 + i| = sqrt(2)$ and $Arg(1 + i) = pi / 4$, so
  $1 + i = sqrt(2) dot e^(i dot pi \/ 4)$. Then
  $
    (1 + i)^8 = (sqrt(2))^8 dot e^(i dot 8 pi \/ 4)
    = 16 dot e^(i dot 2 pi) = 16 dot 1 = 16.
  $
]

== Trigonometric Identities for Free

#only-theory[
  De Moivre's theorem is also an *identity machine*. Take $n = 2$ and
  compare two ways of expanding the same quantity. On one side, De
  Moivre gives
  $
    (cos(phi.alt) + i sin(phi.alt))^2
    = cos(2 phi.alt) + i sin(2 phi.alt).
  $
  On the other side, expand the square directly with $i^2 = -1$:
  $
    (cos(phi.alt) + i sin(phi.alt))^2
    = (cos^2(phi.alt) - sin^2(phi.alt))
    + i dot (2 sin(phi.alt) cos(phi.alt)).
  $
  Two expressions for one number, so their real parts agree and their
  imaginary parts agree:
  $
    cos(2 phi.alt) = cos^2(phi.alt) - sin^2(phi.alt), quad
    sin(2 phi.alt) = 2 sin(phi.alt) cos(phi.alt).
  $
  These are the *double-angle formulas*. For many of you this is the
  first time you have met them -- and notice how little they cost:
  no clever trig, just one complex square and a comparison of parts.
  Every higher multiple-angle formula falls out the same way, by taking
  $n = 3, 4, dots$ -- which is the next exercise.
]

== Roots of a Complex Number

#only-theory[
  In the equations chapter the roots of $x^4 - 16$ landed at the
  corners of a square, and the roots of $x^4 - 1$ on the unit circle,
  and I promised that polar form would explain the evenness. Here is
  the explanation. To solve $z^n = w$, write both sides in polar form
  and use De Moivre backwards.
]

#theorem(title: [$n$-th roots])[
  Let $w = rho dot e^(i dot theta)$ with $rho > 0$. The equation
  $z^n = w$ has exactly $n$ solutions in $CC$:
  $
    z_k = rho^(1 \/ n) dot e^(i dot (theta + 2 pi dot k) \/ n),
    quad k = 0, 1, dots, n - 1.
  $
  All $n$ roots share the modulus $rho^(1 \/ n)$, and their arguments
  are spaced exactly $2 pi \/ n$ apart -- so they are the vertices of a
  regular $n$-gon inscribed in the circle of radius $rho^(1 \/ n)$.
]

#proof[
  Write $z = s dot e^(i dot psi)$. Then $z^n = s^n dot e^(i dot n dot psi)$, and
  $z^n = w = rho dot e^(i dot theta)$ forces, by comparing modulus and
  argument, $s^n = rho$ and $n dot psi = theta + 2 pi dot k$ for some integer
  $k$. So $s = rho^(1 \/ n)$ (a positive real root) and
  $psi = (theta + 2 pi dot k) \/ n$. The values $k = 0, 1, dots, n - 1$
  give $n$ distinct arguments within one full turn; every other $k$
  repeats one of these.
]

#only-theory[
  The special case $w = 1$ deserves its own name. The solutions of
  $z^n = 1$ are the #vocab("n-th roots of unity", "n-te Einheitswurzeln"),
  $
    z_k = e^(2 pi dot i dot k \/ n), quad k = 0, 1, dots, n - 1,
  $
  equally spaced around the *unit* circle, always including $z_0 = 1$.
]

#example[
  The cube roots of unity ($n = 3$) are
  $
    z_0 = e^0 = 1, quad
    z_1 = e^(2 pi dot i \/ 3) = -1 / 2 + sqrt(3) / 2 dot i, quad
    z_2 = e^(4 pi dot i \/ 3) = -1 / 2 - sqrt(3) / 2 dot i,
  $
  the vertices of an equilateral triangle on the unit circle. Note
  $z_1$ and $z_2$ are a conjugate pair -- as they must be, since
  $z^3 - 1$ has real coefficients.
]

#only-theory[
  #cplane(
    xmin: -2.0,
    xmax: 2.0,
    ymin: -2.0,
    ymax: 2.0,
    length: 1.1cm,
    caption: [The three cube roots of unity: a regular triangle on the
      unit circle.],
    {
      cp-unit-circle()
      cp-segment((1, 0), (-0.5, 0.866), color: accent)
      cp-segment((-0.5, 0.866), (-0.5, -0.866), color: accent)
      cp-segment((-0.5, -0.866), (1, 0), color: accent)
      cp-point(1, 0, label: $z_0 = 1$, anchor: "west")
      cp-point(-0.5, 0.866, label: $z_1$, anchor: "south-east")
      cp-point(-0.5, -0.866, label: $z_2$, anchor: "north-east")
    },
  )
]

#example[
  Solve $z^3 = -8$.

  Write $-8 = 8 dot e^(i dot pi)$, so $rho^(1 \/ 3) = 2$ and
  $z_k = 2 dot e^(i dot (pi + 2 pi dot k) \/ 3)$ for $k = 0, 1, 2$:
  $
    z_0 & = 2 dot e^(i dot pi \/ 3)
          = 2 dot (1 / 2 + sqrt(3) / 2 dot i) = 1 + sqrt(3) dot i, \
    z_1 & = 2 dot e^(i dot pi) = -2, \
    z_2 & = 2 dot e^(i 5 pi \/ 3)
          = 2 dot (1 / 2 - sqrt(3) / 2 dot i) = 1 - sqrt(3) dot i.
  $
  One of the three cube roots of $-8$ is the real number $-2$; the
  other two are a conjugate pair. The three are $120 degree$ apart.
]

// ── Exercises ────────────────────────────────────────────────

#ex(difficulty: 2, time: "20 min", calculator: true)[
  Write each number in polar form $r dot e^(i dot phi.alt)$. Give exact
  values where you can, otherwise four significant figures. A CAS may
  be used to check.
  #auto-parts(
    3,
    [$z = 3 + 4 dot i$],
    [$z = -2 + 2 sqrt(3) dot i$],
    [$z = -3 dot i$],
    [$z = -1 - i$],
    [$z = 5$],
    [$z = -4 + 3 dot i$],
  )
][
  #auto-parts(
    3,
    [$5 dot e^(0.9273 dot i)$],
    [$4 dot e^(2 pi dot i \/ 3)$],
    [$3 dot e^(-pi dot i \/ 2)$],
    [$sqrt(2) dot e^(-3 pi dot i \/ 4)$],
    [$5 dot e^(0) = 5$],
    [$5 dot e^(2.498 dot i)$],
  )
]

#ex(difficulty: 2, time: "20 min")[
  Write each number in Cartesian form $a + b dot i$. By hand.
  #auto-parts(
    3,
    [$z = 2 dot e^(2 pi dot i \/ 3)$],
    [$z = 3 dot e^(pi dot i \/ 4)$],
    [$z = 4 dot e^(-pi dot i \/ 6)$],
    [$z = e^(i dot pi)$],
    [$z = 2 dot e^(3 pi dot i \/ 2)$],
    [$z = sqrt(2) dot e^(5 pi dot i \/ 4)$],
  )
][
  #auto-parts(
    3,
    [$-1 + sqrt(3) dot i$],
    [$(3 sqrt(2)) / 2 + (3 sqrt(2)) / 2 dot i$],
    [$2 sqrt(3) - 2 dot i$],
    [$-1$],
    [$-2 dot i$],
    [$-1 - i$],
  )
]

#ex(difficulty: 3, time: "20 min", calculator: true)[
  Use De Moivre's theorem to compute each power. A CAS may be used to
  check.
  #auto-parts(
    2,
    [$(1 + i)^8$],
    [$(sqrt(3) + i)^6$],
    [$(1 + i)^(10) / (1 - i)^8$],
    [$(-1 + sqrt(3) dot i)^5$],
  )
][
  #auto-parts(
    2,
    [$16$],
    [$-64$],
    [$2 dot i$],
    [$-16 - 16 sqrt(3) dot i$],
  )

  For (d): $-1 + sqrt(3) dot i = 2 dot e^(i 2 pi \/ 3)$, so the fifth
  power is $2^5 dot e^(i 10 pi \/ 3) = 32 dot e^(i 4 pi \/ 3)
  = 32 dot (-1 / 2 - sqrt(3) / 2 dot i) = -16 - 16 sqrt(3) dot i$.
]

#ex(difficulty: 3, time: "20 min", hints: (
  [Apply De Moivre with $n = 3$: expand
    $(cos(phi.alt) + i sin(phi.alt))^3$ and compare with
    $cos(3 phi.alt) + i sin(3 phi.alt)$.],
  [Use the binomial expansion $(x + y)^3 = x^3 + 3 x^2 dot y + 3 x dot y^2 + y^3$
    with $x = cos(phi.alt)$ and $y = i sin(phi.alt)$, and remember
    $i^2 = -1$, $i^3 = -i$.],
))[
  Following the double-angle derivation in the text, use De Moivre's
  theorem with $n = 3$ to derive the *triple-angle* formulas for
  $cos(3 phi.alt)$ and $sin(3 phi.alt)$ in terms of $cos(phi.alt)$ and
  $sin(phi.alt)$.
][
  By De Moivre,
  $(cos(phi.alt) + i sin(phi.alt))^3 = cos(3 phi.alt) + i sin(3 phi.alt)$.
  Expanding the cube with the binomial formula and $i^2 = -1$,
  $i^3 = -i$ (write $c = cos(phi.alt)$, $s = sin(phi.alt)$):
  $
    (c + i dot s)^3 &= c^3 + 3 c^2 dot (i dot s) + 3 c dot (i dot s)^2 + (i dot s)^3 \
    &= c^3 + 3 dot i dot c^2 dot s - 3 c dot s^2 - i dot s^3 \
    &= (c^3 - 3 c dot s^2) + i dot (3 c^2 dot s - s^3).
  $
  Comparing real and imaginary parts:
  $
    cos(3 phi.alt) & = cos^3(phi.alt) - 3 cos(phi.alt) sin^2(phi.alt), \
    sin(3 phi.alt) & = 3 cos^2(phi.alt) sin(phi.alt) - sin^3(phi.alt).
  $
  (Using $sin^2 = 1 - cos^2$ and $cos^2 = 1 - sin^2$ these become the
  more familiar $cos(3 phi.alt) = 4 cos^3(phi.alt) - 3 cos(phi.alt)$
  and $sin(3 phi.alt) = 3 sin(phi.alt) - 4 sin^3(phi.alt)$.)
]

#ex(difficulty: 2, time: "25 min", keep-together: true)[
  Find all $n$-th roots of unity for $n = 4$ and for $n = 6$. In each
  case list the roots in both polar and Cartesian form, and sketch them
  on the unit circle.
][
  *$n = 4$:* $z_k = e^(pi dot i dot k \/ 2)$ for $k = 0, 1, 2, 3$, giving
  $z_0 = 1$, $z_1 = i$, $z_2 = -1$, $z_3 = -i$ -- the vertices of a
  square.

  *$n = 6$:* $z_k = e^(pi dot i dot k \/ 3)$ for $k = 0, dots, 5$:
  $
    z_0 &= 1, & z_1 &= 1 / 2 + sqrt(3) / 2 dot i,
    & z_2 &= -1 / 2 + sqrt(3) / 2 dot i, \
    z_3 &= -1, & z_4 &= -1 / 2 - sqrt(3) / 2 dot i,
    & z_5 &= 1 / 2 - sqrt(3) / 2 dot i,
  $
  the vertices of a regular hexagon.

  #cplane-small(
    xmin: -1.6,
    xmax: 1.6,
    ymin: -1.6,
    ymax: 1.6,
    {
      cp-unit-circle()
      cp-point(1, 0, size: 0.07)
      cp-point(0, 1, size: 0.07)
      cp-point(-1, 0, size: 0.07)
      cp-point(0, -1, size: 0.07)
      cp-label(1.35, 1.0, [$n = 4$], color: accent)
    },
  )
  #cplane-small(
    xmin: -1.6,
    xmax: 1.6,
    ymin: -1.6,
    ymax: 1.6,
    {
      cp-unit-circle()
      cp-point(1, 0, size: 0.07)
      cp-point(0.5, 0.866, size: 0.07)
      cp-point(-0.5, 0.866, size: 0.07)
      cp-point(-1, 0, size: 0.07)
      cp-point(-0.5, -0.866, size: 0.07)
      cp-point(0.5, -0.866, size: 0.07)
      cp-label(1.35, 1.0, [$n = 6$], color: accent)
    },
  )
]

#ex(difficulty: 3, time: "25 min", calculator: true)[
  Find all solutions of each equation. Give answers in polar form, and
  in Cartesian form where it is clean to do so.
  #auto-parts(
    2,
    [$z^4 = 1$],
    [$z^3 = -1$],
    [$z^4 = -16$],
    [$z^3 = 2 + 2 dot i$],
  )
][
  #auto-parts(
    1,
    [$z_k = e^(pi dot i dot k \/ 2)$: the roots are $1, i, -1, -i$.],
    [$z_k = e^(i dot (pi + 2 pi dot k) \/ 3)$:
      $z_0 = 1 / 2 + sqrt(3) / 2 dot i$, $z_1 = -1$,
      $z_2 = 1 / 2 - sqrt(3) / 2 dot i$.],
    [$-16 = 16 dot e^(i dot pi)$, so $z_k = 2 dot e^(i dot (pi + 2 pi dot k) \/ 4)$:
      $sqrt(2) dot (1 + i)$, $sqrt(2) dot (-1 + i)$,
      $sqrt(2) dot (-1 - i)$, $sqrt(2) dot (1 - i)$.],
    [$2 + 2 dot i = 2 sqrt(2) dot e^(i dot pi \/ 4)$. The common modulus is
      $(2 sqrt(2))^(1 \/ 3) = sqrt(2)$, so
      $z_k = sqrt(2) dot e^(i dot (pi \/ 4 + 2 pi dot k) \/ 3)$ for
      $k = 0, 1, 2$. Numerically $z_0 approx 1.366 + 0.366 dot i$; use a
      CAS for exact surd form.],
  )
]

== Extra Bits -- The Roots of Unity Sum to Zero

#only-theory[
  The $n$-th roots of unity have a property you can already guess from
  the pictures: being the symmetric corners of a regular $n$-gon
  centered at the origin, they must balance. Their sum is zero.
]

#ex(difficulty: 3, time: "20 min", hints: (
  [The roots are $1, omega, omega^2, dots, omega^(n-1)$ where
    $omega = e^(2 pi dot i \/ n)$ -- a geometric sequence with first term
    $1$ and ratio $omega$.],
  [Use the finite geometric-series sum
    $1 + omega + dots.c + omega^(n-1) = (omega^n - 1) \/ (omega - 1)$,
    valid because $omega eq.not 1$ for $n >= 2$. What is $omega^n$?],
))[
  Show that for every integer $n >= 2$, the $n$-th roots of unity sum
  to zero:
  $ sum_(k=0)^(n-1) e^(2 pi dot i dot k \/ n) = 0. $
][
  Let $omega = e^(2 pi dot i \/ n)$. The $n$ roots are the geometric
  sequence $omega^0, omega^1, dots, omega^(n-1)$, with first term $1$
  and ratio $omega$. Since $n >= 2$ we have $omega eq.not 1$, so the
  finite geometric-series formula applies:
  $
    sum_(k=0)^(n-1) omega^k = (omega^n - 1) / (omega - 1).
  $
  Now $omega^n = e^(2 pi dot i) = 1$, so the numerator is $1 - 1 = 0$ while
  the denominator is nonzero. The sum is therefore $0$. $square$

  Geometrically: the sum of the position vectors to the $n$ evenly
  spaced vertices of a regular $n$-gon centered at the origin is the
  vector to their centroid, scaled by $n$ -- and the centroid of a
  regular polygon is its center, the origin.
]

#print-hints()
#print-vocab()
