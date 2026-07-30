// solutions-basic.typ — Distributions, Foundations (GLF) solutions booklet.
//
// Two booklets rather than one because GLF and SPF number their
// exercises differently: ch-normal, ch-confidence,
// ch-more-distributions and ch-modern are SPF-only, so every exercise
// after ch-normal-intro is offset between the tracks. Reads its
// chapter list from main-basic.typ.

#import "../../common/preamble.typ": *
#set-subject-name("Distributions")
#show: solutions-template.with(level: "basic", show-questions: true)

#for f in read-chapter-files(
  from: "/src/units/distributions/main-basic.typ",
) {
  include f + ".typ"
}
