# Round 18 — Convention detection, format coverage, robustness

This round closes convention-detection gaps, proves format-agnosticism
beyond XML, hardens the constraint walker, and enriches the violation
value-object.

## Files

- [68 — Detection coverage for all 8 conventions](68-detection-coverage.md)
- [69 — JSON / YAML round-trip proof](69-json-yaml-roundtrip.md)
- [70 — Iterative tree walker](70-iterative-walker.md)
- [71 — Enrich Violation with offending value](71-violation-value.md)
- [72 — Close remaining Schema24 child gaps](72-close-child-gaps.md)
- [73 — Document Schema24 nested-parse limitation](73-schema24-parse-limitation.md)
- [74 — Final verification round 18](74-final-verification-round18.md)

## Outcomes

- `Convention::Detection` recognises Spectrum, SpectrumList,
  ReactionScheme, ReactionList as convention-bearing roots.
- JSON and YAML round-trip specs prove the format-agnostic claim
  (lutaml-model applies XML mappings only to XML; JSON/YAML use Ruby
  snake_case names).
- The recursive walker in `Constraint#walk_nodes` is now an iterative
  worklist (DFS pre-order preserved) — a 200-deep Module chain walks
  without stack overflow.
- `Violation` carries an optional `value` field with the offending
  literal; three constraints populate it (AtomIdMustMatchPattern,
  PeakShouldHaveValues, UnitMustHavePower).
- ~25 additional Base modules gained element-specific children
  (reactiveCentre, sample, spectator, transitionState, substance,
  lattice, table, trow, zMatrix, symmetry, map, eigen, xaxis, yaxis)
  plus self-references on 10 recursive containers.
- Schema24 nested-XML parse limitation documented with a pending
  spec that will auto-resolve when lutaml-model fixes its
  TypeResolver context handling.
- 342 specs total, 0 failures, 2 pending. Zero forbidden patterns.
