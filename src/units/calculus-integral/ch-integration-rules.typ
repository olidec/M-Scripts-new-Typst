#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Techniques of Integration")
#let ex = exercise.with(chapter: "Techniques of Integration")

// ── TEACHER'S NOTE ───────────────────────────────────────────
// SCOPE SPLIT. Neither Lehrplan names a technique — both GLF Y4 1.1
// and SPF Y4 1.1 say only "die wichtigsten Integrationsregeln
// anwenden" — so the division is a deliberate teaching decision:
//
//   GLF gets reversing the chain rule as an INTUITIVE, recognitional
//   technique only (§1-2). Guess the antiderivative, differentiate
//   the guess, adjust the constant. No u, no du, no change of limits.
//   The inner function will usually be linear, which is the case
//   already met in ch-antiderivative; other compositions appear, but
//   only where the derivative of the inner function is visibly
//   present as a factor, and always handled by guess-and-adjust.
//
//   SPF gets the same material and then the machinery: the
//   substitution rule stated and justified, the differential dif u,
//   definite integrals with changed limits (§3-4), and integration by
//   parts with theory and practice (§5).
//
// The reason for the asymmetry is not that GLF students cannot manage
// substitution notation. It is that guess-and-adjust is entirely
// sufficient for every integrand they will meet, is faster, and
// cannot produce the two errors the formal method invites — a
// leftover x after substituting, and old limits kept with a new
// variable. GLF also has no CAS to catch either.
//
// PRACTICAL CONSEQUENCE for the exercise sheets: §1 and §2 are the
// GLF technique chapter in full. Everything from §3 onwards is
// only-high, so the basic sheet runs §1, §2, §6.
//
// §6 IS NOT FILLER, and matters most for GLF. The TI-30X Pro
// MathPrint has a numerical integrator and no CAS, so §6 IS the GLF
// method for anything hard. Teaching recognition without teaching its
// limits produces students who grind at e^(-x²) for twenty minutes.
//
// The old LaTeX notes have no techniques chapter at all; old Ex 78(h)
// and (i) need linear substitution (taught in ch-antiderivative) and
// old Ex 80(f) needs more.

= Techniques of Integration

#only-theory[
  The fundamental theorem reduced every definite integral to a single
  question: what is an antiderivative of the integrand? That is
  progress, but it relocates the difficulty rather than removing it.

  Differentiation is an algorithm. Give it any function built from the
  elementary ones and the four rules will grind out the derivative,
  every time, with no cleverness required. Integration has no such
  algorithm. There are techniques, each handling a family of cases,
  and a great deal of pattern recognition — which is why Courant
  called differentiation a craft and integration an art.

  This chapter covers the recognition that matters most, and is honest
  about what happens when it fails.
]

#epigraph(by: "Anonymous")[
  Differentiation is mechanics; integration is art.
]

#objectives(
  bfkm[recognize an integrand produced by the chain rule, and
    integrate it by reversing that rule],
  [verify an antiderivative by differentiating it, and adjust a
    constant factor when the guess is out by one],
  [recognize and integrate quotients of the form
    $f'(x) slash f(x)$],
  [recognize when no elementary antiderivative is available, and
    integrate numerically instead],
  obj(level: "high")[carry out a substitution formally, including the
    differential, and evaluate a definite integral by changing the
    limits of integration],
  obj(level: "high")[integrate by parts, and choose the two factors
    sensibly],
)

== Reversing the Chain Rule

#only-theory[
  Differentiating $(x^2 + 1)^6$ with the chain rule gives
  $ 6 dot (x^2 + 1)^5 dot 2 x. $
  Read that backwards. An integrand consisting of a *composite
  function* multiplied by *the derivative of its inner function* is
  exactly what the chain rule produces — so such an integrand can be
  integrated by undoing the chain rule.

  You have already done this once. In the antiderivative chapter,
  $ integral f(a dot x + b) dif x = 1/a dot F(a dot x + b) + C $
  was exactly this reversal for a *linear* inner function, where the
  derivative of the inner function is the constant $a$ and can simply
  be divided out. That case is the common one and it remains the one
  to look for first.

  What follows extends the same move to inner functions that are not
  linear — but only when their derivative is visibly present as a
  factor in the integrand.
]

#keybox(title: "Guess, differentiate, adjust")[
  If the integrand has the form
  $ g(f(x)) dot f'(x) $
  — a composite function multiplied by the derivative of its inner
  function — then:

  + *Guess* $G(f(x))$, where $G$ is an antiderivative of the outer
    function $g$.
  + *Differentiate* the guess with the chain rule.
  + *Adjust* by whatever constant factor is needed to match the
    integrand.

  Step 2 is not optional and step 3 is never more than a constant. If
  the guess is out by a factor involving $x$, the method does not
  apply to that integrand.
]

#example(title: "The pattern, spelled out")[
  Find $integral 2 x dot (x^2 + 1)^5 dif x$.

  The inner function is $x^2 + 1$, and its derivative $2 x$ is
  standing there as a factor. The outer function is the fifth power,
  whose antiderivative is a sixth power over six — so *guess*
  $ G = 1/6 dot (x^2 + 1)^6. $
  *Differentiate:*
  $ G' = 1/6 dot 6 dot (x^2 + 1)^5 dot 2 x = 2 x dot (x^2 + 1)^5. $
  That is the integrand exactly, so no adjustment is needed:
  $ integral 2 x dot (x^2 + 1)^5 dif x
    = 1/6 dot (x^2 + 1)^6 + C. $
]

#example(title: "When the constant does not quite match")[
  Find $integral x dot e^(x^2) dif x$.

  Inner function $x^2$, derivative $2 x$ — and the integrand has only
  $x$, half of what is needed. Guess anyway:
  $ G = e^(x^2), quad
    G' = e^(x^2) dot 2 x. $
  Twice too big, so halve it:
  $ integral x dot e^(x^2) dif x = 1/2 e^(x^2) + C. $
  Differentiating $1/2 e^(x^2)$ confirms it.
]

#warning[
  A *constant* can be adjusted; a *function of $x$* cannot.

  $ integral e^(x^2) dif x $
  looks almost identical to the previous example and is completely
  different. Guessing $e^(x^2)$ gives a derivative of
  $e^(x^2) dot 2 x$, and the correction needed is division by $2 x$ —
  which is not a constant. There is nothing to adjust.

  This integrand has no elementary antiderivative at all. See §4.
]

#example(title: "A trigonometric inner function")[
  Find $integral cos(x) dot e^(sin(x)) dif x$.

  Inner function $sin(x)$, whose derivative $cos(x)$ is present as a
  factor. Guess $e^(sin(x))$ and differentiate:
  $ (e^(sin(x)))' = e^(sin(x)) dot cos(x), $
  which is the integrand. So
  $ integral cos(x) dot e^(sin(x)) dif x = e^(sin(x)) + C. $
]

#remark[
  Every one of these answers was checked by differentiating it. That
  is not diligence; it is the method. Integration is the one topic in
  this course where verifying your own answer is completely reliable
  and takes ten seconds, and there is accordingly never an excuse for
  a wrong antiderivative.
]

=== Exercises

#ex(
  difficulty: 2,
  time: "25 min",
  calculator: false,
  hints: (
    [First ask whether the inner function is linear — most of these
      are, and then the correction is just one over the coefficient of
      $x$.],
    [For the rest: is some function's derivative sitting there as a
      factor? Guess the antiderivative of the outer function applied
      to the inner one, then differentiate your guess.],
  ),
)[
  Integrate by reversing the chain rule. Differentiate every answer to
  check it.
  #auto-parts(
    2,
    [$integral (3 x - 1)^4 dif x$],
    [$integral e^(2 x) dif x$],
    [$integral 2 x dot (x^2 + 1)^5 dif x$],
    [$integral x dot sqrt(x^2 + 9) dif x$],
    [$integral cos(x) dot e^(sin(x)) dif x$],
    [$integral sin(x) dot cos(x) dif x$],
  )
][
  #auto-parts(
    2,
    [Linear inner function: $1/15 (3 x - 1)^5 + C$.],
    [Linear inner function: $1/2 e^(2 x) + C$.],
    [$1/6 (x^2 + 1)^6 + C$],
    [Guess $(x^2 + 9)^(3/2)$; its derivative is
      $3/2 (x^2+9)^(1/2) dot 2 x = 3 x sqrt(x^2 + 9)$, three times too
      big, so
      $ 1/3 (x^2 + 9)^(3/2) + C. $],
    [$e^(sin(x)) + C$],
    [Inner function $sin(x)$, derivative $cos(x)$ present. Guess
      $sin^2(x)$, whose derivative is $2 sin(x) cos(x)$ — twice too
      big, so $1/2 sin^2(x) + C$.],
  )

  Part (f) has a second correct answer. Taking $cos(x)$ as the inner
  function instead gives $-1/2 cos^2(x) + C$, which differs from the
  first by a constant since $sin^2 + cos^2 = 1$. Two correct
  antiderivatives of the same function always differ by a constant, so
  a mismatch with the answer key is not automatically an error —
  differentiate and see.
]

== The Logarithmic Case

#only-theory[
  One pattern occurs often enough to be worth recognizing on sight: a
  quotient whose numerator is the derivative of its denominator.
]

#keybox(title: "Derivative over function")[
  $ integral (f'(x)) / (f(x)) dif x = ln(abs(f(x))) + C. $

  Whenever the numerator of a quotient is the derivative of its
  denominator — even up to a constant factor — the answer is a
  logarithm.
]

#example(title: "Three logarithms")[
  $ integral (3 x^2) / (x^3 + 2) dif x = ln(abs(x^3 + 2)) + C, $
  since $3 x^2$ is exactly the derivative of $x^3 + 2$.

  $ integral x / (x^2 + 1) dif x = 1/2 ln(x^2 + 1) + C, $
  where the numerator is half the derivative, so the guess
  $ln(x^2+1)$ comes out twice too big and is halved. (No absolute
  value is needed here — $x^2 + 1$ is always positive.)

  $ integral tan(x) dif x = integral (sin(x)) / (cos(x)) dif x
    = -ln(abs(cos(x))) + C, $
  where the numerator is *minus* the derivative of the denominator.
  This is how the tangent gets integrated, and it is worth
  remembering as a result in its own right.
]

#ex(difficulty: 2, time: "15 min", calculator: false)[
  Integrate.
  #auto-parts(
    2,
    [$integral (2 x) / (x^2 + 5) dif x$],
    [$integral 1 / (x dot ln(x)) dif x$],
    [$integral (e^x) / (e^x + 1) dif x$],
    [$integral (x^2) / (x^3 - 4) dif x$],
  )
][
  #auto-parts(
    2,
    [$ln(x^2 + 5) + C$],
    [Read it as $(1 slash x) slash ln(x)$: the numerator is the
      derivative of the denominator, so $ln(abs(ln(x))) + C$.],
    [$ln(e^x + 1) + C$],
    [The numerator is one third of the derivative, so
      $1/3 ln(abs(x^3 - 4)) + C$.],
  )

  Part (b) is the one students most often miss, because $1 slash x$
  does not look like a derivative until you remember whose it is.
]

#only-high[
  == The Substitution Rule

  Guess-and-adjust works, and for straightforward integrands it is
  the fastest route. But it depends on being able to see the answer
  before writing it, and on complicated integrands that becomes a
  gamble. The formal version of the same idea removes the guesswork.

  Introduce a new variable for the inner function:
  $ u = f(x), quad dif u = f'(x) dif x. $
  Then the integrand $g(f(x)) dot f'(x) dif x$ becomes $g(u) dif u$
  outright, and what remains is an integral in $u$ with no $x$ in it
  at all.

  #keybox(title: "Substitution")[
    If $G$ is an antiderivative of $g$, then
    $ integral g(f(x)) dot f'(x) dif x
      = integral g(u) dif u = G(u) + C = G(f(x)) + C. $

    In practice: choose $u = f(x)$, compute
    $dif u = f'(x) dif x$, rewrite the whole integral in terms of $u$,
    integrate, and substitute back.
  ]

  #warning[
    After substituting, *no $x$ may remain anywhere* — not in the
    integrand, not in the differential. If one does, the substitution
    was the wrong one, or the integrand is not of this form at all.

    This is the check that makes the formal method safer than
    guessing: it tells you immediately when the method does not apply,
    whereas a guess can be wrong in a way that is only visible after
    differentiating it.
  ]

  #example(title: "A substitution written out in full")[
    Find $integral (ln(x)) / x dif x$.

    Take $u = ln(x)$, so $dif u = 1/x dif x$. The integrand contains
    $ln(x)$ and a factor $1 slash x$, which is precisely $dif u$:
    $ integral (ln(x)) / x dif x
      = integral u dif u
      = 1/2 u^2 + C
      = 1/2 (ln(x))^2 + C. $
  ]

  #example(title: "Adjusting inside the substitution")[
    Find $integral x^2 dot (x^3 - 5)^7 dif x$.

    Take $u = x^3 - 5$, so $dif u = 3 x^2 dif x$, which gives
    $x^2 dif x = 1/3 dif u$:
    $ integral (x^3 - 5)^7 dot x^2 dif x
      = 1/3 integral u^7 dif u
      = 1/24 u^8 + C
      = 1/24 (x^3 - 5)^8 + C. $
    Note where the constant went: it was absorbed at the moment
    $dif u$ was computed, rather than patched on at the end.
  ]

  #ex(
    difficulty: 2,
    time: "20 min",
    calculator: false,
    level: "high",
    hints: (
      [Name $u$ and compute $dif u$ before touching the integral.],
      [If an $x$ survives the substitution, stop and reconsider the
        choice of $u$.],
    ),
  )[
    Integrate by substitution, showing $u$ and $dif u$ explicitly.
    #auto-parts(
      2,
      [$integral (2 x + 1) dot (x^2 + x)^4 dif x$],
      [$integral (ln(x)) / x dif x$],
      [$integral x^2 dot (x^3 - 5)^7 dif x$],
      [$integral (sin(x))^3 dot cos(x) dif x$],
      [$integral x / sqrt(1 - x^2) dif x$],
      [$integral (e^(1 slash x)) / x^2 dif x$],
    )
  ][
    #auto-parts(
      2,
      [$u = x^2 + x$, $dif u = (2 x + 1) dif x$: #h(0.4em)
        $1/5 (x^2 + x)^5 + C$],
      [$u = ln(x)$, $dif u = 1/x dif x$: #h(0.4em)
        $1/2 (ln(x))^2 + C$],
      [$u = x^3 - 5$, $x^2 dif x = 1/3 dif u$: #h(0.4em)
        $1/24 (x^3 - 5)^8 + C$],
      [$u = sin(x)$, $dif u = cos(x) dif x$: #h(0.4em)
        $1/4 sin^4(x) + C$],
      [$u = 1 - x^2$, $x dif x = -1/2 dif u$: #h(0.4em)
        $-sqrt(1 - x^2) + C$],
      [$u = 1 slash x$, $dif u = -1 slash x^2 dif x$: #h(0.4em)
        $-e^(1 slash x) + C$],
    )

    Part (f) is the one where guessing would have been hard and the
    formal method is easy: the derivative of $1 slash x$ is
    $-1 slash x^2$, which is present up to sign, but that is far from
    obvious by eye.
  ]

  == Definite Integrals by Substitution

  For a definite integral there are two honest routes, and it is worth
  being deliberate about which one you are taking.

  *Substitute back.* Find the antiderivative in terms of $x$, then
  evaluate between the original limits. Safe, and one line longer.

  *Change the limits.* If $u = f(x)$, then as $x$ runs from $a$ to
  $b$, the new variable $u$ runs from $f(a)$ to $f(b)$:
  $ integral_a^b g(f(x)) dot f'(x) dif x
    = integral_(f(a))^(f(b)) g(u) dif u, $
  and you never return to $x$ at all.

  #warning[
    What you must not do is mix the two — change the variable and keep
    the old limits. Once the integrand is written in $u$, the numbers
    on the integral sign are values of $u$, and writing
    $x$\u{2011}values there is simply a different integral.

    Whenever you change variable, change the limits in the same breath
    or not at all.
  ]

  #example(title: "Both routes, same answer")[
    Evaluate $integral_0^(pi/2) sin^2(x) dot cos(x) dif x$.

    *Changing the limits.* With $u = sin(x)$ and
    $dif u = cos(x) dif x$: when $x = 0$, $u = 0$; when
    $x = pi/2$, $u = 1$. So
    $ integral_0^1 u^2 dif u = [1/3 u^3]_0^1 = 1/3. $

    *Substituting back.* The antiderivative is $1/3 sin^3(x)$, and
    $ [1/3 sin^3(x)]_0^(pi/2) = 1/3 - 0 = 1/3. $
  ]

  #ex(difficulty: 2, time: "18 min", calculator: false, level: "high")[
    Evaluate, changing the limits of integration.
    #auto-parts(
      2,
      [$integral_0^1 x dot e^(x^2) dif x$],
      [$integral_1^e (ln(x)) / x dif x$],
      [$integral_0^2 x / (x^2 + 1) dif x$],
      [$integral_0^(pi/2) cos(x) dot sqrt(sin(x)) dif x$],
    )
  ][
    #auto-parts(
      2,
      [$u = x^2$ runs from $0$ to $1$: #h(0.4em)
        $1/2 [e^u]_0^1 = 1/2 (e - 1) approx 0.859$],
      [$u = ln(x)$ runs from $0$ to $1$: #h(0.4em)
        $[1/2 u^2]_0^1 = 1/2$],
      [$u = x^2 + 1$ runs from $1$ to $5$: #h(0.4em)
        $1/2 [ln(u)]_1^5 = 1/2 ln(5) approx 0.805$],
      [$u = sin(x)$ runs from $0$ to $1$: #h(0.4em)
        $[2/3 u^(3/2)]_0^1 = 2/3$],
    )

    In every case the new limits are values of $u$, not of $x$. Part
    (b) is the clearest illustration: the $x$\u{2011}limits $1$
    and $e$ become the $u$\u{2011}limits $0$ and $1$, which look
    nothing like them.
  ]

  == Integration by Parts

  Substitution reverses the chain rule. The product rule also has a
  reverse, and it is the last general technique in this course.

  Start from
  $ (u dot v)' = u' dot v + u dot v' $
  and integrate both sides. The left side integrates to $u dot v$, so
  $ u dot v = integral u' dot v dif x + integral u dot v' dif x, $
  and rearranging gives the rule.

  #keybox(title: "Integration by parts")[
    $ integral u(x) dot v'(x) dif x
      = u(x) dot v(x) - integral u'(x) dot v(x) dif x. $
  ]

  Notice what this does and does not do. It does not evaluate the
  integral — it *trades* it for a different one. The technique is
  worth using only when the new integral is easier than the old, and
  that depends entirely on which factor you call $u$.

  #keybox(title: [Choosing $u$])[
    Pick $u$ to be the factor that gets *simpler* when differentiated,
    and $v'$ to be the factor you can integrate.

    - A power of $x$ is a good $u$: differentiating drops the degree,
      and repeating enough times removes it entirely.
    - $ln(x)$ is almost always $u$, since it differentiates to
      $1 slash x$ and has no easy antiderivative.
    - $e^x$, $sin(x)$ and $cos(x)$ are usually $v'$: they integrate as
      easily as they differentiate, so they are no obstacle either
      way.
  ]

  #example(title: "The standard case")[
    Find $integral x dot e^x dif x$.

    Take $u = x$ and $v' = e^x$, so $u' = 1$ and $v = e^x$:
    $ integral x dot e^x dif x
      = x dot e^x - integral 1 dot e^x dif x
      = x e^x - e^x + C
      = (x - 1) dot e^x + C. $
    The trade worked: the new integral had no $x$ in it at all.

    Had we chosen the other way round — $u = e^x$, $v' = x$ — we would
    have obtained
    $ integral x e^x dif x
      = 1/2 x^2 e^x - 1/2 integral x^2 e^x dif x, $
    which is correct and strictly worse. The power went *up*.
  ]

  #example(title: "A logarithm with nothing to pair it with")[
    Find $integral ln(x) dif x$.

    There appears to be only one factor. Write the integrand as
    $ln(x) dot 1$ and take $u = ln(x)$, $v' = 1$, so
    $u' = 1 slash x$ and $v = x$:
    $ integral ln(x) dif x
      = x dot ln(x) - integral 1/x dot x dif x
      = x ln(x) - x + C. $

    This is the standard way to integrate a logarithm, and the trick
    of supplying an invisible factor $1$ is worth remembering.
  ]

  #ex(
    difficulty: 3,
    time: "25 min",
    calculator: false,
    level: "high",
    hints: (
      [Write down $u$, $u'$, $v'$ and $v$ in a small table before
        substituting into the formula. Most errors here are
        bookkeeping.],
      [Part (d) needs the rule applied twice. Part (f) needs the
        invisible factor $1$.],
    ),
  )[
    Integrate by parts.
    #auto-parts(
      2,
      [$integral x dot sin(x) dif x$],
      [$integral x dot cos(x) dif x$],
      [$integral x dot ln(x) dif x$],
      [$integral x^2 dot e^x dif x$],
      [$integral x dot e^(-x) dif x$],
      [$integral ln(x) dif x$],
    )
  ][
    #auto-parts(
      1,
      [$u = x$, $v' = sin(x)$, so $v = -cos(x)$:
        $ -x cos(x) + integral cos(x) dif x
          = -x cos(x) + sin(x) + C. $],
      [$u = x$, $v' = cos(x)$: #h(0.4em) $x sin(x) + cos(x) + C$.],
      [$u = ln(x)$, $v' = x$, so $v = 1/2 x^2$:
        $ 1/2 x^2 ln(x) - integral 1/2 x dif x
          = 1/2 x^2 ln(x) - 1/4 x^2 + C. $],
      [$u = x^2$, $v' = e^x$ gives
        $x^2 e^x - 2 integral x e^x dif x$, and the remaining integral
        is the worked example above:
        $ (x^2 - 2 x + 2) dot e^x + C. $],
      [$u = x$, $v' = e^(-x)$, so $v = -e^(-x)$:
        $ -x e^(-x) + integral e^(-x) dif x
          = -(x + 1) dot e^(-x) + C. $],
      [$x ln(x) - x + C$, as worked above.],
    )

    #heuristic("solve a simpler version first")

    Part (d) shows the general shape: each application of the rule
    lowers the power by one, so $integral x^n e^x dif x$ takes $n$
    applications and always terminates.
  ]

  #ex(difficulty: 3, time: "12 min", calculator: false, level: "high")[
    Decide, for each integral, whether it calls for substitution or
    for integration by parts, and say how you knew. Then evaluate it.
    #auto-parts(
      2,
      [$integral x dot e^(x^2) dif x$],
      [$integral x dot e^x dif x$],
      [$integral x^2 dot sqrt(x^3 + 1) dif x$],
      [$integral x^2 dot ln(x) dif x$],
    )
  ][
    #auto-parts(
      1,
      [*Substitution.* The factor $x$ is (half) the derivative of the
        inner function $x^2$:
        $1/2 e^(x^2) + C$.],
      [*Parts.* The factor $x$ is not the derivative of anything
        inside $e^x$ — there is no inner function at all:
        $(x - 1) e^x + C$.],
      [*Substitution*, $u = x^3 + 1$:
        $2/9 (x^3 + 1)^(3/2) + C$.],
      [*Parts*, $u = ln(x)$, $v' = x^2$:
        $1/3 x^3 ln(x) - 1/9 x^3 + C$.],
    )

    The diagnostic is the same each time: *is one factor the
    derivative of something inside the other?* If yes, substitute. If
    the two factors are merely multiplied together with no such
    relationship, parts is the candidate. Compare (a) with (b) — the
    integrands differ by a single exponent and need different
    techniques entirely.
  ]
]

== When Nothing Works

#only-theory[
  It is important to know that the techniques of this chapter are not
  a complete method, and that no complete method exists.

  Every one of the following is a perfectly ordinary continuous
  function with perfectly ordinary antiderivatives — and none of those
  antiderivatives can be written using powers, roots, exponentials,
  logarithms and trigonometric functions:
  $ e^(-x^2), quad (sin(x))/x, quad sqrt(1 + x^4), quad 1/ln(x). $

  This is a theorem, proved in the 19th century, not an admission that
  nobody has been clever enough yet. The first of them is the normal
  distribution's bell curve, which is why every probability of the
  form $p(a < X < b)$ for a normal variable has to be looked up in a
  table or computed by a machine.
]

#keybox(title: "The honest response")[
  When you meet a definite integral you cannot do:

  + Check first that the chain rule really cannot be reversed — look
    for an inner function whose derivative is present as a factor.
  + If it is not there, integrate *numerically*. Both the TI-30X Pro
    MathPrint and the TI-Nspire have a numerical integration function;
    it takes the integrand and the two limits and returns a number.
  + Report the answer as a decimal, and say that it was obtained
    numerically.

  A numerical answer is a real answer. What is not acceptable is
  spending twenty minutes hunting for a pattern that is not there.
]

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: true,
  hints: (
    [Look for the derivative of the inner function. If it is present
      up to a constant, reverse the chain rule; if it is absent, go
      numerical.],
  ),
)[
  For each integral, decide whether the chain rule can be reversed. If
  it can, evaluate the integral exactly; if it cannot, evaluate it
  numerically to three decimal places.
  #auto-parts(
    2,
    [$integral_0^1 x dot e^(-x^2) dif x$],
    [$integral_0^1 e^(-x^2) dif x$],
    [$integral_1^2 (2 x) / (x^2 + 3) dif x$],
    [$integral_1^2 1 / (x^2 + 3) dif x$],
  )
][
  #auto-parts(
    1,
    [The factor $x$ is present, so guess $e^(-x^2)$; its derivative is
      $-2 x e^(-x^2)$, so divide by $-2$:
      $ -1/2 [e^(-x^2)]_0^1 = 1/2 dot (1 - e^(-1)) approx 0.316. $],
    [The factor $x$ is missing, and nothing can supply it — this is
      the standard example of a non-elementary integral. Numerically,
      $approx 0.747$.],
    [The numerator is the derivative of the denominator:
      $ [ln(x^2 + 3)]_1^2 = ln(7) - ln(4) = ln(7/4) approx 0.560. $],
    [The numerator is not the derivative of anything useful.
      Numerically, $approx 0.193$. (There is in fact a closed form
      involving the inverse tangent, which is outside this course.)],
  )

  The pairs (a)/(b) and (c)/(d) differ only by the presence or absence
  of a factor in the numerator, and that single factor is the whole
  difference between a one-line exact answer and a numerical one.
]

#ai-box(role: "Checker")[
  Ask an AI assistant for $integral x dot cos(x^2) dif x$ and for
  $integral cos(x^2) dif x$. The first reverses the chain rule
  routinely; the second has no elementary antiderivative — its closed
  form involves a special function called the Fresnel integral, which
  was invented precisely because no elementary expression exists.

  Differentiate whatever it gives you for the second. Then ask
  directly: *"does that function have an elementary antiderivative?"*
  Watching a model handle the difference between "I cannot find it"
  and "it does not exist" is instructive, and the distinction matters
  in this chapter more than anywhere else in the course.
]

#print-hints()
#print-vocab()
