# Style Guide — Gymnasium Muttenz Math Materials (Typst)

This document captures the conventions, structures, and pedagogical design
established for the reworked course materials, so a new chat/project can
pick them up without re-deriving them. Upload this file alongside
`preamble.typ`, `build.sh`, `.gitignore`, `.vscode/settings.json` and
`.vscode/tasks.json`, the two Lehrplan PDFs, and one finished chapter per
unit as Project Knowledge.

## 1. Context

- Teacher of math and computer science at a Swiss Gymnasium (Muttenz).
  Classes are taught as English-medium immersion.
- Two curriculum levels, both governed by the official Lehrplan:
  - **GLF** (Grundlagenfach / Foundations) — `set-level("basic")`
  - **SPF** (Schwerpunktfach / Advanced) — `set-level("high")`
  - SPF has more instructional time and covers everything GLF does, plus
    topics GLF never sees (complex numbers, conic sections) and more depth
    on shared topics (e.g. induction/proof technique, vectors, stochastics).
  - Practical rule of thumb: if a topic is SPF-only, wrap it in
    `#only-high[...]` (theory) or pass `level: "high"` to `exercise()`.
    Shared topics need no wrapping at all — that's the default.
  - In practice, GLF and SPF year 1 use *largely the same chapter list* —
    the extra SPF depth mostly lives as `#only-high[...]` content inside
    shared chapters, not as separate chapters taught earlier. Don't assume
    a topic listed as "SPF year 1" in the Lehrplan means SPF gets a whole
    extra chapter that year; check actual teaching order first.
- Materials are migrating from LaTeX to **Typst**. Preferred language:
  American English, Typst syntax throughout.
- Units written or in progress so far:
  - **Sequences & Series** (`sequences-series`): `ch-basics`,
    `ch-arithmetic`, `ch-higher-order` (SPF-only), `ch-geometric`,
    `ch-proofs` (SPF-only).
  - **Algebra & Functions** (`algebra-functions`), covering roughly all of
    year 1's algebra/function content: `ch-algebra-foundations`,
    `ch-functions-intro`, `ch-linear`, `ch-systems`, `ch-quadratic` are
    taught in that order, identically for GLF and SPF, in year 1.
    `ch-powers` (which opens with the exponent-law arithmetic prelude —
    see below), `ch-exponential`, and `ch-logarithms` are **SPF-only in
    year 1** — registered in that unit's `main-high.typ` but deliberately
    omitted from `main-basic.typ` (this is the whole-chapter-exclusion
    mechanism: which main file registers a chapter decides who sees it
    and when, not a content-level wrapper like `only-high[...]`). GLF
    sees those three chapters later, not as part of year 1's
    algebra-functions block. Polynomials are deliberately **out of
    scope** here entirely — they're revisited later as a
    functions-repetition warm-up right before the calculus unit, not as
    part of this algebra/functions rework.
  - Future units (not yet started): trigonometry, descriptive statistics,
    vectors, complex numbers (SPF-only), conic sections (SPF-only),
    calculus, inferential statistics.

### Where exponent-law arithmetic lives, and why it moved

Exponent-law arithmetic (integer/negative/fractional exponent laws, the
two derivation investigations) was originally drafted as part of
`ch-algebra-foundations`, on the reasoning that it's a general algebra
skill rather than specifically about power *functions*. That turned out
to be wrong once `ch-powers` itself turned out to be SPF-year-1-only
(GLF Lehrplan explicitly places "Potenz- und Logarithmengesetze" in
2. Klasse, not 1. Klasse) — `only-high[...]` only suppresses content
*within* a chapter both tracks read the same year; it can't let GLF pick
the content back up in a *different* year, since GLF's year-2 main file
can't cherry-pick just the `only-high` parts of a chapter it would
otherwise be re-reading in full. The only mechanism that supports "GLF
sees this content later" is chapter-level exclusion — a separate file,
registered independently per level (see above) — so the exponent-law
material moved out of `ch-algebra-foundations` and became the opening
section of `ch-powers` instead, gated the same SPF-year-1/GLF-year-2 way
as the rest of that chapter.

## 2. Pedagogical philosophy (drives *what* gets written, not just *how*)

Core conviction: *access to knowledge is not the same as knowledge.* Six
challenges the materials are designed around:

1. **Countering fatalism about math ability** — levels-of-abstraction
   framing + guaranteed-success entry points + visible struggle modeling.
2. **Critical AI literacy** — role-constrained, evaluative AI tasks
   ("grade the AI," "catch the false proof"), never open-ended
   "solve this for me" prompts.
3. **Managing laptop/concentration issues** — short work sprints with
   visible deliverables; regulate *mode* of device use, not medium.
4. **Curiosity vs. grade-chasing** — ungraded explorations that
   explicitly promise to resurface on a graded exam; grade the oral
   defense of open work, not just the artifact.
5. **Persistence** — model genuine live struggle; name heuristics
   explicitly so "being stuck" comes with a repertoire of moves.
6. **Look-aheads** — spiral the curriculum forward: a special case
   students already grasp intuitively (natural-number powers before
   power *functions*; eyeballing a parabola's steepness before formal
   derivatives) gets named and connected explicitly to the topic that
   will formalize it later, so that later lesson lands as recognition
   ("oh, this is that thing again, properly") rather than pure novelty.
   Distinct from an *exploration* (guided discovery of something new
   right now) — a look-ahead's job is to plant a flag students will
   recognize when they reach it, sometimes chapters or even years
   later. Use `look-ahead(preview:)` in `preamble.typ`, and name the
   destination by **topic**, never by chapter number — numbers shift
   with `register_chapters` include order (see §3), so a hardcoded
   "see Chapter 6" would silently go stale the moment content is
   reordered.

A structural corollary worth naming: the same *template* should recur
across function-family chapters (linear, quadratic, power, exponential,
...) — investigate, classify, transform, model — so that once a student
has been through one such chapter, the shape of the next one is already
familiar even though the algebra inside differs. The recurrence itself is
the connective tissue between chapters; it doesn't need to be manufactured
separately via cross-references.

### Planned look-aheads (not yet written)

A running list, so a good idea doesn't get lost between when it's
proposed and when the relevant chapter actually gets written:

- **`ch-quadratic`**: use the discriminant to estimate/calculate a
  parabola's slope at a point, previewing derivatives — possibly have
  students eyeball slopes first (steeper vs. shallower, positive vs.
  negative) before any calculation, as an intuition anchor for the
  calculus unit's formal treatment of instantaneous rate of change.

## 3. Directory architecture

The project spans multiple units across multiple years and two levels, so
source is organized by *topic*, and separately, reading order is organized
by *year*. A chapter file never knows what year or level it will be read
in — that's decided entirely by whichever `main-*.typ` or `years/*.typ`
file includes it.

```
project-root/
  build.sh
  .gitignore
  .vscode/
    settings.json
    tasks.json
  src/
    common/
      preamble.typ
      images/                       (cross-unit shared assets, if any)
    units/
      algebra-functions/
        ch-algebra-foundations.typ
        ch-functions-intro.typ
        ch-linear.typ
        ch-systems.typ
        ch-quadratic.typ
        ch-powers.typ
        ch-exponential.typ
        ch-logarithms.typ
        images/
        main-basic.typ              main-high.typ
        exercises-basic.typ         exercises-high.typ
        solutions-basic.typ         solutions-high.typ
      sequences-series/
        ch-basics.typ, ch-arithmetic.typ, ch-higher-order.typ,
        ch-geometric.typ, ch-proofs.typ
        images/
        main-basic.typ, main-high.typ, exercises-*.typ, solutions-*.typ
      trigonometry/, stochastics-descriptive/, vectors/, calculus/, ...
    years/
      glf-y1.typ    glf-y2.typ    glf-y3.typ    glf-y4.typ
      spf-y1.typ    spf-y2.typ    spf-y3.typ    spf-y4.typ
  dist/                              (generated, gitignored)
```

- **Unit-scoped documents** (`main-basic.typ`, `main-high.typ`,
  `exercises-basic.typ`, `exercises-high.typ`, `solutions-basic.typ`,
  `solutions-high.typ`) are what you actually hand students week to
  week. Each is built and numbered independently.
- **Year-level documents** (`years/glf-y1.typ`, etc.) span multiple units
  in one document — e.g. Algebra & Functions, then Trigonometry, then
  Descriptive Statistics, in teaching order. These are optional archival
  binders/planning references, not something built by default (see §6).
  The same chapter file can be included by more than one year file at
  different times (e.g. `ch-powers.typ` could be read by SPF in year 1
  and by GLF in year 2) with no forking and no manual renumbering — Typst's
  heading counter numbers chapters by include order, wherever that happens.

### The "part" system (multi-unit documents only)

`register_chapters` entries take either shape:

```typst
("Title", "/root/absolute/path/filename")                 // unit-scoped document
("Title", "/root/absolute/path/filename", "Part Name")    // multi-unit document
```

When a `part` is given and differs from the previous entry's part,
`include_chapters()` inserts a full-page divider (`part-divider(...)`) and
updates the page header to show that part name instead of the fixed
`subject-name` constant. Unit-scoped documents never set a part and the
header falls back to `subject-name` exactly as before — this is fully
backward compatible with every existing unit.

### Path resolution — filenames must be root-absolute

This is a real Typst gotcha, not a style preference, and it will produce
a confusing `failed to load file (access denied)` or `file not found`
error if skipped: **Typst resolves every file path relative to the file
where the path-taking call is textually written — not relative to
whichever file called the surrounding function.** `include_chapters()`'s
`#include` call (and `read-chapter-files()`'s `read()` call) are both
written inside `preamble.typ` itself (living in `src/common/`), so a bare
relative filename like `"ch-basics"` passed into `register_chapters`
would resolve against `src/common/` and fail — regardless of which
`main-*.typ` registered it. **Every filename must therefore be
root-absolute** (start with `/`, resolved against whatever `--root` the
compiler is given — see §8 for why `--root` itself must point at the
project root).

Two different conventions apply depending on who reads the file back:

- **A unit's own `main-basic.typ` / `main-high.typ`** get re-read by
  `read-chapter-files()` (from that unit's `exercises-*.typ` and
  `solutions-*.typ`), and that function parses the file as **plain
  text**, pattern-matching literal quoted strings — it does not evaluate
  Typst expressions. So every entry's path must be written out in full,
  e.g. inside `src/units/sequences-series/main-high.typ`:
  ```typst
  #register_chapters(
    ("Basics", "/src/units/sequences-series/ch-basics"),
    ("Arithmetic", "/src/units/sequences-series/ch-arithmetic"),
  )
  ```
  A `#let unit = "/src/..."` shortcut would break silently here —
  `read-chapter-files()` would only recover the bare suffix after the
  `+` (e.g. `"ch-basics"`), losing the root-absolute prefix, and
  whichever file called it would then hit this exact same problem itself.
- **Anything not read back by `read-chapter-files()`** — currently only
  the multi-unit `years/*.typ` binders — can safely use a `#let`
  shortcut, since nothing re-parses these as text:
  ```typst
  #let af = "/src/units/algebra-functions/"
  #register_chapters(
    ("Algebra Foundations", af + "ch-algebra-foundations", "Algebra & Functions"),
  )
  ```

This same rule is why `fig()` (§7) takes an already-loaded image rather
than a bare filename — the same class of bug, one more place it bites.

### Numbering-scope note

`ex-counter` is global *to whatever gets compiled together*, not global
across the whole project. A unit's own `solutions-basic.typ` numbers
exercises starting at 1 for that compilation; a year-level binder that
also includes that unit will very likely show different exercise numbers
for the same content, because other units contribute exercises before it
in that compilation. This is expected — treat unit booklets and year
binders as two independent numbering schemes and never cross-reference
"exercise N" between them.

## 4. Preamble environments and when to use them

All defined in `src/common/preamble.typ`, imported via
`#import "../../common/preamble.typ": *` from a unit file, or
`#import "../common/preamble.typ": *` from a year file (path depends on
how many directory levels deep the importing file sits — see §3).

**`set-subject-name("...")` is mandatory in every unit-scoped entry
file** — `main-basic.typ`, `main-high.typ`, `exercises-basic.typ`,
`exercises-high.typ`, `solutions-basic.typ`, `solutions-high.typ` —
right after the import:
```typst
#import "../../common/preamble.typ": *
#set-subject-name("Algebra & Functions")
#set-level("basic")
```
The header shows whichever name that document's own call declared;
there is no global default tied to any particular unit (the fallback,
`"Untitled Unit"`, is a deliberately obvious placeholder rather than a
plausible-looking wrong answer — if you see it, a `set-subject-name(...)`
call is missing from that file). Each of the six entry files is a
separate compilation, so Typst state doesn't carry over between
them — the call has to be repeated in each one, not just the first.
Year-level binders (`years/*.typ`) don't need this: the header there is
driven by each `register_chapters` entry's `part` label instead (§3).

| Environment | Purpose | Suppressed in |
|---|---|---|
| `theorem(title:)`, `definition(title:)`, `example(title:)`, `remark()`, `warning()`, `proof()` | Standard theory boxes | sheet + solutions mode |
| `keybox(title:)` | Highlighted key idea/formula, no counter | sheet + solutions mode |
| `quotebox()` | Neutral gray callout for stories/quotations | sheet + solutions mode |
| `only-theory[...]` | Prose/headings that vanish on the exercise sheet | sheet + solutions mode |
| `only-high[...]` / `only-basic[...]` | SPF-only / GLF-only theory | opposite level, + sheet/solutions |
| `exercise(chapter:, level:, difficulty:, time:, hints:)[question][solution]` | The core exercise environment | — (renders differently per mode) |
| `print-hints()` | Prints staged hints; call **once per chapter, before solutions exist anywhere** | sheet mode |
| `ai-box(role:, on-sheet:)[...]` | Role-constrained AI task (roles: Explainer / Checker / Generator / Tutor) | solutions mode always; sheet unless `on-sheet: true` |
| `exploration(title:)[...]` | Ungraded discovery task; auto-appends "one exam problem may grow out of this" | sheet + solutions mode |
| `look-ahead(title:, preview:)[...]` | Names a known special case as an instance of a topic covered formally later; `preview:` names the destination topic | sheet + solutions mode |
| `toolbox()` / `heuristic("...")` | Pólya-style problem-solving moves; print `toolbox()` once early, then badge solutions with `heuristic(...)` | sheet + solutions mode |
| `known-techniques(title:, ..items)` | Running "here's your toolkit so far" recap of specific methods (e.g. equation-solving techniques); call again with a growing list as new methods get taught, under its own `==` heading (a checkpoint moment, not an aside) — pair with a short refresher exercise | sheet + solutions mode |
| `objectives(..items)` with `obj(bfkm:, level:)[...]` / `bfkm(level:)[...]` | Chapter-opening learning-objectives box tied to the Lehrplan; `bfkm[...]` items get a BfKM badge + auto-legend; `level:` filters items per document like `exercise()`'s `level:` | sheet + solutions mode |
| `vocab(en, de, show-de:)` / `print-vocab()` | Immersion glossary: mark a term inline (bold EN + small gray "(dt. _DE_)"), collect it, print alphabetized EN–DE table once at chapter end; dedupes by English term | inline rendering everywhere; recording + table suppressed in sheet + solutions mode |
| `num(x)` | Swiss number formatting `12'345.5` — safe in text AND math mode (see §6; never type `'` in math yourself) | — |
| `abstraction-ladder(l0:, l1:, l2:, l3:)` | Situation → Data → Pattern → Formula figure; use whenever a situation is formalized | (figure suppressed like other `only-theory` content) |
| `data-table(columns:, ...)` | Worksheet-style fill-in table | — |
| `system(..eqs)` | System of equations, bounded by vertical bars, aligned at `=`; `eqs` are `($lhs$, $rhs$)` tuples, any number of rows — see §6 for the full explanation and the `#` sigil requirement | — |
| `dot-triangle`, `domino-row`, `koch-star`, `nested-squares` | Native-shape figures (no external packages) | wrapped in `only-theory` |
| `register_chapters(...)` / `include_chapters()` | Chapter registry; supports an optional `part` for multi-unit documents (see §3) | — |
| `part-divider(title)` | Full-page divider between parts in a multi-unit document; called automatically by `include_chapters()` | — |

**Exercise difficulty & pacing:** every `exercise()` can carry
`difficulty: 1–3` (dot rating, shown in notes AND on the sheet),
`time: "20 min"` (prints a "being stuck is normal" note), and
`hints: (...)` (staged hints, revealed one at a time via `print-hints()`
at the chapter's end — never inline, never adjacent to the solution).
Every exercise set should open with a 1-dot problem.

**Learning objectives:** every chapter opens with an `objectives()` box,
placed right after the chapter's opening prose and before the first
section heading. Phrase items as competencies ("solve...", "explain...",
"decide..."), mirroring the Lehrplan's "Die Schülerinnen und Schüler
können" formulations, and tag every item that implements a
Lehrplan-BfKM competency with `bfkm[...]` — the box doubles as the
coverage audit trail against the official curriculum. Items exclusive
to one level take `obj(level: "high")[...]` (or `"basic"`) inside the
*same* call — don't wrap the whole box in `only-high[...]`; one call
serves both documents. `obj()`/`bfkm()` return plain dictionaries and
are only meaningful inside `objectives(...)` — never use them bare in
prose.

**Vocabulary (immersion support):** the first time a chapter introduces
a technical term, write it as `#vocab("slope", "Steigung")` — bold
English inline, German gloss in small gray, and the pair is recorded.
End every chapter with `#print-hints()` followed by `#print-vocab()`
(hints belong to the exercises, the glossary closes the chapter). Later
mentions: plain text, or `show-de: false` to keep the bold without
repeating the gloss — duplicates are harmless either way, since
`print-vocab()` dedupes by English term. Pick the German term your
students will actually meet in other subjects and German references
(e.g. *Nullstelle*, not a literal translation of "root").
`chapter-template` resets both the hint and vocab stores at chapter
start, so a forgotten `print-*()` call costs that chapter its own
printout but can never leak entries into the next chapter.

## 5. Rendering modes (three, mutually exclusive per document)

- **Lecture notes** (`main-basic.typ` / `main-high.typ`): theory + exercises,
  no solutions, hints deferred to end of chapter.
- **Exercise sheet** (`exercises-basic.typ` / `exercises-high.typ`,
  landscape): exercises only, one per page, blank space to work.
  **Two sheets are required**, for exactly the same reason as the two
  solutions booklets below: sheet mode respects `level:` like every
  other mode (the old show-everything override is gone), so each
  sheet's exercise numbering matches its level's solutions booklet —
  but only if it reads its chapter list from the *matching* main file
  via `read-chapter-files(from:)`. This also fixes chapter selection:
  the GLF sheet no longer carries pages for chapters GLF doesn't read
  that year (e.g. `ch-powers` in year 1). Each sheet page shows a
  "Foundations"/"Advanced" tag next to the exercise number so the two
  printed stacks stay tellable apart. *Migration:* rename an existing
  `exercises.typ` to `exercises-high.typ`, pass
  `level: "high"` explicitly to `exercise-sheet-template.with(...)`,
  and add `exercises-basic.typ` as its sibling.
- **Solutions booklet** (`solutions-basic.typ` / `solutions-high.typ`):
  numbers + solutions only, question shown in small gray for orientation.
  **Two booklets are required** — GLF and SPF number exercises differently
  since SPF-only exercises are skipped in GLF, so numbering only stays in
  sync if each booklet reads its chapter list from the matching main file
  (`read-chapter-files(from: "main-*.typ")`).

## 6. Typst formula conventions (house style)

**Multiplication dots** — insert an explicit `dot` in exactly these cases,
and *only* these cases:
- Two adjacent variables/algebraic symbols: `a b` → `a dot b`,
  `a_1 q^(n-1)` → `a_1 dot q^(n-1)`.
- A number or variable directly touching a parenthesis (either order):
  `2(n-1)` → `2 dot (n-1)`, `n (n+1)` → `n dot (n + 1)`,
  `(k-1) d` → `(k - 1) dot d`.
- Two adjacent parenthesized expressions: `(a-4)(3a+1)` →
  `(a - 4) dot (3 a + 1)`.

**Never** add a dot for:
- A plain coefficient directly before a bare variable: `5n`, `2 a_1`,
  `3 n^2` stay as-is (standard convention).
- A number/variable before a **function keyword** (`sqrt`, `log`, `sin`,
  `cos`, `abs`, `exp`, `ln`, `lim`, custom `limn`): `2 sqrt(2)`,
  `s sqrt(3)`, `log a_1` stay as-is — the trailing parenthesis belongs to
  the function call, not to a second multiplicative factor.
- Point/segment/sequence-of-terms labels: `A S` (segment AS), `P_0 P_1 P_2`
  (a sequence of points) are names, not products — never dot these.

**Subscripts and superscripts** — Typst's `_` and `^` bind only the single
next token. A single digit or letter (`a_1`, `s_n`, `x^2`) is fine as-is.
**Any multi-character subscript or superscript must be wrapped in
parentheses**: `a_20` → `a_(20)`, `s_133` → `s_(133)`, `x^12` → `x^(12)`.
This is a recurring bug class worth grepping for after writing new content:
`grep -noE '[a-zA-Z]_[0-9]{2,}'` (and the analogous pattern with `^`) with
no surrounding parentheses.

**Numbers — Swiss formatting via `num()`** — house convention is the
Swiss format: apostrophe as thousands separator, period as decimal
separator (`1'000`, `12'345.5`). **Never type the apostrophe by hand in
math mode** — `$12'000$` parses the `'` as a *prime* and renders
12′000. Always go through the `num()` helper in `preamble.typ`, which
builds the grouped number as a plain string in code mode (string
content interpolated into math is inserted as literal text, so the
apostrophe arrives as a character, not math syntax). It works
identically in text and math mode:
```typst
The population reached #num(86402) by 1950.        // text mode
$ s_(100) = #num(338350) $                          // math mode
#num(12345.5)                                       // → 12'345.5
```
Grouping starts at 4 digits (`1000` → `1'000`); the decimal part is
never grouped. Don't pass years or other label-like numbers (2026,
postal codes) through `num()` — grouping is for quantities, not names.
Numbers under 1'000 don't need `num()` at all. When drafting, a quick
`grep -noE "[0-9]{4,}"` over new content catches raw ungrouped
quantities (expect false positives from years and exercise data you've
deliberately left plain — it's a review aid, not a hard rule).

**Graph bounds** — when choosing `xmin:`/`xmax:`/`ymin:`/`ymax:` for
`plot-graph()`/`plot()` calls at the default `grid-step: 1`, prefer
values ending in `.5` rather than whole integers, e.g. `xmin: -3.5,
xmax: 4.5` rather than `xmin: -3, xmax: 4`. With integer bounds, the
outermost gridline lands exactly on the plot box's border, so the grid
and the border visually merge; a half-unit margin keeps them distinct
and gives the curve some breathing room. (If a graph uses a non-default
`grid-step`, the same idea applies — aim for the bound to sit at the
midpoint between two gridlines, not exactly on one.)

**Non-breaking hyphen for single-letter compounds** — terms like
`$x$-intercept`, `$y$-axis`, `$x$-coordinate` have a plain ASCII hyphen
sitting right after the closing `$` of the math-mode letter, which
Typst is free to break the line on — leaving an orphaned single letter
like "$y$-" at the end of a line. Use the Unicode non-breaking hyphen
instead: `$y$\u{2011}intercept` renders identically but is never a
break point. Applies to any `$x$-...`/`$y$-...` construction; doesn't
matter for ordinary multi-letter compound words (`well-known` breaking
normally is fine — it's specifically the single-character prefix that
looks bad stranded on its own line).

**Systems of equations — use `system()`, everywhere a system appears**
— `preamble.typ` provides `system(..eqs)`, where each argument is a
2-tuple `($lhs$, $rhs$)`. It renders every system — whether a fully
displayed block or a compact item inside an exercise's `parts()` —
bounded by vertical bars, one equation per row, aligned at `=`:
```typst
$ #system(($5x + 3y$, $9$), ($2x - 4y$, $14$)) $
```
Works for any number of equations (2, 3, or more — not just square
systems). Note the `#` sigil: per Typst's own math documentation, a
`#`-prefixed call is a normal code-mode function call even when
written inside a `$ ... $` block, so its arguments follow normal
code-mode tuple syntax rather than math mode's comma/semicolon-merging
rules — which is exactly what's needed, since each argument is a
genuine 2-element tuple, not just juxtaposed math content. Unlike the
original "reserve this for displayed blocks only" guidance, the
house decision is now to use it for *every* system, including compact
exercise items — the visual weight is worth it for clearly signaling
"this is a system," even in a short list.

Internally `system()` is `math.mat(delim: "|", ..rows)`, built by
mapping each `(lhs, rhs)` tuple to a 3-cell row `(lhs, "=", rhs)` and
spreading the resulting array of rows — confirmed via Typst's own
documented pattern for programmatic matrix construction
(`mat(..#range(1,5).chunks(2))`), not guessed at. If you ever need a
system Typst can't express as clean tuples (e.g. an equation with its
own internal alignment), fall back to writing `mat(delim: "|", ...)`
by hand at that one call site — `system()` covers the common case, not
every conceivable one.

## 7. Images and graphics

Default to a **native Typst figure** in `preamble.typ`
(`dot-triangle`, `domino-row`, `koch-star`, `nested-squares`, or a new
helper in the same spirit) whenever a diagram can be drawn from basic
shapes — coordinate grids, simple function sketches, transformation
diagrams. These compile offline, never go stale, and don't need a file at
all. If you find yourself hand-coding the same kind of diagram more than
once, that's a signal to promote it to a reusable helper in
`preamble.typ` rather than let near-duplicate image files accumulate.

Reach for an actual image file only for the genuine exceptions:
photographs, screenshots, complex GeoGebra/Desmos exports not worth
hand-coding, or scanned figures.

**Location:** an `images/` subfolder inside the relevant unit, next to
that unit's chapter files:

```
src/units/algebra-functions/
  ch-linear.typ
  images/
    linear-transformation-example.png
```

This has to be per-unit rather than global or per-chapter because Typst
resolves any non-absolute path (in `#image()`, `#read()`, `#include`, and
`#import` alike) **relative to the file the reference appears in** — the
same rule that already makes `../../common/preamble.typ` resolve correctly
from inside a unit's `main-basic.typ`. An `#image("images/....png")` call
written inside `ch-linear.typ` therefore resolves the same way whether
that chapter is compiled standalone, included by `main-basic.typ`, or
pulled transitively into a `years/glf-y1.typ` binder sitting three
directories away — the path always follows the chapter file's own
location, not whatever included it.

For assets shared across more than one unit (e.g. a school logo), use
`src/common/images/` instead, next to `preamble.typ`.

**Naming convention:** `<description-with-hyphens>.<ext>`, all lowercase,
no `ch-` prefix (the folder already implies which chapter), and never
named after an exercise number — exercise numbers shift as content gets
reordered, and a stale filename that no longer matches its exercise is
hard to catch later. Good: `linear-transformation-example.png`,
`quadratic-vertex-sketch.svg`. Avoid: `ex03.png`, `fig1.png`.

**Using `fig()`:** `preamble.typ` provides `fig(body, caption:)` to center
a figure and add an optional caption below it — but it takes an
**already-loaded image**, not a filename:
```typst
#fig(image("images/linear-transformation-example.png", width: 80%))
#fig(image("images/quadratic-vertex-sketch.svg", width: 60%), caption: [
  Shifting the parabola 2 units left and 1 unit up.
])
```
The `#image(...)` call has to be written directly in the chapter file
itself, not inside `fig()`. An earlier version of `fig()` tried to take a
bare filename and hardcode the `"images/"` prefix internally — that
doesn't work, for the same path-resolution reason covered in §3: since
`fig()` is defined in `preamble.typ` (in `src/common/`), an `#image(...)`
call written inside it would always look in `src/common/images/`, never
the calling chapter's own `images/` folder.

## 8. Build system

`build.sh` lives at the project root (a sibling of `src/` and `dist/`) and
is unit/year-aware:

```
./build.sh unit <unit-name> <full|chapters|exercises|solutions|all>
./build.sh year <year-name|all>
./build.sh all              # "all" for every unit — NEVER touches years/
./build.sh list              # shows units and year files it can see
```

- `full` builds `main-basic.typ` + `main-high.typ`; `exercises` builds
  **both** sheets (`exercises-basic.typ` + `exercises-high.typ`,
  mirroring how `solutions` handles its two booklets — the old
  single-`exercises.typ` behavior is gone); `solutions` builds
  both booklets; `chapters` builds every chapter standalone, once per
  level (`<chapter>-basic.pdf` / `<chapter>-high.pdf`), with correct
  chapter-heading numbering via a throwaway wrapper file (generated next
  to the chapter so relative imports resolve identically to
  `main-*.typ`, then deleted immediately after compiling).
- Year-level builds are **always opt-in** (`./build.sh year ...`) and are
  deliberately excluded from `./build.sh all`, per the numbering-scope
  note in §3.
- The `chapters` mode determines each level's chapter list by scanning
  that level's `main-*.typ` for `register_chapters(...)` entries. This
  assumes the established convention of **one entry per line, each
  trimmed line starting with `("`** — reformatting an entry across
  multiple lines will make the script silently miss it.
- Compiles with `--diagnostic-format short` so the VS Code problem
  matcher (defined inline in `.vscode/tasks.json`, since custom matchers
  can't be referenced by name outside an extension) can jump to
  file:line:column on error.
- **Always compiles with `--root <project-root>`.** Without an explicit
  `--root`, Typst defaults the project root to the directory containing
  whichever file is being compiled — not the repo root — so any `../`
  import that climbs out of that directory (e.g. a chapter's
  `#import "../../common/preamble.typ"`) gets rejected with
  `failed to load file (access denied)`, not a real permissions problem.
  `build.sh` computes the project root from its own file location
  (`PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"`) so this
  is correct regardless of the caller's cwd. If you ever invoke `typst`
  directly rather than through `build.sh` or the VS Code tasks, pass
  `--root` yourself — see §3 for the root-absolute-path convention this
  also depends on.
- `.vscode/tasks.json` also provides quick single-file compile/watch
  tasks for fast proofreading — useful while drafting, but note that a
  standalone-file compile does **not** reflect that chapter's real
  heading number; use `Build Unit... → chapters` for that.
- `.gitignore` excludes `dist/` wholesale and the transient `_wrapper-*.typ`
  files, but deliberately does *not* blanket-ignore `*.pdf` (reference
  PDFs kept in the repo, e.g. the Lehrplan documents, should stay
  tracked) and does *not* ignore `.vscode/settings.json` /
  `.vscode/tasks.json` (shared project config, not personal preference).

## 9. What to upload to a new project

1. `preamble.typ` (the shared engine — always needed)
2. `Lehrplan_Mathematik_GLF.pdf` and `Lehrplan_Mathematik_SPF.pdf`
   (curriculum source of truth)
3. This file (`STYLE_GUIDE.md`)
4. One finished chapter per unit as a worked example (`ch-geometric.typ`
   for sequences & series is a good choice — it exercises nearly every
   environment: ladder, exploration, both AI-box roles, staged hints,
   data tables)
5. `build.sh`, `.gitignore`, `.vscode/settings.json`, `.vscode/tasks.json`
   if the new project will also handle tooling questions

Project-level custom instructions (short version, paste into the
project's "instructions" field): *"Multi-unit Swiss Gymnasium math course
materials, GLF (Foundations) and SPF (Advanced) levels, written in Typst.
Follow the conventions in STYLE_GUIDE.md exactly, especially the
multiplication-dot rules, the subscript/superscript parenthesization
rule, the per-unit directory layout, and the images/ convention. Prefer
American English."*
