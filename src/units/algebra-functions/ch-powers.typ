#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Powers and Power Functions")
#let ex = exercise.with(chapter: "Powers and Power Functions")

= Powers and Power Functions

#only-theory[
  You already know $x^2$ and $x^3$ from algebra and from the parabolas
  we just studied. This chapter asks a bigger question: what if the
  exponent doesn't have to be a positive whole number at all? Once we
  pin down what negative and fractional exponents actually mean, a
  whole family of curved functions -- power functions -- opens up.
]

#objectives(
  bfkm[apply the laws of exponents, including negative and fractional
    exponents, to simplify expressions],
  bfkm[identify and graph power functions $f(x) = a dot x^n$, and
    describe how the sign and parity of $n$ shape the graph],
  bfkm[describe how shifts and reflections transform the graph of
    *any* function, not just parabolas],
  [solve equations and word problems involving powers and roots],
  [determine the coefficients of a power function from given points
    on its graph],
)

== Exponents

#exploration(title: "The Rice and the Chessboard")[
  According to an old Indian legend, Sissa ben Dahir was a courtier for
  a king. Sissa worked very hard and invented the game of chess. The
  king decided to reward Sissa and asked what he would like. Sissa
  thought carefully and said: "I would like one grain of rice to be put
  on the first square of my board, two on the second square, four on
  the third square, eight on the fourth, and so on."

  The king thought this was a silly request, but agreed.

  + How many grains of rice would there be on the 8th square?
  + How many grains would you need altogether to fill up to the 15th
    square?
  + Estimate how many grains you would need in total to fill the entire
    board this way. Explain your thinking.
]

An exponent represents repeated multiplication of a number by itself, so
$ 3^4 = 3 dot 3 dot 3 dot 3 . $
Generally,
$ a^n = underbrace(a dot a dot a dots.h.c a, n med "times") . $
As long as the exponents are all natural numbers, the following rules
seem self-evident:

#pagebreak()
#keybox(title: "The Laws of Exponents")[
  $
    a^n dot a^m & = a^(n+m) \
        a^n/a^m & = a^(n-m) \
        (a^n)^m & = a^(n dot m) \
    a^n dot b^n & = (a dot b)^n \
        a^n/b^n & = (a/b)^n
  $
]

#example[
  $
    3^2 dot 3^4 = underbrace(3 dot 3, 2 med "times") dot underbrace(3 dot 3 dot 3 dot 3, 4 med "times") = 3^6 .
  $
]

#exploration(title: "What Should a Negative Exponent Mean?")[
  Consider the equation
  $ 2^5/2^3 = 2^(5-3) = 2^2 . $
  Now use the same rule for a similar equation:
  $ 2^3/2^5 = med ? $
  What should $a^(-n)$, for $n in NN$, be?
]

#exploration(title: "What Should a Fractional Exponent Mean?")[
  Consider the equation
  $ (2^2)^3 = 2^2 dot 2^2 dot 2^2 = 2^(2 dot 3) = 2^6 . $
  Now use the same rule for a similar equation:
  $ (2^(1/2))^2 = med ? $
  Hence, what should $2^(1/2)$ be?
]

#exploration(title: "The Largest Number")[
  What is the largest number you can make using the three digits 2, 3,
  and 4 in any way you like, using any operations you like? You may use
  each digit only once. For example: $34 dot 2 = 68$ or $3 + 4^2 = 19$.
]

#ex(difficulty: 1, time: "10 min")[
  Decide which power is larger, without using a calculator.
  #parts(3, [(a) $3^4$ or $4^3$], [(b) $2^3$ or $3^2$], [(c) $2^4$ or $4^2$])
][
  #parts(3, [(a) $3^4$], [(b) $3^2$], [(c) both are equal])
]

#ex(difficulty: 1, time: "15 min")[
  Simplify the following products.
  #parts(
    3,
    [(a) $a^4 dot a$],
    [(b) $(5c) dot (2c)^3$],
    [(c) $(4a^(10)) dot (-6a^4) dot a$],
  )
][
  #parts(3, [(a) $a^5$], [(b) $40c^4$], [(c) $-24a^(15)$])
]

#ex(difficulty: 2, time: "15 min")[
  Simplify the following quotients.
  #parts(
    3,
    [(a) $(6r^5)/(2r^3)$],
    [(b) $(-(x dot y)^3)/((-2x dot y)^2)$],
    [(c) $(4x^5 dot y^4)/(6x^2)$],
  )
][
  #parts(3, [(a) $3r^2$], [(b) $-(x dot y)/4$], [(c) $(2x^3 dot y^4)/3$])
]

#ex(difficulty: 2, time: "15 min")[
  Simplify the following powers.
  #parts(
    3,
    [(a) $(4s^2)^3$],
    [(b) $(d^2 dot e^3 dot f^4)^3$],
    [(c) $(x^2 dot (-z)^3)^5$],
  )
][
  #parts(
    3,
    [(a) $64s^6$],
    [(b) $d^6 dot e^9 dot f^(12)$],
    [(c) $-x^(10) dot z^(15)$],
  )
]

#ex(difficulty: 2, time: "15 min")[
  Order the following terms from smallest to largest.
  #parts(
    2,
    [(a) $(-2)^3, med -2^3, med (-3)^3, med -3^2$],
    [(b) $2^(-2), med 3^(-3), med -2^(-2), med 2^(-3)$],
  )
][
  #parts(
    1,
    [(a) $-3^3 < -3^2 < -2^3 = (-2)^3$],
    [(b) $-2^(-2) < 3^(-3) < 2^(-3) < 2^(-2)$],
  )
]

#ex(difficulty: 2, time: "15 min", keep-together: true)[
  Simplify the following expressions. The results should contain only
  positive exponents.
  #parts(
    3,
    [(a) $(x^4 dot x^(-4))/x^4$],
    [(b) $(6a^4 dot b^(-2))/(72a^7) dot b^(-5)$],
    [(c) $-b^(-1) dot b^(-2)$],
  )
][
  #parts(3, [(a) $1/x^4$], [(b) $1/(12a^3b^7)$], [(c) $-1/b^3$])
]

#ex(difficulty: 1, time: "10 min", hints: (
  "Rewrite each root as a fractional power first.",
))[
  Solve using only your head. Hint: write as powers.
  #parts(
    4,
    [(a) $16^(1/2)$],
    [(b) $625^(1/4)$],
    [(c) $27^(2/3)$],
    [(d) $25^(3/2)$],
  )
][
  #parts(4, [(a) $4$], [(b) $5$], [(c) $9$], [(d) $125$])
]

#ex(difficulty: 2, time: "20 min")[
  Give an exact expression for the solution, then approximate to two
  decimal places using a calculator.
  #parts(
    2,
    [(a) $x^4 = 20$],
    [(b) $x^7 = -100$],
    [(c) $0.4x^4 = 250$],
    [(d) $0.1x^5 = 4$],
    [(e) $3.2x^2 = -2$],
    [(f) $-3x^3 = -81$],
    [(g) $5b^4 + 30 = 100$],
    [(h) $-4y^5 + 12 = 6y^5 - 88$],
  )
][
  + $x = plus.minus root(4, 20) approx plus.minus 2.11$
  + $x = root(7, -100) approx -1.93$
  + $x^4 = 250/0.4 = 625 => x = plus.minus root(4, 625) = plus.minus 5$
  + $x^5 = 4/0.1 = 40 => x = root(5, 40) approx 2.09$
  + $x^2 = (-2)/3.2 = -0.625 =>$ no solution (a square can't be negative)
  + $x^3 = (-81)/(-3) = 27 => x = root(3, 27) = 3$
  + $b^4 = (100-30)/5 = 14 => b = plus.minus root(4, 14) approx plus.minus 1.93$
  + $-10y^5 = -100 => y^5 = 10 => y = root(5, 10) approx 1.58$
]

#example[
  $ root(4, 3) dot root(4, 27) = root(4, 3 dot 27) = root(4, 81) = 3 $
]

#ex(difficulty: 2, time: "15 min")[
  Simplify the following expressions according to the example above.
  #parts(
    4,
    [(a) $root(3, 2) dot root(3, 4)$],
    [(b) $root(3, 12) dot root(3, 18)$],
    [(c) $root(5, 16) dot root(5, 2)$],
    [(d) $root(6, 9) dot root(6, 81)$],
  )
][
  #parts(4, [(a) $2$], [(b) $6$], [(c) $2$], [(d) $3$])
]

#ex(difficulty: 2, time: "10 min", keep-together: true)[
  Calculate without a calculator.
  #parts(
    3,
    [(a) $3^(1/2) dot 12^(1/2)$],
    [(b) $2^(1/5)/64^(1/5)$],
    [(c) $25^(3/8) dot 25^(5/8)$],
  )
][
  #parts(3, [(a) $6$], [(b) $1/2$], [(c) $25$])
]

#ex(difficulty: 3, time: "25 min")[
  Replace $x$ with the appropriate number. These are designed to be
  solved without a calculator.
  #parts(
    4,
    [(a) $x^(0.75) = 8$],
    [(b) $x^(2/3) = 9$],
    [(c) $x^(1.5) = 0.001$],
    [(d) $x^(0.5) = 2$],
    [(e) $x^(0.8) = 1/16$],
    [(f) $x^0 = 0$],
    [(g) $0^x = 0$],
    [(h) $x^0 = 1$],
    [(i) $2^x = 0.5$],
    [(j) $2^x = sqrt(2)$],
    [(k) $4^x = 8$],
    [(l) $8^x = 4$],
    [(m) $1000^x = 100$],
    [(n) $1000^x = 1$],
    [(o) $1000^x = 0.1$],
    [(p) $(sqrt(2))^(10) = 2^x$],
    [(q) $(root(8, 25))^5 = 5^x$],
    [(r) $9^(0.25) = 3^x$],
    [(s) $8^(-0.25) = 2^x$],
  )
][
  #parts(
    4,
    [(a) $x = 16$],
    [(b) $x = 27$],
    [(c) $x = 10^(-2)$],
    [(d) $x = 4$],
    [(e) $x = 1/32$],
    [(f) no solution],
    [(g) $x in (0, infinity)$],
    [(h) $x in RR$],
    [(i) $x = -1$],
    [(j) $x = 1/2$],
    [(k) $x = 3/2$],
    [(l) $x = 2/3$],
    [(m) $x = 2/3$],
    [(n) $x = 0$],
    [(o) $x = -1/3$],
    [(p) $x = 5$],
    [(q) $x = 5/4$],
    [(r) $x = 0.5$],
    [(s) $x = -0.75$],
  )
]

#ex(difficulty: 3, time: "15 min")[
  Solve the following equations without using a calculator.
  #parts(
    2,
    [(a) $9^(50) = 27^x$],
    [(b) $16^(-x) = 2^(10)$],
    [(c) $a^(3/4) dot a^x = a^(2/3)$],
    [(d) $a^(3/4) : a^x = a^(2/3)$],
  )
][
  #parts(
    2,
    [(a) $x = 100/3$],
    [(b) $x = -2.5$],
    [(c) $x = -1/12$],
    [(d) $x = 1/12$],
  )
]

#ex(difficulty: 3, time: "15 min")[
  True or false? Determine without a calculator.
  #parts(
    4,
    [(a) $9^(1.5) in NN$],
    [(b) $5^(1.5) < 11$],
    [(c) $0.5^(0.5) > 0.5$],
    [(d) $pi^(100) < 9^(50)$],
  )
][
  #parts(4, [(a) true], [(b) false], [(c) true], [(d) false])
]

#pagebreak()
== Power Functions and Models

#only-theory[
  We've already met several power functions without naming them:
  $x^2$, $x^3$, and $sqrt(x) = x^(1/2)$ are all functions of the form
  $f(x) = a dot x^n$. Now that we know what any exponent $n$ can mean
  -- negative, fractional, whatever -- we can study this whole family
  at once.
]

#definition(title: "Power Function")[
  $ f(x) = a dot x^n, quad a eq.not 0 $
  is a #vocab("power function", "Potenzfunktion"). Unlike a
  polynomial, a power function has just *one* term, and its exponent
  $n$ can be any real number -- not just a positive whole number.
]

#exploration(title: "Nine Related Graphs")[
  Using a graphing tool, draw $f(x) = x^n$ for
  $n = -4, -3, -2, -1, 0, 1, 2, 3, 4$ -- all in the same coordinate
  system.

  + Which of these graphs look similar to each other?
  + What effect does the *sign* of the exponent have on the shape?
  + The graphs for *even* and *odd* exponents look fundamentally
    different. How? Why?
]

#exploration(title: "Fractional Exponents on One Graph")[
  Draw $f(x) = x^q$ for
  $
    q = 4, med 3/2, med 1, med 2/3, med 1/4, med 0, med -1/2, med -1,
    med -3/2
  $
  on $x in [-3, 3]$, all in the same coordinate system.

  + Which of these graphs look similar to each other?
  + How does the exponent influence the graph? (Hint: compare
    reciprocal exponents, like $1/4$ and $4$.)
]

#keybox(title: "Reading the Shape from the Exponent")[
  - *Even positive* $n$ (like $x^2$, $x^4$): U‑shaped, symmetric about
    the $y$‑axis.
  - *Odd positive* $n$ (like $x^3$, $x^5$): S‑shaped, symmetric about
    the origin, passing through $(0,0)$.
  - *Negative* $n$ (like $x^(-1)$, $x^(-2)$): undefined at $x = 0$,
    with the graph approaching both axes -- the axes are
    #vocab("asymptotes", "Asymptoten") of the graph.
  - Whether the negative-exponent graph sits in two "opposite"
    quadrants (odd $n$) or two "same-side" quadrants (even $n$)
    follows the same even/odd pattern as the positive exponents.
]

#image-grid(
  2,
  gutter: 10pt,
  [
    #plot-graph(
      x => if x == 0 { none } else { calc.pow(x, -4) },
      xmin: -2.5,
      xmax: 2.5,
      ymin: -0.5,
      ymax: 5.5,
      size: 5,
      grid-step: 1,
    )
    Graph A
  ],
  [
    #plot-graph(
      x => calc.pow(x, 3),
      xmin: -1.7,
      xmax: 1.7,
      ymin: -3.7,
      ymax: 3.7,
      size: 5,
      grid-step: 1,
    )
    Graph B
  ],
  [
    #plot-graph(
      x => if x == 0 { none } else { calc.pow(x, -3) },
      xmin: -2.5,
      xmax: 2.5,
      ymin: -4.5,
      ymax: 4.5,
      size: 5,
      grid-step: 1,
    )
    Graph C
  ],
  [
    #plot-graph(
      x => calc.pow(x, 4),
      xmin: -1.7,
      xmax: 1.7,
      ymin: -0.5,
      ymax: 5.5,
      size: 5,
      grid-step: 1,
    )
    Graph D
  ],
)

#ex(difficulty: 2, time: "15 min")[
  Match each power function to one of the four graphs shown above.
  #parts(
    2,
    [(a) $f(x) = x^3$],
    [(b) $f(x) = x^4$],
    [(c) $f(x) = x^(-3)$],
    [(d) $f(x) = x^(-4)$],
  )
][
  #parts(
    2,
    [(a) Graph B],
    [(b) Graph D],
    [(c) Graph C],
    [(d) Graph A],
  )
]

#ex(difficulty: 2, time: "20 min", keep-together: true)[
  Given the functions
  $ f(x) = x^3 + a, quad g(x) = sqrt(x - a), quad h(x) = a/x + 1, $
  determine $a$ so that each graph passes through the given point.
  Where it's impossible, say so.
  #parts(
    2,
    [(a) $P = (2, 3)$],
    [(b) $P = (-4, 1)$],
  )
][
  + For $P = (2,3)$: $f$: $a = -5$. $g$: $a = -7$. $h$: $a = 4$.
  + For $P = (-4,1)$: $f$: $a = 65$. $g$: $a = -5$. $h$: solving
    gives $a = 0$, but a power function needs $a eq.not 0$ -- so
    this isn't possible.
]

#ex(difficulty: 2, time: "20 min", keep-together: true)[
  + The points $A = (3, 1)$ and $B = (6, 16)$ lie on the graph of
    $f(x) = a dot x^n$. Find $a$ and $n$.
  + Find $n$ and $m$ so that the graphs of $f(x) = x^n + 2.5$ and
    $g(x) = x^m - 5$ intersect at $P = (2, 3)$.
][
  + Divide the second equation by the first to eliminate $a$:
    $
      (a dot 6^n)/(a dot 3^n) = 16/1 quad => quad (6/3)^n = 16 quad
      => quad 2^n = 16 quad => quad n = 4.
    $
    Then from $a dot 3^4 = 1$: $a = 1/81$.
  + Both functions must pass through $(2,3)$:
    $ 2^n + 2.5 = 3 => 2^n = 0.5 => n = -1, $
    $ 2^m - 5 = 3 => 2^m = 8 => m = 3. $
]

#ex(difficulty: 2, time: "20 min", keep-together: true)[
  Given $f(x) = x^(-1) - 2$ and $g(x) = 4 - x^(-1)$:
  + Find where each graph crosses the $x$‑axis.
  + Find the point where $f$ and $g$ intersect.
][
  + $f$: $1/x - 2 = 0 => x = 1/2$. $g$: $4 - 1/x = 0 => x = 1/4$.
  + Setting $f(x) = g(x)$: $1/x - 2 = 4 - 1/x => 2/x = 6 => x = 1/3$,
    and $f(1/3) = 3 - 2 = 1$. So they meet at $(1/3, 1)$.
]

#look-ahead(preview: [exponential functions])[
  Every power function keeps the *exponent* fixed and lets the
  *base* vary -- that's what makes $x^2$, $x^3$, and $x^(-1)$ all
  power functions. Flip that around -- fix the base and let the
  exponent vary instead -- and you get an entirely different family:
  exponential functions, $f(x) = a dot b^x$. We study those next.
]

== Transforming Graphs

#only-theory[
  We already learned to read transformations off vertex form for
  parabolas. The same ideas work for *any* function $f$, power
  functions included.
]

#keybox(title: "General Transformations of a Graph")[
  Starting from $y = f(x)$:
  - $y = f(x) + k$: shift *up* by $k$ (down, if $k<0$).
  - $y = f(x - h)$: shift *right* by $h$ (left, if $h<0$).
  - $y = -f(x)$: reflect across the $x$‑axis.
  - $y = f(-x)$: reflect across the $y$‑axis.
  - $y = -f(-x)$: reflect across the origin (both at once).
]

#example[
  Shift $f(x) = 1/8 x^3$
  + $3$ units up: $f(x) + 3 = 1/8 x^3 + 3$.
  + $2$ units right: $f(x - 2) = 1/8 (x-2)^3$.
  + $2$ units left and $1$ unit up:
    $f(x+2) + 1 = 1/8 (x+2)^3 + 1$.
]

#look-ahead(title: "Reflecting Across y = x", preview: [logarithms])[
  There's one more reflection: across the line $y=x$, which swaps the
  roles of $x$ and $y$. Applied to a function's graph, this produces
  its #vocab("inverse function", "Umkehrfunktion") (if it has one).
  We'll use exactly this idea to *define* the logarithm as the
  inverse of an exponential function.
]

#example[
  Reflect $f(x) = sqrt(x)$
  + across the $x$‑axis: $y = -sqrt(x)$.
  + across the $y$‑axis: $y = sqrt(-x)$.
  + across the origin: $y = -sqrt(-x)$.
  + across the line $y = x$: swap $x$ and $y$ in $y = sqrt(x)$ and
    solve for $y$: $x = sqrt(y) => y = x^2$ (for $x gt.eq 0$).
]

#ai-box(role: "Explainer")[
  Ask an AI to explain, in its own words, why reflecting a function's
  graph across the line $y=x$ swaps the roles of its domain and
  range. Does the explanation match what you already worked out
  above? If it uses a term you don't recognize, look it up before
  moving on.
]

#ex(difficulty: 1, time: "10 min")[
  The graph of $f(x) = -x^2 + 5x + 2$ is shifted five units to the
  left. What is the equation of the shifted graph?
][
  $f(x+5) = -x^2 - 5x + 2$.
]

#plot-graph(
  x => if x < 0 { none } else { calc.sqrt(x) },
  (
    fn: x => if x < 2 { none } else { -calc.sqrt(x - 2) + 1 },
    color: warn-col,
  ),
  xmin: -0.5,
  xmax: 7.5,
  ymin: -1.5,
  ymax: 3.5,
  size: 7,
  grid-step: 1,
)

#ex(difficulty: 2, time: "15 min")[
  The graph above shows $f(x) = sqrt(x)$ (in teal) and a transformed
  version $g$ (in orange).
  + Describe the transformation from $f$ to $g$ in words.
  + Give the equation for $g(x)$.
][
  + Reflect across the $x$‑axis, then shift $2$ units right and $1$
    unit up.
  + $g(x) = -sqrt(x - 2) + 1$.
]

#ex(difficulty: 2, time: "15 min")[
  A function $f$ is defined by connecting these four points with
  straight segments, in order:
  $ (-4,-2), quad (-1,-4), quad (1,-1), quad (3,3). $
  Find the corresponding key points of the graph of
  $g(x) = -f(x+1) - 3$.
][
  For each point $(x_0, y_0)$ of $f$, the matching point of $g$ is
  $(x_0 - 1, med -y_0-3)$ (shift left $1$, then reflect across the
  $x$‑axis and shift down $3$):
  $ (-5,-1), quad (-2,1), quad (0,-2), quad (2,-6). $
]

#ex(difficulty: 2, time: "15 min", keep-together: true)[
  Mirror the graph of $f(x) = x^(0.4)$
  #parts(
    2,
    [(a) across the $x$‑axis],
    [(b) across the $y$‑axis],
    [(c) across the line $y = x$],
  )
  and give the equation of each mirrored graph.
][
  #parts(
    2,
    [(a) $y = -x^(0.4)$],
    [(b) $y = (-x)^(0.4)$],
    [(c) $y = x^(2.5)$ (since $1/0.4 = 2.5$)],
  )
]

#print-hints()
#print-vocab()
