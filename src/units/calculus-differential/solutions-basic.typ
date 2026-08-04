// solutions-basic.typ — Foundations (GLF) solutions booklet.
//
// Reads its chapter list from main-basic.typ, so the exercise
// numbering here matches exercises-basic.typ exactly. Note that the
// numbering does NOT match the high-level booklets: level-gated
// exercises offset the count between the two documents, which is why
// cross-references by exercise number are unsafe anywhere in the
// course (STYLE_GUIDE.md).

#import "../../common/preamble.typ": *
#set-subject-name("Calculus: Differentiation")
#show: solutions-template.with(level: "basic")

#for f in read-chapter-files(
  from: "/src/units/calculus-differential/main-basic.typ",
) {
  include f + ".typ"
}
