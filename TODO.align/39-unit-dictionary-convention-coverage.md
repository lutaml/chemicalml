# 39 — Unit-dictionary convention: full upstream constraint coverage

## Why

`reference-docs/conventions/unit-dictionary.md` requires 8 attributes
on every `<unit>`. The gem currently ships 1 rule.

## Current constraints (1)

UnitMustHaveSymbolAndUnitType.

## Missing rules

- `unitList` MUST have `namespace` attribute.
- `unit` MUST have `id` (unique within unitList — already implied by
  pattern rules but enforce presence).
- `unit` MUST have `title` attribute.
- `unit` MUST have `parentSI` attribute.
- `unit` MUST have at least one of `multiplierToSI` or `constantToSI`.
- `unit` MUST contain a single `definition` child.
- `unitList` MUST contain at least one `unit` child.

## Implementation

NodeConstraint subclasses. Register in
`lib/chemicalml/convention/unit_dictionary.rb`.

## Acceptance

- 7 new constraint classes registered (some may consolidate with
  existing UnitMustHaveSymbolAndUnitType).
- Per-class spec under `spec/chemicalml/convention/unit_dictionary/`.
- Full suite still green.
