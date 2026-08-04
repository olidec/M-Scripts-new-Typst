// main-basic.typ — Calculus: Differentiation, Foundations (GLF)
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
// SCHEDULING: GLF meets this unit in year 3 (Lehrplan GLF Y3 2.2,
// Differentialrechnung), with the applications in chapters 9 and 10
// running into year 4 (GLF Y4 1.2, Anwendungen der
// Differentialrechnung). The companion unit calculus-integral follows
// in year 4 (GLF Y4 1.1).
//
// LEVEL SPLIT: unlike probabilities-combinatorics, this unit has NO
// chapter-level exclusion — GLF and SPF read all eleven chapters in
// the same order. Every difference is gated inside the chapters via
// only-high[...] and level: "high", and the substantial ones are:
//   ch-limits          §5, limit laws and indeterminate forms
//                      (SPF Y2 1.3 "Regeln für die Berechnung von
//                      Grenzwerten"); also the intermediate value
//                      theorem in §4
//   ch-asymptotes      asymptotic curves and non-rational asymptotes
//   ch-derivative-definition   the binomial-theorem proof of the
//                      power rule
//   ch-derivative-rules        the derivations of the product and
//                      quotient rules
//   ch-special-derivatives     the derivation of (sin x)' from the
//                      addition theorem
//   ch-curve-analysis          exponential and trigonometric curves
//                      needing numerical stationary points
//                      (SPF Y4 1.2, Krümmungssinn)
//   ch-optimization    §5, the two harder modelling problems
// Two smaller ones worth knowing about: ch-functions-review closes
// with an SPF-only treatment of inverse functions, and
// ch-inverse-problems §2.1 splits on CALCULATOR CAPABILITY — the
// TI-30X Pro MathPrint solves systems in at most three unknowns, so
// the GLF text teaches the hand reductions that get a five-unknown
// quartic down to a 3x3, while the SPF text (TI-Nspire CAS) does not
// need them.

#import "../../common/preamble.typ": *
#set-subject-name("Calculus: Differentiation")
#set-level("basic")

#register_chapters(
  ("Functions", "/src/units/calculus-differential/ch-functions-review"),
  ("Limits", "/src/units/calculus-differential/ch-limits"),
  ("Asymptotes", "/src/units/calculus-differential/ch-asymptotes"),
  ("Rates", "/src/units/calculus-differential/ch-rate-of-change"),
  ("Derivative", "/src/units/calculus-differential/ch-derivative-definition"),
  ("Rules", "/src/units/calculus-differential/ch-derivative-rules"),
  ("Elementary", "/src/units/calculus-differential/ch-special-derivatives"),
  ("Curves", "/src/units/calculus-differential/ch-curve-analysis"),
  ("Finding Functions", "/src/units/calculus-differential/ch-inverse-problems"),
  ("Optimization", "/src/units/calculus-differential/ch-optimization"),
  ("Review", "/src/units/calculus-differential/ch-review"),
  // Uncomment as chapters are finished (commented lines are safely
  // invisible to both text parsers — they don't start with `("` ):
  //
  // No SPF-only chapter in this unit. If one is ever added, register
  // it in main-high.typ alone and note it here, as
  // probabilities-combinatorics does for ch-counting-advanced.
  //
)

#include_chapters()
