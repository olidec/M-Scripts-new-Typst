// ============================================================
//  ch-unit-circle.typ — Chapter: The Unit Circle and Radians
//  Trigonometry unit, chapter 3 (shared GLF/SPF, year 1).
//  Converted from trigonometry_lecture.tex §3 (Ex 28–35), plus the
//  circle-sector exercise (old Ex 16) moved here from §2 — it needs
//  radians, so it could not stay in ch-right-triangles.
//
//  Images expected in images/ (exported from the old img/ folder):
//    trig14_5 → unit-circle-arc.png
//    trig14_4 → angle-rays-vertex.png
//    trig14_8 → unit-circle-coordinates.png
//    tri7     → circle-sectors.png            (old Ex 16)
// ============================================================

#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "The Unit Circle and Radians")
#let ex = exercise.with(chapter: "Unit Circle")

= The Unit Circle and Radians

#only-theory[
  So far $sin(phi.alt)$, $cos(phi.alt)$, and $tan(phi.alt)$ have been
  ratios of sides in a right triangle. That definition served us well,
  but it has a hard ceiling built into it: a right triangle cannot
  contain an angle of $120 degree$, so $sin(120 degree)$ is, so far,
  meaningless. Yet your calculator answers it without hesitation. This
  chapter explains what it is answering -- by moving the whole
  construction onto a circle, where nothing stops the angle from
  turning as far as it likes.
]

#objectives(
  bfkm[define the trigonometric functions on the unit circle and
    describe their properties],
  [convert between degree measure and radian measure in both
    directions],
  [compute arc lengths, sector areas, and segment areas of a circle],
  bfkm[read $cos(phi.alt)$ and $sin(phi.alt)$ as the coordinates of a
    point on the unit circle, for any angle],
  [justify the identities $sin^2(phi.alt) + cos^2(phi.alt) = 1$ and
    $tan(phi.alt) = sin(phi.alt) \/ cos(phi.alt)$ from the unit
    circle],
  [derive the exact values of sine, cosine, and tangent at
    $30 degree$, $45 degree$, and $60 degree$ rather than recalling
    them],
  obj(level: "high")[explain the symmetry identities
    $sin(-phi.alt) = -sin(phi.alt)$, $cos(-phi.alt) = cos(phi.alt)$,
    and $cos(phi.alt) = sin(90 degree - phi.alt)$ geometrically],
)

== Angles, Rays, and Vertices

#only-theory[
  Before measuring angles a second way, it is worth being precise about
  what is being measured.
]

#definition(title: "Angle")[
  An #vocab("angle", "Winkel") is created when two rays meet at a
  point. The two rays are called the #vocab("sides", "Schenkel") of the
  angle, and the point is called its #vocab("vertex", "Scheitelpunkt").
]

#fig(image("images/angle-rays-vertex.pdf", width: 45%))

#only-theory[
  Notice what an angle is _not_: it is not a distance, and the rays are
  infinite, so it carries no length information at all. An angle is a
  measure of _rotation_ -- of how far one ray has been turned away from
  the other. The degree, with its $360$ divisions, is one convention for
  reporting that rotation. It is a good one; it is not the only one, and
  it is not the most natural one.
]

== The Unit Circle and Radians

#only-theory[
  The #vocab("unit circle", "Einheitskreis") is the circle of radius
  $1$, drawn in a coordinate system centered at the origin $(0, 0)$.
]

#fig(image("images/unit-circle-arc.pdf", width: 45%))

#only-theory[
  Place the angle $phi.alt$ at the center, with one side along the
  positive $x$\u{2011}axis. The second side cuts the circle, and between
  the two sides lies an arc of some length $s$. Turn the angle further
  and the arc gets longer; turn it back and the arc gets shorter. The
  arc length and the angle rise and fall together -- so the arc length
  can simply _be_ the angle measure.
]

#definition(title: "Radian")[
  The #vocab("radian", "Radiant") measure of an angle is the length $s$
  of the arc that the angle cuts out of the unit circle.
]

#keybox(title: "Converting between degrees and radians")[
  A full turn is $360 degree$, and the whole circumference of the unit
  circle is $2 pi dot 1 = 2 pi$. So the two measures are related by
  $ 360 degree = 2 pi quad "or" quad 180 degree = pi. $
  From this, every conversion is one multiplication:
  $
    phi.alt_"rad" = phi.alt_"deg" dot pi / 180 quad "and" quad
    phi.alt_"deg" = phi.alt_"rad" dot 180 / pi.
  $
]

#remark[
  Radian measure has no unit attached -- it is a length divided by a
  length, so the units cancel. This is why you will see $sin(2)$ with
  no degree symbol and no "rad" written anywhere: the bare number _is_
  the radian measure. When in doubt about which one is meant, remember
  that a full turn is only $6.28$ radians, so any angle bigger than
  about $7$ written without a symbol is almost certainly a mistake.
]

#look-ahead(
  title: "Why anyone bothers with radians",
  preview: [differential calculus (the derivative)],
)[
  Right now radians look like a second convention doing the same job as
  degrees, with uglier numbers -- $pi\/6$ instead of a clean $30$. So
  why does every mathematician past this point use them?

  Here is the honest answer, which you cannot fully appreciate yet: in
  radians, and _only_ in radians, the derivative of $sin$ is exactly
  $cos$. Measure in degrees and a stray factor of $pi\/180$ attaches
  itself to every single derivative you will ever take, forever. The
  ugly numbers now buy clean ones later. File this away -- when you meet
  it in the calculus unit, it should read as a promise kept.
]

#ex(difficulty: 1, time: "10 min")[
  Find the exact radian measure of each angle given in degree measure.
  #auto-parts(
    3,
    [$60 degree$],
    [$150 degree$],
    [$-270 degree$],
    [$36 degree$],
    [$135 degree$],
    [$50 degree$],
    [$-45 degree$],
    [$400 degree$],
    [$-480 degree$],
  )
][
  #auto-parts(
    3,
    [$pi/3$],
    [$(5 pi)/6$],
    [$-(3 pi)/2$],
    [$pi/5$],
    [$(3 pi)/4$],
    [$(5 pi)/18$],
    [$-pi/4$],
    [$(20 pi)/9$],
    [$-(8 pi)/3$],
  )
]

#ex(difficulty: 1, time: "10 min")[
  Find the degree measure of each angle given in radians. If possible
  give the exact value, otherwise round to three significant figures.
  #auto-parts(
    3,
    [$(3 pi)/4$],
    [$-(7 pi)/2$],
    [$2$],
    [$(7 pi)/6$],
    [$-2.5$],
    [$(5 pi)/3$],
    [$pi/12$],
    [$1.57$],
    [$(8 pi)/3$],
  )
][
  #auto-parts(
    3,
    [$135 degree$],
    [$-630 degree$],
    [$approx 115 degree$],
    [$210 degree$],
    [$approx -143 degree$],
    [$300 degree$],
    [$15 degree$],
    [$approx 90.0 degree$],
    [$480 degree$],
  )
]

#remark[
  Part (h) is worth a second look. $1.57$ is _not_ $90 degree$ -- it is
  $89.95 degree$, and it only rounds to $90.0 degree$ because you were
  asked for three significant figures. The exact right angle is
  $pi\/2 = 1.5707963...$, a number with no finite decimal expansion.
  Every "$1.57$" you meet in a physics formula is an approximation
  someone decided was good enough.
]

== Arcs, Sectors, and Segments

#only-theory[
  The unit circle fixed the radius at $1$ to keep the definition clean.
  Real circles come in all sizes, and scaling the radius scales the arc
  with it -- similarity once more. For a circle of radius $r$, an angle
  of $phi.alt$ radians at the center therefore cuts an arc of length
  $r dot phi.alt$, not $phi.alt$.
]

#keybox(title: "Arc, sector, and segment")[
  For a circle of radius $r$ and a central angle of $phi.alt$
  #emph[in radians]:
  $
            "arc length" quad b & = r dot phi.alt \
     "sector area" quad A_"sec" & = 1/2 dot r^2 dot phi.alt \
    "segment area" quad A_"seg" & = 1/2 dot r^2 dot (phi.alt - sin(phi.alt))
  $
  The #vocab("sector", "Kreissektor") is the pizza slice bounded by two
  radii and the arc. The #vocab("segment", "Kreisabschnitt") is the
  smaller piece bounded by the #vocab("chord", "Sehne") and the arc --
  the slice with its triangle cut off, which is exactly where the
  $-sin(phi.alt)$ comes from.
]

#warning[
  These formulas hold #emph[only] in radians. In degrees they need a
  $phi.alt \/ 360$ factor instead:
  $A_"sec" = (phi.alt \/ 360) dot pi dot r^2$. Mixing the two is the
  single most common way to get a sector problem wrong -- decide which
  measure you are working in _before_ you start, and write it down.
]

#exploration(title: "Where the Segment Formula Comes From")[
  Do not take the segment formula on trust -- rebuild it. Draw a circle
  of radius $r$ with a central angle $phi.alt$. The segment is the
  sector with a triangle removed. Which triangle? What is its area, in
  terms of $r$ and $phi.alt$? Subtract, and see whether you land on
  $1/2 dot r^2 dot (phi.alt - sin(phi.alt))$. Then check your formula
  against the extreme case $phi.alt = pi$: what should the answer be,
  and does your formula agree? #heuristic("check an extreme or special case")
]

#ex(
  difficulty: 2,
  time: "20 min",
  keep-together: true,
  hints: (
    [Each part uses a different one of the three formulas above --
      identify which before you compute anything.],
    [In (a) you are given the area and want the angle: set up the
      sector-area formula and solve for $phi.alt$.],
    [In (b) the perimeter of a segment is not the arc alone -- walk all
      the way around the region and see what you cross.
      #heuristic("draw a picture")],
  ),
)[
  Calculate the requested quantity for each circle.
  #fig(image("images/circle-sectors.pdf", width: 90%))
  #auto-parts(
    3,
    [$r = 32$ cm, shaded (sector) area $= #num(1787)$ $"cm"^2$.
      Find $alpha$.],
    [$r = 6$ cm, $alpha = pi\/4$. Find the perimeter of the shaded
      segment.],
    [$r = 24$ cm, $alpha = 60 degree$. Find the shaded segment area.],
  )
][
  #auto-parts(
    3,
    [In degrees, $(alpha \/ 360) dot pi dot 32^2 = #num(1787)$, so
      $alpha = (#num(1787) dot 360) \/ (pi dot #num(1024)) approx 200 degree$.],
    [The boundary of a segment is the arc _plus_ the chord:
      $b = 6 dot pi\/4 approx 4.71$ cm and the chord is
      $2 dot 6 dot sin(pi\/8) approx 4.59$ cm, giving
      $approx 9.30$ cm.],
    [$60 degree = pi\/3$, so
      $A_"seg" = 1/2 dot 24^2 dot (pi\/3 - sin(pi\/3)) approx 52.2$ $"cm"^2$.],
  )
]

== Sine and Cosine as Coordinates

#only-theory[
  Now for the move that lifts the ceiling. Take the unit circle again,
  and let the angle $phi.alt$ (measured from the positive
  $x$\u{2011}axis, counterclockwise) pick out a point
  $P = (x_P, y_P)$ on it.
]

#fig(image("images/unit-circle-coordinates.pdf", width: 45%))

#only-theory[
  Drop a perpendicular from $P$ to the $x$\u{2011}axis. This builds a
  right triangle whose hypotenuse is the radius -- so it has length
  exactly $1$. Apply the old definitions to it:
  $
    cos(phi.alt) = "adjacent" / "hypotenuse" = x_P / 1 = x_P,
    quad
    sin(phi.alt) = "opposite" / "hypotenuse" = y_P / 1 = y_P.
  $
  The dividing by $1$ is the whole trick, and it is why the radius was
  chosen to be $1$ in the first place.
]

#keybox(title: "The unit-circle definition")[
  For _any_ angle $phi.alt$ whatsoever, let $P$ be the point where the
  angle's second side meets the unit circle. Then
  $ P = (cos(phi.alt), sin(phi.alt)). $
  This agrees with the right-triangle definition wherever the old one
  applied -- and unlike it, it keeps working for $120 degree$, for
  $0 degree$, for $-45 degree$, and for $#num(1000) degree$.
]

#remark[
  Nothing was thrown away here. The right-triangle definition was not
  wrong; it was a special case, visible only in the first quadrant. This
  is a pattern worth noticing, because it will happen to you again and
  again in mathematics: a definition that works gets _extended_ to a
  place it did not previously reach, in the one way that keeps the old
  cases intact.
]

#exploration(title: "Two Angles, One Sine")[
  Can you find two _different_ angles with the same sine? Two different
  angles with the same cosine? Once you have found one such pair, find
  a second pair, then a third -- and then describe the pattern in
  general. How many angles share a given sine value in total? Use the
  circle, not the calculator: the answer is visible in the picture.
]

#ex(difficulty: 2, time: "15 min", hints: (
  [For $45 degree$, the point $P$ sits on the line $y = x$. What does
    that tell you about $x_P$ and $y_P$? Combine it with the fact that
    $P$ is on the circle, so $x_P^2 + y_P^2 = 1$.],
  [For $60 degree$, drop the perpendicular from $P$ and look at the
    triangle formed by $P$, the origin, and $(1, 0)$. All three sides
    are radii or... check its angles. What kind of triangle is it?],
))[
  Use the unit circle to explain why
  $ sin(45 degree) = sqrt(2)/2 quad "and" quad cos(60 degree) = 1/2. $
][
  *The $45 degree$ case.* At $45 degree$ the point $P$ lies on the
  bisector $y = x$, so $x_P = y_P$. Since $P$ lies on the unit circle,
  $x_P^2 + y_P^2 = 1$, hence $2 y_P^2 = 1$ and
  $y_P = 1\/sqrt(2) = sqrt(2)\/2$. As $sin(45 degree) = y_P$, this is
  the claim.

  *The $60 degree$ case.* Let $O$ be the origin, $A = (1, 0)$, and $P$
  the point at $60 degree$. Then $O A$ and $O P$ are both radii, so the
  triangle $O A P$ is isosceles, and its apex angle at $O$ is
  $60 degree$. The two base angles are therefore equal and sum to
  $120 degree$, so each is $60 degree$ -- the triangle is
  *equilateral*, and $A P = 1$ as well. The foot of the perpendicular
  from $P$ is thus the midpoint of $O A$, giving $x_P = 1/2$. As
  $cos(60 degree) = x_P$, this is the claim.
  #heuristic("look for what stays the same")
]

#ex(difficulty: 2, time: "15 min")[
  Use the unit circle to explain the following identities, for all
  angles $phi.alt$:
  #auto-parts(
    1,
    [$sin^2(phi.alt) + cos^2(phi.alt) = 1$,],
    [$tan(phi.alt) = sin(phi.alt) / cos(phi.alt)$.],
  )
][
  #auto-parts(
    1,
    [The point $P = (cos(phi.alt), sin(phi.alt))$ lies on the unit
      circle, and the unit circle is exactly the set of points at
      distance $1$ from the origin. By the Pythagorean theorem that
      distance is $sqrt(x_P^2 + y_P^2)$, so
      $cos^2(phi.alt) + sin^2(phi.alt) = 1^2 = 1$. The identity is
      nothing but the Pythagorean theorem, written in the circle's
      own coordinates -- which is why it is called the *Pythagorean
      identity*.],
    [In the right triangle under $P$, the opposite side has length
      $y_P = sin(phi.alt)$ and the adjacent side $x_P = cos(phi.alt)$.
      So
      $
        tan(phi.alt) = "opposite"/"adjacent" = y_P / x_P
        = sin(phi.alt) / cos(phi.alt),
      $
      whenever $cos(phi.alt) != 0$ -- and where $cos(phi.alt) = 0$, at
      $90 degree$ and $270 degree$, the adjacent side has collapsed and
      $tan$ is genuinely undefined.],
  )
]

#warning[
  The notation $sin^2(phi.alt)$ means $(sin(phi.alt))^2$ -- square the
  _output_ -- and never $sin(sin(phi.alt))$ or $sin(phi.alt^2)$. It is
  an inconsistent piece of notation that mathematics is stuck with for
  historical reasons, and it clashes badly with $sin^(-1)$, which
  really does mean the inverse function and _not_ $1 \/ sin$. Read both
  carefully every time.
]

#ex(difficulty: 2, time: "10 min")[
  Use the two exercises above to calculate the following values
  exactly -- derive each one, do not look it up.
  #auto-parts(
    4,
    [$sin(60 degree)$],
    [$tan(45 degree)$],
    [$cos(pi/4)$],
    [$tan(pi/3)$],
  )
][
  #auto-parts(
    2,
    [From $cos(60 degree) = 1/2$ and the Pythagorean identity,
      $sin^2(60 degree) = 1 - 1/4 = 3/4$, and $sin(60 degree) > 0$, so
      $sin(60 degree) = sqrt(3)/2$.],
    [At $45 degree$, $sin = cos = sqrt(2)/2$, so
      $tan(45 degree) = (sqrt(2)\/2) \/ (sqrt(2)\/2) = 1$.],
    [$pi\/4 = 45 degree$, and by the same $y = x$ argument as for the
      sine, $cos(pi/4) = sqrt(2)/2$.],
    [$pi\/3 = 60 degree$, so
      $tan(pi/3) = sin(60 degree) \/ cos(60 degree)
      = (sqrt(3)\/2) \/ (1\/2) = sqrt(3)$.],
  )
]

#ex(level: "high", difficulty: 3, time: "15 min", hints: (
  [Reflecting a point across the $x$\u{2011}axis negates its
    $y$\u{2011}coordinate and leaves its $x$\u{2011}coordinate alone.
    Which angle does the reflected point belong to?],
  [For the third identity, reflect across the line $y = x$ instead --
    what does that reflection do to a point's two coordinates, and to
    its angle?],
))[
  Given an angle $phi.alt$, use the unit circle and symmetry to explain
  the identities
  $
    sin(-phi.alt) & = -sin(phi.alt), \
    cos(-phi.alt) & = cos(phi.alt), \
     cos(phi.alt) & = sin(90 degree - phi.alt).
  $
][
  *First two.* The angle $-phi.alt$ is $phi.alt$ turned the other way,
  so its point $P'$ is the mirror image of $P$ across the
  $x$\u{2011}axis. Reflection across the $x$\u{2011}axis sends
  $(x, y)$ to $(x, -y)$, so
  $
    P' = (cos(-phi.alt), sin(-phi.alt)) = (x_P, -y_P)
    = (cos(phi.alt), -sin(phi.alt)).
  $
  Comparing coordinates gives both identities at once.

  *Third.* The angle $90 degree - phi.alt$ is measured from the
  positive $x$\u{2011}axis, but $phi.alt$ short of the
  $y$\u{2011}axis -- which is precisely the mirror image of $phi.alt$
  across the line $y = x$. That reflection swaps the two coordinates,
  sending $(x, y)$ to $(y, x)$. So the point of $90 degree - phi.alt$
  is $(y_P, x_P)$, and reading off its first coordinate:
  $cos(90 degree - phi.alt) = y_P = sin(phi.alt)$. Reading off its
  second gives $sin(90 degree - phi.alt) = x_P = cos(phi.alt)$, which
  is the identity as stated.

  #heuristic("look for what stays the same")
]

#remark[
  The third identity explains the "co" in *co*~sine: the cosine of an
  angle is the sine of its *complementary* angle, the one that
  completes it to $90 degree$. The name is not decoration -- it is a
  description.
]

#keybox(title: "The exact values worth knowing")[
  #data-table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr),
    row-height: auto,
    [$phi.alt$],
    [$0 degree$],
    [$30 degree$],
    [$45 degree$],
    [$60 degree$],
    [$90 degree$],
    [radians],
    [$0$],
    [$pi/6$],
    [$pi/4$],
    [$pi/3$],
    [$pi/2$],
    [$sin(phi.alt)$],
    [$0$],
    [$1/2$],
    [$sqrt(2)/2$],
    [$sqrt(3)/2$],
    [$1$],
    [$cos(phi.alt)$],
    [$1$],
    [$sqrt(3)/2$],
    [$sqrt(2)/2$],
    [$1/2$],
    [$0$],
    [$tan(phi.alt)$],
    [$0$],
    [$sqrt(3)/3$],
    [$1$],
    [$sqrt(3)$],
    [--],
  )
  Do not memorize this table as twenty separate facts. Memorize the two
  pictures it comes from -- the square split along its diagonal
  ($45 degree$) and the equilateral triangle split down its height
  ($30 degree$ and $60 degree$) -- and rebuild any entry you need in
  fifteen seconds. Notice also that the sine row read backwards is the
  cosine row: that is the complementary-angle identity above, sitting
  in plain sight.
]

#ex(difficulty: 1, time: "10 min")[
  Calculate the exact value of each trigonometric function.
  #auto-parts(
    3,
    [$sin(45 degree)$],
    [$cos(pi/6)$],
    [$tan(45 degree)$],
    [$sin(pi/3)$],
    [$tan(pi/6)$],
    [$cos(60 degree)$],
  )
][
  #auto-parts(
    3,
    [$sqrt(2)/2$],
    [$sqrt(3)/2$],
    [$1$],
    [$sqrt(3)/2$],
    [$sqrt(3)/3$],
    [$1/2$],
  )
]

#ai-box(role: "Checker")[
  Work out $sin(120 degree)$ on paper first, using nothing but the unit
  circle and the symmetry arguments from this chapter -- your
  calculator's answer does not count as a reason. Then ask an AI to
  explain why $sin(120 degree) = sin(60 degree)$, and compare its
  argument with yours. Pay attention to one specific thing: does its
  explanation ever secretly fall back on a right triangle containing a
  $120 degree$ angle? If so, you have caught it in exactly the mistake
  this chapter was written to prevent.
]

#look-ahead(
  title: "Around and around",
  preview: [the trigonometric functions and their graphs],
)[
  Your exploration above found that many different angles share a sine
  value -- and the reason is now visible: turning a full $360 degree$
  brings $P$ back to where it started, so $sin(phi.alt + 360 degree)$
  and $sin(phi.alt)$ must be equal, for every $phi.alt$, forever.

  A pattern that repeats itself exactly is called *periodic*, and it is
  the reason trigonometry escaped from surveying and turned up in sound,
  light, tides, alternating current, and heartbeats -- none of which
  contain a single triangle. In the next chapter we stop asking what
  $sin(phi.alt)$ _is_ for one angle and start watching what it _does_ as
  $phi.alt$ runs.
]

#print-hints()
#print-vocab()
