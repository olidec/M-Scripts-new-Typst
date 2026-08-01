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
    split-chapters.py <main.typ> <built.pdf> <outdir> <level>

e.g. split-chapters.py src/units/algebra-functions/main-high.typ \\
                       dist/algebra-functions/main-high.pdf \\
                       dist/algebra-functions high

Requires pypdf (pip install pypdf).
"""

import re
import sys
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
# One per line, each trimmed line starting with `("` -- the same
# convention build.sh relies on. Captures (label, path).
#
# NOTE: the first element is a SHORT LABEL, not the chapter title. In
# this project "Foundations" refers to a chapter headed "Algebra
# Foundations", and "Quadratics" to one headed "Quadratic Functions and
# Equations". So the label cannot be matched against the PDF outline --
# we read each chapter's real level-1 heading out of its own .typ file
# instead. The label is only used in messages.
ENTRY_RE = re.compile(r'^\s*\(\s*"([^"]*)"\s*,\s*"([^"]*)"')

# The chapter's own title: the first level-1 heading in the file.
HEADING_RE = re.compile(r"^=\s+(\S.*?)\s*$")

# Fallback: the title passed to chapter-template.
TEMPLATE_TITLE_RE = re.compile(r'chapter-template\.with\(\s*title:\s*"([^"]*)"')

# Typst prefixes outline titles with the heading number, e.g.
# "3 Linear Functions". Strip a leading dotted number group.
NUMBER_PREFIX_RE = re.compile(r"^\s*[\d]+(?:\.[\d]+)*\.?\s+")


def read_registered_chapters(main_typ):
    """[(label, bare-chapter-name), ...] in document order."""
    out = []
    for line in Path(main_typ).read_text(encoding="utf-8").splitlines():
        m = ENTRY_RE.match(line)
        if m:
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
    return NUMBER_PREFIX_RE.sub("", s).strip().casefold()


def match_chapters(registered, outline, chapter_dir):
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

    Returns [(bare_name, outline_title, start_page)] in document order.
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
        return [
            (bare, outline[i][0], outline[i][1])
            for i, (_, bare) in enumerate(registered)
        ]

    for label, bare in unresolved:
        print(f"  (warning: no chapter heading found in the PDF outline "
              f"for {bare}.typ (listed as '{label}') -- skipping)")

    for i, (_, raw, page) in enumerate(norm_outline):
        if i not in used:
            print(f"  (note: top-level heading {raw!r} on page {page + 1} "
                  f"is not a registered chapter -- not split out)")

    matched.sort(key=lambda t: t[2])
    return matched


def split(main_typ, pdf_path, outdir, level):
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
            f"       headings are not marked bookmarked: false."
        )

    # Chapter files sit next to the main file, as build.sh assumes
    # for its own relative imports.
    chapters = match_chapters(registered, outline,
                              Path(main_typ).parent)
    if not chapters:
        sys.exit("error: no chapters could be matched to outline entries")

    outdir = Path(outdir)
    outdir.mkdir(parents=True, exist_ok=True)

    written = 0
    for i, (bare, title, start) in enumerate(chapters):
        # Runs up to the page before the next chapter starts.
        end = chapters[i + 1][2] - 1 if i + 1 < len(chapters) else n_pages - 1

        if end < start:
            # The next chapter begins on this very page -- they share it.
            end = start
            print(f"  (note: '{title}' shares a page with the chapter "
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


def main(argv):
    if len(argv) != 4:
        sys.exit(__doc__.strip())
    split(*argv)


if __name__ == "__main__":
    main(sys.argv[1:])