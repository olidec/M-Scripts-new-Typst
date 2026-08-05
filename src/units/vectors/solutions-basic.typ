// solutions-basic.typ — Vectors Part A, Foundations (GLF) solutions booklet.
//
// Reads the same chapter list as exercises-basic.typ, from
// main-basic.typ, so the numbering in the two documents agrees.

#import "../../common/preamble.typ": *
#set-subject-name("Vectors")
#show: solutions-template.with(level: "basic")

#for f in read-chapter-files(
  from: "/src/units/vectors/main-basic.typ",
) {
  include f + ".typ"
}
