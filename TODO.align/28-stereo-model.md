# 28 — Model::AtomParity + Model::BondStereo

**Status:** complete
**Depends on:** —

## Goal

Add canonical Model classes for the CML stereo elements `<atomParity>`
and `<bondStereo>`. Wire classes exist; the canonical layer is
missing.

## Why

CML's molecular convention uses `<atomParity>` (atom-centre chirality)
and `<bondStereo>` (cis/trans + wedge/hatch) to represent
stereochemistry. Without canonical classes, the gem can parse these
elements but can't represent them in the format-agnostic model —
forcing callers to drop stereo info when going through canonical.

## Deliverables

- [ ] `lib/chemicalml/model/atom_parity.rb` — Model::AtomParity with
      `atom_refs4` (four atom IDs as array) and `value` (typically
      `"1"`, `"-1"`, `"0"`).
- [ ] `lib/chemicalml/model/bond_stereo.rb` — Model::BondStereo with
      `atom_refs2` (optional array), `atom_refs4` (optional array),
      `dict_ref` (optional), `value` (the convention letter: `"W"`,
      `"H"`, `"C"`, `"T"`, `"other"`).
- [ ] Both classes inherit from `Model::Node` and implement
      `value_attributes`.
- [ ] Autoloads declared in `lib/chemicalml/model.rb`.
- [ ] Specs.

## Acceptance

- `Chemicalml::Model::AtomParity.new(atom_refs4: %w[a1 a2 a3 a4], value: "1")`
      works.
- `Chemicalml::Model::BondStereo.new(atom_refs4: %w[a1 a2 a3 a4], value: "C")`
      works.
- Specs pass.
