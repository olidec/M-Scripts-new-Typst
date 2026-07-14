#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Mathematical Modeling")
#let ex = exercise.with(chapter: "Mathematical Modeling")

= Mathematical Modeling

#only-theory[
  A #vocab("mathematical model", "mathematisches Modell") is a
  function chosen to describe a real situation closely enough to be
  useful -- close enough to answer a question, predict a value, or
  reveal a pattern, even though no formula ever captures reality
  perfectly. The hardest part is rarely the algebra; it's recognizing
  *which* function family actually fits the situation in front of
  you. This chapter is about building that instinct.
]

#objectives(
  bfkm[match a real-world situation to the function family (linear,
    quadratic, power, exponential, or logarithmic) that models it],
  bfkm[recognize a model's type directly from a table of data, using
    constant differences and constant ratios],
  bfkm[determine a model's parameters from given data and use it to
    predict new values],
  [distinguish interpolation from extrapolation, and judge which
    predictions a model can be trusted for],
)

== The Modeling Toolkit

#only-theory[
  Five function families cover the overwhelming majority of models
  you'll meet -- all five are ones you already know how to solve
  equations with.
]

#data-table(
  columns: (auto, auto, 1fr),
  row-height: auto,
  [Model],
  [Equation],
  [Typical uses],
  [Linear],
  [$y = m dot x + b$],
  [Constant rate: fixed cost +
    per-unit cost, constant speed, simple conversions.],
  [Quadratic],
  [$y = a dot x^2 + b dot x + c$],
  [Projectile motion,
    area and revenue optimization.],
  [Power],
  [$y = a dot x^n$],
  [Geometric scaling (area $prop$
    $"length"^2$, volume $prop$ $"length"^3$), inverse-square laws,
    biological scaling.],
  [Exponential],
  [$y = a dot b^x$],
  [Population growth, radioactive
    decay, compound interest, cooling and heating.],
  [Logarithmic],
  [$y = a + b log(x)$],
  [Diminishing returns as input
    grows: perceived loudness and brightness, pH, magnitude scales.],
)

== Recognizing a Model from Data

#only-theory[
  Given only a table of $(x,y)$ values -- no formula -- you can often
  tell which family fits just by looking at how $y$ changes as $x$
  increases in equal steps.
]

#keybox(title: "Three Tests")[
  For $x$-values spaced evenly apart:
  - *Constant first differences* ($Delta y$ the same every step)
    $=>$ *linear*. The constant difference is the slope $m$.
  - *Constant second differences* (the differences *of* the
    differences are the same every step) $=>$ *quadratic*.
  - *Constant ratios* ($y$ divided by the previous $y$ is the same
    every step) $=>$ *exponential*. The constant ratio is the growth
    factor $b$.
]

#example[
  #data-table(
    columns: (auto, auto, auto, auto, auto),
    row-height: auto,
    [$x$],
    [$1$],
    [$2$],
    [$3$],
    [$4$],
    [$y$],
    [$3$],
    [$7$],
    [$11$],
    [$15$],
  )
  The differences $7-3$, $11-7$, $15-11$ are all $4$ -- constant, so
  this is *linear* with slope $4$. Since $y=3$ at $x=1$: $y=4x-1$.
]

#example[
  #data-table(
    columns: (auto, auto, auto, auto, auto),
    row-height: auto,
    [$x$],
    [$0$],
    [$1$],
    [$2$],
    [$3$],
    [$y$],
    [$2$],
    [$5$],
    [$10$],
    [$17$],
  )
  First differences: $3, med 5, med 7$ -- not constant. Second
  differences: $5-3=2$ and $7-5=2$ -- constant, so this is
  *quadratic*. Fitting $y = a dot x^2 + b dot x + c$ to the first
  three points gives $y = x^2 + 2x + 2$ (check at $x=3$:
  $9+6+2=17$, which matches).
]

#example[
  #data-table(
    columns: (auto, auto, auto, auto, auto),
    row-height: auto,
    [$x$],
    [$0$],
    [$1$],
    [$2$],
    [$3$],
    [$y$],
    [$5$],
    [$10$],
    [$20$],
    [$40$],
  )
  Each $y$-value is exactly double the one before it -- a constant
  *ratio* of $2$, so this is *exponential* with growth factor $2$.
  Since $y=5$ at $x=0$: $y = 5 dot 2^x$.
]

#keybox(title: "Interpolation vs. Extrapolation")[
  Using a model to predict a $y$-value *between* data points you
  already have is #vocab("interpolation", "Interpolation") --
  usually safe. Using it to predict *beyond* the range of your data
  is #vocab("extrapolation", "Extrapolation") -- riskier, since
  nothing guarantees the same pattern continues forever. (A model of
  a population's growth might fit perfectly for ten years and still
  fail wildly for a hundred, once resources run out.)
]

== Linear Models

#example[
  A taxi charges a flat CHF 6, plus CHF 2.20 per kilometer. How far
  can you travel for CHF 30?
  $
    C(d) = 6 + 2.2 d quad => quad 30 = 6 + 2.2 d quad => quad
    d = 24/2.2 approx 10.9 "km."
  $
]

#ex(difficulty: 1, time: "15 min")[
  A phone plan costs CHF 45 for 100 minutes of calls, and CHF 65 for
  300 minutes. Assume cost is a linear function of minutes used.
  + Find the plan's fixed monthly fee and its per-minute rate.
  + How much would 500 minutes cost?
][
  + The rate is the slope: $(65-45)/(300-100) = 20/200 = 0.1$
    CHF/min. The fixed fee: $45 = "fee" + 0.1 dot 100 => "fee" =
    35$ CHF.
  + $C(500) = 35 + 0.1 dot 500 = 85$ CHF.
]

== Quadratic Models

#example[
  A vendor sells game-day programs at CHF 5 each and sells 200 of
  them. Market research shows that for every CHF 1 price increase,
  20 fewer programs sell. What price maximizes revenue?

  Let $x$ be the number of CHF 1 increases. Then price $=5+x$ and
  quantity sold $=200-20x$, so revenue is
  $ R(x) = (5+x) dot (200-20x) = -20x^2 + 100x + 1000. $
  This is a downward-opening parabola, maximized at its vertex:
  $ x = -100/(2 dot (-20)) = 2.5 . $
  So the best price is $5+2.5=7.50$ CHF, selling $200-50=150$
  programs, for a maximum revenue of $7.50 dot 150 = 1125$ CHF.
]

#ex(difficulty: 2, time: "20 min", keep-together: true)[
  A bakery sells cupcakes at CHF 3 each and sells 150 per day. For
  every CHF 0.50 price increase, 15 fewer cupcakes sell per day.
  + Write the revenue $R(x)$ as a function of the number of CHF 0.50
    increases, $x$.
  + Find the price that maximizes daily revenue, and the maximum
    revenue.
][
  + $R(x) = (3+0.5x) dot (150-15x) = -7.5x^2 + 30x + 450$.
  + Vertex at $x = -30/(2 dot (-7.5)) = 2$, so the best price is
    $3+1=4$ CHF, selling $150-30=120$ cupcakes, for a maximum
    revenue of $4 dot 120 = 480$ CHF.
]

== Power Models

#only-theory[
  Power functions describe how one quantity scales when another one
  does -- not by a fixed amount, and not by a fixed percentage, but
  by a fixed *exponent*.
]

#example[
  #vocab("Kepler's third law", "drittes Keplersches Gesetz") relates
  a planet's orbital period $T$ (in years) to its distance from the
  Sun $r$ (in astronomical units, where Earth's distance is exactly
  $1$ AU): $T = r^(1.5)$.

  Mars orbits at $r=1.524$ AU. Its orbital period is
  $ T = 1.524^(1.5) approx 1.88 "years." $
  (The true value is $1.88$ years -- Kepler's law, from 1619, still
  holds.)
]

#ex(difficulty: 2, time: "15 min")[
  A light source has an intensity of $100$ lux at a distance of $2$
  meters. Light intensity follows an inverse-square law,
  $I(d) = k/d^2$.
  + Find $k$.
  + What is the intensity at $5$ meters?
][
  + $100 = k/2^2 => k = 400$.
  + $I(5) = 400/5^2 = 16$ lux.
]

== Exponential Models

#only-theory[
  Population growth and radioactive decay both move toward *zero*
  (or toward unbounded growth). But not every exponential process
  decays to zero -- Newton's law of cooling describes an object's
  temperature decaying *toward the surrounding temperature*, not
  toward $0$.
]

#definition(title: "Newton's Law of Cooling")[
  An object starting at temperature $T_0$ in surroundings at
  temperature $T_"amb"$ has temperature at time $t$ given by
  $ T(t) = T_"amb" + (T_0 - T_"amb") dot b^t, $
  for some growth factor $0 < b < 1$.
]

#example[
  A cup of coffee is poured at 90°C into a 20°C room. After 10
  minutes it has cooled to 70°C. Predict its temperature after 20
  minutes.

  Here $T_"amb" = 20$ and $T_0 = 90$, so
  $ T(t) = 20 + 70 dot b^t . $
  From $T(10) = 70$: $70 = 20 + 70 dot b^(10) => b^(10) = 5/7$.
  Rather than solving for $b$ itself, notice $20$ minutes is *twice*
  $10$ minutes, so $b^(20) = (b^(10))^2$:
  $ T(20) = 20 + 70 dot (5/7)^2 approx 55.7 . $
  The coffee has cooled to about 55.7°C.
]

#ex(difficulty: 2, time: "15 min")[
  A metal rod at 150°C is placed in a 25°C room. After 5 minutes it
  has cooled to 100°C. Predict its temperature after 15 minutes,
  using the same squaring trick as the example (this time, cubing).
][
  $T(t) = 25 + 125 dot b^t$, with $b^5 = (100-25)/125 = 3/5$ from
  the data. Since $15 = 3 dot 5$: $b^(15) = (b^5)^3$, so
  $ T(15) = 25 + 125 dot (3/5)^3 = 25 + 27 = 52 . $
  The rod has cooled to 52°C.
]

== Logarithmic Models

#only-theory[
  Logarithmic models describe *diminishing returns*: a quantity that
  keeps growing, but more and more slowly. Human perception often
  works this way -- the
  #vocab("Weber-Fechner law", "Weber-Fechner-Gesetz") observes that
  perceived sensation grows roughly with the *logarithm* of actual
  physical intensity, not with the intensity itself. That's exactly
  why sound is measured in decibels and earthquakes on the Richter
  scale, rather than in raw physical units -- a logarithmic scale
  matches how we actually experience these things.
]

#ex(difficulty: 2, time: "10 min")[
  By convention, every $10$ dB increase in sound level corresponds to
  a sound perceived as *twice* as loud. How many more decibels would
  make a sound seem *four* times as loud as the original?
][
  Twice as loud needs $+10$ dB; four times as loud is two doublings
  in a row, so it needs $2 dot 10 = 20$ dB more.
]

== Choosing the Right Model

#only-theory[
  The exercises below don't tell you which model to use -- that's
  the point. Use the difference/ratio tests where you have a data
  table, and think about the situation itself otherwise.
]

#ex(difficulty: 2, time: "15 min", keep-together: true)[
  For each table, decide whether the data is linear, quadratic, or
  exponential, and find its equation.
  #data-table(
    columns: (auto, auto, auto, auto, auto),
    row-height: auto,
    [$x$],
    [$2$],
    [$4$],
    [$6$],
    [$8$],
    [$y$],
    [$9$],
    [$17$],
    [$25$],
    [$33$],
  )
  #data-table(
    columns: (auto, auto, auto, auto, auto),
    row-height: auto,
    [$x$],
    [$0$],
    [$2$],
    [$4$],
    [$6$],
    [$y$],
    [$1$],
    [$9$],
    [$33$],
    [$73$],
  )
  #data-table(
    columns: (auto, auto, auto, auto, auto),
    row-height: auto,
    [$x$],
    [$0$],
    [$1$],
    [$2$],
    [$3$],
    [$y$],
    [$8$],
    [$4$],
    [$2$],
    [$1$],
  )
][
  + Differences: $8, 8, 8$ (for each step of $2$ in $x$), so
    *linear* with slope $8/2 = 4$: $y = 4x + 1$.
  + First differences: $8, 24, 40$; second differences: $16, 16$
    (constant) -- *quadratic*: $y = 2x^2 + 1$.
  + Ratios: $0.5, 0.5, 0.5$ -- *exponential decay*:
    $y = 8 dot 0.5^x$.
]

#ex(difficulty: 1, time: "10 min")[
  Which model family best fits each situation? You don't need to
  find the equation -- just name the family.
  #parts(
    2,
    [(a) A bacterial culture doubles in size every 3 hours.],
    [(b) A ball is thrown into the air; its height is tracked over
      time.],
    [(c) A shipping company charges CHF 5 plus CHF 0.75 per kg.],
    [(d) The gravitational force between two objects, as a function
      of the distance between them.],
  )
][
  #parts(
    2,
    [(a) exponential],
    [(b) quadratic],
    [(c) linear],
    [(d) power (inverse-square)],
  )
]

#look-ahead(preview: [statistics and regression])[
  Every dataset in this chapter was suspiciously perfect -- the
  differences or ratios were *exactly* constant. Real data never
  behaves this well: measurement error and natural variation mean
  the points won't line up exactly on any curve. Finding the
  *best-fitting* model for messy, real data -- rather than the exact
  model for suspiciously clean data -- is exactly what regression,
  in statistics, is for.
]

#print-hints()
#print-vocab()
