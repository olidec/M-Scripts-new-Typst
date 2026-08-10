// ============================================================
//  ch-basics.typ — Basics of Sequences and Series
//
//  Lehrplan anchor
//    GLF 3. Klasse, 2.1 Folgen und Reihen
//      - den Begriff der Zahlenfolge erklären
//      - Berechnungen mit arithmetischen und geometrischen
//        Folgen und Reihen durchführen
//      - Grenzwerte von unendlichen geometrischen Reihen berechnen
//    SPF 2. Klasse, 1.1 Folgen und Reihen
//      - Folgen rekursiv und explizit beschreiben
//      - arithmetische und geometrische Folgen und Reihen erkennen
//        und anwenden
//    Neither entry carries a (BfKM) marker, so no objective in this
//    chapter is tagged with bfkm[...] — unlike e.g. the calculus
//    entries, which are marked. Don't add badges here "for symmetry".
//
// ── TEACHER'S NOTE: two errors in the previous version ──────
//  Both corrected below; flagging them so the old notes can be
//  fixed too.
//
//  * The look-and-say exercise gave the next term after 111221 as
//    13112221. That is the term after next. Reading 111221 aloud
//    gives "three 1s, two 2s, one 1" = 312211; reading THAT aloud
//    gives 13112221. Answer corrected to 312211.
//
//  * The text claimed the sequence a_n = 1/n has "no recursive
//    formula". It does: a_(n+1) = a_n / (1 + a_n) reproduces
//    1, 1/2, 1/3, 1/4, ... exactly. The claim is replaced by the
//    honest version (a recursion exists, but is harder to find and
//    harder to use than the explicit formula), which is also the
//    more useful lesson. Same softening applied to the alternating-
//    fraction exercise, which carried "no recursion".
//
// ── SMALLER CHANGES ─────────────────────────────────────────
//  * Exercises are now interleaved with the theory they test
//    instead of being banked at the end, and each block opens with
//    a 1-dot problem (STYLE_GUIDE §4).
//  * parts() with hand-typed (a)/(b)/... replaced by auto-parts().
//    Question and solution calls are 1:1 in every exercise here.
//  * The "is a continuation ever correct?" discussion was gated
//    only-high in full. The idea is now shared — GLF meets exactly
//    the same trick in IQ-test form — and only the degree-4
//    interpolation construction stays only-high.
//  * Image filenames left exactly as they were so nothing breaks;
//    note that Fractal_Broccoli.jpg does not follow the lowercase
//    hyphenated naming convention of STYLE_GUIDE §7 and could be
//    renamed to romanesco-broccoli.jpg when convenient.
// ============================================================

#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Basics of Sequences and Series")

#let ex = exercise.with(chapter: "Basics")

= Basics of Sequences and Series

#epigraph(by: [Keith Devlin])[
  Mathematics is the science of patterns.
]

#only-theory[
  Patterns are everywhere, and mathematics is in large part the study
  of patterns and of the structures lying underneath them. Many
  patterns occur in nature — the spirals of a nautilus shell, the
  branching of a fern, the self-similar florets of a Romanesco
  broccoli. Others live purely in the world of numbers: the primes
  $2, 3, 5, 7, dots$ underpin modern cryptography, while still other
  sequences are valued for their geometric or purely aesthetic
  appeal.

  #fig(
    image-grid(
      3,
      image("images/Fractal_Broccoli.jpg"),
      image("images/nautilus.jpg"),
      image("images/wave.png"),
    ),
    caption: [
      Three patterns that repeat with a rule: self-similar florets, a
      logarithmic spiral, a periodic wave.
    ],
  )

  This chapter makes the idea of a "number pattern" precise. We
  introduce #vocab("sequences", "Folgen") and the
  #vocab("series", "Reihen") built from them, and we learn the two
  complementary ways of describing a sequence: #emph[explicitly] and
  #emph[recursively]. Everything in the rest of the unit —
  arithmetic sequences, geometric sequences, growth models, infinite
  sums — is a special case of what is set up here.
]

#objectives(
  [explain what a sequence is, and what the series belonging to it
    is],
  [compute any term of a sequence from an explicit formula, and the
    first terms of a sequence from a recursive one],
  [describe a given number pattern both explicitly and recursively,
    and say which of the two forms a situation hands you first],
  [read and write finite sums in sigma notation, and evaluate them],
  [explain why a finite list of terms never forces "the next term",
    and say what mathematicians use instead to pin a sequence down],
)

== Number Patterns

#only-theory[
  Before anything is defined, try the thing itself. Each row below
  continues in a way most people agree on — predict the next entry:
  $
    2, 4, 6, 8, dots quad quad 1, 4, 9, 16, dots quad quad
    1, 1, 2, 3, 5, dots
  $
  The first two are easy to put into words: "add 2 each time", "the
  squares". The third is harder to name but easy to continue once
  you spot that each entry is the sum of the two before it.

  Notice that you did two different things there. Sometimes you
  described how to get from one entry to the *next* one; sometimes
  you described how to get an entry directly from its *position*.
  Those two habits are the whole content of this chapter, and
  neither is better than the other — each situation offers one of
  them cheaply and the other only after some work.
]

#toolbox()

== Sequences

#definition(title: "Sequence")[
  An ordered list of numbers is called a #vocab("sequence", "Folge"),
  and each number in the list is called a #vocab("term", "Glied") of
  the sequence.

  Formally, a sequence is a function whose inputs are the natural
  numbers: the input $n$ goes in and the term $a_n$ comes out. The
  terms could in principle be almost anything; for us they will
  always be real numbers.
]

#look-back(
  title: "A sequence is just a function with a small domain",
  recalls: [the definition of a function],
)[
  A function assigns exactly one output to each input of its domain.
  For the functions you have graphed so far that domain was an
  interval of real numbers, so the graph was a curve. Take the same
  definition and shrink the domain to $NN$: now there are only
  isolated inputs $1, 2, 3, dots$, so the graph is a row of separated
  dots rather than a curve. Nothing else changes. Every word you
  already know — value, domain, increasing, bounded — still applies,
  and we will use them.
]

#only-theory[
  *Notation.* We write a sequence with a name and an
  #vocab("index", "Index"),
  $ (a_n)_(n in NN), $
  where $a$ is the name of the sequence and $n$ records the position
  of the term $a_n$. When the context is clear the brackets are
  dropped and we speak simply of "the sequence $a_n$". Read $a_n$
  aloud as "$a$ sub $n$", and call it the $n$\u{2011}th term.

  Some sequences worth keeping in mind:
  - $1, 2, 3, 4, dots$ — the counting numbers,
  - $2, 3, 5, 7, dots$ — the prime numbers,
  - $2, 7, 12, 17, dots$ — start at $2$ and keep adding $5$,
  - $1, 1/2, 1/3, 1/4, dots$ — the reciprocals of the natural
    numbers.
]

#warning[
  Where the index starts is a *convention*, not a fact, and it
  differs between books, between calculators and between programming
  languages. In this course sequences start at $n = 1$ unless we say
  otherwise, so $a_1$ is the first term.

  Some situations are far more natural starting at $n = 0$ — an
  initial deposit before any interest has been paid, or a population
  at time zero. When you meet such a problem, say in one sentence
  which convention you are using, then stay with it. Most mistakes
  in this unit are off-by-one mistakes.
]

#example(title: "Evaluating a sequence")[
  Given $a_n = 3n + 7$, find $a_1$, $a_7$ and $a_(2018)$.

  Substitute the position of the term into the formula:
  $
    a_1 = 3 dot 1 + 7 = 10, quad a_7 = 3 dot 7 + 7 = 28, quad
    a_(2018) = 3 dot 2018 + 7 = #num(6061).
  $
  A formula like this answers a question about the two-thousandth
  term as cheaply as one about the second — which is exactly what
  makes it worth having.
]

#ex(difficulty: 1, time: "5 min", calculator: false)[
  Write down the first four terms of each sequence, and also the
  term $a_(10)$.
  #auto-parts(
    2,
    [$a_n = 2n - 1$],
    [$a_n = n/(n + 1)$],
    [$a_n = (-1)^n dot n$],
    [$a_n = 10 - n^2$],
  )
][
  #auto-parts(
    2,
    [$1, 3, 5, 7$; #h(0.4em) $a_(10) = 19$],
    [$1/2, 2/3, 3/4, 4/5$; #h(0.4em) $a_(10) = 10/11$],
    [$-1, 2, -3, 4$; #h(0.4em) $a_(10) = 10$],
    [$9, 6, 1, -6$; #h(0.4em) $a_(10) = -90$],
  )
]

#ex(difficulty: 1, time: "12 min", calculator: false)[
  Find a formula $a_n$ describing each sequence.
  #auto-parts(
    2,
    [$4, 8, 12, dots$],
    [$16, 21, 26, dots$],
    [$2, 0, 2, 0, dots$],
    [$3, -7, 11, -15, 19, dots$],
    [$1, 19/21, 18/22, 17/23, dots$],
    [$(-1)/8, (-4)/27, (-9)/64, (-16)/125, dots$],
  )
][
  #auto-parts(
    2,
    [$a_n = 4n$],
    [$a_n = 5n + 11$],
    [$a_n = 1 + (-1)^(n+1)$],
    [$a_n = (-1)^(n+1) dot (4n - 1)$],
    [$a_n = (21 - n)/(19 + n)$ — the terms were deliberately left
      unsimplified so that both patterns stay visible],
    [$a_n = (-n^2)/(n + 1)^3$],
  )
  For (c) and (d) the factor $(-1)^(n+1)$ does the alternating;
  isolate it first and the rest is an ordinary pattern.
  #heuristic("look for what stays the same")
]

== Explicit and Recursive Descriptions

#only-theory[
  Most of the sequences we care about can be described by a formula,
  and there are two kinds of formula.

  An #vocab("explicit formula", "explizite Darstellung") computes any
  term directly from its position $n$. A
  #vocab("recursive formula", "rekursive Darstellung") instead gives
  one or more starting values together with a rule for getting from
  one term to the *next* — think of a line of dominoes, where each
  one topples the one after it. A recursion is useless without its
  starting value: the rule alone says how to continue, not where to
  begin.
]

#only-theory[
  // domino-row() self-gates, but fig()'s caption does not — without
  // this wrapper the caption would print alone on the sheet.
  #fig(
    domino-row(n: 7),
    caption: [
      A recursion says only what each term does to the next one.
      Without the first push, nothing happens.
    ],
  )
]

#keybox(title: "The two descriptions")[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.2em,
    [
      *Explicit*
      $ a_n = 5n - 3 $
      Position in, term out. Jumping straight to $a_(500)$ costs one
      line.
    ],
    [
      *Recursive*
      $ cases(a_1 = 2, a_(n+1) = a_n + 5) $
      Start, then step. Reaching $a_(500)$ costs 499 steps.
    ],
  )
  Both describe $2, 7, 12, 17, dots$ — the same sequence, seen two
  ways.
]

#only-theory[
  Two more examples, to show that neither form is automatically the
  easy one:

  - The reciprocals $1, 1/2, 1/3, dots$ are given explicitly by
    $a_n = 1/n$, and that is obviously the description to use. A
    recursion also exists — $a_(n+1) = a_n \/ (1 + a_n)$ — but it is
    harder to find, harder to justify, and tells you nothing at a
    glance.

  - The sequence $1, 2, 5, 10, 17, dots$ is easier to see
    recursively: we add $1$, then $3$, then $5$ — at each step the
    next odd number,
    $ cases(a_1 = 1, a_(n+1) = a_n + (2n - 1)). $
    It is less obvious, but there is also a tidy explicit formula,
    $ a_n = n^2 - 2n + 2. $

  So the honest summary is this: a situation usually hands you one of
  the two forms for free, and converting to the other one is real
  work. Recognizing *which* form you have been handed is half of
  solving the problem.
]

#only-theory[
  Where do such formulas come from in the first place? Turning a
  situation into a formula is a climb through levels of abstraction.
  This ladder reappears in every chapter — when you are stuck, first
  locate which rung you are standing on and which rung the question
  is asking for.
]

#abstraction-ladder(
  l0: [A climbing gym opens with 2 founding members. Every week,
    5 new members join.],
  l1: [Membership count, week by week:
    #h(0.4em) 2, 7, 12, 17, 22, ...],
  l2: [Each week's count is last week's plus 5:
    #h(0.4em) $cases(a_1 = 2, a_(n+1) = a_n + 5)$ #h(0.4em)
    (recursive).],
  l3: [$a_n = 5n - 3$ — week number in, member count out, no history
    needed (explicit).],
)

#ex(difficulty: 1, time: "10 min", calculator: false, space: "roomy")[
  Write down the first five terms of each sequence.
  #auto-parts(
    2,
    [$cases(a_1 = 4, a_(n+1) = a_n - 3)$],
    [$cases(a_1 = 1, a_(n+1) = 2 a_n)$],
    [$cases(a_1 = 2, a_(n+1) = a_n^2 - 2)$],
    [$cases(a_1 = 1\, a_2 = 3, a_(n+2) = a_(n+1) - a_n)$],
  )
][
  #auto-parts(
    2,
    [$4, 1, -2, -5, -8$],
    [$1, 2, 4, 8, 16$],
    [$2, 2, 2, 2, 2$],
    [$1, 3, 2, -1, -3$],
  )
  Part (c) is worth a second look: the rule is far from trivial, yet
  $2$ is a *fixed point* of it, so nothing ever moves.
  #heuristic("check an extreme or special case")
]

#ex(
  difficulty: 2,
  time: "20 min",
  calculator: false,
  space: 1.5em,
  hints: (
    [Answer the first question first: just compute the terms, and
      only then hunt for a formula. #heuristic("try small cases")],
    [For (b) and (d), compare each term with the nearest power of
      $2$.],
  ),
)[
  Calculate the first five terms of each sequence. Can you find an
  explicit formula for $a_n$?
  #auto-parts(
    2,
    [$a_1 = 1, quad a_(n+1) = 3 a_n$],
    [$a_1 = 1, quad a_(n+1) = 2 a_n + 3$],
    [$a_1 = 0, quad a_(n+1) = a_n + 2/((n + 2) dot (n + 3))$],
    [$a_1 = 1, quad a_(n+1) = 2 a_n - 3$],
    [$a_1 = 0, quad a_(n+1) = 3 a_n + 3^n$],
    [$a_1 = 1, quad a_2 = 1, quad a_(n+2) = a_(n+1) + a_n$],
  )
][
  #auto-parts(
    2,
    [$1, 3, 9, 27, 81$; #h(0.4em) $a_n = 3^(n-1)$],
    [$1, 5, 13, 29, 61$; #h(0.4em) $a_n = 2^(n+1) - 3$],
    [$0, 1/6, 4/15, 1/3, 8/21$; #h(0.4em)
      $a_n = (2 dot (n - 1))/(3 dot (n + 2))$],
    [$1, -1, -5, -13, -29$; #h(0.4em) $a_n = 3 - 2^n$],
    [$0, 3, 18, 81, 324$; #h(0.4em) $a_n = (n - 1) dot 3^(n-1)$],
    [$1, 1, 2, 3, 5$; #h(0.4em) the Fibonacci sequence. A closed form
      does exist, but it is not findable by inspection — and that is
      a fair thing to discover here.],
  )
  In (b) and (d) the terms sit $3$ below and $3$ above a power of $2$
  respectively; in (c) it pays to leave the fractions unsimplified
  while you look. #heuristic("look for what stays the same")
]

#ex(
  difficulty: 2,
  time: "20 min",
  space: "roomy",
  hints: (
    [Parts (g) and (h) follow no polynomial rule at all. For (g),
      #heuristic("look for what stays the same") between three
      consecutive terms; for (h), try reading each term *aloud*.],
  ),
)[
  Find a sensible continuation of each sequence. Where possible, give
  both an explicit and a recursive definition.
  #auto-parts(
    2,
    [$1, 2, 3, 4, dots$],
    [$1, 4, 9, 16, dots$],
    [$2, 4, 8, 16, dots$],
    [$-7, -3, 1, 5, dots$],
    [$2, 6, 12, 20, dots$],
    [$(-3)/5, 11/13, (-19)/21, 27/29, dots$],
    [$1, 1, 2, 3, 5, 8, dots$],
    [$1, 11, 21, 1211, 111221, dots$],
  )
][
  #auto-parts(
    2,
    [$a_n = n$; #h(0.4em) $cases(a_1 = 1, a_(n+1) = a_n + 1)$],
    [$a_n = n^2$; #h(0.4em)
      $cases(a_1 = 1, a_(n+1) = a_n + 2n + 1)$],
    [$a_n = 2^n$; #h(0.4em) $cases(a_1 = 2, a_(n+1) = 2 a_n)$],
    [$a_n = 4n - 11$; #h(0.4em)
      $cases(a_1 = -7, a_(n+1) = a_n + 4)$],
    [$a_n = n^2 + n$; #h(0.4em)
      $cases(a_1 = 2, a_(n+1) = a_n + 2 dot (n + 1))$],
    [$a_n = (-1)^n dot (8n - 5)/(8n - 3)$; #h(0.4em) a recursion
      exists, but it is of no practical use here],
    [the Fibonacci sequence; #h(0.4em)
      $cases(a_1 = 1\, a_2 = 1, a_(n+2) = a_(n+1) + a_n)$],
    [the look-and-say sequence: each term reads the previous one
      aloud. Reading $111221$ gives "three 1s, two 2s, one 1", so the
      next term is $312211$. No elementary closed form.],
  )
  Note that the answers to (a)–(e) are *choices*, not deductions —
  see the discussion below.
]

#ex(
  difficulty: 2,
  time: "15 min",
  calculator: false,
  hints: (
    [Climb the ladder in order: write out the data before you look
      for a pattern, and the pattern before you look for a formula.],
  ),
)[
  Logs are stacked in rows. The top row holds 3 logs, the row below
  it 5, the row below that 7, and so on down the pile.
  #auto-parts(
    1,
    [How many logs are in the $n$\u{2011}th row from the top? Give
      both a recursive and an explicit description.],
    [Which row holds 41 logs?],
    [The pile has 10 rows. How many logs are in it altogether?],
  )
][
  #auto-parts(
    1,
    [$cases(a_1 = 3, a_(n+1) = a_n + 2)$ recursively, and
      $a_n = 2n + 1$ explicitly.],
    [$2n + 1 = 41$ gives $n = 20$: the twentieth row.],
    [Adding the ten terms $3, 5, 7, dots, 21$ gives $120$ logs.
      Doing this by adding one term at a time works here, but it will
      not scale to a pile of 200 rows — the next chapter supplies a
      formula that does.],
  )
]

== Series and Sigma Notation

#definition(title: "Series")[
  Let $(a_n)$ be a sequence. The sums
  $
    s_1 = a_1, quad s_2 = a_1 + a_2, quad
    s_3 = a_1 + a_2 + a_3, quad dots
  $
  are called the #vocab("partial sums", "Teilsummen") of $(a_n)$.
  The sequence $(s_n)$ of partial sums is the
  #vocab("series", "Reihe") associated with $(a_n)$.
]

#warning[
  A series is a *sequence*, not a single number: $s_n$ is the total
  after $n$ terms, and it changes with $n$. Saying "the series
  equals 40" is only meaningful once you have said which $s_n$ you
  mean. Infinite sums are the one case where a single number is
  intended — and making sense of that case needs a limit. See the
  look-ahead below.
]

#only-theory[
  Writing $a_1 + a_2 + dots.c + a_n$ out every time is tedious, so we
  compress it with the
  #vocab("sigma notation", "Summenschreibweise"),
  $ s_n = sum_(k=1)^n a_k. $
  The symbol $sum$ is a capital Greek sigma, for "sum". Read the
  notation as an instruction: let the
  #vocab("summation index", "Summationsindex") $k$ run from $1$ up
  to $n$, evaluate $a_k$ each time, and add up everything you get.
]

#keybox(title: "Reading a sigma")[
  $
    sum_(k=1)^4 underbrace(k^2, "what to add")
    = 1^2 + 2^2 + 3^2 + 4^2 = 30
  $
  The number below the sigma says where the index starts; the number
  above says where it stops. The index is a *dummy*: writing $j$ or
  $i$ instead of $k$ changes nothing at all.
]

#example(title: "Both directions")[
  Expanding a sigma is mechanical:
  $ sum_(k=1)^4 (2k + 1) = 3 + 5 + 7 + 9 = 24. $

  Compressing a sum into a sigma takes one decision — you must choose
  where the index starts, and the formula then adapts. Both of these
  describe the same sum $3 + 5 + 7 + 9$:
  $ sum_(k=1)^4 (2k + 1) = sum_(k=2)^5 (2k - 1). $
  Neither is more correct than the other. Pick whichever makes the
  formula simplest, and say which you picked.
]

#look-ahead(
  title: "What if the sum never stops?",
  preview: [infinite geometric series and their limits],
)[
  The decimal $0.999 dots$ is a sum with no last term,
  $ 0.9 + 0.09 + 0.009 + dots.c $
  Every partial sum is smaller than $1$, yet the partial sums crowd
  up against $1$ as closely as you like. Later in this unit we make
  that idea precise and compute such infinite sums exactly — and the
  answer here really is $1$, not "almost $1$".
]

#ex(difficulty: 1, time: "8 min", calculator: false)[
  Calculate the following sums.
  #auto-parts(
    3,
    [$sum_(k=1)^4 (4k - 7)$],
    [$sum_(k=8)^(11) (k^2 - 100)$],
    [$sum_(k=2)^6 (2^k - 1)$],
  )
][
  #auto-parts(
    3,
    [$-3 + 1 + 5 + 9 = 12$],
    [$-36 - 19 + 0 + 21 = -34$],
    [$3 + 7 + 15 + 31 + 63 = 119$],
  )
]

#ex(difficulty: 2, time: "12 min", calculator: false)[
  Write each series using sigma notation.
  #auto-parts(
    1,
    [$-1 + 3 + 7 + 11 + dots$ (continuing forever)],
    [$-1 + 1 - 1 + 1 - 1 + 1 - 1 + 1 - 1 + 1$],
    [$6 - 12 + 24 - 48 + 96 - 192$],
  )
][
  #auto-parts(
    1,
    [$sum_(n=1)^(oo) (4n - 5)$],
    [$sum_(n=1)^(10) (-1)^n$],
    [$sum_(n=1)^6 6 dot (-2)^(n-1)$],
  )
  Other index choices are equally correct — check yours by expanding
  the first two terms and the last one.
]

#ex(
  difficulty: 2,
  time: "10 min",
  calculator: false,
  hints: (
    [If the index is to start one lower, every occurrence of it
      inside the sum must be pushed one higher to compensate.
      #heuristic("introduce notation") — call the new index $j$ and
      write down how $j$ and $k$ are related.],
  ),
)[
  Rewriting a sum so that its index starts somewhere else is a
  standard move; it costs nothing but bookkeeping.
  #auto-parts(
    1,
    [Rewrite $sum_(k=1)^5 (3k + 1)$ so that the index runs from $0$
      to $4$.],
    [Rewrite $sum_(k=3)^8 k^2$ so that the index runs from $1$ to
      $6$.],
    [Explain why $sum_(k=1)^n (2k - 1)$ and
      $sum_(k=0)^(n-1) (2k + 1)$ are the same sum.],
  )
][
  #auto-parts(
    1,
    [Put $j = k - 1$, so $k = j + 1$ and $3k + 1 = 3j + 4$:
      $ sum_(k=1)^5 (3k + 1) = sum_(j=0)^4 (3j + 4). $
      Both expand to $4 + 7 + 10 + 13 + 16$.],
    [Put $j = k - 2$:
      $ sum_(k=3)^8 k^2 = sum_(j=1)^6 (j + 2)^2. $],
    [Lowering the index by one and raising the expression by one
      leaves every summand untouched: both are
      $1 + 3 + 5 + dots.c + (2n - 1)$, and both have $n$ terms.],
  )
]

== What Counts as "the Next Term"?

#only-theory[
  The word *sensible* in the exercise above was doing quiet work.
  From a strictly mathematical point of view there is *no*
  continuation a sequence is forced to take. Given any finite list of
  terms, and any number you like, some rule produces that number
  next. This is the pitfall at the heart of the pattern questions in
  IQ tests: the expected answer is the *simplest* one, which is a
  claim about human taste, not about arithmetic.

  Take $1, 2, 3, 4, dots$. The obvious continuation is
  $1, 2, 3, 4, 5, 6, dots$ with $a_n = n$. But suppose we insist that
  the fifth term be $17$ instead.
]

#only-high[
  We look for a polynomial $p$ with $a_n = p(n)$. The five conditions
  $
    p(1) = 1, quad p(2) = 2, quad p(3) = 3, quad p(4) = 4, quad
    p(5) = 17
  $
  determine a polynomial of degree four,
  $ p(n) = 1/2 n^4 - 5 n^3 + 35/2 n^2 - 24 n + 12, $
  which continues the sequence as
  $ 1, 2, 3, 4, 17, 66, 187, 428, dots $
  — every bit as valid as the first continuation. The same
  construction works for *any* prescribed fifth term, and that is the
  general statement: no finite list of terms determines the next one.
]

#only-theory[
  The lesson: mathematicians identify a sequence by its
  *definition*, not by its first few terms. When a problem asks for a
  sensible continuation, it is asking for the simplest rule you can
  defend — so part of the answer is stating the rule, not just the
  number.

  There is even an On-Line Encyclopedia of Integer Sequences
  (#link("https://oeis.org/")[oeis.org]); searching for $1, 2, 3, 4$
  returns thousands of distinct, mathematically meaningful sequences
  that begin that way.
]

#ai-box(role: "Generator")[
  Ask an AI chatbot: "What is the next term of $1, 2, 3, 4$?" When it
  answers, reply: "No — the next term is $17$. Justify this
  continuation." Then reply once more: "No, it is $-8$. Justify that
  instead."

  Write down what happens across the three answers. What does this
  exchange tell you about (i) pattern-continuation questions in
  general, and (ii) how readily a chatbot will defend whatever it has
  just been told? Which of its three answers, if any, was actually
  wrong?
]

#exploration(title: "Counting dots")[
  Pebbles arranged in a triangle give the *triangular numbers*
  $1, 3, 6, 10, dots$

  #fig(dot-triangle(rows: 5))

  - Find a recursive description of the triangular numbers. That part
    is quick.
  - Now find an explicit formula. #heuristic("draw a picture") — take
    two copies of the triangle and fit them together into a
    rectangle. What are the rectangle's side lengths?
  - Arrange dots in a square instead. To grow a square from $n^2$
    dots to $(n + 1)^2$ dots you add one L-shaped layer: how many
    dots does that layer need? What does your answer say about the
    sum $1 + 3 + 5 + 7 + dots.c$ of the odd numbers?
]

#print-hints()

#print-vocab()
