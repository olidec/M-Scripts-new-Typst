// main-high.typ — Distributions, Advanced (SPF) lecture notes.
//
// Source of truth for the SPF chapter list and order —
// exercises-high.typ and solutions-high.typ extract their chapter
// lists from here via read-chapter-files(from:), which parses this
// file as PLAIN TEXT. Same three rules as main-basic.typ: one entry
// per line, full literal root-absolute paths, every line within the
// 80-column formatter width.
//
// SCHEDULING: SPF meets this unit in year 3 (Lehrplan 3.1
// Wahrscheinlichkeitsverteilungen), a full year before GLF does.
// The confidence-interval material belongs to SPF's year 4 (3.1
// Induktive Statistik) and is previewed here; the assessable
// treatment of hypothesis testing lives in the inferential-statistics
// unit.
//
// LEVEL SPLIT: four chapters below are SPF-only and absent from
// main-basic.typ — ch-normal (the normal distribution properly, which
// GLF's Lehrplan does not ask for), ch-confidence (calculations),
// ch-more-distributions (the discrete/continuous zoo) and ch-modern.
//
// ch-modern is off-curriculum by design: an outlook on how modern
// statistics has largely abandoned named distributions in favour of
// linear models with parameters. It is last so it can be dropped
// without consequence, and nothing else refers forward to it.

#import "../../common/preamble.typ": *
#set-subject-name("Distributions")
#set-level("high")

#register_chapters(
  ("Random variables", "/src/units/distributions/ch-random-variables"),
  // Uncomment as chapters are finished (commented lines are safely
  // invisible to both text parsers — they don't start with `("` ):
  //
  ("Binomial", "/src/units/distributions/ch-binomial"),
  // ("Binomial test", "/src/units/distributions/ch-binomial-test"),
  // ("Models", "/src/units/distributions/ch-models"),
  // ("Normal curve", "/src/units/distributions/ch-normal-intro"),
  //
  // ---- SPF-only from here; see the header note ----
  // ("Normal", "/src/units/distributions/ch-normal"),
  // ("Confidence", "/src/units/distributions/ch-confidence-intro"),
  // ("Intervals", "/src/units/distributions/ch-confidence"),
  // ("More", "/src/units/distributions/ch-more-distributions"),
  //
  // ---- off-curriculum, safely skippable ----
  // ("Modern", "/src/units/distributions/ch-modern"),
)

#include_chapters()
