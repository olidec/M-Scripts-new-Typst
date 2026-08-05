// exercises-basic.typ — Vectors Part B, Foundations (GLF) exercise sheet.
//
// Reads its chapter list from main-basic.typ, so chapter selection and
// exercise numbering match solutions-basic.typ exactly. The two levels
// diverge here more than in Part A: ch-circles-spheres appears only in
// the high sheet.

#import "../../common/preamble.typ": *
#set-subject-name("Vectors in Space")
#show: exercise-sheet-template.with(level: "basic")

#for f in read-chapter-files(
  from: "/src/units/vectors-space/main-basic.typ",
) {
  include f + ".typ"
}
