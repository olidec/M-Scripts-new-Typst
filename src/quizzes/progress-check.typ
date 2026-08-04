// ============================================================
//  progress-check.typ — Progress Check, about four weeks in
//
//  Compile directly:
//      typst compile progress-check.typ progress-check.pdf
//  Answer key:  set ANSWERS to true below and recompile.
//
//  ITEM-FOR-ITEM ISOMORPHIC TO entry-check.typ. A1 here tests
//  exactly the skill A1 tests there, with different numbers; same
//  for every other item, and the point values are identical part by
//  part. That is what makes "September vs. now" a meaningful
//  comparison rather than two unrelated scores. If you edit one
//  file, edit the other.
//
//  The one deliberate asymmetry is Part G. Parts 0–F are the
//  comparison (35 points, exactly as in September); Part G is new
//  material from the first weeks of the course and is scored
//  SEPARATELY so it cannot contaminate the comparison.
//
//  PART G IS THE PART TO ADJUST. It is written against the standard
//  content of ch-algebra-foundations — rational equations with
//  domain restrictions, simplifying rational expressions, linear
//  inequalities with a solution set. Swap in whatever you actually
//  reached; keep it to three items so the timing holds.
// ============================================================

#import "quiz-common.typ": *

#set-answers(false) // ← true for the answer key

#show: quiz-template.with(
  title: "Progress Check",
  subtitle: "Same skills, four weeks later — ungraded, unrecorded, 35 minutes",
)

#instructions[
  *Still not an exam.* Nothing is recorded and nothing is handed in.

  Parts 0 to F test exactly the same skills as the Entry Check you did
  in the first week, item for item, with different numbers. Part G
  covers material from the last few weeks and is scored separately.

  - *No calculator*, same as last time.
  - About 35 minutes. Same rule as before: two minutes on an item, then
    move on.
  - *Bring out your Entry Check sheet when you mark this one.* Comparing
    the two is the entire point. A single score tells you where you are;
    two scores tell you which way you are moving, which is the more
    useful of the two facts.
]

#v(6pt)

#formula-box[
  Cylinder: $V = pi r^2 dot h$ #h(1.2cm)
  Cone: $V = 1/3 pi r^2 dot h$ #h(1.2cm)
  Sphere: $V = 4/3 pi r^3$ #h(1.2cm)
  Trapezoid: $A = (a + c)/2 dot h$
]

// ────────────────────────────────────────────────────────────
#part(
  "0",
  "Mathematical English",
  minutes: 3,
  note: [Match each English term to its German equivalent. Write the
    letter in the box. Different words from last time — same question:
    can you follow a lesson in English without translating first?],
)

#vocab-match(
  en: (
    "sum",
    "product",
    "exponent",
    "to simplify",
    "inequality",
    "cube root",
    "average (mean)",
    "zero (of a function)",
  ),
  de: (
    "Ungleichung",
    "Nullstelle",
    "Summe",
    "Exponent",
    "Mittelwert",
    "dritte Wurzel",
    "Produkt",
    "vereinfachen",
  ),
  key: [1 — C #h(8pt) 2 — G #h(8pt) 3 — D #h(8pt) 4 — H #h(8pt)
    5 — A #h(8pt) 6 — F #h(8pt) 7 — E #h(8pt) 8 — B],
)

// ────────────────────────────────────────────────────────────
#part("A", "Numbers, powers and roots", minutes: 5)

#q("A1", 1, 1.8cm)[
  Compute exactly. Give the result as a fraction in lowest terms.
  $ 5/6 + 3/4 dot 8/9 $
][
  $3/4 dot 8/9 = 24/36 = 2/3$, then $5/6 + 2/3 = 5/6 + 4/6 = 9/6 = 3/2$.
]

#q("A2", 1, 1.5cm)[
  Compute. Watch the signs and the order of operations.
  $ -3^2 + (-2)^3 dot (-1) $
][
  $-3^2 = -9$ (the exponent binds tighter than the minus sign),
  $(-2)^3 = -8$, so $-9 + (-8) dot (-1) = -9 + 8 = -1$.
]

#q("A3", 1, 1.5cm)[
  Simplify to a single term with a positive exponent.
  $ (3b^4)^2 dot b^(-7) $
][
  $(3b^4)^2 = 9b^8$, and $9b^8 dot b^(-7) = 9b^(8-7) = 9b$.
]

#q("A4", 1, 1.5cm)[
  Compute and give the answer in scientific notation.
  $ ((2 dot 10^(-3)) dot (9 dot 10^7))/(3 dot 10^2) $
][
  Numerator $= 18 dot 10^4$. Then $(18 dot 10^4)/(3 dot 10^2)
  = 6 dot 10^2 = 600$.
]

// ────────────────────────────────────────────────────────────
#part("B", "Terms and equations", minutes: 8)

#q("B1", 1, 2.0cm)[
  Expand and simplify.
  $ (3x + 4)^2 - (2x - 1) dot (2x + 1) $
][
  $(3x+4)^2 = 9x^2 + 24x + 16$ and $(2x-1)(2x+1) = 4x^2 - 1$, so the
  difference is $5x^2 + 24x + 17$.
]

#q("B2", 1, 1.4cm)[
  Factor completely.
  $ 5a^2 - 45 $
][
  Common factor first: $5(a^2 - 9) = 5 dot (a - 3) dot (a + 3)$.
]

#q("B3", 1, 2.2cm)[
  Solve for $x$.
  $ (x + 2)/4 - 1 = (x - 6)/3 $
][
  Multiply by 12: $3 dot (x+2) - 12 = 4 dot (x-6)$, so $3x - 6 = 4x - 24$
  and $x = 18$.
]

#q("B4", 1, 1.8cm)[
  Solve by factoring — the quadratic formula is not needed here.
  $ x^2 - 3x - 10 = 0 $
][
  $(x - 5) dot (x + 2) = 0$, so $x = 5$ or $x = -2$.
]

#q("B5", 1, 2.4cm)[
  Solve the system.
  $ #system(($2x + 3y$, $16$), ($x - y$, $3$)) $
][
  From the second equation $x = y + 3$. Substituting:
  $2 dot (y+3) + 3y = 16 arrow.r 5y = 10 arrow.r y = 2$, hence $x = 5$.
]

// ────────────────────────────────────────────────────────────
#part("C", "Proportional reasoning, percent, units", minutes: 5)

#q("C1", 1, 1.8cm)[
  After a 20% price increase, a bicycle costs CHF 660. What was the
  price before the increase?
][
  CHF 660 is 120% of the original price: $660 slash 1.2 = 550$.
  The original price was CHF 550.
]

#q("C2", 1, 1.6cm)[
  Six workers need 10 days to finish a job. How long would four
  workers need, working at the same rate?
][
  Inverse proportion: $6 dot 10 = 60$ worker-days, so
  $60 slash 4 = 15$ days.
]

#q("C3", 2, 1.8cm)[
  A cyclist covers 18 km in 40 minutes. Give the average speed
  (a) in km/h, (b) in m/s.
][
  (a) $18 slash (2/3) = 27$ km/h. #h(6pt)
  (b) $18000$ m in $2400$ s gives $7.5$ m/s.
]

// ────────────────────────────────────────────────────────────
#part("D", "Functions and graphs", minutes: 6)

#q("D1", 2, 0pt)[
  Read the line off the grid: state its slope, its
  $y$\u{2011}intercept, and its equation.

  #coord-grid(
    xmin: -1,
    xmax: 5,
    ymin: -3,
    ymax: 6,
    lines: ((-1.5, 4),),
  )
][
  It passes through $(0, 4)$ and $(2, 1)$, so the slope is
  $-3 slash 2$ and the $y$\u{2011}intercept is $4$:
  $ y = -3/2 x + 4. $
]

#q("D2", 2, 1.8cm)[
  Let $g(x) = 3x - 12$.
  (a) Compute $g(-2)$. #h(6pt) (b) For which $x$ is $g(x) = 0$?
][
  (a) $g(-2) = -6 - 12 = -18$. #h(6pt)
  (b) $3x - 12 = 0 arrow.r x = 4$.
]

#q("D3", 1, 2.0cm)[
  Where do the lines $y = -2x + 9$ and $y = x - 3$ meet?
][
  $x - 3 = -2x + 9 arrow.r 3x = 12 arrow.r x = 4$, and then $y = 1$.
  They meet at $(4, 1)$.
]

#q("D4", 2, 1.8cm)[
  The table shows a linear, a quadratic or an exponential
  relationship. Which one is it, and what is the rule?

  #align(center, table(
    columns: 5,
    stroke: 0.4pt + luma(170),
    inset: (x: 8pt, y: 3pt),
    [$x$], [0], [1], [2], [3],
    [$y$], [5], [15], [45], [135],
  ))
][
  Each step multiplies $y$ by 3, so the growth is *exponential*:
  $y = 5 dot 3^x$.
]

// ────────────────────────────────────────────────────────────
#part("E", "Geometry", minutes: 6)

#q("E1", 2, 1.8cm)[
  A right triangle has legs of 8 cm and 15 cm.
  (a) How long is the hypotenuse? #h(6pt) (b) What is its area?
][
  (a) $sqrt(8^2 + 15^2) = sqrt(289) = 17$ cm. #h(6pt)
  (b) $(8 dot 15) slash 2 = 60$ cm#super[2].
]

#q("E2", 1, 1.5cm)[
  A cylinder has radius 4 cm and height 9 cm. Give its volume as an
  exact multiple of $pi$.
][
  $V = pi dot 4^2 dot 9 = 144 pi$ cm#super[3] (about 452 cm#super[3]).
]

#q("E3", 2, 1.8cm)[
  A triangle has all three vertices on a circle, and one of its sides
  is a diameter. One of the other two angles measures $28 degree$.
  Find the remaining two angles, and name the theorem you used.
][
  Thales' theorem: the angle opposite the diameter is $90 degree$.
  The third angle is $180 degree - 90 degree - 28 degree = 62 degree$.
]

#q("E4", 1, 1.6cm)[
  The area of a trapezoid is $A = (a + c)/2 dot h$. Solve this formula
  for $a$.
][
  $a + c = (2A)/h$, so $a = (2A)/h - c$.
]

// ────────────────────────────────────────────────────────────
#part("F", "Data and chance", minutes: 2)

#q("F1", 1, 2.0cm)[
  A bag holds 4 green and 6 yellow marbles. You draw two marbles
  without putting the first one back. What is the probability that
  both are green?
][
  $4/10 dot 3/9 = 12/90 = 2/15 approx 13.3%$.
]

// ────────────────────────────────────────────────────────────
#part(
  "G",
  "Since the start of the year",
  minutes: 6,
  note: [New material — not part of the September comparison. Score it
    separately.],
)

#q("G1", 2, 2.4cm)[
  Solve for $x$, and state which values $x$ is not allowed to take.
  $ 5/(x - 2) = 3/(x + 1) $
][
  Restrictions: $x eq.not 2$ and $x eq.not -1$.
  Cross-multiplying, $5 dot (x + 1) = 3 dot (x - 2) arrow.r 5x + 5 = 3x - 6
  arrow.r 2x = -11 arrow.r x = -11/2$. This is allowed, so
  $L = {-11/2}$.
]

#q("G2", 2, 2.2cm)[
  Simplify as far as possible, and state the restrictions on $x$.
  $ (x^2 - 9)/(x^2 + 5x + 6) $
][
  $((x-3) dot (x+3))/((x+2) dot (x+3)) = (x - 3)/(x + 2)$,
  for $x eq.not -3$ and $x eq.not -2$.
]

#q("G3", 2, 2.0cm)[
  Solve the inequality and give the solution set.
  $ -3 dot (x - 2) >= 12 $
][
  $-3x + 6 >= 12 arrow.r -3x >= 6$. Dividing by $-3$ *reverses* the
  inequality: $x <= -2$, so $L = {x in RR | x <= -2}$.
]

#pagebreak()

// ────────────────────────────────────────────────────────────
= Marking your own sheet

#instructions[
  Same rule as in September: full points for a correct final answer,
  half if the method was right but the arithmetic slipped.

  Fill in *both* columns — your September score from the Entry Check
  sheet, and today's. Score Part G separately underneath.
]

#v(6pt)

#self-check(
  compare: true,
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

#block(
  width: 100%,
  fill: accent-bg,
  radius: 3pt,
  inset: (left: 12pt, right: 10pt, top: 7pt, bottom: 7pt),
  stroke: (left: 3pt + accent),
)[
  *Part G — new material, scored on its own:* #h(0.4cm)
  #box(width: 1.4cm, stroke: (bottom: 0.5pt + luma(120))) / 6
]

#v(8pt)

#bands[
  *Reading the two columns.* The number that matters is the
  *difference*, not the total.

  - *Up by 5 or more* — the repair work is working. Keep doing whatever
    you have been doing.
  - *Up by 1 to 4* — real movement. Check *which* parts moved: gains
    concentrated in one part while another stayed flat usually means
    the flat one never actually got worked on.
  - *Roughly unchanged* — no cause for alarm on its own, but four weeks
    have passed. Pick one part, name one specific thing you will do
    about it this week, and write it down at the bottom of this page.
  - *Down* — this happens, and the usual cause is not "getting worse."
    It is that four weeks of new material crowded out the old, or that
    today was simply a bad day. Compare item by item rather than
    total to total, and come and talk to me.

  *Part G separately:* Part G is the first honest look at the new
  material. A low score here four weeks in is a signal to act, not a
  verdict — nothing in Part G has been examined yet, and everything in
  it will come round again.
]

#v(10pt)

#block(
  width: 100%,
  inset: (left: 12pt, right: 10pt, top: 7pt, bottom: 7pt),
  radius: 3pt,
  fill: ahead-bg,
  stroke: (left: 3pt + ahead-col),
)[
  *One thing I will do about it this week:*
  #v(0.5cm)
  #line(length: 100%, stroke: 0.4pt + luma(160))
  #v(0.5cm)
  #line(length: 100%, stroke: 0.4pt + luma(160))
]
