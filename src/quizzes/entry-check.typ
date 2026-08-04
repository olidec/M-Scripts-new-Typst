// ============================================================
//  entry-check.typ — Entry Check, first week of year 1
//
//  Compile directly (no --root needed, no preamble dependency):
//      typst compile entry-check.typ entry-check.pdf
//  Set ANSWERS to true below and recompile for the key:
//      typst compile entry-check.typ entry-check-key.pdf
//
//  DESIGN NOTE — this sheet is calibrated against the Lehrplan
//  Volksschule Basel-Landschaft, 3. Zyklus (Sek I), at the E/P
//  Treffpunkt level, NOT against our own Lehrplan. Every item is
//  something the incoming students were formally taught. Nothing
//  here is new. That is the whole point: the sheet measures what
//  survived the summer, so the score is readable as "where I am"
//  rather than "what I have not learned yet."
//
//  It is ungraded and unrecorded, and it says so on the sheet.
//
//  ITEM LABELS ARE LOAD-BEARING. progress-check.typ is
//  item-for-item isomorphic to this file: A1 there tests exactly
//  what A1 tests here, with different numbers. If you add, drop or
//  re-scope an item, do the same in the other file, or the
//  September/October comparison stops meaning anything.
// ============================================================

#import "quiz-common.typ": *

#set-answers(false) // ← true for the answer key
// #set-answers(true) // ← true for the answer key

#show: quiz-template.with(
  title: "Entry Check",
  subtitle: "Where do you stand right now? — ungraded, unrecorded, 30 minutes",
)

#instructions[
  *This is not an exam.* Nobody records the result, it counts for
  nothing, and you hand nothing in. You mark it yourself next lesson.
  The only purpose is to give you — and me — an honest picture of what
  you are bringing along from Sek, so that neither of us spends the
  year guessing.

  - Everything here was on your Sek I syllabus. Nothing is new.
  - *No calculator.* The numbers are chosen to be workable by hand.
  - Work in pen or pencil directly on this sheet. Show enough that you
    can reconstruct your thinking later.
  - About 30 minutes. If an item stalls you for more than two minutes,
    leave it and move on — a blank is useful information too, and much
    more useful than a rushed guess.
  - Keep this sheet. In about four weeks you will do a parallel version
    and compare the two.
]

#v(6pt)

#formula-box[
  Cylinder: $V = pi r^2 dot h$ #h(1.2cm)
  Cone: $V = 1/3 pi r^2 dot h$ #h(1.2cm)
  Sphere: $V = 4/3 pi r^3$ #h(1.2cm)
  Circle: $A = pi r^2$, #h(3pt) $C = 2 pi r$
]

// ────────────────────────────────────────────────────────────
#part(
  "0",
  "Mathematical English",
  minutes: 3,
  note: [Draw a line from each English term to its German equivalent. This is a language check, not a math check —
    lessons, exercises and exams all run in English.],
)

#vocab-match(
  en: (
    "numerator",
    "denominator",
    "slope",
    "to expand",
    "to factor",
    "square root",
    "ratio",
    [$y$\u{2011}intercept],
  ),
  de: (
    "Verhältnis",
    "Nenner",
    "ausklammern",
    "Steigung",
    "Quadratwurzel",
    "Zähler",
    "y-Achsenabschnitt",
    "ausmultiplizieren",
  ),
  key: [1 — F #h(8pt) 2 — B #h(8pt) 3 — D #h(8pt) 4 — H #h(8pt)
    5 — C #h(8pt) 6 — E #h(8pt) 7 — A #h(8pt) 8 — G],
)

// ────────────────────────────────────────────────────────────
#part("A", "Numbers, powers and roots", minutes: 5)

#q("A1", 1, 1.8cm)[
  Compute exactly. Give the result as a fraction in lowest terms.
  $ 3/4 + 2/3 dot 9/10 $
][
  $2/3 dot 9/10 = 18/30 = 3/5$, then $3/4 + 3/5 = 15/20 + 12/20 = 27/20$.
]

#q("A2", 1, 1.5cm)[
  Compute. Watch the signs and the order of operations.
  $ -2^4 + (-3)^2 dot 2 $
][
  $-2^4 = -16$ (the exponent binds tighter than the minus sign),
  $(-3)^2 = 9$, so $-16 + 9 dot 2 = -16 + 18 = 2$.
]

#q("A3", 1, 1.5cm)[
  Simplify to a single term with a positive exponent.
  $ (2a^3)^2 dot a^(-5) $
][
  $(2a^3)^2 = 4a^6$, and $4a^6 dot a^(-5) = 4a^(6-5) = 4a$.
]

#q("A4", 1, 1.5cm)[
  Compute and give the answer in scientific notation.
  $ ((3 dot 10^8) dot (4 dot 10^(-5)))/(6 dot 10^2) $
][
  Numerator $= 12 dot 10^3$. Then $(12 dot 10^3)/(6 dot 10^2)
  = 2 dot 10^1 = 20$.
]

// ────────────────────────────────────────────────────────────
#part("B", "Terms and equations", minutes: 8)

#q("B1", 1, 2.0cm)[
  Expand and simplify.
  $ (2x - 5)^2 - (x + 3) dot (x - 3) $
][
  $(2x-5)^2 = 4x^2 - 20x + 25$ and $(x+3)(x-3) = x^2 - 9$, so the
  difference is $3x^2 - 20x + 34$.
]

#q("B2", 1, 1.4cm)[
  Factor completely.
  $ 3a^2 - 12 $
][
  Common factor first: $3(a^2 - 4) = 3 dot (a - 2) dot (a + 2)$.
]

#q("B3", 1, 2.2cm)[
  Solve for $x$.
  $ (x - 4)/3 + 2 = (x + 1)/2 $
][
  Multiply by 6: $2 dot (x-4) + 12 = 3 dot (x+1)$, so $2x + 4 = 3x + 3$ and
  $x = 1$.
]

#q("B4", 1, 1.8cm)[
  Solve by factoring — the quadratic formula is not needed here.
  $ x^2 + 2x - 15 = 0 $
][
  $(x + 5) dot (x - 3) = 0$, so $x = -5$ or $x = 3$.
]

#q("B5", 1, 2.4cm)[
  Solve the system.
  $ #system(($3x + 2y$, $16$), ($x - y$, $2$)) $
][
  From the second equation $x = y + 2$. Substituting:
  $3 dot (y+2) + 2y = 16 arrow.r 5y = 10 arrow.r y = 2$, hence $x = 4$.
]

// ────────────────────────────────────────────────────────────
#part("C", "Proportional reasoning, percent, units", minutes: 5)

#q("C1", 1, 1.8cm)[
  After a 25% discount, a jacket costs CHF 180. What was the price
  before the discount?
][
  CHF 180 is 75% of the original price: $180 slash 0.75 = 240$.
  The original price was CHF 240.
]

#q("C2", 1, 1.6cm)[
  Four identical pumps empty a basin in 9 hours. How long would six
  such pumps need?
][
  Inverse proportion: $4 dot 9 = 36$ pump-hours, so
  $36 slash 6 = 6$ hours.
]

#q("C3", 2, 1.8cm)[
  A train covers 45 km in 20 minutes. Give its average speed
  (a) in km/h, (b) in m/s.
][
  (a) $45 slash (1/3) = 135$ km/h. #h(6pt)
  (b) $45000$ m in $1200$ s gives $37.5$ m/s.
]

// ────────────────────────────────────────────────────────────
#part("D", "Functions and graphs", minutes: 6)

#q("D1", 2, 0pt)[
  Read the line off the grid: state its slope, its
  $y$\u{2011}intercept, and its equation.

  #coord-grid(
    xmin: -1,
    xmax: 5,
    ymin: -2,
    ymax: 6,
    lines: ((1.5, -1),),
  )
][
  It passes through $(0, -1)$ and $(2, 2)$, so the slope is
  $3 slash 2$ and the $y$\u{2011}intercept is $-1$:
  $ y = 3/2 x - 1. $
]

#q("D2", 2, 1.8cm)[
  Let $f(x) = -2x + 7$.
  (a) Compute $f(-3)$. #h(6pt) (b) For which $x$ is $f(x) = 0$?
][
  (a) $f(-3) = 6 + 7 = 13$. #h(6pt)
  (b) $-2x + 7 = 0 arrow.r x = 3.5$.
]

#q("D3", 1, 2.0cm)[
  Where do the lines $y = 2x - 1$ and $y = -x + 5$ meet?
][
  $2x - 1 = -x + 5 arrow.r 3x = 6 arrow.r x = 2$, and then $y = 3$.
  They meet at $(2, 3)$.
]

#q("D4", 2, 1.8cm)[
  The table shows a linear, a quadratic or an exponential
  relationship. Which one is it, and what is the rule?

  #align(center, table(
    columns: 5,
    stroke: 0.4pt + luma(170),
    inset: (x: 8pt, y: 3pt),
    [$x$], [0], [1], [2], [3],
    [$y$], [3], [6], [12], [24],
  ))
][
  Each step multiplies $y$ by 2, so the growth is *exponential*:
  $y = 3 dot 2^x$.
]

// ────────────────────────────────────────────────────────────
#part("E", "Geometry", minutes: 6)

#q("E1", 2, 1.8cm)[
  A right triangle has legs of 9 cm and 12 cm.
  (a) How long is the hypotenuse? #h(6pt) (b) What is its area?
][
  (a) $sqrt(9^2 + 12^2) = sqrt(225) = 15$ cm. #h(6pt)
  (b) $(9 dot 12) slash 2 = 54$ cm#super[2].
]

#q("E2", 1, 1.5cm)[
  A cylinder has radius 5 cm and height 12 cm. Give its volume as an
  exact multiple of $pi$.
][
  $V = pi dot 5^2 dot 12 = 300 pi$ cm#super[3] (about 942 cm#super[3]).
]

#q("E3", 2, 1.8cm)[
  A triangle has all three vertices on a circle, and one of its sides
  is a diameter. One of the other two angles measures $35 degree$.
  Find the remaining two angles, and name the theorem you used.
][
  Thales' theorem: the angle opposite the diameter is $90 degree$.
  The third angle is $180 degree - 90 degree - 35 degree = 55 degree$.
]

#q("E4", 1, 1.6cm)[
  The volume of a cone is $V = 1/3 pi r^2 dot h$. Solve this formula
  for $h$.
][
  $h = (3V)/(pi r^2)$.
]

// ────────────────────────────────────────────────────────────
#part("F", "Data and chance", minutes: 2)

#q("F1", 1, 2.0cm)[
  A bag holds 3 red and 5 blue marbles. You draw two marbles without
  putting the first one back. What is the probability that both are
  red?
][
  $3/8 dot 2/7 = 6/56 = 3/28 approx 10.7%$.
]

#pagebreak()

// ────────────────────────────────────────────────────────────
= Marking your own sheet

#instructions[
  Give yourself the full points for a correct final answer, and half
  the points if the method was right but the arithmetic slipped. Be
  honest rather than kind — an inflated number here costs you nothing
  today and helps you not at all in December.
]

#v(6pt)

#self-check(
  total: 35,
  rows: (
    (
      "0",
      "Mathematical English",
      8,
      "Every lesson, every exercise, every exam runs in English.",
    ),
    (
      "A",
      "Exact arithmetic, exponent laws, scientific notation",
      4,
      "Feeds directly into algebra foundations, powers, exponentials, logarithms.",
    ),
    (
      "B",
      "Expanding, factoring, linear and quadratic equations, systems",
      5,
      "The single most load-bearing block of the whole first year.",
    ),
    (
      "C",
      "Percent, inverse proportion, compound units",
      4,
      "Turns up wherever we model a real situation, and again in statistics.",
    ),
    (
      "D",
      "Function values, slope, intercept, intersections, growth type",
      7,
      "The functions strand runs from October of year 1 to the Matura.",
    ),
    (
      "E",
      "Pythagoras, solids, angles, rearranging a formula",
      6,
      "Foundation for trigonometry and later for vectors.",
    ),
    (
      "F",
      "Multi-stage random experiments",
      1,
      "Picked up properly in the stochastics unit in year 2.",
    ),
  ),
)

#v(8pt)

#bands[
  *Reading your total (out of 35)* — these bands describe a starting
  position, not a ceiling. Every one of them is a normal place to
  start, and the distance between the bottom band and the top one is
  a few weeks of deliberate work, not a fact about you.

  - *28–35* — Your Sek foundation is intact. Spend your effort on the
    new material rather than on repair work.
  - *21–27* — Solid, with specific holes. Look at which *parts* cost
    you the points, not at the total; two or three targeted evenings
    close a gap like this.
  - *14–20* — Several foundations need active repair, and they need it
    now rather than in November, because Part B in particular is what
    the next three chapters are built on. Come and talk to me.
  - *below 14* — This says the summer was long, or that some of this
    never fully landed the first time. Either way it is fixable and I
    would rather know in week 1 than in week 12. Come and talk to me.

  Now do one concrete thing: circle the *two* parts where you lost the
  most points. Those two are your work list until the progress check.
]

#v(6pt)

#block(
  width: 100%,
  inset: (left: 12pt, right: 10pt, top: 7pt, bottom: 7pt),
  radius: 3pt,
  fill: ahead-bg,
  stroke: (left: 3pt + ahead-col),
)[
  *In about four weeks* you will get a parallel sheet — same structure,
  same skills, different numbers — plus a short section on what we will
  have covered by then. Keep this one so you can put the two side by
  side. The comparison is the actual point of the exercise; a single
  snapshot tells you much less than a direction of travel.
]
