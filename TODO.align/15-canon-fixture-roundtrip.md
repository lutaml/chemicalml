# 15 — Canon-based fixture round-trip

**Status:** complete
**Depends on:** 13

## Goal

The current `spec/chemicalml/fixtures_round_trip_spec.rb` only checks
that `.molecules.length` is preserved across a round-trip. It misses
attribute-level regressions (dropped attributes, wrong order, changed
values).

Switch to `be_xml_equivalent_to` (from the `canon` gem) for semantic
XML comparison. Depends on task 13 (namespace fix) so the comparison
isn't tripped up by spurious `xmlns=""` attributes.

## Why

- Catches real regressions: a dropped `elementType` attribute or a
  reordered atom would slip past today's check.
- Tolerates formatting differences (attribute order, whitespace) that
  round-trip serialization legitimately introduces.
- Matches the spec idioms used in the sibling `mml` gem.

## Deliverables

- [ ] `fixtures_round_trip_spec.rb` rewritten to use
      `expect(round_tripped_xml).to be_xml_equivalent_to(input_xml)`.
- [ ] One example per fixture file.
- [ ] Document any fixtures that can't yet round-trip cleanly (known
      limitations) with `skip "reason"` rather than removing the test.

## Acceptance

- `bundle exec rspec spec/chemicalml/fixtures_round_trip_spec.rb` is
  green.
- Manually introducing a regression (e.g. dropping an attribute from
  a Base module) causes a spec failure.
