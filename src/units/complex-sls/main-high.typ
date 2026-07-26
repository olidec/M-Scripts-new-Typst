// main-high.typ — Complex Numbers (SPF), lecture notes.
//
// SPF-ONLY UNIT: there is deliberately no main-basic.typ. Complex
// numbers appear in the SPF Lehrplan only (3. Klasse, "1.1 Komplexe
// Zahlen"); GLF never reads this unit. That exclusion is expressed by
// this file having no Foundations counterpart at all — the
// chapter-level mechanism from STYLE_GUIDE.md §3 — which is why no
// chapter in this unit needs an only-high[...] wrapper anywhere.
//
// Source of truth for the chapter list and order: exercises-high.typ
// and solutions-high.typ extract it from here via
// read-chapter-files(from:), which parses this file as PLAIN TEXT.
// One entry per line, full literal root-absolute paths, every line
// inside the 80-column formatter width.
//
// Entries written as (none, "...") are UNNUMBERED INTERLUDES: they are
// included here but skipped by read-chapter-files() (which only
// matches lines starting with `("`), so they stay out of the exercise
// sheet and the solutions booklet automatically.

#import "../../common/preamble.typ": *
#set-subject-name("Complex Numbers")
#set-level("high")

#register_chapters(
  (none, "/src/units/complex-sls/sls-intro"),
  ("Introduction", "/src/units/complex-sls/ch-intro"),
  // Uncomment as chapters are finished:
  ("Arithmetic", "/src/units/complex-sls/ch-arithmetic"),
  ("Equations", "/src/units/complex-sls/ch-equations"),
  ("Gaussian Plane", "/src/units/complex-sls/ch-gaussian-plane"),
  ("Polar Form", "/src/units/complex-sls/ch-polar-form"),
  (none, "/src/units/complex-sls/sls-midpoint"),
  ("Transformations", "/src/units/complex-sls/ch-transformations"),
  ("Loci", "/src/units/complex-sls/ch-loci"),
  ("Review", "/src/units/complex-sls/ch-review"),
)

#include_chapters()
