#!/usr/bin/env python3
"""Generate the class website from classes.yml and the built PDFs.

Run this AFTER build-refs.sh has produced <site>/v/<ref-slug>/<unit>/.

    python3 site/build_site.py --refs-dir .refs --site _site

What it does, in order:

  1. Reads site/classes.yml.
  2. Deletes any solutions booklet that is withheld by every class
     using that (ref, unit) pair — so there is no guessable URL,
     not merely no link.
  3. Walks each class's units, discovering which PDFs actually
     exist rather than assuming.  A missing file is reported and
     skipped, which is what makes SPF-only units (no main-basic)
     work with no special-casing.
  4. Renders one page set per class from the templates.
  5. Writes _encrypt.json listing the pages that the workflow
     should hand to StatiCrypt.

Chapter order and titles come from the source at that ref: the
ordered register_chapters(...) list in main-<level>.typ gives the
sequence, and each chapter file's own chapter-template(title: ...)
gives the display name.  Both are parsed as plain text, exactly as
build.sh's splitter does.
"""

from __future__ import annotations

import argparse
import json
import secrets
import re
import shutil
import sys
from dataclasses import dataclass, field
from pathlib import Path

import markdown as md
import yaml
from jinja2 import Environment, FileSystemLoader, select_autoescape

HERE = Path(__file__).resolve().parent

# One registry entry per line, each trimmed line starting with (" —
# the convention build.sh documents and STYLE_GUIDE.md §3 enforces.
CHAPTER_ENTRY = re.compile(r'^\(\s*"([^"]*)"\s*,\s*"([^"]*)"\s*\)\s*,?\s*$')
CHAPTER_TITLE = re.compile(r'chapter-template\.with\(\s*title:\s*"([^"]*)"')

DOC_KINDS = (
    ("notes", "main", "Lecture notes", "NOTES"),
    ("exercises", "exercises", "Exercise sheet", "EX"),
    ("solutions", "solutions", "Solutions", "SOL"),
)

LEVEL_LABEL = {"basic": "GLF", "high": "SPF"}

warnings: list[str] = []


def warn(msg: str) -> None:
    warnings.append(msg)
    print(f"  warning: {msg}", file=sys.stderr)


def ref_slug(ref: str) -> str:
    """URL-safe form of a git ref: snap/2026-hs -> snap-2026-hs."""
    return re.sub(r"[^A-Za-z0-9._-]+", "-", ref).strip("-") or "ref"


# Lowercase alphanumerics minus the characters people misread when
# copying a link off a whiteboard: 0/o, 1/l/i. 31 symbols, so 8 of them
# is about 8.5e11 combinations — far past guessable, still typable.
SLUG_ALPHABET = "abcdefghjkmnpqrstuvwxyz23456789"


def random_slug(prefix: str = "", length: int = 8) -> str:
    tail = "".join(secrets.choice(SLUG_ALPHABET) for _ in range(length))
    return f"{prefix}-{tail}" if prefix else tail


def human_size(path: Path) -> str:
    kb = path.stat().st_size / 1024
    if kb >= 1024:
        return f"{kb/1024:.1f} MB"
    return f"{kb:.0f} kB" if kb >= 1 else "<1 kB"


# ---- data shapes ----------------------------------------------------


@dataclass
class Download:
    label: str
    badge: str
    href: str
    size: str


@dataclass
class UnitView:
    key: str
    title: str
    docs: list[Download] = field(default_factory=list)
    chapters: list[Download] = field(default_factory=list)
    assets: list[Download] = field(default_factory=list)

    @property
    def empty(self) -> bool:
        return not (self.docs or self.chapters or self.assets)


@dataclass
class ClassView:
    id: str
    name: str
    level: str
    level_label: str
    slug: str
    ref: str
    ref_slug: str
    frozen: bool
    protect: list[str]
    years: list[tuple[str, str, list[UnitView]]]
    exams: list[dict]
    admin_html: str
    base: str

    def url(self, page: str) -> str:
        return f"{self.base}/c/{self.slug}/{page}"


# ---- source parsing -------------------------------------------------


def read_chapter_registry(worktree: Path, unit: str, level: str):
    """Ordered [(registry_label, source_stem)] from main-<level>.typ."""
    main = worktree / "src" / "units" / unit / f"main-{level}.typ"
    if not main.is_file():
        return []
    out = []
    for line in main.read_text(encoding="utf-8").splitlines():
        s = line.strip()
        if not s.startswith('("'):
            continue
        m = CHAPTER_ENTRY.match(s)
        if m:
            out.append((m.group(1), Path(m.group(2)).name))
    return out


def read_chapter_title(
    worktree: Path, unit: str, stem: str, fallback: str
) -> str:
    src = worktree / "src" / "units" / unit / f"{stem}.typ"
    if src.is_file():
        m = CHAPTER_TITLE.search(src.read_text(encoding="utf-8"))
        if m:
            return m.group(1)
    return fallback


# ---- discovery ------------------------------------------------------


def discover_unit(
    site: Path, base: str, worktree: Path, rslug: str, unit: str,
    level: str, title: str,
) -> UnitView | None:
    unit_dir = site / "v" / rslug / unit
    if not unit_dir.is_dir():
        warn(f"{unit} was not built at ref {rslug} — skipped")
        return None

    view = UnitView(key=unit, title=title)
    url = f"{base}/v/{rslug}/{unit}"

    for _, prefix, label, badge in DOC_KINDS:
        pdf = unit_dir / f"{prefix}-{level}.pdf"
        if pdf.is_file():
            view.docs.append(
                Download(label, badge, f"{url}/{pdf.name}", human_size(pdf))
            )

    known = {f"{p}-{level}.pdf" for _, p, _, _ in DOC_KINDS}
    registry = read_chapter_registry(worktree, unit, level)
    for label, stem in registry:
        pdf = unit_dir / f"{stem}-{level}.pdf"
        if pdf.is_file():
            known.add(pdf.name)
            view.chapters.append(
                Download(
                    read_chapter_title(worktree, unit, stem, label),
                    "CH",
                    f"{url}/{pdf.name}",
                    human_size(pdf),
                )
            )
    if registry and not view.chapters:
        # The splitter did not run, or names it, differently than the
        # registry stem.  Fall back to whatever chapter-shaped PDFs are
        # there, alphabetically, rather than silently showing nothing.
        for pdf in sorted(unit_dir.glob(f"*-{level}.pdf")):
            if pdf.name not in known:
                view.chapters.append(
                    Download(
                        pdf.stem.rsplit("-", 1)[0].replace("-", " ").title(),
                        "CH",
                        f"{url}/{pdf.name}",
                        human_size(pdf),
                    )
                )

    for sub in ("notebooks", "data"):
        d = unit_dir / sub
        if not d.is_dir():
            continue
        for f in sorted(p for p in d.rglob("*") if p.is_file()):
            rel = f.relative_to(unit_dir).as_posix()
            badge = "NB" if sub == "notebooks" else "DATA"
            view.assets.append(
                Download(rel, badge, f"{url}/{rel}", human_size(f))
            )

    if view.empty:
        warn(f"{unit} at ref {rslug} produced no {level} files — skipped")
        return None
    return view


def apply_withholding(cfg: dict, site: Path) -> None:
    """Delete solutions withheld by EVERY class sharing that build.

    Two classes can be pinned to the same ref.  If one still wants the
    solutions published, the file has to stay — so a withhold only
    takes effect when it is unanimous.  The generator reports the
    non-unanimous cases so they do not pass unnoticed.
    """
    usage: dict[tuple[str, str, str], list[bool]] = {}
    for c in cfg["classes"]:
        rslug, level = ref_slug(c["ref"]), c["level"]
        withheld = set(c.get("withhold_solutions") or [])
        for units in (c.get("years") or {}).values():
            for unit in units:
                usage.setdefault(
                    (rslug, unit, level), []
                ).append(unit in withheld)

    for (rslug, unit, level), flags in sorted(usage.items()):
        if not any(flags):
            continue
        pdf = site / "v" / rslug / unit / f"solutions-{level}.pdf"
        if all(flags):
            if pdf.is_file():
                pdf.unlink()
                print(f"  withheld: {pdf.relative_to(site)}")
        else:
            warn(
                f"solutions for {unit} ({level}) at {rslug} are withheld by "
                f"one class but published by another — kept"
            )


# ---- content --------------------------------------------------------


def read_markdown(*candidates: Path) -> str:
    parts = [p.read_text(encoding="utf-8") for p in candidates if p.is_file()]
    if not parts:
        return ""
    return md.markdown(
        "\n\n".join(parts), extensions=["extra", "sane_lists", "toc"]
    )


# ---- manifest -------------------------------------------------------


class ManifestError(Exception):
    """A problem in classes.yml, reported as a sentence, not a traceback."""


def load_manifest(path: Path) -> dict:
    """Read classes.yml, fill in optional blocks, reject what cannot work.

    Everything except `classes` has a workable default, so a manifest
    missing `site:` gets a plain-looking site rather than a KeyError six
    frames deep.  What genuinely cannot be guessed — which classes exist,
    and at which level and ref — is checked here so the message names the
    file and the class instead of the line of Python that gave up.
    """
    if not path.is_file():
        raise ManifestError(f"{path}: no such file")
    try:
        cfg = yaml.safe_load(path.read_text(encoding="utf-8"))
    except yaml.YAMLError as e:
        raise ManifestError(f"{path}: not valid YAML\n{e}") from None

    if not isinstance(cfg, dict):
        raise ManifestError(
            f"{path}: the top level must be a mapping with a `classes:` key"
        )

    for key, default in (("site", {}), ("units", {}), ("years", {})):
        if cfg.get(key) is None:
            cfg[key] = default
        if not isinstance(cfg[key], dict):
            raise ManifestError(f"{path}: `{key}:` must be a mapping")

    known_site = {"title", "subtitle", "teacher", "base_path", "footer"}
    for key in sorted(set(cfg["site"]) - known_site):
        print(
            f"warning: {path}: unknown key `{key}:` under `site:` — ignored. "
            f"Known keys: {', '.join(sorted(known_site))}",
            file=sys.stderr,
        )

    cfg["site"].setdefault("title", "Course materials")
    cfg["site"].setdefault("subtitle", "")
    cfg["site"].setdefault("base_path", "")
    cfg["site"].setdefault("footer", "")

    classes = cfg.get("classes")
    if not classes:
        raise ManifestError(
            f"{path}: no `classes:` entries — nothing to generate.\n"
            f"Each entry needs at least id, name, level, slug and ref."
        )
    if not isinstance(classes, list):
        raise ManifestError(f"{path}: `classes:` must be a list")

    seen_ids: set[str] = set()
    seen_slugs: set[str] = set()
    for i, c in enumerate(classes, 1):
        where = f"{path}: class #{i}"
        if not isinstance(c, dict):
            raise ManifestError(f"{where} is not a mapping")
        for key in ("id", "name", "level", "slug", "ref"):
            if not c.get(key):
                raise ManifestError(
                    f"{where} ({c.get('id') or c.get('name') or '?'}) "
                    f"is missing `{key}:`"
                )
        if c["level"] not in LEVEL_LABEL:
            raise ManifestError(
                f"{where} ({c['id']}): level must be "
                f"{' or '.join(LEVEL_LABEL)}, not {c['level']!r}"
            )
        if c["id"] in seen_ids:
            raise ManifestError(f"{path}: duplicate class id {c['id']!r}")
        if c["slug"] in seen_slugs:
            raise ManifestError(
                f"{path}: duplicate slug {c['slug']!r} — two classes would "
                f"overwrite each other's pages"
            )
        seen_ids.add(c["id"])
        seen_slugs.add(c["slug"])

        if c.get("years") is None:
            c["years"] = {}
        if not isinstance(c["years"], dict):
            raise ManifestError(
                f"{where} ({c['id']}): `years:` must map a year key to a "
                f"list of unit folder names"
            )
        for ykey, units in c["years"].items():
            if not isinstance(units, list):
                raise ManifestError(
                    f"{where} ({c['id']}): years.{ykey} must be a list, "
                    f"e.g. [calculus-differential]"
                )
    return cfg



LINK_ATTR = re.compile(r'(?:href|src)="([^"]+)"')


def verify_links(site: Path, base: str) -> None:
    """Check that every internal link resolves to a file that exists.

    Catches the whole family of "the page renders but nothing works"
    faults in one pass: a wrong base_path, a stylesheet that never got
    committed, a PDF the build did not produce. Each of those is
    invisible in the generated HTML and obvious here.
    """
    missing: dict[str, list[str]] = {}
    for page in sorted(site.rglob("*.html")):
        for href in LINK_ATTR.findall(page.read_text(encoding="utf-8")):
            if not href.startswith("/"):
                continue  # external, anchor, or same-directory tab link
            if base and not href.startswith(base + "/"):
                missing.setdefault(
                    f"{href}  (does not start with base_path {base!r})", []
                ).append(str(page.relative_to(site)))
                continue
            rel = href[len(base):].lstrip("/")
            target = site / (rel + "index.html" if rel.endswith("/") else rel)
            if not target.exists():
                missing.setdefault(href, []).append(
                    str(page.relative_to(site))
                )

    for href, pages in sorted(missing.items()):
        warn(f"broken link {href} (on {pages[0]}"
             + (f" and {len(pages) - 1} more)" if len(pages) > 1 else ")"))
    if not missing:
        print("  all internal links resolve")

# ---- rendering ------------------------------------------------------


def build(cfg: dict, refs_dir: Path, site: Path, content: Path,
          templates: Path) -> None:
    base = cfg["site"].get("base_path", "").rstrip("/")
    year_labels = cfg.get("years", {})
    unit_meta = cfg.get("units", {})

    env = Environment(
        loader=FileSystemLoader(templates),
        autoescape=select_autoescape(["html"]),
        trim_blocks=True,
        lstrip_blocks=True,
    )

    apply_withholding(cfg, site)

    encrypt: list[dict] = []
    class_views: list[ClassView] = []

    for c in cfg["classes"]:
        cid, level = c["id"], c["level"]
        rslug = ref_slug(c["ref"])
        worktree = refs_dir / rslug
        if not worktree.is_dir():
            warn(
                f"no worktree for ref {c['ref']} — "
                f"chapter lists unavailable"
            )

        years = []
        for ykey, units in (c.get("years") or {}).items():
            views = []
            for unit in units:
                title = unit_meta.get(unit, {}).get(
                    "title", unit.replace("-", " ").title()
                )
                v = discover_unit(
                    site, base, worktree, rslug, unit, level, title
                )
                if v:
                    views.append(v)
            if views:
                years.append((ykey, year_labels.get(ykey, ykey), views))

        admin_html = read_markdown(
            content / "admin.md", content / "classes" / cid / "admin.md"
        )

        exams = sorted(
            (c.get("exams") or []), key=lambda e: str(e.get("date", ""))
        )

        class_views.append(
            ClassView(
                id=cid,
                name=c["name"],
                level=level,
                level_label=LEVEL_LABEL.get(level, level),
                slug=c["slug"],
                ref=c["ref"],
                ref_slug=rslug,
                frozen=c["ref"] != "main",
                protect=list(c.get("protect") or []),
                years=years,
                exams=exams,
                admin_html=admin_html,
                base=base,
            )
        )

    for cv in class_views:
        out = site / "c" / cv.slug
        out.mkdir(parents=True, exist_ok=True)

        tabs = [("index.html", "Admin"), ("exams.html", "Exam dates")]
        tabs += [(f"{y}.html", label) for y, label, _ in cv.years]

        def render(name: str, template: str, **ctx) -> None:
            html = env.get_template(template).render(
                cls=cv, site=cfg["site"], base=cv.base,
                tabs=tabs, active=name, **ctx
            )
            (out / name).write_text(html, encoding="utf-8")

        render("index.html", "admin.html")
        render("exams.html", "exams.html")
        for ykey, label, units in cv.years:
            render(f"{ykey}.html", "year.html", year_label=label, units=units)

        for page in cv.protect:
            targets = {
                "exams": ["exams.html"],
                "admin": ["index.html"],
                "years": [f"{y}.html" for y, _, _ in cv.years],
            }.get(page, [])
            for t in targets:
                encrypt.append(
                    {"path": f"c/{cv.slug}/{t}", "class_id": cv.id}
                )

    (site / "index.html").write_text(
        env.get_template("index.html").render(site=cfg["site"], base=base),
        encoding="utf-8",
    )
    (site / "_encrypt.json").write_text(
        json.dumps(encrypt, indent=1), encoding="utf-8"
    )
    (site / ".nojekyll").write_text("", encoding="utf-8")

    static_src = HERE / "static"
    if static_src.is_dir():
        shutil.copytree(static_src, site / "static", dirs_exist_ok=True)
        if not (static_src / "style.css").is_file():
            warn(
                f"{static_src} exists but has no style.css — pages will "
                f"render unstyled"
            )
    else:
        warn(
            f"no {static_src} directory — pages will render unstyled. "
            f"style.css belongs in site/static/, not site/."
        )

    verify_links(site, base)

    print(f"\n{len(class_views)} class page set(s), "
          f"{len(encrypt)} page(s) to encrypt, {len(warnings)} warning(s).")


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--manifest", type=Path, default=HERE / "classes.yml")
    ap.add_argument("--refs-dir", type=Path, default=Path(".refs"))
    ap.add_argument("--site", type=Path, default=Path("_site"))
    ap.add_argument("--content", type=Path, default=HERE / "content")
    ap.add_argument("--templates", type=Path, default=HERE / "templates")
    ap.add_argument(
        "--strict", action="store_true",
        help="exit non-zero if anything was missing (use in CI)",
    )
    ap.add_argument(
        "--new-slug", metavar="PREFIX", nargs="?", const="",
        help="print an unguessable slug and exit, optionally prefixed "
             "(e.g. --new-slug 4a-glf). Checked against the manifest so "
             "it cannot collide with a class you already published.",
    )
    ap.add_argument(
        "--plan", action="store_true",
        help="print 'slug<TAB>ref<TAB>unit,unit,...' per distinct ref "
             "and exit; this is what build-refs.sh consumes",
    )
    a = ap.parse_args()

    if a.new_slug is not None:
        taken = set()
        try:
            raw = yaml.safe_load(a.manifest.read_text(encoding="utf-8"))
            taken = {c.get("slug") for c in (raw or {}).get("classes") or []}
        except Exception:
            pass  # a slug is still useful when the manifest is unwritten
        while (slug := random_slug(a.new_slug)) in taken:
            continue
        print(slug)
        return 0

    try:
        cfg = load_manifest(a.manifest)
    except ManifestError as e:
        print(f"error: {e}", file=sys.stderr)
        return 2

    if a.plan:
        plan: dict[str, tuple[str, set[str]]] = {}
        for c in cfg["classes"]:
            slug = ref_slug(c["ref"])
            ref, units = plan.setdefault(slug, (c["ref"], set()))
            for us in (c.get("years") or {}).values():
                units.update(us)
        for slug, (ref, units) in sorted(plan.items()):
            print(f"{slug}\t{ref}\t{','.join(sorted(units))}")
        return 0

    a.site.mkdir(parents=True, exist_ok=True)
    build(cfg, a.refs_dir, a.site, a.content, a.templates)

    return 1 if (a.strict and warnings) else 0


if __name__ == "__main__":
    raise SystemExit(main())