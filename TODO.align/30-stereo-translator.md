# 30 — Translator rules for stereo

**Status:** complete
**Depends on:** 28, 29

## Goal

Add Translator rules so stereo elements round-trip through the
canonical Model:

- `atom_parity_to_canonical` / `atom_parity_from_canonical`
- `bond_stereo_to_canonical` / `bond_stereo_from_canonical`

And wire them into `molecule_to_canonical` / `molecule_from_canonical`
so atoms and bonds carry their stereo children across the translation.

## Deliverables

- [ ] Translator methods for both elements, schema-aware via
      WireClassRegistry.
- [ ] `molecule_to_canonical` reads `cml_atom.atom_parity` and
      translates it.
- [ ] `molecule_from_canonical` writes the parity back to the wire atom.
- [ ] Same for bonds and `bond_stereo`.
- [ ] Spec round-tripping a chiral molecule through canonical.

## Acceptance

- Round-trip a chiral_center fixture through canonical preserves
      the atomParity value.
- Round-trip ethene_with_bond_stereo through canonical preserves
      the bondStereo.
