# 78 — Fixture coverage audit

## Why

`spec/fixtures/` holds CML examples. Current round-trip specs cover a
subset. After recent additions (parallel-array attrs, CommonChildren,
8 conventions), some features may have no fixture exercising them.

## Work

Audit `spec/fixtures/`:

1. Identify fixtures that exercise parallel-array atomArray/bondArray.
2. Identify fixtures covering each convention.
3. Identify fixtures using new child elements (reaction.mechanism,
   reactiveCentre.atomSet, etc.).
4. For features with no fixture, add one under `spec/fixtures/`.

## Acceptance

- Every convention has at least one fixture.
- Parallel-array form has at least one fixture.
- Schema24-only legacy elements have at least one fixture.
