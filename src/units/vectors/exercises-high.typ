// exercises-high.typ — Vectors Part A, Advanced (SPF) exercise sheet.
//
// Reads its chapter list from main-high.typ, so chapter selection and
// exercise numbering match solutions-high.typ exactly.
//
// Part A has no chapter-level exclusions, so the basic and high sheets
// cover the same eight chapters — but they are still built separately,
// because the only-high exercises inside chapters shift the exercise
// numbering between the two levels. That is also why exercises must
// never be cross-referenced by number.

#import "../../common/preamble.typ": *
#set-subject-name("Vectors")
#show: exercise-sheet-template.with(level: "high")

#for f in read-chapter-files(
  from: "/src/units/vectors/main-high.typ",
) {
  include f + ".typ"
}
