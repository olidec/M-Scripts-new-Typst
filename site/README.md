# Course website

Publishes the Typst course materials as a static site. No PDF is ever
committed: every deploy rebuilds each pinned git ref from source and
writes the result under `/v/<ref-slug>/`.

## Layout

```
site/
  classes.yml          the manifest — the only file you edit routinely
  build-refs.sh        compiles every pinned ref into the deploy tree
  build_site.py        generates the HTML from the manifest + built PDFs
  templates/           Jinja templates (one class page set per class)
  static/style.css
  content/
    admin.md                     shown on every class's Admin tab
    classes/<class-id>/admin.md  appended for that class only
.github/workflows/deploy.yml
```

Add `dist/`, `_site/` and `.refs/` to `.gitignore`.

## One-time setup

1. Put a `.typst-version` file at the repo root containing just the
   version you build with, e.g. `0.13.1`. `build-refs.sh` reads it from
   *each checked-out ref*, so an old snapshot keeps rendering the way it
   did when you froze it. Refs without the file fall back to
   `DEFAULT_TYPST_VERSION` in `build-refs.sh` — keep that in sync.

2. Enable Pages: repository → Settings → Pages → Source: GitHub Actions.
   Note that Pages from a **private** repo needs a paid GitHub plan. If
   you'd rather not pay, Cloudflare Pages builds from a private repo on
   the free tier and runs the same workflow steps.

3. If this is a project site (`user.github.io/REPO` rather than a custom
   domain), set `site.base_path: "/REPO"` in `classes.yml`. Every
   generated link is prefixed with it.

4. Add a repository secret named `CLASS_PASSWORDS` containing a JSON
   object keyed by class id:

   ```json
   {"4a-glf": "kepler-2026", "3b-spf": "hyperbola-2026"}
   ```

   The workflow refuses to publish a page listed in `protect:` if this
   secret is missing, rather than shipping it in the clear.

## Running it locally

```bash
pip install jinja2 pyyaml markdown pypdf
./site/build-refs.sh _site .refs          # compiles every pinned ref
python3 site/build_site.py --refs-dir .refs --site _site
python3 -m http.server -d _site 8000
```

Encryption is a workflow step only; locally the protected pages render
in plain HTML so you can read them.

`build_site.py --strict` exits non-zero if anything was missing. Useful
once the manifest has settled; noisy while units are still in progress.

## Everyday operations

**A new unit is ready for a class** — add its folder name to that class's
year list in `classes.yml`. Give it a display title under `units:` if the
folder name isn't presentable. Push.

**A sheet is due, release the solutions** — remove the unit from that
class's `withhold_solutions`. A withheld booklet is *deleted* from the
deploy tree, not merely unlinked, so there's no guessable URL either. If
two classes share a ref and only one withholds, the file stays and the
generator warns.

**End of semester, freeze a class** —

```bash
git tag snap/2026-hs
git push --tags
```

then change that class's `ref:` from `main` to `snap/2026-hs` and push.
Its pages stop moving. Two classes pinned to the same tag cost one build,
not two — the artifacts live under the ref, and class pages only link
into them.

**Exam dates** — edit the `exams:` list. Entries are sorted by date, so
order in the file doesn't matter.

## How the generator decides what to show

It never assumes; it looks. After the build it inspects
`_site/v/<ref>/<unit>/` and links what is actually there. That's what
makes SPF-only units work with no special-casing: `conic-sections` has no
`main-basic.typ`, so a GLF class simply gets nothing for it and a warning
in the log.

Chapter order and titles come from the source at that ref — the ordered
`register_chapters(...)` list in `main-<level>.typ` gives the sequence,
and each chapter file's own `chapter-template(title: ...)` gives the
display name. Both are parsed as plain text, exactly as `build.sh`'s
splitter does, so the same three formatting rules apply: one entry per
line, literal paths, within 80 columns.

## The one change worth making in `preamble.typ`

Print the ref onto the PDF footer, so a student's printout identifies
itself:

```typ
#let build-version = sys.inputs.at("version", default: "draft")
```

and put `build-version` in the page footer. Feeding it in takes one line
in `build.sh` — add to the flags array:

```bash
TYPST_FLAGS=(--root "$PROJECT_ROOT" --diagnostic-format short)
[[ -n "${BUILD_VERSION:-}" ]] && TYPST_FLAGS+=(--input "version=$BUILD_VERSION")
```

`build-refs.sh` already runs each ref in its own subshell, so exporting
`BUILD_VERSION="$ref"` before the `./build.sh` calls is all that's left.
When someone says "my sheet doesn't have exercise 12," that stamp is how
you find out why in ten seconds rather than ten minutes.
