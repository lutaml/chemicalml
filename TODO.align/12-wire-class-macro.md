# 12 — Wire class definition macro

**Status:** complete
**Depends on:** 11

## Goal

Each `lib/chemicalml/cml/schema3/foo.rb` and `schema24/foo.rb` file is
12 lines of boilerplate differing only by the class name and context
id. That's 36 × 2 = 72 files of nearly-identical code.

Reduce to a single declarative call per schema:

```ruby
# lib/chemicalml/cml/schema3.rb
Chemicalml::Cml.define_wire_classes(
  in: Schema3,
  base: Base,
  context_id: :chemicalml_schema3,
  elements: REGISTERED_ELEMENTS
)
```

The macro creates one class per element name, includes the
corresponding Base and Visitable mixins, and defines
`lutaml_default_register`.

## Why

- DRY: one place to change the wire-class shape (e.g. adding another
  mixin, changing the parent class).
- SSOT: the per-element declaration lives in `REGISTERED_ELEMENTS` (from
  task 11), not duplicated across 72 files.
- New schema version: just add `define_wire_classes(in: Schema5, ...)`
  with no per-class boilerplate.

## Deliverables

- [ ] `Chemicalml::Cml.define_wire_classes` class method on the `Cml`
      module. Takes `in:`, `base:`, `context_id:`, `elements:` keyword
      args.
- [ ] Delete the 72 per-class files.
- [ ] Update `schema3.rb` / `schema24.rb` to call the macro.

## Acceptance

- The 72 thin class files are gone.
- `lib/chemicalml/cml/schema3/*.rb` and `schema24/*.rb` directories
  contain only `configuration.rb` (and any future schema-specific
  overrides).
- All specs still pass.
