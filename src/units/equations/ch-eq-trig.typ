// ch-eq-trig.typ — Trigonometric Equations (equations booklet)
//
// SKELETON (Turn 1). Stage headings, labels, objectives, all
// checkpoints and stage checks with verified answers, and todo[…]
// placeholders for theory and practice.
//
// TARGET MISCONCEPTIONS (see stage notes)
//   Trigonometric Equations: M4 one trig solution only; M10 DEG/RAD mode
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
#show: chapter-template.with(title: "Trigonometric Equations")
#let ex = exercise.with(chapter: "Equations")
#let check = check.with(ex: ex)

= Trigonometric Equations

#todo[chapter introduction: why this family of equations matters; how it connects to the regular units]

#objectives(
  [Find all solutions in an interval, using the calculator first value and the unit circle],
  [Choose degrees or radians correctly and set the calculator mode],
)

// ════════════════════════════════════════════════════════
== Trigonometric Equations <st-trig>

#check(
  "Trigonometric Equations",
  (
    [Solve $sin(x) = 1/2$ for $0 degree <= x < 360 degree$.],
    [Solve $cos(x) = -1/2$ for $0 degree <= x < 360 degree$.],
    [Solve $tan(x) = 1$ for $0 degree <= x < 360 degree$.],
    [Solve $sin(x) = 2$.],
  ),
  (
    [$x = 30 degree$ or $x = 150 degree$],
    [$x = 120 degree$ or $x = 240 degree$],
    [$x = 45 degree$ or $x = 225 degree$],
    [No real solution],
  ),
  pass: [Skip to the checkpoint in #goto-first(<st-poly>).],
  fail: [Work through this section.],
)

#todo[theory and worked examples for “Trigonometric Equations”: vocab(), keybox, warning() for the misconceptions above]

#todo[exercises for “Trigonometric Equations”, ramped from difficulty 1 to 3, with an error-analysis task (three students, at least one correct)]

#todo[“Check with your calculator” block, written twice and gated. only-basic: Calculator in DEG or RAD mode as needed; num-solv returns ONE solution near the start value. only-high: solve(… , x) | 0≤x\<2·π compared with solve(…, x) (general solution); check the angle mode. (VERIFY on device)]

#check(
  kind: "Stage check",
  "Trigonometric Equations",
  (
    [Solve $sin(x) = sqrt(3)/2$ for $0 <= x < 2 pi$ (radians).],
    [Solve $cos(x) = 0$ for $0 <= x < 2 pi$ (radians).],
    [Solve $tan(x) = -1$ for $0 <= x < 2 pi$ (radians).],
    yr([Your calculator is in DEG mode and gives $sin^(-1)(0.8) approx 53.13 degree$. Give all solutions of $sin(x) = 0.8$ for $0 degree <= x < 360 degree$.], [Give all real solutions of $sin(x) = 1/2$ (general solution, with $k in ZZ$).]),
  ),
  (
    [$x = pi/3$ or $x = (2 pi)/3$],
    [$x = pi/2$ or $x = (3 pi)/2$],
    [$x = (3 pi)/4$ or $x = (7 pi)/4$],
    yr([$x approx 53.13 degree$ or $x approx 126.87 degree$], [$x = pi/6 + k dot 2 pi$ or $x = (5 pi)/6 + k dot 2 pi$]),
  ),
  pass: [Continue with #goto-first(<st-poly>).],
  fail: [Find the example or exercise that matches your mistake and redo it. If the check still goes wrong, ask your teacher.],
)

// ════════════════════════════════════════════════════════
#print-check-key()

#print-hints()
#print-vocab()
