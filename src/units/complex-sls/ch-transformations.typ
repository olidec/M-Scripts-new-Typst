#import "../../common/preamble.typ": *
#import "../../common/cplane.typ": *
#show: chapter-template.with(title: "Transformations")
#let ex = exercise.with(chapter: "Transformations")

= Transformations and Parametric Curves

#only-theory[
  The polar-form chapter ended with a claim: because multiplying by a
  fixed number rotates and scales the plane, the map $z |-> c dot z$ is
  a *motion of the whole plane*, and that motions built from complex
  arithmetic would be a chapter of their own. This is that chapter.

  The objects we will move are *curves*, and the surprise is how
  cleanly it works. A curve in the plane is secretly a complex-valued
  function, and once it is written that way, translating it, rotating
  it, and scaling it are nothing more than adding and multiplying by
  complex constants -- one arithmetic step per motion, applied to every
  point of the curve at once.
]

#objectives(
  [describe a curve given by $y = f(x)$ or by a pair $(x(t), y(t))$ as
    a single complex-valued function $z(t)$],
  [translate a curve by adding a complex constant],
  [rotate and scale a curve about the origin by multiplying by
    $r dot e^(i dot alpha)$],
  [rotate a curve about any point using the translate--rotate--translate-back
    pattern],
  [recover the Cartesian description of a transformed curve by splitting
    into real and imaginary parts],
)

== Parametric Curves

#only-theory[
  Not every curve is the graph of a function. A circle fails the
  vertical-line test; so does a figure-eight. To describe curves this
  general, let a single #vocab("parameter", "Parameter") $t$ drive both
  coordinates independently:
  $
    K: cases(x = x(t), y = y(t)).
  $
  As $t$ runs over an interval, the point $(x(t), y(t))$ traces the
  #vocab("parametric curve", "Parameterkurve") $K$. Because $x$ and $y$
  move independently, the curve is free to loop, cross itself, and close
  up -- things a graph $y = f(x)$ can never do.
]

#only-theory[
  Two familiar objects are already parametric curves in disguise. A
  *line* in vector form is exactly a parametrization,
  $
    vec(x, y) = vec(2, -1) + t dot vec(-1, 3)
    quad <==> quad
    cases(x(t) = 2 - t, y(t) = -1 + 3 t),
  $
  and *any graph* $y = f(x)$ has the natural parametrization
  $x(t) = t$, $y(t) = f(t)$ -- run $t$ along the $x$-axis and let $y$
  follow. So $y = x^2$ becomes $cases(x(t) = t, y(t) = t^2)$. The
  parametric language *contains* the graphs you already know and reaches
  well beyond them.
]

#only-theory[
#cplane(
  xmin: -3.5,
  xmax: 3.5,
  ymin: -2.5,
  ymax: 2.5,
  show-ticks: false,
  caption: [A Lissajous curve $x(t) = 3 cos(3 t)$, $y(t) = 2 sin(2 t)$
    -- no graph $y = f(x)$ can cross itself like this.],
  {
    cp-curve(
      t => 3 * calc.cos(3 * t),
      t => 2 * calc.sin(2 * t),
      domain: (0, 2 * calc.pi),
      samples: 240,
      color: accent,
    )
  },
)
]

== A Curve Is a Complex-Valued Function

#only-theory[
  Here is the idea the whole chapter turns on. A parametric curve gives,
  for each $t$, a pair of real numbers $(x(t), y(t))$ -- and a pair of
  real numbers *is* a complex number. So collapse the pair into one
  #vocab("complex-valued function", "komplexwertige Funktion"):
  $
    z(t) = x(t) + i dot y(t).
  $
  The $x$-coordinate is the real part, the $y$-coordinate the imaginary
  part. Nothing is lost -- $x(t) = Re(z(t))$ and $y(t) = Im(z(t))$
  recover the pair whenever we want it back -- but everything is
  *gained*, because now the full arithmetic of $CC$ can act on the
  curve.
]

#example[
  Three curves as complex-valued functions.
  - The parabola $y = x^2 - 1$: take $x(t) = t$, so
    $z(t) = t + i dot (t^2 - 1)$.
  - The unit circle, counterclockwise from $1$:
    $z(t) = e^(i dot t) = cos(t) + i sin(t)$, for $t in [0, 2 pi]$.
  - The horizontal line at height $b$: $z(t) = t + i dot b$, for
    $t in RR$.
]

#keybox(title: "Two languages, one curve")[
  A curve can be read two ways, and we will switch freely between them:
  - As *geometry* -- a shape in the plane, drawn by the moving point
    $z(t)$.
  - As *arithmetic* -- a complex-valued function, which we can add to,
    multiply, and otherwise compute with.
  Every transformation below is an arithmetic operation on $z(t)$ that
  we read off as a geometric motion of the curve.
]

== Translation

#only-theory[
  Adding a fixed complex number $c = p + q dot i$ to every point of a
  curve shifts the whole curve by the vector $(p, q)$ -- because
  addition in $CC$ is componentwise, exactly the vector addition from
  the arithmetic chapter.
]

#keybox(title: "Translation")[
  The image of the curve $z(t)$ under #vocab("translation", "Verschiebung")
  by $c = p + q dot i$ is
  $
    w(t) = z(t) + c,
  $
  the curve shifted by $p$ horizontally and $q$ vertically.
]

#example[
  Translate $z(t) = t + i dot (t^2 - 1)$ by $c = 3 + 2 dot i$:
  $
    w(t) = (t + 3) + i dot (t^2 - 1 + 2) = (t + 3) + i dot (t^2 + 1).
  $
  The parabola moves right by $3$ and up by $2$ -- its vertex travels
  from $(0, -1)$ to $(3, 1)$.
]

#only-theory[
#cplane(
  xmin: -3.0,
  xmax: 5.5,
  ymin: -1.5,
  ymax: 5.0,
  show-ticks: false,
  caption: [A curve $z(t)$ (blue) and its translation
    $w(t) = z(t) + (3 + 2 dot i)$ (orange).],
  {
    cp-complex-curve(
      t => (t, t * t - 1),
      domain: (-2, 2),
      color: accent,
    )
    cp-complex-curve(
      t => (t + 3, t * t + 1),
      domain: (-2, 2),
      color: ex-col,
    )
    cp-vector(3, 2, color: luma(120), thickness: 1pt)
  },
)
]

#ex(difficulty: 1, time: "10 min")[
  Write a parametric equation $z(t) = x(t) + i dot y(t)$ for each curve.
  #auto-parts(
    2,
    [the line $y = 1 / 2 x + 3$],
    [the line $2 x - 6 y + 10 = 0$],
    [the parabola $y = x^2 + 2$],
    [the parabola $x = y^2 - 1$],
  )
][
  #auto-parts(
    2,
    [$z(t) = t + i dot (1 / 2 t + 3)$],
    [$z(t) = t + i dot (t + 5) / 3$],
    [$z(t) = t + i dot (t^2 + 2)$],
    [$z(t) = (t^2 - 1) + i dot t$ -- here it is cleanest to let the
      *parameter drive $y$*, since $x$ is given in terms of $y$.],
  )
]

#ex(difficulty: 2, time: "12 min")[
  Find a Cartesian equation $y = f(x)$ for each parametric curve by
  eliminating $t$.
  #auto-parts(
    3,
    [$z(t) = t + i dot (2 - t)$],
    [$z(t) = -t + i dot (t^2 + 1)$],
    [$z(t) = (3 - t) + i dot (2 + t)$],
  )
][
  #auto-parts(
    3,
    [$y = 2 - x$],
    [$y = x^2 + 1$ (since $x = -t$ gives $t = -x$, and
      $t^2 = x^2$)],
    [$y = -x + 5$ (add the two equations: $x + y = 5$)],
  )
]

== Rotation and Scaling about the Origin

#only-theory[
  This is the payoff promised in the polar-form chapter. Multiplying a
  single number by $e^(i dot alpha)$ rotates it by $alpha$ about the
  origin; multiplying *every* point $z(t)$ of a curve by the same
  $e^(i dot alpha)$ rotates the whole curve by $alpha$. And multiplying
  by $r dot e^(i dot alpha)$ rotates by $alpha$ and scales by $r$ in
  one stroke.
]

#keybox(title: "Rotation and scaling about the origin")[
  The image of $z(t)$ under #vocab("rotation", "Drehung") by angle
  $alpha$ about the origin is
  $
    w(t) = e^(i dot alpha) dot z(t).
  $
  Using $w(t) = r dot e^(i dot alpha) dot z(t)$ instead also scales the
  curve by the factor $r$.
]

#example[
  Rotate $z(t) = t + i dot (t^2 + 1)$ by $pi / 4$ (that is,
  $45 degree$) about the origin. Since
  $e^(i dot pi \/ 4) = (1 + i) \/ sqrt(2)$,
  $
    w(t) = (1 + i) / sqrt(2) dot (t + i dot (t^2 + 1))
      = (t - (t^2 + 1)) / sqrt(2)
      + i dot (t + (t^2 + 1)) / sqrt(2).
  $
  Every point has swung $45 degree$ counterclockwise about the origin.
]

#only-theory[
#cplane(
  xmin: -4.0,
  xmax: 3.0,
  ymin: -0.5,
  ymax: 4.5,
  show-ticks: false,
  caption: [A curve $z(t)$ (blue) and its rotation
    $w(t) = e^(i dot pi \/ 4) dot z(t)$ by $45 degree$ about the origin
    (orange).],
  {
    let a = calc.pi / 4
    cp-complex-curve(
      t => (t, t * t + 1),
      domain: (-1.6, 1.6),
      color: accent,
    )
    cp-complex-curve(
      t => {
        let x = t
        let y = t * t + 1
        (calc.cos(a) * x - calc.sin(a) * y, calc.sin(a) * x + calc.cos(a) * y)
      },
      domain: (-1.6, 1.6),
      color: ex-col,
    )
    cp-angle(0, 0, 63.43deg, 108.43deg, radius: 1.6, label: $45 degree$)
  },
)
]

#ex(difficulty: 2, time: "20 min", cas: true)[
  Consider the parabola $y = x^2 - 1$.
  #auto-parts(
    1,
    [Write it as a complex-valued function $z(t)$.],
    [Find where the curve crosses the axes.],
    [Rotate the curve by $30 degree$ counterclockwise about the origin
      to get $w(t)$. Write $w(t)$.],
    [Find the image of the vertex (the point at $t = 0$).],
    [Find, numerically, the values of $t$ at which $w(t)$ crosses the
      axes.],
  )
][
  #auto-parts(
    1,
    [$z(t) = t + i dot (t^2 - 1)$.],
    [Real axis ($Im = 0$): $t^2 - 1 = 0$, so $t = plus.minus 1$, giving
      the points $(plus.minus 1, 0)$. Imaginary axis ($Re = 0$):
      $t = 0$, giving $(0, -1)$.],
    [$w(t) = e^(i dot pi \/ 6) dot z(t)$.],
    [$w(0) = e^(i dot pi \/ 6) dot (-i)
      = sin(pi \/ 6) - i cos(pi \/ 6)
      = 1 / 2 - sqrt(3) / 2 dot i$, i.e. the vertex moves to
      $(1 / 2, -sqrt(3) / 2)$.],
    [Splitting $w(t)$ into parts and setting each to zero gives, with a
      CAS, $t approx -1.33$, $-0.457$, $0.752$, $2.19$.],
  )
]

== Rotation about Any Point

#only-theory[
  Multiplying by $e^(i dot alpha)$ always rotates about the *origin* --
  the one point it fixes. To rotate about some other center $z_0$, use a
  three-step pattern that should feel familiar from everyday life:
  carry the center to the origin, do the rotation there, and carry
  everything back.
  + *Translate* so $z_0$ lands on the origin: $z(t) - z_0$.
  + *Rotate* about the origin: multiply by $e^(i dot alpha)$.
  + *Translate back*: add $z_0$.
]

#theorem(title: "Rotation about any center")[
  The image of the curve $z(t)$ under rotation by angle $alpha$ about
  the point $z_0$ is
  $
    w(t) = e^(i dot alpha) dot (z(t) - z_0) + z_0.
  $
]

#remark[
  The shape *do--act--undo* -- translate in, rotate, translate back --
  is worth recognizing, because it recurs everywhere in mathematics: to
  act somewhere inconvenient, move to where the action is easy, act, and
  move back. You met it implicitly when completing the square, and you
  will meet it again as change of basis, substitution in integration,
  and conjugation in group theory. Here it is, in its simplest visible
  form.
]

#example[
  Rotate the parabola $z(t) = t + i dot t^2$ by $90 degree$ about the
  point $z_0 = 1 + i$. With $e^(i dot pi \/ 2) = i$:
  $
    w(t) &= i dot (z(t) - (1 + i)) + (1 + i) \
      &= i dot ((t - 1) + i dot (t^2 - 1)) + 1 + i \
      &= i dot (t - 1) - (t^2 - 1) + 1 + i \
      &= (1 - (t^2 - 1)) + i dot (1 + (t - 1)) \
      &= (2 - t^2) + i dot t.
  $
  The upward parabola becomes a leftward one -- a quarter turn, as it
  must be.
]

#only-theory[
#cplane(
  xmin: -2.5,
  xmax: 3.0,
  ymin: -1.5,
  ymax: 4.0,
  show-ticks: false,
  caption: [Rotation by $90 degree$ about $z_0 = 1 + i$: the curve
    $z(t) = t + i dot t^2$ (blue) maps to $w(t) = (2 - t^2) + i dot t$
    (orange). The center $z_0$ stays fixed.],
  {
    cp-complex-curve(
      t => (t, t * t),
      domain: (-1.6, 1.6),
      color: accent,
    )
    cp-complex-curve(
      t => (2 - t * t, t),
      domain: (-1.6, 1.6),
      color: ex-col,
    )
    cp-point(1, 1, label: $z_0$, anchor: "south-west", color: def-col)
  },
)
]

#only-theory[
  Every motion in this chapter -- translate, rotate, scale, and rotate
  about a center -- has the same shape: multiply by one complex constant,
  then add another.
]

#keybox(title: "One form for all of them")[
  Every transformation in this chapter can be written as
  $
    w(t) = a dot z(t) + b
  $
  for suitable complex constants $a$ and $b$. Translation is $a = 1$;
  rotation-and-scaling about the origin is $b = 0$ with
  $a = r dot e^(i dot alpha)$; rotation about $z_0$ is
  $a = e^(i dot alpha)$ with $b = z_0 dot (1 - e^(i dot alpha))$. These
  maps -- multiply by one number, add another -- are the
  *similarity transformations* of the plane.
]

#look-ahead(
  title: "The question, turned around",
  preview: [loci],
)[
  So far we have started with a known curve and asked where it *goes*.
  The next chapter turns the question around: instead of the image of a
  curve we already have, we describe a curve by a *condition* its points
  must satisfy -- "all $z$ at distance $3$ from $z_0$", written
  $|z - z_0| = 3$, or "all $z$ equidistant from two points". The same
  complex algebra that moved curves here will, there, carve them out of
  the plane.
]

// ── Exercises ────────────────────────────────────────────────

#ex(difficulty: 2, time: "12 min")[
  Translate the curve $z(t) = t + i dot (t^2 - 4)$ by $c = -2 + 3 dot i$.
  Write $w(t)$, and state where the new vertex lies.
][
  $w(t) = z(t) + c = (t - 2) + i dot (t^2 - 4 + 3) = (t - 2) + i dot (t^2 - 1)$.
  The vertex (at $t = 0$) moves from $(0, -4)$ to $(-2, -1)$.
]

#ex(difficulty: 3, time: "20 min")[
  Rotate the standard parabola $y = x^2$ about the point $Z = (0, -2)$
  by $45 degree$. Write the result as a complex-valued function and find
  the image of the vertex.
][
  Here $z_0 = -2 dot i$ and $z(t) = t + i dot t^2$, so
  $z(t) - z_0 = t + i dot (t^2 + 2)$. With
  $e^(i dot pi \/ 4) = (1 + i) \/ sqrt(2)$,
  $
    w(t) = e^(i dot pi \/ 4) dot (t + i dot (t^2 + 2)) - 2 dot i.
  $
  Multiplying out and separating parts,
  $
    w(t) = (-(t^2 - t + 2)) / sqrt(2)
      + i dot ((t^2 + t) / sqrt(2) + sqrt(2) - 2).
  $
  Image of the vertex ($t = 0$): $w(0) = -sqrt(2) + (sqrt(2) - 2) dot i$,
  i.e. $(-sqrt(2), sqrt(2) - 2)$.
]

#ex(difficulty: 3, time: "18 min")[
  Rotate the standard parabola $y = x^2$ about $Z = (0, 2)$ by
  $-45 degree$. Write the result as a complex-valued function.
][
  With $z_0 = 2 dot i$ and $e^(-i dot pi \/ 4) = (1 - i) \/ sqrt(2)$,
  $
    w(t) = e^(-i dot pi \/ 4) dot (t + i dot (t^2 - 2)) + 2 dot i
      = (sqrt(2) dot (t^2 + t - 2)) / 2
      + i dot ((sqrt(2) dot (t^2 - t)) / 2 - sqrt(2) + 2).
  $
]

#ex(difficulty: 3, time: "22 min", cas: true)[
  The graph of $y = 1 / 2 x^2 - 4$ is rotated about the origin by
  $90 degree$.
  #auto-parts(
    1,
    [Write both the original and the rotated curve as complex-valued
      functions.],
    [Find all intersection points of the two curves.],
  )
][
  #auto-parts(
    1,
    [Original: $z(t) = t + i dot (1 / 2 t^2 - 4)$. Rotated (multiply by
      $e^(i dot pi \/ 2) = i$):
      $w(t) = i dot z(t) = (4 - 1 / 2 t^2) + i dot t$.],
    [A point is on both curves when $Re$ and $Im$ agree for some
      parameters $s$ (on $z$) and $t$ (on $w$): $s = 4 - 1 / 2 t^2$ and
      $1 / 2 s^2 - 4 = t$. Solving numerically,
      $(x, y) approx (-4, 4)$, $(2, -2)$, $(3.24, 1.24)$,
      $(-1.24, -3.24)$.],
  )
]

== Extra Bits -- A Propeller

#only-theory[
  Rotation about a center is exactly the tool for building figures with
  rotational symmetry. Here three congruent curves are fitted together
  into a three-bladed propeller, and every part of the construction is a
  rotation.
]

#only-theory[
#cplane(
  xmin: -4.0,
  xmax: 4.0,
  ymin: -6.0,
  ymax: 2.0,
  length: 0.5cm,
  show-ticks: false,
  caption: [Three congruent cubic arcs, each a $120 degree$ rotation of
    the next about the center, meeting at $A$, $B$, $C$.],
  {
    // K1: y = -x^3/9 + x on [-3, 3]
    let k1 = t => (t, -t * t * t / 9 + t)
    // rotate a point p by angle ang about center c
    let rot = (p, ang, c) => {
      let dx = p.at(0) - c.at(0)
      let dy = p.at(1) - c.at(1)
      (
        c.at(0) + calc.cos(ang) * dx - calc.sin(ang) * dy,
        c.at(1) + calc.sin(ang) * dx + calc.cos(ang) * dy,
      )
    }
    let A = (-3, 0)
    let B = (3, 0)
    cp-complex-curve(k1, domain: (-3, 3), color: accent)
    cp-complex-curve(t => rot(k1(t), -calc.pi / 3, A), domain: (-3, 3), color: def-col)
    cp-complex-curve(t => rot(k1(t), calc.pi / 3, B), domain: (-3, 3), color: warn-col)
    cp-point(-3, 0, label: $A$, anchor: "north-east", size: 0.12)
    cp-point(3, 0, label: $B$, anchor: "north-west", size: 0.12)
    cp-point(0, -5.196, label: $C$, anchor: "north", size: 0.12)
  },
)
]

#ex(difficulty: 3, time: "35 min", hints: (
  [For (a): $A$, $B$, $C$ are the corners of an equilateral triangle
    centered at the origin, with $A$ and $B$ on the real axis at
    $plus.minus 3$. Where must the third corner sit?],
  [For (b): a point-symmetric cubic through the origin has the form
    $f(x) = a dot x^3 + b dot x$ (no even powers). Use the two given
    points to pin down $a$ and $b$.],
  [For (d): $K_2$ is $K_1$ rotated about $A = -3$ by $-60 degree$, and
    $K_3$ is $K_1$ rotated about $B = 3$ by $+60 degree$.],
))[
  The propeller above consists of three congruent curves $K_1$, $K_2$,
  $K_3$ with corners $A = (-3, 0)$, $B = (3, 0)$ and $C = (0, r)$. The
  arc $K_1$ from $A$ to $B$ is a point-symmetric cubic through
  $P = (1, 8 / 9)$.
  #auto-parts(
    1,
    [Find the $y$-coordinate $r$ of $C$.],
    [Show that $K_1$ is $y = -1 / 9 x^3 + x$.],
    [Write $K_1$ as a complex-valued function $z(t)$, $t in [-3, 3]$.],
    [Find complex-valued functions $w(t)$ and $u(t)$ for $K_2$ and
      $K_3$.],
    [Find the angle at which $K_1$ and $K_2$ meet at $A$.],
  )
][
  #auto-parts(
    1,
    [$A$, $B$, $C$ are equally spaced on a circle about the origin, so
      $C$ is $B = (3, 0)$ rotated by $-120 degree$ (or $A$ by
      $+120 degree$): $C = (0, -3 sqrt(3))$, giving $r = -3 sqrt(3)$.],
    [A point-symmetric cubic is $f(x) = a dot x^3 + b dot x$. Through
      $B = (3, 0)$: $27 a + 3 b = 0$, so $b = -9 a$. Through
      $P = (1, 8 / 9)$: $a + b = 8 / 9$, hence $a - 9 a = 8 / 9$, giving
      $a = -1 / 9$ and $b = 1$. So $y = -1 / 9 x^3 + x$.],
    [$z(t) = t + i dot (-1 / 9 t^3 + t) = t - i dot (1 / 9 t^3 - t)$,
      for $t in [-3, 3]$.],
    [$K_2$ is $K_1$ rotated about $A = -3$ by $-60 degree$, and $K_3$ is
      $K_1$ rotated about $B = 3$ by $+60 degree$:
      $
        w(t) &= e^(-i dot pi \/ 3) dot (z(t) + 3) - 3, \
        u(t) &= e^(i dot pi \/ 3) dot (z(t) - 3) + 3.
      $],
    [$K_2$ is $K_1$ rotated by $-60 degree$ about $A$, and $A$ is a
      point of both, so at $A$ the tangent of $K_2$ is the tangent of
      $K_1$ turned by $-60 degree$. The curves therefore meet at
      $alpha = 60 degree$.],
  )
]

#print-hints()
#print-vocab()
