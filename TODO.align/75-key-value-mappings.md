# 75 — key_value mappings for JSON / YAML wire names

## Why

`lutaml-model` supports a `key_value do ... end` block alongside
`xml do ... end` to declare JSON/YAML wire names. Previously Base
modules declared only XML mappings, so JSON output used Ruby
snake_case names (`element_type`, `atom_array`) instead of CML wire
names (`elementType`, `atomArray`).

## Solution

Each `Base::*` module now has an explicit `key_value do ... end`
block written by hand, mirroring its `xml do ... end` block. The
two blocks are kept in sync manually — no runtime introspection,
no DSL, no generation.

This is more verbose than the auto-generation approach
(`Base::WireMappings.auto_key_value_mapping!`) that was tried and
reverted. The user explicitly preferred manual blocks for clarity
and explicitness over DRY.

## Work done

1. Generated initial `key_value do ... end` blocks from each
   `Schema3::*` and `Schema24::*` wire class's XML mappings via a
   one-shot script that introspected the loaded classes.
2. Inserted each block into the corresponding `Base::*` file right
   after the `xml do ... end` block.
3. Removed `Base::WireMappings` module and all
   `auto_key_value_mapping!` calls from wire classes.
4. Verified JSON output carries CML wire names (`elementType`,
   `atomArray`, `formalCharge`).
5. Verified YAML also carries wire names.
6. All 422 specs pass.

## Acceptance

- `Atom.new(element_type: "C").to_json` includes `"elementType":"C"`.
- `Molecule.from_json(json)` round-trips wire names correctly.
- All existing specs pass.
- No runtime introspection or auto-generation — every key_value
  block is hand-written in its Base module.
