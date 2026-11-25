// ch-eq-inequalities.typ — Inequalities (equations booklet)
//
// SKELETON (Turn 1). Stage headings, labels, objectives, all
// checkpoints and stage checks with verified answers, and todo[…]
// placeholders for theory and practice.
//
// TARGET MISCONCEPTIONS (see stage notes)
//   Inequalities: M9 not flipping the inequality sign
// STATUS
//   done:  skeleton, checkpoints, stage checks (answers verified
//          numerically; SymPy could not be installed in the drafting
//          sandbox, so a numeric root scan + substitution was used)
//   to do: theory, worked examples, exercises, warnings, error-analysis
//          tasks, "Check with your calculator" blocks, challenges.
//
// NEEDS A VISUAL CHECK — not compiled (no Typst in the drafting
// environment): route boxes, goto-first links, yr() cells in checks.
// OPTIONAL: whole chapter wrapped in #optional("inequalities").

#import "../../common/preamble.typ": *
#import "config.typ": *
#show: chapter-template.with(title: "Inequalities")
#let ex = exercise.with(chapter: "Equations")
#let check = check.with(ex: ex)

#optional("inequalities")[
= Inequalities

#todo[chapter introduction: why this family of equations matters; how it connects to the regular units]

#objectives(
  [Solve linear and quadratic inequalities],
  [Flip the sign when multiplying or dividing by a negative number],
)

// ════════════════════════════════════════════════════════
== Inequalities <st-ineq>

#check(
  "Inequalities",
  (
    [Solve $2x - 3 < 7$.],
    [Solve $-3x >= 12$.],
    [Solve $x^2 < 9$.],
    [Solve $(x - 1) dot (x + 2) > 0$.],
  ),
  (
    [$x < 5$],
    [$x <= -4$],
    [$-3 < x < 3$],
    [$x < -2$ or $x > 1$],
  ),
  pass: [Skip to the checkpoint in #goto-first(<st-abs>, <st-rev-glf-1>, <st-rev-spf-1>).],
  fail: [Work through this section.],
)

#todo[theory and worked examples for “Inequalities”: vocab(), keybox, warning() for the misconceptions above]

#todo[exercises for “Inequalities”, ramped from difficulty 1 to 3, with an error-analysis task (three students, at least one correct)]

#todo[“Check with your calculator” block, written twice and gated. only-basic: No inequality solver on the TI-30X Pro: solve the boundary equation, then test intervals. only-high: solve(x^2\<9, x). (VERIFY on device)]

#check(
  kind: "Stage check",
  "Inequalities",
  (
    [Solve $5 - 2x > 1$.],
    [Solve $-x/2 <= 3$.],
    [Solve $x^2 >= 4$.],
    [Solve $x^2 - x - 6 < 0$.],
  ),
  (
    [$x < 2$],
    [$x >= -6$],
    [$x <= -2$ or $x >= 2$],
    [$-2 < x < 3$],
  ),
  pass: [Continue with #goto-first(<st-abs>, <st-rev-glf-1>, <st-rev-spf-1>).],
  fail: [Find the example or exercise that matches your mistake and redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════
#print-check-key()

#print-hints()
#print-vocab()
]
