#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Introduction")
#let ex = exercise.with(chapter: "Introduction")

= Introduction

#only-theory[
  Every number you have ever used was invented. Someone chose a symbol,
  agreed what it should mean, and then checked that the old rules still
  worked with the new object in place. Zero was invented. Negative
  numbers were invented, and treated with deep suspicion for centuries.
  Fractions, irrationals -- all of them arrived because somebody
  refused to accept that a perfectly reasonable question had no answer.

  This chapter is the last step in that story. The question this time
  is embarrassingly short: *what is the square root of $-1$?* On the
  number line, nothing squares to a negative. So we will do what
  mathematicians have always done -- step off the line, and build the
  number we need.
]

#objectives(
  [describe the complex numbers as an extension of the real numbers,
    and state precisely which problem that extension solves],
  [work with the imaginary unit $i$, and write square roots of negative
    numbers in the form $a + b dot i$],
  [read off the real and imaginary parts of a complex number, and
    decide when two complex numbers are equal],
  [simplify any integer power of $i$],
  [state the Fundamental Theorem of Algebra and explain what it means
    for $CC$ to be algebraically closed],
)

== Numbers Are Invented

#only-theory[
  Start from the *natural* numbers -- the counting numbers, which turn
  up in essentially every culture on earth. From there, each new number
  system arrives the same way: a perfectly ordinary operation turns out
  to have no answer inside the system we already have. Rather than
  declare the question unanswerable, we invent whatever is missing, and
  then check that nothing we already relied on breaks.
]

#only-theory[
  In a moment you will be asked to invent one of these systems yourself,
  with no worked example to copy -- and if you get stuck, good: that is
  the point. Reach for the *problem-solving toolbox* from the
  orientation; the exploration below is exactly the kind of place those
  moves earn their keep.
]

#exploration(title: "Invent the fix yourself")[
  Do this *before* reading the next page.

  You are a mathematician in 1545. You can solve $x^2 = 4$ and
  $x^2 = 2$, but $x^2 = -1$ defeats you: no number on your number line
  squares to a negative.

  + You decide to invent a new object that does. What is the *smallest*
    amount you have to invent -- one new number, one new number for
    each negative, or something else? Argue for your answer.
  + Once your new object exists, what should $3 + star$ mean, where
    $star$ is your new object? Are you forced to invent even more
    objects just to write down such a sum?
  + Which rules of ordinary algebra do you *insist* keep working? Name
    at least three, and say why you would refuse to give them up.

  Keep your notes. When the definition appears on the next page,
  compare it with what you designed.
]

#only-theory[
  The table below is the whole story in one page. Read the last column
  as the thing that could not be done before, and the row it sits in as
  the invention that fixed it.

  #data-table(
    columns: (auto, auto, 1fr, 1fr),
    row-height: auto,
    [Set],
    [Symbol],
    [Invented for],
    [Previously impossible],
    [Natural],
    [$NN$],
    [Counting],
    [--],
    [Integer],
    [$ZZ$],
    [Subtraction],
    [$5 - 7 in.not NN$],
    [Rational],
    [$QQ$],
    [Division],
    [$2 / 3 in.not ZZ$],
    [Real],
    [$RR$],
    [Roots and limits],
    [$sqrt(2) in.not QQ$],
    [*Complex*],
    [$CC$],
    [Roots of negatives],
    [$sqrt(-1) in.not RR$],
  )
]

#only-theory[
  Each set in that table contains all the ones above it, so nothing is
  ever lost -- an extension only ever adds. The real numbers fill a
  line running from $-oo$ to $+oo$, and every point on that line is
  used up. That is exactly why $x^2 = -1$ is hopeless there: squaring
  any real number, positive or negative, gives something
  non-negative. There is simply no room left on the line for
  $sqrt(-1)$.

  So we leave the line.
]

== The Imaginary Unit

#definition(title: "The imaginary unit")[
  We introduce a new number $i$, the
  #vocab("imaginary unit", "imaginäre Einheit"), defined by the single
  property
  $ i^2 = -1. $
]

#only-theory[
  That is the entire definition. Everything in this course is built on
  that one line, and every calculation you will do reduces, sooner or
  later, to replacing $i^2$ by $-1$.

  The name is a historical accident and a bad one. Descartes coined
  "imaginary" in 1637 as an insult -- he did not believe these things
  were numbers. The label stuck, and it still misleads students four
  centuries later. There is nothing less real about $i$ than there is
  about $-1$ or $sqrt(2)$; all three are objects we invented because we
  needed them, and all three obey rules we can state exactly.
]

#warning[
  Many textbooks write $i = sqrt(-1)$. The notation is suggestive but
  technically wrong, because the rule
  $sqrt(a) dot sqrt(b) = sqrt(a dot b)$ holds for non-negative reals
  and *fails* for negative ones. If we allowed it:
  $
    1 = sqrt(1) = sqrt((-1) dot (-1)) eq.not sqrt(-1) dot sqrt(-1)
    = i dot i = -1.
  $
  We therefore always work from $i^2 = -1$, and never write
  $i = sqrt(-1)$.
]

#ai-box(role: "Checker")[
  The chain in the warning box above proves $1 = -1$, which is false,
  so exactly one step in it must be illegal.

  + First, on paper and without help: decide which step is the illegal
    one, and write one sentence saying what rule it breaks.
  + Now paste the chain into an AI assistant and ask it: "Which step is
    wrong, and why?"
  + Grade its answer against yours. Did it name the same step? Did it
    give a *reason*, or only assert that the step is invalid? If the
    two of you disagree, work out which of you is right -- and do not
    assume it is the machine.
]

#only-theory[
  With $i$ available, square roots of negative numbers become
  routine. Since $i^2 = -1$, for any $n > 0$
  $
    (sqrt(n) dot i)^2 = n dot i^2 = -n,
    quad "so" quad sqrt(-n) = sqrt(n) dot i.
  $
  For example $sqrt(-4) = 2i$ and $sqrt(-3) = sqrt(3) dot i$.
]

#ex(difficulty: 1, time: "10 min")[
  Write each number in the form $a + b dot i$ with $a, b in RR$.
  #auto-parts(
    2,
    [$sqrt(-9)$],
    [$sqrt(-7)$],
    [$3 + sqrt(-16)$],
    [$(1 + sqrt(-8)) / 2$],
  )
][
  #auto-parts(
    2,
    [$0 + 3i$],
    [$0 + sqrt(7) dot i$],
    [$3 + 4i$],
    [$1 / 2 + sqrt(2) dot i$, since $sqrt(-8) = 2 sqrt(2) dot i$],
  )
]

== Complex Numbers

#definition(title: "Complex numbers")[
  A #vocab("complex number", "komplexe Zahl") is any expression of the
  form
  $ z = a + b dot i, quad a, b in RR, quad i^2 = -1. $
  The set of all complex numbers is written $CC$.
  - $a = Re(z)$ is the #vocab("real part", "Realteil") of $z$.
  - $b = Im(z)$ is the #vocab("imaginary part", "Imaginärteil") of $z$.
]

#remark[
  The imaginary part is a *real* number. The imaginary part of
  $3 + 5i$ is $5$, not $5i$. This trips up almost everybody once; make
  it be once.
]

#keybox(title: "One idea, several notations")[
  These notes write the parts as $Re(z)$ and $Im(z)$ -- upright, with
  parentheses -- everywhere. That is the choice; the table is so that
  you recognize the *same two numbers* when a different book, a website
  or a CAS writes them another way.

  #data-table(
    columns: (auto, 1fr),
    row-height: auto,
    [You may also see],
    [Where it comes from],
    [$frak(R)(z)$ and $frak(I)(z)$],
    [Black-letter (*Fraktur*) letters -- the classical convention, still
      standard in much of the complex-analysis literature and in German
      texts, and what LaTeX's `\Re` and `\Im` produce by default.],

    [$Re z$ and $Im z$ (no parentheses)],
    [A common shorthand, used once it is clear where the operator stops
      -- but $Re z + w$ is ambiguous (is it $Re(z) + w$ or $Re(z + w)$?),
      so we keep the parentheses.],
  )

  The two black-letter glyphs are worth being able to read even though
  we will not write them: $frak(R)$ is a capital $R$ and $frak(I)$ a
  capital $I$, however little they look it at first.
]

#example[
  #data-table(
    columns: (1fr, 1fr, 1fr),
    row-height: auto,
    [$z$],
    [$Re(z)$],
    [$Im(z)$],
    [$3 - 5i$],
    [$3$],
    [$-5$],
    [$-sqrt(2) + i$],
    [$-sqrt(2)$],
    [$1$],
    [$7$],
    [$7$],
    [$0$],
    [$-4i$],
    [$0$],
    [$-4$],
  )
]

#only-theory[
  The last two rows deserve a name each. Any real number $a$ can be
  written $a + 0 dot i$, so every real number is also a complex
  number: $RR subset CC$. At the other extreme, a number of the form
  $0 + b dot i$ with $b eq.not 0$ is called
  #vocab("purely imaginary", "rein imaginär").
]

#only-theory[
  One more thing has to be settled before we can compute with these
  objects at all: when are two of them *equal*? The answer looks
  obvious, but it is the single most useful technique in this course,
  so it gets a box of its own.
]

#keybox(title: "Comparing real and imaginary parts")[
  Two complex numbers are equal exactly when their real parts agree
  *and* their imaginary parts agree:
  $
    a + b dot i = c + d dot i
    quad <==> quad
    a = c quad "and" quad b = d
    quad (a, b, c, d in RR).
  $
  In particular $z = 0$ if and only if $Re(z) = 0$ and $Im(z) = 0$.

  So *one* complex equation is really *two* real equations. Whenever a
  problem gives you an equation in $CC$ and asks for real unknowns, the
  first move is almost always: write $z = a + b dot i$, expand, and
  compare parts.
]

#ex(difficulty: 1, time: "10 min")[
  State the real part and the imaginary part of each number.
  #auto-parts(
    2,
    [$z = 4 - 7i$],
    [$z = -sqrt(3) + 1 / 2 dot i$],
    [$z = 5$],
    [$z = -2i$],
  )
][
  #auto-parts(
    2,
    [$Re(z) = 4$, $Im(z) = -7$],
    [$Re(z) = -sqrt(3)$, $Im(z) = 1 / 2$],
    [$Re(z) = 5$, $Im(z) = 0$],
    [$Re(z) = 0$, $Im(z) = -2$],
  )
]

#ex(difficulty: 2, time: "10 min")[
  To which of the sets $NN$, $ZZ$, $QQ$, $RR$, $CC$ does each number
  belong? List *all* that apply.
  #auto-parts(
    2,
    [$-3$],
    [$sqrt(5) dot i$],
    [$0 + 0 dot i$],
    [$2 / 3 - 0 dot i$],
  )
][
  #auto-parts(
    1,
    [$-3 in ZZ, QQ, RR, CC$ -- not in $NN$, since it is negative.],
    [$sqrt(5) dot i in CC$ only: its imaginary part is not zero, so it
      is not real, and therefore in none of the smaller sets.],
    [$0 + 0 dot i = 0 in NN, ZZ, QQ, RR, CC$.],
    [$2 / 3 - 0 dot i = 2 / 3 in QQ, RR, CC$.],
  )
]

#ex(difficulty: 2, time: "15 min", hints: (
  [The right-hand side is $0$. Write it as $0 + 0 dot i$ so that both
    sides are visibly in the form $a + b dot i$.],
  [Now compare real parts, then imaginary parts. Two separate real
    equations, one unknown each.],
))[
  Find all real numbers $a$ and $b$ with
  $ (a - 2) + (3b + 1) dot i = 0. $
  Then explain, in your own words, why a complex number is zero
  exactly when both its real part and its imaginary part are zero.
][
  Write the right-hand side as $0 + 0 dot i$ and compare parts
  (#heuristic("introduce notation")):
  $
    a - 2 = 0 quad => quad a = 2,
    wide
    3b + 1 = 0 quad => quad b = -1 / 3.
  $

  The explanation: a complex number has *exactly one* representation
  $a + b dot i$ with $a, b in RR$. If some number equalled
  $0 = 0 + 0 dot i$ while having, say, $b eq.not 0$, that number would
  have two different representations -- which the definition does not
  allow. So $z = 0$ forces $Re(z) = 0$ and $Im(z) = 0$, and the
  converse is immediate.
]

== Powers of $i$

#only-theory[
  Because $i^2 = -1$, powers of $i$ never produce anything new. Working
  upwards one factor at a time:
  $
    i^0 = 1, quad i^1 = i, quad i^2 = -1, quad i^3 = i^2 dot i = -i,
    quad i^4 = i^2 dot i^2 = 1, quad i^5 = i, quad dots
  $
  and then it repeats. The values run through
  $1, i, -1, -i$ forever, with period $4$. To evaluate $i^n$, all you
  need is the remainder of $n$ on division by $4$.
]

#theorem(title: [Powers of $i$])[
  For every integer $n$,
  $
    i^n = cases(
      1 & "if" n equiv 0 quad (mod 4),
      i & "if" n equiv 1 quad (mod 4),
      -1 & "if" n equiv 2 quad (mod 4),
      -i & "if" n equiv 3 quad (mod 4).
    )
  $
]

#example[
  *Positive exponent.* $i^(23)$: since $23 = 5 dot 4 + 3$, the
  remainder is $3$, so $i^(23) = -i$.

  *Negative exponent.* The theorem covers negative $n$ too, as long as
  you take the remainder correctly: $-3 = (-1) dot 4 + 1$, so
  $-3 equiv 1 quad (mod 4)$ and $i^(-3) = i$.

  Worth checking by hand the first time, since negative exponents are
  where the mistakes live:
  $
    i^(-3) = 1 / i^3 = 1 / (-i)
    = i / ((-i) dot i) = i / 1 = i. quad #sym.checkmark
  $
]

#look-ahead(
  title: "A cycle of four is a quarter turn",
  preview: [the Gaussian plane, and again in polar form],
)[
  Notice what the list $1, i, -1, -i, 1, i, dots$ is doing: multiplying
  by $i$ takes each entry to the next one, and four multiplications
  bring you back to where you started.

  Anything that returns to its starting position after four equal steps
  is going *around* something. Four equal steps around a full circle is
  $90 degree$ per step. That is not a coincidence and it is not a
  metaphor: multiplying by $i$ really is a quarter turn, and once we
  have a picture of $CC$ we will be able to see it. Park the thought --
  when the complex plane arrives, this list is the first thing to draw.
]

#ex(difficulty: 1, time: "10 min")[
  Simplify each expression by hand.
  #auto-parts(
    4,
    [$i^7$],
    [$i^(100)$],
    [$(-i)^3$],
    [$i^(-5)$],
    [$i^(2025)$],
    [$i^(14)$],
    [$i^(-2)$],
    [$i + i^2 + i^3 + i^4$],
  )
][
  #auto-parts(
    4,
    [$-i$],
    [$1$],
    [$i$],
    [$-i$],
    [$i$],
    [$-1$],
    [$-1$],
    [$0$],
  )

  For (c), note $(-i)^3 = -i^3 = -(-i) = i$. For (h), the four
  consecutive powers are $i - 1 - i + 1 = 0$ -- remember this one, the
  next exercise is built on it.
]

#ex(difficulty: 3, time: "20 min", hints: (
  [Part (h) of the previous exercise is not decoration. What is the sum
    of *any* four consecutive powers of $i$?],
  [Try the same sum with $8$ terms instead of $2024$, then $12$. What
    is going on? (#emph[try small cases])],
  [$2024 = 4 dot 506$. Group the terms accordingly.],
))[
  Show that
  $ i + i^2 + i^3 + dots.c + i^(2024) = 0. $
][
  Any four *consecutive* powers of $i$ sum to zero: whatever the
  starting point in the cycle, the four terms are $1, i, -1, -i$ in
  some order, and
  $ 1 + i + (-1) + (-i) = 0. $

  The sum runs from $i^1$ to $i^(2024)$, which is $2024$ terms, and
  $2024 = 4 dot 506$. So the terms split exactly into $506$ blocks of
  four consecutive powers, with none left over
  (#heuristic("try small cases") first, on $8$ or $12$ terms, if the
  grouping is not obvious). Each block contributes $0$, so the total is
  $506 dot 0 = 0$. $square$

  *Where the trap is:* the sum starts at $i^1$, not $i^0$. Had it
  started at $i^0$ there would be $2025$ terms -- $506$ complete blocks
  plus one extra term $i^(2024) = 1$ -- and the answer would be $1$.
  Always count the terms before grouping them.
]

== Why $CC$ Is Where It Stops

#only-theory[
  A fair worry at this point: we invented $CC$ to solve $x^2 = -1$, but
  the same table that got us here suggests an endless staircase. Will
  some new equation force us to invent yet another number system on top
  of $CC$, and then another?

  Remarkably, no. The staircase ends here, and the reason is one of the
  deepest theorems in mathematics.
]

#theorem(title: "Fundamental Theorem of Algebra")[
  Every non-constant polynomial with complex coefficients has at least
  one root in $CC$.
]

#only-theory[
  A #vocab("polynomial", "Polynom") here means an expression
  $
    p(x) = a_n dot x^n + a_(n-1) dot x^(n-1) + dots.c + a_1 dot x + a_0,
    quad a_k in CC.
  $
  The theorem says $CC$ is
  #vocab("algebraically closed", "algebraisch abgeschlossen"): no
  equation of this kind can ever again send us hunting for numbers we
  do not have. Whatever polynomial you write down -- with real
  coefficients, with complex coefficients, of degree $2$ or degree
  $2000$ -- its roots are already sitting in $CC$, waiting.

  Gauss gave the first widely accepted argument for it in 1799. Every
  known proof needs tools from university-level analysis, so we will
  not prove it. We will, however, keep meeting evidence for it: every
  equation we solve in this course will have exactly as many complex
  solutions as its degree predicts.
]

#look-ahead(
  title: "Every quadratic is now solvable",
  preview: [polynomial equations over $CC$],
)[
  You already know the quadratic formula, and you know the rule that
  came with it: if the discriminant $b^2 - 4 dot a dot c$ is negative,
  there is no solution.

  That rule was never quite true. It was shorthand for "no solution
  *among the real numbers*" -- and the only thing standing in the way
  was the square root of a negative number, which you can now take.
  Nothing about the formula needs changing. The case that used to be
  the dead end is about to become the interesting one.
]

== Extra Bits -- Can You Put $CC$ in Order?

#only-theory[
  Something *is* lost in the move from $RR$ to $CC$, and it is worth
  knowing what. On the real line, any two numbers can be compared: for
  any $x$ and $y$, exactly one of $x < y$, $x = y$, $x > y$ holds, and
  the ordering behaves properly with respect to arithmetic -- adding
  the same thing to both sides preserves it, and multiplying two
  positives gives a positive.

  Ask whether $i < 0$ or $i > 0$ and something goes wrong.
]

#ex(difficulty: 3, time: "15 min", hints: (
  [Assume such an ordering exists. Then $i eq.not 0$ must be either
    positive or negative -- take the two cases separately.],
  [In an ordered system, the product of two positives is positive, and
    so is the product of two negatives. Apply that to $i dot i$.],
  [Whatever you conclude about $i^2$, remember what $i^2$ actually
    equals.],
))[
  Show that there is no way to order $CC$ that behaves like the
  ordering of $RR$ -- that is, no relation $<$ on $CC$ for which every
  non-zero number is either positive or negative, and for which a
  product of two positives and a product of two negatives are both
  positive.

  Explain in one sentence what this costs us in practice.
][
  Suppose such an ordering existed. Since $i eq.not 0$, it is either
  positive or negative (#heuristic("check an extreme or special case")
  -- $i$ is the extreme case here, the one new object in the system).

  *Case 1: $i > 0$.* A product of two positives is positive, so
  $i dot i > 0$, i.e. $-1 > 0$.

  *Case 2: $i < 0$.* A product of two negatives is positive, so
  $i dot i > 0$, i.e. again $-1 > 0$.

  Either way $-1 > 0$. But then, multiplying the two positives $-1$ and
  $-1$, we get $1 > 0$ as well -- so $-1$ and $1$ are both positive,
  and adding them gives $0 > 0$, which is absurd. No such ordering
  exists. $square$

  *What it costs:* inequalities between complex numbers are meaningless
  -- "$z < w$" is not a statement about complex numbers at all. Every
  inequality in this course will instead compare *real* quantities
  derived from complex ones: $Re(z)$, $Im(z)$, or the distance $|z|$
  that we meet in the Gaussian plane chapter.
]

#print-hints()
#print-vocab()
