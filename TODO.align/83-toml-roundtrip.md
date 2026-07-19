# 83 — TOML round-trip spec

## Why

lutaml-model supports TOML as a key-value format. CLAUDE.md claims
format-agnosticism — XML/JSON/YAML are tested. Add TOML to complete
the set.

## Work

Add `spec/chemicalml/cml/toml_roundtrip_spec.rb` that round-trips
a Molecule through `to_toml` / `from_toml`. TOML's flat key/value
structure means nested objects get flattened — verify the same
data survives.

## Acceptance

- `Molecule#to_toml` produces a TOML string.
- `Molecule.from_toml(toml)` returns a Molecule with the same id
  and atom data.
