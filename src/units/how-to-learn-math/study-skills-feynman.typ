// study-skills-feynman.typ — standalone one-pager, not part of a unit's
// chapter registry. Adjust the import path to wherever this file ends
// up living relative to src/common/preamble.typ.
#import "../../common/preamble.typ": *
#set-subject-name("Study Skills")
#show: chapter-template.with(title: "The Feynman Method — For Math")

Richard Feynman's trick for learning something was simple: explain it,
in plain words, as if to someone who has never seen it. Not "study"
it — *explain* it, out loud or on paper, start to finish, without
looking anything up.

The point isn't the explanation itself. It's where the explanation
breaks. The moment you slow down, reach for a word you can't define,
or write "and then you just..." — that's not a lapse in your
explaining. That's the exact boundary of what you actually
understand, and it's usually invisible until you try to say the
thing out loud.

#keybox(title: [The four steps])[
  1. *Choose* a topic — one definition, theorem, or type of problem.
  2. *Explain* it from scratch, in your own words, without notes.
  3. *Locate* every place you hesitated, stalled, or got vague.
  4. *Return* to the source for those specific gaps only — then
    explain the whole thing again, from the top.
]

== Adapting it to math

Two things are specific to math:

- Math has two kinds of things to explain, and they hide different
  gaps. Explaining a *definition or theorem* exposes gaps in
  understanding a claim. Explaining a *worked solution* exposes gaps
  in a procedure — and procedural gaps hide easily behind phrases
  like "you just isolate $x$" or "it simplifies to." Force a *why*
  after every *what*: not just which step comes next, but why that
  step is the right move here.
- Writing the explanation works as well as speaking it, and is
  sometimes better, because the hesitation shows up as a concrete
  symptom: the point where you stop writing symbols and want to write
  "$dots.h.c$" or "one can show that."

#remark[
  Don't stop to fix a gap the moment you hit it — mark it (circle it,
  underline it, whatever) and keep going to the end. Fixing as you go
  hides how much you can actually produce unprompted, which is the
  whole point of the exercise.
]

== Before a regular test

Pick one theorem, definition, or worked example per chapter on the
test. Closed book, blank page: explain it as if to a classmate who
missed that lesson. Mark every hesitation. Open the booklet only for
those marked points — then close it and explain the whole thing again
from scratch. If you get through it clean, that topic is done; if
not, you now know exactly what to look up next, not just that
"something" was fuzzy.

== Before the final exam

Same routine, run across an entire year's — or several years'
— material instead of one chapter. Go topic by topic through the
syllabus (a chapter's `objectives()` list is a ready-made checklist)
and Feynman each one briefly. What this buys you that re-reading
notes doesn't: a map of *where* your remaining study time should go.
Two topics that both feel "familiar" on a re-read can be very
different once you try to explain them — and the final rewards
finding that out weeks before the exam, not during it.

#quotebox[
  If you can't explain something in simple terms, you don't
  understand it.
]
#align(right)[#text(
  size: 9pt,
  fill: luma(110),
)[— attributed to Richard Feynman]]
