#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Quadratic Functions and Equations")
#let ex = exercise.with(chapter: "Quadratic Functions and Equations")

= Quadratic Functions and Equations

#only-theory[
  So far, every function we've graphed has been a straight line. But
  most of the world doesn't move in straight lines -- a ball thrown
  into the air, the profit of a company as prices change, the shape
  of a satellite dish: all of these are curves. The simplest curved
  function is the #vocab("quadratic function", "quadratische Funktion")
  and its graph is a #vocab("parabola", "Parabel"). In this chapter we
  learn to read a parabola from its equation, sketch it from a few key
  features, and solve the equations that come with it.
]

#objectives(
  bfkm[identify the three standard forms of a quadratic function --
    standard, factored, and vertex form -- and convert between them],
  bfkm[graph a quadratic function and describe how transformations
    change the shape and position of its parabola],
  bfkm[solve quadratic equations by factoring, completing the square,
    and applying the quadratic formula],
  [use the discriminant to determine the number of solutions of a
    quadratic equation, and connect this to the number of times its
    graph crosses the $x$‑axis],
  [set up and solve a quadratic equation to model a real-world
    situation],
)

== Three Faces of the Same Parabola

#only-theory[
  A quadratic function can be written in three different ways. Each
  form looks different, but they all describe the *same* parabola --
  they just make different features easy to read off at a glance.
]

#definition(title: "Standard Form")[
  $ f(x) = a dot x^2 + b dot x + c, quad a eq.not 0 $
  Since $f(0) = c$, the point $(0, c)$ is the $y$‑intercept.
]

#definition(title: "Factored Form")[
  $ f(x) = a dot (x - x_1) dot (x - x_2) $
  The values $x_1$ and $x_2$ are the #vocab("zeros", "Nullstellen") of
  the function (also called its *roots*) -- the $x$‑values where the
  graph crosses the $x$‑axis.
]

#definition(title: "Vertex Form")[
  $ f(x) = a dot (x - h)^2 + k $
  The point $(h, k)$ is the #vocab("vertex", "Scheitelpunkt") of the
  parabola -- its highest or lowest point -- and the vertical line
  $x = h$ is its #vocab("axis of symmetry", "Symmetrieachse").
]

#keybox(title: "What Each Form Tells You Immediately")[
  - *Standard form* $a dot x^2 + b dot x + c$: the $y$‑intercept
    $(0, c)$.
  - *Factored form* $a dot (x-x_1) dot (x-x_2)$: the zeros $x_1$,
    $x_2$.
  - *Vertex form* $a dot (x-h)^2 + k$: the vertex $(h,k)$ and the axis
    of symmetry $x = h$.
  - In every form, $a$ tells you whether the parabola opens *upward*
    ($a>0$) or *downward* ($a<0$), and how narrow or wide it is.
]

#keybox(title: "From Standard Form to Vertex Form")[
  For $f(x) = a dot x^2 + b dot x + c$, the vertex is at
  $ h = -b/(2a), quad k = f(h). $
  We'll see exactly *why* this works a bit later, when we solve
  quadratic equations by completing the square -- vertex form and
  completing the square are really the same idea.
]

#example[
  Convert $f(x) = 2x^2 - 8x + 5$ to vertex form.
  $ h = -(-8)/(2 dot 2) = 8/4 = 2, quad
    k = f(2) = 2 dot 2^2 - 8 dot 2 + 5 = -3. $
  So $f(x) = 2 dot (x - 2)^2 - 3$. Expanding confirms this matches the
  original: $2 dot (x-2)^2 - 3 = 2x^2 - 8x + 8 - 3 = 2x^2 - 8x + 5$.
]

#ex(difficulty: 1, time: "15 min")[
  Find the vertex of each quadratic function by converting to vertex
  form.
  #parts(
    2,
    [(a) $f(x) = x^2 - 6x + 5$],
    [(b) $f(x) = x^2 + 4x + 1$],
    [(c) $f(x) = -x^2 + 2x + 3$],
    [(d) $f(x) = 3x^2 + 12x + 7$],
    [(e) $f(x) = -2x^2 + 8x - 3$],
    [(f) $f(x) = x^2 - 3x - 4$],
  )
][
  #parts(
    2,
    [(a) vertex $(3, -4)$],
    [(b) vertex $(-2, -3)$],
    [(c) vertex $(1, 4)$],
    [(d) vertex $(-2, -5)$],
    [(e) vertex $(2, 5)$],
    [(f) vertex $(3/2, -25/4)$],
  )
]

== Graphing and Transformations

#only-theory[
  Vertex form makes graphing fast, because it shows the parabola
  $y = x^2$ after it has been stretched, flipped, and shifted.
]

#abstraction-ladder(
  l0: [A ball is thrown upward. Its height changes second by
    second.],
  l1: [$t=0$: $h=1$ m. $t=1$: $h=16$ m. $t=2$: $h=21$ m. $t=3$:
    $h=16$ m.],
  l2: [The heights rise, peak, then fall -- symmetric around $t=2$.],
  l3: [$h(t) = -5 dot (t - 2)^2 + 21$],
)

#keybox(title: "Reading a Transformation from Vertex Form")[
  For $f(x) = a dot (x - h)^2 + k$, compared to the parent function
  $y = x^2$:
  - $|a| > 1$ stretches the parabola *narrower*; $0 < |a| < 1$ makes
    it *wider*.
  - $a < 0$ *reflects* the parabola across the $x$‑axis, so it opens
    downward instead of upward.
  - $h$ shifts the graph *horizontally* ($h > 0$ moves it right).
  - $k$ shifts the graph *vertically* ($k > 0$ moves it up).
]

#example[
  Compare $y = x^2$ (the parent function) with
  $y = -0.5 dot (x - 1)^2 + 3$.
  #plot-graph(
    x => x * x,
    (fn: x => -0.5 * (x - 1) * (x - 1) + 3, color: warn-col),
    xmin: -4.5, xmax: 4.5, ymin: -4.5, ymax: 4.5, size: 7, grid-step: 1,
  )
  The second parabola is *wider* than the first ($|a| = 0.5 < 1$),
  opens *downward* ($a < 0$), and its vertex has shifted from
  $(0,0)$ to $(1,3)$.
]

#ex(difficulty: 1, time: "10 min")[
  For each function, state the vertex, whether the parabola opens
  upward or downward, and whether it is narrower or wider than
  $y = x^2$.
  #parts(
    2,
    [(a) $y = 3 dot (x - 2)^2 + 1$],
    [(b) $y = -(x + 4)^2 - 2$],
    [(c) $y = 0.25 dot (x - 1)^2 + 5$],
    [(d) $y = -2x^2 + 6$],
  )
][
  #parts(
    2,
    [(a) vertex $(2,1)$, opens upward, narrower],
    [(b) vertex $(-4,-2)$, opens downward, same width],
    [(c) vertex $(1,5)$, opens upward, wider],
    [(d) vertex $(0,6)$, opens downward, narrower],
  )
]

== Solving Quadratic Equations

#only-theory[
  A quadratic *equation* sets a quadratic function equal to zero:
  $a dot x^2 + b dot x + c = 0$. Its solutions are exactly the zeros
  of the function -- the $x$‑values where its graph meets the
  $x$‑axis. We now look at three methods for finding them.
]

=== Factoring

#only-theory[
  If a quadratic factors as $a dot (x - x_1) dot (x - x_2) = 0$, the
  *zero-product property* tells us a product is zero exactly when one
  of its factors is zero. So $x = x_1$ or $x = x_2$.
]

#example[
  Solve $x^2 - 5x + 6 = 0$.

  Factoring: $x^2 - 5x + 6 = (x - 2) dot (x - 3)$. By the
  zero-product property, $x - 2 = 0$ or $x - 3 = 0$, so $x = 2$ or
  $x = 3$.
]

#ex(difficulty: 1, time: "20 min", keep-together: true)[
  Solve by factoring.
  #parts(
    2,
    [(a) $x^2 - 5x + 6 = 0$],
    [(b) $x^2 - 3x - 4 = 0$],
    [(c) $x^2 + x - 12 = 0$],
    [(d) $2x^2 + 7x + 3 = 0$],
    [(e) $6x^2 - 5x - 6 = 0$],
    [(f) $x^2 - 9x + 20 = 0$],
  )
][
  #parts(
    2,
    [(a) $x = 2$ or $x = 3$],
    [(b) $x = -1$ or $x = 4$],
    [(c) $x = -4$ or $x = 3$],
    [(d) $x = -3$ or $x = -1/2$],
    [(e) $x = -2/3$ or $x = 3/2$],
    [(f) $x = 4$ or $x = 5$],
  )
]

=== Completing the Square

#only-theory[
  #vocab("Completing the square", "quadratische Ergänzung") turns
  $x^2 + b dot x$ into a perfect square by adding and subtracting
  $(b/2)^2$:
  $ x^2 + b dot x = (x + b/2)^2 - (b/2)^2. $
  This lets us solve any quadratic equation, not just the ones that
  factor nicely.
]

#example[
  Solve $2x^2 - 8x + 5 = 0$ by completing the square.

  This is the same function we converted to vertex form earlier:
  $2x^2 - 8x + 5 = 2 dot (x-2)^2 - 3$. So the equation becomes
  $ 2 dot (x - 2)^2 - 3 = 0 quad => quad (x-2)^2 = 3/2 quad => quad
    x - 2 = plus.minus sqrt(3/2). $
  Since $sqrt(3/2) = sqrt(6)/2$, the solutions are
  $ x = 2 plus.minus sqrt(6)/2. $
]

#ex(difficulty: 2, time: "20 min", keep-together: true)[
  Solve by completing the square.
  #parts(
    2,
    [(a) $x^2 + 6x + 4 = 0$],
    [(b) $x^2 - 4x - 3 = 0$],
    [(c) $3x^2 + 6x - 2 = 0$],
    [(d) $2x^2 - 12x + 7 = 0$],
  )
][
  #parts(
    2,
    [(a) $x = -3 plus.minus sqrt(5)$],
    [(b) $x = 2 plus.minus sqrt(7)$],
    [(c) $x = -1 plus.minus sqrt(15)/3$],
    [(d) $x = 3 plus.minus sqrt(22)/2$],
  )
]

=== The Quadratic Formula

#only-theory[
  Completing the square works every time, but repeating the full
  process for every equation is slow. Doing it once, in general, for
  $a dot x^2 + b dot x + c = 0$ gives a formula we can just plug
  numbers into.
]

#theorem(title: "The Quadratic Formula")[
  The solutions of $a dot x^2 + b dot x + c = 0$ (with $a eq.not 0$)
  are
  $ x = (-b plus.minus sqrt(b^2 - 4 a dot c)) / (2a). $
]

#proof[
  Divide by $a$: $x^2 + (b/a) dot x + c/a = 0$. Complete the square on
  the left side exactly as before -- only now $b/a$ and $c/a$ take
  the place of $b$ and $c$ -- and isolate $x$. Working through the
  same steps gives the boxed formula above.
]

#only-theory[
  The expression under the square root, $b^2 - 4 a dot c$, controls
  how many solutions there are. We look at this closely in the next
  section.
]

#example[
  Solve $3x^2 - 2x - 1 = 0$ using the quadratic formula.
  $ x = (2 plus.minus sqrt((-2)^2 - 4 dot 3 dot (-1))) / (2 dot 3)
    = (2 plus.minus sqrt(16)) / 6 = (2 plus.minus 4)/6. $
  So $x = 1$ or $x = -1/3$.
]

#ex(difficulty: 2, time: "25 min", keep-together: true)[
  Solve using the quadratic formula.
  #parts(
    2,
    [(a) $x^2 - 2x - 1 = 0$],
    [(b) $2x^2 + 3x - 2 = 0$],
    [(c) $x^2 + 4x + 1 = 0$],
    [(d) $3x^2 - 5x - 2 = 0$],
    [(e) $4x^2 + 4x + 1 = 0$],
    [(f) $x^2 - x - 1 = 0$],
  )
][
  #parts(
    2,
    [(a) $x = 1 plus.minus sqrt(2)$],
    [(b) $x = -2$ or $x = 1/2$],
    [(c) $x = -2 plus.minus sqrt(3)$],
    [(d) $x = -1/3$ or $x = 2$],
    [(e) $x = -1/2$ (a repeated solution)],
    [(f) $x = (1 plus.minus sqrt(5))/2$ -- the golden ratio!],
  )
]

#ai-box(role: "Checker")[
  Pick one equation from the exercise above. Solve it completely on
  paper first. Then ask an AI to solve the *same* equation and show
  its steps. Compare line by line: where does it match your work? If
  it disagrees with you anywhere, don't just trust the louder answer
  -- resolve the disagreement by hand.
]

== Techniques You Know So Far

#known-techniques(
  "Factoring and the zero-product property",
  "Completing the square",
  "The quadratic formula",
)

#ex(difficulty: 2, time: "15 min", keep-together: true)[
  Solve each equation using *any* method you like.
  #parts(
    2,
    [(a) $x^2 - 9 = 0$],
    [(b) $x^2 - 4x + 4 = 0$],
    [(c) $2x^2 + x - 6 = 0$],
    [(d) $x^2 + 3x - 1 = 0$],
  )
][
  #parts(
    2,
    [(a) $x = plus.minus 3$],
    [(b) $x = 2$ (a repeated solution)],
    [(c) $x = -2$ or $x = 3/2$],
    [(d) $x = (-3 plus.minus sqrt(13))/2$],
  )
]

== The Discriminant

#only-theory[
  Look again at the quadratic formula:
  $ x = (-b plus.minus sqrt(b^2 - 4 a dot c)) / (2a). $
  Everything about how many solutions there are comes down to what's
  under the square root. This expression has its own name.
]

#definition(title: "Discriminant")[
  For $a dot x^2 + b dot x + c = 0$, the
  #vocab("discriminant", "Diskriminante") is
  $ Delta = b^2 - 4 a dot c. $
]

#keybox(title: "The Discriminant Tells You How Many Solutions")[
  - $Delta > 0$: *two* distinct real solutions -- the parabola
    crosses the $x$‑axis twice.
  - $Delta = 0$: *one* (repeated) solution -- the parabola *touches*
    the $x$‑axis at its vertex.
  - $Delta < 0$: *no* real solutions -- the parabola never meets the
    $x$‑axis at all.
]

#image-grid(3, gutter: 8pt,
  [
    #plot-graph(
      x => (x - 0.5) * (x - (-1.5)),
      xmin: -3.5, xmax: 3.5, ymin: -3.5, ymax: 5.5, size: 4.2,
      grid-step: 1,
    )
    $Delta > 0$: two crossings.
  ],
  [
    #plot-graph(
      x => (x - 1) * (x - 1),
      xmin: -2.5, xmax: 4.5, ymin: -2.5, ymax: 4.5, size: 4.2,
      grid-step: 1,
    )
    $Delta = 0$: one touching point.
  ],
  [
    #plot-graph(
      x => x * x + 2,
      xmin: -3.5, xmax: 3.5, ymin: -1.5, ymax: 6.5, size: 4.2,
      grid-step: 1,
    )
    $Delta < 0$: no crossing.
  ],
)

#ex(difficulty: 1, time: "15 min")[
  Without solving, use the discriminant to state how many real
  solutions each equation has.
  #parts(
    2,
    [(a) $x^2 - 4x + 4 = 0$],
    [(b) $2x^2 + 3x + 5 = 0$],
    [(c) $x^2 - 6x + 9 = 0$],
    [(d) $3x^2 - 2x - 1 = 0$],
    [(e) $x^2 - 9 = 0$],
    [(f) $2x^2 - 4x + 3 = 0$],
  )
][
  #parts(
    2,
    [(a) $Delta = 0$: one solution],
    [(b) $Delta = -31$: no real solutions],
    [(c) $Delta = 0$: one solution],
    [(d) $Delta = 16$: two solutions],
    [(e) $Delta = 36$: two solutions],
    [(f) $Delta = -8$: no real solutions],
  )
]

=== How Many Times Do a Line and a Parabola Meet?

#only-theory[
  Back in the systems chapter, we saw that two straight lines meet at
  most once. A line and a parabola can meet *twice*, *once*, or *not
  at all* -- and now we have exactly the tool to tell which.
  Substitute the line's equation into the parabola's equation. The
  result is a quadratic equation in one variable, and its
  discriminant tells you how many intersection points there are.
]

#example[
  Solve the system
  $ #system(($y$, $x^2 - 2x - 1$), ($y$, $x + 1$)) $
  Setting the two expressions for $y$ equal:
  $ x^2 - 2x - 1 = x + 1 quad => quad x^2 - 3x - 2 = 0. $
  The discriminant is $Delta = 9 + 8 = 17 > 0$, so there are two
  intersection points:
  $ x = (3 plus.minus sqrt(17))/2, quad y = x + 1. $
]

#ex(difficulty: 2, time: "20 min", keep-together: true)[
  For each system, find how many solutions it has, and solve it
  completely if it has any.
  #parts(
    2,
    [(a) $#system(($y$, $x^2$), ($y$, $2x - 1$))$],
    [(b) $#system(($y$, $x^2 - 4$), ($y$, $x - 2$))$],
    [(c) $#system(($y$, $x^2 + 1$), ($y$, $x - 3$))$],
    [(d) $#system(($y$, $-x^2 + 4x$), ($y$, $x + 2$))$],
  )
][
  #parts(
    2,
    [(a) tangent, one solution: $(1, 1)$],
    [(b) two solutions: $(-1, -3)$ and $(2, 0)$],
    [(c) no solution -- the line and parabola never meet],
    [(d) two solutions: $(1, 3)$ and $(2, 4)$],
  )
]

#look-ahead(
  title: "Finding a Tangent Line -- No Calculus Needed",
  preview: [derivatives and instantaneous rate of change],
)[
  A tangent line to a parabola at a point touches the curve there
  without crossing it -- it meets the parabola *exactly once* near
  that point. "Exactly one solution" is exactly the discriminant-zero
  case! We can use this to find a tangent line's slope without any
  calculus at all.

  *Example.* Find the slope of the line tangent to $y = x^2$ at the
  point $(2, 4)$.

  A line through $(2,4)$ with unknown slope $m$ has equation
  $y = m dot (x - 2) + 4$. Where does it meet the parabola?
  $ x^2 = m dot (x - 2) + 4 quad => quad x^2 - m dot x + (2m - 4) = 0. $
  For the line to be *tangent* (touching at exactly one point), this
  equation needs exactly one solution, so its discriminant must be
  zero:
  $ m^2 - 4 dot (2m - 4) = 0 quad => quad m^2 - 8m + 16 = 0 quad =>
    quad (m - 4)^2 = 0. $
  So $m = 4$: the tangent line at $(2,4)$ has slope $4$.

  Before you calculate the next one, guess first: is the parabola
  getting steeper or shallower as $x$ increases? Then check your
  guess with the same method.
]

#ex(
  difficulty: 3,
  time: "20 min",
  hints: (
    "Write the tangent line through the given point with unknown slope $m$, substitute into the parabola's equation, and set the discriminant of the resulting quadratic (in $x$) equal to zero.",
  ),
)[
  Use the discriminant method to find the slope of the tangent line
  to each parabola at the given point.
  #parts(
    2,
    [(a) $y = x^2$ at $(-1, 1)$],
    [(b) $y = 0.5x^2 - 3$ at $(4, 5)$],
  )
][
  #parts(2, [(a) slope $-2$], [(b) slope $4$])
]

== Word Problems

#only-theory[
  Quadratic models show up whenever a quantity depends on the
  *square* of another -- falling objects, areas, and many
  optimization problems all lead to quadratic equations.
]

#example[
  A ball is thrown upward from a height of 1 m with an initial speed
  of 20 m/s. Its height after $t$ seconds (in meters) is
  $ h(t) = -5t^2 + 20t + 1. $
  When does the ball reach its maximum height, and how high is it?

  This is exactly a vertex-form question: $h(t)$ is a
  downward-opening parabola, so its maximum is at its vertex.
  $ t = -20/(2 dot (-5)) = 2, quad h(2) = -5 dot 2^2 + 20 dot 2 + 1
    = 21. $
  The ball reaches a maximum height of $21$ m after $2$ seconds.
]

#ex(difficulty: 2, time: "15 min")[
  Using the same height function $h(t) = -5t^2 + 20t + 1$ from the
  example above:
  + After how many seconds does the ball hit the ground (that is,
    when is $h(t) = 0$)? Round to the nearest tenth of a second.
  + Explain why the *other* solution of $h(t) = 0$ isn't a sensible
    answer to this question.
][
  + Using the quadratic formula: $t = 2 plus.minus sqrt(105)/5$. Only
    the positive solution makes sense, so the ball hits the ground
    after $t approx 4.0$ s.
  + The other solution, $t = 2 - sqrt(105)/5 approx -0.05$ s, is
    negative -- it would describe a time *before* the ball was
    thrown, which isn't part of this situation.
]

#example[
  A farmer has 80 m of fencing and wants to enclose a rectangular pen
  against the side of a barn (so only three sides need fencing). What
  dimensions maximize the enclosed area?

  Let $x$ be the length of each of the two sides perpendicular to the
  barn. The remaining fencing forms the side parallel to the barn:
  $80 - 2x$. The area is
  $ A(x) = x dot (80 - 2x) = -2x^2 + 80x. $
  This is a downward-opening parabola in $x$, maximized at its
  vertex:
  $ x = -80/(2 dot (-2)) = 20. $
  So the pen should be 20 m by $80 - 2 dot 20 = 40$ m, giving a
  maximum area of $20 dot 40 = 800$ m².
]

#ex(difficulty: 2, time: "15 min")[
  The product of two consecutive positive integers is $132$. Find the
  two integers.
][
  Let the integers be $x$ and $x+1$: $x dot (x+1) = 132$, so
  $x^2 + x - 132 = 0$. This factors as $(x - 11) dot (x + 12) = 0$,
  giving $x = 11$ (the other solution, $x = -12$, isn't a positive
  integer). The integers are $11$ and $12$.
]

#ex(difficulty: 2, time: "15 min")[
  A rectangular garden has a perimeter of 100 m and an area of 600
  m². Find its dimensions.
][
  Let the width be $w$; then the length is $50 - w$ (since
  $2w + 2 dot "length" = 100$). The area condition gives
  $ w dot (50 - w) = 600 quad => quad w^2 - 50w + 600 = 0. $
  Solving: $Delta = 2500 - 2400 = 100$, so
  $w = (50 plus.minus 10)/2 = 30$ or $20$. Either way, the garden
  measures 30 m by 20 m.
]

== Extra Bits -- Vieta's Formulas

#only-theory[
  If a quadratic $a dot x^2 + b dot x + c = 0$ has solutions $x_1$
  and $x_2$, its factored form must be
  $a dot (x-x_1) dot (x-x_2) = 0$. Expanding this and comparing
  coefficients with the standard form gives a shortcut: you can read
  off the *sum* and *product* of the solutions directly from $a$,
  $b$, and $c$ -- without solving the equation at all.
]

#theorem(title: "Vieta's Formulas")[
  If $x_1$ and $x_2$ are the solutions of $a dot x^2 + b dot x + c =
  0$ (with $a eq.not 0$), then
  $ x_1 + x_2 = -b/a, quad x_1 dot x_2 = c/a. $
]

#proof[
  Expand the factored form:
  $ a dot (x-x_1) dot (x-x_2) = a dot x^2 - a dot (x_1+x_2) dot x
    + a dot x_1 dot x_2. $
  Comparing this with $a dot x^2 + b dot x + c$ term by term gives
  $-a dot (x_1+x_2) = b$ and $a dot x_1 dot x_2 = c$ -- divide both
  by $a$ to get the formulas above.
]

#example[
  Check Vieta's formulas against $3x^2 - 5x - 2 = 0$, which we solved
  earlier with the quadratic formula as $x_1 = -1/3$ and $x_2 = 2$.

  Sum: $x_1 + x_2 = -1/3 + 2 = 5/3$, matching $-b/a = -(-5)/3 = 5/3$.
  Product: $x_1 dot x_2 = -1/3 dot 2 = -2/3$, matching $c/a = -2/3$.
]

#ex(difficulty: 2, time: "15 min")[
  + Without solving, find the sum and product of the solutions of
    $x^2 - 7x + 10 = 0$.
  + The equation $x^2 - k dot x + 12 = 0$ has $x = 3$ as one of its
    solutions. Use Vieta's formulas to find $k$ and the other
    solution -- without using the quadratic formula.
][
  + Sum $= 7$, product $= 10$.
  + The product of the solutions is $12$, and one of them is $3$, so
    the other is $12/3 = 4$. The sum is then $3 + 4 = 7 = k$.
]

#exploration(title: "Halfway Between the Roots")[
  You now know that $x_1 + x_2 = -b/a$. Divide both sides by $2$ and
  compare with the vertex formula $h = -b/(2a)$ from earlier in this
  chapter. What do you notice? Use the *symmetry* of a parabola to
  explain in words why the vertex must sit exactly halfway between
  the two zeros -- whenever there are two of them.
]

#look-ahead(preview: [power functions])[
  Every quadratic function is built from $x^2$. But $x^2$ is really
  just one member of a much bigger family: $x^3$, $x^4$, and all the
  others are *power functions*, $f(x) = x^n$, each with its own
  characteristic shape. Soon we'll study that whole family at once --
  and quadratics will turn out to be the special case you already
  understand best.
]

#print-hints()
#print-vocab()
