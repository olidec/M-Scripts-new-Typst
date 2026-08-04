// exercises-basic.typ — Foundations (GLF) exercise sheet.
//
// Reads its chapter list from main-basic.typ, so chapter selection
// and exercise numbering match solutions-basic.typ exactly. The
// numbering does NOT match the high-level booklets: ch-improper is
// absent here entirely, and level-gated exercises inside the shared
// chapters offset the count further. Cross-references by exercise
// number are unsafe course-wide (STYLE_GUIDE.md).

#import "../../common/preamble.typ": *
#set-subject-name("Calculus: Integration")
#show: exercise-sheet-template.with(level: "basic")

#for f in read-chapter-files(
  from: "/src/units/calculus-integral/main-basic.typ",
) {
  include f + ".typ"
}
