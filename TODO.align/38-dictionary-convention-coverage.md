# 38 — Dictionary convention: full upstream constraint coverage

## Why

`reference-docs/conventions/dictionary.md` requires namespace,
definition children, id patterns, and unitType/units co-constraints.
Currently 2 of 7 rules enforced.

## Current constraints (2)

EntryMustHaveIdAndTerm, EntryIdsUniqueWithinDictionary.

## Missing rules

- `dictionary` MUST have `namespace` attribute.
- `dictionary` `namespace` SHOULD end with `/` or `#` (warning).
- `entry` MUST contain a single `definition` child.
- `entry` `id` MUST match `[A-Za-z][A-Za-z0-9._-]*`.
- `entry` MUST have `unitType` attribute.
- If `unitType` is `unknown`, `units` MUST NOT be present.
- If `unitType` is `none`, `units` MUST be present and point to
  `http://www.xml-cml.org/unit/si#none`.

## Implementation

New files under
`lib/chemicalml/convention/dictionary/constraints/`, registered in
`lib/chemicalml/convention/dictionary.rb`.

## Acceptance

- 7 new constraint classes registered.
- Per-class spec under `spec/chemicalml/convention/dictionary/`.
- Full suite still green.
