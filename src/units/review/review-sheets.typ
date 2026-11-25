// review-sheets.typ — spiral review sheets, one page each (GLF + SPF).
//
// Short (~20 min) retrieval-practice sheets handed out over the year
// so that earlier topics keep coming back. Every sheet follows the
// same anatomy:
//   1. Recognize        — identify a type/form/method WITHOUT solving
//   2. Core skills      — short standard items, each from a different
//                         earlier topic (interleaved, never blocked)
//   3. Connect/critique — link two topics, or find the error
//   4. Self-check strip — confident / shaky / lost + what to revisit
//
// BUILD (from the project root):
//   typst compile --root . src/units/review/review-sheets.typ
//       → student sheets, both tracks
//   typst compile --root . --input key=true src/units/review/review-sheets.typ
//       → the same pages with the answer key filled in
//   add  --input track=glf   (or spf)  to print one track only
//
// SHEET IDs: <track letter><year><semester>-<n>
//   G2a-1 = GLF, year 2, 1st semester, sheet 1   (S… = SPF)
//
// ADDING A SHEET: copy any review-sheet(...) call below. task() takes
//   topic:      shown on the task AND in the self-check strip, so name
//               it as a TOPIC to revisit — never a chapter number
//   calculator: none | true ("CALC") | false ("NO CALC")
//   difficulty: 1–3 dots
// followed by [question][answer]. Every answer is verified in SymPy
// before it goes in.
//
// The helpers live here rather than in the preamble on purpose:
// exercise() starts a new page per exercise in sheet mode, which is
// the opposite of what a one-page review sheet needs. Promote task()
// and review-sheet() to the preamble only if a second file needs them.

#import "../../common/preamble.typ": *

#let show-key = sys.inputs.at("key", default: "false") == "true"
#let track-filter = sys.inputs.at("track", default: "all")

#let _track-info = (
  glf: (letter: "G", name: "Foundations"),
  spf: (letter: "S", name: "Advanced"),
)

#set page(
  paper: "a4",
  margin: (x: 2cm, top: 1.8cm, bottom: 1.8cm),
  numbering: none,
)
#show: apply-base-style


// ── Building blocks ──────────────────────────────────────────

// A task is plain data; review-sheet() decides how to draw it. That
// keeps the numbering and the self-check strip in sync automatically:
// both are generated from the same list.
#let task(
  topic: none,
  calculator: none,
  difficulty: 1,
  question,
  answer,
) = (
  topic: topic,
  calculator: calculator,
  difficulty: difficulty,
  question: question,
  answer: answer,
)

// Same look as the badge in exercise(): NO CALC is the loud state.
#let _calc-badge(calculator) = {
  if calculator == none { return none }
  let (tag, fg, bg) = if calculator {
    ("CALC", badge-col, none)
  } else {
    ("NO CALC", white, badge-col)
  }
  box(
    baseline: 15%,
    inset: (x: 4pt, y: 1.5pt),
    outset: (y: 1.5pt),
    radius: 2pt,
    fill: bg,
    stroke: 0.5pt + badge-col,
    text(size: 7pt, weight: "semibold", fill: fg, tracking: 0.4pt, tag),
  )
}

#let _dots(n) = {
  if n == 0 { return none }
  range(3)
    .map(i => box(baseline: 15%, circle(
      radius: 2.3pt,
      fill: if i < n { task-col } else { white },
      stroke: 0.6pt + task-col,
    )))
    .join(h(2.5pt))
}

// auto-parts() with explicit column widths, for when one item is much
// longer than the others: wide-parts((1fr, 1fr, 2fr), [..], [..], [..])
#let wide-parts(
  widths,
  ..items,
  row-gutter: 0.5em,
  column-gutter: 1.2em,
) = grid(
  columns: widths,
  row-gutter: row-gutter,
  column-gutter: column-gutter,
  ..items
    .pos()
    .enumerate()
    .map(((i, it)) => [(#"abcdefghijklmnopqrstuvwxyz".at(i)) #it]),
)

#let _tick-box = box(width: 0.75em, height: 0.75em, stroke: 0.5pt + luma(90))

#let _key-box(body) = block(
  width: 100%,
  fill: luma(245),
  inset: (x: 8pt, y: 6pt),
  stroke: (left: 2pt + luma(150)),
)[
  #text(size: 7pt, weight: "bold", fill: luma(110), tracking: 0.4pt)[KEY]
  #h(0.4em)
  #body
]


// ── The sheet ────────────────────────────────────────────────

#let review-sheet(
  track: "glf",
  term: "2a",
  number: 1,
  draws-on: (),
  ..items,
) = {
  if track-filter != "all" and track-filter != track { return }
  let info = _track-info.at(track)
  let id = info.letter + term + "-" + str(number)
  let tasks = items.pos()

  pagebreak(weak: true)

  // Header
  grid(
    columns: (1fr, auto),
    text(size: 14pt, weight: "bold", fill: task-col)[Spiral Review #id],
    align(right + bottom, text(fill: luma(100))[
      #info.name · about 20 min#if show-key [ · *Answer key*]
    ]),
  )
  v(-0.4em)
  line(length: 100%, stroke: 2.5pt + task-col)
  v(0.1em)
  text(size: 9pt, fill: luma(90))[*Draws on:* #draws-on.join(", ")]
  v(0.1em)
  block(text(size: 9pt, style: "italic", fill: luma(90))[
    Work in your notebook. Try every task from memory first — no notes,
    no searching. Only then check your answers and fill in the
    self-check at the bottom.
  ])

  // Tasks
  for (i, t) in tasks.enumerate() {
    v(0.6em)
    let tags = (_calc-badge(t.calculator), _dots(t.difficulty))
      .filter(x => x != none)
      .join(h(0.5em))
    block(width: 100%, breakable: false)[
      #grid(
        columns: (1fr, auto),
        [
          #text(weight: "bold", fill: task-col)[Task #(i + 1)]
          #h(0.5em)
          #text(size: 9pt, fill: luma(110))[#t.topic]
        ],
        align(right + horizon, tags),
      )
      #v(-0.5em)
      #line(length: 100%, stroke: 0.4pt + task-col)
      #v(-0.2em)
      #t.question
      #if show-key { _key-box(t.answer) }
    ]
  }

  // Self-check strip, pushed to the foot of the page
  v(1fr)
  block(width: 100%, breakable: false, {
    set text(size: 9pt)
    text(weight: "bold", fill: task-col, size: 11pt)[Self-check]
    h(0.5em)
    text(fill: luma(110))[After checking: how did each task go?]
    v(0.1em)
    table(
      columns: (auto, 1fr, auto, auto, auto),
      stroke: (x, y) => if y == 0 { (bottom: 0.6pt + task-col) } else {
        (bottom: 0.3pt + luma(200))
      },
      align: (x, y) => if x >= 2 { center + horizon } else {
        left + horizon
      },
      inset: (x: 6pt, y: 4pt),
      table.header(
        [*Task*], [*If shaky or lost, revisit*], [*confident*], [*shaky*],
        [*lost*],
      ),
      ..tasks
        .enumerate()
        .map(((i, t)) => (
          [#(i + 1)],
          t.topic,
          _tick-box,
          _tick-box,
          _tick-box,
        ))
        .flatten(),
    )
    text(style: "italic", fill: luma(110))[
      Anything shaky or lost: redo that task in about a week, without
      looking at your first attempt.
    ]
  })
}


// ════════════════════════════════════════════════════════════
//  GLF — YEAR 1, 1st SEMESTER (draws on the prerequisites from
//  secondary school: fractions, percentages, terms, variables,
//  and equations)
//  Focus: fractions as numbers, and abstraction -- letters as
//  numbers (not objects), terms as general statements, parameters
//  as "a number we have not fixed yet".
// ════════════════════════════════════════════════════════════

#review-sheet(
  track: "glf",
  term: "1a",
  number: 1,
  draws-on: (
    "fractions",
    "percentages",
    "terms and variables",
  ),

  task(topic: "Fractions: comparing and ordering", calculator: false)[
    Order from smallest to largest, without converting to decimals.
    Which one is closest to $1/2$?
    $ 3/4, quad 5/8, quad 2/3, quad 7/12 $
  ][
    Common denominator 24: $18/24, 15/24, 16/24, 14/24$. So
    $7/12 < 5/8 < 2/3 < 3/4$. Closest to $1/2 = 12/24$: $7/12$.
  ],

  task(topic: "Fractions: the four operations", calculator: false)[
    #auto-parts(
      4,
      [$2/3 + 1/4$],
      [$5/6 - 3/4$],
      [$3/5 dot 10/9$],
      [$3/4 div 9/8$],
    )
  ][
    #auto-parts(
      4,
      [$8/12 + 3/12 = 11/12$],
      [$10/12 - 9/12 = 1/12$],
      [$30/45 = 2/3$],
      [$3/4 dot 8/9 = 2/3$],
    )
  ],

  task(
    topic: "Fractions: what may be cancelled",
    calculator: false,
    difficulty: 2,
  )[
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Tim claims $1/2 + 1/3 = 2/5$. Without calculating the correct
        answer first, explain why his result cannot be right. Then
        calculate it.],
      [Ana simplifies $(4 + 6)/4 = 6$ by crossing out the 4s. Is she
        right? What may be cancelled in a fraction, and what may not?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$2/5$ is smaller than $1/2$ alone, but he added something
        positive to $1/2$. Correct: $3/6 + 2/6 = 5/6$.],
      [No: $(4 + 6)/4 = 10/4 = 5/2$. Only common _factors_ of the
        numerator and denominator cancel, never terms of a sum.
        The same holds for $(x + 6)/x$, which is not $6$.],
    )
  ],

  task(
    topic: "Percentages: changing the base",
    calculator: false,
    difficulty: 2,
  )[
    A jacket costs CHF 120. In a sale, its price drops by 25%. After
    the sale, the new price rises by 25%. Does the jacket cost CHF 120
    again? Explain.
  ][
    No: $120 dot 0.75 = 90$, then $90 dot 1.25 = 112.50$. The two
    percentages refer to different bases (120 and 90), so they do not
    cancel. In one step: $120 dot 0.75 dot 1.25 = 120 dot 0.9375$.
  ],

  task(
    topic: "Variables: translating words into terms",
    calculator: false,
    difficulty: 2,
  )[
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [At a school there are 6 times as many students as teachers.
        Write an equation using $S$ for the number of students and $T$
        for the number of teachers. Check it with $T = 10$.],
      [Write a term for the sum of three consecutive whole numbers,
        starting with $n$. Show that the sum is always divisible by 3.],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$S = 6 dot T$. Check: 10 teachers give 60 students. (The common
        mistake $6 dot S = T$ reads the letters as labels, not as
        numbers.)],
      [$n + (n + 1) + (n + 2) = 3n + 3 = 3 dot (n + 1)$: always 3 times
        a whole number.],
    )
  ],
)


#review-sheet(
  track: "glf",
  term: "1a",
  number: 2,
  draws-on: (
    "terms and variables",
    "patterns",
    "linear equations",
    "parameters",
    "areas and Pythagoras",
  ),

  task(topic: "Terms: recognizing equivalent terms", calculator: false)[
    Which of these terms are equal to $2 dot (x + 3)$ for _every_ $x$?
    Test with a number, then explain with algebra.
    #auto-parts(
      4,
      [$2x + 3$],
      [$2x + 6$],
      [$(x + 3) dot 2$],
      [$x + 3 + x + 3$],
    )
  ][
    #auto-parts(
      2,
      [No: for $x = 1$ it gives 5, not 8 (only the $x$ was doubled)],
      [Yes: distributive law],
      [Yes: the order of factors does not matter],
      [Yes: $x + x + 3 + 3 = 2x + 6$],
    )
  ],

  task(
    topic: "Patterns: from examples to a general term",
    calculator: false,
    difficulty: 2,
  )[
    Squares are laid in a row using matches: 1 square needs 4 matches,
    2 squares need 7, 3 squares need 10.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [How many matches do 10 squares need?],
      [Write a term for the number of matches for $n$ squares, and
        explain where it comes from.],
      [Can you use exactly 100 matches to make such a row?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [31],
      [$3n + 1$: one match to start, then 3 more for each square.],
      [$3n + 1 = 100$ gives $n = 33$: yes, 33 squares.],
    )
  ],

  task(
    topic: "Linear equations, also with fractions",
    calculator: false,
    difficulty: 2,
  )[
    Solve and check your solution.
    #auto-parts(
      2,
      [$3 dot (x - 2) = 2x + 5$],
      [$x/2 + x/3 = 10$],
    )
  ][
    #auto-parts(
      2,
      [$3x - 6 = 2x + 5$, so $x = 11$. Check: $27 = 27$.],
      [Multiply by 6: $3x + 2x = 60$, so $x = 12$. Check: $6 + 4 = 10$.],
    )
  ],

  task(
    topic: "Parameters: solving in general",
    calculator: false,
    difficulty: 2,
  )[
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Solve $a dot x + b = c$ for $x$, where $a, b, c$ are fixed
        numbers and $a != 0$. Use your formula to solve
        $4x + 7 = 31$.],
      [Why do we need $a != 0$? What happens to the equation if
        $a = 0$?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$x = (c - b)/a$; here $x = (31 - 7)/4 = 6$.],
      [We divide by $a$, and division by 0 is undefined. For $a = 0$
        the equation reads $b = c$: either it is true for every $x$
        (if $b = c$) or for none (if $b != c$).],
    )
  ],

  task(
    topic: "Terms in geometry: scaling a rectangle",
    calculator: false,
    difficulty: 3,
  )[
    A rectangle has length $l$ and width $w$.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Write terms for its perimeter, its area, and its diagonal.],
      [Both sides are doubled. Use your terms to decide what happens to
        the perimeter, the area, and the diagonal.],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$P = 2 dot (l + w)$, $A = l dot w$, $d = sqrt(l^2 + w^2)$
        (Pythagoras)],
      [$P$: $2 dot (2l + 2w) = 2 dot P$, doubled.
        $A$: $(2l) dot (2w) = 4 dot l dot w$, four times as large.
        $d$: $sqrt(4l^2 + 4w^2) = 2 dot d$, doubled.],
    )
  ],
)


#review-sheet(
  track: "glf",
  term: "1a",
  number: 3,
  draws-on: (
    "proportionality",
    "powers and units",
    "terms",
    "always, sometimes, never",
  ),

  task(topic: "Proportionality: recognizing the type", calculator: false)[
    Proportional, inversely proportional, or neither? Justify.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [The price of identical notebooks and the number you buy.],
      [The time to finish a job and the number of (equally fast)
        workers.],
      [A taxi fare (base fare plus a price per km) and the distance.],
      [The area of a square and its side length.],
    )
  ][
    #auto-parts(
      2,
      [Proportional: twice as many, twice the price],
      [Inversely proportional: twice the workers, half the time],
      [Neither: linear, but 0 km does not cost CHF 0],
      [Neither: doubling the side quadruples the area],
    )
  ],

  task(topic: "Powers and units", calculator: false)[
    #auto-parts(
      4,
      [$(-3)^2$],
      [$-3^2$],
      [$10^(-3)$],
      [1 m² in cm²],
    )
  ][
    #auto-parts(
      4,
      [$9$],
      [$-9$ (the power binds first)],
      [$1/1000 = 0.001$],
      [$100^2 = #num(10000)$ cm²],
    )
  ],

  task(topic: "Terms: order of operations and the distributive law",
    calculator: false)[
    #auto-parts(
      3,
      [Calculate $12 - 3 dot (4 - 6)^2$.],
      [Expand $-2 dot (3x - 5)$.],
      [Factor $6a + 9$.],
    )
  ][
    #auto-parts(
      3,
      [$12 - 3 dot 4 = 0$],
      [$-6x + 10$],
      [$3 dot (2a + 3)$],
    )
  ],

  task(
    topic: "Proportionality: scaling a recipe",
    calculator: false,
    difficulty: 2,
  )[
    A recipe for 4 people needs 300 g of flour. How much flour do you
    need for 6 people? For how many people is 1 kg of flour enough?
  ][
    75 g per person: $6 dot 75 = 450$ g. $#num(1000) / 75 approx 13.3$:
    enough for 13 people.
  ],

  task(
    topic: "Variables: always, sometimes, or never true?",
    calculator: false,
    difficulty: 2,
  )[
    Is each statement always, sometimes, or never true? For
    "sometimes", give one example where it holds and one where it
    fails.
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [$a + b = b + a$],
      [$2 dot x > x$],
      [$x^2 >= x$],
      [$(a + b)^2 = a^2 + b^2$],
    )
  ][
    #auto-parts(
      2,
      [Always (commutative law)],
      [Sometimes: true for $x = 1$, false for $x = -1$ or $x = 0$],
      [Sometimes: true for $x = 2$, false for $x = 1/2$],
      [Sometimes: true for $a = 0$, false for $a = b = 1$],
    )
  ],
)


// ════════════════════════════════════════════════════════════
//  GLF — YEAR 1, 2nd SEMESTER (draws on year 1, 1st semester)
// ════════════════════════════════════════════════════════════

#review-sheet(
  track: "glf",
  term: "1b",
  number: 1,
  draws-on: (
    "algebra",
    "linear equations",
    "linear functions",
  ),

  task(topic: "Algebra: recognizing a pattern to factor", calculator: false)[
    Which pattern (common factor or binomial formula) fits? Factor.
    #auto-parts(
      4,
      [$x^2 + 10x + 25$],
      [$4a^2 - 9$],
      [$6x^2 - 9x$],
      [$x^2 - 6x + 9$],
    )
  ][
    #auto-parts(
      2,
      [First binomial formula: $(x + 5)^2$],
      [Third binomial formula: $(2a - 3) dot (2a + 3)$],
      [Common factor: $3x dot (2x - 3)$],
      [Second binomial formula: $(x - 3)^2$],
    )
  ],

  task(topic: "Algebra: fractions and powers", calculator: false)[
    Simplify.
    #auto-parts(
      4,
      [$3/4 + 5/6$],
      [$2/3 dot 9/10$],
      [$(2^3 dot 2^4) / 2^5$],
      [$(3x^2)^2$],
    )
  ][
    #auto-parts(
      4,
      [$9/12 + 10/12 = 19/12$],
      [$18/30 = 3/5$],
      [$2^(3 + 4 - 5) = 4$],
      [$9x^4$],
    )
  ],

  task(
    topic: "Linear equations and formulas",
    calculator: false,
    difficulty: 2,
  )[
    #auto-parts(
      2,
      [Solve $4 dot (x - 2) - 3 = 2x + 5$.],
      [Solve $P = 2 dot (a + b)$ for $b$.],
    )
  ][
    #auto-parts(
      2,
      [$4x - 11 = 2x + 5$, so $2x = 16$ and $x = 8$],
      [$b = P/2 - a$],
    )
  ],

  task(
    topic: "Linear functions: modeling",
    calculator: false,
    difficulty: 2,
  )[
    A candle is 24 cm tall and burns down 3 cm per hour.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Write its height $h$ as a function of the time $t$ in hours.],
      [When has it burned down completely? Which domain makes sense?],
      [What do the slope and the $y$-intercept mean here?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$h(t) = -3t + 24$],
      [$h(t) = 0$ at $t = 8$ hours; domain $0 <= t <= 8$],
      [Slope: the candle loses 3 cm per hour. $y$-intercept: its height
        at the start, 24 cm.],
    )
  ],

  task(
    topic: "Algebra: binomial formulas",
    calculator: false,
    difficulty: 2,
  )[
    Lia writes $(x + 3)^2 = x^2 + 9$. Show with a number that this is
    wrong, then expand $(x + 3)^2$ correctly.
  ][
    For example $x = 1$: $(1 + 3)^2 = 16$, but $1^2 + 9 = 10$.
    Correct: $(x + 3)^2 = x^2 + 6x + 9$. The middle term $2 dot 3 dot x$
    is missing.
  ],
)


#review-sheet(
  track: "glf",
  term: "1b",
  number: 2,
  draws-on: (
    "linear functions",
    "linear systems",
    "scientific notation",
  ),

  task(topic: "Linear functions: reading the equation", calculator: false)[
    Give the slope and the $y$-intercept of each line, if they exist.
    #auto-parts(
      4,
      [$y = -2x + 5$],
      [$3x + y = 6$],
      [$y = 4$],
      [$x = 2$],
    )
  ][
    #auto-parts(
      2,
      [Slope $-2$, $y$-intercept $5$],
      [$y = -3x + 6$: slope $-3$, $y$-intercept $6$],
      [Horizontal line: slope $0$, $y$-intercept $4$],
      [Vertical line: no slope, no $y$-intercept (not a function)],
    )
  ],

  task(topic: "Linear systems: elimination", calculator: false)[
    Solve the system
    $ #system(($3x + 2y$, $16$), ($5x - 2y$, $0$)) $
  ][
    Add the equations: $8x = 16$, so $x = 2$; then $2y = 16 - 6$, so
    $y = 5$.
  ],

  task(
    topic: "Linear systems: setting up equations",
    calculator: false,
    difficulty: 2,
  )[
    A parking lot holds cars and motorbikes: 30 vehicles with 100
    wheels in total. Set up a system of equations and find how many of
    each there are.
  ][
    With $c$ cars and $m$ motorbikes:
    $ #system(($c + m$, $30$), ($4c + 2m$, $100$)) $
    Subtract twice the first equation from the second: $2c = 40$. So
    20 cars and 10 motorbikes.
  ],

  task(topic: "Algebra: scientific notation", calculator: false)[
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Calculate $(4.2 dot 10^5) dot (3 dot 10^(-2))$ and give the result
        in scientific notation.],
      [A human hair is about $5 dot 10^(-5)$ m thick. How many hairs
        side by side make 1 cm?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$12.6 dot 10^3 = 1.26 dot 10^4$],
      [$10^(-2) / (5 dot 10^(-5)) = 0.2 dot 10^3 = 200$ hairs],
    )
  ],

  task(
    topic: "Linear functions and systems: a triangle",
    calculator: false,
    difficulty: 3,
  )[
    The line $g$ is $y = 2x - 1$; the line $h$ passes through $(0, 5)$
    and $(2, 1)$.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Find the equation of $h$ and the intersection point of $g$ and
        $h$.],
      [Find the area of the triangle formed by $g$, $h$, and the
        $y$-axis.],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$h: y = -2x + 5$. $2x - 1 = -2x + 5$ gives $x = 1.5$: the point
        $(1.5, 2)$.],
      [Vertices $(0, -1)$, $(0, 5)$, $(1.5, 2)$: base 6 on the $y$-axis,
        height 1.5, area $1/2 dot 6 dot 1.5 = 4.5$.],
    )
  ],
)


#review-sheet(
  track: "glf",
  term: "1b",
  number: 3,
  draws-on: (
    "linear equations",
    "algebra",
    "linear functions",
    "linear systems",
  ),

  task(
    topic: "Linear equations: how many solutions?",
    calculator: false,
  )[
    How many solutions does each equation have? Give them.
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [$2x + 3 = 2x + 5$],
      [$3 dot (x + 1) = 3x + 3$],
      [$5x = 0$],
      [$x + 4 = 2x + 4$],
    )
  ][
    #auto-parts(
      2,
      [None: it leads to $3 = 5$],
      [Infinitely many: every $x$ (it leads to $3 = 3$)],
      [One: $x = 0$],
      [One: $x = 0$],
    )
  ],

  task(topic: "Algebra: expanding and simplifying", calculator: false)[
    #auto-parts(
      3,
      [$(x + 2) dot (x - 5)$],
      [$(2x - 1)^2 - 4x^2$],
      [$a dot (b - c) - b dot (a - c)$],
    )
  ][
    #auto-parts(
      3,
      [$x^2 - 3x - 10$],
      [$-4x + 1$],
      [$b dot c - a dot c = c dot (b - a)$],
    )
  ],

  task(
    topic: "Linear functions: the line through two points",
    calculator: false,
    difficulty: 2,
  )[
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Find the equation of the line through $P = (-1, 3)$ and
        $Q = (3, -5)$.],
      [Does $R = (10, -19)$ lie on this line?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Slope $(-5 - 3) / (3 + 1) = -2$; $y = -2x + 1$],
      [$-2 dot 10 + 1 = -19$: yes],
    )
  ],

  task(
    topic: "Linear systems: substitution and graphs",
    calculator: false,
    difficulty: 2,
  )[
    Solve the system $y = 3x - 4$, $2x + y = 6$ by substitution. Sketch
    both lines and mark your solution.
  ][
    $2x + 3x - 4 = 6$, so $x = 2$ and $y = 2$. The lines intersect at
    $(2, 2)$.
  ],

  task(
    topic: "Linear functions: comparing two offers",
    calculator: false,
    difficulty: 2,
  )[
    Phone plan A costs CHF 20 per month plus CHF 0.10 per minute. Plan B
    costs CHF 35 per month, all calls included. For how many minutes per
    month is plan A cheaper?
  ][
    $20 + 0.1 dot m < 35$ gives $m < 150$: plan A is cheaper below 150
    minutes. (At 150 minutes both cost CHF 35; the graphs intersect.)
  ],
)


// ════════════════════════════════════════════════════════════
//  GLF — YEAR 2, 1st SEMESTER (draws on year 1)
// ════════════════════════════════════════════════════════════

#review-sheet(
  track: "glf",
  term: "2a",
  number: 1,
  draws-on: (
    "equations",
    "linear functions",
    "linear systems",
    "right-triangle trigonometry",
  ),

  task(topic: "Equations: recognizing the type", calculator: false)[
    Do _not_ solve yet. For each equation, name its type and the first
    step you would take. Then solve the two you find quickest.
    #auto-parts(
      4,
      [$3 dot (x - 2) = 5x + 4$],
      [$x^2 - 7x = 0$],
      [$(x - 3)^2 = 16$],
      [$2x^2 + 3x - 5 = 0$],
    )
  ][
    #auto-parts(
      2,
      [Linear: expand, collect the $x$-terms. $x = -5$],
      [Quadratic, no constant term: factor out $x$.
        $x dot (x - 7) = 0$, so $x = 0$ or $x = 7$],
      [Quadratic, already a square: take the root, both signs.
        $x - 3 = plus.minus 4$, so $x = 7$ or $x = -1$],
      [Quadratic, general: quadratic formula ($D = 49$).
        $x = 1$ or $x = -5/2$],
    )
  ],

  task(topic: "Linear functions: slope and equation", calculator: false)[
    The line $g$ passes through $A = (-2, 5)$ and $B = (4, 2)$.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Find the equation of $g$ in the form $y = m dot x + b$.],
      [Where does $g$ cross the $x$-axis?],
      [Give the equation of the line through the origin that is
        perpendicular to $g$.],
    )
  ][
    #auto-parts(
      3,
      [$m = (2 - 5)/(4 - (-2)) = -1/2$, $b = 4$:
        $y = -1/2 x + 4$],
      [$0 = -1/2 x + 4$ gives $x = 8$: the point $(8, 0)$],
      [Negative reciprocal slope $2$: $y = 2x$],
    )
  ],

  task(topic: "Linear systems", calculator: false, difficulty: 2)[
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Solve the system
        $ #system(($2x + 3y$, $12$), ($x - y$, $1$)) $
        and say what your answer means geometrically.],
      [Replace the first equation with one that gives the system _no_
        solution. What happens to the two lines?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$x = 3$, $y = 2$: the two lines intersect at $(3, 2)$.],
      [For example $x - y = 4$ (any $x - y = c$ with $c != 1$, or a
        multiple such as $2x - 2y = 5$): the lines are parallel and
        distinct, so they never meet.],
    )
  ],

  task(
    topic: "Right-triangle trigonometry",
    calculator: true,
    difficulty: 2,
  )[
    A 4.5 m ladder leans against a vertical wall. Its foot stands
    1.2 m from the wall.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [What angle does the ladder make with the ground?],
      [How high up the wall does it reach?],
      [Safety guidelines recommend an angle of about $75 degree$. Is the
        ladder set up safely?],
    )
  ][
    #auto-parts(
      3,
      [$cos(alpha) = 1.2 / 4.5$, so $alpha approx 74.5 degree$],
      [$h = sqrt(4.5^2 - 1.2^2) approx 4.34$ m
        (or $4.5 dot sin(alpha)$)],
      [Yes: $74.5 degree$ is very close to $75 degree$.],
    )
  ],

  task(
    topic: "Equations: never divide by a variable",
    calculator: false,
    difficulty: 2,
  )[
    Mia divides both sides of $x^2 = 5x$ by $x$, gets $x = 5$, and
    concludes that this is the only solution. Find her mistake, explain
    why it is one, and solve the equation correctly.
  ][
    Dividing by $x$ silently assumes $x != 0$, but $x = 0$ _is_ a
    solution, so it gets lost. Correct: $x^2 - 5x = 0$, so
    $x dot (x - 5) = 0$, so $x = 0$ or $x = 5$. Rule: factor instead of
    dividing by an expression that could be zero.
  ],
)


#review-sheet(
  track: "glf",
  term: "2a",
  number: 2,
  draws-on: (
    "quadratic functions",
    "algebra",
    "general-triangle trigonometry",
    "linear systems",
  ),

  task(topic: "Quadratic functions: the three forms", calculator: false)[
    Without calculating, name the form each function is written in and
    say what you can read off directly.
    #auto-parts(
      2,
      [$f_1(x) = (x - 2)^2 - 3$],
      [$f_2(x) = -(x + 1)^2 + 4$],
      [$f_3(x) = (x - 1) dot (x + 3)$],
      [$f_4(x) = 2x^2 - 8x + 5$],
    )
  ][
    #auto-parts(
      2,
      [Vertex form: vertex $(2, -3)$, opens upward],
      [Vertex form: vertex $(-1, 4)$, opens downward],
      [Factored form: zeros $x = 1$ and $x = -3$, opens upward],
      [Standard form: $y$-intercept $(0, 5)$, opens upward],
    )
  ],

  task(
    topic: "Quadratic functions: switching forms",
    calculator: false,
    difficulty: 2,
  )[
    Two of the functions in Task 1 have the same vertex, and the other
    two have the same zeros. Find both pairs and show your reasoning.
  ][
    $f_1$ and $f_4$: the vertex of $f_4$ is at $x = -b/(2a) = 2$, and
    $f_4(2) = 8 - 16 + 5 = -3$, so it is $(2, -3)$, as for $f_1$.
    $f_2$ and $f_3$: $-(x + 1)^2 + 4 = 0$ gives $(x + 1)^2 = 4$, so
    $x = 1$ or $x = -3$, as for $f_3$. In fact $f_2 = -f_3$: one graph
    is the other reflected in the $x$-axis.
  ],

  task(topic: "Algebra: binomial formulas and factoring", calculator: false)[
    #auto-parts(
      3,
      [Expand $(2a - 3)^2$.],
      [Factor $9x^2 - 25$.],
      [Simplify $(x^2 - 9)/(x^2 + 3x)$.],
    )
  ][
    #auto-parts(
      3,
      [$4a^2 - 12a + 9$],
      [$(3x - 5) dot (3x + 5)$],
      [$((x - 3) dot (x + 3))/(x dot (x + 3)) = (x - 3)/x$ for $x != 0, -3$],
    )
  ],

  task(
    topic: "General-triangle trigonometry: sine and cosine rule",
    calculator: true,
    difficulty: 2,
  )[
    In triangle $A B C$: $a = 7$ cm, $b = 5$ cm, $gamma = 48 degree$.
    #auto-parts(
      2,
      [Calculate side $c$.],
      [Calculate the angles $alpha$ and $beta$.],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Cosine rule:
        $c^2 = 7^2 + 5^2 - 2 dot 7 dot 5 dot cos(48 degree)$,
        so $c approx 5.21$ cm],
      [Sine rule for $beta$ (opposite the shorter side, so certainly
        acute): $sin(beta) = (5 dot sin(48 degree)) / c$, so
        $beta approx 45.5 degree$ and
        $alpha = 180 degree - 48 degree - beta approx 86.5 degree$.
        Trap: the sine rule for $alpha$ gives $sin(alpha) approx 0.998$,
        which fits both $86.5 degree$ and $93.5 degree$.],
    )
  ],

  task(
    topic: "Quadratic equations and systems: intersections",
    calculator: false,
    difficulty: 2,
  )[
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Find the intersection points of the parabola $y = x^2$ and the
        line $y = x + 2$.],
      [A non-vertical line and a parabola can meet in 0, 1, or 2 points.
        Sketch one example of each case and explain how the equation
        from (a) tells you which case you are in.],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$x^2 = x + 2$, so $x^2 - x - 2 = 0$, so $(x - 2) dot (x + 1) = 0$:
        the points $(2, 4)$ and $(-1, 1)$.],
      [The intersection equation is quadratic, and its discriminant
        decides: $D > 0$ two points, $D = 0$ one point (the line is a
        tangent), $D < 0$ none.],
    )
  ],
)


#review-sheet(
  track: "glf",
  term: "2a",
  number: 3,
  draws-on: (
    "quadratic equations",
    "quadratic functions",
    "trigonometry",
  ),

  task(
    topic: "Quadratic equations: how many solutions?",
    calculator: false,
  )[
    How many solutions does each equation have? Decide before solving.
    #auto-parts(
      4,
      [$x^2 + 4 = 0$],
      [$x^2 - 6x + 9 = 0$],
      [$x^2 - 5x + 6 = 0$],
      [$2x^2 + x + 1 = 0$],
    )
  ][
    #auto-parts(
      2,
      [None: $x^2$ cannot be $-4$],
      [One: $(x - 3)^2 = 0$, $x = 3$],
      [Two: $(x - 2) dot (x - 3) = 0$, $x = 2$ or $x = 3$],
      [None: $D = 1 - 8 < 0$],
    )
  ],

  task(
    topic: "Quadratic functions: a throw",
    calculator: true,
    difficulty: 2,
  )[
    A ball is thrown upward. Its height in meters after $t$ seconds is
    $h(t) = -5t^2 + 20t + 1.5$.
    #auto-parts(
      2,
      [What is its greatest height, and when?],
      [When does it hit the ground?],
    )
  ][
    #auto-parts(
      2,
      [Vertex at $t = 2$: $h(2) = 21.5$ m],
      [$h(t) = 0$ gives $t approx 4.07$ s (the negative solution makes
        no sense here)],
    )
  ],

  task(
    topic: "Trigonometry: sine, cosine, tangent",
    calculator: false,
    difficulty: 2,
  )[
    The angle $alpha$ is acute and $sin(alpha) = 3/5$. Find
    $cos(alpha)$ and $tan(alpha)$ without a calculator. (A sketch of a
    right triangle helps.)
  ][
    Triangle with opposite side 3 and hypotenuse 5: adjacent side
    $sqrt(25 - 9) = 4$. So $cos(alpha) = 4/5$ and $tan(alpha) = 3/4$.
    (Check: $sin(alpha)^2 + cos(alpha)^2 = 9/25 + 16/25 = 1$.)
  ],

  task(
    topic: "Right-triangle trigonometry: heights",
    calculator: true,
    difficulty: 2,
  )[
    From a point 50 m away from the foot of a tower, you see its top at
    an angle of elevation of $32 degree$. How tall is the tower? (Ignore
    your own height.)
  ][
    $h = 50 dot tan(32 degree) approx 31.2$ m
  ],

  task(
    topic: "Quadratic equations: checking a factorization",
    calculator: false,
    difficulty: 2,
  )[
    Elena solves $x^2 + 2x - 8 = 0$ like this:
    $(x + 4) dot (x - 2) = 0$, so $x = 4$ or $x = -2$. Check her
    solutions, find the mistake, and correct it.
  ][
    The factorization is right, but $x + 4 = 0$ gives $x = -4$, and
    $x - 2 = 0$ gives $x = 2$: she flipped both signs. Check:
    $(-4)^2 - 8 - 8 = 0$ and $4 + 4 - 8 = 0$.
  ],
)


// ════════════════════════════════════════════════════════════
//  GLF — YEAR 2, 2nd SEMESTER (draws on year 1 + descriptive
//  statistics)
// ════════════════════════════════════════════════════════════

#review-sheet(
  track: "glf",
  term: "2b",
  number: 1,
  draws-on: (
    "linear and quadratic functions",
    "descriptive statistics",
    "trigonometry on the unit circle",
  ),

  task(topic: "Functions: recognizing the type", calculator: false)[
    Each list gives the $y$-values of a function for $x = 0, 1, 2, 3$.
    Linear, quadratic, or neither? Justify via the step-by-step changes.
    #auto-parts(
      4,
      [$5, 8, 11, 14$],
      [$1, 2, 5, 10$],
      [$2, 4, 8, 16$],
      [$7, 4, 1, -2$],
    )
  ][
    #auto-parts(
      2,
      [Linear: constant differences $+3$],
      [Quadratic: steps $+1, +3, +5$, the same pattern you use to sketch
        $y = x^2$ from its vertex (here $y = x^2 + 1$)],
      [Neither: the values double each step (a preview of exponential
        growth)],
      [Linear: constant differences $-3$],
    )
  ],

  task(topic: "Descriptive statistics: boxplots", calculator: false)[
    The boxplots show the grades of two classes in the same test.
    #boxplot(
      ("Class A", (min: 2.5, q1: 3.75, med: 4.5, q3: 5, max: 6)),
      ("Class B", (min: 3, q1: 4, med: 4.25, q3: 4.5, max: 5.5)),
      xmin: 2,
      xmax: 6,
      xstep: 0.5,
      width: 10cm,
      x-label: [grade],
    )
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Read off the median and the interquartile range of each class.],
      [In which class did at least half of the students score 4.5 or
        higher? Explain.],
      [Which class has the more consistent results? Justify with a
        measure of spread.],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [A: median $4.5$, IQR $5 - 3.75 = 1.25$.
        B: median $4.25$, IQR $4.5 - 4 = 0.5$.],
      [Class A: its median is $4.5$, so half the class is at or above
        it. In class B, $4.5$ is the upper quartile: only about a
        quarter scored that high.],
      [Class B: its IQR ($0.5$) is much smaller than A's ($1.25$), so
        the middle half of the grades lies closer together.],
    )
  ],

  task(
    topic: "Quadratic functions: zeros, vertex, range",
    calculator: false,
    difficulty: 2,
  )[
    Let $f(x) = -x^2 + 6x - 5$.
    #auto-parts(
      3,
      [Find the zeros of $f$.],
      [Find the vertex of the graph.],
      [State the range of $f$.],
    )
  ][
    #auto-parts(
      3,
      [$-(x - 1) dot (x - 5) = 0$: $x = 1$ or $x = 5$],
      [Midway between the zeros, $x = 3$; $f(3) = 4$: vertex $(3, 4)$],
      [Opens downward, so $y <= 4$],
    )
  ],

  task(
    topic: "Trigonometry: the unit circle",
    calculator: false,
    difficulty: 2,
  )[
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Give the exact values of $sin(150 degree)$, $cos(120 degree)$,
        and $tan(135 degree)$. A sketch of the unit circle helps.],
      [Find all angles $0 degree <= alpha < 360 degree$ with
        $sin(alpha) = -1/2$. Give them in degrees and in radians.],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$sin(150 degree) = 1/2$, $cos(120 degree) = -1/2$,
        $tan(135 degree) = -1$ (each by symmetry with the reference
        angle $30 degree$, $60 degree$, or $45 degree$)],
      [$alpha = 210 degree = (7 pi)/6$ or
        $alpha = 330 degree = (11 pi)/6$ (third and fourth quadrant,
        reference angle $30 degree$)],
    )
  ],

  task(
    topic: "Descriptive statistics: shifting data",
    calculator: false,
    difficulty: 2,
  )[
    After a test, the teacher adds a bonus of 0.5 to every grade. Lea
    claims: "The mean and the standard deviation both go up by 0.5."
    Is she right? Correct her claim if necessary, and say what happens
    to the median and the IQR.
  ][
    Only half right. The mean (and the median) go up by $0.5$, but the
    standard deviation (and the IQR) stay the same: every value moves
    by the same amount, so the distances between them do not change.
    Same idea as shifting a graph: its position changes, its shape
    does not.
  ],
)


#review-sheet(
  track: "glf",
  term: "2b",
  number: 2,
  draws-on: (
    "descriptive statistics",
    "linear systems",
    "functions",
    "quadratic equations",
    "right-triangle geometry",
  ),

  task(topic: "Descriptive statistics: choosing a measure of center",
    calculator: false)[
    Which measure of center fits each situation best: the mean, the
    median, or the mode? Give a reason.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [The typical house price in a town where a few villas cost
        several million.],
      [The average daily maximum temperature over one week in May.],
      [A shoe shop wants to know which size to order most of.],
      [The typical waiting time at a doctor's office, where now and
        then a patient waits for two hours.],
    )
  ][
    #auto-parts(
      2,
      [Median: the few villas would pull the mean up.],
      [Mean: no extreme values, and every day should count.],
      [Mode: the shop needs the most frequent size.],
      [Median: the rare long waits would distort the mean.],
    )
  ],

  task(
    topic: "Descriptive statistics: computing key figures",
    calculator: true,
  )[
    Seven students record how many minutes they spent on homework:
    $ 12, quad 15, quad 9, quad 14, quad 20, quad 11, quad 16 $
    Find the mean, the median, the standard deviation, and the
    five-number summary.
  ][
    Mean $97 / 7 approx 13.86$ min, median $14$ min, standard deviation
    $sigma approx 3.36$ min ($sigma_x$ on the calculator; $s_x approx
    3.63$ divides by $n - 1$). Sorted: $9, 11, 12, 14, 15, 16, 20$.
    Five-number summary: $9, 11, 14, 16, 20$.
  ],

  task(
    topic: "Linear systems: setting up equations",
    calculator: false,
    difficulty: 2,
  )[
    A cinema sells adult tickets for CHF 18 and student tickets for
    CHF 12. One evening, 40 tickets were sold for a total of CHF 570.
    Set up a system of equations and find how many tickets of each
    kind were sold.
  ][
    With $a$ adult and $s$ student tickets:
    $ #system(($a + s$, $40$), ($18a + 12s$, $570$)) $
    Substituting $s = 40 - a$: $18a + 480 - 12a = 570$, so $6a = 90$.
    15 adult tickets and 25 student tickets.
  ],

  task(
    topic: "Functions: domain and range",
    calculator: false,
    difficulty: 2,
  )[
    State the largest possible domain of $f$ and $g$, and the range
    of $h$.
    #auto-parts(
      3,
      [$f(x) = sqrt(x - 3)$],
      [$g(x) = 1/(x + 2)$],
      [$h(x) = (x - 1)^2 + 2$],
    )
  ][
    #auto-parts(
      3,
      [$x >= 3$ (no roots of negative numbers)],
      [all $x$ except $x = -2$ (no division by zero)],
      [$y >= 2$ (the vertex $(1, 2)$ is the lowest point)],
    )
  ],

  task(
    topic: "Quadratic equations and Pythagoras: a rectangle",
    calculator: true,
    difficulty: 3,
  )[
    A rectangle has a perimeter of 20 cm and a diagonal of 8 cm.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Find the lengths of its sides.],
      [Find the angle between the diagonal and the longer side.],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$a + b = 10$ and $a^2 + b^2 = 64$. Substituting $b = 10 - a$:
        $2a^2 - 20a + 36 = 0$, so $a^2 - 10a + 18 = 0$ and
        $a = 5 plus.minus sqrt(7)$. The sides are about $7.65$ cm and
        $2.35$ cm.],
      [$tan(alpha) = (5 - sqrt(7)) / (5 + sqrt(7))$, so
        $alpha approx 17.1 degree$],
    )
  ],
)


#review-sheet(
  track: "glf",
  term: "2b",
  number: 3,
  draws-on: (
    "descriptive statistics",
    "quadratic functions",
    "general triangles",
  ),

  task(topic: "Statistics: choosing a chart", calculator: false)[
    Which type of chart fits best? Give a reason.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [The shares of votes for five parties.],
      [The temperature over the course of one day.],
      [The heights of 200 students.],
      [The test results of two classes, to compare them.],
    )
  ][
    #auto-parts(
      2,
      [Bar chart or pie chart (parts of a whole)],
      [Line chart (change over time)],
      [Histogram (distribution of a continuous quantity)],
      [Two boxplots on one axis],
    )
  ],

  task(
    topic: "Statistics: outliers and robustness",
    calculator: false,
    difficulty: 2,
  )[
    Data: $3, 4, 4, 5, 6, 30$.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Find the mean and the median.],
      [Remove the value 30 and find both again. Which measure is more
        robust against outliers?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Mean $52/6 approx 8.67$, median $4.5$],
      [Mean $22/5 = 4.4$, median $4$. The median hardly changes: it is
        robust; the mean is pulled by the outlier.],
    )
  ],

  task(
    topic: "Quadratic functions: completing the square",
    calculator: false,
    difficulty: 2,
  )[
    Write $f(x) = x^2 + 6x + 5$ in vertex form. Give the vertex and the
    zeros.
  ][
    $f(x) = (x + 3)^2 - 4$: vertex $(-3, -4)$; zeros from
    $(x + 3)^2 = 4$: $x = -1$ and $x = -5$.
  ],

  task(
    topic: "General triangles: the sine rule",
    calculator: true,
    difficulty: 2,
  )[
    In triangle $A B C$: $alpha = 35 degree$, $beta = 75 degree$, and
    $c = 10$ cm. Find $gamma$, $a$, and $b$.
  ][
    $gamma = 70 degree$; $a = (10 dot sin(35 degree)) / sin(70 degree)
    approx 6.10$ cm; $b = (10 dot sin(75 degree)) / sin(70 degree)
    approx 10.28$ cm.
  ],

  task(
    topic: "Statistics: scaling and shifting data",
    calculator: false,
    difficulty: 2,
  )[
    A test has a mean of 18 points with a standard deviation of 3
    points. The teacher converts points to percent by multiplying by 4,
    and then adds a bonus of 5 percent to everyone. Find the new mean
    and standard deviation.
  ][
    Multiplying by 4 multiplies both: mean 72, SD 12. Adding 5 shifts
    only the mean: mean 77, SD 12.
  ],
)


// ════════════════════════════════════════════════════════════
//  GLF — YEAR 3, 1st SEMESTER (draws on years 1–2)
// ════════════════════════════════════════════════════════════

#review-sheet(
  track: "glf",
  term: "3a",
  number: 1,
  draws-on: (
    "equations",
    "exponential functions",
    "probability",
    "vectors and lines",
  ),

  task(topic: "Equations: where is the unknown?", calculator: false)[
    Name the tool each equation needs (root, logarithm, quadratic
    formula, ...). Solve without a calculator where possible; otherwise
    give the exact solution.
    #auto-parts(
      4,
      [$3^x = 81$],
      [$x^3 = 64$],
      [$5 dot 1.2^x = 30$],
      [$x^2 - 3x = 10$],
    )
  ][
    #auto-parts(
      2,
      [Unknown in the exponent, same base: $3^x = 3^4$, so $x = 4$],
      [Unknown in the base: cube root, $x = 4$],
      [Unknown in the exponent: isolate, then logarithm.
        $1.2^x = 6$, so $x = (ln(6)) / (ln(1.2)) approx 9.83$],
      [Quadratic: $x^2 - 3x - 10 = (x - 5) dot (x + 2) = 0$, so
        $x = 5$ or $x = -2$],
    )
  ],

  task(
    topic: "Exponential functions: growth models",
    calculator: true,
    difficulty: 2,
  )[
    A town has #num(8400) inhabitants and grows by 1.5% per year.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Write the population $N$ as a function of the time $t$ in years.],
      [How many inhabitants will the town have after 10 years?],
      [When will the population pass #num(10000)? What is the doubling
        time?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$N(t) = #num(8400) dot 1.015^t$],
      [$N(10) approx #num(9749)$, so about #num(9750)],
      [$1.015^t = #num(10000) / #num(8400)$ gives $t approx 11.7$:
        during year 12. Doubling: $1.015^t = 2$ gives
        $t = (ln(2)) / (ln(1.015)) approx 46.6$ years.],
    )
  ],

  task(
    topic: "Probability: drawing without replacement",
    calculator: false,
    difficulty: 2,
  )[
    A bag holds 5 red and 3 blue marbles. You draw two marbles without
    putting the first one back. A tree diagram helps.
    #auto-parts(
      3,
      [$p("both red")$],
      [$p("different colors")$],
      [$p("at least one blue")$],
    )
  ][
    #auto-parts(
      3,
      [$5/8 dot 4/7 = 5/14$],
      [$2 dot 5/8 dot 3/7 = 15/28$],
      [Complement: $1 - 5/14 = 9/14$],
    )
  ],

  task(topic: "Vectors: basic operations", calculator: false)[
    Given $A = (1, 2, 0)$, $B = (3, 1, 2)$, and $C = (4, 5, 1)$:
    #auto-parts(
      3,
      [Find $arrow(A B)$ and its length.],
      [Find the midpoint $M$ of $A B$.],
      [Find $D$ so that $A B C D$ is a parallelogram.],
    )
  ][
    #auto-parts(
      3,
      [$arrow(A B) = vec(2, -1, 2)$, length $sqrt(4 + 1 + 4) = 3$],
      [$M = (2, 1.5, 1)$],
      [$arrow(A D) = arrow(B C)$: $D = (2, 6, -1)$],
    )
  ],

  task(topic: "Lines: does a point lie on a line?", calculator: false,
    difficulty: 2)[
    The line $g$ is given by
    $g: vec(x, y, z) = vec(1, 2, 0) + t dot vec(2, -1, 2)$.
    To check whether $Q = (5, 0, 3)$ lies on $g$, Nina solves
    $1 + 2t = 5$, finds $t = 2$, and concludes that $Q$ lies on $g$.
    Is her argument complete? Decide whether $Q$ lies on $g$.
  ][
    No: one $t$ must work for _all three_ coordinates at once.
    $x$: $t = 2$; $y$: $2 - t = 0$ gives $t = 2$; $z$: $2t = 3$ gives
    $t = 1.5$. The values disagree, so $Q$ does not lie on $g$. (The
    point of $g$ with $t = 2$ is $(5, 0, 4)$.)
  ],
)


#review-sheet(
  track: "glf",
  term: "3a",
  number: 2,
  draws-on: (
    "combinatorics",
    "logarithms",
    "vectors and lines",
    "descriptive statistics",
    "trigonometry",
  ),

  task(topic: "Combinatorics: modeling the counting process",
    calculator: false)[
    For each situation, describe the counting process (how many choices
    at each step?) and give the number of possibilities.
    #auto-parts(
      2,
      [A 4-digit PIN code],
      [Gold, silver, and bronze among 8 runners],
      [A committee of 3 chosen from 8 people],
      [Five different books arranged on a shelf],
    )
  ][
    #auto-parts(
      2,
      [$10 dot 10 dot 10 dot 10 = #num(10000)$],
      [$8 dot 7 dot 6 = 336$ (order matters)],
      [$(8 dot 7 dot 6) / (3 dot 2 dot 1) = binom(8, 3) = 56$ (order
        does not matter)],
      [$5 dot 4 dot 3 dot 2 dot 1 = 5! = 120$],
    )
  ],

  task(topic: "Logarithms: definition and laws", calculator: false)[
    Calculate without a calculator.
    #auto-parts(
      4,
      [$log_2(32)$],
      [$log_3(1/9)$],
      [$log(0.001)$],
      [$log(2) + log(50)$],
    )
  ][
    #auto-parts(
      4,
      [$5$],
      [$-2$],
      [$-3$],
      [$log(100) = 2$],
    )
    Remember: $log(x)$ is short for $log_(10)(x)$.
  ],

  task(
    topic: "Lines in the plane: intersection",
    calculator: false,
    difficulty: 2,
  )[
    $g: vec(x, y) = vec(1, 2) + t dot vec(2, 1)$ and
    $h: vec(x, y) = vec(6, 2) + s dot vec(-1, 2)$.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Find the intersection point of $g$ and $h$.],
      [Give an equation of the line through the origin parallel to $g$.],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$1 + 2t = 6 - s$ and $2 + t = 2 + 2s$ give $t = 2s$, then
        $5s = 5$: $s = 1$, $t = 2$. Intersection point $(5, 4)$.],
      [$vec(x, y) = t dot vec(2, 1)$ (or $y = 1/2 x$)],
    )
  ],

  task(topic: "Descriptive statistics: frequency tables",
    calculator: false)[
    20 students were asked how many siblings they have.
    #align(center, table(
      columns: 5,
      inset: (x: 8pt, y: 4pt),
      [siblings], [0], [1], [2], [3],
      [students], [4], [9], [5], [2],
    ))
    Find the mean, the median, and the mode.
  ][
    Mean $(0 dot 4 + 1 dot 9 + 2 dot 5 + 3 dot 2) / 20 = 25/20 = 1.25$.
    Median: the 10th and 11th values are both 1, so the median is 1.
    Mode: 1.
  ],

  task(
    topic: "Vectors and trigonometry: adding displacements",
    calculator: true,
    difficulty: 3,
  )[
    A hiker walks 3 km due east, then 4 km in the direction $30 degree$
    north of east. How far is she from her starting point, and in which
    direction?
  ][
    Components: $vec(3, 0) + vec(4 dot cos(30 degree), 4 dot sin(30 degree))
    approx vec(6.46, 2)$. Distance $sqrt(6.46^2 + 2^2) approx 6.77$ km,
    direction $arctan(2 / 6.46) approx 17.2 degree$ north of east.
  ],
)


#review-sheet(
  track: "glf",
  term: "3a",
  number: 3,
  draws-on: (
    "linear and exponential growth",
    "logarithms",
    "combinatorics and probability",
    "vectors and lines",
  ),

  task(topic: "Growth: linear or exponential?", calculator: false)[
    Linear or exponential? Write a function for each (start value
    $A$, time $t$ in the given unit).
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [Savings grow by CHF 50 per year.],
      [Savings grow by 3% per year.],
      [A quantity halves every 5 years.],
      [A tank loses 200 liters per hour.],
    )
  ][
    #auto-parts(
      2,
      [Linear: $A + 50 dot t$],
      [Exponential: $A dot 1.03^t$],
      [Exponential: $A dot 0.5^(t \/ 5)$],
      [Linear: $A - 200 dot t$],
    )
  ],

  task(
    topic: "Exponential equations with logarithms",
    calculator: true,
    difficulty: 2,
  )[
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Solve $2^x = 20$.],
      [CHF #num(1000) earns 4% interest per year. When will it have
        grown to CHF #num(1500)?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$x = log(20) / log(2) approx 4.32$],
      [$1.04^t = 1.5$ gives $t = log(1.5) / log(1.04) approx 10.3$:
        after 11 years.],
    )
  ],

  task(
    topic: "Combinatorics and probability: PIN codes",
    calculator: false,
    difficulty: 2,
  )[
    A 4-digit PIN is chosen at random.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [What is the probability that all four digits are different?],
      [What is the probability that it contains at least one 0?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$(10 dot 9 dot 8 dot 7) / 10^4 = #num(5040) / #num(10000)
        = 0.504$],
      [Complement, no 0 at all: $1 - 0.9^4 = 1 - 0.6561 = 0.3439$],
    )
  ],

  task(topic: "Vectors and lines", calculator: false, difficulty: 2)[
    Let $A = (2, -1, 3)$ and $B = (4, 3, -1)$.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Find the distance $abs(arrow(A B))$.],
      [Find the point $C$ on the segment $A B$ with
        $abs(arrow(A C)) = 1/4 dot abs(arrow(A B))$.],
      [Does $(8, 11, -9)$ lie on the line through $A$ and $B$?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$arrow(A B) = vec(2, 4, -4)$, length $sqrt(4 + 16 + 16) = 6$],
      [$C = A + 1/4 dot arrow(A B) = (2.5, 0, 2)$],
      [$A + 3 dot arrow(A B) = (8, 11, -9)$: yes, with $t = 3$],
    )
  ],

  task(
    topic: "Probability: equally likely outcomes",
    calculator: false,
    difficulty: 2,
  )[
    Mia tosses two coins and says: "There are three outcomes: 0, 1, or
    2 heads. So $p("exactly 1 head") = 1/3$." Is she right?
  ][
    No: the three outcomes are not equally likely. The equally likely
    outcomes are HH, HT, TH, TT; exactly one head happens in 2 of 4, so
    the probability is $1/2$.
  ],
)


// ════════════════════════════════════════════════════════════
//  GLF — YEAR 3, 2nd SEMESTER (draws on years 1–2 + planes,
//  sequences and series)
// ════════════════════════════════════════════════════════════

#review-sheet(
  track: "glf",
  term: "3b",
  number: 1,
  draws-on: (
    "sequences and series",
    "planes",
    "lines and planes",
    "exponential functions",
  ),

  task(topic: "Sequences: recognizing the type", calculator: false)[
    Arithmetic, geometric, or neither? Give the next term and an
    explicit formula for $a_n$ (with $a_1$ the first term).
    #auto-parts(
      4,
      [$7, 11, 15, 19, ...$],
      [$3, 6, 12, 24, ...$],
      [$1, 4, 9, 16, ...$],
      [$80, 20, 5, 1.25, ...$],
    )
  ][
    #auto-parts(
      2,
      [Arithmetic, difference $4$: $23$; $a_n = 7 + 4 dot (n - 1)$],
      [Geometric, ratio $2$: $48$; $a_n = 3 dot 2^(n - 1)$],
      [Neither (the squares): $25$; $a_n = n^2$],
      [Geometric, ratio $1/4$: $0.3125$;
        $a_n = 80 dot (1/4)^(n - 1)$],
    )
  ],

  task(topic: "Planes: the coordinate form", calculator: false)[
    The plane $E$ is given by $2x - y + 2z = 6$.
    #auto-parts(
      3,
      [Find the points where $E$ meets the three axes.],
      [Give a normal vector of $E$.],
      [Does $P = (1, 2, 3)$ lie in $E$?],
    )
  ][
    #auto-parts(
      3,
      [$(3, 0, 0)$, $(0, -6, 0)$, $(0, 0, 3)$],
      [$arrow(n) = vec(2, -1, 2)$ (the coefficients)],
      [$2 - 2 + 6 = 6$: yes],
    )
  ],

  task(
    topic: "Lines and planes: intersection",
    calculator: false,
    difficulty: 2,
  )[
    Find the intersection point of the plane $E: 2x - y + 2z = 6$ and
    the line $g: vec(x, y, z) = vec(1, 1, 1) + t dot vec(1, 1, 1)$.
  ][
    Substitute the coordinates of $g$ into $E$:
    $2 dot (1 + t) - (1 + t) + 2 dot (1 + t) = 3 + 3t = 6$, so $t = 1$.
    Intersection point $(2, 2, 2)$; check: $4 - 2 + 4 = 6$.
  ],

  task(
    topic: "Exponential functions: half-life",
    calculator: true,
    difficulty: 2,
  )[
    A patient receives 400 mg of a drug. Its half-life in the body is
    6 hours.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [How much of the drug is left after 15 hours?],
      [After how many hours is less than 50 mg left? (This one works
        without a calculator.)],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$400 dot 0.5^(15 / 6) approx 70.7$ mg],
      [$50 / 400 = 1/8 = 0.5^3$: three half-lives, so after 18 hours.],
    )
  ],

  task(
    topic: "Series: sums of arithmetic sequences",
    calculator: false,
    difficulty: 2,
  )[
    Young Gauss is said to have found $1 + 2 + 3 + dots.c + 100 = 5050$.
    Lukas argues: "The even numbers are half of these, so
    $2 + 4 + 6 + dots.c + 100 = 5050 / 2 = 2525$." Find his mistake and
    calculate the correct sum.
  ][
    The even numbers are half of the _terms_, but each even number is
    bigger than the odd number before it, so their sum is more than
    half. Correct: $2 + 4 + dots.c + 100 = 2 dot (1 + 2 + dots.c + 50)
    = 2 dot 1275 = 2550$ (or 50 terms with average $51$). The odd
    numbers give $2500$, and $2550 + 2500 = 5050$.
  ],
)


#review-sheet(
  track: "glf",
  term: "3b",
  number: 2,
  draws-on: (
    "lines and planes",
    "dot product",
    "geometric series",
    "combinatorics and probability",
    "sequences and logarithms",
  ),

  task(topic: "Lines and planes: recognizing the object",
    calculator: false)[
    All of these describe objects in space. Line or plane? For each
    plane, give a normal vector.
    #auto-parts(
      2,
      row-gutter: 1em,
      [$3x - y + z = 4$],
      [$vec(x, y, z) = vec(1, 0, 2) + t dot vec(1, 1, 0)$],
      [$x = 2$],
      [$vec(x, y, z) = vec(0, 0, 1) + s dot vec(1, 0, 0)
        + t dot vec(0, 1, 0)$],
    )
  ][
    #auto-parts(
      2,
      [Plane, $arrow(n) = vec(3, -1, 1)$],
      [Line (one parameter)],
      [Plane parallel to the $y z$-plane, $arrow(n) = vec(1, 0, 0)$],
      [Plane (two parameters): the plane $z = 1$,
        $arrow(n) = vec(0, 0, 1)$],
    )
  ],

  task(
    topic: "Dot product: angles and right angles",
    calculator: true,
    difficulty: 2,
  )[
    Let $arrow(a) = vec(1, 2, 2)$ and $arrow(b) = vec(2, -1, 2)$.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Calculate the angle between $arrow(a)$ and $arrow(b)$.],
      [For which $k$ is $vec(1, k, 2)$ perpendicular to $arrow(b)$?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$arrow(a) dot arrow(b) = 2 - 2 + 4 = 4$,
        $abs(arrow(a)) = abs(arrow(b)) = 3$, so $cos(phi) = 4/9$ and
        $phi approx 63.6 degree$],
      [$2 - k + 4 = 0$, so $k = 6$],
    )
  ],

  task(
    topic: "Geometric series: savings plans",
    calculator: true,
    difficulty: 2,
  )[
    Every January 1st, Sara pays CHF #num(1000) into an account with
    2% annual interest. Interest is added at the end of each year.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [How much is her first payment worth at the end of year 10?],
      [How much is in the account at the end of year 10?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$#num(1000) dot 1.02^(10) approx #num(1218.99)$ CHF],
      [$#num(1000) dot (1.02 + 1.02^2 + dots.c + 1.02^(10))
        = #num(1000) dot 1.02 dot (1.02^(10) - 1) / 0.02
        approx #num(11168.72)$ CHF],
    )
  ],

  task(
    topic: "Combinatorics and probability: a mini lottery",
    calculator: false,
    difficulty: 2,
  )[
    In a mini lottery you choose 3 of the numbers 1 to 10, and then 3
    numbers are drawn.
    #auto-parts(
      2,
      [What is the probability of getting all 3 right?],
      [What is the probability of getting exactly 2 right?],
    )
  ][
    #auto-parts(
      2,
      [$binom(10, 3) = 120$ possible draws: $p = 1/120$],
      [$(binom(3, 2) dot binom(7, 1)) / 120 = 21/120 = 7/40$],
    )
  ],

  task(
    topic: "Sequences and logarithms: when is a term large?",
    calculator: true,
    difficulty: 2,
  )[
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Which term of the sequence $3, 6, 12, 24, ...$ is the first to
        exceed #num(10000)?],
      [A geometric sequence is an exponential function evaluated at
        whole numbers. Which kind of function does an arithmetic
        sequence correspond to?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$3 dot 2^(n - 1) > #num(10000)$ gives
        $n - 1 > log_2(#num(10000) / 3) approx 11.7$, so $n = 13$:
        $a_(13) = #num(12288)$ (while $a_(12) = #num(6144)$).],
      [A linear function: a constant difference is a constant slope.],
    )
  ],
)


#review-sheet(
  track: "glf",
  term: "3b",
  number: 3,
  draws-on: (
    "sequences",
    "planes",
    "arithmetic series",
    "probability",
    "dot product",
  ),

  task(topic: "Sequences: recursive and explicit", calculator: false)[
    Give the other form: explicit for a recursive sequence, recursive for
    an explicit one.
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [$a_1 = 2$, $a_(n + 1) = a_n + 5$],
      [$a_n = 3 dot 2^n$],
      [$a_1 = 100$, $a_(n + 1) = 0.9 dot a_n$],
      [$a_n = 4n + 1$],
    )
  ][
    #auto-parts(
      2,
      [$a_n = 5n - 3$],
      [$a_1 = 6$, $a_(n + 1) = 2 dot a_n$],
      [$a_n = 100 dot 0.9^(n - 1)$],
      [$a_1 = 5$, $a_(n + 1) = a_n + 4$],
    )
  ],

  task(
    topic: "Planes: from parametric to coordinate form",
    calculator: false,
    difficulty: 2,
  )[
    Find a coordinate equation of
    $E: vec(x, y, z) = vec(1, 0, 0) + s dot vec(1, 1, 0)
    + t dot vec(0, 1, 1)$.
  ][
    A normal vector $vec(a, b, c)$ is perpendicular to both direction
    vectors: $a + b = 0$ and $b + c = 0$, e.g. $arrow(n) = vec(1, -1, 1)$.
    With $(1, 0, 0)$: $x - y + z = 1$.
  ],

  task(
    topic: "Arithmetic series",
    calculator: false,
    difficulty: 2,
  )[
    Find the sum of all multiples of 7 between 1 and 100.
  ][
    $7 + 14 + dots.c + 98$: 14 terms, sum
    $14 dot (7 + 98) / 2 = 735$.
  ],

  task(
    topic: "Probability: tree diagrams",
    calculator: false,
    difficulty: 2,
  )[
    A bent coin shows heads with probability 0.6. It is tossed three
    times. Find the probability of exactly two heads.
  ][
    Three paths (HHT, HTH, THH), each $0.6^2 dot 0.4 = 0.144$:
    $3 dot 0.144 = 0.432$.
  ],

  task(
    topic: "Dot product: right angles and areas",
    calculator: false,
    difficulty: 3,
  )[
    Show that the triangle with $A = (1, 2, 0)$, $B = (3, 3, 2)$, and
    $C = (2, 2, -1)$ has a right angle at $A$, and find its area.
  ][
    $arrow(A B) = vec(2, 1, 2)$, $arrow(A C) = vec(1, 0, -1)$,
    $arrow(A B) dot arrow(A C) = 2 + 0 - 2 = 0$. Area
    $1/2 dot 3 dot sqrt(2) = (3 sqrt(2))/2 approx 2.12$.
  ],
)


// ════════════════════════════════════════════════════════════
//  GLF — YEAR 4, 1st SEMESTER (draws on years 1–3, including
//  differential calculus)
// ════════════════════════════════════════════════════════════

#review-sheet(
  track: "glf",
  term: "4a",
  number: 1,
  draws-on: (
    "derivatives",
    "quadratic functions",
    "rates of change",
    "probability and logarithms",
  ),

  task(topic: "Derivatives: choosing the rule", calculator: false)[
    Which rule(s) does each function need? Then differentiate.
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [$f(x) = 3x^4 - 2x + 7$],
      [$g(x) = x^2 dot sin(x)$],
      [$h(x) = (2x + 1)^5$],
      [$k(x) = x / (x + 1)$],
    )
  ][
    #auto-parts(
      2,
      [Power and sum rule: $f'(x) = 12x^3 - 2$],
      [Product rule: $g'(x) = 2x dot sin(x) + x^2 dot cos(x)$],
      [Chain rule: $h'(x) = 5 dot (2x + 1)^4 dot 2 = 10 dot (2x + 1)^4$],
      [Quotient rule:
        $k'(x) = ((x + 1) - x) / (x + 1)^2 = 1 / (x + 1)^2$],
    )
  ],

  task(
    topic: "Derivatives: tangent lines",
    calculator: false,
    difficulty: 2,
  )[
    Let $f(x) = x^2 - 4x + 1$.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Find the equation of the tangent to the graph of $f$ at $x = 3$.],
      [Where is the tangent horizontal? What do you know about this
        point from earlier work on parabolas?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$f(3) = -2$, $f'(x) = 2x - 4$, $f'(3) = 2$:
        $y = 2 dot (x - 3) - 2 = 2x - 8$],
      [$f'(x) = 0$ at $x = 2$: the point $(2, -3)$, which is the vertex
        of the parabola.],
    )
  ],

  task(
    topic: "Rates of change: average and instantaneous",
    calculator: false,
    difficulty: 2,
  )[
    A stone falls $s(t) = 5t^2$ meters in $t$ seconds.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Find its average speed between $t = 1$ and $t = 3$.],
      [Find its speed at the instant $t = 2$.],
      [Explain both results as slopes in the graph of $s$.],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$(s(3) - s(1)) / (3 - 1) = (45 - 5) / 2 = 20$ m/s],
      [$s'(t) = 10t$, so $s'(2) = 20$ m/s (equal here, because for a
        parabola the secant over an interval is parallel to the tangent
        at its midpoint)],
      [(a) is the slope of the secant through $(1, 5)$ and $(3, 45)$;
        (b) is the slope of the tangent at $(2, 20)$.],
    )
  ],

  task(
    topic: "Probability: \"at least one\"",
    calculator: true,
    difficulty: 2,
  )[
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [What is the probability of rolling at least one six in four
        rolls of a die?],
      [How many rolls do you need so that the probability of at least
        one six is above 90%?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Complement: $1 - (5/6)^4 approx 0.518$],
      [$1 - (5/6)^n > 0.9$, so $(5/6)^n < 0.1$ and
        $n > (log(0.1)) / (log(5/6)) approx 12.6$: 13 rolls.],
    )
  ],

  task(
    topic: "Derivatives: the product rule",
    calculator: false,
    difficulty: 2,
  )[
    Ben differentiates $f(x) = x^2 dot x^3$ as
    $f'(x) = 2x dot 3x^2 = 6x^3$. Show that he is wrong by simplifying
    $f$ first, and state the rule he should have used.
  ][
    $f(x) = x^5$, so $f'(x) = 5x^4$, not $6x^3$. The derivative of a
    product is _not_ the product of the derivatives. Product rule:
    $f'(x) = 2x dot x^3 + x^2 dot 3x^2 = 5x^4$.
  ],
)


#review-sheet(
  track: "glf",
  term: "4a",
  number: 2,
  draws-on: (
    "derivatives",
    "planes",
    "descriptive statistics",
    "lines and trigonometry",
  ),

  task(
    topic: "Derivatives: reading the sign of f'",
    calculator: false,
  )[
    The derivative of a function $f$ is $f'(x) = (x - 1) dot (x + 2)$.
    Without finding $f$: where is $f$ increasing, where decreasing, and
    where does it have a local maximum or minimum?
  ][
    $f'$ has zeros at $x = -2$ and $x = 1$; it is positive for $x < -2$
    and $x > 1$, negative in between. So $f$ increases, then decreases,
    then increases: local maximum at $x = -2$, local minimum at $x = 1$.
  ],

  task(
    topic: "Derivatives: exponential, logarithm, roots, powers",
    calculator: false,
  )[
    Differentiate.
    #auto-parts(
      4,
      [$4 dot e^(3x)$],
      [$ln(x^2 + 1)$],
      [$sqrt(x)$],
      [$5 / x^2$],
    )
  ][
    #auto-parts(
      4,
      [$12 dot e^(3x)$],
      [$(2x) / (x^2 + 1)$],
      [$1 / (2 sqrt(x))$],
      [$-10 / x^3$],
    )
  ],

  task(
    topic: "Planes: point and normal vector",
    calculator: false,
    difficulty: 2,
  )[
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Find a coordinate equation of the plane $E$ through
        $P = (1, 2, 3)$ with normal vector $arrow(n) = vec(2, 1, -2)$.],
      [Does $Q = (0, 0, 1)$ lie in $E$?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$2x + y - 2z = d$ with $d = 2 + 2 - 6 = -2$:
        $E: 2x + y - 2z = -2$],
      [$0 + 0 - 2 = -2$: yes.],
    )
  ],

  task(topic: "Descriptive statistics: working backward",
    calculator: false)[
    Five values have a mean of 12. Four of them are 8, 10, 15, and 17.
    Find the fifth value and the median of all five.
  ][
    The sum is $5 dot 12 = 60$, so the fifth value is
    $60 - 50 = 10$. Sorted: $8, 10, 10, 15, 17$, median $10$.
  ],

  task(
    topic: "Derivatives, lines, and trigonometry: two tangents",
    calculator: true,
    difficulty: 3,
  )[
    The tangents to the parabola $y = x^2$ at $x = 1$ and at $x = -1$
    intersect. Find the intersection point and the acute angle between
    the two tangents.
  ][
    Slopes $plus.minus 2$: $y = 2x - 1$ and $y = -2x - 1$, which meet at
    $(0, -1)$. Each makes the angle $arctan(2) approx 63.4 degree$ with
    the $x$-axis, so the angle between them is
    $180 degree - 2 dot 63.4 degree approx 53.1 degree$.
  ],
)


#review-sheet(
  track: "glf",
  term: "4a",
  number: 3,
  draws-on: (
    "derivatives",
    "the difference quotient",
    "combinatorics",
    "exponential functions",
  ),

  task(topic: "Derivatives: the basic list", calculator: false)[
    Give the derivative. These should be automatic.
    #auto-parts(
      4,
      [$5$],
      [$1/x$],
      [$e^x$],
      [$sin(x)$],
    )
  ][
    #auto-parts(
      4,
      [$0$],
      [$-1/x^2$],
      [$e^x$],
      [$cos(x)$],
    )
  ],

  task(
    topic: "Derivatives: tangent to an exponential curve",
    calculator: false,
    difficulty: 2,
  )[
    Find the tangent to the graph of $f(x) = e^(2x)$ at $x = 0$.
  ][
    $f(0) = 1$, $f'(x) = 2 dot e^(2x)$, $f'(0) = 2$: $y = 2x + 1$.
  ],

  task(
    topic: "Derivatives: the difference quotient",
    calculator: false,
    difficulty: 2,
  )[
    For $f(x) = x^2$, simplify the difference quotient
    $(f(3 + h) - f(3)) / h$ and let $h -> 0$. What does the result mean?
  ][
    $((3 + h)^2 - 9) / h = (6h + h^2) / h = 6 + h -> 6$. It is
    $f'(3)$: the slope of the tangent at $x = 3$, as the limit of secant
    slopes.
  ],

  task(
    topic: "Combinatorics: arrangements with a condition",
    calculator: false,
    difficulty: 2,
  )[
    Five friends sit in a row. Anna and Ben insist on sitting next to
    each other. How many seating orders are possible?
  ][
    Treat Anna and Ben as one block: $4! = 24$ orders, times 2 for
    their order within the block: 48.
  ],

  task(
    topic: "Derivatives of exponential growth",
    calculator: false,
    difficulty: 2,
  )[
    A population grows as $N(t) = 500 dot e^(0.04 t)$ ($t$ in years).
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Find the growth rate at $t = 0$.],
      [Show that $N'(t) = 0.04 dot N(t)$. What does this say in words?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$N'(t) = 20 dot e^(0.04 t)$, $N'(0) = 20$ per year],
      [$N'(t) = 0.04 dot 500 dot e^(0.04 t) = 0.04 dot N(t)$: the growth
        rate is always 4% of the current population.],
    )
  ],
)


// ════════════════════════════════════════════════════════════
//  GLF — YEAR 4, 2nd SEMESTER (Matura run-in: years 1–4a,
//  including integrals, optimization, and probability)
// ════════════════════════════════════════════════════════════

#review-sheet(
  track: "glf",
  term: "4b",
  number: 1,
  draws-on: (
    "integrals",
    "binomial distribution",
    "optimization",
    "conditional probability",
  ),

  task(topic: "Choosing the tool", calculator: false)[
    Do _not_ solve. Name the tool each question calls for, and say why.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [The area between the graph of $f$ and the $x$-axis from $x = 0$
        to $x = 4$.],
      [The largest possible volume of an open box folded from a sheet
        of cardboard.],
      [The probability of exactly 3 defective bulbs in a pack of 10.],
      [The probability that a person is ill, given a positive test.],
    )
  ][
    #auto-parts(
      2,
      [Integral (watch for parts below the axis)],
      [Optimization: derivative $= 0$, then check],
      [Binomial distribution ($n = 10$, independent bulbs)],
      [Conditional probability: tree diagram or table],
    )
  ],

  task(topic: "Integrals: values and areas", calculator: false,
    difficulty: 2)[
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Calculate $integral_0^2 (3x^2 - 2x) dif x$.],
      [Find the area enclosed by the graphs of $f(x) = x^2$ and
        $g(x) = 2x$.],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$lr([x^3 - x^2])_0^2 = 8 - 4 = 4$],
      [Intersections: $x^2 = 2x$ at $x = 0$ and $x = 2$; between them
        $g$ lies above $f$:
        $integral_0^2 (2x - x^2) dif x = lr([x^2 - x^3 / 3])_0^2
        = 4 - 8/3 = 4/3$],
    )
  ],

  task(
    topic: "Binomial distribution: guessing on a test",
    calculator: true,
    difficulty: 2,
  )[
    A multiple-choice test has 10 questions with 4 options each. Lena
    guesses every answer. Let $X$ be the number of correct answers.
    #wide-parts(
      (1fr, 1fr, 2fr),
      [Find $p(X = 3)$.],
      [Find $p(X >= 5)$.],
      [How many correct answers can she expect?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$binom(10, 3) dot 0.25^3 dot 0.75^7 approx 0.250$],
      [$1 - p(X <= 4) approx 0.078$ (binomcdf)],
      [$E(X) = n dot p = 10 dot 0.25 = 2.5$],
    )
  ],

  task(
    topic: "Optimization: the largest area",
    calculator: false,
    difficulty: 2,
  )[
    A farmer fences a rectangular pen along a straight wall, using
    40 m of fence for the other three sides. Which dimensions give the
    largest area?
  ][
    With $x$ the side perpendicular to the wall:
    $A(x) = x dot (40 - 2x) = 40x - 2x^2$, $A'(x) = 40 - 4x = 0$ at
    $x = 10$. So 10 m by 20 m, area 200 m². (Check: $A$ is a downward
    parabola, so this is its vertex, the maximum.)
  ],

  task(
    topic: "Conditional probability: medical tests",
    calculator: false,
    difficulty: 2,
  )[
    A disease affects 1% of the population. A test detects it in 99% of
    ill people, but also gives a positive result for 1% of healthy
    people. Mila says: "A positive test means you are 99% likely to be
    ill." Check her claim with a tree diagram or a table.
  ][
    Per #num(10000) people: 100 are ill, 99 of them test positive;
    #num(9900) are healthy, 99 of them test positive. So
    $p("ill" | "positive") = 99 / (99 + 99) = 50%$. Mila confuses
    $p("positive" | "ill")$ with $p("ill" | "positive")$.
  ],
)


#review-sheet(
  track: "glf",
  term: "4b",
  number: 2,
  draws-on: (
    "function types",
    "integrals",
    "trigonometry",
    "lines and planes",
  ),

  task(topic: "Function types: recognizing by property",
    calculator: false)[
    Which type of function (linear, quadratic, exponential,
    trigonometric) has each property?
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [It grows by the same factor in each step.],
      [Its slope is the same everywhere.],
      [Its values repeat after a fixed interval.],
      [Its graph is symmetric about a vertical line.],
    )
  ][
    #auto-parts(
      4,
      [Exponential],
      [Linear],
      [Trigonometric],
      [Quadratic],
    )
  ],

  task(
    topic: "Integrals: accumulated change",
    calculator: false,
    difficulty: 2,
  )[
    Water flows into a tank at a rate of $r(t) = 6 + 2t$ liters per
    minute, for $0 <= t <= 5$ (in minutes).
    #auto-parts(
      2,
      [How much water flows in during these 5 minutes?],
      [What is the average inflow rate?],
    )
  ][
    #auto-parts(
      2,
      [$integral_0^5 (6 + 2t) dif t = lr([6t + t^2])_0^5 = 55$ liters],
      [$55 / 5 = 11$ liters per minute],
    )
  ],

  task(
    topic: "Antiderivatives: finding the constant",
    calculator: false,
  )[
    Find the function $F$ with $F'(x) = 3x^2 - 4$ and $F(1) = 2$.
  ][
    $F(x) = x^3 - 4x + C$; $F(1) = 1 - 4 + C = 2$ gives $C = 5$, so
    $F(x) = x^3 - 4x + 5$.
  ],

  task(
    topic: "Trigonometry: general triangles",
    calculator: true,
    difficulty: 2,
  )[
    A triangular field has two sides of 50 m and 70 m that meet at an
    angle of $110 degree$. Find the area of the field and the length of
    its third side.
  ][
    Area $1/2 dot 50 dot 70 dot sin(110 degree) approx #num(1644)$ m².
    Third side: $c^2 = 50^2 + 70^2 - 2 dot 50 dot 70 dot cos(110 degree)$,
    so $c approx 99.0$ m.
  ],

  task(
    topic: "Lines and planes: distance from a point to a plane",
    calculator: false,
    difficulty: 3,
  )[
    Let $E: x + 2y - 2z = -12$ and $P = (3, 1, 4)$. Find the point of
    $E$ closest to $P$ and the distance from $P$ to $E$. (Hint: use the
    line through $P$ perpendicular to $E$.)
  ][
    $g: vec(x, y, z) = vec(3, 1, 4) + t dot vec(1, 2, -2)$. Into $E$:
    $(3 + t) + 2 dot (1 + 2t) - 2 dot (4 - 2t) = -3 + 9t = -12$, so
    $t = -1$ and the closest point is $F = (2, -1, 6)$. Distance
    $abs(arrow(F P)) = abs(vec(1, 2, -2)) = 3$.
  ],
)



#review-sheet(
  track: "glf",
  term: "4b",
  number: 3,
  draws-on: (
    "meaning of the integral",
    "optimization",
    "binomial distribution",
    "conditional probability",
  ),

  task(topic: "Integrals: what does the integral mean?",
    calculator: false)[
    What does each integral represent?
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$integral_0^(10) v(t) dif t$, where $v$ is a velocity in m/s],
      [$integral_0^(60) r(t) dif t$, where $r$ is an inflow rate in
        liters per minute],
      [$integral_a^b (f(x) - g(x)) dif x$, where $a, b$ are the
        intersections and $f >= g$ in between],
      [$1/(b - a) dot integral_a^b f(x) dif x$],
    )
  ][
    #auto-parts(
      2,
      [Displacement in the first 10 s (in m)],
      [Liters that flow in during one hour],
      [Area between the two graphs],
      [Average value of $f$ on $[a, b]$],
    )
  ],

  task(
    topic: "Optimization: the open box",
    calculator: false,
    difficulty: 3,
  )[
    From a 12 cm × 12 cm sheet, squares of side $x$ are cut from the
    corners and the sides folded up into an open box. Which $x$ gives
    the largest volume?
  ][
    $V(x) = x dot (12 - 2x)^2$ for $0 < x < 6$;
    $V'(x) = (12 - 2x) dot (12 - 6x) = 0$ at $x = 2$ (or $x = 6$, no
    box). $V(2) = 128$ cm³.
  ],

  task(
    topic: "Binomial distribution",
    calculator: true,
    difficulty: 2,
  )[
    5% of eggs are cracked. A carton holds 10 eggs.
    #auto-parts(
      2,
      [Find $p("no egg cracked")$.],
      [Find $p("at most one egg cracked")$.],
    )
  ][
    #auto-parts(
      2,
      [$0.95^(10) approx 0.599$],
      [$0.95^(10) + 10 dot 0.05 dot 0.95^9 approx 0.914$],
    )
  ],

  task(
    topic: "Conditional probability: two-way tables",
    calculator: false,
    difficulty: 2,
  )[
    Of 200 students, 90 are boys and 110 are girls. 60 of the boys and
    40 of the girls play an instrument. Find
    #auto-parts(
      2,
      [$p("instrument" | "girl")$,],
      [$p("girl" | "instrument")$.],
    )
  ][
    #auto-parts(
      2,
      [$40 / 110 = 4/11 approx 0.36$],
      [$40 / 100 = 0.4$],
    )
  ],

  task(
    topic: "Integrals: Archimedes' parabola",
    calculator: false,
    difficulty: 2,
  )[
    Find the area enclosed by the parabola $y = 4 - x^2$ and the
    $x$-axis. What fraction of the surrounding rectangle
    ($-2 <= x <= 2$, $0 <= y <= 4$) is that?
  ][
    $integral_(-2)^2 (4 - x^2) dif x = lr([4x - x^3 / 3])_(-2)^2
    = 32/3$. The rectangle has area 16, so the fraction is $2/3$
    (Archimedes' result).
  ],
)


// ════════════════════════════════════════════════════════════
//  SPF — YEAR 1, 2nd SEMESTER (draws on year 1, 1st semester)
//  Mostly NO CALC: the TI-Nspire CAS would trivialize most items.
// ════════════════════════════════════════════════════════════

#review-sheet(
  track: "spf",
  term: "1b",
  number: 1,
  draws-on: (
    "the function concept",
    "algebra",
    "linear functions",
    "linear systems",
  ),

  task(topic: "Functions: what counts as a function?", calculator: false)[
    Does each rule assign to every $x$ exactly one $y$? Answer yes or no
    and give a reason.
    #auto-parts(
      2,
      [The pairs $(1, 3), (2, 3), (3, 3), (4, 3)$],
      [The pairs $(1, 4), (2, 5), (2, 6), (3, 7)$],
      [All points $(x, y)$ with $x^2 + y^2 = 25$],
      [Each date of the year $|->$ the students in the class born on
        that date],
    )
  ][
    #auto-parts(
      2,
      [Yes: a constant function; equal outputs are allowed.],
      [No: $x = 2$ has two different values.],
      [No: e.g. $x = 3$ gives $y = 4$ and $y = -4$.],
      [No: some dates have no student, others several.],
    )
  ],

  task(topic: "Algebra: fractions, factoring, formulas", calculator: false)[
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [Calculate $(2/3 - 3/4) div 5/6$.],
      [Factor completely: $2x^3 - 18x$.],
      [Solve $V = 1/3 dot pi dot r^2 dot h$ for $r$ $(r > 0)$.],
    )
  ][
    #auto-parts(
      3,
      [$-1/12 dot 6/5 = -1/10$],
      [$2x dot (x - 3) dot (x + 3)$],
      [$r = sqrt((3V)/(pi dot h))$],
    )
  ],

  task(
    topic: "Linear functions: perpendicular lines and distance",
    calculator: false,
    difficulty: 3,
  )[
    The line $g$ is given by $3x - 2y = 6$, and $P = (5, -2)$.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Write $g$ in the form $y = m dot x + b$.],
      [Find the line $h$ through $P$ perpendicular to $g$.],
      [Find the point on $g$ closest to $P$, and the distance from $P$
        to $g$.],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$y = 3/2 x - 3$],
      [Slope $-2/3$; $-2 = -2/3 dot 5 + b$ gives $b = 4/3$:
        $y = -2/3 x + 4/3$],
      [Intersect $g$ and $h$: $3/2 x - 3 = -2/3 x + 4/3$ gives $x = 2$,
        so the closest point is $Q = (2, 0)$. Distance
        $overline(P Q) = sqrt(3^2 + 2^2) = sqrt(13) approx 3.61$],
    )
  ],

  task(
    topic: "Linear systems: three equations",
    calculator: false,
    difficulty: 2,
  )[
    Solve by hand:
    $ #system(($x + y + z$, $6$), ($2x - y + z$, $3$), ($x + 2y - z$, $2$)) $
  ][
    For example, add equations 1 and 3: $2x + 3y = 8$; add equations 2
    and 3: $3x + y = 5$. Then $y = 5 - 3x$ gives $2x + 15 - 9x = 8$, so
    $x = 1$, $y = 2$, $z = 3$.
  ],

  task(
    topic: "Functions: function notation",
    calculator: false,
    difficulty: 2,
  )[
    Let $f(x) = x^2 - 2x$. Tim claims that $f(x + 1) = x^2 - 2x + 1$.
    Find his mistake and calculate $f(x + 1)$ correctly. What does the
    graph of $x |-> f(x + 1)$ look like compared to the graph of $f$?
  ][
    Tim added 1 to the _output_. Correct: replace every $x$ by
    $(x + 1)$:
    $f(x + 1) = (x + 1)^2 - 2 dot (x + 1) = x^2 + 2x + 1 - 2x - 2
    = x^2 - 1$.
    The graph is the graph of $f$ shifted 1 unit to the _left_.
  ],
)


#review-sheet(
  track: "spf",
  term: "1b",
  number: 2,
  draws-on: (
    "linear systems",
    "algebra",
    "functions as models",
    "linear functions",
  ),

  task(topic: "Linear systems: method and number of solutions",
    calculator: false)[
    Without solving completely: how many solutions does each system
    have, and which method would you use? Then solve those that have
    exactly one solution.
    // Inline (not display) math: no block spacing around each system.
    #auto-parts(
      2,
      row-gutter: 1.6em,
      [$#system(($y$, $2x - 1$), ($3x + y$, $9$))$],
      [$#system(($2x + 3y$, $7$), ($2x - 5y$, $-1$))$],
      [$#system(($x - 2y$, $4$), ($-3x + 6y$, $5$))$],
      [$#system(($y$, $3x + 1$), ($6x - 2y$, $-2$))$],
    )
  ][
    #auto-parts(
      2,
      [One; substitution ($y$ is isolated): $x = 2$, $y = 3$],
      [One; elimination (subtract): $8y = 8$, so $y = 1$, $x = 2$],
      [None: the left side of the second equation is $-3$ times the
        first, the right side is not. Parallel lines.],
      [Infinitely many: substituting gives $-2 = -2$. Same line.],
    )
  ],

  task(topic: "Algebra: scientific notation", calculator: false)[
    Give each result in scientific notation.
    #auto-parts(
      2,
      [$(3 dot 10^4) dot (5 dot 10^(-7))$],
      [$(8 dot 10^9) / (2 dot 10^(12))$],
    )
    Light travels at about $3 dot 10^8$ m/s, and the Sun is about
    $1.5 dot 10^(11)$ m from Earth. How long does sunlight take to reach
    us?
  ][
    #auto-parts(
      3,
      [$15 dot 10^(-3) = 1.5 dot 10^(-2)$],
      [$4 dot 10^(-3)$],
      [$(1.5 dot 10^(11)) / (3 dot 10^8) = 5 dot 10^2$ s $= 500$ s, about
        8 min 20 s],
    )
  ],

  task(
    topic: "Functions as models: domain in context",
    calculator: false,
    difficulty: 2,
  )[
    A taxi charges a base fare of CHF 6 plus CHF 2.50 per kilometer.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Write the fare $C$ as a function of the distance $d$ in km.],
      [What does a 12 km ride cost? How far can you go for CHF 50?],
      [Which domain makes sense here? What do the slope and the
        $y$-intercept mean?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$C(d) = 2.5 d + 6$],
      [$C(12) = 36$: CHF 36. $2.5 d + 6 = 50$ gives $d = 17.6$ km.],
      [$d >= 0$ (up to some practical maximum). Slope: CHF 2.50 per
        extra km; $y$-intercept: the base fare, paid even for 0 km.],
    )
  ],

  task(
    topic: "Linear functions: slopes and parameters",
    calculator: false,
    difficulty: 2,
  )[
    The lines $g: y = k dot x + 2$ and $h: y = -2x + 5$ depend on the
    parameter $k$. For which $k$ are they
    #wide-parts(
      (1fr, 1fr, 2fr),
      [parallel?],
      [perpendicular?],
      [intersecting at a point with $x = 1$?],
    )
  ][
    #auto-parts(
      3,
      [$k = -2$],
      [$k dot (-2) = -1$, so $k = 1/2$],
      [$k + 2 = 3$, so $k = 1$],
    )
  ],

  task(
    topic: "Linear systems: the geometric view",
    calculator: false,
    difficulty: 3,
  )[
    Do the three lines $y = x + 1$, $y = -x + 5$, and $y = 3x - 3$ pass
    through a common point? A system of three equations in two unknowns
    usually has _no_ solution. Explain geometrically why, and why this
    one is an exception.
  ][
    The first two lines meet where $x + 1 = -x + 5$: at $(2, 3)$. The
    third line passes through it too, since $3 dot 2 - 3 = 3$. In
    general, two lines fix one intersection point, and a third line
    would have to pass through exactly that point, which is unlikely.
  ],
)


#review-sheet(
  track: "spf",
  term: "1b",
  number: 3,
  draws-on: (
    "equivalence transformations",
    "algebraic fractions",
    "linear functions",
    "linear systems",
    "functions",
  ),

  task(
    topic: "Equations: which steps are equivalence transformations?",
    calculator: false,
  )[
    Does each step always keep the solution set unchanged? If not,
    explain what can go wrong.
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [Add 5 to both sides.],
      [Multiply both sides by $x$.],
      [Divide both sides by 3.],
      [Square both sides.],
    )
  ][
    #auto-parts(
      2,
      [Yes],
      [No: if $x = 0$, a false equation can become true],
      [Yes (dividing by a nonzero number)],
      [No: $x = 2$ and $x^2 = 4$ do not have the same solutions],
    )
  ],

  task(
    topic: "Algebra: fractions with variables",
    calculator: false,
    difficulty: 2,
  )[
    #auto-parts(
      2,
      [Simplify $(1/x - 1/y) / (1/x + 1/y)$.],
      [Solve $2/(x - 1) = 3/(x + 1)$.],
    )
  ][
    #auto-parts(
      2,
      [Multiply numerator and denominator by $x dot y$:
        $(y - x) / (y + x)$],
      [$2 dot (x + 1) = 3 dot (x - 1)$, so $x = 5$ (allowed, since
        $x != plus.minus 1$)],
    )
  ],

  task(
    topic: "Linear functions: families of lines",
    calculator: false,
    difficulty: 2,
  )[
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Which point do all lines $y = m dot x + 2$ have in common? For
        which $m$ does the line pass through $(4, 0)$?],
      [What do all lines $y = 2x + b$ have in common?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [All pass through $(0, 2)$. $0 = 4m + 2$ gives $m = -1/2$.],
      [The same slope: they are all parallel.],
    )
  ],

  task(
    topic: "Linear systems with a parameter",
    calculator: false,
    difficulty: 2,
  )[
    For which values of $a$ does the system
    $ #system(($x + 2y$, $3$), ($2x + a dot y$, $6$)) $
    have exactly one solution? Infinitely many? None?
  ][
    Subtract twice the first equation: $(a - 4) dot y = 0$. For
    $a != 4$: exactly one solution ($y = 0$, $x = 3$). For $a = 4$:
    infinitely many (the same line twice). Never none, because the
    right-hand sides fit together ($2 dot 3 = 6$).
  ],

  task(
    topic: "Functions: is f(a + b) = f(a) + f(b)?",
    calculator: false,
    difficulty: 2,
  )[
    Check whether $f(a + b) = f(a) + f(b)$ holds for all $a, b$:
    #auto-parts(
      3,
      [$f(x) = 3x$],
      [$f(x) = 3x + 1$],
      [$f(x) = x^2$],
    )
    Which linear functions have this property?
  ][
    #auto-parts(
      3,
      [Yes: $3 dot (a + b) = 3a + 3b$],
      [No: $3a + 3b + 1 != 3a + 3b + 2$],
      [No: $(a + b)^2 != a^2 + b^2$ in general],
    )
    Exactly the proportional ones, $f(x) = m dot x$.
  ],
)


// ════════════════════════════════════════════════════════════
//  SPF — YEAR 2, 1st SEMESTER (draws on year 1)
// ════════════════════════════════════════════════════════════

#review-sheet(
  track: "spf",
  term: "2a",
  number: 1,
  draws-on: (
    "equations",
    "trigonometric equations",
    "inverse functions",
    "regression and correlation",
    "logarithm laws",
  ),

  task(topic: "Equations: choosing the strategy", calculator: false)[
    Name a strategy for each equation, then solve it. Two of them need
    a check at the end. Which ones, and why?
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [$x^4 - 5x^2 + 4 = 0$],
      [$2^(x + 1) = 32$],
      [$sqrt(x + 7) = x + 1$],
      [$log_2(x) + log_2(x - 2) = 3$],
    )
  ][
    #auto-parts(
      2,
      [Substitute $u = x^2$: $u = 1$ or $u = 4$, so
        $x in {-2, -1, 1, 2}$],
      [Same base: $2^(x + 1) = 2^5$, so $x = 4$],
      [Square (check!): $x^2 + x - 6 = 0$ gives $x = 2$ or $x = -3$;
        $x = -3$ fails ($2 != -2$). Only $x = 2$.],
      [Log law (check the domain!): $x dot (x - 2) = 8$ gives $x = 4$
        or $x = -2$; $log_2(-2)$ is undefined. Only $x = 4$.],
    )
  ],

  task(
    topic: "Trigonometric equations",
    calculator: false,
    difficulty: 2,
  )[
    Solve for $0 <= x < 2 pi$.
    #auto-parts(
      2,
      [$2 dot sin(x) = 1$],
      [$cos(2x) = 0$],
    )
  ][
    #auto-parts(
      2,
      [$sin(x) = 1/2$: $x = pi/6$ or $x = (5 pi)/6$],
      [$2x = pi/2 + k dot pi$: $x = pi/4, (3 pi)/4, (5 pi)/4, (7 pi)/4$],
    )
  ],

  task(topic: "Inverse functions", calculator: false, difficulty: 2)[
    Let $f(x) = 3 dot 2^x + 1$.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Find the inverse function $f^(-1)$.],
      [State the range of $f$ and the domain of $f^(-1)$. How are the
        two graphs related?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$y = 3 dot 2^x + 1$ gives $2^x = (y - 1)/3$, so
        $f^(-1)(x) = log_2((x - 1)/3)$],
      [Both are $x > 1$ (range and domain swap). The graphs are mirror
        images in the line $y = x$.],
    )
  ],

  task(
    topic: "Statistics: regression and correlation",
    calculator: false,
  )[
    For 30 adults, the regression line of height $h$ (in cm) on shoe
    size $s$ is $h = 4.2s + 2.5$, with correlation coefficient
    $r = 0.85$.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Predict the height of an adult with shoe size 40, and interpret
        the slope.],
      [Would you use the line for a child with shoe size 25? What does
        $r = 0.85$ tell you, and what does it _not_ tell you?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$4.2 dot 40 + 2.5 = 170.5$ cm. Each extra shoe size goes with
        about 4.2 cm more height, on average.],
      [No: the data are adults only, so this is extrapolation. $r$
        shows a strong positive linear relationship; it does not show
        that one causes the other.],
    )
  ],

  task(topic: "Logarithm laws", calculator: false, difficulty: 2)[
    Sven writes: $log(2) + log(5) = log(2 + 5) = log(7)$. Find his
    mistake, state the correct law, and give the correct value.
  ][
    The sum of logarithms is the logarithm of the _product_, not of
    the sum: $log(a) + log(b) = log(a dot b)$. So
    $log(2) + log(5) = log(10) = 1$.
  ],
)


#review-sheet(
  track: "spf",
  term: "2a",
  number: 2,
  draws-on: (
    "function types",
    "trigonometric models",
    "quadratic equations",
    "general triangles",
    "exponential and logarithmic functions",
  ),

  task(topic: "Function types: reading off key features",
    calculator: false)[
    Name the type of each function and give two features you can read
    off without calculating.
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [$f(x) = 3 dot sin(2x) + 1$],
      [$g(x) = 2 dot 0.5^x$],
      [$h(x) = x^3 - 4x$],
      [$k(x) = log_3(x - 1)$],
    )
  ][
    #auto-parts(
      2,
      [Trigonometric: amplitude 3, period $pi$, range
        $-2 <= y <= 4$],
      [Exponential decay: $g(0) = 2$, asymptote $y = 0$],
      [Polynomial of degree 3: zeros $-2, 0, 2$; point-symmetric
        about the origin],
      [Logarithmic: domain $x > 1$, asymptote $x = 1$, zero at
        $x = 2$],
    )
  ],

  task(
    topic: "Trigonometric functions: modeling",
    calculator: false,
    difficulty: 2,
  )[
    The day length in Basel (in hours) is modeled by
    $ d(t) = 12.2 + 3.7 dot sin((2 pi)/365 dot (t - 80)), $
    where $t$ is the day of the year.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [What are the longest and shortest day lengths?],
      [On which day is the day longest?],
      [What does the number 80 mean?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$12.2 plus.minus 3.7$: 15.9 h and 8.5 h],
      [When the sine is 1: $(2 pi)/365 dot (t - 80) = pi/2$, so
        $t = 80 + 365/4 approx 171$ (about June 20)],
      [A shift: on day 80 (about March 21, the equinox) the day length
        equals its average of 12.2 h and is increasing.],
    )
  ],

  task(
    topic: "Quadratic equations: parameters and the discriminant",
    calculator: false,
    difficulty: 2,
  )[
    For which values of $k$ does $x^2 + k dot x + 9 = 0$ have exactly
    one solution? For which does it have none?
  ][
    $D = k^2 - 36$. Exactly one solution for $D = 0$: $k = 6$ or
    $k = -6$. None for $D < 0$: $-6 < k < 6$.
  ],

  task(
    topic: "General triangles: the ambiguous case",
    calculator: true,
    difficulty: 3,
  )[
    A triangle has $a = 5$, $b = 7$, and $alpha = 40 degree$. Find all
    possible values of $beta$, $gamma$, and $c$.
  ][
    $sin(beta) = (7 dot sin(40 degree)) / 5 approx 0.900$: two triangles.
    $beta approx 64.1 degree$, $gamma approx 75.9 degree$,
    $c approx 7.54$; or $beta approx 115.9 degree$,
    $gamma approx 24.1 degree$, $c approx 3.18$.
  ],

  task(
    topic: "Exponential functions and logarithms: straightening a curve",
    calculator: false,
    difficulty: 2,
  )[
    Let $y = 3 dot 2^x$. Show that $log(y)$ is a linear function of
    $x$, and give its slope and $y$-intercept. Why is this useful when
    you want to check whether data grow exponentially?
  ][
    $log(y) = log(3) + x dot log(2)$: a line with slope $log(2)$ and
    intercept $log(3)$. Data that grow exponentially lie on a straight
    line when $log(y)$ is plotted against $x$ (a semi-log plot), and a
    straight line is easy to recognize and fit.
  ],
)


#review-sheet(
  track: "spf",
  term: "2a",
  number: 3,
  draws-on: (
    "power laws",
    "exponential decay",
    "trigonometric functions",
    "correlation",
    "inverse functions",
  ),

  task(topic: "Power laws: true or false?", calculator: false)[
    True for all allowed values, or false? Give a counterexample for
    the false ones.
    #auto-parts(
      4,
      [$(a dot b)^n = a^n dot b^n$],
      [$(a + b)^2 = a^2 + b^2$],
      [$sqrt(a^2) = a$],
      [$a^(-2) = 1/a^2$],
    )
  ][
    #auto-parts(
      2,
      [True],
      [False: $a = b = 1$ gives $4 != 2$],
      [False: $a = -3$ gives $3$; correct is $abs(a)$],
      [True ($a != 0$)],
    )
  ],

  task(
    topic: "Exponential functions: half-life",
    calculator: true,
    difficulty: 2,
  )[
    A radioactive substance has a half-life of 30 years.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [What fraction is left after 90 years? (No calculator needed.)],
      [By what percentage does the amount decrease each year?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Three half-lives: $1/8$],
      [Yearly factor $0.5^(1 \/ 30) approx 0.9772$: a decrease of about
        2.28% per year],
    )
  ],

  task(
    topic: "Trigonometric functions: building a model",
    calculator: false,
    difficulty: 2,
  )[
    A sinusoidal function has a maximum of 7 at $x = 1$ and the next
    minimum of $-1$ at $x = 4$. Find amplitude, period, and midline, and
    give a function equation.
  ][
    Midline $y = 3$, amplitude 4, half period 3 so period 6:
    $f(x) = 4 dot cos(pi/3 dot (x - 1)) + 3$.
  ],

  task(topic: "Statistics: correlation coefficients", calculator: false)[
    Match each description to one of $r = -0.9$, $r = 0$, $r = 0.5$,
    $r = 0.95$.
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [Points close to a rising line],
      [A shapeless cloud],
      [Points close to a falling line],
      [A rising trend with a lot of scatter],
    )
    A scatterplot shows points lying exactly on a parabola $y = x^2$,
    symmetric about the $y$-axis. Why is $r approx 0$ even though the
    relationship is perfect?
  ][
    #auto-parts(
      2,
      [$r = 0.95$],
      [$r = 0$],
      [$r = -0.9$],
      [$r = 0.5$],
    )
    $r$ only measures _linear_ relationships; the falling and rising
    halves cancel out.
  ],

  task(
    topic: "Inverse functions: restricting the domain",
    calculator: false,
    difficulty: 3,
  )[
    Why does $f(x) = (x - 2)^2 + 1$ have no inverse on all of $RR$?
    Restrict $f$ to $x >= 2$ and find $f^(-1)$ with its domain.
  ][
    $f$ takes each value above 1 twice (e.g. $f(1) = f(3) = 2$). For
    $x >= 2$: $y = (x - 2)^2 + 1$ gives $x = 2 + sqrt(y - 1)$, so
    $f^(-1)(x) = 2 + sqrt(x - 1)$ for $x >= 1$.
  ],
)


// ════════════════════════════════════════════════════════════
//  SPF — YEAR 2, 2nd SEMESTER (draws on year 1 + sequences,
//  series, limits, induction, vectors)
// ════════════════════════════════════════════════════════════

#review-sheet(
  track: "spf",
  term: "2b",
  number: 1,
  draws-on: (
    "sequences and limits",
    "geometric series",
    "limits of functions",
    "dot and cross product",
    "induction",
  ),

  task(topic: "Sequences: type and convergence", calculator: false)[
    Arithmetic, geometric, or neither? Does the sequence converge, and
    if so, to what?
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [$a_1 = 5$, $a_(n + 1) = a_n + 3$],
      [$a_1 = 8$, $a_(n + 1) = -a_n / 2$],
      [$a_n = (2n + 1) / (n + 3)$],
      [$a_n = (-1)^n$],
    )
  ][
    #auto-parts(
      2,
      [Arithmetic ($a_n = 3n + 2$); diverges],
      [Geometric, ratio $-1/2$; converges to $0$],
      [Neither; converges to $2$],
      [Neither; diverges (it alternates between $-1$ and $1$)],
    )
  ],

  task(
    topic: "Geometric series: infinite sums",
    calculator: false,
    difficulty: 2,
  )[
    #auto-parts(
      2,
      [Find $1 + 1/3 + 1/9 + 1/27 + dots.c$],
      [Write $0.272727...$ as a fraction, using a geometric series.],
    )
  ][
    #auto-parts(
      2,
      [$1 / (1 - 1/3) = 3/2$],
      [$27/100 + 27/(100^2) + dots.c = (27/100) / (1 - 1/100)
        = 27/99 = 3/11$],
    )
  ],

  task(topic: "Limits of sequences and functions", calculator: false,
    difficulty: 2)[
    #auto-parts(
      3,
      [$lim_(n -> oo) (3n^2 - n) / (n^2 + 5)$],
      [$lim_(x -> 2) (x^2 - 4) / (x - 2)$],
      [$lim_(x -> oo) (2x + 1) / (x^2 + 1)$],
    )
  ][
    #auto-parts(
      3,
      [Divide by $n^2$: $3$],
      [$((x - 2) dot (x + 2)) / (x - 2) = x + 2 -> 4$],
      [$0$: the graph has the asymptote $y = 0$],
    )
  ],

  task(topic: "Vectors: dot and cross product", calculator: false,
    difficulty: 2)[
    Let $arrow(a) = vec(1, 2, -1)$ and $arrow(b) = vec(3, 0, 1)$.
    #wide-parts(
      (1fr, 1fr, 2.2fr),
      [Calculate $arrow(a) dot arrow(b)$.],
      [Calculate $arrow(a) times arrow(b)$.],
      [Find the area of the triangle spanned by $arrow(a)$ and
        $arrow(b)$.],
    )
  ][
    #auto-parts(
      3,
      [$3 + 0 - 1 = 2$],
      [$vec(2, -4, -6)$ (check: perpendicular to both)],
      [$1/2 dot sqrt(4 + 16 + 36) = sqrt(14) approx 3.74$],
    )
  ],

  task(topic: "Proof by induction", calculator: false, difficulty: 2)[
    Prove by induction that for every $n >= 1$:
    $ 1 + 3 + 5 + dots.c + (2n - 1) = n^2 $
  ][
    Base case $n = 1$: $1 = 1^2$. Induction step: assume
    $1 + 3 + dots.c + (2n - 1) = n^2$. Adding the next odd number
    $2n + 1$ gives $n^2 + 2n + 1 = (n + 1)^2$, which is the statement
    for $n + 1$.
  ],
)


#review-sheet(
  track: "spf",
  term: "2b",
  number: 2,
  draws-on: (
    "vectors",
    "exponential equations",
    "arithmetic and geometric series",
    "trigonometric functions",
  ),

  task(topic: "Vectors: choosing the tool", calculator: false)[
    Dot product or cross product? Say which you would use, and how.
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [The angle between two vectors],
      [A normal vector to the plane spanned by $arrow(u)$ and
        $arrow(v)$],
      [The area of a parallelogram],
      [Checking whether two vectors are perpendicular],
    )
  ][
    #auto-parts(
      2,
      [Dot product:
        $cos(phi) = (arrow(u) dot arrow(v)) / (abs(arrow(u)) dot
        abs(arrow(v)))$],
      [Cross product: $arrow(u) times arrow(v)$],
      [Length of the cross product $abs(arrow(u) times arrow(v))$],
      [Dot product: $arrow(u) dot arrow(v) = 0$],
    )
  ],

  task(
    topic: "Exponential equations: substitution",
    calculator: false,
    difficulty: 2,
  )[
    Solve $4^x - 3 dot 2^x - 4 = 0$. (Hint: $4^x = (2^x)^2$.)
  ][
    With $u = 2^x$: $u^2 - 3u - 4 = (u - 4) dot (u + 1) = 0$, so
    $u = 4$ or $u = -1$. Since $2^x > 0$, only $2^x = 4$: $x = 2$.
  ],

  task(
    topic: "Arithmetic series: counting seats",
    calculator: false,
    difficulty: 2,
  )[
    A theater has 20 seats in the first row, and each row has 2 seats
    more than the row in front of it.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [How many seats do the first 25 rows have together?],
      [Show that the first $n$ rows have $n dot (n + 19)$ seats.],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Row 25 has $20 + 24 dot 2 = 68$ seats; total
        $25 dot (20 + 68) / 2 = #num(1100)$.],
      [Row $n$ has $2n + 18$ seats; total
        $n dot (20 + 2n + 18) / 2 = n dot (n + 19)$.],
    )
  ],

  task(
    topic: "Trigonometric functions: transformations",
    calculator: false,
    difficulty: 2,
  )[
    Describe how the graph of $f(x) = 2 dot cos(x - pi/3)$ arises from
    the graph of $cos(x)$. Give the period of $f$ and its highest point
    for $0 <= x < 2 pi$.
  ][
    Stretched vertically by factor 2, shifted $pi/3$ to the right.
    Period $2 pi$; highest point $(pi/3, 2)$.
  ],

  task(
    topic: "Geometric series: a bouncing ball",
    calculator: false,
    difficulty: 3,
  )[
    A ball is dropped from a height of 5 m. After each bounce it rises
    to 60% of its previous height. What total distance does it travel
    if it keeps bouncing forever?
  ][
    Down 5 m, then up and down $3 + 1.8 + 1.08 + dots.c$ each:
    $5 + 2 dot 3 / (1 - 0.6) = 5 + 15 = 20$ m.
  ],
)


#review-sheet(
  track: "spf",
  term: "2b",
  number: 3,
  draws-on: (
    "limits of sequences",
    "induction",
    "vectors",
    "logarithmic equations",
    "recursive sequences",
  ),

  task(topic: "Limits: which sequences converge?", calculator: false)[
    Converges (to what?) or diverges?
    #auto-parts(
      4,
      [$1/n$],
      [$n/(n + 1)$],
      [$(-2)^n$],
      [$0.99^n$],
    )
  ][
    #auto-parts(
      4,
      [$-> 0$],
      [$-> 1$],
      [Diverges],
      [$-> 0$],
    )
  ],

  task(topic: "Proof by induction", calculator: false, difficulty: 2)[
    Prove by induction that for every $n >= 1$:
    $ 1 + 2 + 4 + dots.c + 2^(n - 1) = 2^n - 1 $
  ][
    Base case $n = 1$: $1 = 2^1 - 1$. Step: assume the formula for $n$.
    Adding $2^n$ gives $2^n - 1 + 2^n = 2 dot 2^n - 1 = 2^(n + 1) - 1$,
    the formula for $n + 1$.
  ],

  task(
    topic: "Vectors: collinearity and areas",
    calculator: false,
    difficulty: 2,
  )[
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Are $vec(2, -1, 3)$ and $vec(-4, 2, -6)$ collinear?],
      [Find the area of the parallelogram spanned by $vec(1, 0, 2)$ and
        $vec(0, 3, 1)$.],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Yes: the second is $-2$ times the first.],
      [$vec(1, 0, 2) times vec(0, 3, 1) = vec(-6, -1, 3)$; area
        $sqrt(36 + 1 + 9) = sqrt(46) approx 6.78$],
    )
  ],

  task(
    topic: "Logarithmic equations: checking the domain",
    calculator: false,
    difficulty: 2,
  )[
    Solve $log(x) + log(x + 3) = 1$.
  ][
    $log(x dot (x + 3)) = 1$, so $x^2 + 3x - 10 = 0$ and $x = 2$ or
    $x = -5$. Since $log(-5)$ is undefined, only $x = 2$.
  ],

  task(
    topic: "Recursive sequences: finding the limit",
    calculator: false,
    difficulty: 3,
  )[
    Let $a_1 = 0$ and $a_(n + 1) = 1/2 dot a_n + 3$. Calculate the
    first few terms. Assuming the sequence converges, find its limit.
  ][
    $0, 3, 4.5, 5.25, 5.625, ...$ A limit $L$ must satisfy
    $L = 1/2 dot L + 3$, so $L = 6$.
  ],
)


// ════════════════════════════════════════════════════════════
//  SPF — YEAR 3, 1st SEMESTER (draws on years 1–2)
// ════════════════════════════════════════════════════════════

#review-sheet(
  track: "spf",
  term: "3a",
  number: 1,
  draws-on: (
    "circles and spheres",
    "lines in space",
    "combinatorics and probability",
    "conditional probability",
  ),

  task(topic: "Circles and spheres: center and radius", calculator: false)[
    Which set of points does each equation describe? Give the center
    and radius where there is one.
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [$x^2 + y^2 - 6x + 4y = 3$],
      [$x^2 + y^2 + z^2 - 2z = 8$],
      [$x^2 + y^2 + 4x + 13 = 0$],
      [$2x^2 + 2y^2 - 8y = 0$],
    )
  ][
    #auto-parts(
      2,
      [$(x - 3)^2 + (y + 2)^2 = 16$: circle, $M = (3, -2)$, $r = 4$],
      [$x^2 + y^2 + (z - 1)^2 = 9$: sphere, $M = (0, 0, 1)$, $r = 3$],
      [$(x + 2)^2 + y^2 = -9$: no points at all],
      [$x^2 + (y - 2)^2 = 4$: circle, $M = (0, 2)$, $r = 2$],
    )
  ],

  task(
    topic: "Lines in space: position and distance",
    calculator: true,
    difficulty: 3,
  )[
    $g: vec(x, y, z) = vec(1, 2, 0) + t dot vec(1, 0, 1)$ and
    $h: vec(x, y, z) = vec(0, 1, 3) + s dot vec(0, 1, 1)$.
    #auto-parts(
      2,
      [Show that $g$ and $h$ are skew.],
      [Find the distance between $g$ and $h$.],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Not parallel (directions are not multiples). Equating:
        $1 + t = 0$ and $2 = 1 + s$ give $t = -1$, $s = 1$; the third
        coordinate gives $t = 3 + s$, i.e. $-1 = 4$: no intersection.],
      [$arrow(n) = vec(1, 0, 1) times vec(0, 1, 1) = vec(-1, -1, 1)$;
        $d = abs(vec(1, 1, -3) dot arrow(n)) / abs(arrow(n))
        = 5 / sqrt(3) approx 2.89$],
    )
  ],

  task(
    topic: "Combinatorics and probability: choosing a group",
    calculator: false,
    difficulty: 2,
  )[
    From a group of 6 girls and 4 boys, 3 people are chosen at random.
    #auto-parts(
      3,
      [$p("all girls")$],
      [$p("at least one boy")$],
      [$p("exactly 2 girls")$],
    )
  ][
    #auto-parts(
      3,
      [$binom(6, 3) / binom(10, 3) = 20/120 = 1/6$],
      [$1 - 1/6 = 5/6$],
      [$(binom(6, 2) dot binom(4, 1)) / 120 = 60/120 = 1/2$],
    )
  ],

  task(
    topic: "Conditional probability and independence",
    calculator: false,
    difficulty: 2,
  )[
    At a school, 40% of the students play an instrument, 30% do a
    sport in a club, and 12% do both. Find the probability that a
    student who plays an instrument does a sport. Are the two events
    independent?
  ][
    $p("sport" | "instrument") = 0.12 / 0.40 = 0.30 = p("sport")$:
    playing an instrument does not change the probability, so the events
    are independent. (Equivalently: $0.4 dot 0.3 = 0.12$.)
  ],

  task(
    topic: "Spheres and planes: tangent planes",
    calculator: false,
    difficulty: 2,
  )[
    The sphere $K: (x - 1)^2 + (y + 2)^2 + z^2 = 25$ passes through
    $P = (4, 2, 0)$. Find the tangent plane to $K$ at $P$, and explain
    why your normal vector is the right one.
  ][
    The radius $arrow(M P) = vec(3, 4, 0)$ is perpendicular to the
    tangent plane, so it is a normal vector: $3x + 4y = d$ with
    $d = 12 + 8 = 20$. Tangent plane: $3x + 4y = 20$.
  ],
)


#review-sheet(
  track: "spf",
  term: "3a",
  number: 2,
  draws-on: (
    "combinatorics",
    "angles between lines and planes",
    "limits and asymptotes",
    "multistage experiments",
    "circles",
  ),

  task(topic: "Combinatorics: modeling the count", calculator: false)[
    Describe the counting process and give an expression for the
    number of possibilities. Evaluate it where that is easy.
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [Arrangements of the letters of BANANA],
      [Tickets in a lottery choosing 6 of 42 numbers],
      [Three-letter codes from 26 letters (repeats allowed)],
      [Ways to put 5 identical balls into 3 boxes],
    )
  ][
    #auto-parts(
      2,
      [$6! / (3! dot 2!) = 60$],
      [$binom(42, 6) = #num(5245786)$],
      [$26^3 = #num(17576)$],
      [Stars and bars: $binom(7, 2) = 21$],
    )
  ],

  task(
    topic: "Angles between lines and planes",
    calculator: false,
    difficulty: 2,
  )[
    Let $E: x - z = 2$ and $F: y + z = 0$, and let $g$ be a line with
    direction vector $vec(1, 1, 0)$. Find the angle
    #auto-parts(
      2,
      [between $g$ and $E$,],
      [between the planes $E$ and $F$.],
    )
  ][
    #auto-parts(
      2,
      [$sin(phi) = abs(vec(1, 1, 0) dot vec(1, 0, -1)) /
        (sqrt(2) dot sqrt(2)) = 1/2$, so $phi = 30 degree$],
      [$cos(phi) = abs(vec(1, 0, -1) dot vec(0, 1, 1)) /
        (sqrt(2) dot sqrt(2)) = 1/2$, so $phi = 60 degree$],
    )
  ],

  task(
    topic: "Limits: asymptotes and gaps",
    calculator: false,
    difficulty: 2,
  )[
    Let $f(x) = (2x^2 - 2) / (x^2 - x - 2)$. Find all asymptotes of
    the graph of $f$, and any points where $f$ is undefined but the
    graph has only a gap.
  ][
    $f(x) = (2 dot (x - 1) dot (x + 1)) / ((x - 2) dot (x + 1))
    = (2 dot (x - 1)) / (x - 2)$ for $x != -1$. Vertical asymptote
    $x = 2$, horizontal asymptote $y = 2$, gap at $(-1, 4/3)$.
  ],

  task(
    topic: "Probability: multistage experiments",
    calculator: false,
  )[
    An archer hits the target with probability 0.8 per shot. She
    shoots until she hits, but at most three times.
    #auto-parts(
      2,
      [Find $p("exactly 2 shots")$.],
      [Find $p("she hits at all")$.],
    )
  ][
    #auto-parts(
      2,
      [Miss, then hit: $0.2 dot 0.8 = 0.16$],
      [Complement of three misses: $1 - 0.2^3 = 0.992$],
    )
  ],

  task(
    topic: "Circles and lines: intersections and tangents",
    calculator: false,
    difficulty: 3,
  )[
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Find the intersection points of the circle $x^2 + y^2 = 25$
        and the line $y = x + 1$.],
      [Find the tangent to the circle at the intersection point in the
        first quadrant.],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$x^2 + (x + 1)^2 = 25$ gives $x^2 + x - 12 = 0$, so $x = 3$ or
        $x = -4$: the points $(3, 4)$ and $(-4, -3)$.],
      [The radius $vec(3, 4)$ is a normal vector: $3x + 4y = 25$.],
    )
  ],
)


#review-sheet(
  track: "spf",
  term: "3a",
  number: 3,
  draws-on: (
    "lines and planes",
    "spheres",
    "conditional probability",
    "combinatorics",
    "circles",
  ),

  task(topic: "Lines and planes: mutual position", calculator: false)[
    How does each line lie relative to $E: x + y + z = 3$? (Hint:
    compare the direction vector with the normal vector first.)
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$g_1: vec(x, y, z) = t dot vec(1, 1, 1)$],
      [$g_2: vec(x, y, z) = vec(1, 1, 1) + t dot vec(1, -1, 0)$],
      [$g_3: vec(x, y, z) = t dot vec(1, 0, -1)$],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$arrow(n) dot arrow(u) = 3 != 0$: intersects $E$ in one point
        (at $t = 1$, the point $(1, 1, 1)$)],
      [$arrow(n) dot arrow(u) = 0$, and $(1, 1, 1)$ lies in $E$: the
        line lies in $E$],
      [$arrow(n) dot arrow(u) = 0$, and $(0, 0, 0)$ is not in $E$:
        parallel to $E$],
    )
  ],

  task(
    topic: "Spheres: lines and tangent planes",
    calculator: false,
    difficulty: 2,
  )[
    The sphere $K: x^2 + y^2 + z^2 = 9$ is given.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Where does the line $vec(x, y, z) = t dot vec(1, 2, 2)$ meet
        $K$?],
      [Is the plane $x + 2y + 2z = 9$ tangent to $K$?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$9t^2 = 9$, $t = plus.minus 1$: $(1, 2, 2)$ and $(-1, -2, -2)$],
      [Distance from the center: $9 / 3 = 3 = r$: yes, tangent at
        $(1, 2, 2)$.],
    )
  ],

  task(
    topic: "Conditional probability: reversing the tree",
    calculator: false,
    difficulty: 2,
  )[
    Urn A holds 3 red and 1 blue ball; urn B holds 1 red and 3 blue.
    A coin decides the urn, then one ball is drawn.
    #auto-parts(
      2,
      [Find $p("red")$.],
      [The ball is red. Find $p("urn A" | "red")$.],
    )
  ][
    #auto-parts(
      2,
      [$1/2 dot 3/4 + 1/2 dot 1/4 = 1/2$],
      [$(3/8) / (1/2) = 3/4$],
    )
  ],

  task(topic: "Combinatorics: committees", calculator: false,
    difficulty: 2)[
    From 5 women and 4 men,
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [how many committees of 3 contain at least one woman?],
      [how many ways are there to fill the posts of president, secretary,
        and treasurer?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [All minus "men only": $binom(9, 3) - binom(4, 3) = 84 - 4 = 80$],
      [Order matters: $9 dot 8 dot 7 = 504$],
    )
  ],

  task(
    topic: "Circles: the circle through three points",
    calculator: false,
    difficulty: 3,
  )[
    Find the circle through $A = (0, 0)$, $B = (6, 0)$, and
    $C = (0, 8)$. (Hint: look at the angle at $A$.)
  ][
    The angle at $A$ is a right angle, so by Thales $B C$ is a
    diameter: center $(3, 4)$, radius $5$.
    $(x - 3)^2 + (y - 4)^2 = 25$.
  ],
)


// ════════════════════════════════════════════════════════════
//  SPF — YEAR 3, 2nd SEMESTER (draws on years 1–2 + complex
//  numbers). Notation follows the complex-numbers unit:
//  b dot i, overline(z), r dot e^(i dot phi.alt), radians.
// ════════════════════════════════════════════════════════════

#review-sheet(
  track: "spf",
  term: "3b",
  number: 1,
  draws-on: (
    "complex numbers",
    "planes and the cross product",
  ),

  task(topic: "Complex numbers: switching forms", calculator: false)[
    Write each number in the other form: algebraic $a + b dot i$ or
    exponential $r dot e^(i dot phi.alt)$.
    #auto-parts(
      4,
      [$1 + i$],
      [$2 dot e^(i dot pi \/ 2)$],
      [$-3$],
      [$1 - sqrt(3) dot i$],
    )
  ][
    #auto-parts(
      2,
      [$sqrt(2) dot e^(i dot pi \/ 4)$],
      [$2 dot i$],
      [$3 dot e^(i dot pi)$],
      [$2 dot e^(-i dot pi \/ 3)$ (or $2 dot e^(i dot 5 pi \/ 3)$)],
    )
  ],

  task(
    topic: "Complex numbers: arithmetic",
    calculator: false,
    difficulty: 2,
  )[
    Let $z = 3 + 4 dot i$ and $w = 1 - 2 dot i$. Calculate
    #auto-parts(
      3,
      [$z dot w$,],
      [$z / w$,],
      [$abs(z)$ and $z dot overline(z)$.],
    )
  ][
    #auto-parts(
      3,
      [$3 - 6 dot i + 4 dot i - 8 dot i^2 = 11 - 2 dot i$],
      [$((3 + 4 dot i) dot (1 + 2 dot i)) / 5 = -1 + 2 dot i$],
      [$abs(z) = 5$, $z dot overline(z) = 25 = abs(z)^2$],
    )
  ],

  task(
    topic: "Complex numbers: solving equations",
    calculator: false,
    difficulty: 2,
  )[
    Solve in $CC$.
    #auto-parts(
      2,
      [$z^2 + 2z + 5 = 0$],
      [$z^3 = -8$],
    )
  ][
    #auto-parts(
      2,
      [$z = -1 plus.minus sqrt(-16) / 2 = -1 plus.minus 2 dot i$],
      [$-8 = 8 dot e^(i dot pi)$, so
        $z_k = 2 dot e^(i dot (pi + 2 pi dot k) \/ 3)$:
        $1 + sqrt(3) dot i$, $-2$, $1 - sqrt(3) dot i$],
    )
  ],

  task(
    topic: "Planes: three points and the cross product",
    calculator: false,
    difficulty: 2,
  )[
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Find a coordinate equation of the plane through
        $A = (1, 1, 0)$, $B = (2, 0, 1)$, and $C = (0, 1, 2)$.],
      [Find the distance of the origin from this plane (exact value).],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$arrow(A B) times arrow(A C) = vec(1, -1, 1) times vec(-1, 0, 2)
        = vec(-2, -3, -1)$, so $arrow(n) = vec(2, 3, 1)$ and
        $2x + 3y + z = 5$ (check with $B$ and $C$).],
      [$d = abs(0 - 5) / sqrt(4 + 9 + 1) = 5 / sqrt(14)$],
    )
  ],

  task(
    topic: "Complex numbers: square roots of negative numbers",
    calculator: false,
    difficulty: 2,
  )[
    Sami calculates
    $sqrt(-4) dot sqrt(-9) = sqrt((-4) dot (-9)) = sqrt(36) = 6$.
    Find the mistake and give the correct value.
  ][
    The law $sqrt(a) dot sqrt(b) = sqrt(a dot b)$ only holds for
    $a, b >= 0$. Correct: $sqrt(-4) dot sqrt(-9) = 2 dot i dot 3 dot i
    = 6 dot i^2 = -6$.
  ],
)


#review-sheet(
  track: "spf",
  term: "3b",
  number: 2,
  draws-on: (
    "the Gaussian plane",
    "complex multiplication as rotation",
    "powers and roots of complex numbers",
    "probability",
  ),

  task(topic: "Gaussian plane: sets of points", calculator: false)[
    Describe each set of points in the Gaussian plane.
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [$abs(z) = 3$],
      [$abs(z - 2 dot i) <= 1$],
      [$Re(z) = Im(z)$],
      [$abs(z - 1) = abs(z + 1)$],
    )
  ][
    #auto-parts(
      2,
      [Circle, center $0$, radius $3$],
      [Disk (with boundary), center $2 dot i$, radius $1$],
      [The line $y = x$],
      [Points equally far from $1$ and $-1$: the imaginary axis],
    )
  ],

  task(
    topic: "Complex multiplication: rotating and stretching",
    calculator: false,
    difficulty: 2,
  )[
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Calculate $i dot (2 + i)$ and show both numbers in the Gaussian
        plane. What does multiplying by $i$ do?],
      [What does multiplying by $1 + i$ do geometrically?],
      [Use (a) to rotate the point $(3, 1)$ by $90 degree$ about the
        origin.],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$-1 + 2 dot i$: a rotation by $90 degree$ about $0$.],
      [$1 + i = sqrt(2) dot e^(i dot pi \/ 4)$: a rotation by
        $45 degree$ and a stretch by the factor $sqrt(2)$.],
      [$i dot (3 + i) = -1 + 3 dot i$: the point $(-1, 3)$],
    )
  ],

  task(
    topic: "Powers of complex numbers",
    calculator: false,
    difficulty: 2,
  )[
    Calculate $(1 + i)^8$ without multiplying out.
  ][
    $(1 + i)^8 = (sqrt(2))^8 dot e^(i dot 8 pi \/ 4) = 16 dot e^(i dot 2 pi)
    = 16$
  ],

  task(
    topic: "Probability: the birthday problem",
    calculator: true,
    difficulty: 2,
  )[
    What is the probability that among 5 people, at least two share a
    birthday? (Ignore February 29.)
  ][
    Complement, all different:
    $1 - (365 dot 364 dot 363 dot 362 dot 361) / 365^5 approx 0.027$
  ],

  task(
    topic: "Roots of unity: a regular hexagon",
    calculator: false,
    difficulty: 3,
  )[
    Find all solutions of $z^6 = 1$ and sketch them in the Gaussian
    plane. Explain why they form a regular hexagon, and find its area.
  ][
    $z_k = e^(i dot k pi \/ 3)$ for $k = 0, ..., 5$: $plus.minus 1$,
    $plus.minus 1/2 plus.minus sqrt(3)/2 dot i$. All have modulus 1 and
    consecutive arguments differ by $pi/3$ (that is, $60 degree$), so
    they form a regular hexagon with circumradius 1: six equilateral
    triangles, area $6 dot sqrt(3)/4 = (3 sqrt(3))/2 approx 2.60$.
  ],
)


#review-sheet(
  track: "spf",
  term: "3b",
  number: 3,
  draws-on: (
    "complex multiplication",
    "polynomial equations",
    "exponential form",
    "trigonometric equations",
    "powers of i",
  ),

  task(
    topic: "Complex numbers: multiplication as a map",
    calculator: false,
  )[
    What does each operation do to a point $z$ in the Gaussian plane?
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [Multiplying by $-1$],
      [Multiplying by $2$],
      [Multiplying by $e^(i dot pi \/ 3)$],
      [Replacing $z$ by $overline(z)$],
    )
  ][
    #auto-parts(
      2,
      [Rotation by $180 degree$ about $0$],
      [Stretch by the factor 2 from $0$],
      [Rotation by $60 degree$ about $0$],
      [Reflection in the real axis],
    )
  ],

  task(
    topic: "Polynomial equations in the complex numbers",
    calculator: false,
    difficulty: 2,
  )[
    Solve $z^3 - z^2 + 4z - 4 = 0$ in $CC$. (Hint: group the terms.)
    Why do the non-real solutions come as a conjugate pair?
  ][
    $z^2 dot (z - 1) + 4 dot (z - 1) = (z - 1) dot (z^2 + 4)$:
    $z = 1$, $z = plus.minus 2 dot i$. For a polynomial with real
    coefficients, conjugating $p(z) = 0$ gives $p(overline(z)) = 0$.
  ],

  task(
    topic: "Complex numbers: exponential form",
    calculator: false,
    difficulty: 2,
  )[
    Let $z = 2 dot e^(i dot pi \/ 3)$ and $w = 3 dot e^(i dot pi \/ 6)$.
    Calculate $z dot w$ and $z / w$, and give both in algebraic form.
  ][
    $z dot w = 6 dot e^(i dot pi \/ 2) = 6 dot i$.
    $z / w = 2/3 dot e^(i dot pi \/ 6)
    = sqrt(3)/3 + 1/3 dot i$.
  ],

  task(
    topic: "Trigonometric equations: substitution",
    calculator: false,
    difficulty: 2,
  )[
    Solve $2 dot cos(x)^2 - cos(x) - 1 = 0$ for $0 <= x < 2 pi$.
  ][
    With $u = cos(x)$: $2u^2 - u - 1 = (2u + 1) dot (u - 1) = 0$.
    $cos(x) = 1$: $x = 0$; $cos(x) = -1/2$: $x = (2 pi)/3$ or
    $x = (4 pi)/3$.
  ],

  task(topic: "Powers of i", calculator: false, difficulty: 2)[
    Calculate $i^(2026)$ and $i^(-1)$. Explain the pattern you use.
  ][
    The powers repeat with period 4: $i, -1, -i, 1$. Since
    $2026 = 4 dot 506 + 2$: $i^(2026) = i^2 = -1$. And
    $i^(-1) = 1/i = -i$ (because $i dot (-i) = 1$).
  ],
)


// ════════════════════════════════════════════════════════════
//  SPF — YEAR 4, 1st SEMESTER (draws on years 1–3, including
//  derivatives, random variables, binomial and normal
//  distributions)
// ════════════════════════════════════════════════════════════

#review-sheet(
  track: "spf",
  term: "4a",
  number: 1,
  draws-on: (
    "distributions",
    "curve analysis",
    "random variables and expected value",
    "normal distribution",
    "optimization",
  ),

  task(topic: "Distributions: is it binomial?", calculator: false)[
    Which random variables are binomially distributed? Give $n$ and $p$,
    or say which condition fails.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [The number of sixes in 20 rolls of a die.],
      [The height of a randomly chosen 18-year-old.],
      [The number of rolls until the first six.],
      [The number of red cards among 5 cards drawn without replacement
        from a deck of 52.],
    )
  ][
    #auto-parts(
      2,
      [Binomial, $n = 20$, $p = 1/6$],
      [Not binomial: a continuous quantity (roughly normal)],
      [Not binomial: the number of trials is not fixed],
      [Not binomial: without replacement, the draws are not
        independent],
    )
  ],

  task(
    topic: "Curve analysis: extrema and inflection",
    calculator: false,
    difficulty: 2,
  )[
    Find the local extrema and the inflection point of
    $f(x) = x^3 - 3x^2 - 9x + 5$.
  ][
    $f'(x) = 3x^2 - 6x - 9 = 3 dot (x - 3) dot (x + 1)$;
    $f''(x) = 6x - 6$. Local maximum $(-1, 10)$ ($f''(-1) < 0$), local
    minimum $(3, -22)$ ($f''(3) > 0$), inflection point $(1, -6)$.
  ],

  task(
    topic: "Random variables: expected value",
    calculator: false,
    difficulty: 2,
  )[
    A game costs CHF 2. You roll two dice. A double six wins CHF 20,
    any other double wins CHF 5, everything else wins nothing.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [Find the expected payout and the expected net gain per game.],
      [What stake would make the game fair?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$E("payout") = 20 dot 1/36 + 5 dot 5/36 = 45/36 = 1.25$ CHF;
        net gain $1.25 - 2 = -0.75$ CHF per game],
      [CHF 1.25],
    )
  ],

  task(
    topic: "Normal distribution",
    calculator: true,
    difficulty: 2,
  )[
    IQ scores are normally distributed with $mu = 100$ and
    $sigma = 15$.
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [Find $p(X > 130)$.],
      [Find $p(85 < X < 115)$.],
      [Which score do only 5% exceed?],
    )
  ][
    #auto-parts(
      3,
      [$approx 0.023$],
      [$approx 0.683$ (within $mu plus.minus sigma$)],
      [$approx 124.7$],
    )
  ],

  task(
    topic: "Optimization: the cheapest can",
    calculator: true,
    difficulty: 3,
  )[
    A cylindrical can must hold 1 liter (#num(1000) cm³). Which radius
    and height minimize its surface area? What do you notice about the
    shape?
  ][
    $h = #num(1000) / (pi dot r^2)$, so
    $S(r) = 2 pi dot r^2 + #num(2000) / r$.
    $S'(r) = 4 pi dot r - #num(2000) / r^2 = 0$ gives
    $r = root(3, 500 / pi) approx 5.42$ cm, $h approx 10.84$ cm. The
    height equals the diameter.
  ],
)


#review-sheet(
  track: "spf",
  term: "4a",
  number: 2,
  draws-on: (
    "derivatives",
    "binomial distribution",
    "complex numbers",
    "optimization",
  ),

  task(topic: "Derivatives: what f' and f'' tell you", calculator: false)[
    What can you conclude about $f$ in each case?
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [$f'(2) = 0$ and $f''(2) < 0$],
      [$f'(x) > 0$ for all $x$],
      [$f''$ changes sign at $x = 1$],
      [$f'(3) = 0$ and $f''(3) = 0$],
    )
  ][
    #auto-parts(
      2,
      [Local maximum at $x = 2$],
      [$f$ is strictly increasing],
      [Inflection point at $x = 1$],
      [No conclusion yet: compare $x^3$ (no extremum) and $x^4$
        (minimum) at $0$.],
    )
  ],

  task(topic: "Derivatives: product, chain, quotient", calculator: false)[
    Differentiate.
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [$x dot e^(-x)$],
      [$sin(x^2)$],
      [$ln(cos(x))$],
      [$(x^2 + 1) / (x - 1)$],
    )
  ][
    #auto-parts(
      2,
      [$(1 - x) dot e^(-x)$],
      [$2x dot cos(x^2)$],
      [$-sin(x) / cos(x) = -tan(x)$],
      [$(x^2 - 2x - 1) / (x - 1)^2$],
    )
  ],

  task(
    topic: "Binomial distribution",
    calculator: true,
    difficulty: 2,
  )[
    A seed germinates with probability 0.9. You plant 20 seeds; $X$ is
    the number that germinate.
    #auto-parts(
      3,
      [Find $p(X = 20)$.],
      [Find $p(X >= 18)$.],
      [Find $E(X)$ and $sigma$.],
    )
  ][
    #auto-parts(
      3,
      [$0.9^(20) approx 0.122$],
      [$approx 0.677$],
      [$E(X) = 18$, $sigma = sqrt(20 dot 0.9 dot 0.1) approx 1.34$],
    )
  ],

  task(
    topic: "Complex numbers: square roots",
    calculator: false,
    difficulty: 2,
  )[
    Solve $z^2 = 2 dot i$, once in algebraic form (set
    $z = a + b dot i$) and once in exponential form.
  ][
    Algebraic: $a^2 - b^2 = 0$ and $2 a dot b = 2$ give
    $a = b = plus.minus 1$. Exponential:
    $2 dot i = 2 dot e^(i dot pi \/ 2)$, so
    $z = plus.minus sqrt(2) dot e^(i dot pi \/ 4)$. Both give
    $z = plus.minus (1 + i)$.
  ],

  task(
    topic: "Optimization: closest point on a curve",
    calculator: false,
    difficulty: 3,
  )[
    Which points of the parabola $y = x^2$ are closest to $P = (0, 3)$?
    (Hint: minimize the _square_ of the distance.)
  ][
    $d(x)^2 = x^2 + (x^2 - 3)^2$; derivative $2x + 4x dot (x^2 - 3)
    = 2x dot (2x^2 - 5) = 0$. At $x = 0$ there is a local maximum
    (distance 3); the minimum is at $x = plus.minus sqrt(5/2)$: the
    points $(plus.minus sqrt(10)/2, 5/2)$, distance
    $sqrt(11)/2 approx 1.66$.
  ],
)


#review-sheet(
  track: "spf",
  term: "4a",
  number: 3,
  draws-on: (
    "derivatives",
    "optimization",
    "normal distribution",
    "binomial distribution",
    "tangents",
  ),

  task(topic: "Derivatives: recognizing the rule", calculator: false)[
    Which rule does each function need? Differentiate.
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [$e^(-x^2)$],
      [$x dot ln(x)$],
      [$sqrt(1 - x^2)$],
      [$tan(x)$],
    )
  ][
    #auto-parts(
      2,
      [Chain: $-2x dot e^(-x^2)$],
      [Product: $ln(x) + 1$],
      [Chain: $-x / sqrt(1 - x^2)$],
      [Quotient ($sin \/ cos$): $1 / cos(x)^2$],
    )
  ],

  task(
    topic: "Optimization: a rectangle under a parabola",
    calculator: false,
    difficulty: 3,
  )[
    A rectangle has its base on the $x$-axis and its upper corners on
    the parabola $y = 12 - x^2$. Find its largest possible area.
  ][
    Corners at $(plus.minus x, 12 - x^2)$:
    $A(x) = 2x dot (12 - x^2) = 24x - 2x^3$, $A'(x) = 24 - 6x^2 = 0$
    at $x = 2$. Largest area $A(2) = 32$.
  ],

  task(
    topic: "Normal distribution: the 68–95–99.7 rule",
    calculator: false,
    difficulty: 2,
  )[
    Apples weigh $mu = 200$ g on average, with $sigma = 5$ g (normally
    distributed). Estimate without a calculator:
    #auto-parts(
      2,
      [$p(190 < X < 210)$],
      [$p(X > 215)$],
    )
  ][
    #auto-parts(
      2,
      [$mu plus.minus 2 sigma$: about 95%],
      [Beyond $mu + 3 sigma$: about 0.15%],
    )
  ],

  task(
    topic: "Binomial distribution: is it surprising?",
    calculator: true,
    difficulty: 2,
  )[
    A coin is tossed 100 times and shows heads 62 times. Find $E(X)$ and
    $sigma$ for a fair coin, and $p(X >= 62)$. Is the result surprising?
  ][
    $E(X) = 50$, $sigma = sqrt(100 dot 0.5 dot 0.5) = 5$. 62 is 2.4
    standard deviations above the mean; $p(X >= 62) approx 0.010$.
    Quite surprising for a fair coin.
  ],

  task(
    topic: "Tangents from an outside point",
    calculator: false,
    difficulty: 3,
  )[
    Find all tangents to $y = x^2$ that pass through $P = (0, -1)$.
  ][
    Tangent at $x_0$: $y = 2x_0 dot x - x_0^2$. Through $(0, -1)$:
    $-x_0^2 = -1$, $x_0 = plus.minus 1$. Tangents $y = 2x - 1$ and
    $y = -2x - 1$.
  ],
)


// ════════════════════════════════════════════════════════════
//  SPF — YEAR 4, 2nd SEMESTER (Matura run-in: years 1–4a,
//  including integrals and conic sections)
// ════════════════════════════════════════════════════════════

#review-sheet(
  track: "spf",
  term: "4b",
  number: 1,
  draws-on: (
    "choosing the tool",
    "integrals",
    "solids of revolution",
    "conic sections",
  ),

  task(topic: "Choosing the tool", calculator: false)[
    Do _not_ solve. Name the tool each question calls for.
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [The volume of a vase whose profile is a known curve],
      [The probability that a normally distributed length lies in a
        given interval],
      [The production level with the largest profit],
      [The angle between two planes],
    )
  ][
    #auto-parts(
      2,
      [Solid of revolution: $V = pi dot integral f(x)^2 dif x$],
      [Normal distribution: normCdf on the calculator],
      [Optimization: derivative of the profit $= 0$, then check],
      [Dot product of the two normal vectors],
    )
  ],

  task(topic: "Integrals: values and areas", calculator: false,
    difficulty: 2)[
    #auto-parts(
      2,
      row-gutter: 0.5em,
      [$integral_0^(pi) sin(x) dif x$],
      [$integral_1^e 1/x dif x$],
      [The area between $y = x^2$ and $y = x^3$ for $0 <= x <= 1$],
    )
  ][
    #auto-parts(
      3,
      [$lr([-cos(x)])_0^(pi) = 2$],
      [$lr([ln(x)])_1^e = 1$],
      [$integral_0^1 (x^2 - x^3) dif x = 1/3 - 1/4 = 1/12$],
    )
  ],

  task(
    topic: "Solids of revolution",
    calculator: false,
    difficulty: 2,
  )[
    The graph of $f(x) = sqrt(x)$, $0 <= x <= 4$, rotates about the
    $x$-axis. Find the volume of the solid.
  ][
    $V = pi dot integral_0^4 x dif x = pi dot lr([x^2 / 2])_0^4
    = 8 pi approx 25.1$
  ],

  task(topic: "Conic sections: reading the equation", calculator: false,
    difficulty: 2)[
    Identify each conic section and give its key data (semi-axes and
    foci, or focus and directrix).
    #auto-parts(
      2,
      [$9x^2 + 25y^2 = 225$],
      [$y^2 = 8x$],
    )
  ][
    #auto-parts(
      2,
      [Ellipse $x^2/25 + y^2/9 = 1$: $a = 5$, $b = 3$, $c = 4$; foci
        $(-4, 0)$ and $(4, 0)$],
      [Parabola: focus $(2, 0)$, directrix $x = -2$],
    )
  ],

  task(
    topic: "Integrals: area versus integral",
    calculator: false,
    difficulty: 2,
  )[
    Noa calculates the area between the graph of $f(x) = x^2 - 1$ and
    the $x$-axis for $0 <= x <= 2$ as
    $integral_0^2 (x^2 - 1) dif x = 8/3 - 2 = 2/3$. Find the mistake
    and the correct area.
  ][
    $f$ is negative on $[0, 1)$, so that part counts negatively and
    cancels. Split at the zero $x = 1$:
    $integral_0^1 (x^2 - 1) dif x = -2/3$ and
    $integral_1^2 (x^2 - 1) dif x = 4/3$. Area $2/3 + 4/3 = 2$.
  ],
)


#review-sheet(
  track: "spf",
  term: "4b",
  number: 2,
  draws-on: (
    "antiderivatives",
    "integrals in motion",
    "normal distribution",
    "trigonometric equations",
    "tangents and areas",
  ),

  task(topic: "Antiderivatives", calculator: false)[
    Find an antiderivative of each function, and check it by
    differentiating.
    #auto-parts(
      4,
      [$3x^2 + 2$],
      [$e^(2x)$],
      [$cos(3x)$],
      [$1 / (x + 1)$],
    )
  ][
    #auto-parts(
      4,
      [$x^3 + 2x$],
      [$1/2 dot e^(2x)$],
      [$1/3 dot sin(3x)$],
      [$ln(abs(x + 1))$],
    )
  ],

  task(
    topic: "Integrals: displacement and distance",
    calculator: false,
    difficulty: 3,
  )[
    A particle moves along a line with velocity
    $v(t) = 3t^2 - 12t + 9$ (in m/s) for $0 <= t <= 4$.
    #auto-parts(
      2,
      [Find its displacement.],
      [Find the total distance traveled.],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$integral_0^4 v(t) dif t = lr([t^3 - 6t^2 + 9t])_0^4 = 4$ m],
      [$v$ changes sign at $t = 1$ and $t = 3$. The three pieces give
        $4$, $-4$, and $4$ m, so the distance is $4 + 4 + 4 = 12$ m.],
    )
  ],

  task(
    topic: "Normal distribution: setting a target",
    calculator: true,
    difficulty: 2,
  )[
    A machine fills bottles with a normally distributed amount,
    $mu = 500$ ml and $sigma = 4$ ml.
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [What fraction of the bottles contain less than 495 ml?],
      [To which mean must the machine be set so that only 1% of the
        bottles contain less than 495 ml ($sigma$ unchanged)?],
    )
  ][
    #auto-parts(
      1,
      row-gutter: 0.5em,
      [$p(X < 495) approx 0.106$],
      [$mu = 495 + 2.326 dot 4 approx 504.3$ ml],
    )
  ],

  task(
    topic: "Trigonometric equations: double angles",
    calculator: false,
    difficulty: 2,
  )[
    Solve $sin(2x) = cos(x)$ for $0 <= x < 2 pi$. (Hint:
    $sin(2x) = 2 dot sin(x) dot cos(x)$.)
  ][
    $cos(x) dot (2 dot sin(x) - 1) = 0$. Do not divide by $cos(x)$!
    $cos(x) = 0$: $x = pi/2, (3 pi)/2$; $sin(x) = 1/2$:
    $x = pi/6, (5 pi)/6$.
  ],

  task(
    topic: "Tangents and areas",
    calculator: false,
    difficulty: 3,
  )[
    The parabola $y = x^2$, its tangent at $x = 1$, and the $y$-axis
    enclose a region. Find its area.
  ][
    Tangent: $y = 2x - 1$. Area
    $integral_0^1 (x^2 - (2x - 1)) dif x = integral_0^1 (x - 1)^2 dif x
    = 1/3$.
  ],
)


#review-sheet(
  track: "spf",
  term: "4b",
  number: 3,
  draws-on: (
    "conic sections",
    "integration",
    "hyperbolas",
    "distance point–line",
    "average value",
  ),

  task(topic: "Conic sections: which curve?", calculator: false)[
    Identify each curve.
    #auto-parts(
      4,
      [$x^2/9 - y^2/4 = 1$],
      [$x^2 + y^2 = 16$],
      [$x = y^2$],
      [$4x^2 + y^2 = 4$],
    )
  ][
    #auto-parts(
      4,
      [Hyperbola],
      [Circle, $r = 4$],
      [Parabola (opening right)],
      [Ellipse, semi-axes 1 and 2],
    )
  ],

  task(
    topic: "Integration: reversing the chain rule",
    calculator: false,
    difficulty: 2,
  )[
    #auto-parts(
      2,
      [Find $integral 2x dot e^(x^2) dif x$.],
      [Calculate $integral_0^1 2x dot (x^2 + 1)^3 dif x$.],
    )
  ][
    #auto-parts(
      2,
      [$e^(x^2) + C$ (check by differentiating)],
      [$lr([(x^2 + 1)^4 / 4])_0^1 = (16 - 1)/4 = 15/4$],
    )
  ],

  task(
    topic: "Hyperbolas: foci and asymptotes",
    calculator: false,
    difficulty: 2,
  )[
    Find the foci and the asymptotes of the hyperbola
    $x^2/16 - y^2/9 = 1$.
  ][
    $a = 4$, $b = 3$, $c = sqrt(16 + 9) = 5$: foci $(-5, 0)$ and
    $(5, 0)$; asymptotes $y = plus.minus 3/4 dot x$.
  ],

  task(
    topic: "Distance from a point to a line",
    calculator: false,
    difficulty: 2,
  )[
    Find the point on the line $g: vec(x, y, z) = t dot vec(1, 2, 2)$
    closest to $P = (3, 0, 0)$, and the distance from $P$ to $g$.
  ][
    The foot $F = t dot vec(1, 2, 2)$ needs
    $(arrow(O P) - t dot arrow(u)) dot arrow(u) = 0$: $3 - 9t = 0$,
    $t = 1/3$, $F = (1/3, 2/3, 2/3)$. Distance
    $abs(vec(8/3, -2/3, -2/3)) = sqrt(72/9) = 2 sqrt(2)$.
  ],

  task(
    topic: "Integrals: the average value of a function",
    calculator: false,
    difficulty: 2,
  )[
    Find the average value of $sin(x)$ on $[0, pi]$. Compare it with
    the average of its largest and smallest values there.
  ][
    $1/pi dot integral_0^(pi) sin(x) dif x = 2/pi approx 0.64$. The
    average of max and min is $0.5$: the sine spends more time near its
    maximum than near $0$.
  ],
)
