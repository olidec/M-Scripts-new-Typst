// main-basic.typ — Algebra & Functions, Foundations (GLF) lecture notes.
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
// its chapter title from each chapter's own chapter-template call —
// so keep them short enough to satisfy the line-length rule.

#import "../../common/preamble.typ": *
#set-subject-name("Algebra & Functions")
#set-level("basic")

#register_chapters(
  ("Foundations", "/src/units/algebra-functions/ch-algebra-foundations"),
  ("Functions", "/src/units/algebra-functions/ch-functions-intro"),
  ("Linear", "/src/units/algebra-functions/ch-linear"),
  ("Systems", "/src/units/algebra-functions/ch-systems"),
  // Uncomment as chapters are finished (commented lines are safely
  // invisible to both text parsers — they don't start with `("` ):
  ("Quadratics", "/src/units/algebra-functions/ch-quadratic"),
  //
  // ch-powers, ch-exponential, ch-logarithms are deliberately ABSENT
  // here — SPF-only in year 1 (see main-high.typ); GLF meets them in
  // year 2. This absence IS the chapter-level exclusion mechanism.
)

#include_chapters()
