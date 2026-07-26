// ============================================================
//  sls-intro.typ — SLS opening interlude
//  Registered in main-high.typ as (none, ".../sls-intro"): included
//  in the lecture notes, before the Introduction chapter, and carries
//  no exercises to the sheet or solutions booklet.
//
//  DATES below are specific to one offering — update them each year.
// ============================================================

#import "../../common/preamble.typ": *

#set page(
  ..chapter-page-setup,
  header: context {
    set text(size: 9pt, fill: luma(120))
    grid(
      columns: (1fr, 1fr),
      align(left)[Complex Numbers — SLS],
      align(right)[Self-Learning Semester],
    )
    v(-4pt)
    line(length: 100%, stroke: 0.5pt + accent)
  },
  footer: context {
    set text(size: 9pt, fill: luma(120))
    line(length: 100%, stroke: 0.3pt + luma(180))
    v(-4pt)
    align(center)[#counter(page).display("1")]
  },
)

#apply-base-style[

= Welcome to the Self-Learning Semester

This semester you will study *complex numbers* -- one of the most
elegant and far-reaching ideas in all of mathematics, and one that a
century of students has found completely learnable. That second point
matters. There is no such thing as a "math person" and a "non-math
person"; there are people who have practiced this kind of thinking and
people who have not yet. Over this semester you will become the first
kind, by doing the one thing that builds it: working carefully through
problems, especially the ones that do not come easily.

What makes this a *self-learning* semester (SLS) is that the
responsibility for your progress sits with you. There are no lectures.
These notes are your course, and how much you get from them depends
almost entirely on how actively you use them.

== What a self-learning semester asks of you

Reading mathematics is not like reading a novel. It is done slowly,
with a pencil, rederiving each step yourself rather than nodding along.
Concretely, you are expected to:

- read each chapter *actively* -- work every example on your own paper
  before looking at how it is done,
- attempt every exercise *before* opening the solutions; a solution you
  read teaches far less than a problem you fought,
- keep track of your own pace against the schedule below, and
- ask for help *early*. Small confusions are quick to clear up; a month
  of accumulated ones is not.

Talking through ideas with a classmate is encouraged. Writing up your
solutions is done alone -- that is where the understanding sets.

== When You Get Stuck

Read this section before you need it, because you *will* need it. Being
stuck is not a sign that something has gone wrong; it is the normal,
default state of doing real mathematics. Professional mathematicians
spend most of their working hours stuck. What separates them from
beginners is not that they get stuck less -- it is that they have a set
of *moves* to try when it happens, instead of freezing or giving up.

Here is the short list this course returns to again and again. When a
problem stops you, do not stare at it; pick a move and start.

#toolbox()

None of these guarantees a solution. What they guarantee is a next
action -- and a next action is almost always enough to get unstuck. You
will see small badges pointing to these moves throughout the notes,
wherever one of them cracks a problem open.

== Working with a CAS -- and with AI

Two kinds of machine will offer to do your thinking for you this
semester: a computer algebra system (CAS), and AI assistants. Both are
genuinely useful, and both are easy to misuse in a way that quietly
prevents you from learning the very thing you are here to learn.

*CAS.* Exercises marked *no CAS* must be done entirely by hand. These
cluster in the early chapters, where fluency with complex arithmetic
by hand is the whole point -- you cannot reason about $z dot overline(z)$
or a conjugate root if the basic manipulation is not automatic. In the
later chapters a CAS is generally allowed, because there the arithmetic
is a means and the ideas are the end. When unsure, do it by hand first,
then let the CAS *check* you.

*AI.* An AI assistant can be a superb study partner -- if you use it as
a partner and not a ghostwriter. The notes model good uses in boxes
labeled by role:
- an *Explainer* rephrases an idea you did not follow the first time;
- a *Checker* confirms (or refutes) an answer you produced yourself;
- a *Tutor* asks you questions rather than handing you the answer;
- a *Generator* invents extra practice problems on a skill you want to
  drill.

But hold on to two facts. First, these systems are *confidently wrong*
often enough to matter -- especially on exactly the fiddly details this
subject is full of: a dropped sign, the wrong quadrant for an argument,
a miscounted root. Never accept a result you cannot verify yourself;
finding the machine's error is itself excellent practice. Second, the
*no CAS* exercises are also *no AI*. Outsourcing them defeats their only
purpose, which is to make the skill *yours*. Use these tools to
understand more, never to think less.

== The Shape of the Unit

The notes are eight chapters -- seven of new material and a closing
review.

#data-table(
  columns: (1fr, auto),
  row-height: auto,
  [Chapter], [Approx. duration],
  [Introduction -- numbers are invented], [1 week],
  [Arithmetic], [1.5 weeks],
  [Equations over $CC$], [1 week],
  [The Gaussian plane], [1.5 weeks],
  [Polar form and Euler's formula], [2 weeks],
  [Transformations and parametric curves], [2 weeks],
  [Loci and further applications], [2 weeks],
  [Review and exam preparation], [as needed],
)

#v(0.5em)

The first five chapters -- through *Polar Form* -- are the core, and
the basis of your *oral exam*. *Transformations* and *Loci* build on
that core and, with everything before them, make up the *written exam*.
The *Review* chapter is a tool for both: start with its self-check to
find your gaps.

== Schedule and Self-Monitoring

Treat the durations above as a planning guide, not a rule. A rough
weekly target for this offering:

#data-table(
  columns: (auto, auto, 1fr),
  row-height: auto,
  [Weeks], [Dates (2026)], [Target],
  [33-34], [10-21 Aug], [Introduction, Arithmetic],
  [35-36], [24 Aug-4 Sep], [Equations, Gaussian Plane],
  [37-39], [7-25 Sep], [Polar Form],
  [39], [21-25 Sep], [*Oral exam*],
  [40-41], [28 Sep-9 Oct], [_School holidays_],
  [42-43], [12-23 Oct], [Transformations],
  [44-45], [26 Oct-6 Nov], [Loci],
  [46], [9-13 Nov], [*Written exam*],
)

#v(0.5em)

If you fall significantly behind, talk to your teacher promptly. A small
delay is easy to recover from; a large one is not.

#v(1em)
#block(
  width: 100%,
  fill: accent-bg,
  radius: 3pt,
  inset: (left: 14pt, right: 10pt, top: 10pt, bottom: 10pt),
  stroke: (left: 4pt + accent),
)[
  #text(weight: "bold", size: 12pt, fill: accent)[
    Oral Exam -- Introduction through Polar Form
  ]
  #v(0.5em)

  *Date:* Week 39, Monday 21 to Friday 25 September 2026.

  *Format:* Individual, 15 minutes per student. You will be asked to
  explain concepts, state definitions and theorems in your own words,
  give examples, and work short problems -- all from the first five
  chapters.

  *Topics:* the definition and arithmetic of complex numbers, equations
  over $CC$, the Gaussian plane and geometric interpretation, polar and
  exponential form, Euler's formula, De Moivre's theorem, and the roots
  of unity.

  *Arranging your appointment:*
  #v(0.3em)
  - Appointments are booked *in pairs*: find a classmate and propose a
    date that suits you both. You are each examined individually, one
    after the other in the same slot.
  - Contact your teacher *before the end of week 37* (Friday 11
    September) with your preferred slot.
  - Slots are confirmed first-come, first-served -- do not leave it
    late.
  - Raise any timetable conflict as early as you can.

  #v(0.3em)
  #text(style: "italic")[
    A well-prepared student can explain any definition or theorem in
    their own words, give an example, and carry out a straightforward
    calculation. You need not memorize proofs word for word; you do need
    to understand *why* the results are true.
  ]
]

]
