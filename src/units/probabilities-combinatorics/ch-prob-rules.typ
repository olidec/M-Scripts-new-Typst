#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Rules for Combining Probabilities")
#let ex = exercise.with(chapter: "Rules for Combining Probabilities")

// ── LOCAL FIGURE HELPER ──────────────────────────────────────
// Two-set Venn diagram drawn natively from Typst primitives rather
// than pulled in as a PNG. STYLE_GUIDE.md §7 prefers this, and here
// it earns its keep twice over: the region counts stay typeset, so an
// example can be re-numbered without re-exporting an image, and the
// same diagram serves both the archery example and the exercises.
//
// PROMOTE TO preamble.typ IF YOU LIKE IT. Venn diagrams recur in
// ch-conditional and in several exercises, and §7 says a diagram
// hand-coded more than once should become a shared helper. It lives
// here only so this chapter compiles before you've touched the
// preamble — if you move it, delete this block and nothing else in
// the chapter changes.
//
// NEEDS A VISUAL CHECK: I cannot render Typst, so the label offsets
// are set by arithmetic rather than by eye. If the region counts sit
// high or low inside the circles, nudge the `- 0.55em` in cell();
// if the set names crowd the circle tops, nudge the `- 1.4em`.
#let venn2(
  a: [],
  ab: [],
  b: [],
  outside: [],
  label-a: [$A$],
  label-b: [$B$],
  omega: [$Omega$],
  size: 8cm,
) = {
  let w = size
  let h = size * 0.58
  let r = w * 0.215
  let cy = h * 0.56
  let cell(x, y, body) = place(
    top + left,
    dx: x - w * 0.09,
    dy: y,
    box(width: w * 0.18, align(center, body)),
  )
  align(center, block(
    width: w,
    height: h,
    stroke: 0.7pt + luma(140),
    inset: 0pt,
    {
      place(
        top + left,
        dx: w * 0.375 - r,
        dy: cy - r,
        circle(radius: r, stroke: 1pt + accent),
      )
      place(
        top + left,
        dx: w * 0.625 - r,
        dy: cy - r,
        circle(radius: r, stroke: 1pt + def-col),
      )
      cell(w * 0.27, cy - 0.55em, a)
      cell(w * 0.50, cy - 0.55em, ab)
      cell(w * 0.73, cy - 0.55em, b)
      cell(w * 0.27, cy - r - 1.4em, text(fill: accent, label-a))
      cell(w * 0.73, cy - r - 1.4em, text(fill: def-col, label-b))
      place(top + left, dx: w * 0.03, dy: h * 0.05, outside)
      place(top + left, dx: w * 0.88, dy: h * 0.05, omega)
    },
  ))
}

= Rules for Combining Probabilities

#only-theory[
  The last chapter ended with a promise and a complaint. The promise
  was that "at least one six in four rolls of a die" would become
  answerable; the complaint was that answering it by the methods
  available so far means sorting through $6^4 = #num(1296)$ outcomes
  by hand.

  This chapter builds four rules that make such questions short. Each
  one is a statement about how events combine — and events are sets,
  so each rule is really a statement about unions, intersections and
  complements. That is why the last chapter opened with sets.
]

#objectives(
  [read and draw a Venn diagram, and fill in the four regions of a
    two-event diagram from the information given],
  bfkm[use the complement rule, and recognize the "at least one"
    problems it turns from hard into easy],
  bfkm[use the addition rule, and say why it subtracts the
    intersection],
  [recognize mutually exclusive events and simplify the addition rule
    accordingly],
  bfkm[use the product rule for independent events],
  [test whether two events are independent, and explain why
    _independent_ and _mutually exclusive_ are not only different but
    nearly opposite],
  obj(level: "high")[show that if $A$ and $B$ are independent then so
    are $A$ and $overline(B)$],
)

== Picturing Events

#only-theory[
  John Venn, born in Hull in 1834, drew sets as regions of the plane:
  a rectangle for everything under consideration, and a closed curve
  for each set inside it. The picture is not a proof of anything, but
  it is very hard to reason about two overlapping events without one.
]

#example(title: "Archery and badminton")[
  A year group has $100$ students. $38$ of them do archery, $30$ play
  badminton, and $16$ do both. Writing $A$ for the archers and $B$ for
  the badminton players:

  #venn2(
    a: [$22$],
    ab: [$16$],
    b: [$14$],
    outside: [$48$],
    label-a: [$A$],
    label-b: [$B$],
    omega: [$Omega$],
  )

  Start from the middle and work outwards, because the $16$ students
  who do both have already been counted in the $38$ and in the $30$:
  $
    abs(A without B) = 38 - 16 = 22, quad
    abs(B without A) = 30 - 16 = 14,
  $
  and the students left over do neither:
  $ 100 - 22 - 16 - 14 = 48. $
  Every one of the $100$ students now sits in exactly one of the four
  regions, which is the check that the diagram is right.
]

#warning[
  Always fill a Venn diagram from the intersection outwards. Writing
  $38$ into the left circle first is the standard way to lose track of
  the $16$ students who belong in two places at once, and it is
  almost always the source of an answer that does not add up to
  $abs(Omega)$.
]

#only-theory[
  Sometimes the overlap is what you are looking for rather than what
  you are given, and then the diagram becomes an equation.
]

#example(title: "Solving for the overlap")[
  Of $30$ students, $17$ play computer games, $10$ play board games,
  and $9$ play neither. How many play both?

  Call the unknown overlap $x$. The four regions then hold $17 - x$,
  $x$, $10 - x$ and $9$ students, and together they must account for
  everyone:
  $
    (17 - x) + x + (10 - x) + 9 = 30
    arrow.r.double 36 - x = 30 arrow.r.double x = 6.
  $

  #venn2(
    a: [$11$],
    ab: [$6$],
    b: [$4$],
    outside: [$9$],
    label-a: [$C$],
    label-b: [$B$],
    omega: [$Omega$],
  )

  So $p(C inter B) = 6/30 = 1/5$, and the students who play board games
  but not computer games number $4$, giving $4/30 = 2/15$.
]

== The Complement

#definition(title: "Complementary Event")[
  The #vocab("complement", "Gegenereignis") of an event $A$ is the
  event $overline(A)$ consisting of all outcomes of $Omega$ that are
  *not* in $A$.

  Exactly one of $A$ and $overline(A)$ must occur, so
  $ p(A) + p(overline(A)) = 1, $
  and therefore
  $
    p(overline(A)) = 1 - p(A) quad "and" quad
    p(A) = 1 - p(overline(A)).
  $
]

#remark[
  Some books write $A^c$ or $A'$ instead of $overline(A)$. This course
  uses the overline throughout.
]

#example[
  In the archery data, $abs(overline(A)) = 100 - 38 = 62$, so
  $ p(overline(A)) = 62/100 = 1 - 38/100 = 0.62. $
]

#only-theory[
  Read the complement rule left to right and it looks like a triviality
  for turning $0.38$ into $0.62$. Read it right to left and it is one
  of the most useful tools in the subject, because it converts a
  question with many favorable cases into one with few.
]

#keybox(title: "The \"at least one\" move")[
  The complement of _at least one_ is _none_.

  Whenever an event is described by the words *at least one*, count
  the one case where it fails instead of the many where it succeeds,
  and subtract from $1$:
  $ p("at least one") = 1 - p("none"). $
]

#example(title: "At least one head")[
  Toss a coin three times. What is the probability of at least one
  head?

  Listing the successes means listing seven of the eight outcomes.
  Listing the failures means listing one, namely $(t, t, t)$:
  $ p("at least one head") = 1 - p((t, t, t)) = 1 - 1/8 = 7/8. $
]

#ex(difficulty: 1, time: "5 min")[
  The probability that an event $A$ happens is $0.37$.
  #auto-parts(
    2,
    [What is the probability that it does not happen?],
    [What is the probability that it either happens or does not?],
  )
][
  #auto-parts(
    2,
    [$p(overline(A)) = 1 - 0.37 = 0.63$.],
    [$1$. The event "$A$ happens or $A$ does not happen" is $Omega$
      itself, and something has to happen. A question worth being
      suspicious of: if you found yourself adding $0.37 + 0.63$, you
      got the right answer for the wrong reason.],
  )
]

== The Addition Rule

#only-theory[
  How likely is it that at least one of two events occurs — that a
  student does archery *or* badminton, that a card is a heart *or* a
  king? In set language this is the union $A union B$, and the naive
  guess is $p(A) + p(B)$.

  Look back at the archery diagram to see what is wrong with that.
  Adding $38 + 30 = 68$ counts the $16$ students in the middle twice,
  once as archers and once as badminton players. The union actually
  contains $22 + 16 + 14 = 52$ students, and $68 - 52 = 16$ is exactly
  the double-counted overlap.
]

#keybox(title: "The addition rule")[
  For any two events $A$ and $B$,
  $ p(A union B) = p(A) + p(B) - p(A inter B), $
  or in terms of counts, when the outcomes are equally likely,
  $ p(A union B) = (abs(A) + abs(B) - abs(A inter B)) / abs(Omega). $

  Because $A union B$ is the event that $A$ *or* $B$ occurs, this is
  sometimes called the *or*-rule, and $p(A "or" B)$ is written for
  $p(A union B)$.
]

#warning[
  "Or" in mathematics is inclusive. $A union B$ occurs when $A$
  occurs, when $B$ occurs, and when both do. If you want "exactly one
  of the two", that is a different event — and its probability is
  $p(A union B) - p(A inter B)$.
]

#example(title: "A heart or a king")[
  One card is drawn from a standard deck of $52$. Let $A$ be "the card
  is a heart" and $B$ "the card is a king", so
  $ p(A) = 13/52 = 1/4 quad "and" quad p(B) = 4/52 = 1/13. $
  There is a king of hearts, and it would be counted twice, so
  $ p(A union B) = 13/52 + 4/52 - 1/52 = 16/52 = 4/13. $
]

#definition(title: "Mutually Exclusive Events")[
  Two events are #vocab("mutually exclusive", "unvereinbar") — or
  equivalently *disjoint* — if they cannot both occur, that is, if
  $A inter B = emptyset$. In a Venn diagram their circles do not
  overlap.

  For such events $p(A inter B) = 0$ and the addition rule loses its
  correction term:
  $ p(A union B) = p(A) + p(B). $
]

#example[
  Toss three coins. "Exactly two heads" and "exactly two tails" cannot
  both happen, so they are mutually exclusive, and
  $ 3/8 + 3/8 = 6/8 = 3/4. $
]

#ex(difficulty: 2, time: "10 min")[
  A supermarket chain accepts only two kinds of card. It estimates
  that $21%$ of its customers carry a Mastercard, $57%$ carry a Visa,
  and $13%$ carry both.
  #auto-parts(
    1,
    [What is the probability that a customer can pay by card at all?],
    [What proportion of customers carry neither card?],
    [What proportion carry exactly one of the two?],
  )
][
  Write $M$ and $V$ for the two events, so $p(M) = 0.21$,
  $p(V) = 0.57$ and $p(M inter V) = 0.13$.
  #auto-parts(
    1,
    [$p(M union V) = 0.21 + 0.57 - 0.13 = 0.65$.],
    [The complement of part 1: $1 - 0.65 = 0.35$.],
    [Take the union and remove the customers counted in both:
      $0.65 - 0.13 = 0.52$. Equivalently $0.08 + 0.44$, the two
      outer regions of the Venn diagram.],
  )
]

#ex(difficulty: 2, time: "8 min")[
  Two events satisfy $p(A) = 3/4$, $p(A union B) = 4/5$ and
  $p(A inter B) = 3/10$. Find $p(B)$.
][
  Rearrange the addition rule to make $p(B)$ the subject:
  $
    p(B) = p(A union B) - p(A) + p(A inter B)
    = 4/5 - 3/4 + 3/10.
  $
  With a common denominator of $20$,
  $ p(B) = 16/20 - 15/20 + 6/20 = 7/20. $
  A sanity check worth doing every time: $p(B) = 0.35$ must be at
  least $p(A inter B) = 0.3$ and at most $p(A union B) = 0.8$. It is.
]

#ex(difficulty: 2, time: "12 min")[
  A sample space has $abs(Omega) = 36$, and two events satisfy
  $abs(A) = 11$, $abs(B) = 6$ and
  $abs(overline(A) inter overline(B)) = 21$.
  #auto-parts(
    1,
    [Draw a Venn diagram and shade the region
      $overline(A) inter overline(B)$.],
    [Find $abs(A inter B)$ and $p(A inter B)$.],
    [Explain why $A$ and $B$ are not mutually exclusive.],
  )
][
  #auto-parts(
    1,
    [The rectangle with the two overlapping circles; the shaded region
      is everything outside both circles. It holds $21$ outcomes.],
    [Outside both circles means outside their union, so
      $abs(A union B) = 36 - 21 = 15$. The addition rule in counting
      form then gives
      $
        abs(A inter B) = abs(A) + abs(B) - abs(A union B)
        = 11 + 6 - 15 = 2,
      $
      and $p(A inter B) = 2/36 = 1/18$.],
    [Because $A inter B eq.not emptyset$ — there are two outcomes in
      both events at once. Mutually exclusive events would need
      $abs(A inter B) = 0$, and indeed $abs(A) + abs(B) = 17$ is
      bigger than $abs(A union B) = 15$, which is only possible when
      something is being double-counted.],
  )
]

== Independence and the Product Rule

#only-theory[
  The addition rule handles _or_. The remaining question is _and_ —
  and unlike _or_, it does not have an answer that works in general.
  Knowing $p(A)$ and $p(B)$ is simply not enough to determine
  $p(A inter B)$; something has to be said about how the two events
  relate.

  The easiest such relationship, and by far the most common in
  practice, is that they do not relate at all.
]

#definition(title: "Independence")[
  Two events are #vocab("independent", "unabhängig") if the occurrence
  of one does not affect the chance that the other occurs.
]

#only-theory[
  Independence is usually recognized from the physical set-up rather
  than calculated. Roll a die and toss a coin: nothing about the coin
  reaches the die. Draw a ball from an urn and put it back: the urn is
  in the same state for the second draw as for the first. In both
  cases the events are independent because there is no mechanism by
  which they could fail to be.
]

#keybox(title: "The product rule")[
  If $A$ and $B$ are independent, then
  $ p(A inter B) = p(A) dot p(B). $

  Because $A inter B$ is the event that $A$ *and* $B$ occur, this is
  the *and*-rule, and $p(A "and" B)$ is written for $p(A inter B)$.
]

#example(title: "A die and a coin")[
  A die is rolled and a coin tossed. Let $H$ be "the coin shows heads"
  and $L$ be "the die shows less than $3$". The sample space has
  $abs(Omega) = 12$, and counting gives $abs(H) = 6$, $abs(L) = 4$ and
  $abs(H inter L) = 2$, so
  $ p(H) = 1/2, quad p(L) = 1/3, quad p(H inter L) = 2/12 = 1/6. $
  The product rule predicts $1/2 dot 1/3 = 1/6$, which is what the
  counting gave — as it must, since the coin and the die have no way
  of influencing one another.

  For the union, the addition rule still applies:
  $ p(H union L) = 6/12 + 4/12 - 2/12 = 8/12 = 2/3. $
]

#only-theory[
  Run that example backwards and the product rule becomes something
  more useful than a shortcut: a way of *detecting* independence in
  data, where no physical argument is available.
]

#keybox(title: "The independence test")[
  $A$ and $B$ are independent *exactly when*
  $ p(A inter B) = p(A) dot p(B). $
  If the two sides differ, the events are
  #vocab("dependent", "abhängig") — knowing that one occurred changes
  the chance of the other.
]

#example(title: "Testing the archery data")[
  From the year group of $100$ students, $p(A) = 0.38$, $p(B) = 0.30$
  and $p(A inter B) = 0.16$. The test gives
  $
    p(A) dot p(B) = 0.38 dot 0.30 = 0.114 eq.not 0.16
    = p(A inter B).
  $
  So archery and badminton are *not* independent in this year group.
  There are more double-players than there would be if the two
  choices were unrelated — perhaps the two clubs meet on different
  evenings, or perhaps the same sort of student is drawn to both.

  Notice what the test does and does not tell us. It says the two
  events are connected. It says nothing about which way the
  connection runs, or whether anything causes anything.
]

#warning[
  *Independent* and *mutually exclusive* are not the same thing, and
  they are not opposite ends of one scale. They are two different
  relationships, and confusing them is the most common error in this
  chapter.

  Worse, they are almost incompatible. Suppose $A$ and $B$ are
  mutually exclusive and both have positive probability. Then
  $ p(A inter B) = 0 quad "but" quad p(A) dot p(B) > 0, $
  so the test fails and the events are *dependent* — strongly so.
  Learning that $A$ occurred tells you with certainty that $B$ did
  not, which is about as much influence as one event can have on
  another.

  Mutually exclusive events overlap as little as possible.
  Independent events are not about overlap at all.
]

#ex(difficulty: 2, time: "10 min")[
  A fair die is rolled once. Let
  $ E = {2, 4, 6}, quad F = {1, 2, 3, 4}, quad G = {5, 6}. $
  #auto-parts(
    1,
    [Are $E$ and $F$ independent? Are they mutually exclusive?],
    [Are $E$ and $G$ independent? Are they mutually exclusive?],
    [Find two events that are mutually exclusive and check, using the
      test, that they are dependent.],
  )
][
  #auto-parts(
    1,
    [$p(E) = 1/2$ and $p(F) = 2/3$, while
      $E inter F = {2, 4}$ gives $p(E inter F) = 1/3$. Since
      $1/2 dot 2/3 = 1/3$, they *are* independent. They are certainly
      not mutually exclusive — they share two outcomes. This is the
      pair to remember: independence has nothing to do with overlap.],
    [$p(G) = 1/3$ and $E inter G = {6}$, so $p(E inter G) = 1/6$, while
      $p(E) dot p(G) = 1/2 dot 1/3 = 1/6$. Independent again, and
      again not mutually exclusive.],
    [For instance $E = {2, 4, 6}$ and $H = {1, 3}$, which cannot both
      occur. Then $p(E inter H) = 0$ but
      $p(E) dot p(H) = 1/2 dot 1/3 = 1/6 eq.not 0$, so they are
      dependent — exactly as the warning above predicts.],
  )
]

#ex(difficulty: 2, time: "12 min")[
  A die is rolled four times. What is the probability of getting at
  least one six?

  Solve it twice: once by the complement, and once by attempting to
  count the favorable outcomes directly. Then say which method you
  would want in an exam.
][
  *By the complement.* The four rolls are independent, and each avoids
  a six with probability $5/6$, so the product rule gives
  $ p("no six at all") = (5/6)^4 = 625/#num(1296), $
  and therefore
  $
    p("at least one six") = 1 - 625/#num(1296) = 671/#num(1296)
    approx 0.518.
  $

  *Directly.* The favorable outcomes are those with exactly one six,
  exactly two, exactly three, or exactly four, and each of those four
  cases has to be counted separately and then added — they are
  mutually exclusive, so adding is legitimate, but there are $671$
  outcomes to organize. Doing it needs tools from the counting
  chapter, and even then it is four calculations where the complement
  needed one.

  The complement, obviously. #heuristic("work backwards from the goal")

  Note also that the answer is close to but not equal to $1/2$: four
  rolls of a die give you slightly better than an even chance of a
  six. A common guess is $4 dot 1/6 = 2/3$, which is what you get by
  wrongly adding the probabilities of four events that are not
  mutually exclusive.
]

#ex(difficulty: 2, time: "12 min")[
  Three fair coins are tossed one at a time and the results recorded
  in order. Find the probability that
  #auto-parts(
    1,
    [there are more heads than tails,],
    [at least two heads are tossed consecutively,],
    [heads and tails alternate.],
  )
][
  Recording the tosses in order gives eight equally likely outcomes:
  $
    h h h, quad h h t, quad h t h, quad h t t, quad
    t h h, quad t h t, quad t t h, quad t t t.
  $
  #auto-parts(
    1,
    [More heads than tails means at least two heads: $h h h$, $h h t$,
      $h t h$, $t h h$. So $p = 4/8 = 1/2$.],
    [Two heads next to each other: $h h h$, $h h t$, $t h h$. So
      $p = 3/8$.],
    [Alternating: $h t h$ and $t h t$. So $p = 2/8 = 1/4$.],
  )
  Eight outcomes is few enough to list, and listing is the honest
  method here — parts 2 and 3 describe events with no tidy structure
  for a rule to exploit.
]

#ex(difficulty: 2, time: "12 min")[
  An urn holds $7$ red balls and $3$ black balls. A ball is drawn,
  its color noted, and *put back*; this is done three times. Find the
  probability that
  #auto-parts(
    1,
    [all three balls are red,],
    [exactly two of the three are black,],
    [at least one black ball is drawn.],
  )
][
  Because each ball is replaced, the urn is identical at every draw
  and the three draws are independent, with $p("red") = 0.7$ and
  $p("black") = 0.3$ throughout.
  #auto-parts(
    1,
    [$0.7^3 = 0.343$.],
    [Exactly two black can happen in three ways, according to which
      draw was red:
      $ b b r, quad b r b, quad r b b. $
      Each has probability $0.3 dot 0.3 dot 0.7 = 0.063$ by the
      product rule, and the three are mutually exclusive, so they add:
      $ 3 dot 0.063 = 0.189. $],
    [By the complement, $1 - p("no black") = 1 - 0.7^3
      = 1 - 0.343 = 0.657$.],
  )
  Part 2 is the pattern of this whole chapter in miniature: *multiply*
  along a sequence of independent stages, then *add* across mutually
  exclusive cases.
]

#only-high[
  #ex(difficulty: 3, level: "high", time: "10 min", hints: (
    "The event A splits into two pieces that cannot both happen: the part of A inside B, and the part of A outside B.",
    "Write that split as an equation about probabilities, then solve it for p(A ∩ B-bar).",
    "Only now use the assumption that A and B are independent.",
  ))[
    Show that if $A$ and $B$ are independent, then $A$ and
    $overline(B)$ are independent as well. Then say in words why this
    ought to be obvious before any algebra is done.
  ][
    The event $A$ occurs either together with $B$ or together with
    $overline(B)$, and never both, so those two pieces are mutually
    exclusive and make up all of $A$:
    $
      p(A) = p(A inter B) + p(A inter overline(B))
      arrow.r.double p(A inter overline(B)) = p(A) - p(A inter B).
    $
    Independence of $A$ and $B$ now lets us replace $p(A inter B)$:
    $
      p(A inter overline(B)) = p(A) - p(A) dot p(B)
      = p(A) dot (1 - p(B)) = p(A) dot p(overline(B)),
    $
    which is exactly the independence test for $A$ and $overline(B)$.

    In words: if learning whether $B$ happened tells you nothing about
    $A$, then learning whether $B$ *failed* to happen tells you
    nothing about $A$ either — it is the same piece of information,
    reported the other way round. Anything else would be strange.
  ]
]

== Techniques You Know So Far

#known-techniques(
  title: "Ways to find a probability",
  [Count equally likely outcomes: $p(A) = abs(A) slash abs(Omega)$],
  [Read the probabilities off a table, or work them out from a
    geometric argument],
  [The complement rule: $p(overline(A)) = 1 - p(A)$ — and its "at
    least one" special case],
  [The addition rule: $p(A union B) = p(A) + p(B) - p(A inter B)$,
    losing its last term when the events are mutually exclusive],
  [The product rule: $p(A inter B) = p(A) dot p(B)$, *only* when the
    events are independent],
)

#only-theory[
  Two of these carry a condition, and the conditions are what get
  forgotten. Counting requires equally likely outcomes; the product
  rule requires independence. Before using either, say out loud which
  one you are relying on and why it holds.
]

#ex(difficulty: 2, time: "12 min")[
  Two fair dice are rolled and both numbers recorded.
  #auto-parts(
    1,
    [What is the probability that at least one die shows a $4$ or
      that the sum is $10$?],
    [Which rule did you use, and what did you have to check before
      using it?],
    [What is the probability that at least one die shows a $4$ *and*
      the sum is $10$? Are those two events independent?],
  )
][
  There are $36$ equally likely ordered pairs. Let $F$ be "at least
  one die shows a $4$" and $S$ be "the sum is $10$".
  #auto-parts(
    1,
    [$F$ contains the six pairs with a $4$ first and the six with a
      $4$ second, less the pair $(4,4)$ counted twice, so
      $abs(F) = 11$. And $S = {(4,6), (5,5), (6,4)}$, so
      $abs(S) = 3$. The overlap is $F inter S = {(4,6), (6,4)}$, so
      $abs(F inter S) = 2$. The addition rule gives
      $ p(F union S) = (11 + 3 - 2)/36 = 12/36 = 1/3. $],
    [The addition rule, which needs no condition at all — that is
      exactly why it carries the $- p(F inter S)$ term. What did need
      checking is that the $36$ ordered pairs are equally likely,
      which is what lets every probability here be a count.],
    [$p(F inter S) = 2/36 = 1/18$. The test:
      $
        p(F) dot p(S) = 11/36 dot 3/36 = 33/#num(1296) = 11/432
        approx 0.0255,
      $
      while $1/18 approx 0.0556$. These differ, so $F$ and $S$ are
      dependent — unsurprisingly, since a sum of $10$ makes a $4$
      much more likely than it otherwise would be. Note the two dice
      are independent of each other; the *events* $F$ and $S$ are
      not. Independence is a property of events, not of equipment.],
  )
]

#ai-box(role: "Explainer")[
  Ask an AI assistant to explain the difference between *mutually
  exclusive* and *independent* events, and to give an example of two
  events that are one but not the other — in both directions.

  Then check its examples against the test yourself, with actual
  numbers. Specifically, check whether its "mutually exclusive but not
  independent" example really does have $p(A inter B) = 0$ while
  $p(A) dot p(B) > 0$.

  Finally, ask it whether two events can be *both* mutually exclusive
  and independent. There is an answer, and it is not "no" — work out
  what has to be true of $p(A)$ or $p(B)$ for both conditions to hold
  at once, and see whether the assistant finds it.
]

#look-ahead(preview: [conditional probability])[
  The product rule came with a condition attached, and every
  interesting problem eventually violates it. Draw a ball from an urn
  and *do not* put it back, and the second draw is no longer the same
  experiment as the first. Test the archery data and the events turn
  out to be dependent.

  What is needed is a version of the *and*-rule that works when the
  events do influence each other — and to write one down we first need
  a way of saying "the probability of $A$, given that $B$ has already
  happened". That is the next chapter, and it is the heart of the
  unit.
]

#print-hints()
#print-vocab()
