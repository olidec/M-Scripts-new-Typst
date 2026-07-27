// solutions-basic.typ — Descriptive Statistics, Foundations (GLF)
// solutions booklet. Reads its chapter list from main-basic.typ so
// chapter selection and exercise numbering always match the
// GLF lecture notes and exercise sheet.

#import "../../common/preamble.typ": *
#set-subject-name("Descriptive Statistics")
#show: solutions-template.with(level: "basic", show-questions: true)

#for f in read-chapter-files(
  from: "/src/units/stochastics-descriptive/main-basic.typ",
) {
  include f + ".typ"
}
