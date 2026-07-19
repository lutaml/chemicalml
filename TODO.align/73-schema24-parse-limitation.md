# 73 — Document Schema24 nested-parse limitation

## Why

`Chemicalml::Cml::Schema24::Document.from_xml` fails on any document
with non-trivial nested content:

```ruby
Chemicalml::Cml::Schema24::Document.from_xml(
  %(<cml xmlns="http://www.xml-cml.org/schema"><molecule id="m1"/></cml>),
  register: :chemicalml_schema24
)
# => Lutaml::Model::InvalidFormatError: Document has no root element.
```

Empty `<cml/>` parses; any child element triggers the failure.

## Root cause

Tracing the failure, the XML parser is invoked twice for nested
content. The second call receives the *attribute value* (e.g. `"m1"`)
instead of an XML fragment — indicating lutaml-model's TypeResolver
is mis-resolving the child type. The error surfaces as
`Unknown type 'molecule' in context 'default'`.

Schema3 does not exhibit this. Both Schema3 and Schema24 register
`:molecule` in their own contexts; the `chemicalml_schema24` context
resolves `:molecule` to `Chemicalml::Cml::Schema24::Molecule`
correctly when inspected directly. The failure is in the
*attribute cast* path inside `Lutaml::Model::Attribute#cast`, which
uses a different lookup mechanism that appears to default to the
`:default` context.

This looks like a lutaml-model issue with how `Attribute#cast` resolves
child types when multiple schema-version contexts are registered
globally. Investigating further requires changes inside lutaml-model.

## Workaround

Schema24 wire classes themselves work correctly when constructed
directly:

```ruby
Chemicalml::Cml::Schema24::Molecule.new(id: "m1", atom_array: ...) # works
Chemicalml::Cml::Schema24::Molecule#to_xml                          # works
```

So Schema24 round-trips through *construction → serialize*, just not
through *parse → re-serialize*. Existing Schema24 specs use direct
construction; they continue to pass.

## Work

1. Document this limitation in `CLAUDE.md` and in a comment on
   `Schema24::Configuration`.
2. Add a `pending: true` spec that asserts the behaviour fails today
   and will catch the regression automatically when lutaml-model is
   fixed.
3. File an issue upstream in `lutaml/lutaml-model`.

## Acceptance

- CLAUDE.md notes the limitation.
- Pending spec exists and is marked `pending`.
