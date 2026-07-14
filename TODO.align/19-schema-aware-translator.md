# 19 — Schema-aware translator helpers

**Status:** complete
**Depends on:** 18

## Goal

Replace every `Cml::Foo.new(...)` in the Translator with
`WireClassRegistry.for(schema, Role::Foo).new(...)`. Pass the schema
through every `*_from_canonical` helper.

## Why

Today `Translator.from_canonical(doc, schema: :schema24)` returns a
Schema24 Document whose children are Schema3 instances — silent
correctness bug. Fixing it requires the WireClassRegistry (task 18)
plus threading `schema:` through every helper.

## Deliverables

- [ ] Every `*_from_canonical` helper takes `schema:` keyword.
- [ ] `from_canonical` itself passes its `schema:` to each helper.
- [ ] No hardcoded `Cml::Foo` in `lib/chemicalml/cml/translator.rb`
      or `value_translations.rb`.
- [ ] Spec verifying `from_canonical(schema: :schema24)` produces
      Schema24 children at every level (Document, Molecule, Atom,
      Bond, Name, Identifier, etc.).

## Acceptance

- Round-trip canonical → Schema24 wire → canonical yields equal doc.
- `wire.molecules.first` is a `Schema24::Molecule` (not Schema3).
- `wire.molecules.first.atom_array.atoms.first` is a `Schema24::Atom`.
