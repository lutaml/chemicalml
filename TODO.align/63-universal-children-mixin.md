# 63 — Universal children mixin

## Why

The CML Schema 2.4 XSD declares `metadataList`, `label`, `name`, and
`description` as children of nearly every element. Adding these four
declarations to every `Base::*` module individually is a DRY
violation: the same 16 lines of `attribute` + `map_element` would
appear in ~50 files.

## Solution

Introduce a shared mixin `Chemicalml::Cml::Base::CommonChildren`
that declares:

```ruby
attribute :metadata_lists, :metadataList, collection: true
attribute :labels, :label, collection: true
attribute :names, :name, collection: true
attribute :descriptions, :description, collection: true
```

with matching `map_element` declarations. The mixin is included by
the `Base::*` modules whose XSD declares these children.

The mixin is **opt-in** — elements that the XSD does not grant these
children to (e.g. `<atom>`, `<bond>` in schema24) do not include it.
This keeps MECE discipline: one place owns the universal child set.

## Work

1. Create `lib/chemicalml/cml/base/common_children.rb`.
2. For each Base module where the XSD declares metadataList/label/name/description as a child, add `include CommonChildren` and remove the now-redundant individual declarations.
3. Add a spec `spec/chemicalml/cml/common_children_spec.rb` asserting
   the children appear after `include CommonChildren` and round-trip
   through XML.

## Acceptance

- `CommonChildren` exists and is included by at least 10 Base modules.
- No Base module re-declares `metadata_lists` / `labels` / `names` / `descriptions` individually.
- Specs green.
