# 91 — AtomParity atomRefs4 distinct constraint

## Why

`<atomParity atomRefs4="a b c d">1</atomParity>` references 4 atoms
around a chiral center. Per CML semantics, all 4 must be distinct
(duplicates make the parity meaningless). No constraint enforces
this today.

## Work

Add `Molecular::Constraints::AtomParityAtomRefs4ShouldBeDistinct`
(applies_to Role::AtomParity). Warning severity. Parses
`node.atom_refs4` and warns if not 4 distinct ids.

Register against molecular.

## Acceptance

- AtomParity with `atomRefs4="a1 a2 a3 a3"` triggers warning.
- AtomParity with `atomRefs4="a1 a2 a3 a4"` passes.
