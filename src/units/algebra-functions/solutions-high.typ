// solutions-high.typ — Algebra & Functions, Advanced (SPF)
// solutions booklet. Reads its chapter list from main-high.typ so
// chapter selection and exercise numbering always match the SPF
// lecture notes and the SPF exercise sheet.

#import "../../common/preamble.typ": *
#set-subject-name("Algebra & Functions")
#show: solutions-template.with(level: "high", show-questions: true)

#for f in read-chapter-files(
  from: "/src/units/algebra-functions/main-high.typ",
) {
  include f + ".typ"
}
