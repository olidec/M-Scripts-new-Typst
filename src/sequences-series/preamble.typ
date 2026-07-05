// ============================================================
//  preamble.typ — Sequences & Series
//  Import with:  #import "preamble.typ": *
//
//  This preamble is shared by FIVE entry points:
//    main-basic.typ      — Foundations level  (#set-level("basic"))
//    main-high.typ       — Advanced  level    (#set-level("high"))
//    exercises.typ       — landscape sheet    (#show: exercise-sheet-template)
//    solutions-basic.typ — solutions booklet  (#show: solutions-template...)
//    solutions-high.typ  — solutions booklet  (#show: solutions-template...)
//
//  Three switches control what is rendered:
//    _level    "basic" | "high"   — set once in each main file
//    _ex-mode  false   | true     — set by exercise-sheet-template
//    _sol-mode false   | true     — set by solutions-template
//
//  Convention:
//    * Theory / prose that differs by level → wrap in
//        #only-high[ ... ]   or   #only-basic[ ... ]
//    * Exercises that differ by level → pass  level: "high"
//        to the exercise() function (NOT only-high).
//    * Plain prose & headings that should vanish on the
//      exercise sheet → wrap in  #only-theory[ ... ].
//
//  New environments (2026 rework):
//    exercise(difficulty: 1–3, time: "20 min", hints: (...))
//    print-hints()        — call before print-solutions()
//    ai-box(role: ...)    — AI task with a defined role
//    exploration(...)     — ungraded discovery task
//    toolbox() / heuristic("...") — Pólya heuristics + inline badges
//    abstraction-ladder(l0:, l1:, l2:, l3:) — formalization figure
// ============================================================

#let subject-name = "Sequences & Series"

// ── Accent colors ────────────────────────────────────────────
#let accent    = rgb("#0097a7")   // teal
#let accent-bg = rgb("#e0f7fa")   // light teal fill
#let warn-col  = rgb("#e65100")   // deep orange
#let warn-bg   = rgb("#fff3e0")   // light orange fill
#let def-col   = rgb("#00695c")   // dark teal (definitions)
#let def-bg    = rgb("#e8f5e9")   // light green fill
#let ex-col    = rgb("#5c6bc0")   // indigo (examples)
#let ex-bg     = rgb("#ede7f6")   // light purple fill
#let ai-col    = rgb("#8e24aa")   // purple (AI tasks)
#let ai-bg     = rgb("#f3e5f5")   // light lilac fill
#let expl-col  = rgb("#b26a00")   // dark amber (explorations)
#let expl-bg   = rgb("#fff8e1")   // light amber fill


// ── Rendering switches ───────────────────────────────────────
// _ex-mode  : false = chapter/main mode (theory + exercises + hints)
//             true  = exercise-sheet mode (exercises only, landscape)
#let _ex-mode = state("exercise-mode", false)

// _sol-mode : false = normal
//             true  = solutions-booklet mode (numbers + solutions only)
#let _sol-mode = state("solution-mode", false)

// In the solutions booklet, print each question in small gray above its
// solution (true) or just the numbered solutions (false).
#let _sol-show-questions = state("solution-show-questions", true)

// True whenever theory/prose should be suppressed (sheet or solutions).
// Call only inside a context block.
#let _hide-aux() = _ex-mode.get() or _sol-mode.get()

// _level   : "high" = show everything (default, also for standalone)
//            "basic" = hide #only-high theory and level:"high" exercises
#let _level = state("doc-level", "high")
#let set-level(lvl) = _level.update(_ => lvl)


// ── Chapter registry ─────────────────────────────────────────
// register_chapters takes (title, filename) pairs. include_chapters
// then includes each file in order with a pagebreak between them.
// Heading numbering is handled automatically by Typst's heading
// counter — chapters are numbered 1, 2, 3, … in include order, so
// the same chapter file can be chapter 3 in one document and
// chapter 4 in another with no manual bookkeeping.
#let _chapter-list = state("chapter-list", ())

#let register_chapters(..entries) = {
  _chapter-list.update(_ => entries.pos())
}

#let include_chapters() = context {
  let entries = _chapter-list.get()
  for (i, entry) in entries.enumerate() {
    if i > 0 { pagebreak(weak: true) }
    include entry.at(1) + ".typ"
  }
}

// read-chapter-files — extract the filenames from the
// register_chapters(...) block of a main file, so that derived
// documents (exercise sheet, solutions booklets) always follow the
// same chapter list and order as the lecture notes.
//   #for f in read-chapter-files(from: "main-high.typ") { ... }
#let read-chapter-files(from: "main-high.typ") = {
  let src = read(from)
  let files = ()
  for line in src.split("\n") {
    let t = line.trim()
    if t.starts-with("(\"") {
      let parts = t.split("\",")
      if parts.len() >= 2 {
        let p = parts.at(1)
        let q1 = p.position("\"")
        if q1 != none {
          let after = p.slice(q1 + 1)
          let q2 = after.position("\"")
          if q2 != none {
            files.push(after.slice(0, q2))
          }
        }
      }
    }
  }
  files
}


// ── Counters & solution store ────────────────────────────────
#let thm-counter = counter("theorem")
#let def-counter = counter("definition")
#let ex-counter  = counter("exercise")   // global — never reset
#let hint-store  = state("hints", ())


// ── Page layouts ─────────────────────────────────────────────
#let chapter-page-setup = (
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2.5cm),
  numbering: "1",
)

#let exercise-page-setup = (
  paper: "a4",
  flipped: true,
  margin: (top: 2cm, bottom: 2cm, left: 2.5cm, right: 2.5cm),
  numbering: "1",
)


// ── Base typography ──────────────────────────────────────────
#let apply-base-style(body) = {
  set text(font: "New Computer Modern", size: 11pt, lang: "en")
  set par(justify: true, leading: 0.7em)
  set heading(numbering: "1.1")
  // On the exercise sheet, chapter/section headings carry no exercise
  // content, so suppress them; in the lecture notes they render normally.
  // Sheet mode: no headings (they carry no exercise content).
  // Solutions mode: keep only chapter titles to structure the booklet.
  // Lecture notes: render normally.
  show heading: it => context {
    if _ex-mode.get() { none }
    else if _sol-mode.get() { if it.level == 1 { it } else { none } }
    else { it }
  }
  body
}


// ── Portrait header/footer ───────────────────────────────────
#let _portrait-header(chapter-title: "", body) = {
  set page(
    ..chapter-page-setup,
    header: context {
      let lvl = if _level.get() == "basic" { "Foundations" } else { "Advanced" }
      let tag = if _sol-mode.get() { "Solutions — " + lvl } else { lvl }
      set text(size: 9pt, fill: luma(120))
      grid(
        columns: (1fr, 1fr),
        align(left)[#subject-name — #tag],
        align(right)[#chapter-title],
      )
      v(-4pt)
      line(length: 100%, stroke: 0.5pt + accent)
    },
    footer: context {
      set text(size: 9pt, fill: luma(120))
      line(length: 100%, stroke: 0.3pt + luma(180))
      v(-4pt)
      align(center)[#counter(page).display("1")]
    },
  )
  body
}


// ────────────────────────────────────────────────────────────
//  INTERNAL: left-bar box
// ────────────────────────────────────────────────────────────
#let _bar-box(bar-color: accent, fill-color: accent-bg,
              label: none, number: none, title: none, body) = {
  let hdr = if label != none {
    [#text(weight: "bold", fill: bar-color)[#label#if number != none [ #number]]#if title != none [. _#title _]]
  } else { none }

  block(
    width: 100%,
    breakable: true,
    fill: fill-color,
    radius: 3pt,
    inset: (left: 14pt, right: 10pt, top: 8pt, bottom: 8pt),
    stroke: (left: 4pt + bar-color),
  )[
    #set par(leading: 0.85em)
    #if hdr != none [#hdr \ ]
    #body
  ]
}


// ────────────────────────────────────────────────────────────
//  THEORY ENVIRONMENTS  (all suppress themselves in sheet mode)
// ────────────────────────────────────────────────────────────

#let theorem(title: none, body) = {
  thm-counter.step()
  context {
    if _hide-aux() { return }
    let n = thm-counter.display()
    _bar-box(
      bar-color: accent, fill-color: accent-bg,
      label: "Theorem", number: n, title: title, body,
    )
  }
}

#let proof(body) = context {
  if _hide-aux() { return }
  block(width: 100%,
        inset: (left: 14pt, right: 4pt, top: 4pt, bottom: 4pt))[
    _Proof._ #body #h(1fr) $square$
  ]
}

#let definition(title: none, body) = {
  def-counter.step()
  context {
    if _hide-aux() { return }
    let n = def-counter.display()
    _bar-box(
      bar-color: def-col, fill-color: def-bg,
      label: "Definition", number: n, title: title, body,
    )
  }
}

#let example(title: none, body) = context {
  if _hide-aux() { return }
  _bar-box(
    bar-color: ex-col, fill-color: ex-bg,
    label: "Example", title: title, body,
  )
}

#let remark(body) = context {
  if _hide-aux() { return }
  block(width: 100%,
        inset: (left: 14pt, right: 4pt, top: 2pt, bottom: 2pt))[
    #text(fill: luma(80), style: "italic")[_Remark._ #body]
  ]
}

#let warning(body) = context {
  if _hide-aux() { return }
  block(
    width: 100%,
    breakable: false,
    fill: warn-bg,
    radius: 3pt,
    inset: (left: 14pt, right: 10pt, top: 8pt, bottom: 8pt),
    stroke: (left: 4pt + warn-col),
  )[
    #text(weight: "bold", fill: warn-col)[⚠ Warning] \
    #body
  ]
}

// keybox — a highlighted "key idea / key formula" callout with no counter.
#let keybox(title: none, body) = context {
  if _hide-aux() { return }
  _bar-box(bar-color: accent, fill-color: accent-bg, [
    #if title != none [#text(weight: "bold", fill: accent)[#title] \ ]
    #body
  ])
}

// quotebox — neutral grey callout for stories / quotations.
#let quotebox(body) = context {
  if _hide-aux() { return }
  block(
    width: 100%,
    breakable: true,
    fill: luma(245),
    radius: 3pt,
    inset: (left: 14pt, right: 10pt, top: 8pt, bottom: 8pt),
    stroke: (left: 4pt + luma(160)),
  )[
    #set par(leading: 0.85em)
    #set text(style: "italic", fill: luma(70))
    #body
  ]
}


// ai-box — an AI task with an explicitly defined role. Roles that
// work well (put the role in the students' hands, not the answer):
//   "Explainer" — ask the AI to explain a concept a different way
//   "Checker"   — solve on paper FIRST, then have the AI solve it
//                 and compare line by line; decide who is wrong
//   "Generator" — have the AI produce similar practice problems
//   "Tutor"     — instruct the AI to ask YOU questions, not answer
// Suppressed on the exercise sheet unless on-sheet: true (use that
// when the AI task IS the exercise content).
#let ai-box(role: "Checker", on-sheet: false, body) = context {
  if _sol-mode.get() { return }
  if _ex-mode.get() and not on-sheet { return }
  _bar-box(
    bar-color: ai-col, fill-color: ai-bg,
    label: "AI task", title: "role: " + role,
    {
      body
      v(4pt)
      text(size: 8.5pt, fill: luma(110), style: "italic")[
        Protocol: 1. attempt on paper — 2. AI, in the role above —
        3. verify every AI claim with a check of your own.
      ]
    },
  )
}

// exploration — an ungraded in-class discovery task. The footer line
// states the deal explicitly: one exam problem will grow out of it.
#let exploration(title: none, body) = context {
  if _hide-aux() { return }
  _bar-box(
    bar-color: expl-col, fill-color: expl-bg,
    label: "Exploration", title: title,
    {
      body
      v(4pt)
      text(size: 8.5pt, fill: luma(110), style: "italic")[
        Not graded — but one exam problem will grow out of this exploration.
      ]
    },
  )
}

// toolbox — the Pólya-style heuristics reference box. Print it once
// early in the course, then refer back via #heuristic(...) badges.
#let _heuristics-list = (
  "try small cases",
  "draw a picture",
  "introduce notation",
  "solve a simpler version first",
  "work backwards from the goal",
  "look for what stays the same",
  "check an extreme or special case",
)

#let toolbox(title: "Problem-solving toolbox") = context {
  if _hide-aux() { return }
  _bar-box(bar-color: def-col, fill-color: def-bg, {
    text(weight: "bold", fill: def-col)[#title]
    v(2pt)
    text(size: 10pt)[
      Nobody sees the solution immediately. When you are stuck, pick a move:
    ]
    v(2pt)
    list(indent: 6pt, .._heuristics-list.map(x => emph(x)))
  })
}

// heuristic — inline badge naming the move used, e.g. in a solution:
//   ... here we used #heuristic("try small cases") before conjecturing.
#let heuristic(name) = box(
  fill: def-bg,
  radius: 2pt,
  inset: (x: 4pt, y: 1.5pt),
  text(size: 9pt, fill: def-col, style: "italic", name),
)


// ────────────────────────────────────────────────────────────
//  PARTS — lettered sub-parts in a multi-column grid
// ────────────────────────────────────────────────────────────
#let parts(cols, ..items) = {
  let col-spec = range(cols).map(_ => 1fr)
  grid(
    columns: col-spec,
    row-gutter: 0.55em,
    column-gutter: 1.2em,
    ..items.pos(),
  )
}


// ────────────────────────────────────────────────────────────
//  VISIBILITY WRAPPERS
// ────────────────────────────────────────────────────────────

// only-theory: prose/headings that vanish on the exercise sheet.
#let only-theory(body) = context {
  if _hide-aux() { return }
  body
}

// only-high: theory shown only in the Advanced document.
#let only-high(body) = context {
  if _hide-aux() { return }
  if _level.get() == "basic" { return }
  body
}

// only-basic: theory shown only in the Foundations document.
#let only-basic(body) = context {
  if _hide-aux() { return }
  if _level.get() == "high" { return }
  body
}


// ────────────────────────────────────────────────────────────
//  EXERCISE
//
//  Usage (define a per-chapter shortcut at the top of the file):
//    #let ex = exercise.with(chapter: "Arithmetic")
//    #ex[ <question> ][ <solution> ]
//    #ex(level: "high")[ <question> ][ <solution> ]   // advanced only
//
//  level: "all"  (default) → appears in both documents + sheet
//         "high"           → Advanced document + sheet only
//         "basic"          → Foundations document only
//
//  The exercise number only advances when the exercise is actually
//  shown, so each document is numbered contiguously.
// ────────────────────────────────────────────────────────────
//  New optional parameters (all backward compatible):
//    difficulty: 0        0 = unrated, 1–3 = rating dots ●○○ … ●●●
//    time: none           e.g. "20 min" — prints an expected-effort note
//                         that frames being stuck as part of the task
//    hints: ()            array of content blocks; collected and printed
//                         by print-hints() so students choose how much
//                         help to take, one hint at a time
#let exercise(
  chapter: "Unknown",
  level: "all",
  difficulty: 0,
  time: none,
  hints: (),
  body,
  solution,
) = context {
  let visible = _ex-mode.get() or level == "all" or level == _level.get()
  if not visible { return }

  ex-counter.step()
  // get() resolves at this exercise's location, i.e. it counts all the
  // step()s of PREVIOUS exercises but not the one placed just above
  // (updates inside a context block apply after the block's location).
  // Hence +1 gives this exercise's number. Using display() here instead
  // would show the pre-step value — numbering would start at 0.
  let n = ex-counter.get().first() + 1

  // Difficulty dots — drawn as circles (no font-coverage issues).
  let dot(filled) = box(baseline: 15%, circle(
    radius: 2.3pt,
    fill: if filled { accent } else { white },
    stroke: 0.6pt + accent,
  ))
  let dots = if difficulty > 0 {
    range(3).map(i => dot(i < difficulty)).join(h(2.5pt))
  } else { none }

  let effort-note = if time != none {
    text(size: 9pt, fill: luma(110), style: "italic")[
      Expected effort: #time. Being stuck for part of that time is
      normal — it is part of the exercise, not a sign that you can't do it.
    ]
  } else { none }

  if _ex-mode.get() {
    // ── EXERCISE-SHEET MODE ──────────────────────────────────
    pagebreak(weak: true)
    grid(
      columns: (1fr, 1fr),
      align(left)[#text(weight: "bold", fill: accent)[#chapter]],
      align(right)[
        #if dots != none [#dots #h(0.6em)]
        #text(fill: luma(100))[Exercise #n]
      ],
    )
    line(length: 100%, stroke: 0.5pt + accent)
    v(1.2em)
    body
    if effort-note != none {
      v(0.8em)
      effort-note
    }
    v(1fr)   // leaves the rest of the page blank for working
  } else if _sol-mode.get() {
    // ── SOLUTIONS-BOOKLET MODE ───────────────────────────────
    v(0.9em)
    block(
      width: 100%,
      breakable: true,
      fill: luma(250),
      radius: 3pt,
      inset: (left: 14pt, right: 10pt, top: 8pt, bottom: 8pt),
      stroke: (left: 4pt + accent),
    )[
      #grid(
        columns: (1fr, auto),
        text(weight: "bold", fill: accent)[Exercise #n],
        align(right + horizon)[#dots],
      )
      #if _sol-show-questions.get() [
        #v(0.2em)
        #block(text(size: 9pt, fill: luma(110), body))
        #v(0.2em)
        #line(length: 100%, stroke: 0.3pt + luma(200))
      ]
      #solution
    ]
  } else {
    // ── CHAPTER / MAIN MODE ──────────────────────────────────
    v(0.6em)
    block(
      width: 100%,
      breakable: true,
      fill: accent-bg,
      radius: 3pt,
      inset: (left: 14pt, right: 10pt, top: 8pt, bottom: 8pt),
      stroke: (left: 4pt + accent),
    )[
      #grid(
        columns: (1fr, auto),
        text(weight: "bold", fill: accent)[Exercise #n],
        align(right + horizon)[#dots],
      )
      #body
      #if effort-note != none [#v(0.4em) #effort-note]
    ]
    v(0.4em)
    if hints.len() > 0 {
      hint-store.update(hs => hs + ((number: n, hints: hints),))
    }
  }
}


// ────────────────────────────────────────────────────────────
//  PRINT-SOLUTIONS — DEPRECATED (kept as a no-op so that older
//  chapter files still compile; the call can simply be deleted).
//  Solutions now live in their own booklets: solutions-basic.typ
//  and solutions-high.typ render each exercise's solution at the
//  exercise site, in a separate document.
// ────────────────────────────────────────────────────────────
#let print-solutions() = none


// ────────────────────────────────────────────────────────────
//  PRINT-HINTS — place once at the end of every chapter file,
//  BEFORE print-solutions(). Only exercises that were given a
//  hints: (...) argument appear here.
// ────────────────────────────────────────────────────────────
#let print-hints() = context {
  if _hide-aux() { return }
  let entries = hint-store.get()
  if entries.len() == 0 { return }

  v(1.5em)
  line(length: 100%, stroke: 0.5pt + luma(180))
  v(0.3em)
  text(weight: "bold", size: 12pt)[Hints]
  linebreak()
  text(size: 9pt, fill: luma(110), style: "italic")[
    Take one hint at a time, then return to the exercise. Reading all
    hints at once turns an exercise into a worked example.
  ]
  v(0.6em)

  for entry in entries {
    grid(
      columns: (2.5cm, 1fr),
      gutter: 0.4em,
      text(weight: "bold", fill: accent)[Ex. #entry.number],
      {
        for (i, hint) in entry.hints.enumerate() {
          if i > 0 { v(0.25em) }
          [_Hint #(i + 1)._ #hint]
        }
      },
    )
    v(0.5em)
  }

  hint-store.update(_ => ())
}


// ────────────────────────────────────────────────────────────
//  CHAPTER TEMPLATE — apply at the top of every chapter file:
//    #show: chapter-template.with(title: "Arithmetic Sequences and Series")
// ────────────────────────────────────────────────────────────
#let chapter-template(title: "Untitled", body) = context {
  thm-counter.update(0)
  def-counter.update(0)
  if _ex-mode.get() {
    body
  } else {
    apply-base-style(_portrait-header(chapter-title: title, body))
  }
}


// ────────────────────────────────────────────────────────────
//  EXERCISE-SHEET TEMPLATE — apply at the top of exercises.typ only.
// ────────────────────────────────────────────────────────────
#let exercise-sheet-template(body) = {
  _ex-mode.update(true)
  set page(..exercise-page-setup)
  apply-base-style(body)
}


// ────────────────────────────────────────────────────────────
//  SOLUTIONS TEMPLATE — apply at the top of a solutions entry
//  file only (see solutions-basic.typ / solutions-high.typ):
//    #show: solutions-template.with(level: "high")
//  Renders ONLY exercise numbers and solutions (plus, optionally,
//  each question in small gray for orientation); all theory,
//  hints, and boxes are suppressed. Exercise numbering respects
//  the level, so it matches the corresponding lecture notes.
//    level:          "basic" | "high"
//    show-questions: true (default) | false for a compact booklet
// ────────────────────────────────────────────────────────────
#let solutions-template(level: "high", show-questions: true, body) = {
  set-level(level)
  _sol-mode.update(true)
  _sol-show-questions.update(_ => show-questions)
  set page(..chapter-page-setup)
  apply-base-style(body)
}


// ── Math shorthands ──────────────────────────────────────────
#let NN = $bb(N)$
#let ZZ = $bb(Z)$
#let QQ = $bb(Q)$
#let RR = $bb(R)$
#let CC = $bb(C)$
#let abs(x)  = $lr(|#x|)$
#let limn = $lim_(n -> oo)$    // limit as n → ∞


// ════════════════════════════════════════════════════════════
//  NATIVE FIGURE HELPERS
//  Drawn with built-in Typst shapes only (no external packages),
//  so they compile offline. Each is one self-contained call —
//  if a figure ever misbehaves it can be removed in isolation.
// ════════════════════════════════════════════════════════════

// dot-triangle(rows) — triangular arrangement of dots (1+2+…+rows).
#let dot-triangle(rows: 4, r: 4pt, gap: 18pt, col: accent) = only-theory(align(center, {
  let w = (rows - 1) * gap + 2 * r
  let h = (rows - 1) * gap + 2 * r
  box(width: w, height: h, {
    for row in range(rows) {
      let count = row + 1
      let cy = r + row * gap
      let rowwidth = (count - 1) * gap
      let startx = (w - rowwidth) / 2
      for c in range(count) {
        let cx = startx + c * gap
        place(dx: cx - r, dy: cy - r, circle(radius: r, fill: col, stroke: none))
      }
    }
  })
}))

// domino-row(n) — a row of standing dominoes (induction "domino effect").
#let domino-row(n: 7, col: accent) = only-theory(align(center,
  stack(
    dir: ltr,
    spacing: 9pt,
    ..range(n).map(_ => rect(width: 6pt, height: 28pt, radius: 1pt,
                             fill: col, stroke: none)),
  )
))

// koch-star — the first iteration of the Koch snowflake (a hexagram).
#let koch-star(R: 1.7cm, col: accent, fillc: accent-bg) = only-theory(align(center, {
  let r = R / calc.sqrt(3)
  let cx = R
  let cy = R
  let pts = ()
  for k in range(12) {
    let rad = if calc.even(k) { R } else { r }
    let ang = 90deg - k * 30deg
    pts.push((cx + rad * calc.cos(ang), cy - rad * calc.sin(ang)))
  }
  box(width: 2 * R, height: 2 * R,
      polygon(fill: fillc, stroke: 0.9pt + col, ..pts))
}))

// nested-squares(levels) — squares formed by joining midpoints, repeated.
#let nested-squares(side: 3cm, levels: 5, col: accent) = only-theory(align(center, {
  box(width: side, height: side, {
    let corners = ((0pt, 0pt), (side, 0pt), (side, side), (0pt, side))
    for lvl in range(levels) {
      let shade = if calc.even(lvl) { none } else { accent-bg }
      place(dx: 0pt, dy: 0pt,
            polygon(fill: shade, stroke: 0.8pt + col, ..corners))
      let nc = ()
      let m = corners.len()
      for i in range(m) {
        let a = corners.at(i)
        let b = corners.at(calc.rem(i + 1, m))
        nc.push(((a.at(0) + b.at(0)) / 2, (a.at(1) + b.at(1)) / 2))
      }
      corners = nc
    }
  })
}))


// abstraction-ladder — the recurring 4-rung "levels of abstraction"
// figure. Use it every time a situation is formalized so the jump to
// a formula becomes a named, practiced move instead of magic.
//   Level 0  the situation (a story)
//   Level 1  the data (numbers, a table)
//   Level 2  the pattern (recursive / verbal description)
//   Level 3  the formula (explicit, symbolic)
// Rungs narrow toward the top: abstraction distills.
#let abstraction-ladder(
  l0: [—], l1: [—], l2: [—], l3: [—],
  labels: ("Situation", "Data", "Pattern", "Formula"),
) = only-theory(block(width: 100%, breakable: false, {
  let rungs = (
    (3, labels.at(3), l3, 58%),
    (2, labels.at(2), l2, 71%),
    (1, labels.at(1), l1, 84%),
    (0, labels.at(0), l0, 97%),
  )
  for (i, r) in rungs.enumerate() {
    let (lvl, lab, content, w) = r
    align(center, box(width: w, block(
      width: 100%,
      fill: if lvl == 3 { accent-bg } else { white },
      radius: 3pt,
      stroke: 0.8pt + accent,
      inset: (x: 10pt, y: 7pt),
      {
        text(size: 9pt, weight: "bold", fill: accent)[Level #lvl — #lab]
        linebreak()
        text(size: 10pt, content)
      },
    )))
    if i < rungs.len() - 1 {
      v(1pt)
      align(center, text(size: 9pt, fill: accent)[#sym.arrow.t #emph[formalize]])
      v(1pt)
    }
  }
}))


// ── Table style ──────────────────────────────────────────────
// Worksheet-friendly table with a full grid:
//   • Full outer border, vertical dividers between every column,
//     horizontal rules between every row.
//   • Header row: tinted background, bold accent text, thick accent
//     bottom rule.
//   • Label column (col 0 in body rows): subtle tint — not writable.
//   • Data cells: white background — space for students to write.
//   • row-height controls body-row height (default 1.8cm gives plenty
//     of writing room; pass `auto` for a compact table).
//
//   #data-table(
//     columns: (auto, 1fr, 1fr, 1fr),
//     [], [(a)], [(b)], [(c)],
//     [$a_1$], [3], [], [7],
//     [$d$],   [], [2], [],
//   )
#let data-table(columns: (), row-height: 1.8cm, ..cells) = {
  let n-cols = if type(columns) == array { columns.len() } else { columns }
  let items  = cells.pos()
  let n-rows = int(items.len() / n-cols)   // includes the header row

  // Row-height tuple: header auto-sizes, body rows use row-height.
  let row-sizes = if row-height == auto {
    auto
  } else {
    (auto,) + range(n-rows - 1).map(_ => row-height)
  }

  // Per-cell stroke:  left/top draw the border of each cell so that
  // adjacent borders never double up; right/bottom close the outer edge.
  let cell-stroke(col, row) = (
    left:   if col == 0           { 0.9pt + luma(110) }
            else                  { 0.5pt + luma(190) },
    right:  if col == n-cols - 1  { 0.9pt + luma(110) }
            else                  { none },
    top:    if row == 0           { 0.9pt + luma(110) }
            else                  { none },
    bottom: if row == 0           { 1.5pt + accent }
            else if row == n-rows - 1 { 0.9pt + luma(110) }
            else                  { 0.5pt + luma(190) },
  )

  table(
    columns: columns,
    rows:    row-sizes,
    stroke:  none,           // individual cells carry their own strokes
    inset:   (x: 0.65em, y: 0.45em),
    align:   center + horizon,
    ..items.enumerate().map(((idx, c)) => {
      let row = int(idx / n-cols)
      let col = calc.rem(idx, n-cols)
      let s   = cell-stroke(col, row)
      if row == 0 {
        // Header row — column labels
        table.cell(
          text(weight: "bold", fill: accent, c),
          fill:   luma(244),
          stroke: s,
        )
      } else if col == 0 {
        // Label column — row variable names
        table.cell(
          text(fill: luma(40), c),
          fill:   luma(248),
          stroke: s,
        )
      } else {
        // Data cells — given values or blank (to be filled in)
        table.cell(c, fill: white, stroke: s)
      }
    }),
  )
}
