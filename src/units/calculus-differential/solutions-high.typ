// solutions-high.typ — Advanced (SPF) solutions booklet.
//
// Counterpart to solutions-basic.typ. Reads its chapter list from
// main-high.typ, so the exercise numbering here matches
// exercises-high.typ exactly — and, as noted there, does not match
// the basic-level booklets.

#import "../../common/preamble.typ": *
#set-subject-name("Calculus: Differentiation")
#show: solutions-template.with(level: "high")

#for f in read-chapter-files(
  from: "/src/units/calculus-differential/main-high.typ",
) {
  include f + ".typ"
}
