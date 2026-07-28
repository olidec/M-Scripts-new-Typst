#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Measures of Spread")
#let ex = exercise.with(chapter: "Measures of Spread")

// ── Datasets ─────────────────────────────────────────────────
// These ARE referenced by the chart calls below, so they earn their
// place as bindings rather than duplicating a printed table.

#let club-a = (33, 34, 34, 34, 35, 35, 35, 35, 36, 36, 36, 37)
#let club-b = (14, 15, 15, 15, 16, 16, 54, 54, 54, 55, 56, 56)

#let antonia = (9.5, 11, 9, 10, 10.5)
#let lars = (13, 7, 6, 15, 9)

#let travel-times = (
  5, 12, 8, 25, 15, 10, 32, 7, 18, 22, 9, 14,
  40, 11, 6, 20, 13, 28, 16, 10, 35, 12, 24, 45,
)


// ── Bell-curve figure (chapter-local) ────────────────────────
// Native Typst: a normal density drawn as a filled polygon, with
// nested bands for |z| <= 1, <= 2, <= 3. Kept local rather than put
// in preamble.typ because so far only this one extension section
// needs it -- promote it if a later unit wants the same picture.
#let bell-curve(width: 12cm, height: 3.8cm) = align(center, {
  let zlo = -3.6
  let zhi = 3.6
  let steps = 100
  let foot = 0.95cm
  let px(z) = width * (z - zlo) / (zhi - zlo)
  let py(z) = height * (1 - calc.exp(-z * z / 2))

  // one shaded band from a to b, closed along the baseline
  let band(a, b, fillc) = {
    let pts = range(steps + 1).map(i => {
      let z = a + (b - a) * i / steps
      (px(z), py(z))
    }) + ((px(b), height), (px(a), height))
    place(dx: 0pt, dy: 0pt, polygon(fill: fillc, stroke: none, ..pts))
  }

  let tick(z, body) = place(
    dx: px(z) - 0.85cm,
    dy: height + 5pt,
    box(width: 1.7cm, align(center, text(size: 8pt, fill: luma(70), body))),
  )

  let pct(z, body) = place(
    dx: px(z) - 0.7cm,
    dy: height - 22pt,
    box(width: 1.4cm, align(center, text(size: 7.5pt, fill: luma(50), body))),
  )

  box(width: width, height: height + foot, {
    // widest band first, narrower bands painted over it
    band(-3, 3, accent.lighten(78%))
    band(-2, 2, accent.lighten(52%))
    band(-1, 1, accent.lighten(22%))

    // the curve itself, closed along the baseline
    let outline = range(steps + 1).map(i => {
      let z = zlo + (zhi - zlo) * i / steps
      (px(z), py(z))
    }) + ((px(zhi), height), (px(zlo), height))
    place(dx: 0pt, dy: 0pt, polygon(
      fill: none,
      stroke: 1pt + accent,
      ..outline,
    ))

    // boundaries at +-1 and +-2 standard deviations
    for z in (-2, -1, 1, 2) {
      place(dx: px(z), dy: py(z), line(
        start: (0pt, 0pt),
        end: (0pt, height - py(z)),
        stroke: 0.6pt + luma(90),
      ))
    }

    place(dx: 0pt, dy: height, line(
      start: (0pt, 0pt),
      end: (width, 0pt),
      stroke: 0.7pt + luma(70),
    ))

    pct(0, [68%])
    pct(-1.5, [13.5%])
    pct(1.5, [13.5%])
    pct(-2.5, [2.1%])
    pct(2.5, [2.1%])

    tick(-2, $mu - 2 sigma$)
    tick(-1, $mu - sigma$)
    tick(0, $mu$)
    tick(1, $mu + sigma$)
    tick(2, $mu + 2 sigma$)
  })
})

= Measures of Spread

#only-theory[
  The previous chapter ended with a promise and a problem. Two tennis
  clubs, both with mean age 35 and median age 35: one where every
  member is in their mid-thirties, and one with a crowd of teenagers,
  a crowd of veterans, and nobody near 35 at all.

  Every measure of center you know reports these two clubs as
  identical. They are not remotely identical, and no amount of
  cleverness about averages will fix that, because the difference is
  not about where the data sits. It is about how far it spreads.
]

#objectives(
  bfkm[compute the range, the quartiles, and the interquartile range
    of a dataset, and state which quartile convention was used],
  bfkm[compute the variance and the standard deviation, and interpret
    the standard deviation in the units of the original data],
  bfkm[draw and read a boxplot, and use boxplots to compare two
    distributions],
  [interpret a percentile, and explain what a percentile does and
    does not say about an individual],
  [identify outliers using the $1.5 dot "IQR"$ rule, and decide
    whether an outlier should be investigated, kept, or removed],
  [apply the 68/95 rule of thumb to bell-shaped data, and
    state when it does not apply],
)

== Two Clubs, One Center

#only-theory[
  Here are the two clubs, with the ages of all twelve members of
  each.
]

#only-theory[
  #fig(
    align(center, text(size: 9.5pt, raw(
      "Club A:  33  34  34  34  35  35  35  35  36  36  36  37\n"
        + "Club B:  14  15  15  15  16  16  54  54  54  55  56  56",
    ))),
    caption: [Both clubs: $n = 12$, total 420, mean 35, median 35.],
  )
]

#only-theory[
  Check it if you like --- both totals are 420, so both means are
  exactly 35, and in both cases the sixth and seventh values average
  to 35, so both medians are exactly 35 as well.

  What distinguishes them is obvious to the eye and invisible to
  every number we have. So we need new numbers: not "where is the
  data?" but "how far apart is it?"
]

== Range and Interquartile Range

#definition(title: "Range")[
  The #vocab("range", "Spannweite") is the difference between the
  largest and the smallest value:
  $ "range" = x_"max" - x_"min". $
]

#only-theory[
  Club A has range $37 - 33 = 4$ years; Club B has range
  $56 - 14 = 42$ years. One number, and the two clubs are already
  distinguishable.

  The range is also the weakest measure in this chapter, because it
  is computed from exactly two observations and ignores the other
  ten. One unusual value moves it entirely, and it can only ever grow
  as you collect more data. It is a first look, not a summary.
]

#definition(title: "Quartiles and the Interquartile Range")[
  Sort the data. The median splits it into a lower and an upper half.

  The lower #vocab("quartile", "Quartil") $Q_1$ is the median of the
  lower half; the upper quartile $Q_3$ is the median of the upper
  half. (The median itself is sometimes written $Q_2$.) Roughly a
  quarter of the data lies below $Q_1$ and a quarter above $Q_3$.

  The #vocab("interquartile range", "Quartilsabstand") is
  $ "IQR" = Q_3 - Q_1, $
  the width of the middle half of the data. Unlike the range, it is
  unaffected by the most extreme values on either side.
]

#warning[
  *When $n$ is odd, the middle value has to go somewhere, and there
  is no universal agreement about where.* This course leaves the
  median out of both halves. Some software puts it into both.

  On the nine values $1, 2, dots, 9$ the two conventions give
  $Q_1 = 2.5, Q_3 = 7.5$ and $Q_1 = 3, Q_3 = 7$ respectively ---
  different quartiles, and therefore a different IQR, from identical
  data. Spreadsheets and statistics packages often use a third rule
  again, based on interpolation.

  None of them is wrong. But in an exam, or in any written work,
  *state which method you used*, and do not be surprised when a
  calculator disagrees with your hand computation by a little.
]

#example(title: "Travel Times")[
  The 24 travel times from the chapter on displaying data, sorted:

  #align(center, text(size: 9.5pt, raw(
    " 5  6  7  8  9 10 10 11 12 12 13 14 | 15 16 18 20 22 24 25 28 32 35 40 45",
  )))

  With $n = 24$ the halves have twelve values each, marked by the
  bar.

  / Median: mean of the 12th and 13th values, $(14 + 15)/2 = 14.5$
    minutes.
  / $Q_1$: median of the lower twelve, i.e. the mean of its 6th and
    7th values, $(10 + 10)/2 = 10$ minutes.
  / $Q_3$: median of the upper twelve, $(24 + 25)/2 = 24.5$ minutes.
  / IQR: $24.5 - 10 = 14.5$ minutes.
  / Range: $45 - 5 = 40$ minutes.

  Read that IQR back into the situation: the middle half of the class
  travels between 10 and 24.5 minutes. The range says the class
  spans 40 minutes, which is true and is driven entirely by two
  people.
]

#ex(difficulty: 1, time: "10 min")[
  For each dataset, find the range, the median, both quartiles, and
  the IQR. State which quartile convention you used.
  #auto-parts(
    1,
    [$4, 7, 8, 11, 13, 15, 18, 21$],
    [$2, 3, 5, 5, 8, 9, 12, 14, 20$],
  )
][
  #auto-parts(
    1,
    [Already sorted, $n = 8$. Range $21 - 4 = 17$. Median: mean of
      the 4th and 5th values, $(11 + 13)/2 = 12$. Lower half
      $4, 7, 8, 11$ gives $Q_1 = (7 + 8)/2 = 7.5$; upper half
      $13, 15, 18, 21$ gives $Q_3 = (15 + 18)/2 = 16.5$. So
      $"IQR" = 9$. With $n$ even, both conventions agree.],
    [Sorted, $n = 9$. Range $20 - 2 = 18$. Median: the 5th value,
      $8$. Using the house convention (median excluded from both
      halves): lower half $2, 3, 5, 5$ gives $Q_1 = 4$; upper half
      $9, 12, 14, 20$ gives $Q_3 = 13$; $"IQR" = 9$. Under the other
      convention $Q_1 = 5$ and $Q_3 = 12$, giving $"IQR" = 7$ ---
      which is why the convention has to be stated.],
  )
]

#ex(difficulty: 2, time: "10 min")[
  Return to the two clubs at the start of the chapter.
  + Compute the range and the IQR for each.
  + Which of the two measures better captures how different the
    clubs are? Explain.
  + Club B gains one new member aged 35. What happens to its range?
    To its IQR? To its median?
][
  + *Club A:* range $37 - 33 = 4$. Lower six $33, 34, 34, 34, 35, 35$
    gives $Q_1 = 34$; upper six $35, 35, 36, 36, 36, 37$ gives
    $Q_3 = 36$; $"IQR" = 2$. \
    *Club B:* range $56 - 14 = 42$. Lower six gives $Q_1 = 15$;
    upper six gives $Q_3 = 54.5$; $"IQR" = 39.5$.
  + Both separate them decisively, and here either would do. The IQR
    is the more trustworthy of the two in general, because it uses
    the middle half of the data rather than two extreme points ---
    but note that in this case *neither* reveals the real structure
    of Club B, which is that it has no members near the middle at
    all.
  + Range: unchanged at 42, since 35 is neither a new minimum nor a
    new maximum. Median: with $n = 13$ the median is the 7th value,
    which is now 35 --- unchanged. IQR: barely moves. A single
    central member is nearly invisible to all three, which is a fair
    warning about how much these summaries discard.
]

== Percentiles

#definition(title: "Percentile")[
  The $p$-th #vocab("percentile", "Perzentil") is the value below
  which roughly $p$ per cent of the data lies.

  The quartiles are percentiles: $Q_1$ is the 25th percentile, the
  median is the 50th, and $Q_3$ is the 75th.
]

#only-theory[
  Percentiles are how growth is tracked in early childhood. A
  paediatrician plots a child's weight and length against reference
  curves --- the WHO Child Growth Standards, built from measurements
  of large numbers of healthy children --- and reports the result as
  a percentile. A length on the 25th percentile means that of 100
  healthy children of the same age and sex, about 25 would be shorter
  and about 75 taller.
]

#warning[
  A percentile is *not a score*. Parents told their child is "on the
  25th percentile" routinely hear it as 25 out of 100 --- a poor
  result, something to be fixed. It is nothing of the kind. Someone
  has to be on the 25th percentile; a quarter of all perfectly
  healthy children are at or below it, by construction. The 50th
  percentile is not a target, and a child cannot be "below average"
  in any sense that implies a deficiency.

  What a paediatrician actually watches is the *trajectory*. A child
  tracking steadily along the 15th percentile is growing normally. A
  child who was on the 75th at one visit and the 25th at the next has
  changed percentile, and that change --- not the level --- is the
  thing worth a second look.
]

#ex(difficulty: 2, time: "10 min")[
  A national reading test is taken by #num(40000) pupils. A pupil is
  told she is on the 90th percentile.
  + Roughly how many pupils scored below her?
  + Her friend is on the 45th percentile and concludes that he
    "failed, because 45% is below half". Respond.
  + The following year the test is made much harder and average
    scores fall sharply. If both pupils perform exactly as before
    relative to their year group, what happens to their percentiles?
][
  + About 90% of #num(40000), which is #num(36000) pupils.
  + He has confused a percentile with a percentage score. The 45th
    percentile means about 45% of pupils scored below him and about
    55% above --- he is a little below the middle of the year group,
    which is an entirely ordinary place to be. It says nothing about
    how many questions he answered correctly, and nothing at all
    about passing.
  + Nothing. Percentiles are positions *within the group*, so if
    everyone's raw score falls together and the ordering is
    unchanged, the percentiles are unchanged. This is also the
    limitation of percentiles: they cannot tell you whether the whole
    cohort improved or declined, only who is where inside it.
]

== The Boxplot

#definition(title: "Five-Number Summary and Boxplot")[
  The #vocab("five-number summary", "Fünf-Punkte-Zusammenfassung")
  of a dataset is
  $ x_"min", quad Q_1, quad "median", quad Q_3, quad x_"max". $

  A #vocab("boxplot", "Boxplot") draws it: a box from $Q_1$ to $Q_3$
  with the median marked inside, and lines --- *whiskers* ---
  reaching out toward the extremes. The box therefore holds the
  middle half of the data, and its width is the IQR.
]

#only-theory[
  The point of a boxplot is comparison. One distribution in a boxplot
  tells you little that the five numbers did not; several
  distributions on a shared axis are readable at a glance.
]

#only-theory[
  #fig(
    boxplot(
      ("Antonia", antonia), ("Lars", lars),
      width: 9cm, x-label: [training time (hours per week)],
    ),
    caption: [Two triathletes, five weeks each. Identical mean
      training time; entirely different consistency.],
  )
]

#only-theory[
  Both athletes average exactly 10 hours a week. Antonia's box is
  narrow --- she trains close to 10 hours every week. Lars's box is
  five times as wide: some weeks 6 hours, some weeks 15. If you were
  their coach, the mean would tell you nothing you needed and the
  boxplot would tell you everything.
]

#definition(title: "Whiskers and Outliers")[
  An observation is treated as an *outlier* if
  it lies more than $1.5 dot "IQR"$ beyond the nearer quartile ---
  that is, below $Q_1 - 1.5 dot "IQR"$ or above
  $Q_3 + 1.5 dot "IQR"$. These two bounds are called the *fences*.

  Each whisker then runs to the most extreme observation that is
  still *inside* the fence, and any observation beyond it is drawn as
  a separate point.
]

#warning[
  The whisker ends at a real data value, not at the fence. It is a
  common error to draw the whisker out to $Q_1 - 1.5 dot "IQR"$
  itself --- but that number is usually not an observation, and often
  is not even a possible one. Compute the fence, then look for the
  furthest actual value that has not crossed it.
]

#example(title: "Finding the Outliers")[
  Twelve delivery times, in minutes:

  #align(center, text(size: 9.5pt, raw(
    "12  14  15  15  16  17  18  18  19  20  21  47",
  )))

  $Q_1 = 15$, median $= 17.5$, $Q_3 = 19.5$, so $"IQR" = 4.5$ and
  $1.5 dot "IQR" = 6.75$. The fences are at
  $15 - 6.75 = 8.25$ and $19.5 + 6.75 = 26.25$.

  Only $47$ lies beyond a fence. The upper whisker therefore stops at
  $21$ --- the largest value still inside --- and $47$ is plotted on
  its own. The lower whisker runs to $12$.

  Now look at what that one value was doing to the summaries. With
  it, the mean is $19.33$ and the standard deviation $8.70$; without
  it, $16.82$ and $2.59$. The median moves from $17.5$ to $17$.
]

#remark[
  Being flagged as an outlier is not grounds for deletion. The
  $1.5 dot "IQR"$ rule is a *convention for drawing whiskers*, not a
  test for whether a value is real, and the constant $1.5$ was chosen
  because it works reasonably on bell-shaped data --- not derived
  from anything.

  A flagged value deserves a question, and the question is where it
  came from. A delivery of 47 minutes might be a typing error, or a
  van breaking down, or the one address across the river. The first
  should be corrected, the second is genuine data about a genuine
  risk, and the third means the dataset mixes two different
  situations. Deleting all three because they are inconvenient is
  how survivorship bias gets manufactured on purpose.
]

#only-theory[
  A boxplot is a summary, and like every summary in this unit it
  discards something. It is worth seeing exactly what. Here is Club B
  --- the teenagers-and-veterans club --- drawn both ways.
]

#only-theory[
  #fig(
    boxplot(("Club B", club-b), width: 9cm, x-label: [age (years)]),
    caption: [The boxplot: a broad, roughly symmetric spread centered
      on 35.],
  )
  #v(0.4em)
  #fig(
    dotplot(club-b, width: 9cm, x-label: [age (years)]),
    caption: [The same twelve members. There is nobody within
      eighteen years of the median.],
  )
]

#only-theory[
  The boxplot is not wrong --- every one of its five numbers is
  correct. But it is built from five numbers, and five numbers cannot
  express a hole in the middle. A boxplot can never show that a
  distribution is bimodal, and if you only ever draw boxplots you
  will never find out.

  The remedy is the one from two chapters ago: look at the
  distribution before you summarize it.
]

#ex(difficulty: 2, time: "15 min", keep-together: true)[
  A biologist measures the length in centimetres of nine dice snakes:

  #align(center, text(size: 9.5pt, raw(
    "84  79  90  73  95  88  92  81  67",
  )))

  + Determine the five-number summary. State your quartile
    convention.
  + Are there any outliers by the $1.5 dot "IQR"$ rule? Where do the
    whiskers end?
  + Sketch the boxplot.
][
  + Sorted: $67, 73, 79, 81, 84, 88, 90, 92, 95$. With $n = 9$ the
    median is the 5th value, $84$. Excluding the median from both
    halves (house convention): lower half $67, 73, 79, 81$ gives
    $Q_1 = (73 + 79)/2 = 76$; upper half $88, 90, 92, 95$ gives
    $Q_3 = (90 + 92)/2 = 91$. Five-number summary:
    $ 67, quad 76, quad 84, quad 91, quad 95. $
    (Under the other convention $Q_1 = 79$ and $Q_3 = 90$.)
  + $"IQR" = 91 - 76 = 15$, so $1.5 dot "IQR" = 22.5$ and the fences
    are at $76 - 22.5 = 53.5$ and $91 + 22.5 = 113.5$. Every
    observation lies between them, so there are no outliers and the
    whiskers run to the true minimum $67$ and maximum $95$.
  + A box from 76 to 91 with the median line at 84, whiskers to 67
    and 95, and no separate points.
]

#ex(difficulty: 2, time: "15 min")[
  Two boxplots are drawn on one axis for the results of a test taken
  before and after a training programme. Maximum score 70.

  #boxplot(
    ("Before", (min: 8, q1: 18, med: 24, q3: 31, max: 44)),
    ("After", (min: 20, q1: 34, med: 44, q3: 52, max: 66)),
    xmin: 0, xmax: 70, xstep: 10,
    width: 9cm, x-label: [score],
  )

  + Give the median, the IQR, and the range for each group.
  + Between which scores does the middle half of the "after" results
    lie?
  + Evaluate the effect of the programme. Mention both the center and
    the spread.
  + Name one thing these boxplots cannot tell you about the
    programme's effect.
][
  + *Before:* median 24, $"IQR" = 31 - 18 = 13$, range $44 - 8 = 36$.
    *After:* median 44, $"IQR" = 52 - 34 = 18$, range $66 - 20 = 46$.
  + Between 34 and 52 --- that is what the box shows.
  + Scores rose substantially: the median climbed 20 points, and the
    weakest "after" result (20) is above the "before" first quartile,
    so more than three quarters of the group now scores above where a
    quarter of them started. But the spread widened too --- the IQR
    grew from 13 to 18 and the range from 36 to 46 --- so the group
    became *less* uniform. The programme helped on average and did
    not help everybody equally.
  + Several things. It cannot tell you whether the same individuals
    improved, since the two boxplots are summaries of groups, not of
    paired results --- a student could have got worse while the
    median rose. It gives no $n$. And it cannot show the shape: the
    "after" group might be bimodal, with the programme working well
    for some and not at all for others, and the boxplot would look
    exactly the same.
]

== Variance and Standard Deviation

#only-theory[
  The IQR uses the quartiles, which means it uses two numbers and
  ignores the rest. That is exactly what makes it robust, and exactly
  what makes it wasteful. The last measure of spread uses every
  observation.

  The natural idea is to measure how far each value sits from the
  mean and then average those distances. Let us try it, with
  Antonia's five training times, whose mean is 10:
  $ (9.5 - 10) + (11 - 10) + (9 - 10) + (10 - 10) + (10.5 - 10)
    = -0.5 + 1 - 1 + 0 + 0.5 = 0. $
]

#only-theory[
  Zero. And that is not bad luck --- the deviations from the mean
  always sum to zero, for every dataset, because that is precisely
  what the mean is: the balance point where the pulls from either
  side cancel. The average deviation is useless as a measure of
  spread, because it is always $0$.

  So the signs must go. Two ways present themselves: take absolute
  values, or square. Both are used. Squaring is the one that wins,
  for a reason the previous chapter already exposed --- the mean is
  the number that minimizes the sum of *squared* deviations, so
  squares are the measure of distance for which the mean is the
  natural center. Absolute values pair naturally with the median
  instead.
]

#definition(title: "Variance and Standard Deviation")[
  The #vocab("variance", "Varianz") is the mean squared deviation
  from the mean:
  $ V = ((x_1 - overline(x))^2 + (x_2 - overline(x))^2 + dots
    + (x_n - overline(x))^2) / n
    = 1/n sum_(i=1)^n (x_i - overline(x))^2. $

  The #vocab("standard deviation", "Standardabweichung") is its
  square root:
  $ s = sqrt(V). $

  Squaring inflates the units --- a variance of travel times is in
  minutes squared, which is not a thing --- so taking the root
  returns the measure to the units of the original data. That is what
  makes $s$, and not $V$, the number one quotes.
]

#example(title: "Antonia and Lars")[
  Both have mean 10 hours.

  *Antonia*, times $9.5, 11, 9, 10, 10.5$:
  $ V = ((-0.5)^2 + 1^2 + (-1)^2 + 0^2 + 0.5^2) / 5
    = 2.5 / 5 = 0.5, quad s = sqrt(0.5) approx 0.71 "hours". $

  *Lars*, times $13, 7, 6, 15, 9$:
  $ V = (3^2 + (-3)^2 + (-4)^2 + 5^2 + (-1)^2) / 5
    = 60 / 5 = 12, quad s = sqrt(12) approx 3.46 "hours". $

  Antonia's training varies by about three quarters of an hour from
  week to week; Lars's by about three and a half. The ratio of their
  standard deviations is roughly $5 : 1$, which matches what the
  boxplots showed.
]

#remark[
  It is tempting to describe $s$ as "the average distance from the
  mean". It is not, quite. Squaring, averaging, and then taking the
  root gives a *root-mean-square* distance, which weights large
  deviations more heavily and therefore always comes out at least as
  large as the plain average distance. For Lars the average distance
  is $(3 + 3 + 4 + 5 + 1)/5 = 3.2$ hours, while $s approx 3.46$.

  "Roughly how far a typical value sits from the mean" is a fair
  description of what $s$ measures. Just do not expect it to equal
  the average of the distances.
]

#remark[
  Your calculator will offer *two* standard deviations, usually
  labelled $sigma x$ and $S x$. They differ in the denominator: one
  divides by $n$, the other by $n - 1$.

  The version defined above, dividing by $n$, describes the dataset
  in front of you, and it is the one this course uses --- so use
  $sigma x$. The $n - 1$ version is used when the data is a *sample*
  and you want to estimate the spread of a larger population it was
  drawn from; dividing by the smaller number makes the estimate
  slightly larger, correcting a bias that would otherwise make
  samples look more uniform than their populations. That belongs to
  inferential statistics, and to a later unit.

  For Antonia, $sigma x approx 0.71$ while $S x approx 0.79$. The gap
  shrinks as $n$ grows, and for large datasets it hardly matters ---
  but for $n = 5$ it plainly does.
]

#ex(difficulty: 1, time: "15 min")[
  Compute the variance and the standard deviation of each dataset by
  hand, dividing by $n$.
  #auto-parts(
    1,
    [$9, 10, 10, 8, 7, 11, 12, 9$],
    [$3, 3, 3, 3, 3, 5, 5, 5, 5, 10$],
  )
][
  #auto-parts(
    1,
    [Sum $= 76$, so $overline(x) = 9.5$. Deviations
      $-0.5, 0.5, 0.5, -1.5, -2.5, 1.5, 2.5, -0.5$; squares
      $0.25, 0.25, 0.25, 2.25, 6.25, 2.25, 6.25, 0.25$, total $18$.
      So $V = 18/8 = 2.25$ and $s = sqrt(2.25) = 1.5$.],
    [Sum $= 45$, so $overline(x) = 4.5$. Squared deviations:
      five values of $(3 - 4.5)^2 = 2.25$, four of
      $(5 - 4.5)^2 = 0.25$, and one of $(10 - 4.5)^2 = 30.25$,
      giving $11.25 + 1 + 30.25 = 42.5$. So $V = 4.25$ and
      $s approx 2.06$. Note how much of that total comes from the
      single value 10 --- squaring is what gives one distant
      observation so much weight.],
  )
]

#ex(difficulty: 2, time: "15 min")[
  Two companies each have 25 employees. Absences in April:

  #data-table(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    row-height: auto,
    [Days absent], [0], [1], [2], [3], [4], [5],
    [Company A], [4], [8], [3], [6], [2], [2],
    [Company B], [1], [3], [16], [5], [0], [0],
  )

  + Show that both companies have the same mean.
  + Compute the standard deviation for each, using frequencies.
  + Interpret the difference in one or two sentences, from the point
    of view of a manager planning cover.
][
  + *A:* $(4 dot 0 + 8 dot 1 + 3 dot 2 + 6 dot 3 + 2 dot 4
      + 2 dot 5)/25 = 50/25 = 2$ days. \
    *B:* $(1 dot 0 + 3 dot 1 + 16 dot 2 + 5 dot 3)/25 = 50/25 = 2$
    days. Identical.
  + *A:* $ V = (4 dot 4 + 8 dot 1 + 3 dot 0 + 6 dot 1 + 2 dot 4
      + 2 dot 9)/25 = 56/25 = 2.24, $
    so $s = sqrt(2.24) approx 1.50$ days. \
    *B:* $ V = (1 dot 4 + 3 dot 1 + 16 dot 0 + 5 dot 1)/25
      = 12/25 = 0.48, $
    so $s = sqrt(0.48) approx 0.69$ days.
  + Both companies lose the same total number of days, but Company B
    is predictable --- almost everyone is absent about two days ---
    while Company A contains both people who are never absent and
    people absent a whole week. Planning cover for A is much harder,
    and the mean alone would have told the manager the two situations
    were the same.
]

#ex(difficulty: 2, time: "10 min")[
  Each of the following datasets has mean 20 and range 40. Without
  computing anything, order them from smallest to largest standard
  deviation, and justify your ordering. Then check one of them by
  calculation.
  #auto-parts(
    1,
    [$0, 10, 20, 30, 40$],
    [$0, 0, 20, 40, 40$],
    [$0, 19, 20, 21, 40$],
  )
][
  Ordering, smallest to largest: (c), (a), (b).

  All three share the two extreme values $0$ and $40$, which
  contribute the same amount to every total. The difference is what
  the middle three values do. In (c) they sit essentially on the
  mean and contribute almost nothing; in (a) they are spread evenly;
  in (b) they are pushed out to the extremes, contributing the
  maximum possible.

  Checking (b): squared deviations $400, 400, 0, 400, 400$, total
  $1600$, so $V = 320$ and $s approx 17.89$. \
  For comparison, (a) gives $V = 200$ and $s approx 14.14$; for (c)
  the squared deviations $400, 1, 0, 1, 400$ total $802$, so
  $V = 160.4$ and $s approx 12.66$. The ordering holds.
  #heuristic("check an extreme or special case")
]

#ex(difficulty: 3, level: "high", time: "20 min", hints: (
  "Write down the definition of the variance for the new dataset, substituting the new values and the new mean, and see what cancels.",
  "If every value gains c, what happens to the mean? So what happens to each deviation x_i - x-bar?",
  "For the scaling case, pull the constant factor out of the squared bracket before summing.",
))[
  A dataset $x_1, dots, x_n$ has mean $overline(x)$, variance $V$,
  and standard deviation $s$.
  + Every value has a constant $c$ added to it. Show that the
    variance is unchanged.
  + Every value is multiplied by a constant $k > 0$. Show that the
    new standard deviation is $k dot s$.
  + A dataset of temperatures in degrees Celsius has standard
    deviation $2.5 degree$C. What is the standard deviation of the
    same temperatures converted to degrees Fahrenheit, using
    $F = 1.8 dot C + 32$?
  + Explain in words why adding a constant leaves the spread alone
    while multiplying does not.
][
  + The new mean is $overline(x) + c$. Each new deviation is
    $ (x_i + c) - (overline(x) + c) = x_i - overline(x), $
    identical to the old one. The squared deviations are therefore
    unchanged, and so is their mean. $V$ is unchanged, and so is $s$.
  + The new mean is $k dot overline(x)$, so each new deviation is
    $ k dot x_i - k dot overline(x) = k dot (x_i - overline(x)), $
    and squaring gives $k^2 dot (x_i - overline(x))^2$. Summing and
    dividing by $n$ pulls the constant out:
    $ V_"new" = k^2 dot V, quad "so" quad
      s_"new" = sqrt(k^2 dot V) = k dot s $
    for $k > 0$.
  + The conversion adds 32 --- which changes nothing --- and
    multiplies by 1.8, which scales the standard deviation:
    $ s_F = 1.8 dot 2.5 = 4.5 degree "F". $
  + Adding a constant slides the whole dataset along the axis
    without changing any distance between values, and spread is
    entirely a matter of distances. Multiplying stretches the axis
    itself, so every distance grows by the same factor and the
    measure of spread grows with it.
]

== Reading a Standard Deviation

#only-theory[
  A standard deviation of 6.1 cm is a number. Turning it into a
  statement about people requires one more idea, and it comes with a
  condition attached.

  Many measured quantities --- heights, masses, measurement errors,
  test scores across a large cohort --- produce histograms with a
  single peak, roughly symmetric, tailing away on both sides. For
  data of that shape, and only for data of that shape, the standard
  deviation has a direct reading.
]

#keybox(title: "The 68 / 95 Rule of Thumb")[
  If a distribution is approximately bell-shaped, then
  - about 68% of the data lies within one standard deviation of the
    mean, in the interval
    $[overline(x) - s, thin overline(x) + s]$;
  - about 95% lies within two standard deviations, in
    $[overline(x) - 2 s, thin overline(x) + 2 s]$.
]

#example(title: "Heights of 275 Students")[
  The heights of 275 female students form a roughly bell-shaped
  histogram with $overline(x) approx 168.4$ cm and $s approx 6.1$ cm.

  One standard deviation either side gives
  $ [168.4 - 6.1, thin 168.4 + 6.1] = [162.3, thin 174.5], $
  so about 68% of these students --- roughly 187 of the 275 --- are
  between 162.3 cm and 174.5 cm tall.

  Two standard deviations give $[156.2, thin 180.6]$, containing
  about 95% of them. Fewer than one in twenty falls outside that
  range in either direction.
]

#warning[
  The rule is worthless for data that is not bell-shaped, and
  applying it anyway is a common and confident error.

  Take Club B, with mean 35 and standard deviation about 19.85. The
  rule would predict that roughly 68% of members are aged between
  15.2 and 54.9. In fact *every one of the twelve* is either 16 or
  under, or 54 and over --- and the interval that is supposed to
  contain two thirds of the club contains almost nobody. Check the
  shape first; the rule is a consequence of the shape, not a property
  of the standard deviation.
]

=== Extension: The Bell Curve

#remark[
  Everything in this short section lies beyond what this course
  examines. It is here because the 68/95 rule looks arbitrary until
  you see where the two numbers come from, and one picture settles
  it.
]

#only-theory[
  The reason bell-shaped histograms keep appearing is that a great
  many quantities are the combined result of a large number of small,
  independent influences --- and quantities built that way tend
  toward one particular curve, whatever the influences happen to be.
  Height is the accumulation of many genetic and nutritional factors;
  measurement error is the accumulation of many small imprecisions.
  Neither was designed to be bell-shaped, and both are.

  That curve is the *normal distribution*. Drawn with the mean in the
  middle and the standard deviation as the unit along the horizontal
  axis, it looks like this:
]

#only-theory[
  #fig(
    bell-curve(),
    caption: [The normal distribution. Each band is one standard
      deviation wide, and the percentage is the share of the data
      falling in it.],
  )
]

#only-theory[
  Now the rule of thumb stops being arbitrary. The two shaded bands
  nearest the middle together hold about
  $34% + 34% = 68%$ of the data --- that is the first part of the
  rule. Adding the next band on each side gives
  $68% + 13.5% + 13.5% = 95%$, which is the second. A third standard
  deviation either way brings the total to about $99.7%$, leaving
  roughly three observations in a thousand outside
  $[mu - 3 sigma, thin mu + 3 sigma]$.

  Notice also what the picture explains about the standard deviation
  itself. It is not an arbitrary way of measuring spread: for this
  curve, $mu plus.minus sigma$ marks precisely the points where the
  curve changes from bending downward to bending outward. The
  standard deviation is built into the shape.
]

#warning[
  None of this transfers to data that is not bell-shaped, as Club B
  demonstrated a moment ago. The percentages are properties of the
  *curve*, and they apply to a dataset only to the extent that the
  dataset resembles it. Always check the histogram first.
]

#look-ahead(preview: [the normal distribution])[
  The bell shape is not a coincidence, and neither are the numbers 68
  and 95. There is a specific mathematical curve --- the normal
  distribution --- that these histograms keep approximating, and
  those percentages are areas under it. You will meet it properly in
  a later unit, together with the reason why so many unrelated
  quantities end up wearing the same shape. For now it is a rule of
  thumb; later it becomes a theorem.
]

== Doing It With a Calculator

// ── TEACHER'S NOTE ───────────────────────────────────────────
// As in ch-center, this is written at the level of NAMED MENUS
// rather than keystrokes, because the guidebook's key glyphs do not
// survive quotation and a wrong keystroke in lecture notes is worse
// than none. Please fill in the actual key labels from a device.
// The TI-Nspire CAS adaptation for SPF is still to be written; the
// concepts and the sigma-x / Sx warning transfer unchanged.

#example(title: "Five-Number Summary and $sigma x$ on the TI-30X Pro")[
  Enter the data in list L1 exactly as in the previous chapter ---
  values in L1, and frequencies in L2 with FRQ set to L2 if you are
  working from a frequency table. Choose *1-Var Stats* and scroll
  through the results.

  Everything in this chapter is there:
  - $sigma x$ --- the standard deviation as defined here, dividing by
    $n$. *This is the one to use.*
  - $S x$ --- the $n - 1$ version. Not used in this course.
  - $"minX"$, $Q_1$, $"Med"$, $Q_3$, $"maxX"$ --- the five-number
    summary, in order, ready to be drawn as a boxplot.

  Two cautions. The calculator uses its own quartile convention, so
  for odd $n$ its $Q_1$ and $Q_3$ may differ slightly from your hand
  computation --- that is the disagreement the warning earlier in
  this chapter predicted, and neither answer is wrong. And it will
  not flag outliers; the fences are yours to compute.
]

#ex(difficulty: 1, time: "15 min")[
  Enter the 24 travel times from the worked example into your
  calculator:

  #align(center, text(size: 9.5pt, raw(
    " 5  6  7  8  9 10 10 11 12 12 13 14 15 16 18 20 22 24 25 28 32 35 40 45",
  )))

  + Check that $n = 24$.
  + Read off $overline(x)$ and $sigma x$.
  + Read off the five-number summary and compare it with the values
    computed by hand earlier in this chapter.
  + Compute the fences and decide whether 45 minutes is an outlier.
    Does the answer surprise you?
][
  + $n = 24$.
  + $overline(x) approx 18.21$ minutes and $sigma x approx 10.84$
    minutes.
  + $"minX" = 5$, $Q_1 = 10$, $"Med" = 14.5$, $Q_3 = 24.5$,
    $"maxX" = 45$ --- matching the hand computation, as it must,
    since $n$ is even and the conventions agree there.
  + $"IQR" = 14.5$, so $1.5 dot "IQR" = 21.75$ and the fences sit at
    $10 - 21.75 = -11.75$ and $24.5 + 21.75 = 46.25$. Since
    $45 < 46.25$, the value 45 is *not* an outlier, and the upper
    whisker runs all the way to it.

    It is mildly surprising --- 45 minutes is nearly twice the third
    quartile and looks extreme on the dotplot. But the distribution
    is right-skewed, which makes the IQR wide, which pushes the upper
    fence far out. The rule is deliberately conservative, and on
    skewed data it flags fewer values than the eye expects.
]

#exploration(title: "Same Summary, Different Data")[
  This is the exercise the last chapter asked you to keep.

  + Construct two datasets, each of ten values, with the *same* mean
    and the *same* standard deviation, that look clearly different
    when you draw them. Draw both.
  + Now make it harder. Construct two datasets of ten values with
    the same five-number summary --- same minimum, quartiles, median
    and maximum --- that still look different. What is the largest
    difference you can hide inside an identical boxplot?
  + Which is harder to fake past, the five-number summary or the
    pair $(overline(x), s)$? Say why.
  + Finally: is there any set of summary numbers that could not be
    fooled this way? Argue for your answer.

  Part 4 has a real answer, and it is worth reaching yourself before
  the next chapter offers one.
]

#ai-box(role: "Tutor")[
  Ask an AI assistant to explain why we square the deviations when
  computing variance, rather than taking absolute values.

  Then push on the answer. Most explanations you will receive fall
  into three families: squaring "makes everything positive", squaring
  "punishes large deviations more", and squaring "is mathematically
  convenient". The first is a poor answer on its own --- absolute
  values also make everything positive, so it does not distinguish
  the two at all. Ask the assistant directly why absolute values are
  not used, and see whether it can connect the choice to the mean
  being the minimizer of squared distance.

  Write down which family the explanation belonged to, and whether
  it survived the follow-up question. An explanation that collapses
  when questioned was not an explanation.
]

#print-hints()
#print-vocab()
