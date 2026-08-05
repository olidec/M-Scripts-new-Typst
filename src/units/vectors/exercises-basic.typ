// exercises-basic.typ — Vectors Part A, Foundations (GLF) exercise sheet.
//
// Reads its chapter list from main-basic.typ, so chapter selection and
// exercise numbering match solutions-basic.typ exactly.
//
// Part A has no chapter-level exclusions, so the basic and high sheets
// cover the same eight chapters — but they are still built separately,
// because the only-high exercises inside chapters shift the exercise
// numbering between the two levels. That is also why exercises must
// never be cross-referenced by number.

#import "../../common/preamble.typ": *
#set-subject-name("Vectors")
#show: exercise-sheet-template.with(level: "basic")

#for f in read-chapter-files(
  from: "/src/units/vectors/main-basic.typ",
) {
  include f + ".typ"
}
