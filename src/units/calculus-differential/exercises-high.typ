// exercises-high.typ — Advanced (SPF) exercise sheet.
//
// Counterpart to exercises-basic.typ; see the comment there for why
// the sheet is split per level. Reads its chapter list from
// main-high.typ, so chapter selection and exercise numbering match
// solutions-high.typ exactly.

#import "../../common/preamble.typ": *
#set-subject-name("Calculus: Differentiation")
#show: exercise-sheet-template.with(level: "high")

#for f in read-chapter-files(
  from: "/src/units/calculus-differential/main-high.typ",
) {
  include f + ".typ"
}
