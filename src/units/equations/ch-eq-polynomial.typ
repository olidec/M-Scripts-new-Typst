// ch-eq-polynomial.typ — Polynomial Equations (equations booklet)
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
#show: chapter-template.with(title: "Polynomial Equations")
#let ex = exercise.with(chapter: "Equations")
#let check = check.with(ex: ex)

= Polynomial Equations

#todo[chapter introduction: why this family of equations matters; how it connects to the regular units]

#objectives(
  [Solve degree-3 and higher equations by factoring],
  [Use a known solution to reduce the degree],
  [Say how many real solutions are possible],
)

// ════════════════════════════════════════════════════════
== Equations of Degree 3 and Higher <st-poly>

#check(
  "Equations of Degree 3 and Higher",
  (
    [Solve $x^3 - 3x^2 - 4x + 12 = 0$.],
    [$x = 1$ is a solution of $x^3 - 6x^2 + 11x - 6 = 0$. Find all solutions.],
    [Solve $x^3 = 4x^2$.],
    [How many real solutions can an equation of degree $3$ have? Name all possibilities.],
  ),
  (
    [$x = -2$, $x = 2$, or $x = 3$],
    [$x = 1$, $x = 2$, or $x = 3$],
    [$x = 0$ or $x = 4$],
    [$1$, $2$, or $3$ (never $0$)],
  ),
  pass: [Skip to the checkpoint in #goto-first(<st-numeric>).],
  fail: [Work through this section.],
)

#todo[theory and worked examples for “Equations of Degree 3 and Higher”: vocab(), keybox, warning() for the misconceptions above]

#todo[exercises for “Equations of Degree 3 and Higher”, ramped from difficulty 1 to 3, with an error-analysis task (three students, at least one correct)]

#todo[“Check with your calculator” block, written twice and gated. only-basic: poly-solv, degree 3. only-high: solve, zeros, factor. (VERIFY on device)]

#check(
  kind: "Stage check",
  "Equations of Degree 3 and Higher",
  (
    [Solve $x^3 + x^2 - 9x - 9 = 0$.],
    [$x = 3$ is a solution of $x^3 - 7x - 6 = 0$. Find all solutions.],
    [Solve $x^3 - 5x^2 + 6x = 0$.],
    [How many real solutions does $x^3 + x = 0$ have?],
  ),
  (
    [$x = -3$, $x = -1$, or $x = 3$],
    [$x = -2$, $x = -1$, or $x = 3$],
    [$x = 0$, $x = 2$, or $x = 3$],
    [One: $x = 0$],
  ),
  pass: [Continue with #goto-first(<st-numeric>).],
  fail: [Find the example or exercise that matches your mistake and redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════
#print-check-key()

#print-hints()
#print-vocab()
