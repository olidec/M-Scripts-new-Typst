// solutions-high.typ — Advanced (SPF) solutions booklet.
//
// Counterpart to solutions-basic.typ. Reads its chapter list from
// main-high.typ, so the exercise numbering here matches
// exercises-high.typ exactly.

#import "../../common/preamble.typ": *
#set-subject-name("Calculus: Integration")
#show: solutions-template.with(level: "high")

#for f in read-chapter-files(
  from: "/src/units/calculus-integral/main-high.typ",
) {
  include f + ".typ"
}
