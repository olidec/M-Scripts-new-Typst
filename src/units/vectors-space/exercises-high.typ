// exercises-high.typ — Vectors Part B, Advanced (SPF) exercise sheet.
//
// Reads its chapter list from main-high.typ, so chapter selection and
// exercise numbering match solutions-high.typ exactly. The two levels
// diverge here more than in Part A: ch-circles-spheres appears only in
// the high sheet.

#import "../../common/preamble.typ": *
#set-subject-name("Vectors in Space")
#show: exercise-sheet-template.with(level: "high")

#for f in read-chapter-files(
  from: "/src/units/vectors-space/main-high.typ",
) {
  include f + ".typ"
}
