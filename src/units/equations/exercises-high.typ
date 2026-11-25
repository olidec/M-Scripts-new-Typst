// exercises-high.typ — Equations (SPF) exercise sheet.
// Reads its chapter list from main-high.typ.

#import "../../common/preamble.typ": *
#set-subject-name("Equations")
#show: exercise-sheet-template.with(level: "high")

#for f in read-chapter-files(
  from: "/src/units/equations/main-high.typ",
) {
  include f + ".typ"
}
