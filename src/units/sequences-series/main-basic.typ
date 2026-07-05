// ============================================================
//  main-basic.typ — Sequences & Series, FOUNDATIONS level
//  Compile with:  typst compile main-basic.typ
//
//  Chapters are listed once below. Heading numbers follow the
//  list order automatically. To add/reorder, edit the list only.
//  Format: ("Chapter Title", "filename")
// ============================================================

#import "../../common/preamble.typ": *

// ── Level switch: Foundations ────────────────────────────────
#set-level("basic")

// ── Chapter list (single source of truth) ────────────────────
#register_chapters(
  ("Basics of Sequences and Series",      "/src/units/sequences-series/ch-basics"),
  ("Arithmetic Sequences and Series",     "/src/units/sequences-series/ch-arithmetic"),
  ("Geometric Sequences and Series",      "/src/units/sequences-series/ch-geometric"),
)

// ── Base typography ──────────────────────────────────────────
#set text(font: "New Computer Modern", size: 11pt, lang: "en")
#set par(justify: true, leading: 0.7em)
#set heading(numbering: "1.1")

// ── Title page ───────────────────────────────────────────────
#set page(..chapter-page-setup, header: none, footer: none, numbering: none)

#align(center)[
  #v(4cm)
  #text(size: 28pt, weight: "bold")[Sequences & Series]
  #v(0.5em)
  #text(size: 16pt, fill: accent)[Foundations]
  #v(0.5em)
  #text(size: 13pt, fill: luma(80))[Lecture Notes]
  #v(3cm)
  #line(length: 60%, stroke: 1pt + accent)
  #v(1cm)
  #text(size: 11pt, fill: luma(80))[#datetime.today().display("[year]")]
]

#pagebreak()

// ── Table of contents ────────────────────────────────────────
#set page(numbering: "i", ..chapter-page-setup)
#counter(page).update(1)
#outline(depth: 2, indent: 1.5em)
#pagebreak()

// ── Chapters ─────────────────────────────────────────────────
#set page(numbering: "1")
#counter(page).update(1)

#include_chapters()
