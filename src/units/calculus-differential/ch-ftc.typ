#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "The Fundamental Theorem")
#let ex = exercise.with(chapter: "The Fundamental Theorem")

// ── TEACHER'S NOTE ───────────────────────────────────────────
// This is the payoff chapter, and it is worth teaching as one. The
// two previous chapters were built so that students arrive here with
// two unconnected things — a family of antiderivatives, and a limit
// of rectangle sums — and with the notational coincidence explicitly
// flagged as unexplained. §2 is where it resolves.
//
// SUGGESTED OPENING. Before any theory, put the three results from
// the end of ch-riemann on the board:
//     ∫₀¹ x dx = 1/2,  ∫₀¹ x² dx = 1/3,  ∫₀¹ x³ dx = 1/4,
// each obtained by a page of summation, and ask what the pattern is.
// Someone will say x^(n+1)/(n+1). Then ask where they have seen that
// expression before. The chapter can start from their answer.
//
// The old LaTeX notes state the theorem in a box, call it "one of the
// most important theorems in math", and move to exercises. Everything
// in §1 and §2 here — the area function, and the geometric argument
// for why its derivative is f — is new. §1 is the load-bearing part:
// without the area function there is no way to see WHY the theorem is
// true, and it becomes a formula to memorize.
//
// §4 (net change) is also new. It is the same theorem read in the
// language of rates, and for many students it is the reading that
// finally makes the statement mean something.

= The Fundamental Theorem

#only-theory[
  Two chapters ago we ran differentiation backwards and got a family
  of functions. One chapter ago we chopped a region into rectangles
  and got a number. The two had nothing to do with each other, except
  that Leibniz — for reasons we deferred — wrote them with the same
  symbol.

  This chapter is where the deferral ends. It turns out that the
  problem of *accumulating* a quantity and the problem of *undoing* a
  rate of change are not two problems. They are one problem, seen from
  two directions, and the result saying so is important enough to be
  called the fundamental theorem of the whole subject.

  It is also the reason integration is worth learning. Riemann sums
  define the definite integral but are a hopeless way to compute it —
  three pages of summation for $integral_0^1 x^2 dif x$. After this
  chapter that calculation takes one line.
]

#epigraph(by: "Michael Spivak")[
  The fundamental theorem of calculus is far from being a difficult
  theorem, but its consequences are so numerous that its name is
  entirely appropriate.
]

#objectives(
  [describe the area function of a given function, and explain why its
    variable of integration must be named separately],
  bfkm[state the fundamental theorem of calculus and explain what it
    asserts],
  [explain why the derivative of the area function is the original
    function],
  bfkm[evaluate a definite integral using an antiderivative],
  [explain why the constant of integration may be omitted when
    evaluating a definite integral],
  bfkm[interpret a definite integral of a rate of change as a net
    change, and distinguish net change from total change],
  obj(level: "high")[compute the average value of a function over an
    interval],
)

== The Area Function

#only-theory[
  The key idea is to stop treating the definite integral as a number
  and start treating it as a *function* — by letting the upper limit
  move.

  Fix a starting point $a$, and for each $x$ define
  $ A(x) = integral_a^x f(t) dif t: $
  the signed area accumulated from $a$ up to $x$. As $x$ slides to the
  right, $A(x)$ grows (where $f$ is positive) or shrinks (where $f$ is
  negative). It is a perfectly ordinary function of $x$.
]

#warning[
  Notice that the variable inside is $t$, not $x$. It has to be:
  $x$ is already in use as the upper limit, and writing
  $integral_a^x f(x) dif x$ would use one letter for two different
  jobs in the same expression.

  The inner variable is a *dummy* — it exists only to be summed over
  and does not survive to the answer. Any letter does:
  $integral_a^x f(t) dif t$ and $integral_a^x f(u) dif u$ are the same
  function of $x$.
]

#exploration(title: "What kind of function is the area function?")[
  Take $a = 0$ throughout, so that $A(x) = integral_0^x f(t) dif t$.

  + Let $f(t) = 2$. Sketch the region and find a formula for $A(x)$
    using nothing but the area of a rectangle.
  + Let $f(t) = 2 t$. Sketch and find $A(x)$ using the area of a
    triangle.
  + Let $f(t) = 3$, then $f(t) = t$, then $f(t) = t + 1$. Find $A(x)$
    in each case.
  + You now have five pairs $f$ and $A$. For each pair, compute
    $A'(x)$ and compare it with $f(x)$.
  + Formulate a conjecture. Does it depend on the choice of $a$?
]

#only-theory[
  The conjecture is that $A' = f$: the area function is an
  antiderivative of the function whose area it is accumulating. And
  changing $a$ changes $A$ only by a constant — it shifts where the
  accumulation starts from — which is invisible to $A'$.

  That statement is worth staring at, because it is not obvious and it
  is not a coincidence of these five examples. It says that the
  rectangle-summing process of the previous chapter *undoes*
  differentiation.
]

== The Theorem

#keybox(title: "Fundamental theorem of calculus, first part")[
  Let $f$ be continuous on an interval containing $a$. Then the area
  function
  $ A(x) = integral_a^x f(t) dif t $
  is differentiable, and
  $ A'(x) = f(x). $
  In words: *every continuous function has an antiderivative, and one
  of them is its own area function.*
]

#example(title: "Why it is true")[
  Look at the difference quotient of $A$. The numerator
  $A(x + h) - A(x)$ is the area accumulated between $x$ and $x + h$ —
  a thin sliver of width $h$ under the graph of $f$:
  $ A(x + h) - A(x) = integral_x^(x + h) f(t) dif t, $
  by the additivity property from the previous chapter.

  #align(center)[
    #plot(
      xmin: -0.3, xmax: 3.3, ymin: -0.4, ymax: 4.6,
      width: 10, height: 5.5,
      axis-x-pos: "bottom", axis-y-pos: "left",
      xlabel: $t$, ylabel: $y$,
      xtick: (), ytick: (),
      show-origin: false,
      fill-area(
        x => 0.4 * x * x + 0.5,
        domain: (0.0, 2.0),
        color: blue.lighten(80%),
      ),
      fill-area(
        x => 0.4 * x * x + 0.5,
        domain: (2.0, 2.45),
        color: rgb("#c94a00").lighten(55%),
      ),
      (
        fn: x => 0.4 * x * x + 0.5, domain: (-0.2, 3.1),
        stroke: blue + 1.4pt,
        label: $f(t)$, label-pos: 0.97, label-side: "above-left",
      ),
      note($a$, (0.0, -0.18), anchor: "center", size: 9pt),
      note($x$, (2.0, -0.18), anchor: "center", size: 9pt),
      note($x + h$, (2.45, -0.18), anchor: "center", size: 9pt),
      note($A(x)$, (1.0, 0.6), anchor: "center", size: 9pt),
    )
  ]

  The blue region is $A(x)$; the narrow orange sliver is the whole of
  $A(x + h) - A(x)$. It is very nearly a rectangle of width $h$ and
  height $f(x)$, and the narrower it gets the more nearly so.

  Now, if $h$ is small, $f$ barely changes across that sliver, so the
  sliver is almost a rectangle of width $h$ and height $f(x)$:
  $ A(x + h) - A(x) approx f(x) dot h. $
  Dividing by $h$,
  $ (A(x + h) - A(x)) / h approx f(x), $
  and the approximation improves as $h$ shrinks — because the
  continuity of $f$ means the height of the sliver varies less and
  less. Taking the limit gives $A'(x) = f(x)$.

  The entire theorem is that picture: *the rate at which area
  accumulates is the height of the graph.*
]

#remark[
  That is worth saying in plain language, because it is the sentence
  to remember when the symbols blur. If you are filling a container
  and the water level is rising, the *rate* at which the volume
  increases depends on how wide the container is at the current level.
  Area accumulates fast where the graph is high and slowly where it is
  low, and not at all where the graph touches the axis.
]

=== From Areas to a Method of Calculation

#only-theory[
  The first part says an antiderivative exists. The second part turns
  that into a computation, and it is the one you will use daily.

  Suppose $F$ is *any* antiderivative of $f$. The area function $A$ is
  also an antiderivative, so the two differ by a constant:
  $ A(x) = F(x) + C. $
  Now evaluate at both ends. At $x = a$ the accumulated area is zero,
  so $0 = F(a) + C$, giving $C = -F(a)$. At $x = b$,
  $ integral_a^b f(t) dif t = A(b) = F(b) + C = F(b) - F(a). $
]

#keybox(title: "Fundamental theorem of calculus, second part")[
  Let $f$ be continuous on $[a, b]$ and let $F$ be *any*
  antiderivative of $f$. Then
  $ integral_a^b f(x) dif x = F(b) - F(a). $

  The standard shorthand for the right-hand side is
  $ [F(x)]_a^b quad "or" quad F(x) bar.v_a^b. $
]

#remark[
  Two things this does *not* require, both worth noticing.

  It does not require the *right* antiderivative — any one will do.
  Replacing $F$ by $F + C$ changes the answer by
  $(F(b) + C) - (F(a) + C) = F(b) - F(a)$: the constants cancel. So
  the $+ C$ that was compulsory in the indefinite integral is
  pointless here, and you should omit it.

  It does not require $f$ to be positive. Nothing in the argument
  assumed the graph was above the axis — the whole thing runs on
  signed areas, which is exactly why the sign convention was
  introduced before the theorem rather than after.
]

#example(title: "One line instead of three pages")[
  $ integral_0^1 x^2 dif x = [1/3 x^3]_0^1
    = 1/3 dot 1 - 1/3 dot 0 = 1/3. $
  Compare that with the page of summation formulas it took last
  chapter. Both are correct; only one is practical.
]

#example(title: "A definite integral with a negative value")[
  $ integral_1^3 (x^2 - 4 x) dif x
    = [1/3 x^3 - 2 x^2]_1^3
    = (9 - 18) - (1/3 - 2)
    = -9 + 5/3 = -22/3. $
  The answer is negative because the graph lies below the axis
  throughout $[1, 3]$. The *area* of that region is $22/3$; the
  *integral* is $-22/3$. Both statements are correct and they are not
  the same statement.
]

=== Exercises

#ex(
  difficulty: 2,
  time: "30 min",
  calculator: false,
  hints: (
    [Find the antiderivative first and write it in square brackets
      before substituting anything. Substituting as you go is how sign
      errors happen.],
    [Parts (h) and (i) need the linear substitution from the first
      chapter of this unit.],
  ),
)[
  Evaluate the following definite integrals. Where the result is
  rational, simplify as far as possible.
  #auto-parts(
    3,
    [$integral_0^1 2 dif x$],
    [$integral_(-1)^1 (u^2 - 2) dif u$],
    [$integral_1^2 (3/x^2 - 1) dif x$],
    [$integral_0^3 4 e^x dif x$],
    [$integral_e^(e^2) 1/x dif x$],
    [$integral_0^(pi) sin(x) dif x$],
    [$integral_(-1)^1 1/(t + 2) dif t$],
    [$integral_0^2 sqrt(6 x + 4) dif x$],
    [$integral_3^4 e^(-x + 1) dif x$],
  )
][
  #auto-parts(
    3,
    [$[2 x]_0^1 = 2$],
    [$[1/3 u^3 - 2 u]_(-1)^1 = -5/3 - 5/3 = -10/3$],
    [$[-3/x - x]_1^2 = -7/2 + 4 = 1/2$],
    [$[4 e^x]_0^3 = 4 dot (e^3 - 1) approx 76.34$],
    [$[ln(abs(x))]_e^(e^2) = 2 - 1 = 1$],
    [$[-cos(x)]_0^(pi) = 1 + 1 = 2$],
    [$[ln(abs(t + 2))]_(-1)^1 = ln(3) - ln(1) = ln(3)$],
    [$[1/9 (6 x + 4)^(3/2)]_0^2 = 1/9 dot (64 - 8) = 56/9$],
    [$[-e^(-x + 1)]_3^4 = -e^(-3) + e^(-2)
      = e^(-3) dot (e - 1) approx 0.086$],
  )

  Part (b) is a useful check on signs: the integrand $u^2 - 2$ is
  negative on most of $[-1, 1]$, so a negative answer is expected.
  Part (e) is a small gift — the limits were chosen so that the
  logarithms come out whole.
]

#ex(
  difficulty: 2,
  time: "8 min",
  calculator: false,
  hints: (
    [Evaluate the integral in terms of $k$ first, then solve the
      resulting equation.],
  ),
)[
  Given that
  $ integral_2^k 1/x dif x = ln(6), $
  find the value of $k$.
][
  $ integral_2^k 1/x dif x = [ln(abs(x))]_2^k = ln(k) - ln(2)
    = ln(k/2). $
  Setting $ln(k slash 2) = ln(6)$ gives $k slash 2 = 6$, so
  $ k = 12. $
  (The logarithm is one-to-one, which is what licenses dropping it
  from both sides.)
]

== Net Change

#only-theory[
  There is a second way to read the theorem, and for many people it is
  the reading that makes it click.

  Apply the second part not to some function $f$, but to a
  *derivative*. If $F$ is a function and $f = F'$ is its rate of
  change, then the theorem says
  $ integral_a^b F'(x) dif x = F(b) - F(a). $

  Read that in words: *the accumulated rate of change over an interval
  equals the net change over that interval*. Which, put like that,
  ought to be obvious — if you add up all the little changes, you get
  the total change. The theorem's content is that this obvious
  statement about rates is the same as the non-obvious statement about
  areas.
]

#example(title: "Velocity and displacement")[
  If $v(t)$ is velocity, then $v = s'$ where $s$ is position, so
  $ integral_(t_1)^(t_2) v(t) dif t = s(t_2) - s(t_1): $
  the integral of velocity is the *displacement* — how far the object
  ended up from where it started.

  This is not the same as the distance travelled. An object that goes
  forwards and comes back has zero displacement and a perfectly
  positive distance. To get distance you must integrate $abs(v)$, which
  in practice means splitting the interval where $v$ changes sign and
  adding the absolute values.
]

#ex(
  difficulty: 3,
  time: "20 min",
  calculator: true,
  hints: (
    [For (b), the particle moves left exactly when its velocity is
      negative. Factor the quadratic.],
    [For (c), distance is not displacement. Split the interval at the
      time found in (b) and add the magnitudes.],
  ),
)[
  A particle moves along a horizontal line with velocity $v$ in m/s,
  where
  $ v(t) = 2 t^2 - 11 t + 12, quad t gt.eq 0. $
  #auto-parts(
    1,
    [Give an expression for the acceleration $a$ in m/s#super[2], in
      terms of $t$.],
    [The particle moves leftwards for $t_1 < t < t_2$. Find $t_1$ and
      $t_2$.],
    [Find the total distance the particle travels between $t = 2$ and
      $t = 5$ seconds.],
    [Find its displacement over the same interval, and explain why the
      two answers differ.],
  )
][
  #auto-parts(
    1,
    [$a(t) = v'(t) = 4 t - 11$.],
    [$v(t) = (2 t - 3) dot (t - 4)$, so the velocity is zero at
      $t = 3/2$ and $t = 4$ and negative between them:
      $t_1 = 1.5$ s and $t_2 = 4$ s.],
    [The sign of $v$ changes at $t = 4$, which lies inside $[2, 5]$,
      so split there:
      $ integral_2^4 v(t) dif t = -14/3, quad
        integral_4^5 v(t) dif t = 19/6. $
      The total distance is the sum of the magnitudes:
      $ 14/3 + 19/6 = 47/6 approx 7.83 " m". $],
    [The displacement is the plain integral over the whole interval,
      $ integral_2^5 v(t) dif t = -14/3 + 19/6 = -3/2 = -1.5 " m", $
      so the particle finishes $1.5$ m to the *left* of where it
      started, having travelled $7.83$ m to get there. The difference
      is the double-counting of the stretch it covered twice — once
      going left and once coming back.],
  )

  #heuristic("draw a picture")

  A sign diagram for $v$ on $[2, 5]$ is worth more here than any
  amount of care with the algebra.
]

#only-high[
  == The Average Value of a Function

  The mean of finitely many numbers is their sum divided by how many
  there are. A function on an interval has infinitely many values, so
  the sum becomes an integral — and "how many" becomes the length of
  the interval.

  #keybox(title: "Average value")[
    The #vocab("average value", "Mittelwert") of a continuous function
    $f$ on $[a, b]$ is
    $ overline(f) = 1/(b - a) dot integral_a^b f(x) dif x. $
  ]

  Geometrically, $overline(f)$ is the height of the rectangle on
  $[a, b]$ having the same area as the region under the graph: the
  level at which the curve would sit if it were flattened out without
  spilling anything.

  For example, the average value of $sin(x)$ over one arch,
  $[0, pi]$, is
  $ 1/pi dot integral_0^(pi) sin(x) dif x = 2/pi approx 0.637 $
  — noticeably less than the peak value $1$, and rather more than the
  half-way guess of $0.5$, since the arch is fatter near the top than
  a triangle would be.
]

#ex(difficulty: 2, time: "12 min", calculator: true, level: "high")[
  #auto-parts(
    1,
    [Find the average value of $f(x) = x^2$ on $[0, 3]$, and find the
      value of $x$ at which $f$ actually attains it.],
    [Find the average value of $v(t) = 20 - 5 t$ on $[0, 4]$ and
      interpret it physically.],
  )
][
  #auto-parts(
    1,
    [$ overline(f) = 1/3 dot integral_0^3 x^2 dif x
        = 1/3 dot [1/3 x^3]_0^3 = 1/3 dot 9 = 3. $
      It is attained where $x^2 = 3$, i.e. at $x = sqrt(3) approx
      1.73$ — not at the midpoint $1.5$, since the parabola spends
      more of its height in the right-hand part of the interval.],
    [$ overline(v) = 1/4 dot integral_0^4 (20 - 5 t) dif t
        = 1/4 dot [20 t - 5/2 t^2]_0^4 = 1/4 dot 40 = 10 " m/s". $
      This is the *average speed* over the four seconds: the object
      covered $40$ m in $4$ s, so a constant $10$ m/s would have taken
      it to the same place. Here the average happens to equal the
      value at the midpoint, because the velocity is linear.],
  )
]

== Why "Fundamental"

#only-theory[
  Three claims, all of them consequences of what this chapter proved.

  *It makes integration possible.* Every definite integral you can
  evaluate, you evaluate by finding an antiderivative. There is no
  other practical method, and without the theorem there would be no
  reason to expect one.

  *It unifies the subject.* Differentiation and integration were
  developed as answers to separate questions — tangents on one side,
  areas and volumes on the other, with a two-thousand-year history
  behind the second. The theorem says they are inverse operations.
  That is why the subject has one name.

  *It explains the notation.* Leibniz's $integral$ is a stretched S
  for *summa*, and he used it for the antiderivative because he
  already understood that the antiderivative computes a sum. The
  symbol you have been reading for three chapters was a claim about
  this theorem all along.
]

#look-ahead(
  title: "What is left to do",
  preview: "areas and techniques",
)[
  Two things, and only two.

  The theorem reduces every definite integral to the problem of
  finding an antiderivative — so the rest of this unit is largely
  about *techniques* for finding them, since the guess-and-check of
  chapter 1 runs out quickly.

  And the theorem computes signed area, while questions usually ask
  for actual area, or for the area *between* two curves. Sorting out
  which regions to add and which to subtract is the subject of the
  next chapter.
]

#ai-box(role: "Explainer")[
  Ask an AI assistant to explain why the derivative of the area
  function $A(x) = integral_a^x f(t) dif t$ is $f(x)$, and require the
  explanation to be *geometric* — about a thin sliver of area — rather
  than symbolic.

  Then ask it a harder question: *what changes if $f$ is negative on
  part of the interval?* A good answer will say that nothing in the
  argument breaks, because the sliver's signed area is still
  $approx f(x) dot h$ and $f(x) < 0$ simply makes it negative, so $A$
  decreases there. A weak answer will start talking about taking
  absolute values, which would break the theorem entirely — and
  spotting that is the point of asking.
]

#print-hints()
#print-vocab()
