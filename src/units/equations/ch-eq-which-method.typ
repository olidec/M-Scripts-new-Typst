// ch-eq-which-method.typ — Which Method? (equations booklet)
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

#import "../../common/preamble.typ": *
#import "config.typ": *
#show: chapter-template.with(title: "Which Method?")
#let ex = exercise.with(chapter: "Equations")
#let check = check.with(ex: ex)

= Which Method?

#todo[chapter introduction: why this family of equations matters; how it connects to the regular units]

#objectives(
  [Recognize an equation type and choose a method],
  [Mix all types, as on the Matura],
)

// ════════════════════════════════════════════════════════
== Which Method? <st-which>

#check(
  "Which method?",
  (
    [$x^2 - 6x = 0$],
    [$2^x = 9$],
    [$sqrt(x + 1) = x - 1$],
    [$x^4 - 10x^2 + 9 = 0$],
  ),
  (
    [Factor out $x$ (product equals zero)],
    [Take the logarithm of both sides],
    [Square both sides, then check],
    [Substitute $u = x^2$],
  ),
  pass: [Skip to the stage check in this section.],
  fail: [Work through this section.],
)

#todo[theory and worked examples for “Which Method?”: vocab(), keybox, warning() for the misconceptions above]

#todo[exercises for “Which Method?”, ramped from difficulty 1 to 3, with an error-analysis task (three students, at least one correct)]

#check(
  kind: "Stage check",
  "Which Method?",
  (
    [$x^2 + 2x - 8 = 0$],
    [$log(x) = 3$],
    [$x/(x - 1) = 2/(x + 1)$],
    [$sin(x) = 0.3$],
  ),
  (
    [Factor or use the quadratic formula],
    [Rewrite as a power: $x = 10^3$],
    [Multiply by the common denominator, then check the domain],
    [Inverse sine, then use the symmetry of the sine curve],
  ),
  pass: [Continue with #goto-first(<st-ineq>, <st-abs>, <st-rev-glf-1>, <st-rev-spf-1>).],
  fail: [Go back to the stages behind your mistakes, then ask your teacher.],
)

// ════════════════════════════════════════════════════════
#print-check-key()

#print-hints()
#print-vocab()
