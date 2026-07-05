// ============================================================
//  solutions-basic.typ — Solutions booklet, FOUNDATIONS level
//  Compile with:  typst compile solutions-basic.typ
//
//  Chapter order is read from main-basic.typ automatically, so the
//  exercise numbering always matches the Foundations lecture notes.
//  (The numbering differs from the Advanced documents, because
//  level: "high" exercises are skipped — hence two booklets.)
//  For a more compact booklet without the gray question texts, set
//  show-questions: false below.
// ============================================================

#import "../../common/preamble.typ": *

#show: solutions-template.with(level: "basic", show-questions: true)

// ── Cover page ───────────────────────────────────────────────
#align(center + horizon)[
  #text(size: 26pt, weight: "bold")[Sequences & Series]
  #v(0.5em)
  #text(size: 14pt, fill: accent)[Solutions — Foundations]
  #v(0.3em)
  #text(size: 12pt, fill: luma(80))[Lecture Notes]
]

#pagebreak()

// Include chapters in the order defined in main-basic.typ
#for fname in read-chapter-files(from: "main-basic.typ") {
  pagebreak(weak: true)
  include fname + ".typ"
}
