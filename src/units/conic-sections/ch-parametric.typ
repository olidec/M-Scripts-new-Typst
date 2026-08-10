#import "../../common/preamble.typ": *
#import "../../common/cplane.typ": *
#import "../../common/conic-figures.typ": *
#show: chapter-template.with(title: "Parametric")
#let ex = exercise.with(chapter: "Parametric")

// ── NOTE ─────────────────────────────────────────────────────
// The old notes' section 5 gave the three parametrizations in
// half a page and then asked students to rotate three conics
// (Exercise 21) with no machinery for doing so. Those rotations
// land here, and the point of putting them here rather than in
// ch-classifying is that the PARAMETRIC form makes rotation
// trivial -- multiply a position vector by a rotation matrix --
// while the Cartesian form makes it a substitution grind. Doing
// both, on the same curve, is the argument for parametrizing.
//
// Two things the old half-page skipped and that are restored:
//   * the parameter t of (a cos t, b sin t) is NOT the polar
//     angle of the point. It is the eccentric anomaly. Students
//     who miss this get wrong answers on any problem that asks
//     for an angle, and nothing in the algebra warns them.
//   * cosh t >= 1 always, so a cosh t reaches only ONE branch of
//     the hyperbola. The sign in front chooses the branch --
//     which is the same sign discussion as in ch-hyperbola,
//     arriving a third time.

= Parametrizing Conics

#only-theory[
  An equation such as $x^2 slash a^2 + y^2 slash b^2 = 1$ answers one
  question: given a point, is it on the curve? It answers a second
  question badly: where *is* the curve? To plot it you must solve for
  $y$, lose half the curve to a square root, and glue two pieces back
  together.

  A parametrization answers the second question directly. Instead of
  testing points it *produces* them, one for each value of a
  parameter, in order. It turns a curve from a set into a journey --
  which is why it is the form used for orbits, trajectories, and
  anything a computer has to draw.
]

#look-back(
  title: "You have done this before",
  recalls: [parametric lines from the vectors unit],
)[
  A line in the vectors unit was written
  $vec(r) = vec(r)_0 + t dot vec(v)$: a starting point, a direction,
  and one parameter running over the reals. That is a
  parametrization, and everything in this chapter is the same idea
  applied to curved paths.

  The one new ingredient is that the parameter no longer moves at a
  constant speed in a straight line, and -- as the ellipse will show
  -- it no longer has the obvious geometric meaning you might expect.
]

#objectives(
  [parametrize a parabola, an ellipse and a hyperbola, and recover the
    Cartesian equation by eliminating the parameter],
  [explain why the parameter in $(a cos t, b sin t)$ is not the polar
    angle of the point, and relate the two],
  [define $sinh$ and $cosh$, prove $cosh^2 - sinh^2 = 1$, and use them
    to parametrize a hyperbola],
  [explain how the sign in $plus.minus a cosh t$ selects a branch],
  [rotate a conic through a given angle, using the rotation matrix on
    the parametric form and a substitution on the Cartesian form, and
    compare the two],
)

== The Parabola

#only-theory[
  The parabola is the easy case, because one of its coordinates is
  already a function of the other. For $y^2 = 2 p x$ take $y$ itself
  as the parameter:
  $
    vec(r)(t) = vec(t^2 / (2 p), t), quad quad t in RR .
  $
  Eliminating $t$ is immediate: $y = t$ and
  $x = t^2 slash (2p) = y^2 slash (2p)$. Shifting the vertex to
  $(u, v)$ adds a constant vector, exactly as it did for lines:
  $
    vec(r)(t) = vec(u, v) + vec(t^2 / (2 p), t) .
  $
]

#remark[
  This is also the shape of every projectile problem in physics. A
  body launched with speed $v_0$ at angle $theta$ has
  $
    x(t) = v_0 cos(theta) dot t, quad quad
    y(t) = v_0 sin(theta) dot t - 1 / 2 g t^2 ,
  $
  which is a parabola in parametric form with $t$ the *time*. That is
  the real advantage: the Cartesian equation tells you the shape of
  the path, and the parametrization tells you where the body is at
  each moment. Exercise 6 asks you to convert between them.
]

== The Ellipse

#only-theory[
  The ellipse needs an identity that keeps a sum of two squares equal
  to one, and there is an obvious candidate:
  $cos^2(t) + sin^2(t) = 1$. Setting
  $
    x = a cos(t), quad quad y = b sin(t)
  $
  gives
  $
    x^2 / a^2 + y^2 / b^2 = cos^2(t) + sin^2(t) = 1
  $
  for every $t$, so every such point is on the ellipse; and as $t$
  runs from $0$ to $2 pi$ the point runs once around it.
]

#keybox(title: "Parametrization of the ellipse")[
  $
    vec(r)(t) = vec(u, v) + vec(a cos(t), b sin(t)),
    quad quad t in [0, 2 pi) ,
  $
  traces the ellipse with centre $(u, v)$ and semi-axes $a$ and $b$
  exactly once. Taking $a = b$ gives the familiar parametrization of a
  circle.
]

#warning[
  The parameter $t$ is *not* the polar angle of the point.

  It is the angle at the centre of the point on the *auxiliary
  circle* of radius $a$ that sits directly above or below it -- the
  circle the ellipse chapter squashed. Astronomers call it the
  #vocab("eccentric anomaly", "exzentrische Anomalie"), reserving
  *true anomaly* for the polar angle.

  The two agree only at the four vertices. In between, the polar angle
  $phi.alt$ of the point $(a cos t, b sin t)$ satisfies
  $
    tan(phi.alt) = b / a tan(t) ,
  $
  which is not $t$ unless $a = b$. Any problem asking "at what angle"
  needs $phi.alt$; substituting $t$ gives a plausible wrong answer.
]

#only-theory[
  #xyplane(
    xmin: -6.6,
    xmax: 6.6,
    ymin: -6.6,
    ymax: 6.6,
    length: 0.6cm,
    caption: [The parameter $t$ measured on the auxiliary circle of
      radius $a = 5$. The ellipse point $(5 cos t, 3 sin t)$ lies
      directly below the circle point $(5 cos t, 5 sin t)$. The polar
      angle $phi.alt$ of the ellipse point is visibly smaller than
      $t$.],
    {
      cn-ellipse(5, 5, color: luma(150), dashed: true)
      cn-ellipse(5, 3)
      cp-segment((0.0, 0.0), (2.5, 4.330), color: expl-col)
      cp-segment((2.5, 4.330), (2.5, 2.598), color: luma(140), dashed: true)
      cp-segment((0.0, 0.0), (2.5, 2.598), color: def-col)
      cp-angle(0, 0, 0deg, 60deg, radius: 1.5, color: expl-col, label: $t$)
      cp-angle(
        0,
        0,
        0deg,
        46.1deg,
        radius: 2.5,
        color: def-col,
        label: $phi.alt$,
      )
      cp-point(2.5, 4.330, color: expl-col, size: 0.07)
      cp-point(2.5, 2.598, label: $P$, anchor: "north-west", color: def-col)
    },
  )
]

== Hyperbolic Functions

#only-theory[
  For the hyperbola the identity has to be $"something"^2 -
  "something"^2 = 1$, and sine and cosine cannot supply it. A new pair
  of functions can, and they are built from the exponential.
]

#definition(title: "Hyperbolic sine and cosine")[
  $
    sinh(t) = (e^t - e^(-t)) / 2,
    quad quad
    cosh(t) = (e^t + e^(-t)) / 2 .
  $
]

#theorem(title: "The hyperbolic identity")[
  For every real $t$,
  $ cosh^2(t) - sinh^2(t) = 1 . $
]

#proof[
  Expanding both squares,
  $
    cosh^2(t) - sinh^2(t)
    & = (e^(2 t) + 2 + e^(-2 t)) / 4 - (e^(2 t) - 2 + e^(-2 t)) / 4 \
    & = 4 / 4 = 1 .
  $
]

#only-theory[
  Three properties are worth having immediately.

  $cosh$ is *even* and $sinh$ is *odd*, directly from the definitions.
  Their derivatives swap without a sign change,
  $
    (sinh(t))' = cosh(t), quad quad (cosh(t))' = sinh(t) ,
  $
  which is a pleasant contrast with the circular case. And, crucially
  for what follows, $cosh(t) >= 1$ for every $t$, with equality only
  at $t = 0$: the identity forces $cosh^2 = 1 + sinh^2 >= 1$, and
  $cosh$ is positive. So $cosh$ never takes a negative value, and
  never a value between $-1$ and $1$ either.
]

#only-theory[
  #xyplane(
    xmin: -2.7,
    xmax: 2.7,
    ymin: -4.2,
    ymax: 4.2,
    length: 0.85cm,
    caption: [$cosh$ (upper) and $sinh$. Both grow like
      $e^t slash 2$ to the right; $cosh$ never dips below $1$, which
      is why $a cosh t$ can reach only one branch of a hyperbola.],
    {
      cp-curve(
        t => t,
        t => (calc.exp(t) + calc.exp(-t)) / 2,
        domain: (-2.1, 2.1),
        samples: 100,
      )
      cp-curve(
        t => t,
        t => (calc.exp(t) - calc.exp(-t)) / 2,
        domain: (-2.1, 2.1),
        samples: 100,
        color: def-col,
      )
      cp-curve(
        t => t,
        t => calc.exp(t) / 2,
        domain: (-2.1, 2.1),
        samples: 60,
        color: luma(150),
        dashed: true,
      )
      cp-point(0, 1, label: none, color: accent, size: 0.06)
    },
  )
]

== The Hyperbola

#keybox(title: "Parametrization of the hyperbola")[
  $
    vec(r)(t) = vec(u, v) + vec(plus.minus a cosh(t), b sinh(t)),
    quad quad t in RR ,
  $
  traces the hyperbola
  $(x-u)^2 slash a^2 - (y-v)^2 slash b^2 = 1$, the $+$ sign giving the
  right branch and the $-$ sign the left.
]

#only-theory[
  That it lands on the curve is the identity again:
  $
    (a cosh(t))^2 / a^2 - (b sinh(t))^2 / b^2
    = cosh^2(t) - sinh^2(t) = 1 .
  $
  The interesting part is the sign. Since $cosh(t) >= 1$ always,
  $a cosh t >= a$ for every $t$: the point never crosses to the left
  of the vertex, so *one* choice of parametrization covers only *one*
  branch. Two signs, two branches.

  This is the third time the same fact has appeared. The definition
  needed $abs(overline(P F_1) - overline(P F_2)) = 2a$ because one
  sign gives one branch; the derivation produced $c x >= a^2$ for the
  same reason; and now $cosh >= 1$ says it again. A curve in two
  pieces makes trouble for any description that is naturally
  connected, and all three are the same trouble.
]

#remark[
  The names are not an accident. For the circle, the parameter $t$ in
  $(cos t, sin t)$ is both the angle and *twice the area* of the
  circular sector swept from the positive axis. The angle
  interpretation fails for the hyperbola -- there is nothing to go
  round -- but the area interpretation survives exactly: the $t$ in
  $(cosh t, sinh t)$ is twice the area of the corresponding
  *hyperbolic sector* of $x^2 - y^2 = 1$. That is what makes them
  hyperbolic functions rather than merely a convenient pair of
  exponentials.
]

== Rotating a Conic

#only-theory[
  Every conic so far has had its axes parallel to the coordinate axes.
  Tilting one is where parametrization earns its keep, because a
  rotation acts on *points*, and a parametrization is a machine for
  producing points.

  Rotating the plane through the angle $alpha$ about the origin is
  multiplication by the rotation matrix from the vectors unit,
  $
    R(alpha) = mat(cos(alpha), -sin(alpha); sin(alpha), cos(alpha)) ,
  $
  or, in the language of the complex-numbers unit, multiplication by
  $e^(i alpha)$. Either way, the rotated curve is parametrized by
  $
    vec(r)_"new" (t) = R(alpha) dot vec(r)(t) ,
  $
  and there is nothing more to do.
]

#example(title: "Two routes, one curve")[
  Rotate the ellipse $x^2 slash 4 + y^2 slash 16 = 1$ through
  $30 degree$.

  *Parametrically.* The ellipse is
  $vec(r)(t) = (2 cos t, 4 sin t)$, so the rotated one is
  $
    vec(r)_"new"(t)
    = mat(cos 30 degree, -sin 30 degree; sin 30 degree, cos 30 degree)
      vec(2 cos(t), 4 sin(t))
    = vec(sqrt(3) cos(t) - 2 sin(t), cos(t) + 2 sqrt(3) sin(t)) .
  $
  Done, in one matrix multiplication.

  *In Cartesian form.* A point $(x, y)$ lies on the rotated curve
  exactly when $R(-30 degree)(x, y)$ lies on the original, so
  substitute
  $
    x |-> (sqrt(3) x + y) / 2, quad quad y |-> (-x + sqrt(3) y) / 2
  $
  into $4 x^2 + y^2 = 16$ and expand. After collecting terms and
  clearing fractions,
  $
    13 x^2 + 6 sqrt(3) x y + 7 y^2 = 64 .
  $
  Same curve, considerably more work -- and a cross term has appeared,
  as the classification chapter promised. Its discriminant is
  $
    Delta = (6 sqrt(3))^2 - 4 dot 13 dot 7 = 108 - 364 = -256 < 0 ,
  $
  confirming an ellipse.
]

#remark[
  Which form you want depends on the question. To *draw* the rotated
  curve, or to animate a point moving along it, the parametric form is
  the only sensible choice. To decide whether a given point lies on it,
  or to classify it, or to intersect it with a line, the Cartesian
  form is. Neither is the "real" description; a conic has both, and
  the fluency worth having is moving between them.
]

// ── Exercises ────────────────────────────────────────────────

#ex(difficulty: 1, time: "12 min", calculator: false)[
  Give a parametrization of each curve, and state the range of the
  parameter needed to trace it exactly once (or, for the unbounded
  ones, entirely).
  #auto-parts(
    2,
    [$x^2 / 9 + y^2 / 25 = 1$],
    [$(x-2)^2 / 16 + (y+1)^2 / 16 = 1$],
    [$y^2 = 6 x$],
    [$x^2 / 4 - y^2 / 9 = 1$],
  )
][
  #auto-parts(
    1,
    [$(3 cos t, 5 sin t)$, $t in [0, 2 pi)$.],
    [$(2 + 4 cos t, -1 + 4 sin t)$, $t in [0, 2 pi)$ -- a circle of
      radius $4$, since the two denominators agree.],
    [$(t^2 slash 6, t)$, $t in RR$. (Here $2p = 6$.)],
    [$(plus.minus 2 cosh t, 3 sinh t)$, $t in RR$, with the two signs
      giving the two branches. One sign alone traces only one of
      them.],
  )
]

#ex(difficulty: 2, time: "15 min", calculator: false)[
  Eliminate the parameter and identify each curve.
  #auto-parts(
    1,
    [$x = 3 + 2 cos t$, $y = -1 + 5 sin t$],
    [$x = 4 cosh t$, $y = 3 sinh t$],
    [$x = 1 - t^2$, $y = 2 t$],
    [$x = 2 sec t$, $y = 3 tan t$ #h(0.3em) (use
      $1 + tan^2 t = sec^2 t$)],
  )
][
  #auto-parts(
    1,
    [$cos t = (x-3) slash 2$ and $sin t = (y+1) slash 5$, so
      $ (x-3)^2 / 4 + (y+1)^2 / 25 = 1 , $
      an ellipse with centre $(3,-1)$, semi-axes $2$ and $5$,
      major axis vertical.],
    [$cosh t = x slash 4$, $sinh t = y slash 3$, so
      $x^2 slash 16 - y^2 slash 9 = 1$: a hyperbola -- but only its
      *right* branch, since $x = 4 cosh t >= 4 > 0$ throughout.],
    [$t = y slash 2$, so $x = 1 - y^2 slash 4$, that is
      $y^2 = -4(x - 1)$: a parabola with vertex $(1, 0)$ opening to
      the left, $2p = -4$.],
    [$sec t = x slash 2$ and $tan t = y slash 3$, so
      $ x^2 / 4 - y^2 / 9 = 1 , $
      a hyperbola. This is the older parametrization of the
      hyperbola, still common in English-language sources; unlike the
      $cosh$ version it reaches both branches, but at the cost of a
      parameter with two excluded values and two infinite jumps.],
  )
]

#ex(difficulty: 2, time: "20 min", calculator: false, hints: (
  [Write down the coordinates of both points and compare their
    $y$-values.],
))[
  Let $P$ be the point $(a cos t, b sin t)$ of an ellipse with
  $a > b > 0$, and let $Q = (a cos t, a sin t)$ be the point of the
  auxiliary circle directly above it.
  #auto-parts(
    1,
    [Show that $tan(phi.alt) = (b slash a) tan(t)$, where $phi.alt$ is
      the polar angle of $P$.],
    [Take $a = 5$, $b = 3$ and $t = 60 degree$. Compute $phi.alt$ and
      confirm it differs from $t$.],
    [For which values of $t$ do $t$ and $phi.alt$ agree?],
  )
][
  #auto-parts(
    1,
    [The polar angle of $P = (a cos t, b sin t)$ satisfies
      $
        tan(phi.alt) = (b sin(t)) / (a cos(t)) = b / a tan(t) .
      $],
    [$tan(phi.alt) = (3 slash 5) tan(60 degree)
      = (3 slash 5) sqrt(3) approx 1.039$, so
      $phi.alt approx 46.1 degree$, well short of $60 degree$. The
      squashing has dragged the point down towards the major axis, and
      it drags the angle with it.],
    [They agree exactly when $tan(phi.alt) = tan(t)$, which given
      $b slash a != 1$ forces $tan t = 0$ or $tan t$ undefined -- that
      is, $t = 0$, $90 degree$, $180 degree$, $270 degree$: the four
      vertices, and nowhere else.],
  )
]

#ex(difficulty: 2, time: "20 min", calculator: false)[
  Prove the following identities directly from the definitions of
  $sinh$ and $cosh$.
  #auto-parts(
    1,
    [$sinh(-t) = -sinh(t)$ and $cosh(-t) = cosh(t)$.],
    [$cosh(t) + sinh(t) = e^t$ and $cosh(t) - sinh(t) = e^(-t)$.],
    [$sinh(2 t) = 2 sinh(t) cosh(t)$.],
    [Deduce from (b) that $cosh(t) >= 1$ for all $t$, with equality
      only at $t = 0$.],
  )
][
  #auto-parts(
    1,
    [Replacing $t$ by $-t$ swaps $e^t$ and $e^(-t)$. The sum
      defining $cosh$ is unchanged; the difference defining $sinh$
      changes sign.],
    [Adding the two definitions gives
      $(e^t - e^(-t) + e^t + e^(-t)) slash 2 = e^t$; subtracting
      gives $e^(-t)$.],
    [$
        2 sinh(t) cosh(t)
        = 2 dot (e^t - e^(-t)) / 2 dot (e^t + e^(-t)) / 2
        = (e^(2t) - e^(-2t)) / 2 = sinh(2 t) ,
      $
      using $(A-B)(A+B) = A^2 - B^2$. Compare the circular identity
      $sin 2t = 2 sin t cos t$: identical in form.],
    [By (b), $cosh t = (e^t + e^(-t)) slash 2$ is the arithmetic mean
      of the two positive numbers $e^t$ and $e^(-t)$, whose product is
      $e^t dot e^(-t) = 1$. By the AM--GM inequality the mean is at
      least the geometric mean $sqrt(1) = 1$, with equality only when
      the two numbers are equal, that is when $e^t = e^(-t)$, that is
      $t = 0$.],
  )
]

#ex(difficulty: 3, time: "35 min", calculator: false, hints: (
  [For the parametric form, all you need is one matrix product.],
  [For the Cartesian form, substitute $R(-alpha)(x,y)$ into the
    original equation. Watch the sign of $alpha$ in part (b).],
))[
  Rotate each conic about the origin through the stated angle
  $alpha$. Give the answer *both* as a parametrization and as a
  Cartesian equation, and check the type of the result with the
  discriminant.
  #auto-parts(
    1,
    [$x^2 / 4 + y^2 / 16 = 1$, #h(0.5em) $alpha = 30 degree$],
    [$-16 x = y^2$, #h(0.5em) $alpha = -150 degree$],
    [$x^2 / 5 - y^2 / 12 = 1$, #h(0.5em) $alpha = 45 degree$],
  )
][
  #auto-parts(
    1,
    [Worked in the text. Parametrically
      $(sqrt(3) cos t - 2 sin t, cos t + 2 sqrt(3) sin t)$;
      in Cartesian form
      $ 13 x^2 + 6 sqrt(3) x y + 7 y^2 = 64 , $
      with $Delta = 108 - 364 = -256 < 0$: an ellipse.
      #sym.checkmark],
    [Here $y^2 = -16 x$, so $2p = -16$ and the parametrization is
      $(-t^2 slash 16, t)$. Rotating by $-150 degree$,
      $
        vec(r)_"new"(t) = mat(
          -sqrt(3) / 2, 1 / 2;
          -1 / 2, -sqrt(3) / 2
        ) vec(-t^2 / 16, t)
        = vec((sqrt(3) t^2) / 32 + t / 2,
              t^2 / 32 - (sqrt(3) t) / 2) .
      $
      In Cartesian form, substituting
      $x |-> (-sqrt(3) x - y) slash 2$,
      $y |-> (x - sqrt(3) y) slash 2$ and clearing fractions gives
      $ x^2 - 2 sqrt(3) x y + 3 y^2 - 32 sqrt(3) x - 32 y = 0 , $
      with $Delta = 12 - 12 = 0$: a parabola. #sym.checkmark

      A shortcut worth spotting: $-150 degree = 30 degree - 180
      degree$, and rotating by $180 degree$ turns $y^2 = -16x$ into
      $y^2 = 16 x$. So this is the same as rotating $y^2 = 16x$
      through $30 degree$, which is a little less unpleasant.],
    [Parametrically the hyperbola is
      $(plus.minus sqrt(5) cosh t, 2 sqrt(3) sinh t)$, and rotating
      by $45 degree$ multiplies by
      $R(45 degree) = (1 slash sqrt(2)) mat(1, -1; 1, 1)$:
      $
        vec(r)_"new"(t) = 1 / sqrt(2)
        vec(plus.minus sqrt(5) cosh(t) - 2 sqrt(3) sinh(t),
            plus.minus sqrt(5) cosh(t) + 2 sqrt(3) sinh(t)) .
      $
      In Cartesian form, substituting
      $x |-> (x + y) slash sqrt(2)$,
      $y |-> (-x + y) slash sqrt(2)$ gives
      $ 7 x^2 + 34 x y + 7 y^2 = 120 , $
      with $Delta = 34^2 - 4 dot 49 = 1156 - 196 = 960 > 0$: a
      hyperbola. #sym.checkmark],
  )

  In every part the parametric answer took one matrix product and the
  Cartesian answer took a page. That is the honest summary of this
  chapter.
]

#ex(difficulty: 2, time: "20 min", calculator: true, hints: (
  [Solve the $x$-equation for $t$ and substitute.],
))[
  A ball is thrown from the origin with speed $v_0 = 20$ m/s at
  $45 degree$ above the horizontal. With $g = 9.81$ m/s#super[2] and
  air resistance ignored, its position after $t$ seconds is
  $
    x(t) = v_0 cos(45 degree) dot t,
    quad quad
    y(t) = v_0 sin(45 degree) dot t - 1 / 2 g t^2 .
  $
  #auto-parts(
    1,
    [Eliminate $t$ to obtain the Cartesian equation of the path, and
      confirm that it is a parabola.],
    [Find the range (where the ball returns to $y = 0$) and the
      maximum height.],
    [Find $p$ for this parabola and locate its focus. Is the focus a
      physically meaningful point here?],
  )
][
  Write $c = cos 45 degree = sin 45 degree = sqrt(2) slash 2$, so
  $v_0 c = 10 sqrt(2) approx 14.142$.
  #auto-parts(
    1,
    [From the first equation $t = x slash (v_0 c)$, and substituting,
      $
        y = x - g / (2 v_0^2 c^2) x^2 = x - (9.81) / 400 x^2 ,
      $
      since $2 v_0^2 c^2 = 2 dot 400 dot 1 slash 2 = 400$. This is a
      downward-opening parabola, as $y$ is quadratic in $x$ with a
      negative leading coefficient.],
    [Setting $y = 0$: $x(1 - 9.81 x slash 400) = 0$, so $x = 0$ or
      $ x = 400 / 9.81 approx 40.8 " m" . $
      The maximum height is at the midpoint $x approx 20.4$ m, giving
      $y approx 20.4 - 9.81 dot 20.4^2 slash 400 approx 10.2$ m.],
    [Writing the path in vertex form,
      $y - 10.2 = -(9.81 slash 400)(x - 20.4)^2$, so
      $(x - 20.4)^2 = 2 p (y - 10.2)$ with
      $2 p = -400 slash 9.81$, that is $p approx -20.4$ m. The focus
      sits $abs(p) slash 2 approx 10.2$ m *below* the vertex -- at
      ground level, directly under the top of the flight.

      Physically it means nothing. The parabola's focus is a property
      of the curve, and here the curve happens to be a trajectory;
      nothing is reflected, emitted or received. It is a good habit to
      ask whether a mathematical feature of a model corresponds to
      anything in the situation being modelled, and a good habit to
      accept the answer when it is no.],
  )
]

#ai-box(role: "Generator")[
  Parametrizations are easy to check and easy to get subtly wrong,
  which makes them good material for this.

  + Ask an AI assistant for five parametrized curves, given only as
    $x(t)$ and $y(t)$, without saying what they are.
  + Identify each one by eliminating the parameter, and state what
    range of $t$ is needed and whether the whole curve is covered.
  + The last point is the one to press on. If any of its answers used
    $cosh$, ask whether the parametrization reaches both branches. If
    any used $cos$ and $sin$ with a restricted domain, ask what part
    of the curve is missing. A parametrization that lands on the right
    curve but covers only part of it is *not* the same object, and
    that distinction is exactly what an assistant is most likely to
    gloss over.
]

#print-vocab()
