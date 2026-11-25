// ch-fractions.typ — Fractions: a self-paced refresher (GLF only)
//
// Built from scratch (no LaTeX source). Standalone remediation unit;
// see main-basic.typ for why there is no Advanced version.
//
// ── SELF-PACED DESIGN ────────────────────────────────────────
// The notes PDF (main-basic) is the student's working booklet.
// Eight stages, from "what is 3/4" up to algebraic double fractions,
// then a Final check and a Challenges section. Every stage:
//
//   1. opens with a CHECKPOINT (test-out). All correct -> skip to the
//      next stage's checkpoint. Any mistake -> work through the stage.
//   2. ends with a STAGE CHECK (fresh items, exit test). All correct ->
//      continue. Any mistake -> look back, then ask the teacher.
//
// The Final check routes PER ITEM back to the stage behind each
// mistake, so it doubles as an optional fast-lane entry test.
// Students mark checks themselves against the answer key printed at
// the end of the chapter; worked solutions are in the solutions
// booklet as usual.
//
// Routing refers to sections by LABEL (<st-a> ... <st-chal>), and the
// section number and page are computed, so reordering or inserting
// material never breaks a "go to" instruction.
//
// TARGET MISCONCEPTIONS
//   M1  fraction bar not read as grouping: (2+6)/2 -> 1+6       [§E]
//   M2  cancelling terms instead of factors                    [§F]
//   M3  adding numerators and denominators: a/b+c/d -> (a+c)/(b+d)
//                                                             [§C, §G]
//   M4  rule transfer between operations                       [§E, §H]
//
// STATUS
//   done:  infrastructure, all checkpoints + Final check (with key),
//          §A–§H complete; six challenges.
//   to do: visual check of the compiled booklet (see below).
//
// All numerical answers verified with SymPy before writing.
//
// NEEDS A VISUAL CHECK — not compiled (no Typst in the drafting
// environment): number-line tick labels, cancel() strokes, the route
// boxes, the stage table, and the answer key layout.
//
// Self-paced helpers (goto, route, check, print-check-key,
// progress-table, todo) live in preamble.typ, SELF-PACED section.

#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Fractions")
#let ex = exercise.with(chapter: "Fractions")

#let check = check.with(ex: ex)

= Fractions

#only-theory[
  You have worked with fractions for years, and most of the rules on
  these pages will look familiar. Even so, fraction mistakes are among
  the most common errors in Gymnasium exams, and strong students make
  them too. The cause is almost never carelessness. Usually it is a rule
  that was memorized without its reason and then applied one step too
  far.

  So this booklet is less about rules than about the _reasons_ for
  them. Once you know why a step works, you can decide for yourself
  whether it is allowed.
]

#objectives(
  [place fractions on the number line and estimate the size of a result
    before computing it],
  [simplify and expand fractions, and tell a term from a factor],
  [add, subtract, multiply, and divide fractions, and choose the right
    rule for each situation],
  [do all of this with algebraic fractions, up to double fractions],
  [check an algebraic simplification by substituting a number],
)

#keybox(title: "How to work through this booklet")[
  You work at your own pace, and you skip what you already know.
  + Each section starts with a short *checkpoint*. Do it without help,
    then mark it yourself with the answers on the last pages.
  + All correct, with your working written down? *Skip* to the next
    checkpoint. Any mistake? Work through the section. It ends with a
    *stage check* that tells you whether you are ready to move on.
  + Tick off each section in the table below as you go.

  Already confident with algebraic fractions? You may start with the
  #goto(<st-final>) instead. It sends you back to exactly the sections
  you need.
]

#progress-table(
  (<st-a>, [What a fraction is]),
  (<st-b>, [Equivalent fractions and simplifying]),
  (<st-c>, [Adding and subtracting]),
  (<st-d>, [Multiplying and dividing]),
  (<st-e>, [Which rule?]),
  (<st-f>, [Letters I: simplifying]),
  (<st-g>, [Letters II: adding and subtracting]),
  (<st-h>, [Letters III: multiplying, dividing, double fractions]),
  (<st-final>, [Final check]),
  (<st-chal>, [Challenges]),
)

// ════════════════════════════════════════════════════════════
== What a Fraction Is <st-a>

#check(
  "What a fraction is",
  (
    [Write $0.75$ as a fraction.],
    [Write $3/8$ as a decimal.],
    [Which is larger: $5/9$ or $1/2$?],
    [Write $7/4$ as a whole number plus a fraction.],
  ),
  ([$3/4$], [$0.375$], [$5/9$], [$1 + 3/4$]),
  pass: [Skip to the checkpoint in #goto(<st-b>).],
  fail: [Work through this section.],
)

#exploration(title: "Size it up")[
  Answer these *without* computing anything exactly: no common
  denominators and no calculator.

  + Is $3/7$ more or less than $1/2$? How can you tell at a glance?
  + Which is larger, $5/8$ or $4/7$? (Think about how far each one is
    from $1$.)
  + Is $7/8 + 1/9$ more or less than $1$?
  + Lena writes $1/2 + 1/3 = 2/5$. Without finding the correct answer,
    explain why her answer _cannot_ be right.
]

#only-theory[
  Every question in the exploration can be answered with a sense of
  _size_, and only because a fraction is a single number with a place
  on the number line. It is not two separate whole numbers stacked on
  top of each other. Keep this in mind on every page that follows.
]

#definition(title: "Fraction")[
  For whole numbers $a$ and $b$ with $b != 0$, the #vocab("fraction",
  "Bruch") $a/b$ is the number $a : b$.

  The #vocab("denominator", "Nenner") $b$ says into how many equal
  parts the unit is cut. The #vocab("numerator", "Zähler") $a$ says how
  many of those parts are taken.
]

#only-theory[
  For example, $3/4$ means: cut the unit into four equal parts and take
  three of them. Since $3/4 = 3 : 4 = 0.75$, that is the single point
  $0.75$ on the number line.

  #number-line(
    from: 0,
    to: 1,
    ticks: (
      (0, [$0$]),
      (0.25, [$1/4$]),
      (0.5, [$1/2$]),
      (0.75, [$3/4$]),
      (1, [$1$]),
    ),
    nl-point(0.75, label: [$3/4 = 0.75$]),
  )

  Nothing stops the numerator from being larger than the denominator:
  $7/4$ means seven quarters, which is one whole and three quarters
  more,
  $ 7/4 = 4/4 + 3/4 = 1 + 3/4 = 1.75. $
]

#remark[
  In primary school you may have written $1 + 3/4$ as $1 #h(0.1em) 3/4$
  ("one and three quarters"). Avoid this from now on. In algebra,
  writing two things next to each other means _multiplying_ them, so
  $1 #h(0.1em) 3/4$ would read as $1 dot 3/4$. Write $7/4$ or $1 + 3/4$.
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Convert without a calculator.
  #auto-parts(
    4,
    [$1/4$ to a decimal],
    [$2/5$ to a decimal],
    [$7/8$ to a decimal],
    [$1/3$ to a decimal],
    [$0.6$ to a fraction],
    [$0.125$ to a fraction],
    [$1.5$ to a fraction],
    [$0.05$ to a fraction],
  )
][
  #auto-parts(
    4,
    [$0.25$],
    [$0.4$],
    [$0.875$],
    [$0.333...$ (the $3$ repeats forever)],
    [$6/10 = 3/5$],
    [$125/1000 = 1/8$],
    [$15/10 = 3/2$],
    [$5/100 = 1/20$],
  )
]

#ex(difficulty: 1, time: "5 min", calculator: false)[
  Write the first four as a whole number plus a fraction smaller than
  $1$, and the last two as a single fraction.
  #auto-parts(
    3,
    [$11/4$],
    [$7/3$],
    [$9/2$],
    [$13/5$],
    [$3 + 2/5$],
    [$1 + 5/6$],
  )
][
  #auto-parts(
    3,
    [$2 + 3/4$],
    [$2 + 1/3$],
    [$4 + 1/2$],
    [$2 + 3/5$],
    [$15/5 + 2/5 = 17/5$],
    [$6/6 + 5/6 = 11/6$],
  )
]

#ex(difficulty: 1, time: "5 min", calculator: false)[
  Which of the two numbers is larger? Decide _without_ computing either
  one exactly, and give a one-line reason.
  #auto-parts(
    2,
    [$5/9$ #h(0.5em) or #h(0.5em) $1/2$],
    [$7/10$ #h(0.5em) or #h(0.5em) $6/9$],
    [$1/3 + 2/7$ #h(0.5em) or #h(0.5em) $1$],
    [$9/10 + 2/11$ #h(0.5em) or #h(0.5em) $1$],
  )
][
  #auto-parts(
    2,
    [$5/9 > 1/2$, because half of $9$ is $4.5$ and $5 > 4.5$.],
    [$7/10 > 6/9$. Both are $3$ parts away from $1$, but tenths are
      smaller than ninths, so $7/10$ is closer to $1$.],
    [$1/3 + 2/7 < 1$. Both terms are less than $1/2$, so their sum is
      less than $1/2 + 1/2 = 1$. (Exactly: $13/21$.)],
    [$9/10 + 2/11 > 1$. $9/10$ is only $1/10$ away from $1$, and
      $2/11 > 1/10$. (Exactly: $119/110$.)],
  )
]

#ex(
  difficulty: 2,
  time: "8 min",
  calculator: false,
  hints: (
    [With $1$ unit $= 6$ cm, how long is $1/6$ of a unit? And $1/3$?],
  ),
)[
  Draw a number line from $0$ to $2$ with $1$ unit $= 6$ cm. Mark
  $1/2$, $2/3$, $5/6$, $7/6$, and $3/2$ on it. Why is $6$ cm a clever
  choice for the unit?
][
  $1/6$ of a unit is $1$ cm, so the points lie at $3$ cm, $4$ cm,
  $5$ cm, $7$ cm, and $9$ cm from $0$. The unit $6$ cm works because
  halves, thirds, and sixths of it are all whole centimeters: $6$ is a
  common multiple of all the denominators.
]

#check(
  kind: "Stage check",
  "What a fraction is",
  (
    [Write $0.4$ as a fraction.],
    [Write $5/4$ as a decimal.],
    [Which is larger: $4/9$ or $1/2$?],
    [Write $13/5$ as a whole number plus a fraction.],
  ),
  ([$2/5$], [$1.25$], [$1/2$], [$2 + 3/5$]),
  pass: [Continue with #goto(<st-b>).],
  fail: [Find the exercise in this section that matches your mistake
    and redo it. If the check still goes wrong, ask your teacher before
    moving on.],
)

// ════════════════════════════════════════════════════════════
== Equivalent Fractions and Simplifying <st-b>

#check(
  "Equivalent fractions",
  (
    [Fill in the gap: $2/3 = #h(1.2em) /15$],
    [Simplify $18/24$.],
    [Simplify $84/126$.],
    [Simplify before multiplying: $(4 dot 15)/(6 dot 25)$],
  ),
  ([$10/15$], [$3/4$], [$2/3$], [$2/5$]),
  pass: [Skip to the checkpoint in #goto(<st-c>).],
  fail: [Work through this section.],
)

#only-theory[
  The fractions $3/4$ and $6/8$ look different, but they sit on the
  same point of the number line. Cutting each quarter in half doubles
  both the number of parts and the number of parts taken, and the
  amount stays the same.

  #number-line(
    from: 0,
    to: 1,
    ticks: (
      (0, [$0$]),
      (0.25, [$1/4$]),
      (0.5, [$2/4$]),
      (0.75, [$3/4$]),
      (1, [$1$]),
    ),
    nl-point(0.75, label: [$3/4$]),
  )
  #number-line(
    from: 0,
    to: 1,
    ticks: (
      (0, [$0$]),
      (0.125, none),
      (0.25, [$2/8$]),
      (0.375, none),
      (0.5, [$4/8$]),
      (0.625, none),
      (0.75, [$6/8$]),
      (0.875, none),
      (1, [$1$]),
    ),
    nl-point(0.75, label: [$6/8$]),
  )

  In symbols, multiplying the numerator and the denominator by the same
  number $k$ is the same as multiplying by $k/k = 1$, and multiplying
  by $1$ never changes a number.
]

#theorem(title: "Equivalent fractions")[
  For $b != 0$ and $k != 0$:
  $ a/b = (a dot k)/(b dot k) $
  Read from left to right, this is #vocab("expanding", "Erweitern").
  Read from right to left, it is #vocab("simplifying", "Kürzen"):
  dividing the numerator and the denominator by the same
  #vocab("common factor", "gemeinsamer Faktor") $k$.
]

#example(title: "Simplifying in small steps")[
  You do not need to find the largest common factor at once. Divide by
  whatever you can see, and repeat:
  $ 84/126 = 42/63 = 14/21 = 2/3 $
  (dividing by $2$, then by $3$, then by $7$). The divisibility rules
  help: a number is divisible by $2$ if its last digit is even, by $3$
  if its digit sum is divisible by $3$, and by $5$ if it ends in $0$ or
  $5$.
]

#example(title: "Simplify before you multiply")[
  When the numerator and the denominator are products, cancel _before_
  multiplying out. The numbers stay small:
  $ (4 dot 15)/(6 dot 25)
    = (cancel(2) dot 2 dot cancel(5) dot 3)/(cancel(2) dot 3 dot cancel(5) dot 5)
    = (2 dot cancel(3))/(cancel(3) dot 5)
    = 2/5 $
  Multiplying out first gives $60/150$, which you then have to simplify
  anyway.
]

#ex(difficulty: 1, time: "5 min", calculator: false)[
  Fill in the gap.
  #auto-parts(
    3,
    [$3/4 = #h(1.2em) /20$],
    [$5/6 = #h(1.2em) /42$],
    [$2/7 = 10/ #h(1.2em)$],
  )
][
  #auto-parts(
    3,
    [$15/20$],
    [$35/42$],
    [$10/35$],
  )
]

#ex(difficulty: 1, time: "6 min", calculator: false)[
  Simplify as far as possible.
  #auto-parts(
    4,
    [$18/24$],
    [$45/60$],
    [$84/126$],
    [$135/225$],
  )
][
  #auto-parts(
    4,
    [$3/4$],
    [$3/4$],
    [$2/3$],
    [$3/5$],
  )
]

#ex(difficulty: 2, time: "6 min", calculator: false)[
  Simplify _before_ multiplying out.
  #auto-parts(
    3,
    [$(8 dot 9)/(12 dot 10)$],
    [$(21 dot 10)/(15 dot 14)$],
    [$(12 dot 25)/(35 dot 18)$],
  )
][
  #auto-parts(
    3,
    [$3/5$],
    [$1$],
    [$10/21$],
  )
]

#ex(difficulty: 2, time: "5 min", calculator: false)[
  Which of these fractions are equal to $2/3$? Justify each answer.
  #auto-parts(
    3,
    [$4/6$],
    [$10/15$],
    [$(2 + 2)/(3 + 2)$],
    [$20/30$],
    [$6/8$],
    [$12/18$],
  )
][
  #auto-parts(
    3,
    [Yes: $(2 dot 2)/(3 dot 2)$.],
    [Yes: $(2 dot 5)/(3 dot 5)$.],
    [No: $4/5$. Adding the same number to the numerator and the
      denominator is _not_ expanding.],
    [Yes: $(2 dot 10)/(3 dot 10)$.],
    [No: $6/8 = 3/4$.],
    [Yes: $(2 dot 6)/(3 dot 6)$.],
  )
]

#check(
  kind: "Stage check",
  "Equivalent fractions",
  (
    [Fill in the gap: $5/8 = #h(1.2em) /56$],
    [Simplify $36/48$.],
    [Simplify $90/150$.],
    [Simplify before multiplying: $(9 dot 14)/(21 dot 6)$],
  ),
  ([$35/56$], [$3/4$], [$3/5$], [$1$]),
  pass: [Continue with #goto(<st-c>).],
  fail: [Find the example or exercise that matches your mistake and
    redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════════
== Adding and Subtracting <st-c>

#check(
  "Adding and subtracting",
  (
    [$3/8 + 2/8$],
    [$1/2 + 1/3$],
    [$5/6 - 3/4$],
    [$2 - 3/5$],
    [$7/12 + 5/18$],
  ),
  ([$5/8$], [$5/6$], [$1/12$], [$7/5$], [$31/36$]),
  cols: 3,
  pass: [Skip to the checkpoint in #goto(<st-d>).],
  fail: [Work through this section.],
)

#only-theory[
  Adding fractions is like adding anything else that comes in units.
  Three apples plus two apples are five apples. In the same way,
  three eighths plus two eighths are five eighths. The denominator
  names the unit (eighths), so it stays the same; only the number of
  units changes.
]

#keybox(title: "Same denominator")[
  $ a/c + b/c = (a + b)/c quad "and" quad a/c - b/c = (a - b)/c $
  Add or subtract the numerators. Keep the denominator.
]

#only-theory[
  Halves and thirds are different units, so $1/2 + 1/3$ cannot be
  added directly, just as you cannot add 1 meter and 1 foot without
  converting first. The way out is to rename both fractions with a
  unit that fits both. Halves and thirds can both be written in
  sixths:

  #number-line(
    from: 0,
    to: 1,
    ticks: (
      (0, [$0$]),
      (1 / 6, [$1/6$]),
      (2 / 6, [$2/6$]),
      (3 / 6, [$3/6$]),
      (4 / 6, [$4/6$]),
      (5 / 6, [$5/6$]),
      (1, [$1$]),
    ),
    nl-point(1 / 3, label: [$1/3$]),
    nl-point(1 / 2, label: [$1/2$]),
  )

  So $1/3 = 2/6$ and $1/2 = 3/6$, and now the units match:
  $ 1/2 + 1/3 = 3/6 + 2/6 = 5/6. $
]

#keybox(title: "Different denominators")[
  + Find a #vocab("common denominator", "gemeinsamer Nenner"): a
    number that both denominators divide.
  + Expand each fraction to that denominator.
  + Add or subtract the numerators, then simplify if possible.
]

#example(title: "Product or least common denominator")[
  The product of the denominators is _always_ a common denominator:
  $ 7/12 + 5/18 = (7 dot 18)/(12 dot 18) + (5 dot 12)/(18 dot 12)
    = 126/216 + 60/216 = 186/216 = 31/36. $
  This works, but the numbers get big and you must simplify at the
  end. The #vocab("least common denominator", "Hauptnenner") is the
  smallest number that both denominators divide. To find it, go
  through the multiples of the larger denominator until the smaller
  one divides it: $18$ (no), $36$ (yes). Then
  $ 7/12 + 5/18 = 21/36 + 10/36 = 31/36. $
  Both ways give the same answer. Use whichever you find safer.
]

#example(title: "Whole numbers")[
  A whole number is a fraction with any denominator you like:
  $2 = 2/1 = 10/5$. So
  $ 2 - 3/5 = 10/5 - 3/5 = 7/5. $
]

#example(title: "Why you cannot add tops and bottoms")[
  It is tempting to write $1/2 + 1/3 = 2/5$. Test the idea on a sum
  you already know:
  $ 1/2 + 1/2 = 1, quad "but the rule would give" quad (1 + 1)/(2 + 2) = 2/4 = 1/2. $
  Adding two halves cannot give one half. The size check from the
  exploration in #goto(<st-a>) catches it too: $2/5$ is smaller than
  $1/2$, so it cannot be $1/2$ _plus_ something.

  (There _is_ one situation where adding tops and bottoms gives the
  right answer. It is not adding fractions, and you will meet it in the
  Challenges.)
]

#ex(difficulty: 1, time: "5 min", calculator: false)[
  Compute and simplify the result.
  #auto-parts(
    3,
    [$3/8 + 2/8$],
    [$5/9 - 2/9$],
    [$7/10 + 9/10$],
    [$11/12 - 5/12$],
    [$4/7 + 5/7 - 2/7$],
  )
][
  #auto-parts(
    3,
    [$5/8$],
    [$3/9 = 1/3$],
    [$16/10 = 8/5$],
    [$6/12 = 1/2$],
    [$7/7 = 1$],
  )
]

#ex(difficulty: 1, time: "6 min", calculator: false)[
  One denominator is a multiple of the other, so it is already a common
  denominator. Compute and simplify.
  #auto-parts(
    3,
    [$1/2 + 1/4$],
    [$2/3 + 1/6$],
    [$3/4 - 3/8$],
    [$5/6 - 1/2$],
    [$1/5 + 3/10$],
  )
][
  #auto-parts(
    3,
    [$2/4 + 1/4 = 3/4$],
    [$4/6 + 1/6 = 5/6$],
    [$6/8 - 3/8 = 3/8$],
    [$5/6 - 3/6 = 2/6 = 1/3$],
    [$2/10 + 3/10 = 5/10 = 1/2$],
  )
]

#ex(
  difficulty: 2,
  time: "12 min",
  calculator: false,
  hints: (
    [Go through the multiples of the larger denominator until the
      smaller one divides it. For (e): $12$, $24$.],
  ),
)[
  Compute and simplify.
  #auto-parts(
    3,
    [$1/3 + 1/4$],
    [$2/5 + 1/3$],
    [$3/4 - 2/3$],
    [$5/6 + 4/9$],
    [$7/12 - 3/8$],
    [$1/4 - 2/3$],
  )
][
  #auto-parts(
    3,
    [$4/12 + 3/12 = 7/12$],
    [$6/15 + 5/15 = 11/15$],
    [$9/12 - 8/12 = 1/12$],
    [$15/18 + 8/18 = 23/18$],
    [$14/24 - 9/24 = 5/24$],
    [$3/12 - 8/12 = -5/12$],
  )
]

#ex(difficulty: 1, time: "6 min", calculator: false)[
  Compute and simplify.
  #auto-parts(
    3,
    [$1 - 3/8$],
    [$2 + 2/3$],
    [$3 - 5/4$],
    [$1/2 + 1/3 + 1/6$],
    [$1 - 1/2 - 1/3$],
  )
][
  #auto-parts(
    3,
    [$8/8 - 3/8 = 5/8$],
    [$6/3 + 2/3 = 8/3$],
    [$12/4 - 5/4 = 7/4$],
    [$3/6 + 2/6 + 1/6 = 1$],
    [$6/6 - 3/6 - 2/6 = 1/6$],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Three students computed a sum or difference. For each one, decide
  whether the work is correct. If it is wrong, name the mistake and give
  the correct result.
  #auto-parts(
    1,
    [Marco: $2/3 + 1/4 = 3/7$],
    [Sara: $1/2 + 1/6 = 3/6 + 1/6 = 4/6 = 2/3$],
    [Tim: $3/4 - 1/6 = 9/12 - 1/12 = 8/12 = 2/3$],
  )
][
  #auto-parts(
    1,
    [Wrong. Marco added the numerators and the denominators. Correct:
      $8/12 + 3/12 = 11/12$. Size check: $3/7 < 2/3$, so it cannot be
      $2/3$ _plus_ something.],
    [Correct.],
    [Wrong. Tim changed the denominator of $1/6$ to $12$ but did not
      expand the numerator: $1/6 = 2/12$, not $1/12$. Correct:
      $9/12 - 2/12 = 7/12$.],
  )
]

#ex(difficulty: 2, time: "6 min", calculator: false)[
  Lea spends $1/3$ of her pocket money on books and $1/4$ of it on
  snacks. What fraction of her pocket money is left? Before computing,
  estimate: is it more or less than half?
][
  Estimate: $1/3 + 1/4$ is more than $1/4 + 1/4 = 1/2$, so _less_ than
  half is left. Exactly:
  $ 1 - 1/3 - 1/4 = 12/12 - 4/12 - 3/12 = 5/12. $
]

#ex(
  difficulty: 3,
  time: "10 min",
  calculator: false,
  hints: (
    [For each sum, how far is each fraction from $1/2$, from $1/4$, or
      from $1$? Or: how much is missing to reach $1$?],
  ),
)[
  + _Without_ computing exactly, decide which of these sums is closest
    to $1$:
    $ 1/2 + 1/3, quad 2/3 + 1/4, quad 3/4 + 1/5 $
  + Check your answer by computing each sum exactly.
  + Continue the pattern with two more sums. What do you notice?
][
  + All three are below $1$. What is missing to reach $1$ is
    $1/2 - 1/3$, $1/3 - 1/4$, and $1/4 - 1/5$ respectively, and these
    gaps get smaller. So $3/4 + 1/5$ is closest.
  + $5/6$, $11/12$, and $19/20$. The gaps to $1$ are $1/6$, $1/12$,
    and $1/20$.
  + $4/5 + 1/6 = 29/30$ and $5/6 + 1/7 = 41/42$. The sums creep closer
    to $1$. The gaps are $1/30$ and $1/42$: for the sum
    $(n - 1)/n + 1/(n + 1)$ the gap is
    $1/n - 1/(n + 1) = 1/(n dot (n + 1))$.
]

#check(
  kind: "Stage check",
  "Adding and subtracting",
  (
    [$4/9 + 2/9$],
    [$1/4 + 1/6$],
    [$7/10 - 2/5$],
    [$3 - 5/6$],
    [$5/8 + 1/12$],
  ),
  ([$2/3$], [$5/12$], [$3/10$], [$13/6$], [$17/24$]),
  cols: 3,
  pass: [Continue with #goto(<st-d>).],
  fail: [Find the example or exercise that matches your mistake and
    redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════════
== Multiplying and Dividing <st-d>

#check(
  "Multiplying and dividing",
  (
    [$2/3 dot 9/10$],
    [$3/4$ of $20$],
    [$5/6 : 10/9$],
    [$(3/4)/(9/8)$],
    [$4 : 2/3$],
  ),
  ([$3/5$], [$15$], [$3/4$], [$2/3$], [$6$]),
  cols: 3,
  pass: [Skip to the checkpoint in #goto(<st-e>).],
  fail: [Work through this section.],
)

#only-theory[
  In everyday language, "half _of_ 6" is $3$, and that is the same as
  $1/2 dot 6$. The word _of_ is the key to multiplying fractions:
  $2/3 dot 3/4$ means "two thirds _of_ three quarters".

  The picture shows a unit square. Its first three columns make up
  $3/4$ of it. Take the top two thirds of that part: the shaded region
  is $2/3$ _of_ $3/4$, and it consists of $6$ of the $12$ equal pieces:

  #area-model(
    cols: (
      ([$1/4$], 3),
      ([$1/4$], 3),
      ([$1/4$], 3),
      ([$1/4$], 3),
    ),
    rows: (([$1/3$], 4), ([$1/3$], 4), ([$1/3$], 4)),
    unit: 0.4cm,
    fill-color: white,
    area-cell(fill: accent-bg),
    area-cell(fill: accent-bg),
    area-cell(fill: accent-bg),
    none,
    area-cell(fill: accent-bg),
    area-cell(fill: accent-bg),
    area-cell(fill: accent-bg),
    none,
    none,
    none,
    none,
    none,
  )

  $ 2/3 dot 3/4 = (2 dot 3)/(3 dot 4) = 6/12 = 1/2 $
  The denominators multiply because the square is cut into
  $3 dot 4 = 12$ pieces. The numerators multiply because $2 dot 3 = 6$
  of them are shaded.
]

#keybox(title: "Multiplying")[
  $ a/b dot c/d = (a dot c)/(b dot d) $
  Multiply straight across: numerator times numerator, denominator
  times denominator. *No common denominator is needed.* Cancel common
  factors _before_ multiplying out, as in #goto(<st-b>).
]

#example(title: "Whole numbers and amounts")[
  A whole number is a fraction with denominator $1$:
  $ 3 dot 2/5 = 3/1 dot 2/5 = 6/5. $
  Only the numerator is multiplied by $3$. (Multiplying the denominator
  as well would be expanding, and the value would not change at all.)

  "$3/4$ of $20$" is $3/4 dot 20 = 60/4 = 15$. In your head: a quarter
  of $20$ is $5$, so three quarters are $15$.
]

#definition(title: "Reciprocal")[
  The #vocab("reciprocal", "Kehrwert") of $a/b$ is $b/a$: the fraction
  turned upside down. A number times its reciprocal is always $1$:
  $ a/b dot b/a = (a dot b)/(b dot a) = 1. $
  The reciprocal of $5 = 5/1$ is $1/5$. The number $0$ has no
  reciprocal.
]

#only-theory[
  Dividing asks _how many times_ one number fits into another. How many
  times does $2/3$ fit into $4$? On the number line, take jumps of
  length $2/3$ starting at $0$. The numbers above count the jumps:

  #number-line(
    from: 0,
    to: 4,
    ticks: (
      (0, [$0$]),
      (1 / 3, none),
      (2 / 3, none),
      (1, [$1$]),
      (4 / 3, none),
      (5 / 3, none),
      (2, [$2$]),
      (7 / 3, none),
      (8 / 3, none),
      (3, [$3$]),
      (10 / 3, none),
      (11 / 3, none),
      (4, [$4$]),
    ),
    nl-point(2 / 3, label: [$1$]),
    nl-point(4 / 3, label: [$2$]),
    nl-point(2, label: [$3$]),
    nl-point(8 / 3, label: [$4$]),
    nl-point(10 / 3, label: [$5$]),
    nl-point(4, label: [$6$]),
  )

  So $4 : 2/3 = 6$. Why does the same answer come out of
  $4 dot 3/2 = 12/2 = 6$? Think in two steps. A third fits into $4$
  exactly $4 dot 3 = 12$ times. Two thirds are twice as long, so they
  fit half as often: $12 : 2 = 6$. Multiplying by $3$ and dividing by
  $2$ is exactly multiplying by $3/2$, the reciprocal of $2/3$.
]

#keybox(title: "Dividing")[
  $ a/b : c/d = a/b dot d/c $
  Dividing by a fraction is multiplying by its reciprocal. Only the
  _second_ fraction (the one you divide by) is turned upside down.
]

#example(title: "Double fractions")[
  A fraction whose numerator or denominator is itself a fraction is a
  #vocab("double fraction", "Doppelbruch"). The main fraction bar is
  still just a division sign:
  $ (3/4)/(9/8) = 3/4 : 9/8 = 3/4 dot 8/9 = (3 dot 8)/(4 dot 9) = 2/3. $
  When you write one by hand, make the main bar clearly longer than the
  others, so that everyone can see which division comes first.
]

#ex(difficulty: 1, time: "6 min", calculator: false)[
  Compute and simplify. Cancel before multiplying where you can.
  #auto-parts(
    3,
    [$2/3 dot 4/5$],
    [$3/4 dot 1/2$],
    [$5/6 dot 3/10$],
    [$4 dot 3/8$],
    [$7/9 dot 9/7$],
    [$(2/3)^2$],
  )
][
  #auto-parts(
    3,
    [$8/15$],
    [$3/8$],
    [$(cancel(5) dot cancel(3))/(2 dot cancel(3) dot 2 dot cancel(5)) = 1/4$],
    [$12/8 = 3/2$],
    [$1$],
    [$2/3 dot 2/3 = 4/9$],
  )
]

#ex(difficulty: 1, time: "5 min", calculator: false)[
  Compute in your head.
  #auto-parts(
    3,
    [$1/3$ of $24$],
    [$3/4$ of $60$],
    [$2/5$ of $35$],
    [$5/8$ of $1$ kg, in grams],
    [$1/2$ of $3/4$],
  )
][
  #auto-parts(
    3,
    [$8$],
    [$45$],
    [$14$],
    [$625$ g],
    [$3/8$],
  )
]

#ex(difficulty: 1, time: "4 min", calculator: false)[
  Write down the reciprocal. Which number in the list has none?
  #auto-parts(
    3,
    [$3/7$],
    [$5$],
    [$1/4$],
    [$1$],
    [$0.2$],
    [$0$],
  )
][
  #auto-parts(
    3,
    [$7/3$],
    [$1/5$],
    [$4$],
    [$1$],
    [$0.2 = 1/5$, so $5$],
    [none: no number times $0$ gives $1$],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Compute and simplify.
  #auto-parts(
    3,
    [$3/4 : 1/2$],
    [$2/5 : 4/25$],
    [$6 : 3/4$],
    [$5/6 : 5$],
    [$7/8 : 7/4$],
    [$1/2 : 1/8$],
  )
][
  #auto-parts(
    3,
    [$3/4 dot 2/1 = 3/2$],
    [$2/5 dot 25/4 = 5/2$],
    [$6 dot 4/3 = 8$],
    [$5/6 dot 1/5 = 1/6$],
    [$7/8 dot 4/7 = 1/2$],
    [$1/2 dot 8/1 = 4$],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Simplify the double fractions.
  #auto-parts(
    4,
    [$(2/3)/(8/9)$],
    [$(5/6)/10$],
    [$4/(2/5)$],
    [$(4/9)/(2/3)$],
  )
][
  #auto-parts(
    4,
    [$2/3 dot 9/8 = 3/4$],
    [$5/6 dot 1/10 = 1/12$],
    [$4 dot 5/2 = 10$],
    [$4/9 dot 3/2 = 2/3$],
  )
]

#ex(difficulty: 2, time: "6 min", calculator: false)[
  + How many bottles of $3/4$ liter can be filled from a $6$-liter
    canister?
  + A cake recipe for $4$ people needs $3/4$ cup of sugar. How much
    sugar is needed for $6$ people?
][
  + $6 : 3/4 = 6 dot 4/3 = 8$ bottles.
  + For $6$ people you need $6/4$ times as much:
    $3/4 dot 6/4 = 18/16 = 9/8$ cup, a little more than one cup.
]

#ex(
  difficulty: 2,
  time: "8 min",
  calculator: false,
  hints: (
    [Is the second number larger or smaller than $1$? What does
      multiplying by a number smaller than $1$ do?],
  ),
)[
  Decide _without_ computing whether the result is larger or smaller
  than the first number. Then state a general rule.
  #auto-parts(
    2,
    [$5/6 dot 7/8$ #h(0.5em) compared with #h(0.5em) $5/6$],
    [$5/6 : 7/8$ #h(0.5em) compared with #h(0.5em) $5/6$],
    [$12 dot 3/5$ #h(0.5em) compared with #h(0.5em) $12$],
    [$12 : 3/5$ #h(0.5em) compared with #h(0.5em) $12$],
  )
][
  #auto-parts(
    2,
    [Smaller: you take only $7/8$ _of_ $5/6$. (Exactly: $35/48$.)],
    [Larger: $7/8$ is smaller than $1$, and dividing by a number
      smaller than $1$ makes a positive number larger.
      (Exactly: $20/21$.)],
    [Smaller: $36/5 = 7.2$.],
    [Larger: $20$.],
  )
  Rule: for a positive number, multiplying by a number between $0$ and
  $1$ makes it smaller, and dividing by such a number makes it larger.
  "Multiplying always makes things bigger" is only true for factors
  larger than $1$.
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Three students did a calculation. For each one, decide whether the
  work is correct. If it is wrong, name the mistake and give the correct
  result.
  #auto-parts(
    1,
    [Nina: $2/3 dot 4/5 = 10/15 dot 12/15 = 120/225 = 8/15$],
    [Omar: $3/4 : 2/5 = 4/3 dot 2/5 = 8/15$],
    [Pia: $6 dot 2/3 = (6 dot 2)/(6 dot 3) = 12/18 = 2/3$],
  )
][
  #auto-parts(
    1,
    [Correct, but a detour: multiplying needs no common denominator.
      Directly: $(2 dot 4)/(3 dot 5) = 8/15$.],
    [Wrong. Omar turned the _first_ fraction upside down. Only the
      divisor is inverted: $3/4 dot 5/2 = 15/8$.],
    [Wrong. Pia multiplied the numerator _and_ the denominator by $6$,
      which is expanding and does not change the value. Correct:
      $6/1 dot 2/3 = 12/3 = 4$.],
  )
]

#check(
  kind: "Stage check",
  "Multiplying and dividing",
  (
    [$3/5 dot 10/9$],
    [$2/3$ of $45$],
    [$3/8 : 9/4$],
    [$(2/5)/(4/15)$],
    [$5 : 5/6$],
  ),
  ([$2/3$], [$30$], [$1/6$], [$3/2$], [$6$]),
  cols: 3,
  pass: [Continue with #goto(<st-e>).],
  fail: [Find the example or exercise that matches your mistake and
    redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════════
== Which Rule? <st-e>

#check(
  "Which rule?",
  (
    [$1/2 + 1/3 dot 3/4$],
    [$(1/2 + 1/3) dot 3/4$],
    [$3/5 - 1/5 : 2$],
    [$(1 - 1/4)/(1 + 1/2)$],
  ),
  ([$3/4$], [$5/8$], [$1/2$], [$1/2$]),
  pass: [Skip to the checkpoint in #goto(<st-f>).],
  fail: [Work through this section.],
)

#only-theory[
  You now know four rules, and each of them works. Most mistakes at
  this point do not come from a wrong rule but from the right rule in
  the wrong place: a common denominator for a product, or "straight
  across" for a sum. So before every step, ask yourself one question:
  _which operation am I doing right now?_
]

#keybox(title: "The four rules side by side")[
  #align(center, table(
    columns: (auto, auto, auto, auto),
    align: (left, center, center, center),
    stroke: 0.5pt + luma(180),
    inset: (x: 6pt, y: 6pt),
    table.header(
      [*Operation*], [*Rule*], [*Common denominator?*], [*Example*],
    ),
    [Add, subtract],
    [$a/c plus.minus b/c = (a plus.minus b)/c$],
    [yes],
    [$1/2 + 1/3 = 5/6$],

    [Multiply],
    [$a/b dot c/d = (a dot c)/(b dot d)$],
    [no],
    [$1/2 dot 1/3 = 1/6$],

    [Divide],
    [$a/b : c/d = a/b dot d/c$],
    [no],
    [$1/2 : 1/3 = 3/2$],

    [Simplify],
    [cancel common _factors_],
    [—],
    [$4/6 = 2/3$],
  ))
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  The same two fractions, four different operations. For each part,
  say which rule you use, then compute and simplify.
  #auto-parts(
    4,
    [$3/4 dot 2/9$],
    [$3/4 + 2/9$],
    [$3/4 : 2/9$],
    [$3/4 - 2/9$],
  )
][
  #auto-parts(
    2,
    [Multiply straight across: $(3 dot 2)/(4 dot 9) = 6/36 = 1/6$],
    [Common denominator $36$: $27/36 + 8/36 = 35/36$],
    [Reciprocal of $2/9$: $3/4 dot 9/2 = 27/8$],
    [Common denominator $36$: $27/36 - 8/36 = 19/36$],
  )
]

#keybox(title: "The fraction bar groups")[
  The #vocab("fraction bar", "Bruchstrich") divides the _whole_
  numerator by the _whole_ denominator. It behaves like a pair of
  invisible parentheses:
  $ (a + b)/c = (a + b) : c $
  This has two consequences.
  - You *may* split a sum in the numerator, as long as _every_ term is
    divided: $(a + b)/c = a/c + b/c$.
  - You may *not* split a sum in the denominator: $c/(a + b) != c/a + c/b$.
]

#example(title: "Reading the bar correctly")[
  $ (2 + 6)/2 = 8/2 = 4 $
  Splitting the numerator is allowed if both terms are divided:
  $2/2 + 6/2 = 1 + 3 = 4$. A common slip is $(2 + 6)/2 = 1 + 6 = 7$,
  where only the $2$ was divided.

  In the denominator there is no such choice:
  $ 12/(2 + 4) = 12/6 = 2, quad "but" quad 12/2 + 12/4 = 6 + 3 = 9. $
]

#ex(difficulty: 1, time: "6 min", calculator: false)[
  Evaluate. Remember what the fraction bar groups.
  #auto-parts(
    3,
    [$(3 + 9)/3$],
    [$(20 - 8)/4$],
    [$30/(2 + 3)$],
    [$(4 dot 6)/(4 + 4)$],
    [$(10 + 5)/5$],
    [$24/(4 + 8)$],
  )
][
  #auto-parts(
    3,
    [$12/3 = 4$],
    [$12/4 = 3$],
    [$30/5 = 6$],
    [$24/8 = 3$],
    [$15/5 = 3$],
    [$24/12 = 2$],
  )
]

#keybox(title: "Order of operations")[
  Fractions follow the same order as whole numbers:
  + parentheses first (and the numerator and the denominator of a
    fraction bar, which act as parentheses),
  + then multiplication and division,
  + then addition and subtraction.
]

#example(title: "Where the parentheses go")[
  Without parentheses, the product comes first:
  $ 2/3 + 1/2 dot 2/5 = 2/3 + 1/5 = 10/15 + 3/15 = 13/15. $
  With parentheses, the sum comes first:
  $ (2/3 + 1/2) dot 2/5 = 7/6 dot 2/5 = 14/30 = 7/15. $
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Compute and simplify. Mind the order of operations.
  #auto-parts(
    2,
    [$2/3 + 1/3 dot 3/4$],
    [$(2/3 + 1/3) dot 3/4$],
    [$1 - 1/2 : 2$],
    [$(1 - 1/2) : 2$],
    [$5/6 - 2/3 dot 1/2$],
    [$1/2 dot 4/5 + 3/5 : 3$],
  )
][
  #auto-parts(
    2,
    [$2/3 + 1/4 = 11/12$],
    [$1 dot 3/4 = 3/4$],
    [$1 - 1/4 = 3/4$],
    [$1/2 : 2 = 1/4$],
    [$5/6 - 1/3 = 1/2$],
    [$2/5 + 1/5 = 3/5$],
  )
]

#example(title: "Double fractions with sums")[
  The main fraction bar groups its whole numerator and its whole
  denominator. Work out each of them first, then divide:
  $ (1/2 + 1/3)/(1/2 - 1/3) = (5/6)/(1/6) = 5/6 dot 6/1 = 5. $
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Simplify the double fractions.
  #auto-parts(
    4,
    [$(1 + 1/2)/(1 - 1/2)$],
    [$(1/3 + 1/4)/(1/3 - 1/4)$],
    [$(2 - 1/3)/(1/6)$],
    [$(3/4)/(1/2 + 1/4)$],
  )
][
  #auto-parts(
    4,
    [$(3/2)/(1/2) = 3$],
    [$(7/12)/(1/12) = 7$],
    [$(5/3)/(1/6) = 10$],
    [$(3/4)/(3/4) = 1$],
  )
]

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: false,
  hints: (
    [Before each part, name the operation, then pick the rule from the
      table.],
  ),
)[
  A mixed set: no two neighbors use the same rule. Compute and
  simplify.
  #auto-parts(
    4,
    [$5/8 - 1/4$],
    [$5/8 dot 4/15$],
    [$7/12 + 1/4$],
    [$9/10 : 3/5$],
    [$2 - 7/4$],
    [$3 dot 5/12$],
    [$4/9 + 5/6$],
    [$(5/6)/(10/3)$],
  )
][
  #auto-parts(
    4,
    [$3/8$],
    [$1/6$],
    [$10/12 = 5/6$],
    [$9/10 dot 5/3 = 3/2$],
    [$1/4$],
    [$15/12 = 5/4$],
    [$8/18 + 15/18 = 23/18$],
    [$5/6 dot 3/10 = 1/4$],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Three students used a rule in a new place. For each one, decide
  whether the work is correct. If it is wrong, name the mistake and give
  the correct result. If it is correct, explain why the method works.
  #auto-parts(
    1,
    [Jonas: $1/3 dot 1/2 = 2/6 dot 3/6 = 6/6 = 1$],
    [Lina: $3/5 + 5/6 = 3/1 + 1/6 = 19/6$ #h(0.3em) (she cancelled the
      two $5$s)],
    [Ali: $2/3 : 4/9 = 6/9 : 4/9 = 6/4 = 3/2$],
  )
][
  #auto-parts(
    1,
    [Wrong. Jonas used the common denominator from addition, then
      multiplied the numerators but kept the denominator $6$. With
      $2/6 dot 3/6$ the denominators must be multiplied too: $6/36$.
      Directly: $1/3 dot 1/2 = 1/6$. Size check: half of a third
      cannot be $1$.],
    [Wrong. Cancelling is only allowed between factors of a single
      product or fraction, never across a plus sign. Correct:
      $18/30 + 25/30 = 43/30$.],
    [Correct. With equal denominators, the question "how many times
      does $4/9$ fit into $6/9$?" is the same as "how many times does
      $4$ fit into $6$?". In symbols:
      $6/9 : 4/9 = 6/9 dot 9/4 = 6/4 = 3/2$. It is a valid method,
      just not the usual one.],
  )
]

#ex(
  difficulty: 3,
  time: "12 min",
  calculator: false,
  hints: (
    [To show that "always" is false, one counterexample is enough. To
      show that "never" is false, one example is enough.],
  ),
)[
  All numbers are positive. Is the statement _always_, _sometimes_, or
  _never_ true? Give an example or a reason.
  + The product of two fractions between $0$ and $1$ is smaller than
    each of them.
  + Dividing a number by a fraction makes the number larger.
  + The sum of two fractions between $0$ and $1$ is smaller than $1$.
  + $(a + b)/(a + c) = b/c$
  + $x/y : x/y = 1$
][
  + Always. Multiplying by a number smaller than $1$ makes a positive
    number smaller, and this applies to each factor in turn.
  + Sometimes. $2 : 1/2 = 4$ is larger, but $2 : 3/2 = 4/3$ is smaller.
    It depends on whether the fraction is smaller or larger than $1$.
  + Sometimes. $1/2 + 1/3 = 5/6 < 1$, but $3/4 + 3/4 = 3/2 > 1$.
  + Sometimes, for instance when $b = c$. In general it is false:
    $(2 + 1)/(2 + 3) = 3/5$, but $1/3 != 3/5$. The $a$ is a term, not a
    factor.
  + Always: any nonzero number divided by itself is $1$.
]

#check(
  kind: "Stage check",
  "Which rule?",
  (
    [$1/4 + 1/2 dot 1/3$],
    [$(1/4 + 1/2) dot 1/3$],
    [$2/3 - 1/6 : 2$],
    [$(1/2 + 1/4)/(1 - 1/4)$],
  ),
  ([$5/12$], [$1/4$], [$7/12$], [$1$]),
  pass: [Continue with #goto(<st-f>).],
  fail: [Find the example or exercise that matches your mistake and
    redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════════
== Letters I: Simplifying <st-f>

#check(
  "Simplifying with letters",
  (
    [$(2x + 2y)/2$],
    [$(x + 5)/5$],
    [$(6x - 9)/(4x - 6)$],
    [$(x^2 - 9)/(x + 3)$],
    [$(7 - 7x)/(7x - 7)$],
  ),
  (
    [$x + y$],
    [cannot be simplified],
    [$3/2$],
    [$x - 3$],
    [$-1$],
  ),
  cols: 3,
  pass: [Skip to the checkpoint in #goto(<st-g>).],
  fail: [Work through this section.],
)

#only-theory[
  Look again at the theorem on equivalent fractions: $k$ _multiplies_
  the whole numerator and the whole denominator. You can only simplify
  when that is the situation in front of you. With numbers you can
  always compute the numerator first. With letters you cannot, so you
  need to know exactly what "multiplies" means.
]

#definition(title: "Terms and factors")[
  Parts that are *added or subtracted* are #vocab("terms",
  "Summanden"). Parts that are *multiplied* are #vocab("factors",
  "Faktoren").

  In $3x + 6$, the terms are $3x$ and $6$. \
  In $3 dot (x + 2)$, the factors are $3$ and $(x + 2)$.

  Both expressions have the same value, $3x + 6 = 3 dot (x + 2)$, but
  only the second one is written as a product.
]

#remark[
  *False friend.* In German, _Term_ means any algebraic expression. In
  English, a _term_ is only one of the parts of a sum. An expression
  such as $3x + 6$ is called an _expression_, and it has two terms.
]

#warning[
  *Cancel factors, never terms.* Simplifying divides the _whole_
  numerator and the _whole_ denominator by the same number. That is
  only possible when both are products that share a factor:
  $ (3 dot cancel(5))/(4 dot cancel(5)) = 3/4,
    quad "but" quad
    (3 + 5)/(4 + 5) = 8/9 != 3/4. $
  The same holds for letters: $(x + 3)/(x + 5)$ cannot be simplified
  at all.
]

#keybox(title: "Simplifying in two steps")[
  + *Factor* the numerator and the denominator completely, so that both
    are written as products.
  + *Cancel* the factors that appear in both, and only whole factors.
]

#only-theory[
  The method is identical for numbers and for letters. Compare the two
  columns:

  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.5em,
    row-gutter: 1em,
    [*Numbers*], [*Letters*],
    [$ 12/18 = (cancel(6) dot 2)/(cancel(6) dot 3) = 2/3 $],
    [$ (6x + 9)/(4x + 6)
        = (3 dot cancel((2x + 3)))/(2 dot cancel((2x + 3)))
        = 3/2 $],

    [$ (15 + 10)/5 = (cancel(5) dot (3 + 2))/cancel(5) = 3 + 2 = 5 $],
    [$ (x^2 + x)/x = (cancel(x) dot (x + 1))/cancel(x) = x + 1 $],
  )

  In the second row, the $5$ and the $x$ could only be cancelled
  _after_ factoring. Before factoring, they were part of a term.
]

#keybox(title: "Self-check: test with a number")[
  To check an algebraic simplification, substitute the same number for
  $x$ on both sides. If the results differ, the step was wrong.

  Is $(x + 3)/(x + 5) = 3/5$? With $x = 2$: the left side is $5/7$ and
  the right side is $3/5$. They differ, so the "simplification" is
  wrong.

  Choose an unremarkable number such as $2$ or $3$, never $0$ or $1$.
  With $x = 0$ the wrong step above gives $3/5 = 3/5$, and the error
  goes unnoticed. A single match does not prove a step correct, but a
  single mismatch proves it wrong. On the TI-30X Pro MathPrint you can
  type in both sides and compare.
]

#remark[
  Cancelling a factor such as $(x + 3)$ is only allowed where that
  factor is not $0$, because you may not divide by $0$. In this booklet
  we assume throughout that no denominator is $0$.
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Decide whether the fraction can be simplified. If it can, simplify
  it. If it cannot, say which part is a term rather than a factor.
  #auto-parts(
    3,
    [$(3x)/(3y)$],
    [$(3 + x)/(3 + y)$],
    [$(2x + 2y)/2$],
    [$(x + 5)/5$],
    [$(x dot (x + 1))/(x + 1)$],
    [$(x + 1)/(x + 1)^2$],
  )
][
  #auto-parts(
    3,
    [$x/y$ #h(0.3em) (the $3$ is a factor of both)],
    [Cannot be simplified: the $3$ is a term in both.],
    [$(2 dot (x + y))/2 = x + y$],
    [Cannot be simplified: the $5$ in the numerator is a term.],
    [$x$],
    [$1/(x + 1)$ #h(0.3em) (since $(x + 1)^2 = (x + 1) dot (x + 1)$)],
  )
]

#ex(
  difficulty: 2,
  time: "12 min",
  calculator: false,
  hints: (
    [Factor first. Look for a number or a variable that divides _every_
      term of the numerator.],
    [In (e), the numerator and the denominator differ only in sign:
      $7 - 7x = -7 dot (x - 1)$.],
  ),
)[
  Simplify as far as possible. Factor first.
  #auto-parts(
    3,
    [$(4x + 8)/4$],
    [$(6x - 9)/(4x - 6)$],
    [$(5x^2 - 10x)/(5x)$],
    [$(x^2 - 2x)/(x^2 - 4x)$],
    [$(7 - 7x)/(7x - 7)$],
    [$(3x + 3y)/(x + y)^2$],
  )
][
  #auto-parts(
    3,
    [$(4 dot (x + 2))/4 = x + 2$],
    [$(3 dot (2x - 3))/(2 dot (2x - 3)) = 3/2$],
    [$(5x dot (x - 2))/(5x) = x - 2$],
    [$(x dot (x - 2))/(x dot (x - 4)) = (x - 2)/(x - 4)$],
    [$(-7 dot (x - 1))/(7 dot (x - 1)) = -1$],
    [$(3 dot (x + y))/((x + y) dot (x + y)) = 3/(x + y)$],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Three students simplified a fraction. For each one, decide whether the
  work is correct. If it is wrong, name the mistake and give the correct
  result.
  #auto-parts(
    3,
    [Anna: $(x + 6)/6 = x + 1$],
    [Ben: $(4x + 2)/2 = 4x + 1$],
    [Chiara: $(x^2 + 3x)/x = x + 3$],
  )
][
  #auto-parts(
    3,
    [Wrong. The $6$ in the numerator is a term, not a factor, so
      nothing can be cancelled. The fraction is already as simple as
      it gets. (It can be split: $x/6 + 1$.)],
    [Wrong. Only one of the two terms was divided by $2$. Correct:
      $(2 dot (2x + 1))/2 = 2x + 1$.],
    [Correct: $(x dot (x + 3))/x = x + 3$.],
  )
]

#ex(
  difficulty: 3,
  time: "10 min",
  calculator: false,
  hints: (
    [Use the binomial formulas:
      $a^2 - b^2 = (a + b) dot (a - b)$ and
      $a^2 + 2a b + b^2 = (a + b)^2$.],
  ),
)[
  Simplify as far as possible, or explain why no simplification is
  possible.
  #auto-parts(
    3,
    [$(x^2 - 9)/(x + 3)$],
    [$(x^2 - 4)/(x^2 + 4x + 4)$],
    [$(x^2 + 9)/(x + 3)$],
  )
][
  #auto-parts(
    3,
    [$((x + 3) dot (x - 3))/(x + 3) = x - 3$],
    [$((x + 2) dot (x - 2))/(x + 2)^2 = (x - 2)/(x + 2)$],
    [No simplification is possible: $x^2 + 9$ cannot be factored, so
      $x + 3$ is not a factor of the numerator. (Test with $x = 2$:
      $13/5$, while $x - 3$ would give $-1$.)],
  )
]

#check(
  kind: "Stage check",
  "Simplifying with letters",
  (
    [$(5x + 10)/5$],
    [$(x + 4)/(x + 8)$],
    [$(x^2 - 3x)/(2x - 6)$],
    [$(x^2 - 1)/(x^2 + 2x + 1)$],
  ),
  (
    [$x + 2$],
    [cannot be simplified],
    [$x/2$],
    [$(x - 1)/(x + 1)$],
  ),
  pass: [Continue with #goto(<st-g>).],
  fail: [Find the example or exercise that matches your mistake and
    redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════════
== Letters II: Adding and Subtracting <st-g>

#check(
  "Adding and subtracting with letters",
  (
    [$x/3 + x/4$],
    [$2/x + 3/(2x)$],
    [$(x + 1)/6 - (x - 2)/4$],
    [$1/x - 1/(x + 1)$],
    [$2/(x - 3) + 1$],
  ),
  (
    [$(7x)/12$],
    [$7/(2x)$],
    [$(8 - x)/12$],
    [$1/(x dot (x + 1))$],
    [$(x - 1)/(x - 3)$],
  ),
  cols: 3,
  pass: [Skip to the checkpoint in #goto(<st-h>).],
  fail: [Work through this section.],
)

#only-theory[
  Nothing new happens when letters appear: you still need a common
  denominator, and you still expand each fraction to it. Compare the
  two columns:

  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.5em,
    row-gutter: 1em,
    [*Numbers*], [*Letters*],
    [$ 1/3 + 1/4 = 4/12 + 3/12 = 7/12 $],
    [$ x/3 + x/4 = (4x)/12 + (3x)/12 = (7x)/12 $],

    [$ 2/5 + 3/7 = (2 dot 7 + 3 dot 5)/(5 dot 7) = 29/35 $],
    [$ 2/x + 3/y = (2 dot y + 3 dot x)/(x y) = (3x + 2y)/(x y) $],
  )

  The second row uses the product of the denominators, which always
  works. When the denominators share a factor, the least common
  denominator is smaller and keeps the work shorter.
]

#keybox(title: "Least common denominator with letters")[
  + Factor every denominator completely.
  + The LCD contains every factor that occurs, each as often as it
    occurs in the denominator where it appears most often.
]

#example(title: "Finding the LCD")[
  For $5/(6x) + 1/(4x^2)$, factor the denominators:
  $6x = 2 dot 3 dot x$ and $4x^2 = 2 dot 2 dot x dot x$. The LCD needs
  $2 dot 2$, $3$, and $x dot x$, so it is $12x^2$:
  $ 5/(6x) + 1/(4x^2) = (5 dot 2x)/(12x^2) + (1 dot 3)/(12x^2)
    = (10x + 3)/(12x^2). $
  For $1/x - 1/(x + 1)$, the denominators have no common factor, so
  the LCD is their product:
  $ 1/x - 1/(x + 1) = (x + 1)/(x dot (x + 1)) - x/(x dot (x + 1))
    = (x + 1 - x)/(x dot (x + 1)) = 1/(x dot (x + 1)). $
]

#only-theory[
  The most common mistake in this section has nothing to do with
  denominators. It happens when several numerators are written over
  one fraction bar, and one of them is subtracted.
]

#keybox(title: "Parentheses around every numerator")[
  When you combine fractions over a single fraction bar, put each
  numerator in parentheses _first_, then expand. A minus sign in front
  of a fraction bar applies to the _whole_ numerator, just as the
  fraction bar groups it.
]

#example(title: "The minus sign in front of a fraction")[
  $ (x + 1)/6 - (x - 2)/4
    &= (2 dot (x + 1))/12 - (3 dot (x - 2))/12 \
    &= (2 dot (x + 1) - 3 dot (x - 2))/12 \
    &= (2x + 2 - 3x + 6)/12 = (8 - x)/12 $
  Without the parentheses, the last line becomes $2x + 2 - 3x - 6$,
  and the result $(-x - 4)/12$ is wrong. The self-check from
  #goto(<st-f>) catches it: with $x = 2$, the original expression is
  $3/6 - 0/4 = 1/2$, and $(8 - 2)/12 = 1/2$ agrees, while
  $(-2 - 4)/12 = -1/2$ does not.
]

#example(title: "Whole expressions and simplifying afterward")[
  A whole expression gets the common denominator as well:
  $ 2/(x - 3) + 1 = 2/(x - 3) + (x - 3)/(x - 3) = (x - 1)/(x - 3),
    quad quad x + 1/x = x^2/x + 1/x = (x^2 + 1)/x. $
  After adding, always check whether the result can be simplified:
  $ x/(x - 2) - 2/(x - 2) = (x - 2)/(x - 2) = 1. $
]

#ex(difficulty: 1, time: "6 min", calculator: false)[
  The denominators are already equal. Compute and simplify.
  #auto-parts(
    3,
    [$x/5 + (3x)/5$],
    [$(2x + 1)/3 + (x - 1)/3$],
    [$(x + 4)/x - 4/x$],
    [$(3x + 2)/7 - (x + 2)/7$],
    [$x^2/(x + 3) - 9/(x + 3)$],
  )
][
  #auto-parts(
    3,
    [$(4x)/5$],
    [$(3x)/3 = x$],
    [$x/x = 1$],
    [$(3x + 2 - x - 2)/7 = (2x)/7$],
    [$(x^2 - 9)/(x + 3) = x - 3$],
  )
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  The denominators are numbers. Compute and simplify.
  #auto-parts(
    2,
    [$x/2 + x/3$],
    [$(3x)/4 - x/6$],
    [$(x + 1)/2 + (x - 1)/4$],
    [$x - x/5$],
  )
][
  #auto-parts(
    2,
    [$(3x)/6 + (2x)/6 = (5x)/6$],
    [$(9x)/12 - (2x)/12 = (7x)/12$],
    [$(2x + 2 + x - 1)/4 = (3x + 1)/4$],
    [$(5x)/5 - x/5 = (4x)/5$],
  )
]

#ex(
  difficulty: 2,
  time: "10 min",
  calculator: false,
  hints: (
    [Parentheses around every numerator before you expand. In (d), the
      $1$ needs the common denominator too.],
  ),
)[
  Watch the minus signs. Compute and simplify.
  #auto-parts(
    2,
    [$(x + 3)/4 - (x - 1)/6$],
    [$(2x - 1)/3 - (x - 2)/2$],
    [$x/2 - (x + 4)/3$],
    [$1 - (x - 1)/x$],
  )
][
  #auto-parts(
    2,
    [$(3 dot (x + 3) - 2 dot (x - 1))/12 = (x + 11)/12$],
    [$(2 dot (2x - 1) - 3 dot (x - 2))/6 = (x + 4)/6$],
    [$(3x - 2 dot (x + 4))/6 = (x - 8)/6$],
    [$(x - (x - 1))/x = 1/x$],
  )
]

#ex(
  difficulty: 2,
  time: "10 min",
  calculator: false,
  hints: (
    [Factor the denominators. For (c), $3x = 3 dot x$ and
      $6x^2 = 2 dot 3 dot x dot x$.],
  ),
)[
  Letters in the denominators. Compute and simplify.
  #auto-parts(
    3,
    [$1/x + 1/(2x)$],
    [$3/x - 2/x^2$],
    [$1/(3x) + 1/(6x^2)$],
    [$2/x + 3/y$],
    [$1/x + x$],
  )
][
  #auto-parts(
    3,
    [$2/(2x) + 1/(2x) = 3/(2x)$],
    [$(3x)/x^2 - 2/x^2 = (3x - 2)/x^2$],
    [$(2x)/(6x^2) + 1/(6x^2) = (2x + 1)/(6x^2)$],
    [$(2y + 3x)/(x y)$],
    [$1/x + x^2/x = (x^2 + 1)/x$],
  )
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  The denominators are sums or differences. Compute and simplify.
  #auto-parts(
    2,
    [$1/x + 1/(x + 1)$],
    [$2/(x - 1) - 1/(x + 1)$],
    [$x/(x + 2) + 1$],
    [$3/(x - 3) - x/(x - 3)$],
  )
][
  #auto-parts(
    2,
    [$(x + 1 + x)/(x dot (x + 1)) = (2x + 1)/(x dot (x + 1))$],
    [$(2 dot (x + 1) - (x - 1))/((x - 1) dot (x + 1))
        = (x + 3)/((x - 1) dot (x + 1))$],
    [$(x + x + 2)/(x + 2) = (2x + 2)/(x + 2)$],
    [$(3 - x)/(x - 3) = (-(x - 3))/(x - 3) = -1$],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Three students added or subtracted fractions. For each one, decide
  whether the work is correct. If it is wrong, name the mistake and give
  the correct result.
  #auto-parts(
    1,
    [Emma: $(x + 2)/3 - (x - 1)/2 = (2x + 4 - 3x - 3)/6 = (1 - x)/6$],
    [David: $1/x + 1/y = 2/(x + y)$],
    [Fiona: $2/x + 3/x^2 = (2x + 3)/x^2$],
  )
][
  #auto-parts(
    1,
    [Wrong. The minus applies to the whole second numerator:
      $-3 dot (x - 1) = -3x + 3$. Correct: $(2x + 4 - 3x + 3)/6
      = (7 - x)/6$. Check with $x = 1$: $1 - 0 = 1$, and
      $(7 - 1)/6 = 1$.],
    [Wrong. David added the numerators and the denominators. Test
      with $x = y = 1$: the left side is $2$, the right side is $1$.
      Correct: $(y + x)/(x y)$.],
    [Correct. The LCD is $x^2$, not $x^3$: $x^2$ already contains the
      factor $x$.],
  )
]

#ex(
  difficulty: 3,
  time: "15 min",
  calculator: false,
  hints: (
    [Factor every denominator first: $x^2 - 4 = (x + 2) dot (x - 2)$
      and $x^2 - x = x dot (x - 1)$.],
    [In (b), $2 - x = -(x - 2)$, so $3/(2 - x) = -3/(x - 2)$.],
  ),
)[
  Factor the denominators first, then compute and simplify.
  #auto-parts(
    2,
    [$1/(x^2 - 4) + 1/(x + 2)$],
    [$1/(x - 2) + 3/(2 - x)$],
    [$x/(x^2 - x) - 1/(x - 1)$],
    [$2/(x^2 + 2x) + 1/x$],
  )
][
  #auto-parts(
    2,
    [$(1 + (x - 2))/((x + 2) dot (x - 2)) = (x - 1)/(x^2 - 4)$],
    [$1/(x - 2) - 3/(x - 2) = -2/(x - 2)$],
    [$x/(x dot (x - 1)) - 1/(x - 1) = 1/(x - 1) - 1/(x - 1) = 0$],
    [$(2 + (x + 2))/(x dot (x + 2)) = (x + 4)/(x dot (x + 2))$],
  )
]

#check(
  kind: "Stage check",
  "Adding and subtracting with letters",
  (
    [$x/4 + x/6$],
    [$3/x - 1/(2x)$],
    [$(x + 2)/3 - (x - 4)/6$],
    [$1/(x - 1) + 1/(x + 1)$],
    [$x - 1/x$],
  ),
  (
    [$(5x)/12$],
    [$5/(2x)$],
    [$(x + 8)/6$],
    [$(2x)/((x - 1) dot (x + 1))$],
    [$(x^2 - 1)/x$],
  ),
  cols: 3,
  pass: [Continue with #goto(<st-h>).],
  fail: [Find the example or exercise that matches your mistake and
    redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════════
== Letters III: Multiplying, Dividing, Double Fractions <st-h>

#check(
  "Multiplying and dividing with letters",
  (
    [$(2x)/3 dot 9/(4x^2)$],
    [$(x^2 - 1)/(3x) dot (6x)/(x + 1)$],
    [$x/y : x^2/y^3$],
    [$(1 + 1/x)/(1 - 1/x)$],
  ),
  (
    [$3/(2x)$],
    [$2 dot (x - 1)$],
    [$y^2/x$],
    [$(x + 1)/(x - 1)$],
  ),
  pass: [Skip to the #goto(<st-final>).],
  fail: [Work through this section.],
)

#only-theory[
  Good news: with letters, multiplying and dividing are _easier_ than
  adding, because no common denominator is needed. The one thing that
  matters is the order of the steps: factor and cancel first, multiply
  last. Compare the two columns:

  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.5em,
    row-gutter: 1em,
    [*Numbers*], [*Letters*],
    [$ 4/9 dot 3/8 = (4 dot 3)/(9 dot 8) = 1/6 $],
    [$ (3x)/4 dot 10/(9x^2) = (3x dot 10)/(4 dot 9x^2) = 5/(6x) $],

    [$ 5/6 : 10/9 = 5/6 dot 9/10 = 3/4 $],
    [$ x^2/y : x/y^3 = x^2/y dot y^3/x = x y^2 $],
  )
]

#keybox(title: "Multiplying and dividing with letters")[
  + Turn every division into a multiplication by the reciprocal of the
    divisor.
  + Factor every numerator and every denominator completely.
  + Write everything over one fraction bar and cancel common factors.
  + Multiply out what is left, or leave it factored.
]

#example(title: "Factor first, multiply last")[
  $ (x^2 - 4)/(2x) dot (4x)/(x + 2)
    = ((x + 2) dot (x - 2) dot 4x)/(2x dot (x + 2))
    = ((x + 2) dot (x - 2) dot 2 dot 2x)/(2x dot (x + 2))
    = 2 dot (x - 2) $
  Multiplying out first would give $(4x^3 - 16x)/(2x^2 + 4x)$, and
  you would then have to factor it all again to simplify.
]

#example(title: "Dividing")[
  $ (x^2 - 4)/(x + 3) : (x - 2)/(2x + 6)
    = ((x + 2) dot (x - 2))/(x + 3) dot (2 dot (x + 3))/(x - 2)
    = 2 dot (x + 2) $
  Only the divisor $(x - 2)/(2x + 6)$ is turned upside down.
]

#only-theory[
  Double fractions with letters can be handled as a division, exactly
  as in #goto(<st-d>). Often there is a faster way, and it uses
  nothing but expanding from #goto(<st-b>): multiply the main
  numerator and the main denominator by the LCD of all the small
  fractions. Every small fraction then disappears at once.
]

#example(title: "Double fractions: expand to clear the small fractions")[
  In $(1 + 2/x)/(1 - 4/x^2)$, the small denominators are $x$ and $x^2$,
  so expand with $x^2$:
  $ (1 + 2/x)/(1 - 4/x^2)
    = ((1 + 2/x) dot x^2)/((1 - 4/x^2) dot x^2)
    = (x^2 + 2x)/(x^2 - 4)
    = (x dot (x + 2))/((x + 2) dot (x - 2))
    = x/(x - 2) $
  With two letters, expand with $x y$:
  $ (1/x - 1/y)/(1/x + 1/y) = (y - x)/(y + x) $
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Compute and simplify.
  #auto-parts(
    3,
    [$(3x)/4 dot 2/x$],
    [$x/5 dot 10/x^2$],
    [$(4x^2)/9 dot 3/(2x)$],
    [$x/y dot y^2/x^3$],
    [$5x dot 3/(10x)$],
    [$((2x)/3)^2$],
  )
][
  #auto-parts(
    3,
    [$(6x)/(4x) = 3/2$],
    [$(10x)/(5x^2) = 2/x$],
    [$(12x^2)/(18x) = (2x)/3$],
    [$(x y^2)/(x^3 y) = y/x^2$],
    [$(15x)/(10x) = 3/2$],
    [$(4x^2)/9$],
  )
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Compute and simplify.
  #auto-parts(
    3,
    [$x/2 : x/6$],
    [$(3x)/4 : 9/(2x)$],
    [$x^2/5 : x$],
    [$1/x : 1/x^2$],
    [$4 : 2/x$],
  )
][
  #auto-parts(
    3,
    [$x/2 dot 6/x = 3$],
    [$(3x)/4 dot (2x)/9 = x^2/6$],
    [$x^2/5 dot 1/x = x/5$],
    [$1/x dot x^2/1 = x$],
    [$4 dot x/2 = 2x$],
  )
]

#ex(
  difficulty: 2,
  time: "12 min",
  calculator: false,
  hints: (
    [Factor every numerator and denominator before you cancel:
      $x^2 - 9 = (x + 3) dot (x - 3)$, $3x + 3 = 3 dot (x + 1)$,
      $x^2 + x = x dot (x + 1)$.],
  ),
)[
  Factor first, then multiply. Simplify as far as possible.
  #auto-parts(
    2,
    [$(x + 2)/4 dot 8/(x + 2)^2$],
    [$(x^2 - 9)/x dot (2x)/(x + 3)$],
    [$(3x + 3)/x^2 dot x/(x + 1)$],
    [$(x^2 + x)/(x - 1) dot (x^2 - 1)/(x + 1)^2$],
  )
][
  #auto-parts(
    2,
    [$((x + 2) dot 8)/(4 dot (x + 2)^2) = 2/(x + 2)$],
    [$((x + 3) dot (x - 3) dot 2x)/(x dot (x + 3)) = 2 dot (x - 3)$],
    [$(3 dot (x + 1) dot x)/(x^2 dot (x + 1)) = 3/x$],
    [$(x dot (x + 1) dot (x + 1) dot (x - 1))/((x - 1) dot (x + 1)^2)
        = x$],
  )
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  Compute and simplify.
  #auto-parts(
    2,
    [$(x + 1)/x : (x + 1)/x^2$],
    [$(x^2 - 1)/(2x) : (x + 1)/(4x^2)$],
    [$(2x - 6)/5 : (x - 3)/10$],
    [$(x^2 + 2x)/(x^2 - 4) : x/(x - 2)$],
  )
][
  #auto-parts(
    2,
    [$(x + 1)/x dot x^2/(x + 1) = x$],
    [$((x + 1) dot (x - 1) dot 4x^2)/(2x dot (x + 1)) = 2x dot (x - 1)$],
    [$(2 dot (x - 3) dot 10)/(5 dot (x - 3)) = 4$],
    [$(x dot (x + 2) dot (x - 2))/((x + 2) dot (x - 2) dot x) = 1$],
  )
]

#ex(
  difficulty: 2,
  time: "12 min",
  calculator: false,
  hints: (
    [Expand the double fraction with the LCD of all the small
      denominators. In (c) that is $x^2$; in (d) it is $x y$.],
  ),
)[
  Simplify the double fractions.
  #auto-parts(
    4,
    [$(1 - 1/x)/(1/x)$],
    [$(x/y)/(x^2/y)$],
    [$(2 + 1/x)/(4 - 1/x^2)$],
    [$(1/x + 1/y)/(1/(x y))$],
  )
][
  #auto-parts(
    2,
    [expand with $x$: $(x - 1)/1 = x - 1$],
    [$x/y dot y/x^2 = 1/x$],
    [expand with $x^2$: $(2x^2 + x)/(4x^2 - 1)
        = (x dot (2x + 1))/((2x + 1) dot (2x - 1)) = x/(2x - 1)$],
    [expand with $x y$: $(y + x)/1 = x + y$],
  )
]

#ex(difficulty: 2, time: "8 min", calculator: false)[
  Three students multiplied or divided. For each one, decide whether
  the work is correct. If it is wrong, name the mistake and give the
  correct result.
  #auto-parts(
    1,
    [Gina: $(x + 3)/6 dot 2/(x + 3) = 2/6 = 1/3$],
    [Hugo: $2/x dot 3/x = 6/x$],
    [Ivo: $x/(x + 1) : x/(x - 1) = (x + 1)/x dot x/(x - 1)
      = (x + 1)/(x - 1)$],
  )
][
  #auto-parts(
    1,
    [Correct: $(x + 3)$ is a factor of the numerator and of the
      denominator.],
    [Wrong. Hugo kept the common denominator, as if he were adding.
      Multiplying multiplies the denominators too: $6/x^2$. Check with
      $x = 2$: $1 dot 3/2 = 3/2$, and $6/4 = 3/2$, but $6/2 = 3$.],
    [Wrong. Ivo turned the _first_ fraction upside down. Only the
      divisor is inverted: $x/(x + 1) dot (x - 1)/x = (x - 1)/(x + 1)$.],
  )
]

#ex(
  difficulty: 3,
  time: "15 min",
  calculator: false,
  hints: (
    [Combine the sums and differences into single fractions first,
      then multiply or divide.],
    [In (c), expand with $x y$ and use $x^2 - y^2 = (x + y) dot (x - y)$.],
  ),
)[
  All four rules at once. Simplify as far as possible.
  #auto-parts(
    3,
    [$(1 + 1/x) dot x/(x + 1)$],
    [$(x - 4/x) : (x - 2)$],
    [$(x/y - y/x)/(1/x + 1/y)$],
  )
][
  #auto-parts(
    1,
    [$(x + 1)/x dot x/(x + 1) = 1$],
    [$(x^2 - 4)/x dot 1/(x - 2) = ((x + 2) dot (x - 2))/(x dot (x - 2))
        = (x + 2)/x$],
    [Expand with $x y$:
      $(x^2 - y^2)/(y + x) = ((x + y) dot (x - y))/(x + y) = x - y$],
  )
]

#check(
  kind: "Stage check",
  "Multiplying and dividing with letters",
  (
    [$(3x)/5 dot 10/(9x^2)$],
    [$(x^2 - 4)/(5x) dot (10x)/(x - 2)$],
    [$x^2/y : x/y^2$],
    [$(1 - 1/x)/(1 + 1/x)$],
  ),
  (
    [$2/(3x)$],
    [$2 dot (x + 2)$],
    [$x y$],
    [$(x - 1)/(x + 1)$],
  ),
  pass: [Continue with the #goto(<st-final>).],
  fail: [Find the example or exercise that matches your mistake and
    redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════════
== Final Check <st-final>

#only-theory[
  This check is at the level expected in exams. Each item belongs to
  one of the "Letters" sections, so your mistakes tell you exactly
  where to go back to.
]

#check(
  kind: "Final check",
  "Algebraic fractions",
  (
    [Simplify $(x^2 - 4x + 4)/(x^2 - 4)$.],
    [$3/(x - 2) - 2/(x + 2)$],
    [$(x/(x + 1))/(x^2/(x^2 - 1))$],
    [$1/2 + 1/(2x) - (x + 1)/(2x)$],
  ),
  (
    [$(x - 2)/(x + 2)$],
    [$(x + 10)/((x - 2) dot (x + 2))$],
    [$(x - 1)/x$],
    [$0$],
  ),
  time: "15 min",
  pass: [Well done. Go on to the #goto(<st-chal>).],
  fail: [Mistake in (a)? Go back to #goto(<st-f>). In (b) or (d)?
    Go back to #goto(<st-g>). In (c)? Go back to #goto(<st-h>).
    Afterwards, return here and redo the items you got wrong.],
)

// ════════════════════════════════════════════════════════════
== Challenges <st-chal>

#only-theory[
  For when you have finished everything else. These problems use
  nothing beyond what is in this booklet, but they ask you to think
  rather than to apply a method. Being stuck for a while is part of the
  fun.
]

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: false,
  hints: (
    [Compute $1/2 + 1/3 + 1/9$ as a single fraction.],
    [For (c), look for three fractions with numerator $1$ whose sum is
      $n/(n + 1)$, where all three denominators divide $n + 1$.],
  ),
)[
  *The 17 camels.* An old trader leaves his $17$ camels to his three
  sons: the eldest is to get $1/2$ of them, the middle son $1/3$, and
  the youngest $1/9$. Since $17$ cannot be divided by $2$, $3$, or $9$,
  the sons argue. A wise woman passing by lends them her own camel. Now
  there are $18$: the eldest takes $9$, the middle son $6$, and the
  youngest $2$. That makes $17$, so the woman takes her camel back.
  + Did each son get at least his share? Compare with the exact shares
    of $17$ camels.
  + Explain the trick with a single fraction calculation.
  + Invent another inheritance (a number of camels and three shares)
    for which the same trick works.
][
  + The exact shares are $17/2 = 8.5$, $17/3 approx 5.67$, and
    $17/9 approx 1.89$ camels. Each son gets more than his share.
  + $1/2 + 1/3 + 1/9 = 9/18 + 6/18 + 2/18 = 17/18$. The will only gives
    away $17/18$ of the herd, so it never divides up all of it. Of $18$
    camels, $17/18$ is exactly $17$, and the borrowed camel is left
    over.
  + For example, $11$ camels with shares $1/2$, $1/4$, $1/6$: the sum
    is $11/12$, and $12$ camels split into $6 + 3 + 2 = 11$. Or $7$
    camels with $1/2$, $1/4$, $1/8$ (sum $7/8$, split $4 + 2 + 1$).
]

#ex(
  difficulty: 3,
  time: "20 min",
  calculator: false,
  hints: (
    [For (c), write $16 = 10 + 6$ and $64 = 60 + 4$. Is the $6$ a factor
      of the numerator?],
    [For (d), call the digits $a$, $b$, $c$, so that the fraction is
      $(10a + b)/(10b + c)$, and the "trick" claims it equals $a/c$.],
  ),
)[
  *Lucky cancelling.* A student "simplifies" $16/64$ by crossing out
  the two $6$s and gets $1/4$.
  + Simplify $16/64$ correctly. Is $1/4$ the right answer?
  + Apply the same "crossing out" trick to $19/95$, $26/65$, $49/98$,
    and $12/24$. In which cases does it give the correct value?
  + Explain why crossing out the $6$ in $16/64$ is _not_ cancelling.
  + Find every fraction of two-digit numbers (smaller than $1$, no
    zeros) for which the trick happens to work. A short program helps.
][
  + $16/64 = (16 dot 1)/(16 dot 4) = 1/4$. The answer is correct.
  + $19/95 -> 1/5$ #sym.checkmark, #h(0.5em)
    $26/65 -> 2/5$ #sym.checkmark, #h(0.5em)
    $49/98 -> 4/8 = 1/2$ #sym.checkmark, #h(0.5em)
    but $12/24 -> 1/4$ is wrong, since $12/24 = 1/2$.
  + $16/64 = (10 + 6)/(60 + 4)$. The $6$ is part of a term, not a factor
    of the numerator, so it cannot be cancelled. A correct result does
    not prove a correct method.
  + Exactly four: $16/64$, $19/95$, $26/65$, and $49/98$. For example,
    test all digits $a, b, c$ from $1$ to $9$ with $a < c$ for
    $(10a + b) dot c = a dot (10b + c)$.
]

#ex(
  difficulty: 3,
  time: "20 min",
  calculator: false,
  hints: (
    [In (a), count shots: how many did Mia take in total, and how many
      went in?],
    [For (d), compare $a/b$ with $(a + c)/(b + d)$ by multiplying both
      sides by $b dot (b + d)$.],
  ),
)[
  *When adding tops and bottoms is right.* In basketball, Mia scores
  $3$ of $5$ free throws in the first half and $5$ of $7$ in the second
  half.
  + What fraction of her free throws did she score in the whole game?
    Compare your answer with $3/5 + 5/7$. Which calculation answers the
    question, and why is the other one meaningless here?
  + Check that the overall rate lies between $3/5$ and $5/7$.
  + Two players, Alex and Ben, compete on free throws:

    #align(center, table(
      columns: (auto, auto, auto),
      align: center,
      stroke: 0.5pt + luma(180),
      inset: (x: 8pt, y: 5pt),
      table.header([], [*1st half*], [*2nd half*]),
      [Alex], [$4$ of $10$], [$3$ of $4$],
      [Ben], [$1$ of $3$], [$7$ of $10$],
    ))

    Show that Alex has the better rate in _each_ half, but Ben has the
    better rate over the whole game. How is that possible?
  + Show that the rule from (b) always holds: for positive numbers
    with $a/b < c/d$, the combined rate $(a + c)/(b + d)$ lies strictly
    between $a/b$ and $c/d$.
][
  + Mia took $5 + 7 = 12$ shots and scored $3 + 5 = 8$, so her rate is
    $(3 + 5)/(5 + 7) = 8/12 = 2/3$. Here adding tops and bottoms is
    right, because it adds _counts_ (shots scored, shots taken). It is
    not the sum of two fractions. The actual sum
    $3/5 + 5/7 = 46/35$ is larger than $1$, which makes no sense as a
    success rate.
  + $3/5 = 0.6$, $2/3 approx 0.667$, and $5/7 approx 0.714$.
  + First half: $4/10 = 0.4 > 1/3$. Second half: $3/4 = 0.75 > 7/10$.
    Overall: Alex $7/14 = 0.5$, Ben $8/13 approx 0.615$. Alex took most
    of his shots in his weak first half, Ben most of his in his strong
    second half. The overall rate is weighted by the number of shots,
    so it is not decided by the two half-time rates alone. This effect
    is called _Simpson's paradox_.
  + $a/b < (a + c)/(b + d)$ is equivalent to
    $a dot (b + d) < b dot (a + c)$, that is $a d < b c$, which is
    equivalent to $a/b < c/d$. The right-hand inequality works the
    same way.
]

#ex(
  difficulty: 3,
  time: "15 min",
  calculator: false,
  hints: (
    [You computed $1/x - 1/(x + 1)$ in the checkpoint of #goto(<st-g>).],
    [Write every term of the sum as a difference using (a), and look at
      what happens to neighboring terms.],
  ),
)[
  *A sum that collapses.*
  + Show that $1/n - 1/(n + 1) = 1/(n dot (n + 1))$.
  + Use (a) to compute
    $ 1/(1 dot 2) + 1/(2 dot 3) + 1/(3 dot 4) + dots + 1/(99 dot 100) $
    without a calculator.
  + What happens to the sum if you keep adding terms? Does it ever
    reach $1$?
][
  + $1/n - 1/(n + 1) = (n + 1 - n)/(n dot (n + 1)) = 1/(n dot (n + 1))$.
  + Written as differences, almost everything cancels:
    $ (1 - 1/2) + (1/2 - 1/3) + (1/3 - 1/4) + dots + (1/99 - 1/100)
      = 1 - 1/100 = 99/100. $
  + With $n$ terms the sum is $1 - 1/(n + 1)$. It gets as close to $1$
    as you like, but it never reaches $1$. Compare the gaps
    $1/(n dot (n + 1))$ in the last exercise of #goto(<st-c>).
]

#ex(
  difficulty: 2,
  time: "20 min",
  calculator: false,
  hints: (
    [The largest unit fraction below $q$ has denominator: divide the
      denominator of $q$ by its numerator and round _up_.],
  ),
)[
  *Egyptian fractions.* The ancient Egyptians wrote every fraction as a
  sum of _different_ unit fractions (fractions with numerator $1$), for
  example $3/4 = 1/2 + 1/4$. The will in the camel problem used the
  same idea.
  + Write $5/6$ and $7/12$ as sums of two different unit fractions.
  + The _greedy method_: subtract the largest unit fraction that is not
    larger than your number, then repeat with what is left. Use it to
    write $4/5$, $2/7$, and $3/7$ as Egyptian fractions.
  + Show that $1/n = 1/(n + 1) + 1/(n dot (n + 1))$. Why does this
    mean that every fraction can be written in infinitely many
    different ways?
][
  + $5/6 = 1/2 + 1/3$. For $7/12$ there are two ways:
    $1/3 + 1/4$ or $1/2 + 1/12$.
  + $4/5 = 1/2 + 1/4 + 1/20$ (after $1/2$, $3/10$ is left; after
    $1/4$, $1/20$). #linebreak()
    $2/7 = 1/4 + 1/28$. #linebreak()
    $3/7 = 1/3 + 1/11 + 1/231$ (after $1/3$, $2/21$ is left; the
    largest unit fraction below it is $1/11$, since $1/10 > 2/21$; and
    $2/21 - 1/11 = 1/231$).
  + $1/(n + 1) + 1/(n dot (n + 1)) = (n + 1)/(n dot (n + 1)) = 1/n$.
    So the largest unit fraction in any representation can be split
    into two smaller, different ones, and that can be repeated
    forever.
]

#ex(
  difficulty: 3,
  time: "20 min",
  calculator: true,
  hints: (
    [If $x_n = a/b$, then $x_(n + 1) = 1 + 1/(a/b) = 1 + b/a$.],
  ),
)[
  *A fraction that never ends.* Start with $x_1 = 1$ and compute each
  new number from the previous one with $x_(n + 1) = 1 + 1/x_n$. So
  $x_2 = 1 + 1/1 = 2$, then $x_3 = 1 + 1/2$, and so on.
  + Compute $x_3$ to $x_8$ as fractions, without a calculator.
  + Convert them to decimals with your calculator. What do you notice?
  + Look at the numerators and denominators. Which famous sequence
    appears? Explain why.
  + (If you know quadratic equations.) Suppose the numbers settle down
    at a value $x$. Then $x = 1 + 1/x$. Solve for $x$.
][
  + $x_3 = 3/2$, $x_4 = 5/3$, $x_5 = 8/5$, $x_6 = 13/8$,
    $x_7 = 21/13$, $x_8 = 34/21$.
  + $1.5$, $1.667$, $1.6$, $1.625$, $1.615$, $1.619$. The values jump
    above and below a limit, getting closer each time.
  + The Fibonacci numbers $1, 1, 2, 3, 5, 8, 13, 21, 34, dots$. If
    $x_n = a/b$, then $x_(n + 1) = 1 + b/a = (a + b)/a$: the new
    numerator is the sum of the old numerator and denominator, and the
    old numerator becomes the new denominator.
  + $x^2 = x + 1$, so $x^2 - x - 1 = 0$ and
    $x = (1 + sqrt(5))/2 approx 1.618$ (the positive solution). This
    is the _golden ratio_.
]

// ════════════════════════════════════════════════════════════
#print-check-key()

#print-hints()
#print-vocab()
