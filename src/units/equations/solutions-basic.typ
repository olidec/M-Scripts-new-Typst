// solutions-basic.typ — Equations (GLF) solutions booklet.

#import "../../common/preamble.typ": *
#set-subject-name("Equations")
#show: solutions-template.with(level: "basic", show-questions: true)

#for f in read-chapter-files(
  from: "/src/units/equations/main-basic.typ",
) {
  include f + ".typ"
}
