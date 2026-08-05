// main-high.typ — Vectors, Part B, Advanced (SPF) lecture notes.
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
// LEVEL SPLIT: this file carries one chapter GLF does not read at
// all — ch-circles-spheres, which is absent from the GLF Lehrplan and
// registered here alone. SPF Lehrplan 2.3 names it explicitly,
// including Tangentenprobleme.

#import "../../common/preamble.typ": *
#set-subject-name("Vectors in Space")
#set-level("high")

#register_chapters(
  ("Cross Product", "/src/units/vectors-space/ch-cross-product"),
  ("Planes", "/src/units/vectors-space/ch-planes"),
  ("Intersections", "/src/units/vectors-space/ch-intersections"),
  ("Angles", "/src/units/vectors-space/ch-angles"),
  ("Distances", "/src/units/vectors-space/ch-distances"),
  ("Circles", "/src/units/vectors-space/ch-circles-spheres"),
  ("Geometry", "/src/units/vectors-space/ch-vector-geometry"),
  ("Graphics", "/src/units/vectors-space/ch-graphics"),
  // Uncomment as chapters are finished (commented lines are safely
  // invisible to both text parsers — they don't start with `("` ):
  //
  // ("Review", "/src/units/vectors-space/ch-review"),
  //
  // ch-circles-spheres above is SPF-only: it appears in this file and
  // NOT in main-basic.typ. Everything else matches Part A's pattern of
  // shared chapters with only-high gating inside them.
  //
)

#include_chapters()
