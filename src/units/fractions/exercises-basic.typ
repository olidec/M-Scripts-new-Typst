#import "../../common/preamble.typ": *
#set-subject-name("Fractions")
#show: exercise-sheet-template.with(level: "basic")

#for f in read-chapter-files(
  from: "/src/units/fractions/main-basic.typ",
) {
  include f + ".typ"
}
