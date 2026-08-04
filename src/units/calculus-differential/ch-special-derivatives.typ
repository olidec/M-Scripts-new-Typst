#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Derivatives of the Elementary Functions")
#let ex = exercise.with(chapter: "Derivatives of the Elementary Functions")

// ── TEACHER'S NOTE ───────────────────────────────────────────
// This chapter repays the four derivatives borrowed on credit in
// ch-derivative-rules §2. The order is forced: e^x must come first
// (nothing else can be derived without it), then ln by inverting it,
// then a^x and log_b by rewriting in terms of those two.
//
// §1 DEFINES e by the property that makes it useful — the base whose
// difference quotient constant is 1 — rather than presenting it as a
// number that happens to be 2.718... . Students meet e in the
// exponential chapter of year 1/2 as "the natural base", usually
// without any reason for the word "natural". This exploration is that
// reason, and it is worth running as a genuine search rather than
// demonstrating it.
//
// §4's derivation of (sin x)' from the addition theorem is only-high
// AND depends on the addition theorem being available. If your trig
// unit did not cover sin(x + y), drop the only-high block: the
// graphical argument before it is self-contained and is what GLF gets
// anyway. (Note that the trig unit deliberately omits the
// double-angle identities, so do not assume the addition theorem came
// along with them.)
//
// MOVED OUT: the old notes' Exercises 66, 67 and 68 (global extrema
// of x^2 cos x; stationary values of e^x cos x; stationary points of
// e^(2x) sin(x)/(x+1)) are NOT here. They need the first- and
// second-derivative tests, which arrive in ch-curve-analysis; they
// have been moved there, where they make a good applied exercise set
// on non-polynomial functions.

= Derivatives of the Elementary Functions

#only-theory[
  In the previous chapter we borrowed four derivatives without
  justification. Time to pay.

  The debt cannot be settled in any order we like. Everything here
  rests on one function, $e^x$, whose derivative has to be established
  first and by other means; from there the natural logarithm follows by
  inverting it, and every other exponential and logarithm follows by
  rewriting it. The trigonometric functions are a separate story with
  their own foundation — a limit you already computed numerically two
  chapters ago.
]

#epigraph(by: "Walter Rudin")[
  This function is undoubtedly the most important in mathematics.
]

#objectives(
  bfkm[differentiate exponential and logarithmic functions to any
    base],
  bfkm[differentiate the trigonometric functions],
  [explain what singles the number $e$ out from every other base of an
    exponential function],
  [derive the derivative of $ln(x)$ from that of $e^x$, using the
    chain rule and the inverse relationship],
  [combine these derivatives with the rules of the previous chapter],
  obj(level: "high")[derive the derivative of $sin(x)$ from the
    addition theorem and the limit $lim_(h -> 0) sin(h) slash h = 1$],
)

== The Exponential Function and the Number $e$

#only-theory[
  Take the simplest exponential function we can, $f(x) = 2^x$, and put
  it through the definition:
  $ f'(x) = lim_(h -> 0) (2^(x + h) - 2^x) / h
    = lim_(h -> 0) (2^x dot (2^h - 1)) / h
    = 2^x dot lim_(h -> 0) (2^h - 1) / h. $

  That factorization is the whole trick, and it is available only for
  exponential functions: $2^(x+h) = 2^x dot 2^h$, so the $x$-part comes
  straight out of the limit and the remaining limit does not depend on
  $x$ at all.

  So the derivative of $2^x$ is $2^x$ *times some constant*. The
  function is proportional to its own derivative. What remains is to
  find the constant — and to notice that it depends on the base.
]

#exploration(title: "Hunting for the natural base")[
  Let $k(b)$ denote the constant above for base $b$:
  $ k(b) = lim_(h -> 0) (b^h - 1) / h. $

  + Estimate $k(2)$ by evaluating $(2^h - 1) slash h$ at
    $h = 0.1$, $0.01$, $0.001$, $0.0001$.
  + Do the same for $k(3)$.
  + One of your two answers is below $1$ and the other above it. So
    somewhere between $2$ and $3$ there is a base with $k(b) = 1$.
    Find it to three decimal places by trial.
  + For that base, what is the derivative of $b^x$? What does the
    answer say about the graph — about the relationship between its
    height and its steepness at every point?
  + Do you recognize the number you found?
]

#only-theory[
  #align(center)[
    #plot(
      xmin: -2.6, xmax: 1.6, ymin: -0.4, ymax: 4.4,
      width: 10, height: 6,
      axis-x-pos: "bottom", axis-y-pos: "center",
      xlabel: $x$, ylabel: $y$,
      xtick: (-2, -1, 1), ytick: (1, 2, 3, 4),
      show-origin: false,
      (
        fn: x => x + 1.0, domain: (-1.35, 1.3),
        stroke: stroke(paint: luma(110), thickness: 0.9pt, dash: "dashed"),
        label: $y = x + 1$, label-pos: 0.05, label-side: "below-right",
      ),
      (
        fn: x => calc.pow(2.0, x), domain: (-2.4, 1.3),
        stroke: green.darken(15%) + 1.3pt,
        label: $2^x$, label-pos: 0.97, label-side: "below-right",
      ),
      (
        fn: x => calc.exp(x), domain: (-2.4, 1.3),
        stroke: blue + 1.5pt,
        label: $e^x$, label-pos: 0.97, label-side: "above-left",
      ),
      (
        fn: x => calc.pow(3.0, x), domain: (-2.4, 1.3),
        stroke: red + 1.3pt,
        label: $3^x$, label-pos: 0.97, label-side: "above-left",
      ),
    )
  ]

  All three curves pass through $(0, 1)$, and the dashed line is the
  line of slope $1$ through that point. It cuts $2^x$, it cuts $3^x$,
  and it is *tangent* to exactly one curve between them.

  The search converges on $b approx 2.718$, and the number is $e$.
  This is not a coincidence to be filed away: it is the *reason* $e$
  matters. Among all the exponential functions $b^x$ — a whole
  continuum of them, all with the same general shape — exactly one has
  the property that its steepness at every point equals its height
  there. That one is called the natural exponential function, and the
  word "natural" finally means something.
]

#keybox(title: [The exponential function is its own derivative])[
  $ (e^x)' = e^x. $

  Equivalently: $e$ is the unique base for which
  $ lim_(h -> 0) (e^h - 1) / h = 1. $
]

#remark[
  You have probably met $e$ before as a decimal, or as the limit
  $lim_(n -> oo) (1 + 1/n)^n$ from compound interest. Those are
  descriptions of the same number, and each is the right one in its
  own context. The description in the keybox is the one that matters
  for calculus, and it is why $e$ appears in the answer to problems
  that have nothing to do with interest — radioactive decay,
  population growth, the cooling of coffee. Whenever a quantity's rate
  of change is proportional to the quantity itself, $e$ is already in
  the room.
]

#example(title: "Immediate consequences")[
  With the chain rule:
  $ (e^(3 x))' = e^(3 x) dot 3, quad
    (e^(-x))' = -e^(-x), quad
    (e^(x^2))' = e^(x^2) dot 2 x. $
  And with the product rule, $(x dot e^x)' = e^x + x dot e^x
  = (1 + x) dot e^x$.
]

== The Natural Logarithm

#only-theory[
  We do not need the definition again. The logarithm is the inverse of
  the exponential, and the chain rule turns that sentence into a
  computation.

  Start from the identity that says exactly that $ln$ undoes $e^x$:
  $ e^(ln(x)) = x quad "for every" x > 0. $
  Both sides are functions of $x$, and they are the same function, so
  their derivatives agree. Differentiate the left side with the chain
  rule — outer $e^x$, inner $ln(x)$ — and the right side trivially:
  $ e^(ln(x)) dot (ln(x))' = 1. $
  But $e^(ln(x))$ is just $x$ again, so
  $ x dot (ln(x))' = 1 quad ==> quad (ln(x))' = 1/x. $
]

#keybox(title: "Derivative of the natural logarithm")[
  $ (ln(x))' = 1/x, quad x > 0. $
]

#remark[
  Something quietly remarkable has happened. The power rule
  $(x^n)' = n dot x^(n-1)$ produces every power of $x$ as a
  derivative — except one. There is no $n$ with $n dot x^(n-1) = x^(-1)$,
  because that would need $n = 0$, and $n = 0$ gives the derivative $0$.

  The single missing case is filled by a function from an entirely
  different family. That gap, and the fact that $ln$ plugs it, will
  matter a great deal in the integration unit next year.
]

#look-ahead(
  title: "The one integral that breaks the pattern",
  preview: "antiderivatives",
)[
  Read backwards, the two boxes above say that an antiderivative of
  $x^n$ is $x^(n+1) slash (n+1)$ — which is undefined when $n = -1$ —
  and that an antiderivative of $1 slash x$ is $ln(x)$. Every table of
  integrals you will ever meet has one line that looks like an
  exception. This is why.
]

== Other Bases

#only-theory[
  Every exponential can be written in base $e$, using
  $b = e^(ln(b))$:
  $ b^x = (e^(ln(b)))^x = e^(ln(b) dot x). $
  Now it is a chain rule problem with inner function $ln(b) dot x$,
  whose derivative is the constant $ln(b)$:
  $ (b^x)' = e^(ln(b) dot x) dot ln(b) = b^x dot ln(b). $

  Logarithms to other bases yield to the change-of-base formula in the
  same way. Since $log_b (x) = ln(x) slash ln(b)$ and $ln(b)$ is a
  constant,
  $ (log_b (x))' = 1 / (x dot ln(b)). $
]

#keybox(title: "Exponentials and logarithms to any base")[
  For $b > 0$, $b eq.not 1$:
  $ (b^x)' = b^x dot ln(b), quad
    (log_b (x))' = 1 / (x dot ln(b)). $
  Setting $b = e$ recovers the two boxes above, since $ln(e) = 1$.
]

#example(title: "A doubling population")[
  A culture doubles every hour, so after $t$ hours its size is
  $N(t) = N_0 dot 2^t$. Its growth rate is
  $ N'(t) = N_0 dot 2^t dot ln(2) = ln(2) dot N(t)
    approx 0.693 dot N(t). $
  So the population grows at about $69%$ of its current size per hour
  — not $100%$, which is the answer most people expect from
  "doubling". The doubling is the *cumulative* effect over the hour;
  the instantaneous rate is smaller, because the population is smaller
  for most of that hour than it is at the end of it.
]

=== Exercises

#ex(difficulty: 1, time: "12 min", calculator: false)[
  Differentiate.
  #auto-parts(
    3,
    [$f(x) = e^(5 x)$],
    [$f(x) = 3^x$],
    [$f(x) = ln(4 x)$],
    [$f(x) = log_(10) (x)$],
    [$f(x) = x dot ln(x)$],
    [$f(x) = e^x / x$],
  )
][
  #auto-parts(
    3,
    [$5 e^(5 x)$],
    [$3^x dot ln(3)$],
    [$1/(4 x) dot 4 = 1/x$. Or note
      $ln(4 x) = ln(4) + ln(x)$ first.],
    [$1 / (x dot ln(10))$],
    [$ln(x) + 1$],
    [$(e^x dot x - e^x) / x^2 = (e^x dot (x - 1)) / x^2$],
  )
]

== The Trigonometric Functions

#only-theory[
  These need a different foundation, and you have already laid part of
  it. Look at the graph of $sin(x)$ and ask where its tangents are
  horizontal: at $dots.h, -pi/2, pi/2, (3 pi)/2, dots.h$ — the peaks
  and troughs. So the derivative must be zero exactly there.

  Ask how steep the graph is at $x = 0$. That is the limit
  $ lim_(h -> 0) (sin(h) - sin(0)) / h = lim_(h -> 0) sin(h) / h, $
  which is precisely the limit you tabulated in the limits chapter and
  found to be $1$. So the derivative takes the value $1$ at the origin.

  A function that is zero at $plus.minus pi/2$, equal to $1$ at the
  origin, and periodic with the same period — the graph of $cos(x)$
  matches at every point we can check.
]

#keybox(title: "Derivatives of sine and cosine")[
  $ (sin(x))' = cos(x), quad (cos(x))' = -sin(x). $
  Both require $x$ in *radians*.
]

#only-high[
  === A Proper Derivation

  The graphical argument above is suggestive, not conclusive — plenty
  of functions vanish at $plus.minus pi/2$ and equal $1$ at the
  origin. Here is the real thing.

  It rests on two limits. The first you have already met numerically:
  $ lim_(h -> 0) sin(h) / h = 1, quad
    lim_(h -> 0) (cos(h) - 1) / h = 0. $
  The second follows from the first: multiply top and bottom by
  $cos(h) + 1$ to get
  $(cos^2(h) - 1) slash (h dot (cos(h) + 1))
  = -sin^2(h) slash (h dot (cos(h) + 1))$, which is
  $-sin(h) dot (sin(h) slash h) slash (cos(h) + 1)$ and therefore
  tends to $-0 dot 1 slash 2 = 0$.

  Now use the addition theorem $sin(x + h) = sin(x) cos(h)
  + cos(x) sin(h)$ in the difference quotient:
  $ (sin(x + h) - sin(x)) / h
    &= (sin(x) cos(h) + cos(x) sin(h) - sin(x)) / h \
    &= sin(x) dot (cos(h) - 1) / h + cos(x) dot sin(h) / h. $
  Letting $h -> 0$, the first term tends to $sin(x) dot 0 = 0$ and the
  second to $cos(x) dot 1$:
  $ (sin(x))' = cos(x). $
  The same computation with the addition theorem for cosine gives
  $(cos(x))' = -sin(x)$; the minus sign comes from the minus in
  $cos(x + h) = cos(x) cos(h) - sin(x) sin(h)$.

  #heuristic("look for what stays the same")

  Notice which step did the real work. The addition theorem is what
  separates the $x$ from the $h$ — the same service that
  $2^(x+h) = 2^x dot 2^h$ performed for the exponential in §1. Both
  derivations have the same shape.
]

#only-theory[
  The tangent needs nothing new. Since
  $tan(x) = sin(x) slash cos(x)$, the quotient rule gave us in the
  previous chapter
  $ (tan(x))' = 1 / cos^2(x) = 1 + tan^2(x). $
]

#warning[
  Every derivative in this section is false in degree mode. In
  degrees, $sin(x)$ is really $sin(pi x slash 180)$ in disguise, so
  the chain rule inserts a factor:
  $ ("degree-mode " sin(x))' = pi/180 dot cos(x) approx 0.0175 dot cos(x). $
  The graph of the degree-mode sine is almost flat on an ordinary
  axis — it takes $360$ units to complete one oscillation — and a
  nearly flat graph has a nearly zero derivative. Radians are not a
  convention chosen for tidiness; they are the choice that makes the
  factor equal to $1$.
]

== The Complete Table

#keybox(title: "Derivatives of the elementary functions")[
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
    [$log_b (x)$], [$1 slash (x dot ln(b))$], [$x$], [$1$],
  ))

  With the four rules of the previous chapter, this table is enough to
  differentiate every function in this course.
]

=== Exercises

#ex(
  difficulty: 2,
  time: "30 min",
  calculator: false,
  hints: (
    [Identify the outermost operation first, exactly as in the
      previous chapter. The new functions change what the innermost
      pieces are, not the strategy.],
    [In (c), rewrite $log_(10)$ in terms of $ln$ before differentiating
      anything. In (j) and (k), simplify after differentiating — both
      collapse.],
  ),
)[
  Differentiate.
  #auto-parts(
    2,
    [$f(x) = 3 x dot ln(x)$],
    [$f(x) = 2^x / (x^2 - 1)$],
    [$f(x) = ln(log_(10) (x^2))$],
    [$f(x) = e^(4 x^3)$],
    [$f(x) = sin(4 x)$],
    [$f(x) = tan^2(x)$],
    [$f(x) = sin(sin(x))$],
    [$f(x) = 1/2 dot e^(sin(2 x))$],
    [$f(x) = sqrt(tan(2 x))$],
    [$f(x) = sin(x) / (1 + cos(x))$],
    [$f(x) = ln(cos(x))$],
  )
][
  #auto-parts(
    2,
    [$3 ln(x) + 3$],
    [$(2^x dot ln(2) dot (x^2 - 1) - 2^x dot 2 x) / (x^2 - 1)^2$],
    [$2 / (x dot ln(x^2))$],
    [$e^(4 x^3) dot 12 x^2$],
    [$4 cos(4 x)$],
    [$2 tan(x) / cos^2(x)$],
    [$cos(sin(x)) dot cos(x)$],
    [$e^(sin(2 x)) dot cos(2 x)$],
    [$1 / (cos^2(2 x) dot sqrt(tan(2 x)))$],
    [$1 / (1 + cos(x))$],
    [$-tan(x)$],
  )

  Part (c) is the messiest and the most instructive. Rewrite
  $log_(10) (x^2) = ln(x^2) slash ln(10)$ first; then the outer $ln$
  contributes $1 slash log_(10)(x^2)$ and the inner part contributes
  $2 slash (x dot ln(10))$, and the two factors of $ln(10)$ cancel.

  Parts (j) and (k) both collapse dramatically. In (j) the numerator
  becomes $cos(x) + cos^2(x) + sin^2(x) = 1 + cos(x)$, which cancels
  one power of the denominator. In (k) the chain rule produces
  $-sin(x) slash cos(x)$, which is $-tan(x)$. Neither collapse is an
  accident worth relying on, but both are worth looking for.
]

== Tangents, Revisited

#ex(difficulty: 2, time: "20 min", calculator: false)[
  Find the equations of the tangent and the normal to the curve at the
  given value of $x$.
  #auto-parts(
    2,
    [$f(x) = sin(x) + cos(x)$ at $x = pi/2$],
    [$f(x) = 2 tan(x)$ at $x = pi/4$],
    [$f(x) = x + e^(2 x)$ at $x = 0$],
    [$f(x) = ln(x + 1)$ at $x = 2$],
  )
][
  #auto-parts(
    1,
    [$f(pi/2) = 1$ and $f'(x) = cos(x) - sin(x)$, so
      $f'(pi/2) = -1$.
      Tangent $y = -x + 1 + pi/2$; #h(0.4em) normal
      $y = x + 1 - pi/2$.],
    [$f(pi/4) = 2$ and $f'(x) = 2 slash cos^2(x)$, so
      $f'(pi/4) = 4$.
      Tangent $y = 4 x + 2 - pi$; #h(0.4em) normal
      $y = -1/4 dot x + 2 + pi/16$.],
    [$f(0) = 1$ and $f'(x) = 1 + 2 e^(2 x)$, so $f'(0) = 3$.
      Tangent $y = 3 x + 1$; #h(0.4em) normal
      $y = -1/3 dot x + 1$.],
    [$f(2) = ln(3)$ and $f'(x) = 1 slash (x + 1)$, so
      $f'(2) = 1/3$.
      Tangent $y = 1/3 dot x + ln(3) - 2/3$; #h(0.4em) normal
      $y = -3 x + ln(3) + 6$.],
  )
]

#ex(
  difficulty: 2,
  time: "10 min",
  calculator: false,
  hints: (
    [Parallel lines have equal slopes. Translate the condition into an
      equation in $x$ before doing anything else.],
  ),
)[
  Consider $y = 3 sin(x)$ on $0 lt.eq x lt.eq 2 pi$. Find every value
  of $x$ at which the tangent to the graph is parallel to the line
  $y = 3/2 dot x + 4$.
][
  Parallel means equal slope, so we need $y' = 3/2$. Since
  $y' = 3 cos(x)$:
  $ 3 cos(x) = 3/2 quad ==> quad cos(x) = 1/2. $
  On $[0, 2 pi]$ this gives
  $ x = pi/3 quad "and" quad x = (5 pi)/3. $
  The constant $4$ in the equation of the line never entered the
  computation — it fixes where the line sits, not how steep it is.
]

#ex(difficulty: 3, time: "15 min", calculator: false, level: "high")[
  #auto-parts(
    1,
    [Show that $f(x) = e^x dot sin(x)$ satisfies
      $f''(x) - 2 f'(x) + 2 f(x) = 0$.],
    [Find a constant $k$ for which $g(x) = e^(k x)$ satisfies
      $g''(x) = 9 g(x)$. How many such constants are there?],
  )
][
  #auto-parts(
    1,
    [Product rule twice:
      $ f'(x) &= e^x dot sin(x) + e^x dot cos(x), \
        f''(x) &= (e^x sin(x) + e^x cos(x))
                 + (e^x cos(x) - e^x sin(x))
               = 2 e^x dot cos(x). $
      Substituting,
      $ f'' - 2 f' + 2 f
        = 2 e^x cos(x) - 2 e^x sin(x) - 2 e^x cos(x)
          + 2 e^x sin(x) = 0. $],
    [$g'(x) = k dot e^(k x)$ and $g''(x) = k^2 dot e^(k x)$, so the
      condition reads $k^2 e^(k x) = 9 e^(k x)$. Since $e^(k x)$ is
      never zero, $k^2 = 9$ and $k = plus.minus 3$ — two constants.],
  )

  #heuristic("introduce notation")

  Equations relating a function to its own derivatives are called
  *differential equations*, and they are how most of physics is
  written. Notice that both parts here were solved by *guessing a
  form* and then pinning down a constant — which remains, at a much
  higher level, the standard method.
]

#ai-box(role: "Explainer")[
  Ask an AI assistant to explain why $e$ rather than $10$ or $2$ is
  called the *natural* base, and require the explanation to be about
  derivatives rather than about compound interest or about the
  decimal expansion. Then ask it what would go wrong if we insisted
  on using $2^x$ everywhere instead.

  A good answer will say that $(2^x)' = 2^x dot ln(2)$, so a factor of
  $ln(2)$ appears in every computation and multiplies up in repeated
  differentiation — nothing becomes impossible, only permanently
  cluttered. If the answer talks about interest compounded
  continuously, ask again: that is a true fact about $e$ and not an
  answer to the question you asked.
]

#print-hints()
#print-vocab()
