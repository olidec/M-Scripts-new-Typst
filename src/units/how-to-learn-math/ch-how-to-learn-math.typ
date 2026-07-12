// ============================================================
//  ch-how-to-learn-math.typ
//  "Chapter 0" — How to Learn Math
//
//  Identical for GLF and SPF: no only-high[...] content anywhere
//  in this file. It is meant to be read once, near the start of
//  Year 1, before either track has diverged in any way that would
//  make level-specific advice necessary.
//
//  Import path assumes this file lives at
//    src/units/how-to-learn-math/ch-how-to-learn-math.typ
//  (two levels below src/, same depth as every other unit) so the
//  import below matches the "../../common/preamble.typ" convention
//  used throughout the project — see STYLE_GUIDE.md §4.
// ============================================================
#import "../../common/preamble.typ": *

#show: chapter-template.with(title: "How to Learn Math")

= How to Learn Math

#quotebox[
  This chapter is not about any particular topic in math. It is about
  *how to get better at math* — because getting better at math is
  itself a skill, and like every other skill in this course, it can be
  practiced, and it can be learned.
]

== Math Is a Skill, Not a Gift

It is easy to look at a classmate who "gets it" quickly and conclude
that some people simply have a math brain and others don't. That
belief is common, comfortable, and wrong — and worse, it is
self-fulfilling: if you believe your ability is fixed, struggling
feels like proof that you've hit your ceiling, so you stop pushing
right at the moment more effort would have paid off.

#definition(title: "Growth mindset")[
  The belief that ability in a domain — including math — develops
  through effortful practice and effective strategy, rather than being
  fixed at birth. Contrasted with a *fixed mindset*, the belief that
  ability is an innate trait you either have or don't.
]

The psychologist Carol Dweck spent decades studying how these two
beliefs shape behavior, and summarized that research for a general
audience in her book _Mindset_ (2006). Jo Boaler, a mathematics
education researcher, applied the same ideas specifically to math
classrooms in _Mathematical Mindsets_ (2015) — her central argument is
that math classes, more than most other subjects, tend to send
students the message that speed and innate talent are what matter,
when neither is actually true of how mathematicians work.

#warning[
  A growth mindset is *not* the belief that effort alone is enough, or
  that telling yourself "I can do this" will fix a bad study strategy.
  Believing change is possible only helps if it leads you to actually
  change *what* you do — the techniques in the rest of this chapter are
  the "what." Mindset without technique is just optimism.
]

#remark[
  Being fast at a calculation and being good at math are not the same
  thing. Some of the most capable mathematicians work slowly and
  carefully by choice. Speed under exam conditions is a separate skill
  you can train later — don't let it stand in for the thing that
  actually matters: whether your reasoning is sound.
]

== A Two-Minute Tour of How Memory Works

A little bit of "meta" knowledge — knowing *why* certain study habits
work — makes it much easier to actually stick with them, especially
when they feel harder than the alternative. And several of the most
effective techniques *do* feel harder while you're doing them. That's
not a coincidence.

#definition(title: "Desirable difficulty")[
  A difficulty introduced deliberately into a learning task that slows
  you down or makes you feel less confident in the moment, but that
  measurably improves how much you remember later. The term comes from
  memory researcher Robert Bjork.
]

Three findings worth knowing:

- *Retrieving beats re-reading.* Closing your notes and trying to
  reconstruct an idea from memory — even if you get it wrong or only
  half-remember it — builds a stronger memory than reading the same
  material again, even though re-reading *feels* more productive in
  the moment. This is called the *testing effect*, and it was
  demonstrated clearly by Roediger and Karpicke (2006): students who
  took a practice recall test remembered dramatically more a week
  later than students who spent the same amount of time re-reading,
  even though the re-readers had felt more confident right after
  studying.
- *Spacing beats cramming.* The same total amount of study time
  produces much better long-term retention when it's spread across
  several short sessions with gaps in between, rather than compressed
  into one long session. This is the *spacing effect*, and it is one
  of the most consistently replicated findings in all of learning
  science — a large meta-analysis of hundreds of experiments by
  Cepeda, Pashler, Vul, Wixted, and Rohrer (2006) confirmed it across a
  huge range of materials and delays.
- *Mixing beats blocking.* Practicing several different kinds of
  problems in a shuffled order builds a skill that pure repetition of
  one kind does not: recognizing *which* method a new problem needs.
  Rohrer and Taylor (2007) showed this directly with math students —
  mixed practice felt harder and produced *worse* performance during
  the practice session itself, but noticeably better performance on a
  test given later.

#keybox(title: "The pattern to notice")[
  All three of these have the same shape: the version that *feels*
  easier and more comfortable in the moment (re-reading, cramming one
  night, drilling one problem type at a time) is worse for what you'll
  actually remember. The version that feels slower and less certain is
  usually the one that's working.
]

== Learning Something New

When you meet a new idea for the first time, the goal is not to get
the "right answer" as fast as possible — it's to build a mental
structure the idea can attach to.

- *Attempt before you're shown.* Given a new type of problem, spend a
  few minutes actually trying it — even blind guesses count — before
  looking at how it's solved. Manu Kapur's research on what he calls
  *productive failure* (2014) found that students who wrestled with a
  problem on their own first, and only afterward received instruction,
  built a *deeper* conceptual understanding than students who were
  taught the method first and then practiced it — even though the
  "struggle first" group did worse on the initial attempt itself.
- *Explain it in your own words, out loud.* If you can't explain *why*
  a step works — not just *that* it works — to a friend, a parent, or
  even to an empty room, you don't fully have it yet. This forces you
  to notice the gaps that silently reading past.
- *Ask "why," not just "how."* "How do I solve this" gets you through
  one exercise. "Why does this method work" gets you through every
  exercise like it, including ones you haven't seen yet.
- *Connect it to what you already know.* New ideas stick far better
  when they're linked to something already in memory rather than filed
  away on their own — this is exactly what the "techniques you know so
  far" boxes throughout this course are for, and it's worth doing the
  same thing informally in your own notes: "this is like [earlier
  idea], except ..."

#ai-box(role: "Tutor")[
  Instead of asking an AI tool to solve a new type of problem for you,
  try telling it explicitly: _"Don't give me the answer. Ask me
  guiding questions until I work it out myself."_ Used this way, an AI
  tool can behave like a patient tutor rather than an answer machine —
  but it will only do that if you ask it to. Left to its own devices,
  most AI tools default to just solving the problem, which is the one
  outcome that helps you learn the least.
]

== Practicing Something You Already Know

Once you've met an idea, practice is what turns "I followed that" into
"I could do that again in three weeks without help." A few concrete
habits:

+ *Keep solutions physically separate from exercises, and use them as
  a checkpoint, not a crutch.* Solve the problem completely before you
  look. When you revisit an old exercise later, cover the solution and
  try to reconstruct it from scratch first — only check afterward.
  Every time you peek early, you're practicing *recognizing* a
  solution instead of practicing *producing* one, and those are
  different skills. Only the second one helps you in an exam.
+ *Make up your own problems.* Take a solved exercise and change the
  numbers, the context, or one condition, and solve your new version.
  Better yet, pose it to a friend and see if you agree on the answer.
  Generating a problem forces you to understand its structure well
  enough to vary it — you cannot invent a good variation of something
  you've only memorized. (This connects to what memory researchers
  call the *generation effect*, first demonstrated by Slamecka and
  Graf (1978): information you produce yourself is remembered better
  than information you're simply given.)
+ *Mix problem types instead of drilling one at a time.* Rather than
  doing twenty near-identical problems in a row, shuffle several kinds
  together — see the spacing/mixing research above. If your textbook
  or worksheet groups problems by type, deliberately practice out of
  order sometimes.
+ *Little and often beats a single long session.* Ten focused minutes
  every other day adds up to more retained knowledge than three hours
  the night before a test — not because three hours is a bad amount of
  time, but because *massed* time is a much less efficient way to
  spend it than the same time spread out. The night-before session
  also arrives too late to catch anything you'd need a second pass to
  fix.

#exploration(title: "Cold retrieval")[
  Pick an exercise you solved correctly at least a week ago. Cover the
  solution completely. Try to solve it again from nothing. If you get
  stuck somewhere, that's not a failure — that's exactly the spot your
  memory needed reinforcing, and now you know where to spend your next
  ten minutes.
]

#exploration(title: "Invent a variant")[
  Take any exercise from this chapter's problem set and change it:
  different numbers, a different real-world context, or one condition
  flipped (e.g. "at least" instead of "at most"). Solve your version.
  Then trade with a partner and solve each other's.
]

== Being Stuck Is Part of the Job

Every worthwhile math problem includes a stretch where you don't yet
know what to do. That feeling — call it stuckness, or frustration — is
not a sign that something has gone wrong. It's usually a sign that the
problem was pitched correctly.

#definition(title: "Frustration tolerance")[
  The capacity to stay engaged with a difficult task despite the
  discomfort of not yet having a solution, instead of disengaging or
  giving up. Like physical stamina, it is built through repeated,
  manageable exposure — not something you either have or don't.
]

Educational researchers use the phrase *productive struggle* for the
kind of difficulty that, if you stay with it, leads to real learning —
as opposed to struggle that's simply too far beyond your current
ability to go anywhere useful. Math is one of the best subjects for
practicing this, precisely because being stuck is built into almost
every genuinely interesting problem, and because a problem's solution
is checkable — you *know* when you've actually gotten there, which
means the struggle has a clear end point to work toward.

Some concrete moves for the moment you're stuck, rather than just
"try harder":

#toolbox()

#remark[
  Notice that being stuck for part of the expected time on an exercise
  is *normal*, not a sign you can't do it — several exercises in this
  course explicitly tell you how long to expect to spend, including
  time to be stuck in. That's on purpose.
]

#exploration(title: "Name the moves")[
  Next time you get stuck on a homework problem, before asking anyone
  for help, write down (a) exactly where you got stuck, and (b) which
  heuristic from the toolbox above you tried, or could try, before
  giving up on it. Compare notes with a classmate — you'll often find
  you were closer than you thought.
]

== A Simple Weekly Routine

You don't need an elaborate system — you need a routine you'll
actually keep. A minimal version that puts the ideas above into
practice:

#data-table(
  columns: (1fr, 2.2fr),
  [Day], [What to do],
  [Right after class], [Skim your notes once — just enough to catch
    anything that made no sense while it's still fresh.],
  [+2 days], [Ten minutes, no notes: redo one or two exercises from
    that class from memory. Check afterward, not before.],
  [+1 week], [Ten minutes: redo one of the same exercises again, plus
    one from an earlier chapter, mixed together.],
  [Night before a test], [Review only — this is not the time to learn
    anything new. If it's new the night before, it was too late three
    weeks ago.],
)

== Further Reading

#only-theory[
  You don't need to read any of this to do well in this course — it's
  here for anyone curious where these ideas actually come from, or who
  wants a more complete treatment than a few paragraphs in a math
  textbook can give.

  *For students:*
  - Barbara Oakley, _A Mind for Numbers: How to Excel at Math and
    Science (Even If You Flunked Algebra)_ (2014) — an accessible,
    student-facing guide built around exactly the retrieval-and-spacing
    ideas above, written by an engineer who struggled with math herself
    before switching fields.
  - Peter Brown, Henry Roediger, and Mark McDaniel, _Make It Stick: The
    Science of Successful Learning_ (2014) — a readable synthesis of
    the cognitive-science research on effective studying, for a general
    audience.
  - Jo Boaler, _Mathematical Mindsets_ (2015) — growth mindset applied
    specifically to math classrooms.

  *The underlying research, for the curious:*
  - Carol Dweck, _Mindset: The New Psychology of Success_ (2006).
  - H. L. Roediger & J. D. Karpicke, "The Power of Testing Memory:
    Basic Research and Implications for Educational Practice,"
    _Perspectives on Psychological Science_ (2006) — the testing
    effect.
  - N. J. Cepeda, H. Pashler, E. Vul, J. T. Wixted, & D. Rohrer,
    "Distributed Practice in Verbal Recall Tasks: A Review and
    Quantitative Synthesis," _Psychological Bulletin_ (2006) — the
    spacing-effect meta-analysis.
  - D. Rohrer & K. Taylor, "The Shuffling of Mathematics Practice
    Problems Boosts Learning," _Instructional Science_ (2007) —
    interleaving, tested specifically on math problems.
  - M. Kapur, "Productive Failure in Learning Math," _Cognitive
    Science_ (2014).
  - J. Dunlosky, K. Rawson, E. Marsh, M. Nathan, & D. Willingham,
    "Improving Students' Learning With Effective Learning Techniques,"
    _Psychological Science in the Public Interest_ (2013) — a
    practical, evidence-graded review comparing many common study
    techniques against each other.
]
