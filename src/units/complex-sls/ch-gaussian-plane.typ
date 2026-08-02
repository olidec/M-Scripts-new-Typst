#import "../../common/preamble.typ": *
#import "../../common/cplane.typ": *
#show: chapter-template.with(title: "The Gaussian Plane")
#let ex = exercise.with(chapter: "Gaussian Plane")

= The Gaussian Plane

#only-theory[
  So far $CC$ has been an algebraic object: a set of expressions
  $a + b dot i$ with rules for combining them. Every calculation you
  have done was symbol-pushing, and it worked, but nothing in it told
  you what a complex number *is*.

  This chapter answers that. A complex number is a *point*, and every
  operation you already know turns out to be a *motion* of the plane --
  a shift, a reflection, and, in the case of multiplication, something
  we will need one more chapter to name properly. From here on, when
  an algebra problem defeats you, the first move is to draw it.
]

#objectives(
  [represent complex numbers as points and as vectors in the Gaussian
    plane, and read a complex number off a diagram],
  [calculate the modulus of a complex number and use its algebraic
    properties],
  [determine the principal argument of a complex number, choosing the
    correct quadrant],
  [explain addition, negation and conjugation as motions of the plane],
  [describe and sketch simple loci: circles, half-planes and strips],
  [prove and apply the triangle inequality],
)

== From a Line to a Plane

#only-theory[
  A complex number $z = a + b dot i$ is fixed by exactly two real
  numbers, $a$ and $b$ -- no more and no fewer. That is precisely the
  amount of information a point in the plane carries, so we simply draw
  $z$ at the point with coordinates $(a, b)$.

  The result is called the
  #vocab("Gaussian plane", "Gausssche Ebene"), after Carl Friedrich
  Gauss, and also the *Argand diagram* or just the *complex plane*.
  The horizontal axis carries the real numbers and is called the
  #vocab("real axis", "reelle Achse"); the vertical axis carries the
  purely imaginary numbers and is called the
  #vocab("imaginary axis", "imaginäre Achse").
]

#only-theory[
  #cplane(
    xmin: -4.5,
    xmax: 4.5,
    ymin: -4.5,
    ymax: 4.5,
    caption: [Three complex numbers as points of the Gaussian plane.],
    {
      cp-point(-1, -1, label: $z_1 = -1 - i$, anchor: "north-east")
      cp-point(3, 2, label: $z_2 = 3 + 2i$, anchor: "south-west")
      cp-point(0, 3, label: $z_3 = 3i$, anchor: "south-west", color: def-col)
    },
  )
]

#keybox(title: "Reading the plane")[
  The correspondence between $CC$ and the plane is one-to-one: every
  complex number is one point, every point is one complex number.
  Three consequences worth memorizing as pictures rather than rules:
  - Real numbers ($b = 0$) lie *on the real axis*. The old number line
    is still there, sitting inside the plane.
  - Purely imaginary numbers ($a = 0$) lie *on the imaginary axis*.
  - $z$ and $overline(z)$ are *mirror images in the real axis*.
]

#remark[
  On our diagrams the axes are labeled with a bold upright $bold("Re")$
  and $bold("Im")$ -- the same two names as the $Re(z)$, $Im(z)$
  operators, set in bold so they read as the *name of the axis* rather
  than as an operator applied to a tick mark. Other books mark the same
  two axes with $x$ and $y$, or with $bb(R)$ and $i bb(R)$ to stress
  that the horizontal axis *is* the real number line and the vertical
  one carries the purely imaginary numbers $i dot b$. All three say the
  same thing; only the label changes.
]

#ex(difficulty: 1, time: "10 min")[
  Plot each number in the Gaussian plane, on a single set of axes.
  #auto-parts(
    3,
    [$z = 3 + 4i$],
    [$z = -2 + i$],
    [$z = -3i$],
    [$z = -1 - i$],
    [$z = 5$],
    [$z = 2 - 3i$],
  )
  Which of them lie on an axis, and which axis?
][
  #cplane-small(
    xmin: -4.5,
    xmax: 5.5,
    ymin: -4.5,
    ymax: 4.5,
    {
      cp-point(3, 4, label: [(a)], anchor: "south-west")
      cp-point(-2, 1, label: [(b)], anchor: "south-west")
      cp-point(0, -3, label: [(c)], anchor: "south-west")
      cp-point(-1, -1, label: [(d)], anchor: "north-east")
      cp-point(5, 0, label: [(e)], anchor: "south-west")
      cp-point(2, -3, label: [(f)], anchor: "south-west")
    },
  )

  (c) is purely imaginary and lies on the imaginary axis; (e) is real
  and lies on the real axis. The other four lie in the open quadrants.
]

== The Modulus

#only-theory[
  Once a complex number is a point, it has a *distance from the
  origin*, and Pythagoras gives it to us immediately.
]

#definition(title: "Modulus")[
  The #vocab("modulus", "Betrag") of $z = a + b dot i$, written $|z|$,
  is its distance from the origin:
  $ |z| = sqrt(a^2 + b^2). $
]

#only-theory[
  #cplane(
    xmin: -1.5,
    xmax: 4.5,
    ymin: -1.5,
    ymax: 3.5,
    caption: [The modulus is the hypotenuse of the triangle with legs
      $a$ and $b$.],
    {
      cp-vector(3, 2, color: accent)
      cp-segment((3, 0), (3, 2), color: luma(140), dashed: true)
      cp-segment((0, 2), (3, 2), color: luma(140), dashed: true)
      cp-point(3, 2, label: $z = a + b dot i$, anchor: "south-west")
      cp-label(1.4, 1.35, $|z|$, color: accent, size: 10pt)
      cp-label(1.5, -0.35, $a$)
      cp-label(-0.35, 1.0, $b$)
    },
  )
]

#only-theory[
  The modulus is always a non-negative *real* number, and it is zero
  only for $z = 0$. It generalizes the absolute value you already know:
  for a real number $a = a + 0 dot i$ the definition gives
  $|a| = sqrt(a^2)$, which is exactly the old absolute value. The
  notation is deliberately the same because it is the same idea --
  distance from zero -- measured in a bigger space.
]

#keybox(title: "The bridge between modulus and conjugate")[
  $ z dot overline(z) = a^2 + b^2 = |z|^2. $
  You proved the left-hand equality in the arithmetic chapter, before
  the modulus had a name. It is the single most useful identity in this
  course: it converts a *distance* (geometric, with an awkward square
  root) into a *product* (algebraic, easy to expand). Almost every
  proof in this chapter and the next runs through it.
]

#theorem(title: "Properties of the modulus")[
  For all $z, w in CC$:
  $
    |z| >= 0, quad "and" quad |z| = 0 <==> z = 0, \
    |overline(z)| = |z|, \
    |z dot w| = |z| dot |w|, \
    abs(z / w) = (|z|) / (|w|) quad (w eq.not 0), \
    |z + w| <= |z| + |w| quad "(triangle inequality)".
  $
]

#only-theory[
  Read the third line geometrically and it is a strong claim: the
  distance of a product is the product of the distances. Multiplication
  therefore *scales*. Read the last line geometrically and it is
  obvious: going from $0$ to $z$ and then on to $z + w$ cannot be
  shorter than going straight to $z + w$. A detour is never a shortcut.
  You will prove it at the end of this chapter.
]

#example[
  $|3 + 4i| = sqrt(9 + 16) = sqrt(25) = 5$.

  $|-1 - i| = sqrt(1 + 1) = sqrt(2)$. Note that the signs disappear:
  $z$, $-z$, $overline(z)$ and $-overline(z)$ all have the same
  modulus, because all four are the same distance from the origin.
]

#ex(difficulty: 1, time: "10 min")[
  Calculate the modulus of each of the six numbers you plotted in the
  previous exercise, and check each answer against your diagram: the
  larger modulus should be the point further from the origin.
  #auto-parts(
    3,
    [$z = 3 + 4i$],
    [$z = -2 + i$],
    [$z = -3i$],
    [$z = -1 - i$],
    [$z = 5$],
    [$z = 2 - 3i$],
  )
][
  #auto-parts(
    3,
    [$|z| = sqrt(9 + 16) = 5$],
    [$|z| = sqrt(5)$],
    [$|z| = 3$],
    [$|z| = sqrt(2)$],
    [$|z| = 5$],
    [$|z| = sqrt(13)$],
  )

  (a) and (e) tie at $5$, which the diagram confirms: both points sit
  on the circle of radius $5$ about the origin.
]

#ex(difficulty: 2, time: "15 min", hints: (
  [Don't reach for square roots. Use $|z|^2 = z dot overline(z)$ on
    both sides and compare what you get.],
  [You will need $overline(z dot w) = overline(z) dot overline(w)$
    from the arithmetic chapter, and the fact that multiplication in
    $CC$ can be reordered freely.],
))[
  Prove that $|z dot w| = |z| dot |w|$ for all $z, w in CC$, without
  writing $z$ and $w$ in the form $a + b dot i$.
][
  Both sides are non-negative reals, so it is enough to show their
  squares agree (#heuristic("work backwards from the goal") -- the
  square root is the obstacle, so square it away first):
  $
    |z dot w|^2 & = (z dot w) dot overline(z dot w)
                  = (z dot w) dot (overline(z) dot overline(w)) \
                & = (z dot overline(z)) dot (w dot overline(w))
                  = |z|^2 dot |w|^2 = (|z| dot |w|)^2.
  $
  Taking square roots of two non-negative numbers preserves the
  equality, so $|z dot w| = |z| dot |w|$. $square$

  Doing it with $z = a + b dot i$ and $w = c + d dot i$ also works, but
  costs half a page of algebra: this is what the modulus--conjugate
  bridge buys you.
]

== Addition, Negation and Conjugation as Motions

#only-theory[
  Instead of drawing $z$ as a point, draw it as an *arrow* from the
  origin to that point. Nothing changes about the number; it is the
  same two coordinates. But addition suddenly becomes visible.

  Since $z_1 + z_2$ adds the real parts and the imaginary parts
  separately, its arrow is the one you get by placing the tail of
  $z_2$'s arrow at the tip of $z_1$'s. The three arrows close up into a
  parallelogram -- exactly the rule you know from vectors.
]

#only-theory[
  #cplane(
    xmin: -0.5,
    xmax: 4.5,
    ymin: -0.5,
    ymax: 4.5,
    caption: [Addition is the parallelogram rule:
      $(2 + i) + (1 + 3i) = 3 + 4i$.],
    {
      cp-segment((2, 1), (3, 4), color: luma(170), dashed: true)
      cp-segment((1, 3), (3, 4), color: luma(170), dashed: true)
      cp-vector(2, 1, color: accent, label: $z_1$, anchor: "north-west")
      cp-vector(1, 3, color: def-col, label: $z_2$, anchor: "east")
      cp-vector(
        3,
        4,
        color: warn-col,
        label: $z_1 + z_2$,
        anchor: "south-west",
      )
    },
  )
]

#only-theory[
  Two more operations are immediate once you look at the picture:
  - $overline(z)$ *reflects $z$ in the real axis* -- the imaginary part
    changes sign, the real part does not.
  - $-z$ *reflects $z$ through the origin* -- both parts change sign,
    which is the same as a half turn.

  And subtraction needs nothing new: $z_1 - z_2 = z_1 + (-z_2)$, so it
  is the parallelogram rule applied to the half-turned $z_2$. The arrow
  from $z_2$ to $z_1$ is exactly $z_1 - z_2$, which is why
  $|z_1 - z_2|$ is the *distance between* $z_1$ and $z_2$ -- a fact the
  loci section leans on completely.
]

#only-theory[
  #cplane(
    xmin: -4.5,
    xmax: 4.5,
    ymin: -3.5,
    ymax: 3.5,
    caption: [$z$, its conjugate, and its negative.],
    {
      cp-point(3, 2, label: $z$, anchor: "south-west")
      cp-point(
        3,
        -2,
        label: $overline(z)$,
        anchor: "north-west",
        color: def-col,
      )
      cp-point(-3, -2, label: $-z$, anchor: "north-east", color: warn-col)
      cp-segment((3, 2), (3, -2), color: def-col, dashed: true)
      cp-segment((3, 2), (-3, -2), color: warn-col, dashed: true)
    },
  )
]

#ex(difficulty: 2, time: "15 min")[
  Let $z = 3 + 2i$.
  #auto-parts(
    1,
    [Mark $z$, $overline(z)$, $-z$ and $-overline(z)$ on one diagram.],
    [What shape do the four points form? Give its dimensions and its
      area.],
    [Show that this shape is the same for *every* $z$ with
      $Re(z) eq.not 0$ and $Im(z) eq.not 0$, and say what happens in
      the two excluded cases.],
  )
][
  #auto-parts(
    1,
    [The four points are $(3, 2)$, $(3, -2)$, $(-3, -2)$ and
      $(-3, 2)$.
      #cplane-small(
        xmin: -4.5,
        xmax: 4.5,
        ymin: -3.5,
        ymax: 3.5,
        {
          cp-region((3, 2), (3, -2), (-3, -2), (-3, 2))
          cp-point(3, 2, label: $z$, anchor: "south-west")
          cp-point(3, -2, label: $overline(z)$, anchor: "north-west")
          cp-point(-3, -2, label: $-z$, anchor: "north-east")
          cp-point(-3, 2, label: $-overline(z)$, anchor: "south-east")
        },
      )],
    [A rectangle with sides parallel to the axes, $6$ wide and $4$
      tall, centered at the origin. Its area is $24$.],
    [In general the four points are $(a, b)$, $(a, -b)$, $(-a, -b)$ and
      $(-a, b)$: a rectangle of width $2|a|$ and height $2|b|$,
      centered at the origin, with area $4 dot |a| dot |b| = 4 dot
      |Re(z)| dot |Im(z)|$. If $a = 0$ or $b = 0$ the rectangle
      collapses to a segment (two of the four points coincide) and the
      area is $0$.],
  )
]

== Multiplying by $i$

#only-theory[
  Addition, negation and conjugation were all easy to see. Multiplication
  is the one operation whose geometry is not obvious -- so we start with
  the simplest possible case and let you find it.
]

#exploration(title: "What does multiplying by $i$ do?")[
  Work on squared paper, and draw every number you compute.

  + Take $z = 3 + 2i$. Calculate $i dot z$, then $i^2 dot z$, then
    $i^3 dot z$, and plot all four points on one diagram.
  + Calculate the modulus of all four. What do you notice?
  + Since the moduli agree, all four points lie on something. On what?
    Draw it.
  + Describe, in one sentence and without using the word "multiply",
    what $i dot z$ does to $z$.
  + Now test your sentence on two more starting numbers of your own
    choosing -- pick one on an axis and one in a different quadrant.
    Does it still hold?
  + Finally: how does this connect to the fact, from the introduction,
    that the powers $i^n$ repeat every four steps?
]

#look-ahead(
  title: "One number, two descriptions",
  preview: [polar form],
)[
  If you did the exploration, you found that multiplying by $i$ leaves
  the distance from the origin alone and changes only the *direction*.

  That is worth sitting with, because it means the pair (real part,
  imaginary part) is not the only sensible way to pin down a complex
  number. *Distance from the origin* plus *direction* would do the job
  just as well -- and, for multiplication, do it far better. Half of
  that pair is the modulus, which we have. The other half needs a name,
  which is the next section. Together they are the polar form, and once
  we have it, multiplication becomes almost trivial.
]

== The Argument

#definition(title: "Argument")[
  The #vocab("argument", "Argument") of a complex number
  $z eq.not 0$ is the angle $phi.alt$ from the positive real axis to
  the arrow $z$, measured counterclockwise. It satisfies
  $ cos(phi.alt) = a / (|z|), quad sin(phi.alt) = b / (|z|). $
  Angles repeat every full turn, so $phi.alt$ is only determined up to
  multiples of $2 pi$. The
  #vocab("principal argument", "Hauptargument") $Arg(z)$ is the unique
  choice in the interval $(-pi, pi]$.

  The number $z = 0$ has no argument: an arrow of length zero points
  nowhere.
]

#only-theory[
  #cplane(
    xmin: -1.5,
    xmax: 4.5,
    ymin: -1.5,
    ymax: 3.5,
    caption: [Modulus and argument locate $z$ just as well as $a$ and
      $b$ do.],
    {
      cp-vector(3, 2, color: accent)
      cp-angle(0, 0, 0deg, 33.69deg, radius: 0.9, label: $phi.alt$)
      cp-point(3, 2, label: $z$, anchor: "south-west")
      cp-label(1.5, 1.4, $|z|$, color: accent, size: 10pt)
    },
  )
]

#warning[
  $phi.alt = arctan(b / a)$ is *not* a formula for the argument. The
  arctangent always returns a value in $(-pi / 2, pi / 2)$, so it can
  only ever name a direction in the right half-plane. For $z = -1 - i$
  it returns $arctan(1) = pi / 4$ -- pointing into the *first* quadrant,
  the exact opposite of where $z$ actually is.

  The arctangent cannot distinguish $z$ from $-z$, because $b / a$ is
  unchanged when both signs flip. Only your sketch can.
]

#keybox(title: "Finding the principal argument")[
  + *Sketch $z$ first.* Note which quadrant it is in, or which axis it
    is on. This step is not optional; it is the step that carries the
    information $arctan$ throws away.
  + Compute the reference angle $alpha = arctan(|b| / |a|)$, a value
    between $0$ and $pi / 2$.
  + Read off $Arg(z)$ from the quadrant:
  #v(0.3em)
  #parts(
    2,
    [1st quadrant ($a > 0$, $b > 0$): $Arg(z) = alpha$],
    [2nd quadrant ($a < 0$, $b > 0$): $Arg(z) = pi - alpha$],
    [4th quadrant ($a > 0$, $b < 0$): $Arg(z) = -alpha$],
    [3rd quadrant ($a < 0$, $b < 0$): $Arg(z) = alpha - pi$],
  )
  + Check against your sketch. If the sign or the quadrant of your
    answer disagrees with the picture, the picture is right.

  On the axes, read the answer straight off the sketch:
  $Arg = 0$ for positive reals, $pi$ for negative reals, $pi / 2$
  straight up, $-pi / 2$ straight down.
]

#example[
  Find the modulus and principal argument of $z = -1 - i$.

  *Sketch:* $a = b = -1$, so $z$ is in the third quadrant, on the
  diagonal.

  *Modulus:* $|z| = sqrt((-1)^2 + (-1)^2) = sqrt(2)$.

  *Argument:* the reference angle is $alpha = arctan(1 / 1) = pi / 4$.
  Third quadrant, so
  $ Arg(z) = alpha - pi = pi / 4 - pi = -(3 pi) / 4. $
  The sketch agrees: $-(3 pi) / 4$ is $135 degree$ clockwise from the
  positive real axis, which lands in the third quadrant.
]

#remark[
  Some books put the principal argument in $[0, 2 pi)$ instead of
  $(-pi, pi]$. Both conventions are in use and neither is more correct;
  they differ by a full turn for every $z$ below the real axis. These
  notes use $(-pi/2, pi/2]$ throughout, and so does every CAS you are
  likely to meet -- but check before trusting an answer from a
  different source.
]

#ai-box(role: "Checker")[
  Pick one complex number in each of the four quadrants -- your own
  choice, not the ones from the example -- and find $|z|$ and $Arg(z)$
  by hand, with a sketch for each.

  Now ask an AI assistant for the modulus and principal argument of the
  same four numbers, and compare line by line.

  + Did it get all four quadrants right, or did it slip on a
    third-quadrant number?
  + Ask it to *show its reasoning* for the one you find most likely to
    trip it up. Does it sketch, describe a quadrant, or does it just
    apply $arctan$?
  + If it used the $[0, 2 pi)$ convention instead of ours, is its
    answer wrong, or right in a different language? Justify.
]

#ex(difficulty: 2, time: "20 min", calculator: true)[
  Find the modulus and the principal argument of each number. Give
  exact values; sketch each one before you calculate. Use a CAS only to
  check your answers afterwards.
  #auto-parts(
    3,
    [$z = 1 + i$],
    [$z = -sqrt(3) + i$],
    [$z = -4$],
    [$z = 3i$],
    [$z = 1 - sqrt(3) dot i$],
    [$z = -2 - 2i$],
  )
][
  #auto-parts(
    3,
    [$|z| = sqrt(2)$, $Arg(z) = pi / 4$],
    [$|z| = 2$, $Arg(z) = (5 pi) / 6$],
    [$|z| = 4$, $Arg(z) = pi$],
    [$|z| = 3$, $Arg(z) = pi / 2$],
    [$|z| = 2$, $Arg(z) = -pi / 3$],
    [$|z| = 2 sqrt(2)$, $Arg(z) = -(3 pi) / 4$],
  )

  In (b) the reference angle is $arctan(1 / sqrt(3)) = pi / 6$ and $z$
  is in the second quadrant, giving $pi - pi / 6 = (5 pi) / 6$. In (f)
  the reference angle is $pi / 4$ in the third quadrant, giving
  $pi / 4 - pi = -(3 pi) / 4$. Cases (c) and (d) sit on the axes and
  need no arctangent at all.
]

== First Loci: Circles and Half-Planes

#only-theory[
  A #vocab("locus", "geometrischer Ort") is the set of all points
  satisfying a stated condition -- written in set-builder notation as
  ${z in CC | "condition"}$, read "the set of all $z$ in $CC$ such that
  the condition holds".

  The whole game is to recognize a familiar shape hiding in an
  algebraic condition, and the key that opens most of them is the one
  we noted above: *$|z_1 - z_2|$ is the distance from $z_1$ to $z_2$.*
]

#keybox(title: "Circles")[
  For a fixed $z_0 in CC$ and $r > 0$,
  $ {z in CC | |z - z_0| = r} $
  is the set of points at distance exactly $r$ from $z_0$ -- that is,
  the *circle* with center $z_0$ and radius $r$.

  Replacing $=$ by $<=$ gives the filled disc, and by $>=$ the exterior.
  A strict inequality excludes the boundary circle, which we draw
  *dashed*; a non-strict one includes it, drawn *solid*.
]

#example[
  Describe and sketch ${z in CC | |z - (1 + 2i)| = 3}$.

  The condition says: the distance from $z$ to $1 + 2i$ equals $3$. So
  it is the circle with center $1 + 2i$ and radius $3$.
]

#only-theory[
  #cplane(
    xmin: -3.5,
    xmax: 5.5,
    ymin: -2.5,
    ymax: 5.5,
    caption: [The locus ${z in CC | |z - (1 + 2i)| = 3}$.],
    {
      cp-circle(1, 2, 3, label: $1 + 2i$, anchor: "north-west")
      cp-segment((1, 2), (4, 2), color: luma(120), dashed: true)
      cp-label(2.5, 2.3, [$r = 3$], color: luma(90))
    },
  )
]

#warning[
  Watch the signs. In ${z in CC | |z + 1 + i| = 1}$ the center is
  *not* $1 + i$. Rewrite the condition to match the standard form
  first: $|z + 1 + i| = |z - (-1 - i)|$, so the center is $-1 - i$.
  A locus condition should always be forced into the shape
  $|z - z_0|$ before anything is read off it.
]

#only-theory[
  Conditions on $Re(z)$ and $Im(z)$ are even simpler, because they
  constrain one coordinate and leave the other free:
  $Re(z) = c$ is the vertical line $a = c$, and $Im(z) = c$ is the
  horizontal line $b = c$. Turn either into an inequality and the line
  becomes a *half-plane*; combine two of them with "and" and you get
  the *intersection* of the two regions.
]

#example[
  Sketch ${z in CC | Re(z) <= 3 "and" Im(z) > 2}$.

  This is everything on or to the left of the vertical line
  $Re(z) = 3$, intersected with everything strictly above the
  horizontal line $Im(z) = 2$. The first boundary is included and drawn
  solid; the second is excluded and drawn dashed.
]

#only-theory[
  #cplane(
    xmin: -4.5,
    xmax: 4.5,
    ymin: -3.5,
    ymax: 4.5,
    caption: [The locus ${z in CC | Re(z) <= 3 "and" Im(z) > 2}$. Solid
      boundary included, dashed excluded.],
    {
      cp-region((-4.5, 2), (3, 2), (3, 4.5), (-4.5, 4.5))
      cp-segment((3, -3.5), (3, 4.5), color: def-col)
      cp-segment((-4.5, 2), (3, 2), color: warn-col, dashed: true)
      cp-label(3.15, -2.6, $Re(z) = 3$, color: def-col, size: 8pt)
      cp-label(-2.6, 2.35, $Im(z) = 2$, color: warn-col, size: 8pt)
    },
  )
]

#ex(difficulty: 2, time: "25 min", keep-together: true)[
  Describe each locus in words and sketch it.
  #auto-parts(
    2,
    [${z in CC | |z| = 2}$],
    [${z in CC | |z - 2i| = 3}$],
    [${z in CC | |z + 1 + i| = 1}$],
    [${z in CC | |z| <= 3}$],
    [${z in CC | |Im(z)| <= 1}$],
    [${z in CC | z = overline(z)}$],
  )
][
  #auto-parts(
    2,
    [Circle, center $0$, radius $2$ -- the circle of radius $2$ about
      the origin.],
    [Circle, center $2i$, radius $3$.],
    [Rewrite as $|z - (-1 - i)| = 1$: circle, center $-1 - i$,
      radius $1$.],
    [The closed disc of radius $3$ about the origin, boundary
      included.],
    [$-1 <= Im(z) <= 1$: the horizontal strip of width $2$ centered on
      the real axis, both boundaries included.],
    [$z = overline(z)$ means $b = -b$, so $b = 0$: the *real axis*.],
  )

  #cplane-small(
    xmin: -4.5,
    xmax: 4.5,
    ymin: -4.5,
    ymax: 5.5,
    {
      cp-region((-4.5, -1), (4.5, -1), (4.5, 1), (-4.5, 1), color: expl-col)
      cp-circle(0, 0, 2)
      cp-circle(0, 2, 3, color: def-col)
      cp-circle(-1, -1, 1, color: warn-col)
      cp-label(2.15, 0, [(a)], color: accent, anchor: "west")
      cp-label(3.15, 2, [(b)], color: def-col, anchor: "west")
      cp-label(-2.15, -1, [(c)], color: warn-col, anchor: "east")
      cp-label(3.6, 1.15, [(e)], color: expl-col, anchor: "south")
    },
  )
]

== Extra Bits -- The Triangle Inequality

#only-theory[
  The last property in the theorem is the one that does real work
  later, and it is the only one whose proof is not a one-liner. The
  obstacle is the same as always -- a sum sitting underneath a square
  root -- and the way past it is the same as always: square both sides
  and use $|z|^2 = z dot overline(z)$.
]

#ex(difficulty: 3, time: "20 min", hints: (
  [Both sides are non-negative, so it is enough to compare their
    squares. Start from $|z + w|^2 = (z + w) dot overline((z + w))$.],
  [Expand. You should get $|z|^2 + |w|^2$ plus a middle term
    $z dot overline(w) + overline(z) dot w$. Show that middle term is
    real, and equal to $2 Re(z dot overline(w))$.],
  [For any complex number $u$ we have $Re(u) <= |u|$ -- a leg of a
    right triangle is at most as long as the hypotenuse. Apply it to
    $u = z dot overline(w)$.],
))[
  Prove the triangle inequality $|z + w| <= |z| + |w|$ for all
  $z, w in CC$.
][
  Expand the square of the left-hand side using
  $|u|^2 = u dot overline(u)$:
  $
    |z + w|^2 & = (z + w) dot (overline(z) + overline(w)) \
              & = z dot overline(z) + z dot overline(w) + w dot overline(z)
                + w dot overline(w) \
              & = |z|^2 + (z dot overline(w) + overline(z dot overline(w)))
                + |w|^2 \
              & = |z|^2 + 2 Re(z dot overline(w)) + |w|^2,
  $
  using $w dot overline(z) = overline(z dot overline(w))$ in the third
  line and $u + overline(u) = 2 Re(u)$ in the fourth.

  Now $Re(u) <= |u|$ for every $u$, and $|z dot overline(w)|
  = |z| dot |overline(w)| = |z| dot |w|$, so
  $
    |z + w|^2 <= |z|^2 + 2 dot |z| dot |w| + |w|^2
    = (|z| + |w|)^2.
  $
  Both $|z + w|$ and $|z| + |w|$ are non-negative, so taking square
  roots preserves the inequality:
  $|z + w| <= |z| + |w|$. $square$
]

#ex(difficulty: 3, time: "15 min", hints: (
  [Go back through the proof and find the one place where an
    inequality, rather than an equality, was used.],
  [That step replaced $Re(u)$ by $|u|$. When are those two equal?],
))[
  The triangle inequality is sometimes an equality. Find exactly when,
  first by looking at the picture and guessing, then by checking your
  guess against the proof above.
][
  *From the picture:* the detour from $0$ to $z$ to $z + w$ has the
  same length as the direct route exactly when there is no detour --
  when $z$ and $w$ point in the *same direction*
  (#heuristic("draw a picture")).

  *From the proof:* the only inequality used was
  $Re(u) <= |u|$ with $u = z dot overline(w)$. For
  $u = c + d dot i$, $Re(u) = |u|$ means $c = sqrt(c^2 + d^2)$, which
  forces $d = 0$ and $c >= 0$: that is, $u$ is a non-negative real.

  So equality holds exactly when $z dot overline(w)$ is a non-negative
  real number. Multiplying by $w$ and using
  $w dot overline(w) = |w|^2$, this says $z dot |w|^2 = t dot w$ for
  some $t >= 0$ -- in other words, for $w eq.not 0$, that $z = lambda
  dot w$ for some real $lambda >= 0$. The two arrows are parallel and
  point the same way, exactly as the picture predicted. (If $z = 0$ or
  $w = 0$ the equality is trivially true.)

  Note what "same direction" will mean once we have the language for
  it: $z$ and $w$ have the *same argument*.
]

#print-hints()
#print-vocab()
