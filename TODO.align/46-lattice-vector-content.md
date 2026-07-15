# 46 — Fix LatticeVector content attribute

## Why

`<latticeVector>1 0 0</latticeVector>` carries vector components as
element content. `lib/chemicalml/cml/base/lattice_vector.rb` declares
only id/title/dictRef/convention/units — **no content attribute**.
The translator's workaround maps `lv.content` ↔ wire `units` —
semantically wrong (units ≠ vector components).

## Fix

1. Add `attribute :content, :string` + `map_content` to Base::LatticeVector.
2. Update Model::LatticeVector to carry `units` and `content` as
   independent fields.
3. Update translator `lattice_vector_to/from_canonical` to map both.
4. Spec round-trip.

## Acceptance

- `<latticeVector units="unit:nm">1 0 0</latticeVector>` round-trips
  with units and content preserved.
- Translator spec covers the fix.
- Full suite green.
