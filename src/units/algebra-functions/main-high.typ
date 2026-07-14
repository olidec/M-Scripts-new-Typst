// main-high.typ — Algebra & Functions, Advanced (SPF) lecture notes.
//
// Source of truth for the SPF chapter list and order —
// exercises-high.typ and solutions-high.typ extract their chapter
// lists from here via read-chapter-files(from:), which parses this
// file as PLAIN TEXT. Same three rules as in main-basic.typ: one
// entry per line, full literal root-absolute paths, every line
// within the 80-column formatter width (a formatter-wrapped entry
// silently disappears from both text parsers).

#import "../../common/preamble.typ": *
#set-subject-name("Algebra & Functions")
#set-level("high")

#register_chapters(
  ("Foundations", "/src/units/algebra-functions/ch-algebra-foundations"),
  ("Functions", "/src/units/algebra-functions/ch-functions-intro"),
  ("Linear", "/src/units/algebra-functions/ch-linear"),
  ("Systems", "/src/units/algebra-functions/ch-systems"),
  // Uncomment as chapters are finished:
  ("Quadratics", "/src/units/algebra-functions/ch-quadratic"),
  //
  // SPF-only in year 1 — registered here, deliberately absent from
  // main-basic.typ (chapter-level exclusion; GLF reads these in
  // year 2). ch-powers opens with the exponent-law prelude:
  ("Powers", "/src/units/algebra-functions/ch-powers"),
  ("Exponentials", "/src/units/algebra-functions/ch-exponential"),
  ("Logarithms", "/src/units/algebra-functions/ch-logarithms"),
  ("Toolkit", "/src/units/algebra-functions/ch-equation-toolkit"),
  ("Modeling", "/src/units/algebra-functions/ch-modeling"),
)

#include_chapters()
