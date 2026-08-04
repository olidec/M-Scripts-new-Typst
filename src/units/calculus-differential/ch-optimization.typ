#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Optimization")
#let ex = exercise.with(chapter: "Optimization")

// ── TEACHER'S NOTE ───────────────────────────────────────────
// The old LaTeX notes give this section no theory at all — a
// calculator icon, then sixteen word problems. Everything in §1 and
// §2 here is new, and §1 is the part that matters: the seven-step
// method, and in particular steps 3 and 4 (the DOMAIN of the model,
// and the verification that the critical point is the extremum you
// want). Students fail these problems at the modelling stage far more
// often than at the calculus stage, so the calculus is the short part
// of every worked example below.
//
// The domain point deserves lesson time. In the corral problem the
// natural domain of A(x) = x(800 - x) is all of R; the domain of the
// MODEL is (0, 800), and outside it the algebra is fine and the fence
// is imaginary. Old Exercise 56 (absolute extrema on [-4, 6]) has
// been kept in §3 precisely because there the endpoints bite.
//
// PROBLEM STATEMENTS REWORDED, not re-answered:
//   * old Ex 50 gives its answer in km; the problem is stated in
//     miles. Answers here are in miles.
//   * old Ex 51 (the smuggling problem) reads as though it is
//     dimensionally confused — $7 per cubic foot against $8 per
//     square foot. It is not: the metal IS the shell of the barrel,
//     sold by area, while the shipping company charges by volume.
//     The wording here says so explicitly. The answer (114 ft^2,
//     $304) is unchanged.
//   * old Ex 60 asks for the shortest crossing time and the old
//     solution gives only the route. The time is 14 minutes; it is
//     now part of the answer.
//
// LEVEL SPLIT: §5 is only-high. Old Exercises 51 and 62 both need a
// modelling step that is genuinely harder than the rest — a
// three-way relation to eliminate in 51, and a trapezoid whose
// parallel sides BOTH depend on the parameter in 62. Everything in
// §3 and §4 is shared.

= Optimization

#only-theory[
  This is what the derivative was invented for.

  Not the tangent lines, and not the curve sketching — those are
  scaffolding. The question that motivated Fermat, Newton and Leibniz,
  and that motivates most of the calculus done in the world today, is
  the question of the *best*: the cheapest route, the strongest beam
  for a given weight, the shape that encloses the most area with the
  least fence. In every one of those problems some quantity is to be
  made as large or as small as possible, and at the point where that
  happens the quantity is momentarily neither increasing nor
  decreasing.

  Which is to say: the derivative is zero there. You already know how
  to find such points and how to classify them. What this chapter adds
  is the part that comes *before* the calculus — turning a situation
  described in words into a function of one variable — and that is
  where nearly all the difficulty lives.
]

#epigraph(by: "Leonhard Euler")[
  Nothing at all takes place in the universe in which some rule of
  maximum or minimum does not appear.
]

#objectives(
  bfkm[set up a function describing a quantity to be optimized, in
    terms of a single variable],
  bfkm[use a constraint to eliminate variables from the target
    function],
  [determine the domain over which the model is meaningful, and use it
    to decide which critical points are admissible],
  bfkm[locate the maximum or minimum with the derivative and verify
    that it is the one required],
  [interpret the result in the language of the original problem,
    including units],
  obj(level: "high")[handle problems in which the constraint relates
    three quantities, or in which the target function must be
    assembled from a geometric figure],
)

== The Method

#keybox(title: "Seven steps")[
  + *Draw and label.* Give every relevant length, cost or quantity a
    name. Nothing else in the method works without this.
  + *Name the target.* Write down, in symbols, the quantity that is
    to be made largest or smallest. Call it $A$, $V$, $C$ — anything
    but $f$, so that it keeps its meaning.
  + *Find the constraint.* There is almost always a second equation:
    the fence is $1600$ m long, the volume is fixed, the point lies on
    a given curve. Use it to eliminate variables until the target
    depends on *one*.
  + *State the domain of the model.* Which values of that variable
    correspond to a situation that actually exists?
  + *Differentiate and solve* $A'(x) = 0$.
  + *Verify.* Confirm that the critical point is the kind of extremum
    you were asked for, and compare it against the endpoints of the
    domain.
  + *Answer the question that was asked* — with units, and in the
    quantities the problem named rather than the ones you introduced.
]

#warning[
  Steps 4 and 6 are the two that get skipped, and they are the two
  that cost marks.

  Step 4 because it feels like pedantry until it isn't. Step 6 because
  after solving $A'(x) = 0$ the answer *feels* finished — but
  $A'(x) = 0$ locates stationary points, and a stationary point may be
  a minimum when you wanted a maximum, or a saddle, or an
  inadmissible root that the domain excludes.
]

=== A Worked Example

#abstraction-ladder(
  l0: [A rectangular corral is to be fenced off using $1600$ m of
    fencing. Make its area as large as possible.],
  l1: [Side lengths $x$ and $y$ (in metres); perimeter fixed at
    $1600$; area $A = x dot y$.],
  l2: [The perimeter condition ties $y$ to $x$, so the area is really
    a function of $x$ alone — and it is a downward parabola.],
  l3: [$A(x) = x dot (800 - x)$, #h(0.4em) $0 < x < 800$.],
)

#example(title: "The corral, in seven steps")[
  *1. Draw and label.* A rectangle with sides $x$ and $y$, both in
  metres.

  *2. Target.* The area, $A = x dot y$.

  *3. Constraint.* The fencing is the perimeter:
  $2 x + 2 y = 1600$, so $y = 800 - x$. Substituting,
  $ A(x) = x dot (800 - x) = 800 x - x^2. $

  *4. Domain of the model.* Both sides must be positive, so $x > 0$
  and $800 - x > 0$: the model lives on $(0, 800)$. Note that the
  *formula* $800 x - x^2$ is perfectly happy at $x = -50$; it just
  describes no corral.

  *5. Differentiate.* $A'(x) = 800 - 2 x = 0$ gives $x = 400$.

  *6. Verify.* $A''(x) = -2 < 0$, so this is a maximum. And it lies
  inside the domain. The endpoints give area zero — a degenerate
  corral of zero width — so the interior point wins comfortably.

  *7. Answer.* With $x = 400$ we get $y = 400$: the corral is a
  *square* of side $400$ m, with area
  $ A = #num(160000) " m"^2. $
]

#remark[
  The answer is a square, and that is not a coincidence peculiar to
  $1600$ m. Redo the computation with a perimeter $P$ instead of a
  number: $A(x) = x dot (P/2 - x)$, so $A'(x) = P/2 - 2 x = 0$ gives
  $x = P/4$ — a square, always.

  Doing the general case costs no more work than the specific one and
  tells you something the specific one cannot. Whenever an
  optimization answer comes out unexpectedly clean, it is worth
  redoing with a letter in place of the number.
]

== Verifying the Extremum

#only-theory[
  Three ways to complete step 6, in rough order of how often they are
  the right tool.

  *The domain has endpoints.* Then the problem is a closed-interval
  problem from the previous chapter: evaluate the target at every
  critical point and at both endpoints, and compare. No classification
  is needed at all.

  *The second derivative.* Fast when $A''$ is easy: negative means
  maximum, positive means minimum. Silent when $A''(x_0) = 0$.

  *The sign of $A'$.* Never fails, and often the quickest of all when
  $A'$ is already factored — which after step 5 it usually is.

  There is also a fourth, informal check worth doing every single time:
  *does the answer make sense?* A negative length, a box taller than
  the cardboard it was cut from, or a cost of zero are all signs that
  something went wrong three steps earlier.
]

#warning[
  A subtlety with the domain. Many models live on an *open* interval —
  the corral on $(0, 800)$ — where the closed-interval theorem does not
  apply and there are no endpoints to evaluate. In practice this is
  rarely a problem, because the target usually degenerates towards the
  ends (area zero, infinite cost) so the interior critical point is
  clearly the winner. But say so, rather than assuming it.
]

== Geometric Optimization

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Find the number that exceeds its square by the greatest amount.
][
  Let the number be $x$; the quantity to maximize is
  $ f(x) = x - x^2. $
  Then $f'(x) = 1 - 2 x = 0$ gives $x = 1/2$, and $f'' = -2 < 0$
  confirms a maximum. The number is $1/2$, and it exceeds its square by
  $1/2 - 1/4 = 1/4$.

  Notice that no constraint was needed here — the problem already
  described a function of one variable. That is unusual.
]

#ex(difficulty: 1, time: "10 min", calculator: false)[
  A rectangular corral is to be enclosed with $1600$ m of fencing.
  Find the maximum possible area.
][
  Worked in full above: a square of side $400$ m, with area
  $#num(160000)$ m#super[2].
]

#ex(
  difficulty: 2,
  time: "12 min",
  calculator: false,
  hints: (
    [Let $x$ be the side of the squares cut from the corners. What are
      the three dimensions of the finished box in terms of $x$?],
    [The domain matters here: $x$ cannot exceed half the side of the
      cardboard, or there is nothing left of the base.],
  ),
)[
  Squares of side $x$ are cut from the four corners of a square piece
  of cardboard with sides of $30$ cm, and the flaps are folded up to
  make an open box. How long should $x$ be so that the box has maximum
  volume?
][
  Folding up flaps of height $x$ leaves a base of side $30 - 2 x$, so
  $ V(x) = x dot (30 - 2 x)^2, quad 0 < x < 15. $
  By the product rule,
  $ V'(x) = (30 - 2 x)^2 + x dot 2 dot (30 - 2 x) dot (-2)
    = (30 - 2 x) dot (30 - 6 x). $
  The roots are $x = 15$ and $x = 5$. The first is excluded by the
  domain — it is the degenerate box with no base at all — so
  $ x = 5 " cm", quad V = 5 dot 400 = 2000 " cm"^3. $

  The sign of $V'$ across $x = 5$ runs $+ -> -$, confirming a maximum.
  This is a good example of the domain doing real work in step 6: one
  of the two stationary points is discarded on geometric grounds
  rather than mathematical ones.
]

#ex(difficulty: 2, time: "12 min", calculator: true)[
  Find the point on the parabola $y = x^2$ that is nearest to the
  point $(6, 3)$.
][
  The distance from $(x, x^2)$ to $(6, 3)$ is
  $ d(x) = sqrt((x - 6)^2 + (x^2 - 3)^2). $
  Minimizing $d$ is the same as minimizing $d^2$, since the square
  root is increasing — and $d^2$ is far pleasanter to differentiate:
  $ (d^2)'(x) = 2 dot (x - 6) + 2 dot (x^2 - 3) dot 2 x
    = 4 x^3 - 10 x - 12. $
  Setting this to zero gives $2 x^3 - 5 x - 6 = 0$, and $x = 2$ is a
  root (dividing out leaves $2 x^2 + 4 x + 3$, whose discriminant is
  negative). So the nearest point is
  $ P = (2, 4). $

  #heuristic("solve a simpler version first")

  The trick of minimizing the square instead of the distance is worth
  keeping. It works whenever the outer function is increasing, and it
  removes a root from every subsequent line.
]

#ex(difficulty: 2, time: "12 min", calculator: true)[
  Which point $P$ on the graph of $f: y = 0.5 x^2$ is closest to the
  point $A = (6, 0)$?
][
  Minimizing the squared distance $(x - 6)^2 + (0.5 x^2)^2$ gives
  $ 2 dot (x - 6) + x^3 = 0 quad ==> quad x^3 + 2 x - 12 = 0, $
  with the root $x = 2$ (the remaining factor $x^2 + 2 x + 6$ has no
  real zeros). So $P = (2, 2)$.
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  Find the absolute maximum and minimum values of
  $f(x) = x^3 - 12 x - 5$ on the interval $[-4, 6]$.
][
  $f'(x) = 3 x^2 - 12 = 0$ gives $x = plus.minus 2$, both inside the
  interval. Evaluating at the critical points *and* both endpoints:
  $ f(-4) = -21, quad f(-2) = 11, quad f(2) = -21, quad f(6) = 139. $
  So the absolute maximum is $139$, at the endpoint $x = 6$, and the
  absolute minimum is $-21$, attained twice — at the interior point
  $x = 2$ and at the endpoint $x = -4$.

  Two lessons in one short problem: the maximum is at an endpoint that
  no derivative would have found, and an absolute extremum need not be
  attained at a single place.
]

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: true,
  hints: (
    [Let the base be square with side $x$. Write the height in terms
      of $x$ using the fixed volume, then write the surface area.],
    [Open-top means five faces, not six.],
  ),
)[
  An open-top box is to have a square base and a volume of
  $#num(13500)$ cm#super[3]. Find the dimensions that minimize the
  amount of material used.
][
  With base side $x$ and height $h$, the volume condition gives
  $x^2 dot h = #num(13500)$, so $h = #num(13500) slash x^2$. The
  material is the base plus four sides:
  $ S(x) = x^2 + 4 x h = x^2 + #num(54000)/x, quad x > 0. $
  $ S'(x) = 2 x - #num(54000)/x^2 = 0
    quad ==> quad x^3 = #num(27000) quad ==> quad x = 30. $
  Then $h = #num(13500) slash 900 = 15$. Since
  $S'' = 2 + #num(108000) slash x^3 > 0$, this is a minimum.

  Base $30 times 30$ cm, height $15$ cm — the height is *half* the
  base, not equal to it. Open-topped boxes are not cubes, and the
  missing lid is exactly why.
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  For which dimensions does a pillar with a square base and a volume of
  $8$ dm#super[3] have the smallest surface area?
][
  With base side $x$ and height $h$, we have $x^2 h = 8$ and
  $ S(x) = 2 x^2 + 4 x h = 2 x^2 + 32/x, quad x > 0. $
  $ S'(x) = 4 x - 32/x^2 = 0 quad ==> quad x^3 = 8 quad ==> quad x = 2, $
  and then $h = 8/4 = 2$. The pillar is a *cube* of side $2$ dm.

  Compare with the previous exercise. Closing the top changes the
  answer from "height half the base" to "height equal to the base" —
  the shape that minimizes surface area depends on which faces you are
  paying for.
]

#ex(
  difficulty: 3,
  time: "18 min",
  calculator: true,
  hints: (
    [Call the radius of the semicircle $r$. The width of the rectangle
      is then $2 r$ — write the perimeter, remembering that the top of
      the rectangle is not framed.],
    ["Let in the most light" means maximize the area, not the
      perimeter.],
  ),
)[
  A window has a rectangular lower part and a semicircular top. There
  are $12$ m of framing material. What dimensions let in the most
  light?
][
  Let $r$ be the radius of the semicircle, so the rectangle has width
  $2 r$ and some height $y$. The frame runs along the two vertical
  sides, the bottom, and the semicircular arc:
  $ 2 r + 2 y + pi r = 12 quad ==> quad
    y = (12 - 2 r - pi r) / 2. $
  The area is the rectangle plus the half-disc:
  $ A(r) = 2 r dot y + (pi r^2)/2
    = 12 r - 2 r^2 - (pi r^2)/2. $
  $ A'(r) = 12 - 4 r - pi r = 0 quad ==> quad
    r = 12/(4 + pi) approx 1.68 " m". $
  The width is $2 r approx 3.36$ m, and substituting back gives
  $y approx 1.68$ m as well. Since $A'' = -4 - pi < 0$, it is a
  maximum.

  The rectangle's height equals the semicircle's radius — so the
  window is exactly as tall in its rectangular part as the semicircle
  is deep. That is a fact about the shape, independent of the $12$ m.
]

#ex(
  difficulty: 3,
  time: "20 min",
  calculator: true,
  hints: (
    [The region is symmetric about the $y$\u{2011}axis, so take the
      rectangle to be symmetric too: corners at $plus.minus x$ on the
      axis and at height $f(x)$.],
    [Factor $A'$ completely before solving. Two of its roots lie
      outside the region.],
  ),
)[
  A rectangle is inscribed in the finite region enclosed by the graph
  of
  $ f: y = 1/5 dot (x^4 - 10 x^2 + 25) $
  and the $x$\u{2011}axis. Calculate the maximum area of this
  rectangle.
][
  Note first that $f(x) = 1/5 dot (x^2 - 5)^2$, so the graph touches
  the axis at $x = plus.minus sqrt(5)$ and the enclosed region runs
  between them. Taking the rectangle symmetric about the
  $y$\u{2011}axis with corners at $plus.minus x$, its width is $2 x$
  and its height is $f(x)$:
  $ A(x) = 2 x dot 1/5 dot (x^2 - 5)^2, quad 0 < x < sqrt(5). $
  Differentiating and factoring,
  $ A'(x) = 2/5 dot (x^2 - 5) dot (5 x^2 - 5)
    = 2 dot (x^2 - 5) dot (x^2 - 1). $
  The roots are $x = plus.minus 1$ and $x = plus.minus sqrt(5)$; the
  only one inside the domain is $x = 1$. There
  $ A = 2/5 dot 1 dot 16 = 32/5 = 6.4. $
]

== Optimization in Context

#ex(
  difficulty: 3,
  time: "20 min",
  calculator: true,
  hints: (
    [Let $x$ be the distance downstream at which the underwater cable
      reaches the far bank. Draw the right triangle: its legs are $1$
      and $x$.],
    [Two cable lengths, two different prices. Write the total cost
      before differentiating anything.],
  ),
)[
  An underground power cable is to run from a power station on one
  bank of a river to a house on the other. The house is $5$ miles
  downstream, and the river has a constant width of $1$ mile. Laying
  cable underground costs \$#num(1000) per mile; laying it under water
  costs \$#num(3000) per mile. How should the cable be laid to
  minimize the total cost, and what is that minimum cost?
][
  Let $x$ be the downstream distance covered by the underwater
  section. That section has length $sqrt(1 + x^2)$ by Pythagoras, and
  the remaining $5 - x$ miles run overland:
  $ C(x) = #num(3000) dot sqrt(1 + x^2) + #num(1000) dot (5 - x),
    quad 0 lt.eq x lt.eq 5. $
  $ C'(x) = (#num(3000) dot x) / sqrt(1 + x^2) - #num(1000) = 0
    quad ==> quad 3 x = sqrt(1 + x^2), $
  so $9 x^2 = 1 + x^2$ and $x = 1 slash sqrt(8) approx 0.354$ miles.

  The underwater run is then $sqrt(1 + 1/8) approx 1.06$ miles and the
  underground run $5 - 0.354 approx 4.65$ miles, for a total cost of
  about
  $ C approx \$#num(7828.43). $

  Compare the two extreme strategies: straight across then along the
  bank costs $#num(3000) + #num(5000) = \$#num(8000)$, and a single
  diagonal costs $#num(3000) sqrt(26) approx \$#num(15297)$. The
  optimum beats both, but it beats the first by only about $2%$ — worth
  knowing before anyone spends a week refining the calculation.
]

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: true,
  hints: (
    [If $s$ inches go to the square, its side is $s slash 4$. If
      $50 - s$ inches go to the circle, that length is the
      *circumference*.],
  ),
)[
  A wire $50$ inches long is cut into two pieces. One piece is bent
  into a circle, the other into a square. Where should the wire be cut
  to minimize the sum of the two areas?
][
  Let $s$ be the length used for the square, so its side is $s/4$ and
  its area $s^2 slash 16$. The circle has circumference $50 - s$, so
  radius $(50 - s) slash (2 pi)$ and area
  $(50 - s)^2 slash (4 pi)$. Then
  $ A(s) = s^2/16 + (50 - s)^2/(4 pi), quad 0 lt.eq s lt.eq 50, $
  $ A'(s) = s/8 - (50 - s)/(2 pi) = 0
    quad ==> quad s = 400/(2 pi + 8) approx 28. $
  So about $28$ inches for the square and $22$ for the circle.

  Worth checking the endpoints, since the domain is closed: all wire
  to the circle ($s = 0$) gives area $approx 199$, all to the square
  gives $approx 156$, and the optimum gives $approx 87.5$. The
  interior point wins — but note that *maximizing* the sum of areas
  would have put everything into the circle, which no derivative would
  have told you.
]

#ex(
  difficulty: 3,
  time: "20 min",
  calculator: true,
  hints: (
    [Walk a distance $d$ along the path first, then cut straight
      across to the opposite corner. Write the time for each leg
      separately — time is distance over speed.],
    [The diagonal leg runs from $(d, 0)$ to the corner $(1, 1)$.],
  ),
)[
  You want to cross a square ploughed field from one corner to the
  opposite corner as quickly as possible. There is a path along one
  edge; the rest of the field is ploughed right up to the other three
  edges. On the ploughed land you walk at $6$ km/h, on the path at
  $10$ km/h. The field is one kilometre square.

  What is the best route, and how long does the crossing take?
][
  Take the starting corner at the origin, the path along the bottom
  edge, and the destination at $(1, 1)$. Walk a distance $d$ along the
  path, then cut across:
  $ T(d) = d/10 + sqrt((1 - d)^2 + 1) / 6, quad 0 lt.eq d lt.eq 1. $
  $ T'(d) = 1/10 - (1 - d) / (6 sqrt((1 - d)^2 + 1)) = 0 $
  gives $6 sqrt((1 - d)^2 + 1) = 10 dot (1 - d)$. Squaring and writing
  $u = 1 - d$:
  $ 36 u^2 + 36 = 100 u^2 quad ==> quad u = 3/4
    quad ==> quad d = 1/4. $
  So walk $250$ m along the path, then cut diagonally across. The time
  is
  $ T = 0.025 + 1.25/6 approx 0.2333 " h" = 14 " minutes". $

  For comparison, cutting straight across the diagonal from the start
  takes $sqrt(2) slash 6 approx 14.14$ minutes, and going along the
  whole path and then up the far edge takes
  $1/10 + 1/6 approx 16$ minutes. The optimum saves only a few
  seconds over the naive diagonal — which is itself a useful thing to
  discover.
]

#ex(
  difficulty: 3,
  time: "18 min",
  calculator: true,
  hints: (
    [Profit is revenue minus cost. Write both in terms of $x$, the
      number of units of $100$ bulbs.],
    [The answer must be a whole number of units. Check the two
      integers either side of your critical point if it is not one.],
  ),
)[
  A manufacturer of lightbulbs finds that the cost of producing $x$
  units of $100$ lightbulbs is
  $ C(x) = 2/3 dot x^3 - 10 x^2 + 52 x + 20 $
  (in dollars). One unit of $100$ lightbulbs sells for \$$74$. How many
  lightbulbs should she produce, and what is her profit?
][
  Revenue is $74 x$, so the profit is
  $ P(x) = 74 x - C(x)
    = -2/3 dot x^3 + 10 x^2 + 22 x - 20. $
  $ P'(x) = -2 x^2 + 20 x + 22 = -2 dot (x - 11) dot (x + 1) = 0 $
  gives $x = 11$ (the root $x = -1$ is outside the domain $x gt.eq 0$).
  Since $P'' (11) = -44 + 20 < 0$, it is a maximum:
  $ P(11) approx \$544.67, $
  from producing $11$ units, i.e. $#num(1100)$ lightbulbs.

  Note what $P'(x) = 0$ says in economic language: it is the point at
  which the marginal revenue $74$ equals the marginal cost $C'(x)$.
  That is the central principle of price theory, and it is nothing but
  step 5 of the method in this chapter.
]

#only-high[
  == Two Harder Models

  Both problems below are hard at the *modelling* stage rather than
  the calculus stage — which is where the real difficulty in this
  subject always was.
]

#ex(
  difficulty: 3,
  time: "20 min",
  calculator: true,
  level: "high",
  hints: (
    [The metal is the *shell* of the barrel, so what you are selling
      is its surface area. What you are paying to ship is its volume.
      Write both in terms of the radius alone.],
    [Use $h = 2 d = 4 r$ to eliminate the height before doing anything
      else.],
  ),
)[
  You intend to move a quantity of precious metal across a border by
  disguising it as a cylindrical barrel, closed at both ends. The
  barrel's *shell* is the metal: once across, you can sell it for
  \$$8$ per square foot of surface. The shipping company charges \$$7$
  per cubic foot of the barrel's *volume*.

  The barrels are designed with the height equal to twice the
  diameter. How many square feet of metal should you ship, and what
  will your profit be?
][
  With radius $r$, the design condition gives $h = 2 d = 4 r$. Then
  $ S(r) = 2 pi r^2 + 2 pi r h = 2 pi r^2 + 8 pi r^2 = 10 pi r^2,
    quad V(r) = pi r^2 h = 4 pi r^3. $
  Revenue is $8 S$ and shipping cost is $7 V$, so
  $ P(r) = 80 pi r^2 - 28 pi r^3, quad r > 0. $
  $ P'(r) = 160 pi r - 84 pi r^2 = 4 pi r dot (40 - 21 r) = 0 $
  gives $r = 40/21 approx 1.90$ ft (discarding $r = 0$). Then
  $ S = 10 pi dot (40/21)^2 approx 114 " ft"^2, quad
    P approx \$304. $

  The structure worth noticing: revenue grows like $r^2$ while cost
  grows like $r^3$, so a small barrel is profitable and a large one is
  not, and somewhere between them is a best size. Any problem with
  that shape — benefit scaling with area, cost with volume — has the
  same answer pattern.
]

#ex(
  difficulty: 3,
  time: "25 min",
  calculator: true,
  level: "high",
  hints: (
    [Find the zeros of $f$ first; $B$ is the positive one.],
    [The trapezoid has two parallel sides, $A B$ and $D C$, and *both*
      the second side and the height depend on the position of $C$.],
    [For the angle, consider what happens to the line $B C$ as $C$
      slides towards $B$.],
  ),
)[
  #emph[(Final examination question.)] Given the graph of
  $ f: y = -0.1 dot (x^2 + 10 x - 39) $
  and a trapezoid $A B C D$, where $A$ is the origin, $B$ is the
  positive zero of $f$, $C$ is an arbitrary point on the parabola in
  the first quadrant, and $D$ is the point on the
  $y$\u{2011}axis at the same height as $C$.
  #auto-parts(
    1,
    [How large can the angle $angle C B A$ be under these
      conditions?],
    [Find the coordinates of $C$ for which the trapezoid has maximum
      area.],
  )
][
  The zeros of $f$ come from $x^2 + 10 x - 39 = 0$, giving $x = 3$ and
  $x = -13$. So $B = (3, 0)$.

  #auto-parts(
    1,
    [As $C$ slides along the parabola towards $B$, the line $B C$
      approaches the *tangent* at $B$, so the angle approaches its
      largest value there. Since
      $f'(x) = -0.1 dot (2 x + 10)$, we get $f'(3) = -1.6$. The ray
      $B A$ points in the negative $x$\u{2011}direction, and the
      limiting ray $B C$ has direction $(-1, 1.6)$, so
      $ tan(angle C B A) -> 1.6 quad ==> quad
        angle C B A -> 57.99 degree. $
      This is a supremum rather than a maximum: it is approached but
      never attained, since $C = B$ would collapse the trapezoid.],
    [Write $C = (c, f(c))$ with $0 < c < 3$. The parallel sides are
      $A B$, of length $3$, and $D C$, of length $c$; the height is
      $f(c) = 3.9 - c - 0.1 c^2$. So
      $ A(c) = 1/2 dot (3 + c) dot (3.9 - c - 0.1 c^2). $
      Expanding and differentiating,
      $ A'(c) = 1/2 dot (0.9 - 2.6 c - 0.3 c^2) = 0
        quad ==> quad 3 c^2 + 26 c - 9 = 0, $
      whose roots are $c = 1/3$ and $c = -9$. Only the first lies in
      the domain, so
      $ C = (1/3, 32/9). $],
  )

  #heuristic("check an extreme or special case")

  Part (a) is unusual and worth discussing: the answer is a limit, not
  a value attained at a stationary point. Not every "how large can it
  be" question is answered by setting a derivative to zero — sometimes
  the quantity is monotonic and the answer sits at an edge of the
  domain that the model excludes.
]

#ai-box(role: "Tutor")[
  Choose an optimization problem from this chapter that you have not
  yet done. Give an AI assistant *only steps 1 to 4* of your own work
  — the labelled diagram in words, the target function, the
  constraint, and the domain — and ask it to check your modelling
  without solving anything. Then do the calculus yourself.

  This split is deliberate. Assistants are extremely reliable at step
  5 and noticeably weaker at steps 3, 4 and 7, which is the exact
  reverse of where students need help. Asking for the whole solution
  gets you a correct answer to a problem you may have set up wrongly,
  and you will not find out which.
]

#print-hints()
#print-vocab()
