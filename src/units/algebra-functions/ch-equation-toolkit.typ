#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Solving Equations: A Toolkit")
#let ex = exercise.with(chapter: "Solving Equations: A Toolkit")

= Solving Equations: A Toolkit

#only-theory[
  Over the past few chapters we've built up a whole collection of
  techniques for solving equations -- one method per type of
  function. This chapter collects them all in one place, adds the two
  techniques we're still missing (radical equations, and equations
  that are secretly linear or quadratic in disguise), and then gives
  you a large pile of practice at the hardest part of all: figuring
  out *which* technique a given equation actually needs.
]

#objectives(
  bfkm[recognize which algebraic technique an equation calls for --
    linear, quadratic, radical, exponential, or logarithmic],
  bfkm[solve radical equations by isolating and raising to a power,
    and check for extraneous solutions],
  bfkm[solve exponential and logarithmic equations algebraically],
  [solve equations that become linear or quadratic after a
    substitution],
  [combine multiple techniques to solve equations that don't announce
    their type],
)

== How Do I Recognize This Equation?

#keybox(title: "A Decision Guide")[
  - $x$ appears only to the first power, with no roots or exponents
    involving $x$ $=>$ *linear*: isolate $x$.
  - $x^2$ appears (or the equation can be rewritten so it does)
    $=>$ *quadratic*: factor, complete the square, or use the
    quadratic formula. Check the discriminant if you're unsure how
    many solutions to expect.
  - $x$ sits *under a root* $=>$ *radical*: isolate the root, raise
    both sides to the matching power -- and always check your
    answers in the *original* equation.
  - $x$ sits *in an exponent* $=>$ *exponential*: try to write both
    sides with the same base; if that's not possible, take $log$ or
    $ln$ of both sides.
  - $x$ sits *inside a logarithm* $=>$ *logarithmic*: rewrite the
    equation without the logarithm, and always check that every
    logarithm's argument ends up positive.
]

#pagebreak()

== Linear Equations

#only-theory[
  Distribute, collect like terms, and isolate $x$. The only real
  danger is arithmetic slips -- there's no algebra here you haven't
  already mastered.
]

#ex(difficulty: 1, time: "10 min", keep-together: true)[
  Solve for $x$.
  #parts(
    2,
    [(a) $3 dot (x-2) + 5 = 2x - 1$],
    [(b) $(2x-1)/3 = (x+4)/2$],
    [(c) $5 - 2 dot (x+1) = 3 dot (2-x) + 4$],
  )
][
  #parts(2, [(a) $x=0$], [(b) $x=14$], [(c) $x=7$])
]

== Quadratic Equations

#only-theory[
  Factor when the numbers cooperate; otherwise complete the square or
  use the quadratic formula. Always check whether the equation is
  already in standard form $a x^2 + b x + c = 0$ before you start --
  many mistakes come from applying a method to an equation that
  isn't set up for it yet.
]

#ex(difficulty: 2, time: "15 min", keep-together: true)[
  Solve for $x$.
  #parts(
    2,
    [(a) $x^2 - 2x - 15 = 0$],
    [(b) $2x^2 - 3 = 5x$],
    [(c) $x^2 + 4x + 1 = 0$],
    [(d) $3x^2 = 12$],
  )
][
  #parts(
    2,
    [(a) $x=-3$ or $x=5$],
    [(b) $x=-1/2$ or $x=3$],
    [(c) $x = -2 plus.minus sqrt(3)$],
    [(d) $x = plus.minus 2$],
  )
]

== Radical Equations

#only-theory[
  In a #vocab("radical equation", "Wurzelgleichung"), the unknown
  sits under a root. The technique: isolate the root on one side,
  then raise both sides to the matching power to remove it.
]

#warning[
  Squaring both sides of an equation can *introduce* solutions that
  don't actually satisfy the original equation -- because squaring
  destroys sign information ($(-2)^2 = 2^2$, even though $-2 eq.not
  2$). Such a fake solution is called an
  #vocab("extraneous solution", "Scheinlösung"). You must substitute
  every candidate solution back into the *original* (unsquared)
  equation to check it's real.
]

#example[
  Solve $sqrt(x+3) = x - 3$.

  Both sides are already isolated, so square directly:
  $
    x + 3 = (x-3)^2 = x^2 - 6x + 9 quad => quad x^2 - 7x + 6 = 0
    quad => quad (x-1) dot (x-6) = 0.
  $
  So $x=1$ or $x=6$. *Checking both* in the original equation:
  - $x=1$: $sqrt(1+3) = 2$, but $x-3 = -2$. Since $2 eq.not -2$,
    this is *extraneous* -- reject it.
  - $x=6$: $sqrt(6+3) = 3$, and $x-3 = 3$. These match, so $x=6$ is
    a genuine solution.

  The only solution is $x = 6$.
]

#example[
  Solve $sqrt(3x-2) = sqrt(x+6)$.

  Squaring both sides removes both roots at once:
  $ 3x - 2 = x + 6 quad => quad 2x = 8 quad => quad x = 4. $
  Checking: both sides give $sqrt(10)$, so $x=4$ is genuine.
]

#ex(difficulty: 2, time: "25 min", keep-together: true)[
  Solve for $x$, checking for extraneous solutions.
  #parts(
    2,
    [(a) $sqrt(2x+7) = 3$],
    [(b) $sqrt(x+10) - x = -2$],
    [(c) $sqrt(3x-2) = sqrt(x+6)$],
    [(d) $sqrt(2x+3) = x$],
  )
][
  + $x=1$ (no extraneous solution here, since the right side was
    already a positive constant).
  + Isolating gives $sqrt(x+10) = x - 2$, which squares to
    $x^2-5x-6=0$, so $x=6$ or $x=-1$. Checking: $x=6$ works
    ($sqrt(16)=4=6-2$); $x=-1$ gives $sqrt(9)=3 eq.not -3$, so it's
    extraneous. Only $x=6$.
  + $x=4$ (shown above).
  + Squaring gives $x^2-2x-3=0$, so $x=3$ or $x=-1$. Checking:
    $x=3$ works ($sqrt(9)=3$); $x=-1$ gives $sqrt(1)=1 eq.not -1$,
    extraneous. Only $x=3$.
]

#ai-box(role: "Checker")[
  Pick one part of the exercise above. Solve it on paper, including
  the extraneous-solution check. Then ask an AI to solve the same
  equation. Did it check for extraneous solutions without being
  asked to? If not, that's worth remembering -- checking your own
  work matters even more with algebra an AI does for you.
]

== Exponential Equations

#only-theory[
  Recall the two techniques from the exponential and logarithm
  chapters: rewrite both sides with a common base if you can, or take
  $log$ or $ln$ of both sides if you can't.
]

#example[
  Solve $2^(x^2) = 8^x$.

  Rewrite $8$ as $2^3$, so both sides share base $2$:
  $
    2^(x^2) = 2^(3x) quad => quad x^2 = 3x quad => quad x^2 - 3x = 0
    quad => quad x dot (x - 3) = 0.
  $
  So $x = 0$ or $x = 3$ -- a same-base exponential equation that
  turned into an ordinary quadratic once the bases matched.
]

#ex(difficulty: 2, time: "20 min", keep-together: true)[
  Solve for $x$.
  #parts(
    2,
    [(a) $3^(x+1) = 27$],
    [(b) $5^(2x-1) = 40$],
    [(c) $2^(3x) = 1/8$],
  )
][
  #parts(
    2,
    [(a) $x = 2$ (same base)],
    [(b) $x = ln(40)/(2 dot ln(5)) + 1/2 approx 1.65$],
    [(c) $x = -1$ (same base)],
  )
]

== Logarithmic Equations

#only-theory[
  Combine logarithms into one using the laws of logarithms, then
  rewrite the equation without a logarithm at all -- and *always*
  check that every argument that ends up inside a logarithm is
  positive.
]

#example[
  Solve $log(x) + log(x-3) = 1$.

  Combine the left side into a single logarithm, then exponentiate:
  $
    log(x dot (x-3)) = 1 quad => quad x dot (x-3) = 10 quad =>
    quad x^2 - 3x - 10 = 0 quad => quad (x-5) dot (x+2) = 0.
  $
  So $x=5$ or $x=-2$. But the original equation needs $x>0$ *and*
  $x-3>0$, i.e. $x>3$. Only $x=5$ satisfies that -- $x=-2$ is
  rejected before we even check the arithmetic, because $log(-2)$
  doesn't exist.
]

#example[
  Solve $log(2x-1) - log(x) = log(3)$.

  $
    log((2x-1)/x) = log(3) quad => quad (2x-1)/x = 3 quad =>
    quad 2x - 1 = 3x quad => quad x = -1.
  $
  The algebra looks clean -- but the original equation needs
  $2x-1>0$ *and* $x>0$, i.e. $x > 1/2$. Since $x=-1$ fails this,
  it's rejected. *This equation has no solution.*
]

#ex(difficulty: 2, time: "20 min", keep-together: true)[
  Solve for $x$, checking the domain.
  #parts(
    2,
    [(a) $log_2 (x+1) = 3$],
    [(b) $ln(x) = 2$],
    [(c) $ln(x+2) - ln(x-1) = ln(4)$],
  )
][
  #parts(
    2,
    [(a) $x = 7$],
    [(b) $x = e^2 approx 7.39$],
    [(c) Combining gives $(x+2)/(x-1) = 4 => x = 2$. Domain needs
      $x>1$, which $x=2$ satisfies.],
  )
]

== Equations in Disguise

#only-theory[
  Some equations aren't linear or quadratic *as written* -- but
  become one after you spot a repeated expression and give it a new
  name. This trick is called
  #vocab("substitution", "Substitution"): replace the repeated
  expression with a single letter, solve the simpler equation that
  results, then translate back.
]

#example[
  Solve $x^4 - 5x^2 + 4 = 0$.

  The equation only involves $x^2$ and $x^4 = (x^2)^2$, so substitute
  $u = x^2$:
  $
    u^2 - 5u + 4 = 0 quad => quad (u-1) dot (u-4) = 0 quad =>
    quad u = 1 "or" u = 4.
  $
  Translating back, $x^2 = u$:
  $ x^2 = 1 => x = plus.minus 1, quad x^2 = 4 => x = plus.minus 2. $
  Four solutions in total: $x = -2, -1, 1, 2$.
]

#example[
  Solve $4^x - 5 dot 2^x + 4 = 0$.

  Since $4^x = (2^x)^2$, substitute $u = 2^x$:
  $ u^2 - 5u + 4 = 0 quad => quad u = 1 "or" u = 4. $
  Translating back:
  $ 2^x = 1 => x = 0, quad 2^x = 4 => x = 2. $
]

#ex(difficulty: 3, time: "20 min", keep-together: true)[
  Solve for $x$ using a substitution.
  #parts(
    2,
    [(a) $(log(x))^2 - 3 log(x) + 2 = 0$],
    [(b) $9^x - 4 dot 3^x - 45 = 0$],
  )
][
  + Let $u = log(x)$: $u^2-3u+2=0 => u=1$ or $u=2$. So $log(x)=1
    => x=10$, or $log(x)=2 => x=100$.
  + Let $u = 3^x$ (note $9^x = (3^x)^2$): $u^2-4u-45=0 => u=9$ or
    $u=-5$. Since $u=3^x$ must be positive, reject $u=-5$. From
    $3^x=9$: $x=2$.
]

== Techniques You Know So Far

#known-techniques(
  "Isolate the variable (linear)",
  "Factor, complete the square, or use the quadratic formula
  (quadratic)",
  "Isolate a root and raise to a power, then check for extraneous
  solutions (radical)",
  "Match bases, or take a logarithm of both sides (exponential)",
  "Rewrite without the logarithm, then check the domain
  (logarithmic)",
  "Substitute for a repeated expression to reveal a linear or
  quadratic equation in disguise",
)

== Mixed Practice

#only-theory[
  The equations below are *not* sorted by type -- figuring out which
  technique applies is part of the exercise.
]

#ex(difficulty: 1, time: "10 min", keep-together: true)[
  #parts(
    2,
    [(a) $x^2 - 5x = 0$],
    [(b) $2^(3x) = 1/8$],
    [(c) $log_2 (x+1) = 3$],
  )
][
  #parts(2, [(a) $x=0$ or $x=5$], [(b) $x=-1$], [(c) $x=7$])
]

#ex(difficulty: 2, time: "20 min", keep-together: true)[
  #parts(
    2,
    [(a) $sqrt(2x+3) = x$],
    [(b) $3x^2 + 2x - 1 = 0$],
    [(c) $(2x-1)/3 = (x+4)/2$],
    [(d) $x^4 - 5x^2 + 4 = 0$],
  )
][
  + Squaring gives $x^2-2x-3=0 => x=3$ or $x=-1$; checking rejects
    $x=-1$ (extraneous). Only $x=3$.
  + $x = -1$ or $x = 1/3$.
  + $x = 14$.
  + $x = -2, -1, 1, 2$.
]

#ex(difficulty: 3, time: "25 min", keep-together: true)[
  #parts(
    2,
    [(a) $log(2x-1) - log(x) = log(3)$],
    [(b) $4^x - 5 dot 2^x + 4 = 0$],
    [(c) $sqrt(x+10) - x = -2$],
    [(d) $9^x - 4 dot 3^x - 45 = 0$],
  )
][
  + The algebra gives $x=-1$, but the domain needs $x>1/2$ --
    *no solution*.
  + $x = 0$ or $x = 2$.
  + Only $x=6$ (checking rejects the extraneous $x=-1$).
  + $x = 2$.
]

#print-hints()
#print-vocab()
