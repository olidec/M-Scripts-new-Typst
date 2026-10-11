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

== Worked example

Here's what a hesitation actually looks like, using the arithmetic
series sum formula, $S_n = n/2 (a_1 + a_n)$.

#example(title: [First pass — closed book])[
  "An arithmetic series adds up the terms of an arithmetic sequence,
  so $S_n = a_1 + a_2 + dots.c + a_n$. There's a shortcut:
  $S_n = n/2 (a_1 + a_n)$. The idea is you pair up the first and last
  term, then the second and second-last, and so on — each pair adds
  up to the same amount, so #text(fill: accent, weight: "bold")[\[hesitation\]]
  — so there are $n/2$ such pairs, and you multiply."
]

Notice what actually happened: the formula came out fine, and so did
the pairing idea. The stall hit at *why every pair sums to the same
amount* — that claim got asserted, not explained. That's the gap,
not "I forgot the formula."

#example(title: [Checking the gap])[
  Pairing term $k$ from the start with term $k$ from the end: the
  first has moved $(k-1) d$ above $a_1$, the last has moved
  $(k - 1) d$ below $a_n$. So each pair is
  $(a_1 + (k-1) d) + (a_n - (k-1)d) = a_1 + a_n$ — the $(k-1)d$
  cancels, for every $k$. That's the whole reason the trick works: it
  isn't a coincidence about first-and-last, it's that moving up and
  down by matching amounts always cancels.
]

#example(title: [Second pass — closed book])[
  "An arithmetic series adds up the terms of an arithmetic sequence:
  $S_n = a_1 + dots.c + a_n$. Pair the $k$-th term from the start
  with the $k$-th from the end. The first is $(k-1)d$ above $a_1$;
  the last is $(k-1) d$ below $a_n$ — so the pair's sum is always
  $a_1 + a_n$, because the $(k-1)d$ shift cancels between them.
  With $n$ terms that's $n/2$ pairs (matching each term exactly once),
  giving $S_n = n/2 (a_1 + a_n)$."
]

#keybox(title: [What the hesitation was worth])[
  The student could already *write down* the correct formula before
  checking anything — the gap wasn't recall, it was justification. A
  "compute $S_20$" exam question would never have caught this. A
  "prove that..." or "explain why..." question would have, immediately.
  Finding that out on a practice page costs nothing; finding it out
  on the exam costs the whole problem.
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
