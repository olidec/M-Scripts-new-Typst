// main-basic.typ — Equations: practice and review (GLF).
// GLF: no ch-eq-complex (SPF only). Chapter-level exclusion works by
// registering a file in one main file only.
// Reviews come last; the third entry element starts a "Year Reviews" part.

#import "../../common/preamble.typ": *
#set-subject-name("Equations")
#set-level("basic")

#register_chapters(
  ("Start", "/src/units/equations/ch-eq-start"),
  ("Foundations", "/src/units/equations/ch-eq-foundations"),
  ("Quadratic Equations", "/src/units/equations/ch-eq-quadratic"),
  ("Systems", "/src/units/equations/ch-eq-systems"),
  ("Exp and Log", "/src/units/equations/ch-eq-exp-log"),
  ("Trigonometry", "/src/units/equations/ch-eq-trig"),
  ("Polynomials", "/src/units/equations/ch-eq-polynomial"),
  ("Numerical", "/src/units/equations/ch-eq-numeric"),
  ("Which Method?", "/src/units/equations/ch-eq-which-method"),
  ("Inequalities", "/src/units/equations/ch-eq-inequalities"),
  ("Absolute Value", "/src/units/equations/ch-eq-absolute-value"),
  ("Review 1", "/src/units/equations/ch-eq-review-glf-1", "Year Reviews"),
  ("Review 2", "/src/units/equations/ch-eq-review-glf-2", "Year Reviews"),
  ("Review 3", "/src/units/equations/ch-eq-review-glf-3", "Year Reviews"),
  ("Review 4", "/src/units/equations/ch-eq-review-glf-4", "Year Reviews"),
)

#include_chapters()
