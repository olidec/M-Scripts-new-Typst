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

// epigraph — a small, decorative "easter-egg" quotation, distinct from
// quotebox above. quotebox is a full grey callout for a story or passage
// worked into the narrative; epigraph is a light, centered flourish for
// dropping a nerdy/mathy one-liner wherever it fits — a chapter opening,
// a section break, an awkward patch of white space. Purely flavor, so
// like the other theory environments it vanishes in sheet/solutions mode
// (via _hide-aux) — an exam sheet is no place for an in-joke.
//   #epigraph[Mathematics is the art of giving the same name to different things.]
//   #epigraph(by: "Henri Poincaré")[
//     Mathematics is the art of giving the same name to different things.
//   ]
// `by:` is free-form — "Kronecker", "Kronecker, 1886", "attributed to
// Erdős", whatever reads best under that particular quote. Omit it for an
// unattributed line. The enclosing quotation marks are drawn by the
// environment, so type only the words of the quote in the body.
#let epigraph(by: none, body) = context {
  if _hide-aux() { return }
  block(width: 100%, breakable: false, inset: (top: 6pt, bottom: 6pt))[
    #align(center, block(width: 82%)[
      #set par(leading: 0.7em, justify: false)
      #set text(size: 10.5pt, style: "italic", fill: luma(90))
      #text(fill: accent)[\u{201C}]#body#text(fill: accent)[\u{201D}]
      #if by != none {
        linebreak()
        text(size: 9pt, style: "normal", fill: luma(130))[\u{2014} #by]
      }
    ])
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
  keep-together: true,
  // CALCULATOR POLICY -- three states, and the default is silence:
  //   none   no badge at all (every exercise written before this
  //          existed, so nothing already in the course changes)
  //   true   "CALC" -- a calculator is expected
  //   false  "NO CALC" -- to be done by hand
  //
  // Deliberately NOT called `calc:`. Inside this function that name
  // would shadow Typst's built-in `calc` module, so the day anyone
  // adds a calc.max() or calc.round() to exercise() it would fail
  // with a baffling error. The preamble uses calc.* 44 times
  // elsewhere; this is the one place the collision could bite.
  //
  // Note this is a policy flag, not a track flag: it says nothing
  // about WHICH machine. GLF sit the TI-30X Pro MathPrint and SPF the
  // TI-Nspire CAS, and exam papers are split by whether a calculator
  // is allowed at all, not by model -- so a single badge serves both
  // levels and needs no interaction with `level`.
  calculator: none,
  body,
  solution,
) = context {
  let visible = level == "all" or level == _level.get()
  if not visible { return }

  ex-counter.step()

  // NUMBERING -- read the counter in a NESTED context, not this one.
  //
  // Reading it in the same context block that emits the step() made
  // the number depend on where that update landed relative to the
  // block's own location, and that differed by MODE: the sheet branch
  // saw its own step (needing no +1) while the notes and solutions
  // branches did not (needing one). No single choice of "+1 or not"
  // can be right for both -- which is why removing the +1 fixed the
  // sheets and broke the other two, starting them at 0.
  //
  // A nested context is located strictly after the update above, so
  // get() here carries this exercise's own number in every mode. The
  // visibility test stays in the OUTER context, so a hidden exercise
  // returns before stepping and never consumes a number.
  context {
    let n = ex-counter.get().first()

    let dot(filled) = box(baseline: 15%, circle(
      radius: 2.3pt,
      fill: if filled { accent } else { white },
      stroke: 0.6pt + accent,
    ))
    let dots = if difficulty > 0 {
      range(3).map(i => dot(i < difficulty)).join(h(2.5pt))
    } else { none }

    // "NO CALC" is the pedagogically loaded state -- it is the one
    // asking for something -- so it carries the stronger color.
    // "CALC" is merely permission and stays quiet.
    let calc-badge = if calculator == none { none } else {
      let (tag, fg, bg) = if calculator == true {
        ("CALC", accent, accent-bg)
      } else {
        ("NO CALC", warn-col, warn-bg)
      }
      box(
        baseline: 15%,
        inset: (x: 4pt, y: 1.5pt),
        outset: (y: 1.5pt),
        radius: 2pt,
        fill: bg,
        stroke: 0.5pt + fg,
        text(size: 7pt, weight: "semibold", fill: fg, tracking: 0.4pt, tag),
      )
    }

    // One handle for everything that sits in the corner, so the three
    // rendering modes below stay identical to each other.
    let tags = if calc-badge == none { dots } else if dots == none {
      calc-badge
    } else { calc-badge + h(0.5em) + dots }

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
          #if tags != none [#tags #h(0.6em)]
          #text(fill: luma(100))[Exercise #n · #lvl-name]
        ],
      )
      line(length: 100%, stroke: 0.5pt + accent)
      v(1.2em)
      body
      // Effort note intentionally omitted here: it's a note to a
      // student reading the chapter alongside the exercise ("you're
      // not behind schedule"), not something that belongs on a
      // standalone printed sheet. It still appears in chapter/notes
      // mode below, and was already absent from the solutions
      // booklet -- so this one change covers both sheets and
      // solutions, per _hide-aux().
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
          align(right + horizon)[#tags],
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
          align(right + horizon)[#tags],
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
// ────────────────────────────────────────────────────────────
//  COMPLEX-NUMBER HELPERS
//
//  Restored after going missing from the preamble: ch-gaussian-plane
//  and ch-arithmetic in complex-sls are written against these, and
//  validate-typst.py already lists all five in its KNOWN set, which is
//  what identified them as expected-but-absent.
//
//  Re, Im, Arg and cis are OPERATORS, so they set upright and take the
//  spacing Typst gives sin/cos/log. Written as math.op they work both
//  with and without parentheses: $Arg(z)$ and $Arg z$ both set
//  correctly.
//
//  Note that Re and Im shadow Typst's Fraktur symbols of the same
//  name. That is deliberate: upright "Re" and "Im" are the modern
//  convention and match what students meet elsewhere. If you want the
//  Fraktur forms anywhere, frak(R) and frak(I) still give them.
//
//  conj is a FUNCTION because it wraps its argument, so it must be
//  called with parentheses: $conj(z)$, never $conj z$.
// ────────────────────────────────────────────────────────────
#let Re = math.op("Re")
#let Im = math.op("Im")
#let Arg = math.op("Arg")
#let cis = math.op("cis")
#let conj(z) = $overline(#z)$


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
          // `dash` is optional and defaults to none, so the resulting
          // stroke is identical to the old `color + 1.3pt` form unless
          // a call asks for dashes. Needed when two curves coincide --
          // see the "infinitely many solutions" panel in ch-systems.
          stroke: stroke(
            paint: f.at("color", default: default-color),
            thickness: f.at("thickness", default: 1.3pt),
            dash: f.at("dash", default: none),
          ),
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

// epigraph — a small, decorative "easter-egg" quotation, distinct from
// quotebox above. quotebox is a full grey callout for a story or passage
// worked into the narrative; epigraph is a light, centered flourish for
// dropping a nerdy/mathy one-liner wherever it fits — a chapter opening,
// a section break, an awkward patch of white space. Purely flavor, so
// like the other theory environments it vanishes in sheet/solutions mode
// (via _hide-aux) — an exam sheet is no place for an in-joke.
//   #epigraph[Mathematics is the art of giving the same name to different things.]
//   #epigraph(by: "Henri Poincaré")[
//     Mathematics is the art of giving the same name to different things.
//   ]
// `by:` is free-form — "Kronecker", "Kronecker, 1886", "attributed to
// Erdős", whatever reads best under that particular quote. Omit it for an
// unattributed line. The enclosing quotation marks are drawn by the
// environment, so type only the words of the quote in the body.
#let epigraph(by: none, body) = context {
  if _hide-aux() { return }
  block(width: 100%, breakable: false, inset: (top: 6pt, bottom: 6pt))[
    #align(center, block(width: 82%)[
      #set par(leading: 0.7em, justify: false)
      #set text(size: 10.5pt, style: "italic", fill: luma(90))
      #text(fill: accent)[\u{201C}]#body#text(fill: accent)[\u{201D}]
      #if by != none {
        linebreak()
        text(size: 9pt, style: "normal", fill: luma(130))[\u{2014} #by]
      }
    ])
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
  // CALCULATOR POLICY -- three states, and the default is silence:
  //   none   no badge at all (every exercise written before this
  //          existed, so nothing already in the course changes)
  //   true   "CALC" -- a calculator is expected
  //   false  "NO CALC" -- to be done by hand
  //
  // Deliberately NOT called `calc:`. Inside this function that name
  // would shadow Typst's built-in `calc` module, so the day anyone
  // adds a calc.max() or calc.round() to exercise() it would fail
  // with a baffling error. The preamble uses calc.* 44 times
  // elsewhere; this is the one place the collision could bite.
  //
  // Note this is a policy flag, not a track flag: it says nothing
  // about WHICH machine. GLF sit the TI-30X Pro MathPrint and SPF the
  // TI-Nspire CAS, and exam papers are split by whether a calculator
  // is allowed at all, not by model -- so a single badge serves both
  // levels and needs no interaction with `level`.
  calculator: none,
  body,
  solution,
) = context {
  let visible = level == "all" or level == _level.get()
  if not visible { return }

  ex-counter.step()

  // NUMBERING -- read the counter in a NESTED context, not this one.
  //
  // Reading it in the same context block that emits the step() made
  // the number depend on where that update landed relative to the
  // block's own location, and that differed by MODE: the sheet branch
  // saw its own step (needing no +1) while the notes and solutions
  // branches did not (needing one). No single choice of "+1 or not"
  // can be right for both -- which is why removing the +1 fixed the
  // sheets and broke the other two, starting them at 0.
  //
  // A nested context is located strictly after the update above, so
  // get() here carries this exercise's own number in every mode. The
  // visibility test stays in the OUTER context, so a hidden exercise
  // returns before stepping and never consumes a number.
  context {
    let n = ex-counter.get().first()

    let dot(filled) = box(baseline: 15%, circle(
      radius: 2.3pt,
      fill: if filled { accent } else { white },
      stroke: 0.6pt + accent,
    ))
    let dots = if difficulty > 0 {
      range(3).map(i => dot(i < difficulty)).join(h(2.5pt))
    } else { none }

    // "NO CALC" is the pedagogically loaded state -- it is the one
    // asking for something -- so it carries the stronger colour.
    // "CALC" is merely permission and stays quiet.
    let calc-badge = if calculator == none { none } else {
      let (tag, fg, bg) = if calculator == true {
        ("CALC", accent, accent-bg)
      } else {
        ("NO CALC", warn-col, warn-bg)
      }
      box(
        baseline: 15%,
        inset: (x: 4pt, y: 1.5pt),
        outset: (y: 1.5pt),
        radius: 2pt,
        fill: bg,
        stroke: 0.5pt + fg,
        text(size: 7pt, weight: "semibold", fill: fg, tracking: 0.4pt, tag),
      )
    }

    // One handle for everything that sits in the corner, so the three
    // rendering modes below stay identical to each other.
    let tags = if calc-badge == none { dots } else if dots == none {
      calc-badge
    } else { calc-badge + h(0.5em) + dots }

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
          #if tags != none [#tags #h(0.6em)]
          #text(fill: luma(100))[Exercise #n · #lvl-name]
        ],
      )
      line(length: 100%, stroke: 0.5pt + accent)
      v(1.2em)
      body
      // Effort note intentionally omitted here: it's a note to a
      // student reading the chapter alongside the exercise ("you're
      // not behind schedule"), not something that belongs on a
      // standalone printed sheet. It still appears in chapter/notes
      // mode below, and was already absent from the solutions
      // booklet -- so this one change covers both sheets and
      // solutions, per _hide-aux().
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
          align(right + horizon)[#tags],
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
          align(right + horizon)[#tags],
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
// ────────────────────────────────────────────────────────────
//  COMPLEX-NUMBER HELPERS
//
//  Restored after going missing from the preamble: ch-gaussian-plane
//  and ch-arithmetic in complex-sls are written against these, and
//  validate-typst.py already lists all five in its KNOWN set, which is
//  what identified them as expected-but-absent.
//
//  Re, Im, Arg and cis are OPERATORS, so they set upright and take the
//  spacing Typst gives sin/cos/log. Written as math.op they work both
//  with and without parentheses: $Arg(z)$ and $Arg z$ both set
//  correctly.
//
//  Note that Re and Im shadow Typst's Fraktur symbols of the same
//  name. That is deliberate: upright "Re" and "Im" are the modern
//  convention and match what students meet elsewhere. If you want the
//  Fraktur forms anywhere, frak(R) and frak(I) still give them.
//
//  conj is a FUNCTION because it wraps its argument, so it must be
//  called with parentheses: $conj(z)$, never $conj z$.
// ────────────────────────────────────────────────────────────
#let Re = math.op("Re")
#let Im = math.op("Im")
#let Arg = math.op("Arg")
#let cis = math.op("cis")
#let conj(z) = $overline(#z)$


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
          // `dash` is optional and defaults to none, so the resulting
          // stroke is identical to the old `color + 1.3pt` form unless
          // a call asks for dashes. Needed when two curves coincide --
          // see the "infinitely many solutions" panel in ch-systems.
          stroke: stroke(
            paint: f.at("color", default: default-color),
            thickness: f.at("thickness", default: 1.3pt),
            dash: f.at("dash", default: none),
          ),
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
//  TRIG-PLOT — plot-graph's sibling for trigonometric curves.
//
//  Same call shape and same color cycling as plot-graph(), with one
//  difference that matters pedagogically: the horizontal axis is
//  ticked and LABELED in multiples of pi (or pi/2), not in integers.
//  A sine curve drawn against an integer axis silently teaches that
//  its zeros sit "somewhere around 3.14"; drawn against a pi axis it
//  teaches that they sit at pi. Every trig graph in the course should
//  use this rather than plot-graph.
//
//  HORIZONTAL BOUNDS ARE IN UNITS OF PI. xmin: -2.25 means -2.25 pi,
//  i.e. a quarter-period of breathing room past the -2 pi tick. This
//  is the trig analogue of the "bounds ending in .5" rule in
//  STYLE_GUIDE.md §6 — keep a margin so the outermost gridline does
//  not merge with the plot border. Vertical bounds (ymin/ymax) are
//  plain numbers, exactly as in plot-graph.
//
//    tick: 0.5  → ticks and gridlines every pi/2  (the default)
//    tick: 1    → ticks and gridlines every pi
//
//  Use tick: 1 on narrow plots (an image-grid cell, a two-column
//  auto-parts item): nine fraction labels do not fit in 5.5 cm.
//
//  The tick at 0 is deliberately omitted from the list — simple-plot
//  already draws the origin label itself (show-origin), and the
//  gridline there is the y-axis.
//
//  Usage:
//    #trig-plot(
//      x => calc.sin(x),
//      (fn: x => calc.cos(x), color: warn-col),
//      xmin: -2.25, xmax: 2.25,      // = -2.25 pi … 2.25 pi
//      ymin: -1.5, ymax: 1.5,
//      width: 12, height: 4.5,
//    )
// ════════════════════════════════════════════════════════════

// One tick label for the value k/den (in units of pi), k != 0.
// den is 1 (whole multiples of pi) or 2 (multiples of pi/2); a k that
// is even under den: 2 is reduced first, so 4 pi/2 prints as 2 pi.
#let _pi-tick-label(k, den) = {
  let (m, d) = if den == 2 and calc.rem(k, 2) == 0 {
    (calc.quo(k, 2), 1)
  } else {
    (k, den)
  }
  let a = calc.abs(m)
  let neg = m < 0
  if d == 1 and a == 1 {
    if neg { $-pi$ } else { $pi$ }
  } else if d == 1 {
    if neg { $-#a pi$ } else { $#a pi$ }
  } else if a == 1 {
    if neg { $-pi/2$ } else { $pi/2$ }
  } else {
    if neg { $-(#a pi)/2$ } else { $(#a pi)/2$ }
  }
}

// Tick positions (in radians) and matching labels for the range
// [lo, hi] given in units of pi. The epsilons stop a bound written as
// exactly 2 from losing or gaining a tick to floating-point drift.
#let _pi-ticks(lo, hi, den) = {
  let first = calc.ceil(lo * den - 1e-9)
  let last = calc.floor(hi * den + 1e-9)
  let ks = range(first, last + 1).filter(k => k != 0)
  (
    positions: ks.map(k => k * calc.pi / den),
    labels: ks.map(k => _pi-tick-label(k, den)),
  )
}

#let trig-plot(
  ..functions,
  xmin: -2.25,
  xmax: 2.25,
  ymin: -1.5,
  ymax: 1.5,
  tick: 0.5,
  ystep: 1,
  width: 12,
  height: 4.5,
  samples: 300,
  show-grid: true,
  x-label: $x$,
  y-label: $y$,
) = align(center, {
  let den = if tick == 1 { 1 } else { 2 }
  let ticks = _pi-ticks(xmin, xmax, den)

  // identical normalization to plot-graph: bare function or dict with
  // our convenience color: key, house palette cycled by position
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
    xmin: xmin * calc.pi,
    xmax: xmax * calc.pi,
    ymin: ymin,
    ymax: ymax,
    width: width,
    height: height,
    show-grid: if show-grid { "major" } else { false },
    xtick: ticks.positions,
    xtick-labels: ticks.labels,
    ytick-step: ystep,
    unit-label-only: false,
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

// ════════════════════════════════════════════════════════════
//  STATISTICAL SUMMARIES AND CHARTS
//
//  simple-plot (imported above) covers function graphs, scatter
//  plots and line plots. It has nothing for the four chart types
//  descriptive statistics actually needs -- bar charts, histograms,
//  dotplots and boxplots -- so those are hand-rolled here from
//  native Typst shapes, in the same spirit as dot-triangle /
//  koch-star above: no external package, compiles offline, never
//  goes stale.
//
//  DESIGN NOTE -- misleading graphs are produced by PARAMETER, not
//  by hand-drawing a second fake figure. bar-chart takes an explicit
//  `ymin:`, so the truncated-axis deception is one changed argument
//  away from the honest chart; histogram takes `bins:`, so the
//  too-few-bins / too-many-bins triptych is three calls differing in
//  one number. That matters pedagogically: students should see that
//  a misleading chart usually needs no fakery at all, just a
//  defensible-looking option chosen badly.
//
//  Like fig() and plot-graph(), NONE of these is wrapped in
//  only-theory -- a chart is very often the question or the solution
//  of an exercise, not just theory prose. Wrap a specific call in
//  #only-theory[...] yourself when you want that occurrence
//  suppressed on the exercise sheet.
//
//  All four take absolute width:/height: in Typst lengths (unlike
//  plot-graph, whose size: is a bare centimeter count inherited from
//  simple-plot). Inside image-grid(), pass a smaller width: so two
//  charts plus the gutter still fit the text block.
// ════════════════════════════════════════════════════════════

// ── Numeric summaries ────────────────────────────────────────
//  Exported so chapter prose can COMPUTE the numbers it quotes --
//  #mean-of(waiting-times) rather than a hardcoded 8.4 -- which is
//  what keeps an example's text, its table and its chart from
//  drifting apart when the dataset is edited.

#let mean-of(xs) = xs.sum() / xs.len()

#let median-of(xs) = {
  let s = xs.sorted()
  let n = s.len()
  if n == 0 { return none }
  if calc.odd(n) { s.at(int((n - 1) / 2)) } else {
    (s.at(int(n / 2) - 1) + s.at(int(n / 2))) / 2
  }
}

// HOUSE CONVENTION -- variance divides by n. Descriptive statistics
// describes the dataset you actually have, so the population formula
// is the definition. The n-1 version below is the separate estimator
// used when the data is a SAMPLE standing in for a larger
// population; both sit on the students' calculators (sigma-x vs.
// s-x), so both are exported here under names that say which is
// which.
#let variance-of(xs) = {
  let m = mean-of(xs)
  xs.map(x => calc.pow(x - m, 2)).sum() / xs.len()
}
#let sd-of(xs) = calc.sqrt(variance-of(xs))

#let sample-variance-of(xs) = {
  let m = mean-of(xs)
  xs.map(x => calc.pow(x - m, 2)).sum() / (xs.len() - 1)
}
#let sample-sd-of(xs) = calc.sqrt(sample-variance-of(xs))

// QUARTILE CONVENTION -- "exclusive" (house default) is the
// median-of-each-half method with the overall median left out of
// both halves when n is odd; this is what the TI calculators and the
// textbook do. "inclusive" keeps the median in both halves. The two
// disagree whenever n is odd (on 1..9: 2.5/7.5 vs. 3/7), which is
// exactly the discrepancy the chapter's warning box is about -- so
// both are implemented and a figure can show them disagreeing on the
// same data.
#let quartiles-of(xs, method: "exclusive") = {
  let s = xs.sorted()
  let n = s.len()
  let h = int(n / 2)
  let lower = if calc.even(n) or method != "inclusive" {
    s.slice(0, h)
  } else { s.slice(0, h + 1) }
  let upper = if calc.even(n) { s.slice(h) } else { s.slice(h + 1) }
  (q1: median-of(lower), med: median-of(s), q3: median-of(upper))
}

#let five-number(xs, method: "exclusive") = {
  let s = xs.sorted()
  let q = quartiles-of(s, method: method)
  (
    min: s.first(),
    q1: q.q1,
    med: q.med,
    q3: q.q3,
    max: s.last(),
    iqr: q.q3 - q.q1,
  )
}

// Linear-interpolation percentile (R's default type 7, and
// spreadsheet PERCENTILE.INC). Deliberately NOT the same rule as
// quartiles-of above: that mismatch is genuine, it is why two tools
// report different quartiles for the same data, and the chapter says
// so out loud rather than hiding it.
#let percentile-of(xs, p) = {
  let s = xs.sorted()
  let n = s.len()
  if n == 0 { return none }
  if n == 1 { return s.first() }
  let pos = (p / 100) * (n - 1)
  let lo = calc.floor(pos)
  let hi = calc.ceil(pos)
  if lo == hi { s.at(int(lo)) } else {
    s.at(int(lo)) + (pos - lo) * (s.at(int(hi)) - s.at(int(lo)))
  }
}

// Display helper for COMPUTED statistics. Rounds, drops a trailing
// ".0" (so a mean that lands exactly on 44 prints as 44, not 44.0 --
// which matters because almost every quantity on this page is
// computed rather than typed), then hands off to num() for the Swiss
// thousands separator. Use this, not num(), for anything that came
// out of the functions above:
//   #stat-num(mean-of(salaries))          -> 94'714.29
//   #stat-num(median-of(nine))            -> 5
//   #stat-num(sd-of(sprint), digits: 3)   -> 0.273
#let stat-num(x, digits: 2) = {
  let r = calc.round(x, digits: digits)
  num(if r == calc.trunc(r) { calc.trunc(r) } else { r })
}

// Returns an ARRAY -- a dataset can be bimodal or multimodal, and
// collapsing that to a single number is the very thing the chapter
// warns against.
#let mode-of(xs) = {
  let tally = (:)
  for x in xs {
    let k = str(x)
    tally.insert(k, tally.at(k, default: 0) + 1)
  }
  let best = calc.max(..tally.values())
  xs.dedup().filter(x => tally.at(str(x)) == best).sorted()
}

// ── Shared chart internals ───────────────────────────────────

#let _chart-axis = 0.7pt + luma(70)
#let _chart-grid = 0.5pt + luma(215)
#let _chart-ink = luma(70)

// Round a raw step up to a human-readable 1 / 2 / 5 x 10^k.
#let _nice-step(span, target: 5) = {
  if span <= 0 { return 1 }
  let raw = span / target
  let mag = calc.pow(10.0, calc.floor(calc.log(raw, base: 10)))
  let norm = raw / mag
  let mult = if norm <= 1 { 1 } else if norm <= 2 { 2 } else if norm <= 5 {
    5
  } else { 10 }
  mult * mag
}

// Tick label: drop a trailing ".0" so 4.0 prints as 4.
#let _fmt(v) = {
  let r = calc.round(v, digits: 3)
  if r == calc.trunc(r) { str(calc.trunc(r)) } else { str(r) }
}

#let _ticks-from(lo, hi, step) = {
  let out = ()
  let k = calc.ceil(lo / step)
  while k * step <= hi + step / 1000 {
    out.push(k * step)
    k += 1
  }
  out
}

// Text centered on an x position, and text right-aligned before one.
// Both go through a fixed-width box because Typst cannot center
// content on a point without knowing its width first.
#let _label-at(x, y, body, w: 1.6cm, size: 8pt) = place(
  dx: x - w / 2,
  dy: y,
  box(width: w, align(center, text(size: size, fill: _chart-ink, body))),
)

#let _label-before(x, y, body, size: 8pt) = place(
  dx: 0pt,
  dy: y,
  box(width: x - 5pt, align(right, text(
    size: size,
    fill: _chart-ink,
    body,
  ))),
)

#let _vrule(x, y0, len, stroke) = place(
  dx: x,
  dy: y0,
  line(start: (0pt, 0pt), end: (0pt, len), stroke: stroke),
)

#let _hrule(x, y, len, stroke) = place(
  dx: x,
  dy: y,
  line(start: (0pt, 0pt), end: (len, 0pt), stroke: stroke),
)



// ════════════════════════════════════════════════════════════
//  ADDITIONS FOR preamble.typ
//
//  Insert this whole block into preamble.typ immediately AFTER the
//  `_hrule` definition at the end of the "Shared chart internals"
//  section (~line 1940) and BEFORE `// ── Bar chart`.
//
//  Conceptually these two belong up with the native figure helpers
//  (dot-triangle, koch-star, ...) around line 1320, but they reuse
//  _chart-axis / _chart-ink / _vrule / _hrule /
//  _ticks-from / _nice-step / _fmt, which are defined further down.
//  Typst needs the definitions first, so they go here.
//
//  Like fig(), plot-graph() and the four charts -- and UNLIKE
//  dot-triangle / koch-star / nested-squares -- neither of these is
//  wrapped in only-theory. That is deliberate and load-bearing: a
//  blank Venn diagram for students to shade themselves IS an exercise
//  question, and a number line with an interval marked on it is very
//  often the solution. Wrap a specific call in #only-theory[...]
//  yourself when a particular occurrence is theory illustration.
// ════════════════════════════════════════════════════════════


// ════════════════════════════════════════════════════════════
//  NUMBER LINE
//
//  A real number line with tick marks, carrying any number of
//  intervals ("spans"), marked points, and distance measurements.
//  Built for four jobs that recur across the course:
//
//    1. interval notation -- [a,b] vs [a,b) vs (a,b] vs (a,b), where
//       the filled/hollow endpoint is the whole point;
//    2. combining intervals -- A and B on stacked rows, so the
//       intersection/union/difference can be read off;
//    3. absolute value as distance -- |x - 3| = 4 as two hops;
//    4. domain and range in ch-functions-intro, including a domain
//       with a point removed (an "open" point is exactly a hole).
//
//  Items are built with three small constructors and passed
//  positionally (they return plain dictionaries, so they are only
//  meaningful inside a number-line(...) call -- never write
//  #nl-span(...) bare in prose):
//
//    nl-span(lo, hi, brackets: "[)", label:, color:, row:)
//    nl-point(x, label:, kind: "closed"|"open", side:, color:, row:)
//    nl-measure(from, to, label:, color:)
//
//  `brackets` is the interval notation itself, as a two-character
//  string -- "[]", "[)", "(]", "()" -- so the call site reads the way
//  the maths is written. Pass `none` for lo or hi to run off the edge
//  with an arrow, which is how an unbounded interval is drawn.
//
//    #number-line(from: -0.5, to: 9.5,
//      nl-span(1, 5, brackets: "[)", label: [$A$], row: 1),
//      nl-span(3, 8, brackets: "(]", label: [$B$], row: 2,
//              color: warn-col),
//    )
//
//    #number-line(from: -1.5, to: 9.5, ticks: none,
//      nl-point(-1, label: [$-1$], side: "below"),
//      nl-point(3,  label: [$3$],  side: "below"),
//      nl-point(7,  label: [$7$],  side: "below"),
//      nl-measure(-1, 3, label: [$4$]),
//      nl-measure(3, 7, label: [$4$]),
//    )
//
//    #number-line(from: -1.5, to: 6.5,          // [4, oo)
//      nl-span(4, none, brackets: "[)"))
//
//    #number-line(from: -3.5, to: 3.5,          // RR without {0}
//      nl-span(none, none, brackets: "()"),
//      nl-point(0, kind: "open", label: [$0$], side: "below"))
//
//  ticks:  auto  -- numeric ticks at a readable step (the default)
//          none  -- no ticks at all, for a purely symbolic line
//          array of (value, label) pairs -- explicit ticks, e.g.
//                   ticks: ((0, [$a$]), (1, [$b$])) for the interval
//                   notation figure, whose endpoints are letters
//                   rather than numbers. A label of `none` draws the
//                   tick mark with no number under it.
//
//  Rows: row 0 (the default) draws the span ON the axis; rows 1, 2,
//  ... stack it above, which is what you want when two intervals are
//  being compared. Point labels sit above their marker by default;
//  side: "below" puts them where coordinates normally go, and the
//  tick numbers then drop a line automatically to make room.
//
//  Space above the topmost label is reserved automatically, so a
//  labeled span never paints over the paragraph before it. `row-gap`
//  must stay above ~18pt whenever the rows carry labels, or a label
//  runs into the bar above it -- shrink it only for unlabeled rows.
//
//  `width` must be an ABSOLUTE length (cm/pt), never a percentage --
//  the geometry is computed in points, exactly as in the charts below.
// ════════════════════════════════════════════════════════════

#let nl-span(
  lo,
  hi,
  brackets: "[]",
  label: none,
  color: accent,
  row: 0,
) = (
  kind: "span",
  lo: lo,
  hi: hi,
  brackets: brackets,
  label: label,
  color: color,
  row: row,
)

#let nl-point(
  x,
  label: none,
  kind: "closed",
  side: "above",
  color: accent,
  row: 0,
) = (
  kind: "point",
  x: x,
  label: label,
  mark: kind,
  side: side,
  color: color,
  row: row,
)

#let nl-measure(from, to, label: none, color: _chart-ink) = (
  kind: "measure",
  from: from,
  to: to,
  label: label,
  color: color,
)

// Small filled triangle marking "the line continues this way".
// dir: 1 points right, -1 points left.
#let _nl-arrow(x, y, dir, color, size: 4pt) = place(
  dx: x,
  dy: y,
  polygon(
    fill: color,
    stroke: none,
    (0pt, 0pt),
    (-dir * size, -size * 0.42),
    (-dir * size, size * 0.42),
  ),
)

// Text centered on an x position that must NEVER wrap.
//
// _label-at boxes its content at a fixed width (1.6cm by default),
// which is right for the numeric tick labels it was written for but
// silently breaks a phrase like "tolerance band" across two lines --
// and the second line then lands on whatever sits below, the axis
// included. Here the INNER box() is auto-width, so it sizes to the
// content and is atomic; the outer fixed-width box only exists to
// provide the centering, and its width is generous rather than
// meaningful. Overflow past that width is harmless: place() does not
// participate in layout and nothing clips.
//
// Pass an explicit `w` only when the label must be centered within a
// known slot, as area-model does with its cell widths.
#let _fig-label(x, y, body, w: 5cm, size: 9pt, fill: _chart-ink) = place(
  dx: x - w / 2,
  dy: y,
  box(width: w, align(center, box(text(size: size, fill: fill, body)))),
)

// Endpoint dot: filled for an included endpoint, hollow for an
// excluded one. The hollow one is filled white rather than left
// transparent so the span bar underneath does not show through --
// that little gap is precisely what "not included" looks like.
#let _nl-dot(x, y, closed, color, r: 3pt) = place(
  dx: x - r,
  dy: y - r,
  circle(
    radius: r,
    fill: if closed { color } else { white },
    stroke: if closed { none } else { 1pt + color },
  ),
)

#let number-line(
  ..items,
  from: 0,
  to: 10,
  ticks: auto,
  step: auto,
  width: 10cm,
  row-gap: 24pt,
  bar-weight: 2.2pt,
  axis-label: none,
  pad-left: 0.7cm,
  pad-right: 0.7cm,
  pad-top: 0.15cm,
) = align(center, {
  let objs = items.pos()
  let lo = from
  let hi = to
  let px(v) = pad-left + width * (v - lo) / (hi - lo)

  let tick-step = if step == auto {
    _nice-step(hi - lo, target: 8)
  } else { step }
  let tick-list = if ticks == none {
    ()
  } else if ticks == auto {
    _ticks-from(lo, hi, tick-step).map(t => (t, _fmt(t)))
  } else { ticks }

  let measures = objs.filter(o => o.kind == "measure")
  let marks = objs.filter(o => o.kind != "measure")
  let max-row = if marks.len() == 0 {
    0
  } else { calc.max(..marks.map(o => o.row)) }

  // Anything labeled below the axis competes with the tick numbers,
  // so the numbers move down a line whenever that happens.
  let has-below = marks.any(o => (
    o.kind == "point"
      and o.at("side", default: "above") == "below"
      and o.label != none
  ))
  let tick-label-dy = if has-below { 20pt } else { 6pt }

  // Labels above a bar or point are placed label-lift above it, and a
  // 9pt line then occupies roughly label-lift..label-lift-11 below
  // that. Two consequences, both of which used to be wrong:
  //
  //   * the TOPMOST label needs that much clear space reserved above
  //     it, or place() pushes it out of the box and it paints over
  //     whatever precedes the figure;
  //   * row-gap has to exceed label-lift, or a label collides with the
  //     bar on the row above it. Hence the 24pt default -- shrink it
  //     only when the rows carry no labels.
  let label-lift = 15pt
  let has-above = marks.any(o => (
    o.label != none and o.at("side", default: "above") != "below"
  ))
  let head = if has-above or measures.len() > 0 { label-lift + 3pt } else {
    0pt
  }

  let measure-band = measures.len() * 18pt
  let axis-y = pad-top + head + measure-band + max-row * row-gap
  let foot-base = if tick-list.len() > 0 or has-below {
    tick-label-dy + 14pt
  } else { 8pt }
  let foot = foot-base + (if axis-label != none { 12pt } else { 0pt })

  box(width: pad-left + width + pad-right, height: axis-y + foot, {
    // ── the axis itself, arrowed at both ends ──
    _hrule(pad-left, axis-y, width, _chart-axis)
    _nl-arrow(pad-left + width + 3pt, axis-y, 1, luma(70))
    _nl-arrow(pad-left - 3pt, axis-y, -1, luma(70))

    // ── ticks ──
    for t in tick-list {
      let v = t.at(0)
      let lab = t.at(1, default: none)
      _vrule(px(v), axis-y - 3pt, 6pt, _chart-axis)
      if lab != none {
        _fig-label(px(v), axis-y + tick-label-dy, lab, w: 2.4cm, size: 8pt)
      }
    }

    // ── spans and points ──
    for o in marks {
      let y = axis-y - o.row * row-gap
      if o.kind == "span" {
        let open-left = o.lo == none
        let open-right = o.hi == none
        let x0 = if open-left { pad-left } else { px(o.lo) }
        let x1 = if open-right { pad-left + width } else { px(o.hi) }
        place(dx: x0, dy: y, line(
          start: (0pt, 0pt),
          end: (x1 - x0, 0pt),
          stroke: bar-weight + o.color,
        ))
        if open-left {
          _nl-arrow(pad-left - 3pt, y, -1, o.color)
        } else {
          _nl-dot(x0, y, o.brackets.starts-with("["), o.color)
        }
        if open-right {
          _nl-arrow(pad-left + width + 3pt, y, 1, o.color)
        } else {
          _nl-dot(x1, y, o.brackets.ends-with("]"), o.color)
        }
        if o.label != none {
          _fig-label(
            (x0 + x1) / 2,
            y - label-lift,
            text(fill: o.color, o.label),
          )
        }
      } else {
        _nl-dot(px(o.x), y, o.mark == "closed", o.color)
        if o.label != none {
          let dy = if o.at("side", default: "above") == "below" {
            y + 6pt
          } else { y - label-lift }
          _fig-label(px(o.x), dy, text(fill: o.color, o.label))
        }
      }
    }

    // ── distance measurements, stacked above everything ──
    for (i, m) in measures.enumerate() {
      let y = pad-top + head + i * 18pt
      let x0 = px(m.from)
      let x1 = px(m.to)
      // thin guides down to the axis, so it is unambiguous which
      // points the measurement runs between
      for x in (x0, x1) {
        place(dx: x, dy: y, line(
          start: (0pt, 0pt),
          end: (0pt, axis-y - y),
          stroke: 0.4pt + luma(180),
        ))
      }
      place(dx: x0, dy: y, line(
        start: (0pt, 0pt),
        end: (x1 - x0, 0pt),
        stroke: 0.7pt + m.color,
      ))
      _nl-arrow(x1, y, 1, m.color, size: 3.5pt)
      _nl-arrow(x0, y, -1, m.color, size: 3.5pt)
      if m.label != none {
        _fig-label((x0 + x1) / 2, y - label-lift, text(fill: m.color, m.label))
      }
    }

    if axis-label != none {
      place(
        dx: pad-left,
        dy: axis-y + tick-label-dy + 13pt,
        box(width: width, align(right, text(
          size: 8pt,
          fill: _chart-ink,
          axis-label,
        ))),
      )
    }
  })
})


// ════════════════════════════════════════════════════════════
//  VENN DIAGRAM (two sets)
//
//  Two labeled circles inside a universal-set rectangle, with any
//  combination of regions shaded.
//
//    #venn2("inter")                       // A ∩ B
//    #venn2("a-only")                      // A \ B
//    #venn2("sym-diff")                    // exactly one of the two
//    #venn2("none")                        // blank, for students to
//                                          // shade in themselves
//
//  Region names (aliases in brackets):
//    "a"        all of A            "b"        all of B
//    "inter"    A ∩ B  ["and"]      "union"    A ∪ B  ["or"]
//    "a-only"   A \ B  ["a-not-b"]  "b-only"   B \ A  ["b-not-a"]
//    "sym-diff" exactly one  ["xor"]
//    "outside"  neither  ["complement", "neither"]
//    "none"     nothing             "all"      everything
//
//  Pass an array to shade several at once: #venn2(("a-only", "b-only")).
//
//  layout:
//    "overlap"  (default) the general case
//    "disjoint" mutually exclusive events -- the circles do not meet,
//               and "inter" then correctly shades nothing at all
//    "subset"   B inside A, for B ⊆ A
//
//  values: places content in each region, keyed by region name -- the
//  form probability exercises actually need:
//
//    #venn2("none", values: (
//      a-only: [0.30], inter: [0.10], b-only: [0.25], outside: [0.35],
//    ))
//
//  Only a-only / inter / b-only / outside have a placement point; a
//  value handed to any other key is ignored. Note that "b-only" has no
//  meaningful position under layout: "subset", since that region is
//  empty by construction.
//
//  Set labels default to A and B and the universe to Omega, matching
//  the house probability notation. Pass universe: none to drop the
//  surrounding rectangle.
//
//  IMPLEMENTATION NOTE -- Typst has no boolean path operations, so the
//  lens A ∩ B is built as an explicit polygon tracing one arc of each
//  circle (the same approach koch-star already uses for its outline).
//  Its area agrees with the exact circular-lens formula to within
//  0.1%, and it depends on nothing but polygon() -- rather than on
//  clip:/radius: interactions, which would be harder to reason about
//  and to keep stable across Typst versions. Every other region is
//  then plain overpainting in the background color, which is why `bg`
//  has to match whatever the diagram is sitting on.
// ════════════════════════════════════════════════════════════

// Points along a circular arc, in float points, y measured downward.
#let _v2-arc(cx, cy, r, a0, a1, n: 48) = range(n + 1).map(i => {
  let t = a0 + (a1 - a0) * i / n
  ((cx + r * calc.cos(t)) * 1pt, (cy - r * calc.sin(t)) * 1pt)
})

// The lens where two circles overlap, as a closed polygon. Returns
// none when the circles miss each other, and the smaller circle when
// one contains the other -- so "inter" stays correct under all three
// layouts without the caller having to think about which case applies.
#let _v2-lens(xa, xb, cy, ra, rb) = {
  let d = calc.abs(xb - xa)
  if d >= ra + rb { return none }
  if d <= calc.abs(ra - rb) {
    let cx = if ra < rb { xa } else { xb }
    let r = calc.min(ra, rb)
    return _v2-arc(cx, cy, r, 0deg, 360deg, n: 96)
  }
  let a = (d * d + ra * ra - rb * rb) / (2 * d)
  let b = d - a
  let ta = calc.acos(calc.max(-1.0, calc.min(1.0, a / ra)))
  let tb = calc.acos(calc.max(-1.0, calc.min(1.0, b / rb)))
  // right-hand arc of A, from the top crossing down to the bottom one,
  // then the left-hand arc of B back up, which closes the shape
  let arc-a = _v2-arc(xa, cy, ra, ta, -ta)
  let arc-b = _v2-arc(xb, cy, rb, 180deg + tb, 180deg - tb)
  arc-a + arc-b
}

#let _v2-canon = (
  "and": "inter",
  "or": "union",
  "xor": "sym-diff",
  "complement": "outside",
  "neither": "outside",
  "a-not-b": "a-only",
  "b-not-a": "b-only",
)

#let venn2(
  ..args,
  layout: "overlap",
  labels: ([$A$], [$B$]),
  universe: [$Omega$],
  values: (:),
  width: 8cm,
  fill-color: accent-bg,
  stroke-color: accent,
  bg: white,
) = align(center, {
  let shade = args.pos().at(0, default: "none")
  let asked = if type(shade) == str { (shade,) } else { shade }
  let regions = asked.map(r => _v2-canon.at(r, default: r))
  let on(r) = regions.contains(r) or regions.contains("all")

  let w = width.pt()
  let h = w * 0.62
  let cy = h * 0.53
  // circle geometry per layout, as fractions of the total width
  let geo = if layout == "disjoint" {
    (0.27, 0.73, 0.190, 0.190)
  } else if layout == "subset" {
    (0.47, 0.555, 0.270, 0.130)
  } else { (0.365, 0.635, 0.250, 0.250) }
  let xa = w * geo.at(0)
  let xb = w * geo.at(1)
  let ra = w * geo.at(2)
  let rb = w * geo.at(3)

  let circ-a = _v2-arc(xa, cy, ra, 0deg, 360deg, n: 96)
  let circ-b = _v2-arc(xb, cy, rb, 0deg, 360deg, n: 96)
  let lens = _v2-lens(xa, xb, cy, ra, rb)

  let disc(pts, col) = place(dx: 0pt, dy: 0pt, polygon(
    fill: col,
    stroke: none,
    ..pts,
  ))

  box(width: width, height: h * 1pt, {
    // ── universal set ──
    if universe != none {
      place(dx: 0pt, dy: 0pt, rect(
        width: width,
        height: h * 1pt,
        radius: 2pt,
        fill: if on("outside") { fill-color } else { bg },
        stroke: 0.6pt + luma(150),
      ))
    } else if on("outside") {
      place(dx: 0pt, dy: 0pt, rect(
        width: width,
        height: h * 1pt,
        fill: fill-color,
        stroke: none,
      ))
    }

    // ── shading, painted in dependency order ──
    // Whole-circle regions go down first; the "-only" crescents are
    // then carved back out of them in the background color.
    if on("outside") {
      disc(circ-a, bg)
      disc(circ-b, bg)
    }
    if on("a") or on("union") or on("a-only") or on("sym-diff") {
      disc(circ-a, fill-color)
    }
    if on("b") or on("union") or on("b-only") or on("sym-diff") {
      disc(circ-b, fill-color)
    }
    if lens != none {
      let carve = (
        (on("a-only") and not (on("b") or on("union") or on("inter")))
          or (on("b-only") and not (on("a") or on("union") or on("inter")))
          or (on("sym-diff") and not on("inter"))
      )
      if carve { disc(lens, bg) }
      if on("inter") { disc(lens, fill-color) }
    }

    // ── outlines, always on top of any shading ──
    place(dx: 0pt, dy: 0pt, polygon(
      fill: none,
      stroke: 1pt + stroke-color,
      ..circ-a,
    ))
    place(dx: 0pt, dy: 0pt, polygon(
      fill: none,
      stroke: 1pt + stroke-color,
      ..circ-b,
    ))

    // ── labels, set in the upper-outer part of each circle. The
    //    inset is deliberately well short of the radius: at 0.55 a
    //    bold 10pt glyph reaches the outline on the small circles
    //    (the inner circle under layout: "subset", and both circles
    //    under "disjoint", which are smaller than the "overlap"
    //    ones). 0.42 clears all three with room to spare.
    if universe != none {
      place(dx: 5pt, dy: 4pt, text(size: 9pt, fill: _chart-ink, universe))
    }
    let inset = 0.42
    _fig-label(
      (xa - ra * inset) * 1pt,
      (cy - ra * inset - 5) * 1pt,
      text(weight: "bold", fill: stroke-color, labels.at(0)),
      w: 2cm,
      size: 10pt,
    )
    _fig-label(
      (xb + rb * inset) * 1pt,
      (cy - rb * inset - 5) * 1pt,
      text(weight: "bold", fill: stroke-color, labels.at(1)),
      w: 2cm,
      size: 10pt,
    )

    // ── per-region content ──
    // Under "subset" the intersection IS the inner circle, so its
    // value would land right under the B label. Drop it below centre.
    let centroid = (
      "a-only": (xa - ra * 0.42, cy),
      "b-only": (xb + rb * 0.42, cy),
      "inter": if layout == "subset" {
        (xb, cy + rb * 0.55)
      } else { ((xa + xb) / 2, cy) },
      "outside": (w * 0.10, h * 0.88),
    )
    for (key, body) in values.pairs() {
      let k = _v2-canon.at(key, default: key)
      let p = centroid.at(k, default: none)
      if p != none {
        _fig-label(p.at(0) * 1pt, (p.at(1) - 5) * 1pt, body, w: 2.4cm)
      }
    }
  })
})


// ════════════════════════════════════════════════════════════
//  AREA MODEL
//
//  A rectangle partitioned into labeled sub-rectangles: the picture
//  behind the distributive law and both special products. Three
//  chapters want it (algebra foundations for a·(b+c), (a+b)^2 and
//  a^2-b^2; quadratic for completing the square; powers for a^m·a^n),
//  which is exactly the "same kind of diagram more than once" signal
//  from STYLE_GUIDE §7 -- so it lives here rather than being
//  hand-placed three times.
//
//  Columns and rows are given as (label, size) tuples, where size is
//  a bare number in arbitrary units scaled by `unit`. Cells follow
//  ROW-MAJOR, one per (row, column) pair:
//
//    #area-model(
//      cols: (([$a$], 3), ([$b$], 2)),
//      rows: (([$a$], 3), ([$b$], 2)),
//      [$a^2$],      [$a dot b$],
//      [$a dot b$],  [$b^2$],
//    )
//
//  A cell may be bare content (used as its label), `none` for an
//  empty cell, or area-cell(...) for anything needing its own fill,
//  a colspan, or the "removed" treatment:
//
//    area-cell(label: [$b^2$], removed: true)      // dashed, unfilled
//    area-cell(label: [I], colspan: 2)             // spans 2 columns
//
//  `removed: true` is what makes the difference-of-squares dissection
//  work -- the corner that gets cut away is drawn in place, dashed
//  and unfilled, rather than silently omitted. Students need to see
//  the hole to see the subtraction.
//
//  `colspan:` matters for the same figure: the piece that gets cut
//  off and rotated is one rectangle, and drawing a column line
//  through it would suggest a cut that isn't being made. A row
//  carrying a colspan therefore has fewer items than there are
//  columns -- cells are consumed left to right, not indexed by
//  position.
//
//  Sizes should be roughly proportional to the quantities they stand
//  for, but they are deliberately NOT to scale with any particular
//  numeric value of a and b -- the diagram is a general argument, and
//  a suspiciously exact-looking picture invites students to measure
//  it instead of reasoning about it.
// ════════════════════════════════════════════════════════════

#let area-cell(
  label: none,
  fill: auto,
  removed: false,
  colspan: 1,
  text-color: auto,
) = (
  label: label,
  fill: fill,
  removed: removed,
  colspan: colspan,
  text-color: text-color,
)

#let area-model(
  ..cells,
  cols: (),
  rows: (),
  unit: 0.7cm,
  fill-color: accent-bg,
  stroke-color: accent,
  label-size: 9.5pt,
  dim-size: 9.5pt,
  pad-left: 1.0cm,
  pad-top: 0.55cm,
) = align(center, {
  let items = cells.pos()
  let ncol = cols.len()
  let nrow = rows.len()

  // running offsets, in the same arbitrary units as the tuples
  let xs = (0,)
  for c in cols { xs.push(xs.last() + c.at(1)) }
  let ys = (0,)
  for r in rows { ys.push(ys.last() + r.at(1)) }
  let total-u = xs.last()
  let total-v = ys.last()

  let px(u) = pad-left + unit * u
  let py(v) = pad-top + unit * v

  box(
    width: pad-left + unit * total-u,
    height: pad-top + unit * total-v,
    {
      // Cells are consumed left to right, row by row. A cell with
      // colspan: n covers n columns and swallows their share of the
      // row, so a row carries FEWER items than there are columns --
      // which is why this walks the array sequentially rather than
      // indexing it at i * ncol + j. With every colspan at its
      // default of 1 the two are identical.
      let k = 0
      for i in range(nrow) {
        let j = 0
        while j < ncol {
          let raw = items.at(k, default: none)
          k += 1
          let cell = if raw == none {
            area-cell()
          } else if type(raw) == dictionary and "removed" in raw {
            raw
          } else { area-cell(label: raw) }

          let span = calc.min(cell.at("colspan", default: 1), ncol - j)
          let x0 = px(xs.at(j))
          let y0 = py(ys.at(i))
          let w = unit * (xs.at(j + span) - xs.at(j))
          let h = unit * rows.at(i).at(1)

          place(dx: x0, dy: y0, rect(
            width: w,
            height: h,
            fill: if cell.removed {
              none
            } else if cell.fill == auto { fill-color } else { cell.fill },
            stroke: if cell.removed {
              (paint: luma(150), thickness: 0.8pt, dash: "dashed")
            } else { 0.8pt + stroke-color },
          ))

          if cell.label != none {
            _fig-label(
              x0 + w / 2,
              y0 + h / 2 - 6pt,
              text(
                fill: if cell.text-color == auto {
                  if cell.removed { luma(120) } else { _chart-ink }
                } else { cell.text-color },
                cell.label,
              ),
              w: w,
              size: label-size,
            )
          }

          j += span
        }
      }

      // ── dimension labels: columns above, rows to the left ──
      for (j, c) in cols.enumerate() {
        _fig-label(
          px(xs.at(j)) + unit * c.at(1) / 2,
          pad-top - 14pt,
          text(fill: stroke-color, weight: "bold", c.at(0)),
          w: 3cm,
          size: dim-size,
        )
      }
      // Same non-wrapping treatment as _fig-label, but right-aligned
      // against the grid rather than centered: pad-left is only about
      // 22pt of usable space, and a row label like $a-b$ is wider than
      // that. The inner box() keeps it on one line and lets it extend
      // leftward instead of stacking.
      for (i, r) in rows.enumerate() {
        place(
          dx: 0pt,
          dy: py(ys.at(i)) + unit * r.at(1) / 2 - 6pt,
          box(width: pad-left - 6pt, align(right, box(text(
            size: dim-size,
            fill: stroke-color,
            weight: "bold",
            r.at(0),
          )))),
        )
      }
    },
  )
})





// ── Bar chart (categorical -- bars separated by gaps) ─────────
//
//  #bar-chart(
//    ("Hydro", 29.1), ("Solar", 1.2), ("Wind", 0.1),
//    y-label: [bn. kWh],
//  )
//
//  Categorical data, so the bars are SEPARATED -- the gap is what
//  distinguishes a bar chart from a histogram, and it is a real
//  distinction, not decoration.
//
//  ymin: is the truncated-axis lever. Compare
//    #bar-chart(..., ymin: 0)     honest
//    #bar-chart(..., ymin: 299)   the same data, "twice as good"

#let bar-chart(
  ..bars,
  ymin: 0,
  ymax: auto,
  ystep: auto,
  width: 8cm,
  height: 5cm,
  bar-color: accent,
  colors: none,
  y-label: none,
  gap: 0.3,
  show-values: false,
  show-grid: true,
  pad-left: 1.1cm,
  pad-bottom: 0.9cm,
  pad-top: 0.15cm,
  pad-right: 0.3cm,
) = align(center, {
  let items = bars.pos()
  let n = items.len()
  let values = items.map(it => it.at(1))
  let data-max = calc.max(..values)

  let step = if ystep == auto { _nice-step(data-max - ymin) } else { ystep }
  let hi = if ymax != auto { ymax } else {
    let h = ymin + calc.ceil((data-max - ymin) / step) * step
    if h <= data-max { h + step } else { h }
  }

  // The tallest bar's printed value needs somewhere to sit. Without
  // this it is pushed clean out of the plot area and lands on the
  // y-label. Raising the axis maximum by whole steps keeps the tick
  // grid readable, which merely nudging the label would not.
  if show-values and ymax == auto {
    let guard = 0
    while (
      height * (1 - (data-max - ymin) / (hi - ymin)) < 15pt and guard < 5
    ) {
      hi += step
      guard += 1
    }
  }

  // The y-label gets a reserved band ABOVE the plot rather than
  // sharing airspace with the bars.
  let head = if y-label != none { pad-top + 0.42cm } else { pad-top }

  let total-w = pad-left + width + pad-right
  let total-h = head + height + pad-bottom
  let base = head + height
  let py(v) = head + height * (1 - (v - ymin) / (hi - ymin))
  let slot = width / n

  box(width: total-w, height: total-h, {
    for t in _ticks-from(ymin, hi, step) {
      if show-grid and t > ymin {
        _hrule(pad-left, py(t), width, _chart-grid)
      }
      _label-before(pad-left, py(t) - 5pt, _fmt(t))
    }

    for (i, it) in items.enumerate() {
      let v = it.at(1)
      let col = if colors == none { bar-color } else {
        colors.at(calc.rem(i, colors.len()))
      }
      let bw = slot * (1 - gap)
      let bx = pad-left + i * slot + (slot - bw) / 2
      let bty = py(calc.max(calc.min(v, hi), ymin))
      let bh = base - bty
      if bh > 0pt {
        place(dx: bx, dy: bty, rect(
          width: bw,
          height: bh,
          fill: col,
          stroke: none,
        ))
      }
      if show-values {
        _label-at(
          pad-left + (i + 0.5) * slot,
          bty - 12pt,
          _fmt(v),
          w: slot,
          size: 7.5pt,
        )
      }
      _label-at(
        pad-left + (i + 0.5) * slot,
        base + 4pt,
        it.at(0),
        w: slot,
        size: 7.5pt,
      )
    }

    _hrule(pad-left, base, width, _chart-axis)
    _vrule(pad-left, head, height, _chart-axis)

    if y-label != none {
      place(dx: pad-left + 3pt, dy: pad-top, text(
        size: 8pt,
        fill: _chart-ink,
        y-label,
      ))
    }
  })
})

// ── Histogram (numeric -- bars touch) ────────────────────────
//
//  #histogram(travel-times)                        // sqrt(n) bins
//  #histogram(travel-times, bins: 4)
//  #histogram(travel-times, bin-width: 10, start: 10)
//  #histogram(counts: ((10, 20, 3), (20, 30, 7)))  // from a table
//
//  bins: auto applies the sqrt(n) rule of thumb, so the DEFAULT is
//  the rule the chapter teaches -- and overriding it is exactly the
//  bin-width investigation.
//
//  counts: takes (lo, hi, frequency) triples for the common case
//  where the frequency table is given and the raw data is not.

#let histogram(
  ..args,
  counts: none,
  bins: auto,
  bin-width: none,
  start: auto,
  ymax: auto,
  ystep: auto,
  width: 8cm,
  height: 5cm,
  bar-color: accent,
  y-label: [frequency],
  x-label: none,
  show-grid: true,
  pad-left: 1.1cm,
  pad-bottom: auto,
  pad-top: 0.15cm,
  pad-right: 0.5cm,
) = align(center, {
  let cells = if counts != none { counts } else {
    let data = args.pos().at(0, default: ())
    let n = data.len()
    let lo0 = if start == auto { calc.min(..data) } else { start }
    let hi0 = calc.max(..data)
    // int() on the whole thing, not just the sqrt branch: calc.round
    // returns a FLOAT when given a float, and range() further down
    // demands a genuine integer. Wrapping here also absorbs a caller
    // who writes bins: 4.0.
    let k = int(if bin-width != none {
      calc.max(1, calc.ceil((hi0 - lo0) / bin-width))
    } else if bins == auto {
      calc.max(1, calc.round(calc.sqrt(n)))
    } else { bins })
    let w = if bin-width != none { bin-width } else {
      if hi0 == lo0 { 1 } else { (hi0 - lo0) / k }
    }
    // Half-open bins [edge, next) so no observation is counted twice;
    // the last bin closes on the right so the maximum is included.
    range(k).map(i => {
      let edge = lo0 + i * w
      let nxt = lo0 + (i + 1) * w
      let c = data
        .filter(x => (
          x >= edge
            and (
              if i == k - 1 { x <= nxt } else {
                x < nxt
              }
            )
        ))
        .len()
      (edge, nxt, c)
    })
  }

  let freqs = cells.map(c => c.at(2))
  let data-max = calc.max(..freqs)
  let step = if ystep == auto { _nice-step(data-max) } else { ystep }
  let hi = if ymax != auto { ymax } else {
    let h = calc.ceil(data-max / step) * step
    if h <= data-max { h + step } else { h }
  }

  let xlo = cells.first().at(0)
  let xhi = cells.last().at(1)

  let head = if y-label != none { pad-top + 0.42cm } else { pad-top }
  // Bin-edge labels take one 8pt line; an x-label goes on a SECOND
  // line below them, never sharing the first.
  let foot = if pad-bottom != auto { pad-bottom } else {
    18pt + (if x-label != none { 12pt } else { 0pt })
  }

  let total-w = pad-left + width + pad-right
  let total-h = head + height + foot
  let base = head + height
  let py(v) = head + height * (1 - v / hi)
  let px(v) = pad-left + width * (v - xlo) / (xhi - xlo)

  box(width: total-w, height: total-h, {
    for t in _ticks-from(0, hi, step) {
      if show-grid and t > 0 { _hrule(pad-left, py(t), width, _chart-grid) }
      _label-before(pad-left, py(t) - 5pt, _fmt(t))
    }

    for c in cells {
      let bx = px(c.at(0))
      let bw = px(c.at(1)) - bx
      let bty = py(c.at(2))
      let bh = base - bty
      if bh > 0pt {
        place(dx: bx, dy: bty, rect(
          width: bw,
          height: bh,
          fill: bar-color,
          stroke: 0.6pt + white,
        ))
      }
    }

    for e in cells.map(c => c.at(0)) + (xhi,) {
      _label-at(px(e), base + 4pt, _fmt(e), size: 7.5pt)
    }

    _hrule(pad-left, base, width, _chart-axis)
    _vrule(pad-left, head, height, _chart-axis)

    if y-label != none {
      place(dx: pad-left + 3pt, dy: pad-top, text(
        size: 8pt,
        fill: _chart-ink,
        y-label,
      ))
    }
    if x-label != none {
      place(
        dx: pad-left,
        dy: base + 18pt,
        box(width: width, align(right, text(
          size: 8pt,
          fill: _chart-ink,
          x-label,
        ))),
      )
    }
  })
})

// ── Dotplot (one dot per observation, stacked) ───────────────
//
//  #dotplot((12, 9, 23, 10, 10, 8, 35, 9, 2, 14))
//
//  The most honest small-data display there is: every single
//  observation stays individually visible, so nothing is hidden by a
//  choice of bin. Worth showing next to the histogram of the same
//  data for exactly that reason.

#let dotplot(
  ..args,
  xmin: auto,
  xmax: auto,
  step: auto,
  width: 9cm,
  dot-radius: 3pt,
  dot-gap: 8pt,
  dot-color: accent,
  x-label: none,
  pad-left: 0.9cm,
  pad-right: 0.9cm,
  pad-top: 0.3cm,
  pad-bottom: auto,
) = align(center, {
  let data = args.pos().at(0, default: ())

  let tally = (:)
  for x in data {
    let k = str(x)
    tally.insert(k, tally.at(k, default: 0) + 1)
  }
  let stack-max = calc.max(..tally.values())

  let lo = if xmin == auto { calc.min(..data) } else { xmin }
  let hi = if xmax == auto { calc.max(..data) } else { xmax }
  let tick-step = if step == auto {
    _nice-step(hi - lo, target: 8)
  } else { step }

  let height = stack-max * dot-gap + dot-radius
  // tick numbers on one line, x-label on the next
  let foot = if pad-bottom != auto { pad-bottom } else {
    20pt + (if x-label != none { 12pt } else { 0pt })
  }
  let total-w = pad-left + width + pad-right
  let total-h = pad-top + height + foot
  let base = pad-top + height
  let px(v) = pad-left + width * (v - lo) / (hi - lo)

  box(width: total-w, height: total-h, {
    for x in data.dedup().sorted() {
      for j in range(tally.at(str(x))) {
        place(
          dx: px(x) - dot-radius,
          dy: base - (j + 1) * dot-gap,
          circle(radius: dot-radius, fill: dot-color, stroke: none),
        )
      }
    }

    _hrule(pad-left, base, width, _chart-axis)

    for t in _ticks-from(lo, hi, tick-step) {
      _vrule(px(t), base, 4pt, _chart-axis)
      _label-at(px(t), base + 6pt, _fmt(t))
    }

    if x-label != none {
      place(
        dx: pad-left,
        dy: base + 20pt,
        box(width: width, align(right, text(
          size: 8pt,
          fill: _chart-ink,
          x-label,
        ))),
      )
    }
  })
})

// ── Boxplot (one or several, sharing one axis) ───────────────
//
//  #boxplot(("Antonia", (9.5, 11, 9, 10, 10.5)),
//           ("Lars",    (13, 7, 6, 15, 9)))
//
//  Each series is ("Label", data-array) -- the five-number summary
//  and the outliers get computed -- or ("Label", (min: .., q1: ..,
//  med: .., q3: .., max: .., outliers: (..))) when only the summary
//  is known. That second form matters: reading a boxplot BACK off a
//  printed figure is its own exercise type, and those exercises have
//  no underlying dataset to hand.
//
//  whiskers: "tukey"  -- whiskers reach the most extreme observation
//                        still within 1.5 x IQR of the quartile;
//                        anything past that is drawn as its own
//                        point. NOTE this is the correct rule: the
//                        whisker ends at a REAL DATA VALUE, not at
//                        the fence itself.
//  whiskers: "minmax" -- whiskers reach the true minimum and
//                        maximum, nothing marked as an outlier (the
//                        textbook's convention).
//
//  method: passes through to quartiles-of, so one figure can show
//  the two quartile conventions disagreeing on identical data.

#let _box-summary(spec, whiskers: "tukey", method: "exclusive") = {
  if type(spec) == dictionary {
    (
      q1: spec.q1,
      med: spec.med,
      q3: spec.q3,
      lo: spec.at("min", default: spec.q1),
      hi: spec.at("max", default: spec.q3),
      outliers: spec.at("outliers", default: ()),
    )
  } else {
    let f = five-number(spec, method: method)
    if whiskers == "minmax" {
      (q1: f.q1, med: f.med, q3: f.q3, lo: f.min, hi: f.max, outliers: ())
    } else {
      let low-fence = f.q1 - 1.5 * f.iqr
      let high-fence = f.q3 + 1.5 * f.iqr
      let inside = spec.filter(x => x >= low-fence and x <= high-fence)
      (
        q1: f.q1,
        med: f.med,
        q3: f.q3,
        lo: calc.min(..inside),
        hi: calc.max(..inside),
        outliers: spec.filter(x => x < low-fence or x > high-fence).sorted(),
      )
    }
  }
}

#let boxplot(
  ..series,
  xmin: auto,
  xmax: auto,
  xstep: auto,
  whiskers: "tukey",
  method: "exclusive",
  width: 9cm,
  box-height: 0.75cm,
  row-gap: 0.5cm,
  box-color: accent,
  fill-color: accent-bg,
  outlier-color: warn-col,
  label-width: 2cm,
  x-label: none,
  pad-right: 0.6cm,
  pad-top: 0.3cm,
  pad-bottom: auto,
) = align(center, {
  let items = series.pos()
  let sums = items.map(it => _box-summary(
    it.at(1),
    whiskers: whiskers,
    method: method,
  ))

  let spread = ()
  for s in sums { spread += (s.lo, s.hi) + s.outliers }
  let raw-lo = calc.min(..spread)
  let raw-hi = calc.max(..spread)
  let margin = (raw-hi - raw-lo) * 0.08
  let lo = if xmin == auto { raw-lo - margin } else { xmin }
  let hi = if xmax == auto { raw-hi + margin } else { xmax }
  let tick-step = if xstep == auto {
    _nice-step(hi - lo, target: 6)
  } else { xstep }

  let n = items.len()
  let plot-h = n * box-height + calc.max(0, n - 1) * row-gap
  // 0.25cm down to the axis, then one line of tick numbers, then the
  // x-label on its own line below those.
  let foot = if pad-bottom != auto { pad-bottom } else {
    0.25cm + 20pt + (if x-label != none { 12pt } else { 0pt })
  }
  let total-w = label-width + width + pad-right
  let total-h = pad-top + plot-h + foot
  let px(v) = label-width + width * (v - lo) / (hi - lo)

  box(width: total-w, height: total-h, {
    for (i, sum) in sums.enumerate() {
      let row-top = pad-top + i * (box-height + row-gap)
      let mid = row-top + box-height / 2

      _hrule(px(sum.lo), mid, px(sum.q1) - px(sum.lo), 0.8pt + box-color)
      _hrule(px(sum.q3), mid, px(sum.hi) - px(sum.q3), 0.8pt + box-color)
      _vrule(
        px(sum.lo),
        row-top + box-height * 0.2,
        box-height * 0.6,
        0.8pt + box-color,
      )
      _vrule(
        px(sum.hi),
        row-top + box-height * 0.2,
        box-height * 0.6,
        0.8pt + box-color,
      )

      place(dx: px(sum.q1), dy: row-top, rect(
        width: px(sum.q3) - px(sum.q1),
        height: box-height,
        fill: fill-color,
        stroke: 0.9pt + box-color,
      ))
      _vrule(px(sum.med), row-top, box-height, 1.4pt + box-color)

      for o in sum.outliers {
        place(dx: px(o) - 2.5pt, dy: mid - 2.5pt, circle(
          radius: 2.5pt,
          fill: none,
          stroke: 0.9pt + outlier-color,
        ))
      }

      _label-before(label-width, mid - 6pt, items.at(i).at(0), size: 9pt)
    }

    let ay = pad-top + plot-h + 0.25cm
    _hrule(label-width, ay, width, _chart-axis)
    for t in _ticks-from(lo, hi, tick-step) {
      _vrule(px(t), ay, 4pt, _chart-axis)
      _label-at(px(t), ay + 6pt, _fmt(t))
    }

    if x-label != none {
      place(
        dx: label-width,
        dy: ay + 20pt,
        box(width: width, align(right, text(
          size: 8pt,
          fill: _chart-ink,
          x-label,
        ))),
      )
    }
  })
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

// ════════════════════════════════════════════════════════════
//  STATISTICAL SUMMARIES AND CHARTS
//
//  simple-plot (imported above) covers function graphs, scatter
//  plots and line plots. It has nothing for the four chart types
//  descriptive statistics actually needs -- bar charts, histograms,
//  dotplots and boxplots -- so those are hand-rolled here from
//  native Typst shapes, in the same spirit as dot-triangle /
//  koch-star above: no external package, compiles offline, never
//  goes stale.
//
//  DESIGN NOTE -- misleading graphs are produced by PARAMETER, not
//  by hand-drawing a second fake figure. bar-chart takes an explicit
//  `ymin:`, so the truncated-axis deception is one changed argument
//  away from the honest chart; histogram takes `bins:`, so the
//  too-few-bins / too-many-bins triptych is three calls differing in
//  one number. That matters pedagogically: students should see that
//  a misleading chart usually needs no fakery at all, just a
//  defensible-looking option chosen badly.
//
//  Like fig() and plot-graph(), NONE of these is wrapped in
//  only-theory -- a chart is very often the question or the solution
//  of an exercise, not just theory prose. Wrap a specific call in
//  #only-theory[...] yourself when you want that occurrence
//  suppressed on the exercise sheet.
//
//  All four take absolute width:/height: in Typst lengths (unlike
//  plot-graph, whose size: is a bare centimeter count inherited from
//  simple-plot). Inside image-grid(), pass a smaller width: so two
//  charts plus the gutter still fit the text block.
// ════════════════════════════════════════════════════════════

// ── Numeric summaries ────────────────────────────────────────
//  Exported so chapter prose can COMPUTE the numbers it quotes --
//  #mean-of(waiting-times) rather than a hardcoded 8.4 -- which is
//  what keeps an example's text, its table and its chart from
//  drifting apart when the dataset is edited.

#let mean-of(xs) = xs.sum() / xs.len()

#let median-of(xs) = {
  let s = xs.sorted()
  let n = s.len()
  if n == 0 { return none }
  if calc.odd(n) { s.at(int((n - 1) / 2)) } else {
    (s.at(int(n / 2) - 1) + s.at(int(n / 2))) / 2
  }
}

// HOUSE CONVENTION -- variance divides by n. Descriptive statistics
// describes the dataset you actually have, so the population formula
// is the definition. The n-1 version below is the separate estimator
// used when the data is a SAMPLE standing in for a larger
// population; both sit on the students' calculators (sigma-x vs.
// s-x), so both are exported here under names that say which is
// which.
#let variance-of(xs) = {
  let m = mean-of(xs)
  xs.map(x => calc.pow(x - m, 2)).sum() / xs.len()
}
#let sd-of(xs) = calc.sqrt(variance-of(xs))

#let sample-variance-of(xs) = {
  let m = mean-of(xs)
  xs.map(x => calc.pow(x - m, 2)).sum() / (xs.len() - 1)
}
#let sample-sd-of(xs) = calc.sqrt(sample-variance-of(xs))

// QUARTILE CONVENTION -- "exclusive" (house default) is the
// median-of-each-half method with the overall median left out of
// both halves when n is odd; this is what the TI calculators and the
// textbook do. "inclusive" keeps the median in both halves. The two
// disagree whenever n is odd (on 1..9: 2.5/7.5 vs. 3/7), which is
// exactly the discrepancy the chapter's warning box is about -- so
// both are implemented and a figure can show them disagreeing on the
// same data.
#let quartiles-of(xs, method: "exclusive") = {
  let s = xs.sorted()
  let n = s.len()
  let h = int(n / 2)
  let lower = if calc.even(n) or method != "inclusive" {
    s.slice(0, h)
  } else { s.slice(0, h + 1) }
  let upper = if calc.even(n) { s.slice(h) } else { s.slice(h + 1) }
  (q1: median-of(lower), med: median-of(s), q3: median-of(upper))
}

#let five-number(xs, method: "exclusive") = {
  let s = xs.sorted()
  let q = quartiles-of(s, method: method)
  (
    min: s.first(),
    q1: q.q1,
    med: q.med,
    q3: q.q3,
    max: s.last(),
    iqr: q.q3 - q.q1,
  )
}

// Linear-interpolation percentile (R's default type 7, and
// spreadsheet PERCENTILE.INC). Deliberately NOT the same rule as
// quartiles-of above: that mismatch is genuine, it is why two tools
// report different quartiles for the same data, and the chapter says
// so out loud rather than hiding it.
#let percentile-of(xs, p) = {
  let s = xs.sorted()
  let n = s.len()
  if n == 0 { return none }
  if n == 1 { return s.first() }
  let pos = (p / 100) * (n - 1)
  let lo = calc.floor(pos)
  let hi = calc.ceil(pos)
  if lo == hi { s.at(int(lo)) } else {
    s.at(int(lo)) + (pos - lo) * (s.at(int(hi)) - s.at(int(lo)))
  }
}

// Display helper for COMPUTED statistics. Rounds, drops a trailing
// ".0" (so a mean that lands exactly on 44 prints as 44, not 44.0 --
// which matters because almost every quantity on this page is
// computed rather than typed), then hands off to num() for the Swiss
// thousands separator. Use this, not num(), for anything that came
// out of the functions above:
//   #stat-num(mean-of(salaries))          -> 94'714.29
//   #stat-num(median-of(nine))            -> 5
//   #stat-num(sd-of(sprint), digits: 3)   -> 0.273
#let stat-num(x, digits: 2) = {
  let r = calc.round(x, digits: digits)
  num(if r == calc.trunc(r) { calc.trunc(r) } else { r })
}

// Returns an ARRAY -- a dataset can be bimodal or multimodal, and
// collapsing that to a single number is the very thing the chapter
// warns against.
#let mode-of(xs) = {
  let tally = (:)
  for x in xs {
    let k = str(x)
    tally.insert(k, tally.at(k, default: 0) + 1)
  }
  let best = calc.max(..tally.values())
  xs.dedup().filter(x => tally.at(str(x)) == best).sorted()
}

// ── Shared chart internals ───────────────────────────────────

#let _chart-axis = 0.7pt + luma(70)
#let _chart-grid = 0.5pt + luma(215)
#let _chart-ink = luma(70)

// Round a raw step up to a human-readable 1 / 2 / 5 x 10^k.
#let _nice-step(span, target: 5) = {
  if span <= 0 { return 1 }
  let raw = span / target
  let mag = calc.pow(10.0, calc.floor(calc.log(raw, base: 10)))
  let norm = raw / mag
  let mult = if norm <= 1 { 1 } else if norm <= 2 { 2 } else if norm <= 5 {
    5
  } else { 10 }
  mult * mag
}

// Tick label: drop a trailing ".0" so 4.0 prints as 4.
#let _fmt(v) = {
  let r = calc.round(v, digits: 3)
  if r == calc.trunc(r) { str(calc.trunc(r)) } else { str(r) }
}

#let _ticks-from(lo, hi, step) = {
  let out = ()
  let k = calc.ceil(lo / step)
  while k * step <= hi + step / 1000 {
    out.push(k * step)
    k += 1
  }
  out
}

// Text centered on an x position, and text right-aligned before one.
// Both go through a fixed-width box because Typst cannot center
// content on a point without knowing its width first.
#let _label-at(x, y, body, w: 1.6cm, size: 8pt) = place(
  dx: x - w / 2,
  dy: y,
  box(width: w, align(center, text(size: size, fill: _chart-ink, body))),
)

#let _label-before(x, y, body, size: 8pt) = place(
  dx: 0pt,
  dy: y,
  box(width: x - 5pt, align(right, text(
    size: size,
    fill: _chart-ink,
    body,
  ))),
)

#let _vrule(x, y0, len, stroke) = place(
  dx: x,
  dy: y0,
  line(start: (0pt, 0pt), end: (0pt, len), stroke: stroke),
)

#let _hrule(x, y, len, stroke) = place(
  dx: x,
  dy: y,
  line(start: (0pt, 0pt), end: (len, 0pt), stroke: stroke),
)



// ════════════════════════════════════════════════════════════
//  ADDITIONS FOR preamble.typ
//
//  Insert this whole block into preamble.typ immediately AFTER the
//  `_hrule` definition at the end of the "Shared chart internals"
//  section (~line 1940) and BEFORE `// ── Bar chart`.
//
//  Conceptually these two belong up with the native figure helpers
//  (dot-triangle, koch-star, ...) around line 1320, but they reuse
//  _chart-axis / _chart-ink / _vrule / _hrule /
//  _ticks-from / _nice-step / _fmt, which are defined further down.
//  Typst needs the definitions first, so they go here.
//
//  Like fig(), plot-graph() and the four charts -- and UNLIKE
//  dot-triangle / koch-star / nested-squares -- neither of these is
//  wrapped in only-theory. That is deliberate and load-bearing: a
//  blank Venn diagram for students to shade themselves IS an exercise
//  question, and a number line with an interval marked on it is very
//  often the solution. Wrap a specific call in #only-theory[...]
//  yourself when a particular occurrence is theory illustration.
// ════════════════════════════════════════════════════════════


// ════════════════════════════════════════════════════════════
//  NUMBER LINE
//
//  A real number line with tick marks, carrying any number of
//  intervals ("spans"), marked points, and distance measurements.
//  Built for four jobs that recur across the course:
//
//    1. interval notation -- [a,b] vs [a,b) vs (a,b] vs (a,b), where
//       the filled/hollow endpoint is the whole point;
//    2. combining intervals -- A and B on stacked rows, so the
//       intersection/union/difference can be read off;
//    3. absolute value as distance -- |x - 3| = 4 as two hops;
//    4. domain and range in ch-functions-intro, including a domain
//       with a point removed (an "open" point is exactly a hole).
//
//  Items are built with three small constructors and passed
//  positionally (they return plain dictionaries, so they are only
//  meaningful inside a number-line(...) call -- never write
//  #nl-span(...) bare in prose):
//
//    nl-span(lo, hi, brackets: "[)", label:, color:, row:)
//    nl-point(x, label:, kind: "closed"|"open", side:, color:, row:)
//    nl-measure(from, to, label:, color:)
//
//  `brackets` is the interval notation itself, as a two-character
//  string -- "[]", "[)", "(]", "()" -- so the call site reads the way
//  the maths is written. Pass `none` for lo or hi to run off the edge
//  with an arrow, which is how an unbounded interval is drawn.
//
//    #number-line(from: -0.5, to: 9.5,
//      nl-span(1, 5, brackets: "[)", label: [$A$], row: 1),
//      nl-span(3, 8, brackets: "(]", label: [$B$], row: 2,
//              color: warn-col),
//    )
//
//    #number-line(from: -1.5, to: 9.5, ticks: none,
//      nl-point(-1, label: [$-1$], side: "below"),
//      nl-point(3,  label: [$3$],  side: "below"),
//      nl-point(7,  label: [$7$],  side: "below"),
//      nl-measure(-1, 3, label: [$4$]),
//      nl-measure(3, 7, label: [$4$]),
//    )
//
//    #number-line(from: -1.5, to: 6.5,          // [4, oo)
//      nl-span(4, none, brackets: "[)"))
//
//    #number-line(from: -3.5, to: 3.5,          // RR without {0}
//      nl-span(none, none, brackets: "()"),
//      nl-point(0, kind: "open", label: [$0$], side: "below"))
//
//  ticks:  auto  -- numeric ticks at a readable step (the default)
//          none  -- no ticks at all, for a purely symbolic line
//          array of (value, label) pairs -- explicit ticks, e.g.
//                   ticks: ((0, [$a$]), (1, [$b$])) for the interval
//                   notation figure, whose endpoints are letters
//                   rather than numbers. A label of `none` draws the
//                   tick mark with no number under it.
//
//  Rows: row 0 (the default) draws the span ON the axis; rows 1, 2,
//  ... stack it above, which is what you want when two intervals are
//  being compared. Point labels sit above their marker by default;
//  side: "below" puts them where coordinates normally go, and the
//  tick numbers then drop a line automatically to make room.
//
//  Space above the topmost label is reserved automatically, so a
//  labeled span never paints over the paragraph before it. `row-gap`
//  must stay above ~18pt whenever the rows carry labels, or a label
//  runs into the bar above it -- shrink it only for unlabeled rows.
//
//  `width` must be an ABSOLUTE length (cm/pt), never a percentage --
//  the geometry is computed in points, exactly as in the charts below.
// ════════════════════════════════════════════════════════════

#let nl-span(
  lo,
  hi,
  brackets: "[]",
  label: none,
  color: accent,
  row: 0,
) = (
  kind: "span",
  lo: lo,
  hi: hi,
  brackets: brackets,
  label: label,
  color: color,
  row: row,
)

#let nl-point(
  x,
  label: none,
  kind: "closed",
  side: "above",
  color: accent,
  row: 0,
) = (
  kind: "point",
  x: x,
  label: label,
  mark: kind,
  side: side,
  color: color,
  row: row,
)

#let nl-measure(from, to, label: none, color: _chart-ink) = (
  kind: "measure",
  from: from,
  to: to,
  label: label,
  color: color,
)

// Small filled triangle marking "the line continues this way".
// dir: 1 points right, -1 points left.
#let _nl-arrow(x, y, dir, color, size: 4pt) = place(
  dx: x,
  dy: y,
  polygon(
    fill: color,
    stroke: none,
    (0pt, 0pt),
    (-dir * size, -size * 0.42),
    (-dir * size, size * 0.42),
  ),
)

// Text centered on an x position that must NEVER wrap.
//
// _label-at boxes its content at a fixed width (1.6cm by default),
// which is right for the numeric tick labels it was written for but
// silently breaks a phrase like "tolerance band" across two lines --
// and the second line then lands on whatever sits below, the axis
// included. Here the INNER box() is auto-width, so it sizes to the
// content and is atomic; the outer fixed-width box only exists to
// provide the centering, and its width is generous rather than
// meaningful. Overflow past that width is harmless: place() does not
// participate in layout and nothing clips.
//
// Pass an explicit `w` only when the label must be centered within a
// known slot, as area-model does with its cell widths.
#let _fig-label(x, y, body, w: 5cm, size: 9pt, fill: _chart-ink) = place(
  dx: x - w / 2,
  dy: y,
  box(width: w, align(center, box(text(size: size, fill: fill, body)))),
)

// Endpoint dot: filled for an included endpoint, hollow for an
// excluded one. The hollow one is filled white rather than left
// transparent so the span bar underneath does not show through --
// that little gap is precisely what "not included" looks like.
#let _nl-dot(x, y, closed, color, r: 3pt) = place(
  dx: x - r,
  dy: y - r,
  circle(
    radius: r,
    fill: if closed { color } else { white },
    stroke: if closed { none } else { 1pt + color },
  ),
)

#let number-line(
  ..items,
  from: 0,
  to: 10,
  ticks: auto,
  step: auto,
  width: 10cm,
  row-gap: 24pt,
  bar-weight: 2.2pt,
  axis-label: none,
  pad-left: 0.7cm,
  pad-right: 0.7cm,
  pad-top: 0.15cm,
) = align(center, {
  let objs = items.pos()
  let lo = from
  let hi = to
  let px(v) = pad-left + width * (v - lo) / (hi - lo)

  let tick-step = if step == auto {
    _nice-step(hi - lo, target: 8)
  } else { step }
  let tick-list = if ticks == none {
    ()
  } else if ticks == auto {
    _ticks-from(lo, hi, tick-step).map(t => (t, _fmt(t)))
  } else { ticks }

  let measures = objs.filter(o => o.kind == "measure")
  let marks = objs.filter(o => o.kind != "measure")
  let max-row = if marks.len() == 0 {
    0
  } else { calc.max(..marks.map(o => o.row)) }

  // Anything labeled below the axis competes with the tick numbers,
  // so the numbers move down a line whenever that happens.
  let has-below = marks.any(o => (
    o.kind == "point"
      and o.at("side", default: "above") == "below"
      and o.label != none
  ))
  let tick-label-dy = if has-below { 20pt } else { 6pt }

  // Labels above a bar or point are placed label-lift above it, and a
  // 9pt line then occupies roughly label-lift..label-lift-11 below
  // that. Two consequences, both of which used to be wrong:
  //
  //   * the TOPMOST label needs that much clear space reserved above
  //     it, or place() pushes it out of the box and it paints over
  //     whatever precedes the figure;
  //   * row-gap has to exceed label-lift, or a label collides with the
  //     bar on the row above it. Hence the 24pt default -- shrink it
  //     only when the rows carry no labels.
  let label-lift = 15pt
  let has-above = marks.any(o => (
    o.label != none and o.at("side", default: "above") != "below"
  ))
  let head = if has-above or measures.len() > 0 { label-lift + 3pt } else {
    0pt
  }

  let measure-band = measures.len() * 18pt
  let axis-y = pad-top + head + measure-band + max-row * row-gap
  let foot-base = if tick-list.len() > 0 or has-below {
    tick-label-dy + 14pt
  } else { 8pt }
  let foot = foot-base + (if axis-label != none { 12pt } else { 0pt })

  box(width: pad-left + width + pad-right, height: axis-y + foot, {
    // ── the axis itself, arrowed at both ends ──
    _hrule(pad-left, axis-y, width, _chart-axis)
    _nl-arrow(pad-left + width + 3pt, axis-y, 1, luma(70))
    _nl-arrow(pad-left - 3pt, axis-y, -1, luma(70))

    // ── ticks ──
    for t in tick-list {
      let v = t.at(0)
      let lab = t.at(1, default: none)
      _vrule(px(v), axis-y - 3pt, 6pt, _chart-axis)
      if lab != none {
        _fig-label(px(v), axis-y + tick-label-dy, lab, w: 2.4cm, size: 8pt)
      }
    }

    // ── spans and points ──
    for o in marks {
      let y = axis-y - o.row * row-gap
      if o.kind == "span" {
        let open-left = o.lo == none
        let open-right = o.hi == none
        let x0 = if open-left { pad-left } else { px(o.lo) }
        let x1 = if open-right { pad-left + width } else { px(o.hi) }
        place(dx: x0, dy: y, line(
          start: (0pt, 0pt),
          end: (x1 - x0, 0pt),
          stroke: bar-weight + o.color,
        ))
        if open-left {
          _nl-arrow(pad-left - 3pt, y, -1, o.color)
        } else {
          _nl-dot(x0, y, o.brackets.starts-with("["), o.color)
        }
        if open-right {
          _nl-arrow(pad-left + width + 3pt, y, 1, o.color)
        } else {
          _nl-dot(x1, y, o.brackets.ends-with("]"), o.color)
        }
        if o.label != none {
          _fig-label(
            (x0 + x1) / 2,
            y - label-lift,
            text(fill: o.color, o.label),
          )
        }
      } else {
        _nl-dot(px(o.x), y, o.mark == "closed", o.color)
        if o.label != none {
          let dy = if o.at("side", default: "above") == "below" {
            y + 6pt
          } else { y - label-lift }
          _fig-label(px(o.x), dy, text(fill: o.color, o.label))
        }
      }
    }

    // ── distance measurements, stacked above everything ──
    for (i, m) in measures.enumerate() {
      let y = pad-top + head + i * 18pt
      let x0 = px(m.from)
      let x1 = px(m.to)
      // thin guides down to the axis, so it is unambiguous which
      // points the measurement runs between
      for x in (x0, x1) {
        place(dx: x, dy: y, line(
          start: (0pt, 0pt),
          end: (0pt, axis-y - y),
          stroke: 0.4pt + luma(180),
        ))
      }
      place(dx: x0, dy: y, line(
        start: (0pt, 0pt),
        end: (x1 - x0, 0pt),
        stroke: 0.7pt + m.color,
      ))
      _nl-arrow(x1, y, 1, m.color, size: 3.5pt)
      _nl-arrow(x0, y, -1, m.color, size: 3.5pt)
      if m.label != none {
        _fig-label((x0 + x1) / 2, y - label-lift, text(fill: m.color, m.label))
      }
    }

    if axis-label != none {
      place(
        dx: pad-left,
        dy: axis-y + tick-label-dy + 13pt,
        box(width: width, align(right, text(
          size: 8pt,
          fill: _chart-ink,
          axis-label,
        ))),
      )
    }
  })
})


// ════════════════════════════════════════════════════════════
//  VENN DIAGRAM (two sets)
//
//  Two labeled circles inside a universal-set rectangle, with any
//  combination of regions shaded.
//
//    #venn2("inter")                       // A ∩ B
//    #venn2("a-only")                      // A \ B
//    #venn2("sym-diff")                    // exactly one of the two
//    #venn2("none")                        // blank, for students to
//                                          // shade in themselves
//
//  Region names (aliases in brackets):
//    "a"        all of A            "b"        all of B
//    "inter"    A ∩ B  ["and"]      "union"    A ∪ B  ["or"]
//    "a-only"   A \ B  ["a-not-b"]  "b-only"   B \ A  ["b-not-a"]
//    "sym-diff" exactly one  ["xor"]
//    "outside"  neither  ["complement", "neither"]
//    "none"     nothing             "all"      everything
//
//  Pass an array to shade several at once: #venn2(("a-only", "b-only")).
//
//  layout:
//    "overlap"  (default) the general case
//    "disjoint" mutually exclusive events -- the circles do not meet,
//               and "inter" then correctly shades nothing at all
//    "subset"   B inside A, for B ⊆ A
//
//  values: places content in each region, keyed by region name -- the
//  form probability exercises actually need:
//
//    #venn2("none", values: (
//      a-only: [0.30], inter: [0.10], b-only: [0.25], outside: [0.35],
//    ))
//
//  Only a-only / inter / b-only / outside have a placement point; a
//  value handed to any other key is ignored. Note that "b-only" has no
//  meaningful position under layout: "subset", since that region is
//  empty by construction.
//
//  Set labels default to A and B and the universe to Omega, matching
//  the house probability notation. Pass universe: none to drop the
//  surrounding rectangle.
//
//  IMPLEMENTATION NOTE -- Typst has no boolean path operations, so the
//  lens A ∩ B is built as an explicit polygon tracing one arc of each
//  circle (the same approach koch-star already uses for its outline).
//  Its area agrees with the exact circular-lens formula to within
//  0.1%, and it depends on nothing but polygon() -- rather than on
//  clip:/radius: interactions, which would be harder to reason about
//  and to keep stable across Typst versions. Every other region is
//  then plain overpainting in the background color, which is why `bg`
//  has to match whatever the diagram is sitting on.
// ════════════════════════════════════════════════════════════

// Points along a circular arc, in float points, y measured downward.
#let _v2-arc(cx, cy, r, a0, a1, n: 48) = range(n + 1).map(i => {
  let t = a0 + (a1 - a0) * i / n
  ((cx + r * calc.cos(t)) * 1pt, (cy - r * calc.sin(t)) * 1pt)
})

// The lens where two circles overlap, as a closed polygon. Returns
// none when the circles miss each other, and the smaller circle when
// one contains the other -- so "inter" stays correct under all three
// layouts without the caller having to think about which case applies.
#let _v2-lens(xa, xb, cy, ra, rb) = {
  let d = calc.abs(xb - xa)
  if d >= ra + rb { return none }
  if d <= calc.abs(ra - rb) {
    let cx = if ra < rb { xa } else { xb }
    let r = calc.min(ra, rb)
    return _v2-arc(cx, cy, r, 0deg, 360deg, n: 96)
  }
  let a = (d * d + ra * ra - rb * rb) / (2 * d)
  let b = d - a
  let ta = calc.acos(calc.max(-1.0, calc.min(1.0, a / ra)))
  let tb = calc.acos(calc.max(-1.0, calc.min(1.0, b / rb)))
  // right-hand arc of A, from the top crossing down to the bottom one,
  // then the left-hand arc of B back up, which closes the shape
  let arc-a = _v2-arc(xa, cy, ra, ta, -ta)
  let arc-b = _v2-arc(xb, cy, rb, 180deg + tb, 180deg - tb)
  arc-a + arc-b
}

#let _v2-canon = (
  "and": "inter",
  "or": "union",
  "xor": "sym-diff",
  "complement": "outside",
  "neither": "outside",
  "a-not-b": "a-only",
  "b-not-a": "b-only",
)

#let venn2(
  ..args,
  layout: "overlap",
  labels: ([$A$], [$B$]),
  universe: [$Omega$],
  values: (:),
  width: 8cm,
  fill-color: accent-bg,
  stroke-color: accent,
  bg: white,
) = align(center, {
  let shade = args.pos().at(0, default: "none")
  let asked = if type(shade) == str { (shade,) } else { shade }
  let regions = asked.map(r => _v2-canon.at(r, default: r))
  let on(r) = regions.contains(r) or regions.contains("all")

  let w = width.pt()
  let h = w * 0.62
  let cy = h * 0.53
  // circle geometry per layout, as fractions of the total width
  let geo = if layout == "disjoint" {
    (0.27, 0.73, 0.190, 0.190)
  } else if layout == "subset" {
    (0.47, 0.555, 0.270, 0.130)
  } else { (0.365, 0.635, 0.250, 0.250) }
  let xa = w * geo.at(0)
  let xb = w * geo.at(1)
  let ra = w * geo.at(2)
  let rb = w * geo.at(3)

  let circ-a = _v2-arc(xa, cy, ra, 0deg, 360deg, n: 96)
  let circ-b = _v2-arc(xb, cy, rb, 0deg, 360deg, n: 96)
  let lens = _v2-lens(xa, xb, cy, ra, rb)

  let disc(pts, col) = place(dx: 0pt, dy: 0pt, polygon(
    fill: col,
    stroke: none,
    ..pts,
  ))

  box(width: width, height: h * 1pt, {
    // ── universal set ──
    if universe != none {
      place(dx: 0pt, dy: 0pt, rect(
        width: width,
        height: h * 1pt,
        radius: 2pt,
        fill: if on("outside") { fill-color } else { bg },
        stroke: 0.6pt + luma(150),
      ))
    } else if on("outside") {
      place(dx: 0pt, dy: 0pt, rect(
        width: width,
        height: h * 1pt,
        fill: fill-color,
        stroke: none,
      ))
    }

    // ── shading, painted in dependency order ──
    // Whole-circle regions go down first; the "-only" crescents are
    // then carved back out of them in the background color.
    if on("outside") {
      disc(circ-a, bg)
      disc(circ-b, bg)
    }
    if on("a") or on("union") or on("a-only") or on("sym-diff") {
      disc(circ-a, fill-color)
    }
    if on("b") or on("union") or on("b-only") or on("sym-diff") {
      disc(circ-b, fill-color)
    }
    if lens != none {
      let carve = (
        (on("a-only") and not (on("b") or on("union") or on("inter")))
          or (on("b-only") and not (on("a") or on("union") or on("inter")))
          or (on("sym-diff") and not on("inter"))
      )
      if carve { disc(lens, bg) }
      if on("inter") { disc(lens, fill-color) }
    }

    // ── outlines, always on top of any shading ──
    place(dx: 0pt, dy: 0pt, polygon(
      fill: none,
      stroke: 1pt + stroke-color,
      ..circ-a,
    ))
    place(dx: 0pt, dy: 0pt, polygon(
      fill: none,
      stroke: 1pt + stroke-color,
      ..circ-b,
    ))

    // ── labels, set in the upper-outer part of each circle. The
    //    inset is deliberately well short of the radius: at 0.55 a
    //    bold 10pt glyph reaches the outline on the small circles
    //    (the inner circle under layout: "subset", and both circles
    //    under "disjoint", which are smaller than the "overlap"
    //    ones). 0.42 clears all three with room to spare.
    if universe != none {
      place(dx: 5pt, dy: 4pt, text(size: 9pt, fill: _chart-ink, universe))
    }
    let inset = 0.42
    _fig-label(
      (xa - ra * inset) * 1pt,
      (cy - ra * inset - 5) * 1pt,
      text(weight: "bold", fill: stroke-color, labels.at(0)),
      w: 2cm,
      size: 10pt,
    )
    _fig-label(
      (xb + rb * inset) * 1pt,
      (cy - rb * inset - 5) * 1pt,
      text(weight: "bold", fill: stroke-color, labels.at(1)),
      w: 2cm,
      size: 10pt,
    )

    // ── per-region content ──
    // Under "subset" the intersection IS the inner circle, so its
    // value would land right under the B label. Drop it below centre.
    let centroid = (
      "a-only": (xa - ra * 0.42, cy),
      "b-only": (xb + rb * 0.42, cy),
      "inter": if layout == "subset" {
        (xb, cy + rb * 0.55)
      } else { ((xa + xb) / 2, cy) },
      "outside": (w * 0.10, h * 0.88),
    )
    for (key, body) in values.pairs() {
      let k = _v2-canon.at(key, default: key)
      let p = centroid.at(k, default: none)
      if p != none {
        _fig-label(p.at(0) * 1pt, (p.at(1) - 5) * 1pt, body, w: 2.4cm)
      }
    }
  })
})


// ════════════════════════════════════════════════════════════
//  AREA MODEL
//
//  A rectangle partitioned into labeled sub-rectangles: the picture
//  behind the distributive law and both special products. Three
//  chapters want it (algebra foundations for a·(b+c), (a+b)^2 and
//  a^2-b^2; quadratic for completing the square; powers for a^m·a^n),
//  which is exactly the "same kind of diagram more than once" signal
//  from STYLE_GUIDE §7 -- so it lives here rather than being
//  hand-placed three times.
//
//  Columns and rows are given as (label, size) tuples, where size is
//  a bare number in arbitrary units scaled by `unit`. Cells follow
//  ROW-MAJOR, one per (row, column) pair:
//
//    #area-model(
//      cols: (([$a$], 3), ([$b$], 2)),
//      rows: (([$a$], 3), ([$b$], 2)),
//      [$a^2$],      [$a dot b$],
//      [$a dot b$],  [$b^2$],
//    )
//
//  A cell may be bare content (used as its label), `none` for an
//  empty cell, or area-cell(...) for anything needing its own fill,
//  a colspan, or the "removed" treatment:
//
//    area-cell(label: [$b^2$], removed: true)      // dashed, unfilled
//    area-cell(label: [I], colspan: 2)             // spans 2 columns
//
//  `removed: true` is what makes the difference-of-squares dissection
//  work -- the corner that gets cut away is drawn in place, dashed
//  and unfilled, rather than silently omitted. Students need to see
//  the hole to see the subtraction.
//
//  `colspan:` matters for the same figure: the piece that gets cut
//  off and rotated is one rectangle, and drawing a column line
//  through it would suggest a cut that isn't being made. A row
//  carrying a colspan therefore has fewer items than there are
//  columns -- cells are consumed left to right, not indexed by
//  position.
//
//  Sizes should be roughly proportional to the quantities they stand
//  for, but they are deliberately NOT to scale with any particular
//  numeric value of a and b -- the diagram is a general argument, and
//  a suspiciously exact-looking picture invites students to measure
//  it instead of reasoning about it.
// ════════════════════════════════════════════════════════════

#let area-cell(
  label: none,
  fill: auto,
  removed: false,
  colspan: 1,
  text-color: auto,
) = (
  label: label,
  fill: fill,
  removed: removed,
  colspan: colspan,
  text-color: text-color,
)

#let area-model(
  ..cells,
  cols: (),
  rows: (),
  unit: 0.7cm,
  fill-color: accent-bg,
  stroke-color: accent,
  label-size: 9.5pt,
  dim-size: 9.5pt,
  pad-left: 1.0cm,
  pad-top: 0.55cm,
) = align(center, {
  let items = cells.pos()
  let ncol = cols.len()
  let nrow = rows.len()

  // running offsets, in the same arbitrary units as the tuples
  let xs = (0,)
  for c in cols { xs.push(xs.last() + c.at(1)) }
  let ys = (0,)
  for r in rows { ys.push(ys.last() + r.at(1)) }
  let total-u = xs.last()
  let total-v = ys.last()

  let px(u) = pad-left + unit * u
  let py(v) = pad-top + unit * v

  box(
    width: pad-left + unit * total-u,
    height: pad-top + unit * total-v,
    {
      // Cells are consumed left to right, row by row. A cell with
      // colspan: n covers n columns and swallows their share of the
      // row, so a row carries FEWER items than there are columns --
      // which is why this walks the array sequentially rather than
      // indexing it at i * ncol + j. With every colspan at its
      // default of 1 the two are identical.
      let k = 0
      for i in range(nrow) {
        let j = 0
        while j < ncol {
          let raw = items.at(k, default: none)
          k += 1
          let cell = if raw == none {
            area-cell()
          } else if type(raw) == dictionary and "removed" in raw {
            raw
          } else { area-cell(label: raw) }

          let span = calc.min(cell.at("colspan", default: 1), ncol - j)
          let x0 = px(xs.at(j))
          let y0 = py(ys.at(i))
          let w = unit * (xs.at(j + span) - xs.at(j))
          let h = unit * rows.at(i).at(1)

          place(dx: x0, dy: y0, rect(
            width: w,
            height: h,
            fill: if cell.removed {
              none
            } else if cell.fill == auto { fill-color } else { cell.fill },
            stroke: if cell.removed {
              (paint: luma(150), thickness: 0.8pt, dash: "dashed")
            } else { 0.8pt + stroke-color },
          ))

          if cell.label != none {
            _fig-label(
              x0 + w / 2,
              y0 + h / 2 - 6pt,
              text(
                fill: if cell.text-color == auto {
                  if cell.removed { luma(120) } else { _chart-ink }
                } else { cell.text-color },
                cell.label,
              ),
              w: w,
              size: label-size,
            )
          }

          j += span
        }
      }

      // ── dimension labels: columns above, rows to the left ──
      for (j, c) in cols.enumerate() {
        _fig-label(
          px(xs.at(j)) + unit * c.at(1) / 2,
          pad-top - 14pt,
          text(fill: stroke-color, weight: "bold", c.at(0)),
          w: 3cm,
          size: dim-size,
        )
      }
      // Same non-wrapping treatment as _fig-label, but right-aligned
      // against the grid rather than centered: pad-left is only about
      // 22pt of usable space, and a row label like $a-b$ is wider than
      // that. The inner box() keeps it on one line and lets it extend
      // leftward instead of stacking.
      for (i, r) in rows.enumerate() {
        place(
          dx: 0pt,
          dy: py(ys.at(i)) + unit * r.at(1) / 2 - 6pt,
          box(width: pad-left - 6pt, align(right, box(text(
            size: dim-size,
            fill: stroke-color,
            weight: "bold",
            r.at(0),
          )))),
        )
      }
    },
  )
})





// ── Bar chart (categorical -- bars separated by gaps) ─────────
//
//  #bar-chart(
//    ("Hydro", 29.1), ("Solar", 1.2), ("Wind", 0.1),
//    y-label: [bn. kWh],
//  )
//
//  Categorical data, so the bars are SEPARATED -- the gap is what
//  distinguishes a bar chart from a histogram, and it is a real
//  distinction, not decoration.
//
//  ymin: is the truncated-axis lever. Compare
//    #bar-chart(..., ymin: 0)     honest
//    #bar-chart(..., ymin: 299)   the same data, "twice as good"

#let bar-chart(
  ..bars,
  ymin: 0,
  ymax: auto,
  ystep: auto,
  width: 8cm,
  height: 5cm,
  bar-color: accent,
  colors: none,
  y-label: none,
  gap: 0.3,
  show-values: false,
  show-grid: true,
  pad-left: 1.1cm,
  pad-bottom: 0.9cm,
  pad-top: 0.15cm,
  pad-right: 0.3cm,
) = align(center, {
  let items = bars.pos()
  let n = items.len()
  let values = items.map(it => it.at(1))
  let data-max = calc.max(..values)

  let step = if ystep == auto { _nice-step(data-max - ymin) } else { ystep }
  let hi = if ymax != auto { ymax } else {
    let h = ymin + calc.ceil((data-max - ymin) / step) * step
    if h <= data-max { h + step } else { h }
  }

  // The tallest bar's printed value needs somewhere to sit. Without
  // this it is pushed clean out of the plot area and lands on the
  // y-label. Raising the axis maximum by whole steps keeps the tick
  // grid readable, which merely nudging the label would not.
  if show-values and ymax == auto {
    let guard = 0
    while (
      height * (1 - (data-max - ymin) / (hi - ymin)) < 15pt and guard < 5
    ) {
      hi += step
      guard += 1
    }
  }

  // The y-label gets a reserved band ABOVE the plot rather than
  // sharing airspace with the bars.
  let head = if y-label != none { pad-top + 0.42cm } else { pad-top }

  let total-w = pad-left + width + pad-right
  let total-h = head + height + pad-bottom
  let base = head + height
  let py(v) = head + height * (1 - (v - ymin) / (hi - ymin))
  let slot = width / n

  box(width: total-w, height: total-h, {
    for t in _ticks-from(ymin, hi, step) {
      if show-grid and t > ymin {
        _hrule(pad-left, py(t), width, _chart-grid)
      }
      _label-before(pad-left, py(t) - 5pt, _fmt(t))
    }

    for (i, it) in items.enumerate() {
      let v = it.at(1)
      let col = if colors == none { bar-color } else {
        colors.at(calc.rem(i, colors.len()))
      }
      let bw = slot * (1 - gap)
      let bx = pad-left + i * slot + (slot - bw) / 2
      let bty = py(calc.max(calc.min(v, hi), ymin))
      let bh = base - bty
      if bh > 0pt {
        place(dx: bx, dy: bty, rect(
          width: bw,
          height: bh,
          fill: col,
          stroke: none,
        ))
      }
      if show-values {
        _label-at(
          pad-left + (i + 0.5) * slot,
          bty - 12pt,
          _fmt(v),
          w: slot,
          size: 7.5pt,
        )
      }
      _label-at(
        pad-left + (i + 0.5) * slot,
        base + 4pt,
        it.at(0),
        w: slot,
        size: 7.5pt,
      )
    }

    _hrule(pad-left, base, width, _chart-axis)
    _vrule(pad-left, head, height, _chart-axis)

    if y-label != none {
      place(dx: pad-left + 3pt, dy: pad-top, text(
        size: 8pt,
        fill: _chart-ink,
        y-label,
      ))
    }
  })
})

// ── Histogram (numeric -- bars touch) ────────────────────────
//
//  #histogram(travel-times)                        // sqrt(n) bins
//  #histogram(travel-times, bins: 4)
//  #histogram(travel-times, bin-width: 10, start: 10)
//  #histogram(counts: ((10, 20, 3), (20, 30, 7)))  // from a table
//
//  bins: auto applies the sqrt(n) rule of thumb, so the DEFAULT is
//  the rule the chapter teaches -- and overriding it is exactly the
//  bin-width investigation.
//
//  counts: takes (lo, hi, frequency) triples for the common case
//  where the frequency table is given and the raw data is not.

#let histogram(
  ..args,
  counts: none,
  bins: auto,
  bin-width: none,
  start: auto,
  ymax: auto,
  ystep: auto,
  width: 8cm,
  height: 5cm,
  bar-color: accent,
  y-label: [frequency],
  x-label: none,
  show-grid: true,
  pad-left: 1.1cm,
  pad-bottom: auto,
  pad-top: 0.15cm,
  pad-right: 0.5cm,
) = align(center, {
  let cells = if counts != none { counts } else {
    let data = args.pos().at(0, default: ())
    let n = data.len()
    let lo0 = if start == auto { calc.min(..data) } else { start }
    let hi0 = calc.max(..data)
    // int() on the whole thing, not just the sqrt branch: calc.round
    // returns a FLOAT when given a float, and range() further down
    // demands a genuine integer. Wrapping here also absorbs a caller
    // who writes bins: 4.0.
    let k = int(if bin-width != none {
      calc.max(1, calc.ceil((hi0 - lo0) / bin-width))
    } else if bins == auto {
      calc.max(1, calc.round(calc.sqrt(n)))
    } else { bins })
    let w = if bin-width != none { bin-width } else {
      if hi0 == lo0 { 1 } else { (hi0 - lo0) / k }
    }
    // Half-open bins [edge, next) so no observation is counted twice;
    // the last bin closes on the right so the maximum is included.
    range(k).map(i => {
      let edge = lo0 + i * w
      let nxt = lo0 + (i + 1) * w
      let c = data
        .filter(x => (
          x >= edge
            and (
              if i == k - 1 { x <= nxt } else {
                x < nxt
              }
            )
        ))
        .len()
      (edge, nxt, c)
    })
  }

  let freqs = cells.map(c => c.at(2))
  let data-max = calc.max(..freqs)
  let step = if ystep == auto { _nice-step(data-max) } else { ystep }
  let hi = if ymax != auto { ymax } else {
    let h = calc.ceil(data-max / step) * step
    if h <= data-max { h + step } else { h }
  }

  let xlo = cells.first().at(0)
  let xhi = cells.last().at(1)

  let head = if y-label != none { pad-top + 0.42cm } else { pad-top }
  // Bin-edge labels take one 8pt line; an x-label goes on a SECOND
  // line below them, never sharing the first.
  let foot = if pad-bottom != auto { pad-bottom } else {
    18pt + (if x-label != none { 12pt } else { 0pt })
  }

  let total-w = pad-left + width + pad-right
  let total-h = head + height + foot
  let base = head + height
  let py(v) = head + height * (1 - v / hi)
  let px(v) = pad-left + width * (v - xlo) / (xhi - xlo)

  box(width: total-w, height: total-h, {
    for t in _ticks-from(0, hi, step) {
      if show-grid and t > 0 { _hrule(pad-left, py(t), width, _chart-grid) }
      _label-before(pad-left, py(t) - 5pt, _fmt(t))
    }

    for c in cells {
      let bx = px(c.at(0))
      let bw = px(c.at(1)) - bx
      let bty = py(c.at(2))
      let bh = base - bty
      if bh > 0pt {
        place(dx: bx, dy: bty, rect(
          width: bw,
          height: bh,
          fill: bar-color,
          stroke: 0.6pt + white,
        ))
      }
    }

    for e in cells.map(c => c.at(0)) + (xhi,) {
      _label-at(px(e), base + 4pt, _fmt(e), size: 7.5pt)
    }

    _hrule(pad-left, base, width, _chart-axis)
    _vrule(pad-left, head, height, _chart-axis)

    if y-label != none {
      place(dx: pad-left + 3pt, dy: pad-top, text(
        size: 8pt,
        fill: _chart-ink,
        y-label,
      ))
    }
    if x-label != none {
      place(
        dx: pad-left,
        dy: base + 18pt,
        box(width: width, align(right, text(
          size: 8pt,
          fill: _chart-ink,
          x-label,
        ))),
      )
    }
  })
})

// ── Dotplot (one dot per observation, stacked) ───────────────
//
//  #dotplot((12, 9, 23, 10, 10, 8, 35, 9, 2, 14))
//
//  The most honest small-data display there is: every single
//  observation stays individually visible, so nothing is hidden by a
//  choice of bin. Worth showing next to the histogram of the same
//  data for exactly that reason.

#let dotplot(
  ..args,
  xmin: auto,
  xmax: auto,
  step: auto,
  width: 9cm,
  dot-radius: 3pt,
  dot-gap: 8pt,
  dot-color: accent,
  x-label: none,
  pad-left: 0.9cm,
  pad-right: 0.9cm,
  pad-top: 0.3cm,
  pad-bottom: auto,
) = align(center, {
  let data = args.pos().at(0, default: ())

  let tally = (:)
  for x in data {
    let k = str(x)
    tally.insert(k, tally.at(k, default: 0) + 1)
  }
  let stack-max = calc.max(..tally.values())

  let lo = if xmin == auto { calc.min(..data) } else { xmin }
  let hi = if xmax == auto { calc.max(..data) } else { xmax }
  let tick-step = if step == auto {
    _nice-step(hi - lo, target: 8)
  } else { step }

  let height = stack-max * dot-gap + dot-radius
  // tick numbers on one line, x-label on the next
  let foot = if pad-bottom != auto { pad-bottom } else {
    20pt + (if x-label != none { 12pt } else { 0pt })
  }
  let total-w = pad-left + width + pad-right
  let total-h = pad-top + height + foot
  let base = pad-top + height
  let px(v) = pad-left + width * (v - lo) / (hi - lo)

  box(width: total-w, height: total-h, {
    for x in data.dedup().sorted() {
      for j in range(tally.at(str(x))) {
        place(
          dx: px(x) - dot-radius,
          dy: base - (j + 1) * dot-gap,
          circle(radius: dot-radius, fill: dot-color, stroke: none),
        )
      }
    }

    _hrule(pad-left, base, width, _chart-axis)

    for t in _ticks-from(lo, hi, tick-step) {
      _vrule(px(t), base, 4pt, _chart-axis)
      _label-at(px(t), base + 6pt, _fmt(t))
    }

    if x-label != none {
      place(
        dx: pad-left,
        dy: base + 20pt,
        box(width: width, align(right, text(
          size: 8pt,
          fill: _chart-ink,
          x-label,
        ))),
      )
    }
  })
})

// ── Boxplot (one or several, sharing one axis) ───────────────
//
//  #boxplot(("Antonia", (9.5, 11, 9, 10, 10.5)),
//           ("Lars",    (13, 7, 6, 15, 9)))
//
//  Each series is ("Label", data-array) -- the five-number summary
//  and the outliers get computed -- or ("Label", (min: .., q1: ..,
//  med: .., q3: .., max: .., outliers: (..))) when only the summary
//  is known. That second form matters: reading a boxplot BACK off a
//  printed figure is its own exercise type, and those exercises have
//  no underlying dataset to hand.
//
//  whiskers: "tukey"  -- whiskers reach the most extreme observation
//                        still within 1.5 x IQR of the quartile;
//                        anything past that is drawn as its own
//                        point. NOTE this is the correct rule: the
//                        whisker ends at a REAL DATA VALUE, not at
//                        the fence itself.
//  whiskers: "minmax" -- whiskers reach the true minimum and
//                        maximum, nothing marked as an outlier (the
//                        textbook's convention).
//
//  method: passes through to quartiles-of, so one figure can show
//  the two quartile conventions disagreeing on identical data.

#let _box-summary(spec, whiskers: "tukey", method: "exclusive") = {
  if type(spec) == dictionary {
    (
      q1: spec.q1,
      med: spec.med,
      q3: spec.q3,
      lo: spec.at("min", default: spec.q1),
      hi: spec.at("max", default: spec.q3),
      outliers: spec.at("outliers", default: ()),
    )
  } else {
    let f = five-number(spec, method: method)
    if whiskers == "minmax" {
      (q1: f.q1, med: f.med, q3: f.q3, lo: f.min, hi: f.max, outliers: ())
    } else {
      let low-fence = f.q1 - 1.5 * f.iqr
      let high-fence = f.q3 + 1.5 * f.iqr
      let inside = spec.filter(x => x >= low-fence and x <= high-fence)
      (
        q1: f.q1,
        med: f.med,
        q3: f.q3,
        lo: calc.min(..inside),
        hi: calc.max(..inside),
        outliers: spec.filter(x => x < low-fence or x > high-fence).sorted(),
      )
    }
  }
}

#let boxplot(
  ..series,
  xmin: auto,
  xmax: auto,
  xstep: auto,
  whiskers: "tukey",
  method: "exclusive",
  width: 9cm,
  box-height: 0.75cm,
  row-gap: 0.5cm,
  box-color: accent,
  fill-color: accent-bg,
  outlier-color: warn-col,
  label-width: 2cm,
  x-label: none,
  pad-right: 0.6cm,
  pad-top: 0.3cm,
  pad-bottom: auto,
) = align(center, {
  let items = series.pos()
  let sums = items.map(it => _box-summary(
    it.at(1),
    whiskers: whiskers,
    method: method,
  ))

  let spread = ()
  for s in sums { spread += (s.lo, s.hi) + s.outliers }
  let raw-lo = calc.min(..spread)
  let raw-hi = calc.max(..spread)
  let margin = (raw-hi - raw-lo) * 0.08
  let lo = if xmin == auto { raw-lo - margin } else { xmin }
  let hi = if xmax == auto { raw-hi + margin } else { xmax }
  let tick-step = if xstep == auto {
    _nice-step(hi - lo, target: 6)
  } else { xstep }

  let n = items.len()
  let plot-h = n * box-height + calc.max(0, n - 1) * row-gap
  // 0.25cm down to the axis, then one line of tick numbers, then the
  // x-label on its own line below those.
  let foot = if pad-bottom != auto { pad-bottom } else {
    0.25cm + 20pt + (if x-label != none { 12pt } else { 0pt })
  }
  let total-w = label-width + width + pad-right
  let total-h = pad-top + plot-h + foot
  let px(v) = label-width + width * (v - lo) / (hi - lo)

  box(width: total-w, height: total-h, {
    for (i, sum) in sums.enumerate() {
      let row-top = pad-top + i * (box-height + row-gap)
      let mid = row-top + box-height / 2

      _hrule(px(sum.lo), mid, px(sum.q1) - px(sum.lo), 0.8pt + box-color)
      _hrule(px(sum.q3), mid, px(sum.hi) - px(sum.q3), 0.8pt + box-color)
      _vrule(
        px(sum.lo),
        row-top + box-height * 0.2,
        box-height * 0.6,
        0.8pt + box-color,
      )
      _vrule(
        px(sum.hi),
        row-top + box-height * 0.2,
        box-height * 0.6,
        0.8pt + box-color,
      )

      place(dx: px(sum.q1), dy: row-top, rect(
        width: px(sum.q3) - px(sum.q1),
        height: box-height,
        fill: fill-color,
        stroke: 0.9pt + box-color,
      ))
      _vrule(px(sum.med), row-top, box-height, 1.4pt + box-color)

      for o in sum.outliers {
        place(dx: px(o) - 2.5pt, dy: mid - 2.5pt, circle(
          radius: 2.5pt,
          fill: none,
          stroke: 0.9pt + outlier-color,
        ))
      }

      _label-before(label-width, mid - 6pt, items.at(i).at(0), size: 9pt)
    }

    let ay = pad-top + plot-h + 0.25cm
    _hrule(label-width, ay, width, _chart-axis)
    for t in _ticks-from(lo, hi, tick-step) {
      _vrule(px(t), ay, 4pt, _chart-axis)
      _label-at(px(t), ay + 6pt, _fmt(t))
    }

    if x-label != none {
      place(
        dx: label-width,
        dy: ay + 20pt,
        box(width: width, align(right, text(
          size: 8pt,
          fill: _chart-ink,
          x-label,
        ))),
      )
    }
  })
})
