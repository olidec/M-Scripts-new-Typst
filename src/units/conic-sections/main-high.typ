// main-high.typ — Conic Sections, Advanced (SPF) lecture notes.
//
// SPF-ONLY UNIT. There is deliberately no main-basic.typ,
// exercises-basic.typ or solutions-basic.typ: the GLF Lehrplan
// contains no Kegelschnitte at all, so the exclusion is expressed
// at the FILE level exactly as in complex-numbers/complex-sls,
// and no chapter in this unit needs an only-high[...] wrapper or
// a level: "high" argument. If you ever find yourself typing one
// here, stop — it means something has been misfiled.
//
// SCHEDULING: SPF year 4 (Lehrplan SPF 4. Klasse, 2.1
// "Kegelschnitte"). Two things in the year-4 syllabus sit BEFORE
// this unit and are used by it:
//   * Integral calculus (1.1/1.2, incl. Rotationskörper) — the
//     area of the ellipse and the volume-of-revolution problems
//     in ch-review depend on it.
//   * Circles and tangent problems by vector methods (year 3,
//     2.3) — ch-tangents continues that work rather than
//     starting a new genre.
//
// Source of truth for the chapter list and order; exercises-high
// and solutions-high extract their lists from here via
// read-chapter-files(from:), which parses this file as PLAIN
// TEXT. Three rules: one entry per line, full literal
// root-absolute paths, every line inside the 80-column formatter
// width (a formatter-wrapped entry silently disappears from both
// text parsers).

#import "../../common/preamble.typ": *
#set-subject-name("Conic Sections")
#set-level("high")

#register_chapters(
  ("Cone", "/src/units/conic-sections/ch-slicing"),
  ("Parabola", "/src/units/conic-sections/ch-parabola"),
  ("Ellipse", "/src/units/conic-sections/ch-ellipse"),
  ("Hyperbola", "/src/units/conic-sections/ch-hyperbola"),
  ("Eccentricity", "/src/units/conic-sections/ch-unified"),
  ("Classifying", "/src/units/conic-sections/ch-classifying"),
  ("Tangents", "/src/units/conic-sections/ch-tangents"),
  ("Parametric", "/src/units/conic-sections/ch-parametric"),
  ("Review", "/src/units/conic-sections/ch-review"),
)

#include_chapters()
