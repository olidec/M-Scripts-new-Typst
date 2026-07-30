// main-basic.typ — Distributions, Foundations (GLF) lecture notes.
//
// Source of truth for WHICH chapters GLF reads and in WHAT order —
// exercises-basic.typ and solutions-basic.typ both extract their
// chapter lists from here via read-chapter-files(from:), which parses
// this file as PLAIN TEXT. Hence three hard rules for the
// register_chapters block (STYLE_GUIDE.md §3): one entry per line,
// full literal root-absolute paths, and every line within the
// 80-column formatter width so the auto-formatter never wraps an
// entry (a wrapped entry silently disappears from both parsers).
//
// SCHEDULING: GLF meets this unit in year 4, SPF in year 3 — so the
// two tracks are a full year apart here, unlike every earlier unit.
//
// LEVEL SPLIT — the widest in the course so far. GLF's Lehrplan (Y4
// 2.1) requires the random variable, the expected value and the
// binomial distribution, and nothing else from this unit. It does NOT
// require the normal distribution. GLF therefore satisfies its
// inferential requirement (Y4 2.2, "Hypothesen ... mit einem
// geeigneten Test ODER geeigneten Vertrauensintervallen") with an
// exact binomial test, which needs no normal distribution at all.
//
// Everything from ch-normal-intro onwards is genuinely optional for
// GLF: overview material for students heading towards a subject that
// will need it. The chapters are ordered so that teaching can stop at
// any point without leaving a gap.

#import "../../common/preamble.typ": *
#set-subject-name("Distributions")
#set-level("basic")

#register_chapters(
  ("Random variables", "/src/units/distributions/ch-random-variables"),
  // Uncomment as chapters are finished (commented lines are safely
  // invisible to both text parsers — they don't start with `("` ):
  //
  // ---- required for GLF (Lehrplan Y4 2.1 / 2.2) ----
  ("Binomial", "/src/units/distributions/ch-binomial"),
  ("Binomial test", "/src/units/distributions/ch-binomial-test"),
  // ("Models", "/src/units/distributions/ch-models"),
  //
  // ---- optional for GLF from here on ----
  // ("Normal curve", "/src/units/distributions/ch-normal-intro"),
  // ("Confidence", "/src/units/distributions/ch-confidence-intro"),
  //
  // ch-normal, ch-confidence, ch-more-distributions and ch-modern are
  // SPF-only and are registered in main-high.typ alone. Do not add
  // them here.
)

#include_chapters()
