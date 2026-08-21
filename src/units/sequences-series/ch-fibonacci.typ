// ============================================================
//  ch-fibonacci.typ — Fibonacci Numbers and the Golden Ratio
//  (Enrichment chapter. Not tied to any Lehrplan competency, so no
//  objectives here carry bfkm[...] badges.)
//
// ── WHO THIS IS FOR ──────────────────────────────────────────
//  Written so it can be handed to a fast-finishing GLF class OR
//  compiled as a bonus SPF chapter, per teacher's note. It is
//  therefore deliberately self-contained rather than relying on
//  only-high/only-basic splits: every exercise carries the default
//  level: "all", so nothing disappears depending on which document
//  compiles it. Register it at the end of the sequences-series
//  main-high.typ (see snippet below) if you want it bundled into
//  the SPF lecture notes; compile ch-fibonacci.typ on its own (or
//  hand it out as a standalone PDF) for fast GLF students. Because
//  it sits outside both main-basic.typ and the graded exercise
//  sheets, nothing here is assumed to have been seen on an exam.
//
// ── REGISTRATION SNIPPET (paste into sequences-series/main-high.typ,
//    as the last entry inside register_chapters(...)) ───────────
//    ("Fibonacci", "/src/units/sequences-series/ch-fibonacci"),
//
// ── IMAGES NEEDED ────────────────────────────────────────────
//  The nature section reuses "images/nautilus.jpg" (already present
//  in this unit's images/ folder, per ch-basics.typ). It ALSO
//  references two images that still need to be added to that same
//  folder:
//    images/sunflower.jpg   — a sunflower head showing spiral florets
//    images/pinecone.jpg    — a pinecone showing spiral scales
//  Both are easy to source under a permissive license (e.g. a
//  Wikimedia Commons photo credited in a caption) or to take
//  yourself. The Fibonacci-square diagram used earlier in the
//  section is drawn natively below (fib-squares()) and needs no
//  image file at all.
//
// ── A NOTE ON THE TWO "APOCRYPHAL" THREADS ──────────────────
//  Both the rabbit problem and the Parthenon/golden-ratio-in-Greek-
//  architecture story are told here with the same light skepticism:
//  genuinely old (13th-century and Euclid-era, respectively), but
//  NOT good evidence for the popular claims built on top of them.
//  This is deliberate — it's a nice second example of the "AI/media
//  literacy" thread the course already runs (see ch-paradoxes.typ),
//  applied to popular-math claims instead of logic puzzles.
//
// ── LOCAL HELPER: fib-squares() ──────────────────────────────
//  A small native (no external package) diagram of the classic
//  Fibonacci square tiling (sides 1, 1, 2, 3, 5, 8), used once below
//  to illustrate the golden-rectangle connection. Candidate for
//  promotion to preamble.typ if a later chapter wants it too — kept
//  local for now, same policy already applied to sim-box().
// ============================================================

#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Fibonacci Numbers and the Golden Ratio")

#let ex = exercise.with(chapter: "Fibonacci")

#let fib-squares(unit: 0.34cm, col: accent, fillc: accent-bg) = only-theory(
  align(center, box(width: 13 * unit, height: 8 * unit, {
    // sides 1, 1, 2, 3, 5, 8 — see header comment for how the
    // coordinates below were derived.
    place(dx: 3 * unit, dy: 5 * unit, rect(
      width: 1 * unit,
      height: 1 * unit,
      fill: fillc,
      stroke: 0.8pt + col,
    ))
    place(dx: 4 * unit, dy: 5 * unit, rect(
      width: 1 * unit,
      height: 1 * unit,
      fill: fillc,
      stroke: 0.8pt + col,
    ))
    place(dx: 3 * unit, dy: 6 * unit, rect(
      width: 2 * unit,
      height: 2 * unit,
      fill: fillc,
      stroke: 0.8pt + col,
    ))
    place(dx: 0 * unit, dy: 5 * unit, rect(
      width: 3 * unit,
      height: 3 * unit,
      fill: fillc,
      stroke: 0.8pt + col,
    ))
    place(dx: 0 * unit, dy: 0 * unit, rect(
      width: 5 * unit,
      height: 5 * unit,
      fill: fillc,
      stroke: 0.8pt + col,
    ))
    place(dx: 5 * unit, dy: 0 * unit, rect(
      width: 8 * unit,
      height: 8 * unit,
      fill: fillc,
      stroke: 0.8pt + col,
    ))
  })),
)

= Fibonacci Numbers and the Golden Ratio

#epigraph[
  The most famous recursion in mathematics starts with a question
  about rabbits and ends at the doorstep of an irrational number.
]

#only-theory[
  This chapter is an extra — it is not needed for any exam, and
  nothing in it will be assumed later. It exists because the
  Fibonacci sequence is one of the few places in school mathematics
  where number theory, algebra, and a genuinely elegant piece of
  algebraic reasoning all meet in one small, self-contained story.
]

#objectives(
  [explain how the Fibonacci sequence is generated recursively, and
    compute any of its early terms by hand],
  [state the defining property of the golden ratio and derive its
    exact value by solving a quadratic equation],
  [derive Binet's formula from the golden ratio and its algebraic
    partner, rather than simply verifying it once it is given],
  [explain informally why the ratio of consecutive Fibonacci numbers
    approaches the golden ratio],
  [distinguish a genuinely documented appearance of the Fibonacci
    sequence from an overstated or unsupported one],
)

== Leonardo of Pisa and the Rabbits

#quotebox[

  In 1202, the Italian merchant and mathematician Leonardo of Pisa
  — better known by his nickname *Fibonacci*, "son of Bonacci" —
  published a book called the _Liber Abaci_ ("Book of Calculation").
  Its real historical importance has nothing to do with rabbits: it
  is one of the works that introduced the Hindu–Arabic numeral
  system (the digits $0$–$9$ and positional notation) to a Europe
  still doing arithmetic with Roman numerals and counting boards.
  That change — replacing $"MCCII"$ with $1202$ — quietly reshaped
  European commerce and science far more than any single sequence
  of numbers did.

  Buried inside the _Liber Abaci_, though, is a small puzzle about
  breeding rabbits. A single pair of rabbits is placed in an
  enclosure. Each pair becomes able to reproduce after one month,
  and from then on produces exactly one new pair every month. No
  rabbit ever dies. How many pairs are there after $n$ months?

  Nobody seriously believes this models actual rabbits — real
  rabbits do not synchronize like this, and do not live forever. The
  puzzle is best read as a stylized arithmetic exercise Fibonacci
  used to illustrate a *pattern of growth*, not as biology. (Also
  worth knowing: the sequence itself was studied earlier still, by
  Indian mathematicians such as Piṅgala and Virahāṅka, in the
  context of counting rhythmic patterns in Sanskrit poetry — several
  centuries before the _Liber Abaci_. Fibonacci popularized the
  sequence in Europe; he did not discover it.)
]

#only-theory[
  Work through the rabbit count month by month. Start with $1$ pair
  (too young to breed) in month $1$. In month $2$ there is still
  just $1$ pair. From month $3$ onward, every pair that existed two
  months ago produces a new pair this month, while every pair alive
  last month is still alive. So
  $ "pairs in month" n = ("pairs last month") + ("pairs two months ago"). $
  Each number is the sum of the two before it — exactly the pattern
  you may already have met informally as $1, 1, 2, 3, 5, dots$
]

#definition(title: "Fibonacci sequence")[
  The #vocab("Fibonacci sequence", "Fibonacci-Folge") is defined
  recursively by
  $
    cases(
      F_1 = 1\, quad F_2 = 1,
      F_(n+2) = F_(n+1) + F_n quad "for" n >= 1,
    )
  $
  giving $1, 1, 2, 3, 5, 8, 13, 21, 34, 55, dots$
]

#warning[
  Some references start the indexing at $F_0 = 0$ instead of
  $F_1 = 1$ — both conventions produce the same list of numbers,
  just shifted by one position. This chapter uses $F_1 = F_2 = 1$
  throughout, matching the convention already used in the Proofs
  chapter's Fibonacci exercise. As always with sequences (see
  Basics of Sequences and Series), state your convention once and
  stay with it.
]

#example(title: "Extending the sequence")[
  Given $F_9 = 34$ and $F_(10) = 55$, find $F_(11)$ and $F_(12)$.

  Each term is the sum of the two before it:
  $
    F_(11) = F_(10) + F_9 = 55 + 34 = 89, quad quad
    F_(12) = F_(11) + F_(10) = 89 + 55 = 144.
  $
]

#ex(difficulty: 1, time: "6 min", calculator: false)[
  Extend the Fibonacci sequence to $F_(15)$, starting from
  $F_1 = F_2 = 1$.
][
  $ 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610. $
  So $F_(15) = 610$.
]

#exploration(title: "Staircases")[
  You can climb a staircase of $n$ steps by taking single steps or
  double steps, in any order (e.g. for $n = 3$: 1-1-1, 1-2, 2-1).
  Let $w(n)$ be the number of different ways to climb $n$ steps.

  Compute $w(1)$, $w(2)$ and $w(3)$ by listing every way directly.
  Then argue, without listing anything, that any way of climbing
  $n$ steps ends with EITHER a final single step (leaving $n - 1$
  steps already climbed some way) OR a final double step (leaving
  $n - 2$ steps already climbed some way) — and never both. What
  recursion does that give you for $w(n)$? Compare it with the
  Fibonacci recursion, and conjecture a formula for $w(n)$ in terms
  of $F_n$.
]

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: false,
  hints: (
    [Every way to climb $n$ steps ends in a single step or a double
      step — exactly the two cases the exploration above asks you to
      separate.
      #heuristic("look for what stays the same")],
  ),
)[
  Confirm the conjecture from the staircase exploration: prove that
  $w(n) = F_(n+1)$ for every $n >= 1$, where $w(n)$ is the number of
  ways to climb $n$ steps using single and double steps.
][
  Splitting by the last step taken: a climb of $n$ steps ending in a
  single step comes from a climb of $n - 1$ steps ($w(n-1)$ ways);
  one ending in a double step comes from a climb of $n - 2$ steps
  ($w(n-2)$ ways). Every climb falls into exactly one of these, so
  $ w(n) = w(n-1) + w(n-2), $
  the Fibonacci recursion. Checking small cases, $w(1) = 1 = F_2$
  and $w(2) = 2 = F_3$, so $w(n)$ and $F_(n+1)$ satisfy the same
  recursion and agree on the first two values — hence
  $w(n) = F_(n+1)$ for all $n >= 1$. (This is the same recursive-
  counting idea from the Probabilities & Combinatorics unit, applied
  to a new situation.)
]

== The Golden Ratio

#only-theory[
  Take a line segment and cut it into a longer piece $a$ and a
  shorter piece $b$. Ask for the cut that makes the whole segment
  relate to the longer piece the same way the longer piece relates
  to the shorter one:
]

#definition(title: "Golden ratio")[
  The #vocab("golden ratio", "Goldener Schnitt") is the positive
  number $phi$ satisfying
  $ (a+b)/a = a/b =: phi, $
  i.e. the ratio obtained when a segment is divided so that the
  whole is to the longer part as the longer part is to the shorter
  part.
]

#quotebox[
  This way of dividing a segment appears in Euclid's _Elements_
  (Book VI, roughly 300 BCE), under the name "division in extreme
  and mean ratio" — Euclid used it as a geometric construction, with
  no symbol $phi$ and no connection to Fibonacci, who lived over a
  thousand years later.

  A popular claim goes much further: that the Parthenon, other
  Greek buildings, and the human body were deliberately designed
  around this exact ratio. This is worth treating with real
  suspicion. Historians of architecture who have actually measured
  the Parthenon find its proportions fit $phi$ no better than they
  fit many other plausible ratios, and no surviving Greek text
  claims any such design principle. The mathematics of $phi$ is
  genuine and old; the specific story about the Parthenon is a much
  later addition, not something Euclid or the Parthenon's builders
  would have recognized.
]

#only-theory[
  Solving for $phi$ turns this ratio into an equation. Writing
  $x = a/b$, the defining property $(a+b)/a = a/b$ becomes
  $1 + 1/x = x$, i.e.
  $ x^2 = x + 1 quad "or equivalently" quad x^2 - x - 1 = 0. $
  By the quadratic formula this equation has two roots, and — unlike
  most quadratics you meet — *both* turn out to matter.
]

#keybox(title: [The two roots of $x^2 = x + 1$])[
  $
    phi = (1 + sqrt(5))/2 approx 1.618034 quad quad
    psi = (1 - sqrt(5))/2 approx -0.618034
  $
  Only $phi$ is a ratio of lengths (it is positive), but $psi$ is
  algebraically its indispensable partner:
  $
    phi + psi = 1, quad quad phi dot psi = -1, quad quad
    phi^2 = phi + 1, quad quad psi^2 = psi + 1.
  $
]

#look-back(
  title: [$phi$ is irrational],
  recalls: [the irrationality proof for $sqrt(5)$ in the
    Mathematical Proofs and Induction chapter],
)[
  If you proved $sqrt(5)$ irrational there, you already have
  everything needed for $phi = (1 + sqrt(5))\/2$: a rational number
  plus or divided by a nonzero rational number of an irrational
  number stays irrational, so $sqrt(5)$ irrational forces $phi$
  irrational too.
]

#ex(difficulty: 1, time: "10 min", calculator: false)[
  Using only $phi^2 = phi + 1$ (no decimal approximations), show:
  #auto-parts(
    1,
    [$1/phi = phi - 1$],
    [$phi^3 = 2 dot phi + 1$],
    [$phi - 1/phi = 1$],
  )
][
  #auto-parts(
    1,
    [From $phi^2 = phi + 1$, dividing every term by $phi$ gives
      $phi = 1 + 1/phi$, so $1/phi = phi - 1$.],
    [$phi^3 = phi dot phi^2 = phi dot (phi + 1) = phi^2 + phi
      = (phi + 1) + phi = 2 dot phi + 1$.],
    [Immediate from (a): $phi - 1/phi = phi - (phi - 1) = 1$.],
  )
]

#only-theory[
  The algebra above has a picture behind it. Take a rectangle with
  side lengths $a > b$ in the golden ratio, $a\/b = phi$. Cut a
  $b times b$ square off one end. What remains is a smaller
  rectangle with sides $b$ and $a - b$ — and because
  $ b/(a - b) = 1/(a\/b - 1) = 1/(phi - 1) = phi, $
  using part (a) of the exercise above, this smaller rectangle is
  *again* a golden rectangle, only smaller. Repeat forever and every
  removed square has a side equal to the side of the one before it,
  scaled down by $phi$ — the same shrink-by-a-constant-factor idea
  from the geometric sequences chapter, now applied to a spiral of
  squares.
]

#fig(
  fib-squares(),
  caption: [
    The golden-rectangle construction, approximated with whole-number
    side lengths $1, 1, 2, 3, 5, 8$ instead of exact powers of $phi$
    — see the identity linking the two in the exercises below.
  ],
)

== Binet's Formula — Where It Comes From

#only-theory[
  It is one thing to be told a closed-form formula for $F_n$ and to
  check it by induction (as you may already have done in the Proofs
  chapter, for specialists). It is a different and more satisfying
  thing to see where such a formula could possibly come from. The
  golden ratio and its algebraic partner $psi$ make that possible.
]

#theorem(title: "Binet's formula")[
  For every $n >= 1$,
  $ F_n = 1/sqrt(5) dot (phi^n - psi^n), $
  where $phi = (1 + sqrt(5))\/2$ and $psi = (1 - sqrt(5))\/2$ are the
  two roots of $x^2 = x + 1$.
]

#proof[
  Both $phi$ and $psi$ satisfy $x^2 = x + 1$, by construction.
  Multiplying that equation through by $x^n$ gives
  $ x^(n+2) = x^(n+1) + x^n $
  for $x = phi$ and, separately, for $x = psi$. So *each* of the two
  sequences $(phi^n)$ and $(psi^n)$ already obeys the Fibonacci
  recursion on its own — and so does any combination
  $ a_n = A dot phi^n + B dot psi^n $
  for constant numbers $A$ and $B$, since the recursion is linear:
  if $a_(n+2) = a_(n+1) + a_n$ holds term-by-term for $phi^n$ and for
  $psi^n$ separately, it holds for $A dot phi^n + B dot psi^n$ too.

  This turns the problem from "guess a formula" into "choose $A$ and
  $B$ so the first two terms come out right." Demanding $a_1 = 1$
  and $a_2 = 1$ gives the system
  $
    A dot phi + B dot psi = 1, quad quad
    A dot phi^2 + B dot psi^2 = 1.
  $
  Using $phi^2 = phi + 1$ and $psi^2 = psi + 1$, the second equation
  becomes $A dot phi + B dot psi + (A + B) = 1$, which by the first
  equation simplifies to $A + B = 0$, i.e. $B = -A$. Substituting
  back into the first equation:
  $
    A dot phi - A dot psi = 1 quad arrow.r.double quad
    A = 1/(phi - psi) = 1/sqrt(5),
  $
  using $phi - psi = sqrt(5)$ from their definitions. Hence
  $A = 1\/sqrt(5)$ and $B = -1\/sqrt(5)$, and
  $ a_n = 1/sqrt(5) dot (phi^n - psi^n) $
  matches the Fibonacci recursion and matches $F_1, F_2$ exactly —
  so it equals $F_n$ for every $n$.
]

#remark[
  The strategy here — write down the characteristic equation of a
  recursion, take its two roots, and combine their powers to match
  the starting values — works for *any* recursion of the form
  $a_(n+2) = p dot a_(n+1) + q dot a_n$ with two distinct roots, not
  only Fibonacci's. Binet's formula is the most famous instance of a
  much more general technique.
]

#example(title: "Using Binet's formula")[
  Estimate $F_(20)$ using Binet's formula, and compare with the
  direct recursion.

  With $phi approx 1.618034$ and $psi approx -0.618034$:
  $
    F_(20) approx (1.618034^(20) - (-0.618034)^(20))/sqrt(5)
    approx #num(6765).
  $
  Direct doubling of the recursion from $F_(15) = 610$ gives the
  same value, $F_(20) = #num(6765)$. Since $abs(psi) < 1$, the term
  $psi^(20)$ is tiny, so $F_n$ is extremely close to
  $phi^n\/sqrt(5)$ alone for even moderately large $n$ — this is
  exactly why the ratio exploration below converges so fast.
]

#ex(
  difficulty: 2,
  time: "12 min",
  calculator: true,
)[
  Use Binet's formula, and your calculator's stored value of
  $sqrt(5)$ (do not round $phi$ or $psi$ by hand), to compute
  $F_(25)$ and $F_(30)$. Round to the nearest integer and check that
  your answer is a whole number, as it must be.
][
  $ F_(25) = #num(75025), quad quad F_(30) = #num(832040). $
  Both come out as whole numbers (up to unavoidable rounding in the
  last digit or two), even though the formula is built entirely from
  irrational pieces — the $psi^n$ term is what quietly cancels the
  irrational part of $phi^n$ each time.
]

== Ratio of Consecutive Terms

#exploration(title: [Where does $phi$ show up in the sequence itself?])[
  Compute the ratios $F_(n+1)\/F_n$ for as many small $n$ as you can
  stand to by hand, then switch to your calculator. What do you
  notice? State a conjecture — as precisely as you can — about what
  happens to $F_(n+1)\/F_n$ as $n$ grows. (No proof is expected here;
  a careful numerical conjecture is the whole point of this
  exploration.)
]

#only-theory[
  The pattern is worth seeing laid out explicitly:
]

#data-table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  row-height: 0.9cm,
  [$n$],
  [1],
  [2],
  [3],
  [4],
  [5],
  [6],
  [$F_n$],
  [1],
  [1],
  [2],
  [3],
  [5],
  [8],
  [$F_(n+1)\/F_n$],
  [1],
  [2],
  [1.5],
  [1.667],
  [1.6],
  [1.625],
)
#v(0.3em)
#data-table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  row-height: 0.9cm,
  [$n$],
  [7],
  [8],
  [9],
  [10],
  [11],
  [12],
  [$F_n$],
  [13],
  [21],
  [34],
  [55],
  [89],
  [144],
  [$F_(n+1)\/F_n$],
  [1.615],
  [1.619],
  [1.618],
  [1.618],
  [1.618],
  [1.618],
)

#only-theory[
  The ratios overshoot and undershoot $phi approx 1.618034$,
  alternately, but the gap shrinks fast — by term $10$ or so it is
  already invisible to three decimal places.
]

#look-ahead(
  title: "Why this deserves a real proof eventually",
  preview: [the formal definition of a limit],
)[
  "The ratios get closer and closer to $phi$" is exactly the kind of
  statement that feels obvious from a table but is not yet a proof —
  what does "closer and closer" actually guarantee? Binet's formula
  gives a shortcut worth keeping in mind for later: dividing
  numerator and denominator of $F_(n+1)\/F_n$ by $phi^n$ gives
  $
    F_(n+1)/F_n = phi dot (1 - (psi\/phi)^(n+1))/(1 - (psi\/phi)^n),
  $
  and since $abs(psi\/phi) < 1$, every power $(psi\/phi)^n$ shrinks
  toward $0$ — which is precisely a *limit* statement, made rigorous
  once you have the formal $epsilon$-$N$ definition.
]

== Fibonacci Numbers in Nature

#only-theory[
  Spiral patterns built from consecutive whole-number turns show up
  repeatedly in plant growth — sunflower seed heads, pinecone
  scales, pineapple segments, and the chambers of a nautilus shell
  are the classic examples. This is a genuine, well-documented
  botanical phenomenon (it has a name, *phyllotaxis*), not an
  overstated pop-math claim like the Parthenon story above — but it
  is worth being precise about exactly what is and isn't true.
]

#fig(
  image-grid(
    3,
    image("images/sunflower.jpg"),
    image("images/pinecone.jpeg"),
    image("images/nautilus.jpg"),
  ),
  caption: [
    Spiral counts on a sunflower head and a pinecone are typically
    consecutive Fibonacci numbers; a nautilus shell's spiral is a
    different, smoother curve that only approximately resembles the
    Fibonacci-square construction (see the warning below).
  ],
)

#only-theory[
  On a sunflower head, seeds are arranged in two interleaved
  families of spirals — one turning clockwise, one counterclockwise
  — and the two spiral counts are very reliably a pair of
  consecutive Fibonacci numbers, commonly $34$ and $55$, or $55$ and
  $89$ on a large flower. Pinecones and pineapples show the same
  phenomenon with their own scale spirals. Botanists explain this
  through a plausible growth-optimization mechanism (each new seed
  or scale forms at a fixed angle from the previous one, close to
  $360 degree \/ phi^2 approx 137.5 degree$, which packs new growth
  as efficiently as possible around the older growth) — this is an
  active area of research, not a mystical coincidence.
]

#warning[
  The nautilus shell is the one example on this page that is
  routinely *overstated*. A nautilus shell grows as a logarithmic
  spiral, which is a genuinely elegant self-similar curve — but its
  growth ratio is close to $4$ per full turn, not $phi$. The popular
  image of quarter-circles inscribed in Fibonacci squares (like the
  diagram earlier in this chapter) is a rough visual cousin of a
  logarithmic spiral, not an accurate model of an actual nautilus.
  Treat "the nautilus is the golden spiral" the same way you treated
  the Parthenon claim earlier: a nice picture that overstates a
  real, more modest mathematical fact.
]

#ai-box(role: "Checker")[
  Ask an AI chatbot to list examples of the golden ratio or the
  Fibonacci sequence appearing in nature, art, or architecture. For
  each claim it makes, try to check it: does the source it implies
  (or that you can find yourself) actually measure the ratio, or is
  the claim repeated from other popular sources without a
  measurement behind it? Sort the AI's list into "well-documented"
  and "overstated or unverifiable," the same way this section
  sorted sunflowers from the Parthenon and the nautilus.
]

== A Few More Identities (For the Fast Finishers)

#only-theory[
  The rest of this chapter is a short collection of genuinely pretty
  identities. All of them can be proved by induction, using exactly
  the technique from the Proofs chapter — pick whichever ones you
  have time for.
]

#ex(
  difficulty: 2,
  time: "15 min",
  hints: (
    [Base case $n = 1$ is one line. For the inductive step, add
      $F_(n+1)$ to both sides of the assumed formula for
      $F_1 + dots.c + F_n$ and simplify the right-hand side.],
  ),
)[
  Prove by induction, for all $n >= 1$:
  $ F_1 + F_2 + dots.c + F_n = F_(n+2) - 1. $
][
  *Base:* $n = 1$: $F_1 = 1$ and $F_3 - 1 = 2 - 1 = 1$. ✓ \
  *Step:* assume $F_1 + dots.c + F_n = F_(n+2) - 1$. Adding
  $F_(n+1)$ to both sides,
  $
    F_1 + dots.c + F_n + F_(n+1) = F_(n+2) + F_(n+1) - 1
    = F_(n+3) - 1,
  $
  using the Fibonacci recursion in the last step — exactly the
  formula with $n + 1$ in place of $n$.
]

#ex(
  level: "all",
  difficulty: 3,
  time: "20 min",
  hints: (
    [Base case: check $n = 1$ and $n = 2$ directly.],
    [For the step, split $F_1^2 + dots.c + F_n^2 + F_(n+1)^2$ into
      the assumed formula plus the new term, then factor out
      $F_(n+1)$ from what remains.],
  ),
)[
  Prove by induction, for all $n >= 1$:
  $ F_1^2 + F_2^2 + dots.c + F_n^2 = F_n dot F_(n+1). $
  (This is exactly the total area of the squares in the golden-
  rectangle diagram earlier in the chapter — the whole rectangle
  built from squares of side $F_1, dots, F_n$ has side lengths $F_n$
  and $F_(n+1)$.)
][
  *Base:* $n = 1$: $F_1^2 = 1$ and $F_1 dot F_2 = 1$. ✓ \
  *Step:* assume $F_1^2 + dots.c + F_n^2 = F_n dot F_(n+1)$. Adding
  $F_(n+1)^2$ to both sides,
  $
    F_1^2 + dots.c + F_n^2 + F_(n+1)^2
    = F_n dot F_(n+1) + F_(n+1)^2
    = F_(n+1) dot (F_n + F_(n+1)) = F_(n+1) dot F_(n+2),
  $
  which is the formula with $n + 1$ in place of $n$.
]

#ex(
  difficulty: 3,
  time: "25 min",
  hints: (
    [Base cases $n = 1$ and $n = 2$ first — check the formula gives
      $(-1)^1$ and $(-1)^2$ correctly, being careful with signs.],
    [Write $F_n dot F_(n+2) - F_(n+1)^2$ in terms of the inductive
      hypothesis $F_(n-1) dot F_(n+1) - F_n^2 = (-1)^n$, using
      $F_(n+2) = F_(n+1) + F_n$ to expand the new term.],
  ),
)[
  (Cassini's identity.) Prove by induction, for all $n >= 2$:
  $ F_(n-1) dot F_(n+1) - F_n^2 = (-1)^n. $
][
  *Base:* $n = 2$: $F_1 dot F_3 - F_2^2 = 1 dot 2 - 1 = 1 = (-1)^2$.
  ✓ \
  *Step:* assume $F_(n-1) dot F_(n+1) - F_n^2 = (-1)^n$. Expand both
  $F_(n+2) = F_(n+1) + F_n$ and $F_(n+1) = F_n + F_(n-1)$:
  $
    F_n dot F_(n+2) - F_(n+1)^2
    & = F_n dot (F_(n+1) + F_n) - F_(n+1) dot (F_n + F_(n-1)) \
    & = F_n dot F_(n+1) + F_n^2 - F_(n+1) dot F_n
    - F_(n+1) dot F_(n-1) \
    & = F_n^2 - F_(n-1) dot F_(n+1) \
    & = -(F_(n-1) dot F_(n+1) - F_n^2) = -(-1)^n = (-1)^(n+1),
  $
  which is the formula with $n + 1$ in place of $n$. (The
  $F_n dot F_(n+1)$ terms on line two cancel exactly.)
]

#ex(
  difficulty: 3,
  time: "20 min",
  hints: (
    [Base case: check $n = 1$, using $F_0 = 0$ and $F_1 = 1$.],
    [For the step, multiply the assumed formula by $phi$ and use
      $phi^2 = phi + 1$ to reorganize the result into the shape
      $F_(n+1) dot phi + F_n$.],
  ),
)[
  Prove by induction, for all $n >= 1$ (with the convention
  $F_0 = 0$):
  $ phi^n = F_n dot phi + F_(n-1). $
][
  *Base:* $n = 1$: $phi^1 = phi = 1 dot phi + 0 = F_1 dot phi + F_0$.
  ✓ \
  *Step:* assume $phi^n = F_n dot phi + F_(n-1)$. Multiplying both
  sides by $phi$ and using $phi^2 = phi + 1$,
  $
    phi^(n+1) = F_n dot phi^2 + F_(n-1) dot phi
    = F_n dot (phi + 1) + F_(n-1) dot phi
    = (F_n + F_(n-1)) dot phi + F_n = F_(n+1) dot phi + F_n,
  $
  which is the formula with $n + 1$ in place of $n$. (A quiet bonus:
  setting $n$ large here and dividing by $phi^n$ recovers the ratio
  convergence from the exploration above, since
  $F_(n-1)\/F_n -> 1\/phi$.)
]

#print-hints()

#print-vocab()
