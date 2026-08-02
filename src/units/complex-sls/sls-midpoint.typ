// ============================================================
//  sls-midpoint.typ — SLS mid-semester interlude
//  Registered in main-high.typ as (none, ".../sls-midpoint"):
//  included in the lecture notes, after Polar Form and before
//  Transformations, and carries no exercises.
//
//  DATES below are offering-specific — update them each year.
// ============================================================

#import "../../common/preamble.typ": *

#set page(
  ..chapter-page-setup,
  header: context {
    set text(size: 9pt, fill: luma(120))
    grid(
      columns: (1fr, 1fr),
      align(left)[Complex Numbers — SLS], align(right)[Self-Learning Semester],
    )
    v(-4pt)
    line(length: 100%, stroke: 0.5pt + accent)
  },
  footer: context {
    set text(size: 9pt, fill: luma(120))
    line(length: 100%, stroke: 0.3pt + luma(180))
    v(-4pt)
    align(center)[#counter(page).display("1")]
  },
)

#apply-base-style[

  = Into the Second Half

  You have worked through the five core chapters -- arithmetic, equations,
  the geometry of the Gaussian plane, and polar and exponential form --
  and sat the oral exam. That is the hard foundation laid, and it is worth
  a moment's acknowledgment: the ideas ahead are, if anything, easier than
  what you have already done, because they rest on it.

  == A Moment to Look Back

  Before pushing on, pause. The most common mistake in the second half of
  a self-learning semester is to treat the oral exam as a finish line and
  let the core fade -- and then meet it again, half-remembered, in the
  written exam. A little consolidation now is worth hours of relearning
  later.

  So spend an hour here, not on new material but on old:
  - Open the *Review* chapter's self-check and work down it honestly.
    Anything you cannot now do *cold* is a gap to close while it is still
    small.
  - Redo two or three exercises from the first five chapters *without*
    looking at the solutions -- particularly any topic that felt shaky in
    the oral exam.
  - Make sure the one central fact of the unit so far is fully yours:
    *multiplication is rotation and scaling.* Everything in the second
    half is built on it.

  This is not lost time. It is the difference between carrying five solid
  chapters into the second half and carrying five shaky ones.

  == What Is New Ahead

  The two remaining chapters are shorter than the ones behind you, but
  they ask for more *geometric* thinking and more *synthesis* -- combining
  tools from across the whole unit rather than applying one at a time.

  *Transformations* takes the fact you just consolidated -- that
  multiplying by a number rotates and scales -- and turns it loose on
  whole curves. A curve becomes a complex-valued function, and translating,
  rotating, and scaling it become single steps of complex arithmetic. This
  connects directly to the parametric curves you meet in calculus.

  *Loci* turns the plane's geometry around once more. Instead of moving a
  known curve, you describe a set of points by a *condition* they satisfy
  -- $|z - z_0| = r$, $arg(z - z_0) = phi.alt$, and the like -- and work
  out what shape the condition carves out. You already met the simplest
  case, the circle; here it becomes a fluent toolkit of lines, rays,
  circles, and regions.

  Take your time with both. They reward it.

  #v(0.5em)
  #block(
    width: 100%,
    fill: accent-bg,
    radius: 3pt,
    inset: (left: 14pt, right: 10pt, top: 10pt, bottom: 10pt),
    stroke: (left: 4pt + accent),
  )[
    #text(weight: "bold", size: 12pt, fill: accent)[
      Written Exam -- The Whole Unit
    ]
    #v(0.5em)

    *Date:* Week 46, approximately 9-13 November 2026; your teacher
    confirms the exact date in week 44.

    *Duration:* 90 minutes.

    *Permitted aids:* your CAS calculator, Standard Formula Booklet.

    *Coverage:* the *entire* unit, Introduction through Loci. About half
    the marks come from the first five chapters and about half from
    Transformations and Loci. The optional *Extra Bits* sections are not
    examined.

    *Format:* a mix of
    - short calculations, some by hand and some with a CAS,
    - problems requiring geometric reasoning and a clear sketch, and
    - one or two longer problems that combine several ideas.

    #v(0.3em)
    #text(style: "italic")[
      The best preparation is the Review chapter's mock exam, done under
      time and without the solutions -- followed by closing whatever gaps
      it exposes.
    ]
  ]

  #v(1.5em)

  == On the Extra Bits

  Most chapters end with an *Extra Bits* section: a result taken a little
  further than the core strictly needs -- a square root of $i$, the sum of
  the roots of unity, a logarithmic spiral. These are genuine mathematics,
  not decoration, and they are there for the pleasure of seeing an idea
  pushed one step past where it had to stop. Read them for that. They will
  not appear on the exam, and skipping one costs you nothing on paper --
  but the curiosity they reward is the same one that makes the rest of the
  subject worth doing.

]
