// ch-eq-complex.typ — Complex Equations (equations booklet, SPF only)
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
#show: chapter-template.with(title: "Complex Equations")
#let ex = exercise.with(chapter: "Equations")
#let check = check.with(ex: ex)

= Complex Equations

#todo[chapter introduction: why this family of equations matters; how it connects to the regular units]

#objectives(
  [Solve quadratic equations with negative discriminant],
  [Find all roots of $z^n = w$],
)

// ════════════════════════════════════════════════════════
== Complex Equations <st-cplx>

#check(
  "Complex Equations",
  (
    [Solve $z^2 = -9$.],
    [Solve $z^2 - 2z + 5 = 0$.],
    [Solve $z^2 = 5 - 12i$.],
    [Solve $z^3 = 8$.],
  ),
  (
    [$z = 3i$ or $z = -3i$],
    [$z = 1 + 2i$ or $z = 1 - 2i$],
    [$z = 3 - 2i$ or $z = -3 + 2i$],
    [$z = 2$, $z = -1 + i sqrt(3)$, or $z = -1 - i sqrt(3)$],
  ),
  pass: [Skip to the checkpoint in #goto-first(<st-which>).],
  fail: [Work through this section.],
)

#todo[theory and worked examples for “Complex Equations”: vocab(), keybox, warning() for the misconceptions above]

#todo[exercises for “Complex Equations”, ramped from difficulty 1 to 3, with an error-analysis task (three students, at least one correct)]

#todo[“Check with your calculator” block, written twice and gated. only-high: cSolve(…, z), cZeros; compare with your hand result. (VERIFY on device)]

#check(
  kind: "Stage check",
  "Complex Equations",
  (
    [Solve $z^2 = -16$.],
    [Solve $z^2 + 4z + 13 = 0$.],
    [Solve $z^2 = -3 + 4i$.],
    [Solve $z^4 = 16$.],
  ),
  (
    [$z = 4i$ or $z = -4i$],
    [$z = -2 + 3i$ or $z = -2 - 3i$],
    [$z = 1 + 2i$ or $z = -1 - 2i$],
    [$z = 2$, $z = -2$, $z = 2i$, or $z = -2i$],
  ),
  pass: [Continue with #goto-first(<st-which>).],
  fail: [Find the example or exercise that matches your mistake and redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════
#print-check-key()

#print-hints()
#print-vocab()
