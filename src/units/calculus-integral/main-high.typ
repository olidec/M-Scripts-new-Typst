// main-high.typ — Calculus: Integration, Advanced (SPF) lecture
// notes.
//
// Source of truth for the SPF chapter list and order —
// exercises-high.typ and solutions-high.typ extract their chapter
// lists from here via read-chapter-files(from:), which parses this
// file as PLAIN TEXT. Same three rules as in main-basic.typ: one
// entry per line, full literal root-absolute paths, every line within
// the 80-column formatter width (a formatter-wrapped entry silently
// disappears from both text parsers).
//
// SCHEDULING: SPF meets this unit in year 4 (SPF Y4 1.1
// Integralrechnung and Y4 1.2 Anwendungen). It assumes
// calculus-differential, whose limits chapters may have been taught
// as early as year 2 — see the scheduling note in that unit's
// main-high.typ.
//
// ONE CHAPTER MORE THAN GLF: ch-improper is registered here and NOT
// in main-basic.typ. SPF Y4 1.2 names uneigentliche Integrale
// explicitly; the GLF Lehrplan does not mention them. Note that
// ch-improper contains no only-high wrappers at all — it is gated at
// the chapter boundary, so everything in it is high-level by
// construction.
//
// The SPF-only material inside shared chapters is listed in
// main-basic.typ. The substantial one is ch-integration-rules §3-5:
// SPF gets the substitution rule stated formally with the
// differential, definite integrals by changing the limits, and
// integration by parts, where GLF gets recognition and
// guess-and-adjust only.
//
// ROTATION ABOUT THE Y-AXIS (ch-solids §6) is only-high and is the
// natural place to mention that the disc argument never privileged a
// particular axis — worth ten minutes with SPF, since it is the same
// four-step argument for the third time.

#import "../../common/preamble.typ": *
#set-subject-name("Calculus: Integration")
#set-level("high")

#register_chapters(
  ("Antiderivative", "/src/units/calculus-integral/ch-antiderivative"),
  ("Riemann Sums", "/src/units/calculus-integral/ch-riemann"),
  ("Fundamental Theorem", "/src/units/calculus-integral/ch-ftc"),
  ("Areas", "/src/units/calculus-integral/ch-areas"),
  ("Techniques", "/src/units/calculus-integral/ch-integration-rules"),
  ("Solids", "/src/units/calculus-integral/ch-solids"),
  ("Improper Integrals", "/src/units/calculus-integral/ch-improper"),
  ("Review", "/src/units/calculus-integral/ch-review-integral"),
)

#include_chapters()
