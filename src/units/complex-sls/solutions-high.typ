// solutions-high.typ — Complex Numbers (SPF) solutions booklet.
//
// No solutions-basic.typ: SPF-only unit, see main-high.typ.

#import "../../common/preamble.typ": *
#set-subject-name("Complex Numbers")
#show: solutions-template.with(level: "high", show-questions: true)

#for f in read-chapter-files(
  from: "/src/units/complex-sls/main-high.typ",
) {
  include f + ".typ"
}
