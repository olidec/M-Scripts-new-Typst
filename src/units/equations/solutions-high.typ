// solutions-high.typ — Equations (SPF) solutions booklet.

#import "../../common/preamble.typ": *
#set-subject-name("Equations")
#show: solutions-template.with(level: "high", show-questions: true)

#for f in read-chapter-files(
  from: "/src/units/equations/main-high.typ",
) {
  include f + ".typ"
}
