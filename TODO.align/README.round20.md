# Round 20 — Schema24 parse bug FIXED

This round found and fixed the long-standing Schema24 nested-XML
parse bug that had been documented as a "limitation" since round 18.

## Root cause

`Cml::Elements::SCHEMA24_ONLY` included CML's legacy `<string>`,
`<integer>`, `<float>` elements, and Schema24::Configuration
registered them as types in the schema24 context. Their XML names
collided with lutaml-model's primitive type names. Every
`attribute :foo, :string` cast in any Schema24 wire class resolved
`:string` to `Chemicalml::Cml::Schema24::String` (a Serializable)
instead of `Lutaml::Model::Type::String` (the primitive).

The Serializable.cast path on a String value tried to deserialize
it as a CML `<string>` element, which failed. Schema3 was
unaffected because Schema 3 doesn't declare these elements.

## Fix

Added `Cml::Elements::SCHEMA24_TYPE_COLLISIONS = %i[Float Integer
String].freeze`. Schema24::Configuration now passes this list as
`except:` when registering SCHEMA24_ONLY. The three wire classes
remain defined (parseable as document roots) but are no longer
registered as types.

## Files

- [76 — Schema24 parse bug FIXED](76-schema24-workaround.md)

## Outcomes

- `Chemicalml::Cml::Schema24::Document.from_xml` parses nested
  content. Schema24 finally works the same as Schema3.
- `spec/chemicalml/cml/schema24_nested_parse_spec.rb` has 3
  passing specs including one with parallel-array atomArray and
  nested molecule.
- Removed the pending spec.
- Updated CLAUDE.md (limitation replaced with collision note).
- Updated TODO 76 with the real root cause and fix.
- Full suite: **423 examples, 0 failures, 0 pending**.

## Lesson

When a bug seems to be in upstream but only one of two parallel
implementations is affected, look for **what's different** about
that implementation's setup. The bug wasn't in lutaml-model's
caching — it was in our registration of type-colliding names.
