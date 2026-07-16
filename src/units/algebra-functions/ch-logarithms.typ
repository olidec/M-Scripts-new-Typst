#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Logarithms")
#let ex = exercise.with(chapter: "Logarithms")

= Logarithms

#only-theory[
  We closed the last chapter stuck: to solve $b^t = "(some number)"$
  for $t$, all we could do was try values on a calculator until we
  got close. Logarithms fix that. A logarithm is nothing more than
  the *name* we give to the answer of an equation where the unknown
  sits in the exponent -- and once it has a name, we can compute with
  it just like any other number.
]

#objectives(
  bfkm[define the logarithm as the solution to an equation with the
    unknown in the exponent, and evaluate logarithms by hand where
    possible],
  bfkm[apply the laws of logarithms to rewrite, combine, and evaluate
    expressions],
  bfkm[solve exponential equations algebraically using logarithms],
  [use the logarithm as the inverse function of an exponential
    function, and find inverse functions in general],
  [apply logarithms to real-world scales such as pH and the Richter
    scale],
)

== The Logarithm as an Answer

#only-theory[
  Consider $2^x = 8$. We can solve this directly, since we recognize
  $2^3 = 8$, so $x = 3$. But what about $2^x = 3$? No whole-number
  exponent gives exactly $3$, and yet the graph of $y = 2^x$
  certainly crosses $y = 3$ *somewhere*. We need a name for that
  somewhere.
]

#definition(title: "Logarithm")[
  The #vocab("logarithm", "Logarithmus") to base $b$ of $a$,
  $x = log_b (a)$, is the solution to $b^x = a$:
  $ log_b (a) = x quad <=> quad b^x = a, $
  where $b > 0$, $b eq.not 1$, and $a > 0$.
]

#only-theory[
  So $2^x = 8$ gives $x = log_2 (8) = 3$, and $2^x = 3$ gives
  $x = log_2 (3)$ -- a perfectly good number, even though it isn't a
  simple fraction. (It's about $1.58$.)
]

#keybox(title: "Two Common Bases")[
  The base $b$ can be almost anything, but two bases show up
  constantly and get their own shorthand:
  - Base $10$: $log_(10)(a)$ is usually just written $log(a)$.
  - Base $e$ (Euler's number, $e approx 2.71828 dots$): $log_e (a)$
    is written $ln(a)$, the
    #vocab("natural logarithm", "natürlicher Logarithmus"). We'll see
    exactly why $e$ deserves its own name in the next section.
]

#example[
  Evaluate each logarithm by rewriting the argument as a power of the
  base.
  + $log_3 (1/9) = log_3 (3^(-2)) = -2$.
  + $log(100000) = log_(10)(10^5) = 5$.
  + $log_2 (root(3, 32)) = log_2 (2^(5/3)) = 5/3$.
  + $ln(root(3, e^2)) = log_e (e^(2/3)) = 2/3$.
]

#ex(difficulty: 1, time: "10 min")[
  Write each equation as a logarithm.
  #parts(
    2,
    [(a) $125 = 5^3$],
    [(b) $0.125 = 2^(-3)$],
    [(c) $0.0001 = 10^(-4)$],
    [(d) $81 = 3^4$],
  )
][
  #parts(
    2,
    [(a) $3 = log_5 (125)$],
    [(b) $-3 = log_2 (0.125)$],
    [(c) $-4 = log_(10)(0.0001)$],
    [(d) $4 = log_3 (81)$],
  )
]

#ex(difficulty: 2, time: "20 min", keep-together: true)[
  Find the value of each logarithm, where it exists.
  #parts(
    3,
    [(a) $log(10)$],
    [(b) $log(100)$],
    [(c) $log(1)$],
    [(d) $log(0.1)$],
    [(e) $log(-5)$],
    [(f) $log_2 (4)$],
    [(g) $log_2 (8)$],
    [(h) $log_2 (0.25)$],
    [(i) $log_2 (sqrt(2))$],
    [(j) $log_2 (1024)$],
    [(k) $ln(e^2)$],
    [(l) $ln(1/e)$],
  )
][
  #parts(
    3,
    [(a) $1$],
    [(b) $2$],
    [(c) $0$],
    [(d) $-1$],
    [(e) doesn't exist],
    [(f) $2$],
    [(g) $3$],
    [(h) $-2$],
    [(i) $1/2$],
    [(j) $10$],
    [(k) $2$],
    [(l) $-1$],
  )
]

#example[
  Evaluate $9^(log_3 (4))$.
  $
    9^(log_3 (4)) = (3^2)^(log_3 (4)) = 3^(2 dot log_3 (4)) =
    (3^(log_3 (4)))^2 = 4^2 = 16
  $
]

#ex(difficulty: 2, time: "10 min")[
  Evaluate each expression.
  #parts(
    2,
    [(a) $10^(log_2 (2))$],
    [(b) $10^(log(100))$],
    [(c) $2^(log_2 (3))$],
    [(d) $4^(log_2 (5))$],
  )
][
  #parts(2, [(a) $10$], [(b) $100$], [(c) $3$], [(d) $25$])
]


#pagebreak()
== The Logarithm as an Inverse Function

#exploration(title: "Discovering Euler's Number")[
  Calculate $(1 + 1/n)^n$ for larger and larger values of $n$:
  $ n = 1, med 10, med 100, med 1000, med 10000, dots $
  What do you notice?
]

#only-theory[
  The number you're approaching is
  #vocab("Euler's number", "Eulersche Zahl"), named after the Basel
  mathematician Leonhard Euler:
  $ e approx 2.718281828459045 dots $
  Like $pi$, $e$ is irrational -- a non-repeating, never-ending
  decimal. It turns up constantly in mathematics, often when you
  least expect it, and it becomes the natural choice of base once we
  start doing calculus with exponential functions.
]

#exploration(title: "Exponentials and Logarithms, Side by Side")[
  Using a graphing tool, draw $f(x) = log_b (x)$ and $g(x) = b^x$
  together, for $b = 2, med 3, med e, med 1/2, med 10$. What do you
  observe about how the two graphs relate to each other?
]

#only-theory[
  This is exactly the "reflect across $y = x$" idea from the powers
  chapter, made concrete: $f: y = log_b (x)$ is the *inverse
  function* of $g: y = b^x$. Applying one right after the other
  cancels out:
  $ log_b (b^x) = x, quad x in RR, $
  $ b^(log_b (x)) = x, quad x in (0, infinity). $
]

#keybox(title: "Domain and Range")[
  The domain of $log_b (x)$ is $(0, infinity)$, and its range is
  $RR$ -- exactly the range and domain of $b^x$, swapped, as you'd
  expect from an inverse function.
]


#example[
  Find the inverse function of $f(x) = 2^(x+1) - 1$.

  Solve for $x$, then swap $x$ and $y$:
  $
    y = 2^(x+1) - 1 quad => quad y + 1 = 2^(x+1) quad => quad
    log_2 (y+1) = x + 1 quad => quad x = log_2 (y+1) - 1.
  $
  So $f^(-1): y = log_2 (x+1) - 1$.
]

#pagebreak()
#example[
  Find the inverse function of $f(x) = 2 dot ln(-x+1)$.
  $
    y = 2 dot ln(-x+1) quad => quad y/2 = ln(-x+1) quad => quad
    e^(y/2) = -x+1 quad => quad x = 1 - e^(y/2).
  $
  So $f^(-1): y = 1 - e^(x/2)$.
]

#ex(difficulty: 3, time: "25 min", keep-together: true)[
  Find the inverse function of each function.
  #parts(
    2,
    [(a) $f(x) = 4^(-x-1)$],
    [(b) $g(x) = (2/3)^(x+2) - 1$],
    [(c) $h(x) = -log_3 (x) + 4$],
    [(d) $i(x) = ln(-x) - 3$],
  )
][
  #parts(
    2,
    [(a) $y = -log_4 (x) - 1$],
    [(b) $y = log_(2/3)(x+1) - 2$],
    [(c) $y = 3^(-x+4)$],
    [(d) $y = -e^(x+3)$],
  )
]

#ai-box(role: "Checker")[
  Pick one inverse function from the exercise above. Verify it
  yourself by composing $f$ and your $f^(-1)$ and checking that you
  get $x$ back. Then ask an AI to do the same verification. Does it
  agree with you?
]

== The Laws of Logarithms

#keybox(title: "The Laws of Logarithms")[
  $
    log_b (x dot y) & = log_b (x) + log_b (y) \
        log_b (x/y) & = log_b (x) - log_b (y) \
        log_b (1/y) & = -log_b (y) \
        log_b (x^n) & = n dot log_b (x) \
          log_c (x) & = log_b (x)/log_b (c)
  $
]

#only-theory[
  The last law, the *change of base* formula, is what lets a
  calculator that only knows $log$ and $ln$ evaluate a logarithm in
  any other base.
]
#pagebreak()
#example[
  Express $log_a (5) + 2 dot log_a (7) - log_a (35)$ as a single
  logarithm.
  $
    log_a (5) + 2 dot log_a (7) - log_a (35) =
    log_a ((5 dot 7^2)/35) = log_a (7).
  $
]

#example[
  Express $1 - log_a (a dot b)$ as a single logarithm.
  $
    1 - log_a (a dot b) = log_a (a) - log_a (a dot b) =
    log_a (a/(a dot b)) = log_a (1/b) = -log_a (b).
  $
]

#example[
  Evaluate $2 dot (log(5) + log(2)) - 1$ without a calculator.
  $
    2 dot (log(5) + log(2)) - 1 = 2 dot log(5 dot 2) - 1 =
    2 dot log(10) - 1 = 2 - 1 = 1.
  $
]

#example[
  Solve $5^(2-x) = 4$ using the natural logarithm.

  Taking $ln$ of both sides:
  $
    (2-x) dot ln(5) = ln(4) quad => quad 2 - x = ln(4)/ln(5) quad
    => quad x = 2 - ln(4)/ln(5).
  $
]

#ex(difficulty: 2, time: "15 min", keep-together: true)[
  Use the laws of logarithms to rewrite each expression.
  #parts(
    2,
    [(a) $log(x/(y dot z))$],
    [(b) $log(a^2)$],
    [(c) $log(sqrt(x dot y))$],
    [(d) $3 dot log(x) + 5 dot log(y)$],
  )
][
  #parts(
    2,
    [(a) $log(x) - log(y) - log(z)$],
    [(b) $2 dot log(a)$],
    [(c) $1/2 dot (log(x) + log(y))$],
    [(d) $log(x^3 dot y^5)$],
  )
]

#ex(difficulty: 2, time: "10 min")[
  Write as a single logarithm.
  #parts(2, [(a) $log(4) + 2 dot log(3) - log(6)$], [(b) $2 - log(5)$])
][
  #parts(2, [(a) $log(6)$], [(b) $log(20)$])
]

#ex(difficulty: 2, time: "20 min", keep-together: true)[
  Solve for $x$ using the natural logarithm.
  #parts(
    2,
    [(a) $3^x = 7$],
    [(b) $4^(x+2) = 80$],
    [(c) $2^(2x-1) = 15$],
  )
][
  #parts(
    2,
    [(a) $x = ln(7)/ln(3) approx 1.77$],
    [(b) $x = ln(80)/ln(4) - 2 approx 1.16$],
    [(c) $x = ln(15)/(2 dot ln(2)) + 1/2 approx 2.45$],
  )
]

#only-theory[
  Now we can finally finish the Smith family's investment problem
  from the last chapter properly -- no more trial and error.
]

#example[
  Recall the Smiths' investment: worth CHF 15'338.11 today, growing
  at $4.2%$ per year. Exactly how many more years, $t$, until it
  passes CHF 20'000?
  $
    15338.11 dot 1.042^t = 20000 quad => quad 1.042^t =
    20000/15338.11
  $
  Taking $ln$ of both sides:
  $
    t dot ln(1.042) = ln(20000/15338.11) quad => quad
    t = ln(20000/15338.11)/ln(1.042) approx 6.45 .
  $
  This confirms and sharpens our earlier trial-and-error estimate: it
  takes about $6.45$ more years, matching what we bracketed between
  $6$ and $7$ years before.
]

== Applications

#definition(title: "pH")[
  The pH of a solution measures how acidic it is:
  $ "pH" = -log_(10)([H^+]), $
  where $[H^+]$ is the concentration of $H^+$ ions, in mol/l.
]

#example[
  Pure water has a pH of $7$. How many $H^+$ ions are there per
  liter?
  $ 7 = -log([H^+]) quad => quad [H^+] = 10^(-7) "mol/l." $
]

#ex(difficulty: 2, time: "20 min", keep-together: true)[
  + A strong acid has a pH of $2$. If $1$ liter of this acid is
    diluted with $1$ liter of water, what is the pH of the resulting
    solution?
  + $400$ ml of an acid with pH $3$ is mixed with $300$ ml of an acid
    with pH $4$. What is the resulting pH?
][
  + The original liter contains $10^(-2)$ mol of $H^+$. Diluted to
    $2$ liters, the new concentration is $10^(-2)/2$ mol/l, so
    $ "pH" = -log(10^(-2)/2) approx 2.30 . $
  + Moles of $H^+$: $10^(-3) dot 0.4 + 10^(-4) dot 0.3 = 4.3 dot
    10^(-4)$, in a total volume of $0.7$ l:
    $ "pH" = -log((4.3 dot 10^(-4))/0.7) approx 3.21 . $
]

#only-theory[
  The Richter scale measures earthquake magnitude on a logarithmic
  scale: each increase of $1$ means $10$ times more energy released.
]

#ex(difficulty: 1, time: "10 min")[
  The 1964 Alaska earthquake measured $9.2$ on the Richter scale; the
  2014 Thailand earthquake measured $6.1$. How many times more energy
  did the Alaska earthquake release?
][
  $ 10^(9.2 - 6.1) = 10^(3.1) approx 1259 . $
]

#look-ahead(preview: [calculus and the number e])[
  We picked out $e$ from a strange-looking limit, $(1+1/n)^n$, and
  it's about to earn that special treatment: once we study
  derivatives, $e^x$ turns out to be the *only* function that is its
  own derivative -- and that single property is why $e$, not $10$ or
  $2$, becomes the natural base for exponential and logarithmic
  functions in calculus.
]

== Extra Bits -- When Does a Logarithm Exist?

#ex(difficulty: 2, time: "15 min", keep-together: true)[
  Decide whether each expression exists. If it does, decide whether
  its value is positive, negative, or zero.
  #parts(
    3,
    [(a) $log(4.3)$],
    [(b) $log(log(1))$],
    [(c) $log(log(log(100)))$],
    [(d) $-log(2^(-3))$],
    [(e) $log(log(0.8))$],
    [(f) $-log(1)$],
  )
][
  #parts(
    3,
    [(a) exists, positive],
    [(b) doesn't exist ($log(1) = 0$, and $log(0)$ is undefined)],
    [(c) exists, negative],
    [(d) exists, positive],
    [(e) doesn't exist ($log(0.8)$ is negative)],
    [(f) exists, zero],
  )
]

#pagebreak()
#ex(difficulty: 3, time: "15 min")[
  For which values of $x$ does $log(log(log(x)))$ have a real value?
][
  Working from the inside out: $log(x)$ needs $x>0$ just to exist,
  but $log(log(x))$ then needs $log(x) > 0$, i.e. $x > 1$. Finally,
  $log(log(log(x)))$ needs $log(log(x)) > 0$, i.e. $log(x) > 1$,
  i.e. $x > 10$. So the expression is real exactly when $x > 10$.
]

#print-hints()
#print-vocab()
