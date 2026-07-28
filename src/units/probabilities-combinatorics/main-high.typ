// main-high.typ — Probabilities & Combinatorics, Advanced (SPF)
// lecture notes.
//
// Source of truth for the SPF chapter list and order —
// exercises-high.typ and solutions-high.typ extract their chapter
// lists from here via read-chapter-files(from:), which parses this
// file as PLAIN TEXT. Same three rules as in main-basic.typ: one
// entry per line, full literal root-absolute paths, every line
// within the 80-column formatter width (a formatter-wrapped entry
// silently disappears from both text parsers).
//
// SCHEDULING: both tracks meet this unit in year 2, after
// Descriptive Statistics (Lehrplan SPF 3.1–3.2).
//
// LEVEL SPLIT: ch-counting-advanced is registered here and
// deliberately absent from main-basic.typ. It carries SPF 3.2's
// "entscheiden, welche Abzählstrategie zielführend ist" and
// selection with repetition (the donut-shop problem), neither of
// which appears in GLF's Lehrplan. Everything else is shared and
// gated inside the chapters via only-high / level:.

#import "../../common/preamble.typ": *
#set-subject-name("Probabilities & Combinatorics")
#set-level("high")

#register_chapters(
  ("Chance", "/src/units/probabilities-combinatorics/ch-randomness"),
  ("Events", "/src/units/probabilities-combinatorics/ch-sample-spaces"),
  ("Rules", "/src/units/probabilities-combinatorics/ch-prob-rules"),
  // Uncomment as chapters are finished (commented lines are safely
  // invisible to both text parsers — they don't start with `("` ):
  //
  // ("Conditional", "/src/units/probabilities-combinatorics/ch-conditional"),
  // ("Trees", "/src/units/probabilities-combinatorics/ch-trees"),
  // ("Counting", "/src/units/probabilities-combinatorics/ch-counting"),
  //
  // SPF-only — see the header note:
  // ("Advanced", "/src/units/probabilities-combinatorics/ch-counting-advanced"),
  //
  // ("Combined", "/src/units/probabilities-combinatorics/ch-prob-counting"),
  // ("Paradoxes", "/src/units/probabilities-combinatorics/ch-paradoxes"),
)

#include_chapters()
