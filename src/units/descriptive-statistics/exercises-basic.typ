// exercises-basic.typ — Foundations (GLF) exercise sheet.
//
// Reads its chapter list from main-basic.typ, so chapter selection and
// exercise numbering are always identical to solutions-basic.typ.
// Never add a chapter here directly — register it in main-basic.typ.
//
// Adapt the two paths below per unit — everything else is fixed.

#import "../../common/preamble.typ": *
#set-subject-name("Descriptive Statistics")
#show: exercise-sheet-template.with(level: "basic")

#for f in read-chapter-files(
  from: "/src/units/descriptive-statistics/main-basic.typ",
) {
  include f + ".typ"
}
