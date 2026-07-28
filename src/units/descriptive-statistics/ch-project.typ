#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "A Statistical Project")
#let ex = exercise.with(chapter: "A Statistical Project")

// ── TEACHER'S NOTE ───────────────────────────────────────────
// This chapter is deliberately built to be OPTIONAL and SCALABLE.
// The three tiers in the second section are the point: tier 1 is a
// single 45-minute lesson needing no preparation and no homework,
// and it is worth running even in a year when nothing else here
// fits. Tiers 2 and 3 exist for the years when there is room.
//
// Nothing later in the unit depends on this chapter, so removing its
// line from main-basic.typ / main-high.typ in a tight year costs
// nothing -- though leaving it in means a student can run a project
// independently whether or not it is taught.
//
// The project briefs near the end are meant to be picked off the
// shelf. Each states its tier, so choosing one is a matter of
// looking at the timetable rather than at the statistics.

= A Statistical Project

#only-theory[
  Everything in this unit has been done to data that arrived
  ready-made. Someone else chose the population, drew the sample,
  wrote the questions, and handed you a tidy list. That is a
  reasonable way to learn the techniques and a poor way to find out
  whether you can use them.

  Real statistical work is mostly the parts that were done for you.
  Deciding what to ask, working out what would count as an answer,
  discovering halfway through that your question cannot be measured,
  and having to write down honestly what went wrong --- that is the
  job. This chapter is about doing it once, from the beginning.
]

#objectives(
  [turn a vague interest into a question that can actually be
    answered with data you can collect],
  [state precisely what will be measured, and in what units, before
    collecting anything],
  [design and justify a sampling method appropriate to the question
    and the time available],
  [analyze a dataset you collected yourself, choosing displays and
    summary measures that suit its shape],
  [write a short report whose claims are supported by the data, and
    which states its own limitations],
)

== The Five Stages

#keybox(title: "The Shape of a Statistical Investigation")[
  + *Question.* What do you want to know? Narrow it until it can be
    answered.
  + *Design.* Who or what is the population? How will you sample?
    What exactly will you measure?
  + *Collect.* Gather the data, and record what went wrong.
  + *Analyze.* Plot first. Then center, spread, shape, outliers.
  + *Report.* State what you found, how confident you are, and what
    you could not determine.

  The stages are not equally difficult. Almost every failed project
  fails in stage 1 or 2, and no amount of careful arithmetic in stage
  4 rescues it.
]

== Scaling to the Time You Have

#only-theory[
  A statistical project can occupy a single lesson or an entire term.
  The stages are the same; what changes is how much of each you do
  yourself and how much is given to you.
]

// data-table is not auto-suppressed -- wrap theory tables or they
// appear on the exercise sheet.
#only-theory[
  #data-table(
    columns: (auto, 1fr, 1fr, 1fr),
    row-height: auto,
    [],
    [*Tier 1* --- one lesson],
    [*Tier 2* --- two or three lessons],
    [*Tier 3* --- full project],

    [Question], [given to you], [chosen from a list], [your own],
    [Design], [given], [you choose the sampling], [you design it all],
    [Collect],
    [in class, minutes],
    [in class plus homework],
    [over days, outside school],

    [Sample], [the class], [the class or a year group], [a real sample],
    [Analyze],
    [one display, one center, one spread],
    [full protocol],
    [full protocol, two variables],

    [Report], [three sentences], [one page], [full written report],
  )
]

#only-theory[
  Tier 1 is not a watered-down version of the others. Collecting your
  own twenty numbers and finding that they do not look like you
  expected teaches something that no textbook dataset can, and it
  fits in forty-five minutes with no preparation. If you only ever do
  one statistical project, do a tier 1 project properly rather than a
  tier 3 project badly.
]

== Stage 1: A Question You Can Answer

#only-theory[
  The commonest way to ruin a project is to begin with a question
  that sounds excellent and cannot be answered. "Are students at this
  school stressed?" is such a question. It names no population
  precisely, no measurable quantity, and no comparison --- so no
  amount of data could settle it.

  Narrowing it is not a retreat. It is the work.
]

#example(title: "Narrowing a Question")[
  / Too vague: "Are students stressed?"
  / Better: "Do students in this school sleep less than the
    recommended amount?"
  / Answerable: "What is the distribution of self-reported sleep on
    a school night among students in years 1 and 2 of this school,
    and what proportion report fewer than 8 hours?"

  The third version names the population (years 1 and 2 here), the
  quantity (hours of sleep on a school night), the method
  (self-report, with all its known weaknesses), and what would count
  as an answer (a distribution and a proportion).

  It is also visibly less exciting than the first version, and that
  is the trade. A question you can answer is worth more than a
  question that sounds important.
]

#keybox(title: "Operationalizing")[
  Before collecting anything, write down the sentence:

  #align(center, emph[
    "For each \_\_\_\_\_\_ in \_\_\_\_\_\_ , I will record \_\_\_\_\_\_ ,
    measured in \_\_\_\_\_\_ , by \_\_\_\_\_\_ ."
  ])

  If you cannot complete it, you are not ready to collect data. Most
  projects that collapse in week three collapse because this sentence
  was never written.
]

#ex(difficulty: 1, time: "10 min")[
  Each of the following is too vague to investigate. Rewrite each as
  an answerable question, naming the population and the quantity to
  be measured.
  #auto-parts(
    1,
    [Is the canteen food good?],
    [Do people spend too much time on their phones?],
    [Is our class better at mathematics than at French?],
  )
][
  Answers will vary; these are model responses.
  + "Among students at this school who eat in the canteen at least
    twice a week, what proportion rate the food 4 or 5 on a
    five-point scale?" --- population and measurement now stated,
    and the rating scale is ordinal, which restricts what may be
    computed.
  + "Among students in year 2, what is the distribution of daily
    screen time in minutes, as reported by their phone's own usage
    tracker over the past seven days?" --- using the device's
    measurement rather than memory removes one large source of
    error.
  + "For the students in this class, how does the mean mark in the
    most recent mathematics test compare with the mean in the most
    recent French test?" --- and note this is barely answerable even
    so, because two tests of different subjects are not a common
    scale. A fairer version compares each subject's marks with the
    year-group distribution for that subject.
]

== Stage 2: Design

#only-theory[
  Design is where the first chapter of this unit gets used. Three
  decisions have to be made and written down before any data is
  collected, because deciding them afterwards is how bias enters
  without anyone noticing.
]

#keybox(title: "Three Decisions, Made in Advance")[
  + *Population.* Exactly who or what are you drawing conclusions
    about? "Students" is not an answer; "students in years 1 and 2 at
    this school" is.
  + *Sampling method.* How will individuals be selected, and which
    group will your method systematically miss? Every method misses
    someone --- naming them in advance is what separates a limitation
    from a flaw.
  + *Measurement.* What exactly is recorded, in what units, to what
    precision? If you are asking a question, write its exact wording
    now and check it for the loading you learned to spot.
]

#warning[
  Write these three down before collecting. Not because it is tidy,
  but because a decision made after seeing the data is contaminated
  by the data: it is much easier to decide who counts as "a regular
  canteen user" once you know which definition gives the more
  interesting result. Deciding first is the only protection, and it
  costs nothing at the time.
]

#ex(difficulty: 2, time: "15 min")[
  A student proposes: "I will find out how long students take to get
  to school by asking people in the canteen at lunchtime."
  + Name two distinct ways this sampling method is likely to be
    biased, and say in which direction each pushes the result.
  + Propose a better method that could still be carried out within
    one school day.
  + Even a well-sampled version of this study has a measurement
    problem. What is it, and how would you reduce it?
][
  + First, canteen users are not a cross-section: students who live
    close may go home for lunch, which would remove short journeys
    and push the mean *up*. Second, whoever is asked will be whoever
    is nearby and willing, which favors the sociable and people the
    interviewer already knows --- a convenience sample whose
    direction of bias is unpredictable, which is worse than a known
    direction.
  + Sample from a list rather than from a place: obtain the year
    group's class lists, number the students, and select at random,
    then find those specific people. Any method that fixes *who*
    before you go looking removes the convenience effect.
  + Travel times are self-reported and therefore remembered,
    rounded, and often reported as the usual case rather than today's
    case --- which is why such data so often clusters on multiples
    of 5. Asking "what time did you leave home today, and what time
    did you arrive?" replaces a remembered duration with two
    remembered clock times, which is measurably more accurate.
]

== Stage 3: Collect

#only-theory[
  Collection is the least intellectually demanding stage and the one
  where projects most often quietly go wrong. Three habits are worth
  more than any technique:

  *Record as you go, not afterwards.* Memory is not data.

  *Keep the raw data.* Never overwrite the original numbers with a
  cleaned version. Anyone reading your report is entitled to ask what
  you changed, and you are entitled to be able to answer.

  *Write down what went wrong.* Non-responses, spoiled measurements,
  the day the equipment failed, the fact that you gave up on the
  random list and asked people you knew. This is not a confession ---
  it is part of the result, and a report that says "eleven of the
  fifty selected students could not be reached" is more trustworthy
  than one that quietly reports 39.
]

== Stage 4: Analyze

#keybox(title: "The Standard Protocol")[
  Always in this order:

  + *Plot it.* A dotplot for small data, a histogram for larger. Look
    before computing anything.
  + *Describe the shape.* Symmetric or skewed? One peak or two? Any
    observation obviously apart from the rest?
  + *Choose a center, and justify the choice.* The shape decides:
    mean for roughly symmetric data, median when it is skewed or has
    outliers.
  + *Choose a spread to match.* Standard deviation goes with the
    mean; the IQR and a boxplot go with the median.
  + *Investigate the outliers.* Where did each come from? An error,
    a real extreme, or evidence that two groups are mixed?
  + *Compare, if you have groups.* Boxplots on a shared axis.

  If a step surprises you, go back to step 1 and look again.
]

#warning[
  You will be tempted to compute first and plot afterwards, because
  the calculator is quick and drawing is slow. Anscombe's quartet
  exists to show what that costs. The plot is not a presentation of
  the result; it is how you find out which result is worth
  computing.
]

== Stage 5: Report

#keybox(title: "What a Report Must Contain")[
  + The question, stated exactly as investigated.
  + The population, the sampling method, and $n$.
  + What was measured, in what units, and how.
  + The displays and the summary figures.
  + What you found, in plain sentences.
  + What went wrong, and who is missing from the data.
  + What you could *not* determine, and what would be needed.

  The last two are what distinguish a statistical report from an
  advertisement. Include them even when --- especially when --- they
  weaken your conclusion.
]

#only-theory[
  One further rule, worth stating separately because it is the one
  most often broken: *do not claim a cause.* You will have found an
  association. Unless you randomly assigned something, that is what
  you have, and the honest sentence is "students who did X also
  tended to have Y", not "X causes Y". If you want to speculate about
  the mechanism, label it as speculation and say what evidence would
  settle it.
]

#ex(difficulty: 2, time: "15 min")[
  A report concludes: "Our survey of 30 students proves that students
  who play sport get better marks. Sport should therefore be made
  compulsory."
  + Identify three separate problems with this conclusion.
  + Rewrite it as a defensible sentence.
][
  + Any three of: *"proves"* --- a sample of 30 cannot prove
    anything, and no observational study proves a causal claim at
    all; *the causal leap* --- the survey found an association, and
    reverse causation (students doing well have more free time) and
    confounding (family circumstances, motivation, health all affect
    both) are equally consistent with it; *the policy jump* ---
    even if sport did improve marks, it would not follow that
    compelling reluctant students produces the same effect as
    choosing sport voluntarily; and *the missing detail* --- no
    sampling method, no measurement definition, and no indication of
    the size of the difference.
  + Something like: "Among the 30 students surveyed, those who
    reported playing sport at least twice a week had a mean mark
    about half a grade higher than those who did not. The sample was
    small and self-selected, and this study cannot determine whether
    sport is a cause: students with more free time, better health, or
    stronger family support may be more likely both to play sport and
    to do well."
]

== Project Briefs

#only-theory[
  Each brief below states its tier. Pick one that fits the time
  available rather than the one that sounds most impressive.
]

#exploration(title: "Brief A --- Travel Times (tier 1)")[
  *One lesson. No preparation, no homework.*

  Every member of the class writes down two clock times: when they
  left home this morning and when they arrived at school. Compute
  each duration in minutes and pool the results on the board.

  + Draw a dotplot of all the values.
  + Describe the shape. Is it symmetric? Is there a tail?
  + Compute the mean and the median. Which better describes a
    typical journey, and why?
  + Compute the IQR, and identify any outliers by the
    $1.5 dot "IQR"$ rule.
  + Write three sentences reporting what you found, including one
    stating who is *not* represented in this data.

  For the last point: the population is not "students at this
  school". It is this class, and this class was not chosen at
  random.
]

#exploration(title: "Brief B --- Reaction Times (tier 1--2)")[
  *One lesson, or two if you compare groups.*

  Working in pairs, measure reaction time by ruler drop. One partner
  holds a ruler vertically; the other places an open hand at the
  0 cm mark without touching it. The ruler is dropped without warning
  and caught as fast as possible. Record the distance $s$ in metres
  at which it was caught, and convert to a time using
  $ t = sqrt((2 s) / g), quad g = 9.81 "m/s"^2. $

  Take ten measurements per person.

  + Plot your own ten values. How consistent are you?
  + Compute your mean and standard deviation. What does the standard
    deviation mean here, in words, about your reactions?
  + Pool the class means and plot them. Is the class distribution
    the same shape as your own ten values?
  + *(Tier 2)* Compare two groups --- dominant hand against
    non-dominant, or before and after ten minutes of exercise --- and
    present the comparison as two boxplots on a shared axis.

  A methodological question worth answering in your report: should
  you use each person's mean of ten, or their best of ten? Say which
  you chose and why.
]

#exploration(title: "Brief C --- Estimation (tier 1)")[
  *One lesson. Works with any class size.*

  Show the class a jar of objects, a line drawn on the board, or a
  photograph of a crowd, and have everyone privately write down an
  estimate. Collect all estimates, then reveal the true value.

  + Plot the estimates. Where does the true value fall in the
    distribution?
  + Compute the mean and the median of the estimates. Which is
    closer to the truth?
  + Compute each person's error, and plot the errors. Are they
    centered on zero, or is the class systematically biased in one
    direction?
  + Discuss: the mean of many independent estimates is often
    strikingly close to the truth. Did that happen here? What would
    have to go wrong for it not to?

  The fourth point is worth taking seriously. The effect depends on
  errors being *independent*, so try the experiment a second time
  after letting three people announce their guesses aloud first, and
  see what happens to the spread.
]

#exploration(title: "Brief D --- Two Shops (tier 2)")[
  *Two lessons plus homework.*

  Choose a basket of 15 to 20 specific products available in two
  different supermarkets. Record the price of each in both shops.

  + Is one shop cheaper overall? Which summary measure answers that
    question, and why is it not the median?
  + Compute the price *difference* for each product and plot the
    differences. What does a difference of zero mean, and how many
    products are near it?
  + Are the differences uniform, or is one shop cheaper on some
    categories and dearer on others?
  + Your basket is a sample of the shops' products. Describe how you
    chose it, and explain honestly whether a shopper could rely on
    your conclusion.

  The fourth point is the real content: a basket chosen by walking
  down one aisle is not representative of a shop's pricing, and the
  supermarkets themselves are well aware of which products customers
  compare.
]

#exploration(title: "Brief E --- Two Variables (tier 2--3, advanced)")[
  *Two or three lessons. Requires the correlation chapter.*

  Collect paired measurements from at least 25 people. Suitable
  pairs: height and arm span; height and shoe size; hours of sleep
  and self-rated alertness; time spent on homework and marks.

  + Draw the scatterplot first. Describe direction, form, and
    strength before computing anything.
  + Compute $r$ and the regression line.
  + Plot the residuals. Does a straight line fit?
  + Interpret the slope in the units of your variables.
  + State clearly what your data does *not* establish, and give at
    least one plausible confounder.

  Height and arm span is the safest choice for a first attempt: the
  relationship is strong and close to linear, so the machinery
  behaves. Homework and marks is the most interesting and the most
  treacherous, and a good report on it will spend more space on
  point 5 than on points 2 to 4 together.
]

== What Usually Goes Wrong

#only-theory[
  These are the failures that recur, in rough order of frequency.

  / The question was never narrowed. Everything downstream is then
    guesswork, because there is no statement to test.
  / The sample was whoever was nearby. Convenience sampling is the
    default failure, and it is invisible from inside the data --- the
    numbers look perfectly normal.
  / The measurement changed halfway through. Someone rounded
    differently, or asked the question a second way, and the two
    halves are not comparable.
  / The plot was skipped. A mean and a standard deviation were
    computed for a bimodal distribution, and the report describes a
    typical case that does not exist.
  / A cause was claimed. Almost every first report does this, usually
    in the final sentence.
  / The limitations section is missing or empty. This is the section
    that makes a report credible, and it is the one people cut when
    they run out of time.
]

#keybox(title: "Before You Hand It In")[
  + Could someone else repeat your study from your description
    alone?
  + Is $n$ stated? Is the sampling method stated?
  + Does every number in your report appear in, or follow from, your
    raw data?
  + Did you plot before you computed?
  + Have you claimed a cause anywhere? Check the last paragraph
    especially.
  + Have you named who is missing from your data?
]

#ai-box(role: "Checker")[
  When your report is drafted --- not before --- give an AI assistant
  your method section only, without your results, and ask it to
  identify the weaknesses in your design.

  Order matters here. Asking before you collect invites you to adopt
  a design you do not understand; asking afterwards gives you a
  critic that cannot be influenced by how the results turned out.

  Sort what it says into three piles: problems you had already named
  in your limitations section, problems that are real and that you
  had missed, and objections that do not actually apply to your
  study. Add the second pile to your report. For the third pile, work
  out *why* the objection does not apply --- that reasoning is worth
  more than the objection was, and it is the part an assistant
  cannot do for you.
]

#only-theory[
  A last word. Your project will produce a smaller, messier result
  than you hoped. The sample will be too small, someone will not
  reply, and the effect you expected will turn out to be within the
  range of ordinary variation.

  That is not a failed project. That is what the overwhelming
  majority of real statistical work looks like, and reporting it
  accurately --- including the parts that did not work --- is the
  entire skill this unit has been building toward. The alternative,
  which is to tidy the story until it sounds conclusive, is exactly
  the practice that gave statistics its bad reputation in the first
  chapter.
]

#print-hints()
#print-vocab()
