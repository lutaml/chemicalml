# 18 — WireClassRegistry

**Status:** complete
**Depends on:** —

## Goal

A central registry that, given a schema symbol and a Role module,
returns the right wire class. Eliminates the hardcoded `Cml::Foo`
references in the Translator (which are all Schema3 aliases).

```ruby
Chemicalml::Cml::WireClassRegistry.for(:schema24, Chemicalml::Cml::Role::Molecule)
# => Chemicalml::Cml::Schema24::Molecule

Chemicalml::Cml::WireClassRegistry.for(:schema3, Chemicalml::Cml::Role::Atom)
# => Chemicalml::Cml::Schema3::Atom
```

## Why

The Translator today hardcodes `Cml::Molecule` (which is an alias for
`Schema3::Molecule`). When the user asks for a Schema24 document,
`Translator.from_canonical(doc, schema: :schema24)` returns a
`Schema24::Document` but its `molecules` collection contains
`Schema3::Molecule` instances. **This is a correctness bug.**

The registry centralizes the lookup so every helper can resolve the
right class for the requested schema.

## Deliverables

- [ ] `lib/chemicalml/cml/wire_class_registry.rb` — module with
      `for(schema, role)` class method.
- [ ] Raises `ArgumentError` on unknown schema or role.
- [ ] Lazily resolves via `Schema3::Foo` / `Schema24::Foo` constants
      (no eager loading).
- [ ] Spec coverage.

## Acceptance

- `WireClassRegistry.for(:schema24, Role::Molecule)` returns
  `Chemicalml::Cml::Schema24::Molecule`.
- `WireClassRegistry.for(:schema3, Role::Atom)` returns
  `Chemicalml::Cml::Schema3::Atom`.
- Unknown schema raises `ArgumentError`.
