// ============================================================
//  ch-general-triangles.typ — Chapter: Trigonometry in General Triangles
//  Trigonometry unit, chapter 4 (shared GLF/SPF, year 1).
//  Converted from trigonometry_lecture.tex §4 (Ex 36–52).
//
//  NOTE: the original stated NEITHER rule — it went straight from the
//  section heading to "Use the sine rule to find the marked side."
//  Both rules are now stated AND derived here.
//
//  Images expected in images/ (exported from the old img/ folder):
//    tri9      → triangle-areas.png              (Ex 36)
//    tri10     → sine-rule-sides.png             (Ex 37)
//    tri11     → sine-rule-angles.png            (Ex 38)
//    tri12     → cosine-rule-sides.png           (Ex 40)
//    tri13     → cosine-rule-angles.png          (Ex 41)
//    tri14     → mixed-rules-abc.png             (Ex 42 a–c)
//    tri15     → mixed-rules-de.png              (Ex 42 d–e)
//    tri16     → ambiguous-case-two-triangles.png
//    tri17     → general-triangle-notation.png   (Ex 44)
//    tri18     → triangle-pqr-area.png           (Ex 46)
//    tri24.pdf → circle-prs.png                  (Ex 48)
//    tri25     → distance-fg.png                 (Ex 49)
//    tri26     → plane-two-ships.png             (Ex 50)
//    tri27     → plane-bearings.png              (Ex 52)
// ============================================================

#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Trigonometry in General Triangles")
#let ex = exercise.with(chapter: "General Triangles")

= Trigonometry in General Triangles

#only-theory[
  Everything so far has needed a right angle. That is a serious
  restriction: most triangles do not have one, and the ones you meet in
  surveying, navigation, and astronomy rarely oblige. The standard
  workaround has been to _build_ a right angle -- drop a perpendicular
  and split the problem into two right triangles, as you did for the
  isosceles triangles in chapter 2.

  That works, but it is laborious, and it hides a better idea. In this
  chapter we do the splitting *once*, in general, with letters instead
  of numbers. What falls out are two formulas that handle any triangle
  at all, right-angled or not -- and one of them will turn out to
  contain the Pythagorean theorem as a special case.
]

#objectives(
  bfkm[apply trigonometric relationships in the general triangle],
  [compute the area of a triangle from two sides and the angle between
    them],
  bfkm[use the sine rule to find missing sides and angles],
  bfkm[use the cosine rule to find missing sides and angles],
  [decide which rule a given configuration calls for, and in which
    order to apply it],
  [recognize the ambiguous (SSA) case and give both solutions when both
    exist],
  [model a real situation (navigation, bearings, distances) as a
    general triangle and solve it],
  obj(level: "high")[justify why the cosine rule generalizes the
    Pythagorean theorem, and derive both rules],
)

== The Area of a Triangle

#only-theory[
  You already know $A = 1/2 dot g dot h$ -- base times height, halved.
  The trouble is that a height is rarely what you are given. Two sides
  and the angle between them is a far more common starting point, and
  trigonometry converts one into the other in a single step.
]

#only-theory[
  In the triangle $A B C$, drop the perpendicular from $C$ onto the
  side $A B$ and call its length $h$. In the right triangle it creates
  on the left, $h$ is opposite the angle $alpha$ and the hypotenuse is
  $b$, so
  $ h = b dot sin(alpha). $
  Substituting this into $A = 1/2 dot c dot h$ gives the formula
  below -- and the two sides used are exactly the two that _enclose_
  the angle.
]

#keybox(title: "Area from two sides and the enclosed angle")[
  $ A = 1/2 dot b dot c dot sin(alpha) $
  and, by the same argument started from a different vertex,
  $
    A = 1/2 dot a dot c dot sin(beta) = 1/2 dot a dot b dot sin(gamma).
  $
  In words: half the product of two sides, times the sine of the angle
  *between* them. The angle must be the enclosed one -- this is the
  single most common way to get the formula wrong.
]

#remark[
  Check the formula against a case you already know: if
  $alpha = 90 degree$ then $sin(alpha) = 1$ and the formula collapses to
  $A = 1/2 dot b dot c$ -- base times height, halved, exactly as it
  should, because in a right triangle the two legs _are_ a base and its
  height. A new formula that contradicts an old one you trust is a
  reason to stop and look for the mistake.
  #heuristic("check an extreme or special case")
]

#ex(difficulty: 1, time: "10 min")[
  Find the area of each triangle.
  #fig(image("images/triangle-areas.pdf", width: 80%))
][
  #auto-parts(
    3,
    [$1/2 dot 4 dot 6 dot sin(60 degree) approx 10.4$],
    [$1/2 dot 8 dot 23 dot sin(105 degree) approx 88.9$],
    [$1/2 dot 30 dot 90 dot sin(45 degree) approx 955$],
  )
]

== The Sine Rule

#only-theory[
  Keep the same perpendicular $h$ from $C$ onto $A B$, but read it
  twice. From the right triangle on the left, $h = b dot sin(alpha)$.
  From the right triangle on the right, $h$ is opposite $beta$ with
  hypotenuse $a$, so $h = a dot sin(beta)$. The height does not care
  which side you compute it from:
  $
    b dot sin(alpha) = a dot sin(beta).
  $
  Dividing both sides by $sin(alpha) dot sin(beta)$ rearranges this
  into the rule. Repeating the argument with the perpendicular from a
  different vertex supplies the third ratio.
  #heuristic("introduce notation")
]

#theorem(title: "The Sine Rule")[
  In any triangle $A B C$,
  $
    a / sin(alpha) = b / sin(beta) = c / sin(gamma).
  $
  Equivalently, flipped:
  $
    sin(alpha) / a = sin(beta) / b = sin(gamma) / c.
  $
]

#keybox(title: "What the sine rule needs")[
  Look at the equation: every usable pair links a *side* with the
  *angle opposite it*. So the sine rule is the right tool exactly when
  you have -- or can get -- a complete side–angle pair, plus one more
  piece. Use whichever of the two forms puts the unknown in the
  numerator: sides on top when hunting a side, sines on top when
  hunting an angle.
]

#ex(difficulty: 1, time: "15 min")[
  Use the sine rule to find the marked side.
  #fig(image("images/sine-rule-sides.png", width: 80%))
][
  #auto-parts(
    3,
    [$x = 7 dot sin(55 degree) \/ sin(80 degree) approx 5.82$ cm],
    [$x = 18 dot sin(20 degree) \/ sin(75 degree) approx 6.37$ cm],
    [$x = 6 dot sin(125 degree) \/ sin(40 degree) approx 7.65$ cm],
    [$n = 9 dot sin(pi\/4) \/ sin(pi\/3) approx 7.35$ cm],
    [$x = 18 dot sin(52 degree) \/ sin(91 degree) approx 14.2$ mm],
  )
]

#remark[
  In (c) and (e) you had to find the third angle first ($180 degree$
  minus the other two) before any pair was complete. That extra step is
  routine -- but notice that in (e) the third angle is $91 degree$,
  just barely obtuse. A sketch that looks right-angled to the eye is
  not the same as one that is.
]

#ex(difficulty: 2, time: "10 min")[
  Use the sine rule to find the marked angle.
  #fig(image("images/sine-rule-angles.png", width: 80%))
][
  #auto-parts(
    2,
    [$sin(x) = 7 dot sin(50 degree) \/ 10 approx 0.536$, so
      $x approx 32.4 degree$.],
    [$sin(x) = 19 dot sin(30 degree) \/ 12 approx 0.792$, so
      $x approx 52.3 degree$ *or* $x approx 127.7 degree$ -- both are
      genuine triangles. See the next section.],
  )
]

#warning[
  Part (b) is not a trick, and $127.7 degree$ is not a stray root to be
  discarded. Your calculator's $sin^(-1)$ only ever hands back the
  acute answer, because a function must return one value -- but the
  unit circle says $sin(180 degree - phi.alt) = sin(phi.alt)$, so
  _every_ sine value belongs to two angles between $0 degree$ and
  $180 degree$. Whenever the sine rule gives you an angle, ask whether
  its supplement also fits the triangle.
]

#ex(difficulty: 2, time: "10 min")[
  The triangle $L M N$ has sides $L M = 32$ m and $M N = 35$ m, with
  $angle L N M = 40 degree$. Find the possible values for
  $angle M L N$.
][
  $L M = 32$ is opposite the known angle at $N$, and $M N = 35$ is
  opposite the wanted angle at $L$. So
  $sin(angle M L N) = 35 dot sin(40 degree) \/ 32 approx 0.703$, giving
  $ angle M L N approx 44.7 degree quad "or" quad approx 135.3 degree. $
  Both are possible: the known angle sits opposite the *shorter* of the
  two given sides, which is precisely the ambiguous configuration.
]

== The Cosine Rule

#only-theory[
  The sine rule always needs a side paired with its opposite angle. Two
  very natural situations hand you no such pair: three sides and no
  angle at all (SSS), or two sides with the angle _between_ them (SAS).
  For those, a second rule is needed.

  Put the triangle in a coordinate system: $A$ at the origin, $B$ at
  $(c, 0)$, and -- reading $C$'s position off the unit-circle
  definition, scaled by $b$ --
  $C = (b dot cos(alpha), b dot sin(alpha))$. The side $a$ is just the
  distance from $B$ to $C$, so
  $
    a^2 & = (b dot cos(alpha) - c)^2 + (b dot sin(alpha))^2 \
        & = b^2 cos^2(alpha) - 2 b c dot cos(alpha) + c^2
          + b^2 sin^2(alpha) \
        & = b^2 dot (cos^2(alpha) + sin^2(alpha)) + c^2
          - 2 b c dot cos(alpha).
  $
  The bracket is $1$, by the Pythagorean identity from the last
  chapter. What remains is the rule.
]

#theorem(title: "The Cosine Rule")[
  In any triangle $A B C$,
  $
    a^2 & = b^2 + c^2 - 2 b c dot cos(alpha), \
    b^2 & = a^2 + c^2 - 2 a c dot cos(beta), \
    c^2 & = a^2 + b^2 - 2 a b dot cos(gamma).
  $
  Solved for the angle instead, the first of these reads
  $
    cos(alpha) = (b^2 + c^2 - a^2) / (2 b c).
  $
]

#keybox(title: "The cosine rule contains Pythagoras")[
  Set $gamma = 90 degree$ in the third form. Then
  $cos(90 degree) = 0$, the whole last term vanishes, and what is left
  is
  $ c^2 = a^2 + b^2. $
  So the cosine rule is not a different theorem that happens to sit
  beside the Pythagorean theorem -- it *is* the Pythagorean theorem,
  extended to triangles that are not right-angled, with
  $-2 a b dot cos(gamma)$ as the exact correction term for the missing
  right angle. Squeeze $gamma$ below $90 degree$ and $cos(gamma) > 0$,
  so $c^2$ comes out _smaller_ than $a^2 + b^2$; open it past
  $90 degree$ and $cos(gamma) < 0$, so $c^2$ comes out _larger_. The
  formula knows.
]

#look-ahead(
  title: "This formula comes back with a new name",
  preview: [vector geometry and the scalar product],
)[
  In a year or two you will meet vectors, and with them the *scalar
  product* (Skalarprodukt) $arrow(u) dot arrow(v)$. One of its first
  properties will be
  $
    abs(arrow(u) - arrow(v))^2 = abs(arrow(u))^2 + abs(arrow(v))^2
    - 2 dot arrow(u) dot arrow(v),
  $
  which is the cosine rule wearing different clothes -- the same
  statement about the same triangle, with $arrow(u) dot arrow(v)$
  playing the part of $a b cos(gamma)$. When that lands, it should feel
  like meeting an old acquaintance, not learning a new fact.
]

#ex(difficulty: 1, time: "15 min")[
  Use the cosine rule to find the marked side.
  #fig(image("images/cosine-rule-sides.png", width: 80%))
][
  #auto-parts(
    2,
    [$x^2 = 6^2 + 7^2 - 2 dot 6 dot 7 dot cos(55 degree)$, so
      $x approx 6.07$ cm],
    [$x^2 = 17^2 + 22^2 - 2 dot 17 dot 22 dot cos(70 degree)$, so
      $x approx 22.7$ m],
    [$p^2 = 195^2 + 210^2 - 2 dot 195 dot 210 dot cos(140 degree)$, so
      $p approx 381$ mm],
    [$t^2 = 2 dot 9.6^2 - 2 dot 9.6^2 dot cos(68 degree)$, so
      $t approx 10.7$ cm],
  )
]

#remark[
  In (c) the enclosed angle is obtuse, so $cos(140 degree)$ is
  negative and the rule _adds_ to $a^2 + b^2$ -- exactly as the keybox
  above predicted. If you got a number smaller than $195$, you dropped
  a minus sign.
]

#ex(difficulty: 2, time: "10 min")[
  Use the cosine rule to find the marked angle.
  #fig(image("images/cosine-rule-angles.png", width: 80%))
][
  #auto-parts(
    2,
    [$cos(Q) = (1.7^2 + 2.5^2 - 2.2^2) \/ (2 dot 1.7 dot 2.5)
      approx 0.506$, so $Q approx 59.6 degree$.],
    [$cos(B) = (17^2 + 23^2 - 38^2) \/ (2 dot 17 dot 23)
      approx -0.801$, so $B approx 143 degree$. The negative cosine
      announces the obtuse angle by itself -- no case analysis needed.],
  )
]

#keybox(title: "Why the cosine rule is safer for angles")[
  Compare the two rules when you are hunting an *angle*:
  - $sin^(-1)$ returns only values in $[0 degree, 90 degree]$, so it
    can never tell you an angle is obtuse. You must check the
    supplement yourself, every time.
  - $cos^(-1)$ returns values across the whole range
    $[0 degree, 180 degree]$, and the sign of the cosine settles acute
    versus obtuse automatically.

  So when both rules are available and you want an angle, the cosine
  rule is the one that cannot quietly mislead you.
]

#ex(difficulty: 2, time: "20 min", keep-together: true)[
  Calculate $x$ in each triangle. *Careful:* this set is mixed -- not
  every part is a cosine-rule problem. Decide which rule each
  configuration calls for *before* you compute anything.
  #fig(image("images/mixed-rules-abc.png", width: 85%))
  #fig(image("images/mixed-rules-de.png", width: 75%))
][
  #auto-parts(
    2,
    [*Cosine rule* (SAS):
      $x^2 = 6.3^2 + 8.2^2 - 2 dot 6.3 dot 8.2 dot cos(62 degree)$, so
      $x approx 7.64$ m.],
    [*Sine rule* (side–angle pair $29$/$60 degree$ available):
      $sin(x) = 26 dot sin(60 degree) \/ 29$, so
      $x approx 50.9 degree$.],
    [*Cosine rule* (SSS):
      $cos(x) = (88^2 + 107^2 - 131^2) \/ (2 dot 88 dot 107)$, so
      $x approx 83.8 degree$.],
    [*Sine rule*: the third angle is $45 degree$, so
      $x = 19 dot sin(55 degree) \/ sin(80 degree) approx 15.8$ cm.],
    [*Sine rule*: the third angle is $35 degree$, so
      $x = 29 dot sin(35 degree) \/ sin(100 degree) approx 16.9$ cm.],
  )
]

== Which Rule, and in Which Order?

#only-theory[
  Just as you can construct the missing sides and angles of a triangle
  with compass and straightedge, you can now calculate them. And just
  as in the geometric case, there is a minimum amount of information
  needed for a unique result -- and exactly one configuration that
  refuses to be pinned down.

  Two pieces of information are obviously never enough. You need at
  least three to even have a chance.
]

#keybox(title: "The five cases")[
  #data-table(
    columns: (auto, 1fr),
    row-height: auto,
    [Given],
    [What you can do],
    [AAA],
    [*Not solvable.* All similar triangles have the same
      interior angles, so you know the triangle's _shape_ but not its
      size. There is no size information anywhere in three angles.],
    [ASA \ AAS \ SAA],
    [Two angles give you the third for free, so you
      always have a complete side–angle pair. *Sine rule.* The solution
      is unique.],
    [SSA \ ASS],
    [Two sides and an angle opposite one of them.
      *Sine rule* -- but this is the ambiguous case. If the known angle
      is opposite the *longer* side, the solution is unique; if it is
      opposite the *shorter* side, there may be two solutions, one, or
      none.],
    [SAS],
    [Two sides and the angle between them: no side–angle pair,
      so the sine rule cannot start. *Cosine rule.* Unique.],
    [SSS],
    [Three sides, no angle: again no pair. *Cosine rule.*
      Unique, if the triangle exists at all. Compute the angle opposite
      the *largest* side first.],
  )
]

#exploration(title: "Answer the 'Why?'")[
  Two claims in the table above were asserted without justification.
  Settle both yourself:

  + *Why compute the largest angle first in the SSS case?* Suppose you
    found the two small angles with the cosine rule and then wanted to
    finish with the sine rule to save effort. What could go wrong? (Hint:
    only one angle in a triangle can be obtuse -- and which rule can
    detect an obtuse angle?) #heuristic("work backwards from the goal")

  + *Why does SSS not always have a solution?* Try to build a triangle
    with sides $2$, $3$, and $9$. Then compute $cos(gamma)$ for it with
    the cosine rule and see what your calculator says. What does the
    formula do when the triangle does not exist?
]

#only-theory[
  === The ambiguous case, up close
]

#example(title: "The ambiguous case (SSA)")[
  Given $alpha = 32 degree$, $a = 3$ cm, and $c = 5$ cm, calculate the
  missing sides and angles.

  The known angle $alpha$ sits opposite $a = 3$, the *shorter* of the
  two given sides -- so we are in the ambiguous case and must allow two
  solutions for $gamma$:
  $
    sin(gamma) / c = sin(alpha) / a quad --> quad
    sin(gamma) = (c dot sin(alpha)) / a = 0.8831...
  $
  $
    gamma_1 = sin^(-1)(0.8831...) approx 62 degree, quad
    gamma_2 = 180 degree - gamma_1 approx 118 degree.
  $
  Each choice determines the remaining angle:
  $
    beta_1 = 180 degree - 32 degree - 62 degree = 86 degree
    quad "and" quad
    beta_2 = 180 degree - 32 degree - 118 degree = 30 degree.
  $
  The sine rule then gives the missing side $b$ in each case:
  $
    b / sin(beta) = a / sin(alpha) quad --> quad
    b = (a dot sin(beta)) / sin(alpha)
  $
  $
    b_1 = (3 dot sin(86 degree)) / sin(32 degree) approx 5.65 " cm",
    quad
    b_2 = (3 dot sin(30 degree)) / sin(32 degree) approx 2.83 " cm".
  $
  Both are real triangles. Neither is the "right" one -- the given data
  simply does not distinguish them.

  #fig(image("images/ambiguous-case-two-triangles.pdf", width: 50%))
]

#only-theory[
  The figure makes the ambiguity concrete. Fix the angle $alpha$ and
  the side $c = A B$. Now side $a = 3$ must reach from $B$ to somewhere
  on the far ray -- so swing a circle of radius $3$ centered at $B$ and
  see where it lands. If $a$ is short, the circle can cross that ray
  *twice*, at $C_1$ and $C_2$, and both crossings are legitimate
  triangles. If $a$ is long enough to overshoot $A$, the circle crosses
  only once. If $a$ is too short to reach the ray at all, there is no
  triangle. That is the entire ambiguous case, in one picture.
]

#ai-box(role: "Explainer")[
  Ask an AI to explain the ambiguous case using the swinging-circle
  picture above -- and specifically to tell you the exact condition, in
  terms of $a$, $c$, and $alpha$, that separates two solutions from one
  from none. Then test its condition against the worked example
  ($alpha = 32 degree$, $a = 3$, $c = 5$) and against a case you
  construct yourself where you know there is exactly one solution.
  Does its rule survive both tests?
]

#ex(difficulty: 3, time: "40 min", keep-together: true)[
  Calculate the missing sides and angles of the general triangle
  $A B C$. If there are multiple solutions, give all of them.
  #fig(image("images/general-triangle-notation.pdf", width: 30%))
  #auto-parts(
    2,
    [$gamma = 30 degree$, $b = 12$, $a = 17$],
    [$gamma = 30 degree$, $c = 7$, $b = 14$],
    [$gamma = 47 degree$, $a = 20$, $beta = 55 degree$],
    [$alpha = 25 degree$, $c = 12$, $a = 7$],
    [$c = 23$, $b = 19$, $a = 11$],
    [$a = 34$, $beta = 43 degree$, $b = 28$],
  )
][
  #auto-parts(
    1,
    [SAS $->$ cosine rule: $c approx 8.93$,
      $alpha approx 107.8 degree$, $beta approx 42.2 degree$.
      (Sanity check: $a = 17$ is the longest side, so $alpha$ must be
      the largest angle.)],
    [SSA with $gamma$ opposite the shorter side, so check for ambiguity:
      $sin(beta) = 14 dot sin(30 degree) \/ 7 = 1$ exactly, so
      $beta = 90 degree$ and the two candidates coincide -- a unique
      solution after all. Then $alpha = 60 degree$ and
      $a approx 12.1$.],
    [Two angles given, so $alpha = 78 degree$; sine rule:
      $c approx 15.0$, $b approx 16.7$.],
    [SSA, $alpha$ opposite the shorter side $->$ *two solutions*: \
      $gamma_1 approx 46.4 degree$, $beta_1 approx 108.6 degree$,
      $b_1 approx 15.7$; \
      $gamma_2 approx 133.6 degree$, $beta_2 approx 21.4 degree$,
      $b_2 approx 6.05$.],
    [SSS $->$ cosine rule, largest side ($c = 23$) first:
      $gamma approx 96.5 degree$, then $alpha approx 28.4 degree$ and
      $beta approx 55.2 degree$.],
    [SSA, $beta$ opposite the shorter side $->$ *two solutions*: \
      $alpha_1 approx 55.9 degree$, $gamma_1 approx 81.1 degree$,
      $c_1 approx 40.6$; \
      $alpha_2 approx 124.1 degree$, $gamma_2 approx 12.9 degree$,
      $c_2 approx 9.17$.],
  )
]

#remark[
  Part (b) is the knife edge of the ambiguous case. The sine came out
  as exactly $1$, so the two candidate angles $sin^(-1)(1) = 90 degree$
  and $180 degree - 90 degree = 90 degree$ collapsed into one. In the
  swinging-circle picture, this is the circle touching the ray
  *tangentially* -- one crossing instead of two. A hair shorter and
  there would have been no triangle at all.
]

== Techniques You Know So Far

#only-theory[
  Before the applications, take stock. You now have a genuine toolkit
  for triangles, and choosing from it is most of the work.
]

#known-techniques(
  title: "Techniques for solving triangles",
  "The angle sum: the three angles total 180°, so two angles give you the third for free.",
  "The Pythagorean theorem: right triangles only, sides only, no angles.",
  "The right-triangle ratios (sin, cos, tan): right triangles only; relates one acute angle to two sides.",
  "The sine rule: any triangle, but needs a complete side–angle pair. Watch for the ambiguous case when hunting an angle.",
  "The cosine rule: any triangle, no pair needed. The only option for SAS and SSS, and the safer option for any angle.",
  "The area formula ½·b·c·sin(α): two sides and the angle between them.",
)

== Various Exercises

#ex(difficulty: 2, time: "25 min", keep-together: true)[
  The points of intersection of the three straight lines
  $
    f: quad & y = 2x - 1 \
    g: quad & y = 1/3 dot x + 2/3 \
    h: quad & y = -x + 6
  $
  form a triangle $A B C$. Determine:
  + the coordinates of the points $A$, $B$, and $C$;
  + the lengths $overline(A B)$, $overline(A C)$, and $overline(B C)$;
  + the interior angles of $A B C$;
  + the area of the triangle $A B C$.
][
  + $A = (1, 1)$, $B = (4, 2)$, $C = (7/3, 11/3)$.
  + $overline(A B) = sqrt(10) approx 3.16$,
    $overline(A C) = (4 sqrt(5))/3 approx 2.98$,
    $overline(B C) = (5 sqrt(2))/3 approx 2.36$.
  + Cosine rule (SSS): $alpha = 45 degree$,
    $beta approx 63.4 degree$, $gamma approx 71.6 degree$.
  + $1/2 dot overline(A B) dot overline(A C) dot sin(alpha)
    approx 3.33$.
]

#ex(difficulty: 2, time: "10 min", hints: (
  [A diagonal splits the parallelogram into two triangles. Which three
    pieces of each triangle do you know? #heuristic("draw a picture")],
  [The two diagonals need the two _different_ angles of the
    parallelogram. If one angle is $37 degree$, what is the other?],
))[
  Find the lengths of the diagonals of a parallelogram whose sides
  measure $14$ cm and $18$ cm and which has one angle of $37 degree$.
][
  Each diagonal closes a SAS triangle with sides $14$ and $18$. The
  parallelogram's angles are $37 degree$ and
  $180 degree - 37 degree = 143 degree$, so
  $
    d_1 & = sqrt(14^2 + 18^2 - 2 dot 14 dot 18 dot cos(37 degree))
          approx 10.8 " cm", \
    d_2 & = sqrt(14^2 + 18^2 - 2 dot 14 dot 18 dot cos(143 degree))
          approx 30.4 " cm".
  $
]

#ex(difficulty: 2, time: "10 min")[
  Find the area of the triangle $P Q R$.
  #fig(image("images/triangle-pqr-area.pdf", width: 30%))
][
  The third angle is $Q = 180 degree - 40 degree - 78 degree
  = 62 degree$. The sine rule gives a second side, e.g.
  $P R = 15 dot sin(62 degree) \/ sin(40 degree) approx 20.6$ cm, and
  then
  $A = 1/2 dot 15 dot 20.6 dot sin(78 degree) approx 151$ $"cm"^2$.
]

#ex(
  difficulty: 3,
  time: "30 min",
  keep-together: true,
  hints: (
    [Draw the cross-section: the two points $A$ and $B$ on the circle,
      the chord between them, and the center of the earth. The chord's
      midpoint $M$, the center, and the surface all lie on one line.
      #heuristic("draw a picture")],
    [The arc $s$ subtends a central angle of $s\/R$ radians -- radians
      earn their keep here. Half of it sits in the right triangle you
      need.],
    [The distance from the center to the chord is $R dot cos(s\/(2R))$.
      The curvature is what is left over.],
  ),
)[
  Due to the curvature of the earth, the surfaces of bodies of water are
  also curved. Consider two points $A$ and $B$ on the surface. Join them
  with a straight line and find the midpoint $M$ of that segment. The
  distance from $M$ to the surface is called the *curvature*.
  + Calculate the curvature of the Rhine ($150$ m). (Radius of the
    earth: $#num(6370)$ km.)
  + Calculate the curvature of Lake Constance (Bodensee) between
    Bregenz and Konstanz ($46$ km).
  + How much longer is the route from Bregenz to Konstanz on the
    water's surface than in a straight line? Does this result seem
    strange?
  + Find a general formula for the curvature of a route $s$.
][
  Answering (d) first makes the rest arithmetic. The arc $s$ subtends a
  central angle $phi.alt = s\/R$ radians. The perpendicular from the
  center to the chord bisects that angle, so the center-to-chord
  distance is $R dot cos(s\/(2R))$ and the curvature is the remainder:
  $
    h = R dot (1 - cos(s / (2R))) approx s^2 / (8R),
  $
  the approximation coming from $cos(x) approx 1 - x^2\/2$ for tiny
  $x$.
  + $h approx 150^2 \/ (8 dot #num(6370000)) approx 0.44$ mm.
  + $h approx #num(46000)^2 \/ (8 dot #num(6370000)) approx 41.5$ m.
  + The arc is $#num(46000)$ m; the chord is
    $2 R dot sin(s\/(2R)) approx #num(45999.9)$ m. The surface route is
    longer by only about $10$ cm -- over $46$ km. It _does_ seem
    strange next to a bulge of $41.5$ m, and the resolution is worth
    stating: the curvature grows like $s^2$, but the arc–chord
    difference grows like $s^3$, so at these scales it is
    vanishingly small. The lake bulges $41$ m upward and is still, for
    every practical purpose, flat to walk across.
]

#ex(level: "high", difficulty: 3, time: "15 min")[
  $P$, $R$, and $S$ lie on a circle with center $O$. Calculate
  $angle P R O$, $angle S R O$, and the area of the triangle $P R S$.
  #fig(image("images/circle-prs.pdf", width: 35%))
][
  $O P$, $O R$, and $O S$ are all radii, so both $O P R$ and $O R S$
  are isosceles with legs $8$ -- that is the fact the figure is built
  on. Cosine rule in each:
  $
    cos(angle P R O) & = (5^2 + 8^2 - 8^2) / (2 dot 5 dot 8) = 0.3125
                       quad --> quad angle P R O approx 71.8 degree, \
    cos(angle S R O) & = (10^2 + 8^2 - 8^2) / (2 dot 10 dot 8) = 0.625
                       quad --> quad angle S R O approx 51.3 degree.
  $
  Then $angle P R S approx 123.1 degree$ and
  $A = 1/2 dot 5 dot 10 dot sin(123.1 degree) approx 20.9$ $"cm"^2$.
]

#ex(difficulty: 3, time: "15 min")[
  Calculate the distance between $F$ and $G$.
  #fig(image("images/distance-fg.pdf", width: 35%))
][
  The $250$ m diagonal is shared by two triangles; solve each with the
  sine rule, then close with the cosine rule.
  In the left triangle the third angle is
  $180 degree - 78 degree - 35 degree = 67 degree$, so
  $250 dot sin(35 degree) \/ sin(67 degree) approx 155.8$ m.
  In the right triangle the third angle is
  $180 degree - 44 degree - 81 degree = 55 degree$, so
  $250 dot sin(81 degree) \/ sin(55 degree) approx 301.4$ m.
  These two sides enclose the angle $78 degree + 44 degree
  = 122 degree$, so
  $
    F G approx sqrt(
      155.8^2 + 301.4^2
      - 2 dot 155.8 dot 301.4 dot cos(122 degree)
    ) approx 406 " m".
  $
]

#ex(difficulty: 2, time: "10 min")[
  Calculate the distance between the two ships.
  #fig(image("images/plane-two-ships.png", width: 75%))
][
  The two depression angles give the horizontal distance from the point
  directly below the plane to each ship:
  $#num(10000)\/tan(52 degree) approx #num(7813)$ m and
  $#num(10000)\/tan(40 degree) approx #num(11918)$ m. The ships are on
  the same side, so
  $d approx #num(11918) - #num(7813) approx #num(4100)$ m.
]

#ex(difficulty: 2, time: "10 min", hints: (
  [The two hands are two sides of a triangle with the center of the
    clock as the enclosed vertex. What is the angle between them at
    exactly 10 o'clock? #heuristic("draw a picture")],
))[
  Calculate the distance between the tips of the hands of a large clock
  on a building at 10 o'clock, if the minute hand is $3$ m long and the
  hour hand is $2.25$ m long.
][
  At 10 o'clock the minute hand points at 12 and the hour hand at 10 --
  two hour-marks apart, so the enclosed angle is
  $2 dot 30 degree = 60 degree$. Cosine rule:
  $
    d = sqrt(3^2 + 2.25^2 - 2 dot 3 dot 2.25 dot cos(60 degree))
    approx 2.70 " m".
  $
]

#ex(difficulty: 3, time: "20 min", hints: (
  [A *bearing* is measured clockwise from north, and every leg of the
    journey gets its own north line. Draw both.],
  [At the turning point, find the interior angle of the triangle. The
    plane changed heading by $65 degree - 30 degree = 35 degree$ -- so
    how much did it fail to go straight on by?],
))[
  An airplane takes off from point $A$. It flies $850$ km on a bearing
  of $030 degree$. It then changes direction to a bearing of
  $065 degree$ and flies a further $500$ km, landing at $B$.
  + What is the straight-line distance from $A$ to $B$?
  + What is the bearing from $A$ to $B$?
  #fig(image("images/plane-bearings.png", width: 50%))
][
  + The heading changed by $35 degree$, so the interior angle at the
    turning point is $180 degree - 35 degree = 145 degree$. Cosine
    rule:
    $
      A B = sqrt(
        850^2 + 500^2
        - 2 dot 850 dot 500 dot cos(145 degree)
      ) approx #num(1290)
      " km".
    $
  + The sine rule gives the angle at $A$ between the first leg and
    $A B$: $sin(A) = 500 dot sin(145 degree) \/ #num(1292) approx 0.222$,
    so $A approx 12.8 degree$. The first leg was on bearing
    $030 degree$, so the bearing from $A$ to $B$ is
    $30 degree + 12.8 degree approx 042.8 degree$.
]

#exploration(title: "Does the Order Matter?")[
  In the flight above, the plane flew $850$ km then $500$ km. Suppose
  it had flown the two legs in the opposite order -- $500$ km on
  bearing $030 degree$, then $850$ km on bearing $065 degree$. Predict
  first, then check: does it land in the same place? Is the distance
  $A B$ the same? Is the *bearing* from $A$ to $B$ the same? Explain
  what your answer says about how the two legs combine -- you are
  discovering a property that will matter a great deal when you meet
  vectors.
]

#print-hints()
#print-vocab()
