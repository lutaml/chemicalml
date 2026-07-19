# Round 17 — XSD gap closure

This round closes the remaining XSD-declared feature gaps in the gem.
Started from a clean XSD-vs-Ruby comparison and worked through each
cluster.

## Files

- [61 — Parallel-array attrs for atomArray/bondArray](61-parallel-array-attrs.md)
- [62 — Per-element attribute gaps](62-per-element-attribute-gaps.md)
- [63 — Universal children mixin](63-universal-children-mixin.md)
- [64 — Per-element child element gaps (Schema 2.4)](64-per-element-child-gaps.md)
- [65 — SimpleUnit convention](65-simple-unit-convention.md)
- [66 — Schema24-only legacy element children](66-schema24-legacy-children.md)
- [67 — Final spec/lint/docs verification](67-final-verification.md)

## Outcomes

- Schema3 XSD: **0 attribute gaps, 0 child gaps** (excluding `<anyCml>`
  wildcard, which is intentionally not modelled as a concrete child).
- Schema24 XSD: **0 attribute gaps**; child gaps reduced from 235 to
  ~140 element-specific declarations, with ~80% of the universal
  children (metadataList/label/name/description) absorbed by the new
  `CommonChildren` mixin.
- 8 conventions now registered (was 5 at start of round): molecular,
  compchem, dictionary, unit-dictionary, unitType-dictionary,
  spectroscopy, cascade, simpleUnit.
- 300 specs total, 0 failures, 0 forbidden patterns.
