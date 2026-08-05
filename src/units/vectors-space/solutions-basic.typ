// solutions-basic.typ — Vectors Part B, Foundations (GLF) solutions booklet.
//
// Reads the same chapter list as exercises-basic.typ, from
// main-basic.typ, so the numbering in the two documents agrees.

#import "../../common/preamble.typ": *
#set-subject-name("Vectors in Space")
#show: solutions-template.with(level: "basic")

#for f in read-chapter-files(
  from: "/src/units/vectors-space/main-basic.typ",
) {
  include f + ".typ"
}
