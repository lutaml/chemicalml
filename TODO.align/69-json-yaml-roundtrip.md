# 69 — JSON / YAML round-trip proof

## Why

CLAUDE.md claims "lutaml-model is format-agnostic (XML/JSON/YAML/TOML
via adapters), so the same class supports whatever serialization
lutaml-model supports". We have no specs proving this. If a downstream
caller wants to serialize CML to JSON (e.g. for a REST API), we should
verify it actually works.

## Work

Add `spec/chemicalml/cml/json_yaml_roundtrip_spec.rb` that:

1. Constructs a representative CML model (Document with a Molecule
   containing an AtomArray).
2. Calls `to_json` / `from_json`.
3. Calls `to_yaml` / `from_yaml`.
4. Asserts the round-tripped model has the same data.
5. Asserts `from_json(to_json(model))` is structurally equivalent to
   `from_xml(to_xml(model))` for the same source model.

## Acceptance

- JSON round-trip spec passes.
- YAML round-trip spec passes.
- The spec proves the format-agnostic claim is true.
