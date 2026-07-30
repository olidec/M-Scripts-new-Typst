#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Testing a Claim")
#let ex = exercise.with(chapter: "Testing a Claim")

// ── sim-box (third copy) ─────────────────────────────────────
// Still duplicated because Typst's `include` does not share top-level
// bindings between chapter files. Promoting it to preamble.typ removes
// this block from three chapters at once and from every chapter still
// to come in this unit.
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

// ── WHY THIS CHAPTER EXISTS, AND FOR WHOM ────────────────────
// This is how GLF satisfies Lehrplan Y4 2.2 — "Hypothesen formulieren
// und mit einem geeigneten Test oder geeigneten Vertrauensintervallen
// überprüfen" — without needing the normal distribution at all. An
// exact binomial test is a complete, honest hypothesis test built from
// nothing but the binomial distribution of the previous chapter, and
// both calculators compute the tail probabilities directly.
//
// It is equally required reading for SPF, who meet the same ideas
// again in year 4 with continuous distributions behind them. The
// only-high section on errors and power is the part SPF will build on.
//
// ── TWO-SIDED TESTS: A DELIBERATE RESTRICTION ────────────────
// §4 doubles the one-tailed probability ONLY when p0 = 0.5, where the
// distribution is symmetric and doubling is exact. For other p0 there
// are several competing conventions for a two-sided binomial p-value
// (doubling, smallest-likelihood, mid-p), none of them obviously
// right, and choosing between them is well beyond either syllabus. The
// chapter says so out loud rather than quietly doubling everything,
// and every non-symmetric example is one-sided.

= Testing a Claim

#only-theory[
  The last chapter finished on an unfinished thought. A retailer claims
  that $4%$ of his units are defective; a buyer tests twenty and finds
  three. Under the claim, $p(X = 3) approx 0.036$ — and that number
  turned out not to answer the question, because every individual
  result is unlikely and *something* had to happen.

  This chapter fixes the question, and the fix is one phrase: not
  _how likely is this result_, but _how likely is a result at least
  this extreme_. Everything else follows from that.
]

#objectives(
  [formulate a null hypothesis and an alternative hypothesis for a
    claim about a proportion],
  bfkm[calculate the p-value of an observed result using the binomial
    distribution, and decide whether to reject the null hypothesis at a
    given significance level],
  [explain why the p-value uses "at least as extreme" rather than
    "exactly this"],
  [find the rejection region for a test by trying values of the
    critical value],
  [state precisely what a small p-value does and does not establish],
  [explain why failing to reject a hypothesis is not evidence that it
    is true],
  obj(level: "high")[distinguish Type I from Type II errors, and
    calculate the power of a test against a stated alternative],
)

== Asking the Question Properly

#only-theory[
  Suppose the retailer is telling the truth, so that each unit really
  is defective with probability $0.04$, independently of the others.
  Then the number of defective units in a sample of twenty is
  $X tilde B(20, 0.04)$, and the first four probabilities are

  #data-table(
    columns: (auto, auto, auto, auto, auto),
    row-height: auto,
    [$k$], [$0$], [$1$], [$2$], [$3$],
    [$p(X = k)$], [$0.442$], [$0.368$], [$0.146$], [$0.036$],
  )

  Finding three defective units has probability $0.036$ — but so has
  every other specific count once you get far enough out, and the buyer
  did not set out to test whether exactly three would appear. What
  makes three units *suspicious* is not that three is unlikely; it is
  that three is *a lot*. Four would be worse, five worse still.

  So the quantity to compute is the probability of three or more:
  $ p(X >= 3) = 1 - p(X <= 2) = 1 - 0.956 = 0.044. $
]

#keybox(title: "The central idea")[
  To judge whether a result is evidence against a claim, calculate the
  probability — *assuming the claim is true* — of getting a result at
  least as extreme as the one observed.

  If that probability is small, then either the claim is false or
  something unusual has happened. If it is not small, the result is
  the kind of thing the claim predicts anyway, and it is no evidence
  against it.
]

#warning[
  "At least as extreme" is not optional decoration. Comparing
  $p(X = 3) = 0.036$ with $p(X >= 3) = 0.044$ they look similar here,
  but that is an accident of small numbers. For a sample of $200$ with
  $12$ defectives, the probability of *exactly* $12$ is about $0.048$
  while the probability of $12$ *or more* is about $0.108$ — more than
  twice as large, and the difference between "worth a look" and
  "entirely ordinary".

  The single value tells you nothing on its own, because as $n$ grows
  every single value becomes unlikely.
]

== Hypotheses

#definition(title: "Null and Alternative Hypothesis")[
  The #vocab("null hypothesis", "Nullhypothese") $H_0$ is the claim
  being tested. It must be specific enough to give a probability
  distribution — for a proportion, it names a value $p_0$.

  The #vocab("alternative hypothesis", "Alternativhypothese") $H_1$
  says what we suspect instead, and in which direction.
]

#example[
  For the retailer:
  $ H_0: p = 0.04 quad "against" quad H_1: p > 0.04. $
  The alternative points upwards because the buyer suspects *more*
  defects than claimed, not fewer. Finding zero defective units would
  be no reason at all to doubt the retailer.
]

#remark[
  Note the asymmetry built into the whole procedure. $H_0$ is the
  hypothesis that gets to supply the distribution, so it is the one
  that can be *tested*, and it is always the claim of no effect, no
  bias, no difference — the boring option. The test then asks whether
  the data are hard to reconcile with it.

  This means $H_0$ is never proved. It is either rejected, or left
  standing for lack of evidence against it, which are two quite
  different things from "shown to be true".
]

== The p-Value and the Significance Level

#definition(title: "p-Value")[
  The #vocab("p-value", "p-Wert") of an observed result is the
  probability, calculated *assuming $H_0$ is true*, of a result at
  least as extreme as the one observed, in the direction of $H_1$.
]

#definition(title: "Significance Level")[
  The #vocab("significance level", "Signifikanzniveau") $alpha$ is a
  threshold fixed *before* looking at the data. If the p-value is at
  most $alpha$, we *reject* $H_0$ and call the result *significant at
  level $alpha$*. Otherwise we do not reject it.

  By long convention $alpha = 0.05$, sometimes $0.01$ where the cost
  of a wrong rejection is high.
]

#example(title: "The retailer, concluded")[
  With $H_0: p = 0.04$, $H_1: p > 0.04$ and three defectives out of
  twenty:
  $ "p-value" = p(X >= 3) = 1 - p(X <= 2) approx 0.044. $
  Since $0.044 < 0.05$, the result is significant at the $5%$ level
  and we reject $H_0$. The buyer has grounds to doubt the $4%$ claim.

  Note how narrow that is. At $alpha = 0.01$ the same data would not
  have been significant, and the retailer's claim would have stood.
]

#warning[
  The number $0.05$ is a convention and nothing more. It is not a
  property of the world, and there is no sense in which $0.049$ is a
  discovery and $0.051$ is nothing.

  Report the p-value itself, and let the reader judge. A conclusion
  that changes when the threshold moves by a hundredth was never a
  strong conclusion.
]

#ex(difficulty: 2, time: "15 min")[
  A seed packet claims that $90%$ of its seeds germinate. A gardener
  plants $50$ and only $40$ come up.
  #auto-parts(
    1,
    [State $H_0$ and $H_1$.],
    [Calculate the p-value.],
    [Test at the $5%$ level and state your conclusion in a sentence
      about seeds, not about numbers.],
    [Would your conclusion change at the $1%$ level?],
  )
][
  #auto-parts(
    1,
    [$H_0: p = 0.9$ against $H_1: p < 0.9$. The alternative points
      downwards: the gardener suspects the packet is overstating its
      germination rate, and $45$ seeds coming up would be no cause for
      complaint.],
    [With $X tilde B(50, 0.9)$ and the extreme direction being *low*
      values,
      $ "p-value" = p(X <= 40) approx 0.0245. $],
    [Since $0.0245 < 0.05$, reject $H_0$: there is evidence at the
      $5%$ level that fewer than $90%$ of these seeds germinate. The
      packet appears to be overstating its germination rate.],
    [Yes. At $alpha = 0.01$ we would have $0.0245 > 0.01$ and would
      *not* reject $H_0$ — the evidence is not strong enough to meet
      the stricter threshold. The data have not changed; only the
      standard of proof has.],
  )
]

== One-Sided and Two-Sided Tests

#only-theory[
  Both tests so far had a direction. Sometimes there is none: a coin
  might be biased either way, and a die might favour any face.
]

#keybox(title: "Choosing the alternative")[
  / One-sided: $H_1: p > p_0$ or $H_1: p < p_0$ — used when only one
    direction would be interesting or is even possible. The p-value is
    a single tail.

  / Two-sided: $H_1: p eq.not p_0$ — used when a departure in either
    direction counts. Both tails must be included, so the p-value is
    larger.

  The direction has to be chosen *before* seeing the data. Choosing it
  afterwards, to suit the result, roughly doubles your chance of a
  false rejection and is a well-known way of finding effects that are
  not there.
]

#example(title: "A suspect coin")[
  A coin is tossed $20$ times and lands heads $15$ times. Is it
  biased?

  Take $H_0: p = 0.5$ against $H_1: p eq.not 0.5$. From the previous
  chapter we already summed this tail by hand:
  $ p(X >= 15) = #num(21700)/#num(1048576) approx 0.0207. $
  Because $p_0 = 0.5$ the distribution is symmetric, so the other tail
  — $p(X <= 5)$ — has exactly the same probability, and the two-sided
  p-value is
  $ 2 dot 0.0207 approx 0.0414. $
  Just below $0.05$: reject $H_0$ at the $5%$ level, but only just.
]

#warning[
  Doubling the tail is exact only when the distribution is symmetric,
  which for a binomial means $p_0 = 0.5$ and nothing else. For any
  other $p_0$ the two tails are different sizes and there are several
  competing conventions for what the two-sided p-value should even be.

  In this course, two-sided tests are for $p_0 = 0.5$. Everything else
  is one-sided, and the direction is stated as part of the
  hypotheses.
]

#ex(difficulty: 2, time: "15 min")[
  The same coin is tossed $20$ times, but this time lands heads $14$
  times.
  #auto-parts(
    1,
    [Calculate the two-sided p-value.],
    [Test at the $5%$ level.],
    [One extra head changed the conclusion. Discuss whether that is a
      sensible way to make decisions.],
  )
][
  #auto-parts(
    1,
    [$ p(X >= 14) = #num(60460)/#num(1048576) approx 0.0577, $
      so the two-sided p-value is $2 dot 0.0577 approx 0.115$.],
    [Since $0.115 > 0.05$, do not reject $H_0$. There is no
      significant evidence that the coin is biased.],
    [It is not a sensible way, and it is worth being uncomfortable
      about. Fourteen heads gives $0.115$ and fifteen gives $0.041$ —
      so a single toss moves the verdict from "no evidence" to
      "significant", even though nothing about the coin changed and
      the two results are almost equally surprising.

      The fault is not in the arithmetic but in reducing a continuous
      measure of evidence to a yes-or-no answer at a fixed cut. The
      honest report is the p-value, together with the sample size:
      *"14 heads in 20 tosses, $P approx 0.12$"* tells a reader
      everything, and "not significant" tells them almost nothing.],
  )
]

== The Rejection Region

#only-theory[
  So far each test computed a p-value from the data. The other way
  round is often more useful: decide *in advance* which results would
  lead to rejection, and then simply look.
]

#definition(title: "Rejection Region")[
  The #vocab("rejection region", "Verwerfungsbereich") of a test is
  the set of results for which $H_0$ would be rejected. Its boundary is
  the #vocab("critical value", "kritischer Wert").
]

#only-theory[
  Finding it needs no new theory — only the cumulative function and a
  few attempts. For a coin tested at $alpha = 0.05$ with $n = 20$
  against $H_1: p > 0.5$, we want the smallest $k$ with
  $p(X >= k) <= 0.05$. Try values:

  #data-table(
    columns: (auto, auto, auto, auto, auto, auto),
    row-height: auto,
    [$k$], [$12$], [$13$], [$14$], [$15$], [$16$],
    [$p(X >= k)$], [$0.252$], [$0.132$], [$0.058$], [$0.021$],
    [$0.006$],
    [reject?], [no], [no], [no], [*yes*], [*yes*],
  )

  So the critical value is $15$ and the rejection region is
  ${15, 16, dots, 20}$. Fourteen heads is not enough; fifteen is.
]

#keybox(title: "Finding a critical value on either calculator")[
  Compute $1 - $ `binomcdf`$(n, p_0, k - 1)$ for a few values of $k$
  and find where it drops below $alpha$. Three or four attempts is
  usually enough, because the tail probabilities fall quickly.

  For a left-tailed test, compute `binomcdf`$(n, p_0, k)$ instead and
  find the largest $k$ that keeps it at or below $alpha$.
]

#remark[
  Look again at that table. The critical value $15$ gives an actual
  rejection probability of $0.021$, not $0.05$ — the test we have
  built has a real significance level of $2.1%$ even though we asked
  for $5%$.

  This is unavoidable and not a mistake. $X$ takes whole-number values,
  so the available tail probabilities are a discrete list — $0.058$,
  $0.021$, $0.006$ — and $0.05$ is simply not on it. We take the
  largest available value that does not exceed $alpha$, and the test is
  slightly stricter than advertised as a result.

  Anything continuous, like the normal distribution, can hit $0.05$
  exactly. That convenience is one of the reasons the normal
  distribution took over the subject.
]

#ex(difficulty: 2, time: "15 min", hints: (
  "You want the smallest k for which p(X >= k) is at most 0.05, so compute 1 - binomcdf(100, 0.25, k-1) for a few k.",
  "Start near the expected value 25 and work upwards. The tail falls fast.",
  "Once you have the critical value, compare the observed 33 with it.",
))[
  A student claims to be able to sense which of four suits a hidden
  card belongs to. She is tested $100$ times and gets $33$ right.
  #auto-parts(
    1,
    [State $H_0$ and $H_1$, and say what $H_0$ means in terms of the
      student.],
    [Find the rejection region for a test at the $5%$ level.],
    [What is the actual significance level of that test?],
    [Calculate the p-value for $33$ correct and state your
      conclusion.],
    [Suppose she had been tested $1000$ times and got $330$ right —
      the same proportion. Without calculating, would the p-value be
      larger or smaller?],
  )
][
  #auto-parts(
    1,
    [$H_0: p = 0.25$ against $H_1: p > 0.25$. Under $H_0$ she is
      guessing: one suit in four, with no ability at all. The
      alternative is one-sided because sensing suits *worse* than
      chance would not support her claim.],
    [With $X tilde B(100, 0.25)$, and $E(X) = 25$, try values upwards:
      $p(X >= 32) approx 0.069$, $p(X >= 33) approx 0.045$. So the
      critical value is $33$ and the rejection region is
      ${33, 34, dots, 100}$.],
    [$p(X >= 33) approx 0.045$, so the real level is $4.5%$ rather
      than the nominal $5%$.],
    [She got exactly $33$, which is the smallest value in the
      rejection region, so the p-value *is* $0.045$ — significant at
      the $5%$ level, and by the narrowest possible margin. The right
      response is not to believe her but to test her again: a result
      this marginal, obtained once, is exactly what chance produces
      about one time in twenty.],
    [Smaller, and dramatically so. The proportion is the same but the
      evidence is ten times as much data, and the standard deviation
      grows only like $sqrt(n)$ while the gap from the expected value
      grows like $n$. $330$ out of $1000$ would be overwhelming.],
  )
]

== What a Test Does Not Tell You

#only-theory[
  This section matters more than the arithmetic, because the
  arithmetic is easy and the interpretation is where essentially
  everyone goes wrong — including, routinely, published research and
  the reporting of it.
]

#keybox(title: "The p-value is conditioned the wrong way round")[
  A p-value is
  $ p("data at least this extreme" | H_0 "is true"). $

  It is *not*
  $ p(H_0 "is true" | "data"). $

  These are different numbers answering different questions, and the
  second is not calculable from the first without knowing how likely
  $H_0$ was to begin with.
]

#only-theory[
  You have met this twice already, and it is the same error each time.
  In the conditional-probability chapter it was
  $p("infected" | "positive")$ against
  $p("positive" | "infected")$, where the difference was a factor of
  three hundred. It was named there as the prosecutor's fallacy.

  A p-value of $0.03$ does not mean there is a $3%$ chance the null
  hypothesis is true. It means that *if* the null hypothesis were
  true, data like this would turn up $3%$ of the time. Whether the
  hypothesis is true additionally depends on how plausible it was
  before the experiment — which the test never asks about.
]

#ex(difficulty: 2, time: "15 min")[
  A test of $H_0: p = 0.5$ against $H_1: p eq.not 0.5$ gives a
  p-value of $0.03$. Which of the following statements are correct?
  Explain what is wrong with each incorrect one.
  #auto-parts(
    1,
    [There is a $3%$ probability that $H_0$ is true.],
    [If $H_0$ were true, a result at least this extreme would occur
      about $3%$ of the time.],
    [There is a $97%$ probability that $H_1$ is true.],
    [The result is significant at the $5%$ level.],
    [The departure from $p = 0.5$ must be large.],
    [If the experiment were repeated, a significant result would
      follow about $97%$ of the time.],
  )
][
  Only statements 2 and 4 are correct.
  #auto-parts(
    1,
    [*Wrong.* This is $p(H_0 | "data")$, and the p-value is
      $p("data" | H_0)$ — the conditions the wrong way round. Getting
      from one to the other needs a prior probability for $H_0$, which
      no test supplies.],
    [*Correct.* This is the definition, stated carefully: conditioned
      on $H_0$, and about results *at least* this extreme rather than
      exactly this one.],
    [*Wrong,* for the same reason as 1, with the added problem that
      $H_1$ covers every value of $p$ except $0.5$ and so is not a
      single hypothesis with a probability of its own.],
    [*Correct,* since $0.03 <= 0.05$. Note this is a statement about a
      convention, not about the world.],
    [*Wrong.* A p-value measures how *surprising* the data are under
      $H_0$, not how *far* from $H_0$ the truth is. A large sample
      makes a tiny departure highly significant; a small sample can
      leave a huge departure unremarkable. Significance and size are
      independent questions, and the second is the one that usually
      matters.],
    [*Wrong.* Nothing in the calculation is about repetitions of the
      experiment. If the true $p$ happened to be $0.6$, a repeat with
      $n = 20$ would reach significance only about $13%$ of the
      time — a fact the p-value does not mention.],
  )
]

#keybox(title: "Failing to reject is not accepting")[
  A large p-value means the data are consistent with $H_0$. It does
  not mean $H_0$ is true.

  Toss a coin four times, get three heads, and the two-sided p-value
  is $0.625$. Nobody should conclude that the coin is fair — the
  experiment was simply far too small to detect anything. "No
  significant evidence of bias" and "evidence of no bias" are
  different findings, and the first is often only a report on the
  sample size.
]

#remark[
  This is also why the direction of a one-sided test has to be fixed
  in advance, and why running many tests is dangerous.

  If you test twenty independent hypotheses at the $5%$ level and all
  twenty are false, the expected number of significant results is
  $20 dot 0.05 = 1$, and the probability of at least one is
  $ 1 - (0.95)^(20) approx 0.64. $
  So a researcher testing twenty things and reporting the one that
  "worked" has found nothing at all, with probability about two thirds.

  That is Littlewood's law from the last unit, wearing a lab coat:
  rarity means nothing until you know how many opportunities there
  were.
]

#only-high[
  == Two Kinds of Error

  #only-theory[
    A test can be wrong in two ways, and they are not symmetric.
  ]

  #keybox(title: "Type I and Type II")[
    / Type I error: rejecting $H_0$ when it is true — a false alarm.
      Its probability is the actual significance level of the test.

    / Type II error: failing to reject $H_0$ when it is false — a
      missed detection. Its probability is written $beta$, and unlike
      a Type I error it cannot be calculated from $H_0$ alone: you must
      say *which* alternative value of $p$ you have in mind.

    The #vocab("power", "Teststärke") of a test against a stated
    alternative is $1 - beta$: the probability that it correctly
    rejects a false $H_0$.
  ]

  #only-theory[
    Lowering $alpha$ shrinks the rejection region, so false alarms
    become rarer and missed detections more common. The two error
    rates trade off against each other, and the only way to reduce both
    at once is to collect more data.
  ]

  #example(title: "How weak is a 20-toss test?")[
    Keep the coin test with $n = 20$, rejecting when $X >= 15$. Suppose
    the coin really is biased, with $p = 0.7$. Then the test rejects
    with probability
    $ p(X >= 15) = 1 - p(X <= 14) approx 0.416, $
    where now $X tilde B(20, 0.7)$.

    So a coin that comes up heads $70%$ of the time escapes detection
    more often than not. Tabulating the power against several
    alternatives:

    #data-table(
      columns: (auto, auto, auto, auto, auto),
      row-height: auto,
      [true $p$], [$0.5$], [$0.6$], [$0.7$], [$0.8$],
      [power], [$0.021$], [$0.126$], [$0.416$], [$0.804$],
    )

    The first column is the Type I error rate, since $p = 0.5$ is
    $H_0$. The rest is the price of a small sample: this test only
    reliably catches a coin that is badly biased.
  ]

  #ex(difficulty: 3, level: "high", time: "15 min")[
    A manufacturer claims a defect rate of $5%$. A sample of $50$ is
    tested, and $H_0: p = 0.05$ is rejected against $H_1: p > 0.05$
    when $6$ or more defects appear.
    #auto-parts(
      1,
      [Find the probability of a Type I error.],
      [The true defect rate is in fact $0.12$. Find the probability of
        a Type II error, and the power of the test.],
      [The manufacturer would prefer a smaller $alpha$; the buyer
        would prefer greater power. Explain the conflict, and say what
        would satisfy both.],
    )
  ][
    #auto-parts(
      1,
      [With $X tilde B(50, 0.05)$,
        $ p(X >= 6) = 1 - p(X <= 5) approx 0.038. $
        So the real significance level is about $3.8%$.],
      [Now $X tilde B(50, 0.12)$, and the test fails to reject when
        $X <= 5$:
        $ beta = p(X <= 5) approx 0.435, quad
          "power" = 1 - beta approx 0.565. $
        A defect rate more than twice the claim goes undetected well
        over two times in five.],
      [Raising the critical value from $6$ lowers $alpha$ and lowers
        the power with it; lowering the critical value does the
        reverse. With $n$ fixed, every gain for one party is a loss
        for the other.

        What satisfies both is a larger sample. Increasing $n$ narrows
        the distribution relative to its mean — $sigma$ grows like
        $sqrt(n)$ while $E(X)$ grows like $n$ — so both error rates
        can be reduced at once. Better data is the only escape from the
        trade-off, which is a general truth about statistics and not a
        fact about defect rates.],
    )
  ]
]

#sim-box(notebook: "03-binomial-test.ipynb")[
  The claim that the coin test has a real significance level of $2.1%$
  rather than $5%$ can be checked by running it:

  ```python
  import numpy as np
  rng = np.random.default_rng(seed=11)

  heads = rng.binomial(20, 0.5, size=200000)
  print("rejected:", (heads >= 15).mean())
  ```

  *What to look for.* A rejection rate near $0.021$, not $0.05$ — the
  test really is stricter than it was asked to be, and simulating it
  is the most convincing way to see that.

  The one line to change is the true value of $p$. Setting it to
  $0.7$ instead of $0.5$ turns the same code into a power calculation,
  and the notebook plots the whole power curve.
]

#ai-box(role: "Checker")[
  Ask an AI assistant to explain what a p-value of $0.03$ means. Do not
  give it the six statements from the exercise above.

  Then grade its answer against them. The two failures to watch for are
  the ones people make: saying or implying that there is a $3%$ chance
  the null hypothesis is true, and treating a small p-value as evidence
  that the effect is *large*.

  Then ask it the harder question: _my p-value was 0.20, so is the null
  hypothesis true?_ A good answer refuses the question and asks about
  the sample size. A weak one says "no significant evidence was found"
  and stops, which is true and useless.
]

#look-ahead(preview: [confidence intervals])[
  A test answers a yes-or-no question about one candidate value of $p$.
  Ask it about $p = 0.04$ and it says "reject"; ask it about
  $p = 0.10$ and it will say something else. Nothing stops you asking
  about every value in turn.

  Doing exactly that — collecting all the values of $p$ that the data
  would *not* have rejected — produces an interval, and that interval
  is far more informative than any single verdict. It is called a
  confidence interval, and it is the last idea in this unit.
]

#print-hints()
#print-vocab()
