// ════════════════════════════════════════════════════════════
//  vec-figures.typ — native figure helpers for the Vectors unit
//  VERSION 6
// ════════════════════════════════════════════════════════════
//
//  Check which copy you have: #vec-figures-version prints it.
//  v1  first draft
//  v2  _abs-head / _arc-mark: normalize length args to floats
//  v3  right-angle mark = quarter-arc + dot; space3d ground planes
//  v4  LABEL SYSTEM REBUILT (see below); projection default is now
//      alpha 45deg, k = 1/sqrt(2); ground planes can span negatives
//  v5  space3d gained graph-paper gridlines (grid: true), for figures
//      students draw INTO; cube vertex labels tightened
//  v6  box-pts / box-edges / box3: the cube generalized to a
//      rectangular solid, so the chapter can show that only DEPTH is
//      foreshortened
//
//  ── WHAT CHANGED IN v4, AND WHY ───────────────────────────
//  Labels used to be anchored at the MIDPOINT of a vector with the
//  text box's TOP-LEFT corner placed at a manual offset. Both halves
//  of that were wrong:
//    · midpoint anchoring puts the label where the shaft is busiest
//      and where a second vector is most likely to cross;
//    · top-left placement means the same offset reads differently
//      for a one-character label and a five-character one, so every
//      figure needs hand-tuning.
//  Now: labels are CENTERED on their anchor, the anchor sits at a
//  settable fraction along the vector (default 0.78, i.e. near the
//  arrowhead), and the default displacement is PERPENDICULAR to the
//  shaft on the side facing away from the middle of the figure. A
//  vector label therefore lands outside whatever the vector bounds,
//  which is what "outside the angle" means in practice.
//
//  Any manual `off:` you wrote against v1–v3 must be re-tuned: the
//  numbers now mean "shift the label's CENTER by this much from its
//  automatic position," and in most cases you can delete them.
//
//  ── 3D PROJECTION CONVENTION ──────────────────────────────
//  Cabinet projection, the standard Schrägbild:
//    y → right, true length      z → up, true length
//    x → toward the viewer, down-left at alpha, scaled by k
//  Defaults: alpha = 45deg, k = 1/sqrt(2) ≈ 0.707. Chosen so the
//  figures can be reproduced on 5 mm graph paper exactly: two grid
//  squares along y and z, one grid-square DIAGONAL along x. That
//  diagonal has length 5·sqrt(2) mm against 10 mm for the other
//  two axes, which is where k = 1/sqrt(2) comes from.
// ════════════════════════════════════════════════════════════

#import "/src/common/preamble.typ": *

#let vec-figures-version = 6

// The house projection, exported so chapters can state it in words
// and exercises can ask students to reproduce it on graph paper.
#let PROJ-ALPHA = 45deg
#let PROJ-K = 0.7071067811865476

// Two standard scales. Use PRINT-UNIT for figures students only read,
// and SHEET-UNIT (with grid: true) for figures they draw INTO — at
// 1 cm per world unit the printed gridlines are 5 mm apart, so the
// figure matches the squared paper the construction is done on.
#let PRINT-UNIT = 0.62cm
#let SHEET-UNIT = 1cm

#let _v-ink = luma(70)
#let _v-grid = 0.5pt + luma(215)
#let _v-axis = 0.7pt + luma(70)
#let _v-hidden = luma(150)

// Translucent fill for plane patches. If your Typst version rejects
// .transparentize(), replace the body with a plain light color such
// as rgb("#dfe9e3").
#let _soft(c, amt: 55%) = c.transparentize(amt)

// ────────────────────────────────────────────────────────────
//  ITEM CONSTRUCTORS
//
//  Positions are world coordinates: (x, y) for vplane, (x, y, z)
//  for space3d.
//
//  LABEL PLACEMENT, shared by s-vec and s-seg:
//    anchor:  fraction along the object, 0 = tail, 1 = head
//    gap:     how far the label sits off the shaft
//    side:    auto | "left" | "right" — which side of the shaft.
//             auto picks the side facing away from the middle of
//             the figure, which is nearly always the readable one.
//    off:     extra manual nudge of the label's CENTRE, added last
//
//  For s-pt, `off: auto` pushes the label radially outward from the
//  middle of the figure — which is what makes cube vertex labels and
//  trace-point labels land outside the solid without hand-tuning.
// ────────────────────────────────────────────────────────────

#let s-vec(
  from: none,
  to: none,
  color: none,
  label: none,
  anchor: 0.78,
  gap: 11pt,
  side: auto,
  off: (0pt, 0pt),
  dashed: false,
  width: 1pt,
  head: 5.5pt,
) = (
  kind: "vec",
  from: from,
  to: to,
  color: color,
  label: label,
  anchor: anchor,
  gap: gap,
  side: side,
  off: off,
  dashed: dashed,
  width: width,
  head: head,
)

#let s-seg(
  from: none,
  to: none,
  color: none,
  label: none,
  anchor: 0.5,
  gap: 10pt,
  side: auto,
  off: (0pt, 0pt),
  dashed: false,
  hidden: false,
  width: 0.8pt,
) = (
  kind: "seg",
  from: from,
  to: to,
  color: color,
  label: label,
  anchor: anchor,
  gap: gap,
  side: side,
  off: off,
  dashed: dashed or hidden,
  width: width,
)

#let s-pt(
  pos,
  label: none,
  off: auto,
  gap: 13pt,
  color: none,
  r: 2.2pt,
  hollow: false,
) = (
  kind: "pt",
  pos: pos,
  label: label,
  off: off,
  gap: gap,
  color: color,
  r: r,
  hollow: hollow,
)

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

// An angle mark at `vertex`, opening from the direction of `from` to
// the direction of `to`. The radius is a SCREEN length: in 3D a true
// circular arc would be an ellipse, and a screen-space arc is what a
// hand-drawn Schrägbild shows anyway.
//
// right: true draws the booklet's right-angle mark — a quarter-arc
// with a dot inside. Note that the arc spans the PROJECTED angle, so
// a right angle in space is drawn as whatever it actually looks like
// on the page. When a right angle is available against more than one
// direction, mark it against the one that projects closest to 90°.
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

#let s-txt(pos, body, off: (0pt, 0pt), size: 9pt, color: none) = (
  kind: "txt",
  pos: pos,
  body: body,
  off: off,
  size: size,
  color: color,
)

// ────────────────────────────────────────────────────────────
//  LOW-LEVEL DRAWING
//  INVARIANT: every coordinate below is a bare float in points.
//  Lengths appear only at the place()/stroke boundary. Arguments a
//  caller would naturally write as a length are normalized on entry.
// ────────────────────────────────────────────────────────────

#let _pt(v) = v * 1pt
#let _f(v) = if type(v) == length { v.pt() } else { v }

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

#let _abs-head(a, b, color, size) = {
  let s = _f(size)
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

// Text CENTERED on an absolute screen point. Centering needs the
// container's dimensions, because place(center + horizon) measures
// from the container's middle — hence cw/ch, which every renderer
// passes in. This is what makes a one-character and a five-character
// label sit equally well at the same offset.
#let _abs-txt(p, body, cw, ch, size: 9pt, color: _v-ink) = place(
  center + horizon,
  dx: _pt(p.at(0) - cw / 2),
  dy: _pt(p.at(1) - ch / 2),
  box(text(size: size, fill: color, body)),
)

#let _abs-arc(c, r, a0, a1, stroke, n: 24) = {
  let prev = none
  for i in range(n + 1) {
    let t = a0 + (a1 - a0) * (i / n)
    let p = (c.at(0) + r * calc.cos(t), c.at(1) - r * calc.sin(t))
    if prev != none { _abs-line(prev, p, stroke) }
    prev = p
  }
}

// ── label geometry ──────────────────────────────────────────

// Unit vector from the middle of the figure toward p. Used to push
// point labels outward.
#let _outward(p, ctr) = {
  let dx = p.at(0) - ctr.at(0)
  let dy = p.at(1) - ctr.at(1)
  let n = calc.sqrt(dx * dx + dy * dy)
  if n < 0.001 { return (0.0, -1.0) }
  (dx / n, dy / n)
}

// Where a shaft label goes: `anchor` of the way along, displaced
// `gap` perpendicular, on the side facing away from the figure's
// middle (or the side you forced).
#let _shaft-label-pos(a, b, anchor, gap, side, off, ctr) = {
  let ax = a.at(0) + anchor * (b.at(0) - a.at(0))
  let ay = a.at(1) + anchor * (b.at(1) - a.at(1))
  let dx = b.at(0) - a.at(0)
  let dy = b.at(1) - a.at(1)
  let n = calc.sqrt(dx * dx + dy * dy)
  if n < 0.001 { n = 1.0 }
  // left-hand normal in screen coordinates (y grows downward)
  let px = -dy / n
  let py = dx / n
  let s = if side == "left" { 1.0 } else if side == "right" { -1.0 } else {
    // auto: away from the middle of the figure
    if px * (ax - ctr.at(0)) + py * (ay - ctr.at(1)) >= 0 { 1.0 } else { -1.0 }
  }
  let g = _f(gap)
  (
    ax + s * g * px + _f(off.at(0)),
    ay + s * g * py + _f(off.at(1)),
  )
}

#let _arc-mark(v, a, b, r, label, color, right, cw, ch) = {
  let ang(p) = {
    let dx = p.at(0) - v.at(0)
    let dy = p.at(1) - v.at(1)
    if calc.abs(dx) < 0.0001 and calc.abs(dy) < 0.0001 { return 0deg }
    calc.atan2(dx, -dy)
  }
  let t1 = ang(a)
  let t2 = ang(b)
  if t2 - t1 > 180deg { t2 -= 360deg }
  if t1 - t2 > 180deg { t2 += 360deg }
  let rp = _f(r)
  let st = 0.7pt + color

  if right {
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
    let rl = rp * 1.60
    _abs-txt(
      (v.at(0) + rl * calc.cos(tm), v.at(1) - rl * calc.sin(tm)),
      label,
      cw,
      ch,
      color: color,
    )
  }
}

// ════════════════════════════════════════════════════════════
//  vplane — 2D coordinate plane
// ════════════════════════════════════════════════════════════
//
//  #vplane(
//    s-vec(to: (2, 3), label: $arrow(u)$),
//    s-vec(from: (2, 3), to: (3, 1), label: $arrow(v)$, color: warn-col),
//    s-vec(to: (3, 1), label: $arrow(u) + arrow(v)$, color: def-col),
//    xmin: -0.5, xmax: 4.5, ymin: -0.5, ymax: 3.5,
//  )
//
//  Bounds end in .5 (STYLE_GUIDE §6) so the outermost gridline does
//  not merge with the frame.
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
  pad: 0.6cm,
) = align(center, {
  let u = unit.pt()
  let its = items.pos()
  let pd = pad.pt()
  let W = (xmax - xmin) * u
  let H = (ymax - ymin) * u
  let cw = W + 2 * pd
  let ch = H + 2 * pd
  let ctr = (cw / 2, ch / 2)

  let X(p) = (pd + (p.at(0) - xmin) * u, pd + (ymax - p.at(1)) * u)
  let TXT(p, body, ..a) = _abs-txt(p, body, cw, ch, ..a)

  box(width: _pt(cw), height: _pt(ch), {
    if frame {
      place(dx: _pt(pd), dy: _pt(pd), rect(
        width: _pt(W),
        height: _pt(H),
        stroke: 0.5pt + luma(190),
      ))
    }

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

    if axes {
      if ymin <= 0 and ymax >= 0 {
        _abs-line(X((xmin, 0)), X((xmax, 0)), _v-axis)
        _abs-head(X((xmax - 0.3, 0)), X((xmax, 0)), _v-ink, 5pt)
        TXT((X((xmax, 0)).at(0) + 2, X((xmax, 0)).at(1) + 10), $x$)
      }
      if xmin <= 0 and xmax >= 0 {
        _abs-line(X((0, ymin)), X((0, ymax)), _v-axis)
        _abs-head(X((0, ymax - 0.3)), X((0, ymax)), _v-ink, 5pt)
        TXT((X((0, ymax)).at(0) + 10, X((0, ymax)).at(1) + 1), $y$)
      }
      if ticks {
        let i = calc.ceil(xmin)
        while i <= xmax {
          if i != 0 {
            TXT(
              (X((i, 0)).at(0), X((i, 0)).at(1) + 8),
              text(size: 7pt)[#i],
            )
          }
          i += 1
        }
        let j = calc.ceil(ymin)
        while j <= ymax {
          if j != 0 {
            TXT(
              (X((0, j)).at(0) - 8, X((0, j)).at(1)),
              text(size: 7pt)[#j],
            )
          }
          j += 1
        }
      }
    }

    // fills first
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

    for it in its {
      if it.kind == "seg" {
        let c = if it.color == none { _v-ink } else { it.color }
        let a = X(it.from)
        let b = X(it.to)
        _abs-line(a, b, (
          paint: c,
          thickness: it.width,
          dash: if it.dashed { "dashed" } else { none },
        ))
        if it.label != none {
          TXT(
            _shaft-label-pos(a, b, it.anchor, it.gap, it.side, it.off, ctr),
            it.label,
          )
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
        if it.label != none {
          TXT(
            _shaft-label-pos(a, b, it.anchor, it.gap, it.side, it.off, ctr),
            it.label,
            color: c,
          )
        }
      }
    }

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
          cw,
          ch,
        )
      }
    }

    for it in its {
      if it.kind == "pt" {
        let c = if it.color == none { _v-ink } else { it.color }
        let p = X(it.pos)
        _abs-dot(p, c, it.r, it.hollow)
        if it.label != none {
          let q = if it.off == auto {
            let d = _outward(p, ctr)
            let g = _f(it.gap)
            (p.at(0) + g * d.at(0), p.at(1) + g * d.at(1))
          } else {
            (p.at(0) + _f(it.off.at(0)), p.at(1) + _f(it.off.at(1)))
          }
          TXT(q, it.label)
        }
      }
    }

    for it in its {
      if it.kind == "txt" {
        let p = X(it.pos)
        TXT(
          (p.at(0) + _f(it.off.at(0)), p.at(1) + _f(it.off.at(1))),
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
//  The canvas sizes itself from every world point in the scene plus
//  the axis tips, so you set the scene, not a width.
//
//  ground: true shades the three coordinate planes in the first
//  octant. ground-lo lets a face reach into negative coordinates —
//  needed because a line can meet the boundary of a convex region in
//  at most two points, so at most TWO of a line's three trace points
//  can ever lie in the first octant.
// ════════════════════════════════════════════════════════════
#let space3d(
  ..items,
  unit: 0.62cm,
  alpha: PROJ-ALPHA,
  k: PROJ-K,
  axes: true,
  axis-len: (4, 5, 4),
  ticks: true,
  ground: false,
  ground-frac: 0.78,
  ground-lo: (0, 0, 0),
  ground-fill: none,
  grid: false,
  grid-step: auto,
  grid-color: none,
  pad: 1.0cm,
) = align(center, {
  let u = unit.pt()
  let its = items.pos()
  let pd = pad.pt()
  let ca = calc.cos(alpha)
  let sa = calc.sin(alpha)

  let P0(p) = (
    (p.at(1) - k * p.at(0) * ca) * u,
    -(p.at(2) - k * p.at(0) * sa) * u,
  )

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
  if ground {
    // all eight corners of the shaded region, not just two: the
    // projection is monotone in each coordinate, so the extreme
    // screen points can come from mixed corners such as (xmax, ymin)
    let gs = (
      (ground-lo.at(0), axis-len.at(0) * ground-frac),
      (ground-lo.at(1), axis-len.at(1) * ground-frac),
      (ground-lo.at(2), axis-len.at(2) * ground-frac),
    )
    for i in (0, 1) {
      for j in (0, 1) {
        for m in (0, 1) {
          pts.push((gs.at(0).at(i), gs.at(1).at(j), gs.at(2).at(m)))
        }
      }
    }
  }
  if pts.len() == 0 { pts = ((0, 0, 0),) }

  let sp = pts.map(P0)
  let minx = calc.min(..sp.map(p => p.at(0)))
  let maxx = calc.max(..sp.map(p => p.at(0)))
  let miny = calc.min(..sp.map(p => p.at(1)))
  let maxy = calc.max(..sp.map(p => p.at(1)))

  let cw = maxx - minx + 2 * pd
  let ch = maxy - miny + 2 * pd
  let ctr = (cw / 2, ch / 2)

  let X(p) = {
    let q = P0(p)
    (q.at(0) - minx + pd, q.at(1) - miny + pd)
  }
  let TXT(p, body, ..a) = _abs-txt(p, body, cw, ch, ..a)

  box(width: _pt(cw), height: _pt(ch), {
    // ── shaded coordinate planes, under everything ──
    if ground {
      let gx = axis-len.at(0) * ground-frac
      let gy = axis-len.at(1) * ground-frac
      let gz = axis-len.at(2) * ground-frac
      let lx = ground-lo.at(0)
      let ly = ground-lo.at(1)
      let lz = ground-lo.at(2)
      let gc = if ground-fill == none { luma(236) } else { ground-fill }
      let faces = (
        ((lx, ly, 0), (gx, ly, 0), (gx, gy, 0), (lx, gy, 0)),
        ((lx, 0, lz), (gx, 0, lz), (gx, 0, gz), (lx, 0, gz)),
        ((0, ly, lz), (0, gy, lz), (0, gy, gz), (0, ly, gz)),
      )
      for f in faces { _abs-poly(f.map(X), fill: gc, stroke: none) }
    }

    // ── graph-paper gridlines ──
    // Plain screen-space horizontal and vertical rules, NOT a
    // projected world grid: the point is to match the squared paper
    // the student is drawing on. Spacing defaults to half a world
    // unit, so at unit: 1cm the lines are 5 mm apart and the figure
    // can be copied square-for-square. The grid is aligned to the
    // projected origin so (0,0,0) always lands on an intersection.
    // Drawn over the shaded planes and under the axes.
    if grid {
      let step = if grid-step == auto { u / 2 } else { _f(grid-step) }
      let gcol = if grid-color == none { 0.4pt + luma(222) } else { grid-color }
      let o = X((0, 0, 0))
      if step > 0.5 {
        let x0 = o.at(0) - calc.floor(o.at(0) / step) * step
        let n = calc.floor((cw - x0) / step)
        for i in range(n + 1) {
          let xv = x0 + i * step
          _abs-line((xv, 0.0), (xv, ch), gcol)
        }
        let y0 = o.at(1) - calc.floor(o.at(1) / step) * step
        let m = calc.floor((ch - y0) / step)
        for j in range(m + 1) {
          let yv = y0 + j * step
          _abs-line((0.0, yv), (cw, yv), gcol)
        }
      }
    }

    if axes {
      let names = ($x$, $y$, $z$)
      let tips = (
        (axis-len.at(0), 0, 0),
        (0, axis-len.at(1), 0),
        (0, 0, axis-len.at(2)),
      )
      // label offsets pushed clear of the axis line itself
      let offs = ((-11, 6), (11, 2), (-2, -12))
      for i in range(3) {
        _abs-line(X((0, 0, 0)), X(tips.at(i)), _v-axis)
        let near = (
          tips.at(i).at(0) * 0.88,
          tips.at(i).at(1) * 0.88,
          tips.at(i).at(2) * 0.88,
        )
        _abs-head(X(near), X(tips.at(i)), _v-ink, 5pt)
        let tp = X(tips.at(i))
        TXT(
          (tp.at(0) + offs.at(i).at(0), tp.at(1) + offs.at(i).at(1)),
          names.at(i),
        )
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

    for it in its {
      if it.kind == "seg" {
        let c = if it.color == none { _v-ink } else { it.color }
        let a = X(it.from)
        let b = X(it.to)
        _abs-line(a, b, (
          paint: c,
          thickness: it.width,
          dash: if it.dashed { "dashed" } else { none },
        ))
        if it.label != none {
          TXT(
            _shaft-label-pos(a, b, it.anchor, it.gap, it.side, it.off, ctr),
            it.label,
          )
        }
      }
    }

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
          TXT(
            _shaft-label-pos(a, b, it.anchor, it.gap, it.side, it.off, ctr),
            it.label,
            color: c,
          )
        }
      }
    }

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
          cw,
          ch,
        )
      }
    }

    for it in its {
      if it.kind == "pt" {
        let c = if it.color == none { _v-ink } else { it.color }
        let p = X(it.pos)
        _abs-dot(p, c, it.r, it.hollow)
        if it.label != none {
          let q = if it.off == auto {
            let d = _outward(p, ctr)
            let g = _f(it.gap)
            (p.at(0) + g * d.at(0), p.at(1) + g * d.at(1))
          } else {
            (p.at(0) + _f(it.off.at(0)), p.at(1) + _f(it.off.at(1)))
          }
          TXT(q, it.label)
        }
      }
    }

    for it in its {
      if it.kind == "txt" {
        let p = X(it.pos)
        TXT(
          (p.at(0) + _f(it.off.at(0)), p.at(1) + _f(it.off.at(1))),
          it.body,
          size: it.size,
          color: if it.color == none { _v-ink } else { it.color },
        )
      }
    }
  })
})

// ────────────────────────────────────────────────────────────
//  SCENE BUILDERS — return arrays of items; splat them in:
//    #space3d(..plane-patch(...), s-pt(...))
// ────────────────────────────────────────────────────────────

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

#let plane-intercepts(p, q, r, fill: none, stroke-color: none) = (
  s-poly(
    ((p, 0, 0), (0, q, 0), (0, 0, r)),
    fill: if fill == none { _soft(accent-bg, amt: 25%) } else { fill },
    stroke-color: if stroke-color == none { accent } else { stroke-color },
    width: 1pt,
  ),
)

#let line3(
  a,
  v,
  tmin: -1.5,
  tmax: 2.5,
  color: none,
  label: none,
  anchor: 0.85,
) = {
  let at(t) = range(3).map(i => a.at(i) + t * v.at(i))
  let c = if color == none { def-col } else { color }
  (
    s-seg(
      from: at(tmin),
      to: at(tmax),
      color: c,
      width: 1pt,
      label: label,
      anchor: anchor,
    ),
  )
}

// ════════════════════════════════════════════════════════════
//  cube — the spatial-reasoning workhorse
// ════════════════════════════════════════════════════════════
//
//  Vertices, German school convention (bottom ABCD counterclockwise
//  seen from above, top EFGH directly over them):
//     A (a,0,0)  B (a,a,0)  C (0,a,0)  D (0,0,0)
//     E (a,0,a)  F (a,a,a)  G (0,a,a)  H (0,0,a)
//  D is hidden behind the solid, so DA, DC, DH are the dashed edges.
//
//  Vertex labels are hand-placed rather than pushed radially outward,
//  because a pure outward rule sends D's label toward A and F's
//  toward G — those pairs sit on the same ray from the cube's centre.
// ════════════════════════════════════════════════════════════
// A rectangular solid: dx deep (along x, toward the viewer), dy wide
// (along y), dz high (along z). The cube is the case dx = dy = dz.
#let box-pts(dx: 4, dy: 4, dz: 4) = (
  A: (dx, 0, 0),
  B: (dx, dy, 0),
  C: (0, dy, 0),
  D: (0, 0, 0),
  E: (dx, 0, dz),
  F: (dx, dy, dz),
  G: (0, dy, dz),
  H: (0, 0, dz),
)

#let cube-pts(a: 4) = box-pts(dx: a, dy: a, dz: a)

#let edge-pt(p, q, t) = range(3).map(i => p.at(i) + t * (q.at(i) - p.at(i)))

#let box-edges(
  dx: 4,
  dy: 4,
  dz: 4,
  color: none,
  hidden-color: none,
  labels: true,
) = {
  let V = box-pts(dx: dx, dy: dy, dz: dz)
  let c = if color == none { luma(55) } else { color }
  let hc = if hidden-color == none { _v-hidden } else { hidden-color }
  let solid = (
    ("A", "B"),
    ("B", "C"),
    ("E", "F"),
    ("F", "G"),
    ("G", "H"),
    ("H", "E"),
    ("A", "E"),
    ("B", "F"),
    ("C", "G"),
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
    // Offsets are of the label's CENTRE from the vertex, in points,
    // screen y downward. A/D and F/G are nudged off the radial line
    // so the near and far vertex of each pair do not collide.
    let offs = (
      A: (-11, 5),
      B: (9, 7),
      C: (11, 2),
      D: (-11, -4),
      E: (-11, -2),
      F: (10, 6),
      G: (10, -6),
      H: (-7, -9),
    )
    for name in ("A", "B", "C", "D", "E", "F", "G", "H") {
      out.push(s-txt(
        V.at(name),
        text(weight: "bold")[#name],
        off: (offs.at(name).at(0) * 1pt, offs.at(name).at(1) * 1pt),
      ))
    }
  }
  out
}

#let cube-edges(
  a: 4,
  color: none,
  hidden-color: none,
  labels: true,
) = box-edges(
  dx: a,
  dy: a,
  dz: a,
  color: color,
  hidden-color: hidden-color,
  labels: labels,
)

#let box3(
  ..items,
  dx: 4,
  dy: 4,
  dz: 4,
  labels: true,
  unit: 0.62cm,
  alpha: PROJ-ALPHA,
  k: PROJ-K,
  grid: false,
  grid-step: auto,
  pad: 0.8cm,
) = space3d(
  ..box-edges(dx: dx, dy: dy, dz: dz, labels: labels),
  ..items.pos(),
  axes: false,
  unit: unit,
  alpha: alpha,
  k: k,
  grid: grid,
  grid-step: grid-step,
  pad: pad,
)

#let cube(
  ..items,
  a: 4,
  labels: true,
  unit: 0.62cm,
  alpha: PROJ-ALPHA,
  k: PROJ-K,
  grid: false,
  grid-step: auto,
  pad: 0.8cm,
) = space3d(
  ..cube-edges(a: a, labels: labels),
  ..items.pos(),
  axes: false,
  unit: unit,
  alpha: alpha,
  k: k,
  grid: grid,
  grid-step: grid-step,
  pad: pad,
)
