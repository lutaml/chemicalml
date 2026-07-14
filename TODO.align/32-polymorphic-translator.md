# 32 — Polymorphic Translator

**Status:** complete
**Depends on:** —

## Goal

`Translator.to_canonical` and `from_canonical` currently only handle
Document roots. A compchem `<module>` root can't go through the
canonical round-trip via the public API — callers must know to use
`module_to_canonical` / `module_from_canonical` directly.

Make both methods polymorphic: dispatch on the input's class via
Role module checks.

## Why

Consistency with the rest of the gem. `WireClassRegistry` already
abstracts over schema versions; the Translator should abstract over
root element kinds too. Users shouldn't need to know upfront whether
their CML is `<cml>`-rooted or `<module>`-rooted.

## Deliverables

- [ ] `Translator.to_canonical(node)`:
      - if `node.is_a?(Chemicalml::Cml::Role::Document)` → existing
        document translation
      - if `node.is_a?(Chemicalml::Cml::Role::Module)` →
        `module_to_canonical(node)`
      - else raise `ArgumentError`
- [ ] `Translator.from_canonical(node, schema:)`:
      - if `node.is_a?(Chemicalml::Model::Document)` → existing
        document translation
      - if `node.is_a?(Chemicalml::Model::Module)` →
        `module_from_canonical(node, schema: schema)`
      - else raise `ArgumentError`

## Acceptance

- Compchem fixture's wire Module translates to canonical Module
      through the public `to_canonical` API.
- Canonical Module translates back through `from_canonical`.
- Unknown input raises `ArgumentError`.
