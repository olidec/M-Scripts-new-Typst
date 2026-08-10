// exercises-high.typ — Conic Sections (SPF) exercise sheet.
//
// No exercises-basic.typ: SPF-only unit, see main-high.typ.
// Reads its chapter list from main-high.typ, so chapter selection
// and exercise numbering match solutions-high.typ exactly.

#import "../../common/preamble.typ": *
#set-subject-name("Conic Sections")
#show: exercise-sheet-template.with(level: "high")

#for f in read-chapter-files(
  from: "/src/units/conic-sections/main-high.typ",
) {
  include f + ".typ"
}
