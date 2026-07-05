// ============================================================
//  years/spf-y1.typ — SPF (Advanced), Year 1
//  Note how close this is to glf-y1.typ: same chapter list, same
//  order — the extra SPF depth lives INSIDE those chapter files
//  as #only-high[...] content, not as extra chapters here. Only
//  the level switch and the added Descriptive Statistics unit
//  differ from the GLF file.
//
//  NOTE ON PATHS: root-absolute (leading "/"), not relative to
//  this file — required for include_chapters() to resolve
//  correctly from inside preamble.typ. See preamble.typ's comment
//  above register_chapters for the full explanation. Safe to use
//  the `#let af = ...` shortcut here specifically because this
//  file is never read back by read-chapter-files() (only a unit's
//  own main-basic.typ/main-high.typ are) — see that same comment
//  for why the shortcut would be unsafe there.
// ============================================================
#import "../common/preamble.typ": *
#set-level("high")

#let af    = "/src/units/algebra-functions/"
#let trig  = "/src/units/trigonometry/"
#let stats = "/src/units/stochastics-descriptive/"

#register_chapters(
  ("Algebra Foundations",       af + "ch-algebra-foundations", "Algebra & Functions"),
  ("Introduction to Functions", af + "ch-functions-intro",     "Algebra & Functions"),
  ("Linear Functions",         af + "ch-linear",               "Algebra & Functions"),
  ("Systems of Equations",     af + "ch-systems",              "Algebra & Functions"),
  ("Quadratic Functions",      af + "ch-quadratic",            "Algebra & Functions"),
  ("Power Functions",          af + "ch-powers",               "Algebra & Functions"),
  ("Exponential Functions",    af + "ch-exponential",          "Algebra & Functions"),
  ("Logarithms",               af + "ch-logarithms",           "Algebra & Functions"),

  ("Trigonometry",             trig + "ch-basics",             "Trigonometry"),

  ("Descriptive Statistics",   stats + "ch-basics",            "Descriptive Statistics"),
)

#include_chapters()
