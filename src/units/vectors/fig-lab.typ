// ════════════════════════════════════════════════════════════
//  fig-lab.typ — visual test sheet for vec-figures.typ  (v4)
// ════════════════════════════════════════════════════════════
//
//      typst compile --root . src/units/vectors/fig-lab.typ
//
//  NOTE ON YOUR v3 EDITS: nearly all the manual `off:` values you
//  added have been DELETED, not kept. Labels are now centered on an
//  anchor near the arrowhead and pushed perpendicular to the shaft
//  automatically, so those offsets would double up. Panels 1.1–1.4
//  therefore need a fresh look even though you had them right.
// ════════════════════════════════════════════════════════════

#import "../../common/preamble.typ": *
#import "/src/common/vec-figures.typ": *

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

All four panels below use *no manual label offsets at all*. If a label
still lands badly, that is a defect in the automatic rule and I would
rather fix the rule than paper over it with an offset.

== 1.1 A vector in standard position, and the same vector moved

#vplane(
  s-vec(to: (3, 2), label: $arrow(v)$),
  s-vec(
    from: (1, -1),
    to: (4, 1),
    label: $arrow(v)$,
    color: ex-col,
    dashed: true,
  ),
  xmin: -0.5,
  xmax: 5.5,
  ymin: -1.5,
  ymax: 3.5,
)

== 1.2 Two points and the vector between them

#vplane(
  s-pt((1, 1), label: $A$),
  s-pt((5, 3), label: $B$),
  s-vec(from: (1, 1), to: (5, 3), label: $arrow(A B)$),
  s-vec(to: (1, 1), label: $arrow(r)_A$, color: ex-col),
  s-vec(to: (5, 3), label: $arrow(r)_B$, color: ex-col, anchor: 0.55),
  xmin: -0.5,
  xmax: 6.5,
  ymin: -0.5,
  ymax: 4.5,
)

#check[
  $arrow(r)_B$ is pulled back to `anchor: 0.55` so it does not crowd $B$;
  everything else is automatic. Check the two position-vector labels land
  on opposite sides of their shafts — the auto rule should push $arrow(r)_A$
  one way and $arrow(r)_B$ the other, since they lie on opposite sides of
  the figure's middle.
]

== 1.3 Addition: triangle rule and parallelogram rule

#grid(
  columns: (1fr, 1fr),
  column-gutter: 8pt,
  vplane(
    s-vec(to: (3, 1), label: $arrow(u)$),
    s-vec(from: (3, 1), to: (4, 4), label: $arrow(v)$, color: warn-col),
    s-vec(
      to: (4, 4),
      label: $arrow(u) + arrow(v)$,
      color: def-col,
      anchor: 0.5,
    ),
    xmin: -0.5,
    xmax: 5.5,
    ymin: -0.5,
    ymax: 4.5,
    unit: 0.68cm,
  ),
  vplane(
    s-poly(
      ((0, 0), (3, 1), (4, 4), (1, 3)),
      fill: rgb("#eef0fa"),
      stroke-color: luma(180),
      dashed: true,
    ),
    s-vec(to: (3, 1), label: $arrow(u)$),
    s-vec(to: (1, 3), label: $arrow(v)$, color: warn-col),
    s-vec(
      to: (4, 4),
      label: $arrow(u) + arrow(v)$,
      color: def-col,
      anchor: 0.55,
    ),
    xmin: -0.5,
    xmax: 5.5,
    ymin: -0.5,
    ymax: 4.5,
    unit: 0.68cm,
  ),
)

== 1.4 Scalar multiples

#vplane(
  s-vec(to: (4, 2), label: $2 arrow(u)$, color: def-col),
  s-vec(to: (2, 1), label: $arrow(u)$),
  s-vec(to: (-2, -1), label: $-arrow(u)$, color: warn-col),
  xmin: -3.5,
  xmax: 5.5,
  ymin: -2.5,
  ymax: 3.5,
)

#check[
  $2arrow(u)$ is now declared *first* so the shorter $arrow(u)$ draws on top
  of it. All three labels sit on the same side of the common line, which
  is what the auto rule does when everything is collinear — tell me if you
  would rather alternate them.
]

== 1.5 Angle between two vectors, and a right angle

#grid(
  columns: (1fr, 1fr),
  column-gutter: 8pt,
  vplane(
    s-vec(to: (4, 1), label: $arrow(a)$),
    s-vec(to: (1, 3), label: $arrow(b)$, color: warn-col),
    s-arc(vertex: (0, 0), from: (4, 1), to: (1, 3), r: 20pt, label: $phi.alt$),
    xmin: -0.5,
    xmax: 4.5,
    ymin: -0.5,
    ymax: 3.5,
    unit: 0.72cm,
  ),
  vplane(
    s-vec(to: (3, 1), label: $arrow(a)$),
    s-vec(to: (-1, 3), label: $arrow(b)$, color: warn-col),
    s-arc(
      vertex: (0, 0),
      from: (3, 1),
      to: (-1, 3),
      r: 16pt,
      right: true,
      color: warn-col,
    ),
    xmin: -2.5,
    xmax: 4.5,
    ymin: -0.5,
    ymax: 3.5,
    unit: 0.72cm,
  ),
)

#check[
  *The main test of the new rule.* Both vector labels should now sit on
  the far side of their arrows, outside the angle, near the arrowheads —
  with $phi.alt$ alone in the wedge between them.
]

= 2 · The 3D scene

== 2.1 Axes, a point, its position vector, and the drop to the base plane

#space3d(
  s-vec(to: (3, 4, 3), label: $arrow(r)_P$, anchor: 0.5),
  s-pt((3, 4, 3), label: $P$),
  s-seg(from: (3, 4, 0), to: (3, 4, 3), dashed: true, color: luma(150)),
  s-seg(from: (3, 0, 0), to: (3, 4, 0), dashed: true, color: luma(150)),
  s-seg(from: (0, 4, 0), to: (3, 4, 0), dashed: true, color: luma(150)),
  s-pt((3, 4, 0), label: $P'$, r: 1.8pt),
  axis-len: (4.2, 5.2, 4),
)

#check[
  Now drawn at the projection you chose: $alpha = 45 degree$,
  $k = 1 slash sqrt(2)$. $arrow(r)_P$ is at `anchor: 0.5` per your note.
]

== 2.2 The chosen projection at graph-paper scale

#grid(
  columns: (1fr, 1fr),
  column-gutter: 10pt,
  align(center)[
    #space3d(
      s-vec(to: (2, 3, 2), label: $arrow(r)_A$, anchor: 0.55),
      s-pt((2, 3, 2), label: $A$),
      axis-len: (3.5, 4.5, 3.5),
      unit: 1cm,
    )
    #text(size: 8pt, fill: luma(110))[`unit: 1cm` — one square = 1 unit]
  ],
  align(center)[
    #space3d(
      s-vec(to: (2, 3, 2), label: $arrow(r)_A$, anchor: 0.55),
      s-pt((2, 3, 2), label: $A$),
      axis-len: (3.5, 4.5, 3.5),
      unit: 0.62cm,
    )
    #text(size: 8pt, fill: luma(110))[`unit: 0.62cm` — print default]
  ],
)

#check[
  At `unit: 1cm` the figure is *literally reproducible on 5 mm paper*: two
  squares along $y$ and $z$, one square diagonal along $x$. That is exactly
  where $k = 1 slash sqrt(2)$ comes from, and it is worth saying out loud in
  `ch-vectors-intro` — it turns "here is how we draw 3D" into a rule
  students can follow with a ruler. Question: should the printed figures
  use `unit: 1cm` too, so students can measure them against their own
  sketches, or stay compact at `0.62cm`?
]

== 2.3 A line: point, direction vector, and the line itself

#space3d(
  ..line3((1, 1, 1), (1, 3, 2), tmin: -0.45, tmax: 1.2, color: luma(120)),
  s-vec(to: (1, 1, 1), label: $arrow(r)_A$, color: ex-col, anchor: 0.55),
  s-vec(from: (1, 1, 1), to: (2, 4, 3), label: $arrow(v)$, color: warn-col),
  s-pt((1, 1, 1), label: $A$),
  s-txt(
    (2.2, 4.6, 3.4),
    text(style: "italic", weight: "bold")[g],
    off: (12pt, 2pt),
  ),
  axis-len: (4, 5.5, 4.5),
)

#check[
  $g: arrow(r) = (1, 1, 1) + t dot (1, 3, 2)$ — direction skew to all three
  axes, as you asked. My previous pick had a direction vector that ran
  almost flat across the page, which made it read as a special case rather
  than a general line. This is the figure `ch-lines` actually needs:
  anchor point, direction vector, and the line through them.
]

== 2.4 A plane: intercept triangle and parametric patch

#grid(
  columns: (1fr, 1fr),
  column-gutter: 14pt,
  align(center)[
    #space3d(
      ..plane-intercepts(4, 5, 3),
      s-pt((4, 0, 0), label: $S_x$, off: (13pt, 9pt), r: 1.8pt),
      s-pt((0, 5, 0), label: $S_y$, off: (6pt, 12pt), r: 1.8pt),
      s-pt((0, 0, 3), label: $S_z$, off: (-14pt, -4pt), r: 1.8pt),
      axis-len: (5.5, 6.5, 4.2),
      unit: 0.6cm,
    )
    #text(size: 8pt, fill: luma(110))[intercept form]
  ],
  align(center)[
    #space3d(
      ..plane-patch((1, 2, 1), (2, 0, 1), (0, 2, 1), lo: -1, hi: 2.2),
      s-vec(from: (1, 2, 1), to: (3, 2, 2), color: warn-col, label: $arrow(u)$),
      s-vec(from: (1, 2, 1), to: (1, 4, 2), color: def-col, label: $arrow(v)$),
      s-pt((1, 2, 1), label: $A$),
      axis-len: (4, 6, 4.5),
      unit: 0.6cm,
    )
    #text(size: 8pt, fill: luma(110))[parametric form]
  ],
)

#check[
  Bigger `unit`, more padding, wider gutter, and the three intercept
  labels moved off the axis lines by hand — the auto rule pushes them
  radially outward, which for $S_x$ means straight into the $x$ label,
  since the intercept and the axis tip lie on the same ray. That is a
  known limit of the outward rule and the reason manual `off:` still
  exists. Confirm the axes now read through the shading rather than
  under it.
]

== 2.5 Normal vector on a plane

#space3d(
  ..plane-patch((2, 2.5, 1), (2, 0, 0), (0, 2, 0), lo: -1, hi: 1),
  s-vec(
    from: (2, 2.5, 1),
    to: (2, 2.5, 3.5),
    color: warn-col,
    label: $arrow(n)$,
  ),
  s-pt((2, 2.5, 1), label: $A$),
  s-arc(
    vertex: (2, 2.5, 1),
    from: (2, 2.5, 3.5),
    to: (2, 4.5, 1),
    r: 13pt,
    right: true,
    color: warn-col,
  ),
  axis-len: (4.5, 5.5, 4.5),
  unit: 0.6cm,
)

#check[
  The right angle is now marked against the *$y$-direction* in the plane
  instead of the $x$-direction. Since $y$ projects horizontally and
  $arrow(n)$ projects vertically, the mark comes out at a true $90 degree$
  on the page and the arc is a proper quarter — your point exactly. Worth
  writing into the style guide as a rule: *mark a right angle against
  whichever in-plane direction projects closest to perpendicular.*
]

== 2.6 Shaded coordinate planes and trace points

#space3d(
  ..line3((3, 2, -2), (-1, -1, 2), tmin: 0.3, tmax: 3.3, color: def-col),
  s-pt((2, 1, 0), label: $S_z$, color: warn-col, r: 2pt),
  s-pt((1, 0, 2), label: $S_y$, color: warn-col, r: 2pt),
  s-pt((0, -1, 4), label: $S_x$, color: warn-col, r: 2pt),
  ground: true,
  ground-lo: (0, -1.6, 0),
  axis-len: (4, 4.5, 6),
  unit: 0.55cm,
)

#check[
  New line: $arrow(r) = (3, 2, -2) + t dot (-1, -1, 2)$, giving
  $S_z (2, 1, 0)$, $S_y (1, 0, 2)$, $S_x (0, -1, 4)$ — all three now on a
  shaded face.

  Getting all three onto the shading needed the $y$-shading extended to
  $y = -1.6$, and that is forced, not cosmetic: *a line meets the boundary
  of a convex region in at most two points*, and the first octant is
  convex — so at most two of a line's three trace points can ever have all
  coordinates non-negative. Worth a `remark()` in `ch-lines`; students who
  expect three tidy first-octant answers are expecting something
  impossible.
]

== 2.7 Figures students draw into: `SHEET-UNIT` + `grid: true`

#space3d(
  s-pt((3, 2, 0), label: $S_z$, color: warn-col, r: 2pt),
  grid: true,
  unit: SHEET-UNIT,
  axis-len: (3.5, 4.5, 3.5),
)

#check[
  *For exercises where the construction happens on the sheet.* One world
  unit is 1 cm and the printed gridlines are 5 mm apart, so a student
  extending this figure by hand counts squares exactly as they would on
  their own paper — two squares along $y$ and $z$, one square diagonal
  along $x$.

  The grid is deliberately *screen-space* horizontal and vertical rules,
  not a projected world grid: it has to match the paper, not the axes.
  It aligns itself so the origin always falls on an intersection.

  Two things to judge: is `luma(222)` at `0.4pt` faint enough to sit
  behind a drawing without competing with it, and does the grid want to
  extend to the edge of the figure as here, or stop at the axes?
]

== 2.8 The same grid under a trace-point figure

#space3d(
  ..line3((3, 2, -2), (-1, -1, 2), tmin: 0.3, tmax: 3.3, color: def-col),
  s-pt((2, 1, 0), label: $S_z$, color: warn-col, r: 2pt),
  s-pt((1, 0, 2), label: $S_y$, color: warn-col, r: 2pt),
  s-pt((0, -1, 4), label: $S_x$, color: warn-col, r: 2pt),
  grid: true,
  axis-len: (4, 4.5, 6),
  unit: 0.72cm,
)

#check[
  Panel 2.6 with the grid on and *the shading removed*, following your
  observation. I have written it into the style guide as a rule rather
  than a preference: *grid or shading, never both.* They are two
  answers to the same question — "which plane is that point in?" — and
  running both means two competing depth cues over the same region. The
  shading is the better cue when the figure is simple and the octant
  reading is the whole point; the grid is better when the figure is busy,
  because it also tells you *how far*, not just *where*.
]

= 3 · Cubes (Chapter 0 — spatial reasoning)

== 3.1 The plain labeled cube

#cube(a: 4)

#check[
  Vertex labels retuned to your list: $A$ further left, $D$ left and up,
  $E$ further left, $F$ right and down, the rest as they were. They are
  hand-placed rather than pushed radially outward, because $A$/$D$ and
  $F$/$G$ each sit on the *same ray* from the cube's centre — a pure
  outward rule sends $D$'s label straight at $A$, which is what went
  wrong the first time.
]

== 3.2 Two points on edges, and the line through them

#let V = cube-pts(a: 4)

#cube(
  a: 4,
  s-pt(
    edge-pt(V.A, V.E, 0.35),
    label: [*P*],
    off: (-15pt, 2pt),
    color: warn-col,
  ),
  s-pt(
    edge-pt(V.C, V.G, 0.75),
    label: [*Q*],
    off: (15pt, -2pt),
    color: warn-col,
  ),
  s-seg(
    from: edge-pt(V.A, V.E, 0.35),
    to: edge-pt(V.C, V.G, 0.75),
    color: warn-col,
    width: 1.1pt,
  ),
  labels: false,
)

#check[
  Labels pushed clear of the body. Renamed to $P$ and $Q$ so they cannot
  be confused with the cube's own vertices $A$ and $C$, which is a live
  risk on a worksheet where both sets of letters appear. Your original
  sheet uses $A$ and $B$ for the marked points on an unlabeled cube — fine
  there, but once the cube is lettered the two schemes collide.
]

== 3.3 A plane section through three edge points

#let P1 = edge-pt(V.A, V.B, 0.5)
#let P2 = edge-pt(V.B, V.F, 0.7)
#let P3 = edge-pt(V.G, V.H, 0.5)

#cube(
  a: 4,
  s-poly(
    (
      P1,
      P2,
      edge-pt(V.F, V.G, 1.0),
      P3,
      edge-pt(V.H, V.E, 0.5),
      edge-pt(V.E, V.A, 1.0),
    ),
    fill: rgb("#f1eff9"),
    stroke-color: ai-col,
    width: 1.1pt,
  ),
  s-pt(P1, label: [*W*], off: (2pt, 12pt), color: ai-col, r: 1.8pt),
  s-pt(P2, label: [*Y*], off: (13pt, 2pt), color: ai-col, r: 1.8pt),
  s-pt(P3, label: [*Z*], off: (-4pt, -13pt), color: ai-col, r: 1.8pt),
  labels: false,
)

== 3.4 Cube with axes — the bridge from Chapter 0 to coordinates

#space3d(
  ..cube-edges(a: 4, labels: true),
  s-vec(to: (4, 4, 4), color: warn-col, label: $arrow(r)_F$, anchor: 0.55),
  axis-len: (5.5, 6, 5.5),
  unit: 0.58cm,
)

== 3.5 A worksheet cube, at sheet scale with a grid

#cube(
  a: 4,
  grid: true,
  unit: SHEET-UNIT,
  s-pt(
    edge-pt(V.A, V.B, 0.5),
    label: [*W*],
    off: (2pt, 12pt),
    color: warn-col,
    r: 2pt,
  ),
  s-pt(
    edge-pt(V.B, V.F, 0.7),
    label: [*Y*],
    off: (13pt, 2pt),
    color: warn-col,
    r: 2pt,
  ),
  s-pt(
    edge-pt(V.G, V.H, 0.5),
    label: [*Z*],
    off: (-4pt, -13pt),
    color: warn-col,
    r: 2pt,
  ),
  labels: false,
)

#check[
  This is what a Cube-Sections task would actually look like on the page:
  three marked points, no section drawn, a grid to construct against.
  Compare the size against your existing worksheet — at `SHEET-UNIT` the
  cube is 4 cm on a side before foreshortening. Big enough to draw in?

  $Y$ has moved off the midpoint of $B F$, which is the bug you caught.
  Under our projection the midpoint of $B F$ lands *exactly* on the
  midpoint of the hidden edge $C D$, so the marked point genuinely belongs
  to two edges as far as the reader can tell. `check-projection.py`
  reproduces it and now guards every figure of this kind — the same fix is
  applied in 3.3.
]

= 4 · Still to build

- *Force / ramp diagram* — inclined plane, weight vector resolved into
  components. Needed for the ramp and boat problems.
- *The right-hand rule* — my one candidate for an actual image file.
- *The two-lines quartet* — identical / parallel / intersecting / skew,
  four small 3D panels side by side.
- *Angle between a line and a plane* — patch, piercing line, normal,
  and both $alpha$ and $phi.alt$ marked.
- *Plumb line onto a plane* — point, foot, reflected point.
- *Classification flowchart*, or keep the existing exported PDF.
