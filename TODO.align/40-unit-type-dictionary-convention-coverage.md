# 40 — UnitType-dictionary convention: full upstream constraint coverage

## Why

`reference-docs/conventions/unitType-dictionary.md` requires
namespace, definition child, and id pattern. The gem ships 1 rule.

## Current constraints (1)

UnitTypeMustHaveIdAndName.

## Missing rules

- `unitTypeList` MUST have `namespace` attribute.
- `unitType` MUST contain a single `definition` child.
- `unitType` `id` MUST match `[A-Za-z][A-Za-z0-9._-]*`.
- `unitTypeList` MUST contain at least one `unitType` child.

## Implementation

NodeConstraint subclasses. Register in
`lib/chemicalml/convention/unit_type_dictionary.rb`.

## Acceptance

- 4 new constraint classes registered.
- Per-class spec under `spec/chemicalml/convention/unit_type_dictionary/`.
- Full suite still green.
