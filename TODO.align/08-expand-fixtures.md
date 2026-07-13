# 08 — Expand fixtures corpus

**Status:** complete
**Depends on:** 02

## Goal

Grow the fixture corpus so it covers the breadth of CML: stereo,
parity, properties, parameters, modules, dictionaries, units,
crystals, lattices. Each fixture exercises one feature so a regression
is easy to localize.

## Deliverables

Add the following seed fixtures under `spec/fixtures/`:

- [ ] `schema3/molecular/ethene_with_bond_stereo.cml` — cis/trans
- [ ] `schema3/molecular/chiral_center.cml` — atomParity
- [ ] `schema3/molecular/with_property.cml` — property + scalar
- [ ] `schema3/molecular/nested_molecules.cml` — parent/child
- [ ] `schema3/molecular/with_formula_inline.cml` — LaTeX-style inline
- [ ] `schema3/compchem/full_nwchem.cml` — full jobList with
      initialization / calculation / finalization
- [ ] `schema3/compchem/with_basis_set.cml` — basisSet list
- [ ] `schema3/dictionary/example.cml` — dictionary with entries
- [ ] `schema3/unit/si_units.cml` — unitList with SI units
- [ ] `schema24/crystal.cml` — crystal + lattice
- [ ] `schema24/spectrum.cml` — peakList
- [ ] `spec/fixtures/README.md` — documents provenance (synthetic vs
      scraped) and licensing

## Acceptance

- All new fixtures round-trip through both Schema3 and Schema24 wire
  classes.
- `bundle exec rspec spec/chemicalml/fixtures_round_trip_spec.rb` is
  green.
