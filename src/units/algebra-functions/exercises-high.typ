// exercises-high.typ — Advanced (SPF) exercise sheet.
//
// Counterpart to exercises-basic.typ; see the comment there for why
// the sheet is split per level. Reads its chapter list from
// main-high.typ, so chapter selection and exercise numbering match
// solutions-high.typ exactly.
//
// Migration note: if a unit still has an old single exercises.typ,
// rename it to exercises-high.typ, add the level: "high" argument
// to the template call below, and create exercises-basic.typ as its
// sibling. (With the new preamble, an unmodified old exercises.typ
// would silently compile as an Advanced sheet — the sheet-mode
// show-everything override is gone and the template's level
// defaults to "high" — so do the rename explicitly rather than
// relying on that.)

#import "../../common/preamble.typ": *
#set-subject-name("Algebra & Functions")
#show: exercise-sheet-template.with(level: "high")

#for f in read-chapter-files(
  from: "/src/units/algebra-functions/main-high.typ",
) {
  include f + ".typ"
}
