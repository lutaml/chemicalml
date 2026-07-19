# 80 — XSD enum constants

## Why

The XSD declares ~30 simpleTypes that restrict to enumeration sets
(orderType, stereoType, chiralityType, latticeType, matrixType,
stateType, peakMultiplicityType, etc.). We model every attribute as
`:string` and accept any value.

Without a single source of truth for the allowed values, downstream
callers that want to validate CML have to scrape the XSD themselves
or hard-code the enums (which drift from the schema).

## Solution

`Chemicalml::Cml::Enums` — frozen-set constants for each XSD enum
simpleType. The constants are the canonical Ruby source of truth
for "what values does this attribute accept".

## Work

1. Create `lib/chemicalml/cml/enums.rb` with one constant per XSD
   enum simpleType. Names match the XSD type name with `Type`
   suffix stripped (e.g. `ORDER_VALUES` for `orderType`).
2. Each constant is a frozen Set of allowed string values.
3. Add specs asserting the constants match the XSD exactly.

## Acceptance

- `Chemicalml::Cml::Enums::ORDER_VALUES` includes `"S"`, `"D"`, `"T"`,
  `"A"`, etc.
- `Chemicalml::Cml::Enums::STEREO_VALUES` includes `"C"`, `"T"`, `"W"`,
  `"H"`.
- Constants are frozen.
- Generated from the XSD (no hand-maintenance).
