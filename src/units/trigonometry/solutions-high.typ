// ============================================================
//  solutions-high.typ — Solutions booklet, ADVANCED level
//  Chapter order is read from main-high.typ automatically, so the
//  exercise numbering always matches the Advanced lecture notes.
//  For a more compact booklet without the gray question texts, set
//  show-questions: false below.
//  Compile via:  ./build.sh unit trigonometry solutions
// ============================================================

#import "../../common/preamble.typ": *
#set-subject-name("Trigonometry")
#show: solutions-template.with(level: "high", show-questions: true)

// ── Cover page ───────────────────────────────────────────────
#align(center + horizon)[
  #text(size: 26pt, weight: "bold")[Trigonometry]
  #v(0.5em)
  #text(size: 14pt, fill: accent)[Solutions — Advanced]
  #v(0.3em)
  #text(size: 12pt, fill: luma(80))[Lecture Notes]
]

#pagebreak()

// Include chapters in the order defined in main-high.typ
#for fname in read-chapter-files(from: "/src/units/trigonometry/main-high.typ") {
  pagebreak(weak: true)
  include fname + ".typ"
}
