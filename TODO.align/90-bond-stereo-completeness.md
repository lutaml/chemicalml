# 90 — BondStereo completeness constraints

## Why

The molecular spec at `reference-docs/conventions/molecular.md` says:

> If value is `C` or `T` — MUST have `atomRefs4` (four distinct atom
> ids; two MUST be the parent bond's atoms). MUST NOT have `atomRefs2`.
> If value is `W` or `H` — MUST have `atomRefs2` (two distinct atom
> ids ... both MUST be in the parent bond).

We have `BondStereoCisTransMustHaveAtomRefs4` and
`BondStereoWedgeHashMustHaveAtomRefs2` but not the distinctness or
parent-bond-membership rules.

## Work

Add to molecular convention:
- `BondStereoAtomRefs4ShouldBeDistinct` (warning) — atomRefs4 has 4 distinct ids
- `BondStereoAtomsShouldBeInParentBond` (warning) — atomRefs2/4
  references should be a subset of the parent bond's atoms (the
  walker doesn't track parents, so this is approximate — checks
  against the document's atoms).

Register both against molecular.

## Acceptance

- `<bondStereo atomRefs4="a1 a2 a3 a3">C</bondStereo>` triggers warning.
- `<bondStereo atomRefs4="a1 a2 a3 a4">C</bondStereo>` passes.
- All existing specs pass.
