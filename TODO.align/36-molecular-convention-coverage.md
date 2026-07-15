# 36 — Molecular convention: full upstream constraint coverage

## Why

`reference-docs/conventions/molecular.md` mandates more rules than the
gem currently enforces. The walker framework already exists; this is
purely additive constraint registration.

## Current constraints (13)

AtomArrayMustContainAtoms, AtomIdsUniqueWithinMolecule,
BondMustReferenceAtomsInSameMolecule, AtomMustHaveId,
AtomMustHaveElementType, BondMustHaveAtomRefs2, BondMustHaveOrder,
MoleculeMustHaveId, AtomCoordinatesMustBePaired,
PropertyMustHaveDictRef, ScalarMustHaveDataType,
BondOrderShouldNotBeNumeric, AtomIdMustMatchPattern.

## Missing rules per upstream spec

- `count` attribute MUST NOT appear on top-level molecules (only on
  children of another molecule).
- `atomArray` — at most one per molecule; mutually exclusive with
  child `<molecule>` elements.
- `bondArray` — at most one per molecule; mutually exclusive with
  child `<molecule>` elements.
- `bondStereo` value `W` or `H` MUST have `atomRefs2`, MUST NOT have
  `atomRefs4`.
- `bondStereo` value `C` or `T` MUST have `atomRefs4`, MUST NOT have
  `atomRefs2`.
- `bondStereo` value `other` MUST have `dictRef`.
- `bond` `id` MUST be unique within the eldest containing molecule.
- `bond` with `order="other"` MUST have `dictRef`.
- `atomArray` MUST be a child of `molecule` or `formula`.
- `bondArray` MUST be a child of `molecule`.

## Implementation

Each rule → one Constraint subclass + `register` call in
`lib/chemicalml/convention/molecular.rb`. New files autoloaded from
`lib/chemicalml/convention/molecular/constraints.rb`.

## Acceptance

- 10 new constraint classes registered.
- Per-class spec under `spec/chemicalml/convention/molecular/`.
- Full suite still green.
