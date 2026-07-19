# 77 — Convention coverage matrix spec

## Why

The gem registers 8 conventions, each with multiple constraints.
Currently each convention has its own spec file, but there is no
single source of truth asserting that every convention:

- is in the Registry
- is detectable via at least one root role
- has at least one violation case for at least one of its constraints
- has at least one passing-case example

A matrix spec catches gaps when adding a new convention (the new
convention's matrix entry fails until it has specs).

## Work

Add `spec/chemicalml/convention/coverage_matrix_spec.rb` that:

1. Iterates `Convention::Registry.builtin_qnames`.
2. For each, asserts the convention is detectable from its declared
   root role.
3. For each constraint class registered against the convention,
   asserts a spec file exists that exercises it (grep for the class
   name in `spec/`).

## Acceptance

- Matrix spec passes for all 8 conventions.
- Adding a 9th convention without specs makes the matrix spec fail.
