// ============================================================
//  math-dictionary.typ — English–German math reference glossary
//
//  A standalone reference document (not a chapter, not tied to any
//  one unit) collecting the vocabulary a Gymnasium immersion student
//  needs across the curriculum, both GLF and SPF. Two sections near
//  the end (Complex Numbers, Conic Sections) are SPF-only content;
//  everything else is shared, though SPF sees more depth on several
//  of these topics (proof/induction, vectors, stochastics).
//
//  Placement: this file assumes it lives one level below src/, e.g.
//    src/reference/math-dictionary.typ
//  so the import below climbs one directory to reach src/common/.
//  If placed elsewhere, adjust the import path to match — same rule
//  as every other entry file in this project (see STYLE_GUIDE.md).
//
//  Compile standalone, e.g.:
//    typst compile --root . src/reference/math-dictionary.typ \
//      dist/reference/math-dictionary.pdf
//
//  Maintenance: add new entries to the relevant section's array
//  below (or a new section + register it in `all-sections`) as new
//  chapters introduce new vocab() terms. The master index at the
//  end is generated automatically from every section, so it never
//  needs separate editing.
// ============================================================

#import "../common/preamble.typ": *

#set-subject-name("Math Dictionary")

#set page(
  ..chapter-page-setup,
  header: context {
    set text(size: 9pt, fill: luma(120))
    grid(
      columns: (1fr, 1fr),
      align(left)[Math Dictionary — English–German],
      align(right)[Reference, all levels],
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

#show: apply-base-style

// ────────────────────────────────────────────────────────────
//  HELPERS
// ────────────────────────────────────────────────────────────
#let entry(en, de) = (en: en, de: de)

// One flowing two-column list of "term — translation" pairs,
// alphabetized by the English term. Same pattern as print-vocab()
// in preamble.typ, reused here so the look is consistent.
#let dict-entries(terms) = {
  let sorted = terms.sorted(key: t => lower(t.en))
  grid(
    columns: (1fr, 1fr),
    column-gutter: 1.6em,
    row-gutter: 0.45em,
    ..sorted.map(t => [#strong(t.en) — #emph(t.de)]),
  )
}

#let dict-section(title, terms, note: none) = [
  = #title
  #if note != none [
    #text(size: 9pt, fill: luma(110), style: "italic")[#note]
    #v(0.4em)
  ]
  #dict-entries(terms)
  #v(1em)
]

// ────────────────────────────────────────────────────────────
//  COVER
// ────────────────────────────────────────────────────────────
#align(center)[
  #v(2cm)
  #text(size: 24pt, weight: "bold", fill: accent)[Math Dictionary]
  #v(0.3em)
  #text(size: 14pt, fill: luma(90))[English–German Reference for Immersion Classes]
  #v(1.5em)
  #line(length: 40%, stroke: 0.5pt + accent)
  #v(1.5em)
  #block(width: 80%)[
    #set align(left)
    #set text(size: 10.5pt)
    This dictionary collects the English math vocabulary used in class,
    paired with the German term you will meet in other subjects, in
    German-language textbooks, and on German-language references
    online. It is organized by topic, the way a course builds up its
    vocabulary, with a single alphabetical index at the end for quick
    lookup.

    Terms belong to both GLF (Foundations) and SPF (Advanced) unless a
    section says otherwise. Two sections — Complex Numbers and Conic
    Sections — are SPF-only.

    This is a living reference: new terms get added as new topics come
    up in class.
  ]
]
#pagebreak()

#outline(title: [Contents], depth: 1)
#pagebreak()

// ────────────────────────────────────────────────────────────
//  1. NUMBERS & ARITHMETIC
// ────────────────────────────────────────────────────────────
#let sec-numbers = (
  entry("natural number", "natürliche Zahl"),
  entry("integer", "ganze Zahl"),
  entry("rational number", "rationale Zahl"),
  entry("irrational number", "irrationale Zahl"),
  entry("real number", "reelle Zahl"),
  entry("prime number", "Primzahl"),
  entry("even number", "gerade Zahl"),
  entry("odd number", "ungerade Zahl"),
  entry("fraction", "Bruch"),
  entry("numerator", "Zähler"),
  entry("denominator", "Nenner"),
  entry("decimal number", "Dezimalzahl"),
  entry("percentage", "Prozentsatz"),
  entry("ratio", "Verhältnis"),
  entry("proportion", "Proportion"),
  entry("sum", "Summe"),
  entry("difference", "Differenz"),
  entry("product", "Produkt"),
  entry("quotient", "Quotient"),
  entry("remainder", "Rest"),
  entry("absolute value", "Betrag"),
  entry("reciprocal", "Kehrwert"),
  entry("rounding", "Runden"),
  entry("greatest common divisor", "größter gemeinsamer Teiler"),
  entry("least common multiple", "kleinstes gemeinsames Vielfaches"),
)

// ────────────────────────────────────────────────────────────
//  2. SETS & LOGIC
// ────────────────────────────────────────────────────────────
#let sec-logic = (
  entry("set", "Menge"),
  entry("element", "Element"),
  entry("subset", "Teilmenge"),
  entry("union", "Vereinigung"),
  entry("intersection", "Schnittmenge"),
  entry("empty set", "leere Menge"),
  entry("interval", "Intervall"),
  entry("statement", "Aussage"),
  entry("proof", "Beweis"),
  entry("counterexample", "Gegenbeispiel"),
  entry("necessary condition", "notwendige Bedingung"),
  entry("sufficient condition", "hinreichende Bedingung"),
  entry("if and only if", "genau dann, wenn"),
  entry("contradiction", "Widerspruch"),
  entry("induction", "Induktion"),
  entry("converse", "Umkehrung"),
)

// ────────────────────────────────────────────────────────────
//  3. ALGEBRAIC FOUNDATIONS
// ────────────────────────────────────────────────────────────
#let sec-foundations = (
  entry("variable", "Variable"),
  entry("expression", "Term"),
  entry("equation", "Gleichung"),
  entry("term (of an expression)", "Summand / Term"),
  entry("coefficient", "Koeffizient"),
  entry("constant", "Konstante"),
  entry("like terms", "gleichartige Terme"),
  entry("expand", "ausmultiplizieren"),
  entry("simplify", "vereinfachen"),
  entry("distributive property", "Distributivgesetz"),
  entry("exponent", "Exponent"),
  entry("base (of a power)", "Basis"),
  entry("inequality", "Ungleichung"),
  entry("solution set", "Lösungsmenge"),
  entry("identity", "Identität"),
  entry("scientific notation", "wissenschaftliche Schreibweise"),
  entry("root", "Wurzel"),
  entry("factor", "faktorisieren"),
)

// ────────────────────────────────────────────────────────────
//  4. EQUATIONS & THE SOLVING TOOLKIT
// ────────────────────────────────────────────────────────────
#let sec-equations = (
  entry("linear equation", "lineare Gleichung"),
  entry("quadratic equation", "quadratische Gleichung"),
  entry("radical equation", "Wurzelgleichung"),
  entry("extraneous solution", "Scheinlösung"),
  entry("substitution", "Substitution"),
  entry("rearrange", "umformen"),
  entry("isolate the variable", "die Variable isolieren"),
  entry("check the solution", "die Lösung überprüfen"),
  entry("domain restriction", "Definitionsbereichseinschränkung"),
)

// ────────────────────────────────────────────────────────────
//  5. FUNCTIONS & GRAPHS
// ────────────────────────────────────────────────────────────
#let sec-functions = (
  entry("relation", "Relation"),
  entry("domain", "Definitionsbereich"),
  entry("range", "Wertebereich"),
  entry("function", "Funktion"),
  entry("inverse function", "Umkehrfunktion"),
  entry("independent variable", "unabhängige Variable"),
  entry("dependent variable", "abhängige Variable"),
  entry("graph", "Graph"),
  entry("coordinate system", "Koordinatensystem"),
  entry("origin", "Ursprung"),
  entry("increasing", "monoton wachsend"),
  entry("decreasing", "monoton fallend"),
  entry("maximum", "Maximum"),
  entry("minimum", "Minimum"),
  entry("symmetry", "Symmetrie"),
  entry("even function", "gerade Funktion"),
  entry("odd function", "ungerade Funktion"),
  entry("composition of functions", "Verkettung von Funktionen"),
  entry("piecewise function", "abschnittsweise definierte Funktion"),
  entry("continuous", "stetig"),
  entry("transformation (of a graph)", "Transformation (des Graphen)"),
)

// ────────────────────────────────────────────────────────────
//  6. LINEAR FUNCTIONS
// ────────────────────────────────────────────────────────────
#let sec-linear = (
  entry("linear function", "lineare Funktion"),
  entry("slope", "Steigung"),
  entry("y-intercept", "y-Achsenabschnitt"),
  entry("x-intercept", "x-Achsenabschnitt"),
  entry("point-slope form", "Punkt-Steigungs-Form"),
  entry("perpendicular", "senkrecht"),
  entry("parallel", "parallel"),
  entry("rate of change", "Änderungsrate"),
  entry("standard form", "Normalform"),
)

// ────────────────────────────────────────────────────────────
//  7. QUADRATIC FUNCTIONS & POLYNOMIALS
// ────────────────────────────────────────────────────────────
#let sec-quadratic = (
  entry("quadratic function", "quadratische Funktion"),
  entry("parabola", "Parabel"),
  entry("zeros", "Nullstellen"),
  entry("vertex", "Scheitelpunkt"),
  entry("axis of symmetry", "Symmetrieachse"),
  entry("completing the square", "quadratische Ergänzung"),
  entry("discriminant", "Diskriminante"),
  entry("polynomial", "Polynom"),
  entry("degree (of a polynomial)", "Grad"),
  entry("leading coefficient", "Leitkoeffizient"),
  entry("factorization", "Faktorisierung"),
  entry("quadratic formula", "Mitternachtsformel"),
  entry("vertex form", "Scheitelpunktform"),
  entry("double root", "doppelte Nullstelle"),
)

// ────────────────────────────────────────────────────────────
//  8. SYSTEMS OF EQUATIONS
// ────────────────────────────────────────────────────────────
#let sec-systems = (
  entry("system of linear equations", "lineares Gleichungssystem"),
  entry("elimination method", "Eliminationsverfahren"),
  entry("substitution method", "Einsetzungsverfahren"),
  entry("break-even point", "Gewinnschwelle"),
  entry("unique solution", "eindeutige Lösung"),
  entry("no solution", "keine Lösung"),
  entry("infinitely many solutions", "unendlich viele Lösungen"),
  entry("matrix", "Matrix"),
  entry("coefficient matrix", "Koeffizientenmatrix"),
)

// ────────────────────────────────────────────────────────────
//  9. POWERS, ROOTS, EXPONENTIALS & LOGARITHMS
// ────────────────────────────────────────────────────────────
#let sec-powers = (
  entry("power", "Potenz"),
  entry("power function", "Potenzfunktion"),
  entry("exponent law", "Potenzgesetz"),
  entry("asymptote", "Asymptote"),
  entry("square root", "Quadratwurzel"),
  entry("cube root", "Kubikwurzel"),
  entry("nth root", "n-te Wurzel"),
  entry("exponential function", "Exponentialfunktion"),
  entry("growth factor", "Wachstumsfaktor"),
  entry("exponential growth", "exponentielles Wachstum"),
  entry("exponential decay", "exponentieller Zerfall"),
  entry("decay factor", "Zerfallsfaktor"),
  entry("compound interest", "Zinseszins"),
  entry("half-life", "Halbwertszeit"),
  entry("logarithm", "Logarithmus"),
  entry("natural logarithm", "natürlicher Logarithmus"),
  entry("common logarithm", "dekadischer Logarithmus"),
  entry("logarithm laws", "Logarithmengesetze"),
  entry("change of base", "Basiswechsel"),
  entry("Euler's number", "Eulersche Zahl"),
)

// ────────────────────────────────────────────────────────────
//  10. SEQUENCES & SERIES
// ────────────────────────────────────────────────────────────
#let sec-sequences = (
  entry("sequence", "Folge"),
  entry("series", "Reihe"),
  entry("term (of a sequence)", "Glied"),
  entry("arithmetic sequence", "arithmetische Folge"),
  entry("geometric sequence", "geometrische Folge"),
  entry("common difference", "konstante Differenz"),
  entry("common ratio", "konstanter Quotient"),
  entry("recursive formula", "rekursive Formel"),
  entry("explicit formula", "explizite Formel"),
  entry("partial sum", "Partialsumme"),
  entry("convergence", "Konvergenz"),
  entry("divergence", "Divergenz"),
  entry("limit", "Grenzwert"),
)

// ────────────────────────────────────────────────────────────
//  11. GEOMETRY
// ────────────────────────────────────────────────────────────
#let sec-geometry = (
  entry("point", "Punkt"),
  entry("line", "Gerade"),
  entry("line segment", "Strecke"),
  entry("ray", "Strahl"),
  entry("angle", "Winkel"),
  entry("triangle", "Dreieck"),
  entry("right triangle", "rechtwinkliges Dreieck"),
  entry("congruent", "kongruent"),
  entry("similar", "ähnlich"),
  entry("perimeter", "Umfang"),
  entry("area", "Flächeninhalt"),
  entry("volume", "Volumen"),
  entry("circle", "Kreis"),
  entry("radius", "Radius"),
  entry("diameter", "Durchmesser"),
  entry("polygon", "Vieleck"),
  entry("quadrilateral", "Viereck"),
  entry("parallelogram", "Parallelogramm"),
  entry("theorem of Pythagoras", "Satz des Pythagoras"),
)

// ────────────────────────────────────────────────────────────
//  12. TRIGONOMETRY
// ────────────────────────────────────────────────────────────
#let sec-trig = (
  entry("sine", "Sinus"),
  entry("cosine", "Kosinus"),
  entry("tangent", "Tangens"),
  entry("unit circle", "Einheitskreis"),
  entry("radian", "Bogenmaß"),
  entry("degree (angle)", "Grad"),
  entry("period", "Periode"),
  entry("amplitude", "Amplitude"),
  entry("hypotenuse", "Hypotenuse"),
  entry("opposite side", "Gegenkathete"),
  entry("adjacent side", "Ankathete"),
  entry("law of sines", "Sinussatz"),
  entry("law of cosines", "Kosinussatz"),
)

// ────────────────────────────────────────────────────────────
//  13. VECTORS
// ────────────────────────────────────────────────────────────
#let sec-vectors = (
  entry("vector", "Vektor"),
  entry("magnitude", "Betrag"),
  entry("direction", "Richtung"),
  entry("position vector", "Ortsvektor"),
  entry("dot product", "Skalarprodukt"),
  entry("cross product", "Kreuzprodukt"),
  entry("unit vector", "Einheitsvektor"),
  entry("component", "Komponente"),
)

// ────────────────────────────────────────────────────────────
//  14. STATISTICS & PROBABILITY
// ────────────────────────────────────────────────────────────
#let sec-stats = (
  entry("data", "Daten"),
  entry("mean", "Mittelwert"),
  entry("median", "Median"),
  entry("mode", "Modus"),
  entry("standard deviation", "Standardabweichung"),
  entry("variance", "Varianz"),
  entry("probability", "Wahrscheinlichkeit"),
  entry("random variable", "Zufallsvariable"),
  entry("event", "Ereignis"),
  entry("sample space", "Ergebnisraum"),
  entry("combination", "Kombination"),
  entry("permutation", "Permutation"),
  entry("distribution", "Verteilung"),
  entry("histogram", "Histogramm"),
  entry("box plot", "Boxplot"),
)

// ────────────────────────────────────────────────────────────
//  15. CALCULUS (INTRODUCTORY)
// ────────────────────────────────────────────────────────────
#let sec-calculus = (
  entry("derivative", "Ableitung"),
  entry("differentiate", "ableiten"),
  entry("tangent line", "Tangente"),
  entry("integral", "Integral"),
  entry("antiderivative", "Stammfunktion"),
  entry("area under the curve", "Fläche unter der Kurve"),
  entry("instantaneous rate of change", "momentane Änderungsrate"),
)

// ────────────────────────────────────────────────────────────
//  16. COMPLEX NUMBERS
// ────────────────────────────────────────────────────────────
#let sec-complex = (
  entry("complex number", "komplexe Zahl"),
  entry("imaginary unit", "imaginäre Einheit"),
  entry("imaginary part", "Imaginärteil"),
  entry("real part", "Realteil"),
  entry("complex conjugate", "konjugiert komplexe Zahl"),
  entry("modulus", "Betrag"),
  entry("argument", "Argument"),
  entry("polar form", "Polarform"),
)

// ────────────────────────────────────────────────────────────
//  17. CONIC SECTIONS
// ────────────────────────────────────────────────────────────
#let sec-conics = (
  entry("conic section", "Kegelschnitt"),
  entry("ellipse", "Ellipse"),
  entry("hyperbola", "Hyperbel"),
  entry("focus (of a conic)", "Brennpunkt"),
  entry("directrix", "Leitlinie"),
  entry("eccentricity", "Exzentrizität"),
  entry("vertex (of a conic)", "Scheitel"),
)

// ────────────────────────────────────────────────────────────
//  18. COMMAND WORDS (exam & instruction language)
// ────────────────────────────────────────────────────────────
#let sec-commands = (
  entry("solve", "lösen"),
  entry("calculate", "berechnen"),
  entry("determine", "bestimmen"),
  entry("show that", "zeigen, dass"),
  entry("prove", "beweisen"),
  entry("justify", "begründen"),
  entry("sketch", "skizzieren"),
  entry("plot", "zeichnen"),
  entry("state", "angeben"),
  entry("explain", "erklären"),
  entry("interpret", "interpretieren"),
  entry("verify", "überprüfen"),
  entry("estimate", "schätzen"),
  entry("compare", "vergleichen"),
  entry("describe", "beschreiben"),
  entry("derive", "herleiten"),
  entry("hence", "daher"),
  entry("given that", "gegeben, dass"),
  entry("round to", "runden auf"),
)

// ────────────────────────────────────────────────────────────
//  SECTIONS
// ────────────────────────────────────────────────────────────
#dict-section("Numbers & Arithmetic", sec-numbers)
#dict-section("Sets & Logic", sec-logic)
#dict-section("Algebraic Foundations", sec-foundations)
#dict-section("Equations & the Solving Toolkit", sec-equations)
#dict-section("Functions & Graphs", sec-functions)
#dict-section("Linear Functions", sec-linear)
#dict-section("Quadratic Functions & Polynomials", sec-quadratic)
#dict-section("Systems of Equations", sec-systems)
#dict-section("Powers, Roots, Exponentials & Logarithms", sec-powers)
#dict-section("Sequences & Series", sec-sequences)
#dict-section("Geometry", sec-geometry)
#dict-section("Trigonometry", sec-trig)
#dict-section(
  "Vectors",
  sec-vectors,
  note: "Shared topic; SPF goes into more depth.",
)
#dict-section("Statistics & Probability", sec-stats)
#dict-section(
  "Calculus (Introductory)",
  sec-calculus,
  note: "Depth varies by level and by year — check the current syllabus.",
)
#dict-section("Complex Numbers", sec-complex, note: "SPF / Advanced only.")
#dict-section("Conic Sections", sec-conics, note: "SPF / Advanced only.")
#dict-section("Command Words", sec-commands, note: [
  The verbs that show up in exercise and exam instructions — knowing
  these cold saves time under pressure.
])

// ────────────────────────────────────────────────────────────
//  MASTER ALPHABETICAL INDEX
// ────────────────────────────────────────────────────────────
#pagebreak()
#let all-sections = (
  sec-numbers, sec-logic, sec-foundations, sec-equations, sec-functions,
  sec-linear, sec-quadratic, sec-systems, sec-powers, sec-sequences,
  sec-geometry, sec-trig, sec-vectors, sec-stats, sec-calculus,
  sec-complex, sec-conics, sec-commands,
)
#let all-terms = all-sections.flatten()

#let index-terms = {
  let seen = ()
  let unique = ()
  for t in all-terms {
    let key = lower(t.en)
    if not seen.contains(key) {
      seen.push(key)
      unique.push(t)
    }
  }
  unique
}

= Alphabetical Index
#text(size: 9pt, fill: luma(110), style: "italic")[
  Every term above, in one alphabetized list — #index-terms.len() entries
  in total. If a term appears in more than one topic section, only its
  first occurrence is listed here; use the section headings above for
  topic context.
]
#v(0.6em)
#dict-entries(index-terms)
