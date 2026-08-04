// ════════════════════════════════════════════════════════════
//  fig-lab.typ — visual test sheet for vec-figures.typ
// ════════════════════════════════════════════════════════════
//
//  Put this and vec-figures.typ in  src/units/vectors/  and compile:
//
//      typst compile --root . src/units/vectors/fig-lab.typ
//
//  (--root matters, per STYLE_GUIDE §8 — without it the
//  ../../common/preamble.typ import is rejected.)
//
//  Each panel is captioned with what to look for. Mark up the PDF
//  or just tell me which numbers are wrong and I will retune.
// ════════════════════════════════════════════════════════════

#import "../../common/preamble.typ": *
#import "vec-figures.typ": *

#set page(paper: "a4", margin: 2cm, numbering: "1")
#set text(font: "Helvetica Neue", size: 10pt)
#set par(justify: true)
#show heading.where(level: 1): it => block(
  above: 1.4em,
  below: 0.7em,
  text(size: 13pt, weight: "bold", fill: accent, it.body),
)
#show heading.where(level: 2): it => block(
  above: 1em,
  below: 0.5em,
  text(size: 10.5pt, weight: "bold", fill: def-col, it.body),
)

#let check(body) = block(
  width: 100%,
  inset: (x: 8pt, y: 6pt),
  fill: luma(246),
  radius: 3pt,
  text(size: 8.5pt, fill: luma(90), body),
)

#align(center)[
  #text(size: 16pt, weight: "bold", fill: accent)[Figure helper test sheet]
  #v(-4pt)
  #text(size: 9pt, fill: luma(110))[
    Vectors unit · `vec-figures.typ` v#vec-figures-version
  ]
]

#v(6pt)

= 1 · The 2D plane

== 1.1 A vector in standard position, and the same vector moved

#vplane(
  s-vec(to: (3, 2), label: $vec(v)$),
  s-vec(from: (1, -1), to: (4, 1), label: $vec(v)$, color: ex-col, dashed: true),
  xmin: -0.5,
  xmax: 5.5,
  ymin: -1.5,
  ymax: 3.5,
)

#check[
  *Look for:* arrowheads that sit exactly on $(3,2)$ and $(4,1)$ with no
  overshoot; labels clear of the arrow shaft; the dashed copy visibly
  parallel and the same length. Tick numerals on both axes, none at the
  origin.
]

== 1.2 Two points and the vector between them

#vplane(
  s-pt((1, 1), label: $A$, off: (-14pt, 2pt)),
  s-pt((5, 3), label: $B$, off: (5pt, -4pt)),
  s-vec(from: (1, 1), to: (5, 3), label: $arrow(A B)$),
  s-vec(to: (1, 1), label: $vec(r)_A$, color: ex-col, off: (-2pt, 4pt)),
  s-vec(to: (5, 3), label: $vec(r)_B$, color: ex-col, off: (2pt, 8pt)),
  xmin: -0.5,
  xmax: 6.5,
  ymin: -0.5,
  ymax: 4.5,
)

#check[
  *Look for:* three arrows meeting cleanly at $A$ and $B$; the two
  position-vector labels not colliding with $arrow(A B)$. This is the
  figure that carries "endpoint minus starting point," so the triangle
  must read at a glance.
]

== 1.3 Addition: triangle rule and parallelogram rule

#grid(
  columns: (1fr, 1fr),
  column-gutter: 8pt,
  vplane(
    s-vec(to: (3, 1), label: $vec(u)$, off: (0pt, 4pt)),
    s-vec(from: (3, 1), to: (4, 4), label: $vec(v)$, color: warn-col),
    s-vec(to: (4, 4), label: $vec(u) + vec(v)$, color: def-col, off: (-30pt, -4pt)),
    xmin: -0.5, xmax: 5.5, ymin: -0.5, ymax: 4.5, unit: 0.68cm,
  ),
  vplane(
    s-poly(
      ((0, 0), (3, 1), (4, 4), (1, 3)),
      fill: rgb("#eef0fa"),
      stroke-color: luma(180),
      dashed: true,
    ),
    s-vec(to: (3, 1), label: $vec(u)$, off: (0pt, 4pt)),
    s-vec(to: (1, 3), label: $vec(v)$, color: warn-col, off: (-16pt, -2pt)),
    s-vec(to: (4, 4), label: $vec(u) + vec(v)$, color: def-col, off: (-30pt, -4pt)),
    xmin: -0.5, xmax: 5.5, ymin: -0.5, ymax: 4.5, unit: 0.68cm,
  ),
)

#check[
  *Look for:* the shaded parallelogram sitting *behind* all three arrows,
  not over them. If the fill covers an arrow the draw order is wrong and
  I need to know.
]

== 1.4 Scalar multiples

#vplane(
  s-vec(to: (2, 1), label: $vec(u)$, off: (0pt, 3pt)),
  s-vec(to: (4, 2), label: $2 vec(u)$, color: def-col, off: (2pt, -14pt)),
  s-vec(to: (-2, -1), label: $-vec(u)$, color: warn-col, off: (-18pt, 2pt)),
  xmin: -3.5,
  xmax: 5.5,
  ymin: -2.5,
  ymax: 3.5,
)

#check[
  *Look for:* $vec(u)$ drawn *on top of* $2vec(u)$ (shorter arrow visible
  against the longer one), and the negative multiple pointing back through
  the origin.
]

== 1.5 Angle between two vectors, and a right angle

#grid(
  columns: (1fr, 1fr),
  column-gutter: 8pt,
  vplane(
    s-vec(to: (4, 1), label: $vec(a)$, off: (0pt, 4pt)),
    s-vec(to: (1, 3), label: $vec(b)$, color: warn-col, off: (-14pt, -2pt)),
    s-arc(vertex: (0, 0), from: (4, 1), to: (1, 3), r: 20pt, label: $phi.alt$),
    xmin: -0.5, xmax: 4.5, ymin: -0.5, ymax: 3.5, unit: 0.72cm,
  ),
  vplane(
    s-vec(to: (3, 1), label: $vec(a)$, off: (0pt, 4pt)),
    s-vec(to: (-1, 3), label: $vec(b)$, color: warn-col, off: (-16pt, 0pt)),
    s-arc(
      vertex: (0, 0), from: (3, 1), to: (-1, 3),
      r: 16pt, right: true, color: warn-col,
    ),
    xmin: -2.5, xmax: 4.5, ymin: -0.5, ymax: 3.5, unit: 0.72cm,
  ),
)

#check[
  *Look for:* the arc opening on the *inside* of the two arrows (not the
  reflex side), $phi.alt$ sitting on the bisector, and the right-angle mark
  reading as the booklet's quarter-arc-plus-dot — dot centered inside the
  arc, neither crowding the vertex nor sitting outside it.
]

= 2 · The 3D scene

== 2.1 Axes, a point, its position vector, and the drop to the base plane

#space3d(
  s-vec(to: (3, 4, 3), label: $vec(r)_P$, off: (-24pt, -6pt)),
  s-pt((3, 4, 3), label: $P$, off: (5pt, -14pt)),
  s-seg(from: (3, 4, 0), to: (3, 4, 3), dashed: true, color: luma(150)),
  s-seg(from: (3, 0, 0), to: (3, 4, 0), dashed: true, color: luma(150)),
  s-seg(from: (0, 4, 0), to: (3, 4, 0), dashed: true, color: luma(150)),
  s-pt((3, 4, 0), label: $P'$, off: (4pt, 2pt), r: 1.8pt),
  axis-len: (4.2, 5.2, 4),
)

#check[
  *This is the single most important panel.* Everything else in the unit
  is drawn on top of these axes. Check: does the $x$-axis run down-left at
  a believable angle? Is the foreshortening ($k=0.5$) enough that a cube
  looks like a cube rather than a slab? Are the unit dots on the axes
  visible but not noisy? Tell me if you would rather have short tick
  strokes than dots.
]

== 2.2 The same scene at three projection settings

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 4pt,
  align(center)[
    #space3d(
      s-vec(to: (3, 4, 3)), s-pt((3, 4, 3)),
      axis-len: (4, 5, 4), alpha: 30deg, k: 0.5, unit: 0.5cm,
    )
    #text(size: 8pt, fill: luma(110))[`alpha: 30deg, k: 0.5`]
  ],
  align(center)[
    #space3d(
      s-vec(to: (3, 4, 3)), s-pt((3, 4, 3)),
      axis-len: (4, 5, 4), alpha: 42deg, k: 0.5, unit: 0.5cm,
    )
    #text(size: 8pt, fill: luma(110))[`alpha: 42deg, k: 0.5` (default)]
  ],
  align(center)[
    #space3d(
      s-vec(to: (3, 4, 3)), s-pt((3, 4, 3)),
      axis-len: (4, 5, 4), alpha: 45deg, k: 0.7, unit: 0.5cm,
    )
    #text(size: 8pt, fill: luma(110))[`alpha: 45deg, k: 0.7`]
  ],
)

#check[
  *Pick one.* Whichever you choose becomes the default for the whole unit,
  including every exercise that asks students to sketch — so it should
  match what you draw on the board.
]

== 2.3 A line in space with its trace points

#space3d(
  ..line3((5, 4, -15), (5, -1, 3), tmin: 2.6, tmax: 4.4),
  s-pt((15, 2, -9), label: $S_z$, off: (4pt, 2pt), color: warn-col),
  axis-len: (6, 6, 5),
  unit: 0.42cm,
)

#check[
  *Look for:* nothing here is expected to be beautiful yet — this panel
  exists to check that `line3` clips sensibly and that a scene whose
  points run well outside the axis box still sizes its canvas correctly
  (no clipped arrowheads, no runaway page width).
]

== 2.4 A plane: intercept triangle and parallelogram patch

#grid(
  columns: (1fr, 1fr),
  column-gutter: 8pt,
  align(center)[
    #space3d(
      ..plane-intercepts(4, 5, 3),
      s-pt((4, 0, 0), label: $S_x$, off: (-16pt, 4pt), r: 1.8pt),
      s-pt((0, 5, 0), label: $S_y$, off: (3pt, 2pt), r: 1.8pt),
      s-pt((0, 0, 3), label: $S_z$, off: (-16pt, -6pt), r: 1.8pt),
      axis-len: (5, 6, 4), unit: 0.5cm,
    )
    #text(size: 8pt, fill: luma(110))[intercept form]
  ],
  align(center)[
    #space3d(
      ..plane-patch((1, 2, 1), (2, 0, 1), (0, 2, 1), lo: -0.8, hi: 1.8),
      s-vec(from: (1, 2, 1), to: (3, 2, 2), color: warn-col, label: $vec(u)$),
      s-vec(from: (1, 2, 1), to: (1, 4, 2), color: def-col, label: $vec(v)$),
      s-pt((1, 2, 1), label: $A$, off: (-13pt, 0pt)),
      axis-len: (4, 6, 4), unit: 0.5cm,
    )
    #text(size: 8pt, fill: luma(110))[parametric form]
  ],
)

#check[
  *Look for:* the translucent fill — do the axes show through it? If the
  `.transparentize()` call failed you will see an opaque green patch
  hiding whatever is behind it, and I will swap in a flat light color.
  Also: are the two direction arrows readable *on* the patch?
]

== 2.5 Normal vector on a plane

#space3d(
  ..plane-patch((2, 2.5, 1), (2, 0, 0), (0, 2, 0), lo: -1, hi: 1),
  s-vec(from: (2, 2.5, 1), to: (2, 2.5, 3.5), color: warn-col, label: $vec(n)$),
  s-pt((2, 2.5, 1), label: $A$, off: (-13pt, 4pt)),
  s-arc(
    vertex: (2, 2.5, 1), from: (2, 2.5, 3.5), to: (4, 2.5, 1),
    r: 13pt, right: true, color: warn-col,
  ),
  axis-len: (4.5, 5.5, 4.5),
  unit: 0.55cm,
)

#check[
  *Look for:* the right-angle mark reading as a right angle *in the
  projection*, which is what a hand-drawn figure does too. It will not sit
  at 90° on the page — confirm it still reads correctly to you.
]

== 2.6 Shaded coordinate planes, and a line's trace points

#space3d(
  ..line3((1, -3, 3), (1, 1, -3), tmin: -0.6, tmax: 2.4, color: def-col),
  s-pt((2, -2, 0), label: $S_z$, off: (4pt, 4pt), color: warn-col, r: 2pt),
  s-pt((0, -4, 6), label: $S_x$, off: (-16pt, -6pt), color: warn-col, r: 2pt),
  s-pt((4, 0, -6), label: $S_y$, off: (4pt, 2pt), color: warn-col, r: 2pt),
  ground: true,
  axis-len: (4.5, 5, 6),
  unit: 0.5cm,
)

#check[
  *This is the trace-point figure*, drawn from a real line
  ($vec(r) = (1, -3, 3) + t dot (1, 1, -3)$, your Exercise 41a), so the
  three marked points are the actual answers. Check that the shading
  makes it obvious *which plane each $S$ lies in* — that is the whole job
  of the gray. If the octant faces are too dark, too light, or the wrong
  size against the axes, say so: `ground-frac` and `ground-fill` are the
  knobs.

  Also confirm the naming reads correctly here: the subscript is the
  coordinate that *vanishes*, so $S_z$ sits in the $x y$‑plane.
]

= 3 · Cubes (Chapter 0 — spatial reasoning)

== 3.1 The plain labeled cube

#cube(a: 4)

#check[
  *Look for:* three dashed edges meeting at $D$, all eight labels legible
  and outside the body, and the whole thing reading unambiguously as a
  cube. Also check the letter placement against your own convention — I
  used bottom $A B C D$ counterclockwise from above, top $E F G H$
  directly above.
]

== 3.2 Two points on edges, and the line through them

#let V = cube-pts(a: 4)

#cube(
  a: 4,
  s-pt(edge-pt(V.A, V.E, 0.35), label: [*A*], off: (5pt, -4pt), color: warn-col),
  s-pt(edge-pt(V.C, V.G, 0.75), label: [*B*], off: (-14pt, -6pt), color: warn-col),
  s-seg(
    from: edge-pt(V.A, V.E, 0.35),
    to: edge-pt(V.C, V.G, 0.75),
    color: warn-col,
    width: 1.1pt,
  ),
  labels: false,
)

#check[
  *This is your Cube-Lines worksheet.* The production version prints the
  cube with the two marked points and *no* connecting line — students draw
  it. So what matters here is that the marked points sit visibly *on* the
  edges and that the cube is big enough to draw inside. Is 4 units at
  `unit: 0.62cm` the right printed size, or should the worksheet cubes be
  larger?
]

== 3.3 A plane section through three edge points

#let P1 = edge-pt(V.A, V.B, 0.5)
#let P2 = edge-pt(V.B, V.F, 0.5)
#let P3 = edge-pt(V.G, V.H, 0.5)

#cube(
  a: 4,
  s-poly(
    (P1, P2, edge-pt(V.F, V.G, 1.0), P3, edge-pt(V.H, V.E, 0.5), edge-pt(V.E, V.A, 1.0)),
    fill: rgb("#f1eff9"),
    stroke-color: ai-col,
    width: 1.1pt,
  ),
  s-pt(P1, label: [*W*], off: (2pt, 5pt), color: ai-col, r: 1.8pt),
  s-pt(P2, label: [*Y*], off: (5pt, -4pt), color: ai-col, r: 1.8pt),
  s-pt(P3, label: [*Z*], off: (-14pt, -10pt), color: ai-col, r: 1.8pt),
  labels: false,
)

#check[
  *This is your Cube-Sections worksheet.* The polygon here is a guess at a
  plausible section, not a computed one — I will generate real sections
  from actual plane equations once the projection settings are locked.
  What I need from this panel: does a filled section polygon sitting over
  dashed hidden edges look right, or should the section be outline-only so
  the cube stays readable?
]

== 3.4 Cube with axes — the bridge from Chapter 0 to coordinates

#space3d(
  ..cube-edges(a: 4, labels: true),
  s-vec(to: (4, 4, 4), color: warn-col, label: $vec(r)_F$, off: (-24pt, 4pt)),
  axis-len: (5.5, 6, 5.5),
  unit: 0.55cm,
)

#check[
  *Look for:* the cube sitting in the corner of the axes with the axes
  still visible. This is the panel that does the actual pedagogical work
  of Chapter 0 → Chapter 1: the same cube students shaded by eye, now with
  coordinates on it.
]

= 4 · Things not yet built

Tell me which of these the unit actually needs and I will add them:

- *Force / ramp diagrams* — an inclined plane with a weight vector
  resolved into components. Needed for the ramp and boat problems.
- *The right-hand rule.* Hard to draw natively; this is my one candidate
  for an actual image file.
- *The two-lines classification quartet* (identical / parallel /
  intersecting / skew) — four small 3D panels side by side.
- *A flowchart helper* for the classification algorithm, or keep the
  existing exported PDF.
- *Angle between a line and a plane* — plane patch, line piercing it,
  normal, and two marked angles $alpha$ and $gamma$.
- *Plumb line onto a plane* — point, foot, reflected point.
