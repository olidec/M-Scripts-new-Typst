// ch-eq-absolute-value.typ — Absolute Value Equations (equations booklet)
//
// SKELETON (Turn 1). Stage headings, labels, objectives, all
// checkpoints and stage checks with verified answers, and todo[…]
// placeholders for theory and practice.
//
// TARGET MISCONCEPTIONS (see stage notes)
//   (none specific to this chapter)
// STATUS
//   done:  skeleton, checkpoints, stage checks (answers verified
//          numerically; SymPy could not be installed in the drafting
//          sandbox, so a numeric root scan + substitution was used)
//   to do: theory, worked examples, exercises, warnings, error-analysis
//          tasks, "Check with your calculator" blocks, challenges.
//
// NEEDS A VISUAL CHECK — not compiled (no Typst in the drafting
// environment): route boxes, goto-first links, yr() cells in checks.
// OPTIONAL: whole chapter wrapped in #optional("absolute-value").

#import "../../common/preamble.typ": *
#import "config.typ": *
#show: chapter-template.with(title: "Absolute Value Equations")
#let ex = exercise.with(chapter: "Equations")
#let check = check.with(ex: ex)

#optional("absolute-value")[
= Absolute Value Equations

#todo[chapter introduction: why this family of equations matters; how it connects to the regular units]

#objectives(
  [Solve absolute value equations by cases],
  [Solve absolute value inequalities],
)

// ════════════════════════════════════════════════════════
== Absolute Value Equations <st-abs>

#check(
  "Absolute Value Equations",
  (
    [Solve $abs(x) = 5$.],
    [Solve $abs(x - 2) = 3$.],
    [Solve $abs(x - 1) = x + 1$.],
    [Solve $abs(x - 3) < 2$.],
  ),
  (
    [$x = -5$ or $x = 5$],
    [$x = -1$ or $x = 5$],
    [$x = 0$],
    [$1 < x < 5$],
  ),
  pass: [Skip to the checkpoint in #goto-first(<st-rev-glf-1>, <st-rev-spf-1>).],
  fail: [Work through this section.],
)

#todo[theory and worked examples for “Absolute Value Equations”: vocab(), keybox, warning() for the misconceptions above]

#todo[exercises for “Absolute Value Equations”, ramped from difficulty 1 to 3, with an error-analysis task (three students, at least one correct)]

#todo[“Check with your calculator” block, written twice and gated. only-basic: Solve both cases by hand; check with num-solv. only-high: solve(abs(…)=…, x). (VERIFY on device)]

#check(
  kind: "Stage check",
  "Absolute Value Equations",
  (
    [Solve $abs(2x - 1) = 5$.],
    [Solve $abs(x + 4) = 0$.],
    [Solve $abs(3x) + 2 = 1$.],
    [Solve $abs(x + 1) >= 3$.],
  ),
  (
    [$x = -2$ or $x = 3$],
    [$x = -4$],
    [No real solution],
    [$x <= -4$ or $x >= 2$],
  ),
  pass: [Continue with #goto-first(<st-rev-glf-1>, <st-rev-spf-1>).],
  fail: [Find the example or exercise that matches your mistake and redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════
#print-check-key()

#print-hints()
#print-vocab()
]
