# 03 — Configuration + lutaml_default_register

**Status:** complete
**Depends on:** 02

## Goal

Wire `lutaml-model`'s `GlobalContext` type-resolution machinery into
the schema-versioned classes. Each schema gets its own context id
(`:chemicalml_schema3`, `:chemicalml_schema24`); each wire class
declares which context it belongs to via `lutaml_default_register`.

This is the same pattern `mml` uses to let `from_xml` resolve child
element types based on the active context.

## Why

Without context-aware type resolution, parsing `<atom>` inside a Schema3
document and inside a Schema24 document both yield the same Ruby class.
Once task 02 introduces real hierarchies, the framework needs to know
which `Atom` class to instantiate based on which schema's `Document`
is being parsed.

## Deliverables

- [ ] `lib/chemicalml/cml/schema3/configuration.rb` —
      `module Schema3::Configuration; extend Chemicalml::ContextConfiguration;
      CONTEXT_ID = :chemicalml_schema3; end`
- [ ] `lib/chemicalml/cml/schema24/configuration.rb` — same shape
      with `CONTEXT_ID = :chemicalml_schema24`
- [ ] `lib/chemicalml/context_configuration.rb` — shared mixin
      providing `register_model`, `populate_context!`, `context`,
      `default_context_id` (modeled on `mml`'s
      `lib/mml/context_configuration.rb`)
- [ ] Each `Schema3::*` and `Schema24::*` class defines
      `def self.lutaml_default_register; :chemicalml_schema3; end`
      (or `:chemicalml_schema24`)
- [ ] `lib/chemicalml/versioned_parser.rb` — `extend`-able mixin with
      `parse(xml, namespace_exist:, context:)` that calls
      `ensure_registered!` then `GlobalContext.resolve_type(:cml, ctx)`
      then `root_class.from_xml(xml, register: ctx)`
- [ ] Schema3 and Schema24 modules `extend VersionedParser`

## Acceptance

- `Chemicalml::Cml::Schema3.parse(xml)` returns a Schema3 document.
- `Chemicalml::Cml::Schema24.parse(xml)` returns a Schema24 document.
- `Chemicalml.parse(xml, schema: :schema24)` dispatches correctly.
- `Lutaml::Model::GlobalContext.context(:chemicalml_schema3)` is
  populated after first parse.
