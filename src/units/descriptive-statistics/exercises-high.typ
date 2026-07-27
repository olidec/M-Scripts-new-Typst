// exercises-high.typ — Advanced (SPF) exercise sheet.
//
// Reads its chapter list from main-high.typ, so chapter selection and
// exercise numbering are always identical to solutions-high.typ.
// Never add a chapter here directly — register it in main-high.typ.
//
// Adapt the two paths below per unit — everything else is fixed.

#import "../../common/preamble.typ": *
#set-subject-name("Descriptive Statistics")
#show: exercise-sheet-template.with(level: "high")

#for f in read-chapter-files(
  from: "/src/units/descriptive-statistics/main-high.typ",
) {
  include f + ".typ"
}
