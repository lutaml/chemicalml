# 61 — Parallel-array attrs for atomArray/bondArray

## Why

CML supports two equivalent serialisations of atom/bond tables:

```xml
<!-- child form (we already model this) -->
<atomArray><atom id="a1" elementType="C" x3="1.0" .../><atom .../></atomArray>

<!-- parallel-array form (we do NOT model this) -->
<atomArray atomID="a1 a2" elementType="C O" x3="1.0 2.0" .../>
```

The parallel-array form is heavily used in real CML documents and is
the only form some legacy tools emit. Round-trip currently drops these
attributes silently.

## Source of truth

`reference-docs/schemas/schema3/schema.xsd` — `atomArrayType` complexType
declares these 14 parallel-array attributes:

- `atomID` (idArrayType)
- `count`, `countArrayType`
- `elementType`, `elementTypeArrayType`
- `formalCharge`, `formalChargeArrayType`
- `hydrogenCount`, `hydrogenCountArrayType`
- `occupancy`, `occupancyArrayType`
- `x2`, `y2` (coordinateComponentArrayType)
- `x3`, `y3`, `z3` (coordinateComponentArrayType)
- `xFract`, `yFract`, `zFract` (coordinateComponentArrayType)

`bondArrayType` declares 4:

- `atomRef1`, `atomRef2` (atomRefArrayType)
- `bondID` (idArrayType)
- `order` (orderArrayType)

## Work

1. `lib/chemicalml/cml/base/atom_array.rb` — declare the 14 attributes
   as `:string` (lutaml-model does not need to validate the inner
   whitespace-separated format) with matching `map_attribute` entries.
2. `lib/chemicalml/cml/base/bond_array.rb` — declare the 4 attributes.
3. Add specs in `spec/chemicalml/cml/parallel_array_spec.rb` asserting
   round-trip for both forms.

## Acceptance

- `Chemicalml.parse` of a parallel-array `<atomArray>` populates the
  attributes; `Chemicalml.serialize` emits them back unchanged.
- Both forms supported for Schema3 and Schema24.
- Specs green.
