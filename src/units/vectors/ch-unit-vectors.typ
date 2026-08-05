#import "../../common/preamble.typ": *
#import "/src/common/vec-figures.typ": *
#show: chapter-template.with(title: "Direction Without Distance")
#let ex = exercise.with(chapter: "Direction Without Distance")

= Direction Without Distance

#only-theory[
  A vector carries two pieces of information at once: how far, and
  which way. Most of the time that is exactly what you want. Sometimes
  it is not.

  If you want to describe the direction a road runs, its length is
  irrelevant. If you want to know how steeply a ramp climbs, the
  weight of the object on it is a separate question. This chapter is
  about pulling the two apart — extracting the direction from a vector
  and discarding the size, and then putting a chosen size back.

  It is also the chapter where the calculator finally appears. Almost
  everything else in this unit is arranged so that you can do it by
  hand, and you should. But angles are genuinely awkward: $sin 15degree$
  is not a nice number and never will be. Where the numbers are nice,
  work exactly and leave surds standing. Where they are not, the
  exercises say so.
]

#objectives(
  bfkm[find the unit vector in the direction of a given vector, and
    build a vector of any required length in that direction],
  [calculate the direction angle of a vector in the plane, taking the
    quadrant into account],
  [convert between the component form of a vector and its
    magnitude-and-angle form],
  [resolve a force into components parallel and perpendicular to a
    slope, and use this to solve ramp problems],
  [combine velocities and find the resulting speed and bearing],
)

== Vectors of Length One

#exploration(title: "Shrink them all to length one")[
  Take these three vectors:
  $
    arrow(u) = vec(3, 4), quad arrow(v) = vec(6, 8), quad
    arrow(w) = vec(-3, -4).
  $

  + Calculate $abs(arrow(u))$, $abs(arrow(v))$ and $abs(arrow(w))$.
    All three are whole numbers.

  + Divide each vector by its own magnitude — that is, calculate
    $
      1/abs(arrow(u)) dot arrow(u), quad
      1/abs(arrow(v)) dot arrow(v), quad
      1/abs(arrow(w)) dot arrow(w).
    $

  + Two of your three answers are identical, and the third is closely
    related to them. Which, and why?

  + What is the magnitude of each of the three answers? Check by
    calculating, not by guessing.

  + Sketch all three original vectors and all three results from the
    origin. What has the division done, geometrically?
]

#only-theory[
  Dividing a vector by its own magnitude produces a vector of length
  exactly $1$ pointing the same way. Doing it to $arrow(u)$ and to
  $arrow(v)$ gave the same answer because they were parallel and
  pointing the same way to begin with — the division threw away
  precisely the information that distinguished them, namely their
  length. The third vector, pointing the opposite way, gave the
  opposite result.

  A vector of length $1$ is called a #vocab("unit vector", "Einheitsvektor").
]

#definition(title: "Unit vector")[
  For any non-zero vector $arrow(a)$, the unit vector in the direction
  of $arrow(a)$ is
  $ arrow(e)_a = 1/abs(arrow(a)) dot arrow(a). $

  It has the same direction as $arrow(a)$ and magnitude $1$.
]

#only-theory[
  That the magnitude really is $1$ is worth one line of checking
  rather than taking on faith. Scaling by a number $k$ multiplies the
  length by $abs(k)$, and here $k = 1 slash abs(arrow(a))$, which is
  positive. So
  $ abs(arrow(e)_a) = 1/abs(arrow(a)) dot abs(arrow(a)) = 1. $

  The process is called #vocab("normalizing", "Normieren") the vector.

  #fig(
    vplane(
      s-vec(to: (3, 4), label: $arrow(a)$, anchor: 0.85),
      s-vec(to: (0.6, 0.8), label: $arrow(e)_a$, color: warn-col, anchor: 0.9),
      xmin: -0.5,
      xmax: 4.5,
      ymin: -0.5,
      ymax: 4.5,
      unit: 0.7cm,
    ),
    caption: [$arrow(a) = vec(3, 4)$ has magnitude $5$, so
      $arrow(e)_a = vec(0.6, 0.8)$ — same direction, length one.],
  )

  Unit vectors are how you say "this way" without saying "this far",
  and once you have one, any length you like is a single multiplication
  away.
]

#keybox(title: "A vector of prescribed length")[
  The vector of length $L$ in the direction of $arrow(a)$ is
  $ L dot arrow(e)_a = L/abs(arrow(a)) dot arrow(a). $
]

#only-theory[
  For example, a vector of length $15$ in the direction of
  $arrow(b) = vec(1, -2, 2)$: first $abs(arrow(b)) = sqrt(1 + 4 + 4) = 3$,
  so
  $
    15 dot arrow(e)_b = 15/3 dot vec(1, -2, 2) = 5 dot vec(1, -2, 2)
    = vec(5, -10, 10).
  $
  A check costs one line: $sqrt(25 + 100 + 100) = sqrt(225) = 15$.
]

#remark[
  Notice which vectors made that calculation pleasant. The magnitude
  came out whole because $1^2 + 2^2 + 2^2 = 9$, and the division was
  then exact.

  You met the same short list in the previous chapters — $(3, 4)$,
  $(1, 2, 2)$, $(2, 3, 6)$, $(4, 3, 12)$ — and it is no accident that
  they keep reappearing. When a problem is designed to be done without
  a calculator, the vectors in it were chosen from a very small
  supply. Recognising them tells you something useful: that an exact
  answer is expected.
]

== Direction Angles

#only-theory[
  In the plane there is a second way to say which way a vector points:
  give the angle it makes with the positive $x$#"‑"axis.
]

#definition(title: "Direction angle")[
  The #vocab("direction angle", "Richtungswinkel") $alpha$ of a vector
  in the plane is the angle from the positive $x$#"‑"axis to the
  vector, measured counterclockwise, with
  $0degree <= alpha < 360degree$.
]

#only-theory[
  #fig(
    vplane(
      s-vec(to: (3.5, 2), label: $arrow(a)$),
      s-arc(
        vertex: (0, 0),
        from: (2, 0),
        to: (3.5, 2),
        r: 26pt,
        label: $alpha$,
      ),
      s-seg(from: (0, 0), to: (4.2, 0), color: luma(140)),
      xmin: -0.5,
      xmax: 4.5,
      ymin: -0.5,
      ymax: 3.5,
      unit: 0.7cm,
      grid: false,
      axes: false,
    ),
  )

  The components and the angle are linked by the right triangle the
  vector closes. With $abs(arrow(a)) = r$,
  $
    a_x = r cos alpha, quad a_y = r sin alpha,
    quad "and therefore" quad tan alpha = a_y / a_x.
  $

  Read the first two from left to right and you can build a vector out
  of a length and a bearing. Read the third one and you can recover
  the angle from the components — but only with care.
]

#look-back(recalls: [sine, cosine and tangent on the unit circle])[
  This is the same relationship you met in trigonometry, seen from the
  other side. There, a point on the unit circle at angle $alpha$ had
  coordinates $(cos alpha, sin alpha)$. Here, the unit vector in the
  direction of $arrow(a)$ *is* that point's position vector:
  $ arrow(e)_a = vec(cos alpha, sin alpha). $

  So normalizing a vector and reading off its direction angle are two
  descriptions of one operation. Every identity you know about sine
  and cosine is available here without modification.
]

#warning[
  Your calculator's $arctan$ (or $tan^(-1)$) always returns an angle
  between $-90degree$ and $90degree$. That covers the right half of
  the plane and nothing else, so for any vector pointing left it gives
  the *wrong* answer — off by exactly $180degree$.

  Take $arrow(a) = vec(-3, 3)$. Then $tan alpha = 3 slash (-3) = -1$,
  and the calculator reports $-45degree$. But $arrow(a)$ points up and
  to the left, into the second quadrant, so the true direction angle
  is $135degree$.

  The fix is not a formula to memorise. It is a *sketch*: draw the
  vector roughly, decide which quadrant it is in, and then check
  whether the calculator's answer is in that quadrant. If it is not,
  add $180degree$ — and if the result is negative, add $360degree$.
]

#only-theory[
  Two worked cases, both exact.

  *$arrow(a) = vec(2, 2)$.* First quadrant, and $tan alpha = 1$, so
  $alpha = 45degree$. The calculator would have agreed.

  *$arrow(b) = vec(-3, 3)$.* Second quadrant, and $tan alpha = -1$.
  The calculator says $-45degree$; that angle points into the fourth
  quadrant, which is wrong, so add $180degree$ to get
  $alpha = 135degree$. A sketch confirms it: the vector bisects the
  second quadrant.

  Where a vector lies along an axis, no calculation is needed at all.
  $vec(5, 0)$ has direction angle $0degree$, $vec(0, 3)$ has
  $90degree$, $vec(-2, 0)$ has $180degree$, and $vec(0, -7)$ has
  $270degree$.
]

== From Angle Back to Components

#only-theory[
  The reverse conversion has no traps in it. Given a magnitude $r$ and
  a direction angle $alpha$,
  $
    arrow(a) = r dot vec(cos alpha, sin alpha)
    = vec(r cos alpha, r sin alpha).
  $

  If $alpha$ is one of the standard angles, the answer stays exact.
  A vector of magnitude $10$ at $60degree$:
  $
    arrow(a) = 10 dot vec(cos 60degree, sin 60degree)
    = 10 dot vec(1 slash 2, sqrt(3) slash 2)
    = vec(5, 5 sqrt(3)).
  $

  If it is not, the answer is a decimal and you round at the end —
  never in the middle.
]

#keybox(title: "The two forms")[
  $
    underbrace(vec(a_x, a_y), "components")
    quad arrow.l.r.long quad
    underbrace((r, alpha), "magnitude and direction")
  $
  $
    r = sqrt(a_x^2 + a_y^2), quad tan alpha = a_y / a_x
    quad quad quad
    a_x = r cos alpha, quad a_y = r sin alpha
  $
]

== Forces on a Slope

#only-theory[
  Here is where unit vectors and direction angles start paying for
  themselves.

  A boat sits on a slipway inclined at an angle $alpha$ to the
  horizontal. Gravity pulls it straight down with a force $arrow(G)$,
  whose magnitude is the boat's weight. Straight down is not along the
  slope, so only part of that force tries to drag the boat downhill;
  the rest presses it into the ramp.

  Splitting $arrow(G)$ into those two parts is called
  #vocab("resolving", "Zerlegen") the force. The two parts are chosen
  perpendicular to each other: one *parallel* to the slope, one
  *perpendicular* to it.

  #fig(
    vplane(
      s-seg(from: (0, 0), to: (6, 3.46), color: luma(90), width: 1.1pt),
      s-seg(from: (0, 0), to: (6, 0), color: luma(150)),
      s-seg(from: (6, 0), to: (6, 3.46), color: luma(150), dashed: true),
      s-arc(
        vertex: (0, 0),
        from: (6, 0),
        to: (6, 3.46),
        r: 30pt,
        label: $alpha$,
      ),
      s-vec(from: (3, 1.73), to: (3, -0.27), label: $arrow(G)$, color: accent),
      s-vec(
        from: (3, 1.73),
        to: (2.13, 1.23),
        label: $arrow(G)_(∥)$,
        color: warn-col,
        gap: 13pt,
      ),
      s-vec(
        from: (3, 1.73),
        to: (3.87, 0.23),
        label: $arrow(G)_(⊥)$,
        color: def-col,
        gap: 13pt,
      ),
      s-seg(from: (2.13, 1.23), to: (3, -0.27), color: luma(180), dashed: true),
      s-seg(from: (3.87, 0.23), to: (3, -0.27), color: luma(180), dashed: true),
      s-pt((3, 1.73), r: 2pt),
      xmin: -0.5,
      xmax: 7.5,
      ymin: -1.5,
      ymax: 4.5,
      unit: 0.62cm,
      grid: false,
      axes: false,
    ),
    caption: [The weight $arrow(G)$ resolved into a component along the
      slope and a component pressing into it. The two components and
      $arrow(G)$ form a right triangle.],
  )
]

#only-theory[
  The angle at the base of the ramp reappears inside that little right
  triangle — a fact worth checking rather than believing, since the
  whole result rests on it. The component $arrow(G)_(⊥)$ is
  perpendicular to the slope, and $arrow(G)$ is perpendicular to the
  horizontal. Two lines perpendicular to two lines that meet at
  $alpha$ themselves meet at $alpha$. So the angle between $arrow(G)$
  and $arrow(G)_(⊥)$ is exactly the slope angle.

  In that right triangle $arrow(G)$ is the hypotenuse, so
  $
    abs(arrow(G)_(∥)) = abs(arrow(G)) dot sin alpha, quad quad
    abs(arrow(G)_(⊥)) = abs(arrow(G)) dot cos alpha.
  $
]

#keybox(title: "A body on a slope")[
  For a body of weight $G$ resting on a slope inclined at $alpha$:
  - the force pulling it down the slope is $G sin alpha$,
  - the force pressing it into the slope is $G cos alpha$.

  To hold the body still (ignoring friction), a force of $G sin alpha$
  up the slope is required.
]

#only-theory[
  *Example.* What force is needed to hold a boat weighing $800$ N on a
  slipway inclined at $30degree$, ignoring friction?

  $ F = 800 dot sin 30degree = 800 dot 1/2 = 400 " N". $

  No calculator, because $30degree$ is a standard angle. Half the
  weight — which is a useful sanity check on the whole model: the
  required force is never more than the weight itself, since
  $sin alpha <= 1$, and it shrinks to nothing as the slope flattens.
  Both of those match what a ramp actually feels like.
]

#exploration(title: "Why ramps are long")[
  A doorway is $40$ cm above the pavement. A wheelchair user can push
  with a force of about $300$ N, and the combined weight of chair and
  user is about $1200$ N.

  + What is the steepest slope they can manage unaided? Give the
    relationship first, as an equation, before reaching for a
    calculator.

  + How long does the ramp have to be to climb $40$ cm at that slope?

  + The second answer comes out exactly, with no rounding, even though
    the first one does not. Why?

  + Building regulations in most countries require ramps *shallower*
    than the slope you have just calculated. Suggest two reasons.
]

#look-ahead(preview: [distances from a point to a line or plane])[
  Resolving a vector into a part along a given direction and a part
  perpendicular to it is not only about ramps. It is one of the most
  reused ideas in the whole unit.

  Later you will want the distance from a point to a plane. The answer
  will be: take the vector from the plane to the point, and resolve it
  into a part lying in the plane and a part perpendicular to it. The
  perpendicular part is the distance. The tool that does the resolving
  in general — for any two directions, not just horizontal and
  vertical — is the dot product, and it is the subject of the next
  chapter.
]

#ex(difficulty: 1, time: "10 min", calculator: false)[
  Find the unit vector in the direction of each of the following.

  #auto-parts(
    3,
    [$vec(3, 4)$],
    [$vec(6, 8)$],
    [$vec(0, -5)$],
    [$vec(1, -2, 2)$],
    [$vec(2, 3, 6)$],
    [$vec(-4, 0, 3)$],
  )

  Two of your six answers are the same. Explain why without
  recalculating.
][
  #auto-parts(
    3,
    [$vec(3 slash 5, 4 slash 5)$],
    [$vec(3 slash 5, 4 slash 5)$],
    [$vec(0, -1)$],
    [$vec(1 slash 3, -2 slash 3, 2 slash 3)$],
    [$vec(2 slash 7, 3 slash 7, 6 slash 7)$],
    [$vec(-4 slash 5, 0, 3 slash 5)$],
  )

  (a) and (b) agree because $vec(6, 8) = 2 dot vec(3, 4)$ — the two
  vectors are parallel and point the same way, so they have the same
  direction, and direction is all a unit vector records.

  Every answer can be checked in one line: the squares of the
  components must add to $1$. For (e), $4 slash 49 + 9 slash 49 +
  36 slash 49 = 1$.
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  #auto-parts(
    1,
    [Find the vector of length $21$ in the direction of
      $vec(2, 3, 6)$.],
    [Find the vector of length $10$ pointing in the direction
      *opposite* to $vec(3, -4)$.],
    [A vector has magnitude $6$ and is parallel to $vec(1, -2, 2)$.
      Write down every possibility.],
  )
][
  #auto-parts(
    1,
    [$abs(vec(2, 3, 6)) = 7$, so the answer is
      $21 slash 7 = 3$ times the vector: $vec(6, 9, 18)$.],
    [$abs(vec(3, -4)) = 5$, so $10 dot arrow(e) = 2 dot vec(3, -4)
      = vec(6, -8)$; reversing gives $vec(-6, 8)$.],
    [Two of them. The magnitude is $3$, so the scale factor is
      $plus.minus 2$:
      $vec(2, -4, 4)$ and $vec(-2, 4, -4)$.

      "Parallel" does not fix the direction along the line, only the
      line itself — which is why the answer is a pair.],
  )
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  Find the direction angle of each vector. Parts (a) to (e) come out
  exactly; sketch each one before you calculate.

  #auto-parts(
    3,
    [$vec(4, 0)$],
    [$vec(0, 3)$],
    [$vec(2, 2)$],
    [$vec(-3, 3)$],
    [$vec(-1, -1)$],
    [$vec(5, -5)$],
  )
][
  #auto-parts(
    3,
    [$0degree$],
    [$90degree$],
    [$45degree$],
    [$135degree$],
    [$225degree$],
    [$315degree$],
  )

  Parts (d), (e) and (f) all have $abs(tan alpha) = 1$, and a
  calculator reports $-45degree$, $45degree$ and $-45degree$
  respectively. Only one of those three is the direction angle. The
  sketch is what tells you which.

  For (e): the vector points down and left, so it lies in the third
  quadrant, between $180degree$ and $270degree$ — and $225degree$ is
  the only candidate. For (f): down and right, fourth quadrant, so
  $-45degree$ becomes $315degree$.
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Write each vector in component form.

  #auto-parts(
    3,
    [$r = 10$, $alpha = 60degree$],
    [$r = 8$, $alpha = 135degree$],
    [$r = 6$, $alpha = 270degree$],
  )
][
  #auto-parts(
    3,
    [$vec(5, 5 sqrt(3))$],
    [$vec(-4 sqrt(2), 4 sqrt(2))$],
    [$vec(0, -6)$],
  )

  For (b): $cos 135degree = -sqrt(2) slash 2$ and
  $sin 135degree = sqrt(2) slash 2$, so both components are
  $8 dot (plus.minus sqrt(2) slash 2) = plus.minus 4 sqrt(2)$.

  As a check, the magnitude must come back out: for (b),
  $sqrt(32 + 32) = sqrt(64) = 8$.
]

#ex(difficulty: 2, time: "8 min", calculator: true)[
  Write each vector in component form, rounding to one decimal place.

  #auto-parts(
    2,
    [$r = 310$, $alpha = 62degree$],
    [$r = 43.2$, $alpha = 19.6degree$],
  )
][
  #auto-parts(
    2,
    [$vec(310 cos 62degree, 310 sin 62degree) approx vec(145.5, 273.7)$],
    [$vec(43.2 cos 19.6degree, 43.2 sin 19.6degree) approx vec(40.7, 14.5)$],
  )

  Round only at the very end. Rounding $cos 62degree$ to two places
  first and then multiplying by $310$ shifts the answer by about half
  a unit — enough to matter.
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  A crate weighing $1500$ N rests on a ramp, friction ignored.

  #auto-parts(
    1,
    [What force, directed up the slope, holds it in place when the
      ramp is inclined at $30degree$?],
    [At what angle does the required force equal exactly half the
      weight? And a quarter of it?],
    [Explain, without calculating, why the required force can never
      exceed the weight of the crate.],
  )
][
  #auto-parts(
    1,
    [$F = 1500 sin 30degree = 750$ N.],
    [Half the weight means $sin alpha = 1 slash 2$, so
      $alpha = 30degree$ — which is part (a) again. A quarter means
      $sin alpha = 1 slash 4$, which is not a standard angle;
      $alpha = arcsin(0.25) approx 14.5degree$.],
    [The required force is $G sin alpha$, and $sin alpha <= 1$ for
      every angle, so $G sin alpha <= G$. Equality would need
      $alpha = 90degree$ — a vertical "ramp", where holding the crate
      on the slope and simply holding it up are the same task.],
  )
]

#ex(difficulty: 3, time: "15 min", calculator: true, hints: (
  "Draw the situation first. Which direction does a wind 'from the south-west' actually blow towards?",
  "Take north as the positive y-direction and east as the positive x-direction, then write both velocities as column vectors.",
  "The resulting velocity is the sum. Its magnitude is the speed; its direction angle, measured from north, is the bearing.",
))[
  A ship is steaming due north at $20$ km/h. A wind blowing from
  $30degree$ west of south pushes it at $5$ km/h.

  Find the ship's resulting speed, and the direction in which it is
  actually travelling.
][
  A wind *from* $30degree$ west of south blows *towards* $30degree$
  east of north. Taking east as $x$ and north as $y$:
  $
    arrow(v)_"ship" = vec(0, 20), quad
    arrow(v)_"wind" = 5 dot vec(sin 30degree, cos 30degree)
    = vec(2.5, 5 sqrt(3) slash 2) approx vec(2.5, 4.33).
  $

  Adding,
  $
    arrow(v) = vec(2.5, 24.33), quad
    abs(arrow(v)) = sqrt(2.5^2 + 24.33^2) approx 24.5 " km/h".
  $

  For the direction, the angle east of north satisfies
  $
    tan theta = 2.5 / 24.33 = 0.1028 arrow.r.double
    theta approx 5.9degree.
  $

  So the ship makes about $24.5$ km/h on a bearing of roughly
  $5.9degree$ east of north.

  Note that the angle was measured from *north*, not from the positive
  $x$#"‑"axis — bearings at sea are quoted that way. The mathematics is
  identical; only the reference direction changed. Always say which
  one you used.
]

#ex(difficulty: 3, time: "12 min", calculator: true)[
  Complete the wheelchair ramp calculation from the exploration.

  A doorway is $40$ cm above the pavement. Chair and user together
  weigh $1200$ N, and the user can push with $300$ N.

  #auto-parts(
    1,
    [Find the steepest angle the user can manage.],
    [Find the length of a ramp climbing $40$ cm at that angle.],
    [A regulation limits ramps to a gradient of $1 : 12$. How long
      must the ramp be then, and what force does the user need?],
  )
][
  #auto-parts(
    1,
    [$1200 sin alpha = 300$, so $sin alpha = 1 slash 4$ and
      $alpha approx 14.5degree$.],
    [The ramp is the hypotenuse of a right triangle of height $40$ cm,
      so its length $L$ satisfies $L sin alpha = 40$, giving
      $ L = 40 / sin alpha = 40 / (1 slash 4) = 160 " cm". $
      Exactly $160$ cm, with no rounding anywhere — because
      $sin alpha$ was exactly $1 slash 4$ even though $alpha$ itself
      was not a nice angle. The awkwardness was entirely in the
      angle, and the angle was never needed.],
    [A gradient of $1 : 12$ means a rise of $1$ for every $12$ along
      the ground, so $tan alpha = 1 slash 12$ and
      $alpha approx 4.76degree$. The ramp length is
      $40 / sin(4.76degree) approx 482$ cm, almost $5$ metres, and the
      force needed is
      $1200 sin(4.76degree) approx 100$ N — a third of what the user
      can manage.

      That is the answer to the last part of the exploration: the
      regulation is not set at the limit of what is *possible* but at
      what is comfortable and repeatable, with margin for wet
      surfaces, tiredness, and users weaker than average.],
  )
]

#only-high[
  #ex(difficulty: 3, time: "14 min", calculator: true)[
    In space a single angle is not enough to fix a direction. Instead
    a vector $arrow(a)$ has three
    #vocab("direction angles", "Richtungswinkel", show-de: false)
    $alpha$, $beta$, $gamma$ — the angles it makes with the positive
    $x$#"‑", $y$#"‑" and $z$#"‑"axes.

    #auto-parts(
      1,
      [Explain why $arrow(e)_a = vec(cos alpha, cos beta, cos gamma)$.],
      [Deduce that
        $cos^2 alpha + cos^2 beta + cos^2 gamma = 1$ for every vector.],
      [Find the three direction angles of $arrow(a) = vec(2, 3, 6)$.],
      [Can a vector in space make an angle of $45degree$ with all
        three axes? Justify your answer.],
    )
  ][
    #auto-parts(
      1,
      [The $x$#"‑"component of $arrow(e)_a$ is how far $arrow(e)_a$
        reaches in the $x$#"‑"direction. Since $arrow(e)_a$ has length
        $1$, that reach is the adjacent side of a right triangle with
        hypotenuse $1$ and angle $alpha$ — so it equals $cos alpha$.
        The same argument applies to the other two axes.],
      [$arrow(e)_a$ is a unit vector, so the squares of its components
        add to $1$. Substituting the components from (a) gives the
        identity immediately.],
      [$abs(arrow(a)) = 7$, so
        $arrow(e)_a = vec(2 slash 7, 3 slash 7, 6 slash 7)$ and
        $
          alpha = arccos(2 slash 7) approx 73.4degree, quad
          beta = arccos(3 slash 7) approx 64.6degree, quad
          gamma = arccos(6 slash 7) approx 31.0degree.
        $
        Check: $4 slash 49 + 9 slash 49 + 36 slash 49 = 1$, as it must.],
      [No. Three angles of $45degree$ would give
        $3 cos^2 45degree = 3 dot 1/2 = 3/2 eq.not 1$.

        The identity in (b) is a genuine constraint: the three
        direction angles are not independent, and choosing two of them
        fixes the third up to sign. The largest angle a vector can make
        with all three axes simultaneously satisfies
        $3 cos^2 theta = 1$, giving $theta approx 54.7degree$ — the
        direction of the cube's space diagonal, which you have already
        met.],
    )
  ]
]

#print-hints()
#print-vocab()
