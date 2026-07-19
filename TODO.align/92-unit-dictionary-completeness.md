# 92 — Unit-dictionary completeness

## Why

`reference-docs/conventions/unit-dictionary.md` says unit MUST have:
- `id` (already covered)
- `title` — typically the full name
- `symbol` (already covered alongside unitType)
- `parentSI` — QName referencing an SI unit
- at least one of `multiplierToSI` or `constantToSI`
- `unitType` (already covered)
- single `definition` child (already covered)

Missing constraints: title, parentSI, multiplierTo/constantToSI.

## Work

Add three constraints to unit-dictionary convention:
- `UnitMustHaveTitle`
- `UnitMustHaveParentSI`
- `UnitMustHaveMultiplierOrConstantToSI`

## Acceptance

- A `<unit>` without `title` triggers an error.
- A `<unit>` with `parentSI="si:m"` passes.
- A `<unit>` without both `multiplierToSI` and `constantToSI` triggers error.
- All existing specs pass.
