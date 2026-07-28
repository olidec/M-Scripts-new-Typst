#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Association and Causation")
#let ex = exercise.with(chapter: "Association and Causation")

// ── Datasets ─────────────────────────────────────────────────

// The first line-of-best-fit dataset from ch-linear. Deliberately the
// SAME points students already fitted by eye there -- the callback in
// section 2 depends on it, so if that exercise is ever edited, edit
// this too.
#let linear-callback = (
  (0, 2.0), (1, 2.4), (2, 2.9), (3, 3.5),
  (4, 4.2), (5, 4.6), (6, 4.9), (7, 5.5),
)

// Anscombe's quartet (F. J. Anscombe, 1973). All four share the same
// mean in x and y, the same line of best fit, and the same
// correlation -- verified to three decimals.
#let anscombe-x = (10, 8, 13, 9, 11, 14, 6, 4, 12, 7, 5)
#let anscombe-1 = (8.04, 6.95, 7.58, 8.81, 8.33, 9.96, 7.24, 4.26, 10.84, 4.82, 5.68)
#let anscombe-2 = (9.14, 8.14, 8.74, 8.77, 9.26, 8.10, 6.13, 3.10, 9.13, 7.26, 4.74)
#let anscombe-3 = (7.46, 6.77, 12.74, 7.11, 7.81, 8.84, 6.08, 5.39, 8.15, 6.42, 5.73)
#let anscombe-x4 = (8, 8, 8, 8, 8, 8, 8, 19, 8, 8, 8)
#let anscombe-4 = (6.58, 5.76, 7.71, 8.84, 8.47, 7.04, 5.25, 12.50, 5.56, 7.91, 6.89)

#let pair(xs, ys) = xs.zip(ys)

#let quartet-plot(pts) = plot(
  xmin: 2, xmax: 20, ymin: 2, ymax: 14,
  width: 5.4cm, height: 4cm,
  show-grid: "major",
  data(pts, mark: "*", mark-fill: accent, mark-stroke: accent, mark-size: 0.1),
)

= Association and Causation

#only-theory[
  Everything so far has looked at one variable at a time. But almost
  every interesting question is about two: does more study time raise
  grades, does the new timetable reduce lateness, does this treatment
  work?

  Questions like these are about a *relationship*, and relationships
  are where statistics is at once most useful and most dangerous. The
  tools for spotting one are straightforward. The reasoning about
  what a relationship means is not, and it is where most bad
  arguments in public life live.
]

#objectives(
  bfkm(level: "high")[read a scatterplot, and interpret a stated line
    of best fit and correlation],
  [describe the association between two variables in terms of
    direction, form, and strength],
  [sketch a line of best fit by eye and use it to make a prediction,
    distinguishing interpolation from extrapolation],
  [explain why an association between two variables does not
    establish that one causes the other, and name the alternative
    explanations],
  [identify a plausible confounding variable in a described study],
  [explain why a comparison can reverse when groups are combined,
    and why summary numbers must be accompanied by a plot],
)

== Two Variables at Once

#definition(title: "Scatterplot")[
  A #vocab("scatterplot", "Streudiagramm") plots one point per
  individual, with one variable on the horizontal axis and the other
  on the vertical. Nothing is summarized and nothing is grouped: each
  point is one member of the dataset, located by both of its values
  at once.
]

#only-theory[
  A scatterplot is read on three counts.

  / Direction: as one variable increases, does the other tend to
    increase (*positive* association) or decrease (*negative*)?
  / Form: do the points cluster around a straight line, around a
    curve, or around nothing in particular?
  / Strength: how tightly do they cluster? A tight band is a strong
    association; a wide cloud with a slight tilt is a weak one.

  A fourth question is worth asking every time: are there points that
  do not belong with the rest? A single distant point can dominate
  the impression a scatterplot gives, and you will see exactly how
  badly at the end of this chapter.
]

#ex(difficulty: 1, time: "10 min")[
  For each pair of variables, predict the direction of the
  association --- positive, negative, or none --- and say whether you
  would expect it to be strong or weak.
  #auto-parts(
    2,
    [A car's age and its resale value],
    [A student's height and their mathematics grade],
    [Hours of revision and exam score],
    [Outdoor temperature and heating costs],
    [Distance from school and travel time],
    [Shoe size and telephone number],
  )
][
  #auto-parts(
    2,
    [Negative and strong --- older cars are worth less, reliably.],
    [None. There is no reason to expect any relationship, and
      finding one in a sample would call for a confounder (age, if
      the sample spans several year groups).],
    [Positive, but weaker than students expect --- effectiveness of
      revision varies enormously, and prior knowledge matters
      too.],
    [Negative and strong.],
    [Positive and strong, though not perfect: mode of transport
      matters, so a distant student on a train may arrive sooner
      than a nearer one who walks.],
    [None. Telephone numbers are nominal labels, so the question is
      not even well posed --- an association would require the
      numbers to mean something as quantities.],
  )
]

== The Line of Best Fit, Revisited

#only-theory[
  You have done this before. In the chapter on linear functions you
  were given a set of points, asked to sketch the line that fitted
  them best, and asked to read off its slope and intercept. Nothing
  told you what "best" meant --- you judged it by eye, and it worked.

  Here is that same set of points again:
]

#only-theory[
  #fig(
    align(center, plot(
      xmin: -1, xmax: 8, ymin: 0, ymax: 6,
      width: 7cm, height: 5cm,
      show-grid: "major",
      data(
        linear-callback,
        mark: "*", mark-fill: accent, mark-stroke: accent,
        mark-size: 0.1,
      ),
    )),
    caption: [The same points you fitted a line to earlier.],
  )
]

#only-theory[
  Sketching a line through a cloud of points is exactly what this
  chapter is about, seen from the other side. Back then, the point
  was the line --- its slope, its intercept, its equation. Now the
  point is the *cloud*: how tightly the points hug whatever line you
  drew, and what it would mean if they hug it very tightly indeed.

  Your eye, when you drew that line, was doing something specific. It
  was trying to keep the points close to the line --- pulling the
  line down when too many points sat below it, tilting it when the
  ends drifted off. That instinct is right, and it can be made
  precise. Making it precise is a matter for the next chapter, and
  only the advanced course needs it. For now the instinct is enough,
  and it is worth knowing that the instinct is good.
]

#definition(title: "Line of Best Fit")[
  A #vocab("line of best fit", "Ausgleichsgerade") is a straight line
  drawn through a scatterplot so as to pass as close as possible to
  the points as a whole.

  Once drawn, it can be used to *predict*: read a value off the
  horizontal axis, go up to the line, read across.
]

#warning[
  Predicting *inside* the range of the data ---
  #vocab("interpolation", "Interpolation") --- is reasonable, because
  you have evidence on both sides of the value you are asking about.

  Predicting *outside* it ---
  #vocab("extrapolation", "Extrapolation") --- is a different act,
  and the further out you go the less it is worth. The line describes
  the region where the data lives. Nothing in the data says the
  pattern continues beyond it, and patterns very often do not: growth
  levels off, materials break, markets saturate. A line fitted to
  children's heights between ages 2 and 10 predicts a height of four
  metres at age 60.
]

#ex(difficulty: 2, time: "15 min", keep-together: true)[
  A shop records the number of ice creams sold against the daily
  maximum temperature:

  #align(center, plot(
    xmin: 8, xmax: 32, ymin: 0, ymax: 220,
    width: 8cm, height: 5cm,
    show-grid: "major",
    data(
      (
        (12, 22), (14, 35), (15, 30), (17, 58), (19, 72),
        (20, 90), (22, 105), (23, 120), (25, 140), (26, 138),
        (28, 165), (30, 190),
      ),
      mark: "*", mark-fill: accent, mark-stroke: accent,
      mark-size: 0.1,
    ),
  ))

  + Describe the association in terms of direction, form, and
    strength.
  + Copy the plot and sketch a line of best fit. Estimate its slope,
    and say what the slope means in this situation.
  + Use your line to estimate sales on a 24 °C day.
  + The owner uses the line to predict sales on a 45 °C day. Give two
    separate reasons to distrust that prediction.
][
  + Positive, close to linear, and strong --- the points lie in a
    narrow band rising steadily from left to right.
  + A reasonable line gives a slope of roughly 8 to 9 ice creams per
    degree. Answers will vary a little, which is expected when the
    line is drawn by eye. The slope means that each additional
    degree of maximum temperature is associated with roughly eight
    or nine more ice creams sold.
  + About 125 to 135 ice creams --- an interpolation, well supported
    by data on both sides.
  + First, 45 °C is far outside the observed range of 12 °C to
    30 °C, so it is an extrapolation and the linear pattern has no
    evidence behind it out there. Second, there is a specific reason
    to expect the pattern to break: at extreme heat people stay
    indoors, the shop may not open, and sales could well fall rather
    than continue rising. The line knows nothing about any of that.
]

#exploration(title: "What the Calculator Already Knows")[
  Your calculator will fit a line for you, and it is worth seeing
  that it agrees with your eye.

  + Enter the eight points from the figure above --- the $x$-values
    $0, 1, dots, 7$ in list L1 and the $y$-values $2.0, 2.4, 2.9,
    3.5, 4.2, 4.6, 4.9, 5.5$ in L2.
  + Choose two-variable statistics, and then the linear regression
    option. The calculator reports a slope $a$ (or $m$) and an
    intercept $b$ (or $q$).
  + Compare them with the values you got by eye when you first met
    these points. They should agree closely --- the published
    answers then were about $0.51$ and $1.97$, and the calculator
    gives $0.5095$ and $1.9667$.
  + The calculator also reports a number $r$, somewhere between $-1$
    and $1$. Try a few datasets of your own: one where the points
    lie almost exactly on a rising line, one where they form a
    shapeless cloud, one where they fall steeply. What does $r$
    seem to measure?

  *A note on what is happening here.* The calculator is not guessing.
  There is a precise definition of the "best" line, and a formula
  that produces it --- which is why it can give four decimal places
  where your eye gave two. That theory sits beyond this course, and
  you are not expected to reproduce it or to be examined on it. What
  you should take away is narrower and still worth having: a line
  fitted by eye and a line fitted by formula are trying to do the
  same job, and on well-behaved data they land in the same place.

  Students in the advanced course meet the definition, the formula,
  and the meaning of $r$ in the chapter that follows this one.
]

== Correlation Does Not Imply Causation

#only-theory[
  Now the hard part. You have found that two variables move together.
  What follows?

  Less than people think. When $X$ and $Y$ are associated, there are
  at least four explanations, and the data alone cannot distinguish
  between them.
]

#keybox(title: "Four Reasons Two Variables Move Together")[
  + *$X$ causes $Y$.* The explanation everyone reaches for first, and
    one of four.
  + *$Y$ causes $X$.* Reverse causation. Hospitals with more staff
    have more patients --- but the patients came first.
  + *Something else causes both.* A
    #vocab("confounding variable", "Störvariable") drives $X$ and $Y$
    independently, producing an association between them with no
    direct link at all.
  + *Chance.* With enough variables, some pairs will move together
    for no reason whatsoever. Search a thousand time series and you
    will find striking correlations between things that have nothing
    to do with each other.

  A correlation is consistent with all four. Establishing the first
  requires something the correlation does not contain --- usually a
  controlled experiment, sometimes a mechanism, always an argument.
]

#only-theory[
  Notice that this is the same shape of reasoning as the warm-weather
  and violence exercise from the first chapter of this unit. What is
  new is that you can now *measure* the association. Measuring it
  more precisely does not make the causal question any easier. A
  correlation of $0.95$ is exactly as silent about causation as a
  correlation of $0.3$; it is only louder.
]

#ex(difficulty: 2, time: "15 min")[
  For each finding, give the most plausible explanation from the four
  above, and justify it. More than one may be defensible.
  #auto-parts(
    1,
    [Children with larger vocabularies are taller.],
    [Countries with more mobile phones per person have longer life
      expectancy.],
    [People who eat breakfast weigh less than people who skip it.],
    [Towns with more police officers report more crimes.],
    [Over one ten-year period, cheese consumption per person tracked
      the number of engineering doctorates awarded almost exactly.],
  )
][
  #auto-parts(
    1,
    [Confounder: age. Older children are both taller and further
      along in language development. Within a single age group the
      association would largely vanish.],
    [Confounder: national wealth. Richer countries have more of
      almost everything, including phones and healthcare. A direct
      effect is not impossible --- phones aid emergency access --- but
      it cannot be read off the correlation.],
    [Genuinely ambiguous, which is why it is here. Breakfast may
      affect weight; weight-conscious people may be more likely to
      eat breakfast (reverse causation); and people who eat
      breakfast differ systematically in income, working hours and
      exercise (confounders). This has been argued in the
      nutritional literature for years, and observational data alone
      has not settled it.],
    [Most plausibly reverse causation, or something close to it:
      towns with more crime hire more police. There may also be a
      reporting effect --- more officers means more crimes recorded
      rather than more committed --- which is the measurement issue
      from the first chapter appearing again.],
    [Chance. There is no mechanism, and no plausible confounder
      linking cheese to doctorates. Given enough series to compare,
      pairs like this are guaranteed to appear; finding one is
      evidence of a diligent search, not of a relationship.],
  )
]

#ex(difficulty: 2, time: "15 min", keep-together: true)[
  A study finds that students who own more books at home achieve
  higher grades. A newspaper reports: "Buying books improves your
  child's grades."
  + Identify at least two confounding variables that could produce
    this association.
  + Design a study that would come closer to answering the causal
    question. What makes it better?
  + Even a well-designed study of this question runs into a practical
    obstacle. What is it?
][
  + Household income (books cost money, and income buys tutoring,
    quiet space, and stability); parental education (educated parents
    own more books *and* help with schoolwork); and the family's
    attitude to reading, which shapes both the shelf and the child.
  + Randomly assign books. Take a large group of comparable
    households, give a substantial number of books to a randomly
    chosen half, and compare grades some years later. Random
    assignment is what makes it better: it breaks the link between
    the treatment and every confounder at once, including the ones
    nobody thought of, because the groups differ only by the coin
    toss.
  + Compliance and time. You can deliver books but you cannot make
    anyone read them, so the study measures the effect of *receiving*
    books rather than of reading them; and grades take years to
    respond, over which families move, drop out, and change. This is
    the general difficulty with causal questions about human lives:
    the clean experiment is often impossible, unethical, or too slow,
    which is exactly why observational data and careful reasoning
    matter so much.
]

== When Combining Groups Reverses the Answer

#only-theory[
  Here is a phenomenon that looks impossible until you see the
  numbers.
]

#example(title: "Two Treatments for Kidney Stones")[
  A comparison of two treatments, A and B, recorded the success rate
  for small stones and large stones separately. The figures below are
  from a 1986 study, and are the standard example of what follows.

  #data-table(
    columns: (auto, auto, auto),
    row-height: auto,
    [], [*Treatment A*], [*Treatment B*],
    [Small stones], [81 / 87 = 93%], [234 / 270 = 87%],
    [Large stones], [192 / 263 = 73%], [55 / 80 = 69%],
    [*Overall*], [*273 / 350 = 78%*], [*289 / 350 = 83%*],
  )

  Read the first two rows: treatment A does better on small stones,
  and A does better on large stones. Read the third: B does better
  overall.

  Every number is correct. A is better for every patient, and worse
  in total.

  The explanation is in the group sizes. Large stones are harder to
  treat --- both treatments do worse on them --- and treatment A was
  given to 263 of the 350 large-stone cases, that is 75% of its
  patients, while B took only 80 of its 350, about 23%. A was doing
  the hard cases. Its overall rate is dragged down not because it
  performs worse but because of *who it was performing on*.

  This reversal on aggregation is called
  #vocab("Simpson's paradox", "Simpson-Paradoxon").
]

#only-theory[
  You have met this before too. The hospital exercise in the first
  chapter of this unit --- where Hospital A had a higher death rate
  because it received the most difficult patients --- was Simpson's
  paradox described in words. Now you can see it in numbers.

  The uncomfortable part is that there is no general rule for which
  table to trust. Here the separated rows are the honest ones,
  because stone size affects the outcome and was not assigned at
  random. In other situations combining is right and separating is
  the distortion. Deciding requires knowing what the variables *are*
  and how they relate --- knowledge that does not live in the data.
]

#ex(difficulty: 3, time: "20 min", keep-together: true, hints: (
  "Work out the four separate pass rates first, then the two overall rates. Do not average the two rates -- count the students.",
  "Look at how many students each department taught, and how hard each department's exams appear to be.",
  "For the last part, ask what would have to be true for the combined figure to be the fair comparison.",
))[
  Two departments at a college report exam results by teaching
  method.

  #data-table(
    columns: (auto, auto, auto),
    row-height: auto,
    [], [*Method X*], [*Method Y*],
    [Department of Physics], [18 / 20 passed], [90 / 110 passed],
    [Department of History], [55 / 100 passed], [7 / 15 passed],
  )

  + Compute the pass rate for each method within each department, and
    then overall.
  + Which method looks better within departments? Which looks better
    overall?
  + Explain the reversal in terms of who was taught what.
  + A college administrator wants one number to decide which method
    to adopt college-wide. Is the overall rate that number? Argue
    carefully.
][
  + Physics: X gives $18/20 = 90%$, Y gives $90/110 approx 81.8%$.
    History: X gives $55/100 = 55%$, Y gives $7/15 approx 46.7%$. \
    Overall: X gives $73/120 approx 60.8%$, Y gives
    $97/125 = 77.6%$.
  + Method X is better in *both* departments; method Y is better
    overall.
  + Physics exams are passed far more often than History exams by
    either method, so the department a student sits in matters more
    than the method. Method Y was used overwhelmingly in Physics
    (110 of its 125 students), while method X was used mostly in
    History (100 of its 120). Y's overall figure is inflated by
    teaching the easier subject, not by teaching better.
  + No, not as it stands. The overall rate compares two methods
    across different mixtures of subject, so it measures the mixture
    as much as the method. It would be the right number only if the
    two methods had been used on comparable groups --- which is
    exactly what random assignment achieves and what did not happen
    here. The defensible move is to report the within-department
    rates, in both of which X wins, or to re-weight both methods to
    a common subject mix before comparing.
]

== Summary Numbers Are Not Enough

#only-theory[
  The last chapter closed by asking whether any set of summary
  numbers could be trusted to capture a dataset. Here is the answer.

  In 1973 the statistician Frank Anscombe published four small
  datasets, eleven points each. They share, to two decimal places:
  the same mean in $x$, the same mean in $y$, the same spread in
  both, the same line of best fit $y = 3.00 + 0.50 dot x$, and the
  same correlation $r approx 0.82$.

  By every summary number in this unit, they are the same dataset.
]

#only-theory[
  #image-grid(
    2,
    fig(quartet-plot(pair(anscombe-x, anscombe-1)), caption: [Set I]),
    fig(quartet-plot(pair(anscombe-x, anscombe-2)), caption: [Set II]),
    fig(quartet-plot(pair(anscombe-x, anscombe-3)), caption: [Set III]),
    fig(quartet-plot(pair(anscombe-x4, anscombe-4)), caption: [Set IV]),
  )
]

#only-theory[
  Set I is what the summaries suggest: a linear relationship with
  scatter. Set II is a clean curve --- there is a perfect
  relationship here, and it is not a straight line, so the line of
  best fit is answering a question nobody should have asked. Set III
  is an exact straight line with one point knocked out of place; that
  single point drags the fitted line away from the other ten. Set IV
  has ten points at the same $x$-value and one far away, and that one
  point determines the slope entirely --- remove it and there is no
  slope at all, since a vertical stack of points has no direction.

  Four datasets, one set of summary numbers, four completely
  different situations. Three of the four would be seriously
  misdescribed by any conclusion drawn from those numbers.
]

#keybox(title: "The Lesson of the Quartet")[
  Summary numbers are necessary and not sufficient. They compress,
  which is their purpose, and compression discards, which is their
  cost.

  So: *plot the data first.* Every time. Not because the numbers lie
  --- every number in Anscombe's quartet is correct --- but because
  a picture is the only cheap way to find out which question the
  numbers are answering.
]

#only-theory[
  This is also the answer to the last chapter's final question. No
  fixed set of summary numbers is safe from being fooled, because any
  finite list of summaries can be matched by datasets that differ in
  something the list does not measure. The defence is not a better
  summary. It is looking.
]

#ex(difficulty: 2, time: "15 min")[
  Using the four plots above:
  + For each set, say whether a line of best fit is an appropriate
    description, and why.
  + For Set III, describe what would happen to the fitted line if the
    one displaced point were removed.
  + Set IV has a correlation of about $0.82$, which by itself sounds
    like strong evidence of a linear relationship. Explain why that
    number is worthless here.
  + A colleague proposes a rule: "always check $r$ before drawing any
    conclusion." Improve the rule.
][
  + *I:* yes --- the points scatter around a straight line, which is
    what a line of best fit describes. *II:* no --- the relationship
    is real but curved, and a straight line systematically
    misdescribes it, overestimating at the ends and underestimating
    in the middle. *III:* not as it stands --- ten points lie
    exactly on a line and one does not, so the fitted line describes
    neither. *IV:* no --- there is no evidence of any linear
    relationship, because there are only two distinct $x$-values.
  + It would swing to pass exactly through the remaining ten points,
    which are perfectly collinear. The fit would become perfect, and
    the slope would change noticeably. One point in eleven is doing
    that.
  + Because $r$ measures how well a straight line fits, and in Set IV
    a line is determined by two locations only: the stack at
    $x = 8$ and the single point at $x = 19$. Any two locations can
    be joined by a line, so a high $r$ is guaranteed and carries no
    information about a relationship. Delete the far point and $r$ is
    undefined.
  + Something like: "plot the data, and check $r$ only after the plot
    has shown that a straight line is the right kind of description."
    The number is a measure of fit for a model you have already
    decided is appropriate, and deciding that is a job for the eye.
]

#ai-box(role: "Checker")[
  Give an AI assistant the eleven points of Anscombe's Set II ---
  which lie on a clean curve --- without telling it what they are.
  Ask it to describe the relationship between the two variables and
  to give a line of best fit.

  Then ask whether a straight line is the right description.

  Record what happened at each step. The question worth answering is
  whether the assistant volunteered the curvature on its own, or only
  conceded it once asked. An assistant that computes a regression
  line for curved data without comment has made exactly the mistake
  this section is about --- and so, for that matter, would a person
  reaching for a formula before looking at a picture.
]

#only-high[
  #look-ahead(preview: [correlation and regression])[
    Two things in this chapter were deliberately left informal. The
    line of best fit was drawn by eye, with "best" left undefined;
    and $r$ arrived as a number the calculator prints, with only a
    rough sense of what it measures.

    Both get made precise in the next chapter: what quantity the best
    line minimizes, how its slope and intercept are computed, what
    $r$ is built from, and why it always lies between $-1$ and $1$.
    None of it changes the reasoning of this chapter --- a precisely
    computed correlation is exactly as silent about causation as an
    eyeballed one.
  ]
]

#print-hints()
#print-vocab()
