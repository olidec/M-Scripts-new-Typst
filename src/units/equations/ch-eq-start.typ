// ch-eq-start.typ — Equations: Practice and Review (equations booklet)
//
// SKELETON (Turn 1). Stage headings, labels, objectives, all
// checkpoints and stage checks with verified answers, and todo[…]
// placeholders for theory and practice.
//
// TARGET MISCONCEPTIONS (see stage notes)
//   (see the individual chapters)
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
#show: chapter-template.with(title: "Equations: Practice and Review")
#let ex = exercise.with(chapter: "Equations")
#let check = check.with(ex: ex)

= Equations: Practice and Review

#only-theory[
  Over four years you meet many kinds of equations. Each one comes with
  its own method, and each one has its own typical mistakes. This
  booklet runs alongside your regular units. It does not replace their
  theory. It gives you one place to practice every equation type, to
  check yourself honestly, and to learn to decide _which method fits_.
]

#objectives(
  [solve each type of equation you meet in the course],
  [check every solution by substitution, an estimate, or a sketch],
  [recognize an equation type and choose a method],
  [use your calculator to check a result, and read its output critically],
)

#keybox(title: "How to use this booklet")[
  You work at your own pace, and you skip what you already know.
  + Each section starts with a short *checkpoint*. Do it without help,
    then mark it yourself with the answers at the end of the chapter.
  + All correct, with your working written down? *Skip* ahead. Any
    mistake? Work through the section. It ends with a *stage check*.
  + Work only on the sections that your class has reached. The *Year*
    column shows when each topic is taught.
  + At the end of each year, use the *year review* to see what you can
    solve now.
]

#todo[how the booklet fits the regular units; what “Year” means in the table; where the year reviews are]

#progress-table(
  (<st-solve>, [What “solve” means], yr([1], [1])),
  (<st-rearr>, [Rearranging formulas], yr([1], [1])),
  (<st-product>, [Product equals zero], yr([1], [1])),
  (<st-quad>, [Quadratic equations], yr([1], [1])),
  (<st-subst>, [Substitution], yr([1], [1])),
  (<st-rational>, [Rational equations], yr([1], [1])),
  (<st-radical>, [Radical equations], yr([1], [1])),
  (<st-param>, [Equations with a parameter], yr([1], [1])),
  (<st-linsys>, [Linear systems], yr([1], [1])),
  (<st-nonlin>, [Nonlinear systems], yr([1], [1])),
  (<st-power>, [Power and root equations], yr([2], [1])),
  (<st-exp>, [Exponential equations], yr([2], [1])),
  (<st-log>, [Logarithmic equations], yr([2], [1])),
  (<st-trig>, [Trigonometric equations], yr([1], [1])),
  (<st-poly>, [Degree 3 and higher], yr([3], [2])),
  (<st-numeric>, [No algebraic solution], yr([3], [3])),
  (<st-cplx>, [Complex equations], yr([—], [3])),
  (<st-which>, [Which method?], yr([1–4], [1–4])),
  (<st-ineq>, [Inequalities (optional)], yr([1], [1])),
  (<st-abs>, [Absolute value (optional)], yr([1], [1])),
)
