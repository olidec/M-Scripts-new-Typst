// ============================================================
//  quiz-common.typ — shared engine for the two diagnostic quizzes
//
//    entry-check.typ     week 1  — "what did Sek I leave you with?"
//    progress-check.typ  week ~5 — isomorphic re-test + new material
//
//  DELIBERATELY STANDALONE. This file imports nothing. The two
//  quizzes are compiled directly:
//
//      typst compile entry-check.typ
//      typst compile progress-check.typ
//
//  with no --root and no dependency on preamble.typ. Reason: these
//  are one-off assessment artifacts that sit outside build.sh and
//  outside the chapter registry, and the preamble's machinery
//  (_ex-mode / _sol-mode / ex-counter / hint-store / chapter
//  registry) would have to be worked around rather than used. The
//  palette and typography below are copied from preamble.typ so the
//  sheets still look like the rest of the course; if the house
//  colors ever change, they change in two places.
//
//  QUESTION LABELS ARE HARDCODED STRINGS ("A1", "B3", ...), not
//  counter-driven. That is on purpose: the self-check grid at the
//  end of each quiz refers to items by label, and the two quizzes
//  must stay item-for-item isomorphic. A counter that silently
//  renumbers when an item is added or dropped would break the whole
//  point of the design.
//
//  ANSWER KEY: each quiz file has a single
//      #set-answers(true / false)
//  line near the top. false = student sheet (blank answer space),
//  true = key + self-check grid filled in. Compile twice, once with
//  each setting, and rename the output.
// ============================================================

// ── Palette (mirrors preamble.typ) ───────────────────────────
#let accent = rgb("#38805f")
#let accent-bg = rgb("#e9f0ec")
#let def-col = rgb("#1b4332")
#let def-bg = rgb("#e9f0ec")
#let task-col = rgb("#4c5fa8")
#let task-bg = rgb("#eef0fa")
#let ahead-col = rgb("#5f6b64")
#let ahead-bg = rgb("#f0f2f1")
#let warn-col = rgb("#b3261e")
#let sol-col = rgb("#8a5a1e")
#let sol-bg = rgb("#faf3e8")

// ── Answer-key switch ────────────────────────────────────────
#let ANSWERS = state("quiz-answers", false)
#let set-answers(v) = ANSWERS.update(_ => v)

// Content that exists only on the key.
#let key-only(body) = context { if ANSWERS.get() { body } }
// Content that exists only on the student sheet.
#let sheet-only(body) = context { if not ANSWERS.get() { body } }

// ── system() — same house convention as preamble.typ ─────────
#let system(..eqs) = math.mat(
  delim: "|",
  ..eqs.pos().map(pair => (pair.at(0), $=$, pair.at(1))),
)

// ── Page template ────────────────────────────────────────────
#let quiz-template(
  title: "",
  subtitle: "",
  course: "Mathematics — Gymnasium Muttenz",
  body,
) = {
  set text(font: "New Computer Modern", size: 10.5pt, lang: "en")
  set par(justify: false, leading: 0.65em)
  set heading(numbering: none)
  show heading.where(level: 1): it => block(above: 0pt, below: 10pt, {
    text(size: 13pt, weight: "bold", fill: accent, it.body)
    v(-3pt)
    line(length: 100%, stroke: 0.6pt + accent)
  })
  set page(
    paper: "a4",
    margin: (top: 2.2cm, bottom: 2cm, left: 2.2cm, right: 2.2cm),
    header: context {
      set text(size: 8.5pt, fill: luma(120))
      let tag = if ANSWERS.get() { "Answer key" } else { "Name: " + "." * 40 }
      grid(
        columns: (1fr, 1fr),
        align(left)[#course], align(right)[#tag],
      )
      v(-4pt)
      line(length: 100%, stroke: 0.5pt + accent)
    },
    footer: context {
      set text(size: 8.5pt, fill: luma(120))
      line(length: 100%, stroke: 0.3pt + luma(180))
      v(-4pt)
      let tot = counter(page).final().first()
      align(center)[#counter(page).display("1") / #tot]
    },
  )

  context {
    align(center, block(width: 100%, {
      text(size: 16pt, weight: "bold", fill: accent)[#title]
      if ANSWERS.get() {
        text(size: 16pt, weight: "bold", fill: warn-col)[ — Answer Key]
      }
      v(2pt)
      text(size: 10pt, fill: luma(90), style: "italic")[#subtitle]
    }))
  }
  v(4pt)
  body
}

// ── Instruction box ──────────────────────────────────────────
#let instructions(body) = block(
  width: 100%,
  fill: ahead-bg,
  radius: 3pt,
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  stroke: (left: 3pt + ahead-col),
  {
    set par(leading: 0.7em)
    body
  },
)

// ── Formula reference ────────────────────────────────────────
#let formula-box(body) = block(
  width: 100%,
  fill: def-bg,
  radius: 3pt,
  inset: (left: 12pt, right: 10pt, top: 7pt, bottom: 7pt),
  stroke: (left: 3pt + def-col),
  {
    text(size: 9.5pt, weight: "bold", fill: def-col)[
      Formulas you may use — no need to memorize these today
    ]
    v(3pt)
    set text(size: 9.5pt)
    body
  },
)

// ── Part heading ─────────────────────────────────────────────
#let part(letter, title, minutes: none, note: none) = block(
  width: 100%,
  breakable: false,
  above: 14pt,
  below: 7pt,
  {
    grid(
      columns: (1fr, auto),
      align(left)[
        #text(size: 11.5pt, weight: "bold", fill: accent)[Part #letter — #title]
      ],
      align(right)[
        #if minutes != none {
          text(size: 8.5pt, fill: luma(130))[≈ #minutes min]
        }
      ],
    )
    v(-2pt)
    line(length: 100%, stroke: 0.6pt + accent)
    if note != none {
      v(2pt)
      text(size: 9pt, fill: luma(100), style: "italic")[#note]
    }
  },
)

// ── One question ─────────────────────────────────────────────
//   q("A1", 2, 2.0cm)[ prompt ][ model answer ]
//   `space` is the blank left for the student; it is replaced by
//   the model answer on the key, so the two versions differ in
//   length and that is fine — they are never handed out together.
#let q(label, points, space, prompt, answer) = block(
  width: 100%,
  breakable: false,
  above: 9pt,
  below: 0pt,
  context {
    grid(
      columns: (1.0cm, 1fr, 0.9cm),
      column-gutter: 2pt,
      align(left + top)[
        #text(weight: "bold", fill: task-col)[#label]
      ],
      {
        set par(leading: 0.65em)
        prompt
      },
      align(right + top)[
        #text(size: 8pt, fill: luma(140))[#points P]
      ],
    )
    if ANSWERS.get() {
      v(3pt)
      pad(left: 1.0cm, block(
        width: 100%,
        fill: sol-bg,
        radius: 2pt,
        inset: (left: 8pt, right: 8pt, top: 5pt, bottom: 5pt),
        stroke: (left: 2.5pt + sol-col),
        {
          set text(size: 9.5pt)
          set par(leading: 0.65em)
          answer
        },
      ))
      v(3pt)
    } else {
      v(space)
    }
  },
)

// ── Vocabulary matching block ────────────────────────────────
//   vocab-match(en: (...), de: (...), key: "1 F  2 B  ...")
#let vocab-match(en: (), de: (), key: "") = {
  let letters = ("A", "B", "C", "D", "E", "F", "G", "H", "I", "J")
  block(width: 100%, breakable: false, {
    grid(
      columns: (1fr, 1fr),
      column-gutter: 14pt,
      block({
        text(size: 9pt, weight: "bold", fill: task-col)[English]
        v(3pt)
        set text(size: 10pt)
        for (i, w) in en.enumerate() {
          let n = str(i + 1) + "."
          block(above: 3pt, below: 3pt)[
            #text(fill: luma(120))[#n] #w #h(1fr) #v(2mm)

          ]
        }
      }),
      block({
        text(size: 9pt, weight: "bold", fill: task-col)[German]
        v(3pt)
        set text(size: 10pt)
        for (i, w) in de.enumerate() {
          let n = letters.at(i) + "."
          block(above: 3pt, below: 3pt)[
            #text(fill: luma(120))[#n] #w #v(2mm)
          ]
        }
      }),
    )
    key-only({
      v(5pt)
      block(
        width: 100%,
        fill: sol-bg,
        radius: 2pt,
        inset: (left: 8pt, right: 8pt, top: 5pt, bottom: 5pt),
        stroke: (left: 2.5pt + sol-col),
        text(size: 9.5pt)[#key],
      )
    })
  })
}

// ── Coordinate grid (pure Typst, no external package) ────────
//
//  Used for the one "read the line off the graph" item in each
//  quiz. Kept deliberately small: preamble.typ's plot-graph() is
//  the right tool inside the course proper, but pulling it in
//  would drag the whole preamble along with it.
//
//  lines: array of (slope, intercept) pairs, drawn clipped to the
//  visible window. dots: array of (x, y) pairs.

#let _clip-line(m, b, xmin, xmax, ymin, ymax) = {
  let x0 = xmin * 1.0
  let x1 = xmax * 1.0
  if m == 0 {
    if b < ymin or b > ymax { return none }
  } else {
    let xa = (ymin - b) / m
    let xb = (ymax - b) / m
    x0 = calc.max(x0, calc.min(xa, xb))
    x1 = calc.min(x1, calc.max(xa, xb))
  }
  if x1 <= x0 { none } else { (x0, m * x0 + b, x1, m * x1 + b) }
}

#let coord-grid(
  xmin: -1,
  xmax: 5,
  ymin: -2,
  ymax: 6,
  unit: 0.58cm,
  lines: (),
  dots: (),
) = {
  let w = (xmax - xmin) * unit
  let h = (ymax - ymin) * unit
  let px(x) = (x - xmin) * unit
  let py(y) = (ymax - y) * unit

  align(center, pad(x: 14pt, y: 12pt, box(width: w, height: h, {
    for i in range(xmin, xmax + 1) {
      place(line(
        start: (px(i), 0pt),
        end: (px(i), h),
        stroke: 0.4pt + luma(205),
      ))
    }
    for j in range(ymin, ymax + 1) {
      place(line(
        start: (0pt, py(j)),
        end: (w, py(j)),
        stroke: 0.4pt + luma(205),
      ))
    }
    place(line(start: (px(0), 0pt), end: (px(0), h), stroke: 0.8pt + luma(70)))
    place(line(start: (0pt, py(0)), end: (w, py(0)), stroke: 0.8pt + luma(70)))

    for i in range(xmin, xmax + 1) {
      if i != 0 {
        place(dx: px(i) - 7pt, dy: py(0) + 2pt, box(
          width: 14pt,
          align(center, text(size: 7pt, fill: luma(95))[#i]),
        ))
      }
    }
    for j in range(ymin, ymax + 1) {
      if j != 0 {
        place(dx: px(0) - 17pt, dy: py(j) - 4pt, box(
          width: 14pt,
          align(right, text(size: 7pt, fill: luma(95))[#j]),
        ))
      }
    }

    for l in lines {
      let seg = _clip-line(l.at(0), l.at(1), xmin, xmax, ymin, ymax)
      if seg != none {
        place(line(
          start: (px(seg.at(0)), py(seg.at(1))),
          end: (px(seg.at(2)), py(seg.at(3))),
          stroke: 1.2pt + task-col,
        ))
      }
    }
    for d in dots {
      place(
        dx: px(d.at(0)) - 2pt,
        dy: py(d.at(1)) - 2pt,
        circle(radius: 2pt, fill: task-col, stroke: none),
      )
    }

    place(dx: w - 9pt, dy: py(0) + 2pt, text(size: 8pt, style: "italic")[x])
    place(dx: px(0) + 4pt, dy: -1pt, text(size: 8pt, style: "italic")[y])
  })))
}

// ── Self-check grid ──────────────────────────────────────────
//
//  rows: array of (part-label, topic, max-points, "what to do")
//  compare: false → one score column (entry check)
//           true  → two score columns, September vs now
#let self-check(rows: (), compare: false, total: 0) = {
  let head = (
    [*Part*],
    [*What it tests*],
    [*Max*],
  )
  let cols = (auto, 1fr, auto)
  if compare {
    head += ([*Sept.*], [*Now*])
    cols += (auto, auto)
  } else {
    head += ([*Mine*],)
    cols += (auto,)
  }

  let body = ()
  for r in rows {
    body += (
      text(weight: "bold", fill: task-col)[#r.at(0)],
      [#r.at(1) \ #text(size: 8.5pt, fill: luma(110), style: "italic")[#r.at(
          3,
        )]],
      align(center)[#r.at(2)],
    )
    if compare {
      body += (
        box(width: 1.1cm, height: 0.55cm),
        box(
          width: 1.1cm,
          height: 0.55cm,
        ),
      )
    } else {
      body += (box(width: 1.1cm, height: 0.55cm),)
    }
  }
  let foot = (
    text(weight: "bold")[Σ],
    text(weight: "bold")[Total],
    align(center)[#text(weight: "bold")[#total]],
  )
  if compare {
    foot += (
      box(width: 1.1cm, height: 0.55cm),
      box(
        width: 1.1cm,
        height: 0.55cm,
      ),
    )
  } else {
    foot += (box(width: 1.1cm, height: 0.55cm),)
  }

  set text(size: 9.5pt)
  table(
    columns: cols,
    align: (left + horizon, left + horizon, center + horizon)
      + (center + horizon,) * (if compare { 2 } else { 1 }),
    stroke: 0.4pt + luma(170),
    fill: (_, y) => if y == 0 { accent-bg } else { none },
    inset: (x: 6pt, y: 5pt),
    ..head,
    ..body,
    ..foot,
  )
}

// ── Interpretation bands ─────────────────────────────────────
#let bands(body) = block(
  width: 100%,
  fill: task-bg,
  radius: 3pt,
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  stroke: (left: 3pt + task-col),
  {
    set par(leading: 0.7em)
    body
  },
)
