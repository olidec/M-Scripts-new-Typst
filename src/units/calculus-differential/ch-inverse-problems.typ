#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Finding Functions")
#let ex = exercise.with(chapter: "Finding Functions")

// ── TEACHER'S NOTE ───────────────────────────────────────────
// The old LaTeX notes open this material with Exercise 41 (read four
// equations off four graphs) and never state the underlying idea:
// that every geometric condition converts into one linear equation in
// the coefficients, and that a polynomial of degree n needs exactly
// n+1 of them. §1 here is that missing idea, presented as a
// translation dictionary, with the counting principle in §2. Once
// students have the dictionary, old Exercises 44-46 stop being
// puzzles and become bookkeeping.
//
// The four graphs of old Exercise 41 are now generated natively
// (§3), so no scan is needed. NOTE ON PLOT WINDOWS: parts (a) and (c)
// grow fast outside the window shown — f(3.5) ~ 17 in (a) — and rely
// on plot-graph clipping to the frame. If your simple-plot version
// does not clip cleanly, narrow xmin/xmax rather than raising ymax,
// which would flatten the features students need to read.
//
// §5 (families of curves) replaces the old §10 opening. The old
// version demonstrates a GeoGebra slider and stops; this version adds
// the locus question — as t varies, the vertex of x^2 + 2tx + 4
// traces y = 4 - x^2, a parabola in its own right. That question is
// the natural one to ask about a family and it makes the "array of
// curves" picture mean something.
//
// NOT here: old Exercises 95-98. All four ask for a parameter that
// makes an ENCLOSED AREA maximal or equal to a given value, so they
// belong to the integral unit. Only old Exercise 99 (slope condition
// on a sin(2x) + b cos(x)) is differentiation, and it appears in §5.

= Finding Functions

#only-theory[
  Every problem so far has run in one direction. You were handed a
  function and asked what its graph does: where it rises, where it
  turns, how it bends. This chapter runs the other way. You are told
  what the graph does, and asked which function does it.

  These are #vocab("inverse problems", "inverse Probleme"), and they
  are what mathematics is usually for outside the classroom. Nobody
  hands an engineer a formula; they hand her a set of requirements —
  the road must be level here, must have this gradient there, must
  pass through those two points — and the formula is the answer, not
  the question.

  The technique is uniform and almost mechanical. Each condition
  becomes an equation; the equations form a system; solving the system
  gives the coefficients. The only genuine skill is the translation
  step, and it is worth doing slowly until it is automatic.
]

#epigraph(by: "Carl Gustav Jacob Jacobi")[
  Invert, always invert.
]

#objectives(
  bfkm[translate geometric conditions on a graph into equations in the
    coefficients of a function],
  [determine how many conditions are needed to pin down a polynomial
    of given degree, and recognize when a problem is
    under- or over-determined],
  bfkm[set up and solve the resulting system of equations to find the
    function],
  [read the equation of a polynomial off its graph, using zeros and
    multiplicities],
  [describe how a family of curves changes as its parameter varies,
    and determine the path traced by a distinguished point],
)

== The Translation Dictionary

#only-theory[
  Every condition you will meet is one of about eight, and each one
  says something about $f$, $f'$ or $f''$ at a particular value of
  $x$. Learn the table and the problems become bookkeeping.
]

#keybox(title: "From geometry to equations")[
  #align(center, table(
    columns: 2,
    align: (left, left),
    stroke: 0.5pt + luma(180),
    inset: 7pt,
    [*The graph #h(0pt)$#h(0pt)dots.h$*], [*gives the equation(s)*],

    [passes through $(p, q)$], [$f(p) = q$],
    [has a zero at $x = p$], [$f(p) = 0$],
    [has slope $m$ at $x = p$], [$f'(p) = m$],
    [has a horizontal tangent at $x = p$], [$f'(p) = 0$],
    [has a local extremum at $(p, q)$], [$f(p) = q$ and $f'(p) = 0$],
    [has a point of inflection at $(p, q)$], [$f(p) = q$ and $f''(p) = 0$],
    [touches the $x$\u{2011}axis at $x = p$], [$f(p) = 0$ and $f'(p) = 0$],
    [has the tangent $y = m dot x + b$ at $x = p$],
    [$f(p) = m dot p + b$ and $f'(p) = m$],
  ))
]

#warning[
  Two entries in that table are worth reading twice.

  A *local extremum at $(p, q)$* is two conditions, not one. Students
  routinely write $f'(p) = 0$ and forget that the problem also told
  them the height. The same applies to a point of inflection.

  *"Touches the $x$\u{2011}axis* — or "the $x$-axis is tangent
  to the curve" — is also two conditions: the graph is at height zero
  *and* travelling horizontally. A zero on its own is only one.
]

#remark[
  A condition that is not on the list, because it is of a different
  kind: *symmetry*. "The graph is symmetric about the
  $y$\u{2011}axis does not produce an equation to be solved. It
  eliminates unknowns before you start, by killing every odd power.
  Applied to a general quartic $a x^4 + b x^3 + c x^2 + d x + e$ it
  removes $b$ and $d$ outright, leaving three unknowns rather than
  five. Always apply symmetry first — it is free.
]

== How Many Conditions Do I Need?

#only-theory[
  A polynomial of degree $n$,
  $ p(x) = a_n x^n + a_(n-1) x^(n-1) + dots.h + a_1 x + a_0, $
  has $n + 1$ coefficients. Every condition from the table above
  produces one linear equation in those coefficients. So:

  #align(center, emph[
    a polynomial of degree $n$ needs exactly $n + 1$ conditions.
  ])

  A cubic needs four, a quartic five. Fewer conditions leave a family
  of solutions; more conditions usually leave none, unless some of
  them repeat information already given.

  Counting first is worth the ten seconds. If you have set up three
  equations for a cubic, you have missed a condition — go back and
  find it before solving anything.
]

=== How Big a System Can You Actually Solve?

#only-basic[
  The linear-system solver on the *TI-30X Pro MathPrint* handles
  systems in at most *three* unknowns. A quartic has five coefficients,
  so for anything beyond a cubic the calculator will not take the
  system as it stands.

  This is less of an obstacle than it looks, because well-posed
  problems almost always hand you one or two coefficients for free.
  Look for these before reaching for the calculator:

  - A condition at $x = 0$ isolates a single coefficient. $f(0) = q$
    reads off the constant term; $f'(0) = m$ reads off the linear
    coefficient; $f''(0) = 0$ reads off the quadratic one. Every power
    with $x$ in it vanishes, so nothing else survives.
  - *Symmetry* deletes every odd (or even) coefficient outright.
  - Two conditions that are *mirror images* — at $x = p$ and $x = -p$
    — usually collapse when added or subtracted, because the odd-power
    terms cancel in one combination and the even-power terms in the
    other.

  In practice, spend a minute reducing by hand and the remainder is
  almost always $3 times 3$ or smaller.
]

#only-high[
  The `solve()` command on the *TI-Nspire CAS* will handle a linear
  system of any size you are likely to write down, so technical
  feasibility is not a constraint for you: set up all five equations
  for a quartic and let the machine grind.

  Reducing by hand first is still worth doing, and not out of
  virtue. A condition at $x = 0$ isolates a single coefficient
  ($f(0)$ gives the constant term, $f'(0)$ the linear one, $f''(0)$
  the quadratic one, since every term with $x$ in it vanishes), and
  symmetry deletes half the unknowns before you start. Each such
  reduction is also a *check*: if the value it hands you contradicts
  something you get later, you have found an error early and cheaply
  rather than at the end of a five-by-five solve.
]

#warning[
  Whichever machine you are using, the system it solves is only as
  good as the translation you fed it. A calculator will happily solve
  an under-determined system by returning a family, or an
  over-determined one by returning nothing, and neither output tells
  you which condition you mistranslated. Count first, solve second,
  and substitute your answer back into the *original* conditions at
  the end.
]

#example(title: "Counting, then solving")[
  Find the polynomial of degree $4$ that is symmetric about the
  $y$\u{2011}axis, passes through $A = (0, 2)$, and has a local
  minimum at $B = (1, 0)$.

  *Count.* Degree $4$ means five coefficients. Symmetry kills two of
  them, leaving three: $p(x) = a x^4 + b x^2 + c$. The remaining
  conditions are $p(0) = 2$, $p(1) = 0$ and $p'(1) = 0$ — three
  equations, three unknowns. The problem is exactly determined.

  *Translate.* With $p'(x) = 4 a x^3 + 2 b x$:
  $ #system(($c$, $2$), ($a + b + c$, $0$), ($4 a + 2 b$, $0$)) $

  *Solve.* The last equation gives $b = -2 a$. Substituting into the
  second with $c = 2$: $a - 2 a + 2 = 0$, so $a = 2$ and $b = -4$.
  $ p(x) = 2 x^4 - 4 x^2 + 2. $

  *Check.* $p(1) = 2 - 4 + 2 = 0$ and $p'(1) = 8 - 8 = 0$. And since
  $p(x) = 2 dot (x^2 - 1)^2$, the graph touches the axis at
  $x = plus.minus 1$ — the symmetry has handed us a second minimum for
  free, which was never asked for but had to be there.
]

=== Exercises

#ex(
  difficulty: 2,
  time: "25 min",
  calculator: false,
  hints: (
    [Write down the general cubic and its first two derivatives before
      reading the conditions. Then take the conditions one at a time.],
    [Count your equations before you solve. If you have fewer than
      four, you have missed something.],
  ),
)[
  Write down the system of equations that must be solved to determine a
  polynomial $p$ of degree $3$ with the given properties. You need not
  solve the systems. The four parts are independent of one another.
  #auto-parts(
    1,
    [The points $P_1 = (0, 1)$, $P_2 = (1, 0)$, $P_3 = (-1, -4)$ and
      $P_4 = (2, -1)$ lie on $p$.],
    [$M_1 = (1, 5)$ is a local maximum and $M_2 = (-1, 1)$ is a local
      minimum.],
    [$I = (0, 3)$ is a point of inflection, and the tangent at
      $P = (2, 9)$ has slope $11$.],
    [The $x$\u{2011}axis is tangent to the curve at the origin, and the
      tangent at $Q = (3, 9)$ passes through the origin.],
  )
][
  Throughout, $p(x) = a x^3 + b x^2 + c x + d$, so
  $p'(x) = 3 a x^2 + 2 b x + c$ and $p''(x) = 6 a x + 2 b$.

  #auto-parts(
    1,
    [$
      #system(
        ($d$, $1$),
        ($a + b + c + d$, $0$),
        ($-a + b - c + d$, $-4$),
        ($8 a + 4 b + 2 c + d$, $-1$),
      )
    $],
    [Each extremum gives two equations — the height and the horizontal
      tangent:
      $
        #system(
          ($a + b + c + d$, $5$),
          ($-a + b - c + d$, $1$),
          ($3 a + 2 b + c$, $0$),
          ($3 a - 2 b + c$, $0$),
        )
      $],
    [The inflection point gives $p(0) = 3$ and $p''(0) = 0$; the
      tangent gives $p(2) = 9$ and $p'(2) = 11$:
      $
        #system(
          ($d$, $3$),
          ($2 b$, $0$),
          ($8 a + 4 b + 2 c + d$, $9$),
          ($12 a + 4 b + c$, $11$),
        )
      $],
    [Tangency to the $x$\u{2011}axis at the origin gives
      $p(0) = 0$ and $p'(0) = 0$. For the second condition, the tangent
      at $Q$ is $y = p(3) + p'(3) dot (x - 3)$; requiring it to pass
      through $(0, 0)$ gives $p(3) - 3 dot p'(3) = 0$, and with
      $p(3) = 9$ this says $p'(3) = 3$:
      $
        #system(
          ($d$, $0$),
          ($c$, $0$),
          ($27 a + 9 b$, $9$),
          ($27 a + 6 b$, $3$),
        )
      $],
  )

  #heuristic("introduce notation")

  Part (d) is the only one where a condition does not translate
  directly, and the move worth remembering is to *write down the
  tangent line as an object* and then impose the requirement on it.
  For the curious: solving (d) gives $b = 2$ and $a = -1/3$, so
  $p(x) = -x^3 / 3 + 2 x^2$.
]

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: true,
  hints: (
    [Five unknowns, so five conditions. One of them is at $x = 0$ and
      therefore gives you a coefficient outright.],
    [That still leaves four unknowns. Subtract one equation from
      another to eliminate the constant term as well — the remaining
      three-by-three system is one your calculator will take.],
  ),
)[
  A polynomial $f$ of degree $4$ has a horizontal tangent at $x = 0$, a
  local minimum at $M = (1, 0)$, and the tangent at $x = 2$ has the
  equation $y = 24 x - 39$. Find $f$.
][
  Five coefficients, so five conditions are needed:
  $f'(0) = 0$; $f(1) = 0$; $f'(1) = 0$; $f(2) = 9$ (since
  $24 dot 2 - 39 = 9$); and $f'(2) = 24$. That is exactly five.

  Writing $f(x) = a x^4 + b x^3 + c x^2 + d x + e$, the condition
  $f'(0) = 0$ gives $d = 0$ immediately — the only term of $f'$ without
  a factor of $x$ is the constant $d$. That leaves four unknowns:
  $
    #system(
      ($a + b + c + e$, $0$),
      ($4 a + 3 b + 2 c$, $0$),
      ($16 a + 8 b + 4 c + e$, $9$),
      ($32 a + 12 b + 4 c$, $24$),
    )
  $
  Subtracting the first equation from the third removes $e$ as well,
  giving $15 a + 7 b + 3 c = 9$. Together with the second and fourth
  equations this is a three-by-three system in $a$, $b$, $c$, which
  solves to $a = 1$, $b = 0$, $c = -2$; the first equation then gives
  $e = 1$.
  $ f(x) = x^4 - 2 x^2 + 1 = (x^2 - 1)^2. $

  *Check.* $f'(x) = 4 x^3 - 4 x$, so $f'(0) = 0$ and $f'(1) = 0$ with
  $f(1) = 0$. At $x = 2$: $f(2) = 9$ and $f'(2) = 32 - 8 = 24$, giving
  the tangent $y = 9 + 24(x - 2) = 24 x - 39$. As in the worked
  example, the answer turns out to be a perfect square and has a
  second minimum at $x = -1$ that nobody asked for.
]

== Reading a Function Off Its Graph

#only-theory[
  When the conditions arrive as a picture rather than as a list, the
  fastest route is usually not a system of equations at all. Use the
  factored form from the first chapter: read off the zeros and their
  multiplicities, which fixes everything except the leading
  coefficient, and then use one further point to fix that.


  #fig(
    plot-graph(
      x => 0.25 * calc.pow(calc.pow(x, 2) - 4, 2),
      xmin: -3.5,
      xmax: 3.5,
      ymin: -1.5,
      ymax: 6.5,
      grid-step: 1,
      width: 8,
      height: 5,
    ),
    caption: [Graph (a).],
  )

  #fig(
    plot-graph(
      x => x * (x - 2),
      xmin: -2.5,
      xmax: 4.5,
      ymin: -2.5,
      ymax: 4.5,
      grid-step: 1,
      width: 8,
      height: 5,
    ),
    caption: [Graph (b).],
  )

  #fig(
    plot-graph(
      x => 0.25 * calc.pow(x + 2, 3) * (x - 1),
      xmin: -3.5,
      xmax: 1.5,
      ymin: -4.5,
      ymax: 6.5,
      grid-step: 1,
      width: 8,
      height: 5,
    ),
    caption: [Graph (c).],
  )

  #fig(
    plot-graph(
      x => -0.5 * calc.pow(x + 1, 2) * (x - 3),
      xmin: -2.5,
      xmax: 4.5,
      ymin: -4.5,
      ymax: 6.5,
      grid-step: 1,
      width: 8,
      height: 5,
    ),
    caption: [Graph (d).],
  )
]

#ex(
  difficulty: 2,
  time: "20 min",
  calculator: false,
  hints: (
    [At each zero, decide first whether the graph crosses or bounces.
      That gives the parity of the multiplicity, and the flatness of
      the crossing usually settles the rest.],
    [Once the factors are fixed, substitute one convenient point — the
      $y$\u{2011}intercept is usually easiest — to find the
      leading coefficient.],
  ),
)[
  Determine the equation of each of the four graphed functions. In each
  case the function is a polynomial of *minimal* degree consistent with
  the picture.
][
  #auto-parts(
    1,
    [Double zeros at $x = plus.minus 2$ (the graph bounces at both), so
      degree $4$ and $f(x) = a dot (x - 2)^2 dot (x + 2)^2$. The
      $y$\u{2011}intercept is $4$, so $a dot 16 = 4$ and
      $a = 1/4$:
      $ f(x) = 1/4 dot (x^2 - 4)^2. $],
    [Simple zeros at $0$ and $2$, opening upwards, with minimum
      $(1, -1)$. So $f(x) = a dot x dot (x - 2)$ with
      $a dot 1 dot (-1) = -1$, giving $a = 1$:
      $ f(x) = x dot (x - 2). $],
    [A flat crossing at $x = -2$ — a triple zero — and a simple zero
      at $x = 1$, so degree $4$ and
      $f(x) = a dot (x + 2)^3 dot (x - 1)$. The
      $y$\u{2011}intercept is $-2$, so $a dot 8 dot (-1) = -2$
      and $a = 1/4$:
      $ f(x) = 1/4 dot (x + 2)^3 dot (x - 1). $],
    [A bounce at $x = -1$ and a crossing at $x = 3$, with both ends
      falling, so degree $3$ with a negative leading coefficient:
      $f(x) = a dot (x + 1)^2 dot (x - 3)$. The
      $y$\u{2011}intercept is $3/2$, so $a dot 1 dot (-3) = 3/2$
      and $a = -1/2$:
      $ f(x) = -1/2 dot (x + 1)^2 dot (x - 3). $],
  )

  Note how little work this was compared with setting up four or five
  simultaneous equations. The multiplicities carry almost all the
  information; only the leading coefficient needs a point.
]

== Rational Functions with Unknown Coefficients

#only-theory[
  The same method works when the unknowns sit inside a quotient. The
  one extra step is worth taking every time: *rewrite the function so
  that differentiating it is easy*. Splitting the fraction term by
  term usually turns a quotient rule problem into a power rule
  problem.
]

#ex(
  difficulty: 3,
  time: "15 min",
  calculator: false,
  hints: (
    [Split the fraction into two terms before differentiating. The
      quotient rule is legal here and much slower.],
    ["Has a maximum or minimum at $P$" is two conditions: the point
      lies on the graph, and the tangent there is horizontal.],
  ),
)[
  Determine $a$ and $b$ so that the graph of
  $ f: y = (a dot x^2 + 1) / (b dot x) $
  has a local maximum or minimum at $P = (2, 1)$.
][
  Split the fraction first:
  $
    f(x) = a/b dot x + 1/(b dot x), quad "so" quad
    f'(x) = a/b - 1/(b dot x^2).
  $

  The horizontal tangent gives $f'(2) = 0$:
  $ a/b - 1/(4 b) = 0 quad ==> quad a = 1/4, $
  since $b eq.not 0$ may be cancelled. The point condition
  $f(2) = 1$ gives
  $ (4 a + 1) / (2 b) = 1 quad ==> quad 4 a + 1 = 2 b, $
  and with $a = 1/4$ this is $2 = 2 b$, so $b = 1$.

  Substituting back:
  $ f(x) = (1/4 dot x^2 + 1) / x = x/4 + 1/x. $

  *Check.* $f(2) = 1/2 + 1/2 = 1$, and $f'(x) = 1/4 - 1/x^2$ vanishes
  at $x = 2$. Since $f''(x) = 2 slash x^3$ is positive there, the
  stationary point is a local *minimum* — the problem said "maximum or
  minimum" precisely because which one it is only emerges at the end.
]

#ex(
  difficulty: 3,
  time: "20 min",
  calculator: false,
  hints: (
    [Divide through by $x^2$ term by term. The result has only powers
      of $x$ in it.],
    [Three unknowns need three conditions. The problem gives you a
      point, a slope at that point, and a zero — count them.],
  ),
)[
  Determine $a$, $b$ and $c$ so that the graph of
  $ f: y = (x^3 + a dot x^2 + b dot x + c) / x^2 $
  has slope $m = -1$ at $P = (-1, -2)$ and meets the
  $x$\u{2011}axis at $x = 1$.
][
  Divide term by term:
  $
    f(x) = x + a + b/x + c/x^2, quad
    f'(x) = 1 - b/x^2 - (2 c)/x^3.
  $

  The three conditions:
  $
    #system(
      ($-1 + a - b + c$, $-2$),
      ($1 - b + 2 c$, $-1$),
      ($1 + a + b + c$, $0$),
    )
  $
  Subtracting the first equation from the third gives $2 b = 0$, so
  $b = 0$. The second then gives $2 c = -2$, so $c = -1$, and the third
  gives $a = 0$.
  $ f(x) = (x^3 - 1) / x^2. $

  *Check.* $f(-1) = (-1 - 1)/1 = -2$; $f'(x) = 1 + 2/x^3$ gives
  $f'(-1) = 1 - 2 = -1$; and $f(1) = 0$.
]

== Families of Curves

#only-theory[
  Sometimes we do not want to pin the parameter down at all. Leaving it
  free turns a single function into a whole
  #vocab("family of curves", "Kurvenschar") — one curve for each value
  of the parameter — and the interesting questions become questions
  about the family as a whole.
]

#example(title: "A family of parabolas")[
  Consider
  $ f_t: y = x^2 + 2 dot t dot x + 4, $
  one parabola for each real $t$. What does $t$ control?

  *Zeros.* Solving $x^2 + 2 t x + 4 = 0$ gives
  $ x = -t plus.minus sqrt(t^2 - 4), $
  so the curve has two zeros when $|t| > 2$, one when $|t| = 2$, and
  none when $|t| < 2$. A single parameter switches the graph between
  three qualitatively different pictures.

  *Vertex.* Since $f_t'(x) = 2 x + 2 t$, the vertex sits at $x = -t$,
  where
  $ y = t^2 - 2 t^2 + 4 = 4 - t^2. $
  So the vertex of the parabola labelled $t$ is the point
  $(-t, 4 - t^2)$.

  *And now the good question.* As $t$ runs through all real numbers,
  that vertex moves. Along what path? Setting $x = -t$, so $t = -x$,
  and substituting into the height:
  $ y = 4 - x^2. $
  The vertices of this family of parabolas trace out — another
  parabola. Every member of the family has its lowest point on that
  single curve.
]

#only-theory[
  Both GeoGebra and the TI-Nspire will draw a family with a
  #vocab("slider", "Schieberegler") for the parameter, and GeoGebra's
  *trace* feature will leave the previous curves on screen as you drag
  it, producing the picture of the whole family at once. Use it to form
  a conjecture; then confirm the conjecture algebraically, as above.
  The picture will not tell you that the locus is exactly $4 - x^2$
  rather than something very like it.
]

=== Exercises

#ex(
  difficulty: 2,
  time: "20 min",
  calculator: false,
  hints: (
    [Differentiate with the product rule, then factor $f'$ completely.
      Both stationary points come out in terms of $a$.],
    [For the locus, express $a$ in terms of the $x$\u{2011}coordinate
      of the point, then substitute into its $y$\u{2011}coordinate.],
  ),
)[
  Consider the family
  $ f_a: y = x dot (x - a)^2, quad a > 0. $
  #auto-parts(
    1,
    [Find the zeros of $f_a$ and their multiplicities.],
    [Find both stationary points in terms of $a$ and classify them.],
    [Determine $a$ so that $f_a$ has a local maximum at $x = 3$.],
    [As $a$ varies over all positive values, the local maximum traces
      out a curve. Find its equation.],
  )
][
  #auto-parts(
    1,
    [A simple zero at $x = 0$ and a double zero at $x = a$. The graph
      crosses at the origin and bounces at $a$.],
    [By the product rule,
      $
        f_a'(x) = (x - a)^2 + x dot 2 dot (x - a)
        = (x - a) dot (3 x - a),
      $
      so the stationary points are $x = a/3$ and $x = a$. Since
      $a > 0$ we have $a/3 < a$, and the sign of $f_a'$ runs
      $+, -, +$ across them: a local maximum at $x = a/3$ and a local
      minimum at $x = a$ (which is the double zero, at height $0$).],
    [$a/3 = 3$, so $a = 9$.],
    [The maximum is at $x = a/3$, where
      $
        y = a/3 dot (a/3 - a)^2 = a/3 dot (4 a^2)/9
        = (4 a^3)/27.
      $
      From $x = a/3$ we get $a = 3 x$, and substituting:
      $ y = (4 dot 27 x^3)/27 = 4 x^3. $
      So every local maximum in this family lies on the cubic
      $y = 4 x^3$.],
  )

  #heuristic("introduce notation")
]

#ex(difficulty: 3, time: "15 min", calculator: false, level: "high")[
  Determine $a$ and $b$ so that the graph of
  $ f: y = a dot sin(2 x) + b dot cos(x) $
  has slope $m = 5$ at the point $P = (pi/6, sqrt(3))$.
][
  Two conditions, two unknowns. The point condition:
  $
    f(pi/6) = a dot sin(pi/3) + b dot cos(pi/6)
    = a dot sqrt(3)/2 + b dot sqrt(3)/2 = sqrt(3),
  $
  so $a + b = 2$ after dividing by $sqrt(3)/2$.

  The slope condition, with
  $f'(x) = 2 a dot cos(2 x) - b dot sin(x)$:
  $ f'(pi/6) = 2 a dot 1/2 - b dot 1/2 = a - b/2 = 5. $

  Subtracting the first equation from the second gives
  $-3 b slash 2 = 3$, so $b = -2$ and $a = 4$.
  $ f(x) = 4 dot sin(2 x) - 2 dot cos(x). $

  Both trigonometric values were the standard ones from the unit
  circle; the only thing that could go wrong here is the chain rule
  factor $2$ in the derivative of $sin(2 x)$.
]

#ex(difficulty: 3, time: "18 min", calculator: false, level: "high")[
  Consider the family
  $ f_t: y = x^3 - 3 dot t^2 dot x, quad t > 0. $
  #auto-parts(
    1,
    [Show that every member of the family is an odd function.],
    [Find the two stationary points in terms of $t$ and classify
      them.],
    [Find the equation of the curve traced by the local maxima, and of
      the curve traced by the local minima, as $t$ varies.],
    [Show that every member of the family has its point of inflection
      at the same place, whatever $t$ is.],
  )
][
  #auto-parts(
    1,
    [$f_t(-x) = -x^3 + 3 t^2 x = -f_t(x)$: both terms are odd powers
      of $x$, and $t$ appears only as a coefficient.],
    [$f_t'(x) = 3 x^2 - 3 t^2 = 3 dot (x - t) dot (x + t)$, so the
      stationary points are $x = plus.minus t$. Since
      $f_t''(x) = 6 x$, we get $f_t''(-t) = -6 t < 0$ — a local
      maximum — and $f_t''(t) = 6 t > 0$ — a local minimum.],
    [At $x = -t$: $y = -t^3 + 3 t^3 = 2 t^3$. From $x = -t$ we get
      $t = -x$, so $y = 2 dot (-x)^3 = -2 x^3$. The maxima lie on
      $y = -2 x^3$.

      At $x = t$: $y = t^3 - 3 t^3 = -2 t^3$, and $t = x$ gives
      $y = -2 x^3$ again. Both loci are the *same* curve — which the
      oddness of every $f_t$ makes inevitable, since the maximum and
      minimum of each member are reflections of one another through
      the origin.],
    [$f_t''(x) = 6 x$ vanishes only at $x = 0$, with a sign change,
      and $f_t(0) = 0$ for every $t$. So the origin is a point of
      inflection for every member of the family — the whole array of
      curves passes through it, and does so with slope $-3 t^2$,
      which is the only thing $t$ still controls there.],
  )
]

#ai-box(role: "Checker")[
  Set up the system for one part of the four-part cubic exercise
  yourself, then ask an AI assistant to set up the same system and
  compare equation by equation before comparing answers.

  Two specific things to watch. First, does it produce the right
  *number* of equations? A missing condition is much easier to miss in
  someone else's work than a wrong one. Second, give it part (d) — the
  tangent at $Q$ passing through the origin — which is the only
  condition in the set that does not translate directly from the
  table. If it writes $p(3) = 9$ and $p'(3) = 9 slash 3$, ask it to
  justify the second equation; the correct route is through the
  equation of the tangent line.
]

#print-hints()
#print-vocab()
