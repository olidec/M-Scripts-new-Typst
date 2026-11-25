// ch-eq-numeric.typ — Numerical Solutions (equations booklet)
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
#show: chapter-template.with(title: "Numerical Solutions")
#let ex = exercise.with(chapter: "Equations")
#let check = check.with(ex: ex)

= Numerical Solutions

#todo[chapter introduction: why this family of equations matters; how it connects to the regular units]

#objectives(
  [Show by a sign change that a solution exists],
  [Use bisection and Newton steps],
  [Count solutions with a sketch],
)

// ════════════════════════════════════════════════════════
== When There Is No Algebraic Solution <st-numeric>

#check(
  "When There Is No Algebraic Solution",
  (
    [Does $x^3 + x - 1 = 0$ have a solution between $0$ and $1$? Why?],
    [Bisection for $f(x) = x^2 - 2$ on $[1, 2]$: which interval is next?],
    [Newton's method for $f(x) = x^2 - 2$ with $x_0 = 1$: find $x_1$.],
    [How many real solutions does $e^x = 3x$ have? (Sketch both graphs.)],
  ),
  (
    [Yes: $f(0) = -1 < 0$ and $f(1) = 1 > 0$ (sign change)],
    [$[1, 1.5]$, since $f(1.5) = 0.25 > 0$],
    [$x_1 = 1.5$],
    [Two ($x approx 0.62$ and $x approx 1.51$)],
  ),
  pass: [Skip to the checkpoint in #goto-first(<st-cplx>, <st-which>).],
  fail: [Work through this section.],
)

#todo[theory and worked examples for “When There Is No Algebraic Solution”: vocab(), keybox, warning() for the misconceptions above]

#todo[exercises for “When There Is No Algebraic Solution”, ramped from difficulty 1 to 3, with an error-analysis task (three students, at least one correct)]

#todo[“Check with your calculator” block, written twice and gated. only-basic: num-solv with several start values. only-high: nSolve(…, x) with a start value or interval; compare with the graph. (VERIFY on device)]

#check(
  kind: "Stage check",
  "When There Is No Algebraic Solution",
  (
    [Does $x^3 - x - 1 = 0$ have a solution between $1$ and $2$? Why?],
    [Bisection for $f(x) = x^3 - 5$ on $[1, 2]$: which interval is next?],
    [Newton's method for $f(x) = x^2 - 5$ with $x_0 = 2$: find $x_1$.],
    [How many real solutions does $ln(x) = 2 - x$ have? (Sketch both graphs.)],
  ),
  (
    [Yes: $f(1) = -1 < 0$ and $f(2) = 5 > 0$ (sign change)],
    [$[1.5, 2]$, since $f(1.5) = -1.625 < 0$],
    [$x_1 = 2.25$],
    [One ($x approx 1.56$)],
  ),
  pass: [Continue with #goto-first(<st-cplx>, <st-which>).],
  fail: [Find the example or exercise that matches your mistake and redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════
#print-check-key()

#print-hints()
#print-vocab()
