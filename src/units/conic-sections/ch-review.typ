#import "../../common/preamble.typ": *
#import "../../common/cplane.typ": *
#import "../../common/conic-figures.typ": *
#show: chapter-template.with(title: "Review")
#let ex = exercise.with(chapter: "Review")

// ── NOTE ON THE INHERITED EXAM QUESTIONS ─────────────────────
// Exercises 1-5 are the "Final Exam Questions" of the old LaTeX
// notes (its 22-26), re-typed and re-verified. Three needed
// repair, and the repairs are recorded in the solutions so a
// student with an old printout can see what changed:
//
//   * Ex 2 (old 23): the line g was never defined in the text,
//     only drawn in the figure. It is the major axis of K2, i.e.
//     y = x/sqrt(3). Without that the last part is unanswerable.
//   * Ex 2(d): the old answer "10.759" is the area of the part of
//     K2 lying on ONE side of the y-axis -- equivalently half the
//     lens K2 & K3. Confirmed numerically to four decimals, and
//     an exact closed form is now given. The old statement did not
//     say which region was meant.
//   * Ex 4 (old 25): as stated the region is not closed on the
//     left. The answer 4pi/3 requires the x-axis segment from
//     (0,0) to (1,0) as the upper boundary on 0 <= x <= 1, and
//     the statement now says so.
//
// Exercise 6 is old Ex 17 (lattice points), which had no home in
// the reworked chapters and is good enrichment. Old Ex 9 (the
// ellipses in the K1..K4 figure) is the same figure as Ex 2 and
// is folded into it.

= Review and Examination Problems

#only-theory[
  Everything in this unit now exists: three curves, two definitions
  each and a proof that they agree, a classification procedure, a
  tangent, and two ways of writing every conic down. What is left is
  to use them together, which is what an examination question does and
  what no single chapter has asked for.

  The problems below are longer than the ones in the chapters, and
  they are deliberately not sorted by topic. Part of the work is
  deciding which tool applies.
]

#keybox(title: "Know cold, or look up")[
  The formula booklet is on the desk during the examination. Knowing
  which half of this list you are allowed to forget is worth real
  marks.

  *Know cold.* The three locus definitions. $a^2 = b^2 + c^2$ for the
  ellipse and $c^2 = a^2 + b^2$ for the hyperbola, and which is which.
  $epsilon = c slash a$, and that $epsilon < 1$, $= 1$, $> 1$
  separates the three. Completing the square. That an ellipse is read
  off from the *sizes* of its denominators and a hyperbola from the
  *signs*. That the asymptotes come from replacing $1$ by $0$.

  *Look up.* The tangent conditions
  $q^2 = a^2 m^2 plus.minus b^2$ and $q = p slash (2m)$. The splitting
  rule for the tangent at a point. Conjugate directions
  $m_1 m_2 = -b^2 slash a^2$. The directrix distance
  $a^2 slash c$. The parametrizations.

  Everything in the second list is a formula. Everything in the first
  is a decision, and the booklet cannot make decisions for you.
]

// ── Exercises ────────────────────────────────────────────────

#ex(difficulty: 3, time: "50 min", calculator: true, hints: (
  [For (c), the corners of the rectangle are $(u plus.minus a,
    v plus.minus b)$. Put the hyperbola in the form
    $(x-u)^2 slash a_2^2 - (y-v)^2 slash a_2^2 = 1$ and substitute
    one corner.],
  [For (f), the point $(5,8)$ is the upper vertex of $K_1$. Where must
    the centre of a circle touching $K_1$ there lie?],
))[
  Consider the curve
  $ K_1: quad 16 x^2 - 160 x + 25 y^2 - 200 y + 400 = 0 . $
  #auto-parts(
    1,
    [What type of curve does the equation describe?],
    [Calculate the coordinates of the centre, the foci and *all* the
      vertices of $K_1$, and draw the curve. Use two grid squares as
      the unit on both axes, and place at least four points exactly.],
    [$K_1$ is enclosed by a rectangle with sides parallel to the
      coordinate axes. Determine the equation of the rectangular
      hyperbola $K_2$ (that is, with $a = b$) centred at the same
      point and passing through all four corners of that rectangle.],
    [Determine the equations of the asymptotes of $K_2$.],
    [Draw $K_2$ and its asymptotes, with at least six exact points.],
    [A circle $K_3$ touches both asymptotes of $K_2$ and touches
      $K_1$ from the inside at the point $(5, 8)$. Determine its
      radius and its centre, exactly and to three significant
      figures.],
  )
][
  #auto-parts(
    1,
    [Both squares are present with coefficients of the same sign
      ($16$ and $25$), so expect an ellipse -- confirmed by (b),
      where the constant comes out positive.],
    [Completing both squares,
      $
        16(x - 5)^2 - 400 + 25(y - 4)^2 - 400 + 400 = 0
        quad ==> quad
        16(x-5)^2 + 25(y-4)^2 = 400 ,
      $
      so
      $ (x-5)^2 / 25 + (y-4)^2 / 16 = 1 . $
      Centre $M = (5, 4)$, $a = 5$, $b = 4$, $c = 3$. Hence
      $
        F_1 = (8, 4), quad F_2 = (2, 4), quad
        A_1 = (10, 4), quad A_2 = (0, 4), \
        B_1 = (5, 8), quad B_2 = (5, 0) .
      $
      Note the question says *all* vertices: four points, not two.],
    [The rectangle has corners $(5 plus.minus 5, 4 plus.minus 4)$,
      that is $(0,0)$, $(10,0)$, $(0,8)$, $(10,8)$. A rectangular
      hyperbola centred at $(5,4)$ has the form
      $
        (x-5)^2 / a^2 - (y-4)^2 / a^2 = 1 .
      $
      Substituting the corner $(10, 8)$: $25 slash a^2 - 16 slash a^2
      = 9 slash a^2 = 1$, so $a^2 = 9$ and
      $ K_2: quad (x-5)^2 / 9 - (y-4)^2 / 9 = 1 . $
      By symmetry all four corners then lie on it.],
    [Replace $1$ by $0$: $(x-5)^2 = (y-4)^2$, so
      $y - 4 = plus.minus (x - 5)$, that is
      $ y = x - 1 quad "and" quad y = -x + 9 . $
      Perpendicular, as they must be for a rectangular hyperbola.],
    [The vertices of $K_2$ are $(2,4)$ and $(8,4)$; the four rectangle
      corners are on the curve; the asymptotes cross at $(5,4)$.],
    [The point $(5,8)$ is the upper vertex $B_1$ of $K_1$, where the
      tangent is horizontal. A circle touching $K_1$ there must have
      its centre on the vertical line $x = 5$, directly below the
      point of contact, so its centre is $(5, 8 - r)$.

      It also touches the asymptote $y = x - 1$, that is
      $x - y - 1 = 0$, so its distance to that line equals $r$:
      $
        (abs(5 - (8 - r) - 1)) / sqrt(2) = r
        quad ==> quad
        (4 - r) / sqrt(2) = r
      $
      (taking $r < 4$, since the circle sits inside). Then
      $4 - r = r sqrt(2)$, so
      $
        r = 4 / (1 + sqrt(2)) = 4(sqrt(2) - 1) approx 1.66 ,
      $
      and the centre is
      $ M_3 = (5, 12 - 4 sqrt(2)) approx (5, 6.34) . $
      By symmetry the distance to the other asymptote is the same.],
  )
]

#ex(difficulty: 3, time: "60 min", calculator: true, hints: (
  [For (b), $K_2$ and $K_3$ are mirror images in the $y$-axis, so
    their intersections lie on it. A point $(0,t)$ is on $K_2$ exactly
    when its rotation by $-120 degree$ is on $K_1$.],
  [For (c), parametrize $K_1$ and minimise the square of the
    distance.],
  [For (d), rotate the whole picture back so that $K_2$ becomes $K_1$,
    then squash $K_1$ into a circle. Areas scale by a constant factor
    under both moves.],
))[
  Three ellipses $K_1$, $K_2$, $K_3$ all have one focus at the origin.
  $K_2$ and $K_3$ are obtained by rotating $K_1$ about the origin
  through $120 degree$ and $240 degree$. The first is
  $ K_1: quad 25 x^2 + 16 y^2 - 96 y - 256 = 0 . $
  Let $P$ be the upper point where $K_2$ and $K_3$ meet, let $A$ be
  the region lying inside $K_2$ and to the right of the $y$-axis, and
  let $g$ be the major axis of $K_2$.
  #auto-parts(
    1,
    [Calculate the centre, the foci and all four vertices of $K_1$.],
    [Determine the coordinates of $P$.],
    [Determine the points of $K_1$ closest to $P$.],
    [Calculate the area of $A$.],
    [Show that $g$ has equation $y = x slash sqrt(3)$. The circle
      $K_4$ with centre $C = (8, 4 sqrt(3))$ touches $g$ at $Q$;
      find the radius of $K_4$ and the coordinates of $Q$.],
  )
][
  #auto-parts(
    1,
    [Completing the square in $y$,
      $
        25 x^2 + 16(y - 3)^2 - 144 - 256 = 0
        quad ==> quad
        x^2 / 16 + (y-3)^2 / 25 = 1 .
      $
      Centre $(0, 3)$; since $25 > 16$ the major axis is vertical with
      $a = 5$, $b = 4$, $c = 3$. Hence
      $
        F_1 = (0, 0), quad F_2 = (0, 6), quad
        A_1 = (0, 8), quad A_2 = (0, -2), \
        B_1 = (4, 3), quad B_2 = (-4, 3) .
      $
      The focus at the origin is what makes the rotation
      construction work: all three ellipses share it.],
    [$K_2$ and $K_3$ are reflections of each other in the $y$-axis, so
      they meet on it. A point $(0, t)$ lies on $K_2$ exactly when its
      rotation through $-120 degree$, namely
      $(t sqrt(3) slash 2, -t slash 2)$, lies on $K_1$:
      $
        (3 t^2 slash 4) / 16 + (-t slash 2 - 3)^2 / 25 = 1 .
      $
      Multiplying by $1600$ and collecting,
      $91 t^2 + 192 t - 1024 = 0$, whose roots are
      $t = 32 slash 13$ and $t = -32 slash 7$. The upper one gives
      $
        P = (0, 32 / 13) approx (0, 2.462) .
      $],
    [Parametrize $K_1$ as $(4 cos theta, 3 + 5 sin theta)$ and write
      $s = sin theta$. Then
      $
        d^2 & = 16 cos^2 theta + (3 + 5 s - 32 / 13)^2
        = 16(1 - s^2) + (5 s + 7 / 13)^2 \
        & = 9 s^2 + (70 s) / 13 + "const" ,
      $
      a quadratic in $s$ with positive leading coefficient. Its
      minimum is at
      $
        s = -70 / (13 dot 18) = -35 / 117 ,
      $
      which lies in $[-1, 1]$ and is therefore attained. Then
      $y = 3 + 5 s = 176 slash 117$ and
      $x = plus.minus 4 sqrt(1 - s^2) = plus.minus 16 sqrt(779)
      slash 117$, so the two closest points are
      $
        (plus.minus 16 sqrt(779) / 117, 176 / 117)
        approx (plus.minus 3.817, 1.504) .
      $
      Two of them, by the symmetry of $K_1$ about the $y$-axis, on
      which $P$ lies.],
    [Rotate the whole picture through $-120 degree$. This is an
      isometry, so it preserves area; $K_2$ becomes $K_1$, and the
      $y$-axis becomes the line through the origin with direction
      $(sqrt(3) slash 2, -1 slash 2)$, that is $y = -x slash
      sqrt(3)$. So $A$ has the same area as the region of $K_1$ cut
      off by that line.

      Now squash: the map $(x, y) |-> (x slash 4, (y - 3) slash 5)$
      turns $K_1$ into the unit circle and multiplies every area by
      $1 slash 20$. The cutting line becomes
      $Y = -(4 slash (5 sqrt(3))) X - 3 slash 5$, whose distance from
      the origin is
      $
        d = (3 slash 5) / sqrt(1 + 16 slash 75)
        = (3 sqrt(3)) / sqrt(91) approx 0.5447 .
      $
      A chord of the unit circle at distance $d$ from the centre cuts
      off a segment of area $1 / 2 (theta - sin(theta))$, where
      $cos(theta slash 2) = d$. Here $theta slash 2 = arccos(0.5447)
      approx 0.99476$, so $theta approx 1.98952$ and the segment has
      area $approx 0.53795$. Undoing the squash,
      $
        A = 20 dot 0.53795 approx 10.759 ,
      $
      or exactly $A = 20 arccos(3 sqrt(3) slash sqrt(91))
      - 480 sqrt(3) slash 91$.

      A CAS will also do this by numerical integration, and in an
      examination that is a perfectly good route. The transformation
      route is worth seeing because it uses the ellipse-as-squashed-
      circle idea to replace an integral by a fact about circles.],
    [The major axis of $K_1$ is the $y$-axis. Rotating a line through
      the origin by $120 degree$ turns direction $(0,1)$ into
      $(-sqrt(3) slash 2, -1 slash 2)$, a direction of slope
      $1 slash sqrt(3)$, so
      $ g: quad y = x / sqrt(3), quad "or" quad x - sqrt(3) y = 0 . $
      The distance from $C = (8, 4 sqrt(3))$ to $g$ is
      $
        r = (abs(8 - sqrt(3) dot 4 sqrt(3))) / sqrt(1 + 3)
        = (abs(8 - 12)) / 2 = 2 .
      $
      The point of contact is the foot of the perpendicular from $C$.
      The line through $C$ perpendicular to $g$ has direction
      $(1, -sqrt(3)) slash 2$, and moving $r = 2$ along it from $C$
      gives
      $
        Q = (8, 4 sqrt(3)) + 2 dot (1 / 2, -sqrt(3) / 2)
        = (9, 3 sqrt(3)) .
      $
      Check: $9 slash sqrt(3) = 3 sqrt(3)$, so $Q$ is on $g$.
      #sym.checkmark],
  )
]

#ex(difficulty: 2, time: "25 min", calculator: false)[
  Consider the hyperbola
  $ 9 x^2 - 16 y^2 - 36 x + 32 y - 124 = 0 . $
  #auto-parts(
    1,
    [Determine the coordinates of the centre, the foci and the
      vertices.],
    [Determine the equations of the asymptotes.],
    [Draw the hyperbola and its asymptotes, with at least six exact
      points.],
  )
][
  #auto-parts(
    1,
    [Completing both squares, keeping the coefficients outside,
      $
        9(x-2)^2 - 36 - 16(y-1)^2 + 16 - 124 = 0
        quad ==> quad
        9(x-2)^2 - 16(y-1)^2 = 144 ,
      $
      so
      $ (x-2)^2 / 16 - (y-1)^2 / 9 = 1 . $
      Centre $(2,1)$, $a = 4$, $b = 3$, $c = 5$, hence
      $
        F_1 = (7, 1), quad F_2 = (-3, 1), quad
        V_1 = (6, 1), quad V_2 = (-2, 1) .
      $],
    [Replacing $1$ by $0$ gives
      $y - 1 = plus.minus 3 / 4 (x - 2)$, that is
      $ 3 x - 4 y - 2 = 0 quad "and" quad 3 x + 4 y - 10 = 0 . $],
    [Draw the asymptote rectangle with corners
      $(2 plus.minus 4, 1 plus.minus 3)$, extend its diagonals, mark
      the vertices at the midpoints of two of its sides, and sketch
      each branch from its vertex out towards the diagonals. Six exact
      points: the two vertices and the four rectangle corners.],
  )
]

#ex(difficulty: 3, time: "25 min", calculator: false, hints: (
  [Sketch first and identify all four boundary pieces before setting
    up any integral.],
))[
  Consider the hyperbola $x^2 - y^2 = 1$.
  #auto-parts(
    1,
    [Sketch the hyperbola together with its asymptotes.],
    [In the fourth quadrant, the asymptote $y = -x$, the $x$-axis, the
      right branch of the hyperbola and the line $x = 2$ enclose a
      finite region $A$. Determine the volume of the solid obtained by
      rotating $A$ about the $x$-axis.],
  )
][
  #auto-parts(
    1,
    [$a = b = 1$: a rectangular hyperbola with vertices
      $(plus.minus 1, 0)$, asymptotes $y = plus.minus x$, and foci
      $(plus.minus sqrt(2), 0)$.],
    [The region has two parts, because its upper boundary changes at
      $x = 1$ where the branch meets the $x$-axis:
      - for $0 <= x <= 1$ it runs from $y = -x$ up to $y = 0$;
      - for $1 <= x <= 2$ it runs from $y = -x$ up to
        $y = -sqrt(x^2 - 1)$.
      Rotating about the $x$-axis, use washers with outer radius
      $abs(-x) = x$ throughout and inner radius $0$ then
      $sqrt(x^2 - 1)$:
      $
        V & = pi integral_0^1 x^2 dif x
        + pi integral_1^2 (x^2 - (x^2 - 1)) dif x \
        & = pi dot 1 / 3 + pi integral_1^2 1 dif x
        = pi / 3 + pi = (4 pi) / 3 .
      $
      The second integrand collapsing to the constant $1$ is the
      hyperbola's equation doing the work: $x^2 - y^2 = 1$ says
      exactly that the difference of the two squared radii is
      constant, so the washer has the same area at every $x$.

      *A note on the statement.* Older printings of this problem name
      only the hyperbola, its asymptotes and the line $x = 2$. That
      does not close the region on the left: between $x = 0$ and
      $x = 1$ there is no hyperbola to bound it above. The $x$-axis
      is needed, and the answer $4 pi slash 3$ assumes it.],
  )
]

#ex(difficulty: 3, time: "30 min", calculator: false)[
  Consider the two curves
  $ K_1: y^2 - 4 x^2 - 4 = 0 quad "and" quad K_2: y^2 - 8 x = 0 . $
  #auto-parts(
    1,
    [Sketch $K_1$ and $K_2$ for $x in [-2, 2]$ in one coordinate
      system, identifying each.],
    [Determine the equations of all asymptotes of $K_1$.],
    [Calculate the common points of $K_1$ and $K_2$.],
    [In the first quadrant $K_1$, $K_2$ and the $y$-axis enclose a
      finite region $A$. Determine the volume of the solid obtained by
      rotating $A$ about the $x$-axis.],
  )
][
  #auto-parts(
    1,
    [$K_1$ is $y^2 slash 4 - x^2 = 1$, a hyperbola opening up and
      down with $a = 2$, $b = 1$, vertices $(0, plus.minus 2)$.
      $K_2$ is $y^2 = 8 x$, a parabola opening to the right with
      $2p = 8$, so $p = 4$ and focus $(2, 0)$.],
    [Replacing $1$ by $0$ in $y^2 slash 4 - x^2 = 1$ gives
      $ y = plus.minus 2 x . $
      Note the slope is $a slash b$ here, not $b slash a$: the
      hyperbola opens vertically.],
    [Substituting $y^2 = 8x$ into $y^2 - 4x^2 - 4 = 0$:
      $
        8 x - 4 x^2 - 4 = 0
        quad ==> quad
        x^2 - 2 x + 1 = (x-1)^2 = 0 ,
      $
      a double root at $x = 1$. Then $y^2 = 8$, so the common points
      are
      $ P_(1,2) = (1, plus.minus 2 sqrt(2)) . $
      The repeated root says the two curves are *tangent* to each
      other there -- which, after the tangents chapter, is a fact you
      can now name rather than merely notice.],
    [In the first quadrant the hyperbola is
      $y = 2 sqrt(x^2 + 1)$ and the parabola is
      $y = sqrt(8 x)$. At $x = 0$ they are at $2$ and $0$; they meet
      at $x = 1$. The hyperbola is the upper boundary throughout, so
      by washers,
      $
        V & = pi integral_0^1 ((2 sqrt(x^2+1))^2 - (sqrt(8x))^2)
          dif x \
        & = pi integral_0^1 (4 x^2 + 4 - 8 x) dif x
        = pi [ (4 x^3) / 3 + 4 x - 4 x^2 ]_0^1
        = (4 pi) / 3 .
      $],
  )
]

#ex(difficulty: 3, time: "35 min", calculator: false, hints: (
  [For (b), factor. Two integers of the same parity have a sum and a
    difference that are both even.],
))[
  A *lattice point* is a point both of whose coordinates are integers.
  #auto-parts(
    1,
    [Show that if a parabola $y = a x^2$ has one lattice point other
      than the origin, then it has infinitely many.],
    [Find all lattice points on the hyperbola $x^2 - y^2 = 84$.],
    [Find a condition on the integer $k$ that decides whether the
      hyperbola $y^2 - x^2 = k$ contains any lattice points at all.],
  )
][
  #auto-parts(
    1,
    [Suppose $(m, n)$ lies on the curve with $m, n in ZZ$ and
      $m != 0$. Then $a = n slash m^2$. For any integer $j$, the point
      with $x = j m$ has
      $
        y = a (j m)^2 = n / m^2 dot j^2 m^2 = n j^2 ,
      $
      an integer. So $(j m, n j^2)$ is a lattice point for every
      integer $j$, and there are infinitely many.],
    [Factor: $(x - y)(x + y) = 84$. The two factors have the same
      parity, since their sum $2x$ is even. They cannot both be odd,
      because their product $84$ is even. So both are even: write
      $x - y = 2 u$ and $x + y = 2 v$, giving $4 u v = 84$, that is
      $ u v = 21 . $
      The divisor pairs of $21$, with signs, are
      $(u,v) = (1,21), (3,7), (7,3), (21,1)$ and their negatives, and
      $x = u + v$, $y = v - u$. This gives
      $
        (plus.minus 22, plus.minus 20)
        quad "and" quad
        (plus.minus 10, plus.minus 4) ,
      $
      all sign combinations independently -- eight lattice points in
      all. Check: $22^2 - 20^2 = 484 - 400 = 84$ and
      $10^2 - 4^2 = 100 - 16 = 84$. #sym.checkmark],
    [The same factoring gives $(y-x)(y+x) = k$ with both factors of
      equal parity. If they are both odd then $k$ is odd; if both
      even then $k$ is divisible by $4$. Conversely both cases occur:
      for odd $k$ take $y - x = 1$ and $y + x = k$, giving
      $y = (k+1) slash 2$ and $x = (k-1) slash 2$; for $k$ divisible
      by $4$ take $y - x = 2$ and $y + x = k slash 2$, giving
      $y = 1 + k slash 4$ and $x = k slash 4 - 1$.

      So $y^2 - x^2 = k$ has lattice points exactly when
      $ k equiv.not 2 quad (mod 4) , $
      that is, when $k$ is odd or a multiple of $4$. The excluded
      cases are $k = 2, 6, 10, 14, dots$ -- a number that is even but
      not divisible by four is never a difference of two squares.],
  )
]

#ex(difficulty: 2, time: "25 min", calculator: false)[
  A single conic is described in five different ways below. Show that
  all five describe the *same* curve, and give its equation in
  standard form.
  #auto-parts(
    1,
    [The set of points whose distances to $(0, 0)$ and to $(6, 0)$
      sum to $10$.],
    [The section of a cone with $alpha = 60 degree$ cut at
      $phi.alt$ with $sin(phi.alt) = 3 sqrt(3) slash 10$, positioned
      so that its centre is $(3, 0)$ and its major axis is
      horizontal.],
    [The curve with a focus at $(0,0)$, directrix
      $x = -16 slash 3$ and eccentricity $3 slash 5$.],
    [The image of the circle $(x - 3)^2 + y^2 = 25$ under the map
      $(x, y) |-> (x, 4 y slash 5)$.],
    [The curve traced by $(3 + 5 cos t, 4 sin t)$.],
  )
][
  All five give
  $ (x - 3)^2 / 25 + y^2 / 16 = 1 , $
  an ellipse with centre $(3, 0)$, $a = 5$, $b = 4$, $c = 3$,
  $epsilon = 3 slash 5$ and foci $(0,0)$ and $(6,0)$.

  #auto-parts(
    1,
    [The two-focus definition with $2a = 10$ and
      $2c = 6$, so $a = 5$, $c = 3$, $b^2 = 25 - 9 = 16$.],
    [By the eccentricity formula from the Dandelin section,
      $epsilon = sin(phi.alt) slash sin(alpha)
      = (3 sqrt(3) slash 10) slash (sqrt(3) slash 2)
      = 3 slash 5$. With the stated centre and orientation, and
      $epsilon = c slash a$, this fixes the same curve up to size --
      and the two given foci in (a) fix the size.],
    [Focus--directrix with $epsilon = 3 slash 5$. The directrices of
      an ellipse sit at distance $a slash epsilon = a^2 slash c
      = 25 slash 3$ from the *centre*, so here at
      $x = 3 plus.minus 25 slash 3$. The focus at the origin is the
      left one, and the directrix belonging to it is the left one,
      $x = 3 - 25 slash 3 = -16 slash 3$, as stated.

      Check it on the right vertex $P = (8, 0)$:
      $overline(P F) = 8$, and
      $overline(P d) = 8 + 16 slash 3 = 40 slash 3$, so
      $epsilon dot overline(P d) = (3 slash 5)(40 slash 3) = 8$.
      #sym.checkmark Each focus has its *own* directrix, on the same
      side of the centre as itself; pairing a focus with the far
      directrix is the standard way to go wrong here.],
    [The circle has centre $(3,0)$ and radius $5$. Squashing
      vertically by $4 slash 5$ leaves the centre and horizontal
      extent alone and scales the vertical semi-axis to $4$.],
    [Comparing with $(u + a cos t, v + b sin t)$ gives centre
      $(3, 0)$, $a = 5$, $b = 4$ directly.],
  )

  The point of the exercise is that "the same curve" has five
  independent certificates, and moving between them is the whole
  unit in miniature.
]

#ai-box(role: "Tutor")[
  Use an assistant to build the revision you actually need rather than
  the revision it thinks you need.

  + Work through Exercises 1--5 first, on paper, and keep a list of
    every step where you hesitated -- not where you were wrong, where
    you *hesitated*.
  + Give the assistant that list and ask it to produce three short
    problems targeting those specific steps. Not a general revision
    sheet: three problems, on your three hesitations.
  + Do them. If you hesitate again in the same place, the gap is
    conceptual and not practice, and the right move is to reread the
    relevant chapter rather than to do a fourth problem.
]

#print-vocab()
