// ============================================================
//  main-high.typ — Trigonometry lecture notes, ADVANCED level
//  Compile via:  ./build.sh unit trigonometry full
//
//  Same chapter list as main-basic.typ (both levels read this unit
//  in year 1); the SPF-only depth — trig equations, modeling
//  oscillations — lives inside the shared chapters as
//  only-high[...] theory and level: "high" exercises.
// ============================================================

#import "../../common/preamble.typ": *
#set-subject-name("Trigonometry")
#set-level("high")

// ── Cover page ───────────────────────────────────────────────
#align(center + horizon)[
  #text(size: 26pt, weight: "bold")[Trigonometry]
  #v(0.5em)
  #text(size: 14pt, fill: accent)[Advanced]
  #v(0.3em)
  #text(size: 12pt, fill: luma(80))[Lecture Notes]
]

#pagebreak()

// Chapter registry — full literal root-absolute paths, one entry per
// line (this file is read back as plain text by read-chapter-files()
// from exercises-high.typ / solutions-high.typ; see STYLE_GUIDE §3).
// Pending chapters stay commented until they are converted.
#register_chapters(
  ("Geometric Foundations", "/src/units/trigonometry/ch-geometry-review"),
  ("Trigonometry in Right Triangles", "/src/units/trigonometry/ch-right-triangles"),
  ("The Unit Circle and Radians", "/src/units/trigonometry/ch-unit-circle"),
  ("Trigonometry in General Triangles", "/src/units/trigonometry/ch-general-triangles"),
  ("The Trigonometric Functions", "/src/units/trigonometry/ch-trig-functions"),
)
#include_chapters()
