#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Counting Strategies")
#let ex = exercise.with(chapter: "Counting Strategies")

// ── SPF-ONLY CHAPTER ─────────────────────────────────────────
// Registered in main-high.typ and deliberately absent from
// main-basic.typ. It carries SPF 3.2's "entscheiden, welche
// Abzählstrategie zielführend ist" together with selection with
// repetition, neither of which appears in GLF's Lehrplan.
//
// Because the whole chapter is high-only, nothing inside needs
// level: "high" or only-high[...] gating. If you ever move a section
// of it down into ch-counting, the gating has to be added there.

// ── TEACHER'S NOTE: an incomplete answer in the LaTeX source ─
// The chess-tournament exercise (old Ex 81) is answered "2 players
// joined late and 9 were registered". That is a solution, but it is
// not the only one: 19 registered with 1 joining late also produces
// exactly 19 extra games. Writing k for the latecomers and n for the
// registered players, the condition factors as
//     k · (2n + k − 1) = 38,
// and 38 = 2 · 19 = 1 · 38 gives the two admissible cases. The
// version below asks for all solutions, which makes it a better
// exercise than the original.
//
// Old Ex 47 (bridge pairs), held back from ch-counting for being
// ambiguous, is posed properly here with both readings.

= Counting Strategies

#only-theory[
  The last chapter built its formulas out of one repeated move and
  then listed them. This one is about the harder question, which the
  Lehrplan puts plainly: deciding *which* strategy will get you there.

  There is also one situation the last chapter deliberately left open.
  Recall the two questions that classify a counting problem — does
  order matter, and may things repeat. Three of the four combinations
  have been dealt with. The fourth is genuinely awkward, and it comes
  first.
]

#objectives(
  [count selections where order does not matter and repeats are
    allowed, by translating the problem into an arrangement of dots
    and bars],
  bfkm[decide which counting strategy fits a given problem, and
    justify the choice],
  [use complementary counting, case-splitting, and
    count-then-divide as deliberate strategies rather than as
    remembered tricks],
  [recognize a problem that has been disguised — a route through a
    grid, a handshake, a diagonal — as one of the standard four],
  [read the continental names for these counts (Permutation,
    Variation, Kombination) without being confused by them],
)

== Repeats Without Order

#only-theory[
  A machine dispenses balls in four colors. Put in a coin and it gives
  you a ball of a color you cannot choose. You buy two. How many
  different color combinations could you end up with?

  Order plainly does not matter — you have two balls in your hand, not
  a sequence — and repeats are plainly allowed, since both could come
  out red. Neither $binom(4, 2) = 6$ nor $4^2 = 16$ is the answer, and
  listing gives $10$. The problem is that no formula so far produces
  a $10$, so we need a way of seeing this situation differently.
  #heuristic("solve a simpler version first")
]

#example(title: "Dots and bars")[
  What you buy is completely described by *how many of each color* you
  received. So record a purchase by writing a dot for each ball and
  separating the colors with bars. With four colors, three bars are
  needed to make four compartments:

  #block(width: 100%)[
    #set align(center)
    $bullet bullet space bar.v space space bar.v space space bar.v
      space$ #h(1.2em) two red \
    $bullet space bar.v space bullet space bar.v space space bar.v
      space$ #h(1.2em) one red, one blue \
    $space bar.v space space bar.v space bullet space bar.v space
      bullet$ #h(1.2em) one yellow, one green
  ]

  Every purchase is one such picture, and every such picture is one
  purchase. So counting purchases is the same as counting these
  arrangements — and an arrangement is just $2$ dots and $3$ bars in
  a row, which is a problem from the last chapter.

  There are $2 + 3 = 5$ positions, and choosing which $2$ hold dots
  settles everything:
  $ binom(5, 2) = 10. $
]

#keybox(title: "Selection with repetition, without order")[
  Choosing $k$ objects from $n$ available types, where the same type
  may be chosen repeatedly and the order of choosing does not matter,
  can be done in
  $ binom(n + k - 1, k) $
  ways.

  The count is $k$ dots and $n - 1$ bars arranged in a row: $n - 1$
  bars are what it takes to divide a row into $n$ compartments.
]

#remark[
  This is the one result in the unit worth committing to memory rather
  than rebuilding, because rebuilding it means reinventing the
  dots-and-bars translation, which is not something that occurs to
  anyone twice.

  What *is* worth being able to do on demand is recognizing the
  situation. The signal is always the same: you are being asked how
  many of each kind, not which ones or in what order.
]

#warning[
  Note which letter is which, because they are easy to swap. In
  $binom(n + k - 1, k)$, the letter $n$ counts the *types available*
  and $k$ counts the *objects taken* — and unlike every other formula
  in the last chapter, here $k$ may perfectly well be larger than $n$.
  Buying twelve donuts from four flavors is $n = 4$, $k = 12$.
]

#ex(difficulty: 2, time: "10 min")[
  A grocery store advertises: mango, passion fruit, pineapple, kaki —
  choose any $12$ fruits for CHF $6$. In how many different ways can a
  bag be filled?
][
  What matters is how many of each of the four kinds go in, not the
  order they are picked up, and the same fruit may be taken many
  times. So $n = 4$ types and $k = 12$ fruits:
  $ binom(4 + 12 - 1, 12) = binom(15, 12) = binom(15, 3)
    = (15 dot 14 dot 13)/6 = 455. $
  In the dots-and-bars picture, $12$ dots and $3$ bars in a row of
  $15$ positions.
]

#ex(difficulty: 3, time: "15 min", hints: (
  "Which is playing the part of the 'types', the oranges or the bowls?",
  "For part 2, the constraint is that no compartment may be empty. Can you make it true before you start counting, rather than checking it afterwards?",
  "Put one orange in each bowl first. What problem is left?",
))[
  Six identical oranges are placed in three bowls
  #auto-parts(
    1,
    [with no restrictions,],
    [so that no bowl is left empty.],
  )
  How many different arrangements are there in each case?
][
  The oranges are identical, so an arrangement is nothing more than
  how many land in each bowl. The bowls are the *types* — there are
  $n = 3$ of them — and the oranges are what gets distributed,
  $k = 6$.
  #auto-parts(
    1,
    [$ binom(3 + 6 - 1, 6) = binom(8, 6) = binom(8, 2)
       = (8 dot 7)/2 = 28. $
      Six dots and two bars: the bars are the walls between bowls.],
    [Rather than counting all $28$ and subtracting the bad ones,
      make the condition true in advance. Put one orange in each bowl
      — there is only one way to do that, since the oranges are
      identical — and distribute the remaining three freely:
      $ binom(3 + 3 - 1, 3) = binom(5, 3) = 10. $
      Building the constraint into the setup is almost always less
      work than filtering for it afterwards.],
  )
]

== All Four Cases Together

#only-theory[
  Every counting problem in this unit is settled by two questions, and
  the answers place it in one of four boxes.
]

#keybox(title: "The two questions")[
  + Does the order of the choices matter?
  + May the same thing be chosen more than once?
]

#data-table(
  columns: (auto, auto, auto),
  row-height: auto,
  [choosing $k$ from $n$], [*order matters*], [*order does not*],
  [*no repeats*], [$n!/(n-k)!$], [$binom(n, k)$],
  [*repeats allowed*], [$n^k$], [$binom(n + k - 1, k)$],
)

#only-theory[
  A fifth situation sits outside the table because it is not a
  selection at all: arranging all $n$ objects, which gives $n!$, or
  $n! slash (n_1! dot dots.c dot n_k!)$ when some of them are
  identical. It is the $k = n$ corner of the top-left box, and it is
  worth keeping in mind separately because so many problems are
  phrased as arrangements rather than as choices.

  The table is a summary, not a method. Reading a problem and knowing
  which box it belongs in is the skill; the formula in the box is the
  easy part, and three of the four can be rebuilt in a line if you
  forget them.
]

#remark[
  *A note on names.* Continental textbooks — and any German-language
  material you consult — give these counts names, and you should be
  able to read them even though this course does not use them:

  / Permutation: an arrangement of all $n$ objects. Same word in
    English.

  / Variation: an ordered selection of $k$ out of $n$ — the top-left
    box. English has no single word for this; it is called a
    _$k$-permutation_, or "permutations of $n$ taken $k$ at a time".

  / Kombination: an unordered selection of $k$ out of $n$ — the
    top-right box. In English, a _combination_.

  Each comes in an _ohne Wiederholung_ (without repetition) and a _mit
  Wiederholung_ (with repetition) flavor, which is the second row of
  the table.

  Everything you will be assessed on is in English, so these names are
  for reading, not for reciting. And a warning worth having: in
  ordinary English, "combination" is used loosely — a bicycle
  combination lock is not a combination at all, since the order of the
  digits certainly matters.
]

== Choosing a Strategy

#only-theory[
  Four strategies do most of the work. None of them is a formula; each
  is a way of turning a problem you cannot count into one you can.
]

#keybox(title: "Four moves")[
  / Count the complement: When the condition says "at least one" or
    excludes only a little, count what you do not want and subtract
    from the total.

  / Split into cases: When the number of choices at one stage depends
    on an earlier choice, the product rule fails. Break the problem
    into cases where it works again, and add.

  / Count with labels, then divide: When things that should be
    identical have been distinguished, count as though they were all
    different and divide by how many times each real object was
    counted.

  / Translate: When none of the above helps, look for a different
    description of the same objects — a route as a sequence of moves,
    a purchase as dots and bars, a committee as a row of yeses.
]

#only-theory[
  The fourth is the hardest to teach and the most useful. Dots and
  bars was one instance. Here is another, and it is worth working
  through slowly.
]

#example(title: "A route as a word")[
  Batman lives at the bottom-left corner of a grid of streets $14$
  blocks wide and $8$ blocks tall, and works at the top-right corner.
  Going home he only ever moves left or down. How many routes are
  there?

  Drawing them is out of the question. But describe a route by writing
  down the moves in order, using L for left and D for down. Every
  route becomes a word — and since home is $14$ blocks left and $8$
  blocks down, every such word has exactly $14$ L's and $8$ D's, in
  some order.

  Conversely every arrangement of $14$ L's and $8$ D's describes
  exactly one route. So counting routes is counting arrangements of a
  word with repeated letters, and that is last chapter's work:
  $ binom(22, 8) = #num(319770). $

  The grid never appears in the calculation. It was translated away.
]

#ex(difficulty: 3, time: "20 min", hints: (
  "Describe a route as a word in L's and D's, as in the example.",
  "For a route that must pass through B, split the journey at B and use the product rule on the two halves.",
  "In part 3, the coin decides each letter of the word independently. Which words does he need, and how likely is any one word?",
))[
  On the same grid, Batman's home is at $A$ (bottom left) and Wayne
  Industries at $C$ (top right). A bar at $B$ sits $6$ blocks left of
  $C$ and $6$ blocks below it.
  #auto-parts(
    1,
    [How many routes lead from $C$ to $A$, moving only left or down?],
    [How many of those pass through $B$?],
    [One evening Batman flips a fair coin at every intersection:
      heads he goes down, tails he goes left. What is the probability
      that he passes the bar? (Assume that on reaching an edge of the
      grid he simply follows it home.)],
    [The next evening he rolls a die instead: $1$ to $4$ means left,
      $5$ or $6$ means down. Now what is the probability he passes
      the bar?],
  )
][
  #auto-parts(
    1,
    [The whole journey is $14$ blocks left and $8$ down, so a route is
      an arrangement of $14$ L's and $8$ D's:
      $ binom(22, 8) = #num(319770). $],
    [Split at $B$. From $C$ to $B$ is $6$ left and $6$ down, a word of
      length $12$; from $B$ to $A$ is the remaining $8$ left and $2$
      down, a word of length $10$. Each route from $C$ to $A$ through
      $B$ is one of the first paired with one of the second, so
      multiply:
      $ binom(12, 6) dot binom(10, 2) = 924 dot 45 = #num(41580). $],
    [Reaching $B$ means the first $12$ flips produce exactly $6$
      heads and $6$ tails, in any order. Each specific sequence of
      $12$ flips has probability $(1 slash 2)^(12)$, and
      $binom(12, 6) = 924$ of them work:
      $ p = 924/#num(4096) = 231/#num(1024) approx 0.226. $
      The edge rule changes nothing here: reaching the bottom edge
      would need $8$ downs, which cannot happen within $12$ flips that
      contain only $6$.],
    [Identical reasoning with an unfair "coin":
      $p("left") = 4/6 = 2/3$ and $p("down") = 1/3$. Each particular
      word with $6$ of each has probability
      $(2 slash 3)^6 dot (1 slash 3)^6$, and there are still $924$ of
      them:
      $ p = binom(12, 6) dot (2/3)^6 dot (1/3)^6
        = #num(19712)/#num(177147) approx 0.111. $
      Favoring left makes him roughly half as likely to arrive at a
      bar that requires equal numbers of both.],
  )
]

#ex(difficulty: 2, time: "12 min")[
  #auto-parts(
    1,
    [How many diagonals does a polygon with $40$ sides have?],
    [A polygon has $324$ diagonals. How many corners does it have?],
  )
][
  #auto-parts(
    1,
    [Every pair of corners determines a line segment, and the ones
      that are *not* diagonals are exactly the $40$ sides. So count
      the pairs and subtract:
      $ binom(40, 2) - 40 = 780 - 40 = 740. $
      Counting the complement, applied to the thing you do not want
      rather than the thing you do.],
    [In general a polygon with $n$ corners has
      $ binom(n, 2) - n = (n dot (n-1))/2 - n = (n dot (n - 3))/2 $
      diagonals. Setting that equal to $324$:
      $ n^2 - 3n - 648 = 0 arrow.r.double
        n = (3 + sqrt(9 + 2592))/2 = (3 + 51)/2 = 27. $],
  )
]

#ex(difficulty: 3, time: "15 min")[
  At a chess tournament every contestant plays every other contestant
  exactly once. Just before the start, some extra players joined, and
  as a result $19$ more games had to be played than originally
  planned.

  How many players were registered, and how many joined late? Find
  *all* the possibilities.
][
  With $n$ registered players and $k$ latecomers, the number of extra
  games is
  $ binom(n + k, 2) - binom(n, 2) = 19. $
  Multiplying by $2$ and expanding,
  $ (n+k)(n+k-1) - n(n-1) = 38, $
  and after cancelling, the left-hand side factors:
  $ k dot (2n + k - 1) = 38. $

  Now $38 = 2 dot 19$, and both factors must be positive whole
  numbers, so only a few splittings are possible. Note also that
  $2n + k - 1$ is much the larger factor for any sensible $n$:

  #auto-parts(
    1,
    [$k = 1$ and $2n + k - 1 = 38$, giving $2n = 38$ and $n = 19$.],
    [$k = 2$ and $2n + k - 1 = 19$, giving $2n = 18$ and $n = 9$.],
  )

  The remaining splittings, $k = 19$ and $k = 38$, force $n$ negative.

  So there are exactly two answers: $19$ registered players with $1$
  latecomer, or $9$ registered with $2$. Checking both,
  $binom(20,2) - binom(19,2) = 190 - 171 = 19$ and
  $binom(11,2) - binom(9,2) = 55 - 36 = 19$.

  A question that looks as though it has one answer often does not,
  and the only way to find out is to solve it properly rather than to
  stop at the first solution that works.
]

#ex(difficulty: 3, time: "12 min")[
  Eight people are to be divided into four pairs.
  #auto-parts(
    1,
    [In how many ways, if the four pairs are simply four pairs?],
    [In how many ways, if the pairs are to be seated at four
      distinguishable tables?],
    [Which of the two would you say the phrase "divided into four
      pairs to play bridge" is asking for? Say what makes it
      ambiguous.],
  )
][
  #auto-parts(
    1,
    [Count with labels and divide, twice over. Line all eight people
      up — $8!$ ways — and read the line as four consecutive pairs.
      Each set of four pairs has been counted many times: the two
      people within a pair can be swapped, in $2^4$ ways, and the four
      pairs themselves can be listed in any of $4!$ orders. So
      $ 8!/(2^4 dot 4!) = #num(40320)/(16 dot 24) = 105. $],
    [Now the order of the pairs *does* matter, since the tables are
      different, so only the within-pair swaps are over-counting:
      $ 8!/2^4 = #num(40320)/16 = #num(2520). $],
    [Either, which is precisely the problem. "Four pairs" suggests
      that the pairs are interchangeable, giving $105$; but bridge is
      played at a table, and if the question intends four specific
      tables then $#num(2520)$ is right. A counting question has to
      say whether the groups are distinguishable — it is not a detail,
      it is a factor of $24$.],
  )
]

#ex(difficulty: 2, time: "12 min")[
  Seven seats are free in one row of a cinema. In how many ways can
  #auto-parts(
    1,
    [seven people be seated,],
    [four people be seated,],
    [three friends be seated together, with the remaining four seats
      left empty?],
  )
][
  #auto-parts(
    1,
    [$7! = #num(5040)$.],
    [An ordered selection of four seats out of seven:
      $ 7 dot 6 dot 5 dot 4 = 840. $
      Equivalently $7! slash 3!$.],
    [Two stages. First, where does the block of three consecutive
      seats begin? It can start at seat $1, 2, 3, 4$ or $5$ — five
      positions. Then the three friends arrange themselves within the
      block in $3! = 6$ ways:
      $ 5 dot 6 = 30. $
      Treating a group that must stay together as a single object is
      worth remembering; it turns a constraint into a stage.],
  )
]

#ex(difficulty: 3, time: "15 min")[
  Consider four-digit numbers — that is, whole numbers from $#num(1000)$
  to $#num(9999)$.
  #auto-parts(
    2,
    [How many are there?],
    [How many have four different digits?],
    [How many contain the digit zero exactly once?],
    [How many begin and end with a $4$?],
  )
][
  The only awkwardness throughout is that the first digit cannot be
  zero.
  #auto-parts(
    1,
    [$9 dot 10 dot 10 dot 10 = #num(9000)$ — or simply
      $#num(9999) - #num(1000) + 1$.],
    [Nine choices for the first digit; then nine remain for the second
      (zero is back in play, but the first digit is gone), eight for
      the third and seven for the last:
      $ 9 dot 9 dot 8 dot 7 = #num(4536). $],
    [The zero cannot be first, so choose its position among the other
      three: $3$ ways. The first digit is then one of $9$ non-zero
      digits, and the two remaining positions each take one of the $9$
      non-zero digits as well:
      $ 3 dot 9 dot 9 dot 9 = #num(2187). $],
    [The first and last digits are fixed, and the middle two are
      free: $10 dot 10 = 100$.],
  )
]

#ex(difficulty: 3, time: "10 min")[
  In the Swiss card game _Schieber_, all $36$ cards are dealt out
  equally among four players. How many different deals are there?
][
  Each player receives $9$ cards. Deal them by choosing the first
  player's hand, then the second's from what is left, and so on:
  $ binom(36, 9) dot binom(27, 9) dot binom(18, 9) dot binom(9, 9). $
  Writing each binomial coefficient out and cancelling gives the
  tidier form
  $ (36!)/(9! dot 9! dot 9! dot 9!) = (36!)/(9!)^4
    approx 2.15 dot 10^(19). $

  The second form is the arrangement view: label the $36$ cards with
  which player gets them — nine A's, nine B's, nine C's and nine D's —
  and every deal is one arrangement of that word.

  Note that the players are distinguishable, so unlike the bridge
  exercise there is no further division by $4!$. Being dealt the hand
  that your neighbor got is a different deal.
]

#ai-box(role: "Generator")[
  Ask an AI assistant to invent five counting problems whose answers
  are $binom(n + k - 1, k)$ — selections with repetition — mixed
  randomly with five whose answers are $binom(n, k)$, without telling
  you which is which.

  Sort them yourself, then check. The interesting outcome is not
  whether you sorted correctly but whether the assistant's *own*
  labels are right: this distinction is one that generated problems
  get wrong surprisingly often, usually by describing objects as
  identical in one sentence and then asking a question that only makes
  sense if they are distinguishable.

  If you find such a problem, rewrite it so that it is unambiguous.
  That is a better exercise than any of the ten.
]

#look-ahead(preview: [counting and probability together])[
  You now have every counting tool this course needs, and rather more
  than the next chapter will use. What remains is to put counting back
  where it came from: probability problems where both the favorable
  cases and the possible ones have to be counted before anything can
  be divided.
]

#print-hints()
#print-vocab()
