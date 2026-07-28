// main-basic.typ — Descriptive Statistics, Foundations (GLF)
// lecture notes.
//
// This file is the source of truth for WHICH chapters GLF reads and in
// WHAT order — exercises-basic.typ and solutions-basic.typ both extract
// their chapter lists from here via read-chapter-files(from:), which
// parses this file as PLAIN TEXT. Hence three hard rules for the
// register_chapters block (STYLE_GUIDE.md §3):
//   * one entry per line,
//   * full literal root-absolute paths (no #let shortcuts),
//   * keep each line within the 80-column formatter width, so the
//     auto-formatter never wraps an entry across lines (a wrapped
//     entry silently disappears from both text parsers).
// The title strings are registry labels only — the page header takes
// its chapter title from each chapter's own chapter-template call.
//
// SCHEDULING NOTE: GLF meets this unit in year 2, SPF in year 1
// (Lehrplan GLF 1.2 / SPF 4.1). That is a timetable difference, not a
// content one — the chapter list below is deliberately IDENTICAL to
// main-high.typ. Level differentiation in this unit happens INSIDE the
// chapters via only-high / only-basic, not by excluding chapters.

#import "../../common/preamble.typ": *
#set-subject-name("Descriptive Statistics")
#set-level("basic")

#register_chapters(
  ("Data & Trust", "/src/units/descriptive-statistics/ch-data-and-trust"),
  ("Displaying", "/src/units/descriptive-statistics/ch-displaying-data"),
  ("Center", "/src/units/descriptive-statistics/ch-center"),
  ("Spread", "/src/units/descriptive-statistics/ch-spread"),
  ("Association", "/src/units/descriptive-statistics/ch-association"),
  //
  // ch-project is OPTIONAL and scalable -- its tier 1 briefs run in a
  // single lesson, tier 3 over weeks. Nothing else in the unit
  // depends on it, so deleting this one line in a tight year costs
  // nothing; leaving it in means students can run a project
  // independently whether or not it is taught.
  ("Project", "/src/units/descriptive-statistics/ch-project"),
  //
  // ch-two-variables is SPF-ONLY and is therefore absent here, not
  // merely commented: the Lehrplan makes scatterplots, regression and
  // correlation an SPF BfKM item (SPF 4.1), and GLF has no
  // corresponding entry. The REASONING about association -- what a
  // correlation does and does not license -- is in ch-association
  // above, which both levels read. Splitting the material this way
  // means the level gate is a chapter boundary rather than forty
  // only-high paragraphs, which is far harder to get wrong.
)

#include_chapters()
