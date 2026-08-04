#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Calculating the Derivative")
#let ex = exercise.with(chapter: "Calculating the Derivative")

// ── IMAGE NOTE ───────────────────────────────────────────────
// One optional figure from the old LaTeX img/ folder:
//   xkcd Newton/Leibniz strip → xkcd-626-newton-and-leibniz.png
// The #image call in §5 is commented out; the prose does not depend
// on it. (xkcd is CC BY-NC 2.5 — attribution and the source URL are
// already in the caption, and the school's use is non-commercial.)
//
// ── TEACHER'S NOTE ───────────────────────────────────────────
// This is the chapter where the limits work pays off, and it is worth
// saying that out loud in class: every difference quotient is 0/0 at
// h = 0, so "cancel the h and then substitute" is not a trick, it is
// the factor-and-cancel move from the limits chapter applied to a
// quotient we built on purpose.
//
// §3 derives the power rule by conjecture-from-cases rather than
// stating it. The SPF proof in §3 uses the binomial theorem, which
// that track has already met via Pascal's triangle in the
// combinatorics unit — worth referring back to explicitly, since the
// connection is not obvious to students and it is one of the few
// places where combinatorics visibly earns its keep in analysis.
//
// Tangent and normal lines are introduced here rather than in
// ch-curve-analysis. The reason is motivational: after eight
// first-principles computations, students should get to DO something
// with a derivative in the same week, and "find the tangent at this
// point" is the shortest route to that.
//
// NOT here: sums, products, quotients, chains. All of §4's exercises
// are deliberately computable from first principles alone.

= Calculating the Derivative

#only-theory[
  The previous chapter defined $f'(x_0)$ as the slope of the tangent —
  a good description and, as we said then, a useless recipe. A slope
  needs two points and we have one.

  The way out was already visible in the shrinking-interval
  calculations: take two points, compute the slope of the secant
  through them, and then let the second point slide into the first.
  The first quantity is something we can compute for any $f$. The
  second is a limit. Putting them together turns the description into
  an algorithm, and that algorithm is what this chapter is about.
]

#epigraph(by: "Bishop George Berkeley, 1734")[
  And what are these fluxions? The velocities of evanescent
  increments. And what are these same evanescent increments? They are
  neither finite quantities, nor quantities infinitely small, nor yet
  nothing. May we not call them the ghosts of departed quantities?
]

#objectives(
  bfkm[state the definition of the derivative as a limit of difference
    quotients, and explain why the limit cannot be evaluated by
    substituting $h = 0$],
  bfkm[compute the derivative of a simple function directly from the
    definition],
  [use the definition to discover the power rule, and apply it to
    powers with negative and fractional exponents],
  bfkm[find the equation of the tangent and of the normal to a curve at
    a given point],
  [explain why a differentiable function must be continuous, and why
    the converse fails],
  obj(level: "high")[prove the power rule for positive integer
    exponents using the binomial theorem],
)

== The Difference Quotient

#only-theory[
  Fix a point $x_0$ and a step $h eq.not 0$. The secant through
  $(x_0, f(x_0))$ and $(x_0 + h, f(x_0 + h))$ has slope
  $ (Delta y) / (Delta x) = (f(x_0 + h) - f(x_0)) / h, $
  which is the average rate of change from the last chapter. Given a
  formula for $f$, this is a formula we can actually write down.

  Now let $h$ shrink. Every value of $h eq.not 0$ gives a genuine
  secant and a genuine number; as $h$ approaches zero, the second point
  slides into the first and the secants close in on the tangent. In the
  language of the limits chapter, we want
  $ lim_(h -> 0) (f(x_0 + h) - f(x_0)) / h. $
]

#definition(title: "The derivative, as a limit")[
  The #vocab("difference quotient", "Differenzenquotient") of $f$ at
  $x_0$ is
  $ (f(x_0 + h) - f(x_0)) / h, quad h eq.not 0. $

  The derivative of $f$ at $x_0$ is its limit:
  $ f'(x_0) = lim_(h -> 0) (f(x_0 + h) - f(x_0)) / h, $
  provided the limit exists. If it does, $f$ is *differentiable* at
  $x_0$.

  Computing this limit at every $x$ produces the *derivative function*
  $ f'(x) = lim_(h -> 0) (f(x + h) - f(x)) / h. $
]

#warning[
  Substituting $h = 0$ into the difference quotient gives
  $ (f(x_0) - f(x_0)) / 0 = 0/0, $
  which is not a number. This is not an unfortunate accident to be
  worked around; it is the situation, every single time, for every
  function.

  And it is exactly the case the limits chapter prepared for. A
  quotient of the form $0 slash 0$ is *indeterminate*: it means the
  answer is not yet visible, not that there is no answer. The standard
  move — factor, cancel the offending factor, then substitute — is
  what every computation below does. The $h$ in the denominator will
  always cancel, because the numerator always vanishes at $h = 0$ and
  therefore always contains a factor $h$.
]

=== Three Worked Examples

#example(title: "The parabola")[
  Let $f(x) = x^2$. Then
  $ f'(x) &= lim_(h -> 0) ((x + h)^2 - x^2) / h \
    &= lim_(h -> 0) (x^2 + 2 x h + h^2 - x^2) / h \
    &= lim_(h -> 0) (2 x h + h^2) / h \
    &= lim_(h -> 0) (2 x + h) \
    &= 2 x. $

  Read the last two lines carefully. Cancelling $h$ is legal because
  the limit never asks about $h = 0$ itself, only about $h$ nearby. Once
  the cancellation is done, the remaining expression $2 x + h$ is
  perfectly well behaved at $h = 0$, and substituting is finally
  allowed.

  So the parabola has slope $2 x$ at the point above $x$: slope $-4$ at
  $x = -2$, slope $0$ at the vertex, slope $6$ at $x = 3$. Check those
  against the graph.
]

#example(title: "A reciprocal")[
  Let $f(x) = 1/x$, with $x eq.not 0$. Here the algebra begins by
  putting the numerator over a common denominator:
  $ f'(x) &= lim_(h -> 0) 1/h dot (1/(x + h) - 1/x) \
    &= lim_(h -> 0) 1/h dot (x - (x + h)) / (x dot (x + h)) \
    &= lim_(h -> 0) 1/h dot (-h) / (x dot (x + h)) \
    &= lim_(h -> 0) (-1) / (x dot (x + h)) \
    &= -1/x^2. $

  The derivative is negative everywhere, which matches the graph: both
  branches of the hyperbola fall.
]

#example(title: "A root")[
  Let $f(x) = sqrt(x)$, with $x > 0$. The useful move is the conjugate
  trick from the limits chapter:
  $ (sqrt(x + h) - sqrt(x)) / h
    &= ((sqrt(x + h) - sqrt(x)) dot (sqrt(x + h) + sqrt(x))) /
       (h dot (sqrt(x + h) + sqrt(x))) \
    &= ((x + h) - x) / (h dot (sqrt(x + h) + sqrt(x))) \
    &= 1 / (sqrt(x + h) + sqrt(x)). $
  Letting $h -> 0$:
  $ f'(x) = 1 / (2 sqrt(x)). $

  Two things to notice. The derivative grows without bound as
  $x -> 0^+$ — the square-root graph leaves the origin vertically. And
  it tends to $0$ as $x$ grows: the graph flattens but never levels
  off, since $1 slash (2 sqrt(x))$ is never actually zero.
]

#remark[
  In every example the pattern was the same: *do algebra until the $h$
  in the denominator cancels, and only then take the limit*. The
  algebra differs — expand, common denominator, conjugate — but the
  strategy does not. If you find yourself taking a limit while an $h$
  is still downstairs, you have gone too fast.
]

=== Exercises

#ex(
  difficulty: 2,
  time: "30 min",
  calculator: false,
  hints: (
    [Write the difference quotient out in full before simplifying
      anything, and keep $x$ and $h$ visually distinct.],
    [For (d) use a common denominator; for (g) use the conjugate. For
      the polynomial parts, expand and watch every term without an $h$
      cancel.],
  ),
)[
  Use the definition to calculate the following derivatives. In each
  case show the step at which the $h$ cancels.
  #auto-parts(
    2,
    [$f(x) = -x^2 + x$],
    [$f(x) = a dot x + b$],
    [$f(x) = a dot x^2 + b dot x + c$],
    [$f(x) = 1/x$],
    [$f(x) = x^3$],
    [$f(x) = x^4$],
    [$f(x) = sqrt(x)$],
    [$f(x) = x^n$, for a positive integer $n$],
  )
][
  #auto-parts(
    1,
    [$(-(x + h)^2 + (x + h) + x^2 - x) slash h
      = (-2 x h - h^2 + h) slash h = -2 x - h + 1 -> -2 x + 1$.],
    [$(a dot (x + h) + b - a dot x - b) slash h
      = (a dot h) slash h = a$, for every $h$. So
      $f'(x) = a$ — the slope of a line is the same everywhere, which
      is reassuring rather than surprising.],
    [$f'(x) = 2 a dot x + b$. Note that (a) and (b) are both special
      cases of this one.],
    [$f'(x) = -1 slash x^2$, as worked above.],
    [$((x + h)^3 - x^3) slash h
      = (3 x^2 h + 3 x h^2 + h^3) slash h
      = 3 x^2 + 3 x h + h^2 -> 3 x^2$.],
    [$f'(x) = 4 x^3$, by the same expansion one degree higher: the
      surviving term is the one with exactly one factor $h$.],
    [$f'(x) = 1 slash (2 sqrt(x))$, as worked above.],
    [$f'(x) = n dot x^(n-1)$. See §3.],
  )

  #heuristic("look for what stays the same")

  Part (c) is worth pausing on. It contains (a) as the case
  $a = -1, b = 1, c = 0$ and (b) as the case $a = 0$ — so doing the
  general one *first* would have saved the other two. Working with
  letters instead of numbers is not extra difficulty; it is usually
  less work.
]

== The Alternative Form

#only-theory[
  There is a second way to write the same limit, and it is sometimes
  more convenient. Instead of a step $h$ away from $x_0$, use a second
  point $x$ and let it approach $x_0$ directly:
  $ f'(x_0) = lim_(x -> x_0) (f(x) - f(x_0)) / (x - x_0). $

  The two forms are the same statement with $x = x_0 + h$. Use whichever
  makes the algebra shorter — the $h$-form is usually better when you
  want the derivative *function*, and this form when you want the
  derivative at one specific point and the numerator factors nicely.
]

#example(title: "The same result, the other way")[
  For $f(x) = x^2$ at $x_0 = 3$:
  $ lim_(x -> 3) (x^2 - 9) / (x - 3)
    = lim_(x -> 3) ((x - 3) dot (x + 3)) / (x - 3)
    = lim_(x -> 3) (x + 3) = 6, $
  which agrees with $f'(3) = 2 dot 3 = 6$. Here the cancelling factor
  is $(x - 3)$ rather than $h$, and it appears because $x_0$ is a zero
  of the numerator — the same reason as before, wearing a different
  hat.
]

== Discovering the Power Rule

#exploration(title: "Guess, then check")[
  You have now differentiated $x^2$, $x^3$ and $x^4$ from the
  definition.

  + Tabulate the three results next to their functions. What is the
    pattern?
  + State a conjecture for the derivative of $f(x) = x^n$.
  + Use your conjecture to predict the derivative of $j(x) = x^5$.
    Then compute it from the definition and see whether the prediction
    survives.
  + Your conjecture was formed from three positive whole numbers.
    Test it on $f(x) = 1/x = x^(-1)$ and on
    $f(x) = sqrt(x) = x^(1/2)$, both of which you have already
    differentiated. Does it still hold?
]

#keybox(title: "The power rule")[
  For every real exponent $n$,
  $ f(x) = x^n quad ==> quad f'(x) = n dot x^(n-1). $

  Two special cases worth naming separately, both of which follow by
  setting $n = 1$ and $n = 0$:
  $ (x)' = 1, quad (c)' = 0 quad "for any constant" c. $
]

#remark[
  The rule as stated claims far more than the exploration established.
  We checked three positive integers, one negative integer and one
  fraction; the rule asserts *every real exponent*, including
  $f(x) = x^(pi)$. That leap is legitimate, but it is a leap, and it is
  not proved by the cases above.

  This is worth being honest about rather than glossing over. What the
  evidence supports is a conjecture; what makes it a theorem is a
  proof, and the proof for general real $n$ needs tools we meet only
  in the chapter on exponential functions. For positive integers, we
  can do it now.
]

#only-high[
  === Proving the Power Rule for Positive Integers

  The obstacle in the general case is expanding $(x + h)^n$, and you
  already know how: the binomial theorem, which arrived in the
  combinatorics unit as the row of Pascal's triangle counting the ways
  to choose $k$ factors of $h$ out of $n$ brackets.

  $ (x + h)^n = x^n + binom(n, 1) x^(n-1) h + binom(n, 2) x^(n-2) h^2
    + dots.h + h^n. $

  Subtracting $x^n$ removes the first term, and every remaining term
  contains at least one factor $h$, so dividing by $h$ is clean:
  $ ((x + h)^n - x^n) / h
    = binom(n, 1) x^(n-1) + binom(n, 2) x^(n-2) h + dots.h + h^(n-1). $

  Now let $h -> 0$. Every term still carrying a factor $h$ vanishes,
  and exactly one term survives — the one that had precisely one $h$ to
  begin with:
  $ f'(x) = binom(n, 1) x^(n-1) = n dot x^(n-1). $

  So the $n$ in the power rule is $binom(n, 1)$, the number of ways of
  picking which single bracket contributes the $h$. That is not a
  coincidence of notation; it is where the factor comes from.
]

=== Exercises

#ex(difficulty: 1, time: "12 min", calculator: false)[
  Differentiate using the power rule. Rewrite each expression as a
  power of $x$ first.
  #auto-parts(
    3,
    [$f(x) = x^5$],
    [$f(x) = 1/x^4$],
    [$f(x) = root(3, x)$],
    [$f(x) = 1 / sqrt(x)$],
    [$f(x) = 2 / x^8$],
    [$f(x) = 5$],
  )
][
  #auto-parts(
    3,
    [$f'(x) = 5 x^4$],
    [$x^(-4)$, so $f'(x) = -4 x^(-5) = -4 slash x^5$],
    [$x^(1/3)$, so $f'(x) = 1/3 dot x^(-2/3)$],
    [$x^(-1/2)$, so $f'(x) = -1/2 dot x^(-3/2)$],
    [$2 x^(-8)$, so $f'(x) = -16 x^(-9) = -16 slash x^9$],
    [$f'(x) = 0$],
  )

  Part (f) is not a trick question. A constant function has a
  horizontal graph, and a horizontal graph has slope $0$ everywhere.
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  #auto-parts(
    1,
    [For which value of $x$ does the graph of $f(x) = x^2$ have slope
      $7$?],
    [Is there a point on the graph of $f(x) = x^3$ with slope $-3$?],
    [Find every point on the graph of $f(x) = 1/x$ at which the
      tangent has slope $-1$.],
  )
][
  #auto-parts(
    1,
    [$f'(x) = 2 x = 7$ gives $x = 3.5$.],
    [No. $f'(x) = 3 x^2 gt.eq 0$ for every $x$, so the cubic never has
      a negative slope — it is increasing everywhere, with a single
      horizontal tangent at the origin.],
    [$f'(x) = -1 slash x^2 = -1$ gives $x^2 = 1$, so $x = 1$ or
      $x = -1$: the points $(1, 1)$ and $(-1, -1)$.],
  )
]

#ai-box(role: "Checker")[
  Choose three of the first-principles computations from the exercise
  set in §1 and work them again on paper, in full. Then ask an AI
  assistant to compute the same three derivatives *from the
  definition*, and compare line by line — not the final answers, which
  will agree, but the intermediate steps.

  The specific thing to look for: does its work ever take the limit
  while an $h$ is still in the denominator, or write $h = 0$ before
  the cancellation? That step is invalid even when the answer it
  produces is right, and it is the single most common flaw in
  worked-out solutions to this material, human and machine alike.
]

== Tangents and Normals

#only-theory[
  We can now do something with a derivative rather than merely compute
  it. The tangent to the graph of $f$ at $x_0$ is a line, and we know
  both a point on it and its slope:

  - the point is $(x_0, f(x_0))$;
  - the slope is $f'(x_0)$.

  Point-slope form does the rest.
]

#keybox(title: "Tangent and normal")[
  The #vocab("tangent", "Tangente") to the graph of $f$ at $x_0$ has
  the equation
  $ y = f(x_0) + f'(x_0) dot (x - x_0). $

  The #vocab("normal", "Normale") at $x_0$ is the line through the same
  point perpendicular to the tangent, so its slope is
  $-1 slash f'(x_0)$:
  $ y = f(x_0) - 1/(f'(x_0)) dot (x - x_0), quad f'(x_0) eq.not 0. $
]

#example(title: "Tangent and normal to a parabola")[
  Find the tangent and the normal to $f(x) = x^2$ at $x_0 = 3$.

  The point is $(3, 9)$ and the slope is $f'(3) = 6$, so the tangent is
  $ y = 9 + 6 dot (x - 3) = 6 x - 9. $
  The normal has slope $-1/6$:
  $ y = 9 - 1/6 dot (x - 3) = -1/6 dot x + 19/2. $
  Check both at $x = 3$: each gives $y = 9$, as it must.
]

#warning[
  A tangent is not "a line meeting the curve exactly once". That
  description works for circles and fails immediately elsewhere.

  The tangent to $y = x^3$ at the origin is the $x$\u{2011}axis, and
  it does not stay on one side of the curve: it *crosses* it at the
  very point of tangency.

  The tangent to $y = sin(x)$ at $x = pi/2$ is the horizontal line
  $y = 1$, which touches the curve again at every point
  $x = pi/2 + 2 k pi$ — infinitely many times.

  A tangent is the line whose slope is $f'(x_0)$. That is the whole
  definition, and it is local: it says nothing about what the line does
  elsewhere.
]

=== Exercises

#ex(difficulty: 1, time: "15 min", calculator: false)[
  Find the equations of the tangent and of the normal at the given
  point.
  #auto-parts(
    2,
    [$f(x) = x^2$ at $x_0 = -1$],
    [$f(x) = 1/x$ at $x_0 = 2$],
    [$f(x) = sqrt(x)$ at $x_0 = 4$],
    [$f(x) = x^3$ at $x_0 = 1$],
  )
][
  #auto-parts(
    2,
    [Point $(-1, 1)$, slope $-2$. Tangent $y = -2 x - 1$; normal
      $y = 1/2 dot x + 3/2$.],
    [Point $(2, 1/2)$, slope $-1/4$. Tangent
      $y = -1/4 dot x + 1$; normal $y = 4 x - 15/2$.],
    [Point $(4, 2)$, slope $1/4$. Tangent $y = 1/4 dot x + 1$;
      normal $y = -4 x + 18$.],
    [Point $(1, 1)$, slope $3$. Tangent $y = 3 x - 2$; normal
      $y = -1/3 dot x + 4/3$.],
  )
]

#ex(
  difficulty: 3,
  time: "15 min",
  calculator: false,
  hints: (
    [Do not assume the point of tangency is the given point — it is
      not on the curve. Call it $(t, t^2)$ and write the tangent
      there.],
    [Impose that the tangent passes through $(0, -4)$ and solve the
      resulting equation for $t$.],
  ),
)[
  Find every tangent to the parabola $f(x) = x^2$ that passes through
  the point $P = (0, -4)$.
][
  The point $P$ does not lie on the parabola, so it is not the point of
  tangency. Let the point of tangency be $(t, t^2)$. The tangent there
  has slope $2 t$, so its equation is
  $ y = t^2 + 2 t dot (x - t) = 2 t dot x - t^2. $
  Requiring it to pass through $(0, -4)$ gives
  $ -4 = -t^2 quad ==> quad t = plus.minus 2. $
  So there are two tangents:
  $ y = 4 x - 4 quad "and" quad y = -4 x - 4, $
  touching at $(2, 4)$ and $(-2, 4)$ respectively.

  #heuristic("introduce notation")

  Introducing the unknown $t$ is the whole idea. "Tangent at a point on
  the curve" is a computation; "tangent through a point off the curve"
  is an equation to be solved, and the two are worth keeping firmly
  apart.
]

== What the Definition Tells Us About Existence

#only-theory[
  The definition also settles the questions the previous chapter could
  only draw pictures of.
]

#example(title: "Why the absolute value fails at the origin")[
  For $f(x) = |x|$ at $x_0 = 0$, the difference quotient is
  $ (|0 + h| - |0|) / h = (|h|) / h
    = cases(
      +1 quad "for" h > 0,
      -1 quad "for" h < 0,
    ) $
  The one-sided limits are $+1$ and $-1$. Both exist and they differ,
  so the two-sided limit does not exist and $f'(0)$ is undefined —
  which is the corner, now computed rather than observed.
]

#keybox(title: "Differentiable implies continuous")[
  If $f$ is differentiable at $x_0$, then $f$ is continuous at $x_0$.

  *Why.* Write the change in $f$ as the difference quotient times $h$:
  $ f(x_0 + h) - f(x_0)
    = h dot (f(x_0 + h) - f(x_0)) / h. $
  As $h -> 0$ the first factor tends to $0$ and the second tends to
  $f'(x_0)$, a finite number. A quantity tending to zero times a
  quantity tending to something finite tends to zero, so
  $f(x_0 + h) -> f(x_0)$ — which is continuity.

  The converse is false: $|x|$ is continuous at $0$ and not
  differentiable there.
]

#remark[
  Notice where the hypothesis was used. The argument needs
  $f'(x_0)$ to be a *finite* number; that is exactly what "the limit
  exists" means, and it is exactly what fails for a vertical tangent.
  This is the limit product law from the previous unit, doing real
  work.
]

// #fig(image("images/xkcd-626-newton-and-leibniz.png", width: 75%),
//   caption: [source: `https://xkcd.com/626/`])

#only-theory[
  A historical footnote. Calculus was developed independently and at
  almost the same time by Isaac Newton (1642–1727) and Gottfried
  Wilhelm Leibniz (1646–1716), and the two of them — or rather their
  supporters — spent decades in a bitter priority dispute. Newton got
  there first and published later; Leibniz published first and devised
  the better notation, which is why you write $(dif y) slash (dif x)$
  and not $dot(y)$.

  Neither of them had limits. The concept in this chapter was made
  precise by Cauchy and Weierstrass in the 19th century, roughly 150
  years after the calculus that depended on it was already being used
  to predict the motion of planets. Rigour, historically, tends to
  arrive after the results rather than before them.
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  #auto-parts(
    1,
    [Show, using difference quotients, that $f(x) = |x - 2|$ is not
      differentiable at $x_0 = 2$.],
    [The function $g(x) = x dot |x|$ *is* differentiable at $0$.
      Compute both one-sided limits of its difference quotient to
      confirm this, and state $g'(0)$.],
    [Sketch both graphs and say, in one sentence each, what the
      difference looks like.],
  )
][
  #auto-parts(
    1,
    [$(|2 + h - 2| - 0) slash h = |h| slash h$, which is $+1$ for
      $h > 0$ and $-1$ for $h < 0$. The one-sided limits differ, so
      the derivative does not exist.],
    [$(g(h) - g(0)) slash h = (h dot |h|) slash h = |h|$ for
      $h eq.not 0$, and $|h| -> 0$ from both sides. So $g'(0) = 0$.],
    [The first graph has a corner at $(2, 0)$: two straight pieces
      meeting at an angle. The second passes through the origin
      smoothly with a horizontal tangent — it is $x^2$ on the right
      and $-x^2$ on the left, glued together without a kink.],
  )
]

#ex(difficulty: 3, time: "15 min", calculator: false, level: "high")[
  Determine $a$ and $b$ so that the function
  $ f(x) = cases(
    x^2 quad "for" x lt.eq 1,
    a dot x + b quad "for" x > 1,
  ) $
  is differentiable at $x_0 = 1$. Explain why continuity alone is not
  enough to determine both constants.
][
  Two conditions are needed, and they arrive in order.

  *Continuity at $1$* requires the two pieces to agree there:
  $1 = a + b$.

  *Differentiability at $1$* requires the one-sided derivatives to
  agree. From the left the slope is $2 x$ evaluated at $1$, i.e. $2$;
  from the right it is the constant $a$. So $a = 2$, and then
  $b = -1$.

  Continuity alone gives one equation in two unknowns and therefore a
  whole family of solutions — every line through $(1, 1)$ joins on
  without a break. Requiring differentiability picks out the single
  member of that family that joins on without a *kink*, and that one is
  the tangent to the parabola at $(1, 1)$.

  #heuristic("draw a picture")
]

#print-hints()
#print-vocab()
