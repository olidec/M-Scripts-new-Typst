// ============================================================
//  solutions-high.typ — Solutions booklet, ADVANCED level
//  Compile with:  typst compile solutions-high.typ
//
//  Chapter order is read from main-high.typ automatically, so the
//  exercise numbering always matches the Advanced lecture notes.
//  For a more compact booklet without the gray question texts, set
//  show-questions: false below.
// ============================================================

#import "../../common/preamble.typ": *

#show: solutions-template.with(level: "high", show-questions: true)

// ── Cover page ───────────────────────────────────────────────
#align(center + horizon)[
  #text(size: 26pt, weight: "bold")[Sequences & Series]
  #v(0.5em)
  #text(size: 14pt, fill: accent)[Solutions — Advanced]
  #v(0.3em)
  #text(size: 12pt, fill: luma(80))[Lecture Notes]
]

#pagebreak()

// Include chapters in the order defined in main-high.typ
#for fname in read-chapter-files(from: "main-high.typ") {
  pagebreak(weak: true)
  include fname + ".typ"
}
