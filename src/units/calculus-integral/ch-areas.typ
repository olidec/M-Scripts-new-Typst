#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Areas")
#let ex = exercise.with(chapter: "Areas")

// ── TEACHER'S NOTE ───────────────────────────────────────────
// The distinction this chapter exists to install is between the
// INTEGRAL (a signed number) and the AREA (a positive one). The old
// LaTeX notes make the point well — the worked example with
// ∫ from -1.24 to 3.24 coming out to exactly zero over a manifestly
// non-empty region is the right example — but they make it once, in
// passing, and then never give it a procedure. §1 here turns it into
// a four-step routine.
//
// §2's derivation of ∫(upper - lower) is worth doing slowly. Most
// students will accept the formula immediately for regions above the
// axis and then privately doubt it when the region dips below. The
// half-page argument (shift both curves up by a constant; the area is
// unchanged and the constant cancels) settles that permanently and
// costs very little.
//
// CALCULATOR NOTE. From §2 onwards most intersection points are not
// exact — old Exercise 80 has five parts out of six needing numerical
// roots. Both tracks are expected to find these numerically and then
// integrate numerically; the exercises are marked calculator: true
// for that reason. What students should NOT do is round an
// intersection to two decimals and then integrate by hand, which
// loses more accuracy than it saves effort.
//
// TWO ANSWERS IN THE OLD NOTES ARE FINE BUT THEIR SETUP IS EASY TO
// MISREAD, so both are spelled out here:
//   * old Ex 81: the curves y = x² and y = 2√x meet at x = ∛4 ≈
//     1.587, NOT at x = 1. Integrating to 1 gives a different (wrong)
//     value of k.
//   * old Ex 83: the region is bounded by THREE curves and must be
//     split at x = -1 + √5, where the tangent crosses g.

= Areas

#only-theory[
  The fundamental theorem computes signed area. Questions, almost
  always, ask for actual area — or for the area of a region trapped
  between two curves, which the theorem does not directly address at
  all.

  Neither gap is deep. Both are entirely a matter of deciding, before
  integrating, which pieces are to be added and which subtracted. That
  decision is made from a sketch, and this is the chapter where a
  sketch stops being a nicety and becomes the first step of the
  method.
]

#epigraph(by: "attributed to Archimedes")[
  Give me a place to stand, and I will move the Earth.
]

#objectives(
  bfkm[calculate the area enclosed between the graph of a function and
    the $x$\u{2011}axis],
  [distinguish the value of a definite integral from the area of the
    corresponding region, and explain when they differ],
  bfkm[calculate the area of a region bounded by two curves],
  [determine the limits of integration by locating intersection
    points, numerically where necessary],
  [handle a region in which the two boundary curves exchange places],
  [determine a parameter from a given area],
)

== Signed Area and Total Area

#only-theory[
  Recall the sign convention: where the graph lies below the
  $x$\u{2011}axis, the integrand is negative and the integral
  subtracts. The consequence is that an integral over a region partly
  above and partly below the axis reports the *difference* of the two
  parts, not their sum.

  In the extreme case the two cancel exactly and the integral is zero
  over a region that plainly has area.
]

#example(title: "An integral of zero over a region that is not empty")[
  Let $f(x) = 1/2 x^4 - 2 x^3 + 4 x$. Factoring,
  $f(x) = x dot (1/2 x^3 - 2 x^2 + 4)$, and the cubic factor has the
  root $x = 2$; dividing it out leaves $x^2 - 2 x - 4$. So the four
  zeros are
  $ x = 1 - sqrt(5) approx -1.236, quad 0, quad 2, quad
    x = 1 + sqrt(5) approx 3.236. $

  Integrating across the whole span:
  $ integral_(-1.236)^(3.236) f(x) dif x = 0. $
  The three pieces come out as $-1.6$, $+3.2$ and $-1.6$: the two
  negative parts exactly cancel the positive one. The region is not
  empty — it has area $6.4$ — and the integral says nothing about it.
]

#keybox(title: "Total area between a graph and the axis")[
  To find the *area* enclosed between the graph of $f$ and the
  $x$\u{2011}axis on $[a, b]$:

  + Find every zero of $f$ inside $(a, b)$.
  + Split $[a, b]$ at those zeros.
  + Integrate over each piece separately.
  + Add the *absolute values* of the results.

  Skipping step 1 is the single most common error in this chapter, and
  it is undetectable from the answer alone — a wrong number that looks
  entirely reasonable.
]

#warning[
  Do not write $integral_a^b abs(f(x)) dif x$ and hope your calculator
  will sort it out. It may well do so numerically, but you will have
  no antiderivative and no exact answer, and in an examination you
  will have shown no method. Split at the zeros.
]

=== Exercises

#ex(
  difficulty: 2,
  time: "30 min",
  calculator: true,
  hints: (
    [Factor each polynomial to find the zeros before integrating
      anything.],
    [Sketch the sign of $f$ between consecutive zeros. If the sign
      alternates, so must the signs of your partial integrals — that
      is a free check on the arithmetic.],
  ),
)[
  Calculate the area enclosed by the graph of $f$ and the
  $x$\u{2011}axis.
  #auto-parts(
    2,
    [$f: y = x^2 - 5 x + 4$],
    [$f: y = x^3 - 2 x^2 - 3 x$],
    [$f: y = x^4 - 10 x^2 + 9$],
    [$f: y = x^3 - 3 x^2 + 4$],
  )
][
  #auto-parts(
    1,
    [Zeros at $1$ and $4$. The graph is below the axis between them,
      so the single integral is $-9/2$ and the area is
      $ A = 9/2 = 4.5. $],
    [$f(x) = x dot (x - 3) dot (x + 1)$, with zeros $-1$, $0$, $3$.
      The two pieces give $+7/12$ and $-45/4$, so
      $ A = 7/12 + 45/4 = 71/6 approx 11.83. $],
    [$f(x) = (x^2 - 1) dot (x^2 - 9)$, with zeros
      $plus.minus 1$ and $plus.minus 3$. The three pieces give
      $-20.27$, $+11.73$ and $-20.27$, so
      $ A approx 52.27. $
      The function is even, which halves the work: the outer two
      pieces are equal.],
    [$f(x) = (x + 1) dot (x - 2)^2$, with zeros $-1$ and $2$, the
      second a *double* zero. The graph touches the axis at $x = 2$
      without crossing, so there is no sign change there and no split
      is needed:
      $ A = integral_(-1)^2 f(x) dif x = 27/4 = 6.75. $],
  )

  Part (d) is the one that rewards checking multiplicities. A zero is
  a place to split only if the sign actually changes there, and at a
  double zero it does not.
]

== The Area Between Two Curves

#only-theory[
  Now take two functions $f$ and $g$ with $f(x) gt.eq g(x)$ on
  $[a, b]$, and consider the region trapped between them.

  If both graphs lie above the axis the argument is immediate: the
  region between them is what is left when the area under $g$ is
  removed from the area under $f$, so
  $ A = integral_a^b f(x) dif x - integral_a^b g(x) dif x
      = integral_a^b (f(x) - g(x)) dif x. $

  What if part of the region lies below the axis, where that picture
  fails? Shift *both* curves upwards by a constant $c$ large enough to
  lift the whole region above the axis. Sliding a region vertically
  does not change its area, and in the integrand
  $ (f(x) + c) - (g(x) + c) = f(x) - g(x) $
  the constant cancels. So the formula was never about the axis at
  all.
]

#keybox(title: "Area between two curves")[
  If $f(x) gt.eq g(x)$ throughout $[a, b]$, the area enclosed between
  the two graphs is
  $ A = integral_a^b (f(x) - g(x)) dif x $
  — *upper minus lower*, regardless of whether either curve is above
  or below the $x$\u{2011}axis.

  When $a$ and $b$ are not given, they are the points where the curves
  meet: solve $f(x) = g(x)$.
]

#remark[
  "Upper" means larger $y$\u{2011}value, which is not always the
  curve that looks more important. The reliable way to decide is to
  pick one convenient $x$ between the intersection points and evaluate
  both functions there. Ten seconds, and it removes the commonest
  source of a sign error in this chapter — an answer that comes out
  negative, which for an area is impossible and therefore at least
  self-announcing.
]

#example(title: "A region between a parabola and a root")[
  Find the area between $y = x^2$ and $y = sqrt(x)$.

  *Intersections.* $x^2 = sqrt(x)$ gives $x^4 = x$, so
  $x dot (x^3 - 1) = 0$ and the curves meet at $x = 0$ and $x = 1$.

  *Which is upper?* At $x = 1/4$: $sqrt(1/4) = 0.5$ and
  $(1/4)^2 = 0.0625$. The root is on top.

  *Integrate.*
  $ A = integral_0^1 (sqrt(x) - x^2) dif x
    = [2/3 x^(3/2) - 1/3 x^3]_0^1
    = 2/3 - 1/3 = 1/3. $
]

#example(title: "A region below the axis")[
  Find the area between $y = -x^2$ and $y = x - 2$ on the interval
  where the parabola is on top.

  Setting $-x^2 = x - 2$ gives $x^2 + x - 2 = 0$, so $x = -2$ and
  $x = 1$. Testing $x = 0$: the parabola gives $0$, the line gives
  $-2$, so the parabola is upper.
  $ A = integral_(-2)^1 (-x^2 - (x - 2)) dif x
    = [-1/3 x^3 - 1/2 x^2 + 2 x]_(-2)^1
    = 7/6 - (-10/3) = 9/2. $
  Both curves spend most of this interval below the axis, and it made
  no difference at all.
]

=== Exercises

#ex(
  difficulty: 2,
  time: "45 min",
  calculator: true,
  hints: (
    [Sketch first, every time. The sketch tells you the limits, which
      curve is upper, and whether they swap — none of which is visible
      from the formulas.],
    [Only (a) and (e) have intersections you can find exactly. For the
      rest, solve numerically and integrate numerically — but do not
      round the intersection points before integrating.],
  ),
)[
  For each pair, sketch the region bounded by the given curves, write
  down an expression for its area, and calculate the result.
  #auto-parts(
    2,
    [$y = x^2$ and $y = sqrt(x)$],
    [$f(x) = ln(x)$ and $g(x) = x - 2$],
    [$y = (x + 2) / (x - 1)$ and $y = -1/2 x + 6$],
    [$y = sin(x)$ and $y = 1/3 x$],
    [$y = x^3 - 2 x^2$ and $y = 2 x^2 - 3 x$],
    [$f(x) = x dot e^(-x^2)$ and $h(x) = x^3 - x$],
  )
][
  #auto-parts(
    1,
    [Meet at $x = 0$ and $x = 1$; the root is upper.
      $ A = integral_0^1 (sqrt(x) - x^2) dif x = 1/3. $],
    [Meet at $x approx 0.1586$ and $x approx 3.1462$; the logarithm is
      upper between them.
      $ A = integral_(0.1586)^(3.1462) (ln(x) - (x - 2)) dif x
        approx 1.95. $],
    [Meet at $x approx 1.725$ and $x approx 9.275$; the line is upper
      between them. Note that the vertical asymptote at $x = 1$ lies
      *outside* the interval, which is what makes the region finite.
      $ A approx 9.68. $],
    [Meet at $x = 0$ and $x approx 2.279$, and also at the mirror
      points, since both functions are odd. Taking the region in the
      first quadrant, where the sine is upper,
      $ A approx 0.785, $
      and the full region — both halves together — has area
      $approx 1.57$.],
    [$x^3 - 2 x^2 = 2 x^2 - 3 x$ gives
      $x dot (x - 1) dot (x - 3) = 0$, so the curves meet at $0$, $1$
      and $3$ — and they *swap places* at $x = 1$. See the next
      section.
      $ A = 5/12 + 8/3 = 37/12 approx 3.08. $],
    [Meet at $x = 0$ and $x approx plus.minus 1.131$, with a swap at
      the origin.
      $ A approx 1.18. $],
  )

  Part (c) is worth a comment: a rational function and a line normally
  enclose two separate regions, one on each side of the vertical
  asymptote. Here the intersection points happen to lie on the same
  side of $x = 1$, so there is only one bounded region — which the
  sketch shows and the algebra does not.
]

== When the Curves Swap Places

#only-theory[
  If $f$ and $g$ cross somewhere strictly inside the interval, then
  $f - g$ changes sign there, and a single integral will again report
  a difference rather than a sum.

  The remedy is the one from §1, with the roles played by $f - g$
  instead of by $f$: split the interval at every crossing, integrate
  each piece, and add the absolute values.
]

#example(title: "Two crossings and a swap")[
  Find the area enclosed by $y = x^3 - 2 x^2$ and $y = 2 x^2 - 3 x$.

  Setting them equal:
  $ x^3 - 4 x^2 + 3 x = 0 quad ==> quad
    x dot (x - 1) dot (x - 3) = 0, $
  so the curves meet at $x = 0$, $x = 1$ and $x = 3$. Three
  intersection points means two regions, and the curves exchange
  places at $x = 1$.

  Testing $x = 1/2$: the cubic gives $-0.375$, the parabola gives
  $-1$. So on $(0, 1)$ the *cubic* is upper. Testing $x = 2$: the
  cubic gives $0$, the parabola gives $2$, so on $(1, 3)$ the
  *parabola* is upper.
  $ A &= integral_0^1 (x^3 - 4 x^2 + 3 x) dif x
      + integral_1^3 (-(x^3 - 4 x^2 + 3 x)) dif x \
    &= 5/12 + 8/3 = 37/12 approx 3.08. $

  Had we integrated $x^3 - 4 x^2 + 3 x$ straight through from $0$ to
  $3$, the answer would have been $5/12 - 8/3 = -9/4$ — negative,
  and therefore obviously not an area, but only obviously if you were
  watching.
]

== Finding a Parameter from an Area

#only-theory[
  The inverse problem again, in a new setting: an area is given, and
  something in the picture is unknown. Set up the integral with the
  unknown carried through, evaluate it, and solve.
]

#ex(
  difficulty: 3,
  time: "18 min",
  calculator: false,
  hints: (
    [Find the zeros of $f$ in terms of $a$ first. They are the limits
      of integration.],
    [Everything will come out as a power of $a$. Solve for that power
      last.],
  ),
)[
  The graph of
  $ f: y = (a - x) dot sqrt(x), quad a > 0 $
  encloses an area of $64.8$ with the $x$\u{2011}axis. Determine the
  value of $a$.
][
  The domain is $x gt.eq 0$, and the zeros are $x = 0$ and $x = a$.
  Between them $f$ is positive, so no splitting is needed. Writing the
  integrand as $a dot x^(1/2) - x^(3/2)$:
  $ integral_0^a (a x^(1/2) - x^(3/2)) dif x
    = [2/3 a x^(3/2) - 2/5 x^(5/2)]_0^a
    = (2/3 - 2/5) dot a^(5/2)
    = 4/15 dot a^(5/2). $
  Setting this equal to $64.8$:
  $ a^(5/2) = 64.8 dot 15/4 = 243 quad ==> quad
    a = 243^(2/5) = (3^5)^(2/5) = 9. $

  #heuristic("introduce notation")

  The arithmetic was arranged to be clean — $243 = 3^5$ is not an
  accident — which is a reliable sign that you have set the integral
  up correctly.
]

#ex(
  difficulty: 3,
  time: "20 min",
  calculator: true,
  hints: (
    [Find where the two curves meet before anything else. They do
      *not* meet at $x = 1$.],
    [Compute the whole area first. Then set up an equation saying the
      part from $0$ to $k$ is half of it.],
  ),
)[
  Consider $f(x) = x^2$ and $g(x) = 2 sqrt(x)$. The line $x = k$
  divides the area bounded by the two curves in half. Find $k$.
][
  *Intersections.* $x^2 = 2 sqrt(x)$ gives $x^4 = 4 x$, so
  $x dot (x^3 - 4) = 0$ and the curves meet at $x = 0$ and
  $x = root(3, 4) approx 1.587$. On that interval $g$ is above $f$.

  *Total area.*
  $ A = integral_0^(root(3, 4)) (2 sqrt(x) - x^2) dif x
    = [4/3 x^(3/2) - 1/3 x^3]_0^(root(3, 4)) = 4/3. $

  *Halving.* We need $k$ with
  $ integral_0^k (2 sqrt(x) - x^2) dif x = 2/3, $
  that is $4/3 k^(3/2) - 1/3 k^3 = 2/3$. Solving numerically,
  $ k approx 0.700. $

  Note that $k$ is well to the left of the midpoint of
  $[0, 1.587]$ — the region is fatter on the left, so less width is
  needed there to accumulate the same area.
]

#ex(
  difficulty: 3,
  time: "25 min",
  calculator: true,
  level: "high",
  hints: (
    [The region is bounded by *three* curves, so it will need
      splitting. Find all three pairwise intersections and sketch
      before integrating.],
    [The two parabolas meet only at the origin; the tangent meets the
      downward parabola at two points, one of which is irrelevant.],
  ),
)[
  Given the two curves $f(x) = 1/4 x^2$ and $g(x) = -x^2$.
  #auto-parts(
    1,
    [Find the equation of the tangent $t(x)$ to $f$ at $x = 4$.],
    [The tangent and the two curves enclose a finite area. Calculate
      it.],
  )
][
  #auto-parts(
    1,
    [$f(4) = 4$ and $f'(x) = 1/2 x$, so $f'(4) = 2$:
      $ t(x) = 4 + 2 dot (x - 4) = 2 x - 4. $],
    [The three boundary curves meet as follows. The parabolas meet
      where $1/4 x^2 = -x^2$, i.e. only at the origin. The tangent
      touches $f$ at $(4, 4)$. The tangent meets $g$ where
      $-x^2 = 2 x - 4$, i.e. $x^2 + 2 x - 4 = 0$, giving
      $x = -1 plus.minus sqrt(5)$; the relevant root is
      $x = -1 + sqrt(5) approx 1.236$.

      So the region runs from $0$ to $4$, with its lower boundary
      changing at $x approx 1.236$ from $g$ to the tangent:
      $ A = integral_0^1.236 (1/4 x^2 + x^2) dif x
          + integral_1.236^4 (1/4 x^2 - (2 x - 4)) dif x. $
      Evaluating, $0.787 + 1.760 approx 2.55$.],
  )

  #heuristic("draw a picture")

  This is the hardest kind of area problem in the course, and the
  difficulty is entirely in step one. Once the picture is right and
  the split point is identified, the integration is routine.
]

#ai-box(role: "Checker")[
  Give an AI assistant this problem: *"find the area enclosed between
  $y = x^3 - 4 x$ and the $x$\u{2011}axis."* The function has
  zeros at $-2$, $0$ and $2$ and is above the axis on one side and
  below on the other, so the straight integral from $-2$ to $2$ is
  zero.

  Then check: did it split at the zeros, or did it integrate straight
  through? Both a correct answer ($8$) and a confidently wrong one
  ($0$) are common, and the reasoning is short enough that you can
  audit every line. If it answered $0$, ask it to sketch the region in
  words and say whether an area can be zero.
]

#print-hints()
#print-vocab()
