// exercises-high.typ — Advanced (SPF) exercise sheet.
//
// Counterpart to exercises-basic.typ. Reads its chapter list from
// main-high.typ, so chapter selection and exercise numbering match
// solutions-high.typ exactly — and, as noted there, do not match the
// basic-level booklets.

#import "../../common/preamble.typ": *
#set-subject-name("Calculus: Integration")
#show: exercise-sheet-template.with(level: "high")

#for f in read-chapter-files(
  from: "/src/units/calculus-integral/main-high.typ",
) {
  include f + ".typ"
}
