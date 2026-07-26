#import "/src/common/preamble.typ": *

// ============================================================
//  EPIGRAPH COLLECTION — easter eggs for the curriculum
//
//  A bank to copy from, not a chapter. It IS valid Typst, so you
//  can compile it as a browsable appendix if you like — just add
//    #import "/src/common/preamble.typ": *
//  at the top. Otherwise treat it as a shopping list: copy the
//  lines you want into a chapter and leave the rest here.
//
//  ORGANIZATION
//    §1  The nature of mathematics
//    §2  Learning, struggle, and teaching
//    §3  Proof, rigor, and being wrong
//    §4  Infinity and the strange
//    §5  Computer science
//    §6  Technology — funny and cautionary
//    §7  Famously wrong, famously misattributed
//    §8  Statistics and being fooled by data
//    §9  Geeky observations and jokes
//    §10 Creative insults (aim at ideas, not people)
//    §11 Weird language — ambiguity and garden paths
//    §12 Punctuation that changes everything
//    §13 Notation — where math's own language betrays it
//    §14 German–English traps for immersion classes
//    §15 Self-reference, paradox, and AI-literacy eggs
//
//  ATTRIBUTION CONVENTION
//    by: "Name"                  — solidly sourced
//    by: "attributed to Name"    — widely quoted, weak or
//                                  second-hand primary source
//    by: "misattributed to Name" — the misattribution IS the joke;
//                                  see the comment above the entry
//  Where the record is genuinely interesting, the comment says so.
//  Getting this right is itself a lesson in source criticism, and
//  quietly models the habit you want students to have.
//
//  ON POEMS: deliberately none here. Math limericks and Piet Hein's
//  grooks are tempting easter eggs, but a short poem is a complete
//  copyrighted work — quoting one entire is a different matter from
//  quoting a sentence of prose. Named so you can look them up and
//  decide for yourself: Leigh Mercer's "dozen, gross and score"
//  limerick, and Hein's grook about erring less and less.
// ============================================================


// ────────────────────────────────────────────────────────────
//  §1  THE NATURE OF MATHEMATICS
// ────────────────────────────────────────────────────────────

#epigraph(by: "Henri Poincaré")[
  Mathematics is the art of giving the same name to different things.
]

// Pairs beautifully with the abstraction-ladder figure: Hilbert's
// point is that the axioms, not the pictures, carry the content.
#epigraph(by: "David Hilbert")[
  One must be able to say "tables, chairs, beer mugs" instead of "points, lines, planes."
]

// From "Recent Work on the Principles of Mathematics" (1901). Russell
// meant it admiringly, about formal abstraction — not as a put-down.
#epigraph(by: "Bertrand Russell")[
  Mathematics is the subject in which we never know what we are talking about.
]

// "Geometry and Experience" (1921). Excellent opener for a modeling
// chapter — it states the whole tension in one sentence.
#epigraph(by: "Albert Einstein")[
  As far as the laws of mathematics refer to reality, they are not certain;
  and as far as they are certain, they do not refer to reality.
]

#epigraph(by: "Carl Friedrich Gauss")[
  Mathematics is the queen of the sciences.
]

// The perfect provocation to place just before constructing the
// rationals, the reals, or the complex numbers.
#epigraph(by: "Leopold Kronecker")[
  God made the integers; all else is the work of man.
]

#epigraph(by: "G. H. Hardy")[
  A mathematician, like a painter or a poet, is a maker of patterns.
]

#epigraph(by: "G. H. Hardy")[
  There is no permanent place in the world for ugly mathematics.
]

#epigraph(by: "Karl Weierstrass")[
  A mathematician who is not also something of a poet will never be a complete mathematician.
]

// Wigner's 1960 paper title, still the best one-line statement of
// the mystery. Good in a modeling or physics-adjacent chapter.
#epigraph(by: "Eugene Wigner")[
  The unreasonable effectiveness of mathematics in the natural sciences.
]

#epigraph(by: "Galileo Galilei")[
  The universe is written in the language of mathematics.
]

#epigraph(by: "Sofia Kovalevskaya")[
  It is impossible to be a mathematician without being a poet in soul.
]


// ────────────────────────────────────────────────────────────
//  §2  LEARNING, STRUGGLE, AND TEACHING
//  Your anti-fatalism and productive-struggle themes live here.
// ────────────────────────────────────────────────────────────

#epigraph(by: "Paul Halmos")[
  The only way to learn mathematics is to do mathematics.
]

// Pólya, "How to Solve It" — arguably the single most useful
// sentence in the entire heuristic toolbox.
#epigraph(by: "George Pólya")[
  If you cannot solve a problem, there is an easier problem you can solve: find it.
]

#epigraph(by: "George Pólya")[
  There is a grain of discovery in the solution of any problem.
]

// Struggle reframed as the method rather than as evidence of
// unfitness — a direct hit on math fatalism.
#epigraph(by: "André Weil")[
  Every mathematician worthy of the name has experienced that lucid exaltation
  in which one thought succeeds another as if by miracle.
]

// Widely quoted, no solid primary source. A good specimen to hand
// students when teaching them to check before believing.
#epigraph(by: "attributed to Albert Einstein")[
  It is not that I am so smart, it is just that I stay with problems longer.
]

#epigraph(by: "attributed to Aristotle")[
  The roots of education are bitter, but the fruit is sweet.
]

#epigraph(by: "Marie Curie")[
  Nothing in life is to be feared, it is only to be understood.
]

#epigraph(by: "Jean Piaget")[
  The principal goal of education is to create people capable of doing new things.
]

#epigraph(by: "William Thurston")[
  Mathematics is not about numbers, equations, or algorithms: it is about understanding.
]

#epigraph(by: "Seymour Papert")[
  You can't think about thinking without thinking about thinking about something.
]


// ────────────────────────────────────────────────────────────
//  §3  PROOF, RIGOR, AND BEING WRONG
// ────────────────────────────────────────────────────────────

// Fermat's margin note, translated from the Latin. The single best
// easter egg in mathematics, and it belongs in a proofs chapter.
#epigraph(by: "Pierre de Fermat, in a book margin, c. 1637")[
  I have discovered a truly marvelous proof of this,
  which this margin is too narrow to contain.
]

// Genuine Knuth, from a 1977 memo. Perfect for the moment a student
// says "but it should work."
#epigraph(by: "Donald Knuth")[
  Beware of bugs in the above code; I have only proved it correct, not tried it.
]

#epigraph(by: "Edsger W. Dijkstra")[
  Testing shows the presence, not the absence, of bugs.
]

// Pauli demolishing a paper too confused to even be checked. Teaches
// a real distinction: false versus unfalsifiable.
#epigraph(by: "attributed to Wolfgang Pauli")[
  That is not only not right; it is not even wrong.
]

// On the gap between finding a result and being able to justify it.
#epigraph(by: "Carl Friedrich Gauss")[
  I have had my results for a long time,
  but I do not yet know how I am to arrive at them.
]

// Erdős's "Book" — God's collection of the perfect proofs.
#epigraph(by: "Paul Erdős")[
  You don't have to believe in God, but you should believe in The Book.
]

// Reported second-hand through Wigner and later Zukav; no written
// source of von Neumann's own. Consoling for a hard chapter.
#epigraph(by: "attributed to John von Neumann")[
  Young man, in mathematics you don't understand things. You just get used to them.
]

#epigraph(by: "Andrew Wiles")[
  Doing mathematics is like a journey through a dark unexplored mansion.
]


// ────────────────────────────────────────────────────────────
//  §4  INFINITY AND THE STRANGE
// ────────────────────────────────────────────────────────────

#epigraph(by: "Georg Cantor")[
  The essence of mathematics lies in its freedom.
]

// Hilbert defending Cantor's transfinite numbers against the finitists.
#epigraph(by: "David Hilbert")[
  No one shall expel us from the paradise that Cantor has created.
]

// Gauss taking precisely the opposite side. Run the two together and
// you have a ready-made classroom argument about completed infinities.
#epigraph(by: "Carl Friedrich Gauss")[
  I protest against the use of infinite magnitude as something completed;
  this is never permissible in mathematics.
]

#epigraph(by: "David Hilbert")[
  The infinite! No other question has ever moved so profoundly the spirit of man.
]

// His own proposed epitaph, now on his tombstone in Göttingen:
// "Wir müssen wissen. Wir werden wissen." Bittersweet — Gödel's
// incompleteness results landed the following year.
#epigraph(by: "David Hilbert")[
  We must know. We will know.
]


// ────────────────────────────────────────────────────────────
//  §5  COMPUTER SCIENCE
// ────────────────────────────────────────────────────────────

#epigraph(by: "Edsger W. Dijkstra")[
  Computer science is no more about computers than astronomy is about telescopes.
]

// Dijkstra's reframing of the Turing-test question. A superb prompt
// for AI literacy: what is the submarine actually doing?
#epigraph(by: "Edsger W. Dijkstra")[
  The question of whether machines can think
  is about as relevant as the question of whether submarines can swim.
]

// Genuinely Knuth's own words (1974), despite the durable folklore
// that he was quoting Hoare. Knuth himself later called it "Hoare's
// dictum," which is probably how the myth started.
#epigraph(by: "Donald Knuth")[
  Premature optimization is the root of all evil.
]

// Karlton said this at Carnegie Mellon around 1970. It went
// unrecorded for decades and surfaced online only in the late 1990s.
#epigraph(by: "Phil Karlton")[
  There are only two hard things in computer science:
  cache invalidation and naming things.
]

// Bambrick's riff — funnier if you place it a page or two AFTER the
// Karlton original, so the joke has to be reconstructed.
#epigraph(by: "Leon Bambrick")[
  There are two hard problems in computer science:
  cache invalidation, naming things, and off-by-one errors.
]

#epigraph(by: "Richard Hamming")[
  The purpose of computing is insight, not numbers.
]

// Hopper kept a clock on her wall that ran counterclockwise, to make
// the point that nothing forces the usual direction.
#epigraph(by: "attributed to Grace Hopper")[
  The most damaging phrase in the language is: we've always done it this way.
]

// The closing line of "Computing Machinery and Intelligence" (1950).
// A lovely note on which to end an entire unit.
#epigraph(by: "Alan Turing")[
  We can only see a short distance ahead,
  but we can see plenty there that needs to be done.
]

#epigraph(by: "Alan Perlis")[
  A language that doesn't affect the way you think about programming is not worth knowing.
]

#epigraph(by: "Fred Brooks")[
  Adding manpower to a late software project makes it later.
]

// Cargill's ninety-ninety rule — the honest estimate for any project.
#epigraph(by: "Tom Cargill")[
  The first 90 percent of the code takes 90 percent of the time.
  The remaining 10 percent takes the other 90 percent.
]

#epigraph(by: "John von Neumann")[
  Anyone who considers arithmetical methods of producing random digits is in a state of sin.
]


// ────────────────────────────────────────────────────────────
//  §6  TECHNOLOGY — FUNNY AND CAUTIONARY
//  Several of these do double duty as AI-literacy prompts.
// ────────────────────────────────────────────────────────────

// The best one-sentence argument for AI literacy ever written, and it
// predates the technology it now describes. Strong chapter opener.
#epigraph(by: "Sydney J. Harris")[
  The real danger is not that computers will begin to think like men,
  but that men will begin to think like computers.
]

#epigraph(by: "Arthur C. Clarke")[
  Any sufficiently advanced technology is indistinguishable from magic.
]

#epigraph(by: "attributed to Pablo Picasso")[
  Computers are useless. They can only give you answers.
]

#epigraph(by: "attributed to Bill Vaughan")[
  To err is human, but to really foul things up you need a computer.
]

// Hammerbacher, an early Facebook data scientist, in 2011.
#epigraph(by: "Jeff Hammerbacher")[
  The best minds of my generation are thinking about how to make people click ads.
]

// Goodhart's law in Strathern's phrasing. Applies to grades and exam
// scores as squarely as to economics — worth letting students notice.
#epigraph(by: "Marilyn Strathern, after Charles Goodhart")[
  When a measure becomes a target, it ceases to be a good measure.
]

// Caption of Peter Steiner's 1993 New Yorker cartoon. It reads very
// differently in the age of generated text and images.
#epigraph(by: "Peter Steiner, cartoon caption, 1993")[
  On the Internet, nobody knows you're a dog.
]

#epigraph(by: "attributed to Alan Kay")[
  Technology is anything that wasn't around when you were born.
]

// Weizenbaum built ELIZA to show how shallow the trick was, and was
// alarmed when people confided in it anyway. Pair with an ai-box.
#epigraph(by: "Joseph Weizenbaum")[
  Extremely short exposures to a relatively simple computer program
  could induce powerful delusional thinking in quite normal people.
]

#epigraph(by: "Douglas Adams")[
  We are stuck with technology when what we really want is just stuff that works.
]

#epigraph(by: "attributed to Steve Wozniak")[
  Never trust a computer you can't throw out a window.
]


// ────────────────────────────────────────────────────────────
//  §7  FAMOUSLY WRONG, FAMOUSLY MISATTRIBUTED
//
//  Two lessons in one. The predictions show that confident experts
//  get the future wrong; the attributions show that confident
//  sources get the past wrong. Consider an exploration in which
//  students try to source these themselves — most collections
//  online reproduce all of them uncritically.
// ────────────────────────────────────────────────────────────

// IBM's own historical FAQ says this is a garbled version of a 1953
// stockholders' meeting remark: Watson Jr. said they had expected
// orders for five IBM 701 machines and came home with eighteen. No
// primary source for the famous version has ever surfaced.
#epigraph(by: "misattributed to Thomas J. Watson, IBM")[
  I think there is a world market for maybe five computers.
]

// Gates has denied this repeatedly and pointedly: no citation has
// ever been produced, and the earliest print appearances date from
// the late 1980s — years after he supposedly said it in 1981.
#epigraph(by: "misattributed to Bill Gates")[
  640K ought to be enough for anybody.
]

// This one is real. Olsen, founder of Digital Equipment Corporation,
// said it in 1977, though he later argued he had meant home-
// automation mainframes rather than personal computers.
#epigraph(by: "Ken Olsen, 1977")[
  There is no reason anyone would want a computer in their home.
]

// The perfect closing joke for this section, and for the collection.
#epigraph(by: "Abraham Lincoln")[
  The problem with quotes on the Internet is that it is hard to verify their authenticity.
]


// ────────────────────────────────────────────────────────────
//  §8  STATISTICS AND BEING FOOLED BY DATA
// ────────────────────────────────────────────────────────────

// The whole philosophy of modeling in seven words.
#epigraph(by: "George Box")[
  All models are wrong, but some are useful.
]

// Twain credited Disraeli; no one has found it in Disraeli. The
// attribution chain is itself an illustration of the point.
#epigraph(by: "attributed by Mark Twain to Benjamin Disraeli")[
  There are three kinds of lies: lies, damned lies, and statistics.
]

#epigraph(by: "attributed to Ronald Coase")[
  If you torture the data long enough, it will confess to anything.
]

// Segal's law — a genuinely useful thought about measurement error.
#epigraph(by: "Segal's law")[
  A man with a watch knows what time it is.
  A man with two watches is never sure.
]

// Almost universally credited to Einstein; actually the sociologist
// William Bruce Cameron, in 1963. Another specimen for §7 treatment.
#epigraph(by: "William Bruce Cameron, not Einstein")[
  Not everything that counts can be counted,
  and not everything that can be counted counts.
]

#epigraph(by: "Andrew Lang")[
  He uses statistics as a drunken man uses lamp-posts —
  for support rather than illumination.
]


// ────────────────────────────────────────────────────────────
//  §9  GEEKY OBSERVATIONS AND JOKES
// ────────────────────────────────────────────────────────────

#epigraph(by: "old joke")[
  There are 10 kinds of people in the world:
  those who understand binary, and those who don't.
]

// Octal 31 equals decimal 25. Drop this into a number-bases lesson
// and wait — the delay before anyone laughs is the whole point.
#epigraph(by: "old joke")[
  Why do programmers confuse Halloween and Christmas? Because Oct 31 equals Dec 25.
]

// Pascal, "Lettres provinciales" (1657). The original argument that
// concision is expensive — useful when marking verbose solutions.
#epigraph(by: "Blaise Pascal")[
  I have made this letter longer than usual because I lack the time to make it shorter.
]

#epigraph(by: "Murphy's law")[
  Anything that can go wrong will go wrong.
]

// From "Gödel, Escher, Bach." Self-referential, so it belongs
// equally well in §15.
#epigraph(by: "Douglas Hofstadter")[
  It always takes longer than you expect,
  even when you take into account Hofstadter's law.
]

// A genuinely reliable heuristic and a fine media-literacy egg.
#epigraph(by: "Betteridge's law of headlines")[
  Any headline that ends in a question mark can be answered by the word "no."
]

// Softened here; Sturgeon's original noun was blunter.
#epigraph(by: "Theodore Sturgeon")[
  Ninety percent of everything is rubbish.
]

// Erdős's private vocabulary: children were "epsilons," alcohol was
// "poison," to "leave" was to die, and to "die" was to stop doing
// mathematics. Charming, and quietly a lesson about defining terms.
#epigraph(by: "Paul Erdős's private vocabulary")[
  To "die" is to stop doing mathematics. To "leave" is to die.
]

#epigraph(by: "old joke")[
  A topologist is someone who cannot tell a coffee mug from a doughnut.
]

// Reads the same backwards — worth having students verify by hand.
#epigraph(by: "a palindrome")[
  Never odd or even.
]

#epigraph(by: "attributed to Leigh Mercer, 1948")[
  A man, a plan, a canal: Panama.
]

// Rényi's line, popularized so relentlessly by Erdős that it is now
// almost always credited to him instead.
#epigraph(by: "Alfréd Rényi, popularized by Paul Erdős")[
  A mathematician is a machine for turning coffee into theorems.
]


// ────────────────────────────────────────────────────────────
//  §10  CREATIVE INSULTS
//
//  CLASSROOM NOTE: these work as easter eggs precisely because they
//  are aimed at arguments, proofs, and code — never at a student.
//  Used on a person, a witty insult is still an insult, and it lands
//  hardest on exactly the students whose confidence is most fragile.
//  Setting one beside a deliberately broken proof ("what would Pauli
//  say about this argument?") gets the laugh and the lesson at once.
// ────────────────────────────────────────────────────────────

// ---- Shakespeare: public domain, and the gold standard ----

#epigraph(by: "Shakespeare, As You Like It")[
  I do desire we may be better strangers.
]

#epigraph(by: "Shakespeare, Troilus and Cressida")[
  He has not so much brain as ear-wax.
]

#epigraph(by: "Shakespeare, Coriolanus")[
  More of your conversation would infect my brain.
]

#epigraph(by: "Shakespeare, Henry IV, Part 1")[
  Thou clay-brained guts, thou knotty-pated fool.
]

#epigraph(by: "Shakespeare, Cymbeline")[
  Thy tongue outvenoms all the worms of Nile.
]

#epigraph(by: "Shakespeare, The Taming of the Shrew")[
  Away, you three-inch fool!
]

#epigraph(by: "Shakespeare, Richard III")[
  Thou lump of foul deformity.
]

// ---- Academic and mathematical put-downs ----

// The classic reviewer's dismissal. Aim it at a circular proof.
#epigraph(by: "attributed to Samuel Johnson")[
  Your manuscript is both good and original; but the part that is good
  is not original, and the part that is original is not good.
]

#epigraph(by: "attributed to Wolfgang Pauli")[
  So young, and already so unknown.
]

#epigraph(by: "John von Neumann")[
  There's no sense in being precise when you don't even know what you're talking about.
]

// Hilbert on a student who abandoned mathematics for poetry.
#epigraph(by: "attributed to David Hilbert")[
  He did not have enough imagination to become a mathematician.
]

// Dijkstra at his most gloriously unreasonable (EWD498, 1975). Reads
// today as period curmudgeonry about a programming language — worth
// a word of framing so nobody mistakes it for advice.
#epigraph(by: "Edsger W. Dijkstra, 1975")[
  The use of COBOL cripples the mind;
  its teaching should therefore be regarded as a criminal offense.
]


// ────────────────────────────────────────────────────────────
//  §11  WEIRD LANGUAGE — AMBIGUITY AND GARDEN PATHS
//
//  Pedagogically the strongest eggs here for an immersion classroom:
//  they show that English is genuinely hard, which quietly tells a
//  struggling non-native student that the difficulty is in the
//  language and not in them. They also set up the contrast that
//  mathematical notation exists to avoid — see §13.
// ────────────────────────────────────────────────────────────

// Your own example. Every "-ough" here is pronounced differently.
#epigraph(by: "four spellings, four sounds")[
  Through tough thorough thought, though.
]

// Grammatical. It means: bison from Buffalo whom bison from Buffalo
// bully, themselves bully bison from Buffalo.
#epigraph(by: "every word is the same word")[
  Buffalo buffalo Buffalo buffalo buffalo buffalo Buffalo buffalo.
]

// Punctuates to: James, while John had had "had," had had "had had";
// "had had" had had a better effect on the teacher.
#epigraph(by: "eleven consecutive identical words")[
  James while John had had had had had had had had had had had a better effect on the teacher.
]

#epigraph(by: "add the punctuation yourself")[
  That that is is that that is not is not is that it it is.
]

// Garden-path sentences: perfectly grammatical, but the reader
// commits to the wrong parse and has to back up. Exactly what a
// badly bracketed expression does.
#epigraph(by: "a garden-path sentence — read it twice")[
  The horse raced past the barn fell.
]

#epigraph(by: "a garden-path sentence — \"man\" is the verb")[
  The old man the boat.
]

// The canonical parsing-ambiguity example, used in early machine
// translation research. "Flies" and "like" swap word classes midway.
#epigraph(by: "attributed to Groucho Marx")[
  Time flies like an arrow; fruit flies like a banana.
]

// Chomsky's demonstration that a sentence can be perfectly
// grammatical and still mean nothing. An unbeatable prompt for
// discussing what a language model is actually doing.
#epigraph(by: "Noam Chomsky, 1957")[
  Colorless green ideas sleep furiously.
]

// Seven words, seven meanings — one per stressed word. Have students
// read it aloud seven times, then ask what stress marks look like in
// mathematical notation. They don't exist. That is the point.
#epigraph(by: "stress each word in turn")[
  I never said she stole my money.
]

// "gh" as in enough, "o" as in women, "ti" as in nation. Long
// credited to Shaw, with no evidence he ever wrote it.
#epigraph(by: "misattributed to George Bernard Shaw")[
  "Ghoti" is pronounced "fish."
]

// Contronyms — words that are their own opposites. A genuine hazard
// when reading English mathematics quickly.
#epigraph(by: "words that mean their own opposite")[
  To cleave is to split apart, and also to cling together.
]

#epigraph(by: "English has no committee")[
  Flammable and inflammable mean the same thing.
  Fat chance and slim chance mean the same thing.
]


// ────────────────────────────────────────────────────────────
//  §12  PUNCTUATION THAT CHANGES EVERYTHING
//
//  These pay off directly in §13: a comma is to a sentence what a
//  bracket is to an expression.
// ────────────────────────────────────────────────────────────

#epigraph(by: "one comma, two very different dinners")[
  Let's eat, Grandma. \
  Let's eat Grandma.
]

#epigraph(by: "same words, opposite meanings")[
  A woman, without her man, is nothing. \
  A woman: without her, man is nothing.
]

// The serial-comma argument in two lines.
#epigraph(by: "the case for the Oxford comma")[
  I'd like to thank my parents, Ayn Rand and God. \
  I'd like to thank my parents, Ayn Rand, and God.
]

// A real 2017 case: Maine dairy drivers won an overtime dispute
// worth about five million dollars because a list in the statute
// lacked a serial comma. Punctuation with a price tag.
#epigraph(by: "Oakhurst Dairy, Maine, 2017")[
  A missing comma in an overtime statute cost a dairy roughly five million dollars.
]

// The "million-dollar comma": a 2006 Canadian contract dispute
// between Rogers and Aliant turned on the placement of one comma
// in a termination clause.
#epigraph(by: "Rogers v. Aliant, 2006")[
  A single misplaced comma let one party cancel a contract years early.
]

// The panda joke, from the misprinted wildlife-guide entry.
#epigraph(by: "a badly punctuated wildlife guide")[
  The panda eats, shoots and leaves.
]


// ────────────────────────────────────────────────────────────
//  §13  NOTATION — WHERE MATH'S OWN LANGUAGE BETRAYS IT
//
//  The payoff section. Having shown that English is ambiguous,
//  these show that mathematical notation is too — merely ambiguous
//  in fewer and better-documented places. A good antidote to "math
//  is the one language with no exceptions."
// ────────────────────────────────────────────────────────────

// The viral one. There is no correct answer, only conventions: it is
// a badly written expression, and the honest response is to add
// brackets. Excellent first-week egg.
#epigraph(by: "there is no right answer, only conventions")[
  6 ÷ 2(1 + 2) = ?
]

// Genuinely inconsistent notation that every student meets and
// almost none question.
#epigraph(by: "the same superscript, two different jobs")[
  sin²x means (sin x)², but sin⁻¹x does not mean 1/(sin x).
]

#epigraph(by: "ask what the division bar covers")[
  Is a/bc equal to (a/b)·c, or to a/(b·c)?
]

// Worth an exploration: the equality is provable several ways, and
// disbelief in it is remarkably durable.
#epigraph(by: "true, and endlessly disputed")[
  0.999… = 1
]

#epigraph(by: "notation is a human invention")[
  The equals sign is younger than the printing press.
  Robert Recorde invented it in 1557.
]


// ────────────────────────────────────────────────────────────
//  §14  GERMAN–ENGLISH TRAPS FOR IMMERSION CLASSES
//
//  Not quotations — small bilingual landmines, in epigraph form
//  because a light touch lands better than a warning box. Each is a
//  real error Swiss students make in English-medium mathematics.
//  Better seeded one per chapter than clustered.
// ────────────────────────────────────────────────────────────

// The single most dangerous false friend in mathematics.
#epigraph(by: "a factor of one thousand, hiding in plain sight")[
  An English billion is a German Milliarde.
  A German Billion is an English trillion.
]

// Directly relevant to your num() helper and Swiss formatting.
#epigraph(by: "the same five characters, two different numbers")[
  In English, 1,000 is one thousand. In German, 1,000 is one.
]

#epigraph(by: "German distinguishes what English blurs")[
  Zahl is a number. Ziffer is a digit.
  English says "number" for both, and confusion follows.
]

// "Term" is a genuine, recurring source of trouble in immersion
// algebra: the German and English meanings do not line up.
#epigraph(by: "false friends in algebra")[
  A German Term is an English expression.
  An English term is one summand of it.
]

#epigraph(by: "the classic")[
  "Ich bekomme ein Steak" does not mean "I become a steak."
]

#epigraph(by: "eventuell means possibly, not eventually")[
  "Eventuell" promises a maybe. "Eventually" promises a yes, later.
]

// A quiet joke about the building the students are sitting in.
#epigraph(by: "you are sitting in a false friend")[
  In English, a gymnasium is a room with wall bars in it.
]

#epigraph(by: "one word, two meanings")[
  A Gerade is a straight line. A gerade Zahl is an even number.
]


// ────────────────────────────────────────────────────────────
//  §15  SELF-REFERENCE, PARADOX, AND AI-LITERACY EGGS
// ────────────────────────────────────────────────────────────

#epigraph(by: "the liar paradox, in four words")[
  This sentence is false.
]

// The informal shape of Gödel's first incompleteness theorem. Place
// it before the formal statement and let it sit there unexplained.
#epigraph(by: "Gödel, informally")[
  This statement cannot be proved.
]

// Russell's paradox in one question — it broke Frege's foundations.
#epigraph(by: "Russell's paradox")[
  Does the set of all sets that do not contain themselves contain itself?
]

// The Berry paradox: the phrase itself is under sixty letters, so it
// both does and does not define that number.
#epigraph(by: "the Berry paradox — count the letters")[
  The smallest positive integer not definable in under sixty letters.
]

#epigraph(by: "the barber paradox")[
  The barber shaves everyone who does not shave himself. Who shaves the barber?
]

// A modern egg with real teeth. Prompt injection in one line, and an
// invitation to ask why a system that cannot reliably tell
// instructions from data is a system to keep a hand on.
#epigraph(by: "the newest paradox")[
  Ignore all previous instructions.
]

// Pair with an ai-box. The point is not that the machine lies, but
// that fluency and correctness are separate properties.
#epigraph(by: "worth pinning above every screen")[
  A confident answer and a correct answer are not the same thing.
]
