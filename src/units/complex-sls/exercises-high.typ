// exercises-high.typ — Complex Numbers (SPF) exercise sheet.
//
// No exercises-basic.typ: SPF-only unit, see main-high.typ.
// Reads its chapter list from main-high.typ, so chapter selection and
// exercise numbering match solutions-high.typ exactly.

#import "../../common/preamble.typ": *
#set-subject-name("Complex Numbers")
#show: exercise-sheet-template.with(level: "high")

#for f in read-chapter-files(
  from: "/src/units/complex-sls/main-high.typ",
) {
  include f + ".typ"
}
