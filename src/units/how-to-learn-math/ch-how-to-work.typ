// ============================================================
//  ch-how-to-work.typ
//  "Chapter 0b" — How to Work in Math
//
//  Companion to ch-how-to-learn-math.typ: that chapter answers
//  *why* (memory, mindset, desirable difficulty); this one answers
//  *what to actually do* on a Tuesday afternoon. Every practice
//  here carries a one-line reason, deliberately — rules with
//  stated reasons get followed; rules without them get gamed.
//
//  Identical for GLF and SPF: no only-high[...] content anywhere.
//  Read once near the start of Year 1, right after Chapter 0.
//
//  No objectives() box, matching its sibling chapter: this chapter
//  implements no Lehrplan competency, so the box would have nothing
//  to audit against.
//
//  Import path assumes this file lives at
//    src/units/how-to-learn-math/ch-how-to-work.typ
//  (two levels below src/, same depth as every other unit).
// ============================================================
#import "../../common/preamble.typ": *

#show: chapter-template.with(title: "How to Work in Math")

= How to Work in Math

#quotebox[
  The previous chapter was about *why* certain habits work. This one
  is about *what to actually do* — in class, at your desk at home,
  and in front of a screen. It is deliberately concrete. Everything
  in it has a reason attached, and you are entitled to the reason.
]

== The Two Rules

Almost everything in this chapter is advice: try it, keep what works
for you, drop what doesn't. Exactly two things are not advice. They
are rules, they apply to every lesson, and here is why.

#keybox(title: "Rule 1 — Work on paper")[
  In class, your default working surface is paper. Not "always, no
  exceptions" — but paper first, and a device only when the device is
  actually the better tool for that specific task.
]

Three reasons, in order of how much they matter:

- *Math notation is two-dimensional.* Fractions stack, exponents
  float, equal signs line up down the page, and an arrow in the
  margin can connect line 3 to line 7. Paper imposes no constraints
  on any of that. Every text editor does. Fighting your tool at the
  exact moment your attention should be on the mathematics is the
  worst possible time to be fighting your tool.
- *Sketching has to be free.* "Draw a picture" is one of the most
  reliable moves in the problem-solving toolbox, and it only gets
  used if it costs you two seconds. If a sketch costs two minutes of
  clicking, you will skip it — and you will skip it precisely on the
  hard problems, where you needed it.
- *You will be examined on paper.* Memory is sensitive to the
  conditions under which it was formed: practicing in conditions that
  resemble the test measurably improves performance on the test.
  Handwriting a solution and typing one are different physical
  skills, and only one of them is assessed.

#remark[
  This is a rule about *class work*, not about devices in general.
  Typing up a clean summary at home, keeping an archive of scanned
  notes, using GeoGebra or a CAS, reading the PDF of these notes —
  all sensible, all fine. The rule targets the moment you are
  actually solving something.
]

#keybox(title: "Rule 2 — Screens flat, screens visible")[
  If you use a convertible or a tablet in class, it lies flat on the
  desk. Screens stay visible. No screen is angled so that only one
  person in the room can see it.
]

This is the rule students most often read as distrust, so let me be
precise about what it is actually for.

- *A raised screen is a wall.* It blocks sight lines in both
  directions. I cannot see that you are stuck on line 2, and you
  cannot see the board without leaning around your own laptop.
- *Divided attention is contagious.* There is a well-known experiment
  by Sana, Weston, and Cepeda (2013) in which students multitasking
  on a laptop during a lecture scored lower on a comprehension test
  afterward — no surprise there. The surprising part: students who
  were merely seated *within view* of someone else's multitasking
  screen scored lower still. Your screen is not only your business,
  because it is in someone else's visual field whether they want it
  there or not.
- *It is easier to not open the tab than to close it.* A visible
  screen is a commitment device. It is not there to catch you; it is
  there so that the decision never has to be made under pressure in
  the first place.

#remark[
  The principle behind both rules is the same one this course applies
  to devices everywhere: regulate the *mode* of use, not the medium.
  You are not being asked to give up a tool. You are being asked to
  use it in the open.
]

== Working on Problems in Class

=== Use enough space

If there is one habit worth changing today, it is this one. Students
routinely squeeze a six-step solution into a 3 cm gap at the bottom
of a page, or into whatever space is left beside a printed exercise.

#keybox(title: "Don't try to save paper")[
  Paper is the cheapest thing in this room. Your attention is the
  most expensive. Never trade the second for the first.
]

Why it matters more than it looks:

- *Written work is external memory.* Every step you can still see is
  a step you don't have to hold in your head. Cramped work forces you
  to reconstruct earlier lines from memory while also doing the next
  one — which is exactly the overload that produces mistakes.
- *You cannot check what you cannot read.* Most errors in a long
  calculation are found by scanning back up the page. A solution
  written in three different directions around a diagram cannot be
  scanned.
- *You will read this again.* In two weeks, when you revisit the
  problem, the cramped version is unusable and you will start over.

Concretely: one line per step. Equal signs under each other. Start a
new page rather than a new column. Leave a margin on the left for
things you'll want to add later — a correction, a name for the
method, a note that this is where you got stuck.

=== Write the attempt down, even the wrong one

When you are given a problem you have not been taught how to solve
yet — which happens on purpose in this course — write down what you
try, including the approaches that go nowhere. Two reasons: a wrong
attempt is what makes the correct method *land* when it arrives
(this is the productive-failure effect from _How to Learn Math_),
and a
recorded wrong attempt is something I can actually help you with. "I
don't get it" is unhelpable. "I tried this and got stuck here" takes
thirty seconds to fix.

=== When something is being explained

Copying the board correctly is necessary and not sufficient. The
difference between a transcript and a set of notes is that notes
contain something you wrote yourself. After each worked example, add
one line in your own words:

#quotebox[
  Why this step is allowed: ...
  #linebreak()
  The move here was: ...
  #linebreak()
  This is like the earlier problem about ..., except ...
]

If you cannot write that line, that is the signal to ask a question —
now, while the example is still on the board, not tonight at 22:00.

=== Ask the question at the moment it appears

Confusion is time-sensitive. A question you ask in the lesson costs
you twenty seconds and often saves four other people the same
confusion. The same question at home costs you half an evening and
frequently gets answered by something that sounds right and isn't.

== Working on Problems at Home

=== The ten-minute rule

#keybox(title: "Ten minutes a day beats three hours the night before")[
  Not because three hours is too little time — because *massed* time
  is a far less efficient way to spend it than the same time spread
  out. This is the spacing effect from _How to Learn Math_, in its
  operational
  form.
]

There is a second, less obvious reason. A short session two days
after a lesson will find the thing you didn't understand while there
is still time to fix it. The night before the exam arrives too late
to fix anything: it can only reveal problems, not solve them.

=== Set up before you start

- Paper, pen, and the exercise. Nothing else on the desk.
- Phone out of reach, and preferably out of the room. Notifications
  are not the main cost — the main cost is the time it takes to get
  back into a half-built chain of reasoning after any interruption at
  all. Long calculations are the most interruption-sensitive thing
  you do all week.
- Decide *in advance* how long the session is. Twenty-five focused
  minutes with a clear stopping point beats ninety unfocused ones,
  and it is far easier to start something that has an end.

=== Getting stuck, on purpose and on a timer

Being stuck is the job, not a malfunction (_How to Learn Math_ makes
that case
at length). What it needs is a protocol, so that "struggling" doesn't
quietly turn into "staring."

+ Work at it for a set time — ten to fifteen minutes is about right
  for a normal exercise.
+ If you're stuck, go through the toolbox explicitly: try a small
  case, draw a picture, solve a simpler version, work backwards.
  Actually try two of them on paper. Don't just consider them.
+ Still stuck after that? Stop, and write down *precisely* where the
  wall is: the last line you are confident about, and what you cannot
  get past. That sentence is now your deliverable. Bring it to class.

Notice what this rules out: fifteen seconds of thought followed by a
search. The struggle is not a formality before you're allowed to look
things up. It is the part that does the work.

=== Check your own answer before you check the key

When you finish, verify the result by a route that is independent of
how you got it:

- Substitute the answer back into the original equation.
- Estimate: is the magnitude even plausible? Is the sign right?
- Test a special or extreme case.
- Sketch it, or compare it against a graph.

This is not busywork. In an exam there is no solutions booklet, so
the ability to tell whether your own answer is right *is itself an
examined skill* — and it's one you never train if your only method of
checking is comparison with a key.

== Reviewing Without Peeking

This deserves its own section because it is the single most common
way students spend real effort and get almost nothing back.

#definition(title: "Illusion of fluency")[
  The mistaken sense that you know something because it feels
  familiar and easy to follow. Recognizing a correct solution is easy
  and feels like competence; producing one from nothing is hard and
  is what is actually assessed. The two feel similar from the inside
  and are completely different skills.
]

Reading through solved exercises and thinking "yes, I know this" is
the purest form of this illusion. Of course it looks familiar — you
are looking straight at it.

#warning[
  A related trap is subtler and harder to notice, because it happens
  below the level of intention: when the next step is visible
  anywhere on the page, your eye takes it. You are then no longer
  solving the problem; you are confirming a solution you have already
  half-read, while sincerely believing you worked it out. This is why
  the solutions in this course live in a *separate booklet* rather
  than under each exercise.
]

The fix is physical, not motivational. Willpower is the wrong tool
here; distance is the right one.

#keybox(title: "The cover rule")[
  Solutions face down, or closed, or in another room. Blank paper.
  Write the solution from nothing. *Only then* compare.
]

#exploration(title: "Test it on yourself")[
  Pick six exercises from a chapter you finished at least a week ago.
  Do three of them with the solutions closed, and three with the
  solutions open beside you. Note how long each took and how
  confident you felt. Then wait three days and redo all six from
  scratch, closed. Which three came back?
]

== Using Your Resources in the Right Order

When you're stuck, there is a natural order to what you reach for,
and most of the value is in not skipping the early steps. Each rung
costs a little more of your independence than the one below it — so
climb, don't jump.

#data-table(
  columns: (0.5fr, 1.5fr, 2fr),
  row-height: auto,
  [#text(weight: "bold")[Order]],
  [#text(weight: "bold")[Resource]],
  [#text(weight: "bold")[Why here]],

  [1],
  [Your own notes and worked examples],
  [Closest to what the exam will look like, and written in the
    language your teacher actually used.],

  [2],
  [The course materials — theory boxes, earlier exercises, the
    toolbox],
  [Written for exactly your level and exactly this sequence of
    topics.],

  [3],
  [A classmate],
  [Explaining is the single best way for *them* to learn, and a peer
    explanation is often pitched better than an expert one.],

  [4],
  [Another book, or a video],
  [A genuinely different presentation can unstick you — but it may
    use different notation and different conventions.],

  [5],
  [Me],
  [Bring the sentence you wrote about where you got stuck.],

  [6],
  [An AI tool],
  [Last, and only under the conditions in the next section.],
)

Two notes on the middle rungs.

*Videos* are the most overrated study resource in existence, for one
specific reason: watching a competent person solve a problem
smoothly produces a strong feeling of understanding and almost no
retrieval. If you use one, pause it before every step and predict
what comes next, then compare. A video you watched straight through
is entertainment.

*Working with classmates* is excellent and easy to do badly. "We did
it together" very often means one person solved it and the other
watched — see the paragraph above for why that's worth roughly
nothing. The version that works: solve separately first, then
compare, then argue about the differences. The disagreements are the
valuable part.

== Working with AI

AI tools are useful, they are not going away, and pretending
otherwise would be silly. They are also, used naively, the most
efficient method ever invented for feeling like you learned something
while learning nothing at all. Both of those statements are true at
once, and the whole skill is in knowing which mode you're in.

#keybox(title: "The principle")[
  Access to knowledge is not the same as knowledge.
]

=== Why the naive use backfires — with evidence

This is not a hunch. In a large study of around a thousand high
school students in Turkish math classes, Bastani and colleagues
(2024) gave some students access to a standard GPT-4 assistant while
they practiced. Those students did substantially *better* than the
control group on the practice problems — and then substantially
*worse* than the control group on a later exam they wrote without
any assistance. Having the tool made the practice look successful
and made the learning worse.

The same study included a second version: an assistant restricted to
giving hints and asking questions rather than answers. That version
did not produce the harm. The difference was not the technology. It
was the role the tool was allowed to play.

Three mechanisms are worth understanding, because they generalize
well beyond this one study:

- *Fluency, again.* A complete, well-formatted solution appearing on
  your screen produces the same feeling of understanding as reading a
  worked example — with even less effort, and therefore even less
  learning. Everything in the section on peeking applies here, in a
  stronger form.
- *Offloading stops encoding.* When people know an answer will remain
  available, they reliably remember less of it. This is efficient
  behavior for a phone number and disastrous behavior for a method
  you will need in an exam room with no phone.
- *The errors are invisible by design.* These tools are fluent first
  and correct second. When one makes a mistake in a multi-step
  algebraic derivation, the mistake is usually in the middle of an
  otherwise plausible-looking argument, in confident prose, with the
  right formatting. You can only catch that if you already understand
  the material — which closes the loop: to use the tool safely, you
  need the knowledge the tool would have replaced.

#warning[
  One specific failure mode you will meet quickly: push back on a
  correct answer and many AI tools will apologize and "correct"
  themselves into a wrong one. They are trained to be agreeable, and
  agreement is not the same as being right. If you say "are you sure?
  I got something else" and it immediately changes its answer, you
  have learned nothing about the mathematics — only something about
  the tool.
]

=== The four roles that do work

The pattern in every good use below is the same: *you* keep the
mathematical work, and the tool takes a supporting job you define
explicitly. If you don't assign a role, it defaults to solving the
problem, which is the one thing that helps you least.

*Tutor — it asks, you answer.*

#quotebox[
  I'm working on this problem: ... Do not give me the answer or the
  next step. Ask me one question at a time to help me find where my
  own reasoning breaks down, and wait for my reply before asking the
  next one.
]

*Explainer — a second presentation of an idea you've already met.*

#quotebox[
  Explain why multiplying both sides of an inequality by a negative
  number flips the sign. Start with a concrete numerical example,
  then give the general argument. I have already read the explanation
  in my notes and it didn't help, so use a different approach.
]

*Checker — you solve, it audits.* Note the constraint in the second
sentence; without it you will simply be handed the answer.

#quotebox[
  Here is my solution: ... Do not solve the problem yourself and do
  not tell me the correct answer. Tell me only the first line where
  something goes wrong, and nothing about how to fix it.
]

*Generator — practice material, built the way the research says it
should be.*

#quotebox[
  Generate ten practice problems on solving quadratic equations, at
  about the level of a first-year Gymnasium course. Shuffle in three
  problems on linear systems and three on simplifying fractions, in
  random order, and do not label which is which. Put the final
  answers in a single list at the end, with no worked solutions.
]

That last prompt is worth a second look: "shuffled, unlabeled" builds
the skill of *choosing* a method, which drilling one problem type
never trains, and "answers only, at the end" removes the temptation
to peek. It is the advice from _How to Learn Math_, turned into a
prompt.

*A fifth, specific to this course:* these classes run in English, and
a term you half-know in German is a real obstacle.

#quotebox[
  What is the standard English mathematical term for "Scheitelpunkt"?
  Give the term, a one-sentence definition, and one example sentence
  using it correctly.
]

=== Prompts that will cost you the exam

- _"Solve this: ..."_ — You get an answer you cannot evaluate, and
  you practice nothing.
- _"Is this right?"_ with a photo and no attempt of your own — Same
  problem, with extra steps.
- _"Explain this to me"_ pasted in before you have tried the problem
  — Skips the productive-failure stage entirely; the explanation
  lands on nothing and slides off.
- _"Write it up nicely"_ for something you'll hand in — Now it isn't
  yours, and the person it fools is you.

=== The verification rule

#keybox(title: "Never accept a result you cannot check independently")[
  Substitute it back. Estimate the magnitude. Test a special case.
  Sketch it. If you have no way at all to check an AI's answer, then
  you were not in a position to use it on that problem.
]

#ai-box(role: "Checker")[
  Take an exercise you have already solved correctly and are
  confident about. Ask an AI tool to solve it, then compare its work
  to yours line by line. Where the two differ, decide who is right
  *before* looking anything up — and write down your reason. Then, if
  its answer was correct, tell it you think it made a mistake and see
  what it does.
]

#remark[
  You will notice that the AI tasks scattered through this course
  always specify a role. That is not decoration. It is the entire
  difference between the version of the tool that helps you and the
  version that quietly takes the exam for you three months early.
]

== One Page, Everything

#data-table(
  columns: (1fr, 1.7fr),
  row-height: auto,
  [#text(weight: "bold")[Situation]],
  [#text(weight: "bold")[What to do]],

  [In class],
  [Paper. Screens flat. One line per step, generous space, equal
    signs aligned. Write down the attempt, including the wrong one.
    Ask the question now.],

  [New material],
  [Try it before you're shown. Add one sentence in your own words to
    every worked example.],

  [Homework],
  [Set a length. Phone elsewhere. Fifteen minutes of real attempts
    with the toolbox before any help. Write down where you got
    stuck.],

  [Finishing a problem],
  [Check it yourself — substitute back, estimate, special case —
    *then* look at the key.],

  [Reviewing],
  [Solutions closed. Blank paper. Reproduce from nothing. Ten minutes
    on most days, not three hours once.],

  [Stuck],
  [Notes, then materials, then a classmate, then a book, then me,
    then AI. In that order.],

  [Using AI],
  [Assign it a role: Tutor, Explainer, Checker, Generator. Never
    accept a result you can't check.],
)

== Where These Rules Come From

#only-theory[
  _How to Learn Math_ lists the general learning-science sources. These
  are the
  ones specific to the practices in this chapter.

  - F. Sana, T. Weston, & N. J. Cepeda, "Laptop Multitasking Hinders
    Classroom Learning for Both Users and Nearby Peers," _Computers &
    Education_ (2013) — the second-hand-distraction result behind
    Rule 2.
  - H. Bastani, O. Bastani, A. Sungu, H. Ge, Ö. Kabakcı, & R.
    Mariman, "Generative AI Can Harm Learning" (2024) — the high
    school math field experiment described above, including the
    hint-only variant that avoided the harm.
  - E. F. Risko & S. J. Gilbert, "Cognitive Offloading," _Trends in
    Cognitive Sciences_ (2016) — a review of what happens to memory
    when information stays externally available.
  - R. A. Bjork, J. Dunlosky, & N. Kornell, "Self-Regulated Learning:
    Beliefs, Techniques, and Illusions," _Annual Review of
    Psychology_ (2013) — on why learners systematically misjudge
    their own learning, which is the illusion of fluency in its
    general form.
  - C. D. Morehead, J. Dunlosky, & K. A. Rawson, "How Much Mightier
    Is the Pen Than the Keyboard for Note-Taking?" _Educational
    Psychology Review_ (2019) — included deliberately as a
    counterweight: the popular claim that handwritten notes beat
    typed ones did not replicate cleanly. The case for Rule 1 rests
    on the two-dimensional nature of mathematical notation and on
    practicing under exam-like conditions, not on that literature.
]
