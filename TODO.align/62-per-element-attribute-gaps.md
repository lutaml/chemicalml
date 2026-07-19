# 62 — Per-element attribute gaps

## Why

XSD vs Ruby Base comparison reveals 53 (schema3) / 58 (schema24)
attribute declarations that are not yet modelled. They cluster across
20 elements. Most are 1-3 missing attributes; the parallel-array
attributes for atomArray/bondArray are split out into TODO 61.

## Gaps (after TODO 61 closes)

| Element | Missing |
|---|---|
| alternative | type |
| band | kpoint (schema24 only) |
| bond | atomRefs (singular, not atomRefs2) |
| cellParameter | error, type |
| cml (module) | fileId, version |
| eigen | orientation |
| entry | convention, title, columns, rows, length, minLength, maxLength, pattern, minExclusive, minInclusive, maxExclusive, maxInclusive, fractionDigits, totalDigits, whiteSpace (XSD facets) |
| isotope | spin |
| module | role, serial |
| molecule | formula |
| peakStructure | type |
| potential | form |
| reaction | format, role |
| reactionScheme | format, role, type |
| reactionStepList | format |
| relatedEntry | type (schema24 only) |
| spectrum | type |
| substance | id |
| substanceList | type |
| unitList | type |

## Work

For each row above, add `attribute :foo, :string` + `map_attribute "foo", to: :foo`
to the relevant `lib/chemicalml/cml/base/*.rb` module.

The 15 XSD facets on `entry` (columns, fractionDigits, etc.) are
genuine CML — they describe the data type the entry represents, and
are emitted by the upstream dictionary files. They are not internal
XSD noise.

## Acceptance

- XSD vs Ruby comparison reports 0 attribute gaps.
- Round-trip of an example with `entry/@pattern` etc. is preserved.
- Spec coverage for at least one new attribute on each touched element.
