#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Rules for Differentiation")
#let ex = exercise.with(chapter: "Rules for Differentiation")

// ── TEACHER'S NOTE ───────────────────────────────────────────
// STRUCTURAL DEPENDENCY worth knowing about. The exercise sets for
// the product, quotient and chain rules only become rich once e^x,
// ln, sin and cos are available — but deriving THOSE needs the chain
// and quotient rules (a^x via e^(ln(a) x), tan via the quotient
// rule). The dependency runs both ways, so something has to be
// borrowed. The old LaTeX notes solved this by dropping a small table
// of special derivatives into §4.1 without comment; this chapter does
// the same thing but labels it honestly as an IOU (§2, "Four
// Derivatives on Credit") with a look-ahead to the next chapter.
// If you would rather not borrow, every exercise marked with a
// dagger in the source comments can be dropped and the chapter still
// works on polynomials and roots alone — but the sets get thin.
//
// §3 is a struggle-before-telling section and should be run as one:
// students test (f g)' = f' g' themselves and find it false BEFORE
// the product rule appears. The single counterexample f = g = x takes
// thirty seconds and does more than any amount of "be careful here".
// Do not shorten it.
//
// CORRECTION carried over from the old notes: in §4.5, Example 2
// (cos(1 - ln(x))) is introduced with "the derivative of f is
// calculated using the quotient rule". It is the chain rule; the
// phrase is a copy-paste artefact from the preceding section.

= Rules for Differentiation

#only-theory[
  Differentiating $x^2$ from the definition took four lines.
  Differentiating $sqrt(x)$ took a conjugate. Differentiating
  something like
  $ f(x) = x dot sqrt(1 - x^2) $
  from the definition is possible in principle and unpleasant in
  practice, and nobody does it.

  What saves us is that complicated functions are *built* out of
  simple ones — added, multiplied, divided, composed — and each of
  those four construction methods has a corresponding rule for
  derivatives. Learn four rules and you can differentiate essentially
  anything you will meet, without ever writing $lim_(h -> 0)$ again.

  Three of the four rules are surprising. That is worth knowing in
  advance, because the natural guess is wrong in each case, and the
  most efficient way to learn them is to make the guess, watch it
  fail, and then see what the correct rule repairs.
]

#epigraph(by: "Gottfried Wilhelm Leibniz, 1684")[
  From this, addition, subtraction, multiplication, division,
  powers and roots may be differentiated — and this is only the
  beginning.
]

#objectives(
  bfkm[differentiate sums, differences and constant multiples of
    functions],
  bfkm[differentiate products and quotients of elementary functions],
  bfkm[differentiate composite functions with the chain rule, after
    identifying the outer and inner functions],
  [combine several rules in one computation, and say which rule
    applies at which stage],
  [explain why the derivative of a product is not the product of the
    derivatives],
  obj(level: "high")[derive the product rule from the definition, and
    the quotient rule from the product rule],
)

== Sums and Constant Multiples

#only-theory[
  Start with the two rules that behave exactly as you would hope. Both
  follow from the definition in two lines, because the difference
  quotient splits along a sum.
]

#keybox(title: "Sum rule and constant multiple rule")[
  For differentiable $f$ and $g$ and any constant $c$:
  $ (f(x) + g(x))' &= f'(x) + g'(x), \
    (c dot f(x))' &= c dot f'(x). $
  The same holds for differences, since a difference is a sum with
  $c = -1$.
]

#example(title: "Why the sum rule is true")[
  $ (f + g)'(x)
    &= lim_(h -> 0) ((f(x+h) + g(x+h)) - (f(x) + g(x))) / h \
    &= lim_(h -> 0) ((f(x+h) - f(x)) / h + (g(x+h) - g(x)) / h) \
    &= f'(x) + g'(x). $
  The last step is the sum law for limits, and it needs both limits to
  exist — which is exactly the hypothesis "$f$ and $g$ differentiable".
]

#only-theory[
  Combined with the power rule, this already covers every polynomial.
  For $p(x) = 3 x^4 - 5 x^2 + 7 x - 2$:
  $ p'(x) = 12 x^3 - 10 x + 7. $
  Differentiate each term, multiply by its exponent, drop the exponent
  by one, and let the constant go to zero.
]

== Four Derivatives on Credit

#only-theory[
  The exercises in this chapter would be thin if polynomials and roots
  were all we had. So we borrow four results now and pay for them in
  the next chapter.
]

#keybox(title: [Four derivatives, to be justified in the next chapter])[
  #align(center, table(
    columns: 2,
    align: (center, center),
    stroke: 0.5pt + luma(180),
    inset: 8pt,
    [$f(x)$], [$f'(x)$],
    [$e^x$], [$e^x$],
    [$ln(x)$], [$1 slash x$],
    [$sin(x)$], [$cos(x)$],
    [$cos(x)$], [$-sin(x)$],
  ))
]

#look-ahead(
  title: "This is a loan, not a gift",
  preview: "derivatives of the elementary functions",
)[
  None of the four has been justified, and you should treat them as
  provisional until they are. The reason for the loan is a genuine
  circularity: the derivatives of $a^x$, $log_b (x)$ and $tan(x)$ are
  obtained *using* the chain and quotient rules of this chapter, so
  those rules have to come first — but the rules are hard to practise
  on polynomials alone.

  Two of the four are worth a moment's thought even now. $e^x$ is its
  own derivative, which says that its graph's steepness at every point
  equals its height there; that property is what singles out the number
  $e$ from every other base. And $sin$ and $cos$ hand the derivative
  back and forth between them, which is why they describe everything
  that oscillates.
]

#warning[
  All four require *radians*. In degree mode the derivative of
  $sin(x)$ is not $cos(x)$ but $(pi slash 180) dot cos(x)$, and every
  subsequent answer inherits the error. Set the calculator once, at the
  start of the unit, and leave it.
]

=== Exercises

#ex(difficulty: 1, time: "15 min", calculator: false)[
  Differentiate.
  #auto-parts(
    3,
    [$f(x) = x^5$],
    [$f(x) = (x - 4)^2$],
    [$f(x) = 4 ln(x)$],
    [$f(x) = 2 e^x + 3 x + 1$],
    [$f(x) = 3 cos(x)$],
    [$f(x) = e^2 dot x + sin(x)$],
    [$f(x) = sqrt(x) dot (root(3, x) + root(4, x))$],
    [$f(x) = (2 x^3 - x) / x$],
  )
][
  #auto-parts(
    3,
    [$5 x^4$],
    [Expand first: $x^2 - 8 x + 16$, so $f'(x) = 2 x - 8$.],
    [$4 slash x$],
    [$2 e^x + 3$],
    [$-3 sin(x)$],
    [$e^2 + cos(x)$],
    [$5/6 dot x^(-1/6) + 3/4 dot x^(-1/4)$],
    [Simplify first: $2 x^2 - 1$, so $f'(x) = 4 x$.],
  )

  Part (f) is the one that catches people: $e^2$ is a *number*, roughly
  $7.39$, not a function of $x$. So the first term is a constant times
  $x$ and differentiates to that constant. Compare it with
  $f(x) = e^(2 + x)$, whose derivative is $e^(2 + x)$ — the
  superscript matters.

  Parts (b), (g) and (h) all make the same point: a minute spent
  rewriting can spare you a rule you have not learned yet.
]

== The Guess That Fails

#exploration(title: "Is the derivative of a product the product of the derivatives?")[
  It would be convenient if
  $ (f(x) dot g(x))' = f'(x) dot g'(x). $

  + Test it on the simplest possible case: $f(x) = x$ and
    $g(x) = x$. What is the left-hand side? What is the right-hand
    side?
  + Test the corresponding guess for quotients,
    $(f slash g)' = f' slash g'$, on $f(x) = x^2$ and $g(x) = x$.
  + Test the corresponding guess for composition,
    $(u(v(x)))' = u'(v(x))$, on $u(x) = x^2$ and $v(x) = 2 x$. By what
    factor is the guess wrong, and where might that factor have come
    from?
  + Sums behaved. Products, quotients and compositions do not. Can you
    say what is different about addition?
]

#only-theory[
  Part 1 settles it in one line: $f dot g = x^2$, whose derivative is
  $2 x$, while $f' dot g' = 1 dot 1 = 1$. The guess is not slightly
  off; it is wrong by a factor that itself depends on $x$.

  Part 4 is the one worth discussing. The difference quotient of a
  *sum* splits into two difference quotients immediately, because
  $(A + B) - (C + D) = (A - C) + (B - D)$. Nothing similar happens for
  a product: $A dot B - C dot D$ does not decompose. Repairing that is
  what the next section does, and the repair is the product rule.
]

== The Product Rule

#keybox(title: "Product rule")[
  If $f(x) = u(x) dot v(x)$, then
  $ f'(x) = u'(x) dot v(x) + u(x) dot v'(x). $

  In words: *derivative of the first times the second, plus the first
  times the derivative of the second.*
]

#only-high[
  === Where It Comes From

  The obstacle in §3 was that $A dot B - C dot D$ does not split. The
  standard repair is to add and subtract a term that makes it split —
  a move worth recognizing, since it recurs throughout analysis.

  $ (u(x+h) dot v(x+h) - u(x) dot v(x)) / h $
  Insert $-u(x) dot v(x+h) + u(x) dot v(x+h)$, which changes nothing:
  $ &= (u(x+h) dot v(x+h) - u(x) dot v(x+h)
        + u(x) dot v(x+h) - u(x) dot v(x)) / h \
    &= v(x+h) dot (u(x+h) - u(x)) / h
       + u(x) dot (v(x+h) - v(x)) / h. $
  Now let $h -> 0$. The two difference quotients tend to $u'(x)$ and
  $v'(x)$. The remaining factor $v(x+h)$ tends to $v(x)$ — and *this*
  is where we need $v$ to be continuous, which it is, because it is
  differentiable. So
  $ f'(x) = v(x) dot u'(x) + u(x) dot v'(x). $

  The result is symmetric in $u$ and $v$, as it must be, since
  $u dot v = v dot u$.
]

#example(title: "A sanity check")[
  We already know $(x^2)' = 2 x$. Writing $x^2 = x dot x$ and applying
  the product rule:
  $ (x dot x)' = (x)' dot x + x dot (x)' = x + x = 2 x. $
  Agreement is not a proof, but a rule that failed this test would be
  finished.
]

#example(title: "A product of unlike things")[
  Let $f(x) = (3 x + 1) dot ln(x)$. Then
  $ f'(x) = (3 x + 1)' dot ln(x) + (3 x + 1) dot (ln(x))'
    = 3 ln(x) + (3 x + 1) dot 1/x. $
  There is no obligation to simplify further, and often no advantage.
]

=== Exercises

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: false,
  hints: (
    [Name $u$ and $v$ explicitly in the margin before differentiating
      anything. Most errors here are bookkeeping errors, not calculus
      errors.],
  ),
)[
  Differentiate with the product rule. You need not simplify.
  #auto-parts(
    2,
    [$f(x) = (x^4 + 3 x^2 + 6) dot (2 x - 1)$],
    [$f(x) = e^x dot (5 x^3 + 4 x)$],
    [$f(x) = sin(x) dot cos(x)$],
    [$f(x) = e^x dot ln(x)$],
  )
][
  #auto-parts(
    1,
    [$f'(x) = (4 x^3 + 6 x) dot (2 x - 1) + (x^4 + 3 x^2 + 6) dot 2$],
    [$f'(x) = e^x dot (5 x^3 + 4 x) + e^x dot (15 x^2 + 4)$],
    [$f'(x) = cos(x) dot cos(x) + sin(x) dot (-sin(x))
      = cos^2(x) - sin^2(x)$],
    [$f'(x) = e^x dot ln(x) + e^x dot 1/x$],
  )

  Part (a) can be checked by expanding the product first and
  differentiating term by term. Do it once — the agreement is worth
  seeing, and after that you will never want to expand again.
]

#ex(difficulty: 3, time: "10 min", calculator: false, level: "high")[
  Find a rule for the derivative of a product of three functions,
  $ f(x) = u(x) dot v(x) dot w(x), $
  by applying the product rule twice. Then state the pattern for $n$
  factors.
][
  Group the first two: $f = (u dot v) dot w$, so
  $ f' = (u dot v)' dot w + (u dot v) dot w'
    = (u' dot v + u dot v') dot w + u dot v dot w' $
  $ = u' dot v dot w + u dot v' dot w + u dot v dot w'. $

  The pattern for $n$ factors: differentiate one factor at a time and
  leave the others alone, then add up all $n$ terms. As a check,
  applying it to $u = v = w = x$ gives $3 x^2$, which is the power rule
  for $x^3$.

  #heuristic("try small cases")
]

== The Quotient Rule

#keybox(title: "Quotient rule")[
  If $f(x) = u(x) / v(x)$ with $v(x) eq.not 0$, then
  $ f'(x) = (u'(x) dot v(x) - u(x) dot v'(x)) / (v(x))^2. $
]

#warning[
  Unlike the product rule, this one is *not* symmetric — a quotient is
  not, so its rule cannot be. The consequences: the numerator is a
  difference, so the order of the two terms matters and swapping them
  flips the sign of your answer; and the denominator is squared.

  The mnemonic that survives contact with exam pressure: *derivative
  of the top times the bottom, minus the top times the derivative of
  the bottom, all over the bottom squared* — and note that it starts
  with the top, exactly as the product rule starts with the first
  factor.
]

#only-high[
  === Where It Comes From

  There is no need to return to the definition. Suppose
  $q(x) = u(x) slash v(x)$ and assume it is differentiable. Then
  $u = q dot v$, and the product rule gives
  $ u' = q' dot v + q dot v'. $
  Solve for $q'$ and substitute $q = u slash v$:
  $ q' = (u' - q dot v') / v
    = (u' - (u dot v') / v) / v
    = (u' dot v - u dot v') / v^2. $

  #heuristic("work backwards from the goal")
]

#example(title: "The reciprocal, again")[
  For $f(x) = 1/x$, take $u(x) = 1$ and $v(x) = x$:
  $ f'(x) = (0 dot x - 1 dot 1) / x^2 = -1/x^2, $
  which agrees with the first-principles computation of the previous
  chapter and with the power rule applied to $x^(-1)$. Three routes,
  one answer.
]

#example(title: "The tangent function")[
  Since $tan(x) = sin(x) slash cos(x)$:
  $ (tan(x))'
    &= (cos(x) dot cos(x) - sin(x) dot (-sin(x))) / cos^2(x) \
    &= (cos^2(x) + sin^2(x)) / cos^2(x)
     = 1 / cos^2(x). $
  Dividing the Pythagorean identity through by $cos^2(x)$ instead gives
  the equivalent form
  $ (tan(x))' = 1 + tan^2(x), $
  and both appear in answer keys. They are the same function.
]

=== Exercises

#ex(difficulty: 2, time: "15 min", calculator: false)[
  Differentiate with the quotient rule. You need not simplify.
  #auto-parts(
    2,
    [$f(x) = (5 x + 3) / (x^2 + 1)$],
    [$f(x) = ln(x) / x$],
    [$f(x) = sin(x) / cos(x)$],
    [$f(x) = e^x / (e^x + 1)$],
  )
][
  #auto-parts(
    1,
    [$f'(x) = (5 dot (x^2 + 1) - (5 x + 3) dot 2 x) / (x^2 + 1)^2$],
    [$f'(x) = (1/x dot x - ln(x) dot 1) / x^2
      = (1 - ln(x)) / x^2$],
    [$f'(x) = 1 slash cos^2(x) = 1 + tan^2(x)$, as above.],
    [$f'(x) = (e^x dot (e^x + 1) - e^x dot e^x) / (e^x + 1)^2
      = e^x / (e^x + 1)^2$],
  )

  Part (d) simplifies remarkably: the $e^(2 x)$ terms in the numerator
  cancel. Always glance at the numerator after expanding — quotient
  rule answers collapse more often than product rule ones do.
]

== The Chain Rule

#only-theory[
  The last and most important rule. It is the one that makes the other
  three worth having, because almost every function of interest is a
  composition of something with something else.

  Recall the decomposition practice from the functions chapter: given
  $f$, identify the *outer* function $u$ and the *inner* function $v$
  so that $f(x) = u(v(x))$. The test was: given a number for $x$, what
  would you compute last?
]

=== First, the Decomposition

#ex(
  difficulty: 1,
  time: "10 min",
  calculator: false,
  hints: (
    [Imagine substituting $x = 2$ and working the expression out on
      paper. Write down the order of the operations you actually
      perform. The last one is the outer function.],
  ),
)[
  Before differentiating anything: for each function, decide whether it
  is a composition. If it is, write it as $f(x) = u(v(x))$ and state
  $u$ and $v$ explicitly. If it is not, say what it is instead.
  #auto-parts(
    2,
    [$f(x) = (2 x^2 + 3 x + 1)^3$],
    [$f(x) = e^(x^2)$],
    [$f(x) = x^2 dot e^x$],
    [$f(x) = ln(3 x^5)$],
    [$f(x) = (ln(x))^3$],
    [$f(x) = sqrt(x^2 + 9)$],
    [$f(x) = cos(x^3 - 1)$],
    [$f(x) = e^(sin(x^2))$],
  )
][
  #auto-parts(
    2,
    [$v(x) = 2 x^2 + 3 x + 1$, #h(0.4em) $u(x) = x^3$],
    [$v(x) = x^2$, #h(0.4em) $u(x) = e^x$],
    [Not a composition — a *product* of $x^2$ and $e^x$.],
    [$v(x) = 3 x^5$, #h(0.4em) $u(x) = ln(x)$],
    [$v(x) = ln(x)$, #h(0.4em) $u(x) = x^3$],
    [$v(x) = x^2 + 9$, #h(0.4em) $u(x) = sqrt(x)$],
    [$v(x) = x^3 - 1$, #h(0.4em) $u(x) = cos(x)$],
    [A composition of *three*: $x |-> x^2 |-> sin(x^2) |-> e^(sin(x^2))$.
      Read as a two-fold composition it is $v(x) = sin(x^2)$ with
      $u(x) = e^x$ — and $v$ is then itself a composition.],
  )

  Parts (d) and (e) are the pair to dwell on. They use the same two
  ingredients, $ln$ and the cube, in opposite roles, and the only
  thing on the page distinguishing them is where the bracket sits.
  Whichever function is on the *outside* is the one whose derivative
  gets evaluated at the other.

  Part (c) is there to keep the question honest: not every complicated
  expression is a composition, and reaching for the chain rule by
  reflex is as much an error as forgetting it.
]


#keybox(title: "Chain rule")[
  If $f(x) = u(v(x))$, then
  $ f'(x) = u'(v(x)) dot v'(x). $

  In words: *the derivative of the outer function, evaluated at the
  inner function, times the derivative of the inner function.*

  The final factor $v'(x)$ is what the naive guess in §3 was missing.
]

#only-theory[
  In Leibniz notation the rule becomes almost self-explanatory. Write
  $y = u(w)$ where $w = v(x)$. Then
  $ (dif y) / (dif x) = (dif y) / (dif w) dot (dif w) / (dif x). $

  As a *rate* statement this is obvious. If $y$ changes three times as
  fast as $w$, and $w$ changes five times as fast as $x$, then $y$
  changes fifteen times as fast as $x$. Rates multiply along a chain,
  which is where the rule gets its name — and why an exchange rate in
  francs per euro times one in euros per dollar gives francs per
  dollar.
]

#warning[
  The Leibniz form looks as though the $dif w$ terms cancel like
  ordinary fractions. They are not fractions, and they do not cancel;
  $dif y slash dif x$ is a single symbol for a limit, not a quotient of
  two quantities.

  That said, Leibniz chose the notation precisely so that it would
  behave this way, and the mnemonic is reliable. Use it — just do not
  mistake it for a proof.
]

#example(title: "A root of a polynomial")[
  Let $f(x) = sqrt(x^2 - x)$. Given a number, you would compute
  $x^2 - x$ first and take the root last, so
  $ v(x) = x^2 - x, quad u(x) = sqrt(x). $
  With $u'(x) = 1 slash (2 sqrt(x))$ and $v'(x) = 2 x - 1$:
  $ f'(x) = 1 / (2 sqrt(x^2 - x)) dot (2 x - 1). $
  Note that $u'$ is evaluated at the *inner function*, not at $x$ —
  the single most common chain rule error is writing
  $1 slash (2 sqrt(x))$ there.
]

#example(title: "A cosine of a logarithm")[
  Let $f(x) = cos(1 - ln(x))$. Here the outer function is $cos$ and the
  inner is $1 - ln(x)$, so
  $ f'(x) = -sin(1 - ln(x)) dot (-1/x)
    = sin(1 - ln(x)) / x. $
  Two minus signs meet and cancel, which is worth checking rather than
  hoping for.
]

#example(title: "A power of a polynomial")[
  Let $f(x) = (3 x^2 - 4 x + 1)^3$. Outer: cube. Inner: the quadratic.
  $ f'(x) = 3 dot (3 x^2 - 4 x + 1)^2 dot (6 x - 4). $
  Expanding the bracket first would give a polynomial of degree six and
  the same answer after considerably more work.
]

=== Exercises

#ex(
  difficulty: 2,
  time: "18 min",
  calculator: false,
  hints: (
    [Write down $u$ and $v$ separately before differentiating, exactly
      as in the functions chapter.],
    [Check every answer for the trailing factor $v'(x)$. If it is
      missing, the answer is wrong even if everything else is right.],
  ),
)[
  Differentiate with the chain rule. You need not simplify.
  #auto-parts(
    2,
    [$f(x) = 4 dot (2 x^2 + 3 x + 1)^3$],
    [$f(x) = e^(x^2)$],
    [$f(x) = ln(3 x^5)$],
    [$f(x) = (ln(x))^3$],
    [$f(x) = cos(x^3 - 1)$],
    [$f(x) = e^(sin(x^2))$],
  )
][
  #auto-parts(
    1,
    [$f'(x) = 12 dot (2 x^2 + 3 x + 1)^2 dot (4 x + 3)$],
    [$f'(x) = e^(x^2) dot 2 x$],
    [$f'(x) = 1/(3 x^5) dot 15 x^4 = 5/x$],
    [$f'(x) = 3 dot (ln(x))^2 dot 1/x$],
    [$f'(x) = -sin(x^3 - 1) dot 3 x^2$],
    [$f'(x) = e^(sin(x^2)) dot cos(x^2) dot 2 x$],
  )

  Compare (c) and (d) carefully. In (c) the logarithm is the *outer*
  function; in (d) it is the inner one, wrapped in a cube. The
  notations $ln(3 x^5)$ and $(ln(x))^3$ differ by the placement of a
  bracket and by nothing else, and they have completely different
  derivatives.

  Part (c) also collapses to $5 slash x$, which the logarithm laws
  predict: $ln(3 x^5) = ln(3) + 5 ln(x)$, whose derivative is $5/x$
  with no chain rule needed at all.

  Part (f) needed the chain rule twice — the inner function
  $sin(x^2)$ is itself a composition. That is the subject of the next
  section.
]

== Putting It All Together

#only-theory[
  Real functions rarely need exactly one rule. The question to ask
  first is always the same, and it is a structural question, not a
  computational one:

  #align(center, emph[
    *What is the last operation I would perform, given a number for
    $x$?*
  ])

  That operation names the rule. If the answer is "multiply two
  things", it is the product rule and each factor is a subproblem. If
  it is "divide", the quotient rule. If it is "apply a function to
  what I have got", the chain rule. Working outwards-in this way turns
  an intimidating expression into a short tree of small problems.
]

#keybox(title: "Strategy")[
  + Simplify first, if simplifying is easy. Expanding a bracket or
    splitting a logarithm can remove a rule entirely.
  + Identify the outermost operation; that fixes the first rule.
  + Apply it, leaving the sub-derivatives unevaluated for now.
  + Repeat on each sub-derivative until only elementary functions
    remain.
  + Simplify only if there is something to gain. An unsimplified but
    correct answer is worth more than a simplified but wrong one.
]

#ex(
  difficulty: 3,
  time: "30 min",
  calculator: false,
  hints: (
    [For each part, write down the outermost operation in words before
      touching a pencil to the algebra.],
    [In (c), the logarithm laws let you avoid the quotient rule
      entirely. In (e), rewrite the root as a power of $1 slash 2$
      only if that helps you.],
  ),
)[
  Differentiate, combining rules as needed. You need not simplify.
  #auto-parts(
    2,
    [$f(x) = x dot sqrt(1 - x^2)$],
    [$f(x) = e^(2 dot (3 x - 1)^4)$],
    [$f(x) = ln(x / (x^2 + 1))$],
    [$f(x) = cos(cos(x^2))$],
    [$f(x) = sqrt(e^(2 x) + e^(-2 x))$],
    [$f(x) = tan(e^x + x)$],
  )
][
  #auto-parts(
    1,
    [Outermost: a product. Product rule, with the chain rule inside:
      $ f'(x) = sqrt(1 - x^2) + x dot (-2 x) / (2 sqrt(1 - x^2))
        = (1 - 2 x^2) / sqrt(1 - x^2). $],
    [Outermost: the exponential. Chain rule twice:
      $ f'(x) = e^(2 dot (3 x - 1)^4) dot 2 dot 4 dot (3 x - 1)^3 dot 3
        = 24 dot (3 x - 1)^3 dot e^(2 dot (3 x - 1)^4). $],
    [Outermost: the logarithm — but split it first. Since
      $ln(x slash (x^2 + 1)) = ln(x) - ln(x^2 + 1)$,
      $ f'(x) = 1/x - (2 x) / (x^2 + 1) = (1 - x^2) / (x dot (x^2+1)). $
      The quotient rule inside a chain rule gives the same answer with
      three times the work.],
    [Outermost: the outer cosine. Chain rule twice:
      $ f'(x) = -sin(cos(x^2)) dot (-sin(x^2)) dot 2 x
        = 2 x dot sin(cos(x^2)) dot sin(x^2). $],
    [Outermost: the root. Chain rule, with a sum inside whose terms
      each need one more:
      $ f'(x) = (2 e^(2 x) - 2 e^(-2 x)) / (2 sqrt(e^(2 x) + e^(-2 x)))
        = (e^(2 x) - e^(-2 x)) / sqrt(e^(2 x) + e^(-2 x)). $],
    [Outermost: the tangent.
      $ f'(x) = (1 + tan^2(e^x + x)) dot (e^x + 1). $],
  )

  #heuristic("solve a simpler version first")

  Part (c) is the moral of the whole section. Two of the five steps
  disappear if you spend ten seconds on the logarithm laws first.
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  Each of the following "solutions" contains exactly one error. Find
  it, name the rule that was misapplied, and give the correct
  derivative.
  #auto-parts(
    1,
    [$f(x) = sin(3 x)$, #h(0.5em) $f'(x) = cos(3 x)$],
    [$f(x) = x^2 dot e^x$, #h(0.5em) $f'(x) = 2 x dot e^x$],
    [$f(x) = (x + 1) / x^2$, #h(0.5em)
      $f'(x) = (1 dot x^2 + (x + 1) dot 2 x) / x^4$],
    [$f(x) = sqrt(x^2 + 9)$, #h(0.5em)
      $f'(x) = 1 / (2 sqrt(x^2 + 9))$],
  )
][
  #auto-parts(
    1,
    [Chain rule: the factor $v'(x) = 3$ is missing.
      $f'(x) = 3 cos(3 x)$.],
    [Product rule: only the first term was written.
      $f'(x) = 2 x dot e^x + x^2 dot e^x$.],
    [Quotient rule: the numerator must be a *difference*.
      $f'(x) = (1 dot x^2 - (x + 1) dot 2 x) slash x^4$, which
      simplifies to $-(x + 2) slash x^3$.],
    [Chain rule: the factor $v'(x) = 2 x$ is missing.
      $f'(x) = x slash sqrt(x^2 + 9)$.],
  )

  Three of the four errors are the same error — a missing factor from
  a rule that was applied halfway. That is what most wrong answers in
  this chapter look like, so it is worth learning to spot the shape.
]

#ai-box(role: "Generator")[
  Ask an AI assistant to produce ten differentiation problems that
  require *at least two* of the four rules, using only $x$, $e^x$,
  $ln(x)$, $sin(x)$ and $cos(x)$ as ingredients — and to give you the
  problems only, not the answers. Work all ten. Only then ask for its
  solutions and compare.

  Then reverse the roles: give the assistant three of your own
  worked solutions, one of which you have deliberately sabotaged with
  a missing chain rule factor, and ask it to find the error. Note
  whether it finds the one you planted, and whether it "finds" any
  that are not there.
]

#print-hints()
#print-vocab()
