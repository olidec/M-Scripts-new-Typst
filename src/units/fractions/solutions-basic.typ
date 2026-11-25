#import "../../common/preamble.typ": *
#set-subject-name("Fractions")
#show: solutions-template.with(level: "basic", show-questions: true)

#for f in read-chapter-files(
  from: "/src/units/fractions/main-basic.typ",
) {
  include f + ".typ"
}
