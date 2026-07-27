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
  // Uncomment as chapters are finished (commented lines are safely
  // invisible to both text parsers — they don't start with `("` ):
  //
  // ("Displaying", "/src/units/descriptive-statistics/ch-displaying-data"),
  // ("Center", "/src/units/descriptive-statistics/ch-center"),
  // ("Spread", "/src/units/descriptive-statistics/ch-spread"),
  //
  // ch-two-variables is registered for BOTH levels. The Lehrplan
  // makes scatterplots/regression/correlation an SPF-only BfKM item,
  // so the machinery (r, the regression line) sits behind only-high —
  // but "correlation does not imply causation" is reasoning both
  // levels need, and it is gated inside the chapter, not here.
  // ("Two Variables", "/src/units/descriptive-statistics/ch-two-variables"),
)

#include_chapters()
