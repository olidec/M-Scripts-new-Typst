// ============================================================
//  main-basic.typ — Trigonometry lecture notes, FOUNDATIONS level
//  Compile via:  ./build.sh unit trigonometry full
//
//  GLF and SPF both read this unit in year 1 with the same chapter
//  list (Lehrplan 3.1 Trigonometrie is identical for both levels) —
//  the SPF extras live INSIDE shared chapters as only-high[...] /
//  level: "high" content, not as separate chapters.
// ============================================================

#import "../../common/preamble.typ": *
#set-subject-name("Trigonometry")
#set-level("basic")

// ── Cover page ───────────────────────────────────────────────
#align(center + horizon)[
  #text(size: 26pt, weight: "bold")[Trigonometry]
  #v(0.5em)
  #text(size: 14pt, fill: accent)[Foundations]
  #v(0.3em)
  #text(size: 12pt, fill: luma(80))[Lecture Notes]
]

#pagebreak()

// Chapter registry — full literal root-absolute paths, one entry per
// line (this file is read back as plain text by read-chapter-files()
// from exercises-basic.typ / solutions-basic.typ; see STYLE_GUIDE §3).
// Pending chapters stay commented until they are converted.
#register_chapters(
  ("Geometric Foundations", "/src/units/trigonometry/ch-geometry-review"),
  ("Trigonometry in Right Triangles", "/src/units/trigonometry/ch-right-triangles"),
  ("The Unit Circle and Radians", "/src/units/trigonometry/ch-unit-circle"),
  ("Trigonometry in General Triangles", "/src/units/trigonometry/ch-general-triangles"),
  ("The Trigonometric Functions", "/src/units/trigonometry/ch-trig-functions"),
)
#include_chapters()
