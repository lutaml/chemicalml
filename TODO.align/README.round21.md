# Round 21 — XSD enums, reference resolution, TOML probe

This round adds the canonical enum source of truth, three
enum-validation constraints, a reference resolver for id-based
links, and a TOML round-trip probe.

## Files

- [80 — XSD enum constants](80-xsd-enum-constants.md)
- [81 — Enum validation constraints](81-enum-validation-constraints.md)
- [82 — Reference resolver](82-reference-resolver.md)
- [83 — TOML round-trip spec](83-toml-roundtrip.md)
- [84 — Final verification round 21](84-final-verification-round21.md)

## Outcomes

- `Chemicalml::Cml::Enums` — 31 frozen-Set constants matching every
  XSD simpleType that restricts to enumerations (orderType,
  stereoType, chiralityType, latticeType, matrixType, stateType,
  peakMultiplicityType, etc.). A spec parses the XSD and asserts
  every constant matches — drift is caught automatically.
- Three enum-validation constraints in the molecular convention
  (bond order, bond stereo, molecule chirality). Warning severity
  so extension values are flagged but not rejected. Each populates
  `Violation.value` with the offending literal.
- `Chemicalml::Cml::ReferenceResolver` walks a document, builds an
  id-index, and resolves `atomRefs2`/`atomRefs4`/`bondRefs`/`ref`
  to actual wire instances. `unresolved_refs` lists every missing
  target — a programmatic alternative to the constraint walker.
- TOML round-trip spec added (3 pending specs because the tomlib
  adapter isn't installed; will auto-resolve when tomlib is added
  to the Gemfile).
- Molecular convention now registers 26 constraints (up from 23).
- **452 examples, 0 failures, 3 pending** (TOML adapter pending).
  Zero forbidden patterns.
