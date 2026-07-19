# 85 — Bond atomRefs2 distinct constraint

## Why

The molecular spec at `reference-docs/conventions/molecular.md` says:

> `atomRefs2` — REQUIRED, two distinct atom ids in same molecule

No current constraint enforces distinctness. A `<bond atomRefs2="a1 a1"/>`
(zero-length self-bond) is silently accepted.

## Work

Add `Molecular::Constraints::BondAtomRefs2ShouldBeDistinct` (warning
severity — there are edge cases in non-classical chemistry). The
constraint parses `node.atom_refs2`, splits on whitespace, and warns
if the two ids are identical.

Register against molecular convention.

## Acceptance

- `<bond atomRefs2="a1 a1"/>` triggers a warning.
- `<bond atomRefs2="a1 a2"/>` passes silently.
- All existing specs pass.
