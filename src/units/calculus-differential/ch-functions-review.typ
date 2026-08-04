#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Functions Revisited")
#let ex = exercise.with(chapter: "Functions Revisited")

// ── TEACHER'S NOTE ───────────────────────────────────────────
// This is chapter 1 of the calculus-differential unit and is
// deliberately a *consolidation*, not a re-teach. Everything here has
// been met before except three things, which are genuinely new:
//   * polynomial end behavior, factored form and multiplicity (§4)
//   * composition and, more importantly, DE-composition (§5)
//   * the habit of reading a function's global shape off its formula
// §5 exists because the chain rule later asks students to split a
// function into an outer and an inner part, and the old LaTeX notes
// never taught that split anywhere — the chain rule was the first
// place it appeared, which is one reason it landed badly.
//
// The old §1 "black box / magic happens" figure is not reproduced
// here. The image can be dropped back in at the marked spot if you
// want it; the prose no longer depends on it.
//
// toolbox() is NOT printed in this chapter. If this unit is taught as
// a standalone booklet, add #toolbox() right after the objectives box;
// if it follows another unit in a year binder, leave it out so the
// heuristics list is not printed twice.

= Functions Revisited

#only-theory[
  Everything in this unit is about functions, so it is worth being
  honest about what that means. You have spent two years meeting
  function families one at a time — linear, quadratic, power,
  exponential, logarithmic, trigonometric — and learning what each one
  does. Calculus does something different. It asks questions that make
  sense for *any* function at all: how steeply is it rising here? where
  does it turn around? how much area sits underneath it?

  To ask those questions we need a shared vocabulary that does not
  depend on which family a function belongs to. That vocabulary is
  what this chapter assembles. Most of it you already own. Some of it
  — how the formula of a polynomial predicts the shape of its graph,
  and how to take a complicated function apart into simpler ones — is
  new, and both pieces will be doing heavy work within a few weeks.
]

#epigraph(by: "Alexandre Grothendieck")[
  It is better to have a good understanding of one thing than a
  superficial understanding of many.
]

#objectives(
  bfkm[determine the #vocab("domain", "Definitionsbereich",
    show-de: false) and #vocab("range", "Wertebereich", show-de: false)
    of a function, and explain how you know that nothing has been left
    out],
  bfkm[decide algebraically whether a function is even, odd or neither,
    and say what each answer means for its graph],
  [read the degree, the leading coefficient and the zeros of a
    polynomial off its factored form],
  [predict the end behavior of a polynomial and its behavior at each
    zero, and use both to sketch the graph without plotting points],
  [write down a polynomial in factored form that has prescribed
    zeros, multiplicities and end behavior],
  [split a composite function into an outer and an inner function],
  obj(level: "high")[decide whether a function has an inverse on a
    given interval, and describe that inverse],
)

== The Cast of Characters

#only-theory[
  A quick roll call. Nothing here should be a surprise; the point is to
  have all the names in one place, because from now on we will use them
  without warning.
]

#definition(title: "Function")[
  A #vocab("function", "Funktion") relates each element of one set (the
  #vocab("domain", "Definitionsbereich")) to exactly one element of a
  second set (the #vocab("range", "Wertebereich")).

  We write $f: y = x^2$, or $f(x) = x^2$, where $f$ is the *name* of
  the function. Names are arbitrary labels and carry no mathematical
  content — a function may perfectly well be called $g$, $p$, or Fred.
]

// #fig(image("images/function-black-box.png", width: 60%))

#only-theory[
  A function can be handed to you in several different forms, and part
  of being fluent is not caring which:

  - as an *equation*, $f: y = x^2$;
  - as a *graph*, the set of all points $(x, f(x))$;
  - as a *table of values*;
  - #box[*implicitly*, as the inverse of something else — $y = arcsin(x)$
      says nothing more than "the number whose sine is $x$".]

  Throughout this course we work only with #vocab("real functions",
  "reelle Funktionen"): both the domain and the range are subsets of
  $RR$.
]

#keybox(title: "The families you already know")[
  A #vocab("polynomial", "Polynom") in $x$ is a sum of powers of $x$
  with real coefficients,
  $ p(x) = a_n dot x^n + a_(n-1) dot x^(n-1) + dots.h + a_1 dot x + a_0,
    quad a_i in RR, quad a_n eq.not 0. $
  The largest exponent $n$ is the #vocab("degree", "Grad") of the
  polynomial and $a_n$ is its #vocab("leading coefficient",
  "Leitkoeffizient"). Linear and quadratic functions are the
  polynomials of degree $1$ and $2$; a non-zero constant function has
  degree $0$.

  A #vocab("rational function", "gebrochenrationale Funktion") is a
  quotient of two polynomials, $f(x) = P(x) / Q(x)$.

  An #vocab("exponential function", "Exponentialfunktion") has the form
  $f(x) = b^x$ with $b > 0$, and a #vocab("logarithmic function",
  "Logarithmusfunktion") the form $f(x) = log_b (x)$ with $b > 0$,
  $b eq.not 1$. Each is the inverse of the other.
]

#look-ahead(
  title: "Rational functions get a chapter of their own",
  preview: "asymptotes",
)[
  Rational functions are listed here only so the name is available.
  What makes them interesting — that they can blow up at a point, or
  flatten out towards a line far from the origin — is the subject of a
  later chapter, once we have limits to describe it with.
]

#remark[
  One habit from the functions unit is worth reactivating now. Every
  graph in this chapter is a *transformed copy* of something simpler.
  When you meet $y = -1/4 dot (x - 2)^2$, do not start a table of
  values: read it as the standard parabola $y = x^2$, shifted $2$ units
  right, flipped, and flattened by a factor $1/4$. That reading is
  faster, it is more reliable, and — as you will see in §4 — it is
  exactly what tells you the shape of a polynomial near one of its
  zeros.
]

== Domain and Range

#only-theory[
  The domain of a function is the set of inputs for which the formula
  makes sense. In practice you almost never construct it directly;
  instead you start from $RR$ and *rule things out*. There are only
  three ways an elementary formula can fail:

  + a denominator is zero,
  + a square root (or any even root) has a negative argument,
  + a logarithm has an argument that is zero or negative.

  The range is genuinely harder, and this asymmetry is worth naming.
  The domain is a local question — check each part of the formula.
  The range is a global one: it asks what the function *achieves* over
  its whole domain, which may require knowing where the function turns
  around. That is one of the things calculus is for, and until we have
  it, a sketch plus a little reasoning is the honest method.
]

#example(title: "Domain and range of a root in a denominator")[
  Find the domain and the range of
  $ f: y = 1 / sqrt(x - 8). $

  *Domain.* The root demands $x - 8 gt.eq 0$, and the denominator
  forbids $sqrt(x-8) = 0$. Together: $x - 8 > 0$, so
  $ X = (8, oo). $

  *Range.* The denominator is positive throughout the domain, so every
  value of $f$ is positive. As $x$ grows the denominator grows without
  bound and $f(x)$ approaches $0$ without ever reaching it. As $x$
  approaches $8$ from the right the denominator becomes arbitrarily
  small and $f(x)$ becomes arbitrarily large. Every positive value is
  therefore attained exactly once:
  $ Y = (0, oo). $
]

#warning[
  "Approaches $0$" and "reaches $0$" are different claims, and the
  bracket you write records which one you mean. A round bracket
  excludes the endpoint, a square bracket includes it. Writing
  $Y = [0, oo)$ above would assert that some input makes
  $1 slash sqrt(x-8)$ equal to zero — and no input does.
]

=== Exercises

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Determine the domain of each function. Say in one word which of the
  three failure modes you ruled out.
  #auto-parts(
    3,
    [$y = 1 / (3 x + 2)$],
    [$y = sqrt(3 - x)$],
    [$y = ln(x^2 - 4)$],
  )
][
  #auto-parts(
    3,
    [Denominator: $3 x + 2 eq.not 0$, so $X = RR without {-2/3}$.],
    [Root: $3 - x gt.eq 0$, so $X = (-oo, 3]$.],
    [Logarithm: $x^2 - 4 > 0$, so $X = RR without [-2, 2]$.],
  )
]

#ex(
  difficulty: 2,
  time: "25 min",
  calculator: true,
  hints: (
    [For the rational functions, the value that is missing from the
      range is the one the graph approaches far out to the left and
      right — divide leading coefficients.],
    [For $y = 1 slash (x^2 - 1)$, split the domain at $x = plus.minus 1$
      and ask what $x^2 - 1$ itself can be on each piece.],
  ),
)[
  Determine the domain $X$ and the range $Y$ of each function, then
  confirm your answer with a graph.
  #auto-parts(
    3,
    [$y = x^2 - 4 x + 2$],
    [$y = -(x + 2)^2 - 3$],
    [$y = sqrt(x + 2)$],
    [$y = -3 x^2 + 6 x - 1$],
    [$y = 1 / sqrt(x + 1)$],
    [$y = -1 / (2 - x)$],
    [$y = (1 + 2 x) / (1 - 2 x)$],
    [$y = 1 / (x^2 - 1)$],
    [$y = sqrt(4 - x^2)$],
    [$y = log_(10) (x - 1)$],
    [$y = sin(x) + 1$],
    [$y = 2 dot cos(x - 1)$],
  )
][
  #auto-parts(
    3,
    [$X = RR$, $Y = [-2, oo)$],
    [$X = RR$, $Y = (-oo, -3]$],
    [$X = [-2, oo)$, $Y = [0, oo)$],
    [$X = RR$, $Y = (-oo, 2]$],
    [$X = (-1, oo)$, $Y = (0, oo)$],
    [$X = RR without {2}$, $Y = RR without {0}$],
    [$X = RR without {1/2}$, $Y = RR without {-1}$],
    [$X = RR without {-1, 1}$, $Y = (-oo, -1] union (0, oo)$],
    [$X = [-2, 2]$, $Y = [0, 2]$],
    [$X = (1, oo)$, $Y = RR$],
    [$X = RR$, $Y = [0, 2]$],
    [$X = RR$, $Y = [-2, 2]$],
  )

  Part (h) is the one that rewards care. On $|x| > 1$ the denominator
  runs through all of $(0, oo)$, so the quotient runs through
  $(0, oo)$ as well. On $|x| < 1$ the denominator runs through
  $[-1, 0)$, and the quotient therefore through $(-oo, -1]$ — the
  value $-1$ is attained, at $x = 0$.
]

#ai-box(role: "Checker")[
  Pick three parts of the previous exercise that you found hardest.
  Determine the range yourself, on paper, with a reason for each
  endpoint. Then ask an AI assistant for the range of the same three
  functions and compare — not the answers, the *reasons*. Where the two
  differ, decide which argument actually rules out the disputed value.
  Ranges are a good stress test: models are reliable at domains and
  noticeably less reliable at ranges, and a confident wrong bracket is
  easy to miss.
]

== Symmetry: Even and Odd Functions

#only-theory[
  Two symmetries occur often enough to have names. Both are statements
  about what happens when the input changes sign, and both can be
  checked without drawing anything.
]

#definition(title: "Even and odd functions")[
  A function $f$ is #vocab("even", "gerade") if, for every $x$ in the
  domain, $-x$ is in the domain too and
  $ f(-x) = f(x). $

  A function $f$ is #vocab("odd", "ungerade") if, for every $x$ in the
  domain, $-x$ is in the domain too and
  $ f(-x) = -f(x). $
]

#keybox(title: "What the symmetry looks like")[
  The graph of an even function is symmetric across the
  $y$\u{2011}axis; the graph of an odd function is symmetric
  about the origin — a $180 degree$ rotation about $(0,0)$ leaves it
  unchanged.
]

#remark[
  The names come from polynomials, and for polynomials they are exact:
  a polynomial is even precisely when only even powers of $x$ occur in
  it, and odd precisely when only odd powers occur. Note that a
  constant term $a_0 = a_0 dot x^0$ counts as an even power — which is
  why $f(x) = x^3 + 4 x + 1$ is neither.
]

#warning[
  "Neither" is the normal case. Most functions have no symmetry at all,
  and a function that is not even is not thereby odd. Checking one
  condition never settles the other.
]

=== Exercises

#ex(difficulty: 1, time: "12 min", calculator: false)[
  Decide algebraically whether each function is even, odd or neither.
  Show the computation of $f(-x)$ in each case.
  #auto-parts(
    4,
    [$f(x) = 4 - x^2$],
    [$f(x) = x^3 + 3 x$],
    [$f(x) = -3 / (2 x)$],
    [$f(x) = x^3 + 4 x + 1$],
    [$f(x) = 2 x^3 - 4 x$],
    [$f(x) = 1 / (x^2 + 1)$],
    [$f(x) = x dot (x - 2)$],
    [$f(x) = x - 2 x^3 + x^5$],
  )
][
  #auto-parts(
    4,
    [even],
    [odd],
    [odd],
    [neither],
    [odd],
    [even],
    [neither],
    [odd],
  )

  For (g), expanding gives $x^2 - 2 x$: an even power and an odd power
  together, so neither. For (c) the domain $RR without {0}$ is
  symmetric about $0$, which is what the definition requires.
]

#ex(difficulty: 2, time: "5 min", calculator: false)[
  Find a function that is both even and odd. Is there more than one?
][
  If $f$ is both, then $f(-x) = f(x)$ and $f(-x) = -f(x)$ for every
  $x$, so $f(x) = -f(x)$, hence $2 dot f(x) = 0$ and $f(x) = 0$.

  So the zero function is the only one — with the pedantic caveat that
  the domain must be symmetric about $0$, so strictly there is one such
  function for each symmetric domain.
]

#exploration(title: "An algebra of symmetries")[
  Even and odd behave a little like the even and odd *numbers* do under
  addition and multiplication — but only a little. Test each of the
  following with several examples of your own, form a conjecture, and
  then try to prove it from the definitions. One of the six has no
  clean answer; find out which.

  + The sum of two even functions.
  + The sum of two odd functions.
  + The sum of an even and an odd function.
  + The product of two even functions.
  + The product of two odd functions.
  + The product of an even and an odd function.
]

#ex(
  difficulty: 3,
  time: "15 min",
  calculator: false,
  hints: (
    [Do not use anything about $f$ except its name. Write out $g(-x)$
      by substituting $-x$ into the *definition* of $g$.],
    [$f(-(-x)) = f(x)$ — the inner minus signs cancel.],
  ),
)[
  Let $f$ be any function whose domain is symmetric about $0$, and
  define
  $ g(x) = f(x) + f(-x), quad h(x) = f(x) - f(-x). $
  #auto-parts(
    1,
    [Show that $g$ is even and $h$ is odd.],
    [Show that every such $f$ can be written as the sum of an even
      function and an odd function.],
  )
][
  #auto-parts(
    1,
    [$g(-x) = f(-x) + f(-(-x)) = f(-x) + f(x) = g(x)$, so $g$ is even.

      $h(-x) = f(-x) - f(-(-x)) = f(-x) - f(x) = -h(x)$, so $h$ is
      odd.],
    [Adding the two definitions gives $g(x) + h(x) = 2 dot f(x)$, so
      $ f(x) = 1/2 dot g(x) + 1/2 dot h(x), $
      and a constant multiple of an even function is even, of an odd
      function odd. So every $f$ splits into an even part and an odd
      part.],
  )

  #heuristic("work backwards from the goal")

  Worth noticing: the statement never used what $f$ *is*. This is the
  parameter-name abstraction habit again — the argument holds for
  polynomials, for $e^x$, for anything at all with a symmetric domain.
  Applied to $f(x) = e^x$ it produces the two functions
  $(e^x + e^(-x)) slash 2$ and $(e^x - e^(-x)) slash 2$, which turn out
  to be important enough to have names of their own.
]

== Polynomials: Degree, End Behavior and Multiplicity

#only-theory[
  You know that a polynomial of degree $1$ graphs as a straight line
  and one of degree $2$ as a parabola. What about degree $5$?

  There is no single picture, but there is something almost as good:
  two rules, one about the far left and far right of the graph and one
  about what happens at each zero, which between them pin the shape
  down well enough to sketch it by hand. Both rules read straight off
  the formula.
]

#exploration(title: "Who wins in the long run?")[
  Consider $p(x) = x^3 - 10 x$ and $q(x) = x^3$.

  + Compute both at $x = 1, 2, 3$. Which is larger, and by how much?
  + Now compute both at $x = 10, 100, 1000$. Compute the *ratio*
    $p(x) slash q(x)$ each time.
  + What is the $-10 x$ term doing to the shape of the graph near the
    origin? What is it doing far away from it?
  + Formulate a rule: for very large $|x|$, which term of a polynomial
    decides what the graph does?
]

#keybox(title: "End behavior of a polynomial")[
  For very large $|x|$ the leading term $a_n dot x^n$ dominates every
  other term, so the two ends of the graph are decided by the degree
  $n$ and the sign of the leading coefficient $a_n$ alone:

  #align(center, table(
    columns: 3,
    align: (left, center, center),
    stroke: 0.5pt + luma(180),
    inset: 6pt,
    [], [$a_n > 0$], [$a_n < 0$],
    [*even* degree \ ($n = 2, 4, 6, dots.h$)],
    [both ends rise \ $y -> +oo$ on both sides],
    [both ends fall \ $y -> -oo$ on both sides],

    [*odd* degree \ ($n = 1, 3, 5, dots.h$)],
    [falls left, rises right],
    [rises left, falls right],
  ))
]

#only-theory[
  #image-grid(
    2,
    plot(
      xmin: -2.8, xmax: 2.8, ymin: -2.6, ymax: 2.6,
      width: 6, height: 4,
      axis-x-pos: "center", axis-y-pos: "center",
      xlabel: none, ylabel: none, xtick: (), ytick: (),
      show-origin: false,
      (
        fn: x => 0.2 * calc.pow(x, 4) - x * x,
        domain: (-2.6, 2.6), stroke: blue + 1.3pt,
        label: [even, $a_n > 0$], label-pos: 0.5, label-side: "below",
      ),
    ),
    plot(
      xmin: -2.8, xmax: 2.8, ymin: -2.6, ymax: 2.6,
      width: 6, height: 4,
      axis-x-pos: "center", axis-y-pos: "center",
      xlabel: none, ylabel: none, xtick: (), ytick: (),
      show-origin: false,
      (
        fn: x => -0.2 * calc.pow(x, 4) + x * x,
        domain: (-2.6, 2.6), stroke: red + 1.3pt,
        label: [even, $a_n < 0$], label-pos: 0.5, label-side: "above",
      ),
    ),
    plot(
      xmin: -2.8, xmax: 2.8, ymin: -2.6, ymax: 2.6,
      width: 6, height: 4,
      axis-x-pos: "center", axis-y-pos: "center",
      xlabel: none, ylabel: none, xtick: (), ytick: (),
      show-origin: false,
      (
        fn: x => 0.2 * calc.pow(x, 3) - x,
        domain: (-2.9, 2.9), stroke: blue + 1.3pt,
        label: [odd, $a_n > 0$], label-pos: 0.5, label-side: "below-right",
      ),
    ),
    plot(
      xmin: -2.8, xmax: 2.8, ymin: -2.6, ymax: 2.6,
      width: 6, height: 4,
      axis-x-pos: "center", axis-y-pos: "center",
      xlabel: none, ylabel: none, xtick: (), ytick: (),
      show-origin: false,
      (
        fn: x => -0.2 * calc.pow(x, 3) + x,
        domain: (-2.9, 2.9), stroke: red + 1.3pt,
        label: [odd, $a_n < 0$], label-pos: 0.5, label-side: "above-right",
      ),
    ),
  )

  Only the two ends of each graph are being claimed here. What happens
  in the middle depends on the other coefficients and is not fixed by
  the degree and the leading coefficient alone.
]

#example(title: "Reading the ends off the formula")[
  For $p(x) = -2 x^5 + 3 x^3 - x + 7$ the degree is $5$ (odd) and the
  leading coefficient is $a_5 = -2 < 0$. So the graph comes down from
  the upper left and leaves towards the lower right. The other three
  terms affect only what happens in between.
]

=== Factored Form and Multiplicity

#only-theory[
  A quadratic with zeros $x_1$ and $x_2$ can be written
  $p(x) = a dot (x - x_1) dot (x - x_2)$. The same idea works for any
  degree, with one extra feature: a factor may be repeated.
]

#definition(title: "Factored form and multiplicity")[
  A polynomial with zeros $x_1, x_2, dots.h, x_k$ can be written in
  #vocab("factored form", "Produktform") as
  $ p(x) = a dot (x - x_1)^(m_1) dot (x - x_2)^(m_2) dots.h.c
    (x - x_k)^(m_k), $
  where $a eq.not 0$ and the exponent $m_i gt.eq 1$ is the
  #vocab("multiplicity", "Vielfachheit") of the zero $x_i$. The degree
  of $p$ is the sum of all the multiplicities,
  $n = m_1 + m_2 + dots.h + m_k$.
]

#example(title: "Reading a factored form")[
  Let $p(x) = 1/3 dot x^2 dot (x + 3)$. Written out fully this is
  $p(x) = 1/3 dot (x - 0)^2 dot (x - (-3))^1$, so:

  - a zero at $x = 0$ with multiplicity $2$;
  - a zero at $x = -3$ with multiplicity $1$;
  - degree $2 + 1 = 3$;
  - leading coefficient $1/3 > 0$, since expanding gives
    $1/3 x^3 + dots.h$ — and *only* the leading term needs to be
    checked, not the whole expansion.
]

#only-theory[
  Near one of its zeros a polynomial behaves like the simplest thing it
  could: close to $x_0$, all the other factors are nearly constant, so
  $ p(x) approx c dot (x - x_0)^m $
  for some constant $c$. In other words the local picture at a zero of
  multiplicity $m$ is a shifted, stretched copy of the graph of
  $y = x^m$ — which you have already drawn. Compare the three basic
  shapes:
]

#fig(
  plot-graph(
    (fn: x => x, color: accent),
    (fn: x => calc.pow(x, 2), color: warn-col),
    (fn: x => calc.pow(x, 3), color: key-col),
    xmin: -1.5,
    xmax: 1.5,
    ymin: -1.5,
    ymax: 1.5,
    grid-step: 1,
    width: 8,
    height: 5.5,
  ),
  caption: [
    Multiplicity $1$ ($y = x$), $2$ ($y = x^2$) and $3$ ($y = x^3$)
    near the origin: cross straight, bounce, cross flat.
  ],
)

#keybox(title: "Behavior at a zero")[
  Let $x_0$ be a zero of multiplicity $m$.

  - $m$ *odd* ($1, 3, 5, dots.h$): the graph *crosses* the
    $x$\u{2011}axis at $x_0$.
  - $m$ *even* ($2, 4, 6, dots.h$): the graph *touches* the
    $x$\u{2011}axis and turns back — it *bounces*.

  The larger $m$ is, the flatter the graph lies against the axis just
  before and after $x_0$.
]

#keybox(title: "Sketching a polynomial from factored form")[
  + Read off the zeros and their multiplicities.
  + Add the multiplicities to get the degree.
  + Determine the sign of the leading coefficient.
  + Use degree and sign to fix the end behavior.
  + Mark the zeros; at each one decide *cross* or *bounce*.
  + Join everything up, respecting both the ends and each zero.

  Notice what this procedure never does: evaluate the function. A
  handful of extra points is a useful check, but the shape comes from
  structure, not from a table.
]

#example(title: "A worked sketch")[
  Sketch $p(x) = -1/4 dot (x - 2)^2 dot (x + 3)^2$.

  + Zeros: $x = 2$ with multiplicity $2$, and $x = -3$ with
    multiplicity $2$.
  + Degree $2 + 2 = 4$, which is even.
  + Leading coefficient $-1/4 < 0$.
  + Even degree, negative leading coefficient: *both ends fall*.
  + Both multiplicities are even, so the graph *bounces* at $x = -3$
    and again at $x = 2$.
  + So the graph rises out of $-oo$ on the left, touches the axis at
    $x = -3$ and turns back down, dips to a low point between the two
    zeros, rises to touch the axis again at $x = 2$, and falls away to
    $-oo$.

  A useful sanity check: since $-1/4 < 0$ and both remaining factors
  are squares, $p(x) lt.eq 0$ *everywhere*. The two zeros are therefore
  the highest points of the graph, and the dip between them — at
  $x = -0.5$, by symmetry — is the lowest point in that region, with
  $p(-0.5) = -625/64 approx -9.77$.
]

#fig(plot-graph(
  x => -0.25 * calc.pow(x - 2, 2) * calc.pow(x + 3, 2),
  xmin: -5.5,
  xmax: 4.5,
  ymin: -12.5,
  ymax: 2.5,
  grid-step: 1,
  width: 11,
  height: 7,
))

#warning[
  The last step of the sketching procedure produces a *shape*, not a
  graph with correct heights. Where the low point between two zeros
  actually lies, and how low it goes, is not something factored form
  tells you — except in a symmetric case like the one above, where you
  can get it for free. Finding turning points in general is what the
  derivative is for, and it is the next thing this unit builds.
]

=== Exercises

#ex(difficulty: 1, time: "15 min", calculator: false)[
  For each polynomial determine the zeros with their multiplicities,
  the degree, and the end behavior. Then sketch the graph.
  #auto-parts(
    2,
    [$p(x) = (x - 1) dot (x + 2) dot (x - 3)$],
    [$p(x) = -2 dot (x + 1)^2 dot (x - 2)$],
    [$p(x) = 1/2 dot x^2 dot (x + 3)$],
    [$p(x) = -(x + 1)^3 dot (x - 1)$],
  )
][
  #auto-parts(
    1,
    [Zeros $1, -2, 3$, each of multiplicity $1$ (all crossings);
      degree $3$; leading coefficient $+1$, so the graph falls on the
      left and rises on the right.],
    [Zero $-1$ with multiplicity $2$ (bounce), zero $2$ with
      multiplicity $1$ (crossing); degree $3$; leading coefficient
      $-2$, so the graph rises on the left and falls on the right.],
    [Zero $0$ with multiplicity $2$ (bounce), zero $-3$ with
      multiplicity $1$ (crossing); degree $3$; leading coefficient
      $1/2 > 0$, so it falls left and rises right.],
    [Zero $-1$ with multiplicity $3$ (flat crossing), zero $1$ with
      multiplicity $1$ (crossing); degree $4$; leading coefficient
      $-1$, so both ends fall.],
  )
]

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: false,
  hints: (
    [Build the factors from the zeros first and ignore the constant
      $a$ entirely. Only then ask what sign $a$ must have.],
    [The degree is fixed by the multiplicities, so once the factors are
      chosen the parity of the degree is no longer yours to choose —
      only the sign of $a$ is.],
  ),
)[
  Write down a possible equation in factored form for a polynomial with
  the given properties. In each case, say how many essentially
  different answers there are.
  #auto-parts(
    1,
    [Degree $3$, with zeros at $x = -1$, $x = 0$ and $x = 2$, and the
      graph rising to the right.],
    [Degree $4$, with double zeros at $x = 1$ and $x = -2$, and the
      graph falling on both ends.],
    [Degree $5$, with a triple zero at $x = 0$ and simple zeros at
      $x = -2$ and $x = 3$.],
  )
][
  #auto-parts(
    1,
    [The three zeros are simple and account for the whole degree, so
      $p(x) = a dot x dot (x + 1) dot (x - 2)$. Odd degree rising to
      the right forces $a > 0$; e.g.
      $p(x) = x dot (x + 1) dot (x - 2)$. Any positive $a$ works, so
      there is a one-parameter family — all vertical stretches of the
      same shape.],
    [$p(x) = a dot (x - 1)^2 dot (x + 2)^2$. Even degree falling on
      both ends forces $a < 0$; e.g.
      $p(x) = -(x - 1)^2 dot (x + 2)^2$.],
    [$p(x) = a dot x^3 dot (x + 2) dot (x - 3)$ with any $a eq.not 0$;
      e.g. $p(x) = x^3 dot (x + 2) dot (x - 3)$. Here the end behavior
      was not prescribed, so both signs of $a$ are allowed and there
      are two families.],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Find two polynomials of *different degrees* that both have exactly
  the zeros $x_1 = -1$ and $x_2 = 4$, and whose graphs look
  qualitatively different. Sketch both.
][
  Any two choices of multiplicities work, as long as no new zero is
  introduced. For example
  $ p(x) = -(x + 1) dot (x - 4) quad "and" quad
    q(x) = 1/2 dot (x + 1)^2 dot (x - 4). $
  The first is a downward parabola crossing the axis twice; the second
  is a cubic that bounces at $x = -1$ and crosses at $x = 4$. Same
  zeros, entirely different graphs — which is the point: the zeros of a
  polynomial do not determine it.
]

#ex(difficulty: 3, time: "15 min", calculator: true, level: "high")[
  A polynomial $p$ of degree $4$ has exactly two zeros, both of them
  crossings, and $p(x) -> +oo$ at both ends.
  #auto-parts(
    1,
    [Is this possible? If so, give an example; if not, explain why
      not.],
    [Same question, but now with $p$ of degree $4$ and *three* zeros,
      all crossings.],
  )
][
  #auto-parts(
    1,
    [Possible. Two crossings mean two zeros of odd multiplicity; the
      multiplicities must sum to $4$, and two odd numbers summing to
      $4$ must be $1 + 3$ or $3 + 1$. So e.g.
      $p(x) = (x + 1)^3 dot (x - 2)$, which has degree $4$ and leading
      coefficient $+1$, so both ends rise as required.],
    [Impossible. Three crossings mean three odd multiplicities, and the
      sum of three odd numbers is odd, so the degree would have to be
      odd — contradicting degree $4$. More generally: a polynomial of
      even degree has an even number of crossings, and one of odd
      degree an odd number. This is the same fact as the end-behavior
      rule, seen from the other side.],
  )

  #heuristic("look for what stays the same")
]

#ai-box(role: "Generator")[
  Ask an AI assistant for five polynomials in factored form of degree
  between $3$ and $5$, with a mix of simple, double and triple zeros,
  and *without* their graphs. Sketch all five by hand using the
  six-step procedure. Only then plot them with your calculator and
  compare.

  Two things to watch for. First, the model will sometimes hand you an
  expanded polynomial instead of a factored one — that is a different
  and much harder exercise, so send it back. Second, check that each
  polynomial really has the multiplicities it claims: a repeated factor
  is easy to state and easy to get wrong.
]

== Building New Functions: Composition

#only-theory[
  Most functions you meet are not primitive. They are built out of
  simpler ones — added, multiplied, or, most importantly, plugged into
  each other.
]

#definition(title: "Composition")[
  Given two functions $u$ and $v$, the #vocab("composition",
  "Verkettung") $u compose v$ is the function
  $ (u compose v)(x) = u(v(x)): $
  apply $v$ first, then apply $u$ to the result. We call $v$ the
  *inner* function and $u$ the *outer* function.

  The domain of $u compose v$ consists of those $x$ in the domain of
  $v$ for which $v(x)$ lies in the domain of $u$.
]

#example(title: "Order matters")[
  Let $u(x) = x^2$ and $v(x) = x + 3$. Then
  $ (u compose v)(x) = (x + 3)^2, quad
    (v compose u)(x) = x^2 + 3. $
  These are different functions — one is a shifted parabola, the other
  a raised one. Composition is not commutative, and reading a formula
  correctly means reading it from the inside out.
]

#only-theory[
  For calculus, the skill that matters is the reverse one:
  *decomposition*. Given a formula, identify the outer and the inner
  function. The test is mechanical — ask what you would compute last if
  you had a number for $x$. That is the outer function.

  For $f(x) = sqrt(x^2 - x)$: given a number, you would first compute
  $x^2 - x$ and then take its root. So $v(x) = x^2 - x$ is inner and
  $u(x) = sqrt(x)$ is outer.
]

#look-ahead(
  title: "Why we are drilling this",
  preview: "the chain rule",
)[
  Differentiating a composite function needs both pieces separately:
  the rule is "derivative of the outer, applied to the inner, times the
  derivative of the inner". Students who find the chain rule hard have
  almost always tripped on the decomposition, not the rule. Getting it
  automatic now costs half a lesson and saves several.
]

=== Exercises

#ex(difficulty: 1, time: "10 min", calculator: false)[
  Write each function as a composition $u(v(x))$, naming $u$ and $v$
  explicitly. Some can be split in more than one way; give the split
  you find most natural.
  #auto-parts(
    2,
    [$f(x) = (3 x - 1)^5$],
    [$f(x) = sin(x^2)$],
    [$f(x) = e^(cos(x))$],
    [$f(x) = ln(3 x^5)$],
    [$f(x) = sqrt(1 + ln(x))$],
    [$f(x) = tan(e^x + x)$],
  )
][
  #auto-parts(
    2,
    [$v(x) = 3 x - 1$, $u(x) = x^5$],
    [$v(x) = x^2$, $u(x) = sin(x)$],
    [$v(x) = cos(x)$, $u(x) = e^x$],
    [$v(x) = 3 x^5$, $u(x) = ln(x)$],
    [$v(x) = 1 + ln(x)$, $u(x) = sqrt(x)$],
    [$v(x) = e^x + x$, $u(x) = tan(x)$],
  )

  Part (e) can also be read as a three-fold composition,
  $x |-> ln(x) |-> 1 + ln(x) |-> sqrt(dot.c)$, and part (d) as
  $ln(3 x^5) = ln(3) + 5 dot ln(x)$, which is not a composition at all.
  Both observations are correct and both will be useful later.
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Let $u(x) = 1/x$ and $v(x) = x - 2$.
  #auto-parts(
    1,
    [Determine $u compose v$ and $v compose u$, with their domains.],
    [Find a function $w$ with $w compose w = "id"$, that is
      $w(w(x)) = x$ for every $x$ in its domain, and which is not the
      identity itself.],
  )
][
  #auto-parts(
    1,
    [$(u compose v)(x) = 1/(x - 2)$ with domain $RR without {2}$;
      $(v compose u)(x) = 1/x - 2$ with domain $RR without {0}$.],
    [Several work. $w(x) = -x$ on $RR$; $w(x) = 1/x$ on
      $RR without {0}$; $w(x) = c - x$ for any constant $c$. Each is
      its own inverse, so its graph is symmetric about the line
      $y = x$.],
  )
]

#only-high[
  === Inverse Functions

  Composition gives the cleanest description of what an inverse
  function is. The inverse $f^(-1)$ of $f$ is the function that undoes
  it:
  $ f^(-1)(f(x)) = x quad "and" quad f(f^(-1)(y)) = y. $

  Not every function has one. $f(x) = x^2$ does not, on all of $RR$:
  both $3$ and $-3$ are sent to $9$, so there is no way to decide what
  $f^(-1)(9)$ should be. Restricted to $x gt.eq 0$ it does, and the
  inverse is $sqrt(x)$. The condition is that $f$ take each value at
  most once on the interval in question — which, graphically, is the
  requirement that every horizontal line meet the graph at most once.

  Reflecting the graph of $f$ in the line $y = x$ gives the graph of
  $f^(-1)$, since the reflection swaps the roles of input and output.
  You have already used this twice without naming it: $ln$ against
  $e^x$, and $arcsin$ against $sin$ restricted to
  $[-pi/2, pi/2]$.
]

#ex(difficulty: 2, time: "12 min", calculator: false, level: "high")[
  For each function, decide whether it has an inverse on the given
  interval. If it does, find a formula for it; if it does not, give the
  largest interval containing $0$ on which it does.
  #auto-parts(
    1,
    [$f(x) = 3 x - 5$ on $RR$],
    [$f(x) = x^2 - 4 x$ on $RR$],
    [$f(x) = e^(2 x)$ on $RR$],
  )
][
  #auto-parts(
    1,
    [Yes. Solving $y = 3 x - 5$ for $x$ gives
      $f^(-1)(x) = (x + 5)/3$.],
    [No: $f(0) = f(4) = 0$. Completing the square gives
      $f(x) = (x - 2)^2 - 4$, so $f$ turns around at $x = 2$; the
      largest interval containing $0$ on which it is one-to-one is
      $(-oo, 2]$. There $f$ is decreasing, and solving
      $y = (x - 2)^2 - 4$ with $x lt.eq 2$ gives
      $f^(-1)(x) = 2 - sqrt(x + 4)$ on $[-4, oo)$.],
    [Yes, since $e^(2 x)$ is strictly increasing. Solving
      $y = e^(2 x)$ gives $f^(-1)(x) = 1/2 dot ln(x)$ on $(0, oo)$.],
  )
]

#print-hints()
#print-vocab()
