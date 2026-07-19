# 76 — Schema24 parse bug: ROOT CAUSE FOUND AND FIXED

## Status: FIXED

## Root cause

The Schema24 nested-XML parse bug had nothing to do with
lutaml-model internals. The root cause was a **type-name collision**
in the Schema24 context registry.

Schema 2.4 declares legacy elements `<string>`, `<integer>`,
`<float>` that share their XML names with lutaml-model primitive
type names (`:string`, `:integer`, `:float`). The Schema24
Configuration registered these CML element classes as types in the
Schema24 context — shadowing the primitives.

Every `attribute :foo, :string` cast in a Schema24 wire class then
resolved `:string` to `Chemicalml::Cml::Schema24::String` (the CML
element class, a `Lutaml::Model::Serializable`) instead of
`Lutaml::Model::Type::String` (the primitive, which just casts to
Ruby String). The Serializable.cast path on a String value tried to
deserialize it as a CML `<string>` element, which failed.

Schema3 was unaffected because Schema 3's XSD doesn't declare
`<string>`, `<integer>`, `<float>` elements.

## Fix

`lib/chemicalml/cml/elements.rb` adds a new constant:

```ruby
SCHEMA24_TYPE_COLLISIONS = %i[Float Integer String].freeze
```

`lib/chemicalml/cml/schema24/configuration.rb#register_models!` now
passes this list as `except:` when registering SCHEMA24_ONLY:

```ruby
register_elements!(
  only: true,
  except: Chemicalml::Cml::Elements::SCHEMA24_TYPE_COLLISIONS
)
```

The CML `<string>`, `<integer>`, `<float>` wire classes remain
defined and parseable as document roots (via VersionedParser), but
they are no longer registered as types — so `:string` attribute
casts resolve correctly to the primitive.

## Verification

- `Chemicalml::Cml::Schema24::Document.from_xml` now parses nested
  content correctly.
- `spec/chemicalml/cml/schema24_nested_parse_spec.rb` has 3 passing
  tests including one with parallel-array atomArray.
- Full suite: 422 examples, 0 failures (previously 2 pending — both
  now pass).
