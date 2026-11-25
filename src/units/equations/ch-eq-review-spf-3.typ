// ch-eq-review-spf-3.typ — Year 3 Review (equations booklet, SPF only)
//
// SKELETON (Turn 1). Stage headings, labels, objectives, all
// checkpoints and stage checks with verified answers, and todo[…]
// placeholders for theory and practice.
//
// TARGET MISCONCEPTIONS (see stage notes)
//   (review of the misconceptions from the stages covered)
// STATUS
//   done:  skeleton, checkpoints, stage checks (answers verified
//          numerically; SymPy could not be installed in the drafting
//          sandbox, so a numeric root scan + substitution was used)
//   to do: theory, worked examples, exercises, warnings, error-analysis
//          tasks, "Check with your calculator" blocks, challenges.
//
// NEEDS A VISUAL CHECK — not compiled (no Typst in the drafting
// environment): route boxes, goto-first links, yr() cells in checks.
// Covers: Years 1–2 + numeric, cplx; calculus equations f′(x) = 0 and intersections for areas
// Calculator: TI-Nspire CAS

#import "../../common/preamble.typ": *
#import "config.typ": *
#show: chapter-template.with(title: "Year 3 Review")
#let ex = exercise.with(chapter: "Equations")
#let check = check.with(ex: ex)

= Year 3 Review

#todo[short introduction to the year review]

#objectives(
  [list the equation types you can solve after year 3],
  [recognize an equation type and choose a method],
  [find which earlier stage to revisit after a mistake],
)

// ════════════════════════════════════════════════════════
== Equations You Can Solve Now <st-rev-spf-3>

#todo[summary table: Type | How to recognize it | Method | Watch out | Calculator check (TI-Nspire CAS)]

// ════════════════════════════════════════════════════════
== Sort the Equations

#todo[sorting task with 8–12 equations: name the type and the method (do not solve)]

// ════════════════════════════════════════════════════════
== Mixed Review

#todo[mixed review set as a check(kind: "Year review", …) with per-item routing back to the stages; coverage: Years 1–2 + numeric, cplx; calculus equations f′(x) = 0 and intersections for areas]

#todo[optional blocks: #optional("inequalities")[…] and #optional("absolute-value")[…]]

#todo[look-ahead box: preview of next year's equation types]

// ════════════════════════════════════════════════════════
#print-check-key()

#print-hints()
#print-vocab()
