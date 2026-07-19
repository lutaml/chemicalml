# 88 — Diverse real-world fixtures

## Why

Current fixtures cover basic structures (water, methanol, ethanol,
compchem, dictionary). Real CML documents have richer features:
bond stereo (wedge/hash), propertyList nesting, reaction mechanisms,
formulas, crystallographic lattices. Adding fixtures that exercise
these ensures the gem handles real-world CML.

## Work

Add fixtures under `spec/fixtures/schema3/`:
- `molecular/chiral_center_with_bond_stereo.cml` — bondStereo W/H
- `molecular/ethanol_with_properties.cml` — propertyList with scalars
- `molecular/ethanol_with_formula.cml` — formula concise
- `crystal/nacl_with_lattice.cml` — crystal + lattice + symmetry
- `reactions/diels_alder.cml` — reactionScheme with reactantList/productList

Round-trip each in a spec.

## Acceptance

- Each fixture parses without raising.
- The features it exercises (bondStereo, property, formula, lattice,
  reaction) round-trip.
