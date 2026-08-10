#import "../../common/preamble.typ": *
#import "../../common/cplane.typ": *
#import "../../common/conic-figures.typ": *
#show: chapter-template.with(title: "Classifying")
#let ex = exercise.with(chapter: "Classifying")

// ── NOTE ON THE OLD CLASSIFICATION RULES ─────────────────────
// The LaTeX source gave five bullets, of which three are false as
// stated. Reproduced here so the corrections are traceable:
//
//   "If A = 0 or C = 0, then the conic is a parabola"
//        -- fails for y^2 = 4 (two parallel lines) and for
//           y^2 = -1 (empty). A parabola needs the LINEAR term in
//           the other variable to survive; that is the actual
//           condition and it is never stated.
//   "If A.C < 0, then the conic is a hyperbola"
//        -- fails for x^2 - y^2 = 0 (two crossing lines).
//   "If A.C > 0 then the conic is an ellipse"
//        -- fails for x^2 + y^2 = 0 (a point) and x^2 + y^2 = -1
//           (empty).
//   "If A = C, then the conic is a circle"
//        -- needs A = C != 0 AND B = 0, and even then only when the
//           constant comes out positive.
//
// The rules are correct for NON-DEGENERATE conics, which is
// presumably what was meant, but a student cannot know a conic is
// non-degenerate before classifying it -- that is what
// classifying IS. The keybox below therefore branches on the sign
// of the constant after completing the square, which decides every
// case including the degenerate ones, and the shortcut rules are
// given afterwards as a check rather than as the method.
//
// Rotation (B != 0) is CLASSIFICATION only here -- the
// discriminant, the invariants, and the angle that removes the
// cross term. Actually rotating a given conic through a given
// angle is ch-parametric, where the rotation matrix and
// multiplication by e^(i alpha) are both available.

= Classifying Conic Sections

#only-theory[
  Every chapter so far has run in one direction: from a geometric
  description to an equation. This one runs the other way. You are
  handed
  $
    x^2 - y^2 + 3 x - 2 y - 43 = 0
  $
  and asked what curve that is. There is no focus in sight, no
  directrix, no cone -- just a second-degree equation in two
  variables, of the kind that turns up when two conditions are
  combined or a physical model is written down.

  The good news is that the answer is always one of a short list, and
  the method is always the same: completing the square. The
  interesting news is that the short list is longer than three.
]

#look-back(
  title: "Everything, briefly",
  recalls: [all five previous chapters],
)[
  You will need the standard forms of all three conics, the fact that
  a hyperbola is identified by the *signs* of its terms and an ellipse
  by the sizes of its denominators, and the degenerate sections from
  the very first chapter -- the point, the single line and the pair of
  crossing lines. That last item is the one most likely to have been
  filed as a curiosity. It is about to become an answer.
]

#objectives(
  [recognize the general second-degree equation and name its
    coefficients],
  [classify and describe any conic with $B = 0$ by completing the
    square, including every degenerate case],
  [distinguish the five degenerate outcomes -- a point, one line, two
    crossing lines, two parallel lines, and the empty set -- and say
    which of them are genuinely sections of a cone],
  [use the discriminant $B^2 - 4 A C$ to classify a rotated conic
    without solving it],
  [use the invariance of $A + C$ and $B^2 - 4 A C$ under rotation as a
    check],
  [find the angle that removes the $x y$ term from a given equation],
)

== The General Second-Degree Equation

#definition(title: "General conic equation")[
  A #vocab("general second-degree equation", "allgemeine Gleichung
  zweiten Grades") in $x$ and $y$ is
  $
    A x^2 + B x y + C y^2 + D x + E y + F = 0 ,
  $
  where $A$, $B$, $C$, $D$, $E$, $F$ are real and $A$, $B$, $C$ are
  not all zero.
]

#only-theory[
  The six coefficients do three separate jobs, and separating them is
  most of the work.

  $A$, $B$ and $C$ -- the quadratic part -- fix the *type* and the
  orientation. $D$ and $E$ fix the *position*: they are what
  completing the square removes. And $F$, once the squares are
  completed, decides whether the curve is the real thing or one of its
  degenerate relatives.

  In particular $B$ is the rotation. If $B = 0$ the conic's axes are
  parallel to the coordinate axes, and everything can be done by
  completing the square. If $B != 0$ it is tilted, and a different
  tool is needed. Take the two cases in that order.
]

== The Case $B = 0$

#only-theory[
  With no $x y$ term the equation splits into an $x$-part and a
  $y$-part that do not interact:
  $
    A x^2 + D x + C y^2 + E y + F = 0 .
  $
  Complete the square in each variable that actually appears
  quadratically, and collect the constants on the right. Everything
  then depends on which of $A$ and $C$ are non-zero, and on the sign
  of what is left on the right.
]

#keybox(title: "Classification when $B = 0$")[
  Complete the square to reach one of the two forms below, and read
  off the answer.

  *Both $A != 0$ and $C != 0$.* The equation becomes
  $ A (x - u)^2 + C (y - v)^2 = K . $

  #table(
    columns: 3,
    stroke: none,
    align: left,
    [], [*$K$ has the sign of $A$*], [*other cases*],
    [$A C > 0$],
    [ellipse (circle if $A = C$)],
    [$K = 0$: a point; \ opposite sign: empty],

    [$A C < 0$], [hyperbola], [$K = 0$: two crossing lines],
  )

  *Exactly one of $A$, $C$ is zero*, say $C = 0$, so that
  $A(x - u)^2 = -E y + K$.
  - If $E != 0$: a *parabola*.
  - If $E = 0$: the equation involves $x$ alone, giving *two parallel
    lines*, *one line*, or *nothing*, according to the sign of
    $K slash A$.

  *Both $A = 0$ and $C = 0$* is excluded: the equation is linear.
]

#warning[
  The short rules "$A C > 0$ means ellipse, $A C < 0$ means
  hyperbola, one of them zero means parabola" are the ones you will
  meet in most textbooks, and each of them is false as it stands:

  - $x^2 + y^2 = 0$ has $A C > 0$ and is a single point;
  - $x^2 - y^2 = 0$ has $A C < 0$ and is the pair of lines
    $y = plus.minus x$;
  - $y^2 = 4$ has $A = 0$ and is a pair of parallel lines, not a
    parabola.

  The rules are correct for conics already known to be
  non-degenerate. But you cannot know that in advance: deciding it is
  precisely what classifying means. So use them as a *check* on the
  answer, never as the method. The method is completing the square,
  and it costs three lines.
]

#example(title: "A full classification")[
  Classify and describe $x^2 - y^2 + 3 x - 2 y - 43 = 0$.

  Here $A = 1$ and $C = -1$, so $A C < 0$ -- expect a hyperbola, but
  confirm it. Completing both squares:
  $
                (x^2 + 3 x) - (y^2 + 2 y) & = 43 \
    (x + 3 / 2)^2 - 9 / 4 - (y + 1)^2 + 1 & = 43 \
                (x + 3 / 2)^2 - (y + 1)^2 & = 177 / 4 .
  $
  The right-hand side is non-zero, so this is a genuine hyperbola.
  Dividing,
  $
    (x + 3 / 2)^2 / (177 slash 4) - (y + 1)^2 / (177 slash 4) = 1 ,
  $
  with centre $(-3 slash 2, -1)$ and $a = b = sqrt(177) slash 2$.
  Equal semi-axes: this is a *rectangular* hyperbola, so its
  asymptotes are perpendicular,
  $y + 1 = plus.minus (x + 3 slash 2)$, and its eccentricity is
  $sqrt(2)$ -- as it is for every rectangular hyperbola.

  Notice how little the shortcut rule told you. It got the type right
  and stopped there.
]

#remark[
  Watch the sign convention when the coefficient is not $1$. In
  $
    2 y^2 - 3 x^2 - 4 y + 12 x + 8 = 0
  $
  the coefficients must stay *outside* the completed squares:
  $2(y^2 - 2y) = 2(y-1)^2 - 2$, and it is $2$ that multiplies the
  $-1$, not $1$. Forgetting to multiply back is the single most
  common arithmetic slip in this chapter, and it produces an answer
  that looks entirely reasonable.
]

== The Degenerate Cases

#only-theory[
  Completing the square can produce five things that are not curves in
  the ordinary sense, and all five are legitimate answers.
]

#keybox(title: "The five degenerate outcomes")[
  #table(
    columns: 3,
    stroke: none,
    align: left,
    [*Example*], [*Solution set*], [*From a cone?*],
    [$4(x-1)^2 + 9(y+2)^2 = 0$], [the point $(1, -2)$], [yes],
    [$(x+1)^2 - 4(y-2)^2 = 0$], [two crossing lines], [yes],
    [$(y - 3)^2 = 0$], [one line (doubled)], [yes],
    [$9 x^2 = 36$], [two parallel lines], [*no*],
    [$(x+1)^2 + (y-2)^2 = -5$], [empty], [*no*],
  )
]

#only-theory[
  The last column is worth dwelling on, because it is the first
  chapter's classification read backwards. A plane through the apex of
  a cone gives a point, a line or two crossing lines, and those are
  exactly the first three rows. But no plane cuts a double cone in two
  *parallel* lines -- all the generators pass through the apex, so any
  two of them meet -- and no plane misses a double cone entirely,
  since the cone widens without bound.

  So the phrase "conic section" is slightly narrower than "solution
  set of a second-degree equation". Two of the five degenerate cases
  are algebraic possibilities with no geometric origin. The parallel
  lines do have one, though, if you are willing to move the apex to
  infinity: a plane parallel to the axis of a *cylinder* cuts it in
  two parallel lines, which is exactly what the sunlight exercise in
  the first chapter produced.
]

#example(title: "A degenerate one")[
  Classify $x^2 - 4 y^2 + 2 x + 16 y - 15 = 0$.

  With $A C = -4 < 0$ the shortcut says hyperbola. Complete the
  squares anyway:
  $
    (x + 1)^2 - 1 - 4(y - 2)^2 + 16 - 15 = 0
    quad ==> quad
    (x + 1)^2 - 4(y - 2)^2 = 0 .
  $
  The right-hand side is zero, so this is *not* a hyperbola. It is a
  difference of two squares and therefore factors:
  $
    ((x + 1) - 2(y - 2)) ((x + 1) + 2(y - 2)) = 0 ,
  $
  giving the two lines
  $ x - 2 y + 5 = 0 quad "and" quad x + 2 y - 3 = 0 , $
  which meet at $(-1, 2)$. Geometrically this is the limiting case in
  which a hyperbola's two branches have collapsed onto its own
  asymptotes.
]

#remark[
  Doing this on a *TI-Nspire CAS*: `completeSquare(expr, x)` will
  complete the square in one named variable, so applying it twice --
  once in $x$, once in $y$ -- reproduces the whole computation.
  Plotting the relation directly in the Graphs application is a fast
  check on the answer, and it is a particularly good check here,
  because a degenerate case that you have misclassified will look
  obviously wrong on screen. Do the algebra first and the plot second;
  a plot alone will not give you the centre or the eccentricity.
]

== The Case $B != 0$

#only-theory[
  An $x y$ term means the conic's axes are not parallel to the
  coordinate axes. Completing the square no longer helps, because
  there is no way to write $A x^2 + B x y + C y^2$ as a sum of squares
  in $x$ and $y$ separately.

  What saves the situation is that the *type* of the conic survives
  rotation. Rotating a picture cannot turn an ellipse into a
  hyperbola. So there should be some combination of $A$, $B$ and $C$
  that does not change when the axes are rotated, and that identifies
  the type. #heuristic("look for what stays the same")
]

#keybox(title: "The discriminant")[
  For $A x^2 + B x y + C y^2 + D x + E y + F = 0$, the
  #vocab("discriminant", "Diskriminante") is
  $ Delta = B^2 - 4 A C . $
  Provided the conic is non-degenerate:
  - $Delta < 0$: an ellipse (a circle when also $A = C$ and $B = 0$);
  - $Delta = 0$: a parabola;
  - $Delta > 0$: a hyperbola.
]

#remark[
  Check the new rule against the old one. When $B = 0$ the
  discriminant is $Delta = -4 A C$, so $Delta < 0$ means $A C > 0$ and
  $Delta > 0$ means $A C < 0$ -- exactly the shortcut rules of the
  previous section, and inheriting exactly their caveat about
  degenerate cases.
]

#theorem(title: "Rotation invariants")[
  Under a rotation of the coordinate axes through any angle, the two
  quantities
  $ A + C quad quad "and" quad quad B^2 - 4 A C $
  are unchanged.
]

#only-theory[
  The proof is a substitution and some patient trigonometry, which is
  left aside here; what matters is how to use it. Both invariants give
  a *free check* on any rotation you perform. If you rotate an
  equation and the new $A' + C'$ differs from the old $A + C$, you
  have made an arithmetic error, and you know it before doing anything
  else with the answer.
]

#keybox(title: "Removing the $x y$ term")[
  Rotating the axes through the angle $theta$ given by
  $ cot(2 theta) = (A - C) / B $
  turns the equation into one with no $x y$ term, which can then be
  classified by completing the square as before.

  In particular, when $A = C$ the right-hand side is $0$, so
  $2 theta = 90 degree$ and $theta = 45 degree$ -- which is why so
  many textbook examples are tilted at exactly $45 degree$.
]

#example(title: "A tilted ellipse")[
  Classify $7 x^2 - 6 sqrt(3) x y + 13 y^2 = 16$.

  First the type, which costs one line:
  $
    Delta = (-6 sqrt(3))^2 - 4 dot 7 dot 13 = 108 - 364 = -256 < 0 ,
  $
  so this is an ellipse. To see it in standard form, rotate. Here
  $
    cot(2 theta) = (7 - 13) / (-6 sqrt(3)) = 1 / sqrt(3)
    quad ==> quad 2 theta = 60 degree
    quad ==> quad theta = 30 degree .
  $
  Substituting $x = (sqrt(3) X - Y) slash 2$ and
  $y = (X + sqrt(3) Y) slash 2$ and collecting terms gives
  $
    4 X^2 + 16 Y^2 = 16
    quad ==> quad
    X^2 / 4 + Y^2 = 1 ,
  $
  an ellipse with $a = 2$ and $b = 1$, tilted at $30 degree$ to the
  coordinate axes. Its eccentricity is
  $c slash a = sqrt(3) slash 2$.

  The invariants check out: $A + C = 7 + 13 = 20$ before and
  $4 + 16 = 20$ after; $Delta = -256$ before and
  $0 - 4 dot 4 dot 16 = -256$ after. #sym.checkmark
]

#look-ahead(
  title: "Rotating on purpose",
  preview: [the parametric chapter],
)[
  This chapter rotates a conic in order to get *rid* of a tilt.
  Sometimes you want to put one in -- to write down the equation of an
  ellipse already known to be tilted at $30 degree$, say. That is the
  same substitution run the other way, and it is much easier with the
  right machinery: a rotation matrix from the vectors unit, or
  multiplication by $e^(i alpha)$ from complex numbers. Both appear in
  the parametric chapter.
]

// ── Exercises ────────────────────────────────────────────────

#ex(difficulty: 2, time: "35 min", calculator: false)[
  Classify each conic, put it in standard form, give its centre or
  vertex, and sketch it.
  #auto-parts(
    2,
    [$3 x^2 + 3 y^2 - 6 x + 9 y - 14 = 0$],
    [$6 x^2 + 12 x - y + 15 = 0$],
    [$x^2 + 2 y^2 + 4 x + 2 y - 27 = 0$],
    [$x^2 - y^2 + 3 x - 2 y - 43 = 0$],
  )
][
  #auto-parts(
    1,
    [$A = C = 3$, so expect a circle. Dividing by $3$ and completing
      both squares,
      $ (x - 1)^2 + (y + 3 / 2)^2 = 95 / 12 approx 7.92 , $
      a circle with centre $(1, -3 slash 2)$ and radius
      $sqrt(95 slash 12) approx 2.81$. (Leave the radius exact; the
      decimal is for the sketch only.)],
    [$C = 0$ and $E = -1 != 0$, so a parabola. Solving for $y$ and
      completing the square,
      $
        y = 6 x^2 + 12 x + 15 = 6(x + 1)^2 + 9
        quad ==> quad
        (x + 1)^2 = 1 / 6 (y - 9) .
      $
      Vertex $(-1, 9)$, opening upward, with $2 p = 1 slash 6$ so
      $p = 1 slash 12$: focus $(-1, 217 slash 24)$ and directrix
      $y = 215 slash 24$. A very narrow parabola, as $p$ small
      predicts.],
    [$A C = 2 > 0$ with $A != C$, so expect an ellipse:
      $
        (x + 2)^2 + 2 (y + 1 / 2)^2 = 63 / 2
        quad ==> quad
        (x + 2)^2 / (63 slash 2) + (y + 1 / 2)^2 / (63 slash 4) = 1 .
      $
      Centre $(-2, -1 slash 2)$, $a^2 = 63 slash 2$,
      $b^2 = 63 slash 4$, so $c = sqrt(63) slash 2
      = 3 sqrt(7) slash 2$ and $epsilon = 1 slash sqrt(2)$. The
      major axis is horizontal.],
    [Worked in the text: a rectangular hyperbola with centre
      $(-3 slash 2, -1)$ and $a = b = sqrt(177) slash 2$.],
  )
]

#ex(difficulty: 2, time: "25 min", calculator: false, hints: (
  [Complete the square first and look at what is left on the right.
    Only then reach for a shortcut rule.],
))[
  Each of the following looks like an ordinary conic and is not.
  Identify the solution set of each exactly, and say which of them
  could arise as the section of a double cone.
  #auto-parts(
    2,
    [$4 x^2 + 9 y^2 - 8 x + 36 y + 40 = 0$],
    [$x^2 - 4 y^2 + 2 x + 16 y - 15 = 0$],
    [$x^2 + y^2 + 2 x - 4 y + 10 = 0$],
    [$9 x^2 - 36 = 0$],
  )
][
  #auto-parts(
    1,
    [$4(x-1)^2 + 9(y+2)^2 = 4 + 36 - 40 = 0$. A sum of two
      non-negative terms is zero only if both vanish, so the solution
      set is the single point $(1, -2)$. From a cone: yes -- a plane
      through the apex with $phi.alt < alpha$.],
    [Worked in the text: the two crossing lines $x - 2y + 5 = 0$ and
      $x + 2y - 3 = 0$, meeting at $(-1, 2)$. From a cone: yes -- a
      plane through the apex with $phi.alt > alpha$.],
    [$(x+1)^2 + (y-2)^2 = -10 + 1 + 4 = -5$. A sum of squares is
      never negative, so the solution set is *empty*. From a cone:
      no. Every plane meets a double cone somewhere.],
    [$x^2 = 4$, so $x = plus.minus 2$: two parallel vertical lines.
      From a cone: no, since all generators pass through the apex and
      so no two of them are parallel. This one comes from a
      *cylinder*.],
  )
]

#ex(difficulty: 1, time: "10 min", calculator: false)[
  Use the discriminant to classify each of the following, assuming
  each is non-degenerate.
  #auto-parts(
    2,
    [$x^2 + 4 x y + y^2 - 12 = 0$],
    [$5 x^2 + 6 x y + 5 y^2 - 8 = 0$],
    [$x^2 + 2 x y + y^2 + x - y = 0$],
    [$x y = 4$],
  )
][
  #auto-parts(
    2,
    [$Delta = 16 - 4 = 12 > 0$: hyperbola.],
    [$Delta = 36 - 100 = -64 < 0$: ellipse.],
    [$Delta = 4 - 4 = 0$: parabola.],
    [$A = C = 0$, $B = 1$, so $Delta = 1 > 0$: hyperbola -- as the
      hyperbola chapter showed directly.],
  )
]

#ex(difficulty: 3, time: "30 min", calculator: false, hints: (
  [Both have $A = C$, so the angle is the same in each and you know
    it without computing anything.],
  [Substitute $x = (X - Y) slash sqrt(2)$ and
    $y = (X + Y) slash sqrt(2)$, and note that $x^2 + y^2$ and
    $x y$ each simplify on their own.],
))[
  Remove the $x y$ term from each equation by rotating the axes, put
  the result in standard form, and state the semi-axes and the
  eccentricity.
  #auto-parts(
    1,
    [$x^2 + 4 x y + y^2 = 12$],
    [$5 x^2 + 6 x y + 5 y^2 = 8$],
  )
  Then check both answers against the two rotation invariants.
][
  Both have $A = C$, so $cot(2 theta) = 0$ and $theta = 45 degree$.
  With $x = (X - Y) slash sqrt(2)$ and $y = (X + Y) slash sqrt(2)$,
  $
    x^2 + y^2 = X^2 + Y^2 ,
    quad quad
    x y = (X^2 - Y^2) / 2 .
  $

  #auto-parts(
    1,
    [$
        X^2 + Y^2 + 2(X^2 - Y^2) = 3 X^2 - Y^2 = 12
        quad ==> quad
        X^2 / 4 - Y^2 / 12 = 1 ,
      $
      a hyperbola with $a = 2$, $b = 2 sqrt(3)$, so $c = 4$ and
      $epsilon = 2$. Invariants: $A + C = 2$ before and
      $3 + (-1) = 2$ after; $Delta = 12$ before and
      $0 - 4 dot 3 dot (-1) = 12$ after. #sym.checkmark],
    [$
        5(X^2 + Y^2) + 3(X^2 - Y^2) = 8 X^2 + 2 Y^2 = 8
        quad ==> quad
        X^2 + Y^2 / 4 = 1 ,
      $
      an ellipse with $a = 2$ along the *new* $Y$-axis and $b = 1$,
      so $c = sqrt(3)$ and $epsilon = sqrt(3) slash 2$. Invariants:
      $A + C = 10$ before and $8 + 2 = 10$ after; $Delta = -64$ before
      and $0 - 4 dot 8 dot 2 = -64$ after. #sym.checkmark

      Note that the major axis came out along $Y$, not $X$: rotating
      by $45 degree$ does not guarantee that the transverse direction
      lands where you expected. The denominators decide, as always.],
  )
]

#ex(difficulty: 3, time: "25 min", calculator: false, hints: (
  [For the first part, what does $Delta = 0$ say about the quadratic
    part $A x^2 + B x y + C y^2$ as a quadratic in $x$?],
))[
  #auto-parts(
    1,
    [Show that $Delta = B^2 - 4 A C = 0$ holds exactly when the
      quadratic part $A x^2 + B x y + C y^2$ is a perfect square (up
      to a constant factor), and explain why that makes a parabola
      the natural outcome.],
    [Find all values of $k$ for which
      $k x^2 + 4 x y + k y^2 = 9$ is an ellipse, a parabola, and a
      hyperbola.],
    [For which of those $k$ is the curve actually a *circle*?],
  )
][
  #auto-parts(
    1,
    [Regard $A x^2 + B x y + C y^2$ as a quadratic in $x$ with
      coefficients $A$, $B y$, $C y^2$. Its discriminant is
      $(B y)^2 - 4 A (C y^2) = (B^2 - 4 A C) y^2 = Delta y^2$. So
      $Delta = 0$ means a repeated root, and the quadratic part
      factors as $A (x - m y)^2$ for a single $m$ -- a perfect square.

      The equation then reads $A(x - m y)^2 + D x + E y + F = 0$: one
      squared expression and a linear remainder. That is exactly the
      shape of a parabola, which has a square in one direction and a
      linear term in the other. When $Delta != 0$ the quadratic part
      factors into two *different* linear factors (real if
      $Delta > 0$, complex if $Delta < 0$), and those two directions
      become the two axes -- or, for a hyperbola, the two
      asymptotes.],
    [$Delta = 16 - 4 k^2 = 4(4 - k^2) = 4(2-k)(2+k)$. Hence
      $
          Delta < 0 " (ellipse) " & <==> abs(k) > 2 , \
         Delta = 0 " (parabola) " & <==> k = plus.minus 2 , \
        Delta > 0 " (hyperbola) " & <==> abs(k) < 2 .
      $
      One caveat worth stating: at $k = plus.minus 2$ the quadratic
      part is $plus.minus 2(x plus.minus y)^2$ and there are no linear
      terms at all, so the equation reduces to
      $(x plus.minus y)^2 = plus.minus 9 slash 2$ -- two parallel
      lines when the sign works out, and empty when it does not.
      Degenerate in both cases, which is why the discriminant rule
      carries its "provided the conic is non-degenerate" clause.],
    [Never. A circle needs $B = 0$, and here $B = 4$ for every $k$.
      The curve is a tilted ellipse for $abs(k) > 2$, at $45 degree$
      since $A = C$, and its two semi-axes are never equal.],
  )
]

#ai-box(role: "Checker")[
  The false shortcut rules corrected in this chapter are widespread.

  + Ask an AI assistant: *"Classify the curve
    $x^2 - 4 y^2 + 2 x + 16 y - 15 = 0$."* Record the answer before
    reading on.
  + If it said "hyperbola", it applied $A C < 0$ without completing
    the square. Ask it to solve the equation explicitly and to state
    the solution set. Does it correct itself, or does it defend the
    first answer?
  + Now the harder question, and the one worth your time: a rule that
    is right for every non-degenerate conic will be right almost
    every time it is used. What does that tell you about how errors of
    this kind survive in textbooks -- and about how much confidence
    you should place in an answer that is usually right?
]

#print-vocab()
