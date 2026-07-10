// ============================================================
//  preamble.typ — shared engine
//  Import with:  #import "preamble.typ": *
//
//  Originally built for the Sequences & Series unit; now shared
//  across all units. Entry points per unit look like:
//    main-basic.typ      — Foundations level  (#set-level("basic"))
//    main-high.typ       — Advanced  level    (#set-level("high"))
//    exercises.typ       — landscape sheet    (#show: exercise-sheet-template)
//    solutions-basic.typ — solutions booklet  (#show: solutions-template...)
//    solutions-high.typ  — solutions booklet  (#show: solutions-template...)
//
//  Above that, YEAR-LEVEL entry points (years/glf-y1.typ, etc.)
//  span multiple units in one document — see the "part" system
//  below register_chapters.
//
//  Switches controlling what is rendered:
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
//  Environments:
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

// _current-part : none | string
// Used only by multi-unit documents (year-level binders that read
// several units back-to-back, e.g. Algebra & Functions, then
// Trigonometry, then Descriptive Statistics). Unit-scoped documents
// (main-basic.typ, main-high.typ, exercises.typ, solutions-*.typ)
// never touch this, and the header falls back to the fixed
// `subject-name` constant exactly as before — fully backward
// compatible with every existing chapter/unit file.
#let _current-part = state("current-part", none)


// ── Chapter registry ─────────────────────────────────────────
// register_chapters takes entries of two shapes:
//   ("Title", "/path/from/root/filename")            — unit-scoped document
//   ("Title", "/path/from/root/filename", "Part")     — multi-unit document;
//                                       a divider page is inserted
//                                       automatically whenever "Part"
//                                       changes from the previous entry.
//
// IMPORTANT — the filename MUST be a root-absolute path (starting with
// "/", resolved against whatever --root the compiler was given), NOT a
// bare filename like "ch-basics". This is not a style preference — it's
// required for correctness. Typst resolves a file path relative to the
// file the path-taking call is textually written in, not relative to
// whichever file called that code. include_chapters()'s `include`
// statement (and read-chapter-files()'s `read()` below) are written
// inside THIS file (preamble.typ, living in src/common/), so a bare
// relative filename would resolve against src/common/ and fail with
// "file not found" — regardless of which main-*.typ registered it.
// Root-absolute paths sidestep this entirely, since Typst resolves
// them against the project root itself, independent of which file's
// source contains the include/read call.
//
// TWO DIFFERENT CONVENTIONS DEPENDING ON WHO READS THE FILE BACK:
//
// (a) A unit's OWN main-basic.typ / main-high.typ — these get read
//     back by read-chapter-files() (from that unit's exercises.typ
//     and solutions-*.typ), and that function reads the file as
//     PLAIN TEXT and pattern-matches literal quoted strings — it
//     does not evaluate Typst expressions. So each entry's path
//     must be a full literal string, written out in full, e.g.
//     (from src/units/sequences-series/main-high.typ):
//       #register_chapters(
//         ("Basics", "/src/units/sequences-series/ch-basics"),
//         ("Arithmetic", "/src/units/sequences-series/ch-arithmetic"),
//       )
//     A `#let unit = "/src/..."` shortcut would break silently here:
//     read-chapter-files() would only recover the bare suffix after
//     the "+" (e.g. "ch-basics"), losing the root-absolute prefix,
//     and whichever file called read-chapter-files() would then hit
//     this exact same access-denied/file-not-found problem itself.
//
// (b) Anything NOT read back by read-chapter-files() — currently
//     that's only the multi-unit years/*.typ binders — CAN use a
//     `#let` shortcut safely, since nothing re-parses these files as
//     text; Typst evaluates the concatenation normally:
//       #let af = "/src/units/algebra-functions/"
//       #register_chapters(
//         ("Algebra Foundations", af + "ch-algebra-foundations", "Algebra & Functions"),
//       )
//
// include_chapters then includes each file in order with a pagebreak
// (or a part-divider, when the part changes) between them. Heading
// numbering is handled automatically by Typst's heading counter —
// chapters are numbered 1, 2, 3, … in include order, so the same
// chapter file can be chapter 3 in one document and chapter 7 in
// another with no manual bookkeeping.
#let _chapter-list = state("chapter-list", ())

#let register_chapters(..entries) = {
  _chapter-list.update(_ => entries.pos())
}

// part-divider — plain full-page title marking the start of a new
// part in a multi-unit document. Deliberately minimal (no counters,
// no header/footer dependency) so it never fights with whichever
// chapter-page-setup is active around it.
#let part-divider(title) = {
  pagebreak(weak: true)
  align(center + horizon, block(width: 80%, {
    line(length: 40%, stroke: 1pt + accent)
    v(0.6em)
    text(size: 22pt, weight: "bold", fill: accent)[#title]
    v(0.6em)
    line(length: 40%, stroke: 1pt + accent)
  }))
  pagebreak(weak: true)
}

#let include_chapters() = context {
  let entries = _chapter-list.get()
  let last-part = none
  for (i, entry) in entries.enumerate() {
    let file = entry.at(1)
    let part = entry.at(2, default: none)

    if part != none and part != last-part {
      part-divider(part)
      _current-part.update(_ => part)
      last-part = part
    } else if i > 0 {
      pagebreak(weak: true)
    }
    include file + ".typ"
  }
}

// read-chapter-files — extract the filenames from the
// register_chapters(...) block of a main file, so that derived
// documents (exercise sheet, solutions booklets) always follow the
// same chapter list and order as the lecture notes.
//   #for f in read-chapter-files(from: "/src/units/sequences-series/main-high.typ") { ... }
// IMPORTANT: `from` must also be root-absolute, same reasoning as
// register_chapters above — this function's `read()` call lives in
// preamble.typ, so a bare "main-high.typ" would resolve against
// src/common/ and fail. Reads only the filename (2nd element) of
// each entry; part labels (3rd element, if present) are irrelevant
// here since exercise sheets and solutions booklets stay unit-scoped
// by design.
// NOTE: this reads the main file as plain text and pattern-matches
// quoted strings — it does NOT evaluate Typst expressions. Each
// register_chapters entry's filename must therefore still appear as
// a literal quoted string on its own line (e.g. unit + "ch-basics"
// written out, or the full literal path) for this parser to see it;
// see the register_chapters comment above for the exact convention.
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
#let ex-counter  = counter("exercise")   // global to whatever gets compiled —
                                          // see numbering-scope note re:
                                          // unit booklets vs. year binders
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
  // Headings must never be the last thing on a page with their content
  // starting fresh on the next one — sticky: true pushes a heading (and
  // whatever follows) to the next page together if it would otherwise
  // land alone at the bottom. This is the systematic fix for the
  // "orphaned heading" layout problem; #pagebreak() (Typst's direct
  // equivalent of LaTeX's \newpage) remains the right tool for any
  // other one-off spot that needs a manual, unconditional page break.
  show heading: set block(sticky: true)
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
      // Multi-unit documents show whichever part is currently active;
      // unit-scoped documents (part never set) fall back to the fixed
      // subject-name constant exactly as before.
      let label = {
        let p = _current-part.get()
        if p != none { p } else { subject-name }
      }
      let tag = if _sol-mode.get() { "Solutions — " + lvl } else { lvl }
      set text(size: 9pt, fill: luma(120))
      grid(
        columns: (1fr, 1fr),
        align(left)[#label — #tag],
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
//  (NOTE: unrelated to the "part" concept above — this is the
//  original multi-column layout helper for (a)/(b)/(c) exercise
//  sub-items, kept under its original name so existing chapter
//  files keep working unmodified.)
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
//    #ex(keep-together: true)[ <question with a table> ][ <solution> ]
//
//  level: "all"  (default) → appears in both documents + sheet
//         "high"           → Advanced document + sheet only
//         "basic"          → Foundations document only
//
//  keep-together: false (default) → exercise box may split across a
//         page break, same as before this parameter existed
//         true  → the whole exercise box (chapter/main mode AND
//         solutions-booklet mode) is kept on one page — use this for
//         anything containing a data-table() or other content that
//         looks broken if split mid-table. Not the default everywhere
//         because forcing every exercise to stay whole can leave
//         awkward gaps at the bottom of a page for longer exercises;
//         opt in per exercise instead. If a keep-together: true
//         exercise is taller than a full page, it will overflow
//         rather than fit — that's a sign to reconsider the exercise
//         itself (split it into two), not a bug in this setting.
// ────────────────────────────────────────────────────────────
#let exercise(
  chapter: "Unknown",
  level: "all",
  difficulty: 0,
  time: none,
  hints: (),
  keep-together: false,
  body,
  solution,
) = context {
  let visible = _ex-mode.get() or level == "all" or level == _level.get()
  if not visible { return }

  ex-counter.step()
  // get() resolves at this exercise's location, i.e. it counts all the
  // step()s of PREVIOUS exercises but not the one placed just above
  // (updates inside a context block apply after the block's location).
  // Hence +1 gives this exercise's number.
  let n = ex-counter.get().first() + 1

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
    v(1fr)
  } else if _sol-mode.get() {
    // ── SOLUTIONS-BOOKLET MODE ───────────────────────────────
    v(0.9em)
    block(
      width: 100%,
      breakable: not keep-together,
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
      breakable: not keep-together,
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
// ────────────────────────────────────────────────────────────
#let print-solutions() = none


// ────────────────────────────────────────────────────────────
//  PRINT-HINTS
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
//  EXERCISE-SHEET TEMPLATE
// ────────────────────────────────────────────────────────────
#let exercise-sheet-template(body) = {
  _ex-mode.update(true)
  set page(..exercise-page-setup)
  apply-base-style(body)
}


// ────────────────────────────────────────────────────────────
//  SOLUTIONS TEMPLATE
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
//  NATIVE FIGURE HELPERS  (unchanged)
// ════════════════════════════════════════════════════════════

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

#let domino-row(n: 7, col: accent) = only-theory(align(center,
  stack(
    dir: ltr,
    spacing: 9pt,
    ..range(n).map(_ => rect(width: 6pt, height: 28pt, radius: 1pt,
                             fill: col, stroke: none)),
  )
))

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
#let data-table(columns: (), row-height: 1.8cm, ..cells) = {
  let n-cols = if type(columns) == array { columns.len() } else { columns }
  let items  = cells.pos()
  let n-rows = int(items.len() / n-cols)

  let row-sizes = if row-height == auto {
    auto
  } else {
    (auto,) + range(n-rows - 1).map(_ => row-height)
  }

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
    stroke:  none,
    inset:   (x: 0.65em, y: 0.45em),
    align:   center + horizon,
    ..items.enumerate().map(((idx, c)) => {
      let row = int(idx / n-cols)
      let col = calc.rem(idx, n-cols)
      let s   = cell-stroke(col, row)
      if row == 0 {
        table.cell(
          text(weight: "bold", fill: accent, c),
          fill:   luma(244),
          stroke: s,
        )
      } else if col == 0 {
        table.cell(
          text(fill: luma(40), c),
          fill:   luma(248),
          stroke: s,
        )
      } else {
        table.cell(c, fill: white, stroke: s)
      }
    }),
  )
}


// ════════════════════════════════════════════════════════════
//  IMAGES — external image files (photos, scans, screenshots,
//  complex GeoGebra/Desmos exports not worth hand-coding). Per
//  STYLE_GUIDE.md §7, every unit keeps these in an `images/`
//  folder next to its chapter files.
//
//  fig() does NOT load the image itself — it only centers whatever
//  content you give it and adds an optional caption below. This is
//  a change from an earlier version that took a bare filename and
//  hardcoded the "images/" prefix internally: that doesn't actually
//  work, because Typst resolves a file path relative to wherever the
//  #image(...) call is textually written, not relative to whichever
//  chapter called the function containing it. Since fig() lives in
//  preamble.typ (in src/common/), an #image("images/" + filename)
//  call written inside fig() would always look in src/common/images/
//  — never the calling chapter's own images/ folder. The #image(...)
//  call has to be written directly in the chapter file itself for
//  its relative path to resolve against that chapter's own location.
//
//  Usage:
//    #fig(image("images/linear-transformation-example.png", width: 80%))
//    #fig(image("images/quadratic-vertex-sketch.svg", width: 60%), caption: [
//      Shifting the parabola 2 units left and 1 unit up.
//    ])
//
//  Like plot-graph below (and unlike the purely decorative
//  dot-triangle / koch-star / nested-squares above), fig() is NOT
//  wrapped in only-theory — a photo can just as easily be part of
//  an exercise's question or its solution as part of theory prose.
//  Wrap a specific call in #only-theory[...] yourself if you want
//  that occurrence suppressed on the exercise sheet.
// ════════════════════════════════════════════════════════════
#let fig(body, caption: none) = align(center, block(width: 100%, {
  body
  if caption != none {
    v(4pt)
    text(size: 9pt, fill: luma(110), style: "italic", caption)
  }
}))


// ════════════════════════════════════════════════════════════
//  PLOT-GRAPH — thin house-style wrapper around the simple-plot
//  package (https://typst.app/universe/package/simple-plot/),
//  pinned at 0.9.1. simple-plot does the actual rendering (axes,
//  stealth arrows, grid, Liang-Barsky clipping at the boundary,
//  discontinuity gaps) — all of it more completely and more
//  robustly than the hand-rolled version this replaced. Its
//  defaults already match what we built by hand: axis-x-extend /
//  axis-y-extend default to (0, 0.5) — positive-direction-only,
//  half-a-unit overshoot — and unit-label-only is its name for the
//  "show only the 1 tick" behavior. Also pulls in riemann-sum and
//  volume-of-revolution, both relevant once the calculus unit
//  starts, and scatter / line-plot for real-data plots (useful for
//  the future statistics units).
//
//  plot-graph below is a convenience layer for the common "plot a
//  few functions with our house colors" case — NOT full coverage
//  of simple-plot's API. For anything it doesn't expose (markers,
//  label-pos / label-side, per-function domains, scatter/line-plot,
//  Riemann sums, volumes of revolution, ...), call `plot` (or the
//  relevant function) directly — both are imported below and
//  available anywhere #import "preamble.typ": * is used.
//
//  Usage (same call shape as before):
//    #plot-graph(
//      x => x * x - 2,
//      (fn: x => 2 * x - 1, color: warn-col),
//      xmin: -3, xmax: 3, ymin: -3, ymax: 6,
//    )
//
//  GOTCHA — sizing is bare numbers, not Typst lengths: simple-plot's
//  width:/height: (and this wrapper's size:/width:/height:) are
//  plain numbers meaning centimeters, e.g. size: 7, NOT 7cm. That's
//  simple-plot's own convention; kept as-is rather than translated,
//  to avoid a fragile unit-conversion layer. It's the one place in
//  this preamble that doesn't take a Typst length.
//
//  Undefined points: same convention as before — return `none` from
//  a function at any x where it's genuinely undefined, e.g.
//    x => if calc.abs(x) < 1e-9 { none } else { 1 / x }
//  simple-plot handles the resulting gap itself (and clips cleanly
//  at the plot boundary); there's no more manual "off the chart"
//  distance check to worry about.
//
//  NOTE: like fig() above, this is NOT wrapped in only-theory — a
//  graph is often part of an exercise's question or its solution,
//  not just theory prose. Wrap a specific call in #only-theory[...]
//  yourself if you want that occurrence suppressed on the exercise
//  sheet.
// ════════════════════════════════════════════════════════════
#import "@preview/simple-plot:0.9.1": plot, scatter, line-plot, riemann-sum, volume-of-revolution, set-plot-defaults, reset-plot-defaults

#let _plot-colors = (accent, warn-col, def-col, ex-col, ai-col, expl-col)

#let plot-graph(
  ..functions,
  xmin: -5,
  xmax: 5,
  ymin: -5,
  ymax: 5,
  size: 7,
  width: none,
  height: none,
  samples: 150,
  grid-step: 1,
  show-grid: true,
  show-unit-ticks: true,
  x-label: $x$,
  y-label: $y$,
) = align(center, {
  let w = if width  != none { width }  else { size }
  let h = if height != none { height } else { size }

  // normalize each argument to a simple-plot function-spec dict,
  // translating our `color:` convenience key to simple-plot's
  // `stroke:`, and cycling default colors from the house palette
  // (same normalization pattern used throughout this file, e.g. in
  // data-table's cell styling)
  let entries = functions.pos().enumerate().map(((i, f)) => {
    let default-color = _plot-colors.at(calc.rem(i, _plot-colors.len()))
    if type(f) == dictionary {
      (
        fn: f.fn,
        stroke: f.at("color", default: default-color) + 1.3pt,
        samples: f.at("samples", default: samples),
      )
    } else {
      (fn: f, stroke: default-color + 1.3pt, samples: samples)
    }
  })

  plot(
    xmin: xmin, xmax: xmax, ymin: ymin, ymax: ymax,
    width: w, height: h,
    show-grid: if show-grid { "major" } else { false },
    xtick-step: grid-step, ytick-step: grid-step,
    unit-label-only: show-unit-ticks,
    xlabel: x-label, ylabel: y-label,
    ..entries,
  )
})


// ════════════════════════════════════════════════════════════
//  IMAGE-GRID — arrange images, plots, or any other visual content
//  in an evenly-spaced N-column grid (2×2, 3×1, whatever the column
//  count and item count work out to — extra items automatically
//  wrap onto a new row, same as CSS/HTML grid auto-flow). This is
//  the native replacement for reaching at a LaTeX multicols-style
//  workaround: multicols was built for flowing paragraph text across
//  columns, not laying out discrete images — grid() is a real grid.
//
//  Usage:
//    #image-grid(2,
//      fig(image("images/before.png", width: 100%)),
//      fig(image("images/after.png", width: 100%)),
//    )                                                     // 2×1
//
//    #image-grid(2,
//      image("images/a.png", width: 100%), image("images/b.png", width: 100%),
//      image("images/c.png", width: 100%), image("images/d.png", width: 100%),
//    )                                                     // 2×2 (4 items ÷ 2 cols = 2 rows)
//
//  Give each image an explicit width: 100% (or similar) on its own
//  #image(...) call so it fills its grid cell consistently — Typst
//  does not auto-scale images to fit a grid column, so differently
//  sized source files will otherwise produce an uneven-looking grid.
//
//  plot-graph() outputs work here too, but remember its size:/width:/
//  height: are absolute centimeters (see the plot-graph comment
//  above), not relative to the grid cell — pick a smaller size: for
//  each plot when placing several side by side so they actually fit
//  the page width together with the gutter, e.g. size: 6 rather than
//  the 7cm default for a 2-column grid.
#let image-grid(cols, ..items, gutter: 12pt, column-gutter: none, row-gutter: none) = grid(
  columns: (1fr,) * cols,
  column-gutter: if column-gutter != none { column-gutter } else { gutter },
  row-gutter: if row-gutter != none { row-gutter } else { gutter },
  ..items.pos(),
)
