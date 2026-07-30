#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Tree Diagrams")
#let ex = exercise.with(chapter: "Tree Diagrams")

// ── LOCAL FIGURE HELPER ──────────────────────────────────────
// Two-stage probability tree, drawn natively. Same reasoning as
// venn2() in ch-prob-rules: the branch probabilities stay typeset, so
// an example can be re-numbered without re-exporting a PNG — which
// matters more here than anywhere, because the whole chapter is
// trees and there are seven of them.
//
// PROMOTE TO preamble.typ ALONGSIDE venn2(). If you do, delete this
// block; nothing else in the chapter changes.
//
// FALLBACK: your LaTeX img/ folder already has ProbTree1 and
// ProbTree2, which cover the Samuel and urn examples. If the native
// version needs more tuning than you want to spend, those two can be
// dropped in for the worked examples and the remaining trees left for
// students to draw.
//
// NEEDS A VISUAL CHECK — I cannot render Typst. The knobs, in the
// order you are most likely to want them:
//   row         vertical spacing between leaves
//   size        total width; x-root/x-mid/x-leaf are fractions of it
//   node-w      width of the label box at each node (also sets where
//               the connecting lines stop, so labels never touch)
//   lab-w       width of the white patch behind each probability;
//               widen it if a long fraction gets clipped, narrow it
//               if adjacent patches touch
//
// DATA FORMAT — stages is a list of first-stage branches:
//   (label, probability, ((leaf-label, probability), ...))
// Note the trailing commas: Typst needs them for one-element tuples.
#let prob-tree(
  root: [],
  stages: (),
  size: 11cm,
  row: 1.1cm,
  leaf-width: 3.6cm,
) = {
  let w = size
  let x-root = w * 0.02
  let x-mid = w * 0.36
  let x-leaf = w * 0.70
  let node-w = w * 0.15
  let lab-w = w * 0.14

  // One row per leaf; a first-stage node sits level with the middle
  // of the block of leaves that hangs off it.
  let n-leaves = stages.map(s => s.at(2).len()).sum()
  let height = row * n-leaves
  let leaf-ys = ()
  let mid-ys = ()
  let seen = 0
  for s in stages {
    let k = s.at(2).len()
    for j in range(k) {
      leaf-ys.push(row * (seen + j + 0.5))
    }
    mid-ys.push(row * (seen + (k - 1) / 2 + 0.5))
    seen = seen + k
  }
  let root-y = height / 2

  // A segment between two absolute points. Placed at the top-left
  // corner of its bounding box so no line coordinate is ever
  // negative — negative coordinates render, but this is one less
  // thing to be wrong about.
  let seg(ax, ay, bx, by) = {
    let ox = calc.min(ax, bx)
    let oy = calc.min(ay, by)
    place(
      top + left,
      dx: ox,
      dy: oy,
      line(
        start: (ax - ox, ay - oy),
        end: (bx - ox, by - oy),
        stroke: 0.7pt + luma(110),
      ),
    )
  }
  let centered(x, y, cw, body) = place(
    top + left,
    dx: x - cw / 2,
    dy: y - 0.55em,
    box(width: cw, align(center, body)),
  )
  // Branch probabilities sit ON the midpoint of their branch, on a
  // white patch that masks the line behind them. Nudging them above
  // the line instead does not survive a steep branch: the label is
  // wider than the branch's horizontal run, so the line crosses it at
  // both ends whatever vertical offset is chosen.
  let on-line(x, y, body) = place(
    top + left,
    dx: x - lab-w / 2,
    dy: y - 0.55em,
    box(width: lab-w, align(center, box(
      fill: white,
      inset: (x: 2.5pt, y: 1pt),
      text(size: 8.5pt, body),
    ))),
  )

  align(center, block(
    width: x-leaf - node-w / 2 + leaf-width,
    height: height,
    inset: 0pt,
    {
      centered(x-root + node-w / 2, root-y, node-w, root)
      let leaf = 0
      for (si, s) in stages.enumerate() {
        let my = mid-ys.at(si)
        let ax = x-root + node-w
        let bx = x-mid - node-w / 2
        seg(ax, root-y, bx, my)
        on-line((ax + bx) / 2, (root-y + my) / 2, s.at(1))
        centered(x-mid, my, node-w, s.at(0))
        for c in s.at(2) {
          let ly = leaf-ys.at(leaf)
          let cx = x-mid + node-w / 2
          let dx2 = x-leaf - node-w / 2
          seg(cx, my, dx2, ly)
          on-line((cx + dx2) / 2, (my + ly) / 2, c.at(1))
          place(
            top + left,
            dx: dx2,
            dy: ly - 0.55em,
            box(width: leaf-width, align(left, c.at(0))),
          )
          leaf = leaf + 1
        }
      }
    },
  ))
}

= Tree Diagrams

#only-theory[
  Almost every problem worth solving has more than one stage. Draw a
  card, then another. Test a patient, then act on the result. Take a
  shot, then take a second.

  The last two chapters supply everything needed to handle such
  problems — the multiplication rule for the stages, the addition rule
  for the alternatives — but applying them to a five-branch problem
  from a standing start is bookkeeping, and bookkeeping is where
  mistakes live. The tree diagram is the bookkeeping, done once and
  drawn.
]

#objectives(
  [draw a tree diagram for a two- or three-stage experiment and label
    every branch],
  bfkm[multiply along a path and add across paths, and say which rule
    from the last two chapters each of those is],
  [set up trees for experiments with and without replacement, and
    explain why the second stage differs between them],
  [use the complement on a tree to answer "at least one" questions],
  [answer a question about the *first* stage given information about
    the second],
  obj(level: "high")[state the law of total probability and point to
    where it appears in a tree],
)

== Reading a Tree

#only-theory[
  A tree is drawn from left to right, one column of branches per
  stage. Every branch carries the probability of taking it, *given
  everything that has already happened on the way to it*. Each
  complete left-to-right route is a
  #vocab("path", "Pfad"), and each path ends at one outcome of the
  whole experiment.
]

#example(title: "Two shots at a target")[
  Samuel hits the bullseye with probability $0.8$, and his shots do
  not affect one another. He takes two shots. Writing $B$ for a hit
  and $overline(B)$ for a miss:

  #prob-tree(
    root: [*Shot 1*],
    stages: (
      ([$B$], [$0.8$], (([$B$], [$0.8$]), ([$overline(B)$], [$0.2$]))),
      (
        [$overline(B)$],
        [$0.2$],
        (([$B$], [$0.8$]), ([$overline(B)$], [$0.2$])),
      ),
    ),
  )

  There are four paths, and they correspond exactly to the four
  outcomes of the experiment:
  $ (B, B), quad (B, overline(B)), quad (overline(B), B), quad
    (overline(B), overline(B)). $
]

#keybox(title: "The two path rules")[
  / Multiply along a path: The probability of one complete path is
    the product of the probabilities on its branches. In German this
    is the #vocab("path multiplication rule",
    "Pfadmultiplikationsregel", show-de: false).

  / Add across paths: The probability of an event is the sum of the
    probabilities of all paths that produce it. This is the
    #vocab("path addition rule", "Pfadadditionsregel", show-de: false).
]

#only-theory[
  Neither rule is new. Multiplying along a path is the general
  multiplication rule
  $p(A sect B) = p(A) dot p(B|A)$ applied one branch at a time —
  which is exactly why every branch probability is a *conditional*
  one, conditioned on the path so far. Adding across paths is the
  addition rule, made easy by the fact that different paths are
  mutually exclusive: an experiment travels down one path and no
  other, so there is never an intersection to subtract.

  The tree is not a new theory. It is a filing system for two rules
  you already have.
]

#example(title: "Samuel, continued")[
  Reading the tree above:
  $ p("two hits") = 0.8 dot 0.8 = 0.64. $
  Exactly one hit happens along two different paths, so multiply
  along each and add:
  $ p("exactly one hit") = 0.8 dot 0.2 + 0.2 dot 0.8 = 0.32. $
  For at least one hit, the complement is a single path:
  $ p("at least one hit") = 1 - 0.2 dot 0.2 = 0.96. $
]

#remark[
  Two checks, both worth doing every time.

  The probabilities on the branches leaving any one node must add to
  $1$ — something has to happen next. And the probabilities of *all
  the complete paths* must add to $1$, for the same reason one level
  up. In the tree above, $0.64 + 0.16 + 0.16 + 0.04 = 1$.
]

== With and Without Replacement

#only-theory[
  Samuel's second column of branches repeated his first, because
  nothing about the first shot changed the second. That is the
  with-replacement case, and it is the easy one: the branch
  probabilities at every stage are the same, and multiplying along a
  path is the product rule for independent events.

  Take a ball out of an urn and do not put it back, and the urn is a
  different urn for the second draw. The second column of branches
  changes — and it changes *differently depending on which branch you
  arrived on*. This is the case the tree earns its keep on.
]

#example(title: "An urn without replacement")[
  An urn holds $5$ green and $6$ red balls. Two are drawn one after
  the other, without replacement.

  #prob-tree(
    root: [*Draw 1*],
    stages: (
      (
        [red],
        [$6/11$],
        (([red], [$5/10$]), ([green], [$5/10$])),
      ),
      (
        [green],
        [$5/11$],
        (([red], [$6/10$]), ([green], [$4/10$])),
      ),
    ),
  )

  Ten balls remain at the second draw whichever branch was taken, but
  their composition differs: a red first draw leaves $5$ red and $5$
  green, a green first draw leaves $6$ red and $4$ green. Compare the
  two "red" branches in the second column — $5/10$ against $6/10$ —
  and the dependence is visible on the page.

  For at least one green, use the complement, which is again a single
  path:
  $ p("at least one green") = 1 - 6/11 dot 5/10
    = 1 - 3/11 = 8/11. $
]

#warning[
  The most common error in a without-replacement tree is to copy the
  first column of branches into the second. If any two branches in the
  second column carry the same probability when the first draw was not
  replaced, check them: usually one of them is wrong.

  A quick test: the denominators in the second column should all have
  gone down by one.
]

#ex(difficulty: 2, time: "12 min")[
  A packet of seeds contains $40%$ red seeds and $60%$ yellow seeds. A
  red seed germinates with probability $0.9$; a yellow seed with
  probability $0.8$. One seed is chosen at random from the packet.
  #auto-parts(
    1,
    [Draw the tree.],
    [Find the probability that the seed is red and germinates.],
    [Find the probability that the seed germinates.],
    [Given that the seed germinated, find the probability that it was
      red.],
  )
][
  #auto-parts(
    1,
    [Two stages: color first, then whether it grows.

      #prob-tree(
        root: [*Seed*],
        stages: (
          (
            [red],
            [$0.4$],
            (([grows], [$0.9$]), ([does not], [$0.1$])),
          ),
          (
            [yellow],
            [$0.6$],
            (([grows], [$0.8$]), ([does not], [$0.2$])),
          ),
        ),
      )],
    [One path: $0.4 dot 0.9 = 0.36$.],
    [Two paths lead to germination, so add them:
      $ 0.4 dot 0.9 + 0.6 dot 0.8 = 0.36 + 0.48 = 0.84. $],
    [This asks about the *first* stage given the second, so use the
      definition of conditional probability with the two numbers
      already computed:
      $ p("red" | "grows") = p("red and grows")/p("grows")
        = 0.36/0.84 = 3/7 approx 0.43. $
      Notice it is below the $0.4$ we started with — germinating is
      slightly more likely for yellow seeds simply because there are
      more of them.],
  )
]

== Working Backwards Through a Tree

#only-theory[
  Part 4 of that exercise is the move worth naming. A tree runs
  forwards in time: the first column is what happens first. But
  questions frequently run backwards — the seed germinated, what color
  was it; the test was positive, is the patient ill; the component is
  faulty, which machine made it.

  There is no need for a new rule, and no need to redraw anything
  right to left. The recipe is always the same.
]

#keybox(title: "Answering a backwards question")[
  + Find every path that matches what you were told, and add their
    probabilities. This is the denominator.
  + Among those, find the paths that also match what you were asked
    about, and add them. This is the numerator.
  + Divide.

  Step 1 is the #vocab("law of total probability",
  "Satz von der totalen Wahrscheinlichkeit", show-de: false): the
  probability of a second-stage event is the sum over all the ways of
  getting to it.
]

#example(title: "The medical test, as a tree")[
  The last chapter built a table for an infection carried by $0.2%$ of
  the population, tested with sensitivity $99.9%$ and specificity
  $99.5%$. Here is the same calculation as a tree.

  #prob-tree(
    root: [*Person*],
    stages: (
      (
        [infected],
        [$0.002$],
        (
          ([positive #h(4pt) $0.001998$], [$0.999$]),
          ([negative], [$0.001$]),
        ),
      ),
      (
        [healthy],
        [$0.998$],
        (
          ([positive #h(4pt) $0.004990$], [$0.005$]),
          ([negative], [$0.995$]),
        ),
      ),
    ),
    leaf-width: 4.6cm,
  )

  Two paths end in a positive result, so
  $ p("positive") = 0.001998 + 0.004990 = 0.006988, $
  and of those, one path also has the person infected:
  $ p("infected" | "positive") = 0.001998/0.006988 approx 0.286, $
  which is what the table gave.

  The advantage of the tree is now visible: the base rate lives on the
  first pair of branches and nowhere else. Change $0.002$ to something
  else and only two numbers move, while a table has to be rebuilt from
  scratch.
]

#ex(difficulty: 2, time: "15 min")[
  A screening test has sensitivity $95%$ and specificity $90%$, and is
  used for a condition carried by $1$ person in $500$.
  #auto-parts(
    1,
    [Draw the tree and find the probability that a randomly chosen
      person tests positive.],
    [Find the probability that someone who tests positive really has
      the condition.],
    [Now suppose the same test is used in a clinic where $1$ patient
      in $5$ has the condition. Redo part 2. Which numbers on your
      tree changed?],
  )
][
  #auto-parts(
    1,
    [With $p("condition") = 1/500 = 0.002$:

      #prob-tree(
        root: [*Person*],
        stages: (
          (
            [condition],
            [$0.002$],
            (([positive], [$0.95$]), ([negative], [$0.05$])),
          ),
          (
            [no condition],
            [$0.998$],
            (([positive], [$0.10$]), ([negative], [$0.90$])),
          ),
        ),
      )

      Adding the two positive paths,
      $ p("positive") = 0.002 dot 0.95 + 0.998 dot 0.10
        = 0.0019 + 0.0998 = 0.1017. $],
    [$ p("condition" | "positive") = 0.0019/0.1017 approx 0.0187, $
      under $2%$. Almost every positive result is a false one.],
    [Only the first pair of branches: $0.2$ and $0.8$ in place of
      $0.002$ and $0.998$. Then
      $ p("positive") = 0.2 dot 0.95 + 0.8 dot 0.10 = 0.19 + 0.08
        = 0.27, $
      and
      $ p("condition" | "positive") = 0.19/0.27 approx 0.704. $
      The test did not change at all. The same positive result now
      means a $70%$ chance instead of a $2%$ one, purely because of
      who is being tested.],
  )
]

#ex(difficulty: 2, time: "12 min")[
  An urn holds six red balls and two blue ones. A ball is drawn, its
  color noted, and returned; then a second ball is drawn.
  #auto-parts(
    1,
    [What is the probability that at least one ball is red?],
    [Given that at least one is red, what is the probability that the
      second one is red?],
    [Given that at least one is red, what is the probability that the
      second one is blue?],
  )
][
  With replacement, so both stages have $p("red") = 6/8 = 3/4$ and
  $p("blue") = 1/4$, and the four paths have probabilities $9/16$,
  $3/16$, $3/16$ and $1/16$.
  #auto-parts(
    1,
    [The complement is the single path (blue, blue):
      $ 1 - 1/4 dot 1/4 = 1 - 1/16 = 15/16. $],
    ["At least one red" holds on three of the four paths, totalling
      $15/16$ — that is the denominator. Of those three, the second
      ball is red on (red, red) and (blue, red), totalling
      $9/16 + 3/16 = 12/16$:
      $ (12 slash 16)/(15 slash 16) = 12/15 = 4/5. $],
    [The only remaining path is (red, blue), with probability $3/16$:
      $ (3 slash 16)/(15 slash 16) = 3/15 = 1/5. $
      As a check, $4/5 + 1/5 = 1$ — given the condition, the second
      ball is red or blue and nothing else.

      It is worth noticing that $4/5$ is *not* $3/4$. The draws are
      independent, but the *condition* mentions both of them, and
      that is enough to change what the second ball is likely to be.],
  )
]

#ex(difficulty: 3, time: "15 min", hints: (
  "The first stage has three branches, not two, and they are equally likely.",
  "The three second stages are different experiments: one coin, two coins, three coins. Work out p(no head) separately for each.",
  "Part 2 runs backwards through the tree. Write down the denominator first.",
))[
  A bag contains three balls labelled $1$, $2$ and $3$. Bill draws one
  ball at random and then tosses that many fair coins.
  #auto-parts(
    1,
    [Calculate the probability that he obtains no head at all.],
    [Given that he obtained no head, find the probability that he
      tossed two coins.],
  )
][
  The first stage has three equally likely branches. Along each, the
  probability of no head is $(1 slash 2)^n$ for $n$ coins.
  #auto-parts(
    1,
    [Three paths lead to "no head", so add them:
      $ 1/3 dot 1/2 + 1/3 dot 1/4 + 1/3 dot 1/8
        = 1/3 dot (1/2 + 1/4 + 1/8) = 1/3 dot 7/8 = 7/24. $],
    [The denominator is the $7/24$ just found. The numerator is the
      single path through ball $2$:
      $ 1/3 dot 1/4 = 1/12. $
      So
      $ p("two coins" | "no head") = (1 slash 12)/(7 slash 24)
        = 24/(12 dot 7) = 2/7. $
      Before the coins were tossed, ball $2$ had probability $1/3$.
      Learning that no head appeared makes it slightly *less* likely —
      fewer coins would have made "no head" easier, so the evidence
      points a little towards ball $1$.],
  )
]

#ex(difficulty: 3, time: "12 min")[
  A bag contains $10$ red balls, $10$ green balls and $6$ white balls.
  Two balls are drawn at random without replacement. What is the
  probability that they are of different colors?
][
  There are three ways for the colors to *match* and six ways for them
  to differ, so the complement is much less work. The first draw is
  from $26$ balls and the second from $25$:
  $ p("same color") = 10/26 dot 9/25 + 10/26 dot 9/25
    + 6/26 dot 5/25. $
  Over the common denominator $26 dot 25 = 650$,
  $ p("same color") = (90 + 90 + 30)/650 = 210/650 = 21/65, $
  and therefore
  $ p("different colors") = 1 - 21/65 = 44/65 approx 0.677. $

  Drawing the whole tree here would mean nine paths. Recognizing that
  only three of them matter, and that they are the complement of what
  was asked, replaces the drawing entirely — which is the point at
  which a tree stops being a tool and starts being homework.
  #heuristic("work backwards from the goal")
]

#ex(difficulty: 3, time: "15 min")[
  Blood types come in four kinds: O, A, B and AB. Their distribution
  differs between populations:

  #data-table(
    columns: (auto, auto, auto, auto, auto),
    row-height: auto,
    [], [O], [A], [B], [AB],
    [United States], [$0.43$], [$0.41$], [$0.12$], [?],
    [China], [$0.36$], [$0.27$], [$0.26$], [$0.11$],
    [Russia], [$0.39$], [$0.34$], [?], [$0.09$],
  )

  #auto-parts(
    1,
    [Find the two missing probabilities.],
    [Dirk lives in the United States and has type B blood, so he can
      receive blood only from donors of type O or type B. What is the
      probability that a randomly chosen US citizen can donate to
      him?],
    [One American, one Chinese person and one Russian are chosen
      independently. What is the probability that all three have type
      O?],
    [What is the probability that all three have the *same* blood
      type?],
  )
][
  #auto-parts(
    1,
    [Each row must add to $1$, since everybody has exactly one blood
      type:
      $ "US: " 1 - 0.43 - 0.41 - 0.12 = 0.04, quad
        "Russia: " 1 - 0.39 - 0.34 - 0.09 = 0.18. $],
    [Types O and B are mutually exclusive, so add:
      $0.43 + 0.12 = 0.55$.],
    [The three choices are independent, so multiply:
      $ 0.43 dot 0.36 dot 0.39 approx 0.060. $],
    [Four mutually exclusive ways for the types to agree, so compute
      each and add:
      $ 0.43 dot 0.36 dot 0.39 &approx 0.060372 \
        0.41 dot 0.27 dot 0.34 &approx 0.037638 \
        0.12 dot 0.26 dot 0.18 &approx 0.005616 \
        0.04 dot 0.11 dot 0.09 &approx 0.000396 $
      giving a total of about $0.104$. Multiply within a case, add
      across cases — the path rules again, on a tree with four
      first-stage branches that nobody needs to draw.],
  )
]

#only-high[
  #ex(difficulty: 3, level: "high", time: "15 min")[
    A factory has two machines. Machine A produces $60%$ of the output
    and $2%$ of its components are defective; machine B produces the
    other $40%$ with a $5%$ defect rate.
    #auto-parts(
      1,
      [What proportion of the factory's output is defective?],
      [A defective component is found. What is the probability that
        machine A made it?],
      [Machine A makes three times as many components as B, but the
        answer to part 2 is well below $3 slash 4$. Explain in a
        sentence why.],
      [Write your calculation in part 1 as a general formula for two
        first-stage branches, and say what it is called.],
    )
  ][
    #auto-parts(
      1,
      [Add the two paths that end in a defective component:
        $ p(D) = 0.6 dot 0.02 + 0.4 dot 0.05 = 0.012 + 0.020
          = 0.032, $
        so $3.2%$ of output is defective.],
      [$ p(A|D) = 0.012/0.032 = 3/8 = 0.375. $],
      [Machine A makes $60%$ of the output — a ratio of $3 : 2$, not
        $3 : 1$ — and its components are two and a half times less
        likely to be faulty, so among the *defective* ones it is
        outnumbered. Being the bigger producer is outweighed by being
        the better one.],
      [With $A$ and $B$ partitioning the first stage,
        $ p(D) = p(A) dot p(D|A) + p(B) dot p(D|B). $
        This is the *law of total probability*: to find the
        probability of a second-stage event, condition on each
        first-stage branch in turn, weight by how likely that branch
        is, and add. It is the denominator in every backwards question
        in this chapter, and it is exactly what "add across paths"
        means when written in symbols.],
    )
  ]
]

#ai-box(role: "Tutor")[
  Pick one of the without-replacement exercises above that you have
  already solved, and describe the situation to an AI assistant in
  words — but ask it *not* to give you the answer. Ask it instead to
  walk you through drawing the tree one stage at a time, checking your
  branch labels as you go.

  Two things to watch for, because they are where these problems go
  wrong and where an assistant is most likely to agree with you when
  it should not:

  #auto-parts(
    1,
    [Do the branches leaving each node add to $1$?],
    [In the second column, has every denominator gone down by one?],
  )

  If it hands you the final number despite being asked not to, that is
  worth noticing too. A tool that will not let you struggle is not
  helping you learn to do this without it.
]

#look-ahead(preview: [counting])[
  Trees have a limit, and it is not conceptual but physical. Three
  coin tosses give a tree with $8$ paths, which is fine. Ten tosses
  give $#num(1024)$, and asking for the probability of exactly six
  heads means finding every path with six heads on it and adding them
  up.

  Each such path has the same probability, so the sum is really a
  multiplication — and all that is missing is a way to count the paths
  without drawing them. That is the next chapter, and it is the last
  piece of machinery this unit needs.
]

#print-hints()
#print-vocab()
