#import "../../common/preamble.typ": *
#import "/src/common/vec-figures.typ": *
#show: chapter-template.with(title: "Seeing in Space")
#let ex = exercise.with(chapter: "Seeing in Space")

// Cube vertices, available to every figure and exercise below.
#let V = cube-pts(a: 4)

= Seeing in Space

#only-theory[
  This chapter contains no formulas. It contains no calculations, and
  nothing in it will be examined directly.

  It is here because of what happens next. The rest of this unit builds
  a machine for answering questions about points, lines and planes in
  space — where they meet, how far apart they are, what angle they
  make. That machine is worth building only if you already believe the
  questions are hard. So before any of it arrives, you are going to
  answer a few of those questions the other way: by looking.

  Some of them you will get in seconds. Some of them will stop you
  completely, and you will not be able to say why one was easy and the
  other was not. That gap is the subject of this unit. Everything that
  follows is a way of reaching the answers your eyes cannot reach —
  and, just as importantly, of *checking* the ones your eyes hand you
  for free.
]

#objectives(
  bfkm[produce a clear, meaningful sketch of a three-dimensional
    situation, and read one that somebody else has drawn],
  [draw a cube or a rectangular solid in the standard oblique
    projection, on squared paper, with the hidden edges correct],
  [find where a line through two given points enters and leaves a
    solid, and say which part of it is hidden],
  [construct the polygon cut out of a cube by a plane through three
    given points],
  [use the two construction rules — same face, parallel faces — and
    explain why each of them is true],
  [say what information a single view of a solid throws away],
)

== Drawing What You Cannot See

#only-theory[
  A sheet of paper is flat and space is not, so every picture of a
  solid is a lie of some kind. The useful question is which lie to
  tell consistently.

  The convention used throughout this course, and in your formula
  booklet, is the #vocab("oblique projection", "Schrägbild"). It is a
  rule you can follow with a ruler on squared paper:

  #keybox(title: "Drawing in oblique projection")[
    - Widths run *right*, at true length.
    - Heights run *up*, at true length.
    - Depths run *down and to the left*, at $45degree$ — and at
      *half* their true length along that diagonal.
  ]

  On $5$ mm paper this is entirely countable. One unit of width or
  height is two squares. One unit of depth is one square *diagonally*,
  down-left. A cube of edge $4$ is therefore eight squares wide, eight
  squares tall, and four diagonals deep.

  #fig(
    cube(a: 4, unit: SHEET-UNIT, grid: true),
    caption: [A cube of edge $4$. Widths and heights are true; depths
      are halved and run at $45degree$. Every corner sits on a grid
      intersection.],
  )

  The depth is halved for a reason that has nothing to do with
  mathematics and everything to do with eyes: drawn at full length,
  the solid looks absurdly long, like a corridor. Halving it produces
  something the brain accepts as a cube. This particular choice —
  $45degree$ and one half — is called the *cabinet projection*, and it
  is what furniture drawings have used for centuries.
]

#only-theory[
  === Which edges are hidden

  A solid cube is opaque. Three of its faces are turned towards you
  and three are turned away, so exactly one vertex is hidden behind the
  body of the cube, and the three edges meeting at that vertex are
  hidden with it. Those three are drawn dashed; the other nine are
  drawn solid.

  #vocab("Hidden edges", "verdeckte Kanten") are not optional
  decoration. A drawing with all twelve edges solid is genuinely
  ambiguous — it can be read as a cube seen from above-front or from
  below-behind, and the two readings disagree about which corner is
  nearest. Dashing the hidden three settles it.
]

#definition(title: "Naming the corners")[
  Throughout this unit a cube is lettered the same way: the bottom
  face $A B C D$ read counterclockwise seen from above, and the top
  face $E F G H$ with $E$ directly above $A$, $F$ above $B$, and so on.

  Drawn in oblique projection with $A$ nearest the front, the hidden
  vertex is $D$, and the hidden edges are $D A$, $D C$ and $D H$.
]

#exploration(title: "What a single view throws away")[
  Below is a cube with a point $P$ marked somewhere on it.

  #fig(cube(
    a: 4,
    s-pt((4, 3, 1), label: [*P*], off: (12pt, 4pt), color: warn-col, r: 2pt),
    labels: false,
  ))

  + Sketch the *top view* of the cube — what you would see looking
    straight down on it — and mark where $P$ appears in that view.

  + Now sketch the *front view*, and mark $P$ there too.

  + Neither view on its own tells you where $P$ is. Which piece of
    information does the top view lose? Which does the front view
    lose?

  + Given both views together, can you always locate $P$? Try to
    invent a solid for which two views are not enough.
]

#only-theory[
  The answer to the third question is the reason for a habit you will
  see in every three-dimensional figure from here on. A top view loses
  height; a front view loses depth. So whenever a figure needs to pin
  a point down, it carries a dashed line dropped from the point
  straight to the base plane, plus dashed lines from there to the
  axes. Those dashed lines are exactly the top view, drawn *inside*
  the picture instead of beside it.

  #fig(
    space3d(
      s-pt((3, 4, 3), label: $P$),
      s-seg(from: (3, 4, 0), to: (3, 4, 3), dashed: true, color: luma(150)),
      s-seg(from: (3, 0, 0), to: (3, 4, 0), dashed: true, color: luma(150)),
      s-seg(from: (0, 4, 0), to: (3, 4, 0), dashed: true, color: luma(150)),
      s-pt((3, 4, 0), label: $P'$, r: 1.8pt),
      axis-len: (4.2, 5.2, 4),
    ),
    caption: [The dashed path from $P$ down to $P'$ and on to the axes
      is the top view, folded into the picture.],
  )
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  On squared paper, draw a cube of edge $4$ in oblique projection,
  letter its vertices $A$ to $H$ in the standard way, and dash the
  hidden edges.

  Then, on the same drawing, mark the midpoint of edge $B F$ and the
  midpoint of edge $C G$.
][
  #fig(cube(
    a: 4,
    unit: SHEET-UNIT,
    grid: true,
    s-pt(edge-pt(V.B, V.F, 0.5), off: (13pt, 3pt), color: warn-col, r: 2pt),
    s-pt(edge-pt(V.C, V.G, 0.5), off: (13pt, 1pt), color: warn-col, r: 2pt),
  ))

  Hidden edges $D A$, $D C$, $D H$ dashed. Both marked midpoints lie
  on *visible* edges, so both are drawn as solid dots.
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Draw a rectangular solid that is $2$ units deep, $5$ units wide and
  $3$ units high, in the same projection.

  How many squares of your paper does each of the three directions
  take up?
][
  #fig(box3(dx: 2, dy: 5, dz: 3, unit: SHEET-UNIT, grid: true, labels: false))

  Width: $5$ units, so $10$ squares to the right. Height: $3$ units,
  so $6$ squares up. Depth: $2$ units, so $2$ squares *diagonally*
  down-left — not $4$, because depth is drawn at half length.

  Notice that the front face is a true $5 times 3$ rectangle. Only the
  depth is distorted. That is worth remembering when you read a figure:
  lengths measured along the width and height directions can be trusted,
  lengths measured into the page cannot.
]

== Two Points Make a Line

#only-theory[
  Two distinct points determine exactly one line. That is not a
  theorem to prove; it is close to what "line" means. The interesting
  question is what the line then *does* — and in particular, where it
  meets the surface of a solid it passes through.

  #fig(
    cube(
      a: 4,
      s-seg(from: (6, 0, 0), to: (4, 1, 1), color: warn-col, width: 1.1pt),
      s-seg(
        from: (4, 1, 1),
        to: (0, 3, 3),
        color: warn-col,
        width: 1.1pt,
        dashed: true,
      ),
      s-seg(from: (0, 3, 3), to: (-2, 4, 4), color: warn-col, width: 1.1pt),
      s-pt((6, 0, 0), label: [*P*], off: (-6pt, 12pt), color: warn-col, r: 2pt),
      s-pt(
        (-2, 4, 4),
        label: [*Q*],
        off: (12pt, -4pt),
        color: warn-col,
        r: 2pt,
      ),
      s-pt((4, 1, 1), color: def-col, r: 2.4pt),
      s-pt((0, 3, 3), color: def-col, r: 2.4pt, hollow: true),
      unit: 0.7cm,
    ),
    caption: [$P$ lies on the line of edge $D A$, two units beyond $A$;
      $Q$ lies on the line of edge $F G$, two units beyond $G$. The
      line $P Q$ enters the cube through the front face and leaves
      through the back face. Inside the solid it is hidden, so it is
      drawn dashed. The exit point is on a face turned away from you,
      so it is drawn hollow.],
  )

  Read the figure carefully before going on. Two things in it are
  doing real work.

  The first is the *dashing*. The segment does not stop at the surface
  of the cube — it continues through the interior, where you could not
  see it, and comes out the far side. Drawing that portion dashed is
  the same convention as the hidden edges, applied to something that
  is not an edge.

  The second is that the two crossing points are on *different kinds
  of face*. The entry point sits on the front face, which is turned
  towards you. The exit point sits on the back face, which is turned
  away. A point you could not actually see is drawn hollow, so that a
  reader can tell.
]

#keybox(title: "Where a line crosses a face")[
  A point where a line passes through a face of a solid is called a
  #vocab("piercing point", "Durchstosspunkt").

  A line that goes into a convex solid comes out again, so it has
  exactly two piercing points — or it misses the solid entirely, and
  has none. It can never have three.
]

#only-theory[
  That last sentence deserves a moment. It is not obvious, and it is
  the first genuinely three-dimensional fact in this course. A cube is
  #vocab("convex", "konvex"): the segment joining any two of its points
  stays inside it. Suppose a line met the surface at three points.
  Two of them would have the middle one lying between them on the
  line, hence inside the solid — but it is also *on the surface*, and a
  point strictly between two interior points cannot be on the surface
  of a convex body. So three is impossible.

  You will meet this fact again, in disguise, when a line's
  #emph[trace points] are computed in the chapter on lines. There the
  solid is replaced by the three coordinate planes, and the question
  "where does this line cross a face?" becomes "where does this line
  cross $z = 0$?" — the same question, with the cube's faces flattened
  out into infinite planes.

  None of this needs to be memorized. What does need to become
  automatic is the first move: before reasoning about a line through a
  solid at all, draw it. #heuristic("draw a picture")
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Copy the cube below. The point $P$ lies on the line of edge $C G$,
  two units *below* $C$; the point $Q$ lies on the line of edge $A E$,
  two units *above* $E$.

  #fig(cube(
    a: 4,
    unit: SHEET-UNIT,
    grid: true,
    s-pt((0, 4, -2), label: [*P*], off: (13pt, 4pt), color: warn-col, r: 2pt),
    s-pt((4, 0, 6), label: [*Q*], off: (-13pt, -4pt), color: warn-col, r: 2pt),
  ))

  Draw the segment $P Q$, dashing the part that is inside the cube,
  and mark both piercing points. Through which two faces does the line
  pass?
][
  #fig(cube(
    a: 4,
    unit: SHEET-UNIT,
    grid: true,
    s-seg(from: (0, 4, -2), to: (1, 3, 0), color: warn-col, width: 1.1pt),
    s-seg(
      from: (1, 3, 0),
      to: (3, 1, 4),
      color: warn-col,
      width: 1.1pt,
      dashed: true,
    ),
    s-seg(from: (3, 1, 4), to: (4, 0, 6), color: warn-col, width: 1.1pt),
    s-pt((0, 4, -2), label: [*P*], off: (13pt, 4pt), color: warn-col, r: 2pt),
    s-pt((4, 0, 6), label: [*Q*], off: (-13pt, -4pt), color: warn-col, r: 2pt),
    s-pt((1, 3, 0), color: def-col, r: 2.4pt, hollow: true),
    s-pt((3, 1, 4), color: def-col, r: 2.4pt),
  ))

  The line enters through the *bottom* face and leaves through the
  *top* face. The entry point lies on the bottom, which is turned away
  from you, so it is hollow; the exit point lies on the top, which you
  can see.

  A useful check on your drawing: both piercing points should land on
  grid intersections. If yours do not, the line has drifted.
]

#ex(difficulty: 3, time: "12 min", calculator: false, hints: (
  "Locate P and Q first, before drawing anything else. Each of them lies on the line containing an edge, extended past a corner.",
  "The segment PQ crosses the cube. Which faces could it possibly use? Look at where P and Q sit relative to the six faces.",
  "Once you have the two piercing points, decide for each one whether it is on a face you can see or a face turned away.",
))[
  On a fresh cube, $P$ lies on the line of edge $H G$, two units
  beyond $G$, and $Q$ lies on the line of edge $A B$, two units beyond
  $A$.

  Draw $P Q$ with the correct dashing, mark the piercing points, and
  say which faces they lie on.
][
  #fig(cube(
    a: 4,
    unit: SHEET-UNIT,
    grid: true,
    s-seg(from: (0, 6, 4), to: (1, 4, 3), color: warn-col, width: 1.1pt),
    s-seg(
      from: (1, 4, 3),
      to: (3, 0, 1),
      color: warn-col,
      width: 1.1pt,
      dashed: true,
    ),
    s-seg(from: (3, 0, 1), to: (4, -2, 0), color: warn-col, width: 1.1pt),
    s-pt((0, 6, 4), label: [*P*], off: (13pt, -3pt), color: warn-col, r: 2pt),
    s-pt((4, -2, 0), label: [*Q*], off: (-13pt, 3pt), color: warn-col, r: 2pt),
    s-pt((1, 4, 3), color: def-col, r: 2.4pt),
    s-pt((3, 0, 1), color: def-col, r: 2.4pt, hollow: true),
  ))

  The line enters through the *right* face $B C G F$ — which you can
  see — and leaves through the *left* face $A D H E$, which is turned
  away.

  This one is harder than the previous exercise for a reason worth
  naming: both of the faces involved are ones you see edge-on, so
  neither piercing point can be located by eye against the face
  outline. You have to reason from the positions of $P$ and $Q$
  instead. That is a small taste of what happens when the eye runs out.
]

== Three Points Make a Plane

#only-theory[
  Three points, provided they do not all lie on one line, determine
  exactly one plane. Cut a cube with that plane and the result is a
  polygon — the #vocab("cross-section", "Schnittfigur") — whose
  vertices lie on the edges of the cube.

  Constructing that polygon by eye is the central task of this
  chapter, and unlike the line problem it does not fall out of a
  single glance. Try one first.
]

#exploration(title: "Cut the cube")[
  Three points are marked on the edges of the cube below: the midpoint
  of $A B$, the midpoint of $A E$, and the midpoint of $A D$.

  #fig(cube(
    a: 4,
    unit: SHEET-UNIT,
    grid: true,
    s-pt((4, 2, 0), off: (2pt, 12pt), color: ai-col, r: 2pt),
    s-pt((4, 0, 2), off: (-13pt, 0pt), color: ai-col, r: 2pt),
    s-pt((2, 0, 0), off: (-4pt, 12pt), color: ai-col, r: 2pt),
  ))

  + Draw the polygon that the plane through these three points cuts
    out of the cube. How many sides does it have?

  + Now suppose the three marked points are the midpoints of $A B$,
    of $C G$, and of $H E$ instead. Try to draw *that* section, on a
    fresh cube.

  Do not expect the second one to come easily. Get as far as you can,
  then read on.
]

#only-theory[
  The first section is a triangle, and most people see it at once:
  all three points sit on faces that meet at the corner $A$, and the
  plane simply slices that corner off.

  The second is a hexagon, and almost nobody sees it. The difference
  between the two is not that one is harder to imagine — it is that
  the first one can be drawn by joining marked points to each other,
  and the second one cannot. Every side of the second hexagon has at
  least one end at a point nobody marked.

  So a method is needed. It rests on two observations, both of which
  you can check on the triangle you have already drawn.
]

#keybox(title: "Two rules for constructing a section")[
  + *Same face.* If two of the section's points lie on the same face
    of the cube, the section's edge between them is the straight
    segment joining them. A plane meets a plane in a straight line,
    and the face is flat.

  + *Parallel faces.* A plane cuts two *parallel* faces of the cube in
    two *parallel* lines.
]

#only-theory[
  The second rule is the one that does the work, and it is worth
  seeing why it is true rather than taking it on trust. Two parallel
  faces never meet. The cutting plane meets each of them in a line.
  Those two lines both lie in the cutting plane, and they can never
  meet each other — because a common point would have to lie on both
  faces at once. Two lines in the same plane that never meet are
  parallel.

  With those two rules, the hexagon becomes constructible rather than
  imaginable. Each time you have two points on one face, join them;
  each time you have a segment on one face, copy its direction onto
  the opposite face through whatever point you have there. Repeat
  until the polygon closes.

  If a section resists you, cut the problem down: ignore the third
  point for a moment and ask what the plane through the *other two*
  and one convenient corner would do, then move the corner back where
  it belongs. #heuristic("solve a simpler version first")
]

#ai-box(role: "Checker")[
  Describe one of these cube sections to an AI assistant in words —
  the cube, the three marked points, and what you want — and ask it
  which polygon comes out.

  Then compare its answer with the one you constructed, and be
  specific about *where* the two differ: the number of sides, which
  edges the vertices sit on, or the shape's symmetry.

  This is a deliberately awkward task to hand to a language model, and
  it is awkward for an interesting reason. Your reasoning happens in a
  picture. To ask the question at all you must first flatten that
  picture into a paragraph, and a paragraph is a poor container for a
  spatial arrangement — try describing "the midpoint of the back
  vertical edge on the left" without ambiguity and you will feel the
  problem. Whatever answer comes back is an answer to the description
  you managed to write, not to the cube you were looking at.

  It may well be right. The point of the exercise is not that the tool
  fails; it is that *you* have to be the one who knows. An answer you
  cannot check is worth nothing to you, and here the only way to check
  is to have done the construction. Notice also which parts of your
  description were hardest to pin down — those are exactly the places
  where coordinates, arriving in the next chapter, will earn their
  keep.
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Draw the section cut from the cube by the plane through the
  midpoints of $A B$, $A E$ and $A D$.

  What kind of triangle is it? Justify your answer without measuring.
][
  #fig(cube(
    a: 4,
    unit: SHEET-UNIT,
    grid: true,
    s-poly(
      ((4, 2, 0), (4, 0, 2), (2, 0, 0)),
      fill: rgb("#f1eff9"),
      stroke-color: ai-col,
      width: 1.1pt,
    ),
    s-pt((4, 2, 0), off: (2pt, 12pt), color: ai-col, r: 2pt),
    s-pt((4, 0, 2), off: (-13pt, 0pt), color: ai-col, r: 2pt),
    s-pt((2, 0, 0), off: (-4pt, 12pt), color: ai-col, r: 2pt),
  ))

  A triangle, cutting the corner $A$ off the cube.

  It is *equilateral*. Each of its three sides is the hypotenuse of a
  right triangle whose two legs are halves of cube edges — so all
  three sides have the same length, whatever that length is. No
  measuring required, and no coordinates either.
]

#ex(difficulty: 2, time: "12 min", calculator: false, hints: (
  "Two of the three marked points lie on the same face. Start there.",
  "You now have a segment on one face. Which face is parallel to it, and which marked point lies on that parallel face?",
))[
  Three points are marked: $R$ on edge $A B$ with $A R = 3$, $S$ on
  edge $A E$ with $A S = 3$, and $T$ on the hidden edge $D C$ with
  $D T = 3$.

  #fig(cube(
    a: 4,
    unit: SHEET-UNIT,
    grid: true,
    s-pt((4, 3, 0), label: [*R*], off: (4pt, 12pt), color: ai-col, r: 2pt),
    s-pt((4, 0, 3), label: [*S*], off: (-13pt, -2pt), color: ai-col, r: 2pt),
    s-pt((0, 3, 0), label: [*T*], off: (6pt, 11pt), color: ai-col, r: 2pt),
  ))

  Construct the section. How many sides does it have, and what shape
  is it?
][
  #fig(cube(
    a: 4,
    unit: SHEET-UNIT,
    grid: true,
    s-poly(
      ((4, 3, 0), (0, 3, 0), (0, 0, 3), (4, 0, 3)),
      fill: rgb("#f1eff9"),
      stroke-color: ai-col,
      width: 1.1pt,
    ),
    s-pt((4, 3, 0), label: [*R*], off: (4pt, 12pt), color: ai-col, r: 2pt),
    s-pt((4, 0, 3), label: [*S*], off: (-13pt, -2pt), color: ai-col, r: 2pt),
    s-pt((0, 3, 0), label: [*T*], off: (6pt, 11pt), color: ai-col, r: 2pt),
    s-pt((0, 0, 3), color: ai-col, r: 2pt),
  ))

  *Construction.* $R$ and $S$ both lie on the front face, so join them
  — that is one side. $R$ and $T$ both lie on the bottom face, so join
  them too. Now use the parallel rule twice: the back face is parallel
  to the front, so the cut across the back must be parallel to $R S$,
  and it starts at $T$. Following that direction from $T$ reaches the
  point on edge $D H$ at height $3$. The left face is parallel to the
  right face, and the section closes.

  *Result.* A quadrilateral with four vertices — $R$, $T$, the point
  at height $3$ on $D H$, and $S$. Opposite sides are parallel by
  construction, so it is a parallelogram; in fact it is a *rectangle*,
  since the side $R T$ runs along the depth direction while $R S$ lies
  in the front face perpendicular to it.
]

#ex(difficulty: 3, time: "18 min", calculator: false, hints: (
  "W and Y are on opposite vertical edges of the cube. Is there a face containing both?",
  "Start with the pair of points that DO share a face, and use the parallel rule from there.",
  "For the last part: what is the midpoint of the segment WY?",
))[
  On a cube, $W$ is the midpoint of edge $A E$, $Y$ is the midpoint of
  edge $C G$, and $T$ lies on edge $A B$ with $A T = 3$.

  #fig(cube(
    a: 4,
    unit: SHEET-UNIT,
    grid: true,
    s-pt((4, 0, 2), label: [*W*], off: (-13pt, 0pt), color: ai-col, r: 2pt),
    s-pt((0, 4, 2), label: [*Y*], off: (13pt, 0pt), color: ai-col, r: 2pt),
    s-pt((4, 3, 0), label: [*T*], off: (4pt, 12pt), color: ai-col, r: 2pt),
  ))

  + Construct the section.

  + $W$ and $Y$ are midpoints of opposite edges of the cube. Show that
    the section must therefore have a centre of symmetry, and say
    where that centre is.
][
  #fig(cube(
    a: 4,
    unit: SHEET-UNIT,
    grid: true,
    s-poly(
      ((4, 3, 0), (3, 4, 0), (0, 4, 2), (0, 1, 4), (1, 0, 4), (4, 0, 2)),
      fill: rgb("#f1eff9"),
      stroke-color: ai-col,
      width: 1.1pt,
    ),
    s-pt((4, 0, 2), label: [*W*], off: (-13pt, 0pt), color: ai-col, r: 2pt),
    s-pt((0, 4, 2), label: [*Y*], off: (13pt, 0pt), color: ai-col, r: 2pt),
    s-pt((4, 3, 0), label: [*T*], off: (4pt, 12pt), color: ai-col, r: 2pt),
  ))

  *(a)* A hexagon. Its six vertices are $T$ and $W$ (given), $Y$
  (given), and three more: the point on $B C$ at distance $3$ from
  $B$, the point on $G H$ at distance $1$ from $G$, and the point on
  $H E$ at distance $1$ from $H$.

  Construction: $T$ and $W$ share the front face — join them. $W$ and
  the point on $H E$ share the left face. $Y$ and the point on $G H$
  share the back face, and that side must be parallel to $T W$ on the
  front. And so on around, each new side either joining two points on
  a shared face or copying a direction onto the opposite face.

  *(b)* $W$ and $Y$ are midpoints of two edges of the cube that are
  diametrically opposite. The midpoint of the segment $W Y$ is
  therefore the centre of the cube, $M$ — and since $W$ and $Y$ both
  lie in the cutting plane, so does the whole segment $W Y$, and hence
  so does $M$.

  Now use the fact that the cube itself is symmetric under a point
  reflection in $M$: that reflection maps the cube to itself, and it
  maps the cutting plane to itself as well, because a plane through
  the centre of a point reflection is fixed by it. So it maps the
  section to itself. A polygon carried onto itself by a point
  reflection has a centre of symmetry — opposite sides parallel and
  equal in length.

  Check it on the drawing: $T$ and the vertex on $H E$ are opposite,
  as are $W$ and $Y$, as are the remaining pair.
]

#only-high[
  #ex(difficulty: 3, time: "15 min", calculator: false)[
    Take the plane through the midpoints of edges $A B$, $C G$ and
    $H E$ — the second case from the exploration at the start of this
    section.

    + Construct the section and identify the shape.

    + Show that all six sides have the same length, without using
      coordinates.

    + Where is the centre of this section, and what does that tell you
      about the direction in which the plane is "facing"?
  ][
    #fig(cube(
      a: 4,
      unit: SHEET-UNIT,
      grid: true,
      s-poly(
        (
          (4, 2, 0),
          (2, 4, 0),
          (0, 4, 2),
          (0, 2, 4),
          (2, 0, 4),
          (4, 0, 2),
        ),
        fill: rgb("#f1eff9"),
        stroke-color: ai-col,
        width: 1.1pt,
      ),
      s-pt((4, 2, 0), color: ai-col, r: 2pt),
      s-pt((0, 4, 2), color: ai-col, r: 2pt),
      s-pt((2, 0, 4), color: ai-col, r: 2pt),
    ))

    *(a)* A regular hexagon, through the midpoints of six of the
    twelve edges. The three unmarked vertices are the midpoints of
    $B C$, $G H$ and $A E$.

    *(b)* Every side joins the midpoints of two edges that meet at a
    common vertex of the cube, and it is the hypotenuse of a right
    triangle whose legs are both half an edge. All six sides are
    therefore hypotenuses of congruent right triangles, so all six
    have the same length. (With edge $4$, each side is $2 sqrt(2)$.)

    *(c)* Opposite vertices of the hexagon are opposite midpoints of
    the cube, so the centre of the section is the centre $M$ of the
    cube. The six edge-midpoints used are the six that are *equally
    far* from the two opposite corners $D$ and $F$ — which is another
    way of saying the plane is perpendicular to the space diagonal
    $D F$. That diagonal direction will turn out to be the plane's
    #emph[normal] direction, and computing it is a two-line
    calculation once vectors arrive.
  ]
]

== Putting Numbers on the Corners

#only-theory[
  Everything so far has been done by looking. It worked, but notice
  what it cost. The exercises had to *tell* you where the points were,
  in sentences — "on the line of edge $H G$, two units beyond $G$",
  "on edge $A B$ with $A T = 3$". Those sentences were clumsy to write
  and easy to misread, and one of them is the reason the AI box above
  was hard.

  There is a better way to say where a point is, and it has been
  sitting in the drawings all along. Put a corner of the cube at the
  origin, run the three axes along the three edges meeting there, and
  every corner acquires a triple of numbers.

  #fig(
    space3d(
      ..cube-edges(a: 4, labels: true),
      s-vec(to: (4, 4, 4), color: warn-col, label: $arrow(r)_F$, anchor: 0.55),
      axis-len: (5.5, 6, 5.5),
      unit: 0.58cm,
    ),
    caption: [The cube with $D$ at the origin. Now $F = (4, 4, 4)$ and
      no sentence is required.],
  )

  With $D$ at the origin, $A = (4, 0, 0)$, $B = (4, 4, 0)$, and so on
  up to $F = (4, 4, 4)$. The point that took a full clause to describe
  — "on the line of edge $H G$, two units beyond $G$" — is
  $(0, 6, 4)$.

  Nothing has been proved by this. Every construction in this chapter
  is still correct, and you could do the whole unit without ever
  writing a coordinate. What changes is that the questions become
  *computable*. "Where does this line cross that face?" stops being
  something you see and becomes something you solve. That is the
  trade the rest of the unit makes: you give up the picture as the
  final authority, and you get answers in cases where the picture
  cannot help.

  The picture does not go away. It becomes the thing you check the
  computation against.
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  Place the cube with $D$ at the origin, as in the figure above, with
  edge length $4$.

  + Write down the coordinates of all eight vertices.

  + Write down the coordinates of the two piercing points from the
    worked example in the previous section — the line entered the
    front face and left through the back face.

  + The part of that line inside the cube runs from one piercing point
    to the other. Using the Pythagorean theorem twice, find its exact
    length.
][
  *(a)* $A = (4, 0, 0)$, $B = (4, 4, 0)$, $C = (0, 4, 0)$,
  $D = (0, 0, 0)$, $E = (4, 0, 4)$, $F = (4, 4, 4)$, $G = (0, 4, 4)$,
  $H = (0, 0, 4)$.

  *(b)* The entry point is $(4, 1, 1)$ on the front face $x = 4$; the
  exit point is $(0, 3, 3)$ on the back face $x = 0$.

  *(c)* Going from $(4, 1, 1)$ to $(0, 3, 3)$, the changes in the three
  directions are $-4$, $+2$ and $+2$. Apply Pythagoras in the base
  plane first, then once more with the height:
  $ d = sqrt(4^2 + 2^2 + 2^2) = sqrt(24) = 2 sqrt(6) approx 4.90. $

  This is the first genuine *measurement* in the unit, and it is worth
  noticing that no drawing could have produced it — the segment runs
  into the page, where the picture halves every length.
]

#look-ahead(preview: [lines and planes in space])[
  Three questions from this chapter are about to come back with
  machinery attached.

  *Where does a line cross a face?* In the next chapters the faces
  become the three coordinate planes, the crossing points become
  #emph[trace points], and finding them is solving one linear equation
  each.

  *What polygon does a plane cut?* The parallel-faces rule you used by
  eye is the statement that two planes with the same normal direction
  never meet. Once a plane has an equation, the section's vertices are
  found by intersecting that equation with each edge in turn — twelve
  short calculations, no imagination required.

  *And the hexagon.* You showed that the section through six edge
  midpoints has all sides equal and is centred at the middle of the
  cube. What you could not show is the thing you probably suspected:
  that the plane is perpendicular to the cube's space diagonal. That
  proof takes one dot product, and it is waiting for you a few
  chapters from now.
]

#print-hints()
#print-vocab()
