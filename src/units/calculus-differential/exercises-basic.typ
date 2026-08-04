// exercises-basic.typ — Foundations (GLF) exercise sheet.
//
// The sheet is split per level even though this unit has no
// chapter-level exclusion, because the level: parameter on individual
// exercises still differs between the two documents — and because a
// shared sheet would give the two tracks different exercise NUMBERING
// for the same problems, which makes cross-referencing in class
// unsafe. Reads its chapter list from main-basic.typ, so chapter
// selection and exercise numbering match solutions-basic.typ exactly.

#import "../../common/preamble.typ": *
#set-subject-name("Calculus: Differentiation")
#show: exercise-sheet-template.with(level: "basic")

#for f in read-chapter-files(
  from: "/src/units/calculus-differential/main-basic.typ",
) {
  include f + ".typ"
}
