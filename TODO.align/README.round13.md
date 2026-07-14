# TODO.align (round 13)

Critical data-loss fix + missing unit types/units + convention
constraint expansion.

| # | Workstream | Status |
|---|---|---|
| 46 | Add atom coordinates (x2/y2/x3/y3/z3/xFract/yFract/zFract) | complete |
| 47 | Add missing unit types + units | complete |
| 48 | Add 5 molecular convention constraints | complete |
| 49 | Final spec + lint pass | complete |

## Critical fix: Atom coordinates were silently dropped

The most important fix in this round: CML `<atom>` elements with
2D coordinates (x2, y2), 3D coordinates (x3, y3, z3), or fractional
coordinates (xFract, yFract, zFract) were being silently dropped
during parsing. This affected virtually every real-world CML file
that contains molecular structures.

Fixed by:
- Adding x2, y2, x3, y3, z3, xFract, yFract, zFract attributes to
  `Base::Atom` with `map_attribute` declarations.
- Adding matching fields to `Model::Atom` (canonical).
- Updating `atom_to_canonical` / `atom_from_canonical` translator
  rules to carry the coordinates through.

Verified: parsing `methanol.cml` now correctly preserves
`x3="-0.713"` through both wire parse and canonical translation.

## Missing unit types + units added

4 unit types referenced by the new dictionaries but not defined:
density, viscosity, surfaceTension, entropy.

10 non-SI units referenced but not defined:
g_cm3, Pa_s, N_m, D (debye), A3, kJ_mol, J_molK, eV,
angstrom2, angstrom3.

## Convention constraints expanded

5 new molecular convention constraints added:
- `AtomMustHaveId` — every atom must have an `id` attribute
- `AtomMustHaveElementType` — every atom must have `elementType`
- `BondMustHaveAtomRefs2` — every bond must have `atomRefs2`
- `BondMustHaveOrder` — every bond must have `order`
- `MoleculeMustHaveId` — every molecule must have `id`

Total molecular constraints: 8 (up from 3).

## Final metrics

- 188 examples, 0 failures
- 121 CML elements (full XSD coverage)
- 8 dictionaries (193+ total entries)
- 8 molecular convention constraints
- 12 total convention constraints (across 5 conventions)
- Atom coordinates fully round-trip (2D, 3D, fractional)
- 0 forbidden patterns
