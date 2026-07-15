# 44 — Fix SCHEMA3_ONLY and add Schema24 Module class

## Why

Actual XSD diff (via `grep '<xsd:element name='`):

- Schema3 has **121** elements. Our `Elements::ALL` matches.
- Schema24 has **137** elements (a superset of Schema3 for most parts).
- **`anyCml` is in Schema3 but NOT Schema24** → must be in
  `SCHEMA3_ONLY`.
- `module` is in BOTH schemas → currently listed in SCHEMA3_ONLY
  is **wrong**.

Current `SCHEMA3_ONLY = %i[Module]` is incorrect and Schema24 is
missing its `cml_module.rb` wire class entirely.

## Fix

1. `lib/chemicalml/cml/elements.rb`:
   `SCHEMA3_ONLY = %i[AnyCml].freeze`
2. Create `lib/chemicalml/cml/schema24/cml_module.rb` mirroring
   `schema3/cml_module.rb`.
3. Update Schema24 autoload list to include `cml_module`.
4. Update translator comment ("Schema 3 only — Schema 2.4 lacks
   `<module>`") — no longer accurate.
5. Verify Schema24 Configuration registers Module.

## Schema24-only elements (not modeled yet)

Schema24 has 16 elements not in Schema3: alternative, annotation,
appinfo, arg, complexObject, enumeration, expression, float,
floatArray, integer, integerArray, operator, relatedEntry, string,
stringArray, tcell, trow.

These are Schema-2.4-only legacy elements. They're outside the
gem's current scope (the gem focuses on Schema 3 + intersection).
Document them in CLAUDE.md so future contributors know.

## Acceptance

- SCHEMA3_ONLY = %i[AnyCml].
- Schema24::CmlModule wire class exists, parses, serializes.
- Translator's module_from_canonical works for schema24.
- Full suite still green.
