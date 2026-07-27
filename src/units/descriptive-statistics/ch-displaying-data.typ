#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Displaying Data")
#let ex = exercise.with(chapter: "Displaying Data")

// ── Datasets used throughout the chapter ─────────────────────
// Defined once and referenced everywhere, so a chart, its table and
// the prose describing it cannot drift apart when the data is edited.

#let travel-times = (
  5,
  12,
  8,
  25,
  15,
  10,
  32,
  7,
  18,
  22,
  9,
  14,
  40,
  11,
  6,
  20,
  13,
  28,
  16,
  10,
  35,
  12,
  24,
  45,
)

#let siblings = (
  1,
  2,
  0,
  1,
  3,
  1,
  2,
  1,
  0,
  2,
  1,
  4,
  2,
  1,
  1,
  0,
  3,
  2,
  1,
  2,
  1,
  0,
  2,
  1,
)

#let club-ages = (
  23,
  25,
  27,
  31,
  34,
  34,
  36,
  38,
  41,
  42,
  42,
  45,
  47,
  48,
  51,
  52,
  52,
  55,
  56,
  58,
  61,
  62,
  63,
  65,
  66,
  68,
  71,
  73,
  74,
  79,
)

= Displaying Data

#only-theory[
  A list of numbers tells you almost nothing. Twenty-four travel times
  written out in a row is not information you can hold in your head;
  it is raw material. The moment you arrange those numbers into a
  table or a picture, patterns appear that were sitting in the data
  all along, invisible.

  That is the promise of this chapter. The warning is that the same
  operation works in reverse: a chart can hide a pattern just as
  easily as it reveals one, and it can suggest a pattern that is not
  there at all. Learning to build these displays and learning to
  distrust them are the same skill, practiced from two directions.
]

#objectives(
  bfkm[organize raw data into a frequency table, using absolute,
    relative, and cumulative frequencies],
  bfkm[display empirical data in a variety of forms --- bar chart,
    histogram, dotplot, stem-and-leaf plot --- and choose the form
    that suits the data],
  [explain why a bar chart and a histogram are not interchangeable,
    and decide which a given variable requires],
  [choose a sensible number of classes for a histogram, and describe
    what is lost when there are too few or too many],
  bfkm[analyze and judge a graphical representation: read values from
    it, state what it does not show, and identify how it misleads],
  [describe the shape of a distribution using symmetry, skew,
    modality, and outliers],
)

== From Raw Data to a Frequency Table

#only-theory[
  Here are the times, in minutes, that 24 students in one class need
  to get to school:
]

#only-theory[
  #fig(
    align(center, text(size: 9.5pt, raw(
      "5  12   8  25  15  10  32   7  18  22   9  14\n"
        + "40  11   6  20  13  28  16  10  35  12  24  45",
    ))),
    caption: [Raw data: 24 travel times in minutes.],
  )
]

#only-theory[
  Nothing about this list is wrong, and nothing about it is useful.
  You cannot see the typical time, whether the values cluster, or
  whether anybody is unusual. The first step is always to count.
]

#definition(title: "Frequency")[
  Given a set of #vocab("raw data", "Rohdaten"), the
  #vocab("absolute frequency", "absolute Häufigkeit") $H(a)$ of a
  value $a$ is the number of times $a$ occurs.

  The #vocab("relative frequency", "relative Häufigkeit") $h(a)$ is
  that count as a proportion of the total:
  $ h(a) = H(a) / n $
  usually written as a percentage. Relative frequencies always sum
  to 1, or to 100%.

  The #vocab("cumulative frequency", "kumulierte Häufigkeit") at $a$
  is the number (or proportion) of observations less than or equal
  to $a$. It answers "how many are at most this?" in one reading.

  A table listing these together is a
  #vocab("frequency table", "Häufigkeitstabelle").
]

#example(title: "Siblings in One Class")[
  The 24 students were also asked how many siblings they have:

  #align(center, text(
    size: 9.5pt,
    raw(
      "1 2 0 1 3 1 2 1 0 2 1 4 2 1 1 0 3 2 1 2 1 0 2 1",
    ),
  ))

  Counting each value gives the frequency table:

  #data-table(
    columns: (auto, auto, auto, auto, auto),
    row-height: auto,
    [Siblings $a$],
    [$H(a)$],
    [$h(a)$],
    [cumulative $H$],
    [cumulative $h$],

    [0],
    [4],
    [16.7%],
    [4],
    [16.7%],
    [1],
    [10],
    [41.7%],
    [14],
    [58.3%],
    [2],
    [7],
    [29.2%],
    [21],
    [87.5%],
    [3],
    [2],
    [8.3%],
    [23],
    [95.8%],
    [4],
    [1],
    [4.2%],
    [24],
    [100.0%],
    [*Total*],
    [*24*],
    [*100%*],
    [---],
    [---],
  )

  Three readings the raw list could not give you: the most common
  answer is one sibling; more than half the class (58.3%) has at most
  one; and exactly one student has four.

  Note the check built into the table --- the absolute frequencies
  must sum to $n = 24$, and the relative frequencies to 100%. If they
  do not, you have miscounted, and you find out immediately rather
  than three steps later.
]

#warning[
  Rounded percentages need not add to exactly 100%. Here they happen
  to, but $1/3$ three times over gives $33.3% + 33.3% + 33.3% =
  99.9%$. That is a rounding artifact, not an error --- say so in a
  footnote rather than silently adjusting one of the numbers to make
  the column look tidy.
]

#ex(difficulty: 1, time: "10 min")[
  A shop records how many customers arrive in each of 20 ten-minute
  periods:

  #align(center, text(
    size: 9.5pt,
    raw(
      "3 5 4 3 6 5 4 4 3 7 5 4 6 3 5 4 5 4 6 4",
    ),
  ))

  Build a frequency table with columns for $H$, $h$, and cumulative
  $H$. Check that your columns sum correctly.
][
  #data-table(
    columns: (auto, auto, auto, auto),
    row-height: auto,
    [Customers $a$],
    [$H(a)$],
    [$h(a)$],
    [cumulative $H$],
    [3],
    [4],
    [20%],
    [4],
    [4],
    [7],
    [35%],
    [11],
    [5],
    [5],
    [25%],
    [16],
    [6],
    [3],
    [15%],
    [19],
    [7],
    [1],
    [5%],
    [20],
    [*Total*],
    [*20*],
    [*100%*],
    [---],
  )

  Both checks pass: $4 + 7 + 5 + 3 + 1 = 20 = n$, and the relative
  frequencies sum to 100%.
]

#ex(difficulty: 2, time: "10 min")[
  Using the siblings table in the example above, answer without
  recounting the raw data:
  #auto-parts(
    1,
    [What proportion of the class has at least two siblings?],
    [What proportion has fewer than three?],
    [A student claims "most of the class is an only child." Use the
      table to respond.],
  )
][
  #auto-parts(
    1,
    [At least two means $2, 3$, or $4$: $7 + 2 + 1 = 10$ students,
      which is $10/24 approx 41.7%$. Equivalently, $100% -
      58.3% = 41.7%$ read straight off the cumulative column.],
    [Fewer than three is the cumulative frequency at $a = 2$, namely
      $21$ students or $87.5%$.],
    [False, and the table says so directly: only 4 students out of
      24 have no siblings, which is $16.7%$ --- far from most. The
      most common answer is one sibling (10 students), which is
      probably what was misremembered.],
  )
]

== Bar Charts and Histograms

#only-theory[
  These two look similar enough that they are constantly confused,
  and the difference is not cosmetic. It tells the reader what kind
  of variable they are looking at.
]

#definition(title: "Bar Chart and Histogram")[
  A #vocab("bar chart", "Säulendiagramm") displays a *categorical*
  variable. One bar per category, and the bars are drawn with *gaps*
  between them, because there is nothing between the categories. The
  order of the bars is your choice --- alphabetical, by size, or
  whatever makes the chart readable.

  A #vocab("histogram", "Histogramm") displays a *numerical*
  variable. The number line is divided into
  #vocab("classes", "Klassen") --- also called bins --- and the bars
  *touch*, because the classes are adjacent stretches of a continuous
  scale. The order is fixed: it is the order of the number line.
]

#only-theory[
  Compare the two. On the left, electricity generation in Switzerland
  by renewable source: the categories are names, and no arrangement
  of them is more correct than another. On the right, the travel
  times from the start of the chapter: the horizontal axis is
  minutes, and moving right along it means something.
]

#only-theory[
  #image-grid(
    2,
    fig(
      bar-chart(
        ("Hydro", 29.1),
        ("Solar", 1.2),
        ("Waste", 1.2),
        ("Biomass", 0.3),
        ("Wind", 0.1),
        width: 5.6cm,
        height: 4cm,
        y-label: [bn. kWh],
      ),
      caption: [Bar chart --- categories, with gaps.],
    ),
    fig(
      histogram(
        travel-times,
        bin-width: 10,
        start: 0,
        width: 5.6cm,
        height: 4cm,
        x-label: [minutes],
      ),
      caption: [Histogram --- a number line, bars touching.],
    ),
  )
]

#warning[
  The gap is not decoration. A histogram drawn with gaps tells the
  reader that the horizontal axis is categorical, which is a false
  statement about the data. A bar chart drawn without gaps claims
  that "Hydro" and "Solar" are adjacent stretches of some scale, and
  that there is something in between them. Neither claim is one you
  want to make by accident.
]

#remark[
  There is a further difference that matters once classes stop being
  equally wide: in a true histogram the *area* of each bar, not its
  height, is proportional to the frequency. With equal class widths
  the two amount to the same thing, which is why equal widths are
  the sane default and the only case treated here. If you ever meet
  a histogram with unequal classes, check which convention its
  author used before reading anything off it.
]

#ex(difficulty: 1, time: "10 min")[
  For each variable, state whether a bar chart or a histogram is the
  correct display, and give your reason in one sentence.
  #auto-parts(
    2,
    [The canton of residence of each student],
    [The mass of each apple in a crate],
    [The favorite sport of each club member],
    [The duration of each phone call at a call center],
    [The number of goals scored in each match],
    [The eye color of each participant],
  )
][
  #auto-parts(
    2,
    [Bar chart --- canton is nominal, so there is nothing between
      the categories.],
    [Histogram --- mass is continuous, and the classes are adjacent
      intervals.],
    [Bar chart --- favorite sport is nominal.],
    [Histogram --- duration is continuous.],
    [Either can be defended. Goals are discrete, so a bar chart with
      one bar per value $0, 1, 2, dots$ is honest and usual for a
      small range; a histogram is appropriate once the range is wide
      enough that individual values need grouping.],
    [Bar chart --- eye color is nominal.],
  )
]

== Choosing the Classes

#only-theory[
  Building a histogram forces a decision the data does not make for
  you: how many classes? The choice is not neutral. Too few and the
  shape is flattened into a couple of blocks. Too many and every
  bar is one or two observations, so what you see is the accident of
  this particular sample rather than the pattern behind it.
]

#keybox(title: "How Many Classes?")[
  A common rule of thumb is
  $ k approx sqrt(n) $
  classes for $n$ observations. For $n = 24$ that gives
  $sqrt(24) approx 4.9$, so about 5 classes.

  Treat it as a starting point, not a law. Two adjustments are almost
  always worth making:
  - Round the class boundaries to human numbers. Classes of width 10
    starting at 0 are far easier to read than classes of width 8
    starting at 5, even if the rule suggested the latter.
  - Look at the result. If the shape changes completely when you try
    a neighboring value of $k$, that instability is itself worth
    knowing, and you should say so rather than picking whichever
    version tells the nicer story.
]

#only-theory[
  The same 24 travel times, three times over. Only the number of
  classes changes.
]

#only-theory[
  #fig(
    histogram(travel-times, bins: 2, width: 10cm, height: 2.9cm),
    caption: [Two classes. Almost everything is lost --- this says
      only "more short journeys than long ones."],
  )
  #v(0.3em)
  #fig(
    histogram(travel-times, width: 10cm, height: 2.9cm),
    caption: [Five classes, the $sqrt(n)$ default. A clear peak at
      the short end and a tail stretching right.],
  )
  #v(0.3em)
  #fig(
    histogram(travel-times, bins: 15, width: 10cm, height: 2.9cm),
    caption: [Fifteen classes. Now the eye sees spikes and gaps that
      are nothing but the roughness of a 24-value sample.],
  )
]

#only-theory[
  The middle picture is the honest one, and notice what it shows that
  the raw list did not: most students live close to school, a few
  live much further, and the distribution is not symmetric. That
  asymmetry is a real feature of the data, and the next section gives
  it a name.
]

#ex(difficulty: 2, time: "15 min")[
  A biologist measures the length in centimeters of 36 fish:
  the shortest is 8 cm and the longest is 44 cm.
  + How many classes does the $sqrt(n)$ rule suggest?
  + That suggestion gives an awkward class width. Propose a width
    and a starting value that a reader could actually work with, and
    say how many classes result.
  + The biologist tries your version and a version with 18 classes.
    The 18-class histogram has several empty classes. Is that a
    reason to prefer your version? Give a reason on each side.
][
  + $sqrt(36) = 6$ classes. The range is $44 - 8 = 36$ cm, so the
    implied width is $36/6 = 6$ cm.
  + Width $6$ starting at $8$ gives boundaries $8, 14, 20, dots$ ---
    arithmetically fine but unpleasant to read. A width of $5$
    starting at $5$ gives $5, 10, 15, dots, 45$: eight classes with
    boundaries anyone can read off instantly. Slightly more classes
    than the rule suggested, which is a fair trade.
  + For your version: with 36 observations spread over 18 classes,
    the average class holds two fish, so empty classes and spikes
    mostly reflect sampling roughness rather than real structure.
    Against: an empty class can be genuine and important --- if the
    gap sits in the middle of the range it may indicate two distinct
    populations (two species, or juveniles and adults), and the
    coarser histogram would conceal exactly that. The honest move is
    to look at both and say which features survive.
]

== Dotplots and Stem-and-Leaf Plots

#only-theory[
  Both of these keep every individual observation visible, which
  makes them well suited to small datasets --- and a useful check on
  whatever a histogram of the same data appears to show.
]

#definition(title: "Dotplot")[
  A #vocab("dotplot", "Punktdiagramm") places one dot per
  observation above its value on a number line, stacking dots when a
  value repeats. Nothing is grouped and nothing is rounded, so no
  choice of class can distort the picture.
]

#only-theory[
  #fig(
    dotplot(travel-times, width: 10cm, x-label: [minutes]),
    caption: [The 24 travel times, one dot each. The crowding on the
      left and the isolated values on the right are the same
      features the five-class histogram showed --- here with nothing
      hidden.],
  )
]

#definition(title: "Stem-and-Leaf Plot")[
  A #vocab("stem-and-leaf plot", "Stängel-Blatt-Diagramm") splits
  each value into a *stem* (the leading digits) and a *leaf* (the
  final digit). Stems are listed down the left, and each observation
  contributes one leaf to its stem's row.

  It is the only display that shows the shape of the distribution and
  preserves every original value at the same time --- the data can be
  read straight back out of it.
]

#example(title: "Ages in a Hiking Club")[
  The ages of the 30 members of a hiking club:

  #align(center, text(size: 9.5pt, raw(
    "23 25 27 31 34 34 36 38 41 42 42 45 47 48 51\n"
      + "52 52 55 56 58 61 62 63 65 66 68 71 73 74 79",
  )))

  Taking the tens digit as the stem:

  #align(center, text(size: 10pt, raw(
    "2 | 3 5 7\n"
      + "3 | 1 4 4 6 8\n"
      + "4 | 1 2 2 5 7 8\n"
      + "5 | 1 2 2 5 6 8\n"
      + "6 | 1 2 3 5 6 8\n"
      + "7 | 1 3 4 9\n"
      + "\n"
      + "key:  4 | 7  means 47 years",
  )))

  Turn the page ninety degrees and the row lengths are a histogram
  with classes of width 10. But unlike a histogram, this one still
  contains the data: the youngest member is 23 and the oldest 79, and
  you can recover every age in between.

  A key is not optional. Without it, `4 | 7` might mean 47, or 4.7,
  or 470.
]

#ex(difficulty: 1, time: "10 min")[
  The masses in grams of 15 letters:

  #align(center, text(
    size: 9.5pt,
    raw(
      "24 31 18 45 27 33 22 39 28 41 19 35 26 30 44",
    ),
  ))

  + Draw a stem-and-leaf plot using the tens digit as the stem, and
    include a key.
  + Read the smallest and largest values back off your plot.
][
  + #align(center, text(size: 10pt, raw(
      "1 | 8 9\n"
        + "2 | 2 4 6 7 8\n"
        + "3 | 0 1 3 5 9\n"
        + "4 | 1 4 5\n"
        + "\n"
        + "key:  3 | 5  means 35 g",
    )))
    Leaves within each row are written in increasing order.
  + Smallest $18$ g, largest $45$ g --- read directly off the first
    and last leaves, which a histogram would not permit.
]

#ex(difficulty: 2, time: "15 min")[
  A dotplot and a histogram are drawn from the same 20 measurements.
  The histogram shows a smooth single peak. The dotplot shows the
  same peak, but also that every observation is an exact multiple
  of 5.
  + What does the histogram fail to reveal, and why?
  + What might explain a dataset in which every value is a multiple
    of 5?
  + Which display would you include in a report, and what would you
    write in the caption?
][
  + The multiples of 5. Classes several units wide absorb the
    individual values, so the pattern of *which* values occur
    disappears into the totals. The histogram shows the distribution
    of the measurements but not their granularity.
  + Almost certainly rounding at the point of recording --- someone
    estimating to the nearest 5, or reading an instrument with 5-unit
    markings, or respondents reporting a remembered figure. It says
    something about the measurement process rather than about the
    quantity being measured, and it caps the precision of anything
    computed from the data.
  + The dotplot, precisely because it surfaces the rounding. A
    caption should state it rather than leave the reader to notice:
    something like "all values recorded to the nearest 5 units;
    apparent precision beyond that is not present in the data."
]

== The Shape of a Distribution

#only-theory[
  Once a distribution is drawn, it can be described in words --- and
  a small vocabulary covers most of what is worth saying. This is not
  terminology for its own sake: the shape decides which summary
  numbers will behave sensibly, which is the whole subject of the
  next chapter.
]

#definition(title: "Describing a Distribution")[
  / Symmetry: a #vocab("distribution", "Verteilung") is
    #vocab("symmetric", "symmetrisch") if the left and right halves
    are near mirror images. It is
    #vocab("right-skewed", "rechtsschief") if the tail stretches to
    the right --- a pile of small values with a few large ones ---
    and *left-skewed* if the tail stretches left.
  / Modality: #vocab("unimodal", "eingipflig") means one clear peak;
    #vocab("bimodal", "zweigipflig") means two. A distribution with
    no peak at all is *uniform*.
  / Outliers: an #vocab("outlier", "Ausreisser") is an observation
    lying far from the rest. The next chapter makes this precise; for
    now, notice them and ask where they came from.
  / Gaps and clusters: a stretch of the range with no observations,
    or observations bunched into separate groups, is worth reporting.
    It often means two populations have been mixed together.
]

#only-theory[
  The travel-time distribution is right-skewed: most students are
  close to school and a few are far, so the tail runs to the right.
  This is the usual shape for anything bounded below by zero and
  unbounded above --- waiting times, incomes, house prices, file
  sizes.

  A bimodal distribution is the one most worth spotting, because it
  usually means the data should not have been pooled in the first
  place. Two peaks in the heights of a mixed group are two groups.
  Two peaks in arrival times at a station are two train timetables.
  The right response is rarely to summarize the mixture; it is to
  split it.
]

#look-ahead(preview: [the mean, the median, and measures of spread])[
  Shape is about to become a practical matter rather than a
  descriptive one. In the next chapter you will meet two competing
  notions of "typical", and the whole question of which to use turns
  on precisely what you have just learned to see: for a symmetric
  distribution they agree, and for a skewed one they can differ
  enough to reverse the conclusion of an argument.
]

#ex(difficulty: 2, time: "15 min")[
  For each dataset, predict the shape --- symmetry or skew, modality,
  likely outliers --- and justify the prediction. You are not
  expected to have the data; reason from what you know about the
  quantity.
  #auto-parts(
    1,
    [The annual incomes of everyone living in a Swiss commune],
    [The heights of all students in a Gymnasium],
    [The scores on a test that most students found easy],
    [The times at which customers enter a restaurant, over one day],
    [The results of rolling a fair die 600 times],
  )
][
  #auto-parts(
    1,
    [Strongly right-skewed. Incomes are bounded below, most cluster
      in a moderate band, and a small number are very large. Extreme
      high outliers are expected and are genuine data, not errors.],
    [Approximately symmetric, and plausibly slightly bimodal if
      recorded across a wide age range or if male and female heights
      are pooled --- two overlapping groups rather than one.],
    [Left-skewed. Most scores pile up near the maximum, with a tail
      of lower scores stretching left. The ceiling of the test
      prevents a right tail from existing.],
    [Bimodal --- a lunch peak and a dinner peak, with a quiet
      afternoon between them. Summarizing with a single "average
      arrival time" would land in the middle of the afternoon lull,
      when almost nobody arrives.],
    [Approximately uniform: six values, each expected about 100
      times. Deviations from flatness are sampling variation, not
      structure --- and expecting perfect flatness is itself a
      mistake.],
  )
]

== Reading a Graph

#only-theory[
  Reading a chart is a skill, and like most skills it is usually
  assumed rather than taught. Most people look at the picture and
  form an impression. The impression is what the designer chose to
  produce; whether it matches the data is a separate question, and
  answering it takes a deliberate procedure.
]

#keybox(title: "Six Things to Read Before the Picture")[
  + *The axes.* What quantity is on each, and in what units? Percent
    or count? Per year or cumulative?
  + *The vertical scale.* Where does it start? A vertical axis that
    does not begin at zero changes every visual comparison on the
    chart.
  + *The sample.* How many observations, over what period, from
    where? A chart with no $n$ is a chart withholding evidence.
  + *The source and date.* Who produced it and when? Data three
    years stale can be perfectly honest and completely irrelevant.
  + *What is absent.* Which categories, years, or groups are not
    shown? An omitted category is invisible by construction.
  + *The question it was built to answer.* Charts are made by people
    with purposes. Naming the purpose tells you where to look
    hardest.
]

#only-theory[
  Only then look at the picture. In that order, the shape is
  something you interpret rather than something that happens to you.
]

#ex(difficulty: 2, time: "15 min")[
  #bar-chart(
    ("Hydro", 29.1),
    ("Solar", 1.2),
    ("Waste", 1.2),
    ("Biomass", 0.3),
    ("Wind", 0.1),
    width: 9cm,
    height: 4.2cm,
    show-values: true,
    y-label: [bn. kWh],
  )

  The chart shows Swiss electricity generation from renewable
  sources in 2016 (Source: Swiss Federal Office of Energy).
  + Roughly what fraction of the renewable total comes from
    hydropower?
  + A newspaper headline reads "Solar overtakes wind twelvefold in
    Swiss energy." Is the claim supported? Is it informative?
  + Name two things this chart does not tell you about Swiss
    electricity.
][
  + The total is $29.1 + 1.2 + 1.2 + 0.3 + 0.1 = 31.9$ bn. kWh, and
    $29.1/31.9 approx 0.91$ --- about 91%, or nine tenths.
  + Supported but close to meaningless. $1.2/0.1 = 12$, so the
    arithmetic holds; but both quantities are tiny beside
    hydropower, and a ratio between two small numbers sounds
    dramatic while describing very little. Roughly 4% of the
    renewable total against roughly 0.3% is the honest phrasing.
  + Several possibilities: it shows only *renewable* sources, so
    nuclear and imported electricity --- a large share of Swiss
    supply --- are absent entirely; it is a single year, so no trend
    is visible; it shows generation, not consumption; and it gives
    no indication of seasonal variation, which is substantial for
    both hydro and solar.
]

== When a Graph Misleads

#only-theory[
  Almost every misleading chart you will meet is drawn from accurate
  data. That is what makes the topic worth a section: the deception
  does not require anybody to lie about a number. It requires a
  formatting decision, each of which has a respectable-sounding
  defense.
]

=== Truncating the Vertical Axis

#only-theory[
  Four schools sit a common test. Their mean scores are 306, 305,
  300, and 302 out of a possible 400 --- a spread of six points,
  about 2%. Here is that data twice. The numbers are identical; the
  only difference is where the vertical axis begins.
]

#only-theory[
  #image-grid(
    2,
    fig(
      bar-chart(
        ("Bernoulli", 306),
        ("Burckhardt", 305),
        ("Fibonacci", 300),
        ("Euler", 302),
        width: 5.4cm,
        height: 4cm,
        y-label: [points],
      ),
      caption: [Axis from 0. Four schools performing almost
        identically.],
    ),
    fig(
      bar-chart(
        ("Bernoulli", 306),
        ("Burckhardt", 305),
        ("Fibonacci", 300),
        ("Euler", 302),
        ymin: 299,
        width: 5.4cm,
        height: 4cm,
        y-label: [points],
      ),
      caption: [Axis from 299. "Best school twice as good as
        weakest."],
    ),
  )
]

#only-theory[
  Measure the bars on the right. Bernoulli's stands seven times the
  height of Fibonacci's, so the picture asserts a seven-to-one ratio
  where the data holds a two per cent difference. Nothing has been
  falsified; a number was changed from 0 to 299.

  And there is a genuine defense for doing it. If all your values lie
  between 299 and 306, an axis starting at zero wastes most of the
  chart on empty space and hides real variation. The rule is
  therefore not "never truncate" --- it is that a truncated axis must
  be conspicuous, and that bars in particular resist truncation,
  because a bar's *length* is what the reader compares. Lines
  tolerate it far better, since a line chart asks you to look at the
  slope.
]

=== Manipulating the Classes

#only-theory[
  The previous section presented class width as a question of
  honesty. It is also a lever. Given a distribution with an
  inconvenient feature --- a gap, a second peak, a cluster of extreme
  values --- there is very often a choice of classes that smooths it
  away, and another that exaggerates it. Both are defensible one at a
  time. Trying several and publishing the most persuasive is not.
]

=== Area Where Length Was Meant

#only-theory[
  A pictogram replaces bars with pictures --- a stack of coins for
  money, a little figure for population. To show a doubling, the
  designer doubles the picture's height. But the picture also gets
  twice as wide, so it covers *four times* the area, and area is what
  the eye responds to.
]

#only-theory[
  #fig(
    align(center, stack(
      dir: ltr,
      spacing: 2cm,
      align(bottom, rect(width: 0.9cm, height: 0.9cm, fill: accent)),
      align(bottom, rect(width: 1.8cm, height: 1.8cm, fill: accent)),
    )),
    caption: [The right square is twice as tall, representing a
      doubling. It covers four times the area, and looks it.],
  )
]

// ── IMAGE (recommended) ──────────────────────────────────────
// A real pictogram from advertising or a newspaper -- the moneybag
// or human-figure kind, scaled in both dimensions. Worth having
// alongside the abstract squares above, because students accept the
// geometric point immediately and still fail to notice the effect in
// the wild, where the picture is charming and the distortion reads
// as design rather than as argument.
// Suggested file: images/pictogram-area-distortion.png
// #only-theory[#fig(
//   image("images/pictogram-area-distortion.png", width: 65%),
//   caption: [A doubling drawn as a quadrupling.],
// )]

=== Three Other Habits Worth Distrusting

#only-theory[
  / Pie charts: the human eye compares angles poorly, so a pie chart
    is a weak way to compare shares --- and a hopeless one once
    there are more than about five slices, or two slices are close
    in size. A bar chart of the same numbers is almost always
    clearer. Tilting the pie into a 3-D perspective is worse still,
    since the slices at the front are drawn larger than the slices at
    the back regardless of their values.
  / Dual axes: two lines on one chart with different vertical scales
    on the left and right. The two scales can be chosen to make the
    lines cross wherever the designer prefers, which manufactures a
    relationship out of nothing. If you see two axes, check what
    happens to the story when you rescale one of them.
  / Cherry-picked windows: showing 2019 to 2022 rather than 2010 to
    2024 turns a fluctuation into a trend, or a trend into noise. Ask
    why *this* window, and what the neighboring years would add.
]

#keybox(title: "Questions for Any Chart You Are Judging")[
  + Does the vertical axis start at zero? If not, is the truncation
    obvious, and are the marks bars or lines?
  + Are the classes or categories equally wide, and would a
    different choice change the story?
  + Is anything scaled in two dimensions to represent one quantity?
  + Are there two vertical axes?
  + Is the horizontal axis in the order the reader will assume?
  + Why does the time window begin and end where it does?
  + Is $n$ stated, and is a source given?
]

=== Four Cases Worth Studying

#only-theory[
  The checklist above is abstract until it meets something real.
  Each of the following actually happened, each was published by an
  organization with a reputation to protect, and in each case the
  underlying numbers were correct.
]

// ─────────────────────────────────────────────────────────────
// TEACHER'S NOTE ON THE FOUR CASES BELOW
//
// The student text describes each chart in enough detail to work
// WITHOUT the image, so the section is usable as it stands. The
// images make it far better -- these are charts that have to be seen
// to land -- but they have to be sourced by hand, so each one gets a
// recommendation block with what to search for and where the
// reporting is.
//
// On rights: Swiss law does not have US-style "fair use". What it
// has is URG Art. 19(1)(b), which permits a teacher to use a
// published work for instruction in the classroom, and Art. 25,
// which permits quotation for commentary where the quotation is
// justified by its purpose and the source is named. Classroom
// distribution of an annotated chart you are analyzing sits
// comfortably inside both. Publishing the same PDF on a public
// website is a different act with a different answer. Caption every
// image with its creator and date regardless -- Art. 25 requires the
// attribution, and a chapter about checking sources should model it.
// I am not a lawyer; if this is ever going online, it is worth ten
// minutes with someone who is.
// ─────────────────────────────────────────────────────────────

#example(title: "Case 1 --- Time Runs Backwards (Georgia, 2020)")[
  In May 2020 the Georgia Department of Public Health published a bar
  chart of confirmed COVID-19 cases in the five worst-affected
  counties. The bars descended steadily from left to right: a clear,
  reassuring decline over two weeks, published while the state was
  deciding how quickly to reopen.

  The dates along the horizontal axis ran April 28, April 27, April
  29, May 1, April 30, May 4, May 6, May 5, May 2, May 7, April 26,
  May 3, May 8, May 9. Not chronological --- sorted by case count,
  highest on the left. The counties also swapped positions from day
  to day, so no county's bars could be followed across the chart
  either.

  The decline was an artifact of the sorting. There had been no
  clear downward trend. The chart was withdrawn and the governor's
  office apologized, explaining that the axis had been arranged
  "to show descending values"; a state representative said she had
  difficulty understanding how it could have happened
  unintentionally.

  What makes this the most instructive case in the section: no
  number was wrong. The deception lives entirely in the *order* of
  the horizontal axis --- a place almost nobody thinks to look,
  because time is assumed.
]

// ── IMAGE (recommended) ──────────────────────────────────────
// The original Georgia DPH chart, pre-correction. Reproduced in the
// Columbia Law School climate/science-deregulation tracker entry
// "COVID-19 Data Misrepresented by Georgia Health Department", and
// in the Atlanta Journal-Constitution and Vox reporting from
// 2020-05-13 onward. Search: "Georgia DPH top 5 counties chart May
// 2020". Show it BEFORE telling students what is wrong -- almost
// nobody spots it unaided, which is the lesson.
// Suggested file: images/georgia-covid-axis-order.png
// #only-theory[#fig(
//   image("images/georgia-covid-axis-order.png", width: 85%),
//   caption: [Georgia Department of Public Health, May 2020.
//     Withdrawn after the axis order was noticed.],
// )]

#example(title: "Case 2 --- Down Means Up (Reuters, 2014)")[
  In February 2014 Reuters published a chart of firearm murders in
  Florida from 1990 to 2012, marking the year the state's "Stand
  Your Ground" law took effect. The line climbs to a peak, then
  plunges. Almost every reader took away the same message: deaths
  fell sharply after the law.

  Deaths rose sharply. The vertical axis was inverted --- zero at the
  top, increasing downward --- so a falling line meant more deaths.
  The designer, Christine Chan, said she preferred to show deaths
  "in negative terms" and had taken the idea from a graphic on Iraq
  war casualties styled to look like running blood.

  This case is worth more than the others precisely because nobody
  was lying. The Reuters article accompanying the chart stated
  correctly that deaths had increased. The intent was artistic. It
  did not matter: the picture overrode the text, and readers left
  with the opposite of the truth.
]

// ── IMAGE (recommended) ──────────────────────────────────────
// The Reuters "Gun deaths in Florida" chart by Christine Chan, Feb
// 2014. Widely reproduced with commentary -- Sociological Images
// ("How to Lie with Statistics: Stand Your Ground and Gun Deaths",
// 2014-12-28) prints the original beside a corrected version, which
// is the ideal pairing for teaching. Business Insider also published
// a flipped correction. Search: "gun deaths in Florida Reuters
// inverted axis".
// Suggested file: images/florida-gun-deaths-inverted-axis.png
// Even better: images/florida-gun-deaths-pair.png -- original and
// corrected side by side, revealed one at a time.
// #only-theory[#fig(
//   image("images/florida-gun-deaths-inverted-axis.png", width: 70%),
//   caption: [Reuters, February 2014. The vertical axis runs from 0
//     at the top downward, so the plunge is a rise.],
// )]

#example(title: "Case 3 --- Two Scales, No Axis (US Congress, 2015)")[
  In a 2015 congressional hearing, a chart was projected showing two
  quantities provided by one organization over the years 2006 to
  2013: one line falling, one line rising, crossing dramatically in
  the middle, with large arrows emphasizing the crossing.

  The chart had no labeled vertical axis at all. The two quantities
  were plotted on different, unstated scales --- one in the millions,
  the other in the hundreds of thousands. Small printed numbers on
  the chart contradicted the picture: at the crossing point, the two
  lines were nowhere near equal. The fact-checking organization
  PolitiFact rated it "Pants on Fire", and the visualization
  researcher Alberto Cairo, asked to assess it, called the graphic a
  lie regardless of one's views on the underlying issue.

  Set the politics aside entirely --- what matters here is the
  technique, and it is the dual-axis trick from the previous section
  taken to its limit. When two scales are unstated, the designer
  chooses where the lines cross. The crossing is a decision, not a
  finding.
]

// ── IMAGE (recommended) ──────────────────────────────────────
// The chart is reproduced in the PolitiFact fact-check of
// 2015-10-01 ("Chart shown at Planned Parenthood hearing is
// misleading and 'ethically wrong'") and in the Boston Globe's
// "most misleading chart of 2015" piece, which also prints a
// corrected version.
//
// JUDGMENT CALL FOR YOU: the underlying subject is abortion. The
// graphical point is excellent and completely separable from the
// topic, and the text above is written to keep it separable -- but a
// politically charged example can hijack the lesson, and you know
// the room. If you would rather not, the same dual-axis technique
// appears in countless business and climate charts; the Chaffetz
// case is simply the most thoroughly documented instance.
// Suggested file: images/dual-axis-no-labels.png
// #only-theory[#fig(
//   image("images/dual-axis-no-labels.png", width: 70%),
//   caption: [Two quantities, two unstated scales, no vertical axis.],
// )]

#example(title: "Case 4 --- The One in Your Pocket")[
  The fourth case is not historical. Open any shopping app and look
  at a product's star rating, or any newspaper's live election
  coverage, or the "screen time" summary on your phone.

  Ask the six questions. What is the vertical axis? Where does it
  start? How many observations? Compared with what? What is not
  shown?

  Most of these displays are fine. Some are not, and the ones that
  are not were designed by people with a commercial interest in the
  impression they produce. The habit of asking is worth more than
  any list of historical scandals, because this is the category you
  will actually meet every day.
]

#ex(difficulty: 2, time: "15 min", keep-together: true)[
  Consider Case 1, the Georgia chart, in which the dates on the
  horizontal axis were sorted by case count rather than by date.
  + The official explanation was that the axis was arranged "to show
    descending values" so that peak values were easier to see. Is
    there any legitimate chart for which sorting the horizontal axis
    by size is the right choice? Give an example.
  + Explain why that justification fails for this particular chart.
  + The chart was published while decisions about reopening were
    being made. Does the context change how serious the error is, or
    only how consequential? Argue both sides briefly.
][
  + Yes --- for a *categorical* horizontal axis, sorting bars by size
    is often the best possible choice. A bar chart of cases by
    canton, sorted from most to fewest, is easier to read than one
    in alphabetical order, and nothing is lost, because the cantons
    have no natural order to destroy.
  + Because dates are not categories. Time has its own order, and
    the reader relies on it without checking --- that is exactly why
    the chart worked as it did. Re-sorting a time axis does not
    merely reorganize the display; it destroys the only feature the
    reader is trying to see, namely the trend, and then replaces it
    with an artificial one running from high to low by construction.
  + *Only consequential:* the graphical error is the same error
    whether the subject is a pandemic or a cake sale, and it should
    be judged as a chart. *More serious:* the duty of care attached
    to a piece of work scales with what depends on it, and a public
    health agency publishing during a reopening decision is not in
    the same position as a student mislabeling a homework graph.
    Both positions are defensible; a good answer commits to one and
    acknowledges the force of the other.
]

#ex(difficulty: 2, time: "15 min")[
  A company's annual profit, in millions of francs, over five years:

  #align(center, text(
    size: 9.5pt,
    raw(
      "2020: 4.1    2021: 4.3    2022: 4.2    2023: 4.4    2024: 4.5",
    ),
  ))

  + Describe how you would draw a bar chart to make the growth look
    dramatic. Be specific about the numbers you would choose.
  + Describe how you would draw one to make the profits look
    completely flat.
  + Both charts show the same data. What single sentence would you
    put beneath the honest version so a reader cannot be misled by
    either?
][
  + Start the vertical axis just below the smallest value --- at
    $4.0$, say --- so the 2020 bar is barely visible and the 2024
    bar towers over it. The visible bar heights would then stand in
    ratio $0.1 : 0.3 : 0.2 : 0.4 : 0.5$, making 2024 five times
    2020, from a real increase of about 10%.
  + Start at zero and extend the axis far above the data --- to 20,
    say. All five bars then reach roughly the same height near the
    bottom of the chart, and the variation is invisible.
  + Something that states the actual magnitude, so neither picture
    can do the reader's thinking: "Profit rose from CHF 4.1 m to
    CHF 4.5 m between 2020 and 2024, an increase of about 10%."
]

#ex(difficulty: 2, time: "15 min", keep-together: true)[
  A magazine prints a chart claiming that a town's population has
  "exploded". The vertical axis runs from #num(9800) to #num(10200),
  and the horizontal axis shows the years 2021 to 2023. The
  population figures are #num(9850), #num(9950), and #num(10100).
  + By what percentage did the population actually change over the
    period?
  + The magazine's editor argues that the axis is labeled honestly,
    every number is correct, and nothing has been hidden. Respond to
    that defense.
  + What would you need to see before deciding whether "exploded" is
    justified?
][
  + From #num(9850) to #num(10100) is an increase of $250$, and
    $250/#num(9850) approx 0.025$ --- about $2.5%$ over two
    years, a little over 1% per year.
  + The defense is factually correct and beside the point. A chart
    is not only a container for numbers; it is a picture, and the
    picture is doing the arguing. Truncating a #num(10000)-person
    axis to a 400-person window magnifies a $2.5%$ change into the
    full height of the chart. The editor is answering "did we state
    anything false?" when the question is "does this chart cause a
    correct impression?" --- and those come apart precisely when
    someone wants them to.
  + At minimum a longer time series: 2021 to 2023 is three points,
    and three points cannot distinguish a trend from a fluctuation.
    Also useful: the town's history over one or two decades, growth
    rates of comparable towns, and whether something specific
    happened (a new development, a boundary change) that would make
    these particular years unrepresentative.
]

#ex(difficulty: 3, time: "20 min", hints: (
  "Work out the two class widths separately -- how many units wide is each one, and how many observations does each contain?",
  "If one class is twice as wide as another, how many observations would you expect it to contain even if the data were completely evenly spread?",
  "Ask what quantity the reader is comparing when they look at two bars: the height, or the total ink?",
))[
  A histogram of household incomes uses classes of width #num(20000)
  up to CHF #num(100000), and then a single class covering
  #num(100000) to #num(300000). The final class is drawn as a bar of
  the same height as the others.
  + Explain why this display exaggerates the number of high-income
    households.
  + The designer replies that the bar's height is exactly the number
    of households in that class, so it is accurate. Is it?
  + Suggest a correct way to draw the final class.
][
  + The final class is #num(200000) wide --- ten times the width of
    each earlier class. Drawn at the same height it occupies ten
    times the area, and area is what the eye reads as quantity, so
    the high-income group appears vastly larger than its count
    warrants. Even a class holding very few households would look
    substantial.
  + The height is accurate; the display is not. In a histogram it is
    the *area* of a bar that represents frequency, and the designer
    has held height constant while varying width, which breaks that
    correspondence. The bar tells the truth about one number and a
    falsehood about the comparison, and readers compare.
  + Scale the height by the class width --- plot frequency *density*
    (frequency divided by class width) instead of raw frequency, so
    that area once again represents count. The wide final class then
    appears as a low, long bar, which is the honest picture of a
    small number of households spread over a broad range. Label the
    vertical axis as a density so the reader knows what they are
    looking at. An alternative, if densities are too much for the
    intended audience, is to keep equal classes and state the count
    above CHF #num(100000) in a note beside the chart.
]

#exploration(title: "Build the Same Lie Twice")[
  Work in pairs. Choose any dataset with at least a dozen values ---
  your own travel times, screen-time figures, the results of a class
  survey, anything.

  + Each of you draws a chart of the *same* data. One of you must
    make the differences look as large as possible; the other must
    make them look as small as possible. You may not alter, omit, or
    invent a single number.
  + Swap charts with another pair. Without being told which is
    which, they identify what each of you did.
  + Together, draw the version you would defend publicly, and write
    the one-sentence caption that makes both other versions
    impossible to misread.

  Bring all three to class. The interesting cases are the ones where
  the "honest" version was hardest to agree on --- and there will be
  some, because for a few of these choices there is no neutral
  option, only a choice you can defend.
]

#ai-box(role: "Checker")[
  Describe one of the charts from the exploration above to an AI
  assistant in words --- the data, the axis range, the class widths
  --- and ask it whether the chart is misleading and why.

  Then check its answer against the chart itself. Three things worth
  watching for: whether it notices the specific manipulation you
  actually used, whether it invents a problem your chart does not
  have, and whether it can tell the difference between a truncated
  axis that is defensible and one that is not.

  Write down one thing it caught that you had missed, and one thing
  it got wrong. If it got nothing wrong, say so --- but check twice
  before you conclude that.
]

== What a Good Graph Does

#only-theory[
  It would be a poor outcome if the last section left you thinking
  that charts are a genre of trickery. They are not. The reason a
  misleading chart works is that a good one is so extraordinarily
  effective --- the eye extracts a pattern from a picture in a
  fraction of the time it takes to read the same pattern out of a
  table, and that speed is a genuine gift, not a trap.

  So it is worth asking the opposite question. What does a chart do
  when it is working?
]

#keybox(title: "Marks of a Good Graph")[
  + *It answers a question.* Not "here is some data" but "here is
    the thing you wanted to know." If you cannot say what question
    the chart answers, it does not have one.
  + *The comparison it wants you to make is the easiest one to
    make.* Quantities meant to be compared sit on a common baseline,
    close together, on one scale.
  + *The encoding fits the data.* Categories get separated bars,
    numbers get a continuous axis, time gets a horizontal axis in
    chronological order. Nothing is scaled in two dimensions to
    represent one quantity.
  + *Most of the ink is data.* Grid lines, shadows, gradients, and
    3-D effects compete with the thing you came to see.
  + *It says where it came from.* Source, date, $n$, and units, so a
    reader who wants to check can.
  + *It rewards a second look.* This is the real test, and it
    inverts the section before: a misleading chart is at its most
    convincing at a glance and falls apart the longer you study it.
    A good chart works at a glance and then keeps giving --- the
    overall shape first, then a group you had not noticed, then an
    exception worth asking about.
]

#example(title: "Three That Changed Something")[
  / Snow, 1854: During a cholera outbreak in Soho, London, John Snow
    marked each death as a bar on a street map. The marks piled up
    around a single water pump on Broad Street --- and, tellingly,
    were nearly absent at a nearby workhouse and brewery, both of
    which had their own water supply. The map did not merely display
    the deaths; it located the cause, at a time when cholera was
    widely believed to spread through bad air. It remains one of the
    most consequential pictures ever drawn, and it is a dotplot on a
    map.
  / Nightingale, 1858: Florence Nightingale charted British military
    deaths in the Crimean War month by month, splitting each month's
    total into deaths from wounds and deaths from preventable
    disease. The disease areas dwarfed the wounds. She was an
    accomplished statistician who understood exactly what she was
    doing: the diagram was designed to be legible to politicians who
    would not read a table, and it worked --- it is credited with
    driving sanitary reform in military hospitals.
  / Minard, 1869: Charles Minard drew Napoleon's 1812 march on
    Moscow as a band whose width is the size of the surviving army,
    tracking geography, direction, and --- on the retreat --- the
    temperature, all in one figure. The band begins broad and ends a
    thread. Six variables, one picture, no arithmetic required of
    the reader.
]

// ── IMAGES (recommended) ─────────────────────────────────────
// All three of the above are in the PUBLIC DOMAIN by age and are on
// Wikimedia Commons in high resolution -- no rights question at all,
// which is why I chose them over modern equivalents:
//   * "Snow-cholera-map-1.jpg"          (Broad Street, 1854)
//   * "Nightingale-mortality.jpg"       (polar area diagram, 1858)
//   * "Minard.png"                      (Napoleon's march, 1869)
// Minard rewards being printed large or handed out on A3; at figure
// size the temperature scale along the retreat is unreadable, and
// that scale is half of what makes it remarkable.
// #only-theory[#fig(
//   image("images/snow-cholera-map-1854.jpg", width: 75%),
//   caption: [John Snow, 1854. Each mark is a death; the cluster
//     identifies the Broad Street pump.],
// )]
// #only-theory[#fig(
//   image("images/nightingale-mortality-1858.jpg", width: 80%),
//   caption: [Florence Nightingale, 1858. Blue: deaths from
//     preventable disease. Red: deaths from wounds.],
// )]
// #only-theory[#fig(
//   image("images/minard-napoleon-1869.png", width: 100%),
//   caption: [Charles Minard, 1869. Army size, geography,
//     direction, and temperature in a single figure.],
// )]

#remark[
  For modern examples that are free to reuse, *Our World in Data*
  (`ourworldindata.org`) publishes its own charts under a Creative
  Commons BY license --- they may be reproduced and distributed with
  credit and no permission required, which is unusually generous and
  makes it the most convenient source of well-made charts for
  classroom use. Note that charts on the site produced by third
  parties carry those parties' own terms instead. The Bundesamt für
  Statistik is the obvious Swiss counterpart when you want data
  about the country you live in.
]

#ex(difficulty: 2, time: "20 min")[
  Snow's map is a display of deaths, but the question he was
  answering was not "how many died?"
  + What question was the map built to answer?
  + Why would a bar chart of deaths per week --- an accurate,
    perfectly respectable display of the same outbreak --- have been
    useless for that question?
  + The near-absence of deaths at the brewery, whose workers drank
    from their own well, does more argumentative work than the
    cluster around the pump. Explain why.
][
  + Roughly: "where is this coming from?" It is a question about
    *location*, so the display had to preserve location --- which is
    why the deaths are placed on a map rather than counted into
    categories.
  + Because a chart of deaths per week discards exactly the variable
    that carries the answer. It would show the outbreak's size and
    timing accurately and say nothing whatsoever about its source.
    The choice of display is downstream of the question, and no
    amount of care in drawing the bar chart could rescue it.
  + Because it is a case where the suspected cause was absent and
    the effect was absent too. The cluster around the pump is
    consistent with the pump being the source --- but also with
    something else about that neighborhood. The brewery sits inside
    the same neighborhood, shares the air, and differs in one
    relevant respect: its workers did not drink the pump water.
    Something present everywhere cannot explain a pattern that stops
    at the brewery door.
]

#ex(difficulty: 1, time: "10 min")[
  A chart is described as follows: "Bar chart. Vertical axis
  unlabeled, starting at 40. Five bars, one per year, 2019--2023.
  Bars shaded with a gradient and drawn in 3-D perspective. No source
  and no $n$."

  List every change you would make, and for each say what the reader
  gains.
][
  Changes, with the gain in each case:
  - *Label the vertical axis* with quantity and units --- without it
    the chart cannot be read at all, only felt.
  - *Start the axis at zero*, or make the truncation conspicuous ---
    bar length is what the reader compares, so a hidden truncation
    corrupts every comparison on the chart.
  - *Drop the 3-D perspective* --- it makes nearer bars look larger
    regardless of value and makes reading a height off the axis
    ambiguous.
  - *Drop the gradient* --- it adds no information and competes with
    the data for attention.
  - *Add the source and date* --- so a reader can check, and so they
    can judge whether the data is current.
  - *State $n$* (or what each bar counts) --- so the reader knows
    whether the differences could be noise.

  Note that the first two are about honesty and the next two are
  about clarity. Both matter, but they fail differently: a cluttered
  chart wastes the reader's effort, while an unlabeled truncated axis
  spends it on reaching a wrong conclusion.
]

#only-theory[
  A closing thought. A chart is an argument, made by a person, about
  what matters in a set of numbers. Arguments can be good or bad,
  honest or slippery --- and the response to a bad argument is never
  to stop listening to arguments. Snow, Nightingale, and Minard were
  making arguments too. The difference is that theirs got better the
  longer you looked.
]

#print-hints()
#print-vocab()
