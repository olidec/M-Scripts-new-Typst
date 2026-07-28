// solutions-high.typ — Probabilities & Combinatorics, Advanced (SPF)
// solutions booklet. Two booklets rather than one because GLF and SPF
// number their exercises differently — ch-counting-advanced is SPF-only,
// so every exercise after it is offset between the two tracks.

#import "../../common/preamble.typ": *
#set-subject-name("Probabilities & Combinatorics")
#show: solutions-template.with(level: "high", show-questions: true)

#for f in read-chapter-files(
  from: "/src/units/probabilities-combinatorics/main-high.typ",
) {
  include f + ".typ"
}
