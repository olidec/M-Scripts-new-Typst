// ch-graphics.typ — EXTENSION CHAPTER, registered for both levels.
//
// Nothing later depends on it and nothing in it is examinable. It is
// here to answer the question "what is any of this for?", which the
// rest of the unit answers only by assertion. Every technique used is
// already in Part A or Part B; the only genuinely new thing is
// Lambert's cosine law, which is a dot product with a physical name.
//
// The one prerequisite that is SPF-only elsewhere is the line-sphere
// intersection (ch-circles-spheres). It is re-derived from scratch in
// section 3 so that GLF readers are not blocked.

#import "../../common/preamble.typ": *
#import "/src/common/vec-figures.typ": *
#show: chapter-template.with(title: "Where the Light Goes")
#let ex = exercise.with(chapter: "Where the Light Goes")

// A circle as a polygon, for the side-view figures. Worth promoting
// into vec-figures.typ if it gets used again.
#let disc(cx, cy, r, n: 48) = range(n).map(i => {
  let t = 2 * calc.pi * i / n
  (cx + r * calc.cos(t), cy + r * calc.sin(t))
})

= Where the Light Goes

#only-theory[
  Every image in a computer-animated film is produced by arithmetic
  with vectors. Not analogously, not in spirit — the calculations in
  this chapter are the ones a renderer actually performs, millions of
  times per frame.

  What makes this worth a chapter is that nothing new is needed. A
  camera ray is a parametric line. Deciding what it hits is a
  line-plane or line-sphere intersection. Deciding how bright the spot
  looks is a dot product. Deciding whether it is in shadow is a second
  ray. Mirrors are the reflection formula from two chapters ago.

  You have the whole toolkit. This chapter assembles it.
]

#objectives(
  [set up the ray from a camera through a pixel],
  [find what a ray hits first, among several objects],
  [apply Lambert's cosine law to find how brightly a surface is lit],
  [decide whether a point is in shadow],
  [reflect a ray in a mirrored surface],
  [read the parameter of a line as time rather than as distance],
)

== Tracing Backwards

#only-theory[
  A photograph is made by light leaving a lamp, bouncing around a
  scene, and a tiny fraction of it arriving at a lens. Simulating that
  directly would be hopeless: almost every ray you launched would miss
  the camera entirely.

  So renderers run the process *backwards*. Start at the eye, send one
  ray out through each pixel of the image, and ask what it hits.
  Whatever the ray finds is what that pixel shows. Because light paths
  are reversible, the picture comes out the same — and now every ray
  you compute is one that matters.

  #fig(
    vplane(
      s-poly(disc(3.5, 1.0, 1.0), fill: rgb("#e9eef7"), stroke-color: luma(150)),
      s-seg(from: (-1, 0), to: (8, 0), color: luma(110), width: 1.1pt),
      s-seg(from: (0.8, -0.4), to: (0.8, 2.6), color: def-col, width: 1.1pt),
      s-seg(from: (0, 1), to: (2.55, 1.31), color: accent, width: 1.1pt),
      s-seg(from: (2.55, 1.31), to: (8, 1.97), color: luma(200), dashed: true),
      s-pt((0, 1), label: $E$),
      s-pt((2.55, 1.31), r: 2.2pt, color: warn-col),
      s-txt((0.8, 2.6), text(size: 8pt)[image plane], off: (0pt, -10pt)),
      s-txt((6.5, 0), text(size: 8pt)[floor], off: (0pt, 11pt)),
      xmin: -1.5, xmax: 8.5, ymin: -0.5, ymax: 3.0,
      unit: 0.72cm, grid: false, axes: false,
    ),
    caption: [Side view. One ray leaves the eye $E$, passes through one
      pixel of the image plane, and stops at the first thing it meets.],
  )
]

== The Ray

#keybox(title: "A camera ray")[
  $ arrow(r)(t) = arrow(e) + t dot arrow(d), quad t > 0, $
  where $arrow(e)$ is the eye and $arrow(d)$ is a *unit* vector
  pointing from the eye through the centre of one pixel.
]

#only-theory[
  This is the parametric line from Part A, with two conditions
  attached that matter in practice.

  *$t > 0$.* The line extends behind the camera as well, and objects
  back there are not visible. Any intersection with $t <= 0$ is
  discarded.

  *$arrow(d)$ is a unit vector.* Then $t$ is measured in *distance*,
  so comparing two hits is comparing two distances. Without
  normalizing, $t$ would still order the hits correctly along one ray,
  but the numbers would mean nothing across different rays.

  The pixel grid does the rest. Fix a rectangle in front of the eye,
  divide it into a grid, and for each cell take the direction from the
  eye to the cell's centre. One image, one ray per pixel.
]

== What Did It Hit?

#only-theory[
  === A plane

  Substitute the ray's components into the plane's Cartesian equation
  and solve for $t$, exactly as in the chapter on intersections. With
  $E: a x + b y + c z + d = 0$,
  $ t = -(arrow(n) dot arrow(e) + d) / (arrow(n) dot arrow(d)), $
  and a zero denominator means the ray runs parallel to the plane and
  misses.

  For a floor at $z = 0$ this collapses to
  $t = -e_z slash d_z$, which is as cheap as an intersection ever gets.
]

#only-theory[
  === A sphere

  A point is on the sphere with centre $M$ and radius $R$ when
  $abs(arrow(M P))^2 = R^2$. Substituting the ray and writing
  $arrow(w) = arrow(e) - arrow(r)_M$ for the vector from the centre to
  the eye,
  $ abs(arrow(w) + t dot arrow(d))^2 = R^2. $
  Expanding the square with the dot product, and using
  $arrow(d) dot arrow(d) = 1$:
  $ t^2 + 2 (arrow(w) dot arrow(d)) t
    + (abs(arrow(w))^2 - R^2) = 0. $

  An ordinary quadratic. Its discriminant decides everything:
  negative and the ray misses, zero and it grazes the silhouette,
  positive and it enters and leaves. Take the smaller positive root —
  the front surface.
]

#keybox(title: "Choosing among several objects")[
  Intersect the ray with every object, keep every $t > 0$, and take
  the *smallest*. That object is the one visible in that pixel.

  This one rule is the entire hidden-surface problem. Nothing has to
  be sorted, and nothing has to be reasoned about — near things hide
  far things because near things have smaller $t$.
]

#only-theory[
  *Worked example.* Take a floor at $z = 0$ and a sphere with
  $M = (0, 0, 1)$, $R = 1$, sitting on it. The eye is at
  $E = (0, -5, 1)$ and one ray has direction $arrow(d) = vec(0, 1, 0)$.

  For the sphere, $arrow(w) = arrow(e) - arrow(r)_M = vec(0, -5, 0)$,
  so $arrow(w) dot arrow(d) = -5$ and $abs(arrow(w))^2 - R^2 = 24$:
  $ t^2 - 10 t + 24 = 0 quad arrow.r.double quad t = 4 "or" t = 6. $
  The floor is never reached, since $d_z = 0$.

  The smaller positive root is $t = 4$, giving the hit point
  $ P = (0, -1, 1), $
  which is the near side of the sphere, facing the camera. The far
  root $t = 6$ is where the ray leaves out the back — real, but
  hidden.
]

== How Bright Is It?

#only-theory[
  A surface tilted away from a light catches less of it. Precisely: a
  patch of surface intercepts light in proportion to the cosine of the
  angle between its normal and the direction to the light. This is
  *Lambert's cosine law*, and in vector form it is a dot product.
]

#keybox(title: "Lambert's cosine law")[
  With $hat(n)$ the unit surface normal and $hat(s)$ the unit vector
  pointing *towards* the light,
  $ "brightness" = max(0, ; hat(n) dot hat(s)). $
]

#only-theory[
  #fig(
    vplane(
      s-seg(from: (-1, 0), to: (8, 0), color: luma(110), width: 1.2pt),
      s-vec(from: (3.5, 0), to: (3.5, 2.4), label: $hat(n)$, color: warn-col),
      s-vec(from: (3.5, 0), to: (5.2, 2.4), label: $hat(s)$, color: accent),
      s-arc(vertex: (3.5, 0), from: (3.5, 2.4), to: (5.2, 2.4), r: 30pt, label: $phi.alt$),
      xmin: -1.5, xmax: 8.5, ymin: -0.5, ymax: 3.0,
      unit: 0.68cm, grid: false, axes: false,
    ),
    caption: [Face the light squarely and $phi.alt = 0$, so the
      brightness is $1$. Turn away and it falls off as $cos phi.alt$.],
  )

  The $max(0, dot)$ is not decoration. When the surface faces away
  from the light the dot product is negative, and negative brightness
  is meaningless — the correct answer is that the point is unlit, and
  clamping at zero says so.

  *Example.* With the light coming from $hat(s) = vec(0, -1, 1)
  slash sqrt(2)$ and the sphere from the previous section:

  #auto-parts(
    1,
    [At the near point $P = (0, -1, 1)$ the normal is
      $hat(n) = arrow(M P) = vec(0, -1, 0)$, so
      $hat(n) dot hat(s) = 1 slash sqrt(2) approx 0.71$.],
    [At the top $P = (0, 0, 2)$ the normal is $vec(0, 0, 1)$, giving
      the same $0.71$.],
    [At the far point $P = (0, 1, 1)$ the normal is $vec(0, 1, 0)$ and
      the dot product is $-0.71$ — clamped to $0$. That point is on
      the dark side.],
  )

  Three points, one light, and the whole of shading. The gradual
  darkening around a rendered sphere is nothing but this cosine.
]

== Shadows

#only-theory[
  A surface can face the light and still be dark, because something
  stands in the way. Testing for that costs one more ray.

  From the hit point $P$, send a ray towards the light. If it strikes
  any object before reaching the light, $P$ is in shadow and its
  brightness is zero regardless of the cosine.

  #fig(
    vplane(
      s-poly(disc(3.5, 1.0, 1.0), fill: rgb("#e9eef7"), stroke-color: luma(150)),
      s-seg(from: (-1, 0), to: (8, 0), color: luma(110), width: 1.1pt),
      s-seg(from: (1.6, 0), to: (3.1, 2.6), color: accent, width: 1.1pt, dashed: true),
      s-seg(from: (5.6, 0), to: (7.1, 2.6), color: def-col, width: 1.1pt, dashed: true),
      s-pt((1.6, 0), r: 2.2pt, color: accent),
      s-pt((5.6, 0), r: 2.2pt, color: def-col),
      s-txt((1.6, 0), text(size: 8pt)[blocked], off: (-4pt, 12pt)),
      s-txt((5.6, 0), text(size: 8pt)[lit], off: (2pt, 12pt)),
      xmin: -1.5, xmax: 8.5, ymin: -0.5, ymax: 3.0,
      unit: 0.72cm, grid: false, axes: false,
    ),
    caption: [Two floor points and their shadow rays. The left one
      meets the sphere on the way; the right one does not.],
  )
]

#warning[
  A shadow ray starting exactly on a surface will often find *that
  surface* at $t = 0$, and every point will report itself as being in
  its own shadow. The image comes out uniformly black and nothing
  looks wrong in the algebra.

  The fix is to require $t > epsilon$ for some small $epsilon$, rather
  than $t > 0$. This is not a mathematical subtlety but a
  floating-point one: the hit point is only approximately on the
  surface, and "approximately zero" has to be treated as zero
  deliberately.
]

== Mirrors

#only-theory[
  If the surface is mirrored, the ray does not stop — it changes
  direction and carries on, and what the pixel shows is whatever the
  *reflected* ray finds.

  The new direction is the reflection formula from the chapter on
  vector geometry:
  $ arrow(d)' = arrow(d)
    - 2 dot (arrow(d) dot arrow(n)) / abs(arrow(n))^2 dot arrow(n). $

  *Example.* A ray with direction $vec(0, 4, -1)$ strikes the floor
  $z = 0$, whose normal is $vec(0, 0, 1)$. Then
  $arrow(d) dot arrow(n) = -1$ and
  $ arrow(d)' = vec(0, 4, -1) + 2 dot vec(0, 0, 1) = vec(0, 4, 1). $
  The vertical component has flipped and the horizontal component has
  not, which is exactly what a mirror does.

  Trace the new ray from the hit point and you have a reflection.
  Allow the process to repeat and you get reflections of reflections —
  which is why renderers impose a maximum depth, or two facing mirrors
  would run forever.
]

== The Parameter as Time

#only-theory[
  One equation has now done two entirely different jobs.

  In this chapter, $arrow(r)(t) = arrow(e) + t dot arrow(d)$ describes
  a ray of light, and $t$ measures *distance* along it.

  In the aeroplane problem that opened the chapter on lines,
  $arrow(r)(t) = arrow(r)_P + t dot arrow(v)$ described a flight path,
  and $t$ measured *time*.

  Same equation. In animation it is read the second way: an object
  with position $arrow(p)_0$ and velocity $arrow(v)$ is at
  $arrow(p)_0 + t dot arrow(v)$ at time $t$, and asking when it
  crosses a plane — the ground, a wall, the edge of the screen — is
  the same line-plane intersection you have been doing all along.

  A renderer computes where things are. An animation system computes
  where they will be. Both are the same parametric line, read with a
  different unit on the parameter.
]

#sim-box(notebook: "04-ray-tracing.ipynb", on-sheet: false)[
  The notebook builds the renderer described above, in about forty
  lines, and produces an actual image. Part A traces the single ray
  worked through in section 3 and prints its hit point, normal and
  brightness, so you can check the arithmetic against the notes.

  Part B renders the scene, with the light direction as the one line
  to change. Then: shadows switched on and off, a mirrored floor, and
  a scene of your own.
]

#look-ahead(preview: [the end of the unit])[
  There is a reason this chapter comes last and a reason it exists at
  all.

  Vectors are usually justified by saying they are *useful in physics*,
  which is true and which nobody finds convincing at sixteen. The
  honest justification is narrower and better: they are the language
  in which questions about position, direction and distance become
  arithmetic — and once a question is arithmetic, a machine can answer
  it several million times a second.

  That is what makes an animated film possible. Not the mathematics
  being clever, but the mathematics being *mechanical*.
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  A camera sits at $E = (0, -5, 1)$. One ray leaves it in the
  direction $arrow(d) = vec(0, 4, -1)$.

  #auto-parts(
    1,
    [Where does this ray meet the floor $z = 0$?],
    [Is $arrow(d)$ a unit vector? If not, what is the actual distance
      from the eye to the hit point?],
    [Explain why a renderer normalizes every direction vector, even
      though the hit point comes out the same either way.],
  )
][
  #auto-parts(
    1,
    [The component equations give $z = 1 - t$, so $z = 0$ at $t = 1$
      and the hit point is $(0, -1, 0)$.],
    [$abs(arrow(d)) = sqrt(0 + 16 + 1) = sqrt(17) approx 4.12$, so no.
      The distance travelled is $t dot abs(arrow(d)) = sqrt(17)$.],
    [Because $t$ is compared *across objects* to decide which is
      nearest, and across rays to decide how far away things are. With
      a unit direction, $t$ *is* the distance and the comparison is
      meaningful; without one, $t$ is measured in units of
      $abs(arrow(d))$, which differs from ray to ray.],
  )
]

#ex(difficulty: 2, time: "14 min", calculator: false)[
  A sphere has centre $M = (0, 0, 1)$ and radius $R = 1$. A ray starts
  at $E = (0, -5, 1)$ with unit direction $arrow(d) = vec(0, 1, 0)$.

  #auto-parts(
    1,
    [Set up the quadratic in $t$ and solve it.],
    [Which root does the renderer use, and what is the hit point?],
    [Find the unit normal at that point.],
    [What does the other root correspond to?],
  )
][
  #auto-parts(
    1,
    [$arrow(w) = arrow(e) - arrow(r)_M = vec(0, -5, 0)$, so
      $arrow(w) dot arrow(d) = -5$ and
      $abs(arrow(w))^2 - R^2 = 25 - 1 = 24$:
      $ t^2 - 10t + 24 = 0 quad arrow.r.double quad t = 4 "or" 6. $],
    [The smaller positive root, $t = 4$, giving $P = (0, -1, 1)$.],
    [$hat(n) = arrow(M P) = vec(0, -1, 0)$, already of length $1$
      because $P$ is at distance $R = 1$ from $M$ and $R = 1$ here.

      In general the normal is $arrow(M P) slash R$.],
    [$t = 6$ is where the ray leaves through the back of the sphere.
      It is a genuine intersection and it is invisible, because the
      front surface is in the way — which the "smallest positive $t$"
      rule handles without any special reasoning.],
  )
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  The light shines from the direction
  $hat(s) = vec(0, -1, 1) slash sqrt(2)$.

  Find the brightness at each of these points of the sphere
  $M = (0, 0, 1)$, $R = 1$.

  #auto-parts(
    2,
    [$P = (0, -1, 1)$],
    [$P = (0, 0, 2)$],
    [$P = (0, 1, 1)$],
    [$P = (1, 0, 1)$],
  )
][
  #auto-parts(
    2,
    [$hat(n) = vec(0, -1, 0)$, so
      $hat(n) dot hat(s) = 1 slash sqrt(2) approx 0.71$.],
    [$hat(n) = vec(0, 0, 1)$, so again $approx 0.71$.],
    [$hat(n) = vec(0, 1, 0)$, giving $-0.71$, clamped to $0$ — the
      dark side.],
    [$hat(n) = vec(1, 0, 0)$, giving $0$ exactly. This point is on the
      terminator, the circle separating lit from unlit.],
  )

  Parts (a) and (b) are equally bright even though one faces the
  camera and the other faces straight up. Brightness depends on the
  angle to the *light*, not to the viewer — which is why a matte
  object looks the same from wherever you stand.
]

#ex(difficulty: 3, time: "16 min", calculator: false, hints: (
  "A shadow ray starts at the floor point and travels towards the light. Write it parametrically.",
  "Substitute into the sphere's equation and look at the discriminant — you do not need the roots themselves.",
))[
  The floor is $z = 0$, the sphere has $M = (0, 0, 1)$ and $R = 1$,
  and the light comes from $hat(s) = vec(0, -1, 1) slash sqrt(2)$.

  Decide whether each floor point is lit or in shadow.

  #auto-parts(
    2,
    [$Q = (0, -1, 0)$],
    [$Q = (0, 1, 0)$],
  )
][
  In both cases the shadow ray is $Q + u dot hat(s)$, and we substitute
  into $abs(arrow(r) - arrow(r)_M)^2 = 1$.

  #auto-parts(
    1,
    [With $arrow(w) = Q - M = vec(0, -1, -1)$:
      $ u^2 + 2 (arrow(w) dot hat(s)) u + (abs(arrow(w))^2 - 1) = 0, $
      and $arrow(w) dot hat(s) = (1 - 1) slash sqrt(2) = 0$ with
      $abs(arrow(w))^2 - 1 = 1$, so the equation is $u^2 + 1 = 0$.
      The discriminant is $-4 < 0$: no intersection, so $Q$ is
      *lit*.],
    [With $arrow(w) = vec(0, 1, -1)$:
      $arrow(w) dot hat(s) = (-1 - 1) slash sqrt(2) = -sqrt(2)$ and
      $abs(arrow(w))^2 - 1 = 1$, so
      $ u^2 - 2 sqrt(2) u + 1 = 0, $
      with discriminant $8 - 4 = 4 > 0$ and roots
      $u = sqrt(2) plus.minus 1$, both positive. The ray meets the
      sphere before reaching the light, so $Q$ is *in shadow*.],
  )

  Note that only the *sign* of the discriminant was needed in (a). A
  renderer does the same: for a shadow test it asks whether anything
  is hit, never where.
]

#ex(difficulty: 3, time: "14 min", calculator: false)[
  A mirrored floor lies in the plane $z = 0$.

  #auto-parts(
    1,
    [A ray with direction $vec(0, 4, -1)$ strikes it at
      $(0, -1, 0)$. Find the direction of the reflected ray, and its
      parametric equation.],
    [Show that the reflected direction has the same magnitude as the
      original, and explain why it must.],
    [The sphere $M = (0, 0, 1)$, $R = 1$ also sits on this floor. Does
      the reflected ray hit it?],
  )
][
  #auto-parts(
    1,
    [$arrow(n) = vec(0, 0, 1)$ and $arrow(d) dot arrow(n) = -1$, so
      $ arrow(d)' = vec(0, 4, -1) + 2 dot vec(0, 0, 1) = vec(0, 4, 1), $
      $ arrow(r) = vec(0, -1, 0) + u dot vec(0, 4, 1). $],
    [Both have magnitude $sqrt(17)$. Reflection reverses the component
      perpendicular to the mirror and leaves the parallel component
      untouched; reversing a sign does not change a length, and by
      Pythagoras the total length is unchanged.],
    [Substituting $(0, -1 + 4u, u)$ into
      $x^2 + y^2 + (z - 1)^2 = 1$:
      $ (4u - 1)^2 + (u - 1)^2 = 1
        quad arrow.r.double quad 17u^2 - 10u + 1 = 0. $
      The discriminant is $100 - 68 = 32 > 0$, so yes — the reflected
      ray does strike the sphere, at
      $u = (5 plus.minus 2 sqrt(2)) slash 17$, taking the smaller
      root.

      In the rendered image this appears as the sphere's reflection in
      the floor.],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  A ball is at $arrow(p)_0 = (1, 2, 10)$ at time $t = 0$ and moves
  with constant velocity $arrow(v) = vec(0, 3, -2)$, where $t$ is in
  seconds.

  #auto-parts(
    1,
    [Where is it after $3$ seconds?],
    [When does it reach the ground $z = 0$, and where?],
    [How fast is it travelling?],
    [The same expression appeared in this chapter as a ray of light.
      What is different about it here?],
  )
][
  #auto-parts(
    1,
    [$(1, 11, 4)$.],
    [$z = 10 - 2t = 0$ gives $t = 5$ seconds, at the point
      $(1, 17, 0)$.],
    [$abs(arrow(v)) = sqrt(0 + 9 + 4) = sqrt(13) approx 3.6$ units per
      second.],
    [Only the *meaning of the parameter*. For a ray, $t$ measures
      distance along the line and the direction is normalized so that
      it does. Here $t$ measures time, the direction is not
      normalized, and its magnitude carries the speed.

      Everything else — the equation, the intersection method, the
      arithmetic — is identical.],
  )
]

#print-hints()
#print-vocab()
