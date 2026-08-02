#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Exponential Functions and Models")
#let ex = exercise.with(chapter: "Exponential Functions and Models")

= Exponential Functions and Models

#only-theory[
  Power functions like $x^2$ or $x^(-1)$ keep the exponent fixed and
  let the base vary. Now we flip that around: keep the *base* fixed
  and let the *exponent* vary. The result -- exponential functions --
  is the natural language for anything that grows or shrinks by a
  fixed *percentage* over and over: populations, investments,
  radioactive decay, epidemics.
]

#objectives(
  bfkm[model growth and decay processes with exponential functions
    $f(x) = a dot b^x$],
  bfkm[convert between a percentage growth or decay rate and a
    growth factor $b$],
  [describe how shifts and reflections affect the graph of an
    exponential function],
  [explain why a horizontal shift of an exponential is a vertical
    stretch, and why a horizontal stretch is a change of base],
  bfkm[convert a growth factor between time units using
    $b^(k t) = (b^k)^t$],
  [determine the equation of an exponential function from two given
    points on its graph],
  [solve applied growth and decay problems, including half-life],
)

== Growth and Decay

#definition(title: "Exponential Function")[
  $ f(x) = a dot b^x, quad b > 0 $
  is an #vocab("exponential function", "Exponentialfunktion"). Since
  these functions usually model something changing over *time*, we
  often write $t$ instead of $x$:
  $ f(t) = a dot b^t . $
]

#exploration(title: "Six Bases, One Family")[
  Use a graphing tool to draw $f(t) = b^t$ for
  $ b = 2, med 4, med 10, med 1/2, med 1/4, med 1/10 . $
  + What do the graphs look like for $b > 1$?
  + What do the graphs look like for $0 < b < 1$?
  + What would happen if $b = 1$?
  + What are the domain and range of these functions?
]

#keybox(title: "Growth vs. Decay")[
  For $f(t) = a dot b^t$ with $a > 0$:
  - $b > 1$: *exponential growth* -- the function increases, getting
    steeper and steeper.
  - $0 < b < 1$: *exponential decay* -- the function decreases,
    flattening out toward $0$ but never reaching it. The $t$‑axis is
    an asymptote.
  - $b = 1$: a constant function, $f(t) = a$ for all $t$.
  - The domain is all real numbers; the range is $(0, infinity)$ (for
    $a > 0$).
]

#only-theory[
  #fig(
    plot-graph(
      x => calc.pow(2.0, x),
      (fn: x => calc.pow(4.0, x), color: warn-col),
      (fn: x => calc.pow(0.5, x), color: def-col),
      (fn: x => 1.0, color: luma(150)),
      xmin: -3.5,
      xmax: 3.5,
      ymin: -0.5,
      ymax: 8.5,
      size: 7,
      grid-step: 1,
    ),
    caption: [$y = 2^t$ (teal), $y = 4^t$ (orange), $y = 0.5^t$ (blue),
      and the constant $y = 1$. Every curve passes through $(0,1)$,
      because $b^0 = 1$ whatever $b$ is. Growth and decay are mirror
      images: $0.5^t = 2^(-t)$.],
  )
]

#example[
  Caffeine breaks down in the blood at a rate of $15%$ per hour. If
  you drink a coffee containing $40$ mg of caffeine, how much is left
  after one hour? After six hours?

  Losing $15%$ each hour means $85%$ remains, so the growth factor is
  $b = 1 - 0.15 = 0.85$.
  $ "after 1 hour:" quad 40 dot 0.85^1 = 34 "mg" $
  $ "after 6 hours:" quad 40 dot 0.85^6 approx 15.1 "mg" $
]

#only-theory[
  It is worth seeing early how violent exponential growth is compared
  with the power functions of the previous chapter. Below, $y = x^2$
  and $y = 2^x$ are plotted together.
]

#only-theory[
  #fig(
    plot-graph(
      x => x * x,
      (fn: x => calc.pow(2.0, x), color: warn-col),
      xmin: -1.5,
      xmax: 5.5,
      ymin: -1.5,
      ymax: 20.5,
      size: 7,
      grid-step: 2,
    ),
    caption: [$y = x^2$ (teal) and $y = 2^x$ (orange). They cross at
      $x = 2$ and again at $x = 4$ -- between those points the
      parabola is *ahead*. After $x = 4$ the exponential pulls away
      and never looks back.],
  )
]

#remark[
  That picture is the whole reason exponential models are treated
  separately. A power function multiplies its input by itself a fixed
  number of times; an exponential multiplies its *output* by a fixed
  number, over and over. Beyond some point -- here $x = 4$ -- the
  second always wins, no matter how large the exponent in the power
  function is. It is also why the parabola winning on $2 < x < 4$
  fools people: a short stretch of data is not enough to tell the two
  apart. #heuristic("check an extreme or special case")
]

== Growth Factors

#only-theory[
  The number $b$ in $f(t) = a dot b^t$ is the
  #vocab("growth factor", "Wachstumsfaktor"). It's directly related
  to a percentage growth or decay rate:
  $ b = 1 + p, $
  where $p$ is the rate written as a decimal ($p>0$ for growth,
  $p<0$ for decay).
]

#ex(difficulty: 1, time: "15 min", keep-together: true)[
  + Find the growth factor $b$ for each rate.
    #parts(
      3,
      [(a) 7% growth],
      [(b) 0.9% growth],
      [(c) 5% decrease],
      [(d) 7.5% decrease],
      [(e) 250% growth],
      [(f) 0.5% decrease],
    )
  + What percentage increase or decrease does each growth factor
    represent?
    #parts(
      4,
      [(a) $b = 1.03$],
      [(b) $b = 1.8$],
      [(c) $b = 0.95$],
      [(d) $b = 2.5$],
      [(e) $b = 0.5$],
      [(f) $b = 0.995$],
      [(g) $b = 1.025$],
      [(h) $b = 0.8$],
    )
][
  + #parts(
      3,
      [(a) $b = 1.07$], [(b) $b = 1.009$], [(c) $b = 0.95$],
      [(d) $b = 0.925$], [(e) $b = 3.5$], [(f) $b = 0.995$],
    )
  + #parts(
      4,
      [(a) 3% increase], [(b) 80% increase], [(c) 5% decrease],
      [(d) 150% increase], [(e) 50% decrease], [(f) 0.5% decrease],
      [(g) 2.5% increase], [(h) 20% decrease],
    )
]

#ai-box(role: "Checker")[
  Pick one growth-factor conversion from the exercise above. Solve it
  yourself first, then ask an AI to convert the same rate. If your
  answers differ, figure out which of you made the mistake -- and
  why.
]

== Transformations of Exponential Functions

#only-theory[
  The four transformations
  $ y = a dot f(b dot (x - h)) + k $
  were set up in the Functions chapter and need no restating. What is
  worth asking, as with every family, is which of the four knobs do
  something *new* for $y = b^x$ -- and here the answer is unusual.
  Two of them collapse, and they collapse into places you would not
  expect.
]

=== A Horizontal Shift Is a Vertical Stretch

#only-theory[
  Shift $y = 2^x$ three units to the right and see what the algebra
  says:
  $ 2^(x-3) = 2^x dot 2^(-3) = 1/8 dot 2^x . $
  The shifted curve is the original curve *scaled down by a factor of
  $8$*. Sliding an exponential sideways and squashing it vertically
  are the same operation.
]

#only-theory[
  #fig(
    plot-graph(
      x => calc.pow(2.0, x),
      (fn: x => calc.pow(2.0, x - 3), color: warn-col),
      xmin: -1.5,
      xmax: 5.5,
      ymin: -0.5,
      ymax: 8.5,
      size: 7,
      grid-step: 1,
    ),
    caption: [$y = 2^x$ (teal) and $y = 2^(x-3)$ (orange). The orange
      curve is the teal one moved $3$ to the right -- and equally, the
      teal one scaled to an eighth of its height. Both descriptions
      are exactly right.],
  )
]

#remark[
  Contrast this with the parabola, where a horizontal shift genuinely
  moves the vertex somewhere new and cannot be imitated by any
  stretch. Each family collapses a different pair of knobs: for a
  *line*, a horizontal shift is a vertical shift; for a *power
  function*, a horizontal stretch is a vertical stretch; for an
  *exponential*, a horizontal shift is a vertical stretch.
]

#ex(
  difficulty: 2,
  time: "10 min",
  calculator: false,
  hints: ([Split the exponent using $b^(m+n) = b^m dot b^n$.],),
)[
  Write each function in the form $a dot b^x$, and state the vertical
  stretch factor.
  #parts(
    2,
    [(a) $y = 2^(x-1)$],
    [(b) $y = 3^(x+2)$],
    [(c) $y = 10^(x-2)$],
    [(d) $y = (1/2)^(x-3)$],
  )
][
  #parts(
    2,
    [(a) $1/2 dot 2^x$, factor $1/2$],
    [(b) $9 dot 3^x$, factor $9$],
    [(c) $1/100 dot 10^x$, factor $1/100$],
    [(d) $8 dot (1/2)^x$, factor $8$],
  )

  In (d) the shift is to the *right* but the curve is stretched *up*,
  because the function is decreasing -- moving a decaying curve right
  means it was higher earlier.
]

=== A Horizontal Stretch Is a Change of Base

#only-theory[
  Now stretch the input instead. For $y = 2^(3x)$,
  $ 2^(3x) = (2^3)^x = 8^x . $
  Compressing an exponential horizontally does not take you out of the
  family at all -- it just changes the base. Every exponential curve is
  every other exponential curve, horizontally stretched.
]

#keybox(title: "Time Scaling")[
  $ b^(k t) = (b^k)^t $
  Rescaling *time* rescales the *growth factor* by the same power.
]

#only-theory[
  This is not an abstraction: it is the growth-factor arithmetic from
  the previous section, seen as a picture. If a quantity grows by
  $5%$ per year, its yearly factor is $1.05$. The monthly factor is
  what you must multiply by twelve times to get $1.05$, i.e.
  $ b_"month" = 1.05^(1\/12) approx 1.00407, $
  a monthly growth of about $0.41%$ -- noticeably less than
  $5% \/ 12 approx 0.42%$, because the growth compounds. Changing the
  time unit from years to months is a horizontal stretch by a factor
  of $12$, and the new base is the old one raised to $1\/12$.
]

#warning[
  A percentage rate is meaningless without its time unit. "$5%$
  growth" is not a number you can transfer between contexts: $5%$ per
  year and $5%$ per month are wildly different processes. Always
  convert with $b^(1\/k)$, never by dividing the percentage.
]

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: true,
  hints: (
    [Find the factor for the time unit you are given first, then raise
      it to the appropriate power.],
    [Going from a longer unit to a shorter one means a fractional
      exponent; the other way round, a whole one.],
  ),
)[
  + An investment grows by $8%$ per year. What is the equivalent
    monthly growth factor and monthly percentage?
  + A population grows by $2%$ per month. By what percentage does it
    grow per year?
  + A sample loses $30%$ of its mass per hour. What is its decay
    factor per minute?
][
  + $1.08^(1\/12) approx 1.00643$, about $0.643%$ per month.
  + $1.02^(12) approx 1.2682$, about $26.8%$ per year -- far more
    than $12 times 2% = 24%$, because of compounding.
  + $0.7^(1\/60) approx 0.99407$, about $0.593%$ lost per minute.
]

#exploration(title: "The Base That Chooses Itself")[
  Every exponential is every other one, restretched -- so no base is
  more "correct" than any other. And yet one base does get singled out
  later on. Compute the slope of $y = b^x$ at the point $(0, 1)$ for
  $b = 2$, then for $b = 3$, by taking two points either side of $0$
  and very close to it. One value of $b$ between $2$ and $3$ makes
  that slope exactly $1$. Find it to two decimal places. What do you
  suppose is special about it?
]

#example[
  Consider $f(t) = (3/2)^t$, $g(t) = (2/3)^t$, and
  $h(t) = (3/2)^(-t)$. These look like three different functions --
  but are they?

  Since $2/3$ is the reciprocal of $3/2$,
  $ g(t) = (2/3)^t = ((3/2)^(-1))^t = (3/2)^(-t) = h(t) . $
  So $g$ and $h$ are actually the *same* function, and both equal
  $f(-t)$ -- a reflection of $f$ across the $y$‑axis.
]

#ex(difficulty: 2, time: "15 min", keep-together: true)[
  Let $f(t) = (3/2)^t$ and $i(t) = -(3/2)^(-t)$.
  + Describe how the graph of $i$ can be obtained from the graph of
    $f$.
  + Write $i(t)$ in terms of $f$.
][
  + Reflect $f$ across the $y$‑axis, then across the $x$‑axis -- that
    is, reflect across the origin.
  + $i(t) = -f(-t)$.
]

#ex(difficulty: 1, time: "10 min")[
  The graph of $f(x) = 2^x$ is shifted $3$ units up and $2$ units to
  the left. Give the equation of the transformed graph.
][
  $ f(x+2) + 3 = 2^(x+2) + 3 $
]

== Finding the Equation from Two Points

#example[
  Find the exponential function $f(x) = a dot b^x$ through
  $A = (1, 6.3)$ and $B = (4, 170.1)$.

  Dividing the two equations eliminates $a$:
  $ (a dot b^4)/(a dot b^1) = 170.1/6.3 quad => quad b^3 = 27 quad
    => quad b = 3. $
  Then from $a dot 3 = 6.3$: $a = 2.1$. So $f(x) = 2.1 dot 3^x$.
]

#exploration(title: "The Ultimate Winner")[
  Compare $f(x) = x^2$, $g(x) = 2^x$, and $h(x) = x^(10)$ for larger
  and larger values of $x$ (try $x=10$, $50$, $100$ on your
  calculator). Which function ends up largest? Does that surprise
  you? What does this tell you about exponential growth compared to
  power-function growth -- no matter how big the power function's
  exponent is?
]

== Word Problems

#only-theory[
  The Smith family invested money using
  #vocab("compound interest", "Zinseszins") -- interest that's
  calculated not just on the original amount, but on the original
  amount *plus* all interest earned so far. That's exactly what makes
  it exponential.
]

#ex(difficulty: 2, time: "20 min", keep-together: true)[
  The Smiths invested money at an interest rate of $4.2%$, compounded
  yearly. Seven years later, their investment is worth about
  CHF 15'338.11.
  + How much did the Smiths invest initially?
  + How much will the investment be worth in $3$ more years, at the
    same rate?
  + Without solving algebraically, use your calculator to estimate
    how many *more* years it will take for the investment to pass
    CHF 20'000.
][
  Let $P_0$ be the initial investment; after $t$ years it grows to
  $P_0 dot 1.042^t$.
  + Solving $P_0 dot 1.042^7 = 15338.11$ gives
    $P_0 = 15338.11/1.042^7 approx #num(11500)$ CHF.
  + Three more years from today: $15338.11 dot 1.042^3 approx
    #num(17353)$ CHF.
  + Trying a few values: after $6$ more years it's worth about
    #num(19633) CHF, and after $7$ more years about #num(20457) CHF
    -- so it takes a little more than $6$ more years to pass
    #num(20000) CHF.
]

#ex(difficulty: 2, time: "20 min", keep-together: true)[
  A syringe contains $20$ mg of an active ingredient. Each hour,
  $10%$ of the *remaining* amount breaks down.
  + How much of the ingredient is left after one full day ($24$
    hours)?
  + Another patient's injection had $22$ mg left after $5$ hours. How
    much was injected originally?
  + A third injection originally contained $50$ mg of a different
    ingredient, of which only $32$ mg remain after $2$ hours. At what
    rate does this ingredient break down?
][
  The growth factor for "10% breaks down each hour" is $b = 0.9$.
  + $20 dot 0.9^(24) approx 1.6$ mg.
  + Solving $a dot 0.9^5 = 22$ gives $a = 22/0.9^5 approx 37.3$ mg.
  + Solving $50 dot b^2 = 32$ gives
    $b = sqrt(32/50) = sqrt(0.64) = 0.8$ -- a $20%$ decay rate per
    hour.
]

#ex(difficulty: 1, time: "10 min")[
  A colony of bacteria grows according to
  $ A(t) = 200 dot 1.13^t, quad t gt.eq 0 med "(days)." $
  + How many bacteria were there at the beginning?
  + How many *new* bacteria appeared on the 10th day alone (that is,
    $A(10) - A(9)$)? Round to a whole number of bacteria.
][
  + $A(0) = 200$.
  + $A(9) approx 600.8$ and $A(10) approx 678.9$, so about
    $678.9 - 600.8 approx 78$ bacteria appeared on day $10$.
]

#ex(difficulty: 2, time: "20 min", keep-together: true)[
  A radioactive material decays exponentially. At the start of an
  experiment there are $5.12 dot 10^(20)$ atoms; after $5$ hours,
  $1.55 dot 10^(16)$ remain. How many atoms remain after
  #parts(
    2,
    [(a) $1$ hour], [(b) $2$ hours], [(c) $4$ hours], [(d) $8$ hours],
  )?
][
  From $b^5 = (1.55 dot 10^(16))/(5.12 dot 10^(20))$, the hourly
  growth factor is $b approx 0.1248$.
  #parts(
    2,
    [(a) $approx 6.39 dot 10^(19)$],
    [(b) $approx 7.97 dot 10^(18)$],
    [(c) $approx 1.24 dot 10^(17)$],
    [(d) $approx 3.01 dot 10^(13)$],
  )
]

#ex(difficulty: 2, time: "10 min")[
  The #vocab("half-life", "Halbwertszeit") of carbon-14 is about
  $5730$ years. How much of a $10$ g sample remains after $15 med 000$
  years?
][
  Every half-life multiplies the remaining amount by $1/2$, so after
  $t$ years, a fraction $(1/2)^(t/5730)$ remains:
  $ 10 dot (1/2)^(#num(15000)/5730) approx 1.63 "g." $
]

#ex(difficulty: 2, time: "15 min")[
  A bacteria culture doubles every $6.5$ hours. Starting with about
  $100$ bacteria, how many will there be after a day and a half
  ($36$ hours)?
][
  $ 100 dot 2^(36/6.5) approx #num(4648) "bacteria." $
]

== Extra Bits -- A Two-Phase Culture

#ex(difficulty: 3, time: "25 min", keep-together: true)[
  A bacteria culture starts with $34$ bacteria and grows by $30%$
  every hour. After $12$ hours, an antibiotic stops the growth, and
  from then on the population *decreases* by $30%$ every $20$
  minutes.
  + How many bacteria were there when the growth stopped?
  + What is the half-life of the decrease phase, in minutes?
  + About how long (from when the antibiotic was added) does it take
    for the population to drop below $1$ bacterium?
][
  + $34 dot 1.3^(12) approx #num(792)$ bacteria.
  + Solving $0.7^(t/20) = 1/2$ for $t$ (by trial, or by the same
    technique as the carbon-14 half-life above) gives $t approx 39$
    minutes.
  + Continuing the decay from $792$ bacteria, the population drops
    below $1$ after about $374$ minutes -- roughly $6.24$ hours.
]

#look-ahead(preview: [logarithms])[
  Notice how we found the *time* in several problems above: not by
  solving algebraically, but by trying values on a calculator until
  we got close. That works, but it's slow and only approximate. What
  we're really missing is a way to solve equations like
  $ b^t = "(some number)" $
  directly for $t$. That's exactly what logarithms are for.
]

#print-hints()
#print-vocab()
