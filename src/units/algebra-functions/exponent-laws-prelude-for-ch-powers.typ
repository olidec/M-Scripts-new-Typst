#import "../../common/preamble.typ": *
#let ex = exercise.with(chapter: "Powers")

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

#keybox(title: "The Laws of Exponents")[
  $ a^n dot a^m &= a^(n+m) \
    a^n/a^m &= a^(n-m) \
    (a^n)^m &= a^(n dot m) \
    a^n dot b^n &= (a dot b)^n \
    a^n/b^n &= (a/b)^n $
]

#example[
  $ 3^2 dot 3^4 = underbrace(3 dot 3, 2 med "times") dot underbrace(3 dot 3 dot 3 dot 3, 4 med "times") = 3^6 . $
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
  #parts(3,
    [(a) $3^4$ or $4^3$],
    [(b) $2^3$ or $3^2$],
    [(c) $2^4$ or $4^2$],
  )
][
  #parts(3,
    [(a) $3^4$], [(b) $3^2$], [(c) both are equal],
  )
]

#ex(difficulty: 1, time: "15 min")[
  Simplify the following products.
  #parts(3,
    [(a) $a^4 dot a$],
    [(b) $(5c) dot (2c)^3$],
    [(c) $(4a^(10)) dot (-6a^4) dot a$],
  )
][
  #parts(3,
    [(a) $a^5$], [(b) $40c^4$], [(c) $-24a^(15)$],
  )
]

#ex(difficulty: 2, time: "15 min")[
  Simplify the following quotients.
  #parts(3,
    [(a) $(6r^5)/(2r^3)$],
    [(b) $(-(x dot y)^3)/((-2x dot y)^2)$],
    [(c) $(4x^5 dot y^4)/(6x^2)$],
  )
][
  #parts(3,
    [(a) $3r^2$], [(b) $-(x dot y)/4$], [(c) $(2x^3 dot y^4)/3$],
  )
]

#ex(difficulty: 2, time: "15 min")[
  Simplify the following powers.
  #parts(3,
    [(a) $(4s^2)^3$],
    [(b) $(d^2 dot e^3 dot f^4)^3$],
    [(c) $(x^2 dot (-z)^3)^5$],
  )
][
  #parts(3,
    [(a) $64s^6$], [(b) $d^6 dot e^9 dot f^(12)$], [(c) $-x^(10) dot z^(15)$],
  )
]

#ex(difficulty: 2, time: "15 min")[
  Order the following terms from smallest to largest.
  #parts(2,
    [(a) $(-2)^3, med -2^3, med (-3)^3, med -3^2$],
    [(b) $2^(-2), med 3^(-3), med -2^(-2), med 2^(-3)$],
  )
][
  #parts(1,
    [(a) $-3^3 < -3^2 < -2^3 = (-2)^3$],
    [(b) $-2^(-2) < 3^(-3) < 2^(-3) < 2^(-2)$],
  )
]

#ex(difficulty: 2, time: "15 min")[
  Simplify the following expressions. The results should contain only
  positive exponents.
  #parts(3,
    [(a) $(x^4 dot x^(-4))/x^4$],
    [(b) $(6a^4 dot b^(-2))/(72a^7) dot b^(-5)$],
    [(c) $-b^(-1) dot b^(-2)$],
  )
][
  #parts(3,
    [(a) $1/x^4$], [(b) $1/(12a^3b^7)$], [(c) $-1/b^3$],
  )
]

#ex(difficulty: 1, time: "10 min", hints: ("Rewrite each root as a fractional power first.",))[
  Solve using only your head. Hint: write as powers.
  #parts(4,
    [(a) $16^(1/2)$],
    [(b) $625^(1/4)$],
    [(c) $27^(2/3)$],
    [(d) $25^(3/2)$],
  )
][
  #parts(4,
    [(a) $4$], [(b) $5$], [(c) $9$], [(d) $125$],
  )
]

#ex(difficulty: 2, time: "20 min")[
  Give an exact expression for the solution, then approximate to two
  decimal places using a calculator.
  #parts(2,
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
  #parts(4,
    [(a) $root(3, 2) dot root(3, 4)$],
    [(b) $root(3, 12) dot root(3, 18)$],
    [(c) $root(5, 16) dot root(5, 2)$],
    [(d) $root(6, 9) dot root(6, 81)$],
  )
][
  #parts(4,
    [(a) $2$], [(b) $6$], [(c) $2$], [(d) $3$],
  )
]

#ex(difficulty: 2, time: "10 min")[
  Calculate without a calculator.
  #parts(3,
    [(a) $3^(1/2) dot 12^(1/2)$],
    [(b) $2^(1/5)/64^(1/5)$],
    [(c) $25^(3/8) dot 25^(5/8)$],
  )
][
  #parts(3,
    [(a) $6$], [(b) $1/2$], [(c) $25$],
  )
]

#ex(difficulty: 3, time: "25 min")[
  Replace $x$ with the appropriate number. These are designed to be
  solved without a calculator.
  #parts(4,
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
  #parts(4,
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
  #parts(2,
    [(a) $9^(50) = 27^x$],
    [(b) $16^(-x) = 2^(10)$],
    [(c) $a^(3/4) dot a^x = a^(2/3)$],
    [(d) $a^(3/4) : a^x = a^(2/3)$],
  )
][
  #parts(2,
    [(a) $x = 100/3$],
    [(b) $x = -2.5$],
    [(c) $x = -1/12$],
    [(d) $x = 1/12$],
  )
]

#ex(difficulty: 3, time: "15 min")[
  True or false? Determine without a calculator.
  #parts(4,
    [(a) $9^(1.5) in NN$],
    [(b) $5^(1.5) < 11$],
    [(c) $0.5^(0.5) > 0.5$],
    [(d) $pi^(100) < 9^(50)$],
  )
][
  #parts(4,
    [(a) true], [(b) false], [(c) true], [(d) false],
  )
]
