// ════════════════════════════════════════════════════════════
//  vec-figures.typ — native figure helpers for the Vectors unit
//  VERSION 3
// ════════════════════════════════════════════════════════════
//
//  Check which copy you have: #vec-figures-version prints it.
//  v1  first draft
//  v2  _abs-head / _arc-mark: normalize length args to floats
//  v3  right-angle mark is now a quarter-arc + dot (booklet style);
//      space3d gained ground: shaded coordinate planes
//
//  STATUS: test module. Once the output looks right, fold this
//  file into preamble.typ and delete it; nothing in the chapters
//  changes except the import line.
//
//  Place next to the chapter files:  src/units/vectors/vec-figures.typ
//  Import from a chapter:            #import "vec-figures.typ": *
//
//  Everything here is drawn with box() + place() + line/polygon/
//  circle, exactly like prob-tree, venn2 and number-line in
//  preamble.typ. No cetz, no external packages, no image files.
//
//  ── THE THREE PUBLIC ENTRY POINTS ─────────────────────────
//    vplane(..items)    2D coordinate plane: grid, axes, arrows
//    space3d(..items)   3D axonometric ("Schrägbild") scene
//    cube(..)           a labeled cube, built on space3d
//
//  Each takes a list of ITEM DICTIONARIES built by the small
//  constructor functions below (s-vec, s-pt, s-seg, s-poly, ...),
//  the same pattern number-line() already uses with nl-span /
//  nl-point / nl-measure. Draw order is fixed and sensible:
//  polygon fills → axes → segments → vectors → points → labels,
//  so a shaded plane never covers the arrows lying on it.
//
//  ── 3D PROJECTION CONVENTION ──────────────────────────────
//  Cabinet projection, the standard Swiss/German Schrägbild:
//    y-axis  → to the right, true length
//    z-axis  → up, true length
//    x-axis  → toward the viewer, down-left at `alpha`,
//              foreshortened by factor `k`
//  Defaults alpha: 42deg, k: 0.5. These are the two knobs most
//  worth fiddling with — see the test sheet.
// ════════════════════════════════════════════════════════════

#import "../../common/preamble.typ": *

#let vec-figures-version = 3

// House ink for figure chrome. Local copies so this file can be
// dropped in and compiled before it is merged into the preamble.
#let _v-ink = luma(70)
#let _v-grid = 0.5pt + luma(215)
#let _v-axis = 0.7pt + luma(70)
#let _v-hidden = luma(150)

// Translucent fill for plane patches. If your Typst version rejects
// .transparentize(), replace the body with a plain light color such
// as rgb("#dfe9e3") — everything else keeps working, the planes just
// stop letting the axes show through.
#let _soft(c, amt: 55%) = c.transparentize(amt)

// ────────────────────────────────────────────────────────────
//  ITEM CONSTRUCTORS
//  Every one returns a plain dictionary. Positions are world
//  coordinates: (x, y) for vplane, (x, y, z) for space3d.
//  Label offsets `off:` are (dx, dy) LENGTHS in screen space,
//  positive dy pointing DOWN, as everywhere in Typst.
// ────────────────────────────────────────────────────────────

// An arrow. This is the workhorse: a vector in standard position is
// s-vec(to: (2,3)); a vector between two points is
// s-vec(from: A, to: B).
#let s-vec(
  from: none,
  to: none,
  color: none,
  label: none,
  off: (5pt, -13pt),
  dashed: false,
  width: 1pt,
  head: 5.5pt,
) = (
  kind: "vec",
  from: from,
  to: to,
  color: color,
  label: label,
  off: off,
  dashed: dashed,
  width: width,
  head: head,
)

// A plain segment, no arrowhead. `hidden: true` is the dashed
// gray used for cube edges behind the solid.
#let s-seg(
  from: none,
  to: none,
  color: none,
  label: none,
  off: (4pt, -12pt),
  dashed: false,
  hidden: false,
  width: 0.8pt,
) = (
  kind: "seg",
  from: from,
  to: to,
  color: color,
  label: label,
  off: off,
  dashed: dashed or hidden,
  width: width,
)

// A marked point.
#let s-pt(
  pos,
  label: none,
  off: (5pt, -16pt),
  color: none,
  r: 2.2pt,
  hollow: false,
) = (
  kind: "pt",
  pos: pos,
  label: label,
  off: off,
  color: color,
  r: r,
  hollow: hollow,
)

// A filled/outlined polygon: a plane patch, a triangle, a cube
// section, the parallelogram spanned by two vectors.
#let s-poly(
  pts,
  fill: none,
  stroke-color: none,
  width: 0.8pt,
  dashed: false,
) = (
  kind: "poly",
  pts: pts,
  fill: fill,
  stroke-color: stroke-color,
  width: width,
  dashed: dashed,
)

// An angle mark at `vertex`, opening from the direction of `from`
// to the direction of `to`. The radius is a SCREEN length, not a
// world one — in 3D a true circular arc would have to be an ellipse,
// and a screen-space arc is exactly what a hand-drawn Schrägbild
// shows anyway.
//
// right: true draws the right-angle mark as a quarter-arc with a dot
// inside it, which is what the formula booklet uses. (A corner
// bracket is the other common convention; the booklet does not use
// it, so neither do we.)
#let s-arc(
  vertex: none,
  from: none,
  to: none,
  r: 15pt,
  label: none,
  color: none,
  right: false,
) = (
  kind: "arc",
  vertex: vertex,
  from: from,
  to: to,
  r: r,
  label: label,
  color: color,
  right: right,
)

// Free-floating text pinned to a world position.
#let s-txt(pos, body, off: (0pt, 0pt), size: 9pt, color: none) = (
  kind: "txt",
  pos: pos,
  body: body,
  off: off,
  size: size,
  color: color,
)

// ────────────────────────────────────────────────────────────
//  SHARED LOW-LEVEL DRAWING (screen coordinates, floats in pt)
// ────────────────────────────────────────────────────────────

#let _pt(v) = v * 1pt

// A polygon given in ABSOLUTE screen coordinates. polygon() lays
// its points out relative to its own origin, so we anchor at the
// bounding-box corner and shift every vertex — that way negative
// coordinates can never silently displace the shape.
#let _abs-poly(pts, fill: none, stroke: none) = {
  if pts.len() < 2 { return }
  let mx = calc.min(..pts.map(p => p.at(0)))
  let my = calc.min(..pts.map(p => p.at(1)))
  place(
    dx: _pt(mx),
    dy: _pt(my),
    polygon(
      fill: fill,
      stroke: stroke,
      ..pts.map(p => (_pt(p.at(0) - mx), _pt(p.at(1) - my))),
    ),
  )
}

#let _abs-line(a, b, stroke) = place(
  dx: _pt(a.at(0)),
  dy: _pt(a.at(1)),
  line(
    start: (0pt, 0pt),
    end: (_pt(b.at(0) - a.at(0)), _pt(b.at(1) - a.at(1))),
    stroke: stroke,
  ),
)

// Arrowhead as a filled triangle whose vertices are computed
// directly in screen coordinates — no rotate(), so there is no
// origin-of-rotation guesswork.
//
// INVARIANT worth keeping: every coordinate inside this module is a
// bare float measured in points, and lengths only appear at the
// place()/stroke boundary. `size` is the one argument callers
// naturally write as a length (5pt), so it gets normalized here
// rather than at each of the ~8 call sites.
#let _abs-head(a, b, color, size) = {
  let s = if type(size) == length { size.pt() } else { size }
  let dx = b.at(0) - a.at(0)
  let dy = b.at(1) - a.at(1)
  let len = calc.sqrt(dx * dx + dy * dy)
  if len < 0.001 { return }
  let ux = dx / len
  let uy = dy / len
  let back = (b.at(0) - s * ux, b.at(1) - s * uy)
  let w = s * 0.40
  _abs-poly(
    (
      b,
      (back.at(0) - w * uy, back.at(1) + w * ux),
      (back.at(0) + w * uy, back.at(1) - w * ux),
    ),
    fill: color,
    stroke: none,
  )
}

#let _abs-dot(p, color, r, hollow) = place(
  dx: _pt(p.at(0)) - r,
  dy: _pt(p.at(1)) - r,
  circle(
    radius: r,
    fill: if hollow { white } else { color },
    stroke: if hollow { 0.9pt + color } else { none },
  ),
)

#let _abs-txt(p, off, body, size: 9pt, color: _v-ink) = place(
  dx: _pt(p.at(0)) + off.at(0),
  dy: _pt(p.at(1)) + off.at(1),
  box(text(size: size, fill: color, body)),
)

// Circular arc drawn as a polyline of short segments. Used for
// angle marks; a closed polygon() would draw the chord as well.
#let _abs-arc(c, r, a0, a1, stroke, n: 24) = {
  let prev = none
  for i in range(n + 1) {
    let t = a0 + (a1 - a0) * (i / n)
    let p = (c.at(0) + r * calc.cos(t), c.at(1) - r * calc.sin(t))
    if prev != none { _abs-line(prev, p, stroke) }
    prev = p
  }
}

// Midpoint of a segment, for label anchoring.
#let _mid(a, b) = ((a.at(0) + b.at(0)) / 2, (a.at(1) + b.at(1)) / 2)

// Angle mark between two screen directions leaving vertex `v`.
// Angles are taken in the usual math orientation, remembering that
// screen y grows downward: a direction (dx, dy) has math angle
// atan2(dx, -dy).
#let _arc-mark(v, a, b, r, label, color, right) = {
  let ang(p) = {
    let dx = p.at(0) - v.at(0)
    let dy = p.at(1) - v.at(1)
    if calc.abs(dx) < 0.0001 and calc.abs(dy) < 0.0001 { return 0deg }
    calc.atan2(dx, -dy)
  }
  let t1 = ang(a)
  let t2 = ang(b)
  // always mark the smaller of the two angles
  if t2 - t1 > 180deg { t2 -= 360deg }
  if t1 - t2 > 180deg { t2 += 360deg }
  let rp = if type(r) == length { r.pt() } else { r }
  let st = 0.7pt + color

  if right {
    // quarter-arc plus a dot on the bisector — the booklet's mark
    _abs-arc(v, 0.72 * rp, t1, t2, st)
    let tm = (t1 + t2) / 2
    _abs-dot(
      (v.at(0) + 0.40 * rp * calc.cos(tm), v.at(1) - 0.40 * rp * calc.sin(tm)),
      color,
      1.15pt,
      false,
    )
  } else {
    _abs-arc(v, rp, t1, t2, st)
  }

  if label != none {
    let tm = (t1 + t2) / 2
    let rl = rp * 1.55
    _abs-txt(
      (
        v.at(0) + rl * calc.cos(tm) - 5,
        v.at(1) - rl * calc.sin(tm) - 6,
      ),
      (0pt, 0pt),
      label,
      size: 9pt,
      color: color,
    )
  }
}

// ════════════════════════════════════════════════════════════
//  vplane — 2D coordinate plane
// ════════════════════════════════════════════════════════════
//
//  #vplane(
//    s-vec(to: (2, 3), label: $vec(u)$),
//    s-vec(from: (2, 3), to: (3, 1), label: $vec(v)$, color: warn-col),
//    s-vec(to: (3, 1), label: $vec(u) + vec(v)$, color: def-col),
//    xmin: -0.5, xmax: 4.5, ymin: -0.5, ymax: 3.5,
//  )
//
//  Bounds follow the house rule from STYLE_GUIDE §6: end them in
//  .5 so the outermost gridline does not merge with the frame.
// ════════════════════════════════════════════════════════════
#let vplane(
  ..items,
  xmin: -0.5,
  xmax: 5.5,
  ymin: -0.5,
  ymax: 4.5,
  unit: 0.8cm,
  grid: true,
  axes: true,
  ticks: true,
  frame: false,
  pad: 0.5cm,
) = align(center, {
  let u = unit.pt()
  let its = items.pos()
  let pd = pad.pt()
  let W = (xmax - xmin) * u
  let H = (ymax - ymin) * u

  // world → screen (y flipped), including the padding offset
  let X(p) = (pd + (p.at(0) - xmin) * u, pd + (ymax - p.at(1)) * u)

  box(width: _pt(W + 2 * pd), height: _pt(H + 2 * pd), {
    if frame {
      place(dx: _pt(pd), dy: _pt(pd), rect(
        width: _pt(W),
        height: _pt(H),
        stroke: 0.5pt + luma(190),
      ))
    }

    // ── grid ──
    if grid {
      let i = calc.ceil(xmin)
      while i <= xmax {
        _abs-line(X((i, ymin)), X((i, ymax)), _v-grid)
        i += 1
      }
      let j = calc.ceil(ymin)
      while j <= ymax {
        _abs-line(X((xmin, j)), X((xmax, j)), _v-grid)
        j += 1
      }
    }

    // ── axes ──
    if axes {
      if ymin <= 0 and ymax >= 0 {
        _abs-line(X((xmin, 0)), X((xmax, 0)), _v-axis)
        _abs-head(X((xmax - 0.3, 0)), X((xmax, 0)), _v-ink, 5pt)
        _abs-txt(X((xmax, 0)), (-2pt, 4pt), $x$, size: 9pt)
      }
      if xmin <= 0 and xmax >= 0 {
        _abs-line(X((0, ymin)), X((0, ymax)), _v-axis)
        _abs-head(X((0, ymax - 0.3)), X((0, ymax)), _v-ink, 5pt)
        _abs-txt(X((0, ymax)), (5pt, -4pt), $y$, size: 9pt)
      }
      if ticks {
        let i = calc.ceil(xmin)
        while i <= xmax {
          if i != 0 and calc.rem(i, 1) == 0 {
            _abs-txt(X((i, 0)), (-3pt, 3pt), text(size: 7pt)[#i])
          }
          i += 1
        }
        let j = calc.ceil(ymin)
        while j <= ymax {
          if j != 0 and calc.rem(j, 1) == 0 {
            _abs-txt(X((0, j)), (-9pt, -6pt), text(size: 7pt)[#j])
          }
          j += 1
        }
      }
    }

    // ── fills first, so nothing is buried ──
    for it in its {
      if it.kind == "poly" {
        _abs-poly(
          it.pts.map(X),
          fill: if it.fill == none { none } else { it.fill },
          stroke: if it.stroke-color == none { none } else {
            (
              paint: it.stroke-color,
              thickness: it.width,
              dash: if it.dashed { "dashed" } else { none },
            )
          },
        )
      }
    }

    // ── segments, then vectors ──
    for it in its {
      if it.kind == "seg" {
        let c = if it.color == none { _v-ink } else { it.color }
        _abs-line(X(it.from), X(it.to), (
          paint: c,
          thickness: it.width,
          dash: if it.dashed { "dashed" } else { none },
        ))
        if it.label != none {
          _abs-txt(_mid(X(it.from), X(it.to)), it.off, it.label)
        }
      }
    }
    for it in its {
      if it.kind == "vec" {
        let c = if it.color == none { accent } else { it.color }
        let a = X(if it.from == none { (0, 0) } else { it.from })
        let b = X(it.to)
        _abs-line(a, b, (
          paint: c,
          thickness: it.width,
          dash: if it.dashed { "dashed" } else { none },
        ))
        _abs-head(a, b, c, it.head)
        if it.label != none { _abs-txt(_mid(a, b), it.off, it.label, color: c) }
      }
    }


    // -- angle marks --
    for it in its {
      if it.kind == "arc" {
        _arc-mark(
          X(it.vertex),
          X(it.from),
          X(it.to),
          it.r,
          it.label,
          if it.color == none { _v-ink } else { it.color },
          it.right,
        )
      }
    }
    // ── points and free text on top ──
    for it in its {
      if it.kind == "pt" {
        let c = if it.color == none { _v-ink } else { it.color }
        _abs-dot(X(it.pos), c, it.r, it.hollow)
        if it.label != none { _abs-txt(X(it.pos), it.off, it.label) }
      }
    }
    for it in its {
      if it.kind == "txt" {
        _abs-txt(
          X(it.pos),
          it.off,
          it.body,
          size: it.size,
          color: if it.color == none { _v-ink } else { it.color },
        )
      }
    }
  })
})

// ════════════════════════════════════════════════════════════
//  space3d — axonometric 3D scene
// ════════════════════════════════════════════════════════════
//
//  The canvas sizes itself: every world point mentioned by any
//  item (plus the axis tips, if axes are on) is projected, and the
//  bounding box of the result plus `pad` becomes the box. So you
//  never set a width — you set the scene and it fits.
//
//  #space3d(
//    s-pt((3, 4, 2), label: $P$),
//    s-vec(to: (3, 4, 2), label: $vec(r)_P$),
//    axis-len: (4, 5, 3),
//  )
// ════════════════════════════════════════════════════════════
#let space3d(
  ..items,
  unit: 0.62cm,
  alpha: 42deg,
  k: 0.5,
  axes: true,
  axis-len: (4, 5, 4),
  ticks: true,
  ground: false,
  ground-frac: 0.78,
  ground-fill: none,
  pad: 0.85cm,
) = align(center, {
  let u = unit.pt()
  let its = items.pos()
  let pd = pad.pt()
  let ca = calc.cos(alpha)
  let sa = calc.sin(alpha)

  // raw projection, before the bounding box is known
  let P0(p) = (
    (p.at(1) - k * p.at(0) * ca) * u,
    -(p.at(2) - k * p.at(0) * sa) * u,
  )

  // every world point in the scene, for the bounding box
  let pts = ()
  for it in its {
    if "pts" in it { pts += it.pts }
    if "from" in it and it.from != none { pts.push(it.from) }
    if "to" in it and it.to != none { pts.push(it.to) }
    if "pos" in it { pts.push(it.pos) }
    if "vertex" in it and it.vertex != none { pts.push(it.vertex) }
  }
  if axes {
    pts += (
      (0, 0, 0),
      (axis-len.at(0), 0, 0),
      (0, axis-len.at(1), 0),
      (0, 0, axis-len.at(2)),
    )
  }
  if pts.len() == 0 { pts = ((0, 0, 0),) }

  let sp = pts.map(P0)
  let minx = calc.min(..sp.map(p => p.at(0)))
  let maxx = calc.max(..sp.map(p => p.at(0)))
  let miny = calc.min(..sp.map(p => p.at(1)))
  let maxy = calc.max(..sp.map(p => p.at(1)))

  let X(p) = {
    let q = P0(p)
    (q.at(0) - minx + pd, q.at(1) - miny + pd)
  }

  box(
    width: _pt(maxx - minx + 2 * pd),
    height: _pt(maxy - miny + 2 * pd),
    {
      // ── shaded coordinate planes ──
      // Three squares in the first octant, the way the formula
      // booklet shades them: they make trace points and "which
      // plane is that point in?" readable at a glance. Drawn first
      // so the axes sit on top of them.
      if ground {
        let gf = ground-frac
        let gx = axis-len.at(0) * gf
        let gy = axis-len.at(1) * gf
        let gz = axis-len.at(2) * gf
        let gc = if ground-fill == none { luma(236) } else { ground-fill }
        let faces = (
          ((0, 0, 0), (gx, 0, 0), (gx, gy, 0), (0, gy, 0)),
          ((0, 0, 0), (gx, 0, 0), (gx, 0, gz), (0, 0, gz)),
          ((0, 0, 0), (0, gy, 0), (0, gy, gz), (0, 0, gz)),
        )
        for f in faces {
          _abs-poly(f.map(X), fill: gc, stroke: none)
        }
      }

      // ── axes ──
      if axes {
        let names = ($x$, $y$, $z$)
        let tips = (
          (axis-len.at(0), 0, 0),
          (0, axis-len.at(1), 0),
          (0, 0, axis-len.at(2)),
        )
        let offs = ((-11pt, 2pt), (3pt, -1pt), (-1pt, -13pt))
        for i in range(3) {
          _abs-line(X((0, 0, 0)), X(tips.at(i)), _v-axis)
          let near = (
            tips.at(i).at(0) * 0.88,
            tips.at(i).at(1) * 0.88,
            tips.at(i).at(2) * 0.88,
          )
          _abs-head(X(near), X(tips.at(i)), _v-ink, 5pt)
          _abs-txt(X(tips.at(i)), offs.at(i), names.at(i), size: 9pt)
        }
        if ticks {
          for i in range(3) {
            let n = calc.floor(axis-len.at(i) - 0.5)
            for j in range(1, n + 1) {
              let q = (0, 0, 0)
              q.at(i) = j
              _abs-dot(X(q), luma(130), 1.3pt, false)
            }
          }
        }
      }

      // ── plane patches / sections first ──
      for it in its {
        if it.kind == "poly" {
          _abs-poly(
            it.pts.map(X),
            fill: it.fill,
            stroke: if it.stroke-color == none { none } else {
              (
                paint: it.stroke-color,
                thickness: it.width,
                dash: if it.dashed { "dashed" } else { none },
              )
            },
          )
        }
      }

      // ── segments ──
      for it in its {
        if it.kind == "seg" {
          let c = if it.color == none { _v-ink } else { it.color }
          _abs-line(X(it.from), X(it.to), (
            paint: c,
            thickness: it.width,
            dash: if it.dashed { "dashed" } else { none },
          ))
          if it.label != none {
            _abs-txt(_mid(X(it.from), X(it.to)), it.off, it.label)
          }
        }
      }

      // ── vectors ──
      for it in its {
        if it.kind == "vec" {
          let c = if it.color == none { accent } else { it.color }
          let a = X(if it.from == none { (0, 0, 0) } else { it.from })
          let b = X(it.to)
          _abs-line(a, b, (
            paint: c,
            thickness: it.width,
            dash: if it.dashed { "dashed" } else { none },
          ))
          _abs-head(a, b, c, it.head)
          if it.label != none {
            _abs-txt(_mid(a, b), it.off, it.label, color: c)
          }
        }
      }


      // -- angle marks --
      for it in its {
        if it.kind == "arc" {
          _arc-mark(
            X(it.vertex),
            X(it.from),
            X(it.to),
            it.r,
            it.label,
            if it.color == none { _v-ink } else { it.color },
            it.right,
          )
        }
      }
      // ── points, then text ──
      for it in its {
        if it.kind == "pt" {
          let c = if it.color == none { _v-ink } else { it.color }
          _abs-dot(X(it.pos), c, it.r, it.hollow)
          if it.label != none { _abs-txt(X(it.pos), it.off, it.label) }
        }
      }
      for it in its {
        if it.kind == "txt" {
          _abs-txt(
            X(it.pos),
            it.off,
            it.body,
            size: it.size,
            color: if it.color == none { _v-ink } else { it.color },
          )
        }
      }
    },
  )
})

// ────────────────────────────────────────────────────────────
//  SCENE BUILDERS — return arrays of items, splat them in:
//    #space3d(..plane-patch(...), s-pt(...))
// ────────────────────────────────────────────────────────────

// The parallelogram patch of a plane E: r = a + t·u + s·v,
// drawn over t, s ∈ [lo, hi] so the "starting point" sits inside
// the patch rather than at a corner.
#let plane-patch(
  a,
  u,
  v,
  lo: -1,
  hi: 2,
  fill: none,
  stroke-color: none,
) = {
  let corner(t, s) = range(3).map(i => (
    a.at(i) + t * u.at(i) + s * v.at(i)
  ))
  (
    s-poly(
      (corner(lo, lo), corner(hi, lo), corner(hi, hi), corner(lo, hi)),
      fill: if fill == none { _soft(accent-bg, amt: 25%) } else { fill },
      stroke-color: if stroke-color == none { accent } else { stroke-color },
    ),
  )
}

// The intercept triangle of a plane given by its three axis
// intercepts — the picture used for sketching ax+by+cz+d=0.
#let plane-intercepts(p, q, r, fill: none, stroke-color: none) = (
  s-poly(
    ((p, 0, 0), (0, q, 0), (0, 0, r)),
    fill: if fill == none { _soft(accent-bg, amt: 25%) } else { fill },
    stroke-color: if stroke-color == none { accent } else { stroke-color },
    width: 1pt,
  ),
)

// A line r = a + t·v drawn over a parameter range, with optional
// arrowheads at both ends so it reads as unbounded.
#let line3(a, v, tmin: -1.5, tmax: 2.5, color: none, label: none) = {
  let at(t) = range(3).map(i => a.at(i) + t * v.at(i))
  let c = if color == none { def-col } else { color }
  (
    s-seg(from: at(tmin), to: at(tmax), color: c, width: 1pt, label: label),
  )
}

// ════════════════════════════════════════════════════════════
//  cube — the spatial-reasoning workhorse
// ════════════════════════════════════════════════════════════
//
//  Vertices, in the German school convention (bottom ABCD counter-
//  clockwise from above, top EFGH directly over them):
//     A (a,0,0)  B (a,a,0)  C (0,a,0)  D (0,0,0)
//     E (a,0,a)  F (a,a,a)  G (0,a,a)  H (0,0,a)
//  D is the vertex hidden behind the solid, so DA, DC, DH are the
//  three dashed edges.
//
//  cube-pts(a) gives you the eight positions by name, so points on
//  edges can be written the way students see them:
//     let V = cube-pts(4)
//     let M = edge-pt(V.A, V.B, 0.5)     // midpoint of edge AB
// ════════════════════════════════════════════════════════════
#let cube-pts(a: 4) = (
  A: (a, 0, 0),
  B: (a, a, 0),
  C: (0, a, 0),
  D: (0, 0, 0),
  E: (a, 0, a),
  F: (a, a, a),
  G: (0, a, a),
  H: (0, 0, a),
)

// Point a fraction t of the way from P to Q.
#let edge-pt(p, q, t) = range(3).map(i => p.at(i) + t * (q.at(i) - p.at(i)))

#let cube-edges(a: 4, color: none, hidden-color: none, labels: true) = {
  let V = cube-pts(a: a)
  let c = if color == none { luma(55) } else { color }
  let hc = if hidden-color == none { _v-hidden } else { hidden-color }
  let solid = (
    ("A", "B"), ("B", "C"), ("E", "F"), ("F", "G"), ("G", "H"),
    ("H", "E"), ("A", "E"), ("B", "F"), ("C", "G"),
  )
  let dashed = (("D", "A"), ("D", "C"), ("D", "H"))
  let out = ()
  for e in solid {
    out.push(s-seg(from: V.at(e.at(0)), to: V.at(e.at(1)), color: c))
  }
  for e in dashed {
    out.push(s-seg(
      from: V.at(e.at(0)),
      to: V.at(e.at(1)),
      color: hc,
      hidden: true,
    ))
  }
  if labels {
    // pushed outward from the body of the cube
    let offs = (
      A: (2pt, 6pt), B: (5pt, 4pt), C: (2pt, 4pt), D: (-11pt, 2pt),
      E: (0pt, -4pt), F: (5pt, -12pt), G: (2pt, -14pt), H: (-11pt, -12pt),
    )
    for name in ("A", "B", "C", "D", "E", "F", "G", "H") {
      out.push(s-txt(
        V.at(name),
        text(weight: "bold")[#name],
        off: offs.at(name),
      ))
    }
  }
  out
}

// Ready-made cube scene. Extra items are drawn on top of the edges.
#let cube(
  ..items,
  a: 4,
  labels: true,
  unit: 0.62cm,
  alpha: 42deg,
  k: 0.5,
  pad: 0.7cm,
) = space3d(
  ..cube-edges(a: a, labels: labels),
  ..items.pos(),
  axes: false,
  unit: unit,
  alpha: alpha,
  k: k,
  pad: pad,
)
