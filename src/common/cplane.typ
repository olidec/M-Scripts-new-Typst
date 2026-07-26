// ============================================================
//  cplane.typ — Gaussian-plane figures (cetz)
//
//  Lives in src/common/, next to preamble.typ, and is imported
//  SEPARATELY and only by chapters that actually draw a complex
//  plane:
//
//    #import "../../common/preamble.typ": *
//    #import "../../common/cplane.typ": *
//
//  Why not in preamble.typ? Because it pulls in cetz, and most
//  units never draw a plane. preamble.typ is imported by every
//  file in the project; a dependency only two or three units need
//  doesn't belong there. STYLE_GUIDE.md §7's rule ("promote a
//  twice-hand-coded diagram to a reusable helper") is satisfied
//  either way — the point of that rule is one shared definition
//  rather than near-duplicate copies, not specifically that the
//  definition live in preamble.typ. The complex-plane axes were
//  hand-copied into three separate chapter files in the LaTeX-era
//  script; that's exactly the duplication this module removes.
//
//  Vectors and conic sections will want the same axes machinery
//  later. If a third unit starts importing it, that's the signal
//  to generalize the axis labels (currently Re/Im) rather than
//  fork the file.
//
//  WHY NOT simple-plot: these figures need arbitrary text
//  annotation at arbitrary points, shaded half-planes and sectors,
//  open-vs-closed boundary markers, and angle arcs. simple-plot is
//  a function plotter; this is diagram drawing. plot-graph() in
//  preamble.typ remains the right tool for y = f(x) graphs, and
//  nothing here replaces it.
//
//  WHY EVERY DRAW CALL IS WRITTEN cetz.draw.something(...):
//  because `import cetz.draw: *` inside a function body executes
//  AFTER that function's parameters are bound, and therefore
//  SHADOWS any parameter sharing a name with a cetz.draw export.
//  cetz.draw exports both `grid` and `anchor`, so a helper with a
//  `grid: true` or `anchor: "south-west"` parameter silently reads
//  the cetz function instead of the argument and fails with
//  "expected boolean, found function". Qualified calls have no such
//  failure mode, cost one prefix, and additionally keep cetz's
//  `line` / `circle` / `rect` / `content` / `grid` / `scale` /
//  `rotate` out of the module scope — which matters, because
//  chapters do `#import "cplane.typ": *` and would otherwise have
//  cetz's versions shadow the Typst built-ins of the same names.
//
//  WHY NO cetz arc(): cetz anchors arc() at the arc's START point,
//  not its center, so arc((0,0), start: 0deg, stop: 60deg,
//  radius: 4) draws an arc centered at (-4, 0) — which is what the
//  old script's angle markers and its shaded sector actually did.
//  Every curved thing here is built from an explicit polyline
//  instead: exact geometry, no dependence on cetz's anchoring
//  conventions, and one less thing to break on a version bump.
//
//  VERSION POLICY: pinned, same reasoning as simple-plot in
//  preamble.typ. Read the changelog for behavior changes, not just
//  new features, before bumping, and re-check a handful of figures
//  afterward.
// ============================================================

#import "@preview/cetz:0.3.4"
#import "preamble.typ": accent, def-col, ex-col, expl-col, fig, warn-col

// ── Figure style constants ───────────────────────────────────
#let cp-axis-stroke = (paint: black, thickness: 1.2pt)
#let cp-grid-stroke = (paint: luma(190), thickness: 0.4pt, dash: "dashed")
#let cp-tick = 0.1 // half-length of an axis tick, in canvas units
#let cp-dot-r = 0.09 // radius of a filled point marker
#let cp-samples = 64 // polyline segments per full turn

// Axis labels. BOLD UPRIGHT Roman — deliberately different from the
// Re(z) / Im(z) operator that appears in running text (defined in
// preamble.typ), for two reasons:
//   • Role. On the plane, "Re" names the axis; in a sentence, Re(z)
//     takes a part. Bold marks the label as a name, not a stray
//     operator, and stops the eye reading the axis tick "3" as an
//     argument to it.
//   • Legibility. Figure text renders at 8–9pt; bold survives the
//     downscale where a thin italic would not.
// Defined here as literal strings, NOT imported from preamble's Re/Im
// operators. That is on purpose: an axis label is a glyph, not the
// part-taking operator, and — the trap that shipped in the first
// draft — writing bare `$Re$` in THIS module's scope (which does not
// import the operator) silently renders the italic product "R e".
// A literal `$bold("Re")$` cannot regress that way.
// To switch the house style to non-bold upright, drop the bold():
//   #let cp-re-label = $"Re"$   /   #let cp-im-label = $"Im"$
#let cp-re-label = $bold("Re")$
#let cp-im-label = $bold("Im")$

// Accept either a Typst angle (60deg, the readable form) or a bare
// float in radians (calc.pi / 3, convenient when the angle comes out
// of a calculation). Everything internal works in radians.
#let _rad(a) = if type(a) == angle { a.rad() } else { float(a) }

// Build a stroke dict, optionally dashed. Used by every helper that
// draws a boundary, so that "dashed = excluded" stays one decision.
#let _stroke(color, thickness, dashed) = {
  let st = (paint: color, thickness: thickness)
  if dashed { st.insert("dash", "dashed") }
  st
}

// ── Axes, grid, ticks ────────────────────────────────────────
// Called automatically by cplane(); exposed separately only for the
// rare figure that needs to draw something UNDER the grid.
#let cp-axes(
  xmin: -4.5,
  xmax: 4.5,
  ymin: -4.5,
  ymax: 4.5,
  show-grid: true,
  show-ticks: true,
  x-label: cp-re-label,
  y-label: cp-im-label,
) = {
  // Floats throughout: cetz reads a bare negative integer in a
  // coordinate tuple as a named-anchor reference, not a number.
  let xmn = float(xmin)
  let xmx = float(xmax)
  let ymn = float(ymin)
  let ymx = float(ymax)
  // Gridlines and ticks sit on integers INSIDE the bounds, so
  // half-unit bounds (house style, STYLE_GUIDE.md §6) work as
  // intended: the outermost gridline stays clear of the border.
  let xs = range(calc.ceil(xmn), calc.floor(xmx) + 1)
  let ys = range(calc.ceil(ymn), calc.floor(ymx) + 1)

  if show-grid {
    for k in xs {
      cetz.draw.line((x: float(k), y: ymn), (x: float(k), y: ymx), stroke: cp-grid-stroke)
    }
    for k in ys {
      cetz.draw.line((x: xmn, y: float(k)), (x: xmx, y: float(k)), stroke: cp-grid-stroke)
    }
  }

  cetz.draw.line(
    (x: xmn, y: 0.0),
    (x: xmx, y: 0.0),
    stroke: cp-axis-stroke,
    mark: (end: "straight"),
  )
  cetz.draw.line(
    (x: 0.0, y: ymn),
    (x: 0.0, y: ymx),
    stroke: cp-axis-stroke,
    mark: (end: "straight"),
  )
  cetz.draw.content((x: xmx, y: 0.0), x-label, anchor: "north-west", padding: 4pt)
  cetz.draw.content((x: 0.0, y: ymx), y-label, anchor: "south-east", padding: 4pt)

  if show-ticks {
    for k in xs {
      if k == 0 { continue }
      cetz.draw.line(
        (x: float(k), y: -cp-tick),
        (x: float(k), y: cp-tick),
        stroke: cp-axis-stroke,
      )
      cetz.draw.content(
        (x: float(k), y: -cp-tick),
        text(size: 7.5pt)[#k],
        anchor: "north",
        padding: 3pt,
      )
    }
    for k in ys {
      if k == 0 { continue }
      cetz.draw.line(
        (x: -cp-tick, y: float(k)),
        (x: cp-tick, y: float(k)),
        stroke: cp-axis-stroke,
      )
      cetz.draw.content(
        (x: -cp-tick, y: float(k)),
        text(size: 7.5pt)[#k],
        anchor: "east",
        padding: 3pt,
      )
    }
    cetz.draw.content(
      (x: -cp-tick, y: -cp-tick),
      text(size: 7.5pt)[$0$],
      anchor: "north-east",
      padding: 2pt,
    )
  }
}

// ── The canvas wrapper ───────────────────────────────────────
//  #cplane(
//    xmin: -3.5, xmax: 4.5,
//    caption: [...],
//    {
//      cp-point(3, 2, label: $z = 3 + 2i$)
//      cp-vector(3, 2)
//    },
//  )
//
//  NOTE the body is a CODE block { ... }, not a content block [ ... ].
//  Every cp-* helper returns cetz element data (an array), not
//  content; a code block joins those arrays into the single array
//  cetz.canvas expects, whereas a content block would wrap them in a
//  sequence cetz can't draw. Same reason the plain cetz examples in
//  the wild are all written cetz.canvas({ ... }).
//
//  Body content is drawn ON TOP of the axes, in the order given.
//  length: is the size of one unit on the page — shrink it, don't
//  scale the whole figure, when a plane has to fit in a solution box.
//
//  Like fig() and plot-graph() in preamble.typ, this is NOT wrapped
//  in only-theory: a plane is as often part of an exercise or its
//  solution as of theory prose. Wrap the call yourself where you
//  want it gone from the sheet.
#let cplane(
  body,
  xmin: -4.5,
  xmax: 4.5,
  ymin: -4.5,
  ymax: 4.5,
  show-grid: true,
  show-ticks: true,
  x-label: cp-re-label,
  y-label: cp-im-label,
  length: 0.75cm,
  caption: none,
) = fig(
  cetz.canvas(
    length: length,
    {
      cp-axes(
        xmin: xmin,
        xmax: xmax,
        ymin: ymin,
        ymax: ymax,
        show-grid: show-grid,
        show-ticks: show-ticks,
        x-label: x-label,
        y-label: y-label,
      )
      body
    },
  ),
  caption: caption,
)

// Compact variant for diagrams inside a solution box, where a
// full-size plane would swamp the text around it.
#let cplane-small = cplane.with(length: 0.45cm, show-ticks: false)

// ── Points and labels ────────────────────────────────────────
// filled: false draws a hollow marker — the standard notation for an
// EXCLUDED point (the tip of an open ray, a puncture in a region).
#let cp-point(
  a,
  b,
  label: none,
  anchor: "south-west",
  color: accent,
  filled: true,
  size: cp-dot-r,
) = {
  cetz.draw.circle(
    (x: float(a), y: float(b)),
    radius: size,
    fill: if filled { color } else { white },
    stroke: if filled { none } else { 1pt + color },
  )
  if label != none {
    cetz.draw.content(
      (x: float(a), y: float(b)),
      text(size: 9pt, fill: color, label),
      anchor: anchor,
      padding: 5pt,
    )
  }
}

// Free-standing annotation, unattached to any marker.
#let cp-label(x, y, body, color: black, anchor: "center", size: 8.5pt) = {
  cetz.draw.content(
    (x: float(x), y: float(y)),
    text(size: size, fill: color, body),
    anchor: anchor,
  )
}

// ── Vectors and segments ─────────────────────────────────────
#let cp-vector(
  a,
  b,
  from: (0, 0),
  color: accent,
  label: none,
  anchor: "south-west",
  thickness: 1.4pt,
  dashed: false,
) = {
  cetz.draw.line(
    (x: float(from.at(0)), y: float(from.at(1))),
    (x: float(a), y: float(b)),
    stroke: _stroke(color, thickness, dashed),
    mark: (end: "straight"),
  )
  if label != none {
    cetz.draw.content(
      (x: float(a), y: float(b)),
      text(size: 9pt, fill: color, label),
      anchor: anchor,
      padding: 6pt,
    )
  }
}

// A plain segment, no arrowhead. dashed: true is the house notation
// for an EXCLUDED boundary (strict inequality).
#let cp-segment(p, q, color: accent, dashed: false, thickness: 1.4pt) = {
  cetz.draw.line(
    (x: float(p.at(0)), y: float(p.at(1))),
    (x: float(q.at(0)), y: float(q.at(1))),
    stroke: _stroke(color, thickness, dashed),
  )
}

// An infinite line, given as a point and a direction, clipped to the
// stated bounds. Pass the SAME bounds as the enclosing cplane() call.
#let cp-line(
  through: (0, 0),
  direction: (1, 0),
  xmin: -4.5,
  xmax: 4.5,
  ymin: -4.5,
  ymax: 4.5,
  color: accent,
  dashed: false,
) = {
  let (px, py) = (float(through.at(0)), float(through.at(1)))
  let (dx, dy) = (float(direction.at(0)), float(direction.at(1)))
  // Longest parameter the box can possibly need, then clamp the
  // endpoints back inside it. Crude but exact enough for a diagram,
  // and it avoids a full Liang-Barsky clip for four lines of gain.
  let span = calc.max(
    float(xmax) - float(xmin),
    float(ymax) - float(ymin),
  ) * 2
  let n = calc.max(calc.sqrt(dx * dx + dy * dy), 1e-9)
  let (ux, uy) = (dx / n, dy / n)
  let clamp(v, lo, hi) = calc.max(lo, calc.min(hi, v))
  let p1 = (
    clamp(px - span * ux, float(xmin), float(xmax)),
    clamp(py - span * uy, float(ymin), float(ymax)),
  )
  let p2 = (
    clamp(px + span * ux, float(xmin), float(xmax)),
    clamp(py + span * uy, float(ymin), float(ymax)),
  )
  cp-segment(p1, p2, color: color, dashed: dashed)
}

// A ray from z0 in direction phi. open: true marks the excluded
// starting point with a hollow circle — arg(z - z0) = phi never
// includes z0 itself, since arg(0) is undefined.
#let cp-ray(
  a,
  b,
  phi,
  length: 4,
  color: accent,
  open: true,
  dashed: false,
) = {
  let t = _rad(phi)
  cetz.draw.line(
    (x: float(a), y: float(b)),
    (x: float(a) + length * calc.cos(t), y: float(b) + length * calc.sin(t)),
    stroke: _stroke(color, 1.4pt, dashed),
    mark: (end: "straight"),
  )
  if open {
    cp-point(a, b, filled: false, color: color, size: 0.1)
  }
}

// ── Circles, arcs, sectors, regions ──────────────────────────
#let cp-circle(
  a,
  b,
  r,
  color: accent,
  dashed: false,
  shade: false,
  center-dot: false,
  label: none,
  anchor: "north-west",
) = {
  cetz.draw.circle(
    (x: float(a), y: float(b)),
    radius: float(r),
    stroke: _stroke(color, 1.4pt, dashed),
    fill: if shade { color.transparentize(85%) } else { none },
  )
  if center-dot or label != none {
    cp-point(a, b, label: label, color: color, anchor: anchor)
  }
}

// Angle marker: a short arc from `start` to `stop` around (a, b),
// with an optional label placed just outside it. Built as a polyline
// (see the header note on cetz's arc()).
#let cp-angle(
  a,
  b,
  start,
  stop,
  radius: 0.7,
  color: def-col,
  label: none,
  label-scale: 1.45,
) = {
  let t0 = _rad(start)
  let t1 = _rad(stop)
  let n = calc.max(
    8,
    calc.ceil(cp-samples * calc.abs(t1 - t0) / (2 * calc.pi)),
  )
  let pts = range(n + 1).map(k => {
    let t = t0 + (t1 - t0) * k / n
    (x: float(a) + radius * calc.cos(t), y: float(b) + radius * calc.sin(t))
  })
  cetz.draw.line(..pts, stroke: (paint: color, thickness: 0.9pt))
  if label != none {
    // Placed on the bisector, just outside the arc. label-scale is
    // exposed because the default is tuned for a moderate angle; a
    // very acute or very obtuse one may want the label pushed out.
    let tm = (t0 + t1) / 2
    cp-label(
      float(a) + radius * label-scale * calc.cos(tm),
      float(b) + radius * label-scale * calc.sin(tm),
      label,
      color: color,
    )
  }
}

// Filled circular sector (a "pie slice") — the shape of an argument
// region such as {z : |z| <= r and 0 <= arg z <= pi/3}.
#let cp-sector(
  a,
  b,
  r,
  start,
  stop,
  color: accent,
  opacity: 85%,
) = {
  let t0 = _rad(start)
  let t1 = _rad(stop)
  let n = calc.max(
    8,
    calc.ceil(cp-samples * calc.abs(t1 - t0) / (2 * calc.pi)),
  )
  let rim = range(n + 1).map(k => {
    let t = t0 + (t1 - t0) * k / n
    (
      x: float(a) + float(r) * calc.cos(t),
      y: float(b) + float(r) * calc.sin(t),
    )
  })
  cetz.draw.line(
    (x: float(a), y: float(b)),
    ..rim,
    close: true,
    fill: color.transparentize(opacity),
    stroke: none,
  )
}

// Filled polygon through the given corners — half-planes, strips and
// compound regions are all just polygons clipped to the plot bounds,
// so pass the bounds' corners:
//   #cp-region((-4.5, 2), (3, 2), (3, 4.5), (-4.5, 4.5))
#let cp-region(..pts, color: accent, opacity: 85%) = {
  cetz.draw.line(
    ..pts.pos().map(p => (x: float(p.at(0)), y: float(p.at(1)))),
    close: true,
    fill: color.transparentize(opacity),
    stroke: none,
  )
}

// ── Parametric curves ────────────────────────────────────────
// The workhorse for the transformations chapter: any complex-valued
// function z(t) is a pair of real functions.
//   #cp-curve(t => t, t => t * t - 1, domain: (-2, 2))
#let cp-curve(
  fx,
  fy,
  domain: (0, 1),
  samples: 120,
  color: accent,
  dashed: false,
  thickness: 1.4pt,
) = {
  let (t0, t1) = (float(domain.at(0)), float(domain.at(1)))
  let pts = range(samples + 1).map(k => {
    let t = t0 + (t1 - t0) * k / samples
    (x: float(fx(t)), y: float(fy(t)))
  })
  cetz.draw.line(..pts, stroke: _stroke(color, thickness, dashed))
}

// Convenience: the curve traced by a complex-valued z(t) given as a
// single function returning an (a, b) pair — often the more natural
// way to write it once the algebra has been done in complex form.
//   #cp-complex-curve(t => (calc.cos(t), calc.sin(t)),
//                     domain: (0, 2 * calc.pi))
#let cp-complex-curve(z, ..args) = cp-curve(
  t => z(t).at(0),
  t => z(t).at(1),
  ..args,
)

// The unit circle, dashed and gray — the reference frame for every
// roots-of-unity picture.
#let cp-unit-circle(r: 1, color: luma(150)) = cp-circle(
  0,
  0,
  r,
  color: color,
  dashed: true,
)
