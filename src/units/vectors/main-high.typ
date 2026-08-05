// main-high.typ — Vectors, Part A, Advanced (SPF) lecture notes.
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
// WHY THIS UNIT IS SPLIT IN TWO. The vector material spans a full
// year for SPF but TWO school years for GLF: Lehrplan GLF 3.1 (2.
// Klasse) covers vectors, the dot product and lines, while planes and
// the intersection/distance/angle problems only arrive in GLF 1.1 (3.
// Klasse). Since build.sh gives each unit directory exactly one set of
// six documents, the material is two units:
//
//     vectors/         Part A — vectors, dot product, lines   (this)
//     vectors-space/   Part B — cross product, planes, distances
//
// GLF reads Part A in year 2 and Part B in year 3. SPF reads both in
// year 2 and therefore receives two booklets rather than one, which is
// no bad thing at fourteen chapters.
//
// LEVEL SPLIT: Part A has NO chapter-level exclusions — this file
// registers exactly the same eight chapters as main-basic.typ, in the
// same order, and the two differ only in their set-level call. All
// level gating in Part A happens inside chapters via only-high. The
// genuine chapter-level exclusion in this material is
// ch-circles-spheres, which lives in Part B and is SPF-only.
//
// SPF-only material in Part A, all of it inside only-high blocks:
// rotations as a non-example of vectors (ch-vectors-intro), linear
// independence (ch-vector-arithmetic), direction cosines
// (ch-unit-vectors), vector projection (ch-dot-product), the
// perpendicular bisector plane (ch-lines), constructing lines at a
// given angle (ch-lines-relative), error analysis (ch-review).

#import "../../common/preamble.typ": *
#set-subject-name("Vectors")
#set-level("high")

#register_chapters(
  ("Space", "/src/units/vectors/ch-spatial-reasoning"),
  ("Vectors", "/src/units/vectors/ch-vectors-intro"),
  ("Arithmetic", "/src/units/vectors/ch-vector-arithmetic"),
  ("Directions", "/src/units/vectors/ch-unit-vectors"),
  ("Dot Product", "/src/units/vectors/ch-dot-product"),
  ("Lines", "/src/units/vectors/ch-lines"),
  ("Two Lines", "/src/units/vectors/ch-lines-relative"),
  ("Review", "/src/units/vectors/ch-review"),
)

#include_chapters()
