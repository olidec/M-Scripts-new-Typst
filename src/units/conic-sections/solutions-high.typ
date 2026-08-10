// solutions-high.typ — Conic Sections (SPF) solutions booklet.
//
// No solutions-basic.typ: SPF-only unit, see main-high.typ.

#import "../../common/preamble.typ": *
#set-subject-name("Conic Sections")
#show: solutions-template.with(level: "high", show-questions: true)

#for f in read-chapter-files(
  from: "/src/units/conic-sections/main-high.typ",
) {
  include f + ".typ"
}
