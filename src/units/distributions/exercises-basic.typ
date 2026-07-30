// exercises-basic.typ — Foundations (GLF) exercise sheet.
//
// Split per level so a student never receives exercise pages for
// chapters they have not studied — which matters more in this unit
// than any other, since four chapters are SPF-only. Reads its chapter
// list from main-basic.typ, so chapter selection and exercise
// numbering match solutions-basic.typ exactly.
//
// Note that sim-box() content is suppressed here by default: a
// simulation task only reaches the sheet if it is written with
// on-sheet: true because running it is part of the question.

#import "../../common/preamble.typ": *
#set-subject-name("Distributions")
#show: exercise-sheet-template.with(level: "basic")

#for f in read-chapter-files(
  from: "/src/units/distributions/main-basic.typ",
) {
  include f + ".typ"
}
