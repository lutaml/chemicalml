# 05 — Schema-aware Translator

**Status:** complete
**Depends on:** 02

## Goal

Update `Chemicalml::Cml::Translator` so it can serialize the canonical
model into either Schema3 or Schema24 wire format, and so it can parse
either schema's wire format back into the canonical model.

## Why

Today the translator only knows about `Cml::Document` (now an alias for
Schema3). Once Schema3 and Schema24 are real class hierarchies, the
translator needs to know which one to instantiate when going from
canonical → wire.

## Deliverables

- [ ] `Translator.from_canonical(model_doc, schema: :schema3)` →
      returns a `Schema3::Document` or `Schema24::Document`
- [ ] `Translator.to_canonical(wire_doc)` → unchanged: detects the
      wire class via `is_a?` and dispatches correctly
- [ ] Existing two-method public API (`to_canonical`,
      `from_canonical`) preserved; new behavior is opt-in via the
      `schema:` keyword (defaults to `:schema3`)

## Acceptance

- Round-trip canonical → Schema3 wire → canonical yields an equal doc.
- Round-trip canonical → Schema24 wire → canonical yields an equal doc.
- Specs cover both schemas.
