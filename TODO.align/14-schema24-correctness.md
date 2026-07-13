# 14 — Schema 2.4 correctness

**Status:** complete
**Depends on:** 11

## Goal

Schema 2.4 does NOT have the generic `<module>` element — it was
introduced in Schema 3. Currently `Chemicalml::Cml::Schema24::Module`
exists anyway, which is incorrect.

Drop `Schema24::Module` and document the divergence in the schema24.rb
file's header comment.

## Why

- SSOT — the set of valid Schema 2.4 elements is defined by the XSD,
  not by Ruby convenience. Including extra elements makes the wire
  classes lie about what schema they implement.
- Compchem-convention documents (which use `<module>` heavily) MUST be
  parsed as Schema 3, not Schema 2.4. This makes that explicit.

## Deliverables

- [ ] Remove `lib/chemicalml/cml/schema24/cml_module.rb`.
- [ ] Remove `Schema24::Module` autoload from `schema24.rb`.
- [ ] Ensure `Schema24::Configuration.register_models!` does NOT
      register `:module`.
- [ ] Document in `schema24.rb` header that Schema 2.4 lacks `<module>`.
- [ ] Add a spec verifying `Chemicalml::Cml::Schema24` does not have
      `Module` defined.

## Acceptance

- `defined?(Chemicalml::Cml::Schema24::Module)` returns `nil`.
- All other Schema24 classes load and round-trip normally.
- Specs pass.
