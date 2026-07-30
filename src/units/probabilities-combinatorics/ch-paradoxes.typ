#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "When Intuition Fails")
#let ex = exercise.with(chapter: "When Intuition Fails")

// ── NOTE ON THE BIRTHDAY NUMBERS ─────────────────────────────
// Your LaTeX notes run the birthday problem on 366 days throughout,
// which treats 29 February as being as likely as any other date. This
// chapter uses 365 and states the assumption openly, since the point
// of the section is that the answer is robust — real birth dates are
// not uniform either, and clustering only makes a shared birthday
// MORE likely, so 23 remains an upper bound.
//
// ── SIMPSON'S PARADOX: DELIBERATE OVERLAP ────────────────────
// Simpson's paradox already appeared descriptively in the
// descriptive-statistics unit. §4 does not re-teach it: it restates
// the same phenomenon in conditional-probability notation, which is
// the thing students could not do the first time round. If you'd
// rather cut the repetition entirely, §4 lifts out cleanly — but the
// kidney-stone exercise is worth keeping somewhere, because it is the
// only place in the unit where students build a reversal themselves
// rather than being shown one.

= When Intuition Fails

#only-theory[
  The very first thing this unit asked you to do was guess. Eight
  pairs of events, and the instruction to decide which of each pair
  was more likely, argue for your answer, then argue against it — and
  to keep what you wrote.

  Fetch it now. Some of those questions have been settled along the
  way; the rest are settled here.

  This chapter is a short list of problems chosen for one shared
  property. Every one of them has a correct answer that almost
  everybody rejects on first hearing, including people who know all
  the mathematics in this unit. They are not tricks or word games. The
  arithmetic is elementary in every case. What fails is something
  else, and it is worth knowing that it fails in you too.
]

#objectives(
  [explain the Monty Hall problem, and identify exactly which
    assumption about the host makes the answer $2 slash 3$],
  [calculate the probability that two people in a group share a
    birthday, and explain why the number of people needed is so
    small],
  [state Simpson's paradox in conditional-probability notation and
    explain what a lurking variable is],
  [recognize that rare events are common when there are enough
    opportunities for them],
  [say, for a problem where intuition and calculation disagree, what
    the intuition was actually computing],
)

== Settling the Opening Questions

#only-theory[
  Look back at the eight pairs. They divide into two groups, and the
  division is the one chapter 1 drew between the three sources of a
  probability.

  Four of them — the lottery against lightning, the plane against the
  car, childbirth in two countries, the shark against the cow — cannot
  be settled by any amount of mathematics. They are questions about
  the world, and only data answers them. That is not a failure of the
  exercise; it is the point of it. Whoever quotes you a number for the
  shark had to go and count.

  The other four are settled by argument alone, and you now have every
  argument required:

  #auto-parts(
    1,
    [*The doctor.* Every doctor earning over CHF #num(100000) is a
      doctor, so the second event is a subset of the first and cannot
      be more likely. Adding detail to a description can only ever
      reduce its probability — and yet the detailed version feels more
      plausible, because it tells a better story.],
    [*The students.* This one really is a data question, but of the
      easiest kind: the school can count its own students, and when
      the whole population is available the relative frequency *is*
      the probability.],
    [*The test.* Settled in the conditional-probability chapter, and
      the answer surprises nearly everyone: for a rare enough
      condition, most people who test positive are healthy.],
    [*The birthdays.* Settled below, and the answer is that the two
      questions are not remotely the same size.],
  )
]

== The Monty Hall Problem

#only-theory[
  You are on a game show facing three doors. Behind one is a car;
  behind the other two, goats. You choose door 1.

  The host, who knows what is behind every door, opens door 3 —
  revealing a goat — and offers you the choice of staying with door 1
  or switching to door 2.

  Should you switch?
]

#warning[
  Almost everyone answers that it makes no difference: two doors
  remain, so the chance must be $1 slash 2$ either way.

  Switching wins two times in three.
]

#example(title: "Why, by listing")[
  Suppose you have chosen door 1 — every other first choice works the
  same way. There are three equally likely arrangements:

  #data-table(
    columns: (auto, auto, auto, auto, auto),
    row-height: auto,
    [], [door 1], [door 2], [door 3], [*switching*],
    [case 1], [car], [goat], [goat], [*loses*],
    [case 2], [goat], [car], [goat], [*wins*],
    [case 3], [goat], [goat], [car], [*wins*],
  )

  In case 1 the host may open either remaining door, and switching
  costs you the car. In case 2 he must open door 3, and switching
  takes you to the car. In case 3 he must open door 2, and switching
  takes you to the car.

  Switching wins in two of three equally likely cases.
]

#keybox(title: "The one-line version")[
  Switching wins exactly when your first choice was wrong.

  Your first choice was wrong with probability $2 slash 3$, and
  nothing the host does afterwards changes what your first choice was.
]

#only-theory[
  If that still feels wrong, scale it up. Imagine a hundred doors. You
  pick door 1 — a $1%$ shot. The host, who knows where the car is,
  then opens ninety-eight other doors, every one a goat, leaving your
  door and one other.

  Nobody hesitates over that one. Your door is still the $1%$ door;
  the host has swept the remaining $99%$ onto a single alternative.
  The three-door case is the same thing with the numbers made small
  enough to argue about.
]

#warning[
  Everything above depends on an assumption that the puzzle usually
  states in passing: *the host knows where the car is and always opens
  a door with a goat behind it.*

  That assumption is what carries the information. Change it and the
  answer changes.
]

#only-high[
  === What the Host Actually Tells You

  #only-theory[
    Suppose instead that the host does not know where the car is, and
    simply opens one of the two doors you did not choose at random.
    Suppose further that it happens to show a goat. Now what?

    Condition on what you saw. Writing $C_i$ for "the car is behind
    door $i$", each has probability $1 slash 3$, and the host opens
    door 2 or door 3 with probability $1 slash 2$ each:

    #auto-parts(
      1,
      [If $C_1$, whichever door he opens shows a goat: probability
        $1$.],
      [If $C_2$, he shows a goat only if he happens to open door 3:
        probability $1 slash 2$.],
      [If $C_3$, likewise: probability $1 slash 2$.],
    )

    So by the law of total probability,
    $ p("goat shown") = 1/3 dot 1 + 1/3 dot 1/2 + 1/3 dot 1/2
      = 2/3, $
    and reversing the condition,
    $ p(C_1 | "goat shown") = (1 slash 3)/(2 slash 3) = 1/2. $

    With an ignorant host, switching gains nothing.

    The two versions look identical — same doors, same goat, same
    offer — and give different answers, because the *event you are
    conditioning on* is different. In the original you learn "the host
    could find a goat to show you", which he always could. In the
    variant you learn "a randomly opened door happened not to hide the
    car", which is genuine evidence in favor of your own door.

    This is what the whole problem is about. It was never about doors.
  ]
]

#ex(difficulty: 2, time: "15 min")[
  Play the game twenty times with a partner and a set of three cards,
  one of them marked. One of you is the host and must always turn over
  an unmarked card that the other did not choose.
  #auto-parts(
    1,
    [Play ten rounds always staying and ten always switching. Record
      the results.],
    [How close are your two totals to the predicted $10 slash 3$ and
      $20 slash 3$?],
    [Your results will not match the prediction exactly. Which chapter
      of this unit says how surprised you should be, and what does it
      say?],
  )
][
  Results will vary; the point is the third part.

  #auto-parts(
    1,
    [Around $3$ or $4$ wins from staying, around $6$ or $7$ from
      switching, is the typical outcome. A run of ten is short enough
      that reversals happen; two or three pairs of students in a class
      will get results that look like nothing at all.],
    [Rarely very close, and that is expected.],
    [Chapter 1, and the law of large numbers. Relative frequency
      approaches probability as the number of trials grows, and ten
      trials is not many — the table in that chapter had a fair coin
      sitting at $0.46$ after a hundred tosses. Pooling the whole
      class's rounds gives a far better estimate than any pair's own
      ten, and is worth doing.],
  )
]

== The Birthday Problem

#only-theory[
  How many people must be in a room before it is more likely than not
  that two of them share a birthday?

  If there are $366$ people, two must share one, since there are only
  $365$ dates to go round (and $366$ in a leap year). That much is
  forced. The question is where the halfway point falls, and the
  usual guess is somewhere around $180$ — half of $365$, on the
  reasoning that the answer ought to be halfway along.

  It is $23$.
]

#example(title: "The calculation")[
  Assume $365$ equally likely birthdays and no twins in the room.
  Rather than counting the ways a match can happen — there are far too
  many — count the one way it cannot, and subtract.

  For nobody to share, each person in turn must avoid every birthday
  already taken. The second person has $364$ free dates out of $365$,
  the third has $363$, and so on:
  $ p("no match among" n) = 364/365 dot 363/365 dot dots.c dot
    (366 - n)/365. $
  Hence
  $ p("some match") = 1 - (365 dot 364 dot dots.c dot (366-n))/365^n. $

  Putting numbers in:

  #data-table(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    row-height: auto,
    [$n$], [$10$], [$20$], [$23$], [$30$], [$50$], [$70$],
    [$p$], [$0.117$], [$0.411$], [$0.507$], [$0.706$], [$0.970$],
    [$0.999$],
  )

  At $23$ the probability passes one half, and by $70$ a shared
  birthday is almost certain.
]

#only-theory[
  The reason for the surprise is that intuition answers a different
  question — the one about *your* birthday rather than *any* shared
  birthday. Those two differ enormously.

  A match needs only some *pair* of people to agree, and pairs are
  what the counting chapter taught you to count. With $23$ people
  there are
  $ binom(23, 2) = 253 $
  pairs, each with roughly a $1$ in $365$ chance of agreeing. That
  many chances at a $1 slash 365$ event is no longer a long shot.

  Ask instead how many people are needed before someone probably
  shares *your* birthday, and each person is a single chance rather
  than a pair. The answer is $253$ — the same number, arriving from
  the other direction, which is a coincidence worth enjoying but not
  reading anything into.
]

#remark[
  The assumption of $365$ equally likely dates is false. Births
  cluster by season and by day of the week, and $29$ February exists.
  None of it matters much, and the direction of the error is known:
  any clustering makes a shared birthday *more* likely, not less. So
  $23$ is an upper bound, and the real figure is a shade lower.

  This is a useful habit to build. When you cannot avoid an
  unrealistic assumption, work out which way it pushes the answer.
]

#ex(difficulty: 2, time: "12 min")[
  #auto-parts(
    1,
    [Show that the probability of no shared birthday among $n$ people
      can be written $ 365!/((365-n)! dot 365^n). $],
    [Use it to check the value $0.411$ for $n = 20$.],
    [There are about $23$ students in your class. Is that evidence
      for or against the calculation? What would count as evidence
      either way?],
  )
][
  #auto-parts(
    1,
    [The product $365 dot 364 dot dots.c dot (366-n)$ has $n$ factors
      and is the top of the fraction; supplying the missing tail
      $(365-n)!$ and dividing it out again turns it into
      $365! slash (365-n)!$. Dividing by $365^n$ gives the stated
      form. It is the same expression as in the example, written
      compactly.],
    [$ 1 - 365!/(345! dot 365^(20)) approx 1 - 0.589 = 0.411. $],
    [On its own, neither. One class is a single trial of an experiment
      whose outcome is a coin-flip either way, and a single trial
      cannot confirm or refute a probability of $0.507$ — the same
      point as the Monty Hall exercise, and as chapter 1. What would
      count as evidence is collecting the answer from every class in
      the school: if a shared birthday turns up in roughly half of the
      classes of about this size, the calculation is doing its job.],
  )
]

== Simpson's Paradox

#only-theory[
  You met this in the descriptive-statistics unit as a warning about
  averages. It is worth revisiting for one reason: you can now say
  precisely what it is.
]

#example(title: "Berkeley, 1973")[
  Graduate admissions at the University of California, Berkeley showed
  men being admitted at a distinctly higher rate than women — about
  $44%$ against $35%$ — a gap far too large to be chance.

  Broken down by department, the picture reversed. Across the six
  largest departments:

  #data-table(
    columns: (auto, auto, auto, auto, auto),
    row-height: auto,
    [], [men applied], [admitted], [women applied], [admitted],
    [A], [$825$], [$62%$], [$108$], [$82%$],
    [B], [$560$], [$63%$], [$25$], [$68%$],
    [C], [$325$], [$37%$], [$593$], [$34%$],
    [D], [$417$], [$33%$], [$375$], [$35%$],
    [E], [$191$], [$28%$], [$393$], [$24%$],
    [F], [$373$], [$6%$], [$341$], [$7%$],
  )

  Four of the six departments admitted women at a *higher* rate than
  men, and the two that did not were close. Yet totalling these six
  columns gives $44.5%$ for men and $30.3%$ for women.

  Both statements are true of the same data.
]

#keybox(title: "The paradox, stated properly")[
  It is possible for
  $ p(A | B) > p(A | overline(B)) $
  to hold overall, while
  $ p(A | B inter C) < p(A | overline(B) inter C) $
  holds for *every* value of some third variable $C$.

  Conditioning on more information can reverse a comparison — not
  weaken it, reverse it.
]

#only-theory[
  The mechanism is visible in the table. Departments A and B admitted
  most applicants; department F admitted almost nobody. Men applied in
  large numbers to A and B; women applied in large numbers to C, E and
  F. So the overall rates are not comparing men to women — they are
  mostly comparing *easy departments to hard ones*.

  The department is a #vocab("lurking variable", "Störvariable"): it
  influences the outcome and is distributed unevenly between the
  groups being compared. Averaging over it does not remove its effect;
  it hides it.
]

#warning[
  There is no rule saying the broken-down figures are the right ones.
  Sometimes they are; sometimes the aggregate is what you want. The
  Berkeley study's own conclusion was that the department-level
  figures showed no bias in admissions, but that itself raises a
  further question the numbers cannot answer — why the two groups
  applied to such different departments.

  Simpson's paradox is not a technique for getting the right number.
  It is a warning that "the number" is not well defined until you say
  what you are conditioning on.
]

#ex(difficulty: 3, time: "15 min")[
  Two treatments for kidney stones were compared. Patients were also
  recorded as having small or large stones.

  #data-table(
    columns: (auto, auto, auto),
    row-height: auto,
    [], [treatment A], [treatment B],
    [small stones], [$81$ of $87$], [$234$ of $270$],
    [large stones], [$192$ of $263$], [$55$ of $80$],
  )

  #auto-parts(
    1,
    [Find the success rate of each treatment for small stones, and
      for large stones. Which treatment is better in each group?],
    [Now find the overall success rate of each treatment. Which
      treatment looks better?],
    [Explain the reversal by looking at how the patients were
      distributed.],
    [A doctor has to choose a treatment for a patient whose stone has
      just been measured as large. Which figures should she use, and
      why?],
  )
][
  #auto-parts(
    1,
    [Small stones: $81 slash 87 approx 93%$ for A against
      $234 slash 270 approx 87%$ for B. Large stones:
      $192 slash 263 approx 73%$ against $55 slash 80 approx 69%$.
      Treatment A is better in both groups.],
    [A: $273$ of $350 = 78%$. B: $289$ of $350 approx 83%$. Treatment
      B looks better overall — the reversal.],
    [Large stones are harder to treat, and treatment A was given
      mostly to patients with large stones ($263$ of its $350$) while
      B was given mostly to patients with small ones ($270$ of its
      $350$). A's overall figure is dragged down by the difficulty of
      the cases it was given, not by the treatment. Stone size is the
      lurking variable.],
    [The large-stone figures — $73%$ against $69%$ — because that is
      the group her patient is in. The overall figures answer a
      question nobody is asking: how well a treatment does on a
      *mixture* of cases that this patient is not a random draw from.
      Conditioning on what you know is the whole content of the
      conditional-probability chapter, and this is what it is for.],
  )
]

== Littlewood's Law

#only-theory[
  The mathematician John Littlewood defined a *miracle* as an event of
  special significance occurring with probability one in a million,
  and then made an estimate.

  A person who is awake and alert for about eight hours a day, and who
  experiences roughly one distinguishable "event" per second, gets
  through
  $ 8 dot #num(3600) = #num(28800) $
  events in a day, and therefore a million events in
  $ #num(1000000)/#num(28800) approx 35 "days". $

  So a one-in-a-million event should happen to each of us about once a
  month. Miracles, on this accounting, are due roughly as often as the
  rent.
]

#remark[
  The estimate is deliberately crude — an "event" is not a
  well-defined thing and one per second is a guess. It does not need
  to be precise to make its point, which is structural rather than
  numerical: rarity is only half of an argument. The other half is how
  many opportunities there were.

  This is the base-rate lesson from the conditional-probability
  chapter, arriving from the other side. There, a rare condition made
  most positive tests false. Here, a rare event becomes ordinary
  because it is given millions of chances.
]

#look-ahead(preview: [inferential statistics])[
  This has a sharp edge in real research. Testing twenty independent
  hypotheses at the $5%$ level means expecting one apparently
  significant result even if every hypothesis is false — because
  "one in twenty" stops being unlikely once you have twenty goes.

  Whole fields have been damaged by not accounting for this. The final
  unit of this course is about doing it properly.
]

== Mixed Problems

#ex(difficulty: 2, time: "10 min")[
  In board games such as Monopoly two dice are rolled and their sum is
  used. Decide whether each statement is true or false, and justify it
  by counting.
  #auto-parts(
    1,
    [A sum of $11$ and a sum of $12$ are equally likely.],
    [A sum of $4$ and a sum of $11$ are equally likely.],
    [A sum of $7$ is more likely than a sum of $8$.],
  )
][
  All $36$ ordered pairs are equally likely, so each part is a count.
  #auto-parts(
    1,
    [False. A sum of $11$ arises from $(5,6)$ and $(6,5)$, a sum of
      $12$ only from $(6,6)$: $2 slash 36$ against $1 slash 36$.],
    [False. A sum of $4$ arises three ways, a sum of $11$ two ways:
      $3 slash 36$ against $2 slash 36$.],
    [True. Six ways against five: $6 slash 36$ against $5 slash 36$.
      Seven is the most likely sum of two dice, which is why it is the
      one the game is built around.],
  )
]

#ex(difficulty: 2, time: "10 min")[
  Two events satisfy $p(A inter overline(B)) = 0.2$ and
  $p(A union B) = 0.9$.
  #auto-parts(
    1,
    [Draw a Venn diagram and shade $overline(A) inter overline(B)$.],
    [Find $p(overline(A) | overline(B))$.],
  )
][
  #auto-parts(
    1,
    [The region outside both circles.],
    [Outside both means outside the union, so
      $ p(overline(A) inter overline(B)) = 1 - p(A union B) = 0.1. $
      The event $overline(B)$ splits into the part inside $A$ and the
      part outside it, and these are mutually exclusive:
      $ p(overline(B)) = p(A inter overline(B))
        + p(overline(A) inter overline(B)) = 0.2 + 0.1 = 0.3. $
      Hence
      $ p(overline(A) | overline(B)) = 0.1/0.3 = 1/3. $],
  )
]

#ex(difficulty: 2, time: "8 min")[
  Two dice are rolled. Given that the sum is $10$, what is the
  probability that one of the dice shows a $4$?
][
  Conditioning replaces the sample space. The sum is $10$ for exactly
  three of the $36$ pairs:
  $ (4, 6), quad (5, 5), quad (6, 4), $
  and two of those contain a $4$. So the probability is $2 slash 3$.

  Note how far this is from the unconditional answer: without the
  condition, a $4$ appears on $11$ of the $36$ pairs, a probability of
  under a third. The information changed the question completely.
]

#ai-box(role: "Checker")[
  Monty Hall is the best test in this book of whether an assistant is
  reasoning or remembering, because the standard version appears
  thousands of times in any training set and the variants barely
  appear at all.

  Ask it the standard problem first. It will almost certainly answer
  $2 slash 3$ and switch.

  Then change one thing and ask again, without flagging that anything
  has changed:

  #auto-parts(
    1,
    [The host does not know where the car is, opens a door at random,
      and it happens to show a goat.],
    [There are four doors, one car; you pick one, the host opens one
      goat door and offers a switch.],
    [The host opens a goat door only when your first choice was
      correct, and otherwise offers nothing.],
  )

  Work out at least the first yourself — it is done in this chapter —
  before comparing. A model that has memorized the answer rather than
  the argument will tend to reply $2 slash 3$ and "always switch" to
  all of them.

  The lesson is not that the tool is bad. It is that a confident,
  fluent, correctly-formatted answer to a question that *looks* like a
  famous one is exactly where you should be most careful, and that
  this applies to you as much as to the machine.
]

#look-ahead(preview: [what comes next])[
  This unit has been about experiments you could describe completely:
  a fixed list of outcomes, each with a probability, and rules for
  combining them.

  Next year the questions change shape. Instead of asking which
  outcomes occur, you will attach a *number* to each outcome — how
  many heads, how much you win, how long you wait — and ask what that
  number does on average and how far it strays. The counting you have
  just learned reappears immediately as the binomial distribution, and
  the base-rate lesson reappears in the last unit of all, where the
  question is what a sample of data entitles you to believe.

  Everything after this is built on the four rules in this unit. There
  are not going to be any more of them.
]

#print-hints()
#print-vocab()
