#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Counting")
#let ex = exercise.with(chapter: "Counting")

// ── TEACHER'S NOTE: two errors in the LaTeX source ───────────
// Both are corrected silently below; flagging them here so the old
// notes can be fixed too.
//
//  * The braille exercise (old Ex 39) is answered 64. A braille cell
//    has 6 dots, each raised or not, giving 2^6 = 64 patterns — but
//    the exercise says "a symbol is created by using at least 1 dot",
//    which excludes the empty cell. The answer is 63. It is a good
//    exercise precisely because of that subtraction, so I've kept the
//    wording and fixed the answer.
//
//  * The binomial-coefficient summary box states binom(n, 0) = 0.
//    It is 1: there is exactly one way to choose nothing. Written
//    correctly in §4 below.
//
// ── ONE EXERCISE MOVED OUT ───────────────────────────────────
// Old Ex 47 ("eight people are divided into four pairs to play
// bridge", answered 2520) is genuinely ambiguous and has been held
// back for ch-counting-advanced, where it can be posed properly. If
// the four pairs are interchangeable the answer is 8!/(2^4 · 4!) =
// 105; the printed 2520 is 8!/2^4, which is the count when the pairs
// are assigned to four distinguishable tables. Worth stating which
// you mean in the question rather than in the solution.

= Counting

#only-theory[
  The tree chapter ended at a wall. Ten coin tosses give a tree with
  #num(1024) paths, and asking for the probability of exactly six
  heads means identifying every path with six heads on it. Each of
  those paths has the same probability, so the sum is really a
  multiplication — the only thing missing is a way to count the paths
  without drawing them.

  That is what this chapter supplies. It has exactly one idea in it,
  used over and over:

  #keybox(title: "The whole chapter")[
    Build the thing in stages and multiply. If that counts some
    arrangements more than once, work out *how many times* each was
    counted, and divide.
  ]

  Everything below is that sentence applied to a slightly different
  situation each time. There are formulas, and they are worth
  recognizing, but none of them is worth memorizing: each one is two
  lines of reasoning away from the sentence above.
]

#objectives(
  bfkm[count the outcomes of a process that happens in stages, by
    multiplying the number of choices at each stage],
  bfkm[use factorials to count arrangements, including when some of
    the objects are identical],
  bfkm[use binomial coefficients to count selections where the order
    does not matter],
  [decide, for a given problem, whether order matters and whether
    things may repeat — and reason from there rather than from a
    remembered formula],
  [explain why choosing $k$ things from $n$ and arranging $k$ yeses
    among $n$ answers are the same problem],
  [build Pascal's triangle, justify its rule, and connect it to the
    expansion of $(a + b)^n$],
)

== Counting in Stages

#only-theory[
  You are at Emile's restaurant. There are two starters, soup or
  juice; three main courses, meat, fish or vegetarian; and three
  desserts, ice cream, cake or tiramisu. How many different meals can
  you order?

  Draw the tree and count its paths: two branches, then three from
  each, then three from each of those. There is no need to finish the
  drawing to see the answer:
  $ 2 dot 3 dot 3 = 18. $
]

#keybox(title: "The product rule")[
  If a process is carried out in $r$ stages, with $n_1$ ways to do the
  first stage, $n_2$ ways to do the second, and so on, then the total
  number of ways to carry out the whole process is
  $ N = n_1 dot n_2 dot dots.c dot n_r. $
]

#warning[
  The product rule needs the *number* of choices at each stage to be
  the same no matter what was chosen earlier. The choices themselves
  may differ — that is fine.

  Choosing a main course does not change how many desserts there are,
  so the rule applies. But if ordering fish removed tiramisu from the
  menu, the second factor would depend on the first and multiplying
  would be wrong. When that happens, split into cases and add.
]

#only-theory[
  The commonest special case is worth naming separately. If every
  stage offers the same $n$ options — because whatever was chosen is
  put back, or because the stages do not interfere — then $k$ stages
  give
  $ underbrace(n dot n dot dots.c dot n, k "factors") = n^k. $
  This is the counting version of "with replacement", and it is why a
  four-digit PIN has $10^4 = #num(10000)$ possibilities.
]

#ex(difficulty: 1, time: "5 min")[
  IKEA sells an office chair in three sizes and four colors, with or
  without a movable head rest. How many different models are there?
][
  Three independent stages:
  $ 3 dot 4 dot 2 = 24 "models". $
  #heuristic("introduce notation")
]

#ex(difficulty: 2, time: "12 min")[
  A Swiss number plate has two letters followed by a four-digit
  number. The letter O is never used, because it is too easily
  confused with a zero, and the four-digit number may not begin with
  a zero.
  #auto-parts(
    1,
    [How many plates of this form exist?],
    [There are roughly $4.7$ million cars registered in Switzerland.
      Is that enough?],
  )
][
  #auto-parts(
    1,
    [Six stages. Each letter has $26 - 1 = 25$ options; the first
      digit has $9$; the other three have $10$ each:
      $ 25 dot 25 dot 9 dot 10 dot 10 dot 10 = #num(5625000). $],
    [Comfortably — about $5.6$ million plates for $4.7$ million cars.
      Not by an enormous margin, though, which is roughly why real
      Swiss plates carry a canton abbreviation as well: it multiplies
      the supply by another factor of $26$.],
  )
]

#ex(difficulty: 2, time: "10 min")[
  A braille cell has three rows and two columns of positions, and each
  position is either raised as a dot or left flat. A symbol must use
  at least one dot.
  #auto-parts(
    1,
    [How many different braille symbols are there?],
    [Braille was designed in the 1820s to be read by a fingertip.
      What does your answer suggest about why the cell is exactly
      this size?],
  )
][
  #auto-parts(
    1,
    [Six positions, each with two states, so $2^6 = 64$ patterns. One
      of those is the cell with no dots at all, which is excluded:
      $ 2^6 - 1 = 63 "symbols". $],
    [Sixty-three is comfortably more than the $26$ letters plus digits
      and punctuation, so the cell is big enough — while staying
      small enough to sit under one fingertip without moving it. A
      fourth row would give $2^8 - 1 = 255$ symbols and no way to
      read them at speed.],
  )
]

#ex(difficulty: 2, time: "12 min")[
  Consider the digits $2$, $3$, $5$, $6$, $7$ and $9$. Digits may be
  repeated.
  #auto-parts(
    1,
    [How many three-digit numbers can be built from them?],
    [How many of those are divisible by $5$?],
    [How many are greater than $653$?],
  )
][
  #auto-parts(
    1,
    [Three stages, six options each: $6^3 = 216$.],
    [A number is divisible by $5$ exactly when it ends in $0$ or $5$,
      and only $5$ is available. So the last stage has one option:
      $ 6 dot 6 dot 1 = 36. $],
    [Here the stages *do* interfere, so split into cases and add.

      If the first digit is $7$ or $9$, the number already exceeds
      $653$ whatever follows: $2 dot 6 dot 6 = 72$.

      If the first digit is $6$, look at the second. For $7$ or $9$
      anything follows: $2 dot 6 = 12$. For $6$, every $66 x$ beats
      $653$: $6$. For $5$, we need $65 x > 653$, so $x in {5, 6, 7,
      9}$: $4$. For $2$ or $3$ the number is too small: $0$.

      Together $72 + 12 + 6 + 4 = 94$.],
  )
]

== Arranging Everything

#only-theory[
  In how many orders can the letters R, E, D be written? Three choices
  for the first letter, then two for the second, then one:
  $3 dot 2 dot 1 = 6$. The product rule again, with the number of
  options shrinking by one at each stage.
]

#definition(title: "Factorial")[
  For a whole number $n >= 1$, the
  #vocab("factorial", "Fakultät") of $n$ is
  $ n! = n dot (n - 1) dot (n - 2) dot dots.c dot 2 dot 1, $
  and $0! = 1$.

  There are $n!$ ways to arrange $n$ distinguishable objects in a
  row.
]

#remark[
  Setting $0! = 1$ can look like a dodge, but it is forced. There is
  exactly one way to arrange no objects — do nothing — and every
  formula in this chapter needs the value $1$ there to keep working at
  its edges. It is a definition chosen so that nothing has to be said
  twice.
]

#example(title: "Shuffling a deck")[
  A deck has $52$ distinguishable cards, so the number of possible
  orders is
  $ 52! approx 8.07 dot 10^(67). $
  Suppose you could shuffle and record a new order every second.
  Getting through all of them would take
  $ 52!/(3600 dot 24 dot 365) approx 2.56 dot 10^(60) "years", $
  against a universe roughly $1.4 dot 10^(10)$ years old.

  So when you shuffle a deck properly, the order in front of you has
  almost certainly never occurred before in the history of the
  universe, and will never occur again.
]

#only-theory[
  Factorials grow faster than almost anything else you will meet.
  $10!$ is about three and a half million; $20!$ is about
  $2.4 dot 10^(18)$, which is more than the number of seconds since
  the Big Bang. This is worth knowing before you try to solve a
  counting problem by listing.
]

#ex(difficulty: 2, time: "12 min")[
  Simplify without a calculator.
  #auto-parts(
    3,
    [$12 dot 11!$],
    [$(n + 1) dot n!$],
    [$(n + 1)! - n!$],
    [$(n + 1)!/(n + 1)$],
    [$n!/(n - 2)!$],
    [$(2n + 1)!/(10n dot (2n + 1))$],
  )
][
  Everything here comes from reading $n! = n dot (n-1)!$ in whichever
  direction is convenient.
  #auto-parts(
    2,
    [$12 dot 11! = 12!$.],
    [$(n + 1) dot n! = (n + 1)!$.],
    [Factor out $n!$:
      $ (n + 1)! - n! = (n + 1) dot n! - n! = n dot n!. $],
    [$(n + 1)! = (n + 1) dot n!$, so dividing gives $n!$.],
    [Cancel everything below $n - 1$:
      $ n!/(n - 2)! = (n dot (n-1) dot (n-2)!)/(n-2)!
        = n dot (n - 1). $],
    [Cancel the $(2n + 1)$ first:
      $ (2n+1)!/(10 n dot (2n+1)) = (2n)!/(10 n)
        = (2n dot (2n - 1)!)/(10 n) = (2n-1)!/5. $],
  )
]

== Arranging When Things Repeat

#only-theory[
  How many arrangements does the word OTTO have? Four letters suggests
  $4! = 24$, but writing them all out gives only six:
  $ "OTTO", quad "OTOT", quad "OOTT", quad "TTOO", quad "TOTO",
    quad "TOOT". $
  The count is too big by a factor of four, and it is worth seeing
  exactly where the four comes from.
]

#example(title: "Where the over-counting comes from")[
  Take four objects $a_1$, $a_2$, $a_3$ and $b$. They are all
  distinguishable, so there are $4! = 24$ arrangements. Now rub out
  the little indices, so the three $a$'s become identical. The
  arrangement
  $ b space a_1 space a_2 space a_3 $
  becomes $b space a space a space a$ — but so do
  $b space a_1 space a_3 space a_2$, $b space a_2 space a_1 space
  a_3$, and three more. The three $a$'s can be permuted among
  themselves in $3! = 6$ ways without changing what you see. The
  indices were never part of the problem; they were put there purely
  so the over-counting could be seen. #heuristic("introduce notation")

  So the $24$ labelled arrangements collapse into groups of $6$, and
  the number of genuinely different arrangements is
  $ 4!/3! = 24/6 = 4. $
]

#keybox(title: "Arrangements with repeated objects")[
  If $n$ objects include $n_1$ of one kind, $n_2$ of a second kind,
  and so on up to $n_k$ of the last kind, the number of
  distinguishable arrangements is
  $ n!/(n_1! dot n_2! dot dots.c dot n_k!). $

  The numerator counts every arrangement as though all $n$ objects
  were different. Each denominator undoes the over-counting caused by
  one group of identical objects.
]

#example[
  OTTO has two O's and two T's, so $4!/(2! dot 2!) = 24/4 = 6$, which
  matches the list.

  MISSISSIPPI has $11$ letters: four I's, four S's, two P's and one M.
  $ 11!/(4! dot 4! dot 2!) = #num(39916800)/#num(1152) = #num(34650). $
]

#only-theory[
  The move in that box is the one to hold on to, because it is the
  only genuinely new technique in the chapter and it returns twice
  more before the end: *count as if everything were distinguishable,
  then divide by the number of times each real object got counted.*
]

#ex(difficulty: 2, time: "10 min")[
  How many distinguishable arrangements are there of the letters of
  #auto-parts(
    3,
    [TOOTHPASTE,],
    [MATHEMATICS,],
    [COCACOLA?],
  )
][
  #auto-parts(
    1,
    [Ten letters, with three T's and two O's:
      $ 10!/(3! dot 2!) = #num(3628800)/12 = #num(302400). $],
    [Eleven letters, with two M's, two A's and two T's:
      $ 11!/(2! dot 2! dot 2!) = #num(39916800)/8 = #num(4989600). $],
    [Eight letters, with three C's, two O's and two A's:
      $ 8!/(3! dot 2! dot 2!) = #num(40320)/24 = #num(1680). $],
  )
]

#ex(difficulty: 3, time: "12 min", hints: (
  "Start by pretending the seats are numbered, and count the arrangements that way.",
  "Now take one seating and rotate everybody one seat to the left. Is that a different arrangement, according to the question?",
  "How many seatings does each genuinely different arrangement get counted as?",
))[
  Five people are seated around a circular table. Two seatings count
  as different only if somebody has a different neighbor — rotating
  everyone around the table does not produce a new seating. How many
  different seatings are there?
][
  Number the seats and there are $5! = 120$ arrangements. But rotating
  a seating by one, two, three or four places produces an arrangement
  that the question says is the same one, so every genuinely different
  seating has been counted $5$ times:
  $ 5!/5 = 120/5 = 24. $

  Equivalently, and more memorably: seat the first person anywhere at
  all — since only relative positions matter, where they sit carries
  no information — and then arrange the remaining four around them in
  $4! = 24$ ways. #heuristic("look for what stays the same")
]

== Choosing Some of Them

#only-theory[
  Six cards carry the numbers $2$, $3$, $4$, $5$, $7$, $9$. How many
  three-digit numbers can be laid out with them?

  Each card can be used once, so the stages shrink as before, but they
  stop after three:
  $ 6 dot 5 dot 4 = 120. $
  It is often convenient to write that product using factorials, by
  supplying the missing tail and cancelling it again:
  $ 6 dot 5 dot 4 = (6 dot 5 dot 4 dot 3 dot 2 dot 1)/(3 dot 2 dot 1)
    = 6!/3!. $
  That is notation, not a new idea. If $6 dot 5 dot 4$ is clearer,
  write $6 dot 5 dot 4$.
]

#only-theory[
  Now change one word in the question. A lottery draws six numbered
  balls from $42$, and a ticket wins if it carries the same six
  numbers — *in any order*. Counting in stages gives
  $42 dot 41 dot 40 dot 39 dot 38 dot 37$, but that counts every set
  of six numbers many times over, once for each order in which it
  could have been drawn.

  How many times? Six numbers can be drawn in $6!$ orders. So divide.
]

#definition(title: "Binomial Coefficient")[
  The number of ways to choose $k$ objects out of $n$, when the order
  of choosing does not matter, is the
  #vocab("binomial coefficient", "Binomialkoeffizient")
  $ binom(n, k) = n!/(k! dot (n - k)!), $
  read "$n$ choose $k$".

  The numerator and the $(n-k)!$ together count the ordered
  selections; the $k!$ divides out the orderings we agreed not to
  distinguish.
]

#example[
  The lottery draws $6$ from $42$:
  $ binom(42, 6) = (42 dot 41 dot 40 dot 39 dot 38 dot 37)/6!
    = #num(5245786). $
  One ticket in a little over five million.
]

#keybox(title: "Values worth recognizing")[
  $ binom(n, 0) = 1, quad binom(n, n) = 1, quad binom(n, 1) = n,
    quad binom(n, n - 1) = n. $
  And $binom(n, k) = 0$ whenever $k > n$ — you cannot choose more
  things than there are.
]

#remark[
  $binom(n, 0) = 1$ trips people up. It is not "no ways"; it is *one*
  way, namely to take nothing at all. The formula agrees:
  $n!/(0! dot n!) = 1$, which is exactly what $0! = 1$ was for.
]

#ex(difficulty: 1, time: "10 min")[
  Evaluate without a calculator.
  #auto-parts(
    4,
    [$binom(5, 3)$],
    [$binom(7, 5)$],
    [$binom(35, 34)$],
    [$binom(1001, 999)$],
  )
][
  Cancel before multiplying — the factorials are enormous and almost
  all of them go away.
  #auto-parts(
    2,
    [$(5 dot 4 dot 3)/(3 dot 2 dot 1) = 10$.],
    [$(7 dot 6)/(2 dot 1) = 21$, choosing the two left out rather than
      the five taken.],
    [$binom(35, 34) = 35$: choosing $34$ of $35$ means choosing which
      single one to leave out.],
    [Same trick: leaving out two of $1001$, so
      $ (1001 dot 1000)/2 = #num(500500). $],
  )
]

== The Same Problem Twice

#only-theory[
  Look at the two formulas from the last two sections side by side.
  Arranging $n$ objects of which $k$ are of one kind and $n - k$ of
  another gives
  $ n!/(k! dot (n-k)!), $
  and choosing $k$ objects from $n$ gives the same thing. That is not
  a coincidence, and noticing why is the most useful thing in this
  chapter.
]

#keybox(title: "Choosing is arranging yeses")[
  Choosing $k$ objects out of $n$ is the same as going down a list of
  $n$ objects and writing *yes* against $k$ of them and *no* against
  the other $n - k$.

  So $binom(n, k)$ counts two things at once: the selections of size
  $k$, and the arrangements of $k$ Y's and $n-k$ N's in a row.
]

#example(title: "Symmetry, for free")[
  Choosing which $8$ students out of $24$ go on a trip is the same as
  choosing which $16$ stay behind — each decision determines the
  other. So without computing anything,
  $ binom(24, 8) = binom(24, 16) quad (= #num(735471)). $
  In general
  $ binom(n, k) = binom(n, n - k), $
  because swapping every yes for a no turns one arrangement into
  exactly one of the other kind.
]

#only-theory[
  This also answers the question the tree chapter left hanging. Toss a
  coin ten times: the paths through the tree are exactly the
  arrangements of ten H's and T's, and those with six heads are the
  arrangements of six H's and four T's. There are
  $ binom(10, 6) = 210 $
  of them, and each has probability $(1 slash 2)^(10)$. No tree
  required.
]

#look-ahead(preview: [the binomial distribution])[
  That calculation — count the paths with $binom(n, k)$, multiply by
  the probability of one path — is the whole of the binomial
  distribution, which you meet next year. You now have both halves of
  it; all that is missing is the name.
]

#ex(difficulty: 2, time: "12 min")[
  #auto-parts(
    1,
    [Ten players enter a chess tournament and each plays every other
      player exactly once. How many games are played?],
    [Sixteen planes lie in space, no two of them parallel. What is the
      largest possible number of lines of intersection?],
    [A class elects two delegates, and there turn out to be $253$
      possible pairs. How many students are in the class?],
  )
][
  All three ask for the number of unordered pairs from a set, which is
  $binom(n, 2) = (n dot (n-1))/2$.
  #auto-parts(
    1,
    [$binom(10, 2) = (10 dot 9)/2 = 45$ games. A game is a pair of
      players, and A-versus-B is the same game as B-versus-A.],
    [Two non-parallel planes meet in exactly one line, so the most
      that can happen is one line per pair:
      $binom(16, 2) = (16 dot 15)/2 = 120$.],
    [Solve $binom(n, 2) = 253$:
      $ (n dot (n-1))/2 = 253 arrow.r.double n^2 - n - 506 = 0
        arrow.r.double n = (1 + sqrt(#num(2025)))/2 = (1 + 45)/2
        = 23. $
      The negative root is discarded, and the class has $23$
      students.],
  )
]

#ex(difficulty: 2, time: "12 min")[
  A chamber choir has $9$ men and $4$ women. A quartet is to sing at a
  soiree. In how many ways can it be chosen if
  #auto-parts(
    1,
    [anyone may be picked,],
    [at least one woman must be in the quartet,],
    [exactly one woman must be in the quartet?],
  )
][
  #auto-parts(
    1,
    [$binom(13, 4) = 715$.],
    ["At least one" calls for the complement — count the quartets with
      *no* woman and subtract:
      $ 715 - binom(9, 4) = 715 - 126 = 589. $],
    [Two independent choices, so multiply: pick the one woman from
      four, then the three men from nine:
      $ binom(4, 1) dot binom(9, 3) = 4 dot 84 = 336. $],
  )
]

#ex(difficulty: 3, time: "12 min")[
  Six students — three boys and three girls — line up in a random
  order for a photograph. What is the probability that boys and girls
  alternate?
][
  All $6! = 720$ orders are equally likely, so this is a counting
  problem wearing a probability hat.

  An alternating line must follow one of exactly two patterns, BGBGBG
  or GBGBGB. Within either, the three boys can be arranged in $3!$
  ways and the girls in $3!$ ways, so the number of alternating
  line-ups is
  $ 2 dot 3! dot 3! = 2 dot 6 dot 6 = 72, $
  and
  $ p("alternating") = 72/720 = 1/10. $
]

== Pascal's Triangle

#only-theory[
  Write the binomial coefficients in rows, one row for each $n$,
  taking $k = 0, 1, dots, n$ along each row:
]

#block(width: 100%)[
  #set align(center)
  $1$ \
  $1 quad 1$ \
  $1 quad 2 quad 1$ \
  $1 quad 3 quad 3 quad 1$ \
  $1 quad 4 quad 6 quad 4 quad 1$ \
  $1 quad 5 quad 10 quad 10 quad 5 quad 1$ \
  $1 quad 6 quad 15 quad 20 quad 15 quad 6 quad 1$
]

#only-theory[
  Every entry is the sum of the two above it. That is not a curiosity
  of the arithmetic; it says something about choosing.
]

#keybox(title: "Pascal's rule")[
  $ binom(n, k) = binom(n - 1, k - 1) + binom(n - 1, k). $
]

#only-theory[
  Here is why, with no algebra. You are choosing $k$ students from a
  class of $n$. Fix your attention on one particular student — call
  her Anna. Every possible committee either contains Anna or does not,
  and never both, so count the two cases separately and add:

  #auto-parts(
    1,
    [Committees *with* Anna: she is in, so the remaining $k - 1$
      places are filled from the other $n - 1$ students, giving
      $binom(n-1, k-1)$.],
    [Committees *without* Anna: all $k$ places are filled from the
      other $n - 1$ students, giving $binom(n-1, k)$.],
  )

  Add them and you have Pascal's rule. The triangle is not a table to
  be looked up — it is this argument, applied over and over.
]

#example(title: "Where the rows come from")[
  Row $n$ of the triangle adds up to $2^n$:
  $ 1 + 4 + 6 + 4 + 1 = 16 = 2^4. $
  Sorting all the subsets of a set of $n$ elements by their size gives
  $binom(n, 0)$ of size $0$, $binom(n, 1)$ of size $1$, and so on — so
  the row total counts *all* the subsets. Which is $2^n$, as the power
  set section of the sample-space chapter found by a completely
  different argument.
]

#only-theory[
  The triangle's other name comes from algebra. Multiply out
  $(a + b)^n$ and the coefficients are exactly row $n$:
  $ (a+b)^2 &= a^2 + 2a b + b^2 \
    (a+b)^3 &= a^3 + 3a^2 b + 3a b^2 + b^3 \
    (a+b)^4 &= a^4 + 4a^3 b + 6a^2 b^2 + 4a b^3 + b^4 $

  The reason is the one from the last section. Expanding
  $(a+b)^4$ means multiplying out
  $ (a+b)(a+b)(a+b)(a+b), $
  and each term of the answer comes from choosing either $a$ or $b$
  from each of the four brackets. A term $a^2 b^2$ arises exactly when
  you choose $b$ from two of the four brackets — and there are
  $binom(4, 2) = 6$ ways to do that. The coefficient counts the
  choices.
]

#keybox(title: "The binomial theorem")[
  $ (a + b)^n = sum_(k=0)^n binom(n, k) a^(n-k) b^k. $
  The name *binomial coefficient* comes from here.
]

#ex(difficulty: 2, time: "12 min")[
  #auto-parts(
    1,
    [Write out rows $7$ and $8$ of Pascal's triangle.],
    [Use row $5$ to expand $(a + b)^5$.],
    [Use row $5$ again to expand $(2x - 1)^5$.],
    [Without expanding anything, find the sum of the coefficients of
      $(a+b)^(20)$.],
  )
][
  #auto-parts(
    1,
    [Each entry is the sum of the two above it:
      $ &1 quad 7 quad 21 quad 35 quad 35 quad 21 quad 7 quad 1 \
        &1 quad 8 quad 28 quad 56 quad 70 quad 56 quad 28 quad
        8 quad 1 $],
    [$ (a+b)^5 = a^5 + 5a^4 b + 10a^3 b^2 + 10a^2 b^3 + 5a b^4
       + b^5. $],
    [Take $a = 2x$ and $b = -1$ in the same expansion. Every odd power
      of $b$ contributes a minus sign, and each $a^j$ brings a factor
      $2^j$:
      $ (2x - 1)^5 = 32x^5 - 80x^4 + 80x^3 - 40x^2 + 10x - 1. $],
    [Setting $a = b = 1$ turns the binomial theorem into a sum of the
      coefficients, and the left-hand side into $2^(20)$:
      $ sum_(k=0)^(20) binom(20, k) = 2^(20) = #num(1048576). $
      Which is the row-sum result from the example above, arrived at
      from the algebra side instead.],
  )
]

== Techniques You Know So Far

#known-techniques(
  title: "Ways to count",
  [Count in stages and multiply — the product rule. If every stage
    offers the same $n$ choices, $k$ stages give $n^k$],
  [Arrange everything: $n!$],
  [Arrange when some objects are identical: divide out each repeated
    group, $n! slash (n_1! dot dots.c dot n_k!)$],
  [Choose an ordered selection: $n dot (n-1) dot dots.c$, stopping
    after $k$ factors],
  [Choose an unordered selection: divide the ordered count by $k!$,
    giving $binom(n, k)$],
  [When "at least one" appears, count the complement instead],
)

#only-theory[
  Notice that the list has one entry that is not a formula. Every
  formula on it was built the same way — count in stages, then divide
  out whatever got counted twice — and if you ever cannot remember
  which one applies, rebuilding it from that sentence is faster than
  guessing.

  The two questions that decide which situation you are in are always
  the same:

  #keybox(title: "The two questions")[
    + Does the order of the choices matter?
    + May the same thing be chosen more than once?
  ]

  Three of the four combinations have appeared in this chapter. The
  fourth — where order does not matter but repeats are allowed — is
  the one genuinely awkward case, and it is dealt with separately.
]

#ai-box(role: "Checker")[
  Counting problems are unusually good for testing an assistant,
  because the answers are single integers that you can verify by a
  completely different route.

  Take the braille exercise from §1 and give it to an AI assistant
  word for word. The answer $64$ is far more common on the internet
  than the correct $63$ — your own source notes had it wrong — so
  there is a real chance the assistant reproduces the mistake.

  Whatever it answers, do not argue. Ask one question instead: _how
  many braille symbols use no dots at all?_ Then ask it to check its
  first answer against that. Getting a model to test its own claim
  against a consequence of that claim is far more reliable than
  telling it that it is wrong, which usually just produces an apology
  and a different wrong answer.
]

#look-ahead(preview: [counting and probability together])[
  Everything in this chapter counted. Nothing in it computed a
  probability, apart from the photograph line-up — which needed only
  the oldest rule in the unit, favorable over possible, with counting
  doing the work at both ends.

  That is what the next chapter is for: the lottery, hands of cards,
  urns drawn from without replacement, and the question that started
  the whole unit off, which is what your chances actually are.
]

#print-hints()
#print-vocab()
