// ============================================================
//  exercises-basic.typ — Exercise sheet, FOUNDATIONS level
//  One exercise per page, landscape A4, no theory, no solutions.
//
//  Chapter order is read from main-basic.typ, so this sheet
//  contains ONLY the chapters GLF actually reads this year — it
//  will never carry pages for an SPF-only chapter (ch-higher-order,
//  ch-proofs) the way the old single exercises.typ did by building
//  from main-high.typ (the superset) for everyone. This is also
//  what keeps this sheet's exercise numbering identical to
//  solutions-basic.typ's.
//  Compile with:  typst compile exercises-basic.typ
// ============================================================

#import "../../common/preamble.typ": *
#set-subject-name("Sequences & Series")

// Activate exercise-sheet mode, Foundations level (hides theory &
// solutions, landscape, and — as of this preamble — filters out any
// exercise marked level: "high")
#show: exercise-sheet-template.with(level: "basic")

// ── Cover page ───────────────────────────────────────────────
#align(center + horizon)[
  #text(size: 26pt, weight: "bold")[Sequences & Series]
  #v(0.5em)
  #text(size: 14pt, fill: accent)[Exercise Sheets — Foundations]
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

// Include chapters in the order defined in main-basic.typ — the
// SAME source main-basic.typ that solutions-basic.typ reads from,
// so chapter selection and exercise numbering stay in lockstep.
#for fname in read-chapter-files(
  from: "/src/units/sequences-series/main-basic.typ",
) {
  include fname + ".typ"
}
