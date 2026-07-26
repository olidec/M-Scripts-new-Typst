#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Data and Trust")
#let ex = exercise.with(chapter: "Data and Trust")

= Data and Trust

#only-theory[
  Almost every important decision you will ever be asked to make ---
  as a voter, a patient, a consumer, a citizen --- arrives wrapped in
  numbers. A party claims crime is rising. A supplement promises
  better sleep. A newspaper reports that students today read less
  than students did twenty years ago. You cannot personally verify
  any of it. What you *can* do is learn to tell the difference
  between a number that carries real information and one that does
  not.

  That is what this unit is for. Before we compute a single average,
  it is worth being clear about where data comes from, what it can
  and cannot tell us, and why the most popular argument for ignoring
  statistics altogether does not survive five minutes of scrutiny.
]

#objectives(
  [explain the difference between a population and a sample, and
    between a parameter and a statistic],
  [classify a variable as nominal, ordinal, discrete, or continuous,
    and explain why the classification restricts what you may
    calculate],
  [judge whether a sampling method is likely to produce a
    representative sample, and name the specific way a given method
    fails],
  [identify sampling bias, self-selection, survivorship bias, and
    loaded questions in a described study],
  obj(level: "high")[describe stratified and cluster sampling, and
    explain when each is preferable to simple random sampling],
  [evaluate a statistical claim in the media: what would have to be
    true for it to hold, and what evidence would settle it],
)

#only-theory[
  It is worth saying why all of this comes before any calculation.
  Computing a standard deviation from a rotten sample is a waste of
  everybody's afternoon, and of the two skills --- running the
  calculation and judging whether it was worth running --- the second
  is the one you will still be using in thirty years.
]

== The Most Repeated Argument Against Statistics

#quotebox[
  "Ich traue keiner Statistik, die ich nicht selbst gefälscht habe." \
  --- attributed to Winston Churchill
]

#only-theory[
  You have almost certainly heard this one, usually delivered as
  though it settles the matter. It is worth taking seriously, because
  it contains one true idea wrapped around one catastrophic one.

  The true idea: numbers can be presented misleadingly. They can.
  Later in this unit you will produce a thoroughly dishonest chart
  yourself, using nothing but honest data and one defensible-looking
  formatting choice, and it will take you about thirty seconds.

  The catastrophic idea: *therefore no statistic tells you anything.*
  Notice what has happened. The slogan is itself a sweeping general
  claim about all statistics everywhere --- exactly the kind of claim
  it tells you never to accept. If you believe it, you have to
  disbelieve it. And in practice nobody applies it evenly: people
  reach for it when a number is inconvenient, and forget it entirely
  when a number supports them. A rule you only apply to your
  opponents is not a rule. It is a convenience.
]

// ── IMAGE (recommended) ──────────────────────────────────────
// A screenshot of the quotation circulating in the wild: a
// quote-card on social media, a motivational-poster site, a slide
// deck -- anywhere it appears attributed to Churchill with no source
// given. The point is to show the mechanism BEFORE the exploration
// asks them to chase the source: this is what an unsourced claim
// looks like while it is spreading, and it looks completely normal.
// Suggested file: images/unsourced-quotation-in-the-wild.png
// #only-theory[#fig(
//   image("images/unsourced-quotation-in-the-wild.png", width: 60%),
//   caption: [Confidently attributed, nowhere sourced.],
// )]

#exploration(title: "Where Did the Quotation Come From?")[
  Try to find the primary source. Not a website that repeats the
  quotation --- the actual speech, letter, article, or book in which
  Churchill is supposed to have said it, with a date.

  Some things to notice as you search:

  + In which language does the quotation circulate? Churchill wrote
    and spoke in English, and left behind an enormous, thoroughly
    indexed body of published work.
  + What do the Churchill archives and the International Churchill
    Society say about it? They maintain a public list of things he is
    widely believed to have said and did not.
  + There is a popular origin story claiming the line was invented as
    wartime propaganda to discredit British figures. Apply the same
    standard to *that* claim. Who first said it, and where is their
    evidence?

  Write down what you found, what you could not find, and what you
  think is the most defensible conclusion given the evidence
  available to you --- including "we do not know" if that is where
  the evidence leads.
]

#keybox(title: "Two Working Principles")[
  Two rules will do a lot of work in this unit.

  *Extraordinary claims require extraordinary evidence.* The stronger
  and more surprising a claim, the better the evidence needed before
  you accept it. The principle is old --- versions of it go back to
  Hume and Laplace --- but the phrasing is Carl Sagan's, and it cuts
  both ways: it is a reason to be skeptical of a miracle cure, and
  equally a reason not to overturn a well-supported finding on the
  strength of one dramatic headline.

  *Correlation does not imply causation.* Two things moving together
  is not the same as one causing the other. We will come back to this
  properly once we can measure how strongly two variables move
  together; for now, simply notice how often a news report slides
  from one to the other in a single sentence.
]

#look-ahead(preview: [scatterplots and correlation])[
  "Correlation does not imply causation" is a slogan until you can
  actually measure a correlation. At the end of this unit you will be
  able to: you will plot two variables against each other, put a
  number on how tightly they move together, and then --- crucially
  --- see that the number is completely silent about *why*. The
  slogan will stop being something you repeat and start being
  something you can demonstrate.
]

== Populations and Samples

#only-theory[
  Every statistical investigation begins with a decision that is
  easy to skip and expensive to get wrong: exactly who or what are we
  talking about?
]

#definition(title: "Population and Sample")[
  The #vocab("population", "Grundgesamtheit") is the complete
  collection of people, objects, or events you want to draw a
  conclusion about.

  A #vocab("sample", "Stichprobe") is the subset of the population
  you actually examine.

  Examining every member of the population is called a
  #vocab("census", "Vollerhebung"). It is usually impossible, often
  unaffordable, and occasionally destructive --- a factory testing
  how long its light bulbs last cannot test all of them and still
  have any to sell.
]

#only-theory[
  The population is defined by your question, not by your data. If
  you want to know how the students at this school travel to school,
  the population is every student at this school. If you survey your
  own class, your sample is your class --- and whether that sample
  can answer the question is a separate matter entirely, which we
  come to below.
]

// ── IMAGE (recommended) ──────────────────────────────────────
// The nested-sets diagram from the old LaTeX script (\centfig{sampling}):
// population -> target population -> sample, as three nested regions
// with a handful of individuals picked out of the innermost. Worth
// having because students reliably conflate the outer two, and the
// picture makes "the population is defined by your question, not by
// your data" visible in one glance.
// Suggested file: images/population-target-sample.png
// #only-theory[#fig(
//   image("images/population-target-sample.png", width: 70%),
//   caption: [The sample is drawn from the target population, which
//     may already be narrower than the population you care about.],
// )]

#definition(title: "Parameter and Statistic")[
  A number describing the whole population is a
  #vocab("parameter", "Parameter"). A number computed from a sample
  is a #vocab("statistic", "Stichprobenkennwert").

  The distinction is important enough that the two get different
  symbols:
]

#data-table(
  columns: (1.4fr, 1fr, 1fr),
  row-height: auto,
  [],
  [*Population (parameter)*],
  [*Sample (statistic)*],
  [Mean],
  [$mu$ (mu)],
  [$overline(x)$ ("x-bar")],
  [Standard deviation],
  [$sigma$ (sigma)],
  [$s$],
  [Size],
  [$N$],
  [$n$],
)

#only-theory[
  Greek letters for the population, Latin letters for the sample.
  The parameter is a fixed number you almost never get to see. The
  statistic is a number you can actually compute --- and it is your
  best available estimate of the parameter.
]

#only-high[
  There is a further point worth making now, because it is the seed
  of everything you will do in inferential statistics later. A
  parameter is a *fixed* quantity: the mean height of all 16-year-olds
  in Switzerland on a given day is some definite number, whether or
  not anyone measures it. A statistic is not fixed. Draw a different
  sample and you get a different $overline(x)$. So a statistic is a
  quantity that *varies*, and the interesting question --- the one an
  entire later unit is devoted to --- is how much it varies, and
  therefore how much confidence a single sample's answer deserves.
]

#ex(difficulty: 1, time: "10 min")[
  For each investigation, name the population and the sample.
  + A pediatrician measures the height of the 32 children in her
    practice born in 2018, to compare them against national growth
    charts.
  + A quality inspector opens 50 of the #num(12000) chocolate bars
    produced in one shift and weighs each one.
  + The Bundesamt für Statistik contacts every household in
    Switzerland for the population census.
  + A student asks the 24 people in her class how far they live from
    school, and reports the average travel distance "for our school".
][
  + Population: all children born in 2018 (or: all Swiss children
    born in 2018, depending on the comparison intended). Sample: the
    32 children in her practice.
  + Population: all #num(12000) bars from that shift. Sample: the 50
    opened.
  + Population: all Swiss households. There is no sample --- this is
    a census.
  + Population: all students at her school. Sample: the 24 in her
    class. (Whether that sample supports a claim about the whole
    school is exactly the issue of the next section.)
]

#ex(difficulty: 1, time: "5 min")[
  A report states: "In our sample of 400 patients, the average
  recovery time was 8.2 days. We estimate the average recovery time
  for all patients treated this way to be about 8 days."

  Which of the two numbers is a parameter and which is a statistic?
  Which one does the report actually know?
][
  $overline(x) = 8.2$ days is the statistic --- computed from the
  sample of $n = 400$, and known exactly. The average recovery time
  for all such patients is the parameter $mu$, which is *not* known;
  the report estimates it. Only the statistic is known; the parameter
  is inferred.
]

== What Kind of Data Is It?

#only-theory[
  Before computing anything, ask what kind of variable you are
  holding. This is not bookkeeping for its own sake: the type decides
  which calculations are meaningful and which are nonsense dressed up
  as arithmetic.
]

#definition(title: "Types of Variables")[
  A #vocab("variable", "Merkmal") is the property being recorded.
  Four types matter here.

  / Nominal: a #vocab("nominal variable", "nominales Merkmal") records
    categories with no natural order --- eye color, canton of
    residence, mode of transport. You may count how often each occurs,
    and nothing else.
  / Ordinal: an #vocab("ordinal variable", "ordinales Merkmal") records
    categories that do have a natural order --- school grades,
    "strongly agree / agree / neutral / disagree", hotel stars. You
    may put them in order, but the gaps between them are not
    guaranteed to be equal.
  / Discrete: a #vocab("discrete variable", "diskretes Merkmal") takes
    countable values --- number of siblings, goals scored, sick days.
    Between 2 and 3 there is nothing.
  / Continuous: a #vocab("continuous variable", "stetiges Merkmal") is
    measured rather than counted --- height, time, temperature, mass.
    Between any two values there is always another; the precision is
    limited only by the instrument.
]

// ── FIGURE (recommended -- native Typst, not an image file) ──
// A four-branch taxonomy tree: variable -> {categorical, numerical},
// categorical -> {nominal, ordinal}, numerical -> {discrete,
// continuous}, with one example under each leaf. Per STYLE_GUIDE §7
// this should be drawn from native shapes rather than imported as a
// picture -- it is boxes and connecting lines, it compiles offline,
// and if it earns its place it belongs in preamble.typ as a reusable
// helper. Say the word and I will write it.

#warning[
  Data being written with digits does not make it numerical. Postal
  codes, jersey numbers, and bus lines are labels: the average postal
  code of Basel-Landschaft is not a place. Before computing a mean,
  check that adding two values would mean anything at all.
]

#remark[
  Ordinal data sits in the awkward middle, and honest people disagree
  about it. Is the average of a 4 and a 6 in Swiss grading really a
  5? That assumes the step from 4 to 5 is worth exactly as much as
  the step from 5 to 6 --- which is a claim about the grading scale,
  not a fact of arithmetic. Averaging grades is universal practice
  and defensible on the grounds that it is useful; it is worth
  knowing that you are making an assumption rather than a
  calculation.
]

#ex(difficulty: 1, time: "10 min")[
  Classify each variable as nominal, ordinal, discrete, or
  continuous.
  #auto-parts(
    2,
    [The canton a student lives in],
    [The number of pets in a household],
    [The time taken to run 100 m],
    [A film's rating from one to five stars],
    [The temperature at noon],
    [The colors of the cars in a car park],
    [A student's ranking in a race (1st, 2nd, 3rd, ...)],
    [The mass of a letter in grams],
  )
][
  #auto-parts(
    2,
    [nominal],
    [discrete],
    [continuous],
    [ordinal],
    [continuous],
    [nominal],
    [ordinal],
    [continuous],
  )
]

#ex(difficulty: 2, time: "10 min")[
  A survey records, for each student, their bus line number, their
  school grade in mathematics, and their travel time in minutes.
  Someone computes the average of all three columns.

  Which averages are meaningful, which are questionable, and which
  are meaningless? Justify each answer in one sentence.
][
  - *Bus line number:* meaningless. It is nominal --- the digits are
    a name, not a quantity, and "the average bus line is 34.7" refers
    to nothing.
  - *Grade:* questionable. It is ordinal, so averaging assumes equal
    steps between grades. It is standard practice and useful, but it
    is an assumption about the scale, not a fact.
  - *Travel time:* meaningful. It is continuous, and the sum of two
    travel times is a genuine quantity.
]

== Getting a Sample Worth Having

#only-theory[
  A sample is only useful if it resembles the population in the ways
  that matter for the question.
]

#definition(title: "Representative Sample")[
  A sample is #vocab("representative", "repräsentativ") if its
  composition is approximately the same as the population's with
  respect to the properties relevant to the investigation.

  The reliable way to achieve this is
  #vocab("simple random sampling", "einfache Zufallsstichprobe"):
  every member of the population has the same chance of being
  selected, and selections do not influence one another.
]

#only-theory[
  Randomness is doing something specific here, and it is worth
  naming. It is not that a random sample is guaranteed to resemble
  the population --- it might, by bad luck, not. It is that a random
  procedure has no *systematic* preference for one kind of member
  over another. Any method that lets a person's convenience,
  visibility, or willingness decide who gets included will lean in
  some direction, and it will lean the same way every time you repeat
  it. A bigger sample does not fix a leaning method; it just makes
  the wrong answer more precise.
]

#only-high[
  Two refinements are worth knowing, because simple random sampling
  is often impractical.

  In #vocab("stratified sampling", "geschichtete Stichprobe") the
  population is first divided into groups (*strata*) that are known
  to differ --- year groups, language regions, age bands --- and a
  random sample is drawn from each, in proportion to its size. This
  guarantees every group is represented, which a simple random sample
  only achieves on average. If you want the opinion of a school with
  four year groups, sampling 25 students at random from each year is
  safer than sampling 100 students at random from the school.

  In #vocab("cluster sampling", "Klumpenstichprobe") the population
  is divided into many similar groups (*clusters*) and a few whole
  clusters are chosen at random, then examined completely. Choosing
  six classes at random and surveying all of them is far cheaper than
  tracking down 150 individually selected students across the whole
  school. The saving comes at a price: students within one class
  resemble each other more than students drawn from everywhere, so a
  cluster sample carries less information than a simple random sample
  of the same size.
]

#ex(difficulty: 2, time: "15 min")[
  For each proposal, decide whether the sample is likely to be
  representative. If it is not, name the specific group that is
  over- or under-represented, and say in which direction you expect
  the result to be wrong.
  + A tour operator wants to know what proportion of Swiss people
    enjoy holidays in the Jura. A polling institute interviews guests
    at a hotel in Delémont.
  + A commune of #num(100000) inhabitants wants to know whether
    residents support building a new car park in the town center. 450
    drivers are surveyed at traffic lights.
  + A school wants to know what students think of the canteen food. A
    sample of students who arrive by bus each morning is
    interviewed.
  + A newspaper asks readers to vote in an online poll on its
    website.
][
  + Not representative. Guests at a Jura hotel have already chosen to
    holiday in the Jura, so enthusiasm will be enormously
    overstated. People who dislike the region are almost entirely
    absent.
  + Not representative. Only drivers are asked, and drivers are
    exactly the group that benefits from a car park. Support will be
    overstated; residents who cycle, walk, or use public transport
    are missing.
  + Not representative for a question about food, but the reason is
    subtler: bus students may be a fine cross-section of opinions
    about the canteen. The problem is that they are systematically
    the students living further away, who may be more likely to eat
    at the canteen at all --- so they are over-represented among
    those with an opinion. Whether this biases the *result* depends
    on the question asked.
  + Not representative. Only readers of that newspaper, only those
    online during the poll, and only those motivated enough to click
    --- and motivation correlates strongly with holding a strong
    opinion. Moderate views will be badly under-represented.
]

== How Samples Go Wrong

#only-theory[
  "The sample was not representative" is a diagnosis, not an
  explanation. It is more useful to be able to name the mechanism.
]

#definition(title: "Four Ways a Sample Misleads")[
  / Sampling bias: with #vocab("sampling bias", "Auswahlverzerrung")
    the method of choosing systematically favors part of the
    population. A daytime telephone survey reaches people who are at
    home during the day.
  / Self-selection: under #vocab("self-selection", "Selbstselektion")
    the participants choose themselves. Online polls, product
    reviews, and "call this number to register your opinion" all
    collect the strongly motivated and miss the indifferent.
  / Survivorship bias: under
    #vocab("survivorship bias", "Überlebendenverzerrung") you can only
    examine what made it into the data, and what failed is invisible.
    See below.
  / Question wording: a question that signals its preferred answer,
    or confuses the reader, produces answers about the question
    rather than about the world.
]

// ── IMAGE (recommended) ──────────────────────────────────────
// The bomber schematic with red dots marking hits on the returning
// planes. The widely used version (McGeddon, Wikimedia, CC BY-SA) is
// a modern illustration rather than a wartime document -- worth
// captioning honestly as such, since a chapter about checking sources
// should not launder one. Place it BEFORE the punchline so students
// can look at the picture and reach Wald's conclusion themselves.
// Suggested file: images/survivorship-bias-bomber.png
// #only-theory[#fig(
//   image("images/survivorship-bias-bomber.png", width: 55%),
//   caption: [Where the returning bombers were hit. A modern
//     illustration of Wald's reasoning, not a wartime diagram.],
// )]

#example(title: "The Armor on the Bombers")[
  During the Second World War, Allied statisticians examined bombers
  returning from missions and mapped where they had been hit. The
  damage clustered on the wings and the fuselage; the engines were
  comparatively clean. The obvious recommendation was to add armor
  where the bullet holes were.

  The mathematician Abraham Wald pointed out that the data described
  only the planes that came *back*. Hits to the engines were rare in
  that sample not because engines were rarely hit, but because a
  plane hit in the engines tended not to return to be measured at
  all. The armor belonged precisely where the returning planes showed
  no damage.

  The sample was not wrong. Every measurement in it was accurate. It
  simply answered a different question from the one being asked ---
  and noticing that is the entire skill.
]

#example(title: "Two Ways to Ask One Question")[
  Compare:

  #quotebox[
    "Don't you agree that a small increase in local taxes is a
    worthwhile investment in the quality of our children's
    education?"
  ]

  #quotebox[
    "Don't you think we should stop piling further burdens on
    taxpayers to fund yet another building project?"
  ]

  Both are about the same proposal. Both will produce a majority ---
  opposite majorities. Neither result tells you anything about public
  opinion; each tells you about the question.

  A neutral version states the facts and offers a balanced range of
  responses:

  #quotebox[
    "The commune proposes raising the communal tax rate by 1% to
    finance a new school building. What is your view? (strongly in
    favor / in favor / neutral / against / strongly against)"
  ]
]

// ── IMAGE (recommended) ──────────────────────────────────────
// The four-target accuracy-vs-precision diagram (\centfig{accuracyvsprecision}
// in the old script): shots tightly grouped off-center, scattered
// around the center, and so on. It earns its place here because it
// separates the two failure modes cleanly -- bias is being off-center,
// and no amount of extra data moves the center; small samples are
// scatter, and more data does shrink that. That is exactly the point
// made in prose two paragraphs above, and the picture makes it stick.
// NOTE: this would want a short paragraph of its own to introduce the
// accuracy/precision vocabulary, which the chapter does not currently
// teach. Happy to write it if you want the concept in.
// Suggested file: images/accuracy-vs-precision.png
// #only-theory[#fig(
//   image("images/accuracy-vs-precision.png", width: 75%),
//   caption: [Bias moves the center; sample size only tightens the
//     scatter.],
// )]

#warning[
  In everyday speech, calling a study "biased" is an accusation about
  someone's motives. In statistics it is a technical description of a
  *method*: a procedure is biased if it leans systematically in one
  direction. An entirely honest, well-intentioned researcher can use
  a badly biased method, and frequently does. Keep the two meanings
  apart --- especially when you are the one being accused.
]

#ex(difficulty: 2, time: "15 min")[
  Name the mechanism at work in each case --- sampling bias,
  self-selection, survivorship bias, or question wording --- and
  explain who or what is missing from the data.
  + An article reports that four out of five successful entrepreneurs
    dropped out of university, and concludes that dropping out
    improves your chances of success.
  + A restaurant's online rating is calculated from the reviews it
    has received.
  + A survey asks: "How satisfied are you with the excellent new
    school timetable?"
  + A study of the effectiveness of a fitness app analyzes the data
    of users who were still using it after six months.
][
  + Survivorship bias. Only successful entrepreneurs were examined.
    The enormous number of people who dropped out and did *not*
    succeed never enter the sample. To answer the question you would
    need the success rate among all dropouts, compared with the
    success rate among all graduates.
  + Self-selection. Reviews are written by people motivated to write
    one, which typically means the delighted and the furious. Diners
    who found the meal acceptable are almost entirely absent, which
    is why rating distributions are so often U-shaped.
  + Question wording. The word "excellent" tells the respondent which
    answer is expected, and makes disagreement feel like a
    correction.
  + Survivorship bias again --- and this one is commercially
    convenient. Users for whom the app did not work stopped using it
    and left the sample. The study measures the experience of people
    the app suited, not the app's effectiveness.
]

#ex(
  difficulty: 2,
  time: "15 min",
  keep-together: true,
  hints: (
    "Write the population down precisely first, including the unit of observation. \"People in Switzerland\" and \"households in Switzerland\" are not the same population, and the second is not a list of the first.",
    "For each one, ask yourself: which members of the population would my method never reach? That group is the source of the bias.",
  ),
)[
  Design a sampling method for each question, aiming to reduce bias
  as far as is practical. State the population, describe your method,
  and name one group your method still risks missing.
  + How many people in Switzerland smoke?
  + What proportion of households own no car?
][
  Answers will vary; these are model responses.
  + Population: all residents of Switzerland (an age floor should be
    stated, e.g. 15 and over). A random sample drawn from the
    population register, contacted by post with follow-up, is far
    better than any street or telephone survey. Still missing:
    people without a registered address, and those who decline ---
    and willingness to answer a question about smoking may itself
    depend on whether you smoke. Self-reporting is a further
    weakness.
  + Population: all households in Switzerland. Households, not
    people, are the sampling unit --- surveying individuals would
    over-represent large households. Random selection from a
    household register; still missing: households that do not
    respond, and any group with unusual mobility patterns (e.g. very
    rural households are near-certain to own a car and may be
    under-sampled if response rates are lower there).
]

#ex(difficulty: 3, level: "high", time: "20 min")[
  A Gymnasium has four year groups of very different sizes: 320, 290,
  250, and 140 students. The school wants to survey 100 students
  about a proposed change to the timetable, and expects opinions to
  differ sharply between younger and older students.
  + Explain why a simple random sample of 100 students from the whole
    school is risky here.
  + Design a proportional stratified sample of 100 students. How many
    should be drawn from each year?
  + The school suggests instead picking four classes at random and
    surveying everyone in them. Name one practical advantage and one
    statistical disadvantage.
][
  + With opinions differing sharply by year, the result depends
    heavily on how many of each year happen to be drawn. A simple
    random sample gets the proportions right *on average*, but any
    single sample may badly over- or under-represent the smallest
    year --- and with only 140 students in it, the fourth year could
    easily be represented by too few students to be meaningful.
  + Total $N = 320 + 290 + 250 + 140 = #num(1000)$, so each stratum
    contributes $100/#num(1000) = 10%$ of its size: $32$, $29$, $25$,
    and $14$ students respectively, drawn at random within each year.
  + Advantage: far cheaper and quicker --- four classes can be
    surveyed in a single lesson each, with no need to track down
    individuals across the school. Disadvantage: students in the same
    class share teachers, timetable, and daily routine, so their
    opinions are more alike than those of 100 students drawn from
    across the school. The sample therefore carries less information
    than its size suggests, and if the four classes happen to fall in
    only two year groups the year-group problem returns.
]

== Thinking Statistically

#only-theory[
  Notice what Wald actually did. He performed no calculation. He
  looked at a table everyone else had already looked at and asked a
  question nobody had asked: *where did these numbers come from?*
  That question, and two of its relatives, will get you further than
  any formula in this unit.
]

#keybox(title: "Three Questions")[
  + *What am I actually measuring?* The quantity recorded and the
    quantity you care about are not always the same thing --- and a
    count is not a rate.
  + *Who or what is missing?* Data comes from whatever survived,
    responded, or got noticed. Everything else is silent.
  + *What else could produce this pattern?* Before accepting the
    first explanation, write down its rivals. If you cannot think of
    any, you have not thought long enough.
]

#ex(difficulty: 1, time: "10 min")[
  Each of the following correlations is real. For each one, suggest a
  third factor that could produce it without either variable causing
  the other.
  #auto-parts(
    1,
    [Ice cream sales and drowning deaths rise and fall together.],
    [The more firefighters attend a fire, the more damage it does.],
    [Children with bigger feet read better.],
    [Countries whose people eat more chocolate win more Nobel
      Prizes.],
    [Villages with more storks nesting have more babies born.],
    [People who take vitamin supplements live longer than people who
      do not.],
  )
][
  #auto-parts(
    1,
    [Season. Hot weather increases both ice cream sales and time
      spent in water.],
    [The size of the fire. Big fires attract more firefighters and
      cause more damage; the firefighters are a response to the
      damage, not a cause of it.],
    [Age. Older children have bigger feet and have been reading
      longer.],
    [National wealth. Rich countries can afford both chocolate and
      well-funded research institutions.],
    [Village size, or rural character. Larger villages have more
      buildings for storks and more residents to have babies; rural
      areas have both more storks and higher birth rates.],
    [Who chooses to take supplements. People who take them also tend
      to exercise, eat well, and visit doctors --- a pattern called
      *healthy-user bias*. The supplement may be doing nothing at
      all.],
  )
]

#ex(difficulty: 2, time: "20 min", keep-together: true)[
  Across many cities, the rate of violent crime is higher in warm
  weather than in cold.
  + Propose at least three different mechanisms that could produce
    this pattern. At least one should not involve temperature
    affecting behavior at all.
  + An argument is put forward that heat makes people aggressive.
    Which of your mechanisms does the observed correlation rule out?
  + Describe one observation that would help distinguish between two
    of your mechanisms. Be specific about what you would compare.
][
  + Several are plausible:
    - *Opportunity.* Warm weather means more people outdoors, later
      into the evening, in contact with strangers. More interactions
      means more of everything, including conflict.
    - *Physiology.* Heat causes discomfort, poor sleep, and
      irritability, lowering the threshold for aggression.
    - *Seasonal companions.* Warm months bring school holidays,
      festivals, tourism, and higher alcohol consumption. None of
      these is temperature itself.
    - *Recording.* Incidents outdoors and in public are more likely
      to be witnessed and reported than incidents indoors, so warm
      weather may raise the *recorded* rate more than the true one.
  + None of them. This is the central point: the correlation is
    equally consistent with all four, so on its own it supports none
    of them over the others. A correlation constrains the set of
    explanations far less than people expect.
  + Examples of discriminating observations:
    - Compare *indoor* violent incidents against temperature. The
      opportunity mechanism predicts little effect indoors; the
      physiology mechanism predicts one.
    - Compare unusually warm days *outside* the summer months --- a
      20°C day in November has the temperature but no school
      holidays, no tourists, and no festival calendar. If the rate
      rises on those days, the seasonal-companions explanation
      weakens.
    - Compare cities with similar climates but different holiday
      calendars.
]

#ex(difficulty: 2, time: "15 min", keep-together: true)[
  When steel helmets were issued to soldiers during the First World
  War, the number of head wounds treated at field hospitals went
  *up*, substantially.

  + A staff officer concludes the helmets are making things worse and
    proposes withdrawing them. What has he overlooked?
  + What would you need to measure instead, to answer the question he
    was actually asking?
  + Describe another situation in which an improvement makes a
    statistic look worse.
][
  + He is comparing counts in a category whose membership has
    changed. Before helmets, a soldier struck on the head frequently
    died and was recorded as a death. Afterwards, the same blow
    produced a wounded man who reached a field hospital and was
    recorded as a head wound. The rise in wounds is partly a
    *transfer* out of the deaths column --- exactly what a helmet is
    supposed to achieve.
  + Head wounds and head-related deaths together, as a rate per
    soldier exposed. If that combined rate is unchanged while the
    split shifts from deaths toward wounds, the helmet is working
    exactly as intended.
  + Many:
    - Better cancer screening raises the number of diagnosed cases,
      because it finds cases that previously went undetected.
    - Improved reporting procedures for harassment or domestic
      violence raise recorded offense counts, sometimes sharply,
      without any change in how often the offense occurs.
    - Seat belts and airbags raise the ratio of injuries to deaths in
      road collisions.
    - Widened diagnostic criteria raise the recorded prevalence of a
      condition without any change in the population.
]

#ex(difficulty: 2, time: "15 min")[
  A city builds a protected bike lane along a busy street. In the
  three years afterwards, the number of cyclists injured on that
  street is 40% higher than in the three years before.

  A newspaper reports that the bike lane has made cycling more
  dangerous. What is the missing quantity, and what would you need to
  know before agreeing or disagreeing?
][
  The report gives a *count* where the question demands a *rate*. If
  the lane persuaded many more people to cycle --- which is its
  purpose --- then the number of cyclists rose too, and a rise in
  injuries may accompany a fall in risk per cyclist.

  The quantity needed is injuries per unit of cycling exposure:
  injuries per cyclist-kilometer, or per cyclist-trip, on that
  street. If cycling volume tripled while injuries rose by 40%, the
  risk per trip fell by roughly half.

  Two further checks: whether injuries on *neighboring* streets fell
  (cyclists may simply have moved), and whether the severity mix
  changed --- a rise in minor injuries alongside a fall in serious
  ones is a different story from the reverse.
]

#ex(difficulty: 2, time: "15 min")[
  Hospital A has a higher death rate among heart-surgery patients
  than Hospital B. A newspaper ranks B above A and advises readers to
  choose B.
  + Give a reason why A might have the higher death rate while
    actually providing better care.
  + Suppose surgeons are ranked publicly on the death rates of their
    own patients. What behavior does this create, and who is harmed
    by it?
][
  + Case mix. A may be the regional referral center that receives the
    most complex and highest-risk cases, precisely because it is
    trusted with them, while B transfers its difficult patients to A
    and operates on healthier ones. The comparison is only meaningful
    after adjusting for how ill the patients were on arrival ---
    what is called risk adjustment.
  + It creates an incentive to decline high-risk patients, since
    operating on someone likely to die worsens your published record
    whether or not surgery was their best chance. The people harmed
    are exactly the patients with the most to gain from surgery. This
    is not hypothetical --- it is a documented effect of published
    surgeon-level mortality rankings, and a good illustration of a
    measure changing the thing it measures.
]

#ex(
  difficulty: 3,
  time: "25 min",
  keep-together: true,
  hints: (
    "Settle two definitions before comparing any methods: what counts as a tree (a minimum trunk diameter, say), and whether the average should weight a thicket of saplings as heavily as a stand of mature trees.",
    "For method (a), picture one tree standing alone in a clearing and one in the middle of a dense thicket. Which of the two is the nearest tree to more of the ground?",
    "For method (c), ask what you must already have done before you can pick a labeled tree at random -- and whether, having done it, you still need a sample at all.",
  ),
)[
  You want to estimate the average height of a tree in a particular
  forest. Four methods are proposed:

  #auto-parts(
    1,
    [Lay a grid of points over the map, 100 m² apart, and measure the
      tree nearest to each point.],
    [Walk into the forest and measure the first ten trees you
      encounter.],
    [Label every tree in the forest, then pick trees at random from
      the list.],
    [Choose several 10 m × 10 m squares at random and measure every
      tree inside each one.],
  )

  + Before comparing the methods, state two definitions the question
    leaves open, and explain how each choice changes the answer.
  + For each method, give one advantage and one specific way it
    distorts the result. For (a), think carefully --- the bias is
    real and easy to miss.
  + Which method would you use, and what would you do about its
    weakness?
][
  + Two definitions are needed:
    - *What counts as a tree.* Without a minimum trunk diameter or
      height, every seedling qualifies, and the answer is dominated
      by saplings. A stated threshold (e.g. trunk diameter at least
      10 cm) makes the question answerable.
    - *What "average tree" means.* An arithmetic mean over
      individual trees weights a dense thicket of thin young trees
      as heavily as a stand of mature ones, and most forests contain
      far more small trees than large. An average per unit area, or
      per size class, may be what is actually wanted.
  + Method by method:
    - *(a) Nearest tree to each grid point.* Advantage: no list of
      trees is needed, and the grid covers the forest evenly.
      Distortion: it systematically favors isolated trees. A tree
      standing alone in a clearing is the nearest tree to a large
      area of ground; a tree in a dense thicket is nearest to almost
      none. Isolated trees get more light and grow differently, so
      the sample is biased toward exactly the unrepresentative
      individuals.
    - *(b) First ten encountered.* Advantage: fast, requires
      nothing. Distortion: you enter from a road, path, or forest
      edge, and edge trees receive more light and wind than interior
      trees. It is a convenience sample, and its bias is systematic
      rather than random --- repeating it will produce the same
      error again.
    - *(c) Label every tree, then draw at random.* Advantage: a
      genuine simple random sample, the statistical ideal.
      Distortion: it is self-defeating. To label every tree you must
      already have found and visited every tree, at which point you
      could have measured them all and taken a census. On any real
      forest it is infeasible, and infeasible methods have no
      advantages.
    - *(d) Random plots, measure everything inside.* Advantage:
      practical, and selecting *locations* at random requires no
      list of trees --- so density is respected rather than
      distorted. Distortion: it is cluster sampling, and trees
      within one plot resemble each other (same soil, light, age,
      species), so the sample carries less information than the same
      number of independently chosen trees. It also needs an
      explicit rule for trees on the boundary.
  + Method (d), with the weakness addressed by using many small
    plots rather than a few large ones --- this spreads the sample
    across more of the forest and reduces the resemblance within
    each cluster --- plus a stated boundary rule (for example, count
    a tree if the center of its trunk lies inside the square). A
    stratified version is better still if the forest has clearly
    distinct areas: sample plots separately from the young
    plantation and the old stand, in proportion to their areas.
]

== Statistics, Facts, and the Media

#only-theory[
  Most statistics reach you through a journalist, an advertisement,
  or a post, and each of those has an interest that is not identical
  to accuracy. Bad statistical reporting is usually not a conspiracy.
  It is a headline competing for your attention, written quickly by
  someone who is not a statistician, about a study they have often
  not read.

  This matters for how you respond to it. "The media lies" is as lazy
  as "statistics prove anything", and it fails the same way: it lets
  you dismiss anything inconvenient without doing any work.
  Distinguishing a badly reported good study from a well-reported bad
  one takes effort, and it is the effort that separates an informed
  citizen from a cynical one.
]

// ── IMAGE (recommended) ──────────────────────────────────────
// A real product's or restaurant's rating distribution, showing the
// characteristic U shape: a pile of 5s, a pile of 1s, almost nothing
// between. Any shopping or review site provides one in a screenshot.
// This is the most immediately convincing evidence of self-selection
// students will meet, because they use these ratings weekly and have
// never had a reason to ask why the middle is empty.
// Suggested file: images/review-distribution-u-shape.png
// #only-theory[#fig(
//   image("images/review-distribution-u-shape.png", width: 55%),
//   caption: [The delighted and the furious both write reviews.
//     Nobody posts to report that dinner was acceptable.],
// )]

#keybox(title: "Questions Worth Asking About Any Statistical Claim")[
  + Who was studied, and who was left out?
  + How many? A striking result from 12 people is a suggestion, not a
    finding.
  + Compared with what? "Doubles your risk" is meaningless without
    the original risk. A doubling from 1 in a million is not news.
  + Who paid for it, and would a different result have been
    inconvenient for them?
  + Is this one study, or a consistent picture across many?
  + Does the headline claim a *cause* where the study measured only
    an *association*?
]

#remark[
  A word about anecdotes. "My grandfather smoked forty a day and
  lived to ninety" is a true statement and tells you almost nothing,
  because a single case cannot distinguish between "smoking is
  harmless" and "smoking is dangerous but some people are lucky". A
  statistic is an attempt to answer exactly the question an anecdote
  cannot. This is not a reason to dismiss people's experiences ---
  it is a reason not to mistake one for evidence about everyone.
]

// ── IMAGE (recommended) ──────────────────────────────────────
// A headline set beside the actual finding of the study it reports
// -- ideally one where the study measured an association and the
// headline announced a cause. If you have a pair from Swiss media so
// much the better; students discount foreign examples as somebody
// else's problem. A cartoon on the same theme (xkcd 552 is the
// obvious one) would work as a lighter alternative, but the real
// side-by-side is more damaging in the useful sense.
// Suggested file: images/headline-vs-finding.png
// #only-theory[#fig(
//   image("images/headline-vs-finding.png", width: 85%),
//   caption: [Same study, two claims. Only one of them was measured.],
// )]

#ai-box(role: "Checker")[
  Find a news article that reports a statistical finding --- a health
  study, a survey, an economic figure. Read it yourself first and
  write down what you think the three weakest points are.

  Then ask an AI assistant to identify the weaknesses in the same
  article. Compare the two lists.

  Now the part that matters: check the AI's claims against the
  article. AI assistants are fluent critics and will readily produce
  plausible-sounding criticisms of studies they have not read,
  including objections that the article has already answered. For
  each point it raised, mark whether it is (a) genuinely supported by
  the text, (b) plausible but unverifiable from the article alone, or
  (c) contradicted by something the article actually says. Report the
  counts.
]

#exploration(title: "Three Claims")[
  Find three statistical claims currently circulating --- in a
  newspaper, an advertisement, a political campaign, or social media.
  For each one:

  + State the claim precisely, in your own words.
  + Work out what the population would have to be, and how a sample
    could realistically have been drawn.
  + Apply the six questions from the box above. Which can you answer
    from the report itself? Which would require finding the original
    study?
  + Decide: does this claim deserve to be believed, doubted, or
    treated as unresolved? "Unresolved" is a legitimate answer and
    often the honest one.

  Bring your three claims to class. We will look at the ones where
  people disagreed.
]

#only-theory[
  One last thought before we start computing. Everything in the rest
  of this unit --- means, medians, quartiles, standard deviations,
  histograms, boxplots --- is a tool for compressing a large amount
  of data into something a human can hold in mind. Compression always
  loses information. The skill is not in performing the compression;
  a calculator does that. The skill is in knowing what got lost, and
  whether it mattered.
]

#print-hints()
#print-vocab()
