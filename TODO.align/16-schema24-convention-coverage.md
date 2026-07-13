# 16 — Schema24 convention coverage

**Status:** complete
**Depends on:** 10

## Goal

All convention specs today build `Chemicalml::Cml::Document.new(...)`
which is an alias for Schema3. The constraints are written to accept
both schemas (after task 10, via role modules), but no spec verifies
Schema24 documents.

Add parallel examples in each convention spec that build Schema24
documents and verify the same violations fire.

## Why

- Confidence that the role-module refactor (task 10) actually works.
- Catches regressions where a future edit accidentally only checks
  Schema3.

## Deliverables

- [ ] `spec/chemicalml/convention/convention_spec.rb` extended with
      Schema24 equivalents of the molecular, compchem, and dictionary
      constraint specs.
- [ ] A shared example helper to avoid duplicating the schema24 path
      for every constraint.

## Acceptance

- At least one Schema24-path example per convention.
- All examples pass.
