// solutions-basic.typ — Probabilities & Combinatorics, Foundations
// (GLF) solutions booklet. Reads its chapter list from main-basic.typ
// so chapter selection and exercise numbering always match the GLF
// lecture notes and the GLF exercise sheet.

#import "../../common/preamble.typ": *
#set-subject-name("Probabilities & Combinatorics")
#show: solutions-template.with(level: "basic", show-questions: true)

#for f in read-chapter-files(
  from: "/src/units/probabilities-combinatorics/main-basic.typ",
) {
  include f + ".typ"
}
