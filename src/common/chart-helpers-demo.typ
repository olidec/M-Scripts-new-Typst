// Compile-test for the statistical chart helpers.
//
// Drop this next to preamble.typ (src/common/) and compile it
// directly -- it is a scratch file, not part of any unit, so it does
// not need set-subject-name / set-level / chapter-template:
//
//   typst compile --root . src/common/chart-helpers-demo.typ
//
// Every number in the "published value" column comes from the
// textbook's own worked solutions or from the old LaTeX script, so
// any mismatch in the computed column is a bug in the helpers, not a
// judgment call.

#import "preamble.typ": *

#set page(paper: "a4", margin: 1.8cm)
#set text(size: 10pt)

= Chart helper compile-test

// ── datasets ────────────────────────────────────────────────
#let script-data = (
  54,
  37,
  57,
  50,
  58,
  39,
  41,
  49,
  51,
  52,
  13,
  40,
  40,
  53,
  38,
  39,
  47,
  24,
  51,
  41,
)
#let antonia = (9.5, 11, 9, 10, 10.5)
#let lars = (13, 7, 6, 15, 9)
#let snakes = (84, 79, 90, 73, 95, 88, 92, 81, 67)
#let travel = (12, 9, 23, 10, 10, 8, 35, 9, 2, 14)
#let sick-a = (0, 0, 0, 0) + (1,) * 8 + (2, 2, 2) + (3,) * 6 + (4, 4) + (5, 5)
#let sprint = (9.9, 10.4, 10.6, 10.0, 9.9, 10.1, 9.8)

== 1. Numeric summaries against published answers

#table(
  columns: 3,
  stroke: 0.5pt + luma(180),
  inset: 5pt,
  [*Quantity*], [*Computed*], [*Published*],

  [script mean], [#stat-num(mean-of(script-data))], [43.7],
  [script median], [#stat-num(median-of(script-data))], [44],
  [script $Q_1$ / $Q_3$],
  [#stat-num(quartiles-of(script-data).q1) / #stat-num(quartiles-of(script-data).q3)],
  [39 / 51.5],

  [script IQR], [#stat-num(five-number(script-data).iqr)], [12.5],
  [script $s$ (with $n-1$)], [#stat-num(sample-sd-of(script-data))], [11.06],

  [script modes],
  [#mode-of(script-data).map(stat-num).join(", ")],
  [39, 40, 41, 51],

  [sprint mean], [#stat-num(mean-of(sprint))], [10.1],
  [sprint variance ($div n$)],
  [#stat-num(variance-of(sprint), digits: 3)],
  [0.074],

  [sprint $s$ ($div n$)],
  [#stat-num(sd-of(sprint), digits: 3)],
  [0.272 (book rounds first)],

  [Company A mean / $s$],
  [#stat-num(mean-of(sick-a)) / #stat-num(sd-of(sick-a))],
  [2 / 1.50],

  [Antonia mean / $s$],
  [#stat-num(mean-of(antonia)) / #stat-num(sd-of(antonia))],
  [10 / 0.7],

  [snakes $Q_1$ / med / $Q_3$],
  [#stat-num(five-number(snakes).q1) / #stat-num(five-number(snakes).med) /
    #stat-num(five-number(snakes).q3)],
  [76 / 84 / 91],
)

The two quartile conventions on $1, 2, dots, 9$ --- these *must*
disagree, that is the whole point of the warning box:

#let nine = (1, 2, 3, 4, 5, 6, 7, 8, 9)
- exclusive (house default) --- Q1 = #stat-num(quartiles-of(nine).q1),
  Q3 = #stat-num(quartiles-of(nine).q3)
- inclusive --- Q1 = #stat-num(quartiles-of(nine, method: "inclusive").q1),
  Q3 = #stat-num(quartiles-of(nine, method: "inclusive").q3)

== 2. Bar chart --- the truncated-axis lever

Identical data. The only difference between the two calls is `ymin`.

#image-grid(
  2,
  fig(
    bar-chart(
      ("Bernoulli", 306),
      ("Burckhardt", 305),
      ("Fibonacci", 300),
      ("Euler", 302),
      width: 5.5cm,
      height: 4cm,
      y-label: [points],
    ),
    caption: [`ymin: 0` --- four schools performing near-identically.],
  ),
  fig(
    bar-chart(
      ("Bernoulli", 306),
      ("Burckhardt", 305),
      ("Fibonacci", 300),
      ("Euler", 302),
      ymin: 299,
      width: 5.5cm,
      height: 4cm,
      y-label: [points],
    ),
    caption: [`ymin: 299` --- "best school twice as good as weakest."],
  ),
)

With per-bar colors and printed values:

#bar-chart(
  ("Hydro", 29.1),
  ("Solar", 1.2),
  ("Waste", 1.2),
  ("Biomass", 0.3),
  ("Wind", 0.1),
  colors: (accent, warn-col, def-col, ex-col, expl-col),
  show-values: true,
  width: 9cm,
  height: 4cm,
  y-label: [bn. kWh],
)

== 3. Histogram --- the bin-width investigation

Same 20 values three times; only `bins` changes. The first uses the
default, i.e. the $sqrt(n)$ rule.

#image-grid(
  3,
  fig(
    histogram(script-data, width: 4.6cm, height: 3.4cm),
    caption: [`bins: auto` ($approx sqrt(20) = 4$)],
  ),
  fig(
    histogram(script-data, bins: 2, width: 4.6cm, height: 3.4cm),
    caption: [`bins: 2` --- too coarse],
  ),
  fig(
    histogram(script-data, bins: 15, width: 4.6cm, height: 3.4cm),
    caption: [`bins: 15` --- too fine],
  ),
)

Fixed bin width with an explicit start, and the same distribution
entered as a frequency table instead of raw data --- these two should
render identically:

#image-grid(
  2,
  histogram(
    script-data,
    bin-width: 10,
    start: 10,
    width: 6cm,
    height: 3.6cm,
  ),
  histogram(
    counts: (
      (10, 20, 1),
      (20, 30, 1),
      (30, 40, 4),
      (40, 50, 6),
      (50, 60, 8),
    ),
    width: 6cm,
    height: 3.6cm,
  ),
)

== 4. Dotplot

Every observation individually visible --- nothing hidden by binning.

#dotplot(travel, width: 9cm, x-label: [travel time (min)])

== 5. Boxplot

Single series, Tukey whiskers. The lower whisker must stop at *24*
(the smallest value inside the fence), *not* at 13 and *not* at
the fence itself; 13 is drawn as an open outlier circle.

#boxplot(("Class 2a", script-data), width: 10cm, x-label: [score])

The same data under the textbook's min--max convention --- no outlier,
whisker runs all the way to 13:

#boxplot(
  ("Class 2a", script-data),
  whiskers: "minmax",
  width: 10cm,
  x-label: [score],
)

Two series sharing one axis --- the comparison use case:

#boxplot(
  ("Antonia", antonia),
  ("Lars", lars),
  width: 10cm,
  x-label: [training time (h)],
)

Summary-only form, for exercises that show a boxplot with no
underlying dataset:

#boxplot(
  ("Before", (min: 8, q1: 18, med: 24, q3: 31, max: 44)),
  ("After", (min: 20, q1: 34, med: 44, q3: 52, max: 66)),
  xmin: 0,
  xmax: 70,
  xstep: 10,
  width: 10cm,
  x-label: [points],
)

== 6. Scatter --- NOT one of the new helpers

scatter() comes from simple-plot, and its argument names are its own,
not ours. Re-enable this once the real signature is confirmed against
the installed package; the data below is Anscombe's first set, which
ch-two-variables will want anyway.

// #scatter(
//   (
//     (10, 8.04), (8, 6.95), (13, 7.58), (9, 8.81), (11, 8.33),
//     (14, 9.96), (6, 7.24), (4, 4.26), (12, 10.84), (7, 4.82),
//     (5, 5.68),
//   ),
//   ...
// )
