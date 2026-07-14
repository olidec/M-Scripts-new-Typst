#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Systems of Equations")
#let ex = exercise.with(chapter: "Systems of Equations")

= Systems of Equations

#only-theory[
  Given two linear equations in two variables (usually $x$ and $y$), we
  can look for a common solution -- a pair of values that satisfies both
  equations at once. This combination of two equations is called a
  *system of linear equations*. There are several different methods for
  solving such a system.
]

== The Graphical Method

#only-theory[
  In this method, both equations are interpreted as equations of linear
  functions. We draw both graphs in a common coordinate system and find
  their point of intersection.
]

#example[
  We consider the system
  $ #system(($y$, $1/3 x - 1$), ($y$, $-x + 3$)) $
  #align(center, plot(
    xmin: -3.5,
    xmax: 5.5,
    ymin: -3.5,
    ymax: 4.5,
    width: 7cm,
    height: 6cm,
    show-grid: "major",
    (fn: x => 1 / 3 * x - 1, stroke: accent + 1.3pt),
    (fn: x => -x + 3, stroke: warn-col + 1.3pt),
  ))
  We can read off that the point of intersection has coordinates
  $S(3, 0)$.
]

#ex(difficulty: 1, time: "10 min")[
  Use the graphical method to solve these systems of linear equations.
  #parts(
    2,
    [(a) $#system(($y$, $2x - 1$), ($y$, $-x + 5$))$],
    [(b) $#system(($2x + y$, $2$), ($x + 2y$, $7$))$],
  )
][
  #parts(2, [(a) $x = 2$, $y = 3$], [(b) $x = -1$, $y = 4$])
]

#only-theory[
  In the example and exercise above, each system had exactly one
  solution -- the two lines crossed at a single point. But that's not
  the only thing that can happen.
]

#keybox(title: "How Many Solutions Can a System Have?")[
  Two lines in the plane relate to each other in exactly one of three
  ways:
  - They cross at *exactly one point* -- the system has *one solution*.
  - They are *parallel* (same slope, different $y$-intercept) and never
    meet -- the system has *no solution*.
  - They are *the same line* (same slope, same $y$-intercept) -- every
    point on the line solves both equations, so the system has
    *infinitely many solutions*.
]

#image-grid(
  2,
  gutter: 10pt,
  [
    #plot-graph(
      x => 0.5 * x + 1,
      (fn: x => -x + 4, color: warn-col),
      xmin: -4.5,
      xmax: 4.5,
      ymin: -1.5,
      ymax: 5.5,
      size: 4.5,
      grid-step: 1,
    )
    One solution -- the lines cross once.
  ],
  [
    #plot-graph(
      x => 0.5 * x + 1,
      (fn: x => 0.5 * x - 1.5, color: warn-col),
      xmin: -4.5,
      xmax: 4.5,
      ymin: -3.5,
      ymax: 3.5,
      size: 4.5,
      grid-step: 1,
    )
    No solution -- the lines are parallel (same slope) and never meet.
  ],
)

#look-ahead(preview: [quadratic functions])[
  Two straight lines can meet at most *once*. But what if one of the
  graphs were curved instead of straight -- like a parabola? A line and
  a parabola can meet twice, once, or not at all. We'll explore exactly
  this once we study quadratic functions.
]

== The Elimination Method

#only-theory[
  This method uses the fact that if two equations are both true, we can
  create a third true equation by adding their left-hand sides and their
  right-hand sides:
  $ A = B "and" C = D quad => quad A + C = B + D. $
  Doing this skillfully lets us *eliminate* one of the unknowns, leaving
  an equation in a single variable that we can solve directly.
]

#example[
  Given the system
  $ #system(($5x + 3y$, $9$), ($2x - 4y$, $14$)) $
  We multiply the top equation by $4$ and the bottom equation by $3$:
  $ #system(($20x + 12y$, $36$), ($6x - 12y$, $42$)) $
  Adding the two equations gives $26x = 78$, so $x = 3$. Plugging this
  into either original equation and solving for $y$:
  $ 5 dot 3 + 3y = 9 quad => quad 3y = -6 quad => quad y = -2. $
  So the solution is $x = 3$, $y = -2$.
]

#example[
  Elimination also reveals when a system has *no solution* or
  *infinitely many*. Consider
  $ #system(($2x + y$, $5$), ($4x + 2y$, $6$)) $
  Multiplying the first equation by $2$ gives $4x + 2y = 10$. Comparing
  this with the second equation:
  $ (4x + 2y) - (4x + 2y) = 10 - 6 quad => quad 0 = 4. $
  This statement is *false* -- no values of $x$ and $y$ can make it
  true. The system has *no solution* (the lines are parallel: both have
  slope $-2$, but different $y$-intercepts).

  Now consider almost the same system, with one number changed:
  $ #system(($2x + y$, $5$), ($4x + 2y$, $10$)) $
  Multiplying the first equation by $2$ now gives $4x + 2y = 10$ -- the
  *same* as the second equation. Subtracting gives
  $ 0 = 0, $
  which is *always true*. The system has *infinitely many solutions*:
  the two equations describe the same line.
]

#ex(difficulty: 2, time: "25 min", keep-together: true)[
  Use the elimination method to solve these systems of linear equations.
  #parts(
    2,
    [(a) $#system(($x + 3y$, $8$), ($x - 2y$, $3$))$],
    [(b) $#system(($x - 6y$, $1$), ($3x + 2y$, $13$))$],
    [(c) $#system(($6x + 3y$, $6$), ($5x + 4y$, $-1$))$],
    [(d) $#system(($x + 3y$, $-1$), ($x - 2y$, $7$))$],
    [(e) $#system(($8x - 12y$, $4$), ($-2x + 3y$, $2$))$],
    [(f) $#system(($5x + 7y$, $9$), ($-11x - 5y$, $1$))$],
  )
][
  #parts(
    2,
    [(a) $x = 5$, $y = 1$],
    [(b) $x = 4$, $y = 1/2$],
    [(c) $x = 3$, $y = -4$],
    [(d) $x = 19/5$, $y = -8/5$],
    [(e) no solution],
    [(f) $x = -1$, $y = 2$],
  )
]

== The Substitution Method

#only-theory[
  In this method, we solve one of the equations for one of the unknowns,
  then plug that expression into the other equation.
]

#example[
  Given the system
  $ #system(($3x - y$, $-9$), ($6x + 2y$, $2$)) $
  We solve the first equation for $y$: $y = 3x + 9$. Plugging this into
  the second equation:
  $
    6x + 2 dot (3x + 9) = 2 quad => quad 12x + 18 = 2 quad => quad 12x = -16 quad => quad x = -16/12 = -4/3.
  $
  Plugging this back into $y = 3x + 9$:
  $ y = 3 dot (-4/3) + 9 = -4 + 9 = 5. $
  So the solution is $x = -4/3$, $y = 5$.
]

#ex(difficulty: 2, time: "25 min", keep-together: true)[
  Use the substitution method to solve these systems of linear
  equations.
  #parts(
    2,
    [(a) $#system(($2x + y$, $1$), ($3x + 2y$, $3$))$],
    [(b) $#system(($3x - 2y$, $7$), ($5x - y$, $-7$))$],
    [(c) $#system(($2x + 8y$, $-6$), ($-5x - 20y$, $15$))$],
    [(d) $#system(($x/5 + y/2$, $8$), ($x + y$, $20$))$],
    [(e) $#system(($2x - y$, $-2$), ($4x + y$, $5$))$],
    [(f) $#system(($0.4x + 0.3y$, $1$), ($0.25x + 0.1y$, $-0.25$))$],
  )
][
  #parts(
    2,
    [(a) $x = -1$, $y = 3$],
    [(b) $x = -3$, $y = -8$],
    [(c) infinitely many solutions: $x = -4y - 3$],
    [(d) $x = 20/3$, $y = 40/3$],
    [(e) $x = 1/2$, $y = 3$],
    [(f) $x = -5$, $y = 10$],
  )
]

== Verifying and Mixed Practice

#ex(difficulty: 1, time: "10 min")[
  Decide which (if either) of the given points is a solution to the
  linear system.
  #parts(
    2,
    [(a) $#system(($x + y$, $6$), ($2x - 4y$, $10$))$ -- test $(3,3)$ or $(10,2)$],
    [(b) $#system(($3x - 2y$, $8$), ($-4x + 3y$, $-11$))$ -- test $(1,2)$ or $(2,-1)$],
  )
][
  + Neither point solves both equations.
  + $(2,-1)$ solves the system; $(1,2)$ does not.
]

#ex(difficulty: 2, time: "30 min", keep-together: true)[
  Use any method to solve the following systems of linear equations.
  #parts(
    2,
    [(a) $#system(($13x + 2y$, $6$), ($23x + 3y$, $6$))$],
    [(b) $#system(($4x + 7y$, $3$), ($-8x - 14y$, $-6$))$],
    [(c) $#system(($-x - y$, $2$), ($x + y$, $-3$))$],
    [(d) $#system(($5x - 2y$, $34$), ($3x + 8y$, $48$))$],
    [(e) $#system(($2x - y/2$, $22$), ($x/3 + 3y$, $21$))$],
    [(f) $#system(($2x + 15y$, $-97$), ($6x - 25y$, $199$))$],
    [(g) $#system(($(1-3x)/10 - (y-4x)/3$, $1/2$), ($(3+x)/20 - 3/4$, $(8-2y)/4$))$],
    [(h) $#system(($(2x-y+3)/(2+x-2y)$, $1$), ($x : y$, $3 : 4$))$],
  )
][
  #parts(
    2,
    [(a) $x = -6/7$, $y = 60/7$],
    [(b) infinitely many solutions: $x in RR$, $y = -4/7 x + 3/7$],
    [(c) no solution],
    [(d) $x = 8$, $y = 3$],
    [(e) $x = 459/37$, $y = 208/37$],
    [(f) $x = 4$, $y = -7$],
    [(g) $x = 2$, $y = 5$],
    [(h) $x = -3/7$, $y = -4/7$],
  )
]

#ex(difficulty: 3, time: "15 min")[
  + For which value of $m$ does the system have no solutions?
    $ #system(($2x - 5y$, $10$), ($y$, $m dot x + 3$)) $
  + For which values of $m$ and $b$ does the system have infinitely
    many solutions?
    $ #system(($4x - 2y$, $6$), ($y$, $m dot x + b$)) $
][
  + $m = 2/5 = 0.4$ -- this makes the two lines parallel (same slope,
    different $y$-intercept).
  + $m = 2$, $b = -3$ -- this makes the second equation describe
    exactly the same line as the first.
]

== Word Problems

#ex(difficulty: 2, time: "15 min")[
  A small company makes and sells handmade candles. Each candle costs
  CHF 4.50 to produce (materials and labor), and the workshop rental
  costs a fixed CHF 320 per month regardless of how many candles are
  made. Each candle sells for CHF 9.50.
  + Write a cost function $C(n)$ and a revenue function $R(n)$ for $n$
    candles sold in a month.
  + Find the *break-even point* -- the number of candles at which cost
    equals revenue -- and the revenue at that point.
][
  + $C(n) = 4.5n + 320$ and $R(n) = 9.5n$.
  + Setting $C(n) = R(n)$: $4.5n + 320 = 9.5n => 320 = 5n => n = 64$.
    At $n = 64$, revenue is $R(64) = 608$ CHF (and cost is the same:
    $C(64) = 288 + 320 = 608$ CHF). Below 64 candles the company runs
    at a loss; above 64, a profit.
]

#ex(difficulty: 2, time: "10 min")[
  Two times the first number minus $1$ produces the second number. When
  you subtract the second number from the first, you get $-1$. Set up a
  system and calculate the two numbers.
][
  $2x - 1 = y$ and $x - y = -1$, giving $x = 2$ and $y = 3$.
]

#ex(difficulty: 2, time: "15 min")[
  A landscaping company placed two orders with a nursery. The first
  order was for 13 bushes and 4 trees, totalling \$487. The second order
  was for 6 bushes and 2 trees, totalling \$232. What were the costs of
  one bush and one tree?
][
  A bush costs \$23 and a tree costs \$47.
]

#ex(difficulty: 2, time: "15 min")[
  The admission fee at a small fair is \$1.50 for children and \$4.00
  for adults. On a certain day, 2200 people entered and \$5050 was
  collected. How many children and how many adults attended?
][
  1500 children and 700 adults.
]

#ex(difficulty: 2, time: "15 min")[
  Calvin has \$8.80 in pennies and nickels. If there are twice as many
  nickels as pennies, how many pennies does Calvin have? How many
  nickels?
][
  80 pennies and 160 nickels.
]

#ex(difficulty: 1, time: "10 min")[
  The sum of two numbers is 90. The larger number is 14 more than 3
  times the smaller number. Find the numbers.
][
  71 and 19.
]

#ex(difficulty: 3, time: "15 min")[
  Bonzo invests some money at 2% interest. He also invests \$1700 more
  than twice that amount at 4% interest. At the end of one interest
  period, the total interest earned was \$278. How much was invested at
  each rate?
][
  \$2100 at 2%, \$5900 at 4%.
]

#ex(difficulty: 2, time: "15 min")[
  Calvin mixes candy that sells for \$2.00 per pound with candy that
  costs \$3.60 per pound to make 50 pounds of candy selling for \$2.16
  per pound. How many pounds of each kind did he use?
][
  45 pounds of the \$2.00 candy and 5 pounds of the \$3.60 candy.
]

#ex(difficulty: 2, time: "15 min")[
  How many gallons of a 60% acid solution and an 80% acid solution must
  be mixed to produce 50 gallons of a 74% acid solution?
][
  15 gallons of the 60% solution and 35 gallons of the 80% solution.
]

#ex(difficulty: 3, time: "20 min")[
  A light aircraft needs 50 minutes for a distance of 180 km with a
  headwind, and 45 minutes for the flight back with a tailwind. What are
  the aircraft's own speed and the wind speed?
][
  Aircraft speed: 228 km/h. Wind speed: 12 km/h.
]

#ex(difficulty: 1, time: "10 min")[
  Two angles are complementary, and the larger one is $14°$ more than 3
  times the smaller one. Find the angles.
][
  $71°$ and $19°$.
]

#ex(difficulty: 2, time: "10 min")[
  How much 10% acid solution should be mixed with a 25% acid solution to
  produce 3 liters of a solution that is 15% acid?
][
  2 liters of the 10% solution and 1 liter of the 25% solution.
]

#ex(difficulty: 3, time: "25 min", keep-together: true)[
  Four straight lines have the following equations:
  $
    #system(($4x + 8y$, $59$), ($x - 2y$, $1$), ($y - 4x$, $3$), ($3y + 2x$, $-19$))
  $
  + How many points of intersection do you expect there to be?
  + Three of the four lines enclose a triangle which has only negative
    coordinates for all its points. Which three lines?
][
  + All four lines have different slopes, so no two are parallel:
    every pair meets at a distinct point, giving $binom(4, 2) = 6$
    points of intersection.
  + The lines $x - 2y = 1$, $y - 4x = 3$, and $3y + 2x = -19$ meet
    pairwise at $(-1,-1)$, $(-5,-3)$, and $(-2,-5)$ -- all in the third
    quadrant.
]

== Extra Bits

#ex(difficulty: 3, time: "20 min")[
  A shop sells its own blend of coffee, using Mocha (£13/kg), Kenyan
  (£14/kg), and Brazilian (£17/kg) beans. 11 kg of this blend costs
  £15/kg on average. The blend uses more Brazilian than Kenyan coffee,
  and an exact whole number of kilograms of each type is used. How many
  kilograms of each type are used?
][
  4 kg Mocha, 2 kg Kenyan, 5 kg Brazilian. (This is the *only* whole-kg
  combination of the three types that adds to 11 kg, averages £15/kg,
  and uses more Brazilian than Kenyan -- worth checking by trying every
  other split once you have the two equations set up.)
]

#ex(difficulty: 3, time: "20 min")[
  There are four children in a family: two girls, Kate and Sally, and
  two boys, Tom and Ben.
  - Tom is 2 years older than Ben.
  - The combined ages of the two boys equal the combined ages of the two
    girls.
  - Kate is twice as old as Sally.
  - A year ago, Tom was twice as old as Sally was then.
  How old are the children?
][
  Ben is 5, Tom is 7, Sally is 4, Kate is 8.
]

#exploration(title: "Add Them All Up")[
  Below is a system of five equations in five unknowns.
  $
    #system(($b + c + d + e$, $4$), ($a + c + d + e$, $5$), ($a + b + d + e$, $1$), ($a + b + c + e$, $2$), ($a + b + c + d$, $0$))
  $
  Add up all five equations. What do you notice? Use this to solve the
  system and find $a$, $b$, $c$, $d$, and $e$ -- without eliminating
  variables one at a time the usual way.
]

== Extra Bits -- Higher-Order Systems

#ex(difficulty: 3, time: "30 min", keep-together: true)[
  Solve the systems of equations.
  #parts(
    2,
    [(a) $#system(($x+y+z$, $33$), ($3x-8y+7z$, $26$), ($5y-3z$, $19$))$],
    [(b) $#system(($x+y+z$, $60$), ($x-3y+2z$, $-4$), ($2x+5y-5z$, $68$))$],
    [(c) $#system(($1/4 x + 3/4 y - z$, $1/8$), ($x - 3/2 y + 4/3 z$, $1/3$), ($1/3 x + 1/2 y - 2/3 z$, $1/6$))$],
    [(d) $#system(($4x+7y$, $10$), ($3x+8z$, $13$), ($3y+5z$, $16$))$],
  )
][
  #parts(
    2,
    [(a) $x=10$, $y=11$, $z=12$],
    [(b) $x=24$, $y=20$, $z=16$],
    [(c) $x=1/2$, $y=1/3$, $z=1/4$],
    [(d) $x=-1$, $y=2$, $z=2$],
  )
]

#print-hints()
