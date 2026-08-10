// main-basic.typ — Vectors, Part B, Foundations (GLF) lecture notes.
//
// Source of truth for WHICH chapters GLF reads and in WHAT order —
// exercises-basic.typ and solutions-basic.typ both extract their
// chapter lists from here via read-chapter-files(from:), which parses
// this file as PLAIN TEXT. Hence three hard rules for the
// register_chapters block (STYLE_GUIDE.md §3):
//   * one entry per line,
//   * full literal root-absolute paths (no #let shortcuts),
//   * keep each line within the 80-column formatter width.
//
// SCHEDULING: GLF meets this unit in year 3 (Lehrplan GLF 1.1 —
// planes, and intersection/distance/angle problems), a year after
// Part A. SPF meets both parts in year 2 (SPF 2.1-2.3).
//
// LEVEL SPLIT: unlike Part A, this unit has a genuine chapter-level
// exclusion. ch-circles-spheres is absent from the GLF Lehrplan
// entirely and is registered in main-high.typ alone — do not add it
// below. The cross product is also absent from the GLF Lehrplan, but
// GLF needs normal vectors for planes in this very unit, so it is
// taught to both levels as a tool, with the derivation, the area
// interpretation and the triple product gated inside only-high.

#import "../../common/preamble.typ": *
#set-subject-name("Vectors in Space")
#set-level("basic")

#register_chapters(
  ("Cross Product", "/src/units/vectors-space/ch-cross-product"),
  ("Planes", "/src/units/vectors-space/ch-planes"),
  ("Intersections", "/src/units/vectors-space/ch-intersections"),
  ("Angles", "/src/units/vectors-space/ch-angles"),
  ("Distances", "/src/units/vectors-space/ch-distances"),
  ("Geometry", "/src/units/vectors-space/ch-vector-geometry"),
  ("Graphics", "/src/units/vectors-space/ch-graphics"),
  ("Review", "/src/units/vectors-space/ch-review"),
  // Uncomment as chapters are finished (commented lines are safely
  // invisible to both text parsers — they don't start with `("` ):
  //
  //
  // ch-circles-spheres is SPF-only and is registered in main-high.typ
  // alone. Do not add it here.
  //
)

#include_chapters()
