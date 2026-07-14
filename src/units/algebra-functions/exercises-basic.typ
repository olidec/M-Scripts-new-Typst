// exercises-basic.typ — Foundations (GLF) exercise sheet.
//
// One of the two per-level sheets that replace the old single
// exercises.typ (which showed every exercise regardless of level,
// so its numbering could match neither solutions booklet, and it
// included chapters GLF doesn't read that year). This file reads
// its chapter list from main-basic.typ, so:
//   * only GLF-registered chapters appear (e.g. no ch-powers /
//     ch-exponential / ch-logarithms in year 1), and
//   * exercise numbering is identical to solutions-basic.typ.
//
// Adapt the two paths below per unit — everything else is fixed.

#import "../../common/preamble.typ": *
#set-subject-name("Algebra & Functions")
#show: exercise-sheet-template.with(level: "basic")

#for f in read-chapter-files(
  from: "/src/units/algebra-functions/main-basic.typ",
) {
  include f + ".typ"
}
