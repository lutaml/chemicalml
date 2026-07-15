# 42 — Wire new Model classes through the translator

## Why

New `Model::*` classes from TODO 41 are inert until the translator
maps them to/from CML wire format.

## Translator additions

- `molecule_to_canonical`: include `crystal`, `spectra`,
  `spectra_lists`, `z_matrix`, `isotope_list`, `sample` fields.
- `molecule_from_canonical`: reverse of above.
- New helpers: `crystal_to/from_canonical`,
  `lattice_to/from_canonical`, `spectrum_to/from_canonical`,
  `peak_to/from_canonical`, `z_matrix_to/from_canonical`,
  `isotope_to/from_canonical`, `sample_to/from_canonical`,
  `reaction_scheme_to/from_canonical`, `spectator_to/from_canonical`.
- `module_to_canonical`: stop hardcoding `lists: []` — collect
  `<list>` children into Model::List collection.

## Implementation

All schema-aware (take `schema:` keyword). Use `WireClassRegistry`
for every wire class lookup. Add to existing
`translator.rb` + `translator/value_translations.rb`.

## Acceptance

- Round-trip spec: parse CML with crystal/spectrum/zMatrix →
  Model → serialize → same CML (canon-compared).
- Full suite still green.
