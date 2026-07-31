#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Randomness and Uncertainty")
#let ex = exercise.with(chapter: "Randomness and Uncertainty")

// ── IMAGE NOTE ───────────────────────────────────────────────
// The figures below still have to be copied out of the old LaTeX
// img/ folder into ./images/ and renamed per STYLE_GUIDE.md §7
// (lowercase, hyphenated, descriptive, never named after an exercise
// number). Old name → suggested new name:
//   conditional_risk        → xkcd-795-conditional-risk.png
//   random-pic-internet-01  → google-most-random-picture.jpg
//   true-random             → true-random-noise.png
//   Coin_Toss               → coin-toss-running-proportion.png
// Every #image call is commented out below so this chapter compiles
// before the files are in place. Uncomment as you add them.
//
// POSSIBLE UPGRADE: true-random-noise.png could be replaced by a
// native Typst figure — a grid of black/white cells driven by a
// deterministic formula. The picture would then itself be an example
// of the pseudo-randomness discussed on the same page, which is a
// better joke than a PNG. Say the word and I'll write the helper.
//
// The coin-toss figure is optional: the table in §3 carries the same
// point natively, and does it with numbers students can check.

// ── TEACHER'S NOTE ───────────────────────────────────────────
// Two factual claims here that I could not verify against a source
// and that are worth a check before printing:
//   * Kerrich's coin experiment (§3): 10'000 tosses, 5067 heads,
//     while interned in Denmark during WWII. The headline figure is
//     very widely reproduced (Freedman/Pisani/Purves among others),
//     but confirm it if you plan to lean on the story.
//   * The two lightning figures in Exercise 1 are taken from your
//     LaTeX notes as given. Exercise 1 asks students to show they are
//     inconsistent, which is the point — but if you have the original
//     NWS source, a real citation would make the exercise land harder.

= Randomness and Uncertainty

#only-theory[
  The last unit was about data you already had. Every technique in it
  — the mean, the median, the box plot, the regression line — looked
  backwards at measurements that had already been made.

  This unit looks forward, at things that have not happened yet, and
  it has to do so without pretending to know more than it does. That
  turns out to require a surprisingly careful vocabulary. We use words
  like _chance_, _random_, _likely_ and _certain_ constantly in
  ordinary speech, and we use them loosely enough that they will not
  survive being calculated with. So the first job is to say exactly
  what they mean.
]

#epigraph(by: "Pierre-Simon Laplace, 1814")[
  The theory of probabilities is at bottom nothing but common sense
  reduced to calculus.
]

#only-theory[
  Laplace is being optimistic. A good deal of this unit consists of
  situations where common sense and the calculus disagree, and common
  sense turns out to be wrong. That is exactly why the subject is
  worth the trouble.
]

#objectives(
  [describe what makes a process #vocab("random", "zufällig",
    show-de: false) and what makes one deterministic, and explain why
    a single event cannot be called random — only a sequence of them],
  // The Lehrplan badges this competency as BfKM for SPF (3.1) but not
  // for GLF (1.3), so the item is written twice rather than once: the
  // objectives box doubles as a coverage audit trail, and a badge in
  // the wrong document would make that record inaccurate.
  bfkm(level: "high")[explain what the relative frequency of an event
    is, and what the probability of an event is],
  obj(level: "basic")[explain what the relative frequency of an event
    is, and what the probability of an event is],
  [estimate a probability from data, and say how much confidence that
    estimate deserves],
  [say where a given probability came from — symmetry, data, or
    judgment — and why that matters],
  [recognize the gambler's fallacy and say precisely what is wrong
    with it],
  obj(level: "high")[explain why the *proportion* of heads settles
    down as tossing continues while the *gap* between heads and tails
    does not],
)

== What Do We Mean by "Random"?

#only-theory[
  In everyday speech, "random" means something like _unexpected_ or
  _unconnected_. People say "oh, that's so random" about a remark that
  came out of nowhere. On 2 May 2017 I typed "most random picture on
  the internet" into a search engine, and this is what came back:
]

// #fig(image("images/google-most-random-picture.jpg", width: 35%))

#only-theory[
  That is a strange picture. It is not a random one. Look at it and
  you can describe it: a man, a rainbow, a flying carpet. It has
  structure, which is precisely what randomness lacks.
]

#definition(title: "Randomness")[
  #vocab("Randomness", "Zufall") is the absence of
  pattern or predictability. A random sequence of events, symbols or
  steps follows no order and no intelligible rule.

  The opposite is #vocab("deterministic", "deterministisch"): a
  process is deterministic if knowing its starting conditions is
  enough to determine every later state.
]

#warning[
  A single event is never random. Randomness is a property of a
  *sequence*, not of one item in it.

  A picture is not random; a coin landing heads is not random. What
  can be random is the process that produced it — the search that
  returned that picture, the toss that produced that head. Ask
  "random" of one outcome and the question has no answer.
]

#only-theory[
  A genuinely random image has no structure to describe. It looks like
  this, and there is nothing more to say about it than that:
]

// #fig(image("images/true-random-noise.png", width: 30%),
//   caption: [Static. There is no shorter description of this picture
//     than the picture itself — which is one working definition of
//     randomness.])

#remark[
  Producing real randomness on a computer is harder than it sounds.
  The standard `random()` in any programming language is a
  #vocab("pseudo-random", "pseudozufällig") number generator: a
  deterministic formula, chosen so that its output has no pattern a
  casual observer will notice. Feed it the same starting value — its
  _seed_ — and it will produce exactly the same "random" sequence
  again, which is enormously useful for debugging and completely
  disqualifying for cryptography. Systems that need the real thing
  sample something physical instead: thermal noise, radioactive decay,
  or in one famous case a wall of lava lamps.
]

#ex(difficulty: 1, time: "5 min")[
  "When I play a game with a die, the event 'rolling a six' has to
  happen by the sixth roll at the latest." Explain what is wrong with
  this statement.
][
  The die has no memory. Nothing about the first five rolls changes
  what the sixth does, so there is no mechanism by which a six could
  become "due".

  It is also straightforwardly false. Each roll avoids a six with
  probability $5/6$, so six rolls in a row avoid it with probability
  $ (5/6)^6 approx 0.335, $ which is a third of the time. Rolling a
  die six times and seeing no six is not a rare event; it is a
  perfectly ordinary afternoon.

  This mistake is common enough to have a name: the
  #vocab("gambler's fallacy", "Spielerfehlschluss"), the belief that
  independent trials somehow keep score.
]

#remark[
  A note on words, since it trips people up. This course writes
  *die* for one and *dice* for several. But "dice" as a singular is
  standard English too, and you will meet it in textbooks, in exam
  papers and in everyday speech. Both are correct; neither is worth
  arguing about.
]

== Which Is More Likely?

#only-theory[
  Before building any machinery, it is worth finding out how good your
  intuition is. The honest answer, for almost everyone, is: patchy.
]

#exploration(title: "Which of the two is more likely?")[
  For each pair, decide which event you think is more likely — or
  whether you cannot tell. Argue for your answer, and then argue
  against it. Two questions to keep asking: _what information is
  missing?_ and _what would have to change for my answer to flip?_

  + $A$: winning the jackpot in a national lottery. \
    $B$: being struck by lightning.
  + $A$: dying in a plane crash. \
    $B$: being hurt in a car accident on the way to the airport.
  + $A$: a person you meet on the street is a doctor. \
    $B$: a person you meet on the street is a doctor who earns more
    than CHF #num(100000) a year.
  + $A$: a student picked at random at this school is female. \
    $B$: a student picked at random at this school is male.
  + $A$: dying in childbirth in Romania. \
    $B$: dying in childbirth in Switzerland.
  + $A$: being killed by a shark. \
    $B$: being killed by a cow.
  + $A$: two people in this class share a birthday. \
    $B$: someone at this school shares *your* birthday.
  + $A$: you test positive for a disease and have it. \
    $B$: you test positive for a disease and are perfectly healthy.

  Keep your answers. Several of these come back later in the unit with
  the machinery needed to settle them properly, and it is worth
  knowing which ones you had backwards.
]

#look-ahead(preview: [conditional probability])[
  Item 3 in that list is not a close call, and it does not need any
  arithmetic: every doctor earning over CHF #num(100000) is a doctor,
  so $B$ cannot possibly be more likely than $A$. Adding detail to a
  description can only ever make it *less* likely, never more — and
  yet the detailed version usually feels more plausible, because it
  tells a better story. That gap between _likely_ and _plausible_ is
  one of the most reliable failures of human judgment there is.

  Item 8 is the one most people get most wrong, and it is the reason
  this unit spends a whole chapter on conditional probability.
]

== From Relative Frequency to Probability

#only-theory[
  If a sequence of outcomes is genuinely unpredictable, how can there
  be anything to calculate at all? The answer is that individual
  outcomes and long-run behavior are completely different things. One
  toss of a coin is unpredictable. Ten thousand tosses are extremely
  predictable — not in their order, but in their proportions.

  You already have the vocabulary for this from the last unit.
]

#definition(title: "Relative Frequency")[
  Suppose an experiment is repeated $n$ times and an event $A$ occurs
  $H(A)$ times. The number $H(A)$ is the
  #vocab("absolute frequency", "absolute Häufigkeit") of $A$, and
  $ h_n (A) = H(A) / n $
  is its #vocab("relative frequency", "relative Häufigkeit").

  A relative frequency is always a number between $0$ and $1$. It
  describes what *did* happen in $n$ particular
  #vocab("trials", "Versuche", show-de: false).
]

#only-theory[
  Here is one run of #num(10000) simulated coin tosses, recorded at
  intervals. $H$ counts the heads, $T$ the tails.
]

#only-theory[
  #data-table(
  columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto),
  row-height: auto,
  [$n$], [10], [50], [100], [500], [#num(1000)], [#num(2000)],
  [#num(5000)], [#num(10000)],
  [heads $H$], [6], [24], [46], [255], [507], [#num(1003)],
  [#num(2515)], [#num(5024)],
  [$h_n$], [0.600], [0.480], [0.460], [0.510], [0.507], [0.502],
  [0.503], [0.502],
  [$abs(H - T)$], [2], [2], [8], [10], [14], [6], [30], [48],
)
]

#only-theory[
  Read the third row from left to right. Early on the relative
  frequency swings wildly — $0.6$, then $0.48$, then $0.46$. By
  #num(1000) tosses it has stopped moving much, and from there on it
  sits stubbornly near $0.5$ and refuses to leave. This settling-down
  is not a coincidence of this particular run. It happens every time,
  for every repeatable experiment, and it is the single fact that
  makes probability possible.

  Now read the fourth row. The *gap* between heads and tails does not
  settle down at all — it starts at 2 and ends at 48. Tossing does not
  "even things out" in the sense of making the counts equal. It makes
  the counts *proportionally* equal, which is a different and much
  weaker claim.
]

#keybox(title: "Probability, informally")[
  The #vocab("probability", "Wahrscheinlichkeit") of an event $A$,
  written $p(A)$, is the number that the relative frequency $h_n (A)$
  approaches as the number of trials $n$ grows.

  Consequently $0 <= p(A) <= 1$, where $p(A) = 0$ means the event
  does not happen and $p(A) = 1$ means it always does.
]

#only-theory[
  That the relative frequency settles at all is a theorem, not a
  definition — it is called the
  #vocab("law of large numbers", "Gesetz der grossen Zahlen"), and
  proving it is university work. Taking it on trust for now costs us
  nothing.
]

// #fig(image("images/coin-toss-running-proportion.png", width: 55%),
//   caption: [Two runs of 50 tosses each: the proportion of heads
//     against the number of tosses.])

#remark[
  The most-cited version of this experiment was run by the South
  African mathematician John Kerrich, who was interned in Denmark
  during the Second World War and, having time available, tossed a
  coin #num(10000) times. He recorded #num(5067) heads — a relative
  frequency of $0.5067$.
]

#warning[
  Probability is a statement about the long run and about nothing
  else. It says nothing whatsoever about the next trial.

  "This coin has probability $0.5$ of heads" does not mean that ten
  tosses give five heads, or that a hundred give fifty. The table
  above got 46 heads in its first 100 tosses and nobody should be
  surprised.
]

#ex(difficulty: 1, time: "10 min")[
  Tim tossed 20 coins at once, counted the heads, and repeated the
  whole thing 10 times. His results were
  $ 11, thick 9, thick 10, thick 8, thick 13, thick 9, thick 6,
    thick 7, thick 10, thick 11. $
  + Use Tim's data to estimate the probability of a coin landing
    heads.
  + He is about to do an eleventh round of 20 coins. How many heads
    should he expect? What is the largest number he could possibly
    get?
  + Suppose he did #num(1000) rounds. About how many heads in total?
  + Your estimate in part 1 is not $0.5$. Does that mean the coins
    are unfair?
][
  + Tim tossed $10 dot 20 = 200$ coins altogether and got
    $11 + 9 + 10 + 8 + 13 + 9 + 6 + 7 + 10 + 11 = 94$ heads. The
    relative frequency is $ h_(200) = 94/200 = 0.47. $
  + Around 9 or 10 — the estimate gives $20 dot 0.47 = 9.4$, and no
    round can produce a fractional number of heads. Any value from 0
    to 20 is possible; 20 is the largest.
  + #num(1000) rounds is #num(20000) coins, so roughly
    $#num(20000) dot 0.47 = #num(9400)$ heads, or about #num(10000)
    if you trust the coins to be fair.
  + No. Two hundred tosses is not many, and a relative frequency of
    $0.47$ is an entirely ordinary result for a fair coin at that
    sample size — look again at the table above, which reached $0.46$
    after 100 tosses of a coin that was fair by construction. To
    distinguish a fair coin from one biased to $0.47$ you would need
    tens of thousands of tosses, and even then only with the tools of
    the last unit in this course. #heuristic("try small cases")
]

#ex(difficulty: 2, time: "10 min")[
  A weather forecast says there is a $70%$ chance of rain in Basel
  tomorrow. Tomorrow happens exactly once, so it cannot be repeated
  #num(10000) times.
  + What could the forecaster's $70%$ possibly mean, given the
    definition above?
  + Describe how you would check, over a year, whether this
    forecaster's numbers are any good.
  + Two things $70%$ does *not* mean: that it rains over $70%$ of the
    area, and that it rains for $70%$ of the day. Why might someone
    reasonably think it did?
][
  + Take all the days on which this forecaster says $70%$. That
    collection *can* be repeated. The claim is that rain falls on
    about $70%$ of those days.
  + Collect every forecast for a year and sort the days into groups by
    what was predicted — the $10%$ days, the $20%$ days, and so on.
    Within each group, find the proportion of days on which it
    actually rained. A well-calibrated forecaster's $30%$ group rains
    about $30%$ of the time, and so on for every group. This is
    genuinely how forecasts are scored.
  + Because $70%$ is a proportion, and rain has an obvious extent in
    both space and time for the proportion to attach itself to. The
    forecast attaches it to neither: it is a proportion of *days*, not
    of anything you could see out of the window.
]

== Where Probabilities Come From

#only-theory[
  Every probability in this unit arrives by one of three routes, and
  it is worth being able to say which, because they do not deserve
  equal trust.
]

#keybox(title: "Three sources")[
  / By symmetry: The outcomes are interchangeable by the physical
    construction of the thing, so they must be equally likely. A fair
    die, a shuffled deck, a balanced roulette wheel. This route gives
    exact answers and needs no data at all — it is the subject of the
    next chapter.

  / From data: The outcomes are not interchangeable and there is no
    argument from symmetry available, so we measure instead: repeat
    many times and take the relative frequency. The probability that a
    manufactured component is faulty, that a Swiss resident is
    left-handed, that a drawing pin lands point-up.

  / By judgment: The experiment cannot be repeated even in principle,
    so there is nothing to count. The probability that this particular
    football match ends in a draw, that a treaty is signed this year.
    Past matches and general knowledge inform the number, but in the
    end somebody decides it.
]

#only-theory[
  The three are not equally solid, and the honest move is to say which
  one you used. A symmetry argument can be checked by anyone. A
  frequency estimate comes with a sample size, and you are entitled to
  ask how big it was. A judgment comes with a person attached, and you
  are entitled to ask who.
]

#remark[
  The drawing-pin example is worth dwelling on. A coin has two sides
  and a symmetry between them; a drawing pin has no symmetry
  whatsoever between "point up" and "on its side". No amount of
  thinking will produce that probability. Somebody has to drop pins
  and count — which is what makes it a much better first experiment
  than a coin.
]

#ex(difficulty: 1, time: "10 min")[
  For each probability, say which of the three sources it must come
  from. Some are arguable; say why if you think so.
  #auto-parts(
    2,
    [A fair die shows an odd number.],
    [A randomly chosen Swiss resident is left-handed.],
    [It rains in Basel tomorrow.],
    [A card drawn from a shuffled deck is a heart.],
    [A drawing pin dropped on the floor lands point-up.],
    [A new medicine passes its clinical trials.],
    [A randomly chosen student at this school is in year 3.],
    [Switzerland wins the next football World Cup.],
  )
][
  #auto-parts(
    2,
    [Symmetry. Three of the six faces are odd and the faces are
      interchangeable.],
    [Data. There is no symmetry between left and right hands in the
      population; somebody has to count.],
    [Arguable, and the interesting one. Weather models are physics,
      but they are calibrated on decades of records, and the final
      number is a model's output rather than a measured frequency.
      Data, with a large helping of judgment.],
    [Symmetry.],
    [Data, and only data — see the remark above.],
    [Judgment, informed by data. This particular medicine has never
      been tested before, so its trial cannot be repeated; base rates
      for similar medicines inform the estimate but do not settle
      it.],
    [Data — but of an unusually reliable kind, since the school can
      simply count its own students. When the whole population is
      available, the relative frequency *is* the probability.],
    [Judgment. The tournament happens once.],
  )
]

#ex(difficulty: 2, level: "high", time: "15 min", hints: (
  "Write down the number of heads and the number of tails separately, rather than working with the proportion straight away.",
  "If n tosses give H heads, how many tails are there? Now write the proportion of heads in terms of H and n only.",
  "Look at the last row of the table in §3 and describe in words what it does. Then ask what it would have to do for the proportion NOT to settle down.",
))[
  In the table in §3, the proportion of heads settles toward $0.5$
  while the gap $abs(H - T)$ grows from 2 to 48.
  + Explain why these two statements do not contradict each other.
  + After $n$ tosses, write the proportion of heads in terms of $H$
    and $n$, and then in terms of the gap $abs(H - T)$ and $n$.
  + A gambler argues: "the proportion has to return to $0.5$, so if
    heads is ahead by 48 now, tails must catch up later." Say
    precisely which part of this is right and which is wrong.
][
  + The proportion is a gap divided by a total, and the total grows
    much faster than the gap does. A lead of 48 in #num(10000) tosses
    is a smaller lead, proportionally, than a lead of 2 in 10.
  + With $H$ heads out of $n$ tosses there are $T = n - H$ tails, so
    the proportion of heads is $H/n$. Writing $d = H - T$ gives
    $H = (n + d)/2$, hence
    $ H/n = 1/2 + d/(2n). $
    For the proportion to approach $1/2$ it is enough that $d/n$
    approaches $0$ — and $d$ may grow without limit as long as it
    grows more slowly than $n$. That is exactly what the table shows:
    $n$ multiplied by #num(1000) while $d$ multiplied by 24.
  + The first half is right: the proportion does return to $0.5$, in
    the sense that $H/n$ approaches $1/2$. The second half is wrong,
    and the formula shows why. Nothing has to *cancel* the lead of 48;
    it only has to be diluted, and continuing to toss dilutes it
    automatically. In fact the typical gap keeps growing — it is
    roughly proportional to $sqrt(n)$ — so tails is not expected to
    catch up at all. This is the gambler's fallacy again, now in its
    more sophisticated disguise. #heuristic("introduce notation")
]

== The Model and the World

#only-theory[
  Everything in this unit will assume perfect coins, balanced dice,
  thoroughly shuffled decks and urns whose balls differ only in color.
  None of these things exists.

  Real coins are slightly worn on one side. Real dice have hollowed
  pips that shift the center of mass. A real deck can be shuffled
  badly, and a real experimenter can, without meaning to, throw in a
  way that favors one outcome. Every calculation we do is a statement
  about an idealized version of the situation, and it transfers to the
  real one only as far as the idealization holds.
]

#warning[
  This is the same warning as the last unit's, in new clothes. There,
  a summary statistic described the data honestly but the data might
  not describe the world. Here, a probability describes the model
  honestly but the model might not describe the world.

  Both failures look identical from inside the mathematics: the
  arithmetic is flawless and the conclusion is wrong. The only defense
  is to keep asking what the numbers were supposed to be about.
]

#ex(difficulty: 1, time: "10 min")[
  Both of these figures were published by the same national weather
  service. The probability of being struck by lightning in a given
  year is $1 slash #num(750000)$; the probability of being struck at
  some point in an 80-year lifetime is $1 slash #num(6250)$.
  + Starting from the yearly figure, estimate roughly what the
    80-year figure ought to be.
  + Compare with the published figure. Are the two consistent?
  + Suggest reasons why two numbers from the same source might not
    agree.
][
  + Eighty years, each carrying a chance of $1 slash #num(750000)$, and
    the chance in any one year is tiny. Adding gives
    $ 80 / #num(750000) = 1 / #num(9375) approx 1.07 dot 10^(-4). $
  + The published figure is $1 slash #num(6250) = 1.6 dot 10^(-4)$,
    about $1.5$ times larger. The two are not consistent: taken at
    face value the second implies a lifetime of $120$ years.
  + Plenty of possibilities, and this is the point of the exercise.
    The figures may come from different decades, or different
    populations. One may count strikes and the other only injuries or
    deaths. One may have been rounded hard for a press release. Or
    somebody simply multiplied wrong. Two published numbers agreeing
    is evidence; two disagreeing tells you at least one has a story
    behind it that the publication did not include.

  _Adding rather than multiplying is an approximation, and a good one
  only because the yearly probability is so small. The exact
  calculation needs the next two chapters, and gives
  $1 slash #num(9375)$ to four significant figures — close enough that
  the shortcut costs nothing here._
]

#ai-box(role: "Generator")[
  Ask an AI assistant to give you a sequence of 100 coin tosses,
  written as a string of H's and T's — and tell it to make them
  random. Separately, produce 100 real tosses: an actual coin, or a
  spreadsheet's random function, or a program you write yourself.

  Now compare the two on one specific measurement: the *longest run*
  of identical letters in each. Count it in both sequences.

  In 100 genuine tosses, the longest run is 6 or more about $80%$ of
  the time, and a run of 4 or shorter happens in only about $3%$ of
  attempts. Sequences produced to "look random" — by an assistant, or
  by a person asked to fake a coin, which is the same experiment —
  tend to alternate far too eagerly and rarely commit to a long run,
  because a long run does not look random even though it is.

  Report which sequence had the longer run. Then say what this tells
  you about the assistant: is it producing randomness, or producing
  something that resembles a description of randomness?
]

#look-ahead(preview: [inferential statistics])[
  The law of large numbers is doing quiet work here that it will do
  loudly later. It says a relative frequency measured on a large
  sample is close to the true probability — which is exactly the
  permission slip needed to measure something about a few hundred
  people and then say something about eight million.

  The whole final unit of this course is about how close "close" is,
  and about what you are entitled to conclude when the sample is all
  you will ever have.
]

#print-hints()
#print-vocab()
