#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Algebra Foundations")
#let ex = exercise.with(chapter: "Algebra Foundations")

// Reusable blank square for fill-in-the-gap exercises.
#let blank = box(height: 24pt, width: 24pt, stroke: 1pt, baseline: 8pt)

= Algebra Foundations

#only-theory[
  Algebra is the language the rest of this course is written in. Almost
  every later chapter -- functions, trigonometry, statistics -- assumes
  you can move symbols around without having to think about it. That
  fluency is the goal here: not new ideas so much as old ideas made
  automatic, and given precise names in English so we can talk about
  them for the next four years.
]

#toolbox()

#objectives(
  [distinguish between variables, algebraic expressions, and equations],
  [evaluate and simplify algebraic expressions, including with
    scientific notation and absolute value],
  [apply the order of operations correctly, including with nested
    exponents and radicals],
  [read and write intervals, and combine them with intersection, union,
    and set difference],
  [solve linear equations, including ones requiring multiple steps or
    fractions],
  bfkm[apply the special products (dt. _binomische Formeln_) to expand
    and to factor algebraic expressions],
  bfkm[solve equations that reduce to a quadratic, by factoring and the
    zero-product property],
  [add, simplify, and manipulate algebraic fractions],
  [translate a word problem into an equation, solve it, and check
    whether the answer makes sense],
  obj(level: "high")[justify the special products both algebraically and
    with an area diagram, rather than only quoting them],
)


== The Big Ideas in Algebra

#only-theory[
  The following graphic gives an overview of the so-called big ideas in
  algebra. Over the next four years we will cover these and many more
  topics.

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
]

#remark[
  Source: #link("https://en.wikipedia.org/wiki/Algebra")
]

=== The Building Blocks of Algebra

#only-theory[
  The main building blocks of algebra are #vocab("variable", "Variable")s,
  #vocab("expression", "Term")s, and #vocab("equation", "Gleichung")s.
]

#warning[
  Two words in that sentence are *false friends* between English and
  German, and they will cost you marks if you mix them up:
  - English *expression* = German _Term_. A German _Term_ is never
    called a "term" in English.
  - English *term* = German _Summand_ / _Glied_: one of the pieces a
    sum is built from. In $3x^2 + 5x - 7$ there are three *terms*, and
    the whole thing is one *expression*.
]



==== Variables

#definition[
  A *variable* is a placeholder (usually a letter or symbol) that stands
  for an unknown number.
]

#only-theory[
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
]

==== Expressions

#definition[
  *Algebraic expressions* can be evaluated and simplified, based on the
  basic properties of arithmetic operations (addition, subtraction,
  multiplication, division, and exponentiation).
]

#only-theory[
  For example:
  - Added terms are simplified using #vocab("coefficient", "Koeffizient")s.
    For example, $x + x + x$ can be simplified as $3 dot x$ (where 3 is
    the coefficient).
  - Multiplied terms are simplified using exponents. For example,
    $x dot x dot x$ is represented as $x^3$.
  - Like terms are added together: for example,
    $2x^2 + 3 a dot b - x^2 + a dot b$ is written as $x^2 + 4 a dot b$,
    because the terms containing $x^2$ are added together, and the terms
    containing $a dot b$ are added together.
  - Parentheses can be "multiplied out," using distributivity. For
    example, $x dot (2x + 3)$ can be written as $(x dot 2x) + (x dot 3)$,
    which simplifies to $2x^2 + 3x$.
  - Expressions can be factored. For example, $6x^5 + 3x^2$, by dividing
    both terms by $3x^2$, can be written as $3x^2 dot (2x^3 + 1)$.
]

#ex(difficulty: 1, time: "10 min", calculator: none, keep-together: true)[
  Evaluate the following terms for the given $x$\u{2011}values.

  #data-table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr),
    [$x$],
    [$x dot (x - 3)$],
    [$8x - (2 - 2x)$],
    [$0.5 dot (-2x) + 2x$],
    [$x^2 + x$],
    [$5$],
    [$10$],
    [],
    [],
    [],
    [$-3$],
    [],
    [],
    [],
    [],
    [$0.1$],
    [],
    [],
    [],
    [],
    [$0$],
    [],
    [],
    [],
    [],
    [$3/4$],
    [],
    [],
    [],
    [],
  )
][
  #data-table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr),
    row-height: auto,
    [$x$],
    [$x dot (x - 3)$],
    [$8x - (2 - 2x)$],
    [$0.5 dot (-2x) + 2x$],
    [$x^2 + x$],
    [$5$],
    [$10$],
    [$48$],
    [$5$],
    [$30$],
    [$-3$],
    [$18$],
    [$-32$],
    [$-3$],
    [$6$],
    [$0.1$],
    [$-0.29$],
    [$-1$],
    [$0.1$],
    [$0.11$],
    [$0$],
    [$0$],
    [$-2$],
    [$0$],
    [$0$],
    [$3/4$],
    [$-27/16$],
    [$11/2$],
    [$3/4$],
    [$21/16$],
  )

  Notice that the third column always returns the value of $x$ itself:
  $0.5 dot (-2x) + 2x = -x + 2x = x$. Simplifying first would have saved
  five evaluations. #heuristic("look for what stays the same")
]

==== Equations

#definition[
  An *equation* states that two expressions are equal, using the symbol
  "=".
]

#only-theory[
  - Some equations are true for all values of the involved variables: the
    commutativity of addition above states that $a + b = b + a$ for all
    values of $a$ and $b$.
  - Some equations are only true for certain values: $x^2 - 1 = 0$ is only
    true if $x = 1$ or $x = -1$. The set of those values is called the
    #vocab("solution set", "Lösungsmenge") of the equation.
]

#keybox(title: "Two important properties of equations")[
  - If $a = b$ and $c = d$, then $a + c = b + d$.
  - If $a = b$, then $a + c = b + c$.

  where $a$, $b$, $c$, and $d$ are arbitrary algebraic expressions.
]

#only-theory[
  You can think of an equation as a balance. If both sides are changed in
  the same fashion, the equation will still be true (_balanced_).

  #fig(image("images/equation-balance-2.png", width: 65%))

  If two equations are added -- left side to left side and right side to
  right side -- then the resulting equation will still be true
  (_balanced_).

  #fig(image("images/equation-balance.png", width: 65%))
]

#ex(difficulty: 1, time: "10 min", calculator: none)[
  Solve the equations for each variable.
  #parts(
    2,
    row-gutter: 1.4em,
    [(a) $p dot V = 10$],
    [(b) $4x + 3y = 10$],
    [(c) $5 dot (x - 2y) = y - (x + 3)$],
    [(d) $G dot p/100 = 20$],
    [(e) $0.5 = v dot t$],
    [(f) $(a + b)/2 = 2a + b$],
  )
][
  #parts(
    3,
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
    [$NN$],
    [the set of the *natural numbers*: either ${1, 2, 3, ...}$
      or ${0, 1, 2, 3, ...}$ depending on the situation],

    [$ZZ$], [the set of the *integers*: ${..., -2, -1, 0, 1, 2, 3, ...}$],
    [$QQ$],
    [the set of the *rational numbers* (all fractions):
      ${p/q | p, q in ZZ, q != 0}$],

    [$RR$],
    [the set of the *real numbers*: contains all numbers on the
      number line],

    [$CC$],
    [the set of the *complex numbers*: adds $sqrt(-1)$ to the
      real numbers -- all algebraic equations can be solved in $CC$],

    [$=$],
    [*equals sign*: the expression on the left is equal to the
      expression on the right],

    [$+$], [*plus sign*: the result of an addition is a *sum*],
    [$-$], [*minus sign*: the result of a subtraction is a *difference*],
    [$dot$ or $times$],
    [*times sign*: the result of a multiplication is
      a *product*],

    [$\/$], [*division sign*: the result of a division is a *quotient*],
    [$x/y$],
    [*fraction*: an alternative way of writing division,
      consisting of a *numerator* ($x$) and a *denominator* ($y$)],

    [$sqrt(x)$],
    [the *square root* of $x$ is the positive number such
      that $sqrt(x) dot sqrt(x) = x$],

    [$x^2$],
    [$x$ *squared*: an abbreviation for $x dot x$. The general
      form $x^n$ is read "$x$ to the $n$\u{2011}th *power*"],

    [$<$],
    [*less than*: the expression on the left is less than the
      expression on the right],

    [$<=$], [*less than or equal to*],
    [$>$], [*greater than*],
    [$>=$], [*greater than or equal to*],
    [$(med), [med], {med}$],
    [*brackets*: used to bring structure to
      expressions; they give the order in which calculations should be
      made],
  )
]

#remark[
  $NN$, $ZZ$, $QQ$, $RR$, and $CC$ above are all *sets* of numbers.
  Often we want to describe just a *piece* of $RR$ -- for example, "all
  numbers between $1$ and $4$." Such a piece is called a
  #vocab("subset", "Teilmenge") of $RR$, and the most common kind we'll
  work with is an #vocab("interval", "Intervall").
]

#only-theory[
  Intervals are special subsets of the real numbers -- they can be
  pictured as a section of the number line. Formally, they can be written
  in set notation, e.g.
  $ I = {x in RR med | med 1 <= x < 4}. $
  Here the square bracket would indicate that $1$ is included in the
  interval, and the round bracket that $4$ is not.

  As intervals come up constantly, they have their own shorthand notation:

  #let _iv(br) = number-line(
    from: -0.6,
    to: 1.6,
    width: 5cm,
    ticks: ((0, [$a$]), (1, [$b$])),
    nl-span(0, 1, brackets: br),
  )

  #keybox(title: "Interval Notation")[
    #data-table(
      columns: (auto, auto, 1fr),
      row-height: auto,
      [Notation],
      [Picture],
      [Set Notation],
      [$[a,b]$],
      _iv("[]"),
      [${x in RR med | med a <= x <= b}$],
      [$[a,b)$],
      _iv("[)"),
      [${x in RR med | med a <= x < b}$],
      [$(a,b]$],
      _iv("(]"),
      [${x in RR med | med a < x <= b}$],
      [$(a,b)$],
      _iv("()"),
      [${x in RR med | med a < x < b}$],
    )
    A #emph[filled] dot means the endpoint belongs to the interval, a
    #emph[hollow] one means it does not. The four intervals contain
    exactly the same numbers apart from their two endpoints -- which is
    why the brackets have to be read carefully rather than glanced at.
  ]

  There are also *unbounded* intervals, where one boundary is
  $plus.minus infinity$. These are written the same way, with $infinity$
  standing in for the missing boundary. For example
  $I = {x in RR med | med x >= 4}$ is written $[4, infinity)$. Remember
  that infinity is a concept, not a number -- so that side of the
  interval always gets a *round* bracket, since infinity itself can never
  actually be included.

  #fig(
    number-line(from: -1.5, to: 7.5, width: 9cm, nl-span(
      4,
      none,
      brackets: "[)",
    )),
    caption: [The unbounded interval $[4, infinity)$. The arrow replaces
      the endpoint that isn't there.],
  )

  Since intervals are sets, we can combine them the same way we'd combine
  any two sets.

  #image-grid(
    3,
    gutter: 8pt,
    [
      #venn2("inter", width: 4.6cm)
      #align(center)[$A inter B$]
    ],
    [
      #venn2("union", width: 4.6cm)
      #align(center)[$A union B$]
    ],
    [
      #venn2("a-only", width: 4.6cm)
      #align(center)[$A without B$]
    ],
  )
]

#definition[
  Given two sets $A$ and $B$:
  - The #vocab("intersection", "Schnittmenge") $A inter B$ is the set of
    elements belonging to *both* $A$ and $B$.
  - The #vocab("union", "Vereinigungsmenge") $A union B$ is the set of
    elements belonging to *at least one* of $A$ and $B$.
  - The #vocab("set difference", "Differenzmenge") $A without B$ is the
    set of elements belonging to $A$ but *not* to $B$.
]

#example[
  Let $A = [1, 5)$ and $B = (3, 8]$.
  - $A inter B = (3, 5)$ -- only the numbers in *both* intervals.
  - $A union B = [1, 8]$ -- every number in *either* interval.
  - $A without B = [1, 3]$ -- numbers in $A$ that are *not* in $B$: $3$
    stays, since $(3,8]$ doesn't include it; everything from $3$ up to
    $5$ gets removed, since that's exactly $A inter B$.

  #v(4pt)
  #number-line(
    from: -0.5,
    to: 9.5,
    width: 10cm,
    step: 1,
    nl-span(1, 5, brackets: "[)", label: [$A$], row: 3),
    nl-span(3, 8, brackets: "(]", label: [$B$], row: 2, color: warn-col),
    nl-span(3, 5, brackets: "()", label: [$A inter B$], row: 1, color: def-col),
  )
  #v(2pt)
  #align(center)[
    #text(size: 9pt, fill: luma(110))[
      Reading down the two bars: the overlap is open at both ends,
      because $A$ stops before $5$ and $B$ starts after $3$.
    ]
  ]
]

#example[
  Let $A = (-infinity, 2]$ and $B = [0, infinity)$.
  - $A inter B = [0, 2]$
  - $A union B = RR$ -- together they cover the whole number line.
  - $A without B = (-infinity, 0)$ -- everything in $A$ that isn't
    also $>= 0$.
]

#remark[
  Set difference is exactly how we describe a domain with a single
  point removed, e.g. the domain of $y = 1/x$ is $RR without {0}$ --
  "all real numbers, except $0$."

  #number-line(
    from: -3.5,
    to: 3.5,
    width: 8cm,
    step: 1,
    nl-span(none, none, brackets: "()"),
    nl-point(0, kind: "open"),
  )
]

#look-ahead(preview: [the domain and range of a function])[
  Interval notation looks like bookkeeping right now. It becomes the
  standard way to answer two questions we will ask of every single
  function from the next chapter onward: *which inputs are allowed*, and
  *which outputs actually occur*. Getting the brackets right here is why
  those answers will be one line long later.
]

#ex(difficulty: 1, time: "10 min", calculator: none)[
  Write each inequality as an interval.
  #parts(
    3,
    [(a) $x > 6$],
    [(b) $x <= -8$],
    [(c) $2 < x < 9$],
    [(d) $0 <= x < 12$],
    [(e) $x > -5$],
    [(f) $-3 <= x <= 3$],
  )
][
  #parts(
    3,
    [(a) $(6, infinity)$],
    [(b) $(-infinity, -8]$],
    [(c) $(2, 9)$],
    [(d) $[0, 12)$],
    [(e) $(-5, infinity)$],
    [(f) $[-3, 3]$],
  )
]

#ex(
  difficulty: 2,
  time: "10 min",
  calculator: none,
  hints: (
    [Draw both intervals on the same number line before you write
      anything down. #heuristic("draw a picture")],
    [For (e)--(h), shade the first interval, then *erase* the part the
      second one covers. Whatever survives is the answer.],
  ),
)[
  Write each of the following as an interval -- or a union of two
  intervals, if it can't be written as one.
  #parts(
    2,
    [(a) $[1,3) inter (2,7)$],
    [(b) $(-infinity,0) inter (-2,5)$],
    [(c) $[-7,-2] union (-infinity,-1)$],
    [(d) $(2,5) union (4,infinity)$],
    [(e) $[1,3) without (2,7)$],
    [(f) $[-7,-2] without (-infinity,-4)$],
    [(g) $RR without [0,5)$],
    [(h) $(-3,3) without {0}$],
  )
][
  #parts(
    2,
    [(a) $(2,3)$],
    [(b) $(-2,0)$],
    [(c) $(-infinity,-1)$],
    [(d) $(2,infinity)$],
    [(e) $[1,2]$],
    [(f) $[-4,-2]$],
    [(g) $(-infinity,0) union [5,infinity)$],
    [(h) $(-3,0) union (0,3)$],
  )
]

== Numbers and Expressions

#only-theory[
  The most fundamental building blocks in mathematics are numbers and the
  operations that can be performed on them. Algebra, like arithmetic,
  involves performing operations such as addition, subtraction,
  multiplication, and division on numbers. In arithmetic we perform
  operations on known, specific numbers (e.g. $5 + 3 = 8$); in algebra we
  often deal with operations on unknown numbers represented by variables,
  usually symbolized by a letter (e.g. $(a+b)/c = a/c + b/c$). The use of
  variables gives us the power to write general statements about
  relationships between numbers.
]

=== Real Numbers

#quotebox[
  "God made integers, all else is the work of man." \
  -- Leopold Kronecker
]

#only-theory[
  A #vocab("real number", "reelle Zahl") is any number that can be
  represented by a point on the real number line. Each point on the real
  number line corresponds to one and only one real number, and each real
  number corresponds to one and only one point on the real number line.
  This kind of relationship is called a #emph[one-to-one correspondence].
  The number associated with a point on the real number line is called
  the #emph[coordinate] of the point.

  #fig(
    number-line(
      from: -4.5,
      to: 4.5,
      width: 11cm,
      step: 1,
      nl-point(-3, label: [$-3$], row: 1),
      nl-point(-1.41421, label: [$-sqrt(2)$], row: 2, color: warn-col),
      nl-point(0.5, label: [$1/2$], row: 1),
      nl-point(3.14159, label: [$pi$], row: 2, color: warn-col),
    ),
    caption: [Whole numbers, fractions and irrational numbers all live on
      the same line -- there are no gaps between them and no separate
      shelf for the awkward ones.],
  )
]

=== Scientific Notation

#only-theory[
  A light year (the distance light travels in one year) is
  #num(9460730472581) kilometers, and the mass of a single water molecule
  is 0.0000000000000000000000056 grams. Without
  #vocab("scientific notation", "wissenschaftliche Schreibweise"), these
  numbers seem meaningless -- it's hard to process very large or very
  small numbers this way. If we instead write $9.46 dot 10^(12)$ km or
  $5.6 dot 10^(-24)$ g, they immediately become clearer.
]

#definition(title: "Scientific Notation")[
  A positive number $N$ is written in scientific notation if it is
  expressed in the form
  $ N = a dot 10^k, quad "where" 1 <= a < 10 "and" k "is an integer." $
]

#only-theory[
  This also gives us a way to compare numbers: if we change the exponent
  $k$ to $k+1$, the number is one
  #vocab("order of magnitude", "Grössenordnung") (ten times) larger.

  #fig(
    number-line(
      from: -13,
      to: 19,
      width: 12.5cm,
      ticks: (
        (-12, [$10^(-12)$]),
        (-9, [$10^(-9)$]),
        (-6, [$10^(-6)$]),
        (-3, [$10^(-3)$]),
        (0, [$10^0$]),
        (3, [$10^3$]),
        (6, [$10^6$]),
        (9, [$10^9$]),
        (12, [$10^(12)$]),
        (15, [$10^(15)$]),
        (18, [$10^(18)$]),
      ),
      nl-point(-9.6, label: [water molecule], row: 1, color: warn-col),
      nl-point(-4.2, label: [human hair], row: 2),
      nl-point(0.2, label: [you], row: 1),
      nl-point(4.9, label: [Basel--Zurich], row: 2),
      nl-point(7.1, label: [Earth], row: 1),
      nl-point(16, label: [light year], row: 2, color: warn-col),
    ),
    caption: [Lengths in meters. One step along this axis is a
      *multiplication* by ten, not an addition -- which is the only
      reason a single line can hold both a molecule and a light year.
      Note that the light year is $9.46 dot 10^(15)$ m; the
      $9.46 dot 10^(12)$ above was in kilometers, and the
      $5.6 dot 10^(-24)$ was a mass in grams, so neither belongs on
      this particular scale.],
  )
]

#quotebox[
  A man walks into a bar and says: "I'd like ten times as many drinks as
  everyone here." -- now that's an order of magnitude!
]

#ex(difficulty: 1, time: "10 min", calculator: true)[
  Write each number in scientific notation, rounding to 3 significant
  figures.
  #parts(
    2,
    [(a) $253.8$],
    [(b) $0.00781$],
    [(c) $#num(7405239)$],
    [(d) $0.0000010448$],
    [(e) $4.9812$],
    [(f) $0.001991$],
    [(g) Land area of Earth: #num(148940000) square kilometers],
    [(h) Relative density of hydrogen: 0.0000899 grams per $"cm"^3$],
  )
][
  #parts(
    2,
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

#only-theory[
  The #vocab("absolute value", "Betrag") of a number $n$ is the distance
  of the number $n$ from zero. It is denoted by vertical bars as
  $abs(n)$, read aloud as "the absolute value of $n$."
]

#definition[
  If $a$ is a real number, then the *absolute value* of $a$ is
  $
    abs(a) = cases(
      a & "if" a >= 0, ,
      -a & "if" a < 0.,
    )
  $
]

#warning[
  The second line does *not* say "$abs(a)$ is negative when $a$ is
  negative." The symbol $-a$ means "the opposite of $a$," and the
  opposite of a negative number is positive: if $a = -7$, then
  $-a = 7$. An absolute value is never negative.
]

#example[
  $
        abs(-3) & = 3 \
    abs(8 - 25) & = 17 \
     abs(5 + 4) & = 9 \
     abs(1 - x) & = cases(
                    1 - x & "if" x <= 1, ,
                    x - 1 & "if" x > 1.,
                  )
  $
]

#ex(difficulty: 1, time: "5 min", calculator: none)[
  Evaluate each absolute value expression.
  #parts(
    3,
    [(a) $abs(-13)$],
    [(b) $abs(7-11)$],
    [(c) $-5 dot abs(-5)$],
    [(d) $abs(-3) - abs(-8)$],
    [(e) $abs(sqrt(3) - 3)$],
    [(f) $(-1)/abs(-1)$],
  )
][
  #parts(
    3,
    [(a) $13$],
    [(b) $4$],
    [(c) $-25$],
    [(d) $-5$],
    [(e) $3 - sqrt(3)$],
    [(f) $-1$],
  )
]

#keybox(title: "Absolute Value as Distance")[
  $abs(x - a)$ is the *distance between $x$ and $a$* on the number line.
  So $abs(x - 3) = 4$ asks: which numbers sit exactly $4$ units away
  from $3$? Reading it this way turns an equation into a picture, and
  the two answers ($-1$ and $7$) can be read straight off the line.

  #v(4pt)
  #number-line(
    from: -3.5,
    to: 9.5,
    width: 9.5cm,
    step: 1,
    nl-point(-1, label: [$-1$], side: "below", color: warn-col),
    nl-point(3, label: [$3$], side: "below"),
    nl-point(7, label: [$7$], side: "below", color: warn-col),
    nl-measure(-1, 3, label: [$4$]),
    nl-measure(3, 7, label: [$4$]),
  )
]

#ex(
  difficulty: 2,
  time: "10 min",
  calculator: none,
  hints: (
    [Every one of these splits into *two* ordinary equations -- one
      where the inside is positive, one where it is negative.],
    [Or read it as a distance and use the number line.
      #heuristic("draw a picture")],
  ),
)[
  Find all values of $x$ that make the equation true.
  #parts(
    2,
    [(a) $abs(x) = 5$],
    [(b) $abs(x - 3) = 4$],
    [(c) $abs(6 - x) = 10$],
    [(d) $abs(3x + 5) = 1$],
  )
][
  #parts(
    2,
    [(a) $x_(1,2) = plus.minus 5$],
    [(b) $x_1 = -1$, $x_2 = 7$],
    [(c) $x_1 = 16$, $x_2 = -4$],
    [(d) $x_1 = -4/3$, $x_2 = -2$],
  )
]

=== Natural Number Powers

#look-ahead(preview: [power functions])[
  You already know how to compute things like $2^3 = 8$ or $5^2 = 25$ --
  here we give this idea a proper name and notation, since it comes back
  in a much bigger way once we study functions of the form $y = x^n$.
]

#definition[
  For a real number $a$ and a natural number $n >= 1$, the
  *$n$\u{2011}th #vocab("power", "Potenz")* of $a$ is
  $ a^n = underbrace(a dot a dot dots.h.c dot a, n med "times") . $
  We call $a$ the *#vocab("base", "Basis")* and $n$ the
  *#vocab("exponent", "Exponent")*.
]

#example[
  $
    2^3 = 2 dot 2 dot 2 = 8 quad quad (-3)^2 = (-3) dot (-3) = 9 quad quad 1^(100) = 1
  $
]

#only-theory[
  By convention, we also define $a^0 = 1$ (for $a != 0$) and $a^1 = a$.

  The *$n$\u{2011}th root* undoes the $n$\u{2011}th power: for $a >= 0$
  and a natural number $n$, $root(n, a)$ is the non-negative number $b$
  such that $b^n = a$. Powers and roots are *inverse operations* of each
  other -- one builds up a repeated product, the other asks "what number,
  raised to this power, gives me this result?"
]

#keybox(title: "Powers and Roots as Inverse Operations")[
  $ b^n = a quad <=> quad b = root(n, a), quad a >= 0, med b >= 0 $
]

#ex(difficulty: 1, time: "10 min", calculator: none)[
  Evaluate.
  #parts(4, [(a) $2^5$], [(b) $(-2)^4$], [(c) $10^3$], [(d) $0.1^2$])
][
  #parts(4, [(a) $32$], [(b) $16$], [(c) $#num(1000)$], [(d) $0.01$])
]

#ex(difficulty: 1, time: "10 min", calculator: none)[
  For each power, write the corresponding root statement, and for each
  root, write the corresponding power statement.
  #parts(
    2,
    [(a) $3^4 = 81$],
    [(b) $root(3, 27) = 3$],
    [(c) $5^2 = 25$],
    [(d) $root(4, 16) = 2$],
  )
][
  #parts(
    2,
    [(a) $root(4, 81) = 3$],
    [(b) $3^3 = 27$],
    [(c) $root(2, 25) = 5$],
    [(d) $2^4 = 16$],
  )
]

=== Roots and Radicals

#only-theory[
  The square #vocab("root", "Wurzel") $sqrt(x)$ of a positive real number
  $x$ is a positive real number $y$ such that $y^2 = x$. Higher roots are
  defined analogously: the $n$\u{2011}th root $root(n, x)$ of a positive
  real number $x$ is a positive real number $y$ such that $y^n = x$.

  The following rules apply for $a >= 0$, $b >= 0$, and $n > 0$,
  $n in NN$:
]

#keybox[
  Product: $quad root(n, a) dot root(n, b) = root(n, a dot b)$ \
  #v(.1cm)
  Quotient: $quad root(n, a) / root(n, b) = root(n, a/b), quad b != 0$
]

#warning[
  There is deliberately *no* rule for a root of a sum. In particular
  $ sqrt(a + b) eq.not sqrt(a) + sqrt(b) . $
  Check it once and you will not forget it:
  $sqrt(9 + 16) = sqrt(25) = 5$, but $sqrt(9) + sqrt(16) = 3 + 4 = 7$.
  Roots distribute over products and quotients, never over sums and
  differences. #heuristic("check an extreme or special case")
]

#ex(difficulty: 1, time: "10 min", calculator: none)[
  Express each in terms of the simplest possible radical.
  #parts(
    3,
    row-gutter: 1.4em,
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
  #parts(
    4,
    [(a) $2 sqrt(2)$],
    [(b) $2$],
    [(c) $6$],
    [(d) $2$],
    [(e) $sqrt(3)/2$],
    [(f) $5 sqrt(2)$],
    [(g) $12 sqrt(2)$],
    [(h) $3$],
  )
]

=== Order of Operations

#only-theory[
  When algebraic expressions contain numerous operations, it is important
  to evaluate the operations in the proper order. Parentheses $(med)$,
  brackets $[med]$, and braces ${med}$ are used for grouping numbers and
  algebraic expressions; operations must be done first within parentheses
  and other grouping symbols. Other grouping symbols include absolute
  value bars, radical signs, and fraction bars. The
  #vocab("order of operations", "Reihenfolge der Rechenoperationen") can
  be remembered using the mnemonic *PEMDAS*.
]

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

#warning[
  A minus sign in front of a power is *not* part of the base unless
  parentheses say so:
  $ -3^2 = -(3^2) = -9, quad "but" quad (-3)^2 = 9 . $
  Step 2 above happens before the subtraction in step 4, which is
  exactly why. The same trap appears with a calculator: type both and
  compare.
]

#only-theory[
  Rules 1--4 describe a *structure*, not a left-to-right march. The
  clearest way to see that is to watch one expression collapse from the
  inside out, one rule at a time:

  #let _step(rule, changed, expr) = (
    text(size: 8.5pt, fill: luma(120), rule),
    text(size: 8.5pt, fill: accent, changed),
    align(center, expr),
  )

  #align(center, block(
    width: 100%,
    grid(
      columns: (auto, auto, 1fr),
      column-gutter: 10pt,
      row-gutter: 7pt,
      align: horizon,
      .._step([given], [], $10 - 5 dot (2-5)^2 + 6/3 + sqrt(16-7)$),
      .._step(
        [rule 1],
        [innermost groups, radical included],
        $10 - 5 dot (-3)^2 + 6/3 + sqrt(9)$,
      ),
      .._step(
        [rule 2],
        [exponents and radicals],
        $10 - 5 dot 9 + 6/3 + 3$,
      ),
      .._step(
        [rule 3],
        [$dot$ and $:$, left to right],
        $10 - 45 + 2 + 3$,
      ),
      .._step(
        [rule 4],
        [$+$ and $-$, left to right],
        $-30$,
      ),
    ),
  ))

  Notice that the fraction bar and the radical sign never needed a rule
  of their own: both are grouping symbols, so rule 1 had already
  finished their insides before rule 2 looked at them. That is what
  survives when the expression stops looking like the ones in a
  "Klammer, Punkt, Strich" slogan.
]

#ex(difficulty: 2, time: "15 min", calculator: none)[
  Simplify the following expressions.
  #parts(
    2,
    row-gutter: 1.4em,
    [(a) $10 - 5 dot (2-5)^2 + 6/3 + sqrt(16-7)$],
    [(b) $abs((-3)^3 + (5^2-3)) / (-(15)/(-3) dot 2)$],
    [(c) $36/2^2 dot 3 - (18-5) dot 2 + 6$],
    [(d) $(-abs(5-7) + 11)/(-1-2)^2$],
  )
][
  #parts(4, [(a) $-30$], [(b) $1/2$], [(c) $7$], [(d) $1$])
]

#exploration(title: "Make 100")[
  How many numbers from 1 to 100 can you make using the digits 2, 0, 2,
  and 3, each exactly once? You may use any operations you like
  (addition, multiplication, powers, roots, etc.).
]

#ai-box(role: "Explainer")[
  Ask an AI what $8 div 2(2+3)$ equals, then ask a second AI the same
  question. If they disagree, neither is broken -- the expression itself
  is ambiguous, and different conventions resolve it differently. Write
  down one sentence saying what each model assumed, then rewrite the
  expression twice, using brackets, so that each answer becomes the
  unambiguous one.
]

== Solving Equations

#ex(difficulty: 1, time: "10 min", calculator: none)[
  Solve the following equations.
  #parts(
    2,
    [(a) $4x - 2 = 3x + 6$],
    [(b) $34 - x = 4x + 12$],
    [(c) $4.2 - 2x = 3x + 4.2$],
    [(d) $3x + 6 = 3x - 6$],
  )
][
  #parts(
    2,
    [(a) $x = 8$],
    [(b) $x = 22/5$],
    [(c) $x = 0$],
    [(d) false -- no solution],
  )

  Part (d) is worth a second look: the variable disappears and what is
  left, $6 = -6$, is simply false. That is the signature of an equation
  with an empty solution set -- not a mistake in your algebra.
]

#ex(
  difficulty: 2,
  time: "10 min",
  calculator: none,
  hints: (
    [Each right-hand side is one of the special products in disguise.
      Decide first *which* of the three it is.],
    [In (a), the $16$ is the square of the missing number, and the
      remaining box must then be twice the product of the two.],
  ),
)[
  Fill in the blanks so that both sides are equal.
  #parts(
    1,
    row-gutter: 2em,
    [(a) $(x + med #blank med)^2 = x^2 + 16 + med #blank med$],
    [(b) $(a - med #blank med) dot (a + med #blank med) = med #blank med - 81 b^2$],
    [(c) $(0.5x - med #blank med)^2 = med #blank med - 1.2 x dot y + 1.44 y^2$],
    [(d) $(med #blank med - 5t)^2 = 49 s^2 - med #blank med + med #blank med$],
  )
][
  #parts(
    1,
    row-gutter: 0.8em,
    [(a) $(x + 4)^2 = x^2 + 16 + 8x$],
    [(b) $(a - 9b) dot (a + 9b) = a^2 - 81 b^2$],
    [(c) $(0.5x - 1.2y)^2 = 0.25 x^2 - 1.2 x dot y + 1.44 y^2$],
    [(d) $(7s - 5t)^2 = 49 s^2 - 70 s dot t + 25 t^2$],
  )
]

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: none,
  hints: (
    [Expand both sides completely first. Several of these collapse to
      something much smaller than they look.],
    [If every $x^2$ cancels, what you are left with is a linear
      equation -- and it may turn out to be true always, or never.],
  ),
)[
  Solve the equations. Do a substitution check.
  #parts(
    2,
    [(a) $2x - (4 - 5x) = 10$],
    [(b) $(x-12)^2 = (x+12)^2$],
    [(c) $(x+3)^2 = x^2 + 18$],
    [(d) $2x^2 - (1.5+x)^2 = (x-0.5)^2$],
    [(e) $(10+5a) dot (3a-2) = 15a^2$],
    [(f) $(x - 1/3)^2 = (1/3 - x)^2$],
  )
][
  #parts(
    2,
    [(a) $x = 2$],
    [(b) $x = 0$],
    [(c) $x = 3/2$],
    [(d) $x = -1.25$],
    [(e) $a = 1$],
    [(f) true -- holds for all $x$],
  )

  In (f), the two sides are opposites of each other before squaring, and
  squaring destroys the sign -- so the equation holds for every $x$
  without any calculation at all.
  #heuristic("look for what stays the same")
]

== Multiplying and Factoring Algebraic Expressions

=== Multiplying Algebraic Expressions

#definition[
  The *#vocab("distributive law", "Distributivgesetz")* for real numbers
  states that
  $
    a dot (b plus.minus c) & = a b plus.minus a c \
    (a plus.minus b) dot c & = a c plus.minus b c
  $
]

#only-theory[
  #fig(
    area-model(
      cols: (([$b$], 3), ([$c$], 2)),
      rows: (([$a$], 2),),
      [$a dot b$],
      [$a dot c$],
    ),
    caption: [The whole rectangle is $a$ tall and $b + c$ wide, so its
      area is $a dot (b + c)$. Cutting it in two gives $a b$ and $a c$.
      The area doesn't care where you draw the line -- which is the
      distributive law.],
  )
]

#example[
  + $2 dot (x-3) = 2x - 6$
  + $(x-4) dot x^2 = x^3 - 4x^2$
  + $(x+2) dot (x+3) = x^2 + 5x + 6$
]

#only-theory[
  In special cases the following formulas -- known in German as the
  *binomische Formeln* -- are particularly important:
]

#keybox(title: "Special Products")[
  $
       (a+b) dot (a-b) & = a^2 - b^2 \
    (a plus.minus b)^2 & = a^2 plus.minus 2 a dot b + b^2
  $
]

#only-theory[
  Both formulas are pictures before they are formulas. For
  $(a+b)^2$, build a square of side $a + b$ and look at the four pieces:

  #fig(
    area-model(
      cols: (([$a$], 3), ([$b$], 2)),
      rows: (([$a$], 3), ([$b$], 2)),
      [$a^2$],
      [$a dot b$],
      [$a dot b$],
      [$b^2$],
    ),
    caption: [$(a+b)^2 = a^2 + 2 a dot b + b^2$. There are *two*
      rectangles, not one -- and they are exactly the term that goes
      missing when someone writes $a^2 + b^2$.],
  )

  For $(a+b) dot (a-b)$, start from a square of side $a$ and cut a
  square of side $b$ out of one corner. What's left has area
  $a^2 - b^2$; slicing it into two pieces and laying them end to end
  gives a rectangle $a + b$ long and $a - b$ tall:

  #image-grid(
    2,
    gutter: 14pt,
    [
      #area-model(
        cols: (([$a-b$], 3), ([$b$], 2)),
        rows: (([$b$], 2), ([$a-b$], 3)),
        area-cell(label: [II]),
        area-cell(label: [$b^2$], removed: true),
        area-cell(label: [I], colspan: 2),
      )
      #align(center)[
        #text(size: 9pt, fill: luma(110))[
          Area $a^2 - b^2$, cut into I and II.
        ]
      ]
    ],
    [
      #area-model(
        cols: (([$a$], 3), ([$b$], 2)),
        rows: (([$a-b$], 3),),
        [I],
        [II],
      )
      #align(center)[
        #text(size: 9pt, fill: luma(110))[
          The same two pieces, rearranged:
          $(a+b) dot (a-b)$.
        ]
      ]
    ],
  )

  Piece II is turned on its side; nothing is added or thrown away, so
  the two areas must be equal. #heuristic("look for what stays the same")
]

#warning[
  The most expensive mistake in all of school algebra:
  $ (a + b)^2 eq.not a^2 + b^2 . $
  Squaring is *not* something you can do to each term separately. Test
  it once with numbers: $(3 + 4)^2 = 7^2 = 49$, while
  $3^2 + 4^2 = 9 + 16 = 25$. The missing $24$ is exactly
  $2 dot 3 dot 4 = 2 a dot b$ -- the two rectangles in the area picture.
]

#only-high[
  Both formulas are worth deriving rather than quoting. The second one
  is just the distributive law applied twice:
  $
    (a+b)^2 & = (a+b) dot (a+b) \
            & = a dot (a+b) + b dot (a+b) \
            & = a^2 + a dot b + b dot a + b^2 = a^2 + 2 a dot b + b^2 .
  $
  Do the same for $(a+b) dot (a-b)$ and note *why* the middle terms
  cancel there but not here. A formula you can rebuild in four lines is
  one you can never quite forget.
]

#example[
  + $(2-x) dot (2+x) = 4 - x^2$
  + $(x+3)^2 = x^2 + 6x + 9$
  + $(4-x)^2 = 16 - 8x + x^2$
]

#look-ahead(preview: [completing the square and the quadratic formula])[
  Right now the special products are used from left to right, to expand.
  Reading them *backwards* -- recognizing $x^2 + 6x + dots$ as the
  beginning of $(x+3)^2$ -- is the whole trick behind completing the
  square, which in turn is where the quadratic formula comes from. The
  pattern you are drilling here is the one that derives that formula.
]

=== Factoring Algebraic Expressions

#only-theory[
  To #vocab("factor", "faktorisieren") an expression means to rewrite it
  as a product of simpler expressions -- the reverse of
  #vocab("expanding", "ausmultiplizieren"). Several methods can help:

  *Method 1: Common Factor*
]

#example[
  $ 2x^2 dot y + x dot y^2 - x^2 dot y^2 = x dot y dot (2x + y - x dot y) $
]

#only-theory[
  *Method 2: Trial and Error*
]

#example[
  $ x^2 - 4x - 12 = (x-6) dot (x+2) $
]

#only-theory[
  *Application: Solving Equations*
]

#example[
  $
           3x^2 + 4x - 4 & = 0 \
    (3x - 2) dot (x + 2) & = 0
  $
  Thus $x_1 = 2/3$ and $x_2 = -2$.
]

#keybox(title: "Why Factoring Solves Equations")[
  A product is zero exactly when one of its factors is zero. So once one
  side is a product and the other side is $0$, a single equation splits
  into several easy ones. This is called the *zero-product property*, and
  it is the reason we bother factoring at all.
]

#warning[
  The zero-product property works because the right-hand side is *zero*.
  From $(x-2) dot (x+1) = 6$ you may *not* conclude $x - 2 = 6$ or
  $x + 1 = 6$ -- there are far too many ways for two numbers to multiply
  to $6$. Always bring everything to one side first.
]

#ex(difficulty: 2, time: "15 min", calculator: none)[
  Expand and simplify.
  #parts(
    3,
    [(a) $(n+4) dot (n-5)$],
    [(b) $(x+7) dot (x-7)$],
    [(c) $(5m+2)^2$],
    [(d) $(x-1)^3$],
    [(e) $(a+b) dot (a-b+1)$],
    [(f) $(1+sqrt(5)) dot (1-sqrt(5))$],
  )
][
  #parts(
    3,
    [(a) $n^2 - n - 20$],
    [(b) $x^2 - 49$],
    [(c) $25m^2 + 20m + 4$],
    [(d) $x^3 - 3x^2 + 3x - 1$],
    [(e) $a^2 + a - b^2 + b$],
    [(f) $-4$],
  )
]

#ex(
  difficulty: 2,
  time: "20 min",
  calculator: none,
  hints: (
    [Always look for a common factor *first* -- (a), (b), (f) and (j)
      all get much smaller once you pull one out.],
    [For (i), substitute $u = y - 3$ and the difference of squares
      becomes visible. #heuristic("introduce notation")],
  ),
)[
  Factor each expression.
  #parts(
    2,
    [(a) $12x^2 - 48$],
    [(b) $x^3 - 6x^2$],
    [(c) $x^2 + x - 12$],
    [(d) $7 - 6m - m^2$],
    [(e) $x^2 - 10x + 16$],
    [(f) $3n^2 - 21n + 30$],
    [(g) $a^2 - 16$],
    [(h) $x^4 - 1$],
    [(i) $9 - (y-3)^2$],
    [(j) $4z^4 - 8z^3 - 96z^2$],
  )
][
  #parts(
    2,
    [(a) $12 dot (x-2) dot (x+2)$],
    [(b) $x^2 dot (x-6)$],
    [(c) $(x-3) dot (x+4)$],
    [(d) $-(m-1) dot (7+m)$],
    [(e) $(x-2) dot (x-8)$],
    [(f) $3 dot (n-2) dot (n-5)$],
    [(g) $(a+4) dot (a-4)$],
    [(h) $(x^2+1) dot (x+1) dot (x-1)$],
    [(i) $-y dot (y-6)$],
    [(j) $4z^2 dot (z-6) dot (z+4)$],
  )

  For (h), the difference of squares can be applied twice; for (i), the
  substitution $u = y - 3$ turns it into $9 - u^2 = (3-u) dot (3+u)$
  before substituting back. #heuristic("introduce notation")
]

#ai-box(role: "Generator")[
  Ask an AI to produce ten quadratic expressions of the form
  $x^2 + b x + c$ that factor into two brackets with *integer* entries.
  Then expand each of the ten yourself and record how many of its claims
  were actually true. Report the hit rate, and for one failure, say in a
  sentence what the model got wrong -- generating plausible-looking
  problems is easy, generating correct ones is not the same task.
]

#ex(difficulty: 2, time: "20 min", calculator: none)[
  Solve the following equations.
  #parts(
    2,
    [(a) $x dot (x-3) = 0$],
    [(b) $4x^2 - 12x = 0$],
    [(c) $x^2 - 16 = 0$],
    [(d) $(1-x)^2 = 4$],
    [(e) $(x-2) dot (2-3x) dot (x+7) = 0$],
    [(f) $x^2 - x - 12 = 0$],
    [(g) $x^2 = -1$],
    [(h) $x^2 + 9x + 20 = 0$],
    [(i) $(x-2)^2 + 4 = 0$],
    [(j) $x^2 - 7x + 12 = 0$],
  )
][
  #parts(
    2,
    [(a) $x_1 = 0$, $x_2 = 3$],
    [(b) $x_1 = 0$, $x_2 = 3$],
    [(c) $x_(1,2) = plus.minus 4$],
    [(d) $x_1 = -1$, $x_2 = 3$],
    [(e) $x_1 = 2$, $x_2 = 2/3$, $x_3 = -7$],
    [(f) $x_1 = -3$, $x_2 = 4$],
    [(g) no real solution],
    [(h) $x_1 = -4$, $x_2 = -5$],
    [(i) no real solution],
    [(j) $x_1 = 3$, $x_2 = 4$],
  )

  In (g) and (i) a square would have to come out negative, which no real
  number can do.
]

#only-high[
  #look-ahead(preview: [complex numbers])[
    "No real solution" is a careful phrase, not a dead end. The equation
    $x^2 = -1$ has no answer *among the real numbers* -- but neither did
    $x + 5 = 2$ before negative numbers existed, and neither did
    $2x = 1$ before fractions. Each time, mathematicians extended the
    number system rather than accepting the gap. Doing it once more, by
    inventing a number whose square is $-1$, produces $CC$ -- and in
    $CC$ every polynomial equation has a solution.
  ]
]

== Working with Fractions

#only-theory[
  A fraction $a/b$ is simply an alternative way of writing the division
  $a : b$. If you remember the following, you should be set:
  - In a fraction, the upper number (or expression) is called the
    #vocab("numerator", "Zähler"), and the lower one is called the
    #vocab("denominator", "Nenner").
  - A fraction can be *simplified* if and only if the numerator and
    denominator share a common *factor*
    (e.g. $4/12 = (4 dot 1)/(4 dot 3) = 1/3$).
  - The minus sign of a negative fraction can be in many different places:
    $ -a/b = (-a)/b = a/(-b) = (-1) dot a/b\. $
  - Fractions can be added and subtracted only if they have a common
    denominator:
    $ (a+c)/(2b^2) + (a-c)/(2b^2) = (2a)/(2b^2) = a/b^2\. $
  - Sometimes it's useful to split a fraction into multiple summands:
    $ (a+b)/c = a/c + b/c\. $
]

#warning[
  "Common *factor*" is the whole sentence -- you may cancel factors, never
  terms:
  $ (x + 3)/3 eq.not x + 1, quad "but" quad (3 dot x)/3 = x . $
  In the first fraction the $3$ in the denominator is a factor of the
  *whole* numerator, not of the $x$ alone. A quick check with $x = 3$
  settles it: the left side is $2$, the right side is $4$.
  #heuristic("check an extreme or special case")
]

#example[
  $
    (1-x^2)/(x^2+x-2) = ((1-x) dot (1+x))/((x-1) dot (x+2)) = (-(1+x))/(x+2) = -(x+1)/(x+2)
  $
]

#example[
  $ x - 1/x = x^2/x - 1/x = (x^2-1)/x $
]

#example[
  $
    (a/b + 1)/(1 - a/b) = (a/b + b/b)/(b/b - a/b) = ((a+b)/b)/((b-a)/b) = (a+b)/b dot b/(b-a) = (a+b)/(b-a)
  $
]

#ai-box(role: "Checker")[
  A student hands in these two lines:
  $ (x + 3)/3 = x + 1 quad quad "and" quad quad (x^2 - 9)/(x - 3) = x + 3 . $
  Exactly one of them is correct. Decide which on paper first, with a
  reason. Then ask an AI to mark the same two lines. If it marks both
  correct, or both wrong, write one sentence identifying the error *the
  model* made -- and say what you would have to add to the prompt to
  stop it happening.
]

#ex(difficulty: 1, time: "15 min", calculator: none)[
  Simplify the following fractions.
  #parts(
    3,
    [(a) $(8a dot b)/(64a^2 dot b^2)$],
    [(b) $(24a^2)/(24a dot b)$],
    [(c) $(-27a^5)/(9a^4)$],
    [(d) $(12a^3 dot x dot y)/(10x^2)$],
    [(e) $(-45a dot b dot m^3 dot n)/(-10m dot n^2)$],
    [(f) $(15x^2 dot y)/(35x dot y^2)$],
  )
][
  #parts(
    3,
    [(a) $1/(8a dot b)$],
    [(b) $a/b$],
    [(c) $-3a$],
    [(d) $(6a^3 dot y)/(5x)$],
    [(e) $(9a dot b dot m^2)/(2n)$],
    [(f) $(3x)/(7y)$],
  )
]

#ex(difficulty: 2, time: "15 min", calculator: none)[
  Simplify the following fractions.
  #parts(
    3,
    [(a) $(28a-35b)/21$],
    [(b) $(5x+5y)/(25x+25y)$],
    [(c) $(8a+16b)/(24a-8b)$],
    [(d) $25/(5x+10)$],
    [(e) $(18a^2 dot b dot c)/(18a^2 dot b^2 dot c+54a^2 dot b dot c^2)$],
    [(f) $(r dot s+r dot t)/(s dot x+t dot x)$],
  )
][
  #parts(
    3,
    [(a) $(4a-5b)/3$],
    [(b) $1/5$],
    [(c) $(a+2b)/(3a-b)$],
    [(d) $5/(x+2)$],
    [(e) $1/(b+3c)$],
    [(f) $r/x$],
  )

  Every one of these needs factoring *before* anything can be cancelled --
  that is the point of the set.
]

#ex(
  difficulty: 2,
  time: "20 min",
  calculator: none,
  hints: (
    [Factor numerator and denominator completely before cancelling
      anything. Most of these hide a difference of squares.],
    [In (f), $x^4 - 16$ is a difference of squares twice over.],
  ),
)[
  Simplify the following fractions.
  #parts(
    3,
    [(a) $(x^2-25)/(x^2+10x+25)$],
    [(b) $(a^4-1)/(a^2-1)$],
    [(c) $(9x^2-16y^2)/(8y-6x)$],
    [(d) $(x^4-2x^2+1)/(x^3-x)$],
    [(e) $(4x-4a dot x)/(4a^2-4)$],
    [(f) $(x^4-16)/(x+2)$],
  )
][
  #parts(
    3,
    [(a) $(x-5)/(x+5)$],
    [(b) $a^2+1$],
    [(c) $-(3x+4y)/2$],
    [(d) $(x^2-1)/x$],
    [(e) $-x/(a+1)$],
    [(f) $(x^2+4) dot (x-2)$],
  )
]

#ex(difficulty: 2, time: "15 min", calculator: none)[
  Multiply and simplify.
  #parts(
    3,
    [(a) $(8a)/(27b) dot (9b dot c)/(16a)$],
    [(b) $3a dot 4/(5a)$],
    [(c) $44x^2 dot y^2 dot (-2x^3)/(11y^3)$],
    [(d) $p/q dot p dot q$],
    [(e) $(-x^2 dot y)/(28z^3) dot (7z^2)/(x^2 dot y^2)$],
    [(f) $(9a)/(4b) dot 6a dot b$],
  )
][
  #parts(
    3,
    [(a) $c/6$],
    [(b) $12/5$],
    [(c) $-(8x^5)/y$],
    [(d) $p^2$],
    [(e) $-1/(4y dot z)$],
    [(f) $(27a^2)/2$],
  )
]

#ex(difficulty: 2, time: "15 min", calculator: none)[
  Divide and simplify.
  #parts(
    2,
    [(a) $(5k dot m)/6 : (3k)/(2m)$],
    [(b) $19r^2 dot s^2 : (19r^2 dot s^2)/(23t)$],
    [(c) $(x dot y)/(w dot z) : y dot z$],
    [(d) $(-(72f)/(85h^3)) : (-(48f^2)/(85h^3))$],
    [(e) $(-14x dot y)/(9z^3) : (21x^2)/(99z^2)$],
    [(f) $(9c^2 dot d)/(a dot b) : 9c^2 dot d$],
  )
][
  #parts(
    2,
    [(a) $(5m^2)/9$],
    [(b) $23t$],
    [(c) $x/(w dot z^2)$],
    [(d) $3/(2f)$],
    [(e) $-(22y)/(3x dot z)$],
    [(f) $1/(a dot b)$],
  )
]

#ex(difficulty: 2, time: "20 min", calculator: none)[
  Add/subtract and simplify.
  #parts(
    3,
    [(a) $4a - (4a^2+5)/(a-1)$],
    [(b) $(17a-15)/39 - (8a+9)/26$],
    [(c) $(5c)/(6a^3) + c/(3a^2)$],
    [(d) $1/a + 1/a^2 + 1/a^3$],
    [(e) $1 - (c-d)/(c+d)$],
    [(f) $5/(2a dot c) + 3/(5c dot d)$],
  )
][
  #parts(
    3,
    [(a) $-(4a+5)/(a-1)$],
    [(b) $(10a-57)/78$],
    [(c) $(5c+2a dot c)/(6a^3)$],
    [(d) $(a^2+a+1)/a^3$],
    [(e) $(2d)/(c+d)$],
    [(f) $(25d+6a)/(10a dot c dot d)$],
  )
]

#ex(difficulty: 2, time: "15 min", calculator: none)[
  Simplify the following fractions.
  #parts(
    2,
    [(a) $(x+4)/(x^2+5x+4)$],
    [(b) $(3n-2)/(6n^2-6n)$],
    [(c) $(a^2-b^2)/(5a-5b)$],
    [(d) $((2x+h)^2-4x^2)/h$],
  )
][
  #parts(
    2,
    [(a) $1/(x+1)$],
    [(b) already in lowest terms],
    [(c) $(a+b)/5$],
    [(d) $4x+h$],
  )

  Part (b) is the odd one out on purpose: $6n^2 - 6n = 6n dot (n-1)$
  shares no factor with $3n - 2$, so there is nothing to cancel. Being
  able to say "this cannot be simplified" *and defend it* is as much a
  skill as simplifying.
]

#look-ahead(preview: [the derivative and instantaneous rate of change])[
  Part (d) of the last exercise deserves a name. The expression
  $ (f(x + h) - f(x))/h $
  measures the average rate of change of a function between $x$ and
  $x + h$ -- for $f(x) = 4x^2$ it simplified to $4x + h$. Later we will
  ask what happens to that answer as $h$ shrinks toward zero. The
  algebra you just did is the entire computational content of that
  question; only the limit is new.
]

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: none,
  hints: (
    [In (b), write the $4$ as a fraction over the same denominator
      before subtracting.],
    [In (d), factor $3x^2 - 3$ first and notice that $1 - x$ is the
      negative of $x - 1$.],
  ),
)[
  Perform the indicated operation and simplify.
  #parts(
    2,
    [(a) $x/5 - (x-1)/3$],
    [(b) $2/(2x-1) - 4$],
    [(c) $1/(x+y) + 1/(x-y)$],
    [(d) $(3x^2-3)/(6x) dot (5x^2)/(1-x)$],
  )
][
  #parts(
    2,
    [(a) $(5-2x)/15$],
    [(b) $(6-8x)/(2x-1)$],
    [(c) $(2x)/(x^2-y^2)$],
    [(d) $-(5x^2+5x)/2$],
  )
]

#ex(
  difficulty: 3,
  time: "10 min",
  calculator: none,
  hints: (
    [Do not put all six over one enormous denominator. Look at the
      denominators' prime factors first: $39 = 3 dot 13$,
      $38 = 2 dot 19$, $33 = 3 dot 11$, $22 = 2 dot 11$.],
    [That pairs them up: $13$ with $39$, $19$ with $38$, $22$ with $33$.
      Add each pair on its own and see what you get.],
  ),
)[
  Calculate the sum.
  $ 3/13 + 8/19 + 3/22 + 1/33 + 3/38 + 4/39 = med ? $
][
  $1$

  Grouping by shared prime factors,
  $3/13 + 4/39 = 13/39 = 1/3$, $8/19 + 3/38 = 19/38 = 1/2$, and
  $3/22 + 1/33 = 11/66 = 1/6$. Then
  $1/3 + 1/2 + 1/6 = 1$. #heuristic("look for what stays the same")
]

#ex(
  difficulty: 1,
  time: "5 min",
  calculator: none,
  hints: ([Both fractions can be written over the denominator $3600$.],),
)[
  Calculate.
  $ sqrt(1/25 + 1/144) = med ? $
][
  $13/60$

  $1/25 + 1/144 = 144/3600 + 25/3600 = 169/3600$, and both $169$ and
  $3600$ are perfect squares. The numbers $5$, $12$, $13$ are not a
  coincidence -- they are a Pythagorean triple, which is where this
  exercise comes from.
]

== Techniques You Know So Far

#only-theory[
  Before we start applying these to real-world problems, let's take stock
  of the equation-solving methods now in your toolkit.
]

#known-techniques(
  "Simple transformations (do the same thing to both sides)",
  "Factoring (common factor, trial and error) together with the zero-product property",
)

#only-theory[
  Here is a quick mixed workout using both techniques together. The
  first decision -- *which* technique -- is the one worth practicing;
  the algebra afterward you already know.
]

#ex(difficulty: 2, time: "15 min", calculator: none, keep-together: true)[
  Solve each equation, using whichever technique fits best.
  #parts(
    2,
    [(a) $5x - 8 = 2x + 7$],
    [(b) $x^2 - 5x + 6 = 0$],
    [(c) $3 dot (2x - 1) = x + 9$],
    [(d) $x^2 - 9x = 0$],
  )
][
  #parts(
    2,
    [(a) $x = 5$],
    [(b) $x_1 = 2$, $x_2 = 3$],
    [(c) $x = 12/5$],
    [(d) $x_1 = 0$, $x_2 = 9$],
  )

  The tell is the highest power: (a) and (c) are linear, so transform;
  (b) and (d) contain an $x^2$, so factor and use the zero-product
  property. In (d), dividing both sides by $x$ would lose the solution
  $x = 0$ -- factor instead of dividing.
]

== Solving Word Problems

#only-theory[
  A classic math word problem consists of two steps:
  - *Translate* the problem into an equation.
  - *Solve* the equation.

  As we gather more experience, we'll see that it's often necessary to add
  a third step to this process:
  - *Assess* the solution: do the numbers make sense? What consequences
    does this result have?

  Even further along, we'll add an additional step at the very beginning:
  - Create a *model* that describes a given situation.

  The middle step -- solving the equation -- is often the least
  interesting one. As a result, the other steps will become more and more
  prominent as we progress.

  The translate step has a shape that repeats every single time. Here it
  is, applied to the bicycle problem further down:
]

#abstraction-ladder(
  l0: [Pat rides his bike home from a point, then gets a flat tire and
    walks back along the very same path.],
  l1: [Riding: $11$ mph for $3/4$ hr. Walking: unknown rate, $2$ hr.],
  l2: [Distance $=$ rate $times$ time, and both journeys cover the
    *same* distance.],
  l3: [$11 dot 3/4 = v dot 2$],
)

#only-theory[
  Level 2 is where the actual thinking happens: noticing that the
  distance is the quantity that does not change is what makes an equation
  possible at all. #heuristic("look for what stays the same")

  #fig(
    number-line(
      from: -0.6,
      to: 9.5,
      width: 10cm,
      step: 1,
      axis-label: [distance (miles)],
      nl-span(
        0,
        8.25,
        brackets: "[]",
        label: [riding: $11 dot 3/4$],
        row: 2,
      ),
      nl-span(
        0,
        8.25,
        brackets: "[]",
        label: [walking: $v dot 2$],
        row: 1,
        color: warn-col,
      ),
    ),
    caption: [The two bars have to end at the same place, because it is
      the same path. That shared endpoint *is* the equation.],
  )

]

#ex(difficulty: 1, time: "10 min", calculator: none)[
  Translate the following into an equation and solve.
  + Four times a number is 48.
  + A number doubled and reduced by 12 equals 10.
  + The sum of a number and its half equals 33.
][
  + $4x = 48 => x = 12$
  + $2x - 12 = 10 => x = 11$
  + $x + x/2 = 33 => x = 22$
]

#ex(
  difficulty: 2,
  time: "10 min",
  calculator: none,
  hints: (
    [Call the shorter piece $x$. How long is the other one, and
      what must the two lengths add up to?],
  ),
)[
  To do a rope trick, a magician needs to cut a piece of rope so that one
  piece is one-third the length of the other. If she begins with an
  $8/3$ ft rope, what lengths will the two pieces be?
][
  $2/3$ ft and $2$ ft.

  With $x$ the short piece, the long one is $3x$ and $x + 3x = 8/3$.
  #heuristic("draw a picture")
]

#ex(
  difficulty: 2,
  time: "10 min",
  calculator: none,
  hints: (
    [If the smallest even integer is $n$, the next two are $n+2$
      and $n+4$ -- not $n+1$ and $n+2$.],
  ),
)[
  Of three consecutive even integers, the sum of the smallest two is
  equal to 6 less than the largest. Find the integers.
][
  $-4$, $-2$, and $0$.

  From $n + (n+2) = (n+4) - 6$ we get $n = -4$. Note that the answer is
  negative -- "integer" was meant literally, and nothing in the problem
  ruled that out. #heuristic("introduce notation")
]

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: true,
  hints: (
    [What quantity is the same for the ride out and the walk
      back?],
  ),
)[
  Pat averages a rate of 11 mph on his bike. One day he rode for 45 min
  ($3/4$ hr) and then got a flat tire and had to walk back home. He
  walked the same path he rode, and it took him 2 hr. What was his
  average rate walking?
][
  4.125 mph.

  The distance is the invariant: $11 dot 3/4 = v dot 2$, so
  $v = 33/8 = 4.125$. A walking pace of about 4 mph ($approx 6.6$ km/h)
  is fast but plausible -- worth checking, since an answer of 40 mph
  would have meant an error somewhere.
  #heuristic("look for what stays the same")
]

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: true,
  hints: (
    [Let $x$ be the amount in the 6% account; then the other
      account holds $x + #num(2000)$.],
  ),
)[
  Sharyn invests \$#num(2000) more in an account that earns 9% simple
  interest than she invests in an account that earns 6% simple interest.
  How much did she invest in each account if her total interest is \$405
  after 1 year?
][
  9% account: \$#num(3500). 6% account: \$#num(1500).

  From $0.09 dot (x + #num(2000)) + 0.06 x = 405$.
  #heuristic("introduce notation")
]

#ex(difficulty: 2, time: "10 min", calculator: true)[
  In 2003, approximately 7.2 million men were in college in the United
  States. This represents an 8% increase over the number of men in
  college in 2000. Approximately how many men were in college in 2000?
  (Round to the nearest tenth of a million.)
][
  6.7 million.

  Note that the answer is *not* $7.2 dot 0.92$: the 8% was taken of the
  smaller, earlier number, so the equation is $1.08 x = 7.2$.
]

#ex(difficulty: 2, time: "10 min", calculator: true)[
  In 2002, there were #num(17430) deaths due to alcohol-related accidents
  in the United States. This was a 5% increase over the number of
  alcohol-related deaths in 1999. How many such deaths were there in
  1999?
][
  #num(16600) deaths.
]

#exploration(title: "A Better Fit")[
  Which is a better fit: a square peg in a round hole, or a round peg in
  a square hole?
]

#only-theory[
  #let _peg(round-hole) = box(width: 3.2cm, height: 3.2cm, {
    let s = 3.2cm
    let m = 0.16cm // margin so strokes aren't clipped
    let side = s - 2 * m
    let outer = if round-hole {
      circle(radius: side / 2, fill: none, stroke: 0.9pt + luma(120))
    } else {
      rect(width: side, height: side, fill: none, stroke: 0.9pt + luma(120))
    }
    place(dx: m, dy: m, outer)
    // inscribed peg: a square inside the circle has diagonal = side,
    // so its own side is side/sqrt(2); a circle inside the square has
    // diameter = side.
    if round-hole {
      let q = side / calc.sqrt(2)
      place(
        dx: m + (side - q) / 2,
        dy: m + (side - q) / 2,
        rect(width: q, height: q, fill: accent-bg, stroke: 1pt + accent),
      )
    } else {
      place(
        dx: m,
        dy: m,
        circle(radius: side / 2, fill: accent-bg, stroke: 1pt + accent),
      )
    }
  })

  #image-grid(
    2,
    gutter: 16pt,
    [
      #align(center, _peg(true))
      #align(center)[
        #text(size: 9pt, fill: luma(110))[square peg, round hole]
      ]
    ],
    [
      #align(center, _peg(false))
      #align(center)[
        #text(size: 9pt, fill: luma(110))[round peg, square hole]
      ]
    ],
  )
]

#ai-box(role: "Checker")[
  Take any two-digit number, reverse its digits, and subtract the
  smaller number from the larger. Do you ever end up with a prime
  number? Prove your answer on paper first, then ask an AI to check --
  and explain -- your reasoning.
]

#print-hints()
#print-vocab()
