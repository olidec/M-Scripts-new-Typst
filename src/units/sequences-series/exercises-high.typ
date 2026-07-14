// ============================================================
//  exercises-high.typ — Exercise sheet, ADVANCED level
//  One exercise per page, landscape A4, no theory, no solutions.
//
//  Chapter order is read from main-high.typ, so this sheet's
//  numbering stays in lockstep with solutions-high.typ. This is
//  the direct counterpart to exercises-basic.typ — see the
//  comment there for why the sheet is split per level rather than
//  the old single superset exercises.typ.
//  Compile with:  typst compile exercises-high.typ
// ============================================================

#import "../../common/preamble.typ": *
#set-subject-name("Sequences & Series")

// Activate exercise-sheet mode, Advanced level (hides theory &
// solutions, landscape, and — as of this preamble — filters out any
// exercise marked level: "basic")
#show: exercise-sheet-template.with(level: "high")

// ── Cover page ───────────────────────────────────────────────
#align(center + horizon)[
  #text(size: 26pt, weight: "bold")[Sequences & Series]
  #v(0.5em)
  #text(size: 14pt, fill: accent)[Exercise Sheets — Advanced]
  #v(0.3em)
  #text(size: 12pt, fill: luma(80))[Lecture Notes]
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

// Include chapters in the order defined in main-high.typ — the
// SAME source main-high.typ that solutions-high.typ reads from,
// so chapter selection and exercise numbering stay in lockstep.
#for fname in read-chapter-files(
  from: "/src/units/sequences-series/main-high.typ",
) {
  include fname + ".typ"
}
