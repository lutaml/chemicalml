# 37 — CompChem convention: full upstream constraint coverage

## Why

`reference-docs/conventions/compchem.md` defines a deep module
structure (jobList → job → initialization/calculation/finalization/
environment) and value-container rules. The gem currently ships only
2 of the ~19 rules.

## Current constraints (2)

CompchemModuleMustContainJobList, JobMustContainInitialization.

## Missing structural rules

- `jobList` module MUST have `id` unique within compchem module.
- `job` module MUST have `id` unique within compchem module.
- `job` module MUST contain at most one `finalization`.
- `job` module MUST contain at most one `environment`.
- If a `calculation` is present in a `job`, a `finalization` MUST
  also be present (co-constraint).
- `initialization` module MUST NOT contain `property`/`propertyList`.
- `initialization` module MUST NOT contain more than one `molecule`.
- `initialization` module MUST NOT contain more than one
  `parameterList`.
- `finalization` module MUST NOT contain `parameter`/`parameterList`.
- `finalization` module MUST NOT contain more than one `molecule`.
- `finalization` module MUST NOT contain more than one `propertyList`.
- `environment` module MUST NOT contain more than one `propertyList`.
- `environment` module MUST NOT contain `parameter`/`parameterList`
  directly.

## Missing value-container rules

- `scalar` with `dataType` `xsd:integer` or `xsd:double` MUST have
  `units`.
- `scalar` with `dataType` `xsd:string` MUST NOT have `units`.
- `array` MUST have `size` ≥ 1; `dataType` MUST be integer or double;
  MUST have `units`.
- `matrix` MUST have `rows` ≥ 1 and `columns` ≥ 1; `dataType` MUST
  be integer or double; MUST have `units`.

## Implementation

Use `DocumentConstraint` for cross-node rules (calculation→finalization
co-constraint), `NodeConstraint` for single-node rules.

CompChem modules are `<module dictRef="compchem:*">`. Match by
`node.is_a?(Chemicalml::Cml::Role::Module)` then check `dict_ref`.

## Acceptance

- 17 new constraint classes registered.
- Per-class spec under `spec/chemicalml/convention/compchem/`.
- Full suite still green.
