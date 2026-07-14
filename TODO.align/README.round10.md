# TODO.align (round 10)

Code cleanliness fixes.

| # | Workstream | Status |
|---|---|---|
| 40 | Fix Base file indentation + extract Translator helpers | complete |

## Issues fixed

### 1. Base file indentation

All 36 Base mixin files had inconsistent indentation on the
`namespace` line inside `xml do` blocks — 12 spaces instead of 14.
Fixed via automated `ruby -i -pe` across `lib/chemicalml/cml/base/*.rb`.

### 2. Translator DRY: extracted name_to_canonical / identifier_to_canonical

`molecule_to_canonical` was constructing `Model::Name` and
`Model::Identifier` inline (two multi-argument `.new` calls in a
single hash value) instead of calling dedicated helper methods —
unlike every other element type which has its own `X_to_canonical`
helper. Extracted to `name_to_canonical` / `identifier_to_canonical`
methods for consistency with the rest of the Translator.

## Final metrics

- 179 examples, 0 failures
- 0 forbidden patterns
- 227 lib files
