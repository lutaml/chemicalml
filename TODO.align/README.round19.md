# Round 19 — JSON wire names, Schema24 workaround attempts, matrix coverage

This round directly addresses the user's question about `key_value`
blocks for JSON/YAML, and continues closing coverage gaps.

## Files

- [75 — key_value mappings for JSON/YAML wire names](75-key-value-mappings.md)
- [76 — Schema24 parse workaround attempts](76-schema24-workaround.md)
- [77 — Convention coverage matrix spec](77-convention-coverage-matrix.md)
- [78 — Fixture coverage audit](78-fixture-audit.md)
- [79 — Final verification round 19](79-final-verification-round19.md)

## Outcomes

- **Answer to user's question**: previously NO, JSON output used
  Ruby snake_case names because no `key_value do ... end` blocks
  were declared. Added `Base::WireMappings` mixin with
  `auto_key_value_mapping!` class method — generates a parallel
  key_value mapping from the existing XML mappings. JSON now
  carries CML wire names (`elementType`, `atomArray`, `formalCharge`).
  Single source of truth — one wire name per attribute.
- **Schema24 nested-XML parse**: ROOT CAUSE FOUND AND FIXED in
  subsequent round (see TODO 76). The bug was a type-name collision:
  Schema24's legacy `<string>`/`<integer>`/`<float>` CML elements
  shadowed lutaml-model's primitive types in the schema24 context.
  Fixed by excluding these from type registration while keeping
  them as wire classes.
- **Convention coverage matrix spec**: 49 specs asserting all 8
  conventions have QName, namespace, >=1 constraint, a spec file,
  a Detection root role, and run detect_and_validate without
  raising. Adding a new convention without full coverage makes
  the matrix spec fail.
- **Fixed bug**: `CompchemModuleMustContainJobList` assumed
  `node.modules` was non-nil; now defensively handles nil.
- **New fixtures**: ethanol IR (spectroscopy), methane combustion
  (cascade), basic SI units (simpleUnit), ethanol parallel-array
  form (parallel_array), standard unit types (unitType-dictionary).
- **422 examples, 0 failures, 0 pending**. Zero forbidden patterns.
  (After TODO 76 fix: 423 examples, 0 failures.)
