#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Random Variables")
#let ex = exercise.with(chapter: "Random Variables")

// ── LOCAL ENVIRONMENT: sim-box ───────────────────────────────
// Holds a short Python snippet plus a line saying what to look for.
// Suppressed in the solutions booklet always, and on the exercise
// sheet unless on-sheet: true — the same gate as ai-box, so a
// simulation reaches the sheet only when running it IS the question.
//
// PROMOTE TO preamble.typ once you have seen it render: it appears in
// every chapter of this unit. If you move it, delete this block and
// nothing else changes.
//
// COLOUR is a one-line decision I have made provisionally: graphite
// on neutral grey, chosen to read as "technical aside" and to stay
// clear of the eight palette pairs already in use. It is closest to
// ahead-col/ahead-bg (slate on blue-grey), so if the two look alike
// on paper, change sim-col/sim-bg here.
//
// Keep snippets to five to eight lines. Anything longer belongs in
// the notebook and not in the notes.
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

// ── TEACHER'S NOTE ───────────────────────────────────────────
// Two exercises here were deliberately held back from the
// probabilities-combinatorics unit because they are expected-value
// problems: the lottery-prize one (old Ex 63) and Elena's card game
// (old Ex 86e). They appear below. Old Ex 64 has been split three
// ways: part (a) is here, part (b) belongs in ch-binomial and part
// (c) — "is it eligible to use the binomial distribution?" — is the
// natural opening exercise for ch-models.
//
// The class dataset: data/reaction-times.csv shipped with this unit is
// SYNTHETIC placeholder data, so that everything compiles and runs
// before your class has collected anything. Replace it with the real
// file after the collection lesson; nothing in the chapter depends on
// the particular numbers, and §5 is written to work with whatever the
// class produces. The placeholder is right-skewed on purpose, because
// real reaction times are.

= Random Variables

#only-theory[
  The last unit answered questions of the form _how likely is this?_
  Every event was a set of outcomes, and the answer was a number
  between $0$ and $1$.

  A great many real questions are not of that form. How many heads
  should I expect? How much will this insurance policy cost the
  company on average? How long will I wait? These ask for a number
  attached to the outcome rather than for the chance of the outcome
  itself — and to answer them, the outcomes have to carry numbers.
]

#objectives(
  [explain what a random variable is, and distinguish the variable
    itself from the event that it takes a particular value],
  [write down the probability distribution of a random variable, and
    check it],
  bfkm[calculate the expected value of a random variable, and
    interpret it],
  [explain why the expected value need not be a value the variable can
    actually take],
  [decide whether a game is fair, and calculate a fair stake],
  [calculate the variance and standard deviation of a random
    variable],
  obj(level: "high")[use the shortcut
    $"Var"(X) = E(X^2) - mu^2$, and say how $E$ and $"Var"$ behave
    under $a X + b$],
)

#remark[
  A word about the computer, once, so it need not be repeated.

  From here on you will meet boxes marked *Simulation* containing a
  few lines of Python. They are there to let you see things that
  cannot be seen any other way — a distribution assembling itself out
  of repeated trials, for instance. They are never the only route to
  an answer. Every result in this unit is reachable with a calculator
  and a pencil, which is just as well, because a calculator and a
  pencil are what you get in an exam.
]

== From Outcomes to Numbers

#definition(title: "Random Variable")[
  A #vocab("random variable", "Zufallsgrösse") is a rule that assigns
  a number to every outcome of a random experiment.

  Random variables are written with capital letters, usually $X$ or
  $Y$; the values they can take are written with the matching small
  letter.
]

#example(title: "Two coins")[
  Toss a coin twice, so
  $Omega = {(h,h), (h,t), (t,h), (t,t)}$, and let $X$ be the number of
  heads. Then $X$ assigns
  $ (h,h) |-> 2, quad (h,t) |-> 1, quad (t,h) |-> 1, quad
    (t,t) |-> 0. $
]

#warning[
  $X$ and "$X = 1$" are different kinds of object, and the difference
  matters for the rest of the unit.

  $X$ is the rule — it turns an outcome into a number, and it is not
  random in itself. "$X = 1$" is an *event*: the set of outcomes that
  $X$ sends to $1$, here ${(h,t), (t,h)}$. So $p(X = 1)$ makes sense,
  and it is the last unit's notation applied to an ordinary event.

  Writing $p(X)$ makes no sense at all.
]

#only-theory[
  You have already met the essential idea. In the sample-space chapter
  the same coin-tossing experiment appeared twice — once recording
  both tosses, once recording only how many heads — and the second
  version's sample space was ${0, 1, 2}$ with unequal probabilities.
  That second experiment *was* a random variable, before there was a
  word for it. What is new is treating the numbers as numbers, so that
  they can be averaged.
]

== The Distribution of a Random Variable

#keybox(title: "Probability distribution")[
  The #vocab("probability distribution", "Wahrscheinlichkeitsverteilung")
  of a random variable $X$ lists every value it can take together with
  the probability of taking it.

  The probabilities must be between $0$ and $1$ and must add to $1$,
  because $X$ takes exactly one value each time the experiment is
  run.
]

#example[
  For $X$ = number of heads in two tosses, the events $X = 0$,
  $X = 1$ and $X = 2$ contain one, two and one of the four equally
  likely outcomes:

  #data-table(
    columns: (auto, auto, auto, auto, auto),
    row-height: auto,
    [$x$], [$0$], [$1$], [$2$], [*sum*],
    [$p(X = x)$], [$1/4$], [$1/2$], [$1/4$], [*$1$*],
  )
]

#remark[
  This is the same table the sample-space chapter used for outcomes
  that were not equally likely, with one change: the top row now holds
  *numbers* rather than labels. That is the whole difference between a
  sample space and a random variable, and it is what makes the next
  section possible. You cannot average "heads".
]

== Expected Value

#only-theory[
  Roll a fair die many times and average the results. Not $3$, not
  $4$: the average settles at $3.5$, because the six faces contribute
  equally and $(1 + 2 + dots.c + 6) slash 6 = 3.5$.

  Now make the values unequally likely. If $X$ is the number of heads
  in two tosses, an average over many repetitions must count the value
  $1$ twice as heavily as $0$ or $2$, because it happens twice as
  often. That is a weighted mean, and you met weighted means in the
  descriptive-statistics unit.
]

#definition(title: "Expected Value")[
  The #vocab("expected value", "Erwartungswert") of a random variable
  $X$ taking the values $x_1, x_2, dots, x_n$ is
  $ E(X) = x_1 dot p(X = x_1) + x_2 dot p(X = x_2) + dots.c
         + x_n dot p(X = x_n) = sum_(i=1)^n x_i dot p(X = x_i). $

  It is often written $mu$, the same letter used for the mean of a
  population, and for good reason: it is a mean, with probabilities in
  place of relative frequencies.
]

#example[
  For the two coins,
  $ E(X) = 0 dot 1/4 + 1 dot 1/2 + 2 dot 1/4 = 1. $
  For a fair die,
  $ E(X) = (1 + 2 + 3 + 4 + 5 + 6) dot 1/6 = 21/6 = 3.5. $
]

#warning[
  The expected value is not the value to expect. A die never shows
  $3.5$.

  It is the long-run *average*, and averages of whole numbers are
  routinely not whole numbers — a country's families average $1.4$
  children without any family having $1.4$ children. Read $E(X)$ as
  "the average over very many repetitions", never as "the most likely
  result" or "the result I should predict".
]

#remark[
  Why the long-run average is what the formula computes is the law of
  large numbers again. Over $N$ repetitions, the value $x_i$ turns up
  with relative frequency close to $p(X = x_i)$, so the ordinary
  average of the results is close to $sum x_i dot p(X = x_i)$. The
  expected value is the mean that the data is heading towards.
]

#ex(difficulty: 2, time: "15 min")[
  Two fair dice are rolled and $X$ is the sum of the two numbers.
  #auto-parts(
    1,
    [Write down the probability distribution of $X$ and check that the
      probabilities add to $1$.],
    [Calculate $E(X)$.],
    [The distribution is symmetric about its middle value. Explain how
      that lets you write down $E(X)$ without doing the sum.],
  )
][
  #auto-parts(
    1,
    [Counting the $36$ equally likely ordered pairs:

      #data-table(
        columns: (auto, auto, auto, auto, auto, auto, auto, auto,
          auto, auto, auto, auto),
        row-height: auto,
        [$x$], [$2$], [$3$], [$4$], [$5$], [$6$], [$7$], [$8$],
        [$9$], [$10$], [$11$], [$12$],
        [$36 dot p$], [$1$], [$2$], [$3$], [$4$], [$5$], [$6$],
        [$5$], [$4$], [$3$], [$2$], [$1$],
      )

      The second row adds to $36$, so the probabilities add to $1$.],
    [$ E(X) = (2 dot 1 + 3 dot 2 + dots.c + 12 dot 1)/36
       = 252/36 = 7. $],
    [Pair the values off from the outside in: $2$ with $12$, $3$ with
      $11$, and so on. Each pair is equally likely and averages $7$,
      and the leftover middle value is $7$ itself. A symmetric
      distribution always has its expected value at the centre of
      symmetry, which is worth spotting before starting any
      arithmetic. #heuristic("look for what stays the same")],
  )
]

#ex(difficulty: 1, time: "8 min")[
  About one person in eight suffers from hay fever. There are $29$
  students in a mathematics course. How many of them would you expect
  to be affected?
][
  Each student is affected with probability $1 slash 8$, and there are
  $29$ of them, so the expected number is
  $ 29 dot 1/8 = 3.625 approx 3.6 "students". $
  Which is of course not a possible number of students. It is the
  average you would get over very many courses of $29$.
]

== Fair Games and Decisions

#only-theory[
  Expected value earns its keep when a number has to be decided: a
  stake, a premium, a price. In every case the question is the same —
  what does this cost on average, over many repetitions?
]

#definition(title: "Fair Game")[
  A game is #vocab("fair", "fair", show-de: false) if the expected
  net gain of each player is $0$.

  If a game pays out $X$ and costs $k$ to play, the net gain is
  $X - k$, and the game is fair exactly when $k = E(X)$.
]

#example(title: "Roulette")[
  A European roulette wheel has $37$ pockets: $18$ red, $18$ black and
  one green zero. Stake CHF $1$ on red and you gain CHF $1$ if it
  comes up red and lose your CHF $1$ otherwise. With $X$ the net gain,
  $ E(X) = (+1) dot 18/37 + (-1) dot 19/37 = -1/37
    approx -0.027. $

  So every franc staked on red loses about $2.7$ centimes on average.
  The single green pocket is the entire business model: without it the
  game would be fair and the casino would break even.
]

#ex(difficulty: 2, time: "12 min")[
  Per million lottery tickets sold, the prizes are one of CHF
  #num(50000), nine of CHF #num(5000), ninety of CHF $500$ and nine
  hundred of CHF $50$. A ticket costs CHF $0.50$.
  #auto-parts(
    1,
    [Find the expected prize per ticket.],
    [Find the expected profit of the organizer per million tickets
      sold.],
    [What stake would make the lottery a fair game? Would anybody run
      it?],
  )
][
  #auto-parts(
    1,
    [The total prize money per million tickets is
      $ #num(50000) + 9 dot #num(5000) + 90 dot 500 + 900 dot 50
        = #num(185000), $
      so the expected prize per ticket is
      $ #num(185000)/#num(1000000) = "CHF " 0.185. $
      Note this is also $E(X)$ computed the long way: each prize value
      times its probability.],
    [Each ticket takes in CHF $0.50$ and pays out CHF $0.185$ on
      average, so
      $ #num(1000000) dot (0.50 - 0.185) = "CHF " #num(315000). $],
    [A fair stake would be CHF $0.185$. Nobody would run it: at a fair
      stake the organizer's expected profit is exactly zero, and
      printing tickets is not free. Every commercial game of chance
      must be unfair in the technical sense, or it could not exist.],
  )
]

#ex(difficulty: 2, time: "12 min")[
  An insurer offers a policy paying CHF #num(10000) if a certain event
  occurs during the year, and nothing otherwise. The event has
  probability $0.015$. The premium is CHF $200$.
  #auto-parts(
    1,
    [What is the insurer's expected payout per policy?],
    [What is the insurer's expected profit per policy?],
    [The premium is more than the expected payout, so buying the
      policy has negative expected value for the customer. Give a
      reason why buying it can still be a sensible decision.],
  )
][
  #auto-parts(
    1,
    [$#num(10000) dot 0.015 = "CHF " 150$.],
    [$200 - 150 = "CHF " 50$ per policy, which is where the salaries
      come from.],
    [Because a loss of CHF #num(10000) may be unaffordable while a
      loss of CHF $200$ is merely annoying, and those two are not on
      the same scale for the customer even though they are for the
      insurer. The insurer holds thousands of policies, so the law of
      large numbers applies to them and their average is reliable;
      the customer holds one, and no average applies to them at all.

      Expected value is the right tool for the party with many
      repetitions. It is not, on its own, the right tool for a
      once-only decision — which is worth remembering every time
      somebody computes an expected value and calls it a
      recommendation.],
  )
]

#ex(difficulty: 3, time: "15 min", hints: (
  "First find the probability of drawing an O on a single draw.",
  "How many O's do you expect in four draws? You do not need the distribution of the number of O's to answer that.",
  "The payout is CHF 5 for each O. What does that make the expected payout, and what is the net after the stake?",
))[
  An urn holds ten cards bearing the letters
  E, P, G, G, G, O, O, T, T, T. A game costs CHF $5$ to play. You draw
  four cards, replacing each before the next, and receive CHF $5$ for
  every O you draw.
  #auto-parts(
    1,
    [What is the expected net result for a player?],
    [Is the game fair? What stake would make it fair?],
  )
][
  #auto-parts(
    1,
    [Two of the ten cards are O's, so $p("O") = 0.2$ on every draw. In
      four draws the expected number of O's is
      $ 4 dot 0.2 = 0.8, $
      and each O pays CHF $5$, so the expected payout is
      $ 5 dot 0.8 = "CHF " 4. $
      After the CHF $5$ stake, the expected net result is
      $ 4 - 5 = -"CHF " 1 "per game". $],
    [Not fair — the player loses CHF $1$ per game on average. A stake
      of CHF $4$ would make it fair.],
  )

  Note what was *not* needed: the distribution of the number of O's.
  Expecting $0.8$ O's and multiplying by CHF $5$ was enough. That
  shortcut is not a coincidence, and the next chapter explains it.
]

== Variance and Standard Deviation

#only-theory[
  Two random variables can share an expected value and behave nothing
  alike. A game that always pays CHF $10$ and a game that pays CHF
  $0$ or CHF $20$ with equal probability both have $E(X) = 10$; only
  one of them is worth talking about.

  What is missing is a measure of spread, and the descriptive-statistics
  unit already supplies the idea: average the squared distances from
  the mean. The only change is that the averaging is done with
  probabilities.
]

#definition(title: "Variance and Standard Deviation")[
  For a random variable $X$ with $E(X) = mu$, the
  #vocab("variance", "Varianz") is
  $ "Var"(X) = sum_(i=1)^n (x_i - mu)^2 dot p(X = x_i), $
  and the #vocab("standard deviation", "Standardabweichung") is
  $ sigma = sqrt("Var"(X)). $
]

#example(title: "A fair die")[
  With $mu = 3.5$,
  $ "Var"(X) = ((1 - 3.5)^2 + (2 - 3.5)^2 + dots.c + (6 - 3.5)^2)
    dot 1/6 = 35/12 approx 2.917, $
  so $sigma = sqrt(35 slash 12) approx 1.708$.

  Both distances of $2.5$ at the ends and both of $0.5$ in the middle
  contribute, and $sigma$ lands between them — a typical roll is
  something like $1.7$ away from $3.5$.
]

#remark[
  Note that the variance is in *squared* units, which is why it is
  almost never quoted on its own. A die's variance is $2.917$
  "squared pips", which means nothing; its standard deviation of
  $1.708$ pips is a length on the same scale as the values, and is
  what gets reported.

  This is exactly the argument the descriptive-statistics unit made
  for the standard deviation over the variance, and it has not
  changed.
]

#only-high[
  === Two Shortcuts

  #only-theory[
    Computing $"Var"(X)$ from the definition means subtracting $mu$
    from every value first, which is tedious and error-prone when
    $mu$ is not a whole number. Expanding the bracket gives a version
    that needs only the values themselves:
    $ "Var"(X) = E(X^2) - mu^2, $
    where $E(X^2) = sum x_i^2 dot p(X = x_i)$ — square the values,
    average with the same probabilities, then subtract the square of
    the mean.

    For the die: $E(X^2) = (1 + 4 + 9 + 16 + 25 + 36) slash 6
    = 91 slash 6$, and
    $ 91/6 - 3.5^2 = 15.1overline(6) - 12.25 = 35/12, $
    as before.

    The second shortcut says what happens when a variable is rescaled.
    If $Y = a X + b$ for constants $a$ and $b$, then
    $ E(Y) = a dot E(X) + b, quad
      "Var"(Y) = a^2 dot "Var"(X), quad
      sigma_Y = abs(a) dot sigma_X. $
    Adding a constant shifts the mean and leaves the spread alone —
    moving every value up by $b$ moves the average up by $b$ and
    changes no distance between values. Multiplying by $a$ stretches
    both, and stretches the variance by $a^2$ because the variance is
    built from squares.
  ]
]

#ex(difficulty: 2, time: "12 min")[
  A random variable $X$ has the distribution

  #data-table(
    columns: (auto, auto, auto, auto, auto),
    row-height: auto,
    [$x$], [$-2$], [$0$], [$1$], [$4$],
    [$p(X = x)$], [$0.1$], [$0.4$], [$0.3$], [$0.2$],
  )

  #auto-parts(
    1,
    [Check the distribution, then find $E(X)$.],
    [Find $"Var"(X)$ and $sigma$.],
    [What is the probability that $X$ lies within one standard
      deviation of its expected value?],
  )
][
  #auto-parts(
    1,
    [The probabilities add to $1$. Then
      $ E(X) = -2 dot 0.1 + 0 dot 0.4 + 1 dot 0.3 + 4 dot 0.2
        = -0.2 + 0.3 + 0.8 = 0.9. $],
    [Squared distances from $0.9$, weighted:
      $ "Var"(X) &= (-2.9)^2 dot 0.1 + (-0.9)^2 dot 0.4
        + (0.1)^2 dot 0.3 + (3.1)^2 dot 0.2 \
        &= 0.841 + 0.324 + 0.003 + 1.922 = 3.09, $
      so $sigma = sqrt(3.09) approx 1.758$.],
    [One standard deviation either side of $0.9$ is the interval from
      $-0.858$ to $2.658$, which contains the values $0$ and $1$:
      $ 0.4 + 0.3 = 0.7. $],
  )
]

#only-high[
  #ex(difficulty: 3, level: "high", time: "12 min")[
    Let $X$ be the score on a fair die.
    #auto-parts(
      1,
      [Use $"Var"(X) = E(X^2) - mu^2$ to confirm
        $"Var"(X) = 35 slash 12$.],
      [A game pays CHF $3$ per pip, minus a CHF $2$ entry fee, so the
        payout is $Y = 3X - 2$. Find $E(Y)$ and $sigma_Y$ without
        writing out the distribution of $Y$.],
      [Explain why $"Var"(Y)$ does not depend on the CHF $2$ fee.],
    )
  ][
    #auto-parts(
      1,
      [$E(X^2) = (1 + 4 + 9 + 16 + 25 + 36) slash 6 = 91 slash 6$, and
        $ 91/6 - (7/2)^2 = 182/12 - 147/12 = 35/12. $],
      [$ E(Y) = 3 dot 3.5 - 2 = "CHF " 8.5, quad
         sigma_Y = 3 dot sqrt(35 slash 12) approx "CHF " 5.12. $],
      [Subtracting a fixed fee moves every possible payout down by the
        same CHF $2$, so every *distance* between payouts is
        unchanged — and the variance is built entirely out of
        distances from the mean, which have all moved along with the
        mean. Only the factor of $3$ stretches the spread.],
    )
  ]
]

== The Class Dataset

#only-theory[
  Everything so far has been a random variable whose distribution was
  known in advance, because it came from a fair die or a fair coin.
  Most real random variables are not like that. Their distribution is
  unknown, and all you have is data.

  So let us get some. Your class will collect its own reaction times —
  a quantity that is genuinely random, genuinely yours, and genuinely
  awkward, which is the point. It will come back in the next two
  chapters.
]

#exploration(title: "Collecting the data")[
  Use any reaction-time test that measures the delay between a signal
  appearing and your click. Each student records *three* attempts.

  Enter the results in a single file with one row per attempt and
  three columns:

  #data-table(
    columns: (auto, auto, auto),
    row-height: auto,
    [`student_id`], [`trial`], [`reaction_ms`],
    [`S01`], [`1`], [`241`],
    [`S01`], [`2`], [`261`],
    [$dots.v$], [$dots.v$], [$dots.v$],
  )

  Two questions to answer before you compute anything, and to write
  down so you can check them later:
  + Do you expect the mean and the median to be about equal? If not,
    which will be larger?
  + Is a person's reaction time one number, or is each attempt a
    fresh draw from something? What would settle that?
]

#remark[
  That file is a *dataframe*: a table in which every column has a
  name and a type, holding data and nothing else.

  The distinction is worth being precise about, because the obvious
  alternative — a spreadsheet — looks like the same thing and is not.
  In a spreadsheet the data, the calculations and the presentation all
  live in the same grid, and afterwards there is no record of what was
  done to get from one to the other. A dataframe keeps the data
  separate from the code that operates on it, so the analysis is a
  thing you can read, correct and run again.

  This is not fussiness. Some well-known economic and public-health
  results have had to be withdrawn because a calculation buried in a
  spreadsheet grid turned out to be wrong and nobody could see it.
]

#sim-box(notebook: "01-random-variables.ipynb")[
  Loading the class data and finding its mean and standard deviation
  takes four lines:

  ```python
  import pandas as pd

  df = pd.read_csv("reaction-times.csv")
  times = df["reaction_ms"]
  print(times.mean(), times.median(), times.std())
  ```

  *What to look for.* Compare the mean with the median. For the
  placeholder data shipped with these notes the mean is about
  $293$ ms and the median about $271$ ms — the mean is the larger,
  which the histogram in the notebook explains at a glance.

  The notebook also has a *Going further* section that splits the
  times by student, to address the second question from the
  collection task.
]

#ex(difficulty: 2, time: "15 min")[
  Using your class's own data:
  #auto-parts(
    1,
    [Find the mean and the standard deviation of all the reaction
      times.],
    [Find the median. Which is larger, the mean or the median, and
      what does that tell you about the shape?],
    [Explain in what sense a single reaction time is a random
      variable, and what its distribution would be.],
    [The mean of your data is an estimate. Of what?],
  )
][
  Answers depend on the class's data; what follows is the reasoning,
  with the placeholder figures as an illustration.
  #auto-parts(
    1,
    [For the placeholder data, a mean of about $293$ ms and a standard
      deviation of about $80$ ms.],
    [Median about $271$ ms, so the mean is larger. That is the
      signature of a right-skewed distribution: a few slow attempts
      pull the mean up while leaving the median where it is. Reaction
      times behave this way for an obvious reason — there is a hard
      floor set by nerve conduction, and no ceiling at all on being
      distracted.],
    [Each attempt produces a number that could not have been predicted
      beforehand, which is exactly what a random variable is. Its
      distribution is the set of values it can take with their
      probabilities — and unlike the die, nobody knows what that
      distribution is. It has to be estimated from data or modelled.],
    [Of the expected value. The mean of $n$ observations estimates
      $E(X)$, and by the law of large numbers the estimate improves as
      $n$ grows. This is the link that the whole of inferential
      statistics is built on, and it is worth noticing that it runs in
      the opposite direction to everything in this chapter: here we
      computed $E(X)$ from a known distribution, and there we will
      estimate an unknown $E(X)$ from data.],
  )
]

#ai-box(role: "Tutor")[
  Take the die-game exercise you have just done and change one thing:
  suppose the die is *loaded*, so that a six comes up with probability
  $0.3$ and the other five faces share the rest equally.

  Work out $E(X)$ yourself first. Then ask an AI assistant for it, and
  compare — not just the answer, but whether it wrote down a
  distribution before averaging.

  Then ask it this: _my die has expected value 3.5, so is it fair?_
  The answer is no, and finding a loaded die with expected value
  exactly $3.5$ is a good exercise in its own right. Watch whether the
  assistant claims that $E(X) = 3.5$ implies fairness — it is a
  tempting thing to say, and it is false, because the expected value
  is one number summarizing six.
]

#look-ahead(preview: [the binomial distribution])[
  Twice in this chapter a shortcut appeared without explanation:
  expecting $29 slash 8$ hay-fever sufferers among $29$ students, and
  $0.8$ O's in four draws. In both cases the answer was
  "number of trials times probability of success", and in neither case
  was a distribution needed.

  That pattern has a name, a formula, and a shape, and the counting
  chapter of the last unit already built half of it: the number of
  paths with $k$ successes in $n$ trials is $binom(n, k)$. Putting
  the two halves together gives the one distribution both tracks are
  required to know.
]

#print-hints()
#print-vocab()
