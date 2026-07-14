# TODO.align (round 14)

Common attributes on original elements + performance fix + specs.

| # | Workstream | Status |
|---|---|---|
| 50 | Add dict_ref/convention/id/title to original elements | complete |
| 51 | O(1) VersionedParser root lookup | complete |
| 52 | Coordinate + constraint specs | complete |

## Fixes

### Missing common attributes on original elements

Three original Base mixins were missing common CML attributes that
the 85 generated elements have by default:

- **Base::Molecule**: added `dict_ref`, `convention`, `chirality`
  with xml mappings. Without these, molecule-level dictRef
  references and convention attributes were silently dropped.
- **Base::Document** (`<cml>`): added `id`, `title`, `dict_ref`,
  `convention` with xml mappings. The root `<cml>` element can
  carry these attributes per the CML schema.
- **Base::Reaction**: added `dict_ref`, `convention` with xml
  mappings.

### O(1) root element lookup

VersionedParser was using `Elements::ALL.find { |_, id| id.to_s == root }`
— O(121) linear search on every `parse()` call. Replaced with a
pre-built reverse index `Elements::XML_TO_CLASS` (frozen Hash)
giving O(1) lookup. Adding new elements to `Elements::ALL`
automatically updates the index.

### New specs (9 examples)

- 5 coordinate round-trip specs: 3D (x3/y3/z3), 2D (x2/y2),
  fractional (xFract/yFract/zFract), through wire → canonical → wire.
- 4 constraint violation specs: atom missing id, atom missing
  elementType, bond missing atomRefs2, molecule missing id.

## Final metrics

- **197 examples, 0 failures**
- 121 CML elements, 8 dictionaries, 12 convention constraints
- Atom coordinates fully round-trip
- O(1) root element dispatch
- 0 forbidden patterns
