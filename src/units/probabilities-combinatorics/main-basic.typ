// main-basic.typ — Probabilities & Combinatorics, Foundations (GLF)
// lecture notes.
//
// Source of truth for WHICH chapters GLF reads and in WHAT order —
// exercises-basic.typ and solutions-basic.typ both extract their
// chapter lists from here via read-chapter-files(from:), which parses
// this file as PLAIN TEXT. Hence three hard rules for the
// register_chapters block (STYLE_GUIDE.md §3):
//   * one entry per line,
//   * full literal root-absolute paths (no #let shortcuts),
//   * keep each line within the 80-column formatter width, so the
//     auto-formatter never wraps an entry across lines (a wrapped
//     entry silently disappears from both text parsers).
// The title strings are registry labels only and are kept short for
// exactly that reason — the page header takes its chapter title from
// each chapter's own chapter-template call, not from here.
//
// SCHEDULING: both tracks meet this unit in year 2, after
// Descriptive Statistics (Lehrplan GLF 1.3 / SPF 3.1–3.2).
//
// LEVEL SPLIT: unlike the descriptive-statistics unit, this one has a
// genuine chapter-level exclusion. GLF's Lehrplan asks only for
// "einfache Abzählprobleme mit kombinatorischen Hilfsmitteln wie
// Fakultäten (BfKM) und Binomialkoeffizienten" — which is exactly
// ch-counting. SPF additionally owns "entscheiden, welche
// Abzählstrategie zielführend ist" and selection with repetition,
// which live in ch-counting-advanced and are deliberately absent
// below. Everything else is shared, gated inside chapters.

#import "../../common/preamble.typ": *
#set-subject-name("Probabilities & Combinatorics")
#set-level("basic")

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
  // ch-counting-advanced is SPF-only and is registered in
  // main-high.typ alone. Do not add it here.
  //
  // ("Combined", "/src/units/probabilities-combinatorics/ch-prob-counting"),
  // ("Paradoxes", "/src/units/probabilities-combinatorics/ch-paradoxes"),
)

#include_chapters()
