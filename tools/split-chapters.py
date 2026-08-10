#!/usr/bin/env python3
"""
split-chapters.py -- cut a built main-*.pdf into one PDF per chapter,
without recompiling and without disturbing the page numbering.

Why this exists
---------------
The old `build.sh chapters` mode compiled each chapter standalone, with
a generated wrapper that reset the heading counter. That produced
correctly *numbered* chapters, but each one was compiled in isolation:
cross-references to other chapters dangled, and a chapter that assumed
material from earlier in the unit read oddly on its own.

Splitting the finished book instead means every chapter PDF is a literal
excerpt of the real thing. Page numbers, heading numbers, exercise
numbers and internal layout are whatever the full document produced,
because they ARE the full document.

How it finds the chapters
-------------------------
Typst writes a PDF outline (bookmarks) from the document headings, so
the top level of that outline is exactly the list of chapters. We read
it with pypdf and resolve each entry to a page index. No source markers,
no `typst query`, no parsing of the PDF text.

To decide what to *call* each file, the script reads the same
register_chapters(...) list out of the level's main-*.typ that build.sh
uses, and matches each registered title against the outline entries.
Matching by title rather than by position means a stray top-level
heading in the front matter (a preface, an appendix) is skipped
gracefully instead of shifting every filename by one.

Usage
-----
    split-chapters.py <main.typ> <built.pdf> <outdir> <level> [-v]

e.g. split-chapters.py src/units/algebra-functions/main-high.typ \\
                       dist/algebra-functions/main-high.pdf \\
                       dist/algebra-functions high

-v / --verbose always prints the outline-vs-wanted-titles table. That
table is printed automatically whenever a chapter fails to match, which
is the only situation in which anyone needs it.

Exit status
-----------
    0   every registered chapter was written
    1   nothing could be split at all, OR at least one registered
        chapter was skipped

A skipped chapter is an error, not a warning: a unit's chapter list and
its headings are both under our control, so a mismatch always means one
of the two is wrong. build.sh reports it and carries on to the other
level rather than aborting the build.

Requires pypdf (pip install pypdf).
"""

import re
import sys
import unicodedata
from pathlib import Path

try:
    import pypdf
except ImportError:
    # Name the interpreter that failed. Without this the message is
    # actively misleading when pypdf IS installed -- just into a
    # different Python than the one running this file, which is the
    # normal situation when the script is launched from an editor's
    # Run button or a non-activated shell rather than through build.sh.
    sys.exit(
        f"error: pypdf is not importable by this interpreter:\n"
        f"           {sys.executable}\n"
        f"       Install it there:\n"
        f"           {sys.executable} -m pip install pypdf\n"
        f"       Or run the script with the project venv instead:\n"
        f"           .venv/bin/python {sys.argv[0]} ...\n"
        f"       (build.sh picks up ./.venv automatically; if you are\n"
        f"        running this file directly from an editor, check which\n"
        f"        interpreter that editor is configured to use.)"
    )


# register_chapters entries look like:
#     ("Foundations", "/src/units/algebra-functions/ch-algebra-foundations"),
#
# THIS MUST NOT BE PARSED LINE BY LINE. The previous version required
# each entry to sit on one line beginning with `("`, and that is not
# something the source is free to guarantee: typstyle reflows any entry
# past the 80-column limit onto separate lines,
#
#     (
#       "Arithmetic Sequences and Series",
#       "/src/units/sequences-series/ch-arithmetic",
#     ),
#
# at which point a line-based parser stops seeing it. In a unit with
# long chapter titles that hits only SOME entries -- sequences-series
# formats its first entry to 78 columns and the rest to 81-87 -- so the
# list silently truncates after chapter 1 rather than failing outright.
# Matching across newlines inside the register_chapters(...) call makes
# the parser indifferent to formatting, which is the only sane contract
# when the file is under a format-on-save formatter.
#
# NOTE: the first element is a SHORT LABEL, not the chapter title. In
# this project "Foundations" refers to a chapter headed "Algebra
# Foundations", and "Quadratics" to one headed "Quadratic Functions and
# Equations". So the label cannot be matched against the PDF outline --
# we read each chapter's real level-1 heading out of its own .typ file
# instead. The label is only used in messages.
ENTRY_RE = re.compile(r'\(\s*"([^"]*)"\s*,\s*"([^"]*)"')

# Fallback when the register_chapters(...) call cannot be delimited:
# search the whole file, but demand a root-absolute path as the second
# string so no other tuple in a main file can be mistaken for an entry.
LOOSE_ENTRY_RE = re.compile(r'\(\s*"([^"]*)"\s*,\s*"(/[^"]*)"')

# The chapter's own title: the first level-1 heading in the file.
HEADING_RE = re.compile(r"^=\s+(\S.*?)\s*$")

# Fallback: the title passed to chapter-template.
TEMPLATE_TITLE_RE = re.compile(r'chapter-template\.with\(\s*title:\s*"([^"]*)"')

# Typst prefixes outline titles with the heading number, e.g.
# "3 Linear Functions". Strip a leading dotted number group.
NUMBER_PREFIX_RE = re.compile(r"^\s*[\d]+(?:\.[\d]+)*\.?\s+")

# Typst source escapes that survive into HEADING_RE's capture but not
# into the rendered PDF text. The house style uses \u{2011} (a
# non-breaking hyphen) in $x$-prefixed compounds, so a heading is one
# stylistic tweak away from carrying one.
UNICODE_ESCAPE_RE = re.compile(r"\\u\{([0-9A-Fa-f]+)\}")


def strip_comments(text):
    """Drop whole-line // comments.

    Only whole-line ones: a trailing comment could contain a "//" that
    is really part of a URL, and truncating there would corrupt the
    line. A commented-OUT entry is always written as a full-line
    comment, which is the case that actually matters.
    """
    return "\n".join(
        line for line in text.splitlines()
        if not line.lstrip().startswith("//")
    )


def register_block(text):
    """The source of the register_chapters(...) call, parens balanced.

    Returns None if the call is absent or unterminated, in which case
    the caller falls back to scanning the whole file.
    """
    i = text.find("register_chapters")
    if i < 0:
        return None
    j = text.find("(", i)
    if j < 0:
        return None
    depth = 0
    for k in range(j, len(text)):
        if text[k] == "(":
            depth += 1
        elif text[k] == ")":
            depth -= 1
            if depth == 0:
                return text[j:k + 1]
    return None


def read_registered_chapters(main_typ):
    """[(label, bare-chapter-name), ...] in document order.

    Formatting-independent: entries are found inside the balanced
    register_chapters(...) call, so it makes no difference whether an
    entry occupies one line or four.
    """
    text = strip_comments(Path(main_typ).read_text(encoding="utf-8"))
    block = register_block(text)
    if block is not None:
        found = ENTRY_RE.finditer(block)
    else:
        found = LOOSE_ENTRY_RE.finditer(text)

    out = []
    for m in found:
        label, path = m.group(1), m.group(2)
        bare = path.rsplit("/", 1)[-1]
        if bare.endswith(".typ"):
            bare = bare[:-4]
        out.append((label, bare))
    return out


def read_chapter_title(chapter_dir, bare):
    """The chapter's own level-1 heading, which is what Typst puts in
    the PDF outline. Returns None if the file is missing or headingless.
    """
    path = Path(chapter_dir) / f"{bare}.typ"
    if not path.is_file():
        return None
    text = path.read_text(encoding="utf-8")
    for line in text.splitlines():
        m = HEADING_RE.match(line)
        if m:
            return m.group(1)
    m = TEMPLATE_TITLE_RE.search(text)
    return m.group(1) if m else None


def read_top_level_outline(reader):
    """[(title, page_index), ...] for depth-0 outline entries only.

    reader.outline nests sub-headings as inner lists, so anything that
    is not a bare item at the top of the structure is a subsection and
    is ignored -- which is exactly the chapter/section distinction we
    want.
    """
    entries = []
    for item in reader.outline:
        if isinstance(item, list):
            continue  # nested = subsections of the previous chapter
        try:
            page = reader.get_destination_page_number(item)
        except Exception as exc:  # unresolvable destination
            print(f"  (warning: cannot resolve outline entry "
                  f"{item.title!r}: {exc})")
            continue
        entries.append((str(item.title), page))
    return entries


def normalize(s):
    """Fold a title down to something that compares equal across the
    Typst-source / rendered-PDF boundary.

    Beyond stripping the heading number and case, this decodes \\u{...}
    escapes and flattens the characters that differ invisibly between
    the two sides: every Unicode dash to "-", curly quotes to straight,
    non-breaking and other exotic spaces to a single ordinary space.
    Every one of those is a mismatch you cannot see by reading the two
    strings next to each other, which is the worst kind to debug.
    """
    s = UNICODE_ESCAPE_RE.sub(lambda m: chr(int(m.group(1), 16)), s)
    s = unicodedata.normalize("NFKC", s)
    out = []
    for ch in s:
        cat = unicodedata.category(ch)
        if cat == "Pd":                       # any dash/hyphen
            out.append("-")
        elif ch in "\u2018\u2019\u02bc":      # curly / modifier apostrophes
            out.append("'")
        elif ch in "\u201c\u201d":            # curly double quotes
            out.append('"')
        elif cat == "Zs" or ch in "\u00a0\u202f\u2009":
            out.append(" ")
        else:
            out.append(ch)
    s = "".join(out)
    s = NUMBER_PREFIX_RE.sub("", s)
    return " ".join(s.split()).casefold()


def report_titles(registered, outline, chapter_dir, matched_bares):
    """Print what the PDF offered against what the sources asked for.

    Shown on any failure, because "no chapters could be matched" on its
    own tells you nothing about WHICH of the two sides is wrong.
    """
    print("  --- top-level outline entries in the PDF ---")
    if not outline:
        print("      (none)")
    for title, page in outline:
        print(f"      p.{page + 1:<4} {title!r}")
    print("  --- level-1 headings wanted, from the chapter sources ---")
    for label, bare in registered:
        title = read_chapter_title(chapter_dir, bare)
        state = "matched" if bare in matched_bares else "NO MATCH"
        shown = repr(title) if title is not None else "(no heading found)"
        print(f"      [{state:>8}] {bare + '.typ':<24} {shown}")
    print("  --- comparison is on the normalized forms ---")
    print("      (heading number, case, dash and quote shape and "
          "whitespace are all folded before comparing)")


def match_chapters(registered, outline, chapter_dir, verbose=False):
    """Pair each registered chapter with its outline entry.

    Primary strategy: read each chapter's own level-1 heading from its
    .typ file and match that against the outline text. This is exact,
    and it tolerates extra top-level headings in the front or back
    matter -- a preface or appendix is reported and skipped rather than
    shifting every subsequent filename by one.

    Fallback: if titles cannot be read (files moved, headings built
    dynamically) but the counts agree, pair them up in document order
    and say so. Better than failing outright, but noisy on purpose,
    because a silent positional match is exactly how filenames get
    quietly attached to the wrong chapter.

    Returns (chapters, skipped) where chapters is
    [(bare_name, outline_title, start_page)] in document order.
    """
    norm_outline = [(normalize(t), t, p) for t, p in outline]
    used, matched, unresolved = set(), [], []

    for label, bare in registered:
        title = read_chapter_title(chapter_dir, bare)
        if title is None:
            unresolved.append((label, bare))
            continue

        want = normalize(title)
        hit = None
        for i, (nt, raw, page) in enumerate(norm_outline):
            if i in used:
                continue
            if nt == want:
                hit = (i, raw, page)
                break
        if hit is None:
            unresolved.append((label, bare))
            continue
        used.add(hit[0])
        matched.append((bare, hit[1], hit[2]))

    # Positional fallback, only when nothing matched at all.
    if not matched and unresolved and len(registered) == len(outline):
        print("  (warning: could not match any chapter heading by title; "
              "falling back to document order)")
        print("  (check that each chapter file's '= Heading' matches the "
              "PDF outline, and that register_chapters lists them in "
              "document order)")
        report_titles(registered, outline, chapter_dir, set())
        return [
            (bare, outline[i][0], outline[i][1])
            for i, (_, bare) in enumerate(registered)
        ], []

    for label, bare in unresolved:
        print(f"  (ERROR: no matching level-1 heading in the PDF outline "
              f"for {bare}.typ (listed as '{label}') -- NOT split out)")

    unregistered = 0
    for i, (_, raw, page) in enumerate(norm_outline):
        if i not in used:
            unregistered += 1
            print(f"  (note: top-level heading {raw!r} on page {page + 1} "
                  f"is not a registered chapter -- not split out)")

    # One unregistered heading is a preface or an appendix and is fine.
    # Several, with a chapter list shorter than the outline, means the
    # list was not read properly -- which is what a formatter reflowing
    # register_chapters(...) used to cause. Say so, rather than leaving
    # a row of mild-looking "note:" lines to be read as normal.
    if unregistered > 1 and len(registered) < len(outline):
        print(f"  (ERROR: only {len(registered)} entr"
              f"{'y' if len(registered) == 1 else 'ies'} parsed out of "
              f"register_chapters(...), but the PDF has {len(outline)} "
              f"top-level headings.")
        print(f"          If the unit really has more chapters than "
              f"that, the chapter list is")
        print(f"          not being read correctly -- check that every "
              f"entry is a literal")
        print(f"          (\"Title\", \"/root/absolute/path\") pair with no "
              f"#let shortcut.)")

    if unresolved or verbose:
        report_titles(registered, outline, chapter_dir,
                      {b for b, _, _ in matched})

    matched.sort(key=lambda t: t[2])
    return matched, unresolved


def split(main_typ, pdf_path, outdir, level, verbose=False):
    reader = pypdf.PdfReader(pdf_path)
    n_pages = len(reader.pages)

    registered = read_registered_chapters(main_typ)
    if not registered:
        sys.exit(f"error: no register_chapters entries found in {main_typ}")

    outline = read_top_level_outline(reader)
    if not outline:
        sys.exit(
            f"error: {pdf_path} has no PDF outline, so chapter starts "
            f"cannot be located.\n"
            f"       Typst normally writes one from the headings; check "
            f"that the chapter\n"
            f"       headings are not marked bookmarked: false, and that "
            f"the PDF is the\n"
            f"       book itself rather than an exercise sheet (sheet mode "
            f"suppresses\n"
            f"       headings, so a sheet PDF genuinely has no outline)."
        )

    # Chapter files sit next to the main file, as build.sh assumes
    # for its own relative imports.
    chapters, skipped = match_chapters(registered, outline,
                                       Path(main_typ).parent, verbose)
    if not chapters:
        sys.exit("error: no chapters could be matched to outline entries")

    # BOUNDARIES COME FROM THE WHOLE OUTLINE, NOT FROM THE MATCHED
    # CHAPTERS ONLY.
    #
    # This used to read `chapters[i + 1][2] - 1`, i.e. "run until the
    # next chapter I managed to match". When one chapter failed to
    # match -- a renamed heading, a stray character, anything -- its
    # pages were not dropped: they were silently absorbed into the file
    # for the chapter BEFORE it. The output then looked perfectly
    # healthy (right number of files, plausible page counts, exit
    # status 0) while one PDF quietly contained two chapters and one
    # chapter was missing entirely. Ending at the next top-level
    # outline entry instead means an unmatched chapter's pages are left
    # out of every file, which is both correct and immediately visible.
    all_starts = sorted({p for _, p in outline})

    outdir = Path(outdir)
    outdir.mkdir(parents=True, exist_ok=True)

    written = 0
    for bare, title, start in chapters:
        later = [p for p in all_starts if p > start]
        end = (later[0] - 1) if later else n_pages - 1

        if end < start:
            # Two top-level headings on one page -- they share it.
            end = start
            print(f"  (note: '{title}' shares a page with the heading "
                  f"that follows; the shared page appears in both files)")

        writer = pypdf.PdfWriter()
        for p in range(start, end + 1):
            writer.add_page(reader.pages[p])

        # Give the excerpt its own bookmark so the chapter title still
        # shows in a PDF viewer's sidebar.
        writer.add_outline_item(title, 0)

        out_path = outdir / f"{bare}-{level}.pdf"
        with open(out_path, "wb") as fh:
            writer.write(fh)

        pages = end - start + 1
        print(f"  split {out_path}  (pp. {start + 1}-{end + 1}, "
              f"{pages} page{'s' if pages != 1 else ''})")
        written += 1

    print(f"  {written} chapter file(s) from {pdf_path}")

    if skipped:
        names = ", ".join(f"{b}.typ" for _, b in skipped)
        print(f"  (ERROR: {len(skipped)} registered chapter(s) not "
              f"written: {names})")
        return 1
    return 0


def main(argv):
    verbose = False
    args = []
    for a in argv:
        if a in ("-v", "--verbose"):
            verbose = True
        else:
            args.append(a)
    if len(args) != 4:
        sys.exit(__doc__.strip())
    return split(*args, verbose=verbose)


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
