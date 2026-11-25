// main-basic.typ — Fractions (refresher), Foundations (GLF) only.
//
// STANDALONE remediation unit, handed out when fraction errors show up
// rather than taught at a fixed point in the year. GLF only: there is
// deliberately no main-high.typ / exercises-high.typ / solutions-high.typ
// (the complex-sls precedent, mirrored), so no chapter needs
// only-basic[...] wrappers.
//
// register_chapters rules as everywhere (STYLE_GUIDE.md §3): one entry
// per line, literal root-absolute paths, within 80 columns.

#import "../../common/preamble.typ": *
#set-subject-name("Fractions")
#set-level("basic")

#register_chapters(
  ("Fractions", "/src/units/fractions/ch-fractions"),
)

#include_chapters()
