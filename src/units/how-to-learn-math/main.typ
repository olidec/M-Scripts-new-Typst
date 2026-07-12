// ============================================================
//  main.typ — standalone entry point for "How to Learn Math"
//
//  This chapter has no level-specific content (no only-high /
//  only-basic anywhere), so unlike every other unit it does NOT
//  need a main-basic.typ / main-high.typ split — one document is
//  the same for both tracks. set-level("high") below is arbitrary
//  and has no visible effect; it's set only because chapter-template
//  reads _level in general and some future edit might add
//  level-specific asides.
//
//  Compile standalone with:
//    typst compile --root <project-root> \
//      src/units/how-to-learn-math/main.typ dist/how-to-learn-math.pdf
//
//  To fold this into a year binder instead (see STYLE_GUIDE.md §3),
//  copy the register_chapters(...) entry below — unchanged — into
//  the TOP of years/glf-y1.typ and years/spf-y1.typ, before that
//  year's first real unit, e.g.:
//
//    #let htlm = "/src/units/how-to-learn-math/"
//    #register_chapters(
//      ("How to Learn Math", htlm + "ch-how-to-learn-math", "Orientation"),
//      ("Algebra Foundations", af + "ch-algebra-foundations", "Algebra & Functions"),
//      ...
//    )
//
//  Giving it its own "Orientation" part means it gets a divider page
//  and its own header label, separate from the first real unit.
// ============================================================
#import "../../common/preamble.typ": *

#set-subject-name("How to Learn Math")
#set-level("high")

#register_chapters(
  ("How to Learn Math", "/src/units/how-to-learn-math/ch-how-to-learn-math"),
)

#include_chapters()
