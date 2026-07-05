// ============================================================
//  years/glf-y1.typ — GLF (Foundations), Year 1
//  Spans multiple units in one document. Compile this only if
//  you actually want a full-year binder PDF; day-to-day teaching
//  still uses each unit's own main-basic.typ / exercises.typ /
//  solutions-basic.typ.
//
//  NOTE ON PATHS: the filenames below are root-absolute (start
//  with "/", resolved against whatever --root the compiler is
//  given), NOT relative to this file. That's required, not a
//  style choice — include_chapters()'s #include call lives inside
//  preamble.typ (src/common/), so a relative path here would be
//  resolved against src/common/ instead of against this file,
//  and fail. See preamble.typ's comment above register_chapters
//  for the full explanation. The #import on the next line is a
//  normal relative import, though — that one's written directly
//  in THIS file, so it resolves correctly relative to years/.
// ============================================================
#import "../common/preamble.typ": *
#set-level("basic")

#let af  = "/src/units/algebra-functions/"
#let trig = "/src/units/trigonometry/"

#register_chapters(
  ("Algebra Foundations",       af + "/src/units/algebra-functions/ch-algebra-foundations", "Algebra & Functions"),
  ("Introduction to Functions", af + "/src/units/algebra-functions/ch-functions-intro",     "Algebra & Functions"),
  ("Linear Functions",         af + "/src/units/algebra-functions/ch-linear",               "Algebra & Functions"),
  ("Systems of Equations",     af + "/src/units/algebra-functions/ch-systems",              "Algebra & Functions"),
  ("Quadratic Functions",      af + "/src/units/algebra-functions/ch-quadratic",            "Algebra & Functions"),
  ("Power Functions",          af + "/src/units/algebra-functions/ch-powers",               "Algebra & Functions"),
  ("Exponential Functions",    af + "/src/units/algebra-functions/ch-exponential",          "Algebra & Functions"),
  ("Logarithms",               af + "/src/units/algebra-functions/ch-logarithms",           "Algebra & Functions"),

  ("Trigonometry",             trig + "/src/units/trigonometry/ch-basics",             "Trigonometry"),
)

#include_chapters()
