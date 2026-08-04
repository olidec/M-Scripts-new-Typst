#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Improper Integrals")
#let ex = exercise.with(chapter: "Improper Integrals")

// ── TEACHER'S NOTE ───────────────────────────────────────────
// LEVEL: THIS CHAPTER IS SPF-ONLY, and the gating is done at the
// CHAPTER BOUNDARY rather than inside the file — it is registered in
// main-high.typ and NOT in main-basic.typ. So there are no only-high
// wrappers anywhere below, and none should be added: everything here
// is high-level by construction. Uneigentliche Integrale are named
// explicitly in SPF Y4 1.2 and appear nowhere in the GLF Lehrplan.
//
// Consequence for numbering: this chapter contributes exercises to
// exercises-high.typ and solutions-high.typ only, which is one more
// reason exercise cross-references by number are unsafe course-wide.
//
// The old LaTeX notes contain nothing on this topic at all.
//
// TWO THINGS WORTH THE LESSON TIME, both in §4:
//   * Gabriel's horn. Finite volume, infinite surface area, from a
//     curve they integrated two chapters ago. It is the best piece of
//     genuine mathematical strangeness available at this level and it
//     costs ten minutes.
//   * The link to the distributions unit. ∫e^(-x) over [0,∞) = 1 is
//     exactly the statement that the exponential density integrates
//     to 1, and the students met densities without ever being able to
//     check that claim. This chapter lets them check it.
//
// THE TRAP IN §3 (∫ from -1 to 1 of 1/x²) should be set deliberately:
// let the class compute it wrongly first, get -2, and then ask how a
// positive integrand can have a negative integral. That question
// answers itself and the point sticks.

= Improper Integrals

#only-theory[
  Every definite integral so far has been a bounded function on a
  bounded interval. Both conditions were doing work: the Riemann sums
  needed finitely many strips of finite width, and each rectangle
  needed a finite height.

  Drop either condition and the definition stops applying. But the
  questions do not stop being asked. What is the total area under
  $y = e^(-x)$ for *all* positive $x$? What is the total probability
  of a normally distributed measurement — an integral over the whole
  real line? Each of these is an integral over an infinite region, and
  the striking thing is that some of them have finite answers.

  The resolution is the one that has resolved everything in these two
  units: do not attempt the infinite case directly. Do the finite case
  and take a limit.
]

#epigraph(by: "Blaise Pascal")[
  The eternal silence of these infinite spaces frightens me.
]

#objectives(
  [state the definition of an improper integral as a limit, for both
    an infinite interval and an unbounded integrand],
  [decide whether a given improper integral converges or diverges, and
    evaluate it when it converges],
  [apply the convergence criterion for powers of $x$, at infinity and
    at the origin],
  [recognize an integral that is improper because the integrand is
    unbounded at an interior point, and treat it correctly],
  [interpret an improper integral in context, including a probability
    density and a solid of infinite extent],
)

== When the Interval Is Infinite

#only-theory[
  There is no such thing as a Riemann sum over $[1, oo)$. So we
  integrate as far as some finite $b$, obtaining an ordinary definite
  integral, and then ask what happens as $b$ grows without bound.
]

#definition(title: "Improper integral over an infinite interval")[
  If $f$ is continuous on $[a, oo)$, define
  $ integral_a^(oo) f(x) dif x = lim_(b -> oo) integral_a^b f(x) dif x. $
  If the limit exists and is finite, the integral
  #vocab("converges", "konvergiert") and its value is that limit. If
  the limit does not exist, or is infinite, the integral
  #vocab("diverges", "divergiert").

  Integrals over $(-oo, b]$ are defined symmetrically. For
  $(-oo, oo)$, split at any convenient point and require *both* halves
  to converge.
]

#example(title: "Two integrands that look alike and do not behave alike")[
  *Convergent.*
  $ integral_1^(oo) 1/x^2 dif x
    = lim_(b -> oo) [-1/x]_1^b
    = lim_(b -> oo) (1 - 1/b) = 1. $
  The region stretching infinitely far to the right has *area $1$*.

  *Divergent.*
  $ integral_1^(oo) 1/x dif x
    = lim_(b -> oo) [ln(x)]_1^b
    = lim_(b -> oo) ln(b) = oo. $
  This region has infinite area.

  #align(center)[
    #plot(
      xmin: 0.4, xmax: 8.6, ymin: -0.1, ymax: 1.3,
      width: 11, height: 5,
      axis-x-pos: "bottom", axis-y-pos: "left",
      xlabel: $x$, ylabel: $y$,
      xtick: (1, 2, 4, 6, 8), ytick: (0.5, 1),
      show-origin: false,
      fill-area(
        x => 1.0 / x, baseline: 0.0, domain: (1.0, 8.5),
        color: red.lighten(80%),
      ),
      fill-area(
        x => 1.0 / (x * x), baseline: 0.0, domain: (1.0, 8.5),
        color: blue.lighten(72%),
      ),
      (
        fn: x => 1.0 / x, domain: (0.8, 8.5),
        stroke: red + 1.4pt, samples: 140,
        label: $1/x$, label-pos: 0.06, label-side: "above-right",
      ),
      (
        fn: x => 1.0 / (x * x), domain: (0.9, 8.5),
        stroke: blue + 1.4pt, samples: 140,
        label: $1/x^2$, label-pos: 0.12, label-side: "below-right",
      ),
    )
  ]

  Both integrands are positive, both decrease to zero, and both graphs
  look much the same when drawn. The difference is entirely in *how
  fast* they approach the axis — and $1 slash x$ does not do it fast
  enough. The picture cannot settle the question either: the two
  regions differ only in a tail that no diagram can show.
]

#remark[
  That an unbounded region can have finite area is the substantive
  content of this chapter, and it is worth pausing on rather than
  accepting. The region under $1 slash x^2$ from $1$ to infinity has
  no right-hand edge; it goes on forever; and its area is exactly $1$,
  the same as a unit square.

  The reconciling thought is that the strips being added get thin very
  quickly. Doubling the right-hand limit from $b$ to $2 b$ adds only
  $1 slash b - 1 slash (2 b)$ to the total — an amount that itself
  shrinks. The sum of infinitely many positive quantities can be
  finite, as the geometric series already told you.
]

#keybox(title: "The power test at infinity")[
  For $a > 0$,
  $ integral_a^(oo) 1/x^p dif x quad
    cases(
      "converges" quad "if" p > 1,
      "diverges" quad "if" p lt.eq 1.
    ) $

  The borderline case $p = 1$ diverges. Every power that decays
  faster than $1 slash x$ converges; $1 slash x$ itself, and
  everything decaying more slowly, does not.
]

#example(title: "The exponential beats every power")[
  $ integral_0^(oo) e^(-x) dif x
    = lim_(b -> oo) [-e^(-x)]_0^b
    = lim_(b -> oo) (1 - e^(-b)) = 1. $
  Exponential decay is far faster than any power, so integrals of
  $e^(-k x)$ over an infinite interval always converge — and the
  answers are usually clean.
]

== When the Function Is Unbounded

#only-theory[
  The second way an integral can be improper: the interval is finite,
  but the integrand blows up somewhere on it. The remedy is the same —
  stop short of the trouble and take a limit.
]

#definition(title: "Improper integral with an unbounded integrand")[
  If $f$ is continuous on $(a, b]$ but unbounded near $a$, define
  $ integral_a^b f(x) dif x
    = lim_(t -> a^+) integral_t^b f(x) dif x, $
  and symmetrically if the trouble is at $b$.

  If the integrand is unbounded at an interior point $c$, split the
  interval at $c$ and require *both* resulting integrals to converge.
]

#example(title: "The power test, the other way round")[
  $ integral_0^1 1/sqrt(x) dif x
    = lim_(t -> 0^+) [2 sqrt(x)]_t^1
    = lim_(t -> 0^+) (2 - 2 sqrt(t)) = 2. $
  Convergent, despite the integrand growing without bound as
  $x -> 0$.

  $ integral_0^1 1/x dif x
    = lim_(t -> 0^+) [ln(x)]_t^1
    = lim_(t -> 0^+) (-ln(t)) = oo. $
  Divergent.
]

#keybox(title: "The power test at the origin")[
  $ integral_0^1 1/x^p dif x quad
    cases(
      "converges" quad "if" p < 1,
      "diverges" quad "if" p gt.eq 1.
    ) $

  Compare this with the test at infinity, and note that the
  inequality has *reversed*. A large $p$ makes the tail small — good
  at infinity — but makes the blow-up at the origin severe — bad
  there. The one exponent that fails at both ends is $p = 1$.
]

#warning[
  An integral can be improper without announcing it. Consider
  $ integral_(-1)^1 1/x^2 dif x. $
  Applying the fundamental theorem mechanically:
  $ [-1/x]_(-1)^1 = -1 - 1 = -2. $

  That answer is impossible. The integrand $1 slash x^2$ is *positive*
  everywhere it is defined, so its integral cannot be negative.

  The error is that $f$ is unbounded at $x = 0$, an interior point of
  the interval, so the fundamental theorem does not apply — it
  requires a continuous integrand. Splitting correctly at $0$:
  $ integral_0^1 1/x^2 dif x
    = lim_(t -> 0^+) (1/t - 1) = oo, $
  so the integral diverges, and so does the other half.

  *Always check the integrand for discontinuities inside the limits of
  integration before applying the fundamental theorem.* This is the
  one place in the course where a completely routine calculation gives
  a confidently wrong answer.
]

== Two Applications

=== Probability Densities

#only-theory[
  In the distributions unit you met continuous random variables
  described by a *density* function, with the property that the total
  probability is $1$. That property is an improper integral, and you
  could not check it at the time.

  The exponential distribution with parameter $lambda > 0$ has density
  $f(x) = lambda dot e^(-lambda x)$ for $x gt.eq 0$. Then
  $ integral_0^(oo) lambda e^(-lambda x) dif x
    = lim_(b -> oo) [-e^(-lambda x)]_0^b
    = lim_(b -> oo) (1 - e^(-lambda b)) = 1, $
  which is exactly the statement that this really is a probability
  density. The same computation with limits $0$ and $t$ gives
  $p(X lt.eq t) = 1 - e^(-lambda t)$, the formula you used for
  waiting times.

  The normal distribution's density involves $e^(-x^2 slash 2)$,
  whose integral over the whole real line is
  $ integral_(-oo)^(oo) e^(-x^2 slash 2) dif x = sqrt(2 pi). $
  This converges — the integrand decays faster than any power — but it
  cannot be evaluated by the methods of this course, since as the
  techniques chapter noted, $e^(-x^2)$ has no elementary
  antiderivative. The $sqrt(2 pi)$ appearing in the front of the
  normal density is precisely the constant needed to divide this down
  to $1$.
]

=== Gabriel's Horn

#only-theory[
  Rotate the curve $y = 1 slash x$, for $x gt.eq 1$, about the
  $x$\u{2011}axis. The resulting solid is infinitely long — a horn
  narrowing forever.

  Its volume, by the disc formula and the calculation from §1:
  $ V = pi integral_1^(oo) 1/x^2 dif x = pi. $
  Finite. A little over three cubic units, for an object of infinite
  length.

  Its surface area is given by an integral we have not derived, but
  the essential point needs only a comparison. The surface area
  integral is
  $ A = 2 pi integral_1^(oo) 1/x dot sqrt(1 + 1/x^4) dif x, $
  and since the square root is at least $1$ throughout,
  $ A gt.eq 2 pi integral_1^(oo) 1/x dif x = oo. $
  Infinite.

  So the horn can be filled with a finite quantity of paint and cannot
  be painted. This is not a paradox, though it is usually presented as
  one — real paint has a thickness, and a coat of any fixed thickness
  on an infinite surface has infinite volume, while the horn itself
  eventually becomes narrower than any coat of paint. What is genuinely
  surprising is simply that $1 slash x^2$ converges and
  $1 slash x$ does not, which is the fact this whole chapter turns
  on.
]

== Exercises

#ex(
  difficulty: 2,
  time: "25 min",
  calculator: false,
  hints: (
    [Replace the infinite limit by $b$, integrate, and then take the
      limit. Write the limit down explicitly — do not substitute
      $oo$ into an antiderivative.],
    [For the power cases, check your answer against the power test.],
  ),
)[
  Determine whether each integral converges. Evaluate those that do.
  #auto-parts(
    2,
    [$integral_1^(oo) 1/x^3 dif x$],
    [$integral_1^(oo) 1/sqrt(x) dif x$],
    [$integral_0^(oo) e^(-2 x) dif x$],
    [$integral_(-oo)^0 e^x dif x$],
    [$integral_0^(oo) x dot e^(-x^2) dif x$],
    [$integral_1^(oo) (ln(x)) / x^2 dif x$],
  )
][
  #auto-parts(
    2,
    [Converges ($p = 3 > 1$):
      $lim_(b -> oo) [-1/(2 x^2)]_1^b = 1/2$.],
    [Diverges ($p = 1/2 lt.eq 1$):
      $[2 sqrt(x)]_1^b = 2 sqrt(b) - 2 -> oo$.],
    [Converges: $[-1/2 e^(-2 x)]_0^b -> 1/2$.],
    [Converges: $[e^x]_(-oo)^0 = 1 - 0 = 1$.],
    [Converges. Reversing the chain rule,
      $[-1/2 e^(-x^2)]_0^b -> 1/2$.],
    [Converges. By parts with $u = ln(x)$, $v' = x^(-2)$:
      $ integral (ln(x))/x^2 dif x = -(ln(x))/x - 1/x, $
      and both terms tend to $0$ as $x -> oo$, while at $x = 1$ the
      value is $-1$. So the integral is $1$.],
  )

  Part (f) is worth noting: $ln(x)$ grows without bound, and yet
  dividing it by $x^2$ produces a convergent integral. Logarithmic
  growth is very slow — slower than every positive power of $x$ — so
  it never rescues a divergence.
]

#ex(
  difficulty: 2,
  time: "20 min",
  calculator: false,
  hints: (
    [Identify *where* the integrand misbehaves before doing anything
      else. In one of these it is at an interior point.],
    [Use the power test at the origin, and remember that its
      inequality runs the opposite way to the test at infinity.],
  ),
)[
  Determine whether each integral converges. Evaluate those that do.
  #auto-parts(
    2,
    [$integral_0^1 1/x^(2/3) dif x$],
    [$integral_0^4 1/sqrt(x) dif x$],
    [$integral_0^1 1/x^2 dif x$],
    [$integral_(-1)^1 1/x^2 dif x$],
  )
][
  #auto-parts(
    2,
    [Unbounded at $0$; $p = 2/3 < 1$, so it converges:
      $lim_(t -> 0^+) [3 x^(1/3)]_t^1 = 3$.],
    [Unbounded at $0$; $p = 1/2 < 1$, so it converges:
      $[2 sqrt(x)]_0^4 = 4$.],
    [Unbounded at $0$; $p = 2 gt.eq 1$, so it diverges.],
    [The integrand is unbounded at $x = 0$, which is *inside* the
      interval. Splitting there, both halves diverge by part (c), so
      the whole integral diverges. Applying the fundamental theorem
      blindly would give $-2$, which is impossible for a positive
      integrand.],
  )
]

#ex(
  difficulty: 3,
  time: "15 min",
  calculator: false,
  hints: (
    [Reverse the chain rule: what function has $1 slash x$ as its
      derivative, and where does it appear here?],
  ),
)[
  #auto-parts(
    1,
    [Evaluate $integral_2^(oo) 1/(x dot (ln(x))^2) dif x$.],
    [Show that $integral_2^(oo) 1/(x dot ln(x)) dif x$ diverges.],
    [Comment on the pair, in the light of the power test.],
  )
][
  #auto-parts(
    1,
    [The derivative of $ln(x)$ is $1 slash x$, which is present as a
      factor, so an antiderivative of
      $(ln(x))^(-2) dot 1/x$ is $-1 slash ln(x)$:
      $ lim_(b -> oo) [-1/ln(x)]_2^b = 0 + 1/ln(2)
        = 1/ln(2) approx 1.44. $],
    [The same recognition gives the antiderivative
      $ln(abs(ln(x)))$, and
      $ lim_(b -> oo) [ln(ln(x))]_2^b = oo, $
      since $ln(ln(b))$ grows without bound — extremely slowly, but
      without bound.],
    [The pair mirrors $integral 1 slash x^p$ exactly: exponent $2$ on
      the logarithm converges, exponent $1$ diverges. The same
      borderline appears one level further out, with $ln(x)$ playing
      the role that $x$ played before. Part (b) also shows how
      *slowly* a divergence can happen: to make the integral exceed
      $10$, you would need $b$ of the order of $e^(e^(10))$, a number
      with about ten thousand digits.],
  )

  #heuristic("look for what stays the same")
]

#ex(difficulty: 3, time: "15 min", calculator: false)[
  Consider rotating the curve $y = 1 slash x^p$, for $x gt.eq 1$,
  about the $x$\u{2011}axis.
  #auto-parts(
    1,
    [For which values of $p$ does the resulting solid have finite
      volume?],
    [For which values of $p$ does the region under the curve, from
      $1$ to infinity, have finite area?],
    [Find a value of $p$ for which the solid has finite volume but the
      generating region has infinite area, and explain how that is
      possible.],
  )
][
  #auto-parts(
    1,
    [The volume is $pi integral_1^(oo) x^(-2 p) dif x$, which converges
      when $2 p > 1$, i.e. $ p > 1/2. $],
    [The area is $integral_1^(oo) x^(-p) dif x$, which converges when
      $ p > 1. $],
    [Any $p$ with $1/2 < p lt.eq 1$ — for instance $p = 1$, which is
      Gabriel's horn itself.

      This is possible because squaring a small number makes it much
      smaller. Far out along the curve, $1 slash x^p$ is less than
      $1$, so the disc radius squared is *smaller* than the radius
      itself, and the volume integrand decays twice as fast as the
      area integrand. Rotating a region can convert an infinite area
      into a finite volume.],
  )

  Part (c) is the honest version of the Gabriel's horn story: the
  surprise is not about paint, it is that squaring the integrand
  doubles the exponent and can push it across the convergence
  threshold.
]

#ai-box(role: "Checker")[
  Give an AI assistant this integral and nothing else:
  $ integral_(-1)^1 1/x^2 dif x. $
  A large fraction of the time the answer will be $-2$, obtained by
  applying the fundamental theorem to a discontinuous integrand.

  If it answers $-2$, ask one question: *"can a positive function have
  a negative integral?"* Then watch what happens. If it answers
  correctly the first time, try
  $integral_(-1)^1 1/x dif x$ and
  $integral_0^2 1/(x - 1) dif x$, both of which hide the same
  discontinuity slightly better.

  The lesson is not that the model is unreliable. It is that this
  particular error — applying a theorem whose hypothesis silently
  fails — produces an answer that looks completely normal, which is
  precisely why you must check the integrand yourself before
  integrating.
]

#print-hints()
#print-vocab()
