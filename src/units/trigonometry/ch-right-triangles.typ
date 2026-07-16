// ============================================================
//  ch-right-triangles.typ — Chapter: Trigonometry in Right Triangles
//  Trigonometry unit, chapter 2 (shared GLF/SPF, year 1).
//  Converted from trigonometry_lecture.tex §2 (Ex 7–15, 17–27).
//
//  NOTE: old Ex 16 (circle sectors: arc length, segment perimeter,
//  sector area) is NOT here — it needs radians and belongs in
//  ch-unit-circle.typ. Registered there instead.
//
//  Images expected in images/ (exported from the old img/ folder):
//    trig14_6       → right-triangle-labels.png
//    tri2           → solve-for-x-triangles.png      (Ex 7)
//    tri3           → solve-all-triangles.png        (Ex 8)
//    tri4.png       → street-light-shadow.png        (Ex 12)
//    tri4.pdf       → isosceles-apex-50.png          (Ex 13)
//    tri6           → rectangles-angle-x.png         (Ex 15)
//    tri8           → two-angles-height.png          (Ex 17)
//    lineangle      → line-slope-angle.png           (Ex 18)
//    angularmomentum → earth-latitude-basel.png      (Ex 19)
//    tri19          → square-angle-epsilon.png       (Ex 20)
//    tri20          → square-quarter-circle-area.png (Ex 21)
//    tri21          → semicircle-inscribed-square.png (Ex 22)
//    tri22.pdf      → semicircle-thales.png          (Ex 23)
//    tri22.png      → line-from-angle-a.png          (Ex 25a)
//    tri23.png      → line-from-angle-b.png          (Ex 25b)
// ============================================================

#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Trigonometry in Right Triangles")
#let ex = exercise.with(chapter: "Right Triangles")

= Trigonometry in Right Triangles

#only-theory[
  We now restrict our attention to #vocab("right triangles", "rechtwinklige Dreiecke"),
  that is, triangles with one right angle. Here the similarity idea from
  the last chapter pays off immediately: two right triangles that share
  one more angle have all three angles equal, so they are similar --
  and therefore the ratios of their sides are the same. A ratio that
  depends only on the angle, and not on how big the triangle is, is
  worth giving a name.
]

#objectives(
  bfkm[define the trigonometric functions in the right triangle and
    describe their properties],
  bfkm[apply the trigonometric ratios in the right triangle to compute
    unknown sides and angles],
  [use the inverse functions $arctan$, $arcsin$, $arccos$ to recover an
    angle from a ratio],
  bfkm[translate a real-world situation (elevation, shadow, distance)
    into a right triangle and solve it],
  [compute the angle of inclination of a line and the angle between two
    lines from their slopes],
  obj(level: "high")[combine several right triangles in one figure to
    solve a composite geometric problem],
)

== The Three Ratios

#only-theory[
  Fix one of the two acute angles of a right triangle and call it
  $phi.alt$. Relative to $phi.alt$, the two legs get names: the side
  facing $phi.alt$ is the #vocab("opposite", "Gegenkathete"), and the
  side touching $phi.alt$ (that is not the hypotenuse) is the
  #vocab("adjacent", "Ankathete"). The
  #vocab("hypotenuse", "Hypotenuse") is always the side opposite the
  right angle -- it does not depend on which acute angle you picked.
]

#fig(image("images/right-triangle-labels.pdf", width: 50%))

#definition(title: "Sine, cosine, and tangent")[
  For an acute angle $phi.alt$ in a right triangle we define the three
  ratios
  $
    sin(phi.alt) & = "opposite" / "hypotenuse" && = (A C) / (A B) \
    cos(phi.alt) & = "adjacent" / "hypotenuse" && = (B C) / (A B) \
    tan(phi.alt) & = "opposite" / "adjacent"   && = (A C) / (B C)
  $
  with the labeling of the figure above.
]

#only-theory[
  These are the #vocab("sine", "Sinus"), the
  #vocab("cosine", "Kosinus"), and the #vocab("tangent", "Tangens") of
  the angle $phi.alt$ -- the whole of trigonometry grows out of these
  three fractions.
]

#keybox(title: "SOH-CAH-TOA")[
  A memory hook worth having: reading each definition as
  letter-triples,
  $
    underbrace(S, "sin") #h(0.1cm) underbrace(O, "opp") #h(0.1cm) underbrace(H, "hyp")
    quad
    underbrace(C, "cos")#h(0.1cm) underbrace(A, "adj")#h(0.1cm) underbrace(H, "hyp")
    quad
    underbrace(T, "tan")#h(0.1cm) underbrace(O, "opp")#h(0.1cm) underbrace(A, "adj")
  $
  But the hook is not the point: the reason these ratios are
  well-defined at all is similarity. Two right triangles with the same
  angle $phi.alt$ are similar, so their side ratios agree -- $sin(phi.alt)$
  is a property of the _angle_, not of any particular triangle.
]

#only-theory[
  We can also go the other way and find the angle belonging to a given
  ratio, using the inverse functions $arcsin$, $arccos$, and $arctan$
  (on most calculators: $sin^(-1)$, $cos^(-1)$, $tan^(-1)$).
]

#example(title: "Recovering an angle")[
  Given $sin(phi.alt) = 5/7$, the angle is
  $
    phi.alt = arcsin(5/7) = sin^(-1)(5/7) approx 45.6 degree.
  $
]

#warning[
  Before every calculation, check that your calculator is in the mode
  you intend -- DEG or RAD. A calculator in radian mode will happily
  report $sin(30) approx -0.988$ and give you no warning at all. When
  an answer is wildly off, this is the first thing to check.
]

#look-ahead(
  title: "One ratio, two readings",
  preview: [the trigonometric functions and the unit circle],
)[
  Right now $sin(phi.alt)$ is a ratio of two lengths in a triangle, so
  it only makes sense for $0 degree < phi.alt < 90 degree$ -- a triangle
  cannot have a $120 degree$ acute angle. Later we will re-read the very
  same $sin(phi.alt)$ as a _coordinate_ on a circle, and that reading
  works for every angle whatsoever, including $120 degree$, $0 degree$,
  and $-45 degree$. Nothing you learn here gets thrown away; it gets
  extended.
]

== Introductory Exercises

#ex(difficulty: 1, time: "15 min")[
  Solve for $x$.
  #fig(image("images/solve-for-x-triangles.pdf", width: 60%))
][
  #parts(
    3,
    [(a) $x approx 86.6$],
    [(b) $x approx 14.5$],
    [(c) $x approx 20.6$],
    [(d) $x approx 374$],
    [(e) $x = 18$],
    [(f) $x = 200$],
  )
]

#ex(difficulty: 2, time: "15 min")[
  Solve for all unknown sides and angles.
  #fig(image("images/solve-all-triangles.pdf", width: 90%))
][
  #parts(
    2,
    [(a) $p approx 5.36$, $r approx 20.7$, $Q = 75 degree$],
    [(b) $alpha approx 22.6 degree$, $gamma approx 67.4 degree$
      (the triangle is $15$-$36$-$39$, a scaled $5$-$12$-$13$)],
  )
]

#ex(difficulty: 2, time: "25 min")[
  In a right triangle $A B C$ (standard notation), the right angle is
  at $C$, so $gamma = 90 degree$. Find the missing sides and angles
  from the given information. Round to three significant figures.
  #auto-parts(
    3,
    [$a = 12$, $c = 20$],
    [$b = 37$, $alpha = 40 degree$],
    [$c = 4.5$, $beta = 55 degree$],
    [$b = 48$, $c = 60$],
    [$a = 11$, $alpha = 35 degree$],
    [$a = 8.5$, $b = 9.7$],
  )
][
  #auto-parts(
    2,
    [$b = 16$, $alpha approx 36.9 degree$, $beta approx 53.1 degree$],
    [$beta = 50 degree$, $a approx 31.0$, $c approx 48.3$],
    [$alpha = 35 degree$, $a approx 2.58$, $b approx 3.69$],
    [$a = 36$, $alpha approx 36.9 degree$, $beta approx 53.1 degree$],
    [$beta = 55 degree$, $b approx 15.7$, $c approx 19.2$],
    [$c approx 12.9$, $alpha approx 41.2 degree$, $beta approx 48.8 degree$],
  )
]

#remark[
  Parts (a) and (d) above are the same triangle in disguise --
  $12$–$16$–$20$ and $36$–$48$–$60$ are both scaled copies of
  $3$–$4$–$5$, which is why their angles come out identical. Spotting
  this saves you a calculation; more importantly, it is similarity
  showing up again where you were not looking for it.
]

== Some Applications

#only-theory[
  Every problem below is the same three-step move: read the situation,
  find (or build) a right triangle in it, and decide which of the three
  ratios connects what you know to what you want. The middle step is
  the one worth practicing -- the calculator handles the rest.
]

#abstraction-ladder(
  l0: [A tree stands on level ground. From $41.5$ m away, you look up
    at its top; your line of sight rises at $70 degree$.],
  l1: [horizontal distance $= 41.5$ m; angle of elevation
    $= 70 degree$; height $h = ?$],
  l2: [The ground, the tree, and the line of sight form a right
    triangle. $h$ is opposite the angle, $41.5$ is adjacent to it.],
  l3: [$h = 41.5 dot tan(70 degree)$],
)

#ex(difficulty: 1, time: "5 min")[
  The tallest tree in the world is reputed to be a giant redwood named
  Hyperion, in Redwood National Park in California, USA. At a point
  $41.5$ m from the center of its base, at the same elevation, the
  #vocab("angle of elevation", "Höhenwinkel") of the top of the tree is
  $70 degree$. How tall is the tree? Give your answer to three
  significant figures.
][
  $h = 41.5 dot tan(70 degree) approx 114$ m.
]

#ex(difficulty: 1, time: "5 min")[
  The top of the Eiffel Tower in Paris (not including the antenna) is
  $300$ m high. What is the angle of elevation of the top of the tower
  from a point on the ground (assumed level) $125$ m from the center of
  the tower's base?
][
  $arctan(300\/125) approx 67.4 degree$.
]

#ex(difficulty: 2, time: "10 min", hints: (
  [There are two right triangles here that share the same angle at the
    tip of the shadow -- the woman's and the lamp post's.
    #heuristic("draw a picture")],
  [You do not actually need trigonometry: similar triangles give
    $h\/5 = 1.62\/2$ directly. Solving it with $tan$ works too -- try
    both and compare.],
))[
  A woman $1.62$ m tall, standing $3$ m from a street light, casts a
  $2$ m long shadow (see the diagram). What is the height of the street
  light?
  #fig(image("images/street-light-shadow.png", width: 50%))
][
  $h = 1.62 dot 5 \/ 2 = 4.05$ m.
]

#ex(difficulty: 2, time: "5 min", hints: (
  [The triangle is isosceles, so the height from the apex splits it
    into two congruent right triangles -- and splits the $50 degree$
    angle in half. #heuristic("draw a picture")],
))[
  Calculate $x$.
  #fig(image("images/isosceles-apex-50.pdf", width: 30%))
][
  Halving the apex angle: $x\/2 = 8 dot sin(25 degree)$, so
  $x approx 6.76$ cm.
]

#ex(difficulty: 1, time: "5 min")[
  A right triangle has sides of length $5$ m, $12$ m, and $13$ m.
  Calculate, to one decimal place, the sizes of its angles.
][
  $22.6 degree$, $67.4 degree$, $90 degree$.
]

#ex(difficulty: 2, time: "10 min")[
  Calculate the angle $x$.
  #fig(image("images/rectangles-angle-x.pdf", width: 45%))
][
  $x = 45 degree$.
]

#ex(difficulty: 2, time: "10 min", hints: (
  [Neither of the two triangles in the figure has enough information on
    its own. Name the unknown horizontal distance from the foot of $x$
    to the $45 degree$ vertex -- say $d$. #heuristic("introduce notation")],
  [Write $x$ twice: once with $tan(45 degree)$ and $d$, once with
    $tan(30 degree)$ and $d + 20$. Then eliminate $d$.],
))[
  Calculate $x$.
  #fig(image("images/two-angles-height.pdf", width: 55%))
][
  With $d$ the distance from the base of $x$ to the $45 degree$ vertex:
  $x = d dot tan(45 degree) = d$ and $x = (d + 20) dot tan(30 degree)$.
  Hence $d = (d + 20) dot tan(30 degree)$, giving
  $d = 20 dot tan(30 degree) \/ (1 - tan(30 degree)) approx 27.3$, so
  $x approx 27.3$ m.
]

#ex(difficulty: 2, time: "5 min")[
  Calculate $alpha$.
  #fig(image("images/line-slope-angle.png", width: 50%))
][
  The line has slope $2/3$, so $alpha = arctan(2\/3) approx 33.7 degree$.
]

#ex(difficulty: 3, time: "15 min", hints: (
  [Basel does not travel around the equator -- it travels around a
    smaller circle of latitude. Draw the cross-section through the
    earth's axis and find the radius of that circle.
    #heuristic("draw a picture")],
  [The radius of Basel's circle is $R dot cos(alpha)$, where
    $R approx 6370$ km. One full turn takes 24 hours.],
))[
  How fast is Basel moving due to the rotation of the earth? (Latitude
  $alpha = 47 degree 34'$; radius of the earth $R approx 6370$ km.)
  #fig(image("images/earth-latitude-basel.pdf", width: 65%))
][
  Basel's circle of latitude has radius
  $r = 6370 dot cos(47.567 degree) approx 4298$ km. Its circumference is
  $2 pi r approx #num(27007)$ km, covered in 24 hours:
  $ v approx #num(1125) " km/h". $
]

#exploration(title: "Faster Than Sound?")[
  The answer above is roughly $#num(1125)$ km/h -- about the speed of
  sound at sea level. So why is there no permanent sonic boom, no wind
  from the east, and nothing at all to notice? Discuss what the
  calculation is _actually_ measuring, and what would have to be true
  for you to feel it. Then estimate: how fast would a point on the
  equator be moving? What about someone standing exactly at the North
  Pole?
]

#ex(difficulty: 2, time: "10 min")[
  $A B C D$ is a square with side length $6$. Calculate the angle
  $epsilon.alt$.
  #fig(image("images/square-angle-epsilon.pdf", width: 25%))
][
  Put $A = (0, 0)$, $B = (6, 0)$, $E = (4, 6)$. Splitting
  $epsilon.alt$ with the vertical through $E$ gives
  $epsilon.alt = arctan(4\/6) + arctan(2\/6) approx 33.69 degree + 18.43 degree
  approx 52.13 degree$.
]

#ex(level: "high", difficulty: 3, time: "15 min")[
  $A B C D$ is a square. Calculate the shaded area.
  #fig(image("images/square-quarter-circle-area.pdf", width: 25%))
][
  $approx 16.8$
]

#ex(level: "high", difficulty: 3, time: "15 min")[
  Calculate $overline(O A)$.
  #fig(image("images/semicircle-inscribed-square.pdf", width: 35%))
][
  $overline(O A) = 4.00$
]

#ex(difficulty: 2, time: "10 min", hints: (
  [A triangle inscribed in a semicircle with the diameter as one side
    always has a right angle at the third vertex (Thales' theorem) --
    which one is it here? #heuristic("look for what stays the same")],
))[
  Calculate $x$ and $epsilon.alt$.
  #fig(image("images/semicircle-thales.pdf", width: 35%))
][
  $epsilon.alt = 30 degree$ and $x = sqrt(3)$.
]

#ex(difficulty: 2, time: "10 min")[
  Find the measures of the angles of an isosceles triangle whose sides
  are $10$ cm, $8$ cm, and $8$ cm.
][
  The height to the base of length $10$ splits the triangle into two
  right triangles with hypotenuse $8$ and adjacent side $5$. The base
  angles are $arccos(5\/8) approx 51.3 degree$, and the apex angle is
  $180 degree - 2 dot 51.3 degree approx 77.4 degree$.
]

== Lines and Angles

#only-theory[
  A line $y = m dot x + b$ has a slope $m$ -- and slope is a ratio of a
  vertical change to a horizontal change. That is exactly the shape of
  a tangent. This connects the algebra of lines you already know to the
  trigonometry you just learned.
]

#keybox(title: "Slope and angle of inclination")[
  The #vocab("angle of inclination", "Steigungswinkel") $alpha$ of a
  line is the angle it makes with the positive
  $x$\u{2011}direction. Since the slope is (rise)/(run),
  $ m = tan(alpha), quad "so" quad alpha = arctan(m). $
  For two lines with angles of inclination $alpha_1$ and $alpha_2$, the
  angle between them is $abs(alpha_1 - alpha_2)$ -- or its supplement,
  whichever is acute.
]

#look-ahead(
  title: "The slope of something that isn't a line",
  preview: [differential calculus (the derivative)],
)[
  A line has one slope, everywhere. A curve does not -- a parabola is
  steep far from its vertex and flat at it. But zoom in far enough on
  any point of a smooth curve and it looks like a line, and _that_ line
  has a slope and therefore an angle of inclination, exactly as above.
  Finding it is what the derivative does. Every time you compute
  $arctan(m)$ here, you are doing by hand the last step of a
  calculation you will meet again in a few years' time.
]

#ex(difficulty: 2, time: "10 min")[
  Calculate the equation $y = m dot x + b$ of each straight line.
  #image-grid(
    2,
    fig(image("images/line-from-angle-a.png", width: 90%), caption: [(a)]),
    fig(image("images/line-from-angle-b.png", width: 90%), caption: [(b)]),
  )
][
  #parts(
    2,
    [(a) $y = -x + 2$],
    [(b) $y = 0.404 dot x - 1.5$],
  )
]

#ex(difficulty: 2, time: "10 min")[
  Find the acute angle between the two given lines.
  #auto-parts(
    2,
    [$y = -2x$ and $y = x$],
    [$y = -3x + 5$ and $y = 2x$],
  )
][
  #auto-parts(
    2,
    [$arctan(-2) approx -63.4 degree$ and $arctan(1) = 45 degree$, a
      difference of $108.4 degree$; the acute angle is
      $180 degree - 108.4 degree approx 71.6 degree$.],
    [$arctan(-3) approx -71.6 degree$ and $arctan(2) approx 63.4 degree$,
      a difference of $135 degree$; the acute angle is $45 degree$.],
  )
]

#warning[
  Subtracting two angles of inclination can hand you an obtuse angle.
  Always ask which of the two angles at the crossing you were asked
  for, and take $180 degree -$ the result if needed. A sketch settles
  it in five seconds; algebra alone will not.
]

#ex(difficulty: 3, time: "30 min", keep-together: true)[
  The three lines
  $
    g_1: quad & y = -2/3 dot x + 9 \
    g_2: quad & -3x + 2y = 5 \
    g_3: quad & x + 8y = 7
  $
  form a triangle.
  + Use the elimination method to determine the intersection of $g_2$
    and $g_3$.
  + Use any method to determine the other corners of the triangle.
  + Determine the lengths of the sides of the triangle.
  + Show that this is a right triangle.
  + Calculate the missing angles of the triangle.
  + Calculate the area of the triangle.
][
  + $ #system(($-3x + 2y$, $5$), ($x + 8y$, $7$)) $
    gives $(-1, 1)$.
  + $g_1 inter g_3 = (15, -1)$ and $g_1 inter g_2 = (3, 7)$.
  + $sqrt(52) approx 7.21$, $sqrt(208) approx 14.42$, and
    $sqrt(260) approx 16.12$.
  + $52 + 208 = 260$, so the Pythagorean theorem holds exactly. The
    right angle is therefore at the vertex opposite the longest side,
    i.e. at $(3, 7)$. (Check it the other way too: $g_1$ has slope
    $-2\/3$ and $g_2$ has slope $3\/2$, and
    $-2\/3 dot 3\/2 = -1$ -- so $g_1 perp g_2$, and $(3, 7)$ is exactly
    where those two meet.)
  + At $(-1, 1)$: $arctan(sqrt(208)\/sqrt(52)) = arctan(2) approx
    63.43 degree$. At $(15, -1)$: $approx 26.57 degree$.
  + $1/2 dot sqrt(52) dot sqrt(208) = 52$.
]

#ai-box(role: "Generator")[
  Ask an AI to generate five more problems in the style of the exercise
  above: three lines given in mixed forms that meet in a right triangle
  with reasonably clean coordinates. Then _check every one_: do the
  three lines really meet in three distinct points? Is the triangle
  really right-angled? Report how many of the five survived, and what
  the AI got wrong when it got it wrong.
]

#print-hints()
#print-vocab()
