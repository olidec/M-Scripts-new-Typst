// ============================================================
//  oral-exam-questions.typ — Oral exam question bank
//  Complex Numbers (SLS) — Introduction through Polar Form
//
//  Assumed location: src/units/complex-sls/, alongside ch-intro.typ
//  etc. (adjust the import path below if you file it elsewhere).
//
//  ONE source, TWO printable documents, controlled by --input:
//    Student handout (hook + working space):
//      typst compile oral-exam-questions.typ oral-exam-student.pdf
//    Teacher master (hook + follow-up prompts):
//      typst compile oral-exam-questions.typ oral-exam-teacher.pdf \
//        --input teacher=true
//
//  DESIGN NOTE — how the 20 questions became 10 exams:
//  Each of the five chapters (Introduction, Arithmetic, Equations,
//  Gaussian Plane, Polar Form) contributes exactly 4 hooks, covering
//  4 distinct core ideas from that chapter. The 10 exams are the 10
//  unordered PAIRS of the 5 chapters (5 choose 2 = 10), and each
//  chapter's 4 hooks are distributed one-per-pairing across the 4
//  exams that chapter appears in. Net effect: every exam draws its
//  two questions from two different chapters, every hook is used
//  exactly once, and every chapter is examined in exactly 4 of the
//  10 exams. Swap entries in `exams` below if you'd rather pair
//  differently — `bank` and `exams` are independent.
// ============================================================

#import "../../common/preamble.typ": *

#let teacher = sys.inputs.at("teacher", default: "false") == "true"

#set page(
  ..chapter-page-setup,
  header: context {
    set text(size: 9pt, fill: luma(120))
    grid(
      columns: (1fr, 1fr),
      align(left)[Complex Numbers -- Oral Exam Questions],
      align(right)[#if teacher [Teacher Copy] else [Student Copy]],
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

// ── Question bank ───────────────────────────────────────────
// One entry per hook: a title, the hook itself (what the student
// sees), and a bank of follow-ups (teacher only). Follow-ups are
// a guide, not a script -- pick the ones the conversation calls for.
// Items marked (stretch) are extensions for a student who is flying
// through the core ones; skip them freely.

#let Q(title, hook, followups) = (
  title: title,
  hook: hook,
  followups: followups,
)

#let bank = (
  intro: (
    Q(
      "The Imaginary Unit",
      [State the defining property of the imaginary unit $i$. Then
        write $sqrt(-9)$ in the form $a + b dot i$.],
      (
        [Why don't we simply define $i = sqrt(-1)$? What goes wrong
          if you assume $sqrt(a) dot sqrt(b) = sqrt(a dot b)$ still
          holds when $a$ and $b$ are negative?],
        [Is every real number also a complex number? How would you
          write $7$ in the form $a + b dot i$?],
        [What does "purely imaginary" mean? Give an example.],
        [In what sense was $i$ "invented"? Were negative numbers or
          $sqrt(2)$ invented in the same sense?],
        [_(stretch)_ Name three ordinary algebra rules you would
          insist keep working once $i$ exists. Why those three?],
      ),
    ),
    Q(
      [Powers of $i$],
      [Simplify $i^(23)$ by hand. Then simplify $i^(-3)$.],
      (
        [What pattern do the powers of $i$ follow, and what is its
          period?],
        [How do you handle a negative exponent -- walk me through
          it without a calculator.],
        [What is $i^0$, and why does that value make sense?],
        [Show that any four *consecutive* powers of $i$ sum to
          zero.],
        [_(stretch)_ The powers of $i$ cycle back to $1$ every four
          steps. What might that suggest about what multiplying by
          $i$ *does* to a number, geometrically? (No right answer
          expected yet -- just a guess.)],
      ),
    ),
    Q(
      "One Equation, Two Real Equations",
      [When are two complex numbers $a + b dot i$ and $c + d dot i$
        equal? Use this to find all real $a, b$ with
        $(a - 2) + (3 b + 1) dot i = 0$.],
      (
        [Why does one complex equation give you *two* real
          equations?],
        [Explain, in your own words, why $z = 0$ exactly when
          $Re(z) = 0$ and $Im(z) = 0$.],
        [What is the first move you make whenever a problem hands
          you an equation in $CC$ and asks for real unknowns?],
        [Where else in this unit have you used this technique?
          Name a chapter or a type of problem.],
        [_(stretch)_ Could a complex number have *two different*
          representations $a + b dot i$? Why does the definition
          rule that out?],
      ),
    ),
    Q(
      "The Fundamental Theorem of Algebra",
      [State the Fundamental Theorem of Algebra. What does it mean
        for $CC$ to be algebraically closed?],
      (
        [How many roots, counted with multiplicity, does a
          degree-$n$ polynomial have over $CC$?],
        [Is that true over $RR$? Give a quick counterexample.],
        [Why does this theorem mean we will never need to invent a
          number system bigger than $CC$?],
        [One thing is lost going from $RR$ to $CC$. What is it, and
          what goes wrong if you try to say $i > 0$ or $i < 0$?],
        [_(stretch)_ Who is credited with the first widely accepted
          proof, and roughly when?],
      ),
    ),
  ),

  arithmetic: (
    Q(
      "Multiplying Complex Numbers",
      [Multiply $(2 + 3 dot i) dot (1 - 4 dot i)$ by hand.],
      (
        [What is the *one* new rule you needed beyond ordinary
          expansion and collecting terms?],
        [Why is it a bad idea to memorize the general formula
          $(a_1 a_2 - b_1 b_2) + (a_1 b_2 + a_2 b_1) dot i$?],
        [How would you compute $z^2$ for $z = a + b dot i$? What
          about $z^3$?],
        [How does adding two complex numbers connect to something
          you already know from vectors?],
        [_(stretch)_ Why does multiplying $(1+i)^(10)$ this way get
          painful fast? What would make high powers easy?],
      ),
    ),
    Q(
      "The Conjugate",
      [Write down the conjugate of $z = 3 - 5 dot i$. Then compute
        $z dot overline(z)$.],
      (
        [Why is $z dot overline(z)$ always a non-negative real
          number? When is it exactly zero?],
        [What is $z + overline(z)$? What is $z - overline(z)$?],
        [For which complex numbers $z$ does $z = overline(z)$
          hold?],
        [Why is $z dot overline(z)$ described as the "algebraic
          engine" of this whole unit -- what does it let you do
          that you couldn't do otherwise?],
        [_(stretch)_ Does conjugation respect addition? That is,
          is $overline(z + w) = overline(z) + overline(w)$? Sketch
          why.],
      ),
    ),
    Q(
      "Dividing Complex Numbers",
      [Compute $1 / (2 - i)$ in Cartesian form.],
      (
        [What is the trick, and why does multiplying top and
          bottom by the conjugate work?],
        [What does the conjugate *do* to the denominator that
          makes this possible?],
        [Is there a shortcut when the denominator is purely
          imaginary, like $i / (-4 - 4 i)$?],
        [What would go wrong if you multiplied the denominator by
          its conjugate but forgot to do the same to the
          numerator?],
        [_(stretch)_ Compute $(3 + 2 dot i) / (7 - i)$. Where do
          sign errors most often creep in?],
      ),
    ),
    Q(
      [Solving $z^2 = w$],
      [Find all $z in CC$ with $z^2 = i$, by writing
        $z = a + b dot i$.],
      (
        [How many solutions do you expect before you start, and
          why?],
        [What relationship do you notice between the two solutions
          you find?],
        [What two real equations do you get after comparing real
          and imaginary parts?],
        [What tool from the introduction are you using here, and
          where did you first meet it?],
        [_(stretch)_ Does conjugation respect multiplication --
          is $overline(z dot w) = overline(z) dot overline(w)$?
          How would you check it?],
      ),
    ),
  ),

  equations: (
    Q(
      [The Quadratic Formula over $CC$],
      [Solve $x^2 - 2 x + 4 = 0$ over $CC$.],
      (
        [What did the old rule "if the discriminant is negative,
          there's no solution" actually mean, precisely?],
        [Why does the quadratic formula keep working once
          $Delta < 0$?],
        [What do you notice about the relationship between your two
          solutions?],
        [Does every quadratic with real coefficients now have a
          solution in $CC$? What about one with *complex*
          coefficients?],
        [_(stretch)_ What theorem, stated later in this unit,
          guarantees the pattern you noticed between the two
          roots?],
      ),
    ),
    Q(
      "Conjugate Roots",
      [State the conjugate-roots theorem. Why does it need the
        coefficients to be real?],
      (
        [Sketch the idea of the proof -- what happens when you
          conjugate both sides of $p(z_0) = 0$?],
        [Give a quick counterexample when the coefficients are
          *not* real. (Hint: think about $(x - i)^2 = 0$.)],
        [Why must every real cubic have at least one real root?],
        [How does this theorem connect to the Fundamental Theorem
          of Algebra?],
        [_(stretch)_ What can you say, by the same kind of parity
          argument, about a real polynomial of degree $5$? Degree
          $4$?],
      ),
    ),
    Q(
      "Reconstructing a Quadratic",
      [One root of a real quadratic equation is $2 + i$. Find the
        equation.],
      (
        [Why must the sum and the product of your two roots come
          out real?],
        [State Vieta's formulas for a monic quadratic in terms of
          its roots.],
        [What is the other root, and how do you know?],
        [Could you run this same idea on a cubic if you knew one
          non-real root? What extra piece of information would you
          need?],
        [_(stretch)_ What if you were told the root was $2 + i$ but
          the leading coefficient was $3$, not $1$ -- how does the
          equation change?],
      ),
    ),
    Q(
      [Equations with $overline(z)$],
      [Outline your strategy for solving $z^2 = i dot overline(z)$
        -- you don't need to finish it, just set it up and describe
        the plan.],
      (
        [Why can't the quadratic formula help here?],
        [Once you compare real and imaginary parts, what kind of
          system do you get, and how would you solve it?],
        [Why doesn't "a degree-$n$ equation has $n$ roots" apply to
          an equation involving $overline(z)$?],
        [What is the general principle you are always falling back
          on for equations like this?],
        [_(stretch)_ If you had time to finish it, how many
          solutions would you guess this equation has? What would
          make you revise that guess?],
      ),
    ),
  ),

  gaussian: (
    Q(
      "Complex Numbers as Points",
      [Plot $z = 3 + 4 dot i$ in the Gaussian plane and compute
        $|z|$.],
      (
        [What real-world idea does the modulus generalize?],
        [How does $|z|$ connect to $z dot overline(z)$ from the
          arithmetic chapter?],
        [Where do the real numbers sit in the plane? Where do the
          purely imaginary numbers sit?],
        [What does $|z_1 - z_2|$ represent, geometrically?],
        [_(stretch)_ Are $z$, $-z$, $overline(z)$ and
          $-overline(z)$ always the same distance from the origin?
          Why?],
      ),
    ),
    Q(
      "Finding the Argument",
      [Find $Arg(-1 - i)$.],
      (
        [Why is $arctan(b / a)$ *not* a formula for the
          argument?],
        [Walk me through your method: what do you compute first,
          and how do you use the quadrant?],
        [What is $Arg(z)$ when $z$ is a positive real number? A
          negative real number?],
        [What interval do we use for the *principal* argument in
          this course?],
        [_(stretch)_ Some books use $[0, 2 pi)$ instead. Would
          $Arg(-1-i)$ come out differently there? By how much?],
      ),
    ),
    Q(
      "Arithmetic as Motion",
      [Describe, geometrically, what conjugation and negation do to
        a point $z$ in the plane.],
      (
        [What does addition of two complex numbers look like as a
          picture?],
        [Why is $|z_1 - z_2|$ the distance between $z_1$ and
          $z_2$?],
        [What shape do the four points $z$, $overline(z)$, $-z$,
          $-overline(z)$ form, in general?],
        [What does multiplying by $i$ do to a point, geometrically?
          How does that connect back to the powers of $i$ from the
          introduction?],
        [_(stretch)_ Subtraction, $z_1 - z_2$, is just addition of
          $z_1$ and $-z_2$. Sketch why that gives you the arrow
          from $z_2$ to $z_1$.],
      ),
    ),
    Q(
      "Loci: Circles and Half-Planes",
      [Describe and sketch
        ${z in CC | |z - (1 + 2 dot i)| = 3}$.],
      (
        [In words, what does $|z - z_0| = r$ describe?],
        [How would the picture change if $=$ became $<=$?],
        [Describe ${z in CC | Re(z) <= 3 "and" Im(z) > 2}$.],
        [If a condition is written $|z + 1 + i| = 1$ instead of
          $|z - z_0| = r$ directly, what do you do first?],
        [_(stretch)_ What does ${z in CC | z = overline(z)}$
          describe? Why?],
      ),
    ),
  ),

  polar: (
    Q(
      "Trigonometric Form",
      [Convert $z = -1 - i$ to trigonometric form.],
      (
        [In terms of $a$ and $b$, what are $r$ and $phi.alt$?],
        [Go the other way: given
          $z = 2 dot (cos((2 pi) / 3) + i sin((2 pi) / 3))$, find
          its Cartesian form.],
        [Why do you need *both* modulus and argument to pin down
          $z$ -- what does each one alone leave undetermined?],
        [What was the very first step you took, before computing
          anything? (Hint: a picture.)],
        [_(stretch)_ What does the trigonometric form become once
          you bring in Euler's formula?],
      ),
    ),
    Q(
      "Multiplication as Rotation and Scaling",
      [What happens, geometrically, when you multiply two complex
        numbers written in polar form?],
      (
        [State the rule for the moduli and the rule for the
          arguments under multiplication.],
        [What is the corresponding rule for division?],
        [What is special, geometrically, about multiplying by $i$?
          How does that connect to the powers of $i$ from the
          introduction?],
        [Why does Euler's formula make the "multiply moduli, add
          arguments" rule almost obvious, without any addition
          formulas?],
        [_(stretch)_ Where does the addition-formula identity for
          $cos(phi.alt_1 + phi.alt_2)$ come from, if you expand the
          product directly in Cartesian form?],
      ),
    ),
    Q(
      "De Moivre's Theorem",
      [Use De Moivre's theorem to compute $(1 + i)^8$.],
      (
        [State De Moivre's theorem in your own words.],
        [Why would computing $(1 + i)^(100)$ by repeated
          multiplication be hopeless, while De Moivre makes it
          easy?],
        [How can De Moivre's theorem be used to derive a
          trigonometric identity, like the formula for
          $cos(2 phi.alt)$?],
        [What is Euler's identity, and why is it often called
          remarkable?],
        [_(stretch)_ Sketch how you would derive the *triple*-angle
          formula for $cos(3 phi.alt)$ using De Moivre with
          $n = 3$.],
      ),
    ),
    Q(
      "Roots of Unity",
      [Find all fourth roots of unity.],
      (
        [In general, how many $n$-th roots does a nonzero complex
          number have?],
        [What shape do the $n$-th roots of a number form, drawn in
          the plane?],
        [Solve $z^3 = -8$.],
        [Why must the non-real roots of unity come in conjugate
          pairs?],
        [_(stretch)_ Why do the $n$-th roots of unity always sum to
          zero? (A one-sentence geometric reason is enough.)],
      ),
    ),
  ),
)

#let chapter-names = (
  intro: "Introduction",
  arithmetic: "Arithmetic",
  equations: "Equations",
  gaussian: "Gaussian Plane",
  polar: "Polar Form",
)

// ── Exam pairings ───────────────────────────────────────────
// The 10 unordered pairs of the 5 chapters, each used once; see the
// design note at the top of the file.
#let exams = (
  ((chapter: "intro", index: 0), (chapter: "arithmetic", index: 0)),
  ((chapter: "intro", index: 1), (chapter: "equations", index: 0)),
  ((chapter: "intro", index: 2), (chapter: "gaussian", index: 0)),
  ((chapter: "arithmetic", index: 1), (chapter: "equations", index: 1)),
  ((chapter: "arithmetic", index: 2), (chapter: "gaussian", index: 1)),
  ((chapter: "intro", index: 3), (chapter: "polar", index: 0)),
  ((chapter: "arithmetic", index: 3), (chapter: "polar", index: 1)),
  ((chapter: "equations", index: 2), (chapter: "gaussian", index: 2)),
  ((chapter: "equations", index: 3), (chapter: "polar", index: 2)),
  ((chapter: "gaussian", index: 3), (chapter: "polar", index: 3)),
)

// ── Rendering ────────────────────────────────────────────────
#let render-question(chapter-key, q) = block(
  width: 100%,
  breakable: true,
  fill: accent-bg,
  radius: 3pt,
  inset: (left: 14pt, right: 12pt, top: 10pt, bottom: 12pt),
  stroke: (left: 3pt + accent),
)[
  #text(size: 9pt, fill: accent, tracking: 1.5pt)[
    #upper(chapter-names.at(chapter-key))
  ]
  #v(2pt)
  #text(weight: "bold", size: 12.5pt)[#q.title]
  #v(6pt)
  #q.hook

  #if teacher [
    #v(10pt)
    #text(style: "italic", size: 9pt, fill: luma(110))[
      Follow-ups -- a guide, not a checklist:
    ]
    #v(4pt)
    #list(..q.followups, marker: text(fill: accent)[▸], spacing: 0.6em)
  ]
]

#let render-exam(n, parts) = {
  if n > 1 { pagebreak(weak: true) }
  block(above: 0pt, below: 12pt)[
    #text(weight: "bold", size: 16pt, fill: accent)[Oral Exam #n]
    #h(1fr)
    #text(size: 10pt, fill: luma(120))[10 -- 15 minutes]
  ]
  line(length: 100%, stroke: 0.6pt + accent)
  v(12pt)
  for (i, part) in parts.enumerate() {
    let q = bank.at(part.chapter).at(part.index)
    text(size: 9.5pt, fill: luma(130), tracking: 0.5pt)[
      QUESTION #(i + 1)
    ]
    v(4pt)
    render-question(part.chapter, q)
    if not teacher {
      v(10pt)
      rect(
        width: 100%,
        height: 6.2cm,
        stroke: 0.6pt + luma(205),
        radius: 2pt,
      )
    }
    if i == 0 { v(16pt) }
  }
}

#apply-base-style[

  #align(center)[
    #text(weight: "bold", size: 18pt)[Complex Numbers]
    #v(2pt)
    #text(size: 13pt, fill: luma(90))[
      Oral Exam Question Bank -- Introduction through Polar Form
    ]
  ]
  #v(0.3em)
  #align(center)[
    #text(size: 10pt, fill: luma(120))[
      #if teacher [Teacher  -- includes follow-up prompts]
      else [Student copy -- one question pair per appointment]
    ]
  ]
  #v(1em)

  #if teacher [
    #block(
      width: 100%,
      fill: luma(248),
      radius: 3pt,
      inset: 10pt,
      stroke: 0.5pt + luma(210),
    )[
      #text(weight: "bold", size: 10.5pt)[How to use this bank]
      #v(0.4em)
      Ten exams, two questions each, 10 -- 15 minutes per student
      (matches the SLS syllabus format). Every exam pairs two
      chapters and every chapter is examined in exactly four of the
      ten exams -- see the design note at the top of the source file
      if you want to re-pair them. Each hook is a starting point,
      not the whole exam: follow the student's answer, branch into
      whichever follow-ups fit, and skip the rest. "Stretch"
      follow-ups are there for a student moving faster than
      expected, not a requirement.
      #colbreak()
    ]
    #v(1.2em)
  ]

  #for (n, parts) in exams.enumerate() {
    render-exam(n + 1, parts)
  }

]
