// solutions-basic.typ — Foundations (GLF) solutions booklet.
//
// Reads its chapter list from main-basic.typ, so the exercise
// numbering here matches exercises-basic.typ exactly.

#import "../../common/preamble.typ": *
#set-subject-name("Calculus: Integration")
#show: solutions-template.with(level: "basic")

#for f in read-chapter-files(
  from: "/src/units/calculus-integral/main-basic.typ",
) {
  include f + ".typ"
}
