// ch-crash-course.typ — SPF ONLY, self-study.
//
// A compressed route through the whole vectors unit (vectors/ and
// vectors-space/) for a student who missed it, aimed at Matura level
// in the shortest honest time (about 9.5 hours of work).
//
// Registered in this unit's main-high.typ alone, so nothing here needs
// an only-high wrapper. Solutions are NOT in the notes: they live in
// solutions-high.typ, which is the booklet the student self-checks
// against. Hints are printed at the end of every module rather than
// at the end of the chapter, so they sit next to the work.
//
// Structure: each module = key boxes with one worked example each,
// 3-4 core exercises, and a final GATE exercise. Solving the gate
// unaided within its time is the signal to move on.
//
// Content is cut from the unit chapters. Omitted on purpose: spatial
// reasoning by eye, direction angles and forces on a slope, scalar vs
// vector quantities, 2D point-slope and intercept forms, triangle
// centres, the graphics chapter, explorations and AI boxes.
//
// Every numerical answer was checked in exact (Fraction) arithmetic.
// Exam questions 1 and 2 are taken verbatim from vectors-space
// ch-review; exam question 3 is new.

#import "../../common/preamble.typ": *
#import "../../common/vec-figures.typ": *
#show: chapter-template.with(title: "Vectors Crash Course")
#let ex = exercise.with(chapter: "Vectors Crash Course")

// Marks the last exercise of each module.
#let gate = text(weight: "bold", fill: task-col)[Gate exercise.]

= Vectors Crash Course

#only-theory[
  This is the whole vectors unit, compressed. It is written for
  someone who missed the unit entirely and needs to reach the level
  of a final examination question in as little time as possible.

  Nothing here is new compared with the full notes; a great deal has
  been left out. What remains is every tool an exam can ask for, one
  worked example per tool, and a small number of exercises chosen so
  that each one practises something the others do not.
]

#keybox(title: "How to use this course")[
  - Work through the modules *in order*. Each one uses the previous
    ones. The time next to each heading is a budget, not a deadline.
  - Read a key box, then follow its worked example *with a pencil*,
    covering the lines below the one you are on. Reading worked
    examples without writing is the slowest way to learn this.
  - The last exercise of every module is a *gate*. If you solve it
    without help in the time shown, move on. If not, redo the worked
    examples of that module and the exercise you found hardest, then
    try the gate again.
  - Solutions are in the separate *solutions booklet*. Look only after
    you have finished an exercise or genuinely stalled for a while.
    Hints, one at a time, are at the end of each module.
  - Have the formula booklet open at §12 _Vector Geometry_. Part of
    the skill is knowing which formulas to look up and which to know
    by heart; the key boxes tell you which is which.
  - Work *without a calculator* unless an exercise says CALC. The
    numbers are chosen so that everything comes out exactly. An answer
    such as $cos(phi.alt) = 14 slash 15$ or $3 sqrt(29)$ is finished.
]

#objectives(
  bfkm[calculate with vectors in components: differences, lengths,
    scalar multiples, midpoints, unit vectors],
  bfkm[calculate the dot product and the cross product and use them to
    find angles, perpendicular vectors and areas],
  bfkm[describe lines and planes by equations and convert between the
    forms],
  [classify the relative position of two lines, of a line and a plane,
    and of two planes, and find their intersections],
  [solve angle and distance problems: point–plane, point–line,
    parallel planes, skew lines, foot of the perpendicular,
    reflection],
  [calculate areas and volumes of triangles, pyramids and tetrahedra],
  [describe circles and spheres by equations and solve intersection
    and tangent problems],
  [work an examination question through under examination conditions],
)

// ════════════════════════════════════════════════════════════
== Before You Start (15 min)

#only-theory[
  Vectors use three skills from earlier years constantly: solving
  small systems of linear equations, Pythagoras, and reading off
  standard angles. Check them now. If Exercise 1 takes more than
  fifteen minutes, revise systems of equations first — almost every
  later problem ends in one.
]

#keybox(title: "Checking with the TI-Nspire CAS")[
  You will work by hand, but your CAS is an excellent *checker*.
  Vectors are entered as lists, for example `[1, 2, 3]`:

  - `dotP([1,2,3], [4,5,6])` — dot product
  - `crossP([1,2,3], [4,5,6])` — cross product
  - `norm([1,2,3])` — magnitude

  Use them after you have an answer, never instead of one. The exam
  has a part without a calculator, and you need the hand methods
  there.
]

#ex(difficulty: 1, time: "15 min", calculator: false)[
  #auto-parts(
    1,
    [Solve $ #system(($2s - t$, $4$), ($s + 3t$, $9$)) $],
    [Solve $ #system(($x + y + z$, $6$), ($2x - y + z$, $3$), ($x + 2y - z$, $2$)) $],
    [A box is $2$ wide, $3$ deep and $6$ high. How long is the
      diagonal from one corner to the opposite corner?],
    [Give exact angles: $arccos(1 slash 2)$, $arcsin(sqrt(2) slash 2)$,
      $arccos(-sqrt(3) slash 2)$, $arccos(0)$.],
  )
][
  #auto-parts(
    1,
    [From the first equation $t = 2s - 4$. Substituting,
      $s + 3 dot (2s - 4) = 9$, so $7s = 21$, $s = 3$ and $t = 2$.
      Check: $6 - 2 = 4$ ✓, $3 + 6 = 9$ ✓.],
    [Adding the first and third equations eliminates $z$:
      $2x + 3y = 8$. Adding the second and third:
      $3x + y = 5$, so $y = 5 - 3x$. Then
      $2x + 15 - 9x = 8$, so $x = 1$, $y = 2$, and from the first
      equation $z = 3$. Check all three:
      $6$ ✓, $2 - 2 + 3 = 3$ ✓, $1 + 4 - 3 = 2$ ✓.],
    [Pythagoras twice: $sqrt(2^2 + 3^2 + 6^2) = sqrt(49) = 7$. This is
      exactly the length of the vector $vec(2, 3, 6)$, which you will
      meet again.],
    [$60 degree$, $45 degree$, $150 degree$, $90 degree$.],
  )
]

// ════════════════════════════════════════════════════════════
== Vectors as Columns (60 min)

#only-theory[
  A #vocab("vector", "Vektor") is a displacement: a size together
  with a direction. It is drawn as an arrow, but where the arrow is
  drawn does not matter — a vector may be shifted parallel to itself
  freely. A point, by contrast, is a place. In calculations both are
  written as three numbers, and keeping them apart is the first habit
  to build.
]

#keybox(title: "Points, position vectors, components")[
  A point is written $A = (a_x, a_y, a_z)$. Its
  #vocab("position vector", "Ortsvektor") is the vector from the
  origin to it:
  $ arrow(r)_A = arrow(O A) = vec(a_x, a_y, a_z). $

  The numbers in the column are the
  #vocab("components", "Komponenten"). Calculating with vectors means
  calculating with components, one row at a time:
  $
    vec(a_x, a_y, a_z) + vec(b_x, b_y, b_z)
    = vec(a_x + b_x, a_y + b_y, a_z + b_z), quad
    k dot vec(a_x, a_y, a_z) = vec(k dot a_x, k dot a_y, k dot a_z).
  $
]

#remark[
  The formula booklet writes points as $A(2 slash -1 slash 4)$. These
  notes write $A = (2, -1, 4)$. Same thing.
]

#keybox(title: "Endpoint minus starting point — know by heart")[
  $
    arrow(A B) = arrow(r)_B - arrow(r)_A
    = vec(b_x - a_x, b_y - a_y, b_z - a_z), quad
    abs(arrow(a)) = sqrt(a_x^2 + a_y^2 + a_z^2).
  $
  The distance between two points is the magnitude of the vector
  joining them: $d(A, B) = abs(arrow(A B))$.
]

#keybox(title: "Parallel vectors and collinear points")[
  $arrow(a)$ and $arrow(b)$ are #vocab("parallel", "kollinear")
  exactly when one is a multiple of the other,
  $arrow(b) = k dot arrow(a)$. Test it by dividing component by
  component: the *same* factor must appear in *every* row.

  Three points $A$, $B$, $C$ lie on one line exactly when
  $arrow(A C) = k dot arrow(A B)$ for some $k$.
]

#keybox(title: "Midpoint, centroid, dividing a segment")[
  $
    arrow(r)_M = 1/2 dot (arrow(r)_A + arrow(r)_B), quad
    arrow(r)_S = 1/3 dot (arrow(r)_A + arrow(r)_B + arrow(r)_C),
  $
  and the point a fraction $t$ of the way from $A$ to $B$ is
  $ arrow(r)_P = arrow(r)_A + t dot arrow(A B). $
  ($M$: midpoint of $A B$. $S$: centroid of triangle $A B C$.)
]

#keybox(title: "Unit vectors and prescribed lengths")[
  The #vocab("unit vector", "Einheitsvektor") in the direction of
  $arrow(a)$ has length $1$:
  $ arrow(e)_a = 1/abs(arrow(a)) dot arrow(a). $
  A vector of length $L$ in that direction is $L dot arrow(e)_a$.
]

#example(title: "All of the above, once")[
  Take $A = (1, 2, 2)$, $B = (4, 8, 8)$, $C = (5, -2, 4)$.

  - $arrow(A B) = vec(3, 6, 6)$ and
    $abs(arrow(A B)) = sqrt(9 + 36 + 36) = 9$.
  - $arrow(A C) = vec(4, -4, 2)$. The ratios to $arrow(A B)$ are
    $4 slash 3$ and $-4 slash 6$ — already different, so the points
    are *not* collinear.
  - Midpoint of $A B$: $M = (5 slash 2, 5, 5)$. Centroid:
    $S = (10 slash 3, 8 slash 3, 14 slash 3)$.
  - The point one third of the way from $A$ to $B$:
    $arrow(r)_A + 1/3 dot vec(3, 6, 6) = vec(2, 4, 4)$, so
    $P = (2, 4, 4)$.
  - A vector of length $12$ in the direction of $arrow(A B)$:
    $12/9 dot vec(3, 6, 6) = vec(4, 8, 8)$. Check:
    $sqrt(16 + 64 + 64) = 12$ ✓.
]

#warning[
  *The order:* $arrow(A B)$ is $B$ minus $A$. Reversing it gives a
  vector pointing the wrong way.

  *The proof of parallelism:* two matching ratios prove nothing; the
  factor has to work in every component. And if a component of one
  vector is $0$, the matching component of the other must be $0$ too.
]

#ex(difficulty: 1, time: "10 min", calculator: false)[
  Let $A = (3, -1, 2)$ and $B = (5, 3, -2)$.

  #auto-parts(
    1,
    [Find $arrow(A B)$ and $abs(arrow(A B))$.],
    [Find the midpoint of $A B$.],
    [Find the unit vector in the direction of $arrow(A B)$.],
    [Find the vector of length $9$ pointing *opposite* to
      $arrow(A B)$.],
  )
][
  #auto-parts(
    1,
    [$arrow(A B) = vec(2, 4, -4)$ and
      $abs(arrow(A B)) = sqrt(4 + 16 + 16) = 6$.],
    [$M = ((3 + 5) slash 2, (-1 + 3) slash 2, (2 - 2) slash 2)
      = (4, 1, 0)$.],
    [$arrow(e) = 1/6 dot vec(2, 4, -4)
      = vec(1 slash 3, 2 slash 3, -2 slash 3)$. Check: the squares add
      to $1 slash 9 + 4 slash 9 + 4 slash 9 = 1$ ✓.],
    [$-9 dot arrow(e) = vec(-3, -6, 6)$. Length
      $sqrt(9 + 36 + 36) = 9$ ✓.],
  )
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  #auto-parts(
    1,
    [Do $A = (-2, 5, -4)$, $B = (10, -1, 0)$ and $C = (-8, 8, -6)$ lie
      on one line?],
    [Do $A = (6, -3, 4)$, $B = (2, 7, -6)$ and $C = (-4, 22, -18)$
      lie on one line?],
    [Find $x$ so that $A = (5, -6)$, $B = (-7, -3)$ and $C = (x, 5)$
      lie on one line.],
  )
][
  #auto-parts(
    1,
    [$arrow(A B) = vec(12, -6, 4)$ and $arrow(A C) = vec(-6, 3, -2)$.
      Every ratio is $-1 slash 2$, so
      $arrow(A C) = -1/2 dot arrow(A B)$: *collinear*, with $C$ on the
      far side of $A$ from $B$.],
    [$arrow(A B) = vec(-4, 10, -10)$ and
      $arrow(A C) = vec(-10, 25, -22)$. The ratios are $2.5$, $2.5$
      and $2.2$. *Not* collinear — the classic trap: two out of three
      is not enough.],
    [$arrow(A B) = vec(-12, 3)$ and $arrow(A C) = vec(x - 5, 11)$. The
      second components contain no unknown, so they fix the factor:
      $11 = 3k$, $k = 11 slash 3$. Then
      $x - 5 = 11/3 dot (-12) = -44$, so $x = -39$.],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  $A = (1, 0, 2)$, $B = (4, 2, 1)$ and $C = (6, 5, 3)$ are three
  vertices of the parallelogram $A B C D$.

  #auto-parts(
    1,
    [Find $D$.],
    [Find the point where the diagonals meet, and check your answer
      using both diagonals.],
    [Find the centroid of triangle $A B C$.],
  )
][
  #auto-parts(
    1,
    [In a parallelogram $arrow(A D) = arrow(B C) = vec(2, 3, 2)$, so
      $arrow(r)_D = arrow(r)_A + vec(2, 3, 2)$ and $D = (3, 3, 4)$.
      Check: $arrow(A B) = vec(3, 2, -1) = arrow(D C)$ ✓.],
    [The diagonals bisect each other. Midpoint of $A C$:
      $(7 slash 2, 5 slash 2, 5 slash 2)$. Midpoint of $B D$:
      $((4 + 3) slash 2, (2 + 3) slash 2, (1 + 4) slash 2)
      = (7 slash 2, 5 slash 2, 5 slash 2)$ ✓.],
    [$S = 1/3 dot (1 + 4 + 6, 0 + 2 + 5, 2 + 1 + 3)
      = (11 slash 3, 7 slash 3, 2)$.],
  )
]

#ex(difficulty: 3, time: "12 min", calculator: false, hints: (
  "In (a), take the factor k from the component pair that contains no unknown.",
  "In (b), a point on the z-axis is (0, 0, z): one unknown. Square the distance condition before doing anything else.",
))[
  #gate

  #auto-parts(
    1,
    [For which $t$ and $s$ are $vec(3, t, -6)$ and $vec(9, -12, s)$
      parallel?],
    [Which points on the $z$#"‑"axis are exactly $7$ units from
      $P = (-6, 3, 7)$?],
  )
][
  #auto-parts(
    1,
    [The first components give the factor: $9 = 3k$, so $k = 3$. Then
      $-12 = 3t$ gives $t = -4$, and $s = 3 dot (-6) = -18$.],
    [With $Q = (0, 0, z)$:
      $abs(arrow(P Q))^2 = 36 + 9 + (z - 7)^2 = 49$, so
      $(z - 7)^2 = 4$ and $z = 9$ or $z = 5$. The points are
      $(0, 0, 9)$ and $(0, 0, 5)$.

      Two answers is what to expect: the points at distance $7$ from
      $P$ form a sphere, and a line meets a sphere at most twice.],
  )
]

#print-hints()

// ════════════════════════════════════════════════════════════
== The Dot Product (60 min)

#only-theory[
  The dot product turns two vectors into a number, and that number
  carries the angle between them. It is the tool for every
  perpendicularity question in the rest of the course.
]

#definition(title: "Dot product — know by heart")[
  $
    arrow(a) dot arrow(b) = a_x dot b_x + a_y dot b_y + a_z dot b_z
    = abs(arrow(a)) dot abs(arrow(b)) dot cos(phi.alt),
  $
  where $phi.alt$ is the angle between the two vectors. This is the
  #vocab("dot product", "Skalarprodukt").
]

#keybox(title: "Angle, sign, perpendicularity")[
  $
    cos(phi.alt) = (arrow(a) dot arrow(b)) /
    (abs(arrow(a)) dot abs(arrow(b))),
    quad 0 degree <= phi.alt <= 180 degree.
  $
  The sign alone tells you a lot: $arrow(a) dot arrow(b) > 0$ means
  acute, $= 0$ means a right angle, $< 0$ means obtuse. In particular,
  for non-zero vectors,
  $
    arrow(a) perp arrow(b)
    quad arrow.l.r.double quad
    arrow(a) dot arrow(b) = 0.
  $
  Also worth knowing: $arrow(a) dot arrow(a) = abs(arrow(a))^2$.
]

#keybox(title: "Splitting a vector along a direction — look up")[
  The part of $arrow(b)$ along $arrow(a)$, and the part across it:
  $
    arrow(b)_(∥) = (arrow(a) dot arrow(b)) / abs(arrow(a))^2
    dot arrow(a),
    quad quad
    arrow(b)_(⊥) = arrow(b) - arrow(b)_(∥).
  $
  The idea behind it — dotting with a unit vector measures how far you
  get in that direction — is what makes distances work later on.
]

#example[
  *Angle.* $arrow(a) = vec(1, -2, 2)$ and $arrow(b) = vec(-3, 0, -3)$:
  $arrow(a) dot arrow(b) = -3 + 0 - 6 = -9$, $abs(arrow(a)) = 3$,
  $abs(arrow(b)) = sqrt(18) = 3 sqrt(2)$, so
  $
    cos(phi.alt) = (-9)/(9 sqrt(2)) = -1/sqrt(2)
    quad arrow.r.double quad phi.alt = 135 degree.
  $

  *Splitting.* $arrow(b) = vec(3, 3, 0)$ along $arrow(a) = vec(1, 2, 2)$:
  $arrow(a) dot arrow(b) = 9$ and $abs(arrow(a))^2 = 9$, so
  $arrow(b)_(∥) = vec(1, 2, 2)$ and
  $arrow(b)_(⊥) = vec(2, 1, -2)$. Two checks: they add back to
  $arrow(b)$, and $vec(1, 2, 2) dot vec(2, 1, -2) = 0$ ✓.
]

#warning[
  $arrow(a) dot arrow(b) = 0$ does *not* mean one of the vectors is
  $arrow(0)$: $vec(2, 3) dot vec(3, -2) = 0$. For the same reason you
  cannot cancel — $arrow(a) dot arrow(b) = arrow(a) dot arrow(c)$ does
  not give $arrow(b) = arrow(c)$ — and you can never divide by a
  vector.
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Without calculating any angle, decide whether the angle is acute,
  right or obtuse. Then give the exact angle in (e) and (f).

  #auto-parts(
    2,
    [$vec(5, 1, -2)$ and $vec(1, 3, 4)$],
    [$vec(-2, 6, 1)$ and $vec(3, 1, 2)$],
    [$vec(4, -1, 2)$ and $vec(1, 2, -1)$],
    [$vec(0, 7, -3)$ and $vec(9, 3, 8)$],
    [$vec(1, 1, 0)$ and $vec(1, 0, 1)$],
    [$vec(1, 1, 0)$ and $vec(-1, 0, 1)$],
  )
][
  #auto-parts(
    2,
    [$5 + 3 - 8 = 0$: right angle.],
    [$-6 + 6 + 2 = 2 > 0$: acute.],
    [$4 - 2 - 2 = 0$: right angle.],
    [$0 + 21 - 24 = -3 < 0$: obtuse.],
    [Dot product $1$, both lengths $sqrt(2)$:
      $cos(phi.alt) = 1 slash 2$, so $60 degree$.],
    [Dot product $-1$: $cos(phi.alt) = -1 slash 2$, so
      $120 degree$.],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  $A = (1, 2, 3)$, $B = (-3, 2, 4)$ and $C = (1, -4, 3)$ form a
  triangle.

  #auto-parts(
    1,
    [Show that the triangle has a right angle, and say at which
      vertex.],
    [Find its area exactly.],
  )
][
  #auto-parts(
    1,
    [$arrow(A B) = vec(-4, 0, 1)$ and $arrow(A C) = vec(0, -6, 0)$ have
      dot product $0$, so the right angle is at $A$.],
    [The two legs are $abs(arrow(A B)) = sqrt(17)$ and
      $abs(arrow(A C)) = 6$, so
      $"Area" = 1/2 dot sqrt(17) dot 6 = 3 sqrt(17)$.],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  The vector $vec(7, a, b)$ is perpendicular to both $vec(4, 3, 8)$
  and $vec(-5, 20, 9)$. Find $a$ and $b$.
][
  Two dot products set to zero:
  $ #system(($28 + 3a + 8b$, $0$), ($-35 + 20a + 9b$, $0$)) $
  that is $3a + 8b = -28$ and $20a + 9b = 35$. Multiply the first by
  $20$ and the second by $3$ and subtract: $133b = -665$, so
  $b = -5$, and then $3a = 12$, $a = 4$.

  *Check:* $28 + 12 - 40 = 0$ ✓ and $-35 + 80 - 45 = 0$ ✓.

  Keep this exercise in mind. In the next section but one, the
  cross product will
  produce a vector perpendicular to two given vectors in one line:
  $vec(4, 3, 8) times vec(-5, 20, 9) = vec(-133, -76, 95)
  = -19 dot vec(7, 4, -5)$.
]

#ex(difficulty: 3, time: "15 min", calculator: true, hints: (
  "For (a), compute a·b and |a|² first; the rest is the booklet formula.",
  "For (b), put D at the origin: then F = (4, 4, 4), A = (4, 0, 0) and G = (0, 4, 4).",
))[
  #gate

  #auto-parts(
    1,
    [Split $arrow(b) = vec(5, 4, 1)$ into a part parallel to
      $arrow(a) = vec(2, 2, -1)$ and a part perpendicular to it. Check
      both parts.],
    [A cube has edge $4$. Its bottom face is $A B C D$ with $D$ at
      the origin, $A = (4, 0, 0)$, $B = (4, 4, 0)$, $C = (0, 4, 0)$,
      and the top face $E F G H$ lies directly above, $E$ over $A$, $F$
      over $B$, and so on. Find the
      angle between the space diagonal $arrow(D F)$ and the edge
      $arrow(D A)$, and the angle between the two space diagonals
      $arrow(D F)$ and $arrow(A G)$. Give exact cosines first.],
  )
][
  #auto-parts(
    1,
    [$arrow(a) dot arrow(b) = 10 + 8 - 1 = 17$ and
      $abs(arrow(a))^2 = 9$, so
      $
        arrow(b)_(∥) = 17/9 dot vec(2, 2, -1)
        = vec(34 slash 9, 34 slash 9, -17 slash 9), quad
        arrow(b)_(⊥) = vec(11 slash 9, 2 slash 9, 26 slash 9).
      $
      *Checks:* the two parts add to $arrow(b)$, and
      $arrow(a) dot arrow(b)_(⊥) = (22 + 4 - 26) slash 9 = 0$ ✓.],
    [$F = (4, 4, 4)$ and $G = (0, 4, 4)$, so
      $arrow(D F) = vec(4, 4, 4)$, $arrow(D A) = vec(4, 0, 0)$,
      $arrow(A G) = vec(-4, 4, 4)$.

      Diagonal and edge: $cos(phi.alt) = 16 slash (4 sqrt(3) dot 4)
      = 1 slash sqrt(3)$, so $phi.alt approx 54.7 degree$.

      Two diagonals: dot product $-16 + 16 + 16 = 16$, both lengths
      $4 sqrt(3)$, so $cos(phi.alt) = 16 slash 48 = 1 slash 3$ and
      $phi.alt approx 70.5 degree$.],
  )
]

#print-hints()

// ════════════════════════════════════════════════════════════
== Lines (90 min)

#keybox(title: "The vector equation of a line — know by heart")[
  A line through the point $A$ with
  #vocab("direction vector", "Richtungsvektor") $arrow(v)$:
  $ g: arrow(r) = arrow(r)_A + t dot arrow(v), quad t in RR. $
  Written out row by row, these are the three *component equations*
  $x = a_x + t dot v_x$, $y = a_y + t dot v_y$,
  $z = a_z + t dot v_z$, and that is what you actually calculate with.

  A line has infinitely many correct equations: any point of it as
  anchor, any non-zero multiple of $arrow(v)$ as direction. An answer
  that looks different from the solutions is not therefore wrong.
]

#keybox(
  title: "Point on a line, and trace points",
)[
  *Point test.* Solve *one* component equation for $t$, then check
  that the *same* $t$ works in the other two.

  #vocab("Trace points", "Spurpunkte"): $S_x$, $S_y$, $S_z$ are where
  the line meets the coordinate planes; the subscript names the
  coordinate that is zero. For $S_z$, set $z = 0$, solve for $t$,
  substitute. If $v_z = 0$, the line never reaches $z = 0$ (unless it
  lies in it) and $S_z$ does not exist — write "none".
]

#example[
  $g: arrow(r) = vec(1, -3, 3) + t dot vec(1, 1, -3)$.

  - $S_z$: $3 - 3t = 0$, $t = 1$, giving $S_z = (2, -2, 0)$.
  - $S_x$: $1 + t = 0$, $t = -1$, giving $S_x = (0, -4, 6)$.
  - $S_y$: $-3 + t = 0$, $t = 3$, giving $S_y = (4, 0, -6)$.

  Is $(3, -1, -3)$ on $g$? From $x$: $t = 2$. Then
  $y = -3 + 2 = -1$ ✓ and $z = 3 - 6 = -3$ ✓. Yes.
]

#keybox(title: "Two lines in space")[
  Two lines are #emph[identical], #emph[parallel], #emph[intersecting]
  or #vocab("skew", "windschief") — not parallel and never meeting,
  which is the *ordinary* case in space.

  + *Are the directions parallel?*
    - Yes: test whether the anchor point of one lies on the other.
      It does → identical. It does not → parallel.
    - No: go to step 2.
  + Set the two equations equal (with *different* parameters $t$ and
    $s$). That gives three equations in two unknowns. Solve two of
    them, then test the values in the *third*.
    - Third equation holds → intersecting; substitute $t$ to get the
      point.
    - Third equation fails → skew.
]

#example[
  $g: arrow(r) = vec(5, 4, 5) + t dot vec(2, 1, -3)$ and
  $h: arrow(r) = vec(0, 0, -1) + s dot vec(1, 1, 1)$.

  The directions are not parallel. Component by component:
  $ 5 + 2t = s, quad 4 + t = s, quad 5 - 3t = -1 + s. $
  The first two give $5 + 2t = 4 + t$, so $t = -1$ and $s = 3$. The
  third: left side $5 + 3 = 8$, right side $-1 + 3 = 2$. They differ,
  so the lines are *skew*.

  Had you stopped after two equations, you would have reported an
  intersection that does not exist.
]

#keybox(title: "Angle between two lines")[
  $
    cos(phi.alt) = abs(arrow(v)_1 dot arrow(v)_2) /
    (abs(arrow(v)_1) dot abs(arrow(v)_2)),
    quad 0 degree <= phi.alt <= 90 degree.
  $
  The absolute value is new: a line has no preferred direction, so
  the angle between lines is always the acute one. This works for
  skew lines too.
]

#keybox(title: "Lines in the plane")[
  In two dimensions a line also has a
  #vocab("Cartesian equation", "Koordinatengleichung")
  $ g: a x + b y + c = 0, $
  and $vec(a, b)$ is a #vocab("normal vector", "Normalenvektor") — a
  vector perpendicular to the line. From a direction $vec(v_x, v_y)$
  you get a normal by swapping the components and flipping one sign:
  $vec(3, 2) arrow.r vec(2, -3)$. Then the equation is
  $a dot (x - x_A) + b dot (y - y_A) = 0$ for any point $A$ of the
  line.

  In space there is no such single equation for a line. One equation
  in $x$, $y$, $z$ describes a *plane*, which is next.
]

#warning[
  Three errors cost marks every year in this module: using the same
  parameter for both lines, skipping the third equation, and leaving
  out the absolute value in the angle between two lines.
]

#remark[
  The formula booklet writes the second parameter as $tilde(t)$
  instead of $s$. Same thing.
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  #auto-parts(
    1,
    [Write down two different vector equations for the line $g$
      through $P = (1, -2, 2)$ and $Q = (3, -1, 2)$.],
    [Do $(7, 1, 2)$ and $(5, 0, 3)$ lie on $g$?],
  )
][
  #auto-parts(
    1,
    [$arrow(r) = vec(1, -2, 2) + t dot vec(2, 1, 0)$ and, for
      example, $arrow(r) = vec(3, -1, 2) + t dot vec(-4, -2, 0)$.
      Every point has $z = 2$, because $v_z = 0$.],
    [$(7, 1, 2)$: $1 + 2t = 7$ gives $t = 3$; then $y = -2 + 3 = 1$ ✓
      and $z = 2$ ✓. *Yes.*

      $(5, 0, 3)$: $z = 3 eq.not 2$, and every point of $g$ has
      $z = 2$. *No.*],
  )
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  #auto-parts(
    1,
    [Find all trace points of
      $arrow(r) = vec(2, 5, 9) + t dot vec(0, 5, 3)$, and explain any
      that are missing.],
    [Find all trace points of
      $arrow(r) = vec(-5, 6, -2) + t dot vec(5, 0, 1)$.],
    [A line has trace points $S_z = (2, -3, 0)$ and
      $S_x = (0, -2, 1)$. Find its third trace point.],
  )
][
  #auto-parts(
    1,
    [$S_z$: $9 + 3t = 0$, $t = -3$, so $S_z = (2, -10, 0)$.
      $S_y$: $5 + 5t = 0$, $t = -1$, so $S_y = (2, 0, 6)$.
      $S_x$: none — $v_x = 0$, so $x = 2$ on the whole line, which is
      parallel to the $y z$#"‑"plane.],
    [$S_x$: $t = 1$, $(0, 6, -1)$. $S_z$: $t = 2$, $(5, 6, 0)$.
      $S_y$: none, since $y = 6$ throughout.],
    [The direction is $arrow(S_z S_x) = vec(-2, 1, 1)$, so
      $g: arrow(r) = vec(2, -3, 0) + t dot vec(-2, 1, 1)$. For $S_y$:
      $-3 + t = 0$, $t = 3$, giving $S_y = (-4, 0, 3)$.],
  )
]

#ex(
  difficulty: 3,
  time: "20 min",
  calculator: false,
  keep-together: false,
  hints: (
    "Always look at the directions first. If they are parallel you never need to solve a system.",
    "In the other branch: solve two equations, then TEST the third.",
    "In (e), one component equation reads 1 = 1. What does that leave you with?",
  ),
)[
  Classify each pair as identical, parallel, intersecting or skew.
  Give the intersection point where there is one.

  #auto-parts(
    1,
    [$g: vec(14, -1, 15) + s dot vec(-6, 4.5, -9)$, #h(6pt)
      $h: vec(4, 6.5, 0) + t dot vec(4, -3, 6)$],
    [$g: vec(3, -6, 10) + s dot vec(-6, 1, 8)$, #h(6pt)
      $h: vec(6, 9, 4) + t dot vec(-3, 0, 4)$],
    [$g: vec(2, 5, 0) + s dot vec(0, 0.4, -1)$, #h(6pt)
      $h: vec(3, 9, 0) + t dot vec(0, -2, 5)$],
    [$g: vec(9, 5, 0) + s dot vec(2, 1, -2)$, #h(6pt)
      $h: vec(6, 3, 1) + t dot vec(1, 0, -3)$],
    [$g: vec(6, 1, 3) + s dot vec(4, 0, 5)$, #h(6pt)
      $h: vec(2, 1, 9) + t dot vec(2, 0, -3)$],
  )
][
  #auto-parts(
    1,
    [*Identical.* $vec(-6, 4.5, -9) = -1.5 dot vec(4, -3, 6)$, so the
      directions are parallel, and $(4, 6.5, 0)$ lies on $g$: from
      $x$, $14 - 6s = 4$ gives $s = 5 slash 3$, and then
      $y = -1 + 7.5 = 6.5$ ✓, $z = 15 - 15 = 0$ ✓.],
    [*Skew.* Not parallel. The $y$ equation $-6 + s = 9$ gives
      $s = 15$; the $x$ equation $3 - 90 = 6 - 3t$ gives $t = 31$.
      Third equation: $10 + 120 = 130$ against $4 + 124 = 128$. Fails.],
    [*Parallel.* $vec(0, -2, 5) = -5 dot vec(0, 0.4, -1)$, but every
      point of $g$ has $x = 2$ and every point of $h$ has $x = 3$.],
    [*Intersecting* at $(5, 3, 4)$. The $y$ equation $5 + s = 3$
      gives $s = -2$; the $x$ equation $9 - 4 = 6 + t$ gives $t = -1$;
      the $z$ equation: $0 + 4 = 4$ and $1 + 3 = 4$ ✓.],
    [*Intersecting* at $(6, 1, 3)$. The $y$ equation reads $1 = 1$ and
      tells you nothing, so use the other two:
      $6 + 4s = 2 + 2t$ and $3 + 5s = 9 - 3t$. The first gives
      $t = 2 + 2s$; substituting, $3 + 5s = 3 - 6s$, so $s = 0$ and
      $t = 2$. Both lines lie in the plane $y = 1$, and two
      non-parallel lines in a plane always meet.],
  )
]

#ex(difficulty: 3, time: "12 min", calculator: true, hints: (
  "In (a), the x equation of l1 is 2 - t = 0. Start there.",
  "In (b), the coefficients of a Cartesian equation are a normal vector. The angle between two lines equals the angle between their normals.",
))[
  #gate

  #auto-parts(
    1,
    [Find the intersection point and the angle between
      $
        g_1: arrow(r) = vec(2, -1, 1) + t dot vec(-1, 2, -1), quad
        g_2: arrow(r) = vec(0, 2, 3) + s dot vec(0, 1, -4).
      $],
    [Find the angle between the lines $2x - 3y - 3 = 0$ and
      $3x + 2y - 24 = 0$ in the plane.],
  )
][
  #auto-parts(
    1,
    [*Intersection.* The $x$ equation $2 - t = 0$ gives $t = 2$; the
      $y$ equation $-1 + 4 = 2 + s$ gives $s = 1$; the $z$ equation:
      $1 - 2 = -1$ and $3 - 4 = -1$ ✓. The point is
      $S = (0, 3, -1)$.

      *Angle.* $arrow(v)_1 dot arrow(v)_2 = 0 + 2 + 4 = 6$,
      $abs(arrow(v)_1) = sqrt(6)$, $abs(arrow(v)_2) = sqrt(17)$, so
      $cos(phi.alt) = 6 slash sqrt(102) approx 0.594$ and
      $phi.alt approx 53.6 degree$.],
    [The normals $vec(2, -3)$ and $vec(3, 2)$ have dot product
      $6 - 6 = 0$, so the lines are perpendicular: $90 degree$.],
  )
]

#print-hints()

// ════════════════════════════════════════════════════════════
== The Cross Product and Planes (90 min)

#definition(title: "Cross product — look up, but practise")[
  The #vocab("cross product", "Vektorprodukt") of two vectors in
  space is the vector
  $
    arrow(a) times arrow(b) = vec(
      a_y dot b_z - a_z dot b_y,
      a_z dot b_x - a_x dot b_z,
      a_x dot b_y - a_y dot b_x
    ).
  $
  It is perpendicular to both $arrow(a)$ and $arrow(b)$.
]

#keybox(title: "What it gives you")[
  - *A normal.* A vector perpendicular to two given vectors, in one
    line. *Always check* with two dot products — it takes ten seconds
    and catches nearly every slip.
  - *An area.* $abs(arrow(a) times arrow(b))
    = abs(arrow(a)) dot abs(arrow(b)) dot sin(phi.alt)$ is the area
    of the parallelogram spanned by $arrow(a)$ and $arrow(b)$. The
    triangle is *half* of it.
  - *A parallelism test.* Parallel vectors have
    $arrow(a) times arrow(b) = arrow(0)$.

  Order matters: $arrow(b) times arrow(a) = -(arrow(a) times arrow(b))$.
]

#example[
  $vec(2, -1, 3) times vec(-1, 0, 5)
  = vec(
    (-1) dot 5 - 3 dot 0, 3 dot (-1) - 2 dot 5,
    2 dot 0 - (-1) dot (-1)
  ) = vec(-5, -13, -1)$.

  Check: $vec(-5, -13, -1) dot vec(2, -1, 3) = -10 + 13 - 3 = 0$ ✓
  and $vec(-5, -13, -1) dot vec(-1, 0, 5) = 5 + 0 - 5 = 0$ ✓.
]

#warning[
  The middle component is where the formula goes wrong. In all three
  rows the subscripts cycle $x arrow.r y arrow.r z arrow.r x$; if your
  middle row reads $a_x dot b_z - a_z dot b_x$ you have the sign the
  wrong way round. The two-dot-product check will catch it.
]

#only-theory[
  A plane is fixed by a point and two directions in it — or, much
  more usefully, by a point and *one* direction perpendicular to it.
  The cross product turns the first description into the second.
]

#definition(title: "Three equations of a plane")[
  With $A$ a point of $E$, $arrow(u)$, $arrow(v)$ two non-parallel
  directions in $E$ and $arrow(n)$ a normal vector:

  / Parametric form: $E: arrow(r) = arrow(r)_A + t dot arrow(u)
    + s dot arrow(v)$
  / Normal form: $E: arrow(n) dot (arrow(r) - arrow(r)_A) = 0$
  / Cartesian form: $E: a x + b y + c z + d = 0$ with
    $arrow(n) = vec(a, b, c)$

  The normal form is the Cartesian form before multiplying out.
]

#keybox(title: "The Cartesian form does almost all the work — know by heart")[
  - *Normal:* the coefficients of $x$, $y$, $z$ *are* a normal
    vector. From $2x - 3y + 6z - 5 = 0$: $arrow(n) = vec(2, -3, 6)$.
  - *Point on the plane?* Substitute and see whether you get $0$.
  - *Parallel plane through $Q$:* keep $a$, $b$, $c$; find the new
    $d$ by substituting $Q$.
  - *Intercepts:* set two of the variables to $0$. A *missing*
    variable means the plane is parallel to that axis — it has no
    intercept there.
]

#keybox(title: "Recipe: the plane through three points")[
  + $arrow(n) = arrow(A B) times arrow(A C)$. Divide by a common
    factor if you like; any non-zero multiple is still a normal.
  + Substitute $A$ into $a x + b y + c z + d = 0$ to find $d$.
  + Check with $B$ and $C$.

  The same recipe converts a parametric form: $arrow(n) = arrow(u)
  times arrow(v)$, then substitute the anchor point.
]

#example[
  The plane through $A = (1, 1, 1)$, $B = (3, 1, 0)$ and
  $C = (5, 0, 0)$.

  $arrow(A B) = vec(2, 0, -1)$, $arrow(A C) = vec(4, -1, -1)$, and
  $arrow(A B) times arrow(A C) = vec(-1, -2, -2)$, which we tidy to
  $vec(1, 2, 2)$. Substituting $A$: $1 + 2 + 2 + d = 0$, so
  $d = -5$:
  $ E: x + 2y + 2z - 5 = 0. $
  Check: $B$ gives $3 + 0 + 2 - 5 = 0$ ✓, $C$ gives $5 - 5 = 0$ ✓.

  As a bonus, the area of triangle $A B C$ is
  $1/2 dot abs(vec(-1, -2, -2)) = 1/2 dot 3 = 3 slash 2$.
]

#ex(difficulty: 1, time: "12 min", calculator: false)[
  #auto-parts(
    1,
    [Calculate $vec(1, 2, 3) times vec(4, 5, 6)$ and
      $vec(4, 5, 6) times vec(1, 2, 3)$. Check one of them with two dot
      products.],
    [Find the exact area of the triangle with $A = (2, 1, 1)$,
      $B = (4, 2, -1)$ and $C = (1, 1, -2)$.],
  )
][
  #auto-parts(
    1,
    [$vec(-3, 6, -3)$ and $vec(3, -6, 3)$ — opposites, as the order
      rule says. Check: $vec(-3, 6, -3) dot vec(1, 2, 3)
      = -3 + 12 - 9 = 0$ ✓ and
      $vec(-3, 6, -3) dot vec(4, 5, 6) = -12 + 30 - 18 = 0$ ✓.],
    [$arrow(A B) = vec(2, 1, -2)$, $arrow(A C) = vec(-1, 0, -3)$,
      $arrow(A B) times arrow(A C) = vec(-3, 8, 1)$, so
      $"Area" = 1/2 dot sqrt(9 + 64 + 1) = sqrt(74) slash 2$.
      Forgetting the $1/2$ is the standard error.],
  )
]

#ex(difficulty: 2, time: "14 min", calculator: false)[
  Find the Cartesian equation of each plane.

  #auto-parts(
    1,
    [$E: arrow(r) = vec(2, 5, -3) + t dot vec(-1, 4, 0)
    + s dot vec(0, -2, 6)$],
    [The plane through $P = (4, 2, 1)$ containing the line
      $g: arrow(r) = vec(2, 1, 3) + t dot vec(1, -3, 1)$.],
  )
][
  #auto-parts(
    1,
    [$vec(-1, 4, 0) times vec(0, -2, 6) = vec(24, 6, 2)$, tidied to
      $vec(12, 3, 1)$. With $(2, 5, -3)$: $24 + 15 - 3 + d = 0$, so
      $d = -36$:
      $ E: 12x + 3y + z - 36 = 0. $
      Check: $vec(12, 3, 1) dot vec(-1, 4, 0) = 0$ ✓.],
    [The plane contains the anchor $A = (2, 1, 3)$ of $g$, the
      direction $vec(1, -3, 1)$, and $arrow(A P) = vec(2, 1, -2)$.
      $
        arrow(n) = vec(2, 1, -2) times vec(1, -3, 1)
        = vec(-5, -4, -7) arrow.r vec(5, 4, 7).
      $
      With $A$: $10 + 4 + 21 + d = 0$, so
      $E: 5x + 4y + 7z - 35 = 0$. Check $P$: $20 + 8 + 7 - 35 = 0$ ✓.],
  )
]

#ex(difficulty: 2, time: "10 min", calculator: false)[
  #auto-parts(
    1,
    [Which of $P = (1, 0, 2)$, $Q = (2, 1, 2)$ and $R = (-1, 3, 0)$ lie
      on $E: x + 2y + 2z - 5 = 0$?],
    [Find the axis intercepts of $2x + 5y - 4z - 20 = 0$ and of
      $5x - 6y + 30 = 0$.],
    [Find the plane through $Q = (2, 2, -2)$ parallel to
      $x - 2y - 3z = 0$.],
  )
][
  #auto-parts(
    1,
    [$P$: $1 + 0 + 4 - 5 = 0$, yes. $Q$: $2 + 2 + 4 - 5 = 3$, no.
      $R$: $-1 + 6 + 0 - 5 = 0$, yes.],
    [First plane: $x = 10$, $y = 4$, $z = -5$. Second plane: $x = -6$,
      $y = 5$, and *no* $z$#"‑"intercept — the $z$ term is missing, so
      the plane is parallel to the $z$#"‑"axis.],
    [Same normal, new $d$: $2 - 4 + 6 + d = 0$, so $d = -4$ and the
      plane is $x - 2y - 3z - 4 = 0$.],
  )
]

#ex(difficulty: 3, time: "15 min", calculator: false, hints: (
  "In (a), a plane passes through the origin exactly when its constant d is 0.",
  "In (b), the intercepts are 16, 9 and 144/c. The solid is a pyramid with a right triangle as base.",
))[
  #gate

  #auto-parts(
    1,
    [Does the origin lie on the plane through $A = (-2, 0, 1)$,
      $B = (4, 0, -2)$ and $C = (-1, -4, 3)$?],
    [The plane $9x + 16y + c dot z - 144 = 0$ meets the axes at $A$,
      $B$, $C$. Find $c$ so that the pyramid $O A B C$ has volume
      $384$.],
  )
][
  #auto-parts(
    1,
    [$arrow(A B) = vec(6, 0, -3)$, $arrow(A C) = vec(1, -4, 2)$,
      $arrow(n) = vec(-12, -15, -24) arrow.r vec(4, 5, 8)$. With $A$:
      $-8 + 0 + 8 + d = 0$, so $d = 0$ and the plane is
      $4x + 5y + 8z = 0$. A plane with $d = 0$ contains the origin:
      *yes*.],
    [Intercepts $A = (16, 0, 0)$, $B = (0, 9, 0)$,
      $C = (0, 0, 144 slash c)$. Base: the right triangle $O A B$ of
      area $1/2 dot 16 dot 9 = 72$; height $abs(144 slash c)$. So
      $
        V = 1/3 dot 72 dot abs(144/c) = #num(3456) / abs(c) = 384,
      $
      giving $abs(c) = 9$, so $c = 9$ or $c = -9$. Both are genuine:
      the two pyramids are mirror images in the $x y$#"‑"plane.],
  )
]

#print-hints()

// ════════════════════════════════════════════════════════════
== Intersections and Angles (75 min)

#keybox(title: "Line meets plane")[
  Substitute the line's three component equations into the plane's
  Cartesian equation. You get *one* equation in $t$:

  - one solution → the line pierces the plane; substitute $t$ back;
  - an identity such as $0 = 0$ → the line lies in the plane;
  - a contradiction such as $4 = 0$ → the line is parallel to it.

  Shortcut: if $arrow(n) dot arrow(v) = 0$ the line is parallel or
  contained, and one point test decides which.
]

#keybox(title: "Two planes meet in a line")[
  + *Direction:* $arrow(v) = arrow(n)_1 times arrow(n)_2$ (the line
    lies in both planes, so it is perpendicular to both normals).
  + *A point:* set one coordinate to $0$ — usually $x$ — and solve
    the remaining $2 times 2$ system. If that system is contradictory,
    the line never reaches $x = 0$; set $y = 0$ or $z = 0$ instead.

  If the normals are parallel, the planes are parallel or identical.
  Two planes *never* meet in a single point.
]

#example[
  *Line and plane.* $g: arrow(r) = vec(7, 6, 3) + t dot vec(2, -1, -2)$
  and $E: 2x - 2y - z + 17 = 0$:
  $
    2 dot (7 + 2t) - 2 dot (6 - t) - (3 - 2t) + 17
    = 16 + 8t = 0,
  $
  so $t = -2$ and $S = (3, 8, 7)$. Check: $6 - 16 - 7 + 17 = 0$ ✓.

  *Two planes.* $E_1: 2x - y + z - 1 = 0$ and $E_2: x + 2y - z = 0$.
  Direction $vec(2, -1, 1) times vec(1, 2, -1) = vec(-1, 3, 5)$. With
  $x = 0$: $-y + z = 1$ and $2y - z = 0$ give $y = 1$, $z = 2$. So
  $ g: arrow(r) = vec(0, 1, 2) + t dot vec(-1, 3, 5). $
]

#keybox(title: "Angles with planes — look up")[
  Two planes: the angle between their normals,
  $
    cos(phi.alt) = abs(arrow(n)_1 dot arrow(n)_2) /
    (abs(arrow(n)_1) dot abs(arrow(n)_2)).
  $
  A line and a plane: the *same expression*, but with the *sine*,
  $
    sin(phi.alt) = abs(arrow(n) dot arrow(v)) /
    (abs(arrow(n)) dot abs(arrow(v))).
  $
  Both angles lie between $0 degree$ and $90 degree$. Quick tests:
  $E_1 perp E_2 arrow.l.r.double arrow(n)_1 dot arrow(n)_2 = 0$;
  $g perp E arrow.l.r.double arrow(v) = k dot arrow(n)$.
]

#only-theory[
  #fig(
    space3d(
      ..plane-patch((2, 2.5, 1), (2, 0, 0), (0, 2, 0), lo: -1, hi: 1),
      s-seg(
        from: (0.5, 1, -1),
        to: (3.5, 4, 3),
        color: def-col,
        width: 1.2pt,
      ),
      s-seg(from: (3.5, 4, 3), to: (3.5, 4, 1), color: luma(150), dashed: true),
      s-seg(from: (2, 2.5, 1), to: (3.5, 4, 1), color: luma(150), dashed: true),
      s-vec(
        from: (2, 2.5, 1),
        to: (2, 2.5, 3.5),
        color: warn-col,
        label: $arrow(n)$,
      ),
      s-arc(
        vertex: (2, 2.5, 1),
        from: (2, 2.5, 3.5),
        to: (3.5, 4, 3),
        r: 20pt,
        label: $beta$,
        color: warn-col,
      ),
      s-arc(
        vertex: (2, 2.5, 1),
        from: (3.5, 4, 3),
        to: (3.5, 4, 1),
        r: 32pt,
        label: $phi.alt$,
        color: def-col,
      ),
      s-pt((2, 2.5, 1), r: 2pt),
      axis-len: (4.5, 5.5, 4.5),
      unit: 0.62cm,
    ),
    caption: [The dot product gives $beta$, the angle with the normal.
      The question asks for $phi.alt = 90 degree - beta$, the angle
      with the plane — hence the sine.],
  )
]

#warning[
  Using $arccos$ instead of $arcsin$ for a line and a plane gives
  $90 degree - phi.alt$: a perfectly plausible number with no
  arithmetic error anywhere. Sanity check: a line lying *in* a plane
  must give $0 degree$.

  The formula booklet calls the line–plane angle $alpha$; these notes
  keep $phi.alt$ for every angle.
]

#example[
  *Two planes.* $x - y + 3z - 1 = 0$ and $-3x - 4y + 6z + 4 = 0$:
  $cos(phi.alt) = abs(-3 + 4 + 18) slash (sqrt(11) dot sqrt(61))
  = 19 slash sqrt(671)$, so $phi.alt approx 42.8 degree$.

  *Line and plane.* $arrow(v) = vec(-2, -1, 1)$ and
  $E: 2x - y + z - 5 = 0$:
  $sin(phi.alt) = abs(-4 + 1 + 1) slash (sqrt(6) dot sqrt(6))
  = 1 slash 3$, so $phi.alt approx 19.5 degree$.
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  Find the intersection point of $g$ and $E$, or explain why there is
  none.

  #auto-parts(
    1,
    [$E: 2x - y + 3z + 1 = 0$, #h(4pt)
      $g: arrow(r) = vec(3, -4, -1) + t dot vec(2, -1, 1)$],
    [$E: x + 2y - 5z + 9 = 0$, #h(4pt)
      $g: arrow(r) = vec(-2, -1, 4) + t dot vec(3, 1, -2)$],
    [$E: 2x - y + 3z + 5 = 0$, #h(4pt)
      $g: arrow(r) = vec(3, 5, 0) + t dot vec(2, 1, -1)$],
  )
][
  #auto-parts(
    1,
    [$2 dot (3 + 2t) - (-4 - t) + 3 dot (-1 + t) + 1 = 8 + 8t = 0$,
      so $t = -1$ and the point is $(1, -3, -2)$.],
    [$(-2 + 3t) + 2 dot (-1 + t) - 5 dot (4 - 2t) + 9 = -15 + 15t = 0$,
      so $t = 1$ and the point is $(1, 0, 2)$.],
    [$arrow(n) dot arrow(v) = 4 - 1 - 3 = 0$: no piercing point. The
      anchor gives $6 - 5 + 0 + 5 = 6 eq.not 0$, so the line is
      *parallel* to the plane, not lying in it.],
  )
]

#ex(difficulty: 2, time: "12 min", calculator: false, hints: (
  "Both directions of F have first component 0. What does that tell you about x on F?",
))[
  Find the line of intersection of
  $
    E: arrow(r) = vec(3, 1, 2) + t dot vec(1, 0, 0)
    + s dot vec(0, 1, 1)
    quad "and" quad
    F: arrow(r) = vec(4, 2, 0) + u dot vec(0, 2, -1)
    + v dot vec(0, 0, -1).
  $
][
  *Convert to Cartesian form first.* For $E$:
  $vec(1, 0, 0) times vec(0, 1, 1) = vec(0, -1, 1)$, and the anchor
  gives $-1 + 2 + d = 0$, so $E: -y + z - 1 = 0$.

  For $F$: both directions have first component $0$ and the anchor has
  $x = 4$, so every point of $F$ has $x = 4$. (The cross product
  confirms it: $vec(-2, 0, 0)$, giving $-2x + 8 = 0$.)

  *Intersect.* $x = 4$ and $z = y + 1$ with $y$ free. Taking
  $y = -1$ gives the point $(4, -1, 0)$; the direction is
  $vec(0, -1, 1) times vec(1, 0, 0) = vec(0, 1, 1)$:
  $ g: arrow(r) = vec(4, -1, 0) + t dot vec(0, 1, 1). $
]

#ex(difficulty: 2, time: "12 min", calculator: true)[
  Find the angles.

  #auto-parts(
    1,
    [Between the planes $2x + y - 2z = 0$ and $x - 2y + 5 = 0$.],
    [Between the planes $x + y + z = 3$ and $z = 0$.],
    [Between the line $arrow(r) = t dot vec(1, 1, 1)$ and the plane
      $z = 0$.],
    [Between the line $arrow(r) = vec(3, 1, 0) + t dot vec(1, 2, -1)$
      and the plane $2x + 4y - 2z + 7 = 0$.],
  )
][
  #auto-parts(
    1,
    [$vec(2, 1, -2) dot vec(1, -2, 0) = 0$: perpendicular, $90 degree$.
      No calculator needed — test for $0$ first.],
    [$cos(phi.alt) = 1 slash sqrt(3)$, so $phi.alt approx 54.7 degree$.],
    [Line and plane, so sine: $sin(phi.alt) = 1 slash sqrt(3)$, so
      $phi.alt approx 35.3 degree$. Compare with (b): same number,
      different inverse function.],
    [$arrow(n) = vec(2, 4, -2) = 2 dot arrow(v)$: the line is
      *perpendicular* to the plane, $90 degree$. The formula agrees:
      $sin(phi.alt) = 12 slash (sqrt(24) dot sqrt(6)) = 1$.],
  )
]

#ex(difficulty: 3, time: "16 min", calculator: false, hints: (
  "Perpendicular to a plane means the line's direction is a multiple of the normal: (k - 2, 1, k) = m · (3, -1, 1).",
  "The second component gives m at once.",
))[
  #gate

  The plane $E: 3x - y + z - 3 = 0$ and the line
  $ g: arrow(r) = vec(3, 2k - 1, -1) + t dot vec(k - 2, 1, k) $
  are given.

  #auto-parts(
    1,
    [Find $k$ so that $g$ is perpendicular to $E$.],
    [For that $k$, find the point where $g$ meets $E$.],
  )
][
  #auto-parts(
    1,
    [$vec(k - 2, 1, k) = m dot vec(3, -1, 1)$. The second row gives
      $m = -1$, the third $k = -1$, and the first checks:
      $k - 2 = -3 = 3m$ ✓. So $k = -1$ and
      $g: arrow(r) = vec(3, -3, -1) + t dot vec(-3, 1, -1)$.],
    [$3 dot (3 - 3t) - (-3 + t) + (-1 - t) - 3 = 8 - 11t = 0$, so
      $t = 8 slash 11$ and
      $ S = (9 slash 11, -25 slash 11, -19 slash 11). $
      *Check:* $(27 + 25 - 19 - 33) slash 11 = 0$ ✓. Fractions are
      normal here; keep them exact.],
  )
]

#print-hints()

// ════════════════════════════════════════════════════════════
== Distances (90 min)

#only-theory[
  Dividing the left-hand side of a plane's equation by the length of
  its normal turns the equation into a ruler: evaluated at any point,
  it gives that point's distance from the plane.

  #fig(
    vplane(
      s-seg(
        from: (-1, 0),
        to: (8, 0),
        color: def-col,
        width: 1.2pt,
        label: [$E$],
        anchor: 0.04,
      ),
      s-vec(
        from: (1.5, 0),
        to: (1.5, 2.2),
        color: warn-col,
        label: $arrow(e)_n$,
      ),
      s-vec(from: (1.5, 0), to: (6, 3), label: $arrow(A P)$, color: accent),
      s-seg(from: (6, 3), to: (6, 0), color: luma(150), dashed: true),
      s-seg(from: (1.5, 0), to: (1.5, 3), color: luma(210)),
      s-seg(from: (1.5, 3), to: (6, 3), color: luma(150), dashed: true),
      s-txt((1.5, 1.6), text(size: 9pt)[$d$], off: (-11pt, 0pt)),
      s-arc(
        vertex: (1.5, 0),
        from: (1.5, 2.2),
        to: (8, 0),
        r: 12pt,
        right: true,
        color: luma(130),
      ),
      s-pt((1.5, 0), label: $A$),
      s-pt((6, 3), label: $P$),
      xmin: -1.5,
      xmax: 9.5,
      ymin: -0.5,
      ymax: 3.5,
      unit: 0.55cm,
      grid: false,
      axes: false,
    ),
    caption: [Seen edge-on. The distance is the component of
      $arrow(A P)$ along the unit normal.],
  )
]

#keybox(title: "Hesse normal form and point–plane distance — look up")[
  For $E: a x + b y + c z + d = 0$, the
  #vocab("Hesse normal form", "Hessesche Normalform") is
  $ (a x + b y + c z + d) / sqrt(a^2 + b^2 + c^2) = 0, $
  and the distance of $P = (x_P, y_P, z_P)$ from $E$ is
  $
    d(P, E) = (a dot x_P + b dot y_P + c dot z_P + d) /
    sqrt(a^2 + b^2 + c^2).
  $
  The booklet puts absolute value bars around the numerator. Without
  them the result is *signed*: two points with the same sign lie on
  the same side of $E$. Report a distance as a positive number.
]

#example[
  $E: x + 2y + 2z - 5 = 0$, with $abs(arrow(n)) = 3$.
  For $P = (1, 3, 2)$: $(1 + 6 + 4 - 5) slash 3 = 2$. For the origin:
  $(0 - 5) slash 3 = -5 slash 3$. So $P$ is at distance $2$, the origin
  at distance $5 slash 3$, on opposite sides.
]

#keybox(title: "Parallel planes")[
  - *Distance between them:* take any point on one and use the Hesse
    form of the other. But first make the normals *identical*, not
    just parallel: $6x + 8y - 29 = 0$ must become
    $3x + 4y - 14.5 = 0$ before comparing with $3x + 4y - 12 = 0$.
  - *Plane at distance $L$ from $E$:* keep $a$, $b$, $c$, write the
    new constant as $D$, and require the Hesse distance of a point of
    $E$ to be $plus.minus L$. There are always *two* answers, one on
    each side, unless the question names a side.
]

#keybox(title: "Foot of the perpendicular and reflection")[
  + Perpendicular line from $P$:
    $s: arrow(r) = arrow(r)_P + t dot arrow(n)$.
  + Substitute into $E$, solve: $t = t_0$.
  + #vocab("Foot of the perpendicular", "Lotfusspunkt"):
    $B = P + t_0 dot arrow(n)$, the point of $E$ nearest $P$.
  + Distance: $abs(t_0) dot abs(arrow(n))$.
  + Mirror image: $P' = P + 2 t_0 dot arrow(n)$.
]

#example[
  $E: 4x - 3y + 2z - 12 = 0$ and $P = (15, -11, 3)$. Substituting
  $(15 + 4t, -11 - 3t, 3 + 2t)$:
  $ 4 dot (15 + 4t) - 3 dot (-11 - 3t) + 2 dot (3 + 2t) - 12 = 87 + 29t = 0, $
  so $t_0 = -3$. Then $B = (3, -2, -3)$, the distance is
  $3 sqrt(29)$, and $P' = (15 - 24, -11 + 18, 3 - 12) = (-9, 7, -9)$.
  Hesse check: $87 slash sqrt(29) = 3 sqrt(29)$ ✓.
]

#keybox(title: "Point–line distance and reflected rays — look up")[
  The distance from $P$ to the line $g: arrow(r) = arrow(r)_A
  + t dot arrow(v)$ is
  $ d(P, g) = abs(arrow(v) times arrow(A P)) / abs(arrow(v)). $
  (Parallelogram area divided by its base gives its height.)

  A ray with direction $arrow(v)$ hitting a mirror with normal
  $arrow(n)$ leaves with direction
  $
    arrow(v)' = arrow(v) - 2 dot (arrow(v) dot arrow(n)) /
    abs(arrow(n))^2 dot arrow(n).
  $
  This one is not in the booklet as it stands, but it is
  $arrow(v) - 2 arrow(v)_(∥)$: reverse the part of $arrow(v)$ along
  the normal, using the booklet's projection formula.
  Volume of a pyramid: $V = 1/3 dot "base" dot "height"$, where the
  height is usually a Hesse distance.
]

#example[
  $P = (5, 8, 4)$ and $g$ through $A = (2, 3, 0)$ with
  $arrow(v) = vec(-1, -6, -2)$. With $arrow(A P) = vec(3, 5, 4)$,
  $arrow(v) times arrow(A P) = vec(-14, -2, 13)$, so
  $
    d = sqrt(196 + 4 + 169) / sqrt(1 + 36 + 4)
    = sqrt(369 / 41) = sqrt(9) = 3.
  $
  Combine the roots before evaluating, and the answer is exact.
]

#remark[
  Everything here works in the plane too, with one coordinate fewer:
  the distance from $P$ to the line $a x + b y + c = 0$ is
  $abs(a dot x_P + b dot y_P + c) slash sqrt(a^2 + b^2)$.
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  For $E: x - 2y - 2z + 4 = 0$:

  #auto-parts(
    1,
    [find the signed distances of $P = (1, 3, 2)$ and
      $Q = (2, -1, -2)$,],
    [decide whether $P$ and $Q$ lie on the same side of $E$.],
  )
][
  #auto-parts(
    1,
    [$abs(arrow(n)) = 3$. $d(P, E) = (1 - 6 - 4 + 4) slash 3
      = -5 slash 3$ and $d(Q, E) = (2 + 2 + 4 + 4) slash 3 = 4$.],
    [Opposite signs, so opposite sides: $P$ at distance $5 slash 3$,
      $Q$ at distance $4$.],
  )
]

#ex(difficulty: 2, time: "14 min", calculator: false)[
  #auto-parts(
    1,
    [Find both planes parallel to $E: 2x + 2y + z - 1 = 0$ at distance
      $3$ from it.],
    [Find the plane parallel to $E: 2x + 2y + z - 8 = 0$ at distance
      $4$, on the same side of $E$ as $A = (-2, 3, 1)$.],
    [How far apart are $2x - y + 2z = 4$ and $4x - 2y + 4z = 30$?],
  )
][
  #auto-parts(
    1,
    [$(0, 0, 1)$ lies on $E$ and $abs(arrow(n)) = 3$. For
      $2x + 2y + z + D = 0$: $(1 + D) slash 3 = plus.minus 3$, so
      $D = 8$ or $D = -10$:
      $2x + 2y + z + 8 = 0$ and $2x + 2y + z - 10 = 0$.],
    [$d(A, E) = (-4 + 6 + 1 - 8) slash 3 = -5 slash 3$: $A$ is on the
      negative side. With $(0, 0, 8)$ on $E$:
      $(8 + D) slash 3 = plus.minus 4$, so $D = 4$ or $D = -20$.
      Test $A$ in each: $+7 slash 3$ and $-17 slash 3$. Only the
      second has the same sign, so the answer is
      $2x + 2y + z - 20 = 0$.],
    [Rescale the second first: $2x - y + 2z - 15 = 0$. The point
      $(2, 0, 0)$ lies on the first plane, and
      $(4 - 0 + 0 - 15) slash 3 = -11 slash 3$. The planes are
      $11 slash 3$ apart.],
  )
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  #auto-parts(
    1,
    [Reflect $P = (0, -5, 5)$ in $E: x + 4y - 3z + 9 = 0$, and check
      that the midpoint of $P$ and its image lies on $E$.],
    [Find the distance from $P = (3, 1, 5)$ to the line
      $g: arrow(r) = vec(1, 1, 1) + t dot vec(2, -1, 2)$.],
  )
][
  #auto-parts(
    1,
    [$abs(arrow(n))^2 = 26$. Substituting
      $(t, -5 + 4t, 5 - 3t)$: $t - 20 + 16t - 15 + 9t + 9
      = -26 + 26t = 0$, so $t_0 = 1$ and
      $P' = (0, -5, 5) + 2 dot vec(1, 4, -3) = (2, 3, -1)$.
      Midpoint $(1, -1, 2)$: $1 - 4 - 6 + 9 = 0$ ✓.],
    [$arrow(A P) = vec(2, 0, 4)$ and
      $arrow(v) times arrow(A P) = vec(-4, -4, 2)$, of length $6$.
      With $abs(arrow(v)) = 3$: $d = 6 slash 3 = 2$.],
  )
]

#ex(difficulty: 3, time: "20 min", calculator: false, keep-together: false)[
  $E: x + 2y + 2z - 6 = 0$ is given.

  #auto-parts(
    1,
    [Find the distance from $D = (1, 1, 1)$ to $E$.],
    [A light ray starts at $P = (7, 2, 2)$ and reflects at
      $S = (2, 1, 1)$ on $E$. Check that $S$ is on $E$, then find a
      parametric equation of the reflected ray.],
    [$E$ and the three coordinate planes bound a pyramid. Find its
      volume.],
  )
][
  #auto-parts(
    1,
    [$d = (1 + 2 + 2 - 6) slash 3 = -1 slash 3$: distance
      $1 slash 3$.],
    [$2 + 2 + 2 - 6 = 0$ ✓. Incoming direction
      $arrow(P S) = vec(-5, -1, -1)$, with
      $arrow(P S) dot arrow(n) = -9$ and $abs(arrow(n))^2 = 9$:
      $
        arrow(v)' = vec(-5, -1, -1) + 2 dot vec(1, 2, 2)
        = vec(-3, 3, 3) arrow.r vec(-1, 1, 1),
      $
      so the reflected ray is
      $arrow(r) = vec(2, 1, 1) + t dot vec(-1, 1, 1)$, $t >= 0$.],
    [Intercepts $6$, $3$, $3$. Base: the right triangle in the
      $x y$#"‑"plane with legs $6$ and $3$, area $9$; height $3$.
      $V = 1/3 dot 9 dot 3 = 9$.],
  )
]

#ex(
  difficulty: 3,
  time: "20 min",
  calculator: true,
  keep-together: false,
  hints: (
    "For (a), write S = (-2 + 3t, -13 + 6t, 23 - 9t) and set |SA|² = |SB|². The squares of t cancel.",
    "For (b), the height is the distance from S to the plane through A, B and C.",
  ),
)[
  #gate

  $A = (6, 2, 2)$, $B = (2, -4, -2)$ and $C = (8, 0, -6)$ form the base
  of a pyramid. Its apex $S$ is equidistant from $A$ and $B$ and lies
  on the line through $P = (-2, -13, 23)$ and $Q = (1, -7, 14)$.

  #auto-parts(
    1,
    [Find $S$.],
    [Find the height of the pyramid.],
    [Find the angle $beta = angle A B C$.],
    [Find the volume of the pyramid.],
  )
][
  #auto-parts(
    1,
    [$arrow(P Q) = vec(3, 6, -9)$, so
      $S = (-2 + 3t, -13 + 6t, 23 - 9t)$. Expanding
      $abs(arrow(S A))^2 = abs(arrow(S B))^2$, the $t^2$ terms cancel
      and what remains is $8 - 24t = 0$, so $t = 1 slash 3$ and
      $ S = (-1, -11, 20). $
      *Check:* $abs(arrow(S A))^2 = 49 + 169 + 324 = 542$ and
      $abs(arrow(S B))^2 = 9 + 49 + 484 = 542$ ✓.],
    [$arrow(A B) times arrow(A C) = vec(40, -40, 20)
      arrow.r vec(2, -2, 1)$, length $3$; with $A$ the base plane is
      $2x - 2y + z - 10 = 0$. Then
      $h = (-2 + 22 + 20 - 10) slash 3 = 10$.],
    [$arrow(B A) = vec(4, 6, 4)$, $arrow(B C) = vec(6, 4, -4)$, both of
      length $sqrt(68)$, dot product $24 + 24 - 16 = 32$:
      $cos(beta) = 32 slash 68 = 8 slash 17$, so
      $beta approx 61.9 degree$.],
    [Base area $1/2 dot abs(vec(40, -40, 20)) = 1/2 dot 60 = 30$, so
      $V = 1/3 dot 30 dot 10 = 100$.],
  )
]

#print-hints()

// ════════════════════════════════════════════════════════════
== Skew Lines, Volumes, Circles and Spheres (90 min)

#keybox(title: "Distance between skew lines — look up")[
  For $g_1$ through $A$ with direction $arrow(v)_1$ and $g_2$ through
  $B$ with direction $arrow(v)_2$:
  $
    d(g_1, g_2) = abs((arrow(v)_1 times arrow(v)_2) dot arrow(A B)) /
    abs(arrow(v)_1 times arrow(v)_2).
  $
  A result of $0$ means the lines intersect. For parallel lines the
  formula fails (the cross product is $arrow(0)$): use the point–line
  distance instead.
]

#keybox(title: "Scalar triple product — look up")[
  $V = abs((arrow(a) times arrow(b)) dot arrow(c))$ is the volume of
  the #vocab("parallelepiped", "Spat") spanned by the three vectors.
  The tetrahedron on the same three edges has one sixth of it.

  Four points $A$, $B$, $C$, $D$ lie in one plane exactly when
  $(arrow(A B) times arrow(A C)) dot arrow(A D) = 0$.
]

#example[
  $g_1: arrow(r) = vec(2, -1, 1) + t dot vec(-1, 2, -1)$ and
  $g_2: arrow(r) = vec(0, 2, 3) + s dot vec(0, 1, 1)$:
  $arrow(v)_1 times arrow(v)_2 = vec(3, 1, -1)$ and
  $arrow(A B) = vec(-2, 3, 2)$, so
  $ d = abs(-6 + 3 - 2) / sqrt(11) = 5 / sqrt(11) approx 1.51. $
]

#definition(title: "Circle and sphere")[
  The circle with centre $M = (u, v)$ and radius $r$, and the sphere
  with centre $M = (u, v, w)$ and radius $R$:
  $
    (x - u)^2 + (y - v)^2 = r^2, quad
    (x - u)^2 + (y - v)^2 + (z - w)^2 = R^2.
  $
  Multiplied out, a sphere looks like
  $x^2 + y^2 + z^2 + D x + E y + F z + G = 0$; *complete the square*
  in each variable to recover $M$ and $R$.
]

#example[
  $x^2 + y^2 + z^2 - 4x + 6y - 2z - 11 = 0$:
  $
    (x - 2)^2 + (y + 3)^2 + (z - 1)^2 = 11 + 4 + 9 + 1 = 25,
  $
  so $M = (2, -3, 1)$ and $R = 5$. Watch the signs: the coordinate
  $-3$ appears as $+3$ in the bracket.
]

#warning[
  After completing the square, only a *positive* right-hand side gives
  a circle or sphere. Zero gives a single point; a negative number
  gives no points at all.
]

#keybox(title: "Spheres meeting points, lines and planes")[
  - *Point:* compare $abs(arrow(M P))^2$ with $R^2$ — smaller is
    inside, equal is on, larger is outside.
  - *Line:* substitute the component equations into the sphere's
    equation. A quadratic in $t$: two solutions (the line cuts it),
    one (the line is a #vocab("tangent", "Tangente")), none (it
    misses).
  - *Plane:* compare $d = d(M, E)$ with $R$. If $d < R$, the plane cuts
    a circle with radius $r = sqrt(R^2 - d^2)$, whose centre is the
    foot of the perpendicular from $M$. If $d = R$ the plane is a
    #vocab("tangent plane", "Tangentialebene").
  - *Tangent at a point $T$ on it:* the tangent plane (or, for a
    circle, the tangent line) is the one through $T$ with normal
    $arrow(M T)$.
]

#only-theory[
  #fig(
    vplane(
      s-seg(
        from: (-1, 1.4),
        to: (9, 1.4),
        color: def-col,
        width: 1.2pt,
        label: [$E$],
        anchor: 0.05,
      ),
      s-seg(
        from: (4, 4),
        to: (4, 1.4),
        color: warn-col,
        width: 1.1pt,
        dashed: true,
      ),
      s-seg(from: (4, 4), to: (6.6, 1.4), color: accent, width: 1.1pt),
      s-seg(from: (4, 1.4), to: (6.6, 1.4), color: luma(120), width: 1.1pt),
      s-arc(
        vertex: (4, 1.4),
        from: (4, 4),
        to: (6.6, 1.4),
        r: 12pt,
        right: true,
        color: luma(130),
      ),
      s-txt((4, 2.7), text(size: 9pt)[$d$], off: (-10pt, 0pt)),
      s-txt((5.3, 2.7), text(size: 9pt)[$R$], off: (8pt, -2pt)),
      s-txt((5.3, 1.4), text(size: 9pt)[$r$], off: (0pt, 11pt)),
      s-pt((4, 4), label: $M$),
      xmin: -1.5,
      xmax: 10.5,
      ymin: 0.5,
      ymax: 4.5,
      unit: 0.55cm,
      grid: false,
      axes: false,
    ),
    caption: [A plane cutting a sphere, seen edge-on: $R$, $d$ and the
      cut circle's radius $r$ form a right triangle.],
  )
]

#example[
  *Tangent to a circle.* $(x - 3)^2 + (y + 2)^2 = 25$ at
  $T = (6, 2)$. Check: $9 + 16 = 25$ ✓. The normal is
  $arrow(M T) = vec(3, 4)$, so the tangent is
  $3 dot (x - 6) + 4 dot (y - 2) = 0$, that is $3x + 4y - 26 = 0$.
]

#ex(difficulty: 2, time: "14 min", calculator: false)[
  #auto-parts(
    1,
    [Apply the skew-line distance formula to
      $g_1: arrow(r) = vec(2, -1, 1) + t dot vec(-1, 2, -1)$ and
      $g_2: arrow(r) = vec(0, 2, 3) + s dot vec(0, 1, -4)$, and
      interpret your answer.],
    [Do $A = (2, 1, 0)$, $B = (0, 4, -3)$, $C = (-1, 0, 5)$ and
      $D = (3, 5, 2)$ lie in one plane? Find the volume of the
      tetrahedron $A B C D$.],
  )
][
  #auto-parts(
    1,
    [$arrow(v)_1 times arrow(v)_2 = vec(-7, -4, -1)$ and
      $arrow(A B) = vec(-2, 3, 2)$, so the numerator is
      $abs(14 - 12 - 2) = 0$ and $d = 0$. The lines *intersect* — it
      is the pair from the gate exercise on lines. The formula doubles as an
      intersection test.],
    [$arrow(A B) = vec(-2, 3, -3)$, $arrow(A C) = vec(-3, -1, 5)$,
      $arrow(A D) = vec(1, 4, 2)$.
      $arrow(A B) times arrow(A C) = vec(12, 19, 11)$, and dotting with
      $arrow(A D)$: $12 + 76 + 22 = 110 eq.not 0$. Not coplanar. The
      tetrahedron has volume $110 slash 6 = 55 slash 3$.],
  )
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  Find the centre and radius, or explain why there is no circle or
  sphere.

  #auto-parts(
    1,
    [$x^2 + y^2 + 8x - 10y + 5 = 0$],
    [$x^2 + y^2 + z^2 + 12x - 6z + 9 = 0$],
    [$x^2 + y^2 + 6x - 8y + 25 = 0$],
  )
][
  #auto-parts(
    1,
    [$(x + 4)^2 + (y - 5)^2 = -5 + 16 + 25 = 36$: $M = (-4, 5)$,
      $r = 6$.],
    [$(x + 6)^2 + y^2 + (z - 3)^2 = -9 + 36 + 9 = 36$:
      $M = (-6, 0, 3)$, $R = 6$. No $y$ term just means the centre has
      $y = 0$.],
    [$(x + 3)^2 + (y - 4)^2 = -25 + 9 + 16 = 0$. *Not a circle*: the
      only solution is the single point $(-3, 4)$.],
  )
]

#ex(difficulty: 3, time: "16 min", calculator: false, keep-together: false)[
  The plane $E: x + 2y + 2z + 4 = 0$ is tested against three spheres,
  all with centre $M = (1, 1, 1)$.

  #auto-parts(
    1,
    [Find the distance from $M$ to $E$.],
    [For $R = 5$: show that $E$ cuts the sphere, and find the centre
      and radius of the circle of intersection.],
    [For $R = 3$: show that $E$ is a tangent plane and find the point
      of contact.],
    [For $R = 2$: what happens?],
  )
][
  #auto-parts(
    1,
    [$d = (1 + 2 + 2 + 4) slash 3 = 3$.],
    [$3 < 5$, so $E$ cuts. The centre is the foot of the perpendicular:
      $(1 + t, 1 + 2t, 1 + 2t)$ in $E$ gives $9 + 9t = 0$, $t = -1$,
      so the centre is $(0, -1, -1)$. Radius
      $sqrt(25 - 9) = 4$.],
    [$d = 3 = R$: tangent. The point of contact is the same foot,
      $(0, -1, -1)$. Check with the tangent-plane rule:
      $arrow(M T) = vec(-1, -2, -2)$ is indeed a multiple of the normal
      of $E$.],
    [$3 > 2$: the plane misses the sphere.],
  )
]

#ex(
  difficulty: 3,
  time: "16 min",
  calculator: false,
  keep-together: false,
  hints: (
    "Write the line as (9 + 5t, 5 + 2t, 16 + 5t) and substitute into the sphere. Divide the quadratic by 54.",
    "For (b), the normal of the tangent plane at T is the vector from M to T.",
  ),
)[
  #gate

  The sphere $s: (x - 2)^2 + (y + 5)^2 + z^2 = 81$ and the points
  $A = (9, 5, 16)$ and $B = (14, 7, 21)$ are given.

  #auto-parts(
    1,
    [Find the points where the line $A B$ meets $s$.],
    [Find the tangent plane to $s$ at the intersection point with the
      larger $z$#"‑"coordinate.],
  )
][
  #auto-parts(
    1,
    [Direction $arrow(A B) = vec(5, 2, 5)$, so the line is
      $(9 + 5t, 5 + 2t, 16 + 5t)$. Substituting:
      $
        (7 + 5t)^2 + (10 + 2t)^2 + (16 + 5t)^2 = 81
        quad arrow.r.double quad 54t^2 + 270t + 324 = 0,
      $
      that is $t^2 + 5t + 6 = 0$, so $t = -2$ or $t = -3$. The points
      are $(-1, 1, 6)$ and $(-6, -1, 1)$.],
    [$T = (-1, 1, 6)$ and $arrow(M T) = vec(-3, 6, 6)$, tidied to
      $vec(-1, 2, 2)$:
      $
        -(x + 1) + 2 dot (y - 1) + 2 dot (z - 6) = 0
        quad arrow.r.double quad x - 2y - 2z + 15 = 0.
      $
      Check: $-1 - 2 - 12 + 15 = 0$ ✓.],
  )
]

#print-hints()

// ════════════════════════════════════════════════════════════
== Exam Simulation (75–110 min)

#only-theory[
  Three questions of examination length and difficulty. Work them under
  real conditions:

  - *no calculator* — every answer comes out exactly;
  - *formula booklet allowed*;
  - *35 minutes each*, and stop when the time is up;
  - *show your working* — a clear argument with a slip earns more than
    a bare correct number.

  Later parts lean on earlier ones. If a part defeats you, say what you
  would have done with its answer and carry on: that is how exams are
  marked. Mark your work against the solutions booklet afterwards, and
  for every lost mark name the module it belongs to. That list is your
  revision plan.
]

#ex(difficulty: 3, time: "35 min", calculator: false, keep-together: false)[
  *Exam question 1.* The points $A = (6, 0, 0)$, $B = (0, 6, 0)$ and
  $C = (0, 0, 12)$ lie in a plane $E$; $O$ is the origin.

  #auto-parts(
    1,
    [Find the Cartesian equation of $E$.],
    [Show that $P = (2, 2, 4)$ lies on $E$, and find the distance from
      $Q = (4, 5, 3)$ to $E$.],
    [Find the foot $F$ of the perpendicular from $Q$ to $E$, and the
      mirror image $Q'$ of $Q$ in $E$.],
    [Find the exact cosine of the angle between $E$ and the
      $x y$#"‑"plane.],
    [Find the volume of the pyramid $O A B C$.],
    [Find the plane $G$ through $Q$ parallel to $E$, state the distance
      between $E$ and $G$, and comment on your answer.],
  )
][
  #auto-parts(
    1,
    [$arrow(A B) = vec(-6, 6, 0)$, $arrow(A C) = vec(-6, 0, 12)$,
      $arrow(A B) times arrow(A C) = vec(72, 72, 36) arrow.r
      vec(2, 2, 1)$. With $A$: $12 + d = 0$, so
      $E: 2x + 2y + z - 12 = 0$. Check $B$ and $C$: $12 - 12 = 0$ ✓.],
    [$P$: $4 + 4 + 4 - 12 = 0$ ✓. With $abs(arrow(n)) = 3$:
      $d(Q, E) = (8 + 10 + 3 - 12) slash 3 = 3$.],
    [$(4 + 2t, 5 + 2t, 3 + t)$ in $E$: $9 + 9t = 0$, $t_0 = -1$.
      $F = (2, 3, 2)$ (check: $4 + 6 + 2 - 12 = 0$ ✓) and
      $Q' = (4, 5, 3) - 2 dot (2, 2, 1) = (0, 1, 1)$.
      Check: $d(Q', E) = -3$, same distance, other side ✓.],
    [Normals $vec(2, 2, 1)$ and $vec(0, 0, 1)$:
      $cos(phi.alt) = 1 slash (3 dot 1) = 1 slash 3$.],
    [Base: the right triangle $O A B$, area $18$; height $12$.
      $V = 1/3 dot 18 dot 12 = 72$.],
    [$G: 2x + 2y + z + D = 0$ with $8 + 10 + 3 + D = 0$, so
      $G: 2x + 2y + z - 21 = 0$. With $A$:
      $(12 - 21) slash 3 = -3$, so the planes are $3$ apart. Of course:
      $Q$ lies on $G$ and is $3$ from $E$ — part (f) is part (b) again.],
  )
]

#ex(difficulty: 3, time: "35 min", calculator: false, keep-together: false)[
  *Exam question 2.* Two lines are given:
  $
    g: arrow(r) = vec(-1, 2, 6) + t dot vec(2, -1, -2), quad
    h: arrow(r) = vec(0, 0, 8) + s dot vec(1, 1, -4).
  $

  #auto-parts(
    1,
    [Show that $g$ and $h$ intersect, and find the intersection point
      $S$.],
    [Find the exact angle between $g$ and $h$.],
    [Find the Cartesian equation of the plane $E$ containing both
      lines.],
    [Find the distance from $P = (3, 3, 5)$ to $E$.],
    [Find the point of $E$ nearest to $P$. Comment on your answer.],
    [$E$ and the three coordinate planes bound a pyramid. Find its
      volume.],
  )
][
  #auto-parts(
    1,
    [Not parallel. $-1 + 2t = s$ and $2 - t = s$ give $t = 1$, $s = 1$.
      Third equation: $6 - 2 = 4$ and $8 - 4 = 4$ ✓. So
      $S = (1, 1, 4)$.],
    [$arrow(v)_1 dot arrow(v)_2 = 2 - 1 + 8 = 9$, lengths $3$ and
      $3 sqrt(2)$: $cos(phi.alt) = 9 slash (9 sqrt(2)) = 1 slash
      sqrt(2)$, so $phi.alt = 45 degree$.],
    [$vec(2, -1, -2) times vec(1, 1, -4) = vec(6, 6, 3) arrow.r
      vec(2, 2, 1)$. With $S$: $2 + 2 + 4 + d = 0$, so
      $E: 2x + 2y + z - 8 = 0$. Check both anchors:
      $-2 + 4 + 6 - 8 = 0$ ✓, $8 - 8 = 0$ ✓.],
    [$d = (6 + 6 + 5 - 8) slash 3 = 3$.],
    [$(3 + 2t, 3 + 2t, 5 + t)$ in $E$: $9 + 9t = 0$, $t_0 = -1$, so the
      nearest point is $(1, 1, 4) = S$. Indeed
      $arrow(S P) = vec(2, 2, 1) = arrow(n)$: $P$ sits directly above $S$
      on the normal, which is also why the distance is exactly
      $abs(arrow(n)) = 3$.],
    [Intercepts $4$, $4$, $8$. Base area $1/2 dot 4 dot 4 = 8$, height
      $8$: $V = 64 slash 3$.],
  )
]

#ex(difficulty: 3, time: "35 min", calculator: false, keep-together: false)[
  *Exam question 3.* The sphere $s: x^2 + y^2 + z^2 = 100$ and the
  points $P = (2, 4, 4)$, $Q = (4, 5, 2)$ and $R = (0, 5, 4)$ are
  given.

  #auto-parts(
    1,
    [Find the Cartesian equation of the plane $E$ through $P$, $Q$,
      $R$.],
    [Show that $E$ cuts $s$, and find the centre and radius of the
      circle of intersection. Comment on the centre.],
    [Show that $K = (0, 6, 8)$ lies on $s$, and find the tangent plane
      $T$ to $s$ at $K$.],
    [Find the exact cosine of the angle between $E$ and $T$.],
    [The circle from (b) is the base of a cone whose apex is the
      origin. Find its volume.],
    [Find the volume of the tetrahedron $O P Q R$ in two different
      ways.],
  )
][
  #auto-parts(
    1,
    [$arrow(P Q) = vec(2, 1, -2)$, $arrow(P R) = vec(-2, 1, 0)$,
      $arrow(P Q) times arrow(P R) = vec(2, 4, 4) arrow.r vec(1, 2, 2)$.
      With $P$: $2 + 8 + 8 + d = 0$, so
      $E: x + 2y + 2z - 18 = 0$. Check: $Q$ gives $4 + 10 + 4 = 18$ ✓,
      $R$ gives $0 + 10 + 8 = 18$ ✓.],
    [The centre is $O$, the radius $10$, and
      $d(O, E) = abs(-18) slash 3 = 6 < 10$:
      $E$ cuts $s$. The foot from $O$: $(t, 2t, 2t)$ in $E$ gives
      $9t = 18$, $t = 2$, so the centre is $(2, 4, 4)$ and the radius
      is $sqrt(100 - 36) = 8$.

      *Comment:* the centre is $P$ itself — $arrow(O P) = 2 dot
      arrow(n)$, so $P$ was already the foot of the perpendicular.],
    [$0 + 36 + 64 = 100$ ✓. Normal $arrow(O K) = vec(0, 6, 8)
      arrow.r vec(0, 3, 4)$, so $T: 3y + 4z + d = 0$ with
      $18 + 32 + d = 0$: $T: 3y + 4z - 50 = 0$.],
    [$cos(phi.alt) = abs(0 + 6 + 8) slash (3 dot 5) = 14 slash 15$.],
    [Base radius $8$, height $6$ (the distance from (b)):
      $V = 1/3 dot pi dot 64 dot 6 = 128 pi$.],
    [*Triple product:*
      $arrow(O P) times arrow(O Q) = vec(-12, 12, -6)$, dotted with
      $arrow(O R) = vec(0, 5, 4)$ gives $60 - 24 = 36$, so
      $V = 36 slash 6 = 6$.

      *Base times height:* triangle $P Q R$ has area
      $1/2 dot abs(vec(2, 4, 4)) = 3$, and the height is
      $d(O, E) = 6$: $V = 1/3 dot 3 dot 6 = 6$ ✓. Two routes that share
      no arithmetic — that is what makes the agreement worth
      something.],
  )
]

// ════════════════════════════════════════════════════════════
== What to Remember

#keybox(title: "Question, and the tool that answers it")[
  #table(
    columns: (1fr, 1.25fr),
    stroke: none,
    inset: (x: 4pt, y: 3pt),
    [*Length, distance between points*], [$abs(arrow(A B))$],
    [*Parallel? Collinear?*], [one vector a multiple of the other],
    [*Perpendicular?*], [dot product $= 0$],
    [*Angle between vectors / lines*],
    [dot product over magnitudes; absolute value for lines],

    [*Vector perpendicular to two vectors*], [cross product],
    [*Area of a triangle*], [$1/2 dot abs(arrow(A B) times arrow(A C))$],
    [*Plane through three points*],
    [cross product for $arrow(n)$, substitute a point for $d$],

    [*Point on a plane?*], [substitute into the Cartesian equation],
    [*Line meets plane*], [substitute; one equation in $t$],
    [*Two planes meet*],
    [$arrow(n)_1 times arrow(n)_2$; set one coordinate to $0$],

    [*Two lines*], [directions first; then test the third equation],
    [*Angle plane–plane / line–plane*], [$arccos$ / $arcsin$],
    [*Point–plane distance*], [Hesse normal form],
    [*Nearest point, mirror image*], [travel along $arrow(n)$],
    [*Point–line distance*],
    [$abs(arrow(v) times arrow(A P)) slash abs(arrow(v))$],

    [*Skew lines distance, volumes*], [triple product formulas],
    [*Sphere and plane*], [compare $d(M, E)$ with $R$],
    [*Tangent plane at $T$*], [normal $arrow(M T)$],
  )
]

#warning[
  The standard errors, collected:
  $arrow(A B)$ is $B - A$ · two matching ratios do not prove parallel ·
  different parameters for two lines · test the third equation ·
  absolute value for angles between lines and planes · $arcsin$ for a
  line and a plane · rescale before comparing parallel planes · a
  "plane at distance $L$" has two answers · the triangle is *half* the
  cross product · keep fractions as fractions until the end.
]

#print-vocab()
