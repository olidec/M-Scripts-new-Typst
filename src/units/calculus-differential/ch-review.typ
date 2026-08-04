#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Review and Synthesis")
#let ex = exercise.with(chapter: "Review and Synthesis")

// ── TEACHER'S NOTE ───────────────────────────────────────────
// §4 is INTERLEAVED practice and its value depends entirely on the
// technique not being announced. Every exercise set earlier in the
// unit sits under a heading that names the rule, so students have
// spent ten weeks being told which tool to reach for; the research
// (Rohrer, Bjork) is consistent that this inflates in-lesson
// performance and depresses retention. Do not sort these by type, do
// not add sub-headings, and resist the urge to help when a student
// asks "is this a product rule one?" — working that out IS the
// exercise.
//
// §5 takes only the DIFFERENTIATION parts of the old notes' final
// examination questions:
//   * old Ex 100 — part (a) only; (b) and (c) are areas.
//   * old Ex 101 — part (a) only; (b) is an area ratio.
//   * old Ex 102 — part (a) only; (b) and (c) are an area and a
//     solid of revolution.
// The omitted parts are not lost: they belong in the review chapter
// of the calculus-integral unit, where the same three questions can
// be posed COMPLETE. That is a better use of them than splitting each
// question across two years, and it also gives next year's review a
// ready-made set of genuine Matura questions.

= Review and Synthesis

#only-theory[
  This unit began with a speedometer and a contradiction: a rate at an
  instant, when no time passes and no distance is covered. It ends
  with a method that answers questions no amount of algebra could
  reach — where a curve turns, how a shape should be proportioned to
  waste the least material, which route across a field is quickest.

  What made that possible was a single new idea, applied over and over.
  Everything between those two points was either a way of computing the
  derivative or a way of reading it.
]

#objectives(
  [state the definition of the derivative and explain what it
    measures, in both the geometric and the rate reading],
  [differentiate any function assembled from the elementary functions,
    choosing the appropriate rule without being told which],
  [carry out a complete curve discussion and interpret every feature
    of the result],
  [set up and solve an optimization problem from a verbal
    description],
  [determine a function from conditions on its graph],
)

== The Shape of the Unit

#only-theory[
  Four movements, and it is worth being able to say what each was for.

  *Preparation* (chapters 1–3). Domain, symmetry, polynomial shape,
  limits, asymptotes. None of this was calculus; all of it was
  vocabulary the calculus would need. The limits chapter in particular
  was not an end in itself — it existed so that a quotient which is
  $0 slash 0$ at the point of interest could be given a value.

  *The idea* (chapters 4–5). Average rate of change, the shrinking
  interval, the difference quotient, and finally
  $f'(x) = lim_(h -> 0) (f(x + h) - f(x)) slash h$. Chapter 4 built the
  picture with no formula; chapter 5 supplied the formula. That order
  was deliberate and it is the order you should recall the material
  in.

  *The machinery* (chapters 6–7). Four rules and a table. Nobody
  computes a derivative from the definition once these exist — but
  every one of them was *derived* from the definition, and if you ever
  forget one, that is where it lives.

  *The uses* (chapters 8–10). Reading a graph off a formula; finding a
  formula from a graph; and finding the best. This is where the unit
  was heading all along.
]

== One Page

#keybox(title: "The definition")[
  $ f'(x) = lim_(h -> 0) (f(x + h) - f(x)) / h $
  — the slope of the tangent at $x$, and the instantaneous rate of
  change of $f$ at $x$. Differentiable implies continuous; the
  converse is false.
]

#keybox(title: "The elementary derivatives")[
  #align(center, table(
    columns: 4,
    align: (center, center, center, center),
    stroke: 0.5pt + luma(180),
    inset: 7pt,
    [$f(x)$], [$f'(x)$], [$f(x)$], [$f'(x)$],
    [$x^n$], [$n dot x^(n-1)$], [$sin(x)$], [$cos(x)$],
    [$e^x$], [$e^x$], [$cos(x)$], [$-sin(x)$],
    [$b^x$], [$b^x dot ln(b)$], [$tan(x)$], [$1 slash cos^2(x)$],
    [$ln(x)$], [$1 slash x$], [$c$], [$0$],
  ))
]

#keybox(title: "The four rules")[
  $ (u + v)' &= u' + v' \
    (c dot u)' &= c dot u' \
    (u dot v)' &= u' dot v + u dot v' \
    (u / v)' &= (u' dot v - u dot v') / v^2 \
    (u(v(x)))' &= u'(v(x)) dot v'(x) $
]

#keybox(title: "The tests")[
  - $f' > 0$ on an interval: increasing. $f' < 0$: decreasing.
  - $f'(x_0) = 0$: stationary point. *Necessary for an extremum at a
    differentiable point, never sufficient.*
  - Sign of $f'$ across $x_0$: $+ -> -$ maximum, $- -> +$ minimum, no
    change saddle. *Never fails.*
  - $f''(x_0) < 0$ maximum, $> 0$ minimum, $= 0$ *no information*.
  - $f'' > 0$: concave up. $f'' < 0$: concave down.
  - $f''(x_0) = 0$ *and* $f''$ changes sign there: point of
    inflection.
  - Global extrema on $[a, b]$: compare $f$ at every stationary point
    *and* at both endpoints.
  - Tangent at $x_0$: #h(0.4em)
    $y = f(x_0) + f'(x_0) dot (x - x_0)$. Normal: slope
    $-1 slash f'(x_0)$.
]

== The Thread: Algebra and Geometry

#only-theory[
  One idea has run under this whole unit, as it runs under the whole
  course: *an algebraic statement and a geometric statement are the
  same statement*. Everything you learned to compute was, at the same
  time, something you learned to see.

  The table below is the unit in one picture. Read it left to right to
  turn a picture into an equation — which is what the inverse-problems
  chapter asked of you. Read it right to left to turn an equation into
  a picture — which is what curve analysis asked.
]

#keybox(title: "Translating both ways")[
  #align(center, table(
    columns: 3,
    align: (left, left, left),
    stroke: 0.5pt + luma(180),
    inset: 6pt,
    [*Algebraically*], [*Geometrically*], [*Where it appeared*],

    [$f(x_0) = 0$], [the graph meets the $x$\u{2011}axis at $x_0$],
    [factored form, ch. 1],

    [$f(-x) = f(x)$], [symmetric about the $y$\u{2011}axis],
    [symmetry, ch. 1],

    [$lim_(x -> oo) f(x) = b$], [the graph flattens towards $y = b$],
    [asymptotes, ch. 3],

    [$f'(x_0) = m$], [the tangent at $x_0$ has slope $m$],
    [the derivative, ch. 5],

    [$f'(x) > 0$], [the graph rises], [monotonicity, ch. 8],

    [$f'(x_0) = 0$], [the tangent at $x_0$ is horizontal],
    [stationary points, ch. 8],

    [$f''(x) > 0$], [the graph bends upwards], [concavity, ch. 8],

    [$f''$ changes sign at $x_0$], [the graph stops bending one way
      and starts bending the other], [inflection, ch. 8],

    [$f'(x_0)$ does not exist], [a corner, a cusp, or a break],
    [differentiability, ch. 4],
  ))
]

#remark[
  Notice which column you find easier to work in. Most students are
  faster left to right and slower right to left, because school
  algebra trains one direction far harder than the other. If that is
  you, the fix is not more differentiation practice — it is spending
  ten minutes with the middle column covered up, reconstructing it
  from the left.
]

== Mixed Practice

#only-theory[
  Every exercise set so far has appeared under a heading naming the
  technique. Real problems do not arrive labelled, and the skill of
  *choosing* a method is separate from the skill of executing it — and
  much less practised.

  The exercises below are deliberately shuffled. Before touching any
  of them, decide which tool the problem calls for and write that down.
  You will be slower than in the chapter exercises, and you will
  remember more.
]

#ex(
  difficulty: 2,
  time: "30 min",
  calculator: false,
  hints: (
    [For each one, ask the same question as always: what is the last
      operation you would perform, given a number for $x$? That names
      the rule.],
    [Three of the twelve are quicker after rewriting than they are by
      any rule. Look for them before differentiating.],
  ),
)[
  Differentiate. The rules are not in any particular order, and some
  problems need more than one.
  #auto-parts(
    3,
    [$f(x) = x^3 dot ln(x)$],
    [$f(x) = sin(x^2 + 1)$],
    [$f(x) = (2 x - 1) / (x + 3)$],
    [$f(x) = e^(-x^2 / 2)$],
    [$f(x) = sqrt(x) dot (x - 4)$],
    [$f(x) = ln(x/3)$],
    [$f(x) = tan(3 x)$],
    [$f(x) = x / e^x$],
    [$f(x) = (x^2 + 1)^5$],
    [$f(x) = cos^2(x)$],
    [$f(x) = 2^(3 x)$],
    [$f(x) = sin(x) / x^2$],
  )
][
  #auto-parts(
    3,
    [Product: $3 x^2 ln(x) + x^2$],
    [Chain: $2 x dot cos(x^2 + 1)$],
    [Quotient: $7 slash (x + 3)^2$],
    [Chain: $-x dot e^(-x^2 / 2)$],
    [Expand first, $x^(3/2) - 4 x^(1/2)$:
      $3/2 x^(1/2) - 2 x^(-1/2)$],
    [Rewrite first, $ln(x) - ln(3)$: #h(0.4em) $1 slash x$],
    [Chain: $3 slash cos^2(3 x)$],
    [Rewrite as $x dot e^(-x)$, then product:
      $(1 - x) dot e^(-x)$],
    [Chain: $10 x dot (x^2 + 1)^4$],
    [Chain: $-2 sin(x) cos(x) = -sin(2 x)$],
    [Chain with a general base:
      $2^(3 x) dot ln(2) dot 3$],
    [Quotient: $(x cos(x) - 2 sin(x)) slash x^3$],
  )

  Parts (e), (f) and (h) are the three that reward a rewrite. In (f)
  the logarithm law removes the chain rule entirely; in (h) writing
  $e^(-x)$ instead of a denominator turns a quotient into a product
  and saves a squared denominator.
]

#ex(
  difficulty: 3,
  time: "40 min",
  calculator: true,
  hints: (
    [Each part belongs to a different chapter of this unit. Name the
      chapter before starting.],
  ),
)[
  Four unrelated problems.
  #auto-parts(
    1,
    [Find the equation of the tangent to $f(x) = x dot e^x$ at
      $x = 0$, and the equation of the normal there.],
    [A cubic $p$ has a point of inflection at $(0, 2)$, a local
      minimum at $x = 1$, and passes through $(2, 6)$. Find $p$.],
    [A closed cylindrical can is to hold $500$ cm#super[3]. What
      radius minimizes the surface area?],
    [Determine all asymptotes of
      $g(x) = (x^2 + 3 x) slash (x - 1)$, and say whether the graph
      crosses any of them.],
  )
][
  #auto-parts(
    1,
    [*Tangents, ch. 5.* $f(0) = 0$ and
      $f'(x) = e^x + x e^x = (1 + x) e^x$, so $f'(0) = 1$. Tangent
      $y = x$; normal $y = -x$.],
    [*Inverse problems, ch. 9.* Write
      $p(x) = a x^3 + b x^2 + c x + d$. The inflection point gives
      $p(0) = 2$, so $d = 2$, and $p''(0) = 0$, so $2 b = 0$ and
      $b = 0$. The minimum gives $p'(1) = 3 a + c = 0$, and the point
      gives $8 a + 2 c + 2 = 6$, i.e. $4 a + c = 2$. Solving the pair
      $3 a + c = 0$, $4 a + c = 2$ gives $a = 2$ and $c = -6$:
      $ p(x) = 2 x^3 - 6 x + 2. $
      (Check: $p(2) = 16 - 12 + 2 = 6$, and $p''(1) = 12 > 0$, so
      $x = 1$ really is a minimum.)],
    [*Optimization, ch. 10.* With $pi r^2 h = 500$ we get
      $h = 500 slash (pi r^2)$, so
      $ S(r) = 2 pi r^2 + 2 pi r h = 2 pi r^2 + 1000/r, quad r > 0. $
      $S'(r) = 4 pi r - 1000 slash r^2 = 0$ gives
      $r^3 = 250 slash pi$, so $r approx 4.30$ cm and
      $h approx 8.60$ cm. The height is twice the radius — the
      optimal can is exactly as tall as it is wide.],
    [*Asymptotes, ch. 3.* The denominator vanishes at $x = 1$ where
      the numerator is $4 eq.not 0$: vertical asymptote $x = 1$.
      Division gives
      $ (x^2 + 3 x) / (x - 1) = x + 4 + 4/(x - 1), $
      so the oblique asymptote is $y = x + 4$. The graph crosses it
      only where $4 slash (x - 1) = 0$, which never happens — so it
      does not cross.],
  )

  Part (c) is worth remembering as a fact about cans: minimizing metal
  for a fixed volume gives $h = 2 r$. Real drink cans are noticeably
  taller than that, which tells you that metal is not the only thing
  being optimized.
]

== Examination Questions

#only-theory[
  Three questions from past final examinations. Each was originally
  set with further parts requiring integration; those parts return
  next year, when you can answer them.
]

#ex(difficulty: 2, time: "20 min", calculator: false)[
  #emph[(Final examination, 1986.)] Given the function
  $ f: y = x^2 - 1/6 dot x^3. $
  Determine the domain, the zeros, the extrema and the points of
  inflection of the graph of $f$, and sketch it.
][
  Domain $RR$. Zeros: $x^2 dot (1 - x/6) = 0$ gives $x = 0$ (double)
  and $x = 6$.

  $f'(x) = 2 x - x^2/2 = (x dot (4 - x)) / 2$, so the stationary
  points are $x = 0$ and $x = 4$. With $f''(x) = 2 - x$:
  $f''(0) = 2 > 0$, a local minimum at $(0, 0)$; and
  $f''(4) = -2 < 0$, a local maximum at $(4, 16/3)$.

  $f''(x) = 0$ at $x = 2$, with a sign change, so there is a point of
  inflection at $(2, 8/3)$.

  The double zero at the origin is also the local minimum, which is
  exactly what a double zero looks like: the graph touches the axis
  and turns.
]

#ex(
  difficulty: 3,
  time: "20 min",
  calculator: false,
  hints: (
    [$P$ is not on the curve, so it is not the point of tangency. Call
      the point of tangency $(t, f(t))$.],
    [Write the tangent at $t$, impose that it passes through $P$, and
      solve the resulting cubic in $t$. One root is obvious.],
  ),
)[
  #emph[(Final examination, 1987.)] Consider the curve
  $ f: y = x dot (x - 3)^2. $
  Determine every tangent to the curve that passes through
  $P = (1, 9)$.
][
  With $f'(x) = (x - 3)^2 + 2 x dot (x - 3) = 3 dot (x - 3) dot
  (x - 1)$, the tangent at $(t, f(t))$ is
  $ y = t dot (t - 3)^2 + 3 dot (t - 3) dot (t - 1) dot (x - t). $
  Requiring it to pass through $(1, 9)$ and simplifying gives
  $ -t dot (2 t^2 - 9 t + 12) = 0. $
  The quadratic factor has discriminant $81 - 96 < 0$, so the only
  real root is $t = 0$. Since $f(0) = 0$ and $f'(0) = 9$, there is
  exactly *one* such tangent:
  $ y = 9 x. $

  #heuristic("introduce notation")

  A point outside a cubic will usually admit more than one tangent, so
  the answer here is worth a sanity check — plot the curve and the
  line and confirm that $y = 9 x$ touches at the origin and passes
  through $(1, 9)$.
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  #emph[(Adapted from Calculus AP, 2011.)] Let $R$ be the region in
  the first quadrant enclosed by the graphs of $f(x) = 8 x^3$ and
  $g(x) = sin(pi dot x)$. Write an equation for the line tangent to
  the graph of $f$ at $x = 1/2$.
][
  $f(1/2) = 8 dot 1/8 = 1$ and $f'(x) = 24 x^2$, so
  $f'(1/2) = 6$. The tangent is
  $ y = 1 + 6 dot (x - 1/2) = 6 x - 2. $

  The point $(1/2, 1)$ is where the two curves meet, since
  $sin(pi/2) = 1$ as well — which is why the original question
  singled it out. The remaining parts asked for the area of $R$ and
  the volume of the solid obtained by rotating it, and both wait for
  next year.
]

#look-ahead(
  title: "Where this goes next",
  preview: "the integral calculus",
)[
  You have spent this unit going in one direction: from a function to
  its rate of change. Next year runs the other way.

  Given the *rate* at which something changes, can we recover the
  quantity? Given a velocity, the distance travelled? That question
  turns out to have a second, apparently unrelated answer — the area
  under a curve — and the fact that these two are the same problem is
  called the fundamental theorem of calculus. It is the single most
  surprising result in this subject, and it is the reason
  "differential" and "integral" calculus share a name.

  Two things from this unit will be needed on the first day. The chain
  rule, read backwards, becomes the main technique for computing
  integrals. And the observation from chapter 7 — that the power rule
  produces every power except $x^(-1)$, and that $ln$ fills the gap —
  becomes the one line in every integral table that looks like an
  exception.
]

#ai-box(role: "Tutor")[
  Ask an AI assistant to generate a twenty-question mixed review of
  this unit, with instructions that it must *not* group the questions
  by topic and must *not* reveal which technique each one needs. Work
  through them and mark yourself.

  Then, for every question you got wrong, ask the assistant a single
  question: *"what was the earliest step at which I went wrong?"* —
  not "what is the answer". The distinction matters. A wrong answer
  usually has one bad step and several correct ones after it, and the
  correct ones are the ones you will otherwise repeat.
]

#print-hints()
#print-vocab()
