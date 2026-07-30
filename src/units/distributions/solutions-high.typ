// solutions-high.typ — Distributions, Advanced (SPF) solutions booklet.
//
// Two booklets rather than one because GLF and SPF number their
// exercises differently: ch-normal, ch-confidence,
// ch-more-distributions and ch-modern are SPF-only, so every exercise
// after ch-normal-intro is offset between the tracks. Reads its
// chapter list from main-high.typ.

#import "../../common/preamble.typ": *
#set-subject-name("Distributions")
#show: solutions-template.with(level: "high", show-questions: true)

#for f in read-chapter-files(
  from: "/src/units/distributions/main-high.typ",
) {
  include f + ".typ"
}
