// exercises-basic.typ — Foundations (GLF) exercise sheet.
//
// The sheet is split per level so that a GLF student never receives
// exercise pages for chapters they have not studied — in this unit
// that matters more than usual, since ch-counting-advanced is SPF-only
// (see main-basic.typ). Reads its chapter list from main-basic.typ, so
// chapter selection and exercise numbering match solutions-basic.typ
// exactly.

#import "../../common/preamble.typ": *
#set-subject-name("Probabilities & Combinatorics")
#show: exercise-sheet-template.with(level: "basic")

#for f in read-chapter-files(
  from: "/src/units/probabilities-combinatorics/main-basic.typ",
) {
  include f + ".typ"
}
