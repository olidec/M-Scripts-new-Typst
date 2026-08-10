#import "../../common/preamble.typ": *
#import "../../common/cplane.typ": *
#import "../../common/conic-figures.typ": *
#show: chapter-template.with(title: "The Cone")
#let ex = exercise.with(chapter: "The Cone")

// ── FIGURE NOTE ──────────────────────────────────────────────
// Every profile in this chapter is drawn with alpha = 60deg and
// reach = 3.0, which puts the generators at (+-1.5, +-2.598). The
// bounds below (+-2.4 by +-3.0) hold that plus the longest cutting
// line without cropping. Keep them identical across all seven
// profiles: the whole argument of the chapter is a comparison
// between pictures, and a figure that silently rescales makes a
// steeper cone look like a different cut.
//
// The one rendered 3D cone is an image because it is orientation,
// not reasoning -- STYLE_GUIDE.md section 7's "complex export not
// worth hand-coding" exception. Everything a student has to think
// with is a native profile.

= Slicing the Cone

#only-theory[
  Three curves have been in this course for years without ever being
  introduced to each other. You met the parabola as the graph of a
  quadratic function, the circle as the set of points at a fixed
  distance from a center, and a hyperbola as the graph of
  $y = 1 slash x$. This unit shows that these -- together with one you
  have not met, the ellipse -- are a single family, and it says so
  literally: they are the curves you get by slicing a cone.

  That is a claim about one surface in space, and it deserves checking
  rather than admiring. This chapter sets up the cone and the cuts. The
  next three start again from scratch, describing each curve by a
  condition on distances in the plane with no cone anywhere in sight,
  because that is where every formula comes from. The cone returns in
  the eccentricity chapter, where two spheres wedged inside it prove
  the two accounts describe the same curves.
]

#epigraph(by: "attributed to Johannes Kepler")[
  Where there is matter, there is geometry.
]

#objectives(
  [describe a double cone by its apex, axis and generators, and by the
    angle $alpha$ between a generator and the base plane],
  [define the ellipse, the parabola and the hyperbola as sections of a
    double cone, and state the condition on the cutting angle
    $phi.alt$ that produces each],
  [recognize the circle as the special case $phi.alt = 0 degree$],
  [identify the three degenerate sections produced by a plane through
    the apex],
  [decide from an edge-on profile sketch which section a given plane
    produces, and locate the vertices of that section on the sketch],
  [explain why some plausible physical set-ups -- a coin's shadow,
    sunlight -- can never produce a hyperbola],
)

== The Double Cone

#only-theory[
  Everything starts with a surface, and the surface is not quite the
  cone of everyday speech.
]

#definition(title: "Double cone")[
  Let $a$ be a line, and let $g$ be a second line meeting it at a point
  $S$ at an angle. Rotating $g$ about $a$ sweeps out a surface, the
  #vocab("double cone", "Doppelkegel") with
  #vocab("apex", "Kegelspitze") $S$ and #vocab("axis", "Achse") $a$.

  Each position of the rotating line is a
  #vocab("generator", "Mantellinie") of the cone. The surface falls
  into two halves meeting at the apex, called
  #vocab("nappes", "Halbkegel"), and it is unbounded in both
  directions.
]

#remark[
  A cone in the everyday sense -- an ice-cream cone, or the solid in
  the formula booklet with $V = 1/3 pi r^2 h$ -- is a bounded piece of
  *one* nappe with a flat lid on it. The cone of this chapter is
  neither bounded nor solid: it is a surface, and it has two halves.
  Both halves earn their keep. The hyperbola exists only because the
  second nappe is there.
]

#only-theory[
  One number describes the shape of the cone. Take the plane through
  the apex perpendicular to the axis -- the *base plane* -- and measure
  the angle $alpha$ between it and a generator. By the rotational
  symmetry every generator makes the same angle, so $alpha$ is a
  property of the cone and not of the generator we happened to pick.
  A narrow, spiky cone has $alpha$ close to $90 degree$; a wide, flat
  one has $alpha$ close to $0 degree$.
]

#only-theory[
  #fig(
    image("images/cone-sections.png", width: 48%),
    caption: [The four non-degenerate sections on one double cone.
      Only the plane changes; the cone is the same throughout.],
  )
]

#definition(title: "Conic section")[
  A #vocab("conic section", "Kegelschnitt") is the intersection of a
  double cone with a plane.
]

== Cutting at an Angle

#only-theory[
  Which curve you get depends on one number as well: the angle
  $phi.alt$ between the cutting plane and the base plane, measured so
  that $phi.alt = 0 degree$ means a horizontal cut and
  $phi.alt = 90 degree$ a cut parallel to the axis. Everything is
  settled by comparing $phi.alt$ with $alpha$.
]

#keybox(title: "The three types")[
  Let $alpha$ be the angle a generator makes with the base plane, and
  $phi.alt in [0 degree, 90 degree]$ the angle of the cutting plane.
  If the plane does *not* pass through the apex, the section is

  - an #vocab("ellipse", "Ellipse") when
    $0 degree <= phi.alt < alpha$. The plane crosses every generator of
    one nappe, so the section is closed and bounded. The special case
    $phi.alt = 0 degree$ gives a #vocab("circle", "Kreis").
  - a #vocab("parabola", "Parabel") when $phi.alt = alpha$. The plane
    is parallel to exactly one generator, which it therefore never
    meets. The section is unbounded and in one piece.
  - a #vocab("hyperbola", "Hyperbel") when
    $alpha < phi.alt <= 90 degree$. The plane reaches both nappes, so
    the section is unbounded and in two pieces, called *branches*.
]

#only-theory[
  The pictures that make this obvious are not the three-dimensional
  ones. Look at the cone *edge-on*: take the plane through the axis
  perpendicular to the cutting plane and draw what you see in it. The
  cone becomes two crossing lines, the cutting plane becomes a single
  line, and the whole classification is one comparison of slopes.
]

#only-theory[
  #image-grid(
    2,
    cn-blank(
      xmin: -2.4,
      xmax: 2.4,
      ymin: -3.0,
      ymax: 3.0,
      caption: [$phi.alt = 0 degree$: circle.],
      {
        cn-cone-profile(
          alpha: 60deg,
          reach: 3.0,
          phi: 0deg,
          cut-through: (0.0, 1.8),
          cut-len: 3.0,
          mark-alpha: true,
        )
      },
    ),
    cn-blank(
      xmin: -2.4,
      xmax: 2.4,
      ymin: -3.0,
      ymax: 3.0,
      caption: [$0 degree < phi.alt < alpha$: ellipse.],
      {
        cn-cone-profile(
          alpha: 60deg,
          reach: 3.0,
          phi: 20deg,
          cut-through: (0.0, 1.5),
          cut-len: 3.6,
          mark-phi: true,
        )
      },
    ),
    cn-blank(
      xmin: -2.4,
      xmax: 2.4,
      ymin: -3.0,
      ymax: 3.0,
      caption: [$phi.alt = alpha$: parabola. The cut is parallel to the
        right-hand generator and never meets it.],
      {
        cn-cone-profile(
          alpha: 60deg,
          reach: 3.0,
          phi: 60deg,
          cut-through: (0.5, 0.0),
          cut-len: 5.0,
        )
      },
    ),
    cn-blank(
      xmin: -2.4,
      xmax: 2.4,
      ymin: -3.0,
      ymax: 3.0,
      caption: [$phi.alt > alpha$: hyperbola. The cut reaches both
        nappes, once above the apex and once below.],
      {
        cn-cone-profile(
          alpha: 60deg,
          reach: 3.0,
          phi: 85deg,
          cut-through: (0.7, 0.0),
          cut-len: 5.2,
        )
      },
    ),
  )
]

#warning[
  In an edge-on profile the cutting plane looks like a *line*. It is
  still a plane; it appears as a line only because it stands
  perpendicular to the page. The two points where that line crosses the
  generators are two genuine points of the section -- and, as Exercise
  2 asks you to work out, they are exactly its vertices.
]

#example(title: "Reading a profile")[
  A cone has $alpha = 55 degree$. A plane meets it at $phi.alt = 55
  degree$ but passes nowhere near the apex. Since $phi.alt = alpha$,
  the section is a parabola -- regardless of how far from the apex the
  plane sits. Moving the plane parallel to itself changes the *size* of
  the parabola, never its type. Only the angle decides the type.
]

#warning[
  A cut parallel to the axis ($phi.alt = 90 degree$) is often said to
  produce a *rectangular* hyperbola, one whose asymptotes meet at a
  right angle. That is false, and it is false in a way worth
  remembering: the section depends on the *cone* as well as on the
  plane. A vertical cut through a narrow cone gives a hyperbola with
  steep asymptotes, and through a wide cone one with shallow
  asymptotes. Perpendicular asymptotes happen for exactly one cone --
  the one with $alpha = 45 degree$. Exercise 4 asks you to prove it.
]

#ai-box(role: "Checker")[
  Ask an AI assistant: *"If a plane cuts a double cone parallel to its
  axis, is the resulting hyperbola always rectangular?"*

  + Record its answer verbatim before reading further. This claim is
    repeated in a good number of textbooks and websites, so there is a
    real chance the assistant repeats it too.
  + Whatever it said, ask it to justify the answer using the cone's
    half-angle. Does the justification survive contact with the
    $alpha = 30 degree$ and $alpha = 60 degree$ cases?
  + If it was wrong and you corrected it, ask yourself the harder
    question: what made you able to tell? Name the specific piece of
    reasoning -- not "I knew it was wrong", but the step.
]

== Sections Through the Apex

#only-theory[
  Everything above assumed the cutting plane misses the apex. If it
  passes through it, the section collapses -- but it collapses along
  the same three angle conditions, which is a good sign that the
  classification is the right one.
]

#keybox(title: "The degenerate sections")[
  For a plane through the apex $S$:
  - $phi.alt < alpha$: the plane touches the cone at $S$ and nowhere
    else. The section is a *single point*.
  - $phi.alt = alpha$: the plane is tangent to the cone along one
    generator. The section is a *single line*.
  - $phi.alt > alpha$: the plane cuts through both nappes. The section
    is a *pair of intersecting lines*.

  These are the #vocab("degenerate conics", "entartete Kegelschnitte").
]

#only-theory[
  #image-grid(
    3,
    cn-blank(
      xmin: -2.4,
      xmax: 2.4,
      ymin: -3.0,
      ymax: 3.0,
      caption: [$phi.alt < alpha$: a point.],
      {
        cn-cone-profile(
          alpha: 60deg,
          reach: 3.0,
          phi: 30deg,
          cut-through: (0.0, 0.0),
          cut-len: 4.4,
        )
      },
    ),
    cn-blank(
      xmin: -2.4,
      xmax: 2.4,
      ymin: -3.0,
      ymax: 3.0,
      caption: [$phi.alt = alpha$: a line.],
      {
        cn-cone-profile(
          alpha: 60deg,
          reach: 3.0,
          phi: 60deg,
          cut-through: (0.0, 0.0),
          cut-len: 5.4,
        )
      },
    ),
    cn-blank(
      xmin: -2.4,
      xmax: 2.4,
      ymin: -3.0,
      ymax: 3.0,
      caption: [$phi.alt > alpha$: two lines.],
      {
        cn-cone-profile(
          alpha: 60deg,
          reach: 3.0,
          phi: 85deg,
          cut-through: (0.0, 0.0),
          cut-len: 5.6,
        )
      },
    ),
  )
]

#remark[
  Do not file the degenerate cases under "curiosities". When we go the
  other way in the classification chapter -- from a second-degree
  equation to the curve it describes -- a single point and a pair of
  crossing lines both turn up as perfectly ordinary answers, and
  writing "ellipse" for one of them is a wrong answer, not a rounding
  error.
]

#remark[
  There is one thing a second-degree equation can describe that is
  *not* a section of a cone: nothing at all. The solution set of
  $x^2 + y^2 = -1$ is empty, but no plane misses a double cone -- the
  cone widens without bound, so every plane in space meets it
  somewhere. The empty case exists only on the equation side of the
  story.
]

#look-ahead(
  title: "Where this is going",
  preview: [the eccentricity chapter],
)[
  The definitions in this chapter are the ones Apollonius worked with
  around 200 BC, and they are the ones the syllabus asks you to be able
  to state. They are also nearly useless for calculating anything:
  nothing in "slice the cone at $37 degree$" tells you where the curve
  crosses an axis.

  So the next three chapters put the cone away and start again. Each
  curve gets a definition as a #vocab("locus", "geometrischer Ort") --
  a set of points in the plane picked out by a condition on distances,
  exactly as you defined circles and perpendicular bisectors in the
  complex-numbers unit. Every equation, every focus and every asymptote
  comes from there.

  Which leaves an obvious debt: two definitions, and no reason yet to
  believe they describe the same curves. That debt is paid with two
  spheres.
]

#exploration(title: "Four curves from one torch")[
  A torch (flashlight) beam is a cone of light with the bulb at the
  apex. A wall is a cutting plane. The bright patch is a conic section,
  and you can run the entire classification with the lights off.

  + Hold the torch pointing straight at the wall, perpendicular to it.
    What shape is the patch?
  + Tilt the torch slowly. Watch the patch. At what moment does it stop
    being a closed curve, and what is happening at the cone at that
    moment?
  + Keep tilting. Can you get a patch made of two separate pieces? If
    not, what would have to be true of the beam for that to be
    possible?
  + A torch produces only one nappe, and only the rays travelling
    forward. Which of the four types can you actually produce, and
    which are out of reach in principle rather than in practice?
  + Shine the torch into the corner where two walls meet. The cutting
    surface is now two planes. Sketch what you see and account for both
    pieces.
]

// ── Exercises ────────────────────────────────────────────────

#ex(difficulty: 1, time: "12 min")[
  A double cone has $alpha = 70 degree$. Name the section produced by a
  cutting plane at each of the following angles $phi.alt$ to the base
  plane. In (a)--(d) the plane misses the apex; in (e)--(f) it passes
  through it.
  #auto-parts(
    3,
    [$phi.alt = 0 degree$],
    [$phi.alt = 25 degree$],
    [$phi.alt = 70 degree$],
    [$phi.alt = 88 degree$],
    [$phi.alt = 40 degree$],
    [$phi.alt = 88 degree$],
  )
][
  #auto-parts(
    3,
    [Circle ($phi.alt = 0 degree$).],
    [Ellipse ($phi.alt < alpha$).],
    [Parabola ($phi.alt = alpha$).],
    [Hyperbola ($phi.alt > alpha$).],
    [A single point: $phi.alt < alpha$ through the apex.],
    [Two intersecting lines: $phi.alt > alpha$ through the apex.],
  )

  Parts (d) and (f) use the same angle and give different answers,
  which is the point of the pairing: the angle decides the *type*, and
  whether the plane passes through the apex decides whether that type
  degenerates.
]

#ex(difficulty: 2, time: "18 min", hints: (
  [Draw the cone edge-on first: two lines through the apex at
    $50 degree$ to the horizontal. The cutting plane is then a single
    line, and you are choosing its slope.],
  [For the last part, ask what the two crossing points are in the
    three-dimensional picture. They lie in the section, and they lie in
    the plane through the axis.],
))[
  Draw an edge-on profile of a cone with $alpha = 50 degree$. On three
  separate copies, draw a cutting line producing
  #auto-parts(
    3,
    [an ellipse,],
    [a parabola,],
    [a hyperbola.],
  )
  In each case state a value of $phi.alt$ that works, and mark the
  points where your cutting line crosses the generators. Finally: what
  are those marked points in the three-dimensional picture?
][
  Any $phi.alt$ with $0 degree <= phi.alt < 50 degree$ for (a),
  $phi.alt = 50 degree$ exactly for (b), and
  $50 degree < phi.alt <= 90 degree$ for (c). For (b) the cutting line
  is parallel to one generator and crosses the other one only; for (c)
  it crosses one generator above the apex and the other below.

  The marked points are the *vertices* of the section. The profile
  plane contains the axis and is perpendicular to the cutting plane, so
  its intersection with the cutting plane is the axis of symmetry of
  the section -- and the points where a conic meets its own axis of
  symmetry are its vertices. This is why the ellipse gets two, the
  parabola one, and the hyperbola one on each branch.
]

#ex(difficulty: 3, time: "25 min", hints: (
  [A hyperbola needs the cutting plane to reach *both* nappes. Where
    is the second nappe in the coin set-up?],
  [For the last part, what is it that actually blurs the edge of a
    shadow? It is not the air.],
))[
  Hold a coin under a small light bulb so that it casts a shadow on a
  table top. Turning the coin changes the shape of the shadow, which
  makes it look as though the whole plane-cuts-cone story is on display
  -- but you can never produce a hyperbola this way.
  #auto-parts(
    1,
    [Why not? Argue from the cone, not from experiment.],
    [Does it help to move the coin so that it is no longer directly
      under the bulb?],
    [In practice the coin has to be held fairly close to the table.
      Why? Would it make any difference on the Moon, where there is no
      atmosphere?],
  )
][
  #auto-parts(
    1,
    [The rays through the rim of the coin form a double cone with its
      apex at the bulb, but the shadow is the section cut by the table,
      and the table lies entirely *below* the bulb. Every ray that
      contributes to the shadow travels downward from the bulb and
      reaches the table, so the plane crosses every generator of the
      lower nappe and the section is closed: an ellipse. Equivalently
      and more usefully: a bounded section is an ellipse, and the
      shadow of a coin is bounded. To get a hyperbola some rim ray
      would have to travel horizontally or upward and never reach the
      table -- which happens only when the coin is tilted so far that
      its plane contains the bulb, and then it casts no shadow at all,
      just a line.],
    [No. The argument above never used the coin being directly
      underneath. It used only that the shadow is bounded, which
      moving the coin sideways does not change.],
    [The bulb is not a point. It is a small but genuinely extended
      source, so each point of the coin's rim casts a small spread of
      shadow edges -- the penumbra -- and the width of that spread
      grows in proportion to the distance from the coin to the table.
      Hold the coin close and the penumbra is thin and the ellipse
      sharp; hold it high and the shadow is large, faint and
      soft-edged, and the geometry becomes unmeasurable.

      On the Moon the penumbra would be no narrower, because what
      creates it is the angular size of the source, not the air. What
      *would* change is the contrast: with no atmosphere there is no
      scattered light filling in the shadow, so the dark region is far
      darker and the edge is easier to see. Sharper to the eye, the
      same width to a ruler.],
  )
]

#ex(difficulty: 3, time: "25 min", calculator: false, hints: (
  [Put the apex at the origin with the axis along $z$. A generator
    rises at angle $alpha$, so a point at horizontal distance $r$ from
    the axis lies at height $z = plus.minus r tan(alpha)$.],
  [Inside the cutting plane $x = d$, use $y$ and $z$ as the
    coordinates. Nothing else in the equation is a variable.],
))[
  Set up coordinates with the apex at the origin and the axis along the
  $z$-axis, so that the double cone with base angle $alpha$ has the
  equation $z^2 = tan^2(alpha) dot (x^2 + y^2)$. Cut it with the plane
  $x = d$, where $d > 0$ -- a plane parallel to the axis, so
  $phi.alt = 90 degree$.
  #auto-parts(
    1,
    [Show that in the coordinates $y$ and $z$ of the cutting plane the
      section has the equation
      $ z^2 / (d^2 tan^2(alpha)) - y^2 / d^2 = 1. $],
    [The asymptotes of this hyperbola are the lines
      $z = plus.minus tan(alpha) dot y$. Deduce that the section is
      rectangular exactly when $alpha = 45 degree$, and so that the
      claim corrected earlier in this chapter really is false in
      general.],
    [What happens to the section as $alpha -> 90 degree$?],
  )
][
  #auto-parts(
    1,
    [Substituting $x = d$ into the equation of the cone gives
      $
        z^2 = tan^2(alpha) dot (d^2 + y^2)
        quad ==> quad
        z^2 - tan^2(alpha) dot y^2 = d^2 tan^2(alpha).
      $
      Dividing through by $d^2 tan^2(alpha)$ gives the stated form.
      Reading off the standard shape, the semi-transverse axis is
      $a = d tan(alpha)$ along $z$ and the semi-conjugate axis is
      $b = d$.],
    [The two asymptotes have slopes $plus.minus tan(alpha)$, so they
      are perpendicular exactly when
      $
        -tan^2(alpha) = -1
        quad <==> quad
        tan(alpha) = 1
        quad <==> quad
        alpha = 45 degree
      $
      (taking $alpha in (0 degree, 90 degree)$). The angle of the
      *cone* decides it, and the angle of the plane -- fixed at
      $90 degree$ throughout -- has nothing to do with it.],
    [The vertices sit at $z = plus.minus d tan(alpha)$, which runs off
      to infinity as $alpha -> 90 degree$. The cone is closing onto its
      own axis, the plane $x = d$ stays a distance $d$ away from that
      axis, and in the limit no part of the section remains within any
      bounded region of the plane.],
  )
]

#ex(difficulty: 2, time: "15 min")[
  The Sun is far enough away that its rays arriving at the Earth are
  effectively parallel.
  #auto-parts(
    1,
    [What surface do the rays grazing the rim of a circular disc form
      when the light source is the Sun rather than a bulb?],
    [Classify the sections a plane can cut from that surface.],
    [Which of the conic types have become impossible, and what feature
      of the cone was responsible for them?],
  )
][
  #auto-parts(
    1,
    [A circular cylinder: the limiting case of a cone whose apex has
      receded to infinity, so that all the generators are parallel
      instead of meeting.],
    [A plane not parallel to the axis cuts an ellipse, which becomes a
      circle when the plane is perpendicular to the axis. A plane
      parallel to the axis cuts either two parallel lines, or one line
      when it is tangent, or nothing when it misses the cylinder
      entirely.],
    [The parabola and the hyperbola are both gone. Both of them depend
      on a generator the cutting plane fails to meet, and on a cone all
      generators eventually spread far enough apart for a plane to slip
      past one -- while on a cylinder the generators stay parallel, so
      a plane either misses all of them or meets all of them. Note also
      the new degenerate case: two *parallel* lines, which no double
      cone can produce, since its generators all pass through the
      apex.],
  )
]

#print-vocab()
