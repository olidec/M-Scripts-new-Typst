#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Asymptotes")
#let ex = exercise.with(chapter: "Asymptotes")

// ── TEACHER'S NOTE ───────────────────────────────────────────
// The main structural change from the old LaTeX notes: the three
// "Remember" boxes stating the horizontal/oblique rules are gone. All
// three now fall out of ONE idea — divide P by Q and look at what is
// left over — which is derived in §4 and then specialized. The rules
// are still stated as a summary keybox at the end of §4, so nothing
// is lost for students who want a lookup table, but the table is now
// a consequence rather than an axiom.
//
// New here, and worth the half-page: §2 distinguishes a vertical
// asymptote from a HOLE. The old notes had the right example (the
// x = 1 case of (x-1)/(x^2-1)) but no language for what happens
// there instead; with the limits chapter behind us we can now say
// "removable discontinuity, limit 1/2" and mean it.
//
// Also new: §5's point that a graph MAY cross its horizontal or
// oblique asymptote. Students routinely believe otherwise, and the
// belief survives contact with a dozen worked examples that happen
// not to cross.
//
// CORRECTION carried over from the old notes: Exercise 10(h),
// h(x) = sqrt(-x+1)/(1-x), is answered there with the horizontal
// asymptote y = 0 only. Simplifying gives 1/sqrt(1-x) on x < 1, which
// ALSO has the vertical asymptote x = 1 (approached from the left).
// It appears here as Exercise 4(h) with both.

= Asymptotes

#only-theory[
  Some graphs run away to infinity, and some of them run away in an
  orderly fashion. A graph that climbs without bound near $x = 2$, or
  that flattens out towards the height $y = 3$ far out to the right, is
  doing something describable: it is being guided by a line it never
  quite reaches.

  Those guiding lines are asymptotes, and they are the last piece of
  the "what does this graph look like" toolkit we assemble before
  turning to the derivative. With end behavior, zeros, symmetry and
  asymptotes in hand you can sketch most functions in this course
  without plotting a single point — everything except where exactly the
  turning points sit, which is precisely the gap the derivative fills.
]

#epigraph[
  An asymptote is a line a curve gets to know very well and never
  meets.
]

#objectives(
  bfkm[locate the vertical asymptotes of a rational function, and
    determine the behavior of the graph on each side of one],
  [distinguish a vertical asymptote from a removable discontinuity, and
    say what happens at the latter],
  bfkm[determine the horizontal or oblique asymptote of a rational
    function by comparing the degrees of numerator and denominator],
  [obtain the equation of an oblique asymptote by polynomial division,
    and explain why the remainder may be discarded],
  [construct a function with prescribed asymptotes],
  [sketch a rational function from its zeros, symmetry and asymptotes
    alone],
  obj(level: "high")[describe asymptotic behavior that is not a
    straight line, and find asymptotes of functions that are not
    rational],
)

== What an Asymptote Is

#definition(title: "Asymptote")[
  An #vocab("asymptote", "Asymptote") of the graph of $f$ is a line
  which the graph approaches arbitrarily closely.

  Concretely, the line $y = m dot x + b$ is an asymptote of $f$ if
  $ lim_(x -> oo) (f(x) - (m dot x + b)) = 0 $
  (or the same with $x -> -oo$). The line $x = x_0$ is a *vertical*
  asymptote if the values of $f$ grow without bound as $x$ approaches
  $x_0$ from at least one side.
]

#remark[
  The definition above is one sentence doing two different jobs,
  because the two situations really are different. A horizontal or
  oblique asymptote is a statement about the far edges of the graph:
  the *difference* between the function and the line vanishes. A
  vertical asymptote is a statement about a single finite $x$, where
  the function has no value at all.

  Note also that a horizontal asymptote is nothing but an oblique one
  with $m = 0$. There are really only two kinds; we name three because
  the calculations differ.
]

#only-theory[
  Asymptotes can occur for any function, but they are most systematic
  for rational functions
  $ f(x) = P(x) / Q(x), $
  where $P$ and $Q$ are polynomials — and for those we can find every
  asymptote by a procedure rather than by inspiration. That is what the
  next three sections do.
]

== Vertical Asymptotes

#only-theory[
  A quotient explodes when its denominator vanishes and its numerator
  does not. That is the whole rule.
]

#keybox(title: "Vertical asymptotes of a rational function")[
  The rational function $f(x) = P(x) slash Q(x)$ has a vertical
  asymptote at $x_0$ if
  $ Q(x_0) = 0 quad "and" quad P(x_0) eq.not 0. $

  If $Q(x_0) = 0$ *and* $P(x_0) = 0$, there is no asymptote at $x_0$
  until you have cancelled the common factor and looked again.
]

#example(title: "A zero of the denominator that is not an asymptote")[
  Find the vertical asymptotes of
  $ f: y = (x - 1) / (x^2 - 1). $

  The denominator vanishes at $x = 1$ and at $x = -1$, so those are the
  only candidates.

  At $x = -1$: the numerator takes the value $-2 eq.not 0$, so this
  *is* a vertical asymptote.

  At $x = 1$: the numerator also vanishes. Factoring and cancelling,
  $ (x - 1) / (x^2 - 1) = (x - 1) / ((x - 1) dot (x + 1))
    = 1 / (x + 1), quad x eq.not 1, $
  and the reduced expression is perfectly well behaved at $x = 1$:
  $ lim_(x -> 1) f(x) = 1/2. $
  So the graph has a *hole* at $(1, 1/2)$, not an asymptote — a
  removable discontinuity in the language of the previous chapter.
]

#warning[
  A hole and a vertical asymptote look nothing alike, and a calculator
  will happily hide the difference from you: the missing point is one
  pixel wide. Always check the numerator at every zero of the
  denominator, before drawing anything.
]

=== Which Way Does It Go?

#only-theory[
  Knowing that the graph explodes at $x_0$ is only half the
  information. It may go up on both sides, down on both sides, or one
  of each — and the one-sided limits are what decide it.

  For $f(x) = (x - 1) slash (x^2 - 1) = 1 slash (x + 1)$ near
  $x_0 = -1$: just to the left of $-1$ the quantity $x + 1$ is a small
  *negative* number, so the quotient is a large negative one. Just to
  the right it is a small positive number. Hence
  $ lim_(x -> -1^-) f(x) = -oo, quad lim_(x -> -1^+) f(x) = +oo. $
  In practice you do not need the algebra: substitute a value very
  close on each side and read off the sign.
]

=== Exercises

#ex(difficulty: 1, time: "12 min", calculator: false)[
  Determine all vertical asymptotes and all holes, and for each
  asymptote state the behavior on both sides.
  #auto-parts(
    2,
    [$f(x) = 1 / (x - 3)$],
    [$f(x) = (x + 2) / (x^2 - 4)$],
    [$f(x) = x / (x^2 + 1)$],
    [$f(x) = (x^2 - 9) / (x^2 - 3 x)$],
  )
][
  #auto-parts(
    2,
    [Vertical asymptote $x = 3$; the values fall to $-oo$ from the left
      and rise to $+oo$ from the right.],
    [Cancelling gives $1 slash (x - 2)$ for $x eq.not -2$: a hole at
      $(-2, -1/4)$ and a vertical asymptote $x = 2$, with the graph
      falling to $-oo$ from the left and rising to $+oo$ from the
      right.],
    [None: the denominator $x^2 + 1$ is never zero.],
    [Cancelling gives $(x + 3) slash x$ for $x eq.not 3$: a hole at
      $(3, 2)$ and a vertical asymptote $x = 0$, with the graph
      falling to $-oo$ from the left and rising to $+oo$ from the
      right.],
  )

  Part (d) rewards care in both directions — the cancellation removes
  one candidate and leaves the other standing.
]

== Horizontal Asymptotes

#only-theory[
  This one is already done. In the previous chapter we compared the
  degrees of numerator and denominator and read off
  $lim_(x -> oo) f(x)$; a finite value of that limit is exactly a
  horizontal asymptote.
]

#keybox(title: "Horizontal asymptotes")[
  For $f(x) = P(x) slash Q(x)$ with $deg P = p$ and $deg Q = q$:

  - $p < q$: #h(0.6em) horizontal asymptote $y = 0$.
  - $p = q$: #h(0.6em) horizontal asymptote $y = a_p slash b_q$, the
    quotient of the leading coefficients.
  - $p > q$: #h(0.6em) no horizontal asymptote.
]

#example(title: "Equal degrees")[
  For
  $ f: y = (4 x - 6 x^2) / (2 x^2 + 5 x - 3) $
  numerator and denominator both have degree $2$, with leading
  coefficients $-6$ and $2$. The horizontal asymptote is therefore
  $ y = (-6)/2 = -3. $
  Note that the leading coefficient is the one belonging to the
  *highest* power, which here is not the first term written down.
]

== Oblique Asymptotes

#only-theory[
  What if the numerator wins — if $p > q$? Then the function grows
  without bound, and yet it may still grow in an orderly way.

  Rather than memorize a third rule, do the one thing that always
  works: *divide*. Polynomial division of $P$ by $Q$ produces a
  quotient and a remainder,
  $ P(x) / Q(x) = S(x) + R(x) / Q(x), quad deg R < deg Q, $
  where $S$ is a polynomial of degree $p - q$. Because the remainder
  $R$ has lower degree than $Q$, the fraction $R(x) slash Q(x)$ tends
  to $0$ as $x -> plus.minus oo$ — by the first case of the rule in
  §3. So far out, $f$ and $S$ become indistinguishable:
  $ lim_(x -> plus.minus oo) (f(x) - S(x)) = 0. $

  Compare that to the definition of an asymptote in §1. It is the same
  statement. Whatever $S$ turns out to be, the graph of $f$ hugs the
  graph of $S$.
]

#keybox(title: "One rule, three cases")[
  Divide $P$ by $Q$ and look at the quotient $S$:

  - $deg S = 0$ (i.e. $p = q$): $S$ is a constant, the horizontal
    asymptote.
  - $deg S = 1$ (i.e. $p = q + 1$): $S(x) = m dot x + b$, an *oblique*
    asymptote.
  - $deg S gt.eq 2$: no straight asymptote at all — but the graph still
    hugs the curve $y = S(x)$.

  And if $p < q$ the division is trivial, $S = 0$, giving the
  horizontal asymptote $y = 0$. All four cases are the same
  calculation.
]

#example(title: "Dividing to find an oblique asymptote")[
  Find the asymptotes of
  $ f: y = (x^2 - 1) / (x + 4). $

  *Vertical.* The denominator vanishes at $x = -4$, where the numerator
  takes the value $15 eq.not 0$: a vertical asymptote at $x = -4$.

  *Oblique.* Dividing $x^2 - 1$ by $x + 4$:
  $ (x^2 - 1) / (x + 4) = x - 4 + 15 / (x + 4). $
  (Check by multiplying back: $(x - 4) dot (x + 4) = x^2 - 16$, and
  $-16 + 15 = -1$.) The remainder term tends to $0$, so the oblique
  asymptote is
  $ y = x - 4. $

  #align(center)[
    #plot(
      xmin: -12.5, xmax: 6.5, ymin: -24.5, ymax: 10.5,
      width: 11, height: 8,
      axis-x-pos: "center", axis-y-pos: "center",
      xlabel: $x$, ylabel: $y$,
      xtick: (-12, -8, -4, 4), ytick: (-20, -10, 10),
      show-origin: false,
      vline(-4.0, stroke: stroke(
        paint: luma(120), thickness: 0.7pt, dash: "dashed",
      )),
      (
        fn: x => x - 4.0, domain: (-12.0, 6.0),
        stroke: stroke(paint: luma(110), thickness: 0.9pt, dash: "dashed"),
        label: $y = x - 4$, label-pos: 0.97, label-side: "below-right",
      ),
      (
        fn: x => (x * x - 1.0) / (x + 4.0), domain: (-12.0, -5.2),
        stroke: blue + 1.4pt, samples: 140,
      ),
      (
        fn: x => (x * x - 1.0) / (x + 4.0), domain: (-3.0, 6.0),
        stroke: blue + 1.4pt, samples: 140,
        label: $f(x) = (x^2 - 1)/(x + 4)$,
        label-pos: 0.6, label-side: "right",
      ),
      note([$x = -4$], (-4.3, -20.0), anchor: "east", size: 9pt),
    )
  ]

  Both branches hug the dashed line far from the origin, and neither
  goes anywhere near it in the middle. That is exactly what "the
  difference tends to zero" claims and all that it claims.
]

#example(title: "A denominator that never vanishes")[
  For
  $ f: y = (x^3 - 3 x^2) / (x^2 + 1) $
  division gives
  $ (x^3 - 3 x^2) / (x^2 + 1) = x - 3 + (3 - x) / (x^2 + 1). $
  The remainder term has degree $1$ over degree $2$ and therefore tends
  to $0$, so $y = x - 3$ is an oblique asymptote. Since $x^2 + 1$ is
  never zero, there are no vertical asymptotes at all.

  A CAS will do this division for you — the command is usually called
  `expand` or `propFrac` — but do a few by hand first, or the output
  will be a formula you cannot check.
]

=== Exercises

#ex(difficulty: 1, time: "10 min", calculator: false)[
  Determine the horizontal or oblique asymptote of each function.
  #auto-parts(
    2,
    [$f(x) = (3 x + 1) / (x - 2)$],
    [$f(x) = (x + 5) / (x^2 + 1)$],
    [$f(x) = (x^2 + 2 x) / (x - 1)$],
    [$f(x) = (2 x^3 + x) / (x^2 + 4)$],
  )
][
  #auto-parts(
    2,
    [Equal degrees: horizontal asymptote $y = 3$.],
    [Numerator of lower degree: horizontal asymptote $y = 0$.],
    [Division gives $x + 3 + 3 slash (x - 1)$, so the oblique
      asymptote is $y = x + 3$.],
    [Division gives $2 x + (-7 x) slash (x^2 + 4)$, so the oblique
      asymptote is $y = 2 x$.],
  )
]

#ex(
  difficulty: 2,
  time: "25 min",
  calculator: false,
  hints: (
    [Do the vertical asymptotes first — they need only the
      denominator's zeros, checked against the numerator.],
    [In (c) and (h) simplify the expression before doing anything
      else. A root in the numerator or denominator can hide both a
      degree and a domain restriction.],
  ),
)[
  Find *all* asymptotes of the following functions.
  #auto-parts(
    2,
    [$a(x) = (2 x + 1) / (3 x + 2)$],
    [$b(x) = (1 + x) / (1 + x^2)$],
    [$c(x) = sqrt(x^4 + 1) / (3 x^2 + x)$],
    [$d(x) = 1/x + x$],
    [$e(x) = (root(4, x) + 1) / (root(3, x) + 1)$],
    [$g(x) = (x^2 - 1) / (3 x^2 + x + 1)$],
    [$h(x) = (x^3 - 3 x^2 + 1) / (2 x^2)$],
    [$k(x) = sqrt(-x + 1) / (1 - x)$],
  )
][
  Writing v, h, o for vertical, horizontal and oblique:

  #auto-parts(
    2,
    [v: $x = -2/3$; #h(0.4em) h: $y = 2/3$.],
    [h: $y = 0$. The denominator $1 + x^2$ has no real zeros, so there
      is no vertical asymptote.],
    [v: $3 x^2 + x = x dot (3 x + 1) = 0$ gives $x = 0$ and
      $x = -1/3$; #h(0.4em) h: for large $|x|$ the numerator behaves
      like $x^2$, so $y = 1/3$.],
    [v: $x = 0$; #h(0.4em) o: $y = x$, since $1 slash x -> 0$. Here the
      function is already in divided form.],
    [h: $y = 0$. The domain is $x gt.eq 0$ (fourth root), the
      denominator never vanishes there, and
      $root(4, x) slash root(3, x) = x^(-1/12) -> 0$.],
    [h: $y = 1/3$. The discriminant of $3 x^2 + x + 1$ is
      $1 - 12 < 0$, so there are no real zeros and no vertical
      asymptote.],
    [v: $x = 0$; #h(0.4em) o: division gives
      $x/2 - 3/2 + 1 slash (2 x^2)$, so $y = x/2 - 3/2$.],
    [Since $sqrt(-x + 1) = sqrt(1 - x)$ and $1 - x > 0$ on the domain
      $x < 1$, the function simplifies to
      $ k(x) = 1 / sqrt(1 - x). $
      So h: $y = 0$ as $x -> -oo$; #h(0.4em) *and* v: $x = 1$,
      approached from the left only, with $k(x) -> +oo$.],
  )

  Part (h) is the trap: written in its original form the function
  looks like a ratio with matching zeros, and it is tempting to
  conclude that they cancel to nothing interesting. They do cancel —
  and what is left still blows up at $x = 1$.
]

#ex(difficulty: 2, time: "15 min", calculator: false)[
  Find an equation for a function $f$ with the stated properties, and
  sketch its graph.
  #auto-parts(
    1,
    [$f$ has the horizontal asymptote $y = 1$ and the vertical
      asymptote $x = -2$.],
    [$f$ has the oblique asymptote $y = 2 x$ and a zero at $x = -2$.],
    [$f$ is symmetric about the origin and has the oblique asymptote
      $y = -x$.],
  )
][
  #auto-parts(
    1,
    [A vertical asymptote at $-2$ means the factor $(x + 2)$ in the
      denominator; a horizontal asymptote at $y = 1$ means equal
      degrees with equal leading coefficients. E.g.
      $ f(x) = x / (x + 2). $],
    [Start from the asymptote and add something that vanishes at
      infinity: $f(x) = 2 x + c slash x$. The zero condition gives
      $-4 - c/2 = 0$, so $c = -8$ and
      $ f(x) = 2 x - 8/x. $
      (It also has a zero at $x = 2$, which was not forbidden.)],
    [$f(x) = -x + 1/x$ works: each term is odd, so $f$ is odd, and
      $1 slash x -> 0$ leaves the asymptote $y = -x$. Any
      $f(x) = -x + c slash x$ with $c eq.not 0$ does the same.],
  )

  #heuristic("work backwards from the goal")

  The common move in all three: write down the asymptote first, then
  add a correction term that dies off at infinity. Every rational
  function *is* its asymptote plus such a term — that is what the
  division in §4 says — so building one this way is not a trick, it is
  the definition read backwards.
]

== What Asymptotes Do Not Tell You

#only-theory[
  Two beliefs that most students arrive with, both false.

  *"The graph never touches its asymptote."* For a vertical asymptote,
  true — the function has no value there. For a horizontal or oblique
  one, false. The definition only requires the difference to tend to
  zero far out; it says nothing about what happens near the origin.
  The function
  $ f(x) = x / (x^2 + 1) $
  has the horizontal asymptote $y = 0$ and *sits on it* at $x = 0$.
  Worse, $sin(x) slash x$ has the same asymptote and crosses it
  infinitely often.

  #align(center)[
    #plot(
      xmin: -6.5, xmax: 6.5, ymin: -0.75, ymax: 0.75,
      width: 11, height: 4,
      axis-x-pos: "center", axis-y-pos: "center",
      xlabel: $x$, ylabel: $y$,
      xtick: (-6, -4, -2, 2, 4, 6), ytick: (-0.5, 0.5),
      show-origin: false,
      hline(0.0, stroke: stroke(
        paint: luma(110), thickness: 0.9pt, dash: "dashed",
      )),
      (
        fn: x => x / (x * x + 1.0), domain: (-6.3, 6.3),
        stroke: blue + 1.4pt, samples: 140,
        label: $f(x) = x/(x^2 + 1)$,
        label-pos: 0.93, label-side: "above-right",
      ),
      note([$y = 0$], (-6.2, 0.12), anchor: "west", size: 9pt),
    )
  ]

  *"A function has at most one horizontal asymptote."* False as soon
  as we leave rational functions: the two ends of the graph are two
  independent questions. For
  $ f(x) = x / (1 + e^x) $
  the values tend to $0$ as $x -> +oo$, while as $x -> -oo$ the term
  $e^x$ vanishes and $f(x)$ becomes indistinguishable from $x$. One
  horizontal asymptote on the right, one oblique asymptote on the
  left.
]

#only-high[
  === Asymptotic Curves and Non-Rational Functions

  The division rule in §4 covers the case $deg S gt.eq 2$ without
  comment, and it is worth taking seriously. For
  $ f(x) = (x^4 + 1) / x^2 = x^2 + 1/x^2 $
  the graph approaches the *parabola* $y = x^2$ as
  $x -> plus.minus oo$. No line describes this end behavior, but a
  curve does, and the reasoning is unchanged: the difference tends to
  zero. Such a curve is sometimes called an asymptotic curve
  (#emph[Näherungskurve]).

  For functions that are not rational there is no division to perform,
  and each case needs its own argument. The tool is usually the
  conjugate trick from the limits chapter. You showed there that
  $ lim_(x -> oo) (sqrt(x^2 + x) - x) = 1/2, $
  which says precisely that $y = x + 1/2$ is an asymptote of
  $y = sqrt(x^2 + x)$ on the right.
]

#ex(difficulty: 3, time: "20 min", calculator: true, level: "high")[
  Can a single function have a vertical, a horizontal *and* an oblique
  asymptote all at once?
  #auto-parts(
    1,
    [Show that no *rational* function can.],
    [Find a function that does, or prove that none exists.],
  )
][
  #auto-parts(
    1,
    [For a rational function, division produces one quotient $S$, and
      $S$ is a single polynomial: either constant (horizontal) or of
      degree $1$ (oblique), never both. And $S$ describes both ends at
      once, since the remainder tends to $0$ in both directions. So
      the two are mutually exclusive. Vertical asymptotes are
      independent of this and may of course be present.],
    [Yes — drop the requirement of rationality, and use the fact that
      the two ends are independent. Take
      $ f(x) = x / (1 + e^x) + 1/x. $
      As $x -> +oo$ both terms vanish, giving the horizontal asymptote
      $y = 0$. As $x -> -oo$ the term $e^x$ vanishes and $1 slash x$
      does too, so $f(x) - x -> 0$: the oblique asymptote $y = x$. And
      at $x = 0$ the second term blows up, giving the vertical
      asymptote $x = 0$.],
  )

  #heuristic("solve a simpler version first")

  The moral is about where the rule in §4 gets its force. Polynomial
  division describes *both* ends with one object, which is exactly why
  a rational function's two ends can never disagree. Nothing in the
  definition of an asymptote requires that; it is a feature of the
  family.
]

== Putting It Together

#only-theory[
  Everything in the last three chapters now combines into a single
  routine. Given a function, determine in this order:

  + the domain, and the zeros;
  + any symmetry (even, odd, or neither);
  + the vertical asymptotes and holes;
  + the behavior as $x -> plus.minus oo$: horizontal, oblique, or
    neither;
  + a sketch consistent with all of the above.

  What is still missing from the list is where the graph turns around
  and how it bends between the features you have found. That is the
  next chapter, and it is the last one.
]

#ex(
  difficulty: 2,
  time: "30 min",
  calculator: true,
  hints: (
    [Do the five steps in the order given. The sketch is the last
      step, not the first — if you plot before you analyze, you will
      believe whatever the screen shows you.],
    [In (b), the numerator factors. In (c), check whether replacing
      $x$ by $-x$ changes anything before doing any other work.],
  ),
)[
  For each function, determine the domain and range, the zeros, whether
  the function is even or odd, and all asymptotes. Then sketch the
  graph.
  #auto-parts(
    2,
    [$f: y = x^2 - x - 12$],
    [$f: y = (x^2 - 1) / (x + 4)$],
    [$f: y = (x^2 + 1) / (x^2 - 1)$],
    [$f: y = sqrt(4 - x^2)$],
  )
][
  #auto-parts(
    1,
    [Domain $RR$; zeros $x = -3$ and $x = 4$; neither even nor odd;
      no asymptotes. The vertex sits at $x = 1/2$ with
      $y = -49/4$, so the range is $[-49/4, oo)$.],
    [Domain $RR without {-4}$; zeros $x = plus.minus 1$; neither even
      nor odd. Vertical asymptote $x = -4$ (the numerator is $15$
      there); division gives $x - 4 + 15 slash (x + 4)$, so the
      oblique asymptote is $y = x - 4$. The range is *not* all of
      $RR$: solving $y = (x^2 - 1) slash (x + 4)$ for $x$ gives
      $x^2 - y dot x - (4 y + 1) = 0$, which has a real solution only
      when its discriminant $y^2 + 16 y + 4$ is non-negative, i.e.
      $ Y = (-oo, -8 - 2 sqrt(15)] union [-8 + 2 sqrt(15), oo)
        approx (-oo, -15.75] union [-0.25, oo). $
      The two excluded numbers are the heights of a local maximum and
      a local minimum — features we can only locate by hand for now,
      and will be able to find directly in the next chapter.],
    [Domain $RR without {-1, 1}$; no zeros, since $x^2 + 1 > 0$
      always; *even*, since replacing $x$ by $-x$ changes nothing.
      Vertical asymptotes $x = plus.minus 1$; equal degrees give the
      horizontal asymptote $y = 1$. On $|x| > 1$ the values run
      through $(1, oo)$; on $|x| < 1$ the denominator is negative and
      the values run through $(-oo, -1]$, the endpoint being attained
      at $x = 0$. So the range is
      $(-oo, -1] union (1, oo)$.],
    [Domain $[-2, 2]$; zeros $x = plus.minus 2$; *even*; no asymptotes
      — the graph simply stops. Range $[0, 2]$: it is the upper half
      of the circle $x^2 + y^2 = 4$.],
  )

  Part (d) is a useful reminder that a graph can end without any
  asymptote being involved. Running out of domain and running off to
  infinity are different things.
]

#ai-box(role: "Explainer")[
  Ask an AI assistant to explain why a rational function whose
  numerator has degree two more than its denominator has no straight
  asymptote — and to do it *without* using the word "division". Then
  ask for a second explanation that does use division. Which of the two
  would you have found more convincing a week ago, and which do you
  find more convincing now?

  Then check the claim yourself on
  $f(x) = (x^4 + 1) slash (x^2 + 1)$: divide it out and describe the
  end behavior in your own words.
]

#print-hints()
#print-vocab()
