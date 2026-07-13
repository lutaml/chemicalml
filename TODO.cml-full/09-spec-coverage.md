# 09 — Spec coverage

**Status:** pending
**Depends on:** 02, 04, 05, 06

## Goal

Every public method has specs. Every fixture round-trips. Every
convention has at least one passing and one failing case. No `double`.

## Deliverables

- [ ] `spec/chemicalml/cml/schema3/*_spec.rb` — one per wire class
- [ ] `spec/chemicalml/cml/schema24/*_spec.rb` — one per wire class
- [ ] `spec/chemicalml/model/*_spec.rb` — one per canonical class
- [ ] `spec/chemicalml/cml/translator_spec.rb` — extended to cover the
      new model classes added in `06-extend-canonical-translator.md`
- [ ] `spec/chemicalml/convention/*_spec.rb` — one per convention,
      positive and negative paths
- [ ] `spec/chemicalml/dictionary_spec.rb` — registry lookup,
      round-trip YAML → model → YAML
- [ ] `spec/chemicalml/fixtures_round_trip_spec.rb` — iterates every
      `.cml` file under `spec/fixtures/`, parses, re-serializes,
      re-parses, asserts equality

## Constraints

- Never `double`. Use real instances or `Struct.new`.
- Specs assert on **state**, not on "should have received" method-call
  counts.
- Specs live under `spec/chemicalml/`, mirroring `lib/chemicalml/`.

## Acceptance

- `bundle exec rspec` is green.
- `bundle exec rspec --profile 10` shows no examples taking a
  surprising amount of time (sanity check — no accidental network or
  file I/O in hot paths).
