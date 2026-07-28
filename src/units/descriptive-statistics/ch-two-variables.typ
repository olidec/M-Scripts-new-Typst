#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Correlation and Regression")
#let ex = exercise.with(chapter: "Correlation and Regression")

// ── NOTE ON GATING ───────────────────────────────────────────
// This chapter is registered ONLY in main-high.typ, so the whole
// file is SPF material by construction. That is why nothing here is
// wrapped in only-high: the level gate is the chapter boundary, not
// a paragraph attribute. only-theory is still required, since the
// exercise sheet is built from this same file.

// ── Datasets ─────────────────────────────────────────────────

// Worked by hand in full. Chosen so every entry of the working table
// is an integer: Suu = 10, Svv = 74, Suv = 27, giving m = 2.7 exactly.
#let hand-x = (1, 2, 3, 4, 5)
#let hand-y = (3, 5, 8, 10, 14)

// Anscombe's Set II, reused from ch-association -- its residuals form
// a textbook arch.
#let ans2-x = (10, 8, 13, 9, 11, 14, 6, 4, 12, 7, 5)
#let ans2-resid = (
  (10, 1.139), (8, 1.139), (13, -0.761), (9, 1.269), (11, 0.759),
  (14, -1.901), (6, 0.129), (4, -1.901), (12, 0.129), (7, 0.759),
  (5, -0.761),
)

// Swiss weather stations: altitude in m, approximate long-term mean
// annual temperature in degrees C. Illustrative rather than official
// -- but close enough that the fitted slope recovers the atmospheric
// lapse rate, which is the point of the example.
#let alt-temp = (
  (316, 10.5), (556, 9.4), (553, 9.0), (454, 9.7),
  (556, 9.9), (1594, 3.5), (2502, -1.3), (3580, -7.2),
)

= Correlation and Regression

#only-theory[
  The previous chapter left two things deliberately vague. You drew a
  line of best fit by eye, and nobody said what "best" meant. Your
  calculator printed a number $r$, and nobody said what it was.

  Both are made precise here. Neither changes a word of the reasoning
  in that chapter: a correlation computed to four decimal places is
  exactly as silent about causation as one drawn by hand. What you
  gain is the ability to compute it, to say what it does and does not
  measure, and to recognize the situations where the number is
  meaningless even though the formula still returns a value.
]

#objectives(
  bfkm[compute the correlation coefficient $r$, and interpret its
    sign, its magnitude, and its limitations],
  bfkm[determine the equation of the regression line by the method
    of least squares, and use it to make and criticize predictions],
  [explain in what sense the regression line is "best", and derive
    its slope and intercept],
  [compute and plot residuals, and use a residual plot to judge
    whether a linear model is appropriate],
  [interpret the coefficient of determination $r^2$ as a proportion
    of variance, and state precisely what it does not mean],
)

== Standardizing

#only-theory[
  Before comparing two variables we have to deal with the fact that
  they are measured in different units. Altitude in metres and
  temperature in degrees are not comparable quantities, and any
  sensible measure of how they move together must not depend on
  whether we chose metres or kilometres.

  The device that solves this is worth knowing in its own right.
]

#definition(title: "The z-Score")[
  For a dataset with mean $overline(x)$ and standard deviation $s_x$,
  the #vocab("z-score", "z-Wert") of an observation is
  $ z_i = (x_i - overline(x)) / s_x. $

  It says how many standard deviations the observation lies above
  (positive) or below (negative) the mean.

  A $z$-score has no units: the numerator and denominator are both in
  the units of the original data, and they cancel. This makes
  observations from entirely different scales comparable.
]

#example(title: "Which Result Was Better?")[
  A student scores 72 on a mathematics test where the class mean was
  60 with $s = 8$, and 85 on a French test where the class mean was
  78 with $s = 12$.

  Raw scores say French. Standardizing says otherwise:
  $ z_"math" = (72 - 60) / 8 = 1.5, quad
    z_"French" = (85 - 78) / 12 approx 0.58. $

  Relative to the class, the mathematics result is much the stronger:
  one and a half standard deviations above the mean against a little
  over half of one. The raw scores were never comparable, because the
  two tests were not equally hard and the two classes were not
  equally spread.
]

#ex(difficulty: 1, time: "10 min")[
  A dataset has mean 50 and standard deviation 6.
  + Find the $z$-scores of the observations 59, 50, and 38.
  + An observation has $z = 2.5$. What is its value?
  + Explain why an observation with $z = 0$ is not necessarily
    typical, using an example.
][
  + $z = (59 - 50)/6 = 1.5$; $z = 0$; $z = (38 - 50)/6 = -2$.
  + $x = 50 + 2.5 dot 6 = 65$.
  + $z = 0$ only says the value equals the mean, and the mean need
    not be a typical value. In the bimodal club from the chapter on
    spread --- mean 35, with every member either 16 or under or 54
    and over --- a member aged 35 would have $z = 0$ and would be the
    least typical person there.
]

== The Correlation Coefficient

#only-theory[
  Now standardize both variables. If large values of $x$ tend to
  accompany large values of $y$, then $z_x$ and $z_y$ will usually
  have the same sign, and their product will usually be positive. If
  large $x$ accompanies small $y$, the product will usually be
  negative. If there is no pattern, positive and negative products
  will roughly cancel.

  Averaging those products is therefore a measure of association ---
  and it is exactly the number your calculator prints.
]

#definition(title: "Correlation Coefficient")[
  The #vocab("correlation coefficient", "Korrelationskoeffizient") is
  the mean of the products of the paired $z$-scores:
  $ r = 1/n sum_(i=1)^n
    ((x_i - overline(x)) / s_x) dot ((y_i - overline(y)) / s_y). $

  Writing $u_i = x_i - overline(x)$ and $v_i = y_i - overline(y)$ for
  the deviations, and cancelling the $n$ inside $s_x$ and $s_y$, this
  becomes the form used for computation:
  $ r = (sum u_i dot v_i) / sqrt((sum u_i^2) dot (sum v_i^2)). $
]

#keybox(title: "Properties of $r$")[
  - $-1 <= r <= 1$ always. The proof falls out of the next section.
  - $r > 0$ means positive association, $r < 0$ negative, $r approx 0$
    no *linear* association.
  - $r = plus.minus 1$ exactly when every point lies on one straight
    line.
  - $r$ has no units, and is unchanged if either variable is shifted
    or rescaled --- measuring altitude in kilometres instead of
    metres leaves $r$ alone.
  - $r$ is symmetric: swapping $x$ and $y$ does not change it. On its
    own it therefore cannot tell you which variable would be the
    predictor, still less which causes which.
]

#example(title: "Computing $r$ by Hand")[
  Five paired observations:

  #data-table(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    row-height: auto,
    [$x_i$], [1], [2], [3], [4], [5], [*sum*],
    [$y_i$], [3], [5], [8], [10], [14], [],
    [$u_i = x_i - 3$], [$-2$], [$-1$], [0], [1], [2], [0],
    [$v_i = y_i - 8$], [$-5$], [$-3$], [0], [2], [6], [0],
    [$u_i dot v_i$], [10], [3], [0], [2], [12], [*27*],
    [$u_i^2$], [4], [1], [0], [1], [4], [*10*],
    [$v_i^2$], [25], [9], [0], [4], [36], [*74*],
  )

  Here $overline(x) = 3$ and $overline(y) = 8$. Note the check built
  into the table: both deviation rows must sum to zero.

  $ r = 27 / sqrt(10 dot 74) = 27 / sqrt(740) approx 0.993. $

  A very strong positive association --- as the scatterplot would
  have suggested.
]

#warning[
  $r$ measures *linear* association and nothing else. Anscombe's
  Set II from the previous chapter has $r approx 0.82$, which sounds
  like good evidence of a straight-line relationship, and its points
  lie on a perfect curve. A high $r$ does not establish that a line
  is the right description, and a low $r$ does not establish that
  there is no relationship --- only that there is no *straight* one.

  This is why the rule is to plot first and compute second, not the
  other way round.
]

#ex(difficulty: 2, time: "15 min")[
  Compute $r$ for the following data, using a table like the one
  above.

  #align(center, text(size: 9.5pt, raw(
    "x:   2    4    6    8   10\n"
      + "y:   3    7    8   12   15",
  )))
][
  $overline(x) = 6$ and $overline(y) = 9$.

  #data-table(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    row-height: auto,
    [$u_i$], [$-4$], [$-2$], [0], [2], [4], [*0*],
    [$v_i$], [$-6$], [$-2$], [$-1$], [3], [6], [*0*],
    [$u_i v_i$], [24], [4], [0], [6], [24], [*58*],
    [$u_i^2$], [16], [4], [0], [4], [16], [*40*],
    [$v_i^2$], [36], [4], [1], [9], [36], [*86*],
  )

  $ r = 58 / sqrt(40 dot 86) = 58 / sqrt(3440) approx 0.989. $
]

== What "Best" Means

#only-theory[
  A line $y = m dot x + q$ predicts $hat(y)_i = m dot x_i + q$ for
  each observation. The prediction misses by $y_i - hat(y)_i$. The
  method of #vocab("least squares", "Methode der kleinsten Quadrate")
  chooses the line making the total of the *squared* misses as small
  as possible:
  $ S(m, q) = sum_(i=1)^n (y_i - m dot x_i - q)^2. $

  Squaring here does the same job it did for the variance: it removes
  signs, so that misses above and below cannot cancel, and it
  penalizes a few large misses more heavily than many small ones.
]

#only-theory[
  Minimizing $S$ over two variables at once looks hard, and is not,
  because a result from the chapter on measures of center does most
  of the work.

  *Step 1 --- find $q$.* Hold $m$ fixed and write
  $d_i = y_i - m dot x_i$. Then
  $ S = sum (d_i - q)^2, $
  which is exactly the quantity minimized by the *mean* of the
  $d_i$. So the best $q$ is
  $ q = overline(d) = overline(y) - m dot overline(x). $
  Rearranged, this says
  $overline(y) = m dot overline(x) + q$: *the regression line always
  passes through the point $(overline(x), overline(y))$*, whatever
  the slope turns out to be.

  *Step 2 --- find $m$.* Substituting that $q$ back,
  $ y_i - m dot x_i - q
    = (y_i - overline(y)) - m dot (x_i - overline(x))
    = v_i - m dot u_i, $
  so
  $ S(m) = sum (v_i - m dot u_i)^2
    = sum v_i^2 - 2 m sum u_i v_i + m^2 sum u_i^2. $
  This is a quadratic in $m$ opening upward, so its minimum sits at
  the vertex:
  $ m = (sum u_i v_i) / (sum u_i^2). $
]

#keybox(title: "The Regression Line")[
  $ m = (sum u_i dot v_i) / (sum u_i^2) = r dot s_y / s_x,
    quad quad q = overline(y) - m dot overline(x), $
  where $u_i = x_i - overline(x)$ and $v_i = y_i - overline(y)$.

  The line passes through $(overline(x), overline(y))$.
]

#remark[
  The second form of the slope, $m = r dot s_y / s_x$, is worth
  reading carefully. It says the slope is the correlation *scaled by
  the two spreads*. Since $abs(r) <= 1$, it follows that
  $abs(m) <= s_y / s_x$: the fitted line is always less steep than
  the line through the extremes would suggest. Predicted values are
  pulled toward $overline(y)$ --- which is where the word
  "regression" comes from, and it is a real effect, not an artifact.
]

#example(title: "The Regression Line for the Five Points")[
  From the table computed earlier, $sum u v = 27$ and
  $sum u^2 = 10$, with $overline(x) = 3$ and $overline(y) = 8$. So
  $ m = 27/10 = 2.7, quad q = 8 - 2.7 dot 3 = -0.1, $
  giving
  $ hat(y) = 2.7 dot x - 0.1. $

  Check that it passes through $(3, 8)$:
  $2.7 dot 3 - 0.1 = 8.0$. ✓
]

#ex(difficulty: 2, time: "20 min")[
  Use your table from the previous exercise, where $sum u v = 58$,
  $sum u^2 = 40$, $overline(x) = 6$ and $overline(y) = 9$.
  + Determine the equation of the regression line.
  + Verify that it passes through $(overline(x), overline(y))$.
  + Predict $y$ when $x = 7$.
  + The value $x = 25$ lies far outside the data. Compute the
    prediction anyway, then say what it is worth.
][
  + $m = 58/40 = 1.45$ and $q = 9 - 1.45 dot 6 = 0.3$, so
    $hat(y) = 1.45 dot x + 0.3$.
  + $1.45 dot 6 + 0.3 = 8.7 + 0.3 = 9 = overline(y)$. ✓
  + $hat(y) = 1.45 dot 7 + 0.3 = 10.45$. This is an interpolation,
    with data on both sides.
  + $hat(y) = 1.45 dot 25 + 0.3 = 36.55$. The arithmetic is
    faultless and the prediction is worth very little: $x = 25$ is
    two and a half times the largest observed value, and nothing in
    the data indicates that the linear pattern persists that far.
    The formula will always return a number; that is not the same as
    the number meaning something.
]

== Residuals

#definition(title: "Residual")[
  The #vocab("residual", "Residuum") of an observation is what the
  line failed to account for:
  $ e_i = y_i - hat(y)_i = y_i - (m dot x_i + q). $

  Residuals always sum to zero --- that is a consequence of choosing
  $q = overline(y) - m dot overline(x)$ --- so their total tells you
  nothing. Their *pattern* tells you a great deal.
]

#only-theory[
  A #emph[residual plot] graphs $e_i$ against $x_i$. If a straight
  line is the right description, the residuals should look like
  structureless scatter about zero: no curve, no trend, no widening.
  Anything else is the data reporting that the model is wrong.

  Three patterns are worth recognizing:

  / A curve or arch: the true relationship is not linear. The line
    is systematically too high in one region and too low in another.
  / A funnel: the spread of the residuals grows with $x$. The line
    may be fine, but predictions are far less reliable at one end
    than the other, and a single quoted accuracy would be
    misleading.
  / One extreme residual: a single point the model fits badly.
    Worth investigating, especially if it is also extreme in $x$,
    because such points can drag the whole line toward themselves.
]

#example(title: "A Residual Plot That Fails")[
  Anscombe's Set II from the previous chapter --- the one with
  $r approx 0.82$ whose points lie on a clean curve. Fitting the
  regression line and plotting the residuals:

  #align(center, plot(
    xmin: 3, xmax: 15, ymin: -2.5, ymax: 2,
    width: 8cm, height: 4.5cm,
    show-grid: "major",
    data(
      ans2-resid,
      mark: "*", mark-fill: accent, mark-stroke: accent,
      mark-size: 0.1,
    ),
  ))

  The residuals trace a perfect arch: strongly negative at both ends,
  positive through the middle. This is not scatter. The line is
  underestimating in the middle of the range and overestimating at
  both extremes, exactly as a straight line must when the truth is a
  curve.

  Note what has happened. The correlation $r approx 0.82$ gave no
  warning at all. The residual plot makes the failure impossible to
  miss --- which is why it is the standard check after any fit.
]

#ex(difficulty: 2, time: "15 min")[
  For the five points $x = 1, 2, 3, 4, 5$ and $y = 3, 5, 8, 10, 14$,
  the regression line is $hat(y) = 2.7 dot x - 0.1$.
  + Compute all five residuals.
  + Verify that they sum to zero.
  + Do they show any pattern suggesting the linear model is
    inappropriate?
][
  + Predictions are $2.6, 5.3, 8.0, 10.7, 13.4$, so the residuals
    $e_i = y_i - hat(y)_i$ are
    $ 0.4, quad -0.3, quad 0.0, quad -0.7, quad 0.6. $
  + $0.4 - 0.3 + 0.0 - 0.7 + 0.6 = 0$. ✓
  + No systematic pattern is visible --- the signs alternate
    irregularly and the magnitudes are similar across the range. With
    only five points, though, very little could be detected either
    way: a residual plot is a weak instrument on small datasets, and
    finding no pattern in five points is not evidence that none
    exists.
]

== How Much Is Explained

#only-theory[
  One loose end remains from the derivation. Substituting the optimal
  slope $m = (sum u v) / (sum u^2)$ back into $S(m)$ gives the
  smallest achievable total squared error:
  $ S_"min" = sum v_i^2 - (sum u_i v_i)^2 / (sum u_i^2). $

  Now recall that $r^2 = (sum u v)^2 / ((sum u^2)(sum v^2))$, so
  $(sum u v)^2 / (sum u^2) = r^2 dot sum v^2$, and therefore
  $ S_"min" = sum v_i^2 dot (1 - r^2). $

  Two consequences follow immediately, and both are worth having.
]

#keybox(title: "Two Consequences")[
  *First, $abs(r) <= 1$.* $S_"min"$ is a sum of squares, so
  $S_"min" >= 0$; and $sum v^2 > 0$ for any data that is not all
  identical. Hence $1 - r^2 >= 0$, which is to say $r^2 <= 1$ and
  $-1 <= r <= 1$. The bound is not an extra assumption --- it is
  forced by the fact that a sum of squares cannot be negative.

  *Second, $r^2$ has a meaning.* Rearranging,
  $ r^2 = 1 - S_"min" / (sum v_i^2)
    = 1 - "leftover variation" / "total variation". $
  The quantity $r^2$, called the
  #vocab("coefficient of determination", "Bestimmtheitsmass"), is
  the proportion of the variation in $y$ that the line accounts for.
  An $r^2$ of $0.85$ says the line accounts for 85% of the variation,
  and 15% remains.
]

#warning[
  "Explained" is a technical term here and it is routinely
  overinterpreted. $r^2 = 0.85$ does *not* mean that $x$ causes 85%
  of $y$, nor that predictions will be right 85% of the time. It is a
  statement about how much of the spread in $y$ the fitted line
  accounts for, and nothing more. Every caution from the previous
  chapter still applies to a model with $r^2 = 0.99$.

  A high $r^2$ with an arched residual plot --- Anscombe's Set II
  again --- means the line accounts for a lot of the variation and
  is still the wrong model.
]

#ex(difficulty: 2, time: "15 min")[
  For a dataset of 20 paired observations, $sum v_i^2 = 480$ and the
  fitted line leaves $S_"min" = 72$.
  + Compute $r^2$ and $r$. Can you determine the sign of $r$?
  + What proportion of the variation in $y$ is not accounted for?
  + A second dataset has $r = -0.9$. Which of the two fits accounts
    for more of the variation in $y$?
][
  + $r^2 = 1 - 72/480 = 1 - 0.15 = 0.85$, so
    $abs(r) = sqrt(0.85) approx 0.922$. The sign cannot be
    determined: $r^2$ discards it, and both a strong positive and a
    strong negative association give the same $r^2$. You would need
    the sign of $sum u v$, or the scatterplot.
  + $15%$.
  + The second: $r = -0.9$ gives $r^2 = 0.81$, against $0.85$ for
    the first. The negative sign is irrelevant to this comparison
    --- it describes direction, not quality of fit.
]

#ex(difficulty: 3, time: "25 min", keep-together: true, hints: (
  "Write down the slope for each of the two fits. The first predicts y from x; the second swaps the roles, so which deviation sum goes on the bottom?",
  "Multiply the two slopes together and compare what you get with the formula for r squared.",
  "For the last part: if the two lines were the same line, what would the product of their slopes have to be?",
))[
  Fitting $y$ from $x$ gives a slope $m_1 = (sum u v) / (sum u^2)$.
  One could equally fit $x$ from $y$, obtaining a line
  $hat(x) = m_2 dot y + c$ with slope $m_2 = (sum u v) / (sum v^2)$.
  + Show that $m_1 dot m_2 = r^2$.
  + Verify this for the five points $x = 1, dots, 5$,
    $y = 3, 5, 8, 10, 14$, where $sum u v = 27$, $sum u^2 = 10$ and
    $sum v^2 = 74$.
  + Explain why the two lines are different lines, even though both
    describe "the relationship between $x$ and $y$", and say what
    that means for the habit of calling one variable the cause.
  + Under what condition do the two lines coincide? Interpret that
    condition.
][
  + Multiplying,
    $ m_1 dot m_2 = (sum u v) / (sum u^2) dot (sum u v) / (sum v^2)
      = (sum u v)^2 / ((sum u^2)(sum v^2)) = r^2, $
    since the last expression is exactly the definition of $r^2$.
  + $m_1 = 27/10 = 2.7$ and $m_2 = 27/74 approx 0.3649$, so
    $m_1 dot m_2 approx 0.9851$. And $r approx 0.9925$ gives
    $r^2 approx 0.9851$. ✓
  + Because least squares minimizes the squared errors *in the
    direction of the variable being predicted*: the first line makes
    vertical misses small, the second makes horizontal ones small.
    Those are different criteria, so they give different lines.

    The consequence is that the regression line is *asymmetric* while
    $r$ is symmetric. Choosing which variable to predict is a
    modelling decision you bring to the data --- the data does not
    contain it. So the direction of a fitted line reflects your
    choice of roles, never a discovered direction of influence, and
    the previous chapter's warning survives intact.
  + Only when $m_1 dot m_2 = 1$, that is $r^2 = 1$, that is
    $r = plus.minus 1$ --- exactly when every point lies on a single
    straight line. Whenever there is any scatter at all the two
    lines differ, and they differ more the weaker the correlation.
    #heuristic("check an extreme or special case")
]

== A Real Fit

#example(title: "Altitude and Temperature")[
  Approximate long-term mean annual temperatures at eight Swiss
  weather stations, against the altitude of the station:

  #align(center, plot(
    xmin: 0, xmax: 4000, ymin: -10, ymax: 14,
    width: 8.5cm, height: 5.5cm,
    show-grid: "major",
    data(
      alt-temp,
      mark: "*", mark-fill: accent, mark-stroke: accent,
      mark-size: 0.1,
    ),
  ))

  The fit gives
  $ hat(y) = -0.00546 dot x + 12.34, quad r approx -0.999,
    quad r^2 approx 0.998. $

  *Reading the slope.* Per metre of altitude the temperature falls by
  about $0.00546 degree$C, which is easier to state per 100 metres:
  roughly $0.55 degree$C colder for every 100 m climbed. That is not
  merely a number produced by a formula --- it is close to the
  atmospheric lapse rate, the rate at which air cools with height,
  which is around $0.6 degree$C per 100 m. The regression has
  recovered a physical constant from eight weather stations.

  *Reading the intercept.* At $x = 0$, the model predicts
  $12.34 degree$C at sea level. Switzerland has no sea-level weather
  station, so this is an extrapolation --- a modest one, and
  plausible, but not something the data establishes.

  *Reading $r^2$.* Altitude accounts for 99.8% of the variation in
  mean temperature across these stations. Almost nothing else
  matters at this scale, which is why the points sit so tightly on
  the line.
]

#ex(difficulty: 2, time: "15 min")[
  Using the fitted model $hat(y) = -0.00546 dot x + 12.34$:
  + Predict the mean annual temperature at 1000 m.
  + The summit of the Dufourspitze is at 4634 m. Compute the
    prediction, then give two reasons to treat it with caution.
  + The station at Chur (556 m) has an actual mean of
    $9.9 degree$C. Compute its residual and interpret the sign.
  + $r approx -0.999$ is close to the strongest possible value.
    Does this establish that altitude *causes* the temperature
    difference? What would?
][
  + $-0.00546 dot 1000 + 12.34 approx 6.9 degree$C.
  + $-0.00546 dot 4634 + 12.34 approx -13 degree$C. Caution on two
    counts: it is an extrapolation about 1000 m beyond the highest
    station, and a summit is not a valley floor --- exposure, wind,
    and snow cover make a peak behave differently from a station at
    the same altitude on a slope. The linear pattern is being
    stretched past both its data and its physical setting.
  + $hat(y) = -0.00546 dot 556 + 12.34 approx 9.30$, so
    $e = 9.9 - 9.30 approx +0.6 degree$C. Chur is warmer than
    altitude alone predicts --- consistent with its sheltered
    position in the Rhine valley.
  + No. $r$ measures how tightly the points follow a line, and
    nothing about direction of influence --- it would be identical
    with the axes swapped, which would absurdly suggest temperature
    causes altitude. What settles it here is a *mechanism*: the
    physics of air expanding and cooling as it rises is independently
    established, and it predicts the slope we observe. Causal claims
    are won by mechanism or by experiment, never by $r$.
]

== On the Calculator

// ── TEACHER'S NOTE ───────────────────────────────────────────
// Written at the level of NAMED MENUS for the TI-Nspire CAS, since
// the exact key sequences need checking on a device and a wrong
// keystroke in lecture notes is worse than none. The workflow
// (Lists & Spreadsheet -> named columns -> Statistics -> Stat
// Calculations -> Linear Regression) is right; please confirm the
// labels and the exact menu path.

#example(title: "Linear Regression on the TI-Nspire CAS")[
  Open a *Lists & Spreadsheet* page and enter the two variables in
  adjacent columns, giving each column a name at the top --- say
  `alt` and `temp`. Naming them matters: the regression dialog asks
  for lists by name.

  Then from the statistics menu choose *Stat Calculations* and
  *Linear Regression ($m x + b$)*, and set the X List and Y List to
  your two columns. The output includes:
  - $m$ and $b$ --- the slope and intercept of the regression line;
  - $r$ --- the correlation coefficient;
  - $r^2$ --- the coefficient of determination;
  - a *RegEqn* entry holding the equation itself, which can be
    pasted onto a graph over the scatterplot.

  Plotting the scatter and the regression line together, and then
  the residuals, takes a few seconds and should be automatic after
  every fit. The calculator will fit a line to anything --- to
  Anscombe's Set II, to a circle, to noise --- and report a slope
  with four decimal places each time.
]

#exploration(title: "Break the Correlation Coefficient")[
  Your task is to build datasets that make $r$ report something
  misleading, and then to say what would have caught you out.

  + Construct a dataset of at least eight points with $r > 0.9$ for
    which a straight line is clearly the wrong model. What does its
    residual plot look like?
  + Construct a dataset of ten points with $r approx 0$ in which
    there is nevertheless an obvious, strong relationship between
    the two variables.
  + Start from a dataset with $r approx 0$ and add a *single* point
    that pushes $r$ above $0.8$. How far out did it have to be?
  + Take any dataset with a strong correlation and split it into two
    subgroups so that the correlation within each subgroup is much
    weaker than the correlation overall. What is this an instance
    of?

  For each one, name the single diagnostic that would have exposed
  the problem. In at least three of the four, it is the same
  diagnostic.
]

#ai-box(role: "Generator")[
  Ask an AI assistant to generate a dataset of twelve paired values
  with a correlation coefficient of approximately $0.7$.

  Then compute $r$ yourself from what it produces.

  This is a task assistants are unreliable at in a specific and
  instructive way: producing text that *describes* a correlation is
  easy, and producing numbers that *have* one requires actual
  computation. Record the value you get. If it is close, ask for
  $r = -0.35$ and check again; if it is close again, ask for a
  dataset with $r approx 0.7$ whose residual plot shows clear
  curvature, which requires holding two conditions at once.

  Report where it broke down, and whether it noticed.
]

#look-ahead(preview: [inferential statistics])[
  Every number in this unit has described the data in front of you.
  Not one has said anything about a wider population --- and that is
  usually the question people actually care about. A correlation of
  $0.7$ in a sample of twelve is entirely compatible with no
  relationship at all in the population it came from; the same $0.7$
  in a sample of ten thousand is not.

  Turning a description into a defensible claim about a population is
  a different subject, with its own machinery: sampling
  distributions, confidence intervals, significance. That is where
  the $n - 1$ in the sample standard deviation finally earns its
  keep, and where the very first chapter of this unit --- population
  and sample, parameter and statistic --- turns out to have been the
  foundation all along.
]

#print-hints()
#print-vocab()
