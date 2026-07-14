# 29 — Wire Atom/Bond to carry stereo children

**Status:** complete
**Depends on:** 28

## Goal

Today `Base::Atom` doesn't declare an `atom_parity` child attribute.
Same for `Base::Bond` and `bond_stereo`. So parsing a fixture with
`<atom><atomParity .../></atom>` silently drops the parity. Add the
child attributes to the Base mixins.

## Why

Without this, the wire classes can't represent stereo even though
their dedicated wire classes (AtomParity, BondStereo) exist.

## Deliverables

- [ ] `Base::Atom` declares `attribute :atom_parity, :atomParity`
      and `xml do map_element "atomParity", to: :atom_parity end`.
- [ ] `Base::Bond` declares `attribute :bond_stereo, :bondStereo`
      and `xml do map_element "bondStereo", to: :bond_stereo end`.
- [ ] Parse a fixture with `<atomParity>` and confirm it's loaded.
- [ ] Round-trip preserves the child.

## Acceptance

- Parsing `ethene_with_bond_stereo.cml` retains the bondStereo.
- Parsing `chiral_center.cml` retains the atomParity.
