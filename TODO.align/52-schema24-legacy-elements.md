# 52 — Schema24 legacy elements (selective)

## Why

Schema 2.4 XSD declares 17 elements not in Schema 3. Three of them
are useful enough to model: `annotation` (documentation wrapper),
`appinfo` (application info), `enumeration` (dictionary enum, used
by entries that predate the schema3 enum attribute).

The other 14 (`alternative`, `arg`, `complexObject`, `expression`,
`float`, `floatArray`, `integer`, `integerArray`, `operator`,
`relatedEntry`, `string`, `stringArray`, `tcell`, `trow`) are either
redundant with Schema 3's unified `scalar`/`array`/`table` or relate
to legacy expression machinery. Out of scope for now.

## Implementation

- Add `Base::Annotation`, `Base::Appinfo`, `Base::Enumeration`.
- Add `Role::Annotation`, `Role::Appinfo`, `Role::Enumeration`.
- Add `Schema24::Annotation`, `Schema24::Appinfo`, `Schema24::Enumeration`.
- Add to `Elements::ALL` with new `SCHEMA24_ONLY` list.
- Schema3 skips these; Schema24 registers them.

## Acceptance

- Three new wire classes registered for Schema24 only.
- Schema3 lookup raises ArgumentError for these (not in Schema 3).
- Full suite green.
