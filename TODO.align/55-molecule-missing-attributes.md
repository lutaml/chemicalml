# 55 — Fix Model::Molecule missing attributes (correctness)

## Why

`Base::Molecule` declares `spin_multiplicity`, `dict_ref`,
`convention`, `chirality` attributes, but `Model::Molecule` doesn't
have them and the translator drops them silently. These are
chemically important (chirality in particular).

## Fix

Add `spin_multiplicity`, `dict_ref`, `convention`, `chirality` to
`Model::Molecule`. Update translator molecule_to_canonical and
molecule_from_canonical to map them.

## Acceptance

- All 4 attributes round-trip through translator.
- Existing specs unchanged.
- Full suite green.
