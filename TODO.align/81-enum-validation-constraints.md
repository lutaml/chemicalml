# 81 — Enum validation constraints

## Why

With enum constants defined (TODO 80), add warning-severity
constraints that flag attribute values outside the XSD-declared
enum set. Warning (not error) because CML allows extension values.

## Work

Add constraints under the molecular convention (where most enum
attributes live):

1. `BondOrderShouldBeInEnum` (applies_to Role::Bond) — warning if
   `bond.order` not in `Cml::Enums::ORDER_VALUES`.
2. `BondStereoShouldBeInEnum` (applies_to Role::BondStereo) —
   warning if `bondStereo.value` not in `Cml::Enums::STEREO_VALUES`.
3. `MoleculeChiralityShouldBeInEnum` (applies_to Role::Molecule) —
   warning if `molecule.chirality` not in `Cml::Enums::CHIRALITY_VALUES`.
4. `LatticeTypeShouldBeInEnum` (applies_to Role::Lattice) —
   warning if not in `LATTICE_VALUES`.

Each constraint is registered against the molecular convention.

## Acceptance

- A bond with `order="X"` triggers a warning.
- A bond with `order="S"` passes silently.
- All existing specs pass.
