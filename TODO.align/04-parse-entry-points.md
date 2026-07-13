# 04 — Top-level parse / serialize entry points

**Status:** complete
**Depends on:** 02, 03

## Goal

Provide a single, obvious entry point for users: `Chemicalml.parse(xml,
schema: :schema3)` returns the right wire document. Symmetrically,
`Chemicalml.serialize(doc)` produces XML. This mirrors `Mml.parse(input,
version:)`.

## Why

Today users must know which class to call `.from_xml` on:
`Chemicalml::Cml::Schema3::Document.from_xml(xml)`. After task 02 this
gets worse — there are now two real hierarchies. A single dispatch
function is the obvious UX.

## Deliverables

- [ ] `Chemicalml.parse(xml, schema: :schema3, namespace_exist: true)`
      → dispatches via `Schema::Registry` to the right VersionedParser.
- [ ] `Chemicalml.serialize(document)` → just calls `document.to_xml`.
      Exists for API symmetry.
- [ ] `Chemicalml.parser_for(schema)` → returns the Schema3 or Schema24
      module (raises `ArgumentError` on unknown).
- [ ] Document in `README.adoc` and `CLAUDE.md`.

## Pattern

```ruby
# lib/chemicalml.rb (additions)
def parse(xml, schema: :schema3, **opts)
  parser_for(schema).parse(xml, **opts)
end

def serialize(document, **opts)
  document.to_xml(**opts)
end

def parser_for(schema)
  case schema
  when :schema3  then Chemicalml::Cml::Schema3
  when :schema24 then Chemicalml::Cml::Schema24
  else
    raise ArgumentError, "unsupported schema: #{schema.inspect} " \
                         "(supported: :schema3, :schema24)"
  end
end
module_function :parse, :serialize, :parser_for
```

## Acceptance

- `Chemicalml.parse("<cml>...</cml>")` works (defaults to Schema3).
- `Chemicalml.parse("<cml>...</cml>", schema: :schema24)` returns a
  `Schema24::Document`.
- Unknown schema raises `ArgumentError`.
