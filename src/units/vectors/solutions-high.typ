// solutions-high.typ — Vectors Part A, Advanced (SPF) solutions booklet.
//
// Reads the same chapter list as exercises-high.typ, from
// main-high.typ, so the numbering in the two documents agrees.

#import "../../common/preamble.typ": *
#set-subject-name("Vectors")
#show: solutions-template.with(level: "high")

#for f in read-chapter-files(
  from: "/src/units/vectors/main-high.typ",
) {
  include f + ".typ"
}
