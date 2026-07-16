// ============================================================
//  preamble.typ — shared engine
//  Import with:  #import "preamble.typ": *
//
//  Originally built for the Sequences & Series unit; now shared
//  across all units. Entry points per unit look like:
//    main-basic.typ       — Foundations level  (#set-level("basic"))
//    main-high.typ        — Advanced  level    (#set-level("high"))
//    exercises-basic.typ  — landscape sheet, Foundations
//                           (#show: exercise-sheet-template.with(level: "basic"))
//    exercises-high.typ   — landscape sheet, Advanced
//                           (#show: exercise-sheet-template.with(level: "high"))
//    solutions-basic.typ  — solutions booklet  (#show: solutions-template...)
//    solutions-high.typ   — solutions booklet  (#show: solutions-template...)
//
//  Sheets are split per level for the same reason the solutions
//  booklets are: GLF and SPF number exercises differently, so a
//  single mixed sheet could not match either booklet's numbering.
//  Each sheet reads its chapter list from the MATCHING main file
//  via read-chapter-files(from:).
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
//    objectives(..items)  — chapter-opening learning objectives box;
//                           items via obj(...) / bfkm(...) constructors
//    vocab(en, de) / print-vocab() — immersion glossary: mark terms
//                           inline, print an EN–DE table at chapter end
//    num(x)               — Swiss number formatting (12'345.5), safe
//                           in math mode (never type ' in math — prime!)
// ============================================================

// subject-name is per-document, not a global constant — every unit's
// main-basic.typ / main-high.typ / exercises.typ / solutions-*.typ must
// call set-subject-name("...") near the top (right after importing this
// file) to identify itself in the header. The fallback below is
// deliberately an obvious placeholder rather than a plausible-looking
// unit name — if you ever see "Untitled Unit" in a header, that's the
// signal a set-subject-name(...) call is missing from that file, not a
// silent mislabel like defaulting to some other unit's name would be.
#let _subject-name = state("subject-name", "Untitled Unit")
#let set-subject-name(name) = _subject-name.update(_ => name)

// ── Accent colors ────────────────────────────────────────────
#let accent = rgb("#0097a7")   // teal
#let accent-bg = rgb("#e0f7fa")   // light teal fill
#let warn-col = rgb("#e65100")   // deep orange
#let warn-bg = rgb("#fff3e0")   // light orange fill
#let def-col = rgb("#00695c")   // dark teal (definitions)
#let def-bg = rgb("#e8f5e9")   // light green fill
#let ex-col = rgb("#5c6bc0")   // indigo (examples)
#let ex-bg = rgb("#ede7f6")   // light purple fill
#let ai-col = rgb("#8e24aa")   // purple (AI tasks)
#let ai-bg = rgb("#f3e5f5")   // light lilac fill
#let expl-col = rgb("#b26a00")   // dark amber (explorations)
#let expl-bg = rgb("#fff8e1")   // light amber fill
#let ahead-col = rgb("#455a64")   // slate blue-grey (look-aheads)
#let ahead-bg = rgb("#eceff1")   // light blue-grey fill
#let goal-col = rgb("#33691e")   // dark olive (learning objectives)
#let goal-bg = rgb("#f9fbe7")   // light lime fill


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
// never touch this, and the header falls back to whatever that
// document's own set-subject-name(...) call declared (see above).
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
#let ex-counter = counter("exercise")   // global to whatever gets compiled —
// see numbering-scope note re:
// unit booklets vs. year binders
#let hint-store = state("hints", ())
#let vocab-store = state("vocab", ())   // (en:, de:) pairs collected by
// vocab(), printed by print-vocab()
// at the chapter's end — same
// collect-then-print pattern as
// hint-store above


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
    if _ex-mode.get() { none } else if _sol-mode.get() {
      if it.level == 1 { it } else { none }
    } else { it }
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
      // unit-scoped documents (part never set) fall back to whatever
      // this document's own set-subject-name(...) call declared.
      let label = {
        let p = _current-part.get()
        if p != none { p } else { _subject-name.get() }
      }
      let tag = if _sol-mode.get() { "Solutions — " + lvl } else { lvl }
      set text(size: 9pt, fill: luma(120))
      grid(
        columns: (1fr, 1fr),
        align(left)[#label — #tag], align(right)[#chapter-title],
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
#let _bar-box(
  bar-color: accent,
  fill-color: accent-bg,
  label: none,
  number: none,
  title: none,
  body,
) = {
  let hdr = if label != none {
    [#text(weight: "bold", fill: bar-color)[#label#if (
          number != none
        ) [ #number]]#if title != none [. _#title _]]
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
      bar-color: accent,
      fill-color: accent-bg,
      label: "Theorem",
      number: n,
      title: title,
      body,
    )
  }
}

#let proof(body) = context {
  if _hide-aux() { return }
  block(width: 100%, inset: (left: 14pt, right: 4pt, top: 4pt, bottom: 4pt))[
    _Proof._ #body #h(1fr) $square$
  ]
}

#let definition(title: none, body) = {
  def-counter.step()
  context {
    if _hide-aux() { return }
    let n = def-counter.display()
    _bar-box(
      bar-color: def-col,
      fill-color: def-bg,
      label: "Definition",
      number: n,
      title: title,
      body,
    )
  }
}

#let example(title: none, body) = context {
  if _hide-aux() { return }
  _bar-box(
    bar-color: ex-col,
    fill-color: ex-bg,
    label: "Example",
    title: title,
    body,
  )
}

#let remark(body) = context {
  if _hide-aux() { return }
  block(width: 100%, inset: (left: 14pt, right: 4pt, top: 2pt, bottom: 2pt))[
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
    #v(.1cm)
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
    bar-color: ai-col,
    fill-color: ai-bg,
    label: "AI task",
    title: "role: " + role,
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
    bar-color: expl-col,
    fill-color: expl-bg,
    label: "Exploration",
    title: title,
    {
      body
      v(4pt)
      text(size: 8.5pt, fill: luma(110), style: "italic")[
        Not graded — but one exam problem may grow out of this exploration.
      ]
    },
  )
}

// look-ahead — spiral-curriculum callout, distinct in purpose from
// exploration() above: exploration() is guided discovery of something
// NEW; look-ahead() names something students ALREADY know (often
// intuitively, from a special case) as an instance of a bigger idea
// they'll meet formally later. Two flavors, one box:
//   "you already secretly know this — let's name it properly"
//     e.g. natural-number powers before formal power functions
//   "here's a taste of something bigger, coming later"
//     e.g. estimating a parabola's slope by eye, before derivatives
// preview: names the DESTINATION TOPIC (not a chapter number — chapter
// numbers shift with include order, see register_chapters) that this
// foreshadows, rendered as a small forward-reference line. Omit it if
// the look-ahead doesn't point at one specific future topic.
#let look-ahead(title: none, preview: none, body) = context {
  if _hide-aux() { return }
  _bar-box(
    bar-color: ahead-col,
    fill-color: ahead-bg,
    label: "Look Ahead",
    title: title,
    {
      body
      if preview != none {
        v(4pt)
        text(size: 8.5pt, fill: luma(110), style: "italic")[
          ↗ This previews an idea we'll study formally in #preview.
        ]
      }
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

// known-techniques — a running "here's what's in your toolkit so far"
// recap, distinct from toolbox() above: toolbox() lists general Pólya-
// style problem-solving MOVES (try small cases, draw a picture, ...)
// once, early, for the whole course. known-techniques() lists SPECIFIC
// algebraic methods for a specific kind of task (here: solving
// equations), and is meant to be called again and again across
// chapters with a growing list as new methods get taught — e.g. just
// "simple transformations" and "factoring" early on, later "simple
// transformations, factoring, the quadratic formula", and so on. Pass
// the full current list explicitly every time (no automatic tracking
// across chapters — chapters can be compiled standalone or reordered,
// so there's no reliable notion of "what's been taught so far" to
// infer automatically; the explicit list is what stays correct
// regardless of compilation context).
//
// Usage — give it its own subsection heading (e.g. "== Techniques You
// Know So Far"), not just an inline box at the end of something else —
// it's a genuine checkpoint moment, not an aside, and a heading makes
// it a place students can navigate back to later. Pair with a short
// recap/refresher exercise mixing the listed techniques, right before
// students need all of them together (e.g. right before a word-problems
// section):
//   == Techniques You Know So Far
//   #known-techniques(
//     "Simple transformations (do the same thing to both sides)",
//     "Factoring (common factor, trial and error)",
//   )
//   #ex(...)[ mixed recap problem ][ ... ]
#let known-techniques(title: "Techniques you know so far", ..items) = context {
  if _hide-aux() { return }
  _bar-box(bar-color: def-col, fill-color: def-bg, {
    text(weight: "bold", fill: def-col)[#title]
    v(2pt)
    list(indent: 6pt, ..items.pos())
  })
}

// ────────────────────────────────────────────────────────────
//  OBJECTIVES — chapter-opening learning-objectives box, tied to
//  the Lehrplan's competency list. Serves two purposes at once:
//  orientation for students ("this is what you're building toward")
//  and a coverage audit trail for the teacher — each chapter's
//  objectives() call is the explicit record of which Lehrplan
//  competencies that chapter implements.
//
//  Items are built with two small constructors (they return plain
//  dictionaries, so they only make sense INSIDE objectives(...) —
//  never write #bfkm[...] bare in prose):
//    obj(bfkm: false, level: "all")[ ... ]   — general constructor
//    bfkm(level: "all")[ ... ]               — sugar for obj(bfkm: true)
//  Bare content is also accepted and treated as obj()[...].
//
//  bfkm: true appends a small "BfKM" badge — the Lehrplan's marker
//  for basale fachliche Kompetenzen (competencies deemed essential
//  for general university readiness). A one-line legend explaining
//  the abbreviation is added automatically whenever at least one
//  visible item carries the badge.
//
//  level: works like exercise()'s level:, not like only-high[...] —
//  an item marked level: "high" simply doesn't appear in the
//  Foundations document, so one objectives() call serves both
//  levels without duplicating the shared items:
//    #objectives(
//      bfkm[solve quadratic equations with the quadratic formula],
//      obj(level: "high")[derive the formula by completing the square],
//    )
//
//  Place it right after the chapter's opening prose, before the
//  first section heading. Suppressed on sheets and in solutions
//  like all other theory boxes.
// ────────────────────────────────────────────────────────────
#let obj(bfkm: false, level: "all", body) = (
  body: body,
  bfkm: bfkm,
  level: level,
)
#let bfkm(level: "all", body) = obj(bfkm: true, level: level, body)

#let _bfkm-badge = box(
  fill: luma(240),
  radius: 2pt,
  inset: (x: 3.5pt, y: 1pt),
  text(size: 8pt, fill: luma(90), weight: "bold")[BfKM],
)

#let objectives(title: "After this chapter, you can", ..items) = context {
  if _hide-aux() { return }
  let lvl = _level.get()
  let norm = items
    .pos()
    .map(it => if type(it) == dictionary { it } else {
      (body: it, bfkm: false, level: "all")
    })
  let vis = norm.filter(it => it.level == "all" or it.level == lvl)
  if vis.len() == 0 { return }
  let any-bfkm = vis.any(it => it.bfkm)
  _bar-box(bar-color: goal-col, fill-color: goal-bg, {
    text(weight: "bold", fill: goal-col)[#title …]
    v(2pt)
    list(indent: 6pt, ..vis.map(it => {
      if it.bfkm { it.body + h(4pt) + _bfkm-badge } else { it.body }
    }))
    if any-bfkm {
      v(4pt)
      text(size: 8.5pt, fill: luma(110), style: "italic")[
        BfKM = _basale fachliche Kompetenzen_ — competencies the Lehrplan
        marks as essential for general university readiness.
      ]
    }
  })
}

// ────────────────────────────────────────────────────────────
//  VOCAB — immersion-teaching vocabulary support. Students learn
//  "slope" and "root" in English here, but will meet "Steigung"
//  and "Nullstelle" in other subjects, in German textbooks, and
//  in German-language references — the glossary bridges that gap.
//
//  vocab(en, de) is used INLINE at the point where a term is first
//  introduced. It renders the English term in bold, followed by the
//  German equivalent in small gray — and records the pair for the
//  chapter-end glossary:
//    The #vocab("slope", "Steigung") of a line measures ...
//  For later mentions of the same term (where repeating the German
//  would be noise), either just write the word plainly, or use
//  show-de: false to still get the bold styling without the gloss:
//    ... so the #vocab("slope", "Steigung", show-de: false) doubles.
//  (Repeat calls are harmless — print-vocab() deduplicates by
//  English term, first occurrence wins.)
//
//  In sheet/solutions mode the inline rendering still appears (a
//  term can be part of an exercise's question text), but nothing is
//  recorded — the glossary is lecture-notes-only.
//
//  print-vocab() — call ONCE per chapter, at the chapter's end
//  (after print-hints() reads nicely: hints belong to the exercises,
//  the glossary closes the chapter). Prints an alphabetized two-
//  column EN–DE table and clears the store. Like print-hints(), a
//  forgotten call would leak entries into the next chapter — but
//  chapter-template resets both stores at chapter start as a guard
//  (see there), so a missing call costs you that chapter's glossary,
//  never a corrupted one in the chapter after it.
// ────────────────────────────────────────────────────────────
#let vocab(en, de, show-de: true) = context {
  if not _hide-aux() {
    vocab-store.update(vs => vs + ((en: en, de: de),))
  }
  strong(en)
  if show-de {
    h(0.3em)
    text(size: 9pt, fill: luma(110))[(dt. #emph(de))]
  }
}

#let print-vocab(title: "Vocabulary — English–German") = context {
  if _hide-aux() { return }
  let entries = vocab-store.get()
  if entries.len() == 0 { return }

  // deduplicate by English term (first occurrence wins), then sort
  let seen = ()
  let unique = ()
  for e in entries {
    let key = lower(e.en)
    if not seen.contains(key) {
      seen.push(key)
      unique.push(e)
    }
  }
  let sorted = unique.sorted(key: e => lower(e.en))

  pagebreak()
  text(weight: "bold", size: 12pt)[#title]
  linebreak()
  text(size: 9pt, fill: luma(110), style: "italic")[
    Terms introduced in this chapter. You will meet the German
    equivalents in other subjects and in German-language references.
  ]
  v(0.6em)

  grid(
    columns: (1fr, 1fr),
    column-gutter: 1.6em,
    row-gutter: 0.45em,
    ..sorted.map(e => [#strong(e.en) — #emph(e.de)]),
  )

  vocab-store.update(_ => ())
}


// ────────────────────────────────────────────────────────────
//  PARTS — lettered sub-parts in a multi-column grid
//  (NOTE: unrelated to the "part" concept above — this is the
//  original multi-column layout helper for (a)/(b)/(c) exercise
//  sub-items, kept under its original name so existing chapter
//  files keep working unmodified.)
//
//  row-gutter defaults to 1em rather than a tighter value because
//  most math-course content is fraction-heavy, and a fraction is
//  visually much taller than a line of plain text (numerator,
//  fraction bar, denominator all stacked) — a gutter tuned for
//  short plain-text items reads as cramped once fractions show up,
//  which in practice is most of the time here. Override per call
//  for anything that wants tighter or looser spacing:
//    #parts(3, row-gutter: 1.6em, ...)   // extra room, tall content
//    #parts(4, row-gutter: 0.5em, ...)   // compact, short plain text
// ────────────────────────────────────────────────────────────
#let parts(cols, ..items, row-gutter: 1em, column-gutter: 1.2em) = {
  let col-spec = range(cols).map(_ => 1fr)
  grid(
    columns: col-spec,
    row-gutter: row-gutter,
    column-gutter: column-gutter,
    ..items.pos(),
  )
}

// auto-parts — same layout as parts() above, but generates the
// (a)/(b)/(c)... label for each item automatically instead of you
// typing it by hand. Pass bare content, no manual label:
//   #auto-parts(3,
//     [$5x - 8 = 2x + 7$],
//     [$x^2 - 5x + 6 = 0$],
//   )
//
// IMPORTANT — this only stays correct if the matching solution's
// auto-parts() call has the SAME NUMBER of items IN THE SAME ORDER
// as the question's. If a solution ever consolidates two answers
// into one entry, skips one, or reorders them, the generated letters
// will silently drift out of sync between question and solution —
// with no error, just a wrong label. Use plain parts() with manual
// labels instead for any exercise like that; auto-parts() is for the
// common one-to-one case, not a blanket replacement.
//
// start: lets the lettering continue from a later point (e.g.
// start: 4 begins at "(e)") if a single exercise splits its items
// across more than one auto-parts() call.
#let _letters = "abcdefghijklmnopqrstuvwxyz".clusters()

#let auto-parts(
  cols,
  ..items,
  row-gutter: 1em,
  column-gutter: 1.2em,
  start: 0,
) = {
  let labeled = items
    .pos()
    .enumerate()
    .map(((i, item)) => {
      [(#_letters.at(i + start)) #item]
    })
  parts(cols, ..labeled, row-gutter: row-gutter, column-gutter: column-gutter)
}

// system — displays a system of equations, one per row, aligned at
// "=" and bounded by vertical bars on both sides (house style for
// displayed systems of equations — see STYLE_GUIDE.md §6). Works for
// any number of equations (2, 3, or more), not just square systems.
//
// IMPORTANT — call this with the # sigil, even when writing it inside
// a $ ... $ block. Per Typst's own math documentation, a #-prefixed
// call is a normal CODE-mode function call and its arguments follow
// normal code-mode parsing rules (genuine tuples), rather than math
// mode's special comma/semicolon merging rules — which is exactly
// what's needed here, since each argument is a real 2-element tuple
// (left-hand side, right-hand side), not just juxtaposed math content.
//
// Usage:
//   $ #system(($x + 3y$, $8$), ($x - 2y$, $3$)) $
// works for 2, 3, or more equations the same way:
//   $ #system(($x+y+z$, $33$), ($3x-8y+7z$, $26$), ($5y-3z$, $19$)) $
//
// Internally this is math.mat(delim: "|", ..rows) where rows is built
// by mapping each (lhs, rhs) tuple to a 3-cell row (lhs, "=", rhs) —
// confirmed via Typst's documented ..array-spread pattern for
// programmatic matrix construction (mat(..#range(1,5).chunks(2))),
// not guessed at.
#let system(..eqs) = math.mat(
  delim: "|",
  ..eqs.pos().map(pair => (pair.at(0), $=$, pair.at(1))),
)


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
//  level: "all"  (default) → appears in both documents + both sheets
//         "high"           → Advanced document + Advanced sheet only
//         "basic"          → Foundations document + Foundations sheet only
//
//  Sheets respect level exactly like the lecture notes and the
//  solutions booklets do (the sheet-mode override that used to show
//  every exercise on the single sheet is gone). This is what keeps a
//  sheet's exercise numbering identical to its matching solutions
//  booklet — the whole reason the sheet is split per level.
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
  let visible = level == "all" or level == _level.get()
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
    // The level tag next to the exercise number keeps the two
    // printed sheet stacks (Foundations / Advanced) tellable apart
    // at a glance — sheet pages have no page header to carry it.
    let lvl-name = if _level.get() == "basic" { "Foundations" } else {
      "Advanced"
    }
    pagebreak(weak: true)
    grid(
      columns: (1fr, 1fr),
      align(left)[#text(weight: "bold", fill: accent)[#chapter]],
      align(right)[
        #if dots != none [#dots #h(0.6em)]
        #text(fill: luma(100))[Exercise #n · #lvl-name]
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
  // Leak guard: hint-store and vocab-store are collect-then-print
  // stores that only clear when their print-*() call runs. If a
  // chapter forgets that call, its entries would otherwise silently
  // attach to the NEXT chapter's printout. Resetting both at chapter
  // start bounds the damage: a forgotten call costs that chapter its
  // own hints/glossary (visible, easy to notice) instead of
  // corrupting the following chapter's (subtle, easy to miss).
  hint-store.update(_ => ())
  vocab-store.update(_ => ())
  if _ex-mode.get() {
    body
  } else {
    apply-base-style(_portrait-header(chapter-title: title, body))
  }
}


// ────────────────────────────────────────────────────────────
//  EXERCISE-SHEET TEMPLATE
//  Apply with an explicit level, one sheet file per level:
//    exercises-basic.typ:
//      #show: exercise-sheet-template.with(level: "basic")
//    exercises-high.typ:
//      #show: exercise-sheet-template.with(level: "high")
//  Each sheet must read its chapter list from the MATCHING main
//  file (read-chapter-files(from: ".../main-basic.typ") for the
//  basic sheet, etc.) — that is what keeps chapter selection AND
//  exercise numbering in sync with the matching solutions booklet.
// ────────────────────────────────────────────────────────────
#let exercise-sheet-template(level: "high", body) = {
  set-level(level)
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


// ── Swiss number formatting ──────────────────────────────────
// House convention: Swiss format — apostrophe as thousands
// separator, period as decimal separator (1'000, 12'345.5).
//
// NEVER type the apostrophe by hand inside math mode: $12'000$
// parses the ' as a PRIME and renders 12′000 (a 12-prime followed
// by 000). num() sidesteps this because it builds the grouped
// number as a plain string in code mode — string content
// interpolated into math is inserted as literal text, so the
// apostrophe arrives as a character, not as math syntax. It works
// identically in text and math mode:
//   text:  The population reached #num(86402) by 1950.
//   math:  $ s_(100) = #num(338350) $
//   float: #num(12345.5)   →  12'345.5
//
// Grouping starts at 4 digits (1000 → 1'000), matching common
// Swiss usage; the decimal part is never grouped. Negative input
// gets a proper minus sign (U+2212), though in math it reads more
// naturally to keep the sign in the formula: $-#num(1234)$.
//
// Don't pass years or other "label" numbers (2026, ZIP codes)
// through num() — grouping is for quantities, not names.
#let num(x) = {
  let s = if type(x) == str { x } else { str(x) }
  let neg = s.starts-with("-")
  let body = if neg { s.slice(1) } else { s }
  let parts = body.split(".")
  let ip = parts.at(0)
  let dp = if parts.len() > 1 { parts.at(1) } else { none }

  let ds = ip.clusters()
  let n = ds.len()
  let grouped = ""
  for (i, d) in ds.enumerate() {
    grouped += d
    let remaining = n - 1 - i
    if remaining > 0 and calc.rem(remaining, 3) == 0 {
      grouped += "\u{2019}" // ’ typographic apostrophe (Swiss separator)
    }
  }

  let out = grouped + (if dp != none { "." + dp } else { "" })
  if neg { "\u{2212}" + out } else { out }
}


// ── Math shorthands ──────────────────────────────────────────
#let NN = $bb(N)$
#let ZZ = $bb(Z)$
#let QQ = $bb(Q)$
#let RR = $bb(R)$
#let CC = $bb(C)$
#let abs(x) = $lr(|#x|)$
#let limn = $lim_(n -> oo)$    // limit as n → ∞


// ════════════════════════════════════════════════════════════
//  NATIVE FIGURE HELPERS  (unchanged)
// ════════════════════════════════════════════════════════════

#let dot-triangle(rows: 4, r: 4pt, gap: 18pt, col: accent) = only-theory(align(
  center,
  {
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
          place(dx: cx - r, dy: cy - r, circle(
            radius: r,
            fill: col,
            stroke: none,
          ))
        }
      }
    })
  },
))

#let domino-row(n: 7, col: accent) = only-theory(align(center, stack(
  dir: ltr,
  spacing: 9pt,
  ..range(n).map(_ => rect(
    width: 6pt,
    height: 28pt,
    radius: 1pt,
    fill: col,
    stroke: none,
  )),
)))

#let koch-star(R: 1.7cm, col: accent, fillc: accent-bg) = only-theory(align(
  center,
  {
    let r = R / calc.sqrt(3)
    let cx = R
    let cy = R
    let pts = ()
    for k in range(12) {
      let rad = if calc.even(k) { R } else { r }
      let ang = 90deg - k * 30deg
      pts.push((cx + rad * calc.cos(ang), cy - rad * calc.sin(ang)))
    }
    box(width: 2 * R, height: 2 * R, polygon(
      fill: fillc,
      stroke: 0.9pt + col,
      ..pts,
    ))
  },
))

#let nested-squares(side: 3cm, levels: 5, col: accent) = only-theory(align(
  center,
  {
    box(width: side, height: side, {
      let corners = ((0pt, 0pt), (side, 0pt), (side, side), (0pt, side))
      for lvl in range(levels) {
        let shade = if calc.even(lvl) { none } else { accent-bg }
        place(dx: 0pt, dy: 0pt, polygon(
          fill: shade,
          stroke: 0.8pt + col,
          ..corners,
        ))
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
  },
))

// abstraction-ladder — the recurring 4-rung "levels of abstraction"
// figure. Use it every time a situation is formalized so the jump to
// a formula becomes a named, practiced move instead of magic.
#let abstraction-ladder(
  l0: [—],
  l1: [—],
  l2: [—],
  l3: [—],
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
      align(center, text(
        size: 9pt,
        fill: accent,
      )[#sym.arrow.t #emph[formalize]])
      v(1pt)
    }
  }
}))


// ── Table style ──────────────────────────────────────────────
#let data-table(columns: (), row-height: 1.8cm, ..cells) = {
  let n-cols = if type(columns) == array { columns.len() } else { columns }
  let items = cells.pos()
  let n-rows = int(items.len() / n-cols)

  let row-sizes = if row-height == auto {
    auto
  } else {
    (auto,) + range(n-rows - 1).map(_ => row-height)
  }

  let cell-stroke(col, row) = (
    left: if col == 0 { 0.9pt + luma(110) } else { 0.5pt + luma(190) },
    right: if col == n-cols - 1 { 0.9pt + luma(110) } else { none },
    top: if row == 0 { 0.9pt + luma(110) } else { none },
    bottom: if row == 0 { 1.5pt + accent } else if row == n-rows - 1 {
      0.9pt + luma(110)
    } else { 0.5pt + luma(190) },
  )

  table(
    columns: columns,
    rows: row-sizes,
    stroke: none,
    inset: (x: 0.65em, y: 0.45em),
    align: center + horizon,
    ..items
      .enumerate()
      .map(((idx, c)) => {
        let row = int(idx / n-cols)
        let col = calc.rem(idx, n-cols)
        let s = cell-stroke(col, row)
        if row == 0 {
          table.cell(
            text(weight: "bold", fill: accent, c),
            fill: luma(244),
            stroke: s,
          )
        } else if col == 0 {
          table.cell(
            text(fill: luma(40), c),
            fill: luma(248),
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
//  pinned at 1.0.0 (its first release explicitly declared API-stable
//  — see the package changelog). simple-plot does the actual
//  rendering (axes, stealth arrows, grid, Liang-Barsky clipping at
//  the boundary, discontinuity gaps) — all of it more completely and
//  more robustly than the hand-rolled version this replaced.
//  unit-label-only is its name for our "show only the 1 tick"
//  behavior. Also pulls in riemann-sum and volume-of-revolution,
//  both relevant once the calculus unit starts, and scatter /
//  line-plot for real-data plots (useful for the future statistics
//  units). Two more pedagogical helpers ship with the package itself
//  and are worth knowing about for later: plot-rational() (a
//  rational-function wrapper with asymptote support) and
//  limit-schema() (schematic one-sided-limit diagrams) — both
//  re-exported below, neither wrapped here since they're already
//  purpose-built for exactly the units that will need them.
//
//  VERSION POLICY: don't bump this pin reflexively on every release.
//  Pre-1.0 point releases in particular can change rendering
//  *behavior*, not just add features — e.g. axis-x-extend /
//  axis-y-extend's default changed between 0.9.1 and 1.0.0 from
//  (0, 0.5) (half a data unit, scales with plot range) to
//  (0pt, 0.3cm) (a fixed absolute length). Before bumping the pin,
//  read the changelog for behavior changes, not just new features,
//  and re-check a handful of existing figures afterward.
//
//  MARKER FILL DEPENDS ON SHAPE, NOT A BUG: mark-fill only has a
//  visible effect on fillable marker shapes like "*" — "o" renders as
//  an outline-only glyph, so mark-fill silently has nothing to apply
//  to (no error, just no visible change). This is genuinely useful:
//  it gives a reliable way to draw OPEN vs. CLOSED circles for
//  piecewise-function endpoints, e.g. for a jump discontinuity:
//    // open (excluded) endpoint — hollow, since "o" ignores fill
//    data(((x0, y0),), mark: "o", mark-stroke: accent, mark-size: 0.12)
//    // closed (included) endpoint — filled
//    data(((x0, y0),), mark: "*", mark-fill: accent, mark-stroke: accent, mark-size: 0.12)
//
//  plot-graph below is a convenience layer for the common "plot a
//  few functions with our house colors" case — NOT full coverage
//  of simple-plot's API. For anything it doesn't expose (markers,
//  label-pos / label-side, per-function domains, scatter/line-plot,
//  Riemann sums, volumes of revolution, parametric curves, ...),
//  call `plot` (or the relevant function) directly — both are
//  imported below and available anywhere #import "preamble.typ": *
//  is used.
//
//  Usage (same call shape as before):
//    #plot-graph(
//      x => x * x - 2,
//      (fn: x => 2 * x - 1, color: warn-col),
//      xmin: -3.5, xmax: 3.5, ymin: -3.5, ymax: 6.5,
//    )
//
//  STYLE TIP — bounds ending in .5: at the default grid-step: 1,
//  prefer xmin:/xmax:/ymin:/ymax: values ending in .5 rather than
//  whole integers. With integer bounds the outermost gridline lands
//  exactly on the plot box's border and visually merges with it; a
//  half-unit margin keeps the grid and the border distinct and gives
//  the curve room to breathe. See STYLE_GUIDE.md §6.
//
//  Sizing: as of 1.0.0, simple-plot's width:/height: accept EITHER a
//  real Typst length (7cm) OR a bare number (7, meaning centimeters,
//  kept for backward compatibility with older simple-plot versions).
//  This wrapper's size:/width:/height: pass straight through either
//  way — no conversion layer needed anymore.
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
#import "@preview/simple-plot:1.0.0": (
  data, hline, limit-schema, line-plot, parametric, plot, plot-rational,
  reset-plot-defaults, riemann-sum, scatter, set-plot-defaults, vline,
  volume-of-revolution,
)

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
  let w = if width != none { width } else { size }
  let h = if height != none { height } else { size }

  // normalize each argument to a simple-plot function-spec dict,
  // translating our `color:` convenience key to simple-plot's
  // `stroke:`, and cycling default colors from the house palette
  // (same normalization pattern used throughout this file, e.g. in
  // data-table's cell styling)
  let entries = functions
    .pos()
    .enumerate()
    .map(((i, f)) => {
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
    xmin: xmin,
    xmax: xmax,
    ymin: ymin,
    ymax: ymax,
    width: w,
    height: h,
    show-grid: if show-grid { "major" } else { false },
    xtick-step: grid-step,
    ytick-step: grid-step,
    unit-label-only: show-unit-ticks,
    xlabel: x-label,
    ylabel: y-label,
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
#let image-grid(
  cols,
  ..items,
  gutter: 12pt,
  column-gutter: none,
  row-gutter: none,
) = grid(
  columns: (1fr,) * cols,
  column-gutter: if column-gutter != none { column-gutter } else { gutter },
  row-gutter: if row-gutter != none { row-gutter } else { gutter },
  ..items.pos(),
)
