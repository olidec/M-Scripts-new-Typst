// ============================================================
//  exercises-basic.typ — Exercise sheets, FOUNDATIONS level
//  Landscape A4, one exercise per page, no solutions, no theory.
//  Chapter order is read from main-basic.typ automatically, so the
//  exercise numbering always matches the Foundations lecture notes
//  and the Foundations solutions booklet.
//  Compile via:  ./build.sh unit trigonometry exercises
// ============================================================

#import "../../common/preamble.typ": *
#set-subject-name("Trigonometry")
#show: exercise-sheet-template.with(level: "basic")

// ── Cover page ───────────────────────────────────────────────
#align(center + horizon)[
  #text(size: 26pt, weight: "bold")[Trigonometry]
  #v(0.5em)
  #text(size: 14pt, fill: accent)[Exercise Sheets — Foundations]
  #v(2cm)
  #grid(
    columns: (auto, 4cm),
    gutter: 0.8em,
    align(right + horizon)[#text(size: 11pt)[Name:]],
    line(length: 4cm, stroke: 0.5pt + luma(120)),
    align(right + horizon)[#text(size: 11pt)[Class:]],
    line(length: 4cm, stroke: 0.5pt + luma(120)),
  )
]

// Include chapters in the order defined in main-basic.typ
#for fname in read-chapter-files(from: "/src/units/trigonometry/main-basic.typ") {
  include fname + ".typ"
}
