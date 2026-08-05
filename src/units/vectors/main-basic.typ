// main-basic.typ — Vectors, Part A, Foundations (GLF) lecture notes.
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
// LEVEL SPLIT: Part A has NO chapter-level exclusions — main-high.typ
// registers exactly the same eight chapters in the same order. All
// level gating in Part A happens inside chapters via only-high, which
// is why this file and main-high.typ differ only in their set-level
// call. The genuine chapter-level exclusion in this material is
// ch-circles-spheres, which lives in Part B and is SPF-only.

#import "../../common/preamble.typ": *
#set-subject-name("Vectors")
#set-level("basic")

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
