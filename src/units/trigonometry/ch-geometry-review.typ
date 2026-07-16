// ============================================================
//  ch-geometry-review.typ — Chapter: Geometric Foundations
//  Trigonometry unit, chapter 1 (shared GLF/SPF, year 1).
//  Converted from trigonometry_lecture.tex §1 (Ex 1–6).
//
//  Images expected in images/ (exported from the old img/ folder):
//    trig14_2                     → crossed-heights.png        (Ex 2)
//    trig14_1                     → shape-abcd-height.png      (Ex 3)
//    trig14_3                     → square-bisector.png        (Ex 4)
//    triangle-basics              → triangle-labeling.png
//    triangle-classification-angles → triangle-classification.png
//    missing-angles               → missing-angles.png         (Ex 5)
//    pyth.png                     → pythagoras-rearrangement.png
// ============================================================

#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Geometric Foundations")
#let ex = exercise.with(chapter: "Geometric Foundations")

= Geometric Foundations

#only-theory[
  The word #vocab("trigonometry", "Trigonometrie") comes from two Greek
  words, _trigonon_ and _metron_, meaning "triangle measurement."
  Trigonometry developed out of the use and study of triangles -- in
  surveying, navigation, architecture, and astronomy -- to find
  relationships between the lengths of the sides of triangles and the
  measurements of their angles. As a result, trigonometric functions
  were initially defined as functions of angles, that is, functions
  whose domains are angle measurements. With the development of calculus
  in the seventeenth century and the growth of knowledge in the
  sciences, the applications of the trigonometric functions grew to
  include a wide variety of periodic (repetitive) phenomena such as wave
  motion, vibrating strings, oscillating pendulums, alternating
  electrical current, and biological cycles.
]

#objectives(
  [decide whether two figures are similar and justify your decision],
  [use ratios of corresponding sides in similar figures to compute
    unknown lengths],
  [label a triangle with the standard notation for vertices, sides, and
    angles, and read angle notation like $angle B A C$],
  [classify angles and triangles by their angle measures],
  [apply the angle-sum theorem and the Pythagorean theorem to find
    missing angles and sides],
)

== Similarity

#only-theory[
  Two geometrical objects are called #vocab("similar", "ähnlich") if
  they both have the same shape, or one has the same shape as the mirror
  image of the other. More precisely, one can be obtained from the other
  by uniformly scaling (enlarging or shrinking), possibly with
  additional translation, rotation, and reflection.
]

#keybox(title: "Similar figures")[
  Corresponding angles and ratios of corresponding lengths remain
  constant in similar figures. Also: if a shape is scaled by a factor
  $c in RR$, then all lengths are scaled by the factor $abs(c)$.
]

#look-ahead(
  title: "Ratios with names",
  preview: [trigonometry in right triangles (the next chapter)],
)[
  In similar figures, the ratios of corresponding sides stay constant.
  For right triangles, these fixed ratios turn out to be so useful that
  they get their own names -- _sine_, _cosine_, and _tangent_.
  Everything trigonometry does with an angle is powered by exactly the
  similarity idea you are practicing here.
]

#ex(difficulty: 1, time: "10 min")[
  Is each statement true or false? If it is false, can you qualify the
  statement to make it true?
  - Any two squares are similar.
  - Any two rectangles are similar.
  - Any two rhombuses are similar.
  - Any two circles are similar.
  - Any two #vocab("sectors", "Kreissektoren") of circles are similar.
  - Any two #vocab("equilateral", "gleichseitig") triangles are similar.
  - Any two #vocab("isosceles", "gleichschenklig") triangles are
    similar.
][
  - True.
  - False. Any two rectangles whose sides are in the same ratio are
    similar.
  - False. Any two rhombuses whose angles are equal are similar (or
    whose diagonals are in the same ratio).
  - True.
  - False. A sector of one circle is similar to a sector of another
    circle if the two sectors have the same angle at the center.
  - True.
  - False. Any two isosceles triangles whose base angles are equal are
    similar (or whose sides are in the same ratio, or whose height and
    base are in the same ratio).
]

#ex(
  difficulty: 2,
  time: "10 min",
  hints: (
    [The height $E F$ creates two pairs of similar triangles -- one
      pair involving the $6.5$ m post, one involving the $4$ m post.],
    [Express $E F$ twice, once through each pair of similar triangles,
      and combine the two equations. #heuristic("introduce notation")],
  ),
)[
  Determine the height $E F$, if $A C = 10$ m.
  #fig(image("images/crossed-heights.pdf", width: 55%))
][
  $E F approx 2.48$ m. (Surprisingly, the answer does not depend on
  $A C$ at all: $E F = (6.5 dot 4)\/(6.5 + 4)$.)
]

#ex(difficulty: 2, time: "10 min")[
  Given the shape $A B C D$, use similar triangles to determine the
  height of $C$ above $A D$.
  #fig(image("images/shape-abcd-height.pdf", width: 40%))
][
  $10$
]

#ex(
  difficulty: 3,
  time: "20 min",
  hints: (
    [Draw a large, accurate figure and chase angles: the diagonals of a
      square meet at $90 degree$, and $angle O A B = 45 degree$, so the
      #vocab("angle bisector", "Winkelhalbierende") makes an angle of
      $22.5 degree$ with $A B$. #heuristic("draw a picture")],
    [Place the square in a coordinate system with side length $s$ and
      compute both $N O$ and $P C$ in terms of $s$ -- then compare
      them.],
  ),
)[
  (Bonus) The diagonals of a square meet at $O$. The bisector of the
  angle $angle O A B$ meets $B O$ and $B C$ at $N$ and $P$
  respectively. The length of $N O$ is 24. How long is $P C$?
  #fig(image("images/square-bisector.pdf", width: 35%))
][
  For side length $s$, coordinates (or angle chasing) give
  $N O = (1 - 1/sqrt(2)) dot s$ and $P C = (2 - sqrt(2)) dot s$, so
  $P C$ is always exactly twice $N O$: $P C = 48$.
]

#exploration(title: "The Similar Sheet")[
  Take a sheet of A4 paper and fold it in half, short edge to short
  edge -- the result is A5. Are the two rectangles similar? Measure and
  check. Then work out: if a rectangle _is_ similar to its own half,
  what must the ratio of its sides be? Compare your answer with the
  actual dimensions of A4 ($297 times 210$ mm).
]

#ai-box(role: "Checker")[
  Decide on paper first: are any two parabolas similar? (Think about
  what uniform scaling does to the graph of $y = a dot x^2$.) Then ask an
  AI the same question and compare its argument with yours, line by
  line. If you disagree, decide who is wrong -- and why.
]

== Angles and Triangles

#only-theory[
  Some reminders and vocabulary for working with triangles.
]

#keybox(title: "Labeling triangles")[
  In a triangle the corners -- sometimes called
  #vocab("vertices", "Eckpunkte") -- are usually labeled with uppercase
  letters, the sides with lowercase letters, and the angles with Greek
  letters:

  #fig(image("images/triangle-labeling.pdf", width: 65%))

  Sometimes an angle is given by the angle symbol followed by three
  letters. This denotes the angle at the _center_ vertex, so in the
  figure above $alpha = angle B A C = angle C A B$.
]

#only-theory[
  In mathematical expressions we generally use Greek letters
  ($alpha, beta, gamma, dots$) for angles. It helps if you can
  recognize them.
]

#keybox(title: "The Greek Alphabet")[
  #grid(
    columns: (auto, 1fr, auto, 1fr, auto, 1fr),
    row-gutter: 0.55em,
    column-gutter: 1em,
    [$alpha$], [alpha], [$iota$], [iota], [$rho$], [rho],
    [$beta$], [beta], [$kappa$], [kappa], [$sigma$], [sigma],
    [$gamma$], [gamma], [$lambda$], [lambda], [$tau$], [tau],
    [$delta$], [delta], [$mu$], [mu], [$upsilon$], [upsilon],
    [$epsilon$], [epsilon], [$nu$], [nu], [$phi$], [phi],
    [$zeta$], [zeta], [$xi$], [xi], [$chi$], [chi],
    [$eta$], [eta], [$omicron$], [omicron], [$psi$], [psi],
    [$theta$], [theta], [$pi$], [pi], [$omega$], [omega],
  )
]

#definition(title: "Angle types")[
  - An angle is #vocab("acute", "spitz") if it is between $0 degree$
    and $90 degree$.
  - An angle is a #vocab("right angle", "rechter Winkel") if it equals
    $90 degree$.
  - An angle is #vocab("obtuse", "stumpf") if it is between $90 degree$
    and $180 degree$.
]

#theorem(title: "Angle Sum")[
  The sum of the interior angles in any triangle equals $180 degree$.
]

#only-theory[
  Triangles are classified by their angles: _acute_ (all three angles
  acute), _right_ (one right angle), and _obtuse_ (one obtuse angle) --
  and by their sides: _equilateral_ (all sides equal) and _isosceles_
  (two sides equal).

  #fig(image("images/triangle-classification.png", width: 70%))
]

#ex(difficulty: 1, time: "10 min")[
  Determine the missing angles in each triangle.
  #fig(image("images/missing-angles.png", width: 85%))
][
  #parts(
    3,
    [Triangle $A B C$: $125 degree$],
    [Triangle $D E F$: $37 degree$],
    [Triangle $X Y Z$: $alpha = 36 degree$],
  )
]

== The Pythagorean Theorem

#theorem(title: "Pythagorean Theorem")[
  In a right triangle with #vocab("legs", "Katheten") $a$ and $b$ and
  #vocab("hypotenuse", "Hypotenuse") $c$ (the side opposite the right
  angle),
  $ a^2 + b^2 = c^2. $
]

#proof[
  A proof by rearrangement: both large squares below have side length
  $a + b$, so they have the same area. Removing the four identical
  right triangles from each leaves $a^2 + b^2$ on the left and $c^2$ on
  the right.

  #fig(
    image("images/pythagoras-rearrangement.png", width: 80%),
    caption: [Source:
      #link("http://faculty.smcm.edu/sgoldstine/pythagoras.html")],
  )
]

#ex(difficulty: 2, time: "15 min")[
  Find the numeric value of the indicated angle(s) for the right
  triangle $A B C$ (standard notation), where the right angle is at
  $C$.
  #auto-parts(
    2,
    [Find $beta$ if $alpha = 45 degree$.],
    [Find $alpha$ and $beta$ if $beta = 2 alpha$.],
    [Find $alpha$ and $beta$ if $beta = alpha^2$.],
    [Find $alpha$ and $beta$ if $beta = 1/alpha$.],
  )
][
  #auto-parts(
    2,
    [$beta = 45 degree$],
    [$alpha = 30 degree$, $beta = 60 degree$],
    [$alpha = 9 degree$, $beta = 81 degree$],
    [$alpha = 89.99 degree$, $beta = 0.01 degree$ (or vice versa)],
  )
]

#print-hints()
#print-vocab()
