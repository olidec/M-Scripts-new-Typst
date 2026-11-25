// solutions-high.typ — Vectors Crash Course (SPF) solutions booklet.
//
// No solutions-basic.typ: SPF-only, see main-high.typ.

#import "../../common/preamble.typ": *
#set-subject-name("Vectors Crash Course")
#show: solutions-template.with(level: "high", show-questions: true)

#for f in read-chapter-files(
  from: "../units/vectors-crash-course/main-high.typ",
) {
  include f + ".typ"
}
