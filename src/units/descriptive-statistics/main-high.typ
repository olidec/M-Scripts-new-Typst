// main-high.typ — Descriptive Statistics, Advanced (SPF)
// lecture notes.
//
// This file is the source of truth for WHICH chapters SPF reads and in
// WHAT order — exercises-high.typ and solutions-high.typ both extract
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
// main-basic.typ. Level differentiation in this unit happens INSIDE the
// chapters via only-high / only-basic, not by excluding chapters.

#import "../../common/preamble.typ": *
#set-subject-name("Descriptive Statistics")
#set-level("high")

#register_chapters(
  ("Data & Trust", "/src/units/descriptive-statistics/ch-data-and-trust"),
  ("Displaying", "/src/units/descriptive-statistics/ch-displaying-data"),
  ("Center", "/src/units/descriptive-statistics/ch-center"),
  ("Spread", "/src/units/descriptive-statistics/ch-spread"),
  ("Association", "/src/units/descriptive-statistics/ch-association"),
  //
  // ch-two-variables is SPF-only (Lehrplan SPF 4.1: Streudiagramme
  // lesen, Regressionsgeraden und Korrelation verstehen). It builds
  // directly on ch-association above -- that chapter fits a line by
  // eye and leaves "best" undefined; this one defines it. It must
  // therefore stay AFTER ch-association in this list.
  ("Two Variables", "/src/units/descriptive-statistics/ch-two-variables"),
  //
  // ch-project is OPTIONAL and scalable -- its tier 1 briefs run in a
  // single lesson, tier 3 over weeks. Nothing else in the unit
  // depends on it, so deleting this one line in a tight year costs
  // nothing; leaving it in means students can run a project
  // independently whether or not it is taught.
  ("Project", "/src/units/descriptive-statistics/ch-project"),
)

#include_chapters()
