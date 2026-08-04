// main-basic.typ — Calculus: Integration, Foundations (GLF) lecture
// notes.
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
//
// SCHEDULING: GLF meets this unit in year 4 (Lehrplan GLF Y4 1.1,
// Integralrechnung). It assumes the companion unit
// calculus-differential, taught in year 3.
//
// CHAPTER-LEVEL EXCLUSION: ch-improper is SPF-only and is registered
// in main-high.typ ALONE — uneigentliche Integrale appear in SPF Y4
// 1.2 and nowhere in the GLF Lehrplan. It is the only chapter-level
// difference in this unit; everything else is gated inside the
// chapters via only-high[...] and level: "high":
//   ch-integration-rules  §3-5 — the substitution rule stated
//                         formally (u, dif u), definite integrals by
//                         changing the limits, and integration by
//                         parts. GLF gets reversing the chain rule as
//                         a recognitional technique only (§1-2):
//                         guess, differentiate, adjust. See the
//                         teacher's note in that file for the
//                         reasoning.
//   ch-riemann            the induction proof of the sum-of-squares
//                         formula (SPF Y2 1.2); GLF is given the
//                         formula
//   ch-ftc                §5, the average value of a function
//   ch-solids             §6, rotation about the y-axis
//   ch-areas              the three-boundary tangent problem
//
// ONE CHAPTER IS OPTIONAL FOR GLF. ch-solids is included by your
// decision, but only SPF Y4 1.2 requires it and nothing downstream
// depends on it — it is the one chapter that can be cut for time
// without breaking anything later.

#import "../../common/preamble.typ": *
#set-subject-name("Calculus: Integration")
#set-level("basic")

#register_chapters(
  ("Antiderivative", "/src/units/calculus-integral/ch-antiderivative"),
  ("Riemann Sums", "/src/units/calculus-integral/ch-riemann"),
  ("Fundamental Theorem", "/src/units/calculus-integral/ch-ftc"),
  ("Areas", "/src/units/calculus-integral/ch-areas"),
  ("Techniques", "/src/units/calculus-integral/ch-integration-rules"),
  ("Solids", "/src/units/calculus-integral/ch-solids"),
  ("Review", "/src/units/calculus-integral/ch-review-integral"),
  // SPF-only, registered in main-high.typ alone (commented lines are
  // safely invisible to both text parsers — they don't start with `("`):
  //
  // ("Improper Integrals", "/src/units/calculus-integral/ch-improper"),
  //
)

#include_chapters()
