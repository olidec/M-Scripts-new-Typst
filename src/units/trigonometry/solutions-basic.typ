// ============================================================
//  solutions-basic.typ — Solutions booklet, FOUNDATIONS level
//  Chapter order is read from main-basic.typ automatically, so the
//  exercise numbering always matches the Foundations lecture notes.
//  For a more compact booklet without the gray question texts, set
//  show-questions: false below.
//  Compile via:  ./build.sh unit trigonometry solutions
// ============================================================

#import "../../common/preamble.typ": *
#set-subject-name("Trigonometry")
#show: solutions-template.with(level: "basic", show-questions: true)

// ── Cover page ───────────────────────────────────────────────
#align(center + horizon)[
  #text(size: 26pt, weight: "bold")[Trigonometry]
  #v(0.5em)
  #text(size: 14pt, fill: accent)[Solutions — Foundations]
  #v(0.3em)
  #text(size: 12pt, fill: luma(80))[Lecture Notes]
]

#pagebreak()

// Include chapters in the order defined in main-basic.typ
#for fname in read-chapter-files(from: "/src/units/trigonometry/main-basic.typ") {
  pagebreak(weak: true)
  include fname + ".typ"
}
