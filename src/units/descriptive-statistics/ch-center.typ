#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Measures of Center")
#let ex = exercise.with(chapter: "Measures of Center")

// NOTE: unlike ch-displaying-data, this chapter declares no dataset
// arrays. Both datasets here are displayed to the reader literally --
// as a raw list and as a frequency table -- so an array would merely
// duplicate them, and a #let that has to be kept in step with a
// printed table is a drift risk rather than a protection against one.
// The stats helpers (mean-of, median-of, stat-num) are still the
// right tool wherever a chapter computes a figure it does NOT also
// print; note that the validator flags code calls inside $...$, so
// they read best in prose rather than inside display math.

= Measures of Center

#only-theory[
  The last chapter turned a list of numbers into a picture. This one
  compresses it further --- all the way down to a single number that
  claims to stand for the whole set.

  That is an enormous compression, and it is worth being suspicious
  of. Twenty-three salaries become one figure; a whole distribution
  becomes a dot. Something must be lost. The useful question is not
  whether to do it --- everyone does it, constantly --- but which of
  the several competing answers to use, and what each one throws
  away.
]

#objectives(
  bfkm[compute the arithmetic mean, the median, and the mode from
    raw data and from a frequency table],
  bfkm[choose the appropriate measure of center for a given
    distribution, and justify the choice by the shape of the data],
  [explain what "robust" means, and why the median is robust against
    outliers while the mean is not],
  [predict how the mean and the median respond when every value is
    shifted or scaled, or when a single value is added or changed],
  obj(level: "high")[explain the sense in which the mean and the
    median are each optimal, and connect the mean's optimality to
    the measure of spread that follows],
  [compute one-variable statistics on a calculator, including from a
    frequency table, and state which displayed quantity is which],
)

== Three Kinds of Average

#only-theory[
  English has one everyday word, "average", for at least three
  different things. That ambiguity is not harmless --- a good deal of
  public argument runs on it --- so we start by separating them.
]

#definition(title: "Mean, Median, Mode")[
  For data $x_1, x_2, dots, x_n$:

  The #vocab("arithmetic mean", "arithmetisches Mittel") is the sum
  divided by the count,
  $ overline(x) = (x_1 + x_2 + dots + x_n) / n = 1/n sum_(i=1)^n x_i. $

  The #vocab("median", "Median") is the middle value of the data
  *after sorting*. If $n$ is odd it is the single middle value; if
  $n$ is even it is the arithmetic mean of the two middle values.

  The #vocab("mode", "Modus") is the value that occurs most often. A
  dataset may have more than one mode, or none worth naming.
]

#warning[
  Sorting is not optional for the median. The middle value of the
  list as written is not the median unless the list happens already
  to be in order, and this is far and away the most common mistake in
  this chapter.
]

#example(title: "Seven Salaries")[
  A small firm pays its seven employees, in CHF:

  #align(center, text(size: 9.5pt, raw(
    "68'000   61'000   72'000   255'000   70'000   76'000   61'000",
  )))

  *Mean.* The total is CHF #num(663000), so
  $ overline(x) = #num(663000) / 7 approx #num(94714). $

  *Median.* Sorted:

  #align(center, text(size: 9.5pt, raw(
    "61'000   61'000   68'000   70'000   72'000   76'000   255'000",
  )))

  With $n = 7$ the middle is the 4th value, so the median is
  CHF #num(70000).

  *Mode.* CHF #num(61000), which occurs twice.

  Now notice the problem. The mean is about CHF #num(95000), and
  *six of the seven employees earn less than that*. A number
  describing the typical salary ought not to be higher than almost
  everybody's salary. The median, CHF #num(70000), sits where a
  typical employee actually is.
]

#ex(difficulty: 1, time: "10 min")[
  Determine the mean, the median, and the mode of each dataset.
  Round to two decimal places where necessary.
  #auto-parts(
    1,
    [$1, 3, 4, 8, 1, 7, 1, 5$],
    [$18, 13, 16, 20, 21, 13, 19$],
    [$1.7, 1.6, 3.8, 5.1, 1.6, 0.9, 1.2, 1.6, 100, 1.6$],
  )
][
  #auto-parts(
    1,
    [Sorted: $1, 1, 1, 3, 4, 5, 7, 8$. Sum $= 30$, so
      $overline(x) = 30/8 = 3.75$. With $n = 8$ the median is the
      mean of the 4th and 5th values, $(3 + 4)/2 = 3.5$. Mode: $1$.],
    [Sorted: $13, 13, 16, 18, 19, 20, 21$. Sum $= 120$, so
      $overline(x) = 120/7 approx 17.14$. Median: the 4th value,
      $18$. Mode: $13$.],
    [Sorted: $0.9, 1.2, 1.6, 1.6, 1.6, 1.6, 1.7, 3.8, 5.1, 100$.
      Sum $= 118.6$, so $overline(x) = 11.86$. Median: mean of the
      5th and 6th values, both $1.6$, so $1.6$. Mode: $1.6$.

      Worth pausing on: the mean is more than seven times the
      median, and larger than nine of the ten values. The single
      entry $100$ has taken the mean somewhere no observation
      is.],
  )
]

#ex(difficulty: 1, time: "5 min")[
  A student computes the median of $12, 5, 9, 3, 7$ by taking the
  middle entry of the list and reports $9$. What went wrong, and what
  is the correct median?
][
  The list was not sorted. Sorted it reads $3, 5, 7, 9, 12$, and with
  $n = 5$ the median is the 3rd value, $7$. The student reported the
  middle *position* of the original list rather than the middle
  *value* of the ordered data.
]

== Averages from a Frequency Table

#only-theory[
  Data usually arrives already counted. Adding up 51 individual ages
  when the table tells you that seventeen of them are 18 is wasted
  effort --- and on a large dataset, impossible.
]

#definition(title: "Mean of a Frequency Distribution")[
  If the value $a_i$ occurs with absolute frequency $H(a_i)$, then
  $ overline(x)
    = (H(a_1) dot a_1 + H(a_2) dot a_2 + dots + H(a_k) dot a_k) / n,
    quad "where" n = sum_(i=1)^k H(a_i). $

  Each value is counted as many times as it occurs. This is called a
  #vocab("weighted mean", "gewichtetes Mittel"): the frequencies are
  the weights.

  For the median, use the *cumulative* frequencies. With $n$ values,
  the median sits at position $(n+1)/2$ when $n$ is odd; count down
  the cumulative column until you first reach or pass that position.
]

#example(title: "An Age Distribution")[
  A club records the ages of its 51 members:

  #data-table(
    columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto),
    row-height: auto,
    [Age $a$], [15], [16], [17], [18], [19], [20], [65], [67],
    [$H(a)$], [4], [12], [7], [17], [2], [1], [3], [5],
  )

  *Mean.*
  $ overline(x) = (4 dot 15 + 12 dot 16 + 7 dot 17 + 17 dot 18
    + 2 dot 19 + 1 dot 20 + 3 dot 65 + 5 dot 67) / 51
    = #num(1265) / 51 approx 24.8. $

  *Median.* With $n = 51$, the median is the 26th value. Counting
  cumulatively: $4$, then $16$, then $23$, then $40$ --- so the 26th
  value falls in the group aged 18. The median is $18$.

  The mean says 24.8 years; the median says 18. Both are correct, and
  they describe the club so differently that it is worth asking what
  is going on. Eight members are in their sixties, and those eight
  pull the mean up by nearly seven years. Told "the average member is
  25", you would picture a club that does not exist: almost nobody is
  25.
]

#ex(difficulty: 2, time: "15 min")[
  A boat rental company records the rental duration, in hours, of 30
  rentals:

  #data-table(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    row-height: auto,
    [Duration $a$], [1], [2], [3], [4], [5], [7],
    [$H(a)$], [4], [8], [7], [5], [4], [2],
  )

  + Verify that the frequencies account for all 30 rentals.
  + Compute the mean rental duration.
  + Determine the median and the mode.
][
  + $4 + 8 + 7 + 5 + 4 + 2 = 30$. ✓
  + $ overline(x) = (4 dot 1 + 8 dot 2 + 7 dot 3 + 5 dot 4
      + 4 dot 5 + 2 dot 7) / 30 = 95/30 approx 3.17 "hours". $
  + With $n = 30$ the median is the mean of the 15th and 16th values.
    Cumulative frequencies: $4, 12, 19, dots$ --- so both the 15th
    and the 16th fall in the group of duration 3, and the median is
    $3$ hours. The mode is $2$ hours, with 8 rentals.
]

== Which Average?

#only-theory[
  Everything so far has been arithmetic. This section is the part
  that matters.
]

#definition(title: "Robustness")[
  A measure is #vocab("robust", "robust") if changing a small number
  of observations --- even changing them a great deal --- barely
  moves it.

  The median is robust. Take the seven salaries and raise the top one
  from CHF #num(255000) to CHF #num(2000000): the sorted order is
  unchanged, the 4th value is still CHF #num(70000), and the median
  does not move at all. The mean rises by CHF #num(249286).

  The mean is not robust, and this is not a defect. The mean uses
  every value, which is exactly why it responds to every value. The
  median achieves its stability by ignoring almost all of them.
]

#example(title: "Two Honest Averages, One Dispute")[
  The employees of a firm are negotiating pay. The staff list, with
  annual salaries in CHF:

  #data-table(
    columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto),
    row-height: auto,
    [Salary],
    [60'000], [78'000], [86'000], [92'000], [110'000],
    [140'000], [160'000], [250'000],

    [Number], [3], [10], [3], [2], [1], [2], [1], [1],
  )

  Management states that the average salary is CHF #num(96000). The
  employees' representative states that the average is CHF
  #num(78000) and that it is not enough.

  Both are telling the truth.

  *Management is quoting the mean.* The total wage bill is CHF
  #num(2202000) across $n = 23$ employees, giving
  $ overline(x) = #num(2202000) / 23 approx #num(95739), $
  which rounds to CHF #num(96000).

  *The representative is quoting the median --- and the mode.* Ten of
  the 23 employees earn exactly CHF #num(78000), so that is the mode.
  Sorting the 23 salaries, the 12th is also CHF #num(78000), so it is
  the median too. The employees' figure has two independent defenses;
  management's has one.

  Neither side has invented a number. The disagreement is about which
  question "what does a typical employee earn?" is asking --- and
  each side has chosen the reading that favors it, which is what
  people do.
]

#keybox(title: "Choosing a Measure of Center")[
  Use the *median* when the distribution is skewed or contains
  outliers, and whenever the question is about a typical individual
  --- incomes, house prices, waiting times, response times.

  Use the *mean* when the distribution is roughly symmetric without
  extreme values, and whenever totals matter. If you need the total
  wage bill, the mean is the number that gives it to you:
  $"total" = n dot overline(x)$. The median will not do that.

  Use the *mode* for categorical data, where the others do not exist
  at all --- the most common blood type, the most common commute
  method --- and for discrete data where the most frequent value is
  itself the point.

  When the mean and the median differ substantially, that difference
  is a finding. Report both.
]

#only-theory[
  There is a reliable link between shape and the two numbers. For a
  symmetric distribution the mean and the median coincide. For a
  right-skewed distribution --- a pile of small values with a long
  tail of large ones --- the tail drags the mean upward while the
  median stays put, so the mean exceeds the median. Left-skewed data
  reverses it.

  This works in both directions, and the backwards direction is the
  useful one: told only that a distribution has mean 9.8 and median
  7, you can conclude it is right-skewed without ever seeing it.
]

#ex(difficulty: 2, time: "10 min")[
  For one course of study, the mean time to graduate is 9.8 semesters
  and the median is 7 semesters.
  + What does the comparison tell you about the shape of the
    distribution?
  + Sketch roughly what a histogram of the graduation times would
    look like.
  + Which figure should appear in a brochure advising prospective
    students how long the degree takes? Argue for your choice, then
    give the strongest argument against it.
][
  + The mean sits well above the median, so the distribution is
    right-skewed: most students finish in around seven semesters,
    and a minority take considerably longer, pulling the mean up.
    Note there is no corresponding tail on the left --- nobody
    finishes in one semester --- because the distribution is bounded
    below.
  + A tall peak at about 6--8 semesters, falling away sharply on the
    left and trailing off slowly to the right, with a few
    observations far out at 15 or 20 semesters.
  + *For the median:* the question a prospective student is asking is
    "how long will this take *me*?", and the median answers it --- 7
    semesters is what a typical student experiences, while almost
    nobody takes 9.8. *Against:* the median hides a real risk. A
    student choosing a degree deserves to know that a substantial
    minority take much longer, and quoting 7 alone conceals that.
    The honest brochure gives both, or gives the median together
    with the proportion who finish within, say, nine semesters.
]

#ex(difficulty: 2, time: "10 min")[
  In a tennis club, the mean age of the members is 35 years, and the
  median is also 35.
  + What can you conclude about the age distribution?
  + What can you *not* conclude? Give two clearly different age
    distributions that both have mean and median 35.
][
  + Only that it is roughly symmetric about 35 --- there is no long
    tail in either direction, or there are balancing tails on both
    sides.
  + You cannot conclude anything about *spread*, and that is the
    substantial gap. Two examples:
    - A club of adults all aged between 33 and 37, tightly bunched
      around 35.
    - A junior-and-veterans club: half the members aged about 15,
      half aged about 55, and nobody near 35 at all. The mean is 35,
      the median is 35, and 35 is the one age nobody is.

    The second is bimodal, and no measure of center can reveal it.
    This is precisely what the next chapter is for.
]

#look-ahead(preview: [variance, standard deviation, and quartiles])[
  Both exercises above ended in the same place: two datasets sharing
  a center and differing in every way that matters. A measure of
  center is half a description at best. The next chapter supplies the
  other half --- numbers that say how spread out the data is --- and
  with the two together you can finally distinguish the tennis club
  where everyone is 35 from the one where nobody is.
]

== What Happens When the Data Changes

#only-theory[
  Two questions come up constantly in practice: what happens to the
  average if every value shifts, and what happens if one value moves.
  The answers are different in character, and both are worth knowing
  without recomputing.
]

#keybox(title: "Shifting and Scaling")[
  If every value in a dataset has a constant $c$ added to it, then
  the mean, the median, and the mode all increase by $c$.

  If every value is multiplied by a constant $k$, then the mean, the
  median, and the mode are all multiplied by $k$.

  In short, all three measures of center follow the data. Convert
  from centimeters to meters and the mean converts with it; give
  everyone a raise of CHF #num(2000) and every measure of center
  rises by CHF #num(2000).
]

#ex(difficulty: 2, time: "15 min")[
  A dataset has mean $overline(x) = 3.56$ and median $3$.
  + Every value is increased by 5. Give the new mean and median.
  + Instead, every value is multiplied by 3. Give the new mean and
    median.
  + Instead, every value is multiplied by 3 and then decreased by 2.
    Give the new mean and median.
  + A single new value, $40$, is added to the dataset, which
    originally had $n = 9$. Can you give the new mean exactly? The
    new median? Explain the difference between the two cases.
][
  + Mean $3.56 + 5 = 8.56$; median $3 + 5 = 8$.
  + Mean $3 dot 3.56 = 10.68$; median $3 dot 3 = 9$.
  + Mean $3 dot 3.56 - 2 = 8.68$; median $3 dot 3 - 2 = 7$.
  + The new mean, yes: the original total is $9 dot 3.56 = 32.04$,
    so the new total is $72.04$ over $n = 10$ values, giving
    $overline(x) = 7.204$. The new median, no --- adding a value
    above the median shifts the middle position, and where the new
    median lands depends on the individual values around the middle,
    which the summary does not give you. This is the robustness
    property seen from the other side: the mean depends on the total
    alone, while the median depends on the arrangement.
]

#ex(difficulty: 2, time: "10 min")[
  In a software company the median monthly wage is CHF #num(6200)
  and the mean is CHF #num(6400).
  + What does the comparison suggest about the wage distribution?
  + The owner, already the highest earner, gives herself a large
    raise. What happens to the median? To the mean?
  + After the raise the mean rises to CHF #num(6900) and the
    company has 40 employees. By how much did she raise her own
    wage?
][
  + The mean exceeds the median, so the distribution is right-skewed:
    a majority earn near CHF #num(6200) and a few high earners pull
    the mean up.
  + The median does not change at all --- she was already the
    highest-paid, so the sorted order is unchanged and the middle
    value stays where it was. The mean rises.
  + The total wage bill is $n dot overline(x)$. Before:
    $40 dot #num(6400) = #num(256000)$. After:
    $40 dot #num(6900) = #num(276000)$. Since only her wage changed,
    the raise is $#num(276000) - #num(256000) = #num(20000)$ francs
    per month. #heuristic("work backwards from the goal")
]

== Why These Two?

#only-high[
  It is reasonable to ask where the mean and the median come from ---
  whether they are two arbitrary conventions, or whether each is the
  right answer to some precise question. They are the second thing.

  Suppose you must replace an entire dataset by a single number $a$,
  and you want $a$ to be as close as possible to all the data at
  once. "As close as possible" has to be made precise, and there are
  two natural ways to measure total distance:
  $ S(a) = sum_(i=1)^n (x_i - a)^2
    quad "and" quad
    T(a) = sum_(i=1)^n abs(x_i - a). $

  The number minimizing $S$ is the mean. The number minimizing $T$ is
  the median.

  The first is worth verifying, because it takes three lines.
  Expanding,
  $ S(a) = sum x_i^2 - 2 a sum x_i + n dot a^2, $
  a quadratic in $a$ opening upward, so its minimum is at the vertex
  $ a = (sum x_i) / n = overline(x). $

  The second cannot be done by differentiating, since $abs(dot)$ has
  a corner --- but there is a direct argument. Standing at a point
  $a$ and stepping a little to the right, every observation to your
  left gets farther by that step and every observation to your right
  gets nearer by the same amount. The total $T$ therefore decreases
  exactly while more data lies to the right than to the left, and
  increases once the balance tips. The minimum is at the point with
  equal counts on both sides: the median.

  Note what this argument gives when $n$ is even. Between the two
  middle values the counts are equal everywhere, so $T$ is *constant*
  across that whole interval --- every point in it minimizes. The
  convention of taking the midpoint is exactly that: a convention,
  chosen to make the median a single well-defined number.
]

#look-ahead(preview: [variance and standard deviation])[
  The quantity $S(a) = sum (x_i - overline(x))^2$ just introduced is
  not going away. Its minimum value --- the total squared distance
  from the data to its own mean --- is, after dividing by $n$,
  precisely the definition of variance in the next chapter. So the
  mean and the standard deviation are not two separate ideas that
  happen to be used together: the standard deviation measures the
  amount by which the mean fails to describe the data.
]

== Doing It With a Calculator

#only-theory[
  Everything so far has been done by hand, deliberately. Doing it by
  hand a dozen times is what makes it obvious that the mean uses
  every value and the median uses two, which is the whole content of
  robustness. Once that is secure, there is no virtue in adding up
  fifty numbers by hand, and the calculator takes over.
]

// ── TEACHER'S NOTE ───────────────────────────────────────────
// The walkthrough below is written for the TI-30X Pro MathPrint in
// terms of NAMED MENUS (data editor, lists L1/L2/L3, 1-Var Stats,
// the DATA and FRQ fields, the stat-variable list) rather than
// keystrokes. That was deliberate -- the manual's key glyphs do not
// survive being quoted, and a wrong keystroke in a set of lecture
// notes is worse than none. Please check the exact key labels
// against a device and fill them in; the flow itself is right.
//
// The SPF adaptation for the TI-Nspire CAS is still to be written --
// the concepts and the Sx/sigma-x warning transfer unchanged, only
// the procedure differs.

#example(title: "One-Variable Statistics on the TI-30X Pro")[
  *Raw data.* Open the data editor and type the values into list L1,
  one per row. Then choose *1-Var Stats*, set DATA to L1 and FRQ to
  ONE (each value counted once), and confirm. The calculator displays
  a list of quantities; scroll through it.

  *From a frequency table.* This is where the calculator earns its
  keep. Put the *values* in L1 and their *frequencies* in L2, then
  set DATA to L1 and FRQ to L2. The age distribution from earlier in
  this chapter needs eight rows instead of fifty-one entries, and the
  calculator returns $overline(x) approx 24.8$ directly. You have
  computed a weighted mean without doing any weighting yourself.

  *What the display means.* Among the quantities shown:
  - $n$ --- the number of observations. Check this first, every
    time. If $n$ is wrong, everything after it is wrong, and a
    mistyped frequency is invisible in any other way.
  - $overline(x)$ --- the arithmetic mean.
  - $"Med"$ --- the median. Also $"minX"$, $"Q"_1$, $"Q"_3$,
    $"maxX"$, which belong to the next chapter.
  - $sum x$ --- the total of all values, which is $n dot overline(x)$
    and is what you need for any "total wage bill" question.
  - $S x$ and $sigma x$ --- two measures of spread. Ignore both for
    now. The next chapter explains why there are two of them and
    which one this course uses.
]

#warning[
  The calculator will not tell you the *mode*, and it will not tell
  you whether the mean is the sensible choice. It answers the
  question you typed, not the one you meant. Every judgment in this
  chapter --- is this distribution skewed, is the mean or the median
  the honest summary, is that outlier an error or a fact --- remains
  entirely yours.
]

#ex(difficulty: 1, time: "10 min")[
  Enter the age distribution from the worked example --- values 15,
  16, 17, 18, 19, 20, 65, 67 with frequencies 4, 12, 7, 17, 2, 1, 3,
  5 --- into your calculator as a frequency table.
  + Check that the calculator reports $n = 51$. If not, find the
    typing error before going on.
  + Read off $overline(x)$ and $"Med"$, and confirm they match the
    values computed by hand in the example.
  + Read off $sum x$. Explain what this number is in the context of
    the club, and check it against $n dot overline(x)$.
][
  + $n = 51$, matching the total of the frequency column. A wrong
    $n$ means a frequency was mistyped.
  + $overline(x) approx 24.804$ and $"Med" = 18$, agreeing with the
    example.
  + $sum x = #num(1265)$: the sum of the ages of all 51 members,
    in years. Check: $51 dot 24.804 approx #num(1265)$. ✓ On its own
    it is a strange quantity --- nobody needs the combined age of a
    tennis club --- but the same total for salaries is the annual
    wage bill, and for sales it is the revenue.
]

#ex(difficulty: 3, level: "high", time: "20 min", hints: (
  "Write down what you know as equations. If the mean of the first group is known and its size is known, what is the total of that group?",
  "The combined mean is the combined total divided by the combined count -- so work with totals, not with means, until the very end.",
  "For the last part, try a small case: two groups of very different sizes with very different means, and see what the plain average of the two means gives you.",
))[
  Class A has 18 students with a mean test score of 4.6. Class B has
  12 students with a mean of 5.1.
  + Find the mean score of all 30 students.
  + A teacher computes $(4.6 + 5.1)/2 = 4.85$ instead. Explain why
    this is wrong, and say whether it is too high or too low.
  + Under what condition would the teacher's method give the right
    answer?
  + Can you determine the median of the combined group from the
    information given? Justify your answer.
][
  + Work with totals. Class A contributes $18 dot 4.6 = 82.8$ and
    class B contributes $12 dot 5.1 = 61.2$, so the combined total is
    $144.0$ over $30$ students:
    $ overline(x) = 144.0 / 30 = 4.8. $
  + The teacher averaged the two means as though the classes were
    the same size, giving each class equal weight when class A has
    half as many students again as class B. The correct mean, $4.8$,
    is *lower* than $4.85$, because the larger class is the
    lower-scoring one and should count for more. The teacher's
    method is too high.
  + Exactly when the two groups are the same size. Then
    $ (n dot overline(x)_A + n dot overline(x)_B) / (2n)
      = (overline(x)_A + overline(x)_B) / 2, $
    and the two methods agree.
  + No. Medians do not combine --- knowing each group's middle value
    says nothing about the middle value of the merged, re-sorted
    list, since that depends on how the individual values interleave.
    This is the same asymmetry as before: the mean is recoverable
    from totals and counts, while the median needs the actual
    arrangement. #heuristic("try small cases")
]

#exploration(title: "Build a Dataset to Order")[
  Working backwards from a summary to the data is the fastest way to
  find out whether you understand the summary. For each of the
  following, construct a dataset satisfying the conditions, or
  explain why none exists.

  + Ten values with mean $50$ and median $20$.
  + Ten values with mean $20$ and median $50$.
  + Five values with mean $10$, median $10$, and mode $10$, that are
    not all equal to $10$.
  + Seven values whose mean is larger than six of the seven values.
  + A dataset whose mode is larger than its maximum.
  + Five whole numbers with mean $6$, median $6$, and range $20$.
  + Two datasets with identical mean, median, and mode, that look
    nothing alike when drawn.

  For the last one, draw both. Keep it --- the next chapter opens
  with exactly that problem.
]

#ai-box(role: "Checker")[
  Pick three of your answers from the exploration, including at
  least one you found difficult, and ask an AI assistant to verify
  that each dataset satisfies the stated conditions.

  Then check its checking. Compute the mean, median, and mode of each
  of your datasets yourself and compare. Assistants are reliable at
  arithmetic and much less reliable at noticing that a condition
  cannot be met at all --- so item 5 above is the interesting test.
  Give it that one and see whether it constructs an answer rather
  than telling you none exists.

  Report what happened. If it invented a dataset, work out where the
  invented one first goes wrong.
]

#print-hints()
#print-vocab()
