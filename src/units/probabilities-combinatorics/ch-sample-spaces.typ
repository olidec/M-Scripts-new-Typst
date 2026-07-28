#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Sample Spaces and Events")
#let ex = exercise.with(chapter: "Sample Spaces and Events")

// ── IMAGE NOTE ───────────────────────────────────────────────
// One figure from the old LaTeX img/ folder is used here. Copy it
// into ./images/ and rename per STYLE_GUIDE.md §7:
//   spinner → spinner-four-sectors.png
// The #image call is commented out below so the chapter compiles
// before the file is in place.
//
// The spinner is worth keeping as an image (a four-sector disc with a
// pointer is fiddly to draw natively and the drawing carries no
// pedagogical weight of its own), but §4 is written so that the angle
// table below it stands on its own if the picture is missing.

// ── NOTATION (settled — keep consistent across the whole unit) ──
// B ⊂ A (Typst `subset`) is the house symbol for "B is a subset of
// A", used INCLUSIVELY: it allows B = A, and ∅ ⊂ A holds for every
// set. This is the notation used in lessons and in the German-
// language materials, so it is what students see on the board.
// Some international texts instead reserve ⊂ for STRICT inclusion
// and write ⊆ for the inclusive relation. The remark after the
// subset definition warns students about that, so an outside source
// doesn't catch them out. Do not switch to ⊆ in later chapters —
// ⊂ appears in every chapter from here on.

= Sample Spaces and Events

#only-theory[
  The last chapter left probability defined but not calculable: the
  number that a relative frequency approaches, which is fine as a
  meaning and useless as a method. Nobody wants to toss a coin
  #num(10000) times to discover something they could have reasoned out
  in a line.

  Reasoning it out requires being precise about two things: what the
  possible outcomes of an experiment are, and which of them count as
  the event we care about. Both are collections of things, so the
  language we need is the language of sets.
]

#objectives(
  [use the set operations — union, intersection, difference,
    complement — and read the symbols for them],
  [write down the sample space of a random experiment, and describe an
    event as a subset of it],
  [explain why the same experiment can have several different sample
    spaces, and why the choice matters],
  bfkm[calculate the probability of an event when all outcomes are
    equally likely],
  [say why the equally-likely rule fails when it fails, and recognize
    the standard trap],
  [work with a probability distribution given as a table, and check it
    for consistency],
  obj(level: "high")[write down the power set of a small set and
    explain why a set with $n$ elements has $2^n$ subsets],
)

== The Language of Sets

#only-theory[
  You have met sets before; this section fixes notation rather than
  teaching anything new. Read it quickly and come back when a symbol
  stops being obvious.
]

#definition(title: "Set")[
  A #vocab("set", "Menge") is a collection of distinct objects, called
  its #vocab("elements", "Elemente", show-de: false). Sets are usually
  named with capital letters and written between braces:
  $ A = {1, 2, 3}. $
  A set with no elements at all is the
  #vocab("empty set", "leere Menge"), written $emptyset$.

  The number of elements of $A$ is its
  #vocab("cardinality", "Mächtigkeit"), written $abs(A)$.
]

#example[
  #auto-parts(
    1,
    [$A = {1, 2, 3}$, so $abs(A) = 3$.],
    [$B = {2, 4, 6, dots}$, the even numbers. $B$ is infinite.],
    [$C = {"John", "Paul", "George", "Ringo"}$, so $abs(C) = 4$.],
    [$D = {A, B, C}$ — a set whose three elements are themselves sets,
      so $abs(D) = 3$.],
    [$abs(emptyset) = 0$.],
  )
]

#remark[
  "Distinct" is doing real work in that definition. A set records
  which objects are in it and nothing else — not how many times, not
  in what order. So ${1, 2, 2, 3}$ and ${3, 1, 2}$ are the same set as
  ${1, 2, 3}$. This is exactly the property that will make sets the
  wrong tool in a few chapters' time, when we start caring about order
  and repetition and have to build something else.
]

#definition(title: "Subset")[
  $B$ is a #vocab("subset", "Teilmenge") of $A$, written
  $B subset A$, if every element of $B$ is also an element of $A$.

  Every set has at least two subsets: itself and the empty set.
  $
    emptyset subset A quad "and" quad A subset A
    quad "for every set" A.
  $
]

#remark[
  Some international textbooks reserve $subset$ for _strict_
  inclusion — meaning $B subset A$ but $B eq.not A$, in the same way
  that $<$ is the strict version of $<=$ — and write $subset.eq$ when
  equality is allowed. This course makes no such distinction:
  $B subset A$ always allows $B = A$. If you meet $subset.eq$ in
  another book, it means what $subset$ means here.
]

#only-theory[
  Three operations combine sets. All three will reappear within a page
  as operations on events, which is the only reason we are doing this.
]

#keybox(title: "Union, intersection, difference")[
  / $A union B$: the #vocab("union", "Vereinigung") — everything that
    is in $A$ *or* in $B$ (or in both).

  / $A inter B$: the #vocab("intersection", "Schnittmenge") —
    everything that is in $A$ *and* in $B$.

  / $A without B$: the #vocab("difference", "Differenz") — everything
    that is in $A$ but *not* in $B$.
]

#example[
  With $A = {1, 2, 3}$ and $B = {2, 4, 6}$:
  $
    A union B = {1, 2, 3, 4, 6}, quad A inter B = {2}, quad
    A without B = {1, 3}.
  $
]

#warning[
  Union and intersection do not care about the order of $A$ and $B$.
  Difference does:
  $ B without A = {4, 6} eq.not {1, 3} = A without B. $
  Subtracting sets is no more symmetric than subtracting numbers.
]

#definition(title: "Disjoint Sets")[
  Two sets are #vocab("disjoint", "disjunkt") if they have no element
  in common, that is, if $A inter B = emptyset$.
]

#only-high[
  === Power Sets

  Collecting all the subsets of a set gives a new set, one level up.

  #definition(title: "Power Set")[
    The #vocab("power set", "Potenzmenge") of $A$, written $cal(P)(A)$,
    is the set of *all* subsets of $A$.
  ]

  #example[
    For $A = {1, 2, 3}$:
    $
      cal(P)(A) = {emptyset, {1}, {2}, {3}, {1, 2}, {1, 3},
        {2, 3}, {1, 2, 3}},
    $
    so $abs(cal(P)(A)) = 8 = 2^3$. That is no accident: building a
    subset means deciding, for each of the $abs(A)$ elements
    separately, whether it goes in. Each element offers two choices,
    and the choices are independent of one another, so
    $ abs(cal(P)(A)) = 2^(abs(A)). $
  ]

  #look-ahead(preview: [counting])[
    That last argument — "two choices for each of $n$ items, so $2^n$
    altogether" — is the whole of combinatorics in miniature. Nothing
    in the counting chapter is harder than this; there is just more of
    it.
  ]
]

#ex(difficulty: 1, time: "8 min")[
  Let $Omega = {1, 2, 3, dots, 12}$, let $A$ be the multiples of $3$
  in $Omega$ and let $B$ be the even numbers in $Omega$.
  #auto-parts(
    2,
    [List $A$ and $B$.],
    [Find $A union B$ and $abs(A union B)$.],
    [Find $A inter B$.],
    [Find $A without B$ and $B without A$.],
    [Are $A$ and $B$ disjoint?],
    [Find a non-empty subset of $Omega$ disjoint from both.],
  )
][
  #auto-parts(
    2,
    [$A = {3, 6, 9, 12}$ and $B = {2, 4, 6, 8, 10, 12}$.],
    [$A union B = {2, 3, 4, 6, 8, 9, 10, 12}$, so
      $abs(A union B) = 8$. Note $8 eq.not abs(A) + abs(B) = 10$: the
      two elements of the intersection would otherwise be counted
      twice.],
    [$A inter B = {6, 12}$.],
    [$A without B = {3, 9}$ and $B without A = {2, 4, 8, 10}$.],
    [No — $A inter B eq.not emptyset$.],
    [Any set of numbers that are neither even nor multiples of three,
      for instance ${1, 5, 7, 11}$ or just ${7}$.],
  )
]

== Random Experiments, Outcomes and Events

#definition(title: "Experiment, Sample Space, Event")[
  An #vocab("experiment", "Versuch") is any process that produces an
  #vocab("outcome", "Ergebnis"). It is a
  #vocab("random experiment", "Zufallsexperiment") if the outcome is
  not certain in advance.

  The #vocab("sample space", "Ergebnisraum") of a random experiment is
  the set $Omega$ of *all* its possible outcomes.

  An #vocab("event", "Ereignis") is a subset of the sample space:
  a collection of outcomes we have some reason to group together.
]

#remark[
  $Omega$ is a capital omega, the last letter of the Greek alphabet.
  Some English-language books write $S$ (for _sample space_) instead;
  the two mean the same thing. This course uses $Omega$.
]

#warning[
  An outcome is an *element* of $Omega$. An event is a *subset* of
  $Omega$. These are different kinds of object, and the difference is
  not pedantry — you can take unions and intersections of events, and
  you cannot do that to outcomes.

  When a single outcome is the event of interest, write it as the
  one-element set it is: the event "the die shows a four" is ${4}$,
  not $4$.
]

#example(title: "Three experiments")[
  / Toss a coin twice and record both results: With $h$ for heads and
    $t$ for tails,
    $ Omega = {(h, h), (h, t), (t, h), (t, t)}, quad abs(Omega) = 4. $
    The event "both tosses agree" is $A = {(h, h), (t, t)}$.

  / Toss a coin twice and record how many heads: Now
    $ Omega = {0, 1, 2}, quad abs(Omega) = 3. $
    The event "at least one head" is $A = {1, 2}$.

  / Roll a standard six-sided die: $Omega = {1, 2, 3, 4, 5, 6}$. The
    event "even" is $A = {2, 4, 6}$; the event "less than five" is
    $B = {1, 2, 3, 4}$.
]

#keybox(title: "The sample space is a choice, not a fact")[
  The first two experiments above are the *same physical action* —
  toss a coin twice — with different sample spaces, because they
  record different things.

  A sample space is not something an experiment has. It is something
  you decide, when you decide what to write down. Different decisions
  give different sample spaces, and as the next two sections show,
  some of those decisions are far more useful than others.
]

#only-high[
  === Writing It Formally

  The individual outcomes in $Omega$ are usually written with a
  lower-case omega and an index:
  $ Omega = {omega_1, omega_2, omega_3, dots, omega_n}. $
  An event $A$ is a subset of $Omega$, which is the same as saying it
  is an element of the power set:
  $ A subset Omega quad "or equivalently" quad A in cal(P)(Omega). $
  So for the die, there are $2^6 = 64$ different events — including
  $emptyset$ (the event that nothing happens) and $Omega$ itself (the
  event that something does).
]

#ex(difficulty: 1, time: "5 min")[
  A coin and a standard six-sided die are thrown, and the face of the
  coin and the number on the die are recorded, in that order. Write
  down the sample space and its cardinality.
][
  $
    Omega = {(h, 1), (h, 2), (h, 3), (h, 4), (h, 5), (h, 6),
      (t, 1), (t, 2), (t, 3), (t, 4), (t, 5), (t, 6)},
  $
  so $abs(Omega) = 12$. Two possibilities for the coin, six for the
  die, and every combination of the two occurs exactly once.
]

#ex(difficulty: 2, time: "12 min")[
  A box holds three balls: one blue, one green, one yellow. You draw a
  ball, note its color, put it back, and draw again.
  + Write down the sample space.
  + Write down the event $Y$ that the first ball is yellow.
  + Write down the event $T$ that both balls have the same color.
  + Now repeat all three parts for the version of the experiment in
    which the first ball is *not* replaced.
][
  Writing $b$, $g$, $y$ for the colors and recording the two draws in
  order:
  + $Omega = {(b, b), (b, g), (b, y), (g, b), (g, g), (g, y),
      (y, b), (y, g), (y, y)}$, with $abs(Omega) = 9$.
  + $Y = {(y, b), (y, g), (y, y)}$.
  + $T = {(b, b), (g, g), (y, y)}$.
  + Without replacement the three repeats disappear:
    $ Omega = {(b, g), (b, y), (g, b), (g, y), (y, b), (y, g)}, $
    with $abs(Omega) = 6$. Then $Y = {(y, b), (y, g)}$, and
    $T = emptyset$ — an event that is possible in the first version of
    the experiment and impossible in the second. Changing the
    procedure changed the sample space, and with it what can happen at
    all.
]

== Equally Likely Outcomes

#only-theory[
  Chapter 1 listed three sources of a probability, and put symmetry
  first. Here is what symmetry buys.

  If nothing distinguishes the outcomes of an experiment from one
  another — the six faces of a fair die, the 52 cards of a shuffled
  deck — then no outcome can be more likely than any other. They share
  a total probability of $1$ equally between them, and computing a
  probability collapses into counting.
]

#keybox(title: "The equally likely case")[
  If all $abs(Omega)$ outcomes of a random experiment are equally
  likely, then for every event $A$
  $
    p(A) = abs(A) / abs(Omega)
    = "number of favorable cases" / "number of possible cases".
  $
]

#example[
  A fair die is rolled, so $Omega = {1, 2, 3, 4, 5, 6}$ and
  $abs(Omega) = 6$.

  #auto-parts(
    1,
    [$A$: "a four". Then $A = {4}$, $abs(A) = 1$ and
      $p(A) = 1/6$.],
    [$B$: "a prime number". Then $B = {2, 3, 5}$, $abs(B) = 3$ and
      $p(B) = 3/6 = 1/2$.],
    [$C$: "a nine". Then $C = emptyset$, $abs(C) = 0$ and
      $p(C) = 0/6 = 0$.],
  )
]

#keybox(title: "Three consequences")[
  For every event $A$ of any random experiment:
  #auto-parts(
    1,
    [$0 <= p(A) <= 1$. There is no such thing as a negative
      probability, and none larger than $1$, however strongly you
      feel about the event.],
    [$p(emptyset) = 0$ and $p(Omega) = 1$. Something has to happen,
      and it has to be one of the things on the list.],
    [The probabilities of all the individual outcomes add up to $1$.],
  )
]

#warning[
  The counting rule holds *only* when the outcomes are equally likely.
  It is not a definition of probability; it is a shortcut available
  under one specific condition, and applying it without checking that
  condition is the single most common mistake in this subject.

  Every "number of favorable cases over number of possible cases"
  calculation you write should be preceded by an answer to the
  question: _equally likely — why?_
]

#ex(difficulty: 2, time: "10 min")[
  A student argues: "Toss a coin twice. There are three possible
  outcomes — two heads, two tails, or one of each. So each has
  probability $1/3$."
  + Which sample space is the student using?
  + Toss two coins thirty times and record how often each of the three
    outcomes occurs. What do you find?
  + Explain exactly where the argument breaks down.
][
  + $Omega = {"two heads", "one of each", "two tails"}$, which is a
    perfectly legitimate sample space — the student's error is not
    there.
  + "One of each" comes up about half the time, not a third.
  + The three outcomes are not equally likely, so the counting rule
    does not apply to this sample space. Recording the two tosses
    separately gives
    $ Omega' = {(h, h), (h, t), (t, h), (t, t)}, $
    whose four outcomes *are* equally likely, by the symmetry of the
    coin and the fact that the tosses do not affect each other. Two of
    those four give "one of each", so its probability is
    $2/4 = 1/2$, against $1/4$ each for the other two.

    The student's sample space is correct and their counting is
    correct. What is missing is the check that the rule applies.
]

#remark[
  This is not a beginner's mistake in any embarrassing sense.
  D'Alembert published it in the _Encyclopédie_ in 1754, arguing that
  the probability of getting at least one head in two tosses is $2/3$
  rather than $3/4$, and he was one of the finest mathematicians in
  Europe. The trap is genuinely well made.
]

#only-theory[
  The fix in that exercise is the move worth remembering, and it works
  far beyond coins:

  #keybox(title: "Refining the sample space")[
    If the outcomes you are recording are not equally likely, look for
    a *finer* experiment — one that records more detail — whose
    outcomes are equally likely. Compute there, then translate back.
  ]

  Going from "how many heads" to "which coin showed what" throws away
  no information and buys symmetry. Almost every probability
  calculation in the next four chapters is this move in some disguise.
]

#ex(difficulty: 1, time: "8 min")[
  Chips numbered $1$ to $20$ are placed in a box and one is drawn at
  random.
  #auto-parts(
    1,
    [What is the probability that the number is a multiple of $3$?],
    [What is the probability that the number is not a multiple of $4$?],
  )
][
  All twenty chips are equally likely, so $abs(Omega) = 20$ and the
  counting rule applies.
  #auto-parts(
    1,
    [The multiples of three are ${3, 6, 9, 12, 15, 18}$, six of them,
      so $p = 6/20 = 0.3$.],
    [The multiples of four are ${4, 8, 12, 16, 20}$, five of them, so
      fifteen chips are not multiples of four and
      $p = 15/20 = 0.75$.],
  )
]

#ex(difficulty: 1, time: "12 min")[
  Find the probability of each event. State the sample space you are
  using and why its outcomes are equally likely.
  #auto-parts(
    1,
    [You toss two coins and both show heads.],
    [You toss three coins and exactly two show heads.],
    [An urn holds $3$ yellow, $4$ green and $8$ blue balls. You draw
      one blindly and it is yellow.],
    [From the same urn — the yellow ball having been put back — you
      draw a blue ball.],
  )
][
  #auto-parts(
    1,
    [Recording both coins separately gives four equally likely
      outcomes, one of which is $(h, h)$: $p = 1/4$.],
    [Recording all three separately gives $2 dot 2 dot 2 = 8$ equally
      likely outcomes. Exactly two heads happens for $h h t$, $h t h$
      and $t h h$, so $p = 3/8$.],
    [The fifteen balls are equally likely to be drawn — they differ
      only in color, which is not something the drawing hand can
      detect. Three are yellow, so $p = 3/15 = 1/5$.],
    [Eight of the fifteen are blue, so $p = 8/15$.],
  )
]

#ex(difficulty: 2, time: "15 min")[
  Two fair dice are rolled and both numbers are recorded.
  #auto-parts(
    2,
    [Describe the sample space. How many outcomes are there?],
    [Both dice show the same number.],
    [The two numbers differ by exactly $2$.],
    [The two numbers are different.],
    [The sum is $1$.],
    [The sum is $9$.],
    [The sum is $8$.],
    [The sum is $13$.],
  )
][
  #auto-parts(
    2,
    [Every ordered pair $(a, b)$ with $a, b in {1, dots, 6}$:
      $abs(Omega) = 6 dot 6 = 36$. They are equally likely because the
      dice are fair and neither affects the other — which is exactly
      why the pairs must be recorded *in order*.],
    [Six pairs $(1,1), dots, (6,6)$, so $p = 6/36 = 1/6$.],
    [The pairs $(1,3), (2,4), (3,5), (4,6)$ and their four reverses:
      eight in all, so $p = 8/36 = 2/9$.],
    [The complement of part 2: $30/36 = 5/6$.],
    [Impossible — the smallest sum is $2$. So $p = 0$.],
    [$(3,6), (4,5), (5,4), (6,3)$: $p = 4/36 = 1/9$.],
    [$(2,6), (3,5), (4,4), (5,3), (6,2)$: $p = 5/36$.],
    [Impossible — the largest sum is $12$. So $p = 0$.],
  )
]

#ex(difficulty: 2, time: "15 min")[
  Two dice are rolled. Write down a sample space for each of the
  following ways of recording the result, say how many outcomes it
  has, and decide whether those outcomes are equally likely.
  #auto-parts(
    1,
    [You record both numbers, in order.],
    [You record which two numbers came up, but not which die showed
      which.],
    [You record only the sum.],
  )
  Which of the three is the right one to compute with, and why?
][
  #auto-parts(
    1,
    [The $36$ ordered pairs of the previous exercise. Equally
      likely.],
    [Unordered pairs, of which there are $21$: fifteen with two
      different numbers, plus the six doubles. *Not* equally likely —
      the unordered pair ${1, 2}$ arises from two of the $36$ ordered
      outcomes while ${1, 1}$ arises from only one, so it is twice as
      likely.],
    [The eleven sums $2, 3, dots, 12$. Not equally likely either, as
      the previous exercise already showed: the sum $8$ has
      probability $5/36$ and the sum $12$ only $1/36$.],
  )
  The first. It is the only one of the three whose outcomes are
  equally likely, so it is the only one where probabilities can be
  found by counting — and the other two can always be recovered from
  it by grouping outcomes together. This is the refinement move again:
  when in doubt, record more.
]

#only-high[
  #ex(difficulty: 2, level: "high", time: "10 min")[
    #auto-parts(
      1,
      [List all subsets of $A = {a, b, c}$ and check that there are
        $2^3$ of them.],
      [How many different events does a single roll of a die have?],
      [How many of those events contain the outcome $6$? Explain your
        answer without listing them.],
    )
  ][
    #auto-parts(
      1,
      [$emptyset$; ${a}, {b}, {c}$; ${a,b}, {a,c}, {b,c}$; and
        ${a,b,c}$. That is $1 + 3 + 3 + 1 = 8 = 2^3$.],
      [An event is any subset of $Omega = {1, dots, 6}$, so there are
        $2^6 = 64$ of them.],
      [Half of them, so $32$. Building an event means deciding
        separately for each of the six outcomes whether it is in; if
        the decision for $6$ is fixed to "in", the remaining five
        decisions are free, giving $2^5 = 32$.],
    )
  ]
]

== When Outcomes Are Not Equally Likely

#only-theory[
  Refining the sample space is a good move but not always an available
  one. A drawing pin has no finer symmetric experiment hiding inside
  it; neither does a football match. When symmetry runs out, the
  individual probabilities have to come from somewhere else — measured
  from data, argued geometrically, or simply given to us — and they
  are then listed in a table.
]

#keybox(title: "Probability distribution")[
  A random experiment with outcomes $omega_1, omega_2, dots, omega_n$
  is fully described by listing the probability of each:

  #data-table(
    columns: (auto, auto, auto, auto, auto),
    row-height: auto,
    [outcome],
    [$omega_1$],
    [$omega_2$],
    [$dots$],
    [$omega_n$],
    [probability],
    [$p(omega_1)$],
    [$p(omega_2)$],
    [$dots$],
    [$p(omega_n)$],
  )

  Each entry lies between $0$ and $1$, and the entries must add to
  $1$. The probability of an event is then the sum of the
  probabilities of the outcomes it contains.
]

#example(title: "Counting heads, revisited")[
  Toss a coin twice and record how many heads, so $Omega = {0, 1, 2}$.
  These outcomes are not equally likely, but the refined experiment
  $Omega' = {(h,h), (h,t), (t,h), (t,t)}$ is. Grouping its four
  equally likely outcomes by their number of heads gives the table:

  #data-table(
    columns: (auto, auto, auto, auto),
    row-height: auto,
    [$omega$],
    [$0$],
    [$1$],
    [$2$],
    [$p(omega)$],
    [$1/4$],
    [$2/4 = 1/2$],
    [$1/4$],
  )

  The entries add to $1$, as they must.
]

#only-theory[
  Sometimes the geometry of the experiment supplies the numbers.
  Imagine a spinner mounted at the center of a disc divided into four
  unequal sectors. The pointer is equally likely to come to rest in
  any *direction*, so the probability of a sector is its share of the
  full turn.
]

// #fig(image("images/spinner-four-sectors.png", width: 32%),
//   caption: [A spinner with four unequal sectors.])

#example(title: "The spinner")[
  Measuring the four sectors gives angles of $63degree$, $71degree$,
  $103degree$ and $123degree$. Dividing each by $360degree$:

  #data-table(
    columns: (auto, auto, auto, auto, auto, auto),
    row-height: auto,
    [outcome],
    [$omega_1$],
    [$omega_2$],
    [$omega_3$],
    [$omega_4$],
    [sum],
    [angle],
    [$63degree$],
    [$71degree$],
    [$103degree$],
    [$123degree$],
    [$360degree$],
    [$p(omega_i)$],
    [$approx 0.175$],
    [$approx 0.197$],
    [$approx 0.286$],
    [$approx 0.342$],
    [$1$],
  )

  The last column is the check. If the probabilities had not added to
  $1$, something would have been measured or copied wrong.
]

#remark[
  Building that check into the table is worth doing every time. A
  probability distribution that does not sum to $1$ is not a slightly
  inaccurate distribution — it is not a distribution at all, and every
  number computed from it afterwards is meaningless.
]

#only-high[
  === A Warning About Zero

  For an experiment with finitely many outcomes, $p(A) = 0$ and "$A$
  cannot happen" mean the same thing: the probabilities are a finite
  list of non-negative numbers, so a sum of them is zero only if every
  term is.

  The spinner quietly breaks this. Its pointer does not choose from a
  finite list — it can come to rest at *any* angle, of which there are
  infinitely many. The probability of any one exact angle must then be
  $0$, since infinitely many equal positive numbers cannot sum to $1$.
  And yet the pointer does stop somewhere. Landing exactly on the
  boundary between two sectors has probability zero and is not
  impossible.

  #look-ahead(preview: [continuous distributions])[
    Infinite sample spaces need probability attached to *intervals*
    rather than to individual points — an arc of the disc rather than
    a single direction. Everything in this unit stays finite, but the
    spinner is the first crack in that assumption, and it is where the
    normal distribution eventually comes from.
  ]
]

#ex(difficulty: 2, time: "10 min")[
  Three horses $A$, $B$ and $C$ run a race, and exactly one of them
  wins. $A$ is twice as likely to win as $B$, and the winning chances
  of $B$ and $C$ are in the ratio $2 : 3$. Find the three
  probabilities.
][
  Take $p(B) = 2k$ for some $k > 0$. The ratio $2 : 3$ then gives
  $p(C) = 3k$, and $A$ being twice as likely as $B$ gives $p(A) = 4k$.

  Exactly one horse wins, so the three probabilities describe all the
  outcomes and must add to $1$:
  $ 4k + 2k + 3k = 9k = 1, quad "so" quad k = 1/9. $
  Hence
  $ p(A) = 4/9, quad p(B) = 2/9, quad p(C) = 3/9 = 1/3. $
  A check: the three do add to $1$, and $p(A)$ is indeed twice
  $p(B)$. #heuristic("introduce notation")
]

#ex(difficulty: 3, time: "15 min", hints: (
  "Let r be the number of red balls. How many balls are in the urn altogether — in terms of r?",
  "Each part gives you one equation (or one inequality) in r. Write it down before solving anything.",
  "In part 3, remember that r has to be a whole number.",
))[
  An urn holds $8$ white balls, $6$ blue balls and an unknown number
  of red balls. One ball is drawn at random. How many red balls are
  in the urn if the probability of drawing
  #auto-parts(
    1,
    [a white ball is $2/9$,],
    [a red ball is $3/5$,],
    [a blue ball is less than $2/7$?],
  )
][
  Let $r$ be the number of red balls; the urn then holds $14 + r$
  balls altogether, all equally likely to be drawn.
  #auto-parts(
    1,
    [$
      8/(14 + r) = 2/9 arrow.r.double 72 = 2 dot (14 + r)
      arrow.r.double 36 = 14 + r arrow.r.double r = 22.
    $],
    [$
      r/(14 + r) = 3/5 arrow.r.double 5r = 3 dot (14 + r)
      arrow.r.double 2r = 42 arrow.r.double r = 21.
    $],
    [$
        6/(14 + r) < 2/7 arrow.r.double 42 < 2 dot (14 + r)
        arrow.r.double 21 < 14 + r arrow.r.double r > 7,
      $
      so there must be at least $8$ red balls. Note the answer is a
      whole number even though the inequality is not: $r > 7$ and $r$
      an integer together give $r >= 8$.],
  )

  The three parts describe three different urns, not one. Each answer
  is consistent only with its own condition.
]

#ai-box(role: "Checker")[
  Work the two-dice exercise above on paper first, all eight parts,
  and write down your sample space explicitly.

  Then give an AI assistant only part 3 (the two numbers differ by
  exactly $2$) and compare its answer to yours line by line. If you
  disagree, do not assume either of you is right: settle it by listing
  the favorable pairs.

  Then ask it a question you already know the answer to and that it is
  much more likely to get wrong: _rolling two dice, what is the
  probability that the two numbers are the same, if I do not care
  which die is which?_ The tempting answer uses the $21$ unordered
  pairs from the exercise after it and gets $6/21$. The correct answer is $1/6$.
  Which does it give — and if it gives the right one, can it say what
  is wrong with the other?
]

#look-ahead(preview: [the rules for combining probabilities])[
  Every probability so far has been found the same way: describe the
  event as a set, count it, divide. That works, and it does not scale.
  Asking for the probability of "at least one six in four rolls" means
  counting a subset of $1296$ outcomes, and nobody wants to do that by
  hand.

  The next chapter builds the rules that make such questions
  answerable without listing anything — and every one of them will be
  a statement about unions, intersections and complements, which is
  why this chapter spent its first pages on sets.
]

#print-hints()
#print-vocab()
