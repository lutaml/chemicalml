# 53 — Round-trip integration specs

## Why

Per-element translator specs cover individual `*_to_canonical` /
`*_from_canonical` calls. They miss integration issues — wire-format
mismatches, attribute renames, namespace leaks — that only surface
when you go XML → canonical → XML → canonical and compare.

## Specs

A new `spec/chemicalml/integration/round_trip_spec.rb` that, for each
fixture under `spec/fixtures/schema3/`:

1. Parse the CML XML → wire tree.
2. Translate wire → canonical Model.
3. Translate canonical → wire.
4. Serialize wire → XML.
5. Re-parse → second wire tree.
6. Compare first and second wire trees via `value_attributes`.

Uses real wire instances throughout (no doubles per project rule).
Also includes synthetic minimal docs for: crystal-bearing molecule,
spectrum-bearing molecule, zMatrix molecule, isotopeList molecule.

## Acceptance

- Every fixture round-trips.
- Synthetic minimal docs round-trip.
- Full suite green.
