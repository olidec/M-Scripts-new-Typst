// exercises-basic.typ — Equations (GLF) exercise sheet.
// Reads its chapter list from main-basic.typ.

#import "../../common/preamble.typ": *
#set-subject-name("Equations")
#show: exercise-sheet-template.with(level: "basic")

#for f in read-chapter-files(
  from: "/src/units/equations/main-basic.typ",
) {
  include f + ".typ"
}
