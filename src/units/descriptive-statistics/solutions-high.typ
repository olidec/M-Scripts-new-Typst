// solutions-high.typ — Descriptive Statistics, Advanced (SPF)
// solutions booklet. Reads its chapter list from main-high.typ so
// chapter selection and exercise numbering always match the
// SPF lecture notes and exercise sheet.

#import "../../common/preamble.typ": *
#set-subject-name("Descriptive Statistics")
#show: solutions-template.with(level: "high", show-questions: true)

#for f in read-chapter-files(
  from: "/src/units/descriptive-statistics/main-high.typ",
) {
  include f + ".typ"
}
