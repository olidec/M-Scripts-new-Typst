#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Conditional Probability")
#let ex = exercise.with(chapter: "Conditional Probability")

// ── A NOTE ON WHY THERE ARE NO VENN DIAGRAMS HERE ────────────
// The venn2() helper defined in ch-prob-rules is deliberately not
// repeated. Typst's `include` does not leak top-level bindings into
// the including document, so it would have to be duplicated — but
// more to the point, conditioning is the one thing a Venn diagram is
// bad at. A two-way table puts the conditioning row or column right
// there to be read off; a Venn diagram makes you mentally erase the
// rest of the rectangle. §2 makes that comparison explicitly rather
// than quietly, so students learn to reach for the table.
//
// If you'd rather have one Venn picture at the top of §1 for
// continuity, promote venn2() to preamble.typ and it becomes a
// one-line addition here.

= Conditional Probability

#only-theory[
  Every probability so far has been unconditional: a statement about
  an experiment whose result is entirely unknown. But information
  arrives. The first card is turned over, the first ball is drawn, the
  test result comes back — and the question is no longer what was
  likely at the start, but what is likely now.

  This is the most useful idea in the unit and the one most reliably
  got wrong, including by people whose jobs depend on getting it
  right.
]

#objectives(
  bfkm[calculate a conditional probability $p(A|B)$, from a table and
    from the formula],
  [explain conditioning as a change of sample space],
  [state clearly why $p(A|B)$ and $p(B|A)$ are different questions
    with different answers],
  [build a two-way table from percentages, and read conditional
    probabilities off it in both directions],
  bfkm[use the general multiplication rule
    $p(A sect B) = p(B) dot p(A|B)$],
  [recognize independence as the special case $p(A|B) = p(A)$],
  [explain why a test that is right $99%$ of the time can still be
    wrong most of the time it says yes],
  obj(level: "high")[write down the rule for reversing a condition and
    say where each of its pieces comes from],
)

== Conditioning Is a Change of Sample Space

#only-theory[
  Return to the year group from the last chapter: $100$ students, of
  whom $38$ do archery, $30$ play badminton and $16$ do both.

  Pick a student at random and the probability they do archery is
  $38 slash 100 = 0.38$. Now suppose someone tells you the student
  plays badminton. What is the probability they also do archery?

  The $70$ students who do not play badminton are no longer candidates
  — the information has removed them from consideration. What is left
  is the $30$ badminton players, and $16$ of those do archery:
  $ 16/30 = 8/15 approx 0.53. $
  Knowing about the badminton has pushed the probability of archery
  from $0.38$ up to $0.53$.
]

#keybox(title: "The idea in one sentence")[
  Conditioning on $B$ means throwing away everything outside $B$ and
  treating $B$ itself as the new sample space.
]

#only-theory[
  That sentence is the whole chapter; the formula is just what happens
  when you write it down. Both $16$ and $30$ were counts out of the
  same $100$, so dividing each by $100$ changes nothing:
  $ 16/30 = (16 slash 100)/(30 slash 100)
    = p(A sect B)/p(B). $
  The numerator counts the outcomes in the new sample space that also
  lie in $A$ — which is exactly $A sect B$.
]

#definition(title: "Conditional Probability")[
  The #vocab("conditional probability", "bedingte Wahrscheinlichkeit")
  of $A$ #vocab("given", "unter der Bedingung", show-de: false) $B$,
  written $p(A|B)$, is
  $ p(A|B) = p(A sect B) / p(B), quad "provided" p(B) > 0. $

  In words: of all the ways $B$ can happen, what fraction also has $A$
  happening? It is the same "favorable over possible" as before, with
  $B$ playing the part of $Omega$.
]

#remark[
  The condition $p(B) > 0$ is not a technicality to be skipped. There
  is no sensible answer to "given that something impossible happened,
  what follows?", and the formula reflects that by refusing to divide.

  Note also that the vertical bar is not division and not a
  set operation. $p(A|B)$ is a single symbol meaning one number; the
  bar is punctuation, and it is read "given".
]

#example[
  A fair die is rolled. Let $A$ be "the result is a $6$" and $B$ be
  "the result is even".
  $ p(A) = 1/6, quad p(B) = 1/2, quad p(A sect B) = 1/6, $
  so
  $ p(A|B) = (1 slash 6)/(1 slash 2) = 1/3. $
  Which is obvious once stated in words: told that the die came up
  even, you are choosing between $2$, $4$ and $6$.
]

== Two-Way Tables

#only-theory[
  A Venn diagram shows a conditional probability only if you mentally
  erase most of the picture. A table shows it directly: conditioning
  on a category means covering everything except that row or column,
  and reading what is left.

  This is why almost every real conditional-probability problem
  arrives as a table, and why building one is usually the first move.
]

#example(title: "Color blindness")[
  Researchers recorded $1000$ people in a small town by sex and by
  color blindness.

  #data-table(
    columns: (auto, auto, auto, auto),
    row-height: auto,
    [], [male], [female], [*total*],
    [color-blind], [$40$], [$2$], [*$42$*],
    [not color-blind], [$470$], [$488$], [*$958$*],
    [*total*], [*$510$*], [*$490$*], [*$1000$*],
  )

  Let $C$ be "color-blind" and $W$ be "female". Two questions that
  sound almost the same:

  *How likely is a woman to be color-blind?* Cover everything but the
  *female* column. It holds $490$ people, of whom $2$ are color-blind:
  $ p(C|W) = 2/490 = 1/245 approx 0.004. $

  *How likely is a color-blind person to be a woman?* Cover everything
  but the *color-blind* row. It holds $42$ people, of whom $2$ are
  women:
  $ p(W|C) = 2/42 = 1/21 approx 0.048. $

  The same $2$ people sit in the numerator both times. Everything that
  differs is the denominator — which is to say, everything that
  differs is what we agreed to condition on.
]

#warning[
  $p(A|B)$ and $p(B|A)$ are different numbers answering different
  questions. Above they differ by a factor of more than ten.

  Swapping them is not a slip of notation; it is a change of subject.
  "What fraction of women are color-blind" and "what fraction of
  color-blind people are women" are questions about different groups
  of people, and no amount of algebra will turn one answer into the
  other without more information.
]

#remark[
  This confusion has a name outside mathematics — the *prosecutor's
  fallacy* — because courtrooms are where it does the most damage.
  "The probability of this DNA match, if the defendant is innocent, is
  one in a million" is a statement about $p("match" | "innocent")$.
  It is routinely reported as though it said
  $p("innocent" | "match")$, which is a completely different number
  and usually a very much larger one.
]

#ex(difficulty: 2, time: "15 min")[
  A public health department interviewed $768$ students in grades
  10--12 about smoking and sorted them into three groups: smokers
  (more than a pack a week), occasional smokers (less than a pack a
  week) and non-smokers.

  #data-table(
    columns: (auto, auto, auto, auto, auto),
    row-height: auto,
    [], [smoker], [occasional], [non-smoker], [*total*],
    [male], [$127$], [$73$], [$214$], [*$414$*],
    [female], [$99$], [$66$], [$189$], [*$354$*],
    [*total*], [*$226$*], [*$139$*], [*$403$*], [*$768$*],
  )

  A student is picked at random from the study.
  #auto-parts(
    1,
    [Find the probability that the student is female; that the
      student is a male smoker; that the student is a non-smoker.],
    [Find the probability that the student is a non-smoker, given that
      she is female.],
    [What proportion of the whole study consists of non-smoking
      females? Explain why this is not the same as your answer to
      part 2.],
  )
][
  #auto-parts(
    1,
    [$p("female") = 354/768 approx 0.461$;
      $p("male and smoker") = 127/768 approx 0.165$;
      $p("non-smoker") = 403/768 approx 0.525$.],
    [Cover all but the female row: $354$ students, $189$ of them
      non-smokers, so
      $ p("non-smoker" | "female") = 189/354 approx 0.534. $],
    [$189/768 approx 0.246$. The numerator is the same $189$ students
      both times; the denominator is not. Part 2 asks what fraction
      *of the women* do not smoke, part 3 what fraction *of everyone*
      are non-smoking women. The first conditions on being female, the
      second does not.],
  )
]

#ex(difficulty: 2, time: "12 min")[
  In a survey, $100$ students were asked whether they prefer watching
  television or playing sport. The table was only partly filled in:

  #data-table(
    columns: (auto, auto, auto, auto),
    row-height: auto,
    [], [boys], [girls], [*total*],
    [television], [], [], [],
    [sport], [$33$], [$29$], [],
    [*total*], [*$46$*], [], [*$100$*],
  )

  #auto-parts(
    1,
    [Complete the table.],
    [Find the probability that a student chosen at random prefers
      television.],
    [Find the probability that a student prefers television, given
      that the student is a boy.],
  )
][
  #auto-parts(
    1,
    [Every row and column has to add up, which is enough to fix the
      whole table. There are $100 - 46 = 54$ girls; the sport row
      totals $33 + 29 = 62$; so the television row totals $38$, made
      up of $46 - 33 = 13$ boys and $54 - 29 = 25$ girls.

      #data-table(
        columns: (auto, auto, auto, auto),
        row-height: auto,
        [], [boys], [girls], [*total*],
        [television], [$13$], [$25$], [*$38$*],
        [sport], [$33$], [$29$], [*$62$*],
        [*total*], [*$46$*], [*$54$*], [*$100$*],
      )],
    [$38/100 = 0.38$.],
    [Restrict to the boys' column, which holds $46$ students, of whom
      $13$ prefer television:
      $ p("television" | "boy") = 13/46 approx 0.283. $
      Boys prefer television noticeably less often than the group as a
      whole does.],
  )
]

#ex(difficulty: 3, time: "15 min", hints: (
  "Add a totals row and a totals column to the table before you calculate anything.",
  "For part 1(iii), 'or' is inclusive — do not count the non-defective components from machine I twice.",
  "For part 2, compare p(defective) with p(defective | machine I). If the machine made no difference, what would you expect?",
))[
  Three machines work independently to produce the same component.
  After one production run:

  #data-table(
    columns: (auto, auto, auto),
    row-height: auto,
    [], [defective], [non-defective],
    [machine I], [$6$], [$120$],
    [machine II], [$4$], [$80$],
    [machine III], [$10$], [$150$],
  )

  + One component is chosen at random from the whole run. Find the
    probability that it is
    #auto-parts(
      2,
      [from machine I,],
      [a defective component from machine II,],
      [non-defective or from machine I,],
      [from machine I, given that it is defective.],
    )
  + Is the quality of a component independent of the machine that made
    it?
][
  Totalling first: the machines produced $126$, $84$ and $160$
  components, so the run is $370$ components, of which $20$ are
  defective and $350$ are not.

  + #auto-parts(
      2,
      [$126/370 = 63/185 approx 0.341$.],
      [$4/370 = 2/185 approx 0.011$.],
      [Inclusive *or*, so use the addition rule and do not
        double-count machine I's good components:
        $ (350 + 126 - 120)/370 = 356/370 = 178/185 approx 0.962. $],
      [Restrict to the $20$ defective components; $6$ came from
        machine I:
        $ p("I" | "defective") = 6/20 = 3/10. $],
    )
  + No. Overall $p("defective") = 20/370 = 2/37 approx 0.054$, while
    for machine I alone
    $ p("defective" | "I") = 6/126 = 1/21 approx 0.048. $
    These differ, so knowing which machine made a component changes
    the chance it is faulty. Machine III is the worst offender —
    $10/160 = 0.0625$ — and worth investigating.
]

== The Multiplication Rule

#only-theory[
  The last chapter's product rule needed the events to be independent,
  which most interesting events are not. Rearranging the definition of
  conditional probability removes that restriction at no cost.
]

#keybox(title: "The general multiplication rule")[
  For any two events with $p(B) > 0$,
  $ p(A sect B) = p(B) dot p(A|B), $
  and equally, when $p(A) > 0$,
  $ p(A sect B) = p(A) dot p(B|A). $

  In words: the chance that both happen is the chance that the first
  happens, times the chance that the second happens *given* that it
  did.
]

#only-theory[
  This is the rule the whole of the next chapter runs on. Every path
  through a tree diagram is a chain of these factors multiplied
  together.

  It also puts independence in its proper place. If $A$ and $B$ are
  independent then knowing about $B$ changes nothing about $A$, so
  $p(A|B) = p(A)$ — and substituting that into the rule above returns
  $p(A sect B) = p(A) dot p(B)$, the special case we started with.
]

#keybox(title: "Three ways to say the same thing")[
  For events of positive probability, these are equivalent:
  #auto-parts(
    1,
    [$A$ and $B$ are independent;],
    [$p(A|B) = p(A)$;],
    [$p(A sect B) = p(A) dot p(B)$.],
  )
  The second is the most meaningful — it says the information is
  worthless — and the third is the easiest to check.
]

#ex(difficulty: 2, time: "12 min")[
  Two events satisfy $p(A) = 7/10$, $p(A union B) = 9/10$ and
  $p(A sect B) = 3/10$. Find
  #auto-parts(
    3,
    [$p(B)$,],
    [$p(overline(B) sect A)$,],
    [$p(B sect overline(A))$,],
    [$p(overline(B) sect overline(A))$,],
    [$p(B|A)$.],
  )
][
  #auto-parts(
    2,
    [From the addition rule,
      $p(B) = 9/10 - 7/10 + 3/10 = 5/10 = 1/2$.],
    [The part of $A$ outside $B$: $7/10 - 3/10 = 4/10 = 2/5$.],
    [The part of $B$ outside $A$: $5/10 - 3/10 = 2/10 = 1/5$.],
    [Outside both is outside the union: $1 - 9/10 = 1/10$.],
    [$ p(B|A) = p(A sect B)/p(A)
       = (3 slash 10)/(7 slash 10) = 3/7. $],
  )
  A check: the four regions $3/10$, $2/5$, $1/5$, $1/10$ add to $1$,
  as they must.
]

#ex(difficulty: 2, time: "12 min")[
  Two events satisfy $p(A|B) = 0.30$, $p(B|A) = 0.60$ and
  $p(A sect B) = 0.18$.
  #auto-parts(
    1,
    [Find $p(B)$ and $p(A)$.],
    [Are $A$ and $B$ independent? Justify your answer.],
    [Find $p(B sect overline(A))$.],
  )
][
  #auto-parts(
    1,
    [Read the multiplication rule backwards, in both directions:
      $ p(B) = p(A sect B)/p(A|B) = 0.18/0.30 = 0.6, quad
        p(A) = p(A sect B)/p(B|A) = 0.18/0.60 = 0.3. $],
    [Yes: $p(A) dot p(B) = 0.3 dot 0.6 = 0.18 = p(A sect B)$. It could
      have been spotted a step earlier — $p(A|B) = 0.30 = p(A)$, which
      is the statement that $B$ tells you nothing about $A$.],
    [$p(B) - p(A sect B) = 0.6 - 0.18 = 0.42$.],
  )
]

#ex(difficulty: 2, time: "12 min")[
  Two events satisfy $p(A) = 9/16$, $p(B) = 3/8$ and
  $p(A|B) = 1/4$. Find the probability that
  #auto-parts(
    1,
    [both events happen,],
    [exactly one of the two happens,],
    [neither happens.],
  )
][
  #auto-parts(
    1,
    [The multiplication rule turns the conditional probability into an
      intersection:
      $ p(A sect B) = p(B) dot p(A|B) = 3/8 dot 1/4 = 3/32. $],
    [First the union:
      $ p(A union B) = 9/16 + 3/8 - 3/32
        = 18/32 + 12/32 - 3/32 = 27/32. $
      "Exactly one" is the union with the overlap removed:
      $ 27/32 - 3/32 = 24/32 = 3/4. $],
    [$1 - 27/32 = 5/32$.],
  )
]

#ex(difficulty: 2, time: "10 min")[
  An airline is proud of its punctuality. The probability that a
  scheduled flight departs on time is $p(D) = 0.83$; that it arrives
  on time is $p(A) = 0.92$; and that it both departs and arrives on
  time is $p(A sect D) = 0.78$. Find the probability that a flight
  #auto-parts(
    1,
    [arrives on time, given that it departed on time,],
    [departed on time, given that it arrived on time,],
    [and decide whether arriving on time and departing on time are
      independent.],
  )
][
  #auto-parts(
    1,
    [$p(A|D) = 0.78/0.83 approx 0.940$.],
    [$p(D|A) = 0.78/0.92 approx 0.848$.],
    [$p(A) dot p(D) = 0.92 dot 0.83 = 0.7636$, which is not $0.78$, so
      the events are dependent. Sensibly so: a flight that leaves late
      has less chance of arriving on time, which is why $p(A|D)$ at
      $0.940$ sits above the unconditional $p(A) = 0.92$.],
  )
]

#only-high[
  #ex(difficulty: 3, level: "high", time: "12 min")[
    Two independent events satisfy $p(A) = k$, $p(B) = k + 0.3$ and
    $p(A sect B) = 0.18$.
    #auto-parts(
      1,
      [Find $k$.],
      [Find $p(A union B)$.],
      [Find $p(overline(A) | overline(B))$.],
    )
  ][
    #auto-parts(
      1,
      [Independence gives $p(A) dot p(B) = p(A sect B)$, so
        $ k dot (k + 0.3) = 0.18
          arrow.r.double k^2 + 0.3 k - 0.18 = 0. $
        The quadratic formula gives $k = 0.3$ or $k = -0.6$, and a
        probability cannot be negative, so $k = 0.3$ and
        $p(B) = 0.6$.],
      [$p(A union B) = 0.3 + 0.6 - 0.18 = 0.72$.],
      [The last chapter's SPF exercise showed that independence of $A$
        and $B$ carries over to $overline(A)$ and $overline(B)$. So
        conditioning on $overline(B)$ tells us nothing:
        $ p(overline(A) | overline(B)) = p(overline(A))
          = 1 - 0.3 = 0.7. $
        The alternative is to compute
        $p(overline(A) sect overline(B)) = 1 - 0.72 = 0.28$ and divide
        by $p(overline(B)) = 0.4$, which gives $0.7$ as well.],
    )
  ]

  #ex(difficulty: 3, level: "high", time: "10 min")[
    Give an example of two events with $p(A|B) = p(B|A)$ where neither
    probability is $0$. Then find every case in which this happens.
  ][
    Roll two dice; let $A$ be "the first is even" and $B$ "the second
    is even". Both conditional probabilities equal $1/2$.

    In general, writing both sides out,
    $ p(A|B) = p(A sect B)/p(B) quad "and" quad
      p(B|A) = p(A sect B)/p(A), $
    two fractions with the same numerator. If that numerator is not
    zero, they are equal exactly when the denominators are:
    $ p(A|B) = p(B|A) arrow.l.r.double p(A) = p(B). $
    So the condition has nothing to do with independence or with
    overlap — it is simply that the two events are equally likely to
    begin with. (The excluded case $p(A sect B) = 0$ makes both sides
    $0$ regardless.)
  ]
]

== Base Rates: Why Good Tests Give Bad Answers

#only-theory[
  A test for a disease is described by two numbers. Its
  #vocab("sensitivity", "Sensitivität") is the probability that it
  comes back positive for someone who has the disease; its
  #vocab("specificity", "Spezifität") is the probability that it comes
  back negative for someone who does not.

  Suppose a test for a certain infection has sensitivity $99.9%$ and
  specificity $99.5%$. You take it. It is positive. How worried should
  you be?
]

#only-theory[
  Almost nobody reasons about this well using fractions. The reliable
  method is to stop working with probabilities and start counting
  people — invent a population large enough to make every group a
  whole number, and fill in a table. #heuristic("draw a picture")

  About $0.2%$ of the Swiss population carries this infection, so in
  a million people we expect $2000$ infected and $998'000$ not. Of the
  $2000$ infected, the test catches $99.9%$, so $1998$ test positive.
  Of the $998'000$ healthy people, $99.5%$ correctly test negative,
  which leaves $0.5%$ — that is $4990$ people — testing positive
  anyway.

  #data-table(
    columns: (auto, auto, auto, auto),
    row-height: auto,
    [], [tests positive], [tests negative], [*total*],
    [infected], [$#num(1998)$], [$2$], [*$#num(2000)$*],
    [not infected], [$#num(4990)$], [$#num(993010)$],
    [*$#num(998000)$*],
    [*total*], [*$#num(6988)$*], [*$#num(993012)$*],
    [*$#num(1000000)$*],
  )

  Now read off the answer by covering all but the "tests positive"
  column. It holds $#num(6988)$ people, of whom $#num(1998)$ are
  actually infected:
  $ p("infected" | "positive") = #num(1998)/#num(6988)
    approx 0.286. $
]

#keybox(title: "The base rate")[
  A positive result from a test that is right well over $99%$ of the
  time leaves you about $29%$ likely to have the disease, and about
  $71%$ likely not to.

  Nothing is wrong with the test. What dominates the answer is the
  #vocab("base rate", "Basisrate") — how rare the disease is to begin
  with. Because the healthy group is five hundred times larger than
  the infected group, even a very small error rate applied to it
  produces more false positives than there are true ones.
]

#warning[
  The two numbers that describe the test are both conditional
  probabilities, and both are conditioned the wrong way round for the
  question a patient is asking.

  The test reports $p("positive" | "infected")$. The patient wants
  $p("infected" | "positive")$. Getting from one to the other requires
  a third number the test itself never mentions — the base rate — and
  no amount of improving the test will remove that requirement.
]

#remark[
  This is why screening programs are designed the way they are: a
  cheap, sensitive first test to rule people out, followed by a
  second, more specific test applied only to those who tested
  positive. The second test is not run on a population where the
  disease is rare — it is run on a group in which nearly $30%$ have
  it, and against that base rate its positive result means a great
  deal more.

  It is also why "the test is $99%$ accurate" is a sentence that
  carries almost no information on its own.
]

#look-ahead(preview: [tree diagrams])[
  Building a population and counting is dependable but inflexible —
  change the base rate and the whole table has to be rebuilt. The next
  chapter draws the same calculation as a tree, where the base rate
  sits on the first pair of branches and can be altered without
  touching anything else.

  It is worth working the infection example both ways once, to see
  that the tree and the table are the same object drawn differently.
]

#ex(difficulty: 2, time: "15 min")[
  There is a test for a cat allergy. For people who really have the
  allergy, it reports the allergy $80%$ of the time. For people who do
  not have it, it reports the allergy anyway $10%$ of the time.

  Suppose $1%$ of the population is allergic to cats.
  #auto-parts(
    1,
    [Build a table for a population of $#num(10000)$ people.],
    [You test positive. What is the probability that you are actually
      allergic?],
    [The test is wrong only $20%$ of the time for allergic people and
      $10%$ of the time for everyone else. Explain, in a sentence,
      why the answer to part 2 is nevertheless so small.],
  )
][
  #auto-parts(
    1,
    [Of $#num(10000)$ people, $100$ are allergic and $9900$ are not.
      The test reports the allergy for $80$ of the $100$, and for
      $10%$ of the $9900$, which is $990$ people.

      #data-table(
        columns: (auto, auto, auto, auto),
        row-height: auto,
        [], [tests positive], [tests negative], [*total*],
        [allergic], [$80$], [$20$], [*$100$*],
        [not allergic], [$990$], [$#num(8910)$], [*$#num(9900)$*],
        [*total*], [*$#num(1070)$*], [*$#num(8930)$*],
        [*$#num(10000)$*],
      )],
    [Restrict to the $#num(1070)$ people who tested positive; $80$ of
      them are allergic:
      $ p("allergic" | "positive") = 80/#num(1070) approx 0.0748, $
      or about $7.5%$.],
    [Because the non-allergic group is $99$ times bigger. Ten percent
      of a very large group is a much larger number of people than
      eighty percent of a very small one — $990$ against $80$ — so
      most positive results come from healthy people simply because
      there are so many more of them.],
  )
]

#ex(difficulty: 2, time: "12 min")[
  In a study of $100$ people, $40$ consumed more than $5 "g"$ of salt
  a day. Half of that group had high blood pressure. Among the
  remaining people, $15%$ had high blood pressure.
  #auto-parts(
    1,
    [Show the data in a two-way table.],
    [What proportion of the people with high blood pressure are heavy
      salt consumers?],
    [Which conditional probability did the question in part 2 ask for,
      and which one did the first paragraph give you?],
  )
][
  #auto-parts(
    1,
    [Half of the $40$ heavy consumers is $20$; $15%$ of the remaining
      $60$ is $9$.

      #data-table(
        columns: (auto, auto, auto, auto),
        row-height: auto,
        [], [high blood pressure], [normal], [*total*],
        [more than $5 "g"$ salt], [$20$], [$20$], [*$40$*],
        [$5 "g"$ salt or less], [$9$], [$51$], [*$60$*],
        [*total*], [*$29$*], [*$71$*], [*$100$*],
      )],
    [Restrict to the $29$ people with high blood pressure, of whom
      $20$ are heavy salt consumers:
      $ p("much salt" | "high blood pressure") = 20/29 approx 0.690. $],
    [Part 2 asks for
      $p("much salt" | "high blood pressure")$; the data gave
      $p("high blood pressure" | "much salt") = 0.5$. The two differ
      substantially — $0.69$ against $0.50$ — and the reason is the
      unequal group sizes, exactly as in the medical test above.

      Notice also what neither number says: nothing here shows that
      salt *causes* high blood pressure. This is an observational
      study, and the two groups may differ in a dozen other ways.],
  )
]

#only-high[
  === Reversing a Condition

  #only-theory[
    The table method works because it computes both sides of the
    multiplication rule. Writing that out gives the reversal in one
    line. Since $p(A sect B)$ can be split either way,
    $ p(B) dot p(A|B) = p(A sect B) = p(A) dot p(B|A), $
    and dividing by $p(A)$ turns a condition around:
    $ p(B|A) = (p(A|B) dot p(B)) / p(A). $

    This is *Bayes' rule*, named for Thomas Bayes, whose paper on it
    was published in 1763, two years after he died. Every piece of it
    has already appeared in the table: $p(B)$ is the base rate,
    $p(A|B)$ is the test's sensitivity, and $p(A)$ — the probability
    of testing positive at all — is the column total, which is itself
    assembled from both rows.

    The formula is worth recognizing, but for an actual calculation,
    build the table. It is harder to misremember a table.
  ]
]

#ai-box(role: "Checker")[
  Give an AI assistant the medical test from this section — but change
  the numbers: sensitivity $95%$, specificity $90%$, and a disease
  carried by $1$ person in $500$. Ask for the probability that someone
  who tests positive has the disease.

  Work it out yourself first by building a population of $#num(100000)$
  and counting. Then compare.

  Whatever answer it gives, ask a follow-up: _what would the answer be
  if the disease affected 1 person in 5 instead?_ The test has not
  changed at all, so if the assistant's second answer is not
  dramatically larger than its first, it is not using the base rate —
  it is pattern-matching to a problem it has seen before. Watch for a
  reply that quotes the sensitivity, $95%$, as the answer to the
  original question. That is the prosecutor's fallacy, and it is the
  single most common way this problem is got wrong.
]

#look-ahead(preview: [inferential statistics])[
  The base-rate lesson has a life well beyond medicine. Any time a
  rare thing is searched for in a large population — fraud in
  transactions, a security threat in airport screening, a rare fault
  on a production line — most of the alarms will be false, no matter
  how good the detector is.

  In the final unit this returns wearing a different hat. A
  statistical test that rejects a hypothesis at the $5%$ level is
  making exactly the claim a medical test makes, with exactly the same
  gap between $p("data" | "hypothesis")$ and
  $p("hypothesis" | "data")$ — and exactly the same consequences for
  anyone who confuses the two.
]

#print-hints()
#print-vocab()
