// ============================================================
//  self-check-learning-habits.typ
//  Formative self-check on "How to Learn Math" + "How to Work
//  in Math". Not graded, not registered as a chapter by default —
//  compile standalone and hand out.
//
//  DELIBERATE ARCHITECTURE EXCEPTION: this file does NOT use
//  exercise(). Two reasons. (1) exercise() routes its solution to
//  a separate booklet, and the entire value of a formative item is
//  feedback arriving while the student still remembers what they
//  were thinking — delayed feedback on a misconception is close to
//  worthless. (2) exercise() steps the global ex-counter, and
//  these are not course exercises; they must not shift the
//  numbering that the solutions booklets depend on. The feedback
//  therefore lives in this same file, behind a pagebreak.
//
//  HOW TO RUN IT (about 15 minutes):
//   - Hand out pages 1-2 only. Keep the answers page back until
//     every student has written an answer to all of Part A.
//     Closed notes — say so out loud; it is the point.
//   - Run Part A as a hinge: collect a show of hands per question
//     (a/b/c/d) BEFORE handing out the feedback. The distribution
//     tells you what to reteach, and the public disagreement is
//     what makes the feedback land. Items 4 and 6 are the ones
//     that usually split the room.
//   - Part C is private. Never collect it, never comment on it.
//
//  Level-agnostic: no only-high/only-basic content anywhere.
//  Lives at src/units/how-to-learn-math/self-check-learning-habits.typ
// ============================================================
#import "../../common/preamble.typ": *

#show: chapter-template.with(title: "Self-Check: How You Work")

= Self-Check: How You Work

#quotebox[
  This is not graded and never will be. It is also closed-notes,
  which is not a formality — answering from memory is the first item
  on the test. Write an answer to every question in Part A before you
  turn to the feedback page. A wrong answer you committed to is worth
  far more here than a right answer you looked up.
]

== Part A — Six Quick Decisions

*Question 1.* You have read your notes on quadratic equations three
times. Everything on the page makes sense. What is the best use of
your next ten minutes?

#enum(
  numbering: "a)",
  [Read them once more, to be safe.],
  [Close the notes and write out the method from memory, then check.],
  [Go through the worked examples again, following each step
    carefully.],
  [Move on to the next topic — you understand this one.],
)

*Question 2.* You have 90 minutes in total to prepare for a test that
is two weeks away. Which plan will leave you remembering the most on
the day?

#enum(
  numbering: "a)",
  [90 minutes the evening before the test.],
  [45 minutes on each of the two evenings before the test.],
  [All 90 minutes today, so it is done early and off your mind.],
  [Roughly 10 minutes on nine different days across the two weeks.],
)

*Question 3.* A worksheet has twelve problems of four different
types. Which order will help you most on the test?

#enum(
  numbering: "a)",
  [All three of type 1, then all three of type 2, and so on.],
  [Shuffled, so consecutive problems are usually different types.],
  [It makes no difference — the same twelve problems either way.],
  [Grouped by type, because you should master one thing before
    moving to the next.],
)

*Question 4.* You take the advice above and practice mixed problems.
It feels harder than before, you are slower, and you make more
mistakes than when you drilled one type at a time. What does that
mean?

#enum(
  numbering: "a)",
  [The method does not suit the way you learn.],
  [You should go back to one type at a time until it feels easy
    again.],
  [This is exactly what it is supposed to feel like.],
  [You did not properly understand the original lesson.],
)

*Question 5.* You are stuck on an exercise and you decide to use an
AI tool. Which prompt is most likely to help you in the exam, where
the tool will not be available?

#enum(
  numbering: "a)",
  ["Solve this problem: ..."],
  ["Explain how to solve this, step by step."],
  ["Do not give me the answer or the next step. Ask me one question
    at a time until I find where my own reasoning breaks down."],
  ["Give me the answer so that I can check my own work against it."],
)

*Question 6.* An AI tool produces a clean, confident, well-formatted
solution. Your own answer is different. What do you do first?

#enum(
  numbering: "a)",
  [Substitute both answers back into the original problem and see
    which one survives.],
  [Assume the tool is right — it is correct far more often than you
    are.],
  [Tell it you think it is wrong, and take whatever it says next.],
  [Ask a second AI tool and go with the majority.],
)

== Part B — Two Scenarios

*Question 7.* You have been working on a problem for fifteen minutes
and made no progress at all. Write down the next three things you
will do, in order.

#v(2.5cm)

*Question 8.* Here is a real study session:

#quotebox[
  I sat down with the solutions booklet open beside me. I did eight
  quadratic equations, one after the other. Whenever I could not see
  what to do within about twenty seconds, I glanced at the next line
  of the solution and carried on. All eight came out right. I felt
  ready.
]

Name three separate things that are wrong with it, and say what each
one costs.

#v(3.5cm)

== Part C — An Honest Audit

Nobody will see this page. It only works if you are honest, and it is
the only part of this sheet that will actually change anything.

Thinking about the last seven days:

#enum(
  numbering: "1.",
  [On how many days did you do any math at all outside class?],
  [When you last reviewed something, were the solutions visible
    while you worked? Yes or no.],
  [When you were last stuck, how long did you work at it before
    reaching for help of some kind? Estimate in minutes.],
)

Now write one sentence, in this form:

#keybox(title: "The commitment")[
  This week, instead of #h(2.5cm) I will #h(4cm) .
]

Pick one change. Not four. A single habit you actually keep beats a
plan you abandon on Thursday.

#pagebreak()

== Answers, and Why

Check your answers only now. For each one you got wrong, read the
explanation of the option you *chose*, not just the correct one — the
reason a wrong answer was attractive to you is the useful information
on this page.

*Question 1 — b.*

#enum(
  numbering: "a)",
  [Re-reading is the most popular study method and one of the
    weakest. It feels productive because the material gets easier to
    read each time, which is not the same as getting easier to
    recall.],
  [*Correct.* Retrieving beats re-reading — and the check afterward
    tells you exactly which part to work on.],
  [Following someone else's correct steps trains recognition.
    The exam asks for production. These are different skills that
    feel identical from the inside.],
  ["It makes sense when I read it" is the classic report of a
    student who is about to be surprised by a test. The only
    evidence that you know something is that you could produce it
    without the page.],
)

*Question 2 — d.*

#enum(
  numbering: "a)",
  [Same time, worst result. Cramming also arrives too late to fix
    anything it uncovers.],
  [Better than a, still mostly massed. Two sessions is not spacing;
    it is cramming twice.],
  [A good trap: early is not the same as spaced. One block today
    leaves thirteen days for it to fade, with no second pass to
    catch it.],
  [*Correct.* Same 90 minutes, spread across nine gaps. The gaps are
    doing the work, not the minutes.],
)

*Question 3 — b.*

#enum(
  numbering: "a)",
  [Blocked practice. You will feel fluent by the third problem of
    each type — mostly because you already know which method to
    use.],
  [*Correct.* Shuffling forces you to *choose* a method, which is
    the part the exam actually tests. On a mixed sheet, nothing
    tells you which tool to reach for.],
  [The problems are the same; the skill you practice is not.],
  [The most reasonable-sounding wrong answer here, and worth
    understanding: "master one thing at a time" is fine for the
    first encounter with a method, and stops being good advice
    the moment you can do the method at all.],
)

*Question 4 — c.*

#enum(
  numbering: "a)",
  [This has nothing to do with how you personally learn. The effect
    shows up in essentially everyone who has been tested for it.],
  [The trap the whole idea is designed around. Going back to
    blocked practice restores the comfortable feeling and removes
    the benefit.],
  [*Correct.* Slower, harder, and more error-prone during practice
    is the signature of a desirable difficulty. Performance while
    you are learning and how much you retain afterward are two
    different measurements, and they frequently point in opposite
    directions.],
  [Extra mistakes here are caused by the *format* of the practice,
    not by a gap in your understanding.],
)

*Question 5 — c.*

#enum(
  numbering: "a)",
  [Produces an answer you are in no position to evaluate, and
    practices nothing.],
  [The most tempting wrong answer, because it sounds educational.
    But watching a fluent explanation appear is closer to watching a
    video than to solving a problem — and it skips the struggle that
    would have made it stick.],
  [*Correct.* You keep the mathematical work; the tool takes a
    supporting role you defined. Left undirected, these tools default
    to just solving the problem.],
  [Reasonable in principle, and in practice this is the prompt people
    use at the moment they have stopped trying. If you genuinely want
    to check your work, you need your own answer first — see
    Question 6.],
)

*Question 6 — a.*

#enum(
  numbering: "a)",
  [*Correct.* Verification by a route independent of how the answer
    was produced. This is the only move on the list that also works
    in an exam.],
  [They are fluent first and correct second. Mistakes in multi-step
    algebra usually sit in the middle of an argument that looks
    entirely plausible.],
  [The specific failure worth knowing about: push back and many of
    these tools will apologize and "correct" a right answer into a
    wrong one. Agreement is not evidence.],
  [Two confident guesses are not more reliable than one, and neither
    of them checked anything.],
)

*Question 7 — a model answer.*

Give yourself credit for any three of these, in roughly this order:

+ Go through the toolbox explicitly and actually try two moves on
  paper — a small case, a picture, a simpler version, working
  backwards. Considering them does not count.
+ Write down precisely where the wall is: the last line you are sure
  about, and what you cannot get past.
+ Take that sentence to class, a classmate, or a resource — in that
  order of preference.

If your three steps began with a search or a prompt, that is the
finding. The fifteen minutes are not a waiting period you have to sit
through before you are allowed to look something up; they are the
part that does the work.

*Question 8 — four flaws, any three.*

- *The solutions were open.* When the next step is visible anywhere
  on the page, your eye takes it, and you finish sincerely believing
  you worked it out. Cost: you practiced recognizing solutions, not
  producing them.
- *Eight problems of one type.* Blocked practice, so the method was
  never in question. Cost: no practice at choosing a method — the
  thing the test asks for.
- *Twenty seconds before peeking.* Cost: no productive struggle at
  all, and no idea afterward which parts you could actually have done
  alone.
- *"I felt ready."* Cost: the confidence is evidence about the
  session's comfort, not about what will be available in two weeks.
  Under these conditions it is the least reliable signal on the list.

== What to Do About Your Result

The point of this sheet is not the number you got right. It is which
single habit you change this week.

#data-table(
  columns: (1fr, 1.5fr),
  row-height: auto,
  [#text(weight: "bold")[If you missed]],
  [#text(weight: "bold")[Change this, starting this week]],

  [1 or 8],
  [Close the solutions. Blank paper, reproduce from nothing, compare
    afterward. This one change is worth more than the other five
    together.],

  [2],
  [Ten minutes on most days. Put it somewhere fixed — after dinner,
    on the train — so it is not a decision you have to make.],

  [3 or 4],
  [Shuffle your practice. When a worksheet is grouped by type, do it
    out of order on purpose, and expect it to feel worse.],

  [5 or 6],
  [Before you open an AI tool, decide out loud which role it gets:
    Tutor, Explainer, Checker, or Generator. If you cannot name one,
    you are not ready to use it on that problem yet.],

  [7],
  [Next time you are stuck, set a timer for fifteen minutes and
    write down where the wall is before you do anything else.],
)

#remark[
  If you got everything right, the honest test is Part C, not Part A.
  Knowing what good practice looks like and doing it are famously
  unrelated — that gap is the normal case, not a personal failing,
  and closing it is what the rest of the year is for.
]
