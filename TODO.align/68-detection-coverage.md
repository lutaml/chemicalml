# 68 — Detection coverage for all 8 conventions

## Why

`Convention::Detection.convention_of` lists 6 root roles (Document,
Module, Molecule, Dictionary, UnitList, UnitTypeList). With 8
conventions now registered, several conventions have no auto-detection
path:

| Convention   | Expected root role | Currently detected? |
|--------------|--------------------|---------------------|
| molecular    | Document / Module / Molecule | yes |
| compchem     | Module             | yes |
| dictionary   | Dictionary         | yes |
| unit-dictionary | UnitList        | yes |
| unitType-dictionary | UnitTypeList | yes |
| spectroscopy | Spectrum / SpectrumList | **no** |
| cascade      | ReactionScheme / ReactionList | **no** |
| simpleUnit   | UnitList           | yes |

## Work

1. Extend `CONVENTION_ROOTS` to include:
   - `Role::Spectrum`, `Role::SpectrumList`
   - `Role::ReactionScheme`, `Role::ReactionList`
2. Add specs covering each convention's auto-detection from a root
   element with the right `convention` attribute.

## Acceptance

- `Detection.convention_of(spectrum)` returns the convention string
  when the spectrum declares one.
- All 8 conventions are auto-detectable from at least one root role.
