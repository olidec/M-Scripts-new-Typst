// ============================================================
//  exercises.typ — Exercise sheets only, landscape A4
//  One exercise per page, no solutions, no theory.
//  Chapter order is read from main-high.typ automatically, so
//  this sheet always contains EVERY exercise (the superset).
//  Compile with:  typst compile exercises.typ
// ============================================================

#import "../../common/preamble.typ": *

// ── Parse chapter filenames from main-high.typ ───────────────
// Extracts the filename from each ("Title", "filename") entry in
// the register_chapters(...) block.
#let chapter-files = {
  let src = read("/src/units/sequences-series/main-high.typ")
  let files = ()
  for line in src.split("\n") {
    let t = line.trim()
    if t.starts-with("(\"") {
      let parts = t.split("\",")
      if parts.len() >= 2 {
        let p = parts.at(1)
        let q1 = p.position("\"")
        if q1 != none {
          let after = p.slice(q1 + 1)
          let q2 = after.position("\"")
          if q2 != none {
            files.push(after.slice(0, q2))
          }
        }
      }
    }
  }
  files
}

// Activate exercise-sheet mode (hides theory & solutions, landscape)
#show: exercise-sheet-template

// ── Cover page ───────────────────────────────────────────────
#align(center + horizon)[
  #text(size: 26pt, weight: "bold")[Sequences & Series]
  #v(0.5em)
  #text(size: 14pt, fill: accent)[Exercise Sheets]
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

// Include chapters in the order defined in main-high.typ
#for fname in chapter-files {
  include fname + ".typ"
}
