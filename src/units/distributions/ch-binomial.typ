#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "The Binomial Distribution")
#let ex = exercise.with(chapter: "The Binomial Distribution")

// ── sim-box (duplicated from ch-random-variables) ────────────
// Typst's `include` does not leak top-level bindings between chapter
// files, so this has to be repeated until sim-box moves into
// preamble.typ. Keep the two copies identical, or promote it now and
// delete both blocks — it appears in every remaining chapter of this
// unit, so promoting is the better use of five minutes.
#let sim-col = rgb("#37474f")
#let sim-bg = rgb("#f5f5f5")
#let sim-box(notebook: none, on-sheet: false, body) = context {
  if _sol-mode.get() { return }
  if _ex-mode.get() and not on-sheet { return }
  _bar-box(
    bar-color: sim-col,
    fill-color: sim-bg,
    label: "Simulation",
    title: if notebook != none { "notebook: " + notebook } else { none },
    body,
  )
}

// ── TEACHER'S NOTE: calculator instructions ──────────────────
// §5 names the calculator functions and — importantly — states the
// convention that a cdf gives p(X <= k) rather than p(X < k), which is
// the single most common source of off-by-one errors here.
//
// What it deliberately does NOT give is menu paths or key sequences,
// because I cannot verify those and a wrong keypress printed in the
// notes is worse than none. Both calculators expose the functions
// under a distributions menu; if you want the exact routes written in,
// send me the sequences for the TI-30X Pro MathPrint and the
// TI-Nspire CAS and I will add a boxed reference for each track.
//
// PLEASE CONFIRM ONE THING I could not check: that the TI-Nspire's
// binomCdf takes a lower AND an upper bound (so p(X <= k) needs bounds
// 0 and k) while the TI-30X's binomcdf takes the single value k. §5 is
// written that way. If both in fact take a single k, delete the
// sentence about bounds — the mathematical point of the box, that a cdf
// is always p(X <= k) and never p(X < k), is unaffected either way.
//
// ── THE BINOMIAL TEST IS NOT IN THIS CHAPTER ─────────────────
// It has its own: ch-binomial-test, required for both tracks, and the
// route by which GLF satisfies Lehrplan Y4 2.2. This chapter ends by
// pointing at it. The split keeps "what the distribution is" separate
// from "using it to decide something", and makes the coverage of 2.2
// visible in the chapter list rather than buried in a section.

= The Binomial Distribution

#only-theory[
  Twice in the last chapter a shortcut appeared with no justification.
  The expected number of hay-fever sufferers among $29$ students was
  $29 dot 1 slash 8$; the expected number of O's in four draws was
  $4 dot 0.2$. Both times the answer was simply _trials times
  probability_, and no distribution was needed to get it.

  Those two situations have the same structure, and it is by far the
  most common structure in the subject: something is tried a fixed
  number of times, each try succeeds or fails, and the question is how
  many successes there were. This chapter works out the distribution
  of that count — and the counting chapter of the last unit has
  already done half the work.
]

#objectives(
  [check whether a situation is a sequence of Bernoulli trials, and
    name which condition fails when one does],
  bfkm[state and apply the binomial distribution
    $p(X = k) = binom(n, k) p^k (1-p)^(n-k)$],
  [explain where each of its three factors comes from],
  [describe how the shape of the distribution depends on $n$ and $p$],
  bfkm[use $E(X) = n p$ and $sigma = sqrt(n p (1-p))$],
  [calculate cumulative probabilities — "at least", "at most",
    "between" — by hand and with a calculator, without off-by-one
    errors],
)

== Bernoulli Trials

#definition(title: "Bernoulli Trial")[
  A #vocab("Bernoulli trial", "Bernoulli-Versuch") is an experiment
  with exactly two outcomes, conventionally called *success* and
  *failure*. The probability of success is written $p$, and of failure
  $q = 1 - p$.

  Jakob Bernoulli, after whom they are named, was from Basel.
]

#keybox(title: "When the binomial distribution applies")[
  All four of these must hold:
  + the number of trials $n$ is *fixed in advance*;
  + each trial has exactly *two* outcomes;
  + the probability of success $p$ is the *same* at every trial;
  + the trials are *independent*.
]

#warning[
  Check all four, every time, and name the one that fails. Almost
  every misuse of the binomial distribution comes from condition 3 or
  4, and both fail in the same everyday situation: drawing without
  replacement.

  Take four cards from a deck and ask how many are aces. The trials
  are not independent and $p$ changes after every card, so the count
  is not binomially distributed. It is the sample-space chapter's
  urn problem, and the last unit counted it with binomial
  coefficients instead — which is a different calculation with a
  confusingly similar name.
]

#ex(difficulty: 1, time: "10 min")[
  Decide for each whether the count described is binomially
  distributed. If it is not, say which condition fails.
  #auto-parts(
    1,
    [A die is rolled seven times and the number shown is recorded each
      time.],
    [Four cards are drawn from a deck without replacement, and the
      number of red cards is recorded.],
    [Five marbles are drawn from an urn holding $3$ black and $7$ red,
      each being replaced before the next draw, and the number of
      black ones is recorded.],
    [The blood group of ten patients is recorded.],
    [A basketball player takes ten free throws and the number scored
      is recorded.],
  )
][
  #auto-parts(
    1,
    [No — condition 2. Recording the number shown gives six outcomes,
      not two. It *would* be binomial if the question were "how many
      sixes", because that reduces each roll to success or failure.],
    [No — conditions 3 and 4. Without replacement the deck changes, so
      $p$ is not constant and the draws are not independent.],
    [Yes. Fixed $n = 5$, two outcomes, $p = 0.3$ throughout because of
      the replacement, and the draws do not affect each other.],
    [No — condition 2 again: four blood groups. "How many patients
      have group O" would be binomial.],
    [Arguable, and worth arguing about. Conditions 1 and 2 hold. But
      is $p$ really the same on the tenth throw as on the first, and
      are the throws independent — or does a player warm up, tire, or
      lose confidence after a miss? The binomial distribution is a
      *model* here, not a fact, which is the subject of the next
      chapter.],
  )
]

== The Distribution

#only-theory[
  Suppose $n$ independent trials each succeed with probability $p$,
  and let $X$ be the number of successes. What is $p(X = k)$?

  Take one particular sequence of results with $k$ successes — say
  success, success, failure, success, failure — and multiply along it,
  which independence permits. Every success contributes $p$ and every
  failure contributes $q = 1 - p$, so the sequence has probability
  $ p^k dot (1 - p)^(n - k), $
  and note that this does not depend on the *order* of the results,
  only on how many of each there are. Every sequence with $k$
  successes has exactly this probability.

  So all that remains is to count the sequences. A sequence of $n$
  results with $k$ successes is an arrangement of $k$ S's and
  $n - k$ F's — which is precisely what the counting chapter answered:
  there are $binom(n, k)$ of them. Different sequences are mutually
  exclusive, so their probabilities add.
]

#keybox(title: "The binomial distribution")[
  If $X$ counts the successes in $n$ independent trials each
  succeeding with probability $p$, then
  $ p(X = k) = binom(n, k) dot p^k dot (1 - p)^(n - k), quad
    k = 0, 1, dots, n. $

  We write $X tilde B(n, p)$ and call $n$ and $p$ the *parameters* of
  the distribution.
]

#remark[
  Read the formula as three separate questions, and it stops being
  something to memorize:

  / $p^k$: what is the chance the $k$ successes happen?
  / $(1-p)^(n-k)$: what is the chance the other trials all fail?
  / $binom(n, k)$: in how many arrangements could that have occurred?

  The first two come from the product rule and the third from the
  counting chapter. Nothing in this formula is new; only the
  assembly is.
]

#example(title: "Three sixes in ten rolls")[
  Roll a die ten times and let $X$ count the sixes, so
  $X tilde B(10, 1 slash 6)$. Then
  $ p(X = 3) = binom(10, 3) dot (1/6)^3 dot (5/6)^7
    = 120 dot (1/6)^3 dot (5/6)^7 approx 0.155. $
]

#example(title: "An old question, recognized")[
  The probability of at least one six in four rolls was found in the
  last unit by taking the complement: $1 - (5 slash 6)^4 approx
  0.518$.

  In the new language that is $X tilde B(4, 1 slash 6)$ and
  $ p(X >= 1) = 1 - p(X = 0)
    = 1 - binom(4, 0) (1/6)^0 (5/6)^4 = 1 - (5/6)^4, $
  since $binom(4, 0) = 1$. The same calculation, now a special case of
  something general.
]

== The Shape of the Distribution

#only-theory[
  A binomial distribution has only two parameters, and between them
  they determine everything about its shape. It is worth looking at a
  few.
]

#only-theory[
  With $n = 10$ and $p = 0.5$, successes and failures are
  interchangeable, so the distribution is symmetric about $5$:
]

#only-theory[
  #bar-chart(
  ("0", 0.001),
  ("1", 0.010),
  ("2", 0.044),
  ("3", 0.117),
  ("4", 0.205),
  ("5", 0.246),
  ("6", 0.205),
  ("7", 0.117),
  ("8", 0.044),
  ("9", 0.010),
  ("10", 0.001),
  y-label: [$p(X = k)$],
  width: 9cm,
  height: 3.6cm,
)
]

#only-theory[
  Lowering $p$ to $0.2$ pushes the mass to the left and makes the
  distribution visibly lopsided, with a longer tail on the right:
]

#only-theory[
  #bar-chart(
  ("0", 0.107),
  ("1", 0.268),
  ("2", 0.302),
  ("3", 0.201),
  ("4", 0.088),
  ("5", 0.026),
  ("6", 0.006),
  ("7", 0.001),
  ("8", 0.000),
  ("9", 0.000),
  ("10", 0.000),
  y-label: [$p(X = k)$],
  bar-color: warn-col,
  width: 9cm,
  height: 3.6cm,
)
]

#only-theory[
  Now keep $p = 0.2$ and raise $n$ to $30$. The skew is still there,
  but much fainter — the distribution has become almost symmetric,
  and its outline is starting to look like a bell:
]

#only-theory[
  #bar-chart(
  ("0", 0.0012),
  ("1", 0.0093),
  ("2", 0.0337),
  ("3", 0.0785),
  ("4", 0.1325),
  ("5", 0.1723),
  ("6", 0.1795),
  ("7", 0.1538),
  ("8", 0.1106),
  ("9", 0.0676),
  ("10", 0.0355),
  ("11", 0.0161),
  ("12", 0.0064),
  ("13", 0.0022),
  ("14", 0.0007),
  ("15", 0.0002),
  y-label: [$p(X = k)$],
  bar-color: def-col,
  width: 11cm,
  height: 3.6cm,
)
]

#only-theory[
  The bars stop at $15$ only because everything beyond it is too small
  to see: $p(X > 15) approx 0.00005$ in total.
]

#keybox(title: "Two rules of thumb")[
  + The distribution is symmetric when $p = 0.5$, skewed to the right
    when $p < 0.5$ and to the left when $p > 0.5$.
  + The skew fades as $n$ grows. Whatever $p$ is, a large enough $n$
    makes the distribution nearly symmetric and bell-shaped.
]

#look-ahead(preview: [the normal distribution])[
  That second rule is a large hint. A shape which appears whenever $n$
  is big enough, no matter what $p$ was, is a shape worth having a
  name and a formula for — and it is the same curve that turns up in
  heights, in measurement errors and in almost every average of
  anything.

  It is the reason the normal distribution exists, and it arrives in
  two chapters' time.
]

== Expected Value and Standard Deviation

#only-theory[
  Both shortcuts from the last chapter can now be justified, and the
  justification is short enough to be worth seeing.
]

#keybox(title: "Mean and spread of a binomial")[
  If $X tilde B(n, p)$ then
  $ E(X) = n p, quad
    "Var"(X) = n p (1 - p), quad
    sigma = sqrt(n p (1 - p)). $
]

#only-theory[
  For the expected value, look at a single trial. A random variable
  that is $1$ on success and $0$ on failure has expected value
  $ 1 dot p + 0 dot (1 - p) = p. $
  The total number of successes is the sum of $n$ such variables, and
  averages add: doing something $n$ times, each contributing $p$ on
  average, contributes $n p$ in total. Hence $29 dot 1 slash 8$ and
  $4 dot 0.2$.
]

#example[
  For $X tilde B(10, 1 slash 6)$, the number of sixes in ten rolls:
  $ E(X) = 10 dot 1/6 approx 1.67, quad
    sigma = sqrt(10 dot 1/6 dot 5/6) approx 1.18. $
  So about one or two sixes, give or take one. Look back at the
  $n = 10$, $p = 0.2$ chart above and the numbers match what you see:
  the mass sits near $2$ and is nearly all within about one bar either
  side.
]

#remark[
  Note that $sigma$ grows like $sqrt(n)$ while $E(X)$ grows like $n$.
  Ten thousand coin tosses have expected value $#num(5000)$ and
  standard deviation $50$ — the spread is only $1%$ of the mean.

  This is the gambler's fallacy result from the very first chapter of
  the last unit, in a formula. The gap between heads and tails grows,
  but it grows like $sqrt(n)$ while the total grows like $n$, so as a
  *proportion* it shrinks to nothing.
]

== Cumulative Probabilities

#only-theory[
  Exam questions rarely ask for exactly $k$ successes. They ask for at
  least, at most, fewer than, or between — and each of those is a sum
  of the individual probabilities.
]

#example(title: "At least 15 heads in 20 tosses, by hand")[
  With $X tilde B(20, 0.5)$, every sequence has probability
  $(1 slash 2)^(20)$, so the whole calculation is a count:
  $ p(X >= 15) &= (binom(20,15) + binom(20,16) + binom(20,17)
    + binom(20,18) + binom(20,19) + binom(20,20))/2^(20) \
    &= (#num(15504) + #num(4845) + #num(1140) + 190 + 20 + 1)/#num(1048576) \
    &= #num(21700)/#num(1048576) approx 0.0207. $

  Six terms, and only because $p = 0.5$ made the powers of $p$ and
  $q$ identical. With any other $p$ each term needs its own two
  powers, and a question about "at least $3$" out of $50$ would need
  forty-eight terms.
]

#only-theory[
  Which is why calculators have a cumulative binomial function. But
  do the sum above by hand once, because it tells you what that
  function *is*: a tail probability is a sum, and nothing more
  mysterious.
]

#keybox(title: "The one convention that matters")[
  What every cumulative binomial function computes is
  $ p(X <= k), $
  the probability of $k$ *or fewer* successes — never $p(X < k)$.

  On the TI-30X Pro MathPrint this is `binomcdf` with the single value
  $k$. On the TI-Nspire CAS, `binomCdf` takes a *lower and an upper*
  bound, so $p(X <= k)$ is entered with bounds $0$ and $k$, and a
  "between" question can be asked directly. The single-value function
  is `binompdf` or `binomPdf` on the two machines.

  Everything else is rearrangement:
  #auto-parts(
    1,
    [$p(X <= k)$ — straight from the function.],
    [$p(X < k) = p(X <= k - 1)$.],
    [$p(X >= k) = 1 - p(X <= k - 1)$.],
    [$p(X > k) = 1 - p(X <= k)$.],
    [$p(a <= X <= b) = p(X <= b) - p(X <= a - 1)$.],
  )
]

#warning[
  Lines 2 and 3 are where marks are lost. "At least $15$" is
  $1 - p(X <= 14)$, not $1 - p(X <= 15)$ — subtracting the wrong
  cumulative value removes the case $X = 15$, which is the very case
  you were asked about.

  Write down which $k$ goes into the function *before* touching the
  calculator, and check it against the worked sum above: with
  $n = 20$ and $p = 0.5$, the answer to "at least $15$" is
  $0.0207$. If your keystrokes give $0.0059$, you have made exactly
  this error.
]

#sim-box(notebook: "02-binomial.ipynb")[
  Both charts in §3 came from three lines:

  ```python
  from scipy.stats import binom

  k = range(0, 11)
  print(binom.pmf(k, 10, 0.5).round(3))
  print(binom.cdf(14, 20, 0.5).round(5))
  ```

  *What to look for.* `binom.pmf` is `binompdf` and `binom.cdf` is
  `binomcdf`, with the same convention: `cdf(14, ...)` is
  $p(X <= 14)$. Checking a keystroke against a line of code is a
  cheap way to find an off-by-one error.

  The notebook has one line to change — the parameter $p$ — so you can
  watch the shape lose its skew as $n$ rises, and a *Going further*
  section that simulates trials instead of computing them and compares
  the two.
]

#ex(difficulty: 2, time: "15 min")[
  A poll of $20$ adults in a large city asks whether they support
  banning smoking in restaurants. About $60%$ of the population
  supports it.
  #auto-parts(
    1,
    [What is the probability that exactly $5$ of them support it?],
    [What is the probability that none of them does?],
    [What is the probability that at least one does?],
    [What is the probability that at least two do?],
  )
][
  Let $X$ be the number in favour, so $X tilde B(20, 0.6)$.
  #auto-parts(
    1,
    [$ binom(20, 5) (0.6)^5 (0.4)^(15) approx 0.00129. $
      Strikingly unlikely — the expected number is
      $20 dot 0.6 = 12$, and $5$ is a long way below it.],
    [$ p(X = 0) = (0.4)^(20) approx 1.10 dot 10^(-8), $
      about one chance in ninety million.],
    [$ p(X >= 1) = 1 - p(X = 0) approx 0.99999999. $],
    [$ p(X >= 2) = 1 - p(X <= 1) approx 0.9999997. $
      Note the calculator route: $1 - $ `binomcdf`$(20, 0.6, 1)$, with
      $1$ and not $2$ as the last argument.],
  )
]

#ex(difficulty: 2, time: "12 min")[
  A retailer claims that only $4%$ of the units he sells are
  defective. A buyer tests a sample of $20$.
  #auto-parts(
    1,
    [If the claim is true, what is the probability that at most one
      unit in the sample is defective?],
    [The buyer in fact finds three defective units. If the claim is
      true, how likely is exactly that?],
    [Does your answer to part 2 show that the retailer is wrong?],
  )
][
  Let $X$ be the number of defective units, and suppose the claim
  holds, so $X tilde B(20, 0.04)$.
  #auto-parts(
    1,
    [$ p(X <= 1) = binom(20,0)(0.96)^(20) + binom(20,1)(0.04)(0.96)^(19)
       approx 0.810. $],
    [$ p(X = 3) = binom(20, 3)(0.04)^3 (0.96)^(17) approx 0.0364. $],
    [No, and this is worth being careful about. Every individual
      outcome of a $20$-unit sample is fairly unlikely — even the most
      likely one, $X = 0$, has probability only about $0.44$. Being
      told that something with probability $0.036$ happened is not by
      itself evidence of anything, because *something* had to happen.

      The right question is not how likely this exact result is, but
      how likely a result *at least this extreme* is. That question
      has an answer and a name, and it is the next chapter.],
  )
]

#ex(difficulty: 2, time: "12 min")[
  About one person in eight suffers from hay fever. A mathematics
  course has $29$ students.
  #auto-parts(
    1,
    [How many would you expect to be affected, and what is the
      standard deviation?],
    [What is the probability that more than $6$ of them are
      affected?],
    [Compare your answer to part 2 with the rule of thumb that values
      more than two standard deviations above the mean are unusual.],
  )
][
  Let $X$ be the number affected, so $X tilde B(29, 1 slash 8)$.
  #auto-parts(
    1,
    [$ E(X) = 29 dot 1/8 = 3.625, quad
       sigma = sqrt(29 dot 1/8 dot 7/8) approx 1.78. $],
    [$ p(X > 6) = 1 - p(X <= 6) approx 1 - 0.938 = 0.062. $
      Note the argument is $6$, not $7$: "more than $6$" excludes $6$
      itself, so everything up to and including $6$ is subtracted.],
    [Two standard deviations above the mean is
      $3.625 + 2 dot 1.78 approx 7.2$, so "more than $6$" is roughly
      the region beyond $1.9 sigma$ — just inside the usual threshold.
      A probability of $0.062$ agrees: unusual, but not remarkable.
      One class in sixteen will do it.],
  )
]

#ex(difficulty: 2, time: "12 min")[
  #auto-parts(
    1,
    [A fair coin is tossed $#num(10000)$ times. Find $E(X)$ and
      $sigma$ for the number of heads.],
    [Express $sigma$ as a percentage of $E(X)$. Do the same for
      $100$ tosses.],
    [Use this to explain, in one sentence, why the *proportion* of
      heads settles down while the *gap* between heads and tails does
      not.],
  )
][
  #auto-parts(
    1,
    [$ E(X) = #num(10000) dot 0.5 = #num(5000), quad
       sigma = sqrt(#num(10000) dot 0.5 dot 0.5) = 50. $],
    [$50 slash #num(5000) = 1%$. For $n = 100$:
      $E(X) = 50$ and $sigma = 5$, so $5 slash 50 = 10%$ — ten times
      as large in relative terms for a hundred times fewer tosses.],
    [Because $sigma$ grows like $sqrt(n)$ and $E(X)$ like $n$, so the
      absolute spread keeps growing while the spread *relative to the
      total* shrinks — which is exactly what "the proportion converges
      but the gap does not" means.],
  )
]

#only-high[
  #ex(difficulty: 3, level: "high", time: "15 min", hints: (
    "Write down the ratio p(X = k) / p(X = k-1) and simplify it. The binomial coefficients differ by a single factor.",
    "The probabilities increase as long as that ratio is bigger than 1. Solve the inequality for k.",
    "Compare your answer with E(X) = np.",
  ))[
    For $X tilde B(n, p)$, the most likely value of $X$ is called the
    *mode* of the distribution.
    #auto-parts(
      1,
      [Show that
        $ p(X = k)/p(X = k - 1) = (n - k + 1)/k dot p/(1 - p). $],
      [Deduce that the probabilities increase while
        $k < (n + 1) p$ and decrease afterwards, so the mode is the
        whole number just below $(n + 1) p$.],
      [For $X tilde B(10, 0.2)$, find the mode and compare it with
        $E(X)$. Check against the second chart in §3.],
    )
  ][
    #auto-parts(
      1,
      [Since $binom(n,k) = binom(n, k-1) dot (n - k + 1) slash k$, the
        two coefficients differ by that single factor, and the powers
        differ by one factor of $p$ up and one of $(1-p)$ down:
        $ p(X = k)/p(X = k-1)
          = (n - k + 1)/k dot p^k/p^(k-1)
            dot (1-p)^(n-k)/(1-p)^(n-k+1)
          = (n - k + 1)/k dot p/(1 - p). $],
      [The probabilities rise exactly while the ratio exceeds $1$:
        $ (n - k + 1) p > k (1 - p)
          arrow.r.double (n + 1) p > k. $
        So each probability is bigger than the one before it while
        $k < (n+1)p$, and smaller afterwards — the distribution rises
        to a single peak and falls away, with the mode at the largest
        whole number below $(n+1)p$.],
      [$(n+1)p = 11 dot 0.2 = 2.2$, so the mode is $2$, while
        $E(X) = 10 dot 0.2 = 2$. The chart in §3 has its tallest bar
        at $k = 2$, with $p approx 0.302$. Mean and mode are close but
        need not coincide — and cannot always, since one of them must
        be a whole number and the other need not be.],
    )
  ]
]

#ai-box(role: "Checker")[
  Off-by-one errors in cumulative probabilities are the most common
  mistake in this chapter, and they are also one an assistant makes
  readily, because the wrong answer is a perfectly plausible number.

  Ask an AI assistant: _a fair coin is tossed 20 times; what is the
  probability of at least 15 heads?_ You know the answer is $0.0207$,
  and you know the plausible wrong answer is $0.0059$.

  Whatever it says, ask it to write down which cumulative value it
  used and why. Then ask the same question phrased as "more than 14
  heads" — the same event, differently worded. A model reasoning about
  the event gives the same number twice; one pattern-matching on the
  words may not.
]

#look-ahead(preview: [using a distribution to decide something])[
  The defective-units exercise ended on an unfinished thought. A buyer
  who finds three faulty units in twenty wants to know whether the
  retailer's $4%$ claim can still be believed — and computing
  $p(X = 3) approx 0.036$ turned out not to answer that, because every
  individual result is unlikely and something had to happen.

  What is needed instead is the probability of a result *at least as
  extreme* as the one observed: a tail probability, which is exactly
  what the cumulative function returns. Doing that carefully, and
  saying honestly what the answer does and does not establish, is a
  hypothesis test — and it is the last thing on the required list for
  both tracks.
]

#print-hints()
#print-vocab()
