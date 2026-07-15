# 47 — Wire Molecule#crystal/spectra/property_lists through translator

## Why

`Base::Molecule` declares `crystal`, `spectra`, `property_lists`
children, but `Model::Molecule` doesn't have those fields and
`molecule_to_canonical/from_canonical` silently drops them. Silent
data loss.

## Fix

1. Add `crystal`, `spectra`, `property_lists` accessors to
   `Model::Molecule`.
2. Wire through `molecule_to_canonical` (read wire, build Model) and
   `molecule_from_canonical` (read Model, build wire).
3. Update `Model::Molecule#children` and `#value_attributes`.
4. Spec round-trip with a molecule containing crystal + propertyList.

## Acceptance

- A molecule with `<crystal>` and `<propertyList>` children round-trips
  through canonical without loss.
- Full suite green.
