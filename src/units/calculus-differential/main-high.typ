// main-high.typ — Calculus: Differentiation, Advanced (SPF) lecture
// notes.
//
// Source of truth for the SPF chapter list and order —
// exercises-high.typ and solutions-high.typ extract their chapter
// lists from here via read-chapter-files(from:), which parses this
// file as PLAIN TEXT. Same three rules as in main-basic.typ: one
// entry per line, full literal root-absolute paths, every line
// within the 80-column formatter width (a formatter-wrapped entry
// silently disappears from both text parsers).
//
// SCHEDULING — and this unit has a wrinkle GLF does not. The SPF
// Lehrplan places limits a full year before derivatives: Grenzwerte
// is SPF Y2 1.3, while Ableitung is SPF Y3 2.1. Chapters 2 and 3
// (ch-limits, ch-asymptotes) therefore sit naturally at the END of
// year 2, alongside the sequences-and-series unit whose convergence
// work motivates them, with chapters 4 onwards taught in year 3 and
// the applications (chapters 9 and 10) running into year 4
// (SPF Y4 1.2). The unit is written to work either way — taught as
// one block in year 3 nothing is lost, since chapters 2 and 3 are
// self-contained — but if you do split it, note that ch-limits opens
// by explicitly recalling the geometric series, and that reference
// lands better when the series unit is recent.
//
// LEVEL SPLIT: no chapter-level exclusion — SPF and GLF read all
// eleven chapters in the same order, with every difference gated
// inside the chapters. See the fuller list in main-basic.typ; the
// SPF-only material is ch-limits §5 (limit laws, indeterminate
// forms) and the intermediate value theorem, the asymptotic-curve
// section of ch-asymptotes, the three derivations (power rule via
// the binomial theorem, product and quotient rules, (sin x)' from
// the addition theorem), the non-polynomial curve analysis in
// ch-curve-analysis §6, the inverse-function section closing
// ch-functions-review, and ch-optimization §5.
//
// ONE DEPENDENCY TO CHECK BEFORE TEACHING: the only-high derivation
// of (sin x)' in ch-special-derivatives §4 uses the addition theorem
// sin(x + h) = sin(x)cos(h) + cos(x)sin(h). The trigonometry unit
// deliberately omits the double-angle identities, so do not assume
// the addition theorem came along with them. If it did not, drop
// that block — the graphical argument preceding it is self-contained.

#import "../../common/preamble.typ": *
#set-subject-name("Calculus: Differentiation")
#set-level("high")

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
  //
  //
)

#include_chapters()
