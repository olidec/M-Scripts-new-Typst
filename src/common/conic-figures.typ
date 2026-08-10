// ════════════════════════════════════════════════════════════
//  conic-figures.typ — conic-section figures
//
//  Lives in src/common/, next to preamble.typ and cplane.typ.
//  Chapters that draw a conic import all three:
//
//    #import "../../common/preamble.typ": *
//    #import "../../common/cplane.typ": *
//    #import "../../common/conic-figures.typ": *
//
//  cplane.typ is imported explicitly rather than relied on to come
//  through transitively. It would, but a chapter that says where each
//  of cp-curve and cn-ellipse comes from is a chapter you can still
//  read in two years.
//
//  WHAT IS HERE AND WHAT IS NOT. Everything below is composition over
//  cplane.typ — not one call to cetz appears in this file. A conic is
//  a parametric curve, an asymptote is a line, a focus is a point,
//  and cplane already draws all three; what was missing was the
//  three-line-long parametrizations and a house convention for which
//  colour means what. Keeping it that way means a cetz version bump
//  can only ever break ONE file in the project.
//
//  HOUSE COLOUR CONVENTION for this unit — the whole reason these
//  wrappers exist rather than raw cp-curve calls at every site:
//
//    accent      the conic itself
//    def-col     foci, vertices, and any other named point
//    expl-col    the directrix
//    luma(140)   asymptotes and construction lines, dashed
//    warn-col    is NOT used; red stays reserved for warning()
//
//  A student who has read three chapters should be able to look at a
//  figure and know which curve is the answer without a legend.
//
//  AXIS PARAMETER. Every helper that can point two ways takes
//  axis: "x" or axis: "y", and it always means THE AXIS OF THE CONIC
//  — never the axis of the page. So axis: "x" describes a parabola
//  opening left/right and a hyperbola opening left/right, and the
//  directrix of such a conic is a VERTICAL line. Getting this
//  backwards is the one predictable way to misuse this module, hence
//  the repetition in each docstring.
// ════════════════════════════════════════════════════════════

#import "cplane.typ": *

// ── Hyperbolic functions ─────────────────────────────────────
//  calc has no sinh/cosh/asinh, so they are built from exp here —
//  which is exactly the definition ch-parametric gives the students,
//  so the figure code and the theory agree by construction rather
//  than by coincidence.
#let cn-sinh(t) = (calc.exp(t) - calc.exp(-t)) / 2
#let cn-cosh(t) = (calc.exp(t) + calc.exp(-t)) / 2
#let cn-tanh(t) = cn-sinh(t) / cn-cosh(t)

//  The inverse of sinh, needed to answer "which parameter value puts
//  the branch exactly at the top edge of the picture?".
//  From y = (e^t - e^-t)/2, substituting u = e^t gives the quadratic
//  u^2 - 2yu - 1 = 0, whose positive root is y + sqrt(y^2 + 1).
#let cn-asinh(s) = calc.ln(s + calc.sqrt(s * s + 1))

// Accept a Typst angle or a bare float in radians, as cplane does.
#let _cn-rad(a) = if type(a) == angle { a.rad() } else { float(a) }

// ── Math symbols used INSIDE figure code ─────────────────────
//  Math mode resolves an identifier from the surrounding scope
//  before it falls back to the symbol table. cn-cone-profile takes
//  parameters called `alpha` and `phi`, so writing $alpha$ or
//  $phi.alt$ anywhere in its body reads the PARAMETER -- an angle
//  value -- and not the Greek letter. $phi.alt$ then fails outright
//  ("cannot access fields on type angle"); $alpha$ is worse, because
//  it succeeds and quietly typesets `60deg` into the figure.
//
//  Binding the two labels here, at module level where neither name
//  is a parameter of anything, fixes both and keeps the parameters
//  named after the angles they denote in the text. Same family of
//  hazard as cplane.typ's note on `import cetz.draw: *` shadowing
//  `grid` and `anchor`: in Typst a parameter name is not inert.
//
//  RULE for new helpers here: if a parameter shares its name with a
//  math symbol, never write that symbol inline in the body -- add it
//  to the list below and refer to the binding.
#let _cn-sym-alpha = $alpha$
#let _cn-sym-phi = $phi.alt$

// ── The plane ────────────────────────────────────────────────
//  Plain italic $x$ and $y$, NOT bold like cplane's Re/Im. The bold
//  there marks an operator NAME so the eye doesn't read the tick "3"
//  as an argument to it; x and y are ordinary variables and should
//  look like the x and y in the surrounding equations.
#let cn-x-label = $x$
#let cn-y-label = $y$

#let xyplane = cplane.with(x-label: cn-x-label, y-label: cn-y-label)

#let xyplane-small = cplane.with(
  length: 0.45cm,
  show-ticks: false,
  x-label: cn-x-label,
  y-label: cn-y-label,
)

//  A bare canvas: bounds, a body and a caption, no coordinate system
//  at all. For diagrams that live IN a plane rather than being about
//  one — the edge-on cone profiles, the folding constructions, the
//  Dandelin figures.
#let cn-blank = cplane.with(
  show-axes: false,
  show-grid: false,
  show-ticks: false,
)

// ── The three curves ─────────────────────────────────────────

//  Ellipse (x - u)^2/a^2 + (y - v)^2/b^2 = 1, drawn from the
//  parametrization (u + a cos t, v + b sin t). a and b are the two
//  SEMI-axes as written in the equation; which of them is the major
//  one is the reader's problem, not this function's, so no ordering
//  is enforced and a = b legitimately draws a circle.
#let cn-ellipse(
  a,
  b,
  center: (0, 0),
  color: accent,
  dashed: false,
  thickness: 1.4pt,
  samples: 180,
) = cp-curve(
  t => float(center.at(0)) + float(a) * calc.cos(t),
  t => float(center.at(1)) + float(b) * calc.sin(t),
  domain: (0, 2 * calc.pi),
  samples: samples,
  color: color,
  dashed: dashed,
  thickness: thickness,
)

//  Hyperbola, from (a cosh t, b sinh t).
//
//    axis: "x"  ->  (x-u)^2/a^2 - (y-v)^2/b^2 = 1, opening left/right
//    axis: "y"  ->  (y-v)^2/a^2 - (x-u)^2/b^2 = 1, opening up/down
//
//  In BOTH cases a is the semi-transverse axis (the one that carries
//  the vertices) and b the semi-conjugate axis, matching the booklet.
//
//  extent: how far the drawn arc reaches along the conjugate
//  direction, in world units from the centre. Set it to the plot
//  bound and the branches end exactly at the edge of the picture,
//  which is what makes a hyperbola look infinite instead of
//  arbitrarily cropped.
//
//  branches: "both" | "positive" | "negative", where positive means
//  the branch on the positive side of the transverse axis — the
//  right-hand one for axis: "x", the upper one for axis: "y". A
//  single branch is what the LORAN problem needs.
#let cn-hyperbola(
  a,
  b,
  center: (0, 0),
  axis: "x",
  extent: 3.0,
  branches: "both",
  color: accent,
  dashed: false,
  thickness: 1.4pt,
  samples: 90,
) = {
  let u = float(center.at(0))
  let v = float(center.at(1))
  let aa = float(a)
  let bb = float(b)
  let tm = cn-asinh(float(extent) / bb)
  let dom = (-tm, tm)

  let branch(sgn) = if axis == "x" {
    cp-curve(
      t => u + sgn * aa * cn-cosh(t),
      t => v + bb * cn-sinh(t),
      domain: dom,
      samples: samples,
      color: color,
      dashed: dashed,
      thickness: thickness,
    )
  } else {
    cp-curve(
      t => u + bb * cn-sinh(t),
      t => v + sgn * aa * cn-cosh(t),
      domain: dom,
      samples: samples,
      color: color,
      dashed: dashed,
      thickness: thickness,
    )
  }

  if branches != "negative" { branch(1.0) }
  if branches != "positive" { branch(-1.0) }
}

//  The two asymptotes of that same hyperbola, as full clipped lines.
//  Pass the SAME bounds as the enclosing xyplane() call — as with
//  cp-line, this function has no way to know them otherwise.
//
//  Slopes are +-b/a for axis: "x" and +-a/b for axis: "y", which is
//  the one asymmetry students reliably get wrong; expressing both as
//  direction vectors rather than slopes keeps it out of the caller's
//  hands and handles the vertical case for free.
#let cn-asymptotes(
  a,
  b,
  center: (0, 0),
  axis: "x",
  xmin: -4.5,
  xmax: 4.5,
  ymin: -4.5,
  ymax: 4.5,
  color: luma(140),
  dashed: true,
) = {
  let aa = float(a)
  let bb = float(b)
  let dirs = if axis == "x" {
    ((aa, bb), (aa, -bb))
  } else {
    ((bb, aa), (bb, -aa))
  }
  for d in dirs {
    cp-line(
      through: center,
      direction: d,
      xmin: xmin,
      xmax: xmax,
      ymin: ymin,
      ymax: ymax,
      color: color,
      dashed: dashed,
    )
  }
}

//  Parabola in the booklet's form, with p the semi-latus rectum:
//
//    axis: "x"  ->  (y-v)^2 = 2p(x-u), opening right for p > 0
//    axis: "y"  ->  (x-u)^2 = 2p(y-v), opening up    for p > 0
//
//  Pass a negative p to open the other way; there is deliberately no
//  `direction` argument, because the sign of p carries that
//  information in the equation too and a second mechanism would let a
//  figure disagree with its own caption.
//
//  extent: half the width of the drawn arc measured ACROSS the axis
//  of the parabola — so for axis: "x" the arc runs from y = v-extent
//  to y = v+extent.
#let cn-parabola(
  p,
  vertex: (0, 0),
  axis: "x",
  extent: 3.0,
  color: accent,
  dashed: false,
  thickness: 1.4pt,
  samples: 140,
) = {
  let u = float(vertex.at(0))
  let v = float(vertex.at(1))
  let pp = float(p)
  let e = float(extent)
  if axis == "x" {
    cp-curve(
      t => u + t * t / (2 * pp),
      t => v + t,
      domain: (-e, e),
      samples: samples,
      color: color,
      dashed: dashed,
      thickness: thickness,
    )
  } else {
    cp-curve(
      t => u + t,
      t => v + t * t / (2 * pp),
      domain: (-e, e),
      samples: samples,
      color: color,
      dashed: dashed,
      thickness: thickness,
    )
  }
}

// ── Named points and lines ───────────────────────────────────

//  A focus. Slightly smaller than cplane's default dot: a conic
//  figure often carries five or six marked points and the default
//  size starts to read as a blob at length: 0.45cm.
#let cn-focus(
  x,
  y,
  label: $F$,
  anchor: "south-west",
  color: def-col,
  size: 0.085,
) = cp-point(x, y, label: label, anchor: anchor, color: color, size: size)

//  A vertex. Same colour family as a focus, one size down, because a
//  vertex is a point OF the curve and a focus is not — the figure
//  should not suggest they are the same kind of object.
#let cn-vertex(
  x,
  y,
  label: none,
  anchor: "south-west",
  color: def-col,
  size: 0.065,
) = cp-point(x, y, label: label, anchor: anchor, color: color, size: size)

//  The centre of an ellipse or hyperbola: hollow, because it is not
//  on the curve and is not a focus either.
#let cn-center(
  x,
  y,
  label: $M$,
  anchor: "south-east",
  color: def-col,
  size: 0.075,
) = cp-point(
  x,
  y,
  label: label,
  anchor: anchor,
  color: color,
  filled: false,
  size: size,
)

//  A directrix, spanning the full plot.
//
//    axis: "x"  ->  the VERTICAL line x = value
//    axis: "y"  ->  the HORIZONTAL line y = value
//
//  Read axis: as "the axis of the conic this belongs to", exactly as
//  in cn-parabola: a conic with a horizontal axis has a vertical
//  directrix. Pass the same bounds as the enclosing xyplane().
#let cn-directrix(
  value,
  axis: "x",
  xmin: -4.5,
  xmax: 4.5,
  ymin: -4.5,
  ymax: 4.5,
  color: expl-col,
  dashed: false,
  label: $d$,
  gap: 0.35,
) = {
  let c = float(value)
  let g = float(gap)
  if axis == "x" {
    cp-segment((c, float(ymin)), (c, float(ymax)), color: color, dashed: dashed)
    if label != none {
      cp-label(c - g, float(ymax) - g, label, color: color)
    }
  } else {
    cp-segment((float(xmin), c), (float(xmax), c), color: color, dashed: dashed)
    if label != none {
      cp-label(float(xmin) + g, c - g, label, color: color)
    }
  }
}

// ── Shaded regions ───────────────────────────────────────────

//  The region between two parametric curves, for the volume-of-
//  revolution problems in ch-review. f and g are functions
//  t -> (x, y); the outline runs forward along f and back along g,
//  so the two must be given over the SAME parameter interval and
//  must meet (or be closed off by the plot edge) at both ends.
#let cn-between(
  f,
  g,
  domain: (0, 1),
  samples: 60,
  color: accent,
  opacity: 84%,
) = {
  let t0 = float(domain.at(0))
  let t1 = float(domain.at(1))
  let n = samples
  let fwd = range(n + 1).map(k => f(t0 + (t1 - t0) * k / n))
  let bwd = range(n + 1).map(k => g(t1 + (t0 - t1) * k / n))
  cp-region(..fwd, ..bwd, color: color, opacity: opacity)
}

// ── The cone, seen edge-on ───────────────────────────────────
//
//  A double cone drawn in profile: apex at the origin, axis vertical,
//  the two generators appearing as two full lines through the apex at
//  angle alpha to the horizontal. A cutting plane perpendicular to
//  the page appears as a single line at angle phi.
//
//  WHY A PROFILE RATHER THAN A 3D PICTURE. The 3D picture is prettier
//  and says less. Every question this unit opens with — is phi bigger
//  or smaller than alpha, does the plane meet one nappe or both, does
//  it pass through the apex — is a question about a 2D cross-section
//  through the axis, and the profile answers it by inspection. It is
//  also a figure a student can redraw on squared paper in fifteen
//  seconds, which the 3D one is not. Keep one rendered 3D cone in the
//  chapter for orientation and reason on profiles thereafter.
//
//  CAPTION IT HONESTLY: the cutting plane appears as a line only
//  because it is perpendicular to the page. Say so, every time —
//  a student who thinks the plane IS a line has learned the figure
//  and not the geometry.
//
//    alpha         angle of a generator to the base plane, i.e. to
//                  the horizontal. The apex half-angle is 90deg-alpha.
//    reach         how far each generator is drawn from the apex.
//    phi           angle of the cutting line to the horizontal;
//                  none draws no cut at all.
//    cut-through   a point the cutting line passes through. Put it at
//                  the origin for the degenerate sections.
//    mark-alpha /  draw the angle arc, with a dashed horizontal
//    mark-phi      reference ray to measure it against.
#let cn-cone-profile(
  alpha: 60deg,
  reach: 3.0,
  phi: none,
  cut-through: (0.0, 1.5),
  cut-len: 4.0,
  color: luma(70),
  cut-color: accent,
  cut-dashed: false,
  show-axis: true,
  mark-alpha: false,
  mark-phi: false,
  apex-label: none,
) = {
  let al = _cn-rad(alpha)
  let r = float(reach)
  let gx = r * calc.cos(al)
  let gy = r * calc.sin(al)

  if show-axis {
    cp-segment(
      (0.0, -gy),
      (0.0, gy),
      color: luma(175),
      dashed: true,
      thickness: 0.8pt,
    )
  }

  // The two generators. Each is drawn as one segment straight THROUGH
  // the apex, so the double cone reads as a double cone and not as
  // two separate wedges that happen to touch.
  cp-segment((-gx, -gy), (gx, gy), color: color, thickness: 1.2pt)
  cp-segment((gx, -gy), (-gx, gy), color: color, thickness: 1.2pt)
  cp-point(0, 0, label: apex-label, anchor: "east", color: color, size: 0.07)

  if mark-alpha {
    cp-segment(
      (0.0, 0.0),
      (gx * 0.8, 0.0),
      color: luma(175),
      dashed: true,
      thickness: 0.8pt,
    )
    cp-angle(
      0,
      0,
      0deg,
      alpha,
      radius: 0.7,
      color: color,
      label: _cn-sym-alpha,
    )
  }

  if phi != none {
    let ph = _cn-rad(phi)
    let h = float(cut-len) / 2
    let cx = float(cut-through.at(0))
    let cy = float(cut-through.at(1))
    let dx = h * calc.cos(ph)
    let dy = h * calc.sin(ph)
    cp-segment(
      (cx - dx, cy - dy),
      (cx + dx, cy + dy),
      color: cut-color,
      dashed: cut-dashed,
    )
    if mark-phi {
      cp-segment(
        (cx, cy),
        (cx + h * 0.65, cy),
        color: luma(175),
        dashed: true,
        thickness: 0.8pt,
      )
      cp-angle(
        cx,
        cy,
        0deg,
        phi,
        radius: 0.55,
        color: cut-color,
        label: _cn-sym-phi,
      )
    }
  }
}
