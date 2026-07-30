#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Probability with Counting")
#let ex = exercise.with(chapter: "Probability with Counting")

= Probability with Counting

#only-theory[
  This chapter has no new rules in it. It has the oldest rule in the
  unit,
  $ p(A) = abs(A)/abs(Omega), $
  and the counting tools built to make $abs(A)$ and $abs(Omega)$
  computable when they run into the millions.

  What it does have is a decision to make on every single problem, and
  a reassuring fact about that decision which is worth meeting head
  on: there is usually more than one right way to count, and the right
  ways all agree.
]

#objectives(
  bfkm[find a probability by counting the favorable outcomes and the
    possible outcomes],
  [set up a sample space of equally likely outcomes before counting
    anything, and say why it is equally likely],
  [solve the same problem by counting ordered outcomes and by counting
    unordered ones, and explain why the two agree],
  [recognize the error of counting the numerator one way and the
    denominator the other],
  [choose the easier of two correct approaches],
  [use complementary counting on "at least one" problems in this
    setting],
)

== Counting Both Ends

#only-theory[
  The counting rule carries a condition that has been stated before
  and is worth stating once more, because from here on the counting is
  hard enough to distract from it: the outcomes of $Omega$ must be
  equally likely.

  There is a second condition that has not been needed until now,
  because until now the sample spaces were small enough to see. It
  matters a great deal here.
]

#warning[
  $abs(A)$ and $abs(Omega)$ must be counted *in the same sample
  space*.

  You are free to decide what an outcome is — whether drawing two
  balls produces an ordered pair or an unordered set, whether dealing
  a hand records the order the cards arrived in. What you are not free
  to do is decide one way for the numerator and the other way for the
  denominator. That produces an answer which is not merely inaccurate
  but meaningless, and it is by a wide margin the most common mistake
  in this chapter.
]

== Two Ways to Count, One Answer

#only-theory[
  An urn holds $3$ red balls and $5$ blue ones. Two are drawn without
  replacement. What is the probability that both are red?

  Here are three solutions. They look nothing like each other.
]

#example(title: "The same problem three times")[
  *Counting ordered pairs.* Regard an outcome as "which ball came out
  first, which second". There are $8 dot 7 = 56$ such outcomes,
  equally likely because every ball is as likely as any other at each
  stage. Of these, $3 dot 2 = 6$ have a red ball both times:
  $ p = 6/56 = 3/28. $

  *Counting unordered pairs.* Regard an outcome as "which two balls
  are now in my hand", forgetting the order. There are
  $binom(8, 2) = 28$ such outcomes, equally likely for the same
  reason. Of these, $binom(3, 2) = 3$ consist of two red balls:
  $ p = 3/28. $

  *Multiplying along a path.* Draw the tree. The first ball is red
  with probability $3 slash 8$; given that, the second is red with
  probability $2 slash 7$:
  $ p = 3/8 dot 2/7 = 6/56 = 3/28. $
]

#keybox(title: "Ordered and unordered agree")[
  Counting ordered outcomes and counting unordered outcomes give the
  same probability, provided you use the same choice top and bottom.

  The reason is that passing from ordered to unordered divides *both*
  counts by the same number — the $k!$ orders of the $k$ objects
  drawn — and a fraction is unchanged when numerator and denominator
  are divided by the same thing:
  $ (3 dot 2)/(8 dot 7) = (3 dot 2 slash 2!)/(8 dot 7 slash 2!)
    = binom(3, 2)/binom(8, 2). $
]

#only-theory[
  This is worth more than a technical remark. You were genuinely free
  to decide what counted as an outcome — that was a modelling choice,
  not a fact about the urn — and it would be alarming if the
  probability depended on it. It does not. The freedom is real and it
  is harmless.

  What is not harmless is mixing.
]

#ex(difficulty: 2, time: "12 min")[
  Two cards are drawn from a shuffled deck of $52$, without
  replacement. Four students calculate the probability that both are
  aces.

  #auto-parts(
    1,
    [Anja: $binom(4, 2) slash binom(52, 2) = 6 slash #num(1326)$],
    [Ben: $4/52 dot 3/51$],
    [Chiara: $(4 dot 3) slash (52 dot 51) = 12 slash #num(2652)$],
    [Dario: $binom(4, 2) slash (52 dot 51) = 6 slash #num(2652)$],
  )

  Evaluate all four. One of them is wrong. Which, and what exactly
  went wrong — not just "the formula", but which set was counted where?
][
  The first three all give
  $ 1/221 approx 0.0045, $
  and Dario gives $1 slash 442$, exactly half as much.

  #auto-parts(
    1,
    [Anja counts unordered pairs at both ends: $binom(52,2)$ hands of
      two cards, $binom(4,2)$ of them all-ace. Correct.],
    [Ben multiplies along a path — the general multiplication rule,
      with the second factor conditioned on the first. Correct.],
    [Chiara counts ordered pairs at both ends: $52 dot 51$ possible,
      $4 dot 3$ favorable. Correct, and it is Ben's calculation with
      the fractions not yet multiplied out.],
    [Dario counted the numerator as a set of unordered pairs and the
      denominator as a set of ordered pairs. His numerator lives in a
      sample space of $#num(1326)$ outcomes and his denominator in one
      of $#num(2652)$, so the fraction is not a probability of
      anything. The factor of $2$ he is out by is exactly the $2!$ he
      divided out of the top and not the bottom.],
  )

  Dario's answer is not a rounding error or a slightly wrong model. It
  is the ratio of a count of one kind of thing to a count of a
  different kind of thing.
]

#only-theory[
  If both ways are correct, which should you use? Whichever is less
  work, and that depends entirely on the question.
]

#keybox(title: "Which way to count")[
  / Unordered is usually easier: when the question is about *which*
    objects were obtained — two aces, a committee of four, six correct
    lottery numbers. Order was never mentioned, so do not introduce
    it.

  / Ordered is usually easier: when the question refers to the
    sequence — the first ball is red, the third digit is even, the
    letters spell a word. Order is part of the question, so keep it.

  / A tree is usually easier: when the stages have different rules, or
    when the probabilities change between stages in a way that is
    easier to describe than to count.
]

#example(title: "The same problem, one easy way and one hard way")[
  A committee of four is chosen from $9$ men and $4$ women. What is
  the probability that exactly one woman is on it?

  *Unordered.* Choose the woman and the three men:
  $ p = (binom(4, 1) dot binom(9, 3))/binom(13, 4)
      = (4 dot 84)/715 = 336/715 approx 0.470. $

  *Ordered.* There are $13 dot 12 dot 11 dot 10 = #num(17160)$
  ordered selections. The favorable ones need a woman in one of four
  positions, so $4$ positions $times 4$ women $times$ the $9 dot 8
  dot 7$ ordered choices of men, giving $4 dot 4 dot 504 = #num(8064)$
  — and
  $ #num(8064)/#num(17160) = 336/715, $
  the same answer after four times the work.
]

== Drawing Without Replacement

#only-theory[
  The shape of problem below turns up constantly: a collection
  containing two or more kinds of thing, a handful taken out at once,
  and a question about how many of each kind came with it. Lottery
  tickets, quality control, committees, hands of cards and urns full
  of colored balls are all the same problem wearing different clothes.

  Because "taken out at once" means order is not recorded, these are
  the unordered case, and the pattern is always: multiply a binomial
  coefficient for each kind, divide by one for the whole.
]

#example(title: "The Swiss lottery")[
  Six numbers are drawn from $42$. A ticket matching all six wins the
  jackpot. Order does not matter, so
  $ abs(Omega) = binom(42, 6) = #num(5245786), $
  and exactly one of those draws is yours:
  $ p("six correct") = 1/#num(5245786). $

  For five correct, count the draws that match your ticket in exactly
  five places. Choose which five of your six numbers were drawn, then
  which of the $36$ numbers you did not pick made up the sixth:
  $ p("five correct") = (binom(6, 5) dot binom(36, 1))/binom(42, 6)
    = 216/#num(5245786) approx 4.1 dot 10^(-5). $

  The pattern generalizes: for exactly $k$ correct,
  $ p(k "correct") = (binom(6, k) dot binom(36, 6 - k))/binom(42, 6). $
]

#ex(difficulty: 2, time: "10 min")[
  A batch of $20$ light bulbs contains $8$ defective ones. Six bulbs
  are taken out to be tested. What is the probability that all six
  work?
][
  Order is not recorded, so count unordered selections of six bulbs:
  $ abs(Omega) = binom(20, 6) = #num(38760). $
  Twelve of the bulbs work, and all six must come from those:
  $ abs(A) = binom(12, 6) = 924. $
  Hence
  $ p = 924/#num(38760) = 77/#num(3230) approx 0.024. $
  Under one test in forty comes back clean, which is what you would
  hope from a batch that is $40%$ defective.
]

#ex(difficulty: 2, time: "12 min")[
  A delegation of four is chosen at random from a group of $8$ Swiss,
  $5$ Germans and $3$ Italians. Find the probability that the
  delegation
  #auto-parts(
    1,
    [consists only of Swiss members,],
    [contains no Swiss members,],
    [contains at least one Swiss member.],
  )
  Parts 1 and 2 have the same answer. Explain why, without
  calculating.
][
  There are $16$ people, so $abs(Omega) = binom(16, 4) = #num(1820)$.
  #auto-parts(
    1,
    [$binom(8, 4) slash binom(16, 4) = 70 slash #num(1820) = 1/26$.],
    [The non-Swiss also number $5 + 3 = 8$, so
      $binom(8, 4) slash binom(16, 4) = 1/26$ again.],
    [The complement of part 2:
      $1 - 1 slash 26 = 25 slash 26 approx 0.96$.],
  )
  Parts 1 and 2 agree because the group splits exactly in half: $8$
  Swiss and $8$ non-Swiss. Choosing four people who are all Swiss and
  choosing four who are all non-Swiss are the same counting problem
  with the labels swapped, so no arithmetic is needed to see that the
  answers match.
]

#ex(difficulty: 2, time: "12 min")[
  A volleyball team of six is picked at random from $10$ players, of
  whom $8$ are boys and $2$ are girls.
  #auto-parts(
    1,
    [In how many ways can the team be selected?],
    [In how many of those is exactly one girl on the team?],
    [What is the probability that exactly one girl is on the team?],
  )
][
  #auto-parts(
    1,
    [$binom(10, 6) = 210$.],
    [Choose the one girl from two and the five boys from eight:
      $ binom(2, 1) dot binom(8, 5) = 2 dot 56 = 112. $],
    [$112 slash 210 = 8 slash 15 approx 0.53$.],
  )
]

#ex(difficulty: 3, time: "15 min")[
  An urn contains ten cards bearing the letters
  $ "E", quad "P", quad "G", "G", "G", quad "O", "O", quad
    "T", "T", "T". $
  #auto-parts(
    1,
    [Two cards are drawn together. What is the probability that they
      show the same letter?],
    [The two cards do show the same letter. What is the probability
      that the letter is G?],
    [Now the cards are drawn one at a time and replaced each time, ten
      times over. What is the probability of drawing exactly six T's?],
    [Drawing in the same way, how many draws are needed before the
      probability of seeing at least one G exceeds $95%$?],
  )
][
  #auto-parts(
    1,
    [Two cards taken together, so count unordered pairs:
      $binom(10, 2) = 45$. A matching pair comes from the three G's,
      the two O's or the three T's:
      $ binom(3,2) + binom(2,2) + binom(3,2) = 3 + 1 + 3 = 7, $
      giving $p = 7 slash 45$.],
    [Condition on the $7$ matching pairs, of which $3$ are the G's:
      $ p("G" | "same") = 3/7. $],
    [With replacement each draw is independent, and
      $p("T") = 3 slash 10$. Exactly six T's in ten draws means
      choosing which six draws they were, then multiplying:
      $ binom(10, 6) dot (0.3)^6 dot (0.7)^4 approx 0.0368. $],
    [The complement is that no G appears, and $p("not G") = 0.7$ at
      every draw:
      $ 1 - (0.7)^n > 0.95 arrow.r.double (0.7)^n < 0.05. $
      Trying values, $(0.7)^8 approx 0.058$ and
      $(0.7)^9 approx 0.040$, so $n = 9$ draws are needed.],
  )
]

#only-high[
  #ex(difficulty: 3, level: "high", time: "12 min")[
    Ms. Robinson gives her class $20$ study problems and will pick
    $10$ of them for the test. Carl can solve $15$ of the $20$.
    #auto-parts(
      1,
      [Find the probability that Carl can solve every problem on the
        test.],
      [Find the probability that he can solve exactly $8$ of them.],
    )
  ][
    The test is an unordered selection of $10$ problems from $20$, so
    $abs(Omega) = binom(20, 10) = #num(184756)$.
    #auto-parts(
      1,
      [All ten must come from the $15$ he can solve:
        $ binom(15, 10)/binom(20, 10) = #num(3003)/#num(184756)
          = 21/#num(1292) approx 0.016. $],
      [Eight from the $15$ he knows and the other two from the $5$ he
        does not:
        $ (binom(15, 8) dot binom(5, 2))/binom(20, 10)
          = (#num(6435) dot 10)/#num(184756) = 225/646
          approx 0.348. $],
    )
  ]

  #ex(difficulty: 3, level: "high", time: "12 min")[
    A bag contains six real diamonds and five fake ones. Six are taken
    out at random. What is the probability that at most four of them
    are real?
  ][
    "At most four" covers five cases — none, one, two, three or four
    real — while its complement covers only two, so count the
    complement.

    With $abs(Omega) = binom(11, 6) = 462$, exactly five real means
    five of the six real diamonds and one of the five fakes, and
    exactly six real means all six:
    $ binom(6, 5) dot binom(5, 1) + binom(6, 6) = 30 + 1 = 31. $
    Hence
    $ p("at most four real") = 1 - 31/462 = 431/462 approx 0.933. $
  ]
]

== Counting Paths

#only-theory[
  When the draws are replaced, or the trials are independent for some
  other reason, the sample space is the set of *sequences* rather than
  the set of selections — and the counting question becomes: how many
  sequences have the property I want?

  The tree chapter left this exact question open, and the counting
  chapter answered it. Every path with $k$ successes out of $n$ trials
  is an arrangement of $k$ Y's and $n - k$ N's, so there are
  $binom(n, k)$ of them, and when the trials are fair each has the
  same probability.
]

#ex(difficulty: 2, time: "12 min")[
  A fair coin is tossed ten times. Find the probability of
  #auto-parts(
    1,
    [exactly five heads,],
    [at least five heads.],
  )
][
  Each of the $2^(10) = #num(1024)$ sequences of ten tosses is equally
  likely, so both parts are counting problems.
  #auto-parts(
    1,
    [The sequences with five heads are the arrangements of five H's
      and five T's:
      $ binom(10, 5)/2^(10) = 252/#num(1024) approx 0.246. $
      Worth noticing: the single most likely number of heads is five,
      and it still happens less than a quarter of the time.],
    [Add the cases from five heads to ten:
      $ (binom(10,5) + binom(10,6) + dots.c + binom(10,10))/2^(10)
        = (252 + 210 + 120 + 45 + 10 + 1)/#num(1024)
        = 638/#num(1024) approx 0.623. $
      The numbers being added are the right-hand half of row $10$ of
      Pascal's triangle.],
  )
]

#ex(difficulty: 3, time: "15 min", hints: (
  "The six balls are not all different, so the three labels do not have the same probability. Work those out first.",
  "For part 1, list the ways three labels can add to 5, then count the orders of each.",
  "For part 3, the complement of 'at least one 2' is 'no 2 at all'.",
))[
  Six balls labelled $1$, $2$, $2$, $3$, $3$, $3$ are placed in a bag.
  A ball is taken, its number noted, and returned before the next is
  taken.
  #auto-parts(
    1,
    [Three balls are taken. Find the probability that the numbers add
      to $5$.],
    [Ten balls are taken. Find the probability that fewer than four of
      them are labelled $2$.],
    [How many balls must be taken for the probability of getting at
      least one $2$ to exceed $0.95$?],
  )
][
  The labels are not equally likely:
  $ p(1) = 1/6, quad p(2) = 2/6 = 1/3, quad p(3) = 3/6 = 1/2. $
  #auto-parts(
    1,
    [Three labels add to $5$ in two ways as unordered collections,
      each of which occurs in three orders:
      $ {1, 1, 3}: quad 3 dot (1/6)^2 dot 1/2 = 1/24, \
        {1, 2, 2}: quad 3 dot 1/6 dot (1/3)^2 = 1/18. $
      Adding, $1 slash 24 + 1 slash 18 = 3 slash 72 + 4 slash 72
      = 7 slash 72 approx 0.097$.],
    ["Fewer than four" means $0$, $1$, $2$ or $3$ balls labelled $2$.
      Each count $k$ is a choice of which draws they were, times the
      probabilities:
      $ sum_(k=0)^3 binom(10, k) dot (1/3)^k dot (2/3)^(10-k)
        approx 0.559. $],
    [The complement is drawing no $2$ at all, which has probability
      $(2 slash 3)^n$:
      $ 1 - (2/3)^n > 0.95 arrow.r.double (2/3)^n < 0.05. $
      Since $(2 slash 3)^7 approx 0.059$ and
      $(2 slash 3)^8 approx 0.039$, at least $8$ draws are needed.],
  )
]

#ex(difficulty: 3, time: "20 min")[
  #emph[Matura, Gymnasium Muttenz.] Elena is given a drawing divided
  into $12$ sections and eight colored pencils. She colors each
  section with exactly one color, choosing freely and independently
  for each section.
  #auto-parts(
    1,
    [How many different paintings could she produce?],
    [How many if $8$ sections are red and $4$ are blue?],
    [How many if exactly $4$ sections are blue, exactly $2$ are red,
      and the remaining sections use none of those two colors?],
    [What is the probability that at least one section is red?],
    [What is the probability that the eighth section she colors is
      the first one to use her eighth color — that is, that her first
      eight sections use all eight colors?],
  )
][
  #auto-parts(
    1,
    [Twelve independent stages with eight choices each:
      $ 8^(12) = #num(68719476736). $],
    [The colors are fixed; all that is free is *which* sections are
      red. Choosing those settles the rest:
      $ binom(12, 8) = 495. $],
    [Three stages. Choose the $4$ blue sections, then the $2$ red ones
      from what is left, then color the remaining $6$ sections with
      any of the other $6$ colors:
      $ binom(12, 4) dot binom(8, 2) dot 6^6
        = 495 dot 28 dot #num(46656) = #num(646652160). $],
    [Complement: no section is red, so each of the twelve uses one of
      the other seven colors:
      $ 1 - (7/8)^(12) approx 1 - 0.201 = 0.799. $],
    [The first eight sections must use eight different colors — $8$
      choices for the first, $7$ for the second, and so on:
      $ (8 dot 7 dot 6 dot dots.c dot 1)/8^8 = 8!/8^8
        = #num(40320)/#num(16777216) approx 0.0024. $
      About one painting in $416$.],
  )
]

== When Counting Runs Out

#only-theory[
  Every problem so far had finitely many outcomes to count. Some do
  not, and it is worth seeing one before leaving the chapter, if only
  to know what the boundary looks like.
]

#ex(difficulty: 3, time: "15 min", hints: (
  "Describe the cut by a single number: how far along the pipe it is, as a fraction of the total length.",
  "There is nothing to count here. What can you measure instead?",
  "Write down the condition 'the longer piece is at least 8 times the shorter' as an inequality in that number, and solve it. Do not forget that either piece could be the longer one.",
))[
  A plumber cuts a pipe in two at a point chosen at random along its
  length. What is the probability that the longer piece is at least
  eight times the length of the shorter one?
][
  Take the pipe to have length $1$ and let $x$ be the position of the
  cut, so $x$ lies anywhere in the interval $[0, 1]$ and no position
  is more likely than another. There is no finite list of outcomes to
  count — but there is a length to measure, and the spinner in the
  sample-space chapter already suggested the replacement: probability
  is the *share of the interval* on which the condition holds.

  The two pieces have lengths $x$ and $1 - x$. If the shorter is the
  left-hand one,
  $ 1 - x >= 8x arrow.r.double 1 >= 9x arrow.r.double x <= 1/9, $
  and by symmetry the right-hand piece is the shorter when
  $x >= 8 slash 9$. So the condition holds on two intervals, each of
  length $1 slash 9$:
  $ p = 1/9 + 1/9 = 2/9 approx 0.22. $

  The counting rule has not been abandoned so much as translated:
  favorable over possible has become favorable *length* over possible
  length. #heuristic("draw a picture")
]

#look-ahead(preview: [continuous distributions])[
  That last exercise is the second crack in the finite world, after
  the spinner. Measuring a length instead of counting outcomes is the
  whole idea behind continuous probability, and it is where the normal
  distribution lives.

  It is also the reason a probability of zero need not mean
  impossible: the cut lands at exactly one point, and every single
  point has length zero.
]

#ai-box(role: "Checker")[
  Give an AI assistant the four students' calculations from the
  two-aces exercise in §2 and ask it which are correct. Do not tell it
  that one is wrong.

  Then ask the harder question: _why do the three correct ones agree,
  when one counts ordered outcomes and another counts unordered
  ones?_ A good answer names the factor of $2!$ and says it cancels
  between numerator and denominator. A weak answer says only that they
  are "different valid approaches", which is a restatement of the
  question rather than an answer to it.

  This is a useful test to have in your pocket. Asking a model *why*
  two correct results agree is usually more revealing than asking it
  for the results.
]

#look-ahead(preview: [where intuition fails])[
  You now have every tool in the unit. The last chapter uses them on a
  short list of famous problems chosen for one shared property: almost
  everybody gets them wrong, including people who know all the
  mathematics you have just learned.
]

#print-hints()
#print-vocab()
