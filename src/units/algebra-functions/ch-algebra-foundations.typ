#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Algebra Foundations")
#let ex = exercise.with(chapter: "Algebra Foundations")

= Algebra Foundations

#toolbox()

== The Big Ideas in Algebra

#only-theory[
  The following graphic gives an overview of the so-called big ideas in
  algebra. Over the next four years we will cover these and many more
  topics.
]

#fig(
  image("images/big-ideas-in-algebra.png", width: 85%),
  caption: [Source: #link("http://www.greatmathsteachingideas.com/")],
)

=== What is Algebra?

In its most general form, algebra is the study of mathematical symbols
and the rules for manipulating them. It is a unifying thread running
through almost all of mathematics. The more basic parts of algebra are
called *elementary algebra*; the more abstract parts are called
*abstract algebra* or *modern algebra*. Elementary algebra is essential
for any study of mathematics, science, or engineering, as well as
applications such as medicine and economics. Abstract algebra is a
major area of advanced mathematics, studied primarily by professional
mathematicians. Much early work in algebra -- as the Arabic origin of
its name suggests -- was done in the Near East, by mathematicians such
as al-Khwārizmī (780--850) and Omar Khayyam (1048--1131).

#remark[
  Source: #link("https://en.wikipedia.org/wiki/Algebra")
]

=== The Building Blocks of Algebra

The main building blocks of algebra are #emph[variables], #emph[expressions],
and #emph[equations].

==== Variables

#definition[
  A *variable* is a placeholder (usually a letter or symbol) that stands
  for an unknown number.
]

Variables can have different interpretations depending on the situation:
- In an equation (see below), a variable may stand for an unknown number:
  $ x + 2 = 5 $
- A variable may be used to describe a general situation: if a car is
  going 5 m/s, then after $t$ seconds it will have traveled $s = 5 dot t$
  meters.
- Variables can describe relationships between quantities that vary: if
  $c$ is the circumference of a circle and $d$ is its diameter, then the
  ratio $c/d$ is always constant, and $c/d = pi$.
- Variables can be used to describe general *rules* (or theorems) of
  mathematics: the operation of addition is commutative, i.e.
  $a + b = b + a$.

==== Expressions

#definition[
  *Algebraic expressions* can be evaluated and simplified, based on the
  basic properties of arithmetic operations (addition, subtraction,
  multiplication, division, and exponentiation).
]

For example:
- Added terms are simplified using coefficients. For example,
  $x + x + x$ can be simplified as $3 dot x$ (where 3 is the coefficient).
- Multiplied terms are simplified using exponents. For example,
  $x dot x dot x$ is represented as $x^3$.
- Like terms are added together: for example, $2x^2 + 3 a b - x^2 + a b$
  is written as $x^2 + 4 a b$, because the terms containing $x^2$ are
  added together, and the terms containing $a b$ are added together.
- Parentheses can be "multiplied out," using distributivity. For
  example, $x dot (2x + 3)$ can be written as $(x dot 2x) + (x dot 3)$,
  which simplifies to $2x^2 + 3x$.
- Expressions can be factored. For example, $6x^5 + 3x^2$, by dividing
  both terms by $3x^2$, can be written as $3x^2 dot (2x^3 + 1)$.

#ex(difficulty: 1, time: "10 min", keep-together: true)[
  Evaluate the following terms for the given $x$-values.

  #data-table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr),
    [$x$], [$x dot (x - 3)$], [$8x - (2 - 2x)$], [$0.5 dot (-2x) + 2x$], [$x^2 + x$],
    [$5$], [$10$], [], [], [],
    [$-3$], [], [], [], [],
    [$0.1$], [], [], [], [],
    [$0$], [], [], [], [],
    [$3/4$], [], [], [], [],
  )
][
  #data-table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr),
    row-height: auto,
    [$x$], [$x dot (x - 3)$], [$8x - (2 - 2x)$], [$0.5 dot (-2x) + 2x$], [$x^2 + x$],
    [$5$], [$10$], [$48$], [$5$], [$30$],
    [$-3$], [$18$], [$-32$], [$-3$], [$6$],
    [$0.1$], [$-0.29$], [$-1$], [$0.1$], [$0.11$],
    [$0$], [$0$], [$-2$], [$0$], [$0$],
    [$3/4$], [$-27/16$], [$11/2$], [$3/4$], [$21/16$],
  )
]

==== Equations

#definition[
  An *equation* states that two expressions are equal, using the symbol
  "=".
]

- Some equations are true for all values of the involved variables: the
  commutativity of addition above states that $a + b = b + a$ for all
  values of $a$ and $b$.
- Some equations are only true for certain values: $x^2 - 1 = 0$ is only
  true if $x = 1$ or $x = -1$.

#keybox(title: "Two important properties of equations")[
  - If $a = b$ and $c = d$, then $a + c = b + d$.
  - If $a = b$, then $a + c = b + c$.

  where $a$, $b$, $c$, and $d$ are arbitrary algebraic expressions.
]

#pagebreak()
You can think of an equation as a balance:
#image-grid(1,image("images/equation-balance.png", width: 75%),image("images/equation-balance-2.png", width: 75%))

#ex(difficulty: 1, time: "15 min")[
  Solve the equations for each variable.
  #parts(3,
    [(a) $p dot V = 10$],
    [(b) $4x + 3y = 10$],
    [(c) $5 dot (x - 2y) = y - (x + 3)$],
    [(d) $G dot p/100 = 20$],
    [(e) $0.5 = v dot t$],
    [(f) $(a + b)/2 = 2a + b$],
  )
][
  #parts(3,
    [(a) $p = 10/V$ and $V = 10/p$],
    [(b) $x = (10 - 3y)/4$ and $y = (10 - 4x)/3$],
    [(c) $x = (11y - 3)/6$ and $y = (6x + 3)/11$],
    [(d) $G = 2000/p$ and $p = 2000/G$],
    [(e) $v = 0.5/t = 1/(2t)$ and $t = 0.5/v = 1/(2v)$],
    [(f) $a = -b/3$ and $b = -3a$],
  )
]

#remark[
  More information on the basics of algebra can be found at Khan
  Academy: #link("https://www.khanacademy.org/math/algebra/x2f8bb11595b61c86:foundation-algebra")
]

#keybox(title: "A short list of mathematical expressions and symbols")[
  #table(
    columns: (auto, 1fr),
    stroke: 0.4pt + luma(190),
    inset: 7pt,
    align: (center + horizon, left + horizon),
    [$NN$], [the set of the *natural numbers*: either ${1, 2, 3, ...}$
      or ${0, 1, 2, 3, ...}$ depending on the situation],
    [$ZZ$], [the set of the *integers*: ${..., -2, -1, 0, 1, 2, 3, ...}$],
    [$QQ$], [the set of the *rational numbers* (all fractions):
      ${p/q | p, q in ZZ, q != 0}$],
    [$RR$], [the set of the *real numbers*: contains all numbers on the
      number line],
    [$CC$], [the set of the *complex numbers*: adds $sqrt(-1)$ to the
      real numbers -- all algebraic equations can be solved in $CC$],
    [$=$], [*equals sign*: the expression on the left is equal to the
      expression on the right],
    [$+$], [*plus sign*: the result of an addition is a *sum*],
    [$-$], [*minus sign*: the result of a subtraction is a *difference*],
    [$dot$ or $times$], [*times sign*: the result of a multiplication is
      a *product*],
    [$\/$], [*division sign*: the result of a division is a *quotient*],
    [$x/y$], [*fraction*: an alternative way of writing division,
      consisting of a *numerator* ($x$) and a *denominator* ($y$)],
    [$sqrt(x)$], [the *square root* of $x$ is the positive number such
      that $sqrt(x) dot sqrt(x) = x$],
    [$x^2$], [$x$ *squared*: an abbreviation for $x dot x$. The general
      form $x^n$ is read "$x$ to the $n$-th *power*"],
    [$<$], [*less than*: the expression on the left is less than the
      expression on the right],
    [$<=$], [*less than or equal to*],
    [$>$], [*greater than*],
    [$>=$], [*greater than or equal to*],
    [$(med), [med], {med}$], [*brackets*: used to bring structure to
      expressions; they give the order in which calculations should be
      made],
  )
]

== Numbers and Expressions

The most fundamental building blocks in mathematics are numbers and the
operations that can be performed on them. Algebra, like arithmetic,
involves performing operations such as addition, subtraction,
multiplication, and division on numbers. In arithmetic we perform
operations on known, specific numbers (e.g. $5 + 3 = 8$); in algebra we
often deal with operations on unknown numbers represented by variables,
usually symbolized by a letter (e.g. $(a+b)/c = a/c + b/c$). The use of
variables gives us the power to write general statements about
relationships between numbers.

=== Real Numbers

#quotebox[
  "God made integers, all else is the work of man." \
  -- Leopold Kronecker
]

A real number is any number that can be represented by a point on the
real number line. Each point on the real number line corresponds to one
and only one real number, and each real number corresponds to one and
only one point on the real number line. This kind of relationship is
called a #emph[one-to-one correspondence]. The number associated with a
point on the real number line is called the #emph[coordinate] of the
point.

=== Scientific Notation

A light year (the distance light travels in one year) is
9,460,730,472,581 kilometers, and the mass of a single water molecule is
0.0000000000000000000000056 grams. Without scientific notation, these
numbers seem meaningless -- it's hard to process very large or very
small numbers this way. If we instead write $9.46 dot 10^12$ km or
$5.6 dot 10^(-24)$ g, they immediately become clearer.

#definition(title: "Scientific Notation")[
  A positive number $N$ is written in scientific notation if it is
  expressed in the form
  $ N = a dot 10^k, quad "where" 1 <= a < 10 "and" k "is an integer." $
]

This also gives us a way to compare numbers: if we change the exponent
$k$ to $k+1$, the number is one #emph[order of magnitude] (ten times)
larger.

#quotebox[
  A man walks into a bar and says: "I'd like ten times as many drinks as
  everyone here." -- now that's an order of magnitude!
]

#ex(difficulty: 1, time: "15 min")[
  Write each number in scientific notation, rounding to 3 significant
  figures.
  #parts(2,
    [(a) $253.8$],
    [(b) $0.00781$],
    [(c) $7405239$],
    [(d) $0.0000010448$],
    [(e) $4.9812$],
    [(f) $0.001991$],
    [(g) Land area of Earth: 148,940,000 square kilometers],
    [(h) Relative density of hydrogen: 0.0000899 grams per $"cm"^3$],
  )
][
  #parts(2,
    [(a) $2.54 dot 10^2$],
    [(b) $7.81 dot 10^(-3)$],
    [(c) $7.41 dot 10^6$],
    [(d) $1.04 dot 10^(-6)$],
    [(e) $4.98$],
    [(f) $1.99 dot 10^(-3)$],
    [(g) $1.49 dot 10^8 "km"^2$],
    [(h) $8.99 dot 10^(-5) "g/cm"^3$],
  )
]

=== Absolute Value

The absolute value of a number $n$ is the distance of the number $n$
from zero. The absolute value is denoted by vertical bars as $abs(n)$,
read aloud as "the absolute value of $n$."

#definition[
  If $a$ is a real number, then the *absolute value* of $a$ is
  $ abs(a) = cases(
    a & "if" a >= 0,,
    -a & "if" a < 0.,
  ) $
]

#example[
  $ abs(-3) &= 3 \
    abs(8 - 25) &= 17 \
    abs(5 + 4) &= 9 \
    abs(1 - x) &= cases(
      1 - x & "if" x <= 1,,
      x - 1 & "if" x > 1.,
    ) $
]

#ex(difficulty: 1, time: "10 min")[
  Evaluate each absolute value expression.
  #parts(3,
    [(a) $abs(-13)$],
    [(b) $abs(7-11)$],
    [(c) $-5 dot abs(-5)$],
    [(d) $abs(-3) - abs(-8)$],
    [(e) $abs(sqrt(3) - 3)$],
    [(f) $(-1)/abs(-1)$],
  )
][
  #parts(3,
    [(a) $13$], [(b) $4$], [(c) $-25$],
    [(d) $-5$], [(e) $3 - sqrt(3)$], [(f) $-1$],
  )
]

#ex(difficulty: 2, time: "15 min")[
  Find all values of $x$ that make the equation true.
  #parts(2,
    [(a) $abs(x) = 5$],
    [(b) $abs(x - 3) = 4$],
    [(c) $abs(6 - x) = 10$],
    [(d) $abs(3x + 5) = 1$],
  )
][
  #parts(2,
    [(a) $x_(1,2) = plus.minus 5$],
    [(b) $x_1 = -1$, $x_2 = 7$],
    [(c) $x_1 = 16$, $x_2 = -4$],
    [(d) $x_1 = -4/3$, $x_2 = -2$],
  )
]

=== Roots and Radicals

The square root $sqrt(x)$ of a positive real number $x$ is a positive
real number $y$ such that $y^2 = x$. Higher roots are defined
analogously: the $n$-th root $root(n, x)$ of a positive real number $x$
is a positive real number $y$ such that $y^n = x$.

The following rules apply for $a >= 0$, $b >= 0$, and $n > 0$, $n in NN$:

#keybox[
  Product: $quad root(n, a) dot root(n, b) = root(n, a dot b)$ \
  Quotient: $quad root(n, a) / root(n, b) = root(n, a/b), quad b != 0$
]

#ex(difficulty: 1, time: "15 min")[
  Express each in terms of the simplest possible radical.
  #parts(3,
    [(a) $sqrt(8)$],
    [(b) $sqrt(28)/sqrt(7)$],
    [(c) $sqrt(3) dot sqrt(12)$],
    [(d) $root(4, 64)/root(4, 4)$],
    [(e) $sqrt(15/20)$],
    [(f) $sqrt(50)$],
    [(g) $sqrt(288)$],
    [(h) $root(3, 9) dot root(3, 3)$],
  )
][
  #parts(4,
    [(a) $2 sqrt(2)$], [(b) $2$], [(c) $6$], [(d) $2$],
    [(e) $sqrt(3)/2$], [(f) $5 sqrt(2)$], [(g) $12 sqrt(2)$], [(h) $3$],
  )
]

=== Order of Operations

When algebraic expressions contain numerous operations, it is important
to evaluate the operations in the proper order. Parentheses $(med)$,
brackets $[med]$, and braces ${med}$ are used for grouping numbers and
algebraic expressions; operations must be done first within parentheses
and other grouping symbols. Other grouping symbols include absolute
value bars, radical signs, and fraction bars. The order of operations
can be remembered using the mnemonic *PEMDAS*.

#keybox(title: "Order of Operations")[
  + First, simplify expressions within parentheses and other grouping
    symbols -- including absolute value bars, fraction bars, and
    radicals. If parentheses are nested, start with the innermost ones.
  + Evaluate expressions involving exponents, radicals, and absolute
    values.
  + Perform multiplication or division in the order in which they occur,
    left to right.
  + Perform addition or subtraction in the order in which they occur,
    left to right.
]

#ex(difficulty: 2, time: "15 min")[
  Simplify the following expressions.
  #parts(2,
    [(a) $10 - 5 dot (2-5)^2 + 6/3 + sqrt(16-7)$],
    [(b) $abs((-3)^3 + (5^2-3)) / (-15/(-3) dot 2)$],
    [(c) $36/2^2 dot 3 - (18-5) dot 2 + 6$],
    [(d) $(-abs(5-7) + 11)/(-1-2)^2$],
  )
][
  #parts(4,
    [(a) $-30$], [(b) $1/2$], [(c) $7$], [(d) $1$],
  )
]
