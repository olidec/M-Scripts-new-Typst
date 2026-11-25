// config.typ — shared settings for the Equations booklet.
//
// optional-topics: set a topic to false to drop its whole chapter
// from every build (notes, sheets, solutions). Progress-table rows and
// goto-first links skip anything that is absent from the build.

#import "../../common/preamble.typ": *

#let optional-topics = (
  inequalities: true,
  absolute-value: true,
)

#let optional(topic, body) = if optional-topics.at(topic) { body }

// Basic text for GLF, high text for SPF. Works in checks and tables,
// unlike only-basic / only-high (which hide in sheet mode).
#let yr(basic, high) = context {
  if _level.get() == "basic" { basic } else { high }
}

// "Section 3.2 (p. 9)" for the first label that exists in this build.
#let goto-first(..lbls) = context {
  let l = lbls.pos().find(l => query(l).len() > 0)
  if l == none { [the next chapter] } else { goto(l) }
}
