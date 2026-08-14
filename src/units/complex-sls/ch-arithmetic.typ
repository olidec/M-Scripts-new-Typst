#import "../../common/preamble.typ": *
#show: chapter-template.with(title: "Arithmetic")
#let ex = exercise.with(chapter: "Arithmetic")

= Arithmetic with Complex Numbers

#only-theory[
  Here is the good news, stated once and meant literally: you already
  know how to do the arithmetic in this chapter. Adding, subtracting,
  multiplying and dividing complex numbers uses no rule you have not
  used for years -- the distributive law, collecting like terms,
  clearing a denominator. There is exactly *one* new fact in the whole
  chapter, and you already met it:
  $ i^2 = -1. $
  Everything below is ordinary algebra with that single substitution
  applied whenever it can be. If a calculation ever feels mysterious,
  you have almost certainly forgotten to treat $i$ as just another
  symbol that happens to square to $-1$.
]

// ─────────────────────────────────────────────────────────────
//  CHAPTER-OPENING SONG (kept per teaching decision).
//
//  Bob Wells' "Imaginary Numbers", sung to the tune of Lennon's
//  "Imagine". Source (and the text to paste below):
//    http://www.pleacher.com/mp/mpoetry/imagine.html
//
//  The full lyric is NOT reproduced here — paste your existing block
//  in the marked spot. The surrounding markup is already correct: the
//  old version set `#set quote` INSIDE an only-theory block and padded
//  it by 10em, which is why it rendered off-center and leaked onto the
//  sheet. quotebox() fixes both — it is a self-suppressing callout
//  (gone from the exercise sheet automatically) and needs no `set`
//  rules. Keep the attribution line as the last line of the block.
// ─────────────────────────────────────────────────────────────
#quotebox[
  #align(left)[#text(
      fill: luma(150),
    )[\
      Imaginary Numbers \
      They're easy if you try\
      When a negative's under the radical\
      You just remove the 'i'\
      Imaginary numbers\
      Are really no big deal\

      Imaginary Numbers\
      Both complex and pure\
      Open a whole new world for\
      Math geeks for sure\
      Imagine all the numbers\
      Making sense to you - ooh-hoo-ooo\

      You may say I'm a dreamer\
      But I'm not the only one\
      I hope someday you will join us\
      Where i squared is negative one\

      Imaginary Numbers\
      Are a really useful tool\
      Once you get to know them\
      They're infinitely cool!\
      Imagine all the numbers\
      Making sense to you -ooh-hoo-ooo\

      You may say I'm a dreamer\
      But I'm not the only one\
      I hope someday you will join us\
      where i squared is negative one.

      #v(0.3em) #align(right)[#text(
        size: 9pt,
      )[— Bob Wells, to the tune of Lennon's *Imagine* · #link("http://www.pleacher.com/mp/mpoetry/imagine.html")[pleacher.com]]]
    ]
  ]]

#only-theory[
  A word of warning about that song, though, because it is a nice
  example of how a catchy line can be *slightly* wrong. "When a
  negative's under the radical, you just remove the $i$" is the
  cheerful version; the careful version, from the introduction, is that
  we never simply write $sqrt(-1) = i$ and start moving it around,
  because $sqrt(a) dot sqrt(b) = sqrt(a dot b)$ fails for negative
  numbers. Enjoy the song. Trust the definition $i^2 = -1$.
]
#pagebreak()
#objectives(
  [add, subtract, multiply and divide complex numbers written in
    Cartesian form $a + b dot i$],
  [form the complex conjugate $overline(z)$ and use its algebraic
    properties],
  [recognize $z dot overline(z)$ as a non-negative real number, and use
    the conjugate to make a denominator real],
  [compute small integer powers of a complex number],
  [solve a simple equation such as $z^2 = w$ by comparing real and
    imaginary parts],
)

#only-theory[
  Throughout the chapter, $z_1 = a_1 + b_1 dot i$ and
  $z_2 = a_2 + b_2 dot i$ stand for arbitrary complex numbers, with all
  of $a_1, a_2, b_1, b_2$ real. Whenever a final answer is a complex
  number, we write it in #vocab("Cartesian form", "kartesische Form")
  $a + b dot i$ -- real part first, then the imaginary part, with the
  $i$ pulled out to the right. An answer left as
  $2 - 8 dot i + 3 dot i$ is not finished; $2 - 5 dot i$ is.
]

== Addition and Subtraction

#only-theory[
  Adding complex numbers means adding the real parts and the imaginary
  parts *separately* -- the two parts never mix, because one carries an
  $i$ and the other does not.
]

#theorem(title: "Addition and subtraction")[
  $
    z_1 + z_2 & = (a_1 + a_2) + (b_1 + b_2) dot i, \
    z_1 - z_2 & = (a_1 - a_2) + (b_1 - b_2) dot i.
  $
]

#example[
  With $z_1 = 2 + 3 dot i$ and $z_2 = 1 - 4 dot i$:
  $
    z_1 + z_2 = (2 + 1) + (3 - 4) dot i = 3 - i, \
    z_1 - z_2 = (2 - 1) + (3 + 4) dot i = 1 + 7 dot i.
  $
]

#look-ahead(
  title: "Two parts, two coordinates",
  preview: [the Gaussian plane],
)[
  Notice that this is exactly how you add *vectors*: components add
  separately. That is not an analogy that happens to work -- it is a
  sign that a complex number is carrying the same information as a
  point in a plane. Two chapters from now we will draw complex numbers
  as points, and this componentwise addition will become the
  parallelogram rule you know from physics.
]

== Multiplication

#only-theory[
  To multiply, expand the product exactly as you would expand
  $(a_1 + b_1 dot x) dot (a_2 + b_2 dot x)$ with a variable $x$ -- and then, at the
  very end, use the one new fact to replace $i^2$ by $-1$.
]

#theorem(title: "Multiplication")[
  $
    z_1 dot z_2
    = (a_1 dot a_2 - b_1 dot b_2)
    + (a_1 dot b_2 + a_2 dot b_1) dot i.
  $
]

#proof[
  Expand and collect, substituting $i^2 = -1$ in the middle line:
  $
    (a_1 + b_1 dot i) dot (a_2 + b_2 dot i) & = a_1 dot a_2 + a_1 dot b_2 dot i + a_2 dot b_1 dot i
                                              + b_1 dot b_2 dot i^2 \
                                            & = a_1 dot a_2 - b_1 dot b_2
                                              + (a_1 dot b_2 + a_2 dot b_1) dot i.
  $
]

#warning[
  Do *not* memorize the multiplication formula. Nobody who is fluent
  with complex numbers has it memorized; they expand and substitute
  every time, which is faster and far less error-prone than recalling
  which product gets the minus sign. The formula is there to be
  *derived*, not stored.
]

#example[
  With $z_1 = 2 + 3 dot i$ and $z_2 = 1 - 4 dot i$:
  $
    z_1 dot z_2
    = (2 + 3 dot i) dot (1 - 4 dot i)
    = 2 - 8 dot i + 3 dot i - 12 dot i^2 \
    = (2 + 12) + (-8 + 3) dot i
    = 14 - 5 dot i.
  $
  The $-12 dot i^2$ became $+12$ -- the step that does all the work.
]

== The Conjugate

#only-theory[
  One small construction unlocks division and turns out to be the most
  useful single tool in the whole subject. It is almost nothing: flip
  the sign of the imaginary part.
]

#definition(title: "Complex conjugate")[
  The #vocab("complex conjugate", "komplex konjugierte Zahl") of
  $z = a + b dot i$ is
  $ overline(z) = a - b dot i. $
  It has the same real part as $z$ and the opposite imaginary part.
]

#only-theory[
  The conjugate is worth this much attention because of what happens
  when you *combine* $z$ with $overline(z)$. Two of the following three
  identities recover the real and imaginary parts; the third is the one
  that matters most.
]

#theorem(title: "The conjugate and the parts")[
  For $z = a + b dot i$:
  $
      z + overline(z) & = 2 a = 2 Re(z), \
      z - overline(z) & = 2 b dot i = 2 Im(z) dot i, \
    z dot overline(z) & = a^2 + b^2.
  $
  In particular $z dot overline(z)$ is a *non-negative real number*,
  and it is zero only when $z = 0$.
]

#proof[
  All three are direct. For the third, the product is a difference of
  two squares:
  $
    (a + b dot i) dot (a - b dot i)
    = a^2 - (b dot i)^2 = a^2 - b^2 dot i^2 = a^2 + b^2.
  $
]

#keybox(title: [Why $z dot overline(z)$ is the key])[
  The product $z dot overline(z) = a^2 + b^2$ takes two complex numbers
  and returns a *real* one -- with no $i$ left anywhere. That is exactly
  what you need to divide (it clears $i$ from a denominator), and it is
  the algebraic engine behind almost every proof later in the unit.
  Learn to reach for $z dot overline(z)$ the moment you want to turn
  something complex into something real.
]

#look-ahead(
  title: "A real number waiting for a name",
  preview: [the modulus, in the Gaussian plane],
)[
  Look again at $z dot overline(z) = a^2 + b^2$. Under the square root,
  $sqrt(a^2 + b^2)$ is the length of the hypotenuse of a triangle with
  legs $a$ and $b$ -- a *distance*. When we draw complex numbers as
  points, that distance will get a name and a symbol, $|z|$, and this
  identity will read $z dot overline(z) = |z|^2$. Keep it in view; it
  is the same fact wearing geometry.
]

#only-theory[
  The conjugate also gets along with arithmetic in the cleanest
  possible way: conjugating a sum or a product is the same as
  conjugating the pieces first and combining afterwards.
]

#theorem(title: "The conjugate respects arithmetic")[
  For all $z, w in CC$:
  $
    overline(z + w) = overline(z) + overline(w), quad
    overline(z dot w) = overline(z) dot overline(w), quad
    overline(overline(z)) = z.
  $
]

#remark[
  Read the middle identity as a promise for later: it is precisely
  what makes $|z dot w| = |z| dot |w|$ true once the modulus arrives.
  You will prove that in the Gaussian-plane chapter, and it will lean
  on this line.
]

== Division

#only-theory[
  Division is the one operation with no obvious first move: what could
  $1 / (1 + i)$ possibly mean? Before reading on, try to find the trick
  yourself -- you have seen its twin before.
]

#exploration(title: "Make the denominator real")[
  You already know how to remove a root from a denominator. To simplify
  $1 / (1 - sqrt(2))$ you multiply top and bottom by $1 + sqrt(2)$,
  because $(1 - sqrt(2)) dot (1 + sqrt(2)) = 1 - 2 = -1$ is rational: the
  cross terms cancel.

  + The denominator $1 + i$ has the same shape. What should you
    multiply top and bottom by, so that the new denominator is a real
    number? (You met the answer in the previous section.)
  + Carry it out for $1 / (1 + i)$ and write the result in the form
    $a + b dot i$.
  + State the general rule in words: to divide by $z_2$, multiply the
    top and bottom by a particular number built from $z_2$, chosen so
    that the new denominator comes out real. Which number is it, and
    why does multiplying by it clear the $i$?
]

#theorem(title: "Division")[
  For $z_2 eq.not 0$, multiply numerator and denominator by the
  conjugate of the denominator:
  $
    z_1 / z_2
    = (z_1 dot overline(z_2)) / (z_2 dot overline(z_2))
    = (z_1 dot overline(z_2)) / (a_2^2 + b_2^2).
  $
  The denominator $a_2^2 + b_2^2$ is a positive real number, so the
  result is again a complex number in Cartesian form.
]

#example[
  With $z_1 = 2 + 3 dot i$ and $z_2 = 1 - 4 dot i$, so
  $overline(z_2) = 1 + 4 dot i$:
  $
    z_1 / z_2
    = (2 + 3 dot i) / (1 - 4 dot i) dot (1 + 4 dot i) / (1 + 4 dot i)
    = ((2 + 3 dot i) dot (1 + 4 dot i)) / (1^2 + 4^2)
    = (-10 + 11 dot i) / 17
    = -10 / 17 + 11 / 17 dot i.
  $
]

#ai-box(role: "Checker")[
  Division is where sign slips hide, so it is a good place to practice
  checking rather than trusting.

  + Compute $(3 + 2 dot i) / (7 - i)$ by hand, in Cartesian form.
  + Ask an AI assistant for the same quotient, then compare digit for
    digit with your answer.
  + If they disagree, *find the error* rather than assuming the machine
    is right -- redo your multiplication of $(3 + 2 dot i)$ by the
    conjugate, and check the denominator $7^2 + 1^2$ separately. One of
    you dropped a sign; make sure you know which, and why.
]

== Powers

#only-theory[
  Small integer powers need nothing new: multiply the number by itself.
  For a square, the binomial formula is quickest, remembering
  $i^2 = -1$:
  $
    z^2 = (a + b dot i)^2 = a^2 - b^2 + 2 a dot b dot i.
  $
  A cube is then one more multiplication, $z^3 = z dot z^2$.
]

#pagebreak()
#example[
  With $z = 2 + 3 dot i$:
  $
    z^2 = (2 + 3 dot i)^2 = 4 + 12 dot i + 9 dot i^2 = -5 + 12 dot i.
  $
]

#look-ahead(
  title: "High powers the hard way, then the easy way",
  preview: [polar form and De Moivre's theorem],
)[
  Try computing $(1 + i)^(10)$ by repeated multiplication and you will
  see the problem: it works, but it is a slog, and $(1 + i)^(100)$ by
  hand is out of the question. There is a beautiful shortcut, but it
  needs a completely different way of writing a complex number -- by
  its distance and direction rather than its two parts. That is polar
  form, and with it a hundredth power costs about as much as a first.
  For now, powers stay small.
]

== Extra Bits -- A Square Root of $i$

#only-theory[
  The Fundamental Theorem of Algebra, from the introduction, promised
  that $CC$ is where equations stop sending us hunting for new numbers.
  Here is the smallest interesting test of that promise: does $i$
  itself have a square root *inside* $CC$? The tool is the one from the
  introduction -- a single complex equation is two real equations,
  compared part by part.
]

#ex(difficulty: 3, time: "20 min", hints: (
  [Write the unknown root as $z = a + b dot i$ with $a, b$ real, square
    it, and set it equal to $i = 0 + 1 dot i$.],
  [Compare real and imaginary parts. You get two real equations:
    $a^2 - b^2 = 0$ and $2 a dot b = 1$.],
  [From the first equation $a = plus.minus b$. The second forces $a$
    and $b$ to have the *same sign* -- which of the two cases survives?],
))[
  Find all $z in CC$ with $z^2 = i$ -- that is, find both square roots
  of $i$ -- by writing $z = a + b dot i$ and comparing real and
  imaginary parts.
][
  Let $z = a + b dot i$. Then
  $z^2 = a^2 - b^2 + 2 a dot b dot i$, and $z^2 = i$ means
  $a^2 - b^2 + 2 a dot b dot i = 0 + 1 dot i$. Comparing parts
  (#heuristic("introduce notation")) gives two real equations:
  $
    a^2 - b^2 = 0, quad 2 a dot b = 1.
  $
  The first gives $a = plus.minus b$. Since $2 a dot b = 1 > 0$,
  the product $a dot b$ is positive, so $a$ and $b$ share a sign and we
  need $a = b$ (not $a = -b$). Then $2 a^2 = 1$, so
  $a = b = 1 / sqrt(2)$ or $a = b = -1 / sqrt(2)$. The two square roots
  of $i$ are
  $
    z = 1 / sqrt(2) + 1 / sqrt(2) dot i
    quad "and" quad
    z = -1 / sqrt(2) - 1 / sqrt(2) dot i.
  $

  *Two roots, as promised.* A degree-$2$ equation has two solutions in
  $CC$, and here they are -- exact opposites of each other, $z$ and
  $-z$, which is the pattern you will always see for a square root.
  Note what we did *not* need: no $sqrt(-1)$, no new symbol, nothing
  outside $CC$. The Fundamental Theorem of Algebra kept its promise.
]

// ── Exercises ────────────────────────────────────────────────

#ex(difficulty: 2, time: "20 min", calculator: true)[
  Let $z_1 = 2 + 3 dot i$, $z_2 = 3 / 2 - 4 dot i$, $z_3 = 1 - 5 dot i$
  and $z_4 = (3 + 4 dot i) / 5$. Calculate each of the following, and
  check your answers with a CAS.
  #auto-parts(
    2,
    [$z_1 + z_3$],
    [$z_1 - 2 z_2$],
    [$z_2 + z_4$],
    [$5 z_4 - 2 z_2$],
    [$3 z_1 + 4 z_2 - z_3 - 5 z_4$],
    [$z_1 dot z_2 + z_3 dot z_4$],
    [$z_3^2 - 2 / 3 z_2 dot z_4$],
  )
][
  #auto-parts(
    2,
    [$3 - 2 dot i$],
    [$-1 + 11 dot i$],
    [$21 / 10 - 16 / 5 dot i$],
    [$12 dot i$],
    [$8 - 6 dot i$],
    [$98 / 5 - 57 / 10 dot i$],
    [$-401 / 15 - 46 / 5 dot i$],
  )
]

#ex(difficulty: 2, time: "15 min")[
  Let $v = 1 + i$, $w = 4 dot i$ and $z = 2 - 5 dot i$. Calculate each
  of the following by hand.
  #auto-parts(
    2,
    [$v dot z$],
    [$v dot (w - z)$],
    [$Re(v dot w dot z)$],
    [$Im(v + w dot z)$],
  )
][
  #auto-parts(
    2,
    [$7 - 3 dot i$],
    [$-11 + 7 dot i$],
    [$12$],
    [$9$],
  )
]

#ex(difficulty: 2, time: "15 min")[
  Write each of the following in Cartesian form $a + b dot i$, by hand.
  #auto-parts(
    2,
    [$(3 + 2 dot i) / (7 - i)$],
    [$i / (-4 - 4 dot i)$],
    [$1 / i$],
    [$(3 + 4 dot i) / (-i)$],
  )
][
  #auto-parts(
    2,
    [$19 / 50 + 17 / 50 dot i$],
    [$-1 / 8 - 1 / 8 dot i$],
    [$-i$],
    [$-4 + 3 dot i$],
  )

  In (c) and (d) the denominator is already purely imaginary, so
  multiplying top and bottom by $i$ (or by $-i$) is enough -- no need
  for the full conjugate machinery.
]

#ex(difficulty: 2, time: "15 min")[
  Calculate $z^2$ and $z^3$ for each number, by hand.
  #auto-parts(
    2,
    [$z = 1 + i$],
    [$z = 2 - i$],
    [$z = -3 + 2 dot i$],
    [$z = 1 / 2 + sqrt(3) / 2 dot i$],
  )
][
  #auto-parts(
    1,
    [$z^2 = 2 dot i$, $quad z^3 = -2 + 2 dot i$],
    [$z^2 = 3 - 4 dot i$, $quad z^3 = 2 - 11 dot i$],
    [$z^2 = 5 - 12 dot i$, $quad z^3 = 9 + 46 dot i$ (via
      $z^3 = z dot z^2$)],
    [$z^2 = -1 / 2 + sqrt(3) / 2 dot i$, $quad z^3 = -1$],
  )

  Part (d) is worth a second look: a number that is neither real nor
  imaginary, cubed, gives $-1$. It is a cube root of $-1$, and where it
  comes from is exactly the kind of question polar form answers.
]

#ex(difficulty: 2, time: "15 min", hints: (
  [Write $z = a + b dot i$, form $overline(z)$, and substitute into
    each side.],
  [For the product, you will need to expand $(a + b dot i) dot (c + d dot i)$
    and conjugate the result, then separately conjugate each factor and
    multiply. Show the two match.],
))[
  Prove, for $z = a + b dot i$ and $w = c + d dot i$, that the conjugate
  respects addition and multiplication:
  #auto-parts(
    1,
    [$overline(z + w) = overline(z) + overline(w)$],
    [$overline(z dot w) = overline(z) dot overline(w)$],
  )
][
  #auto-parts(
    1,
    [$overline(z + w) = overline((a + c) + (b + d) dot i)
    = (a + c) - (b + d) dot i = (a - b dot i) + (c - d dot i)
    = overline(z) + overline(w).$],
    [Expand first, then conjugate:
      $z dot w = (a dot c - b dot d) + (a dot d + b dot c) dot i$, so
      $overline(z dot w) = (a dot c - b dot d) - (a dot d + b dot c) dot i$.
      Conjugating the factors first:
      $overline(z) dot overline(w) = (a - b dot i) dot (c - d dot i)
      = (a dot c - b dot d) - (a dot d + b dot c) dot i$. The two agree. $square$],
  )
]

#ex(difficulty: 1, time: "5 min")[
  For which complex numbers $z$ is $z = overline(z)$? Justify your
  answer in one line.
][
  Writing $z = a + b dot i$, the condition $z = overline(z)$ reads
  $a + b dot i = a - b dot i$, so $2 b dot i = 0$, hence $b = 0$.
  Thus $z = overline(z)$ exactly when $z$ is *real*. (A number equals
  its own mirror image in the real axis precisely when it already sits
  on that axis.)
]

#print-hints()
#print-vocab()
