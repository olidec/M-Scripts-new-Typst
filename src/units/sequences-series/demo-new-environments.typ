// ============================================================
//  demo-new-environments.typ — smoke test for the 2026 additions
//  Compile standalone:  typst compile demo-new-environments.typ
//  Everything here also works inside a normal chapter file and
//  behaves correctly in both levels and in exercise-sheet mode.
// ============================================================
#import "../../common/preamble.typ": *

#show: chapter-template.with(title: "New environments — demo")
#let ex = exercise.with(chapter: "Demo")

= The abstraction ladder

#only-theory[
  The same ladder appears whenever a situation is formalized. Naming the
  levels makes "translating into math" a practiced move instead of magic —
  and gives students a place to say _where_ they got stuck.
]

#abstraction-ladder(
  l0: [A ball is dropped from a height of 2 m. Each bounce reaches 70% of
       the previous height.],
  l1: [Bounce heights (m): #h(0.4em) 2, #h(0.3em) 1.4, #h(0.3em) 0.98,
       #h(0.3em) 0.686, ...],
  l2: [Each height is the previous one multiplied by 0.7:
       #h(0.4em) $a_(n+1) = 0.7 dot a_n$.],
  l3: [$a_n = 2 dot 0.7^(n-1)$ — geometric with $a_1 = 2$, $q = 0.7$.],
)

= Toolbox and heuristic badges

#toolbox()

In worked solutions, name the move as it is used: here we used
#heuristic("try small cases") before conjecturing a formula, and
#heuristic("draw a picture") to see why the areas halve.

= AI task

#ai-box(role: "Checker")[
  Solve Exercise 2 below on paper first. Then ask an AI of your choice to
  solve it, and compare line by line. If the answers differ, decide who is
  wrong — and prove it with a check (e.g. compute the first two perimeters
  by hand and compare with the partial sum).
]

= Exploration

#exploration(title: "Nested squares")[
  #nested-squares(side: 3.2cm, levels: 5)
  Joining the midpoints of a square produces a new square. What fraction of
  the area survives each step? If the construction is repeated forever, what
  is the total area of all the squares together? Experiment, conjecture,
  then justify.
]

= Exercises: difficulty dots, effort note, staged hints

#ex(difficulty: 1)[
  A geometric sequence has $a_1 = 2$ and $q = 0.7$. Compute $a_5$.
][
  $a_5 = 2 dot 0.7^4 = 0.4802$.
]

#ex(
  difficulty: 3,
  time: "20 min",
  hints: (
    [Compare the side length of one square with the side length of the
     next one — #heuristic("draw a picture").],
    [The perimeters form a geometric series. What is $q$, and why does
     the series converge?],
  ),
)[
  In the nested-squares figure above, the outer square has side length 1
  and the construction is continued forever. Determine the total perimeter
  of all squares combined.
][
  Consecutive side lengths scale by $sqrt(2)\/2$, so the perimeters form a
  geometric series with first term $4$ and $q = sqrt(2)\/2 < 1$:
  $ P = 4/(1 - sqrt(2)\/2) = 8/(2 - sqrt(2)) = 4 dot (2 + sqrt(2))
      = 8 + 4 sqrt(2) approx 13.66. $
  We used #heuristic("look for what stays the same"): the scaling factor
  between consecutive squares.
]

// Hints first, then solutions — students hit the hints page before the
// answers page.
#print-hints()
