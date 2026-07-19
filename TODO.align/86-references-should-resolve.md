# 86 — References-should-resolve constraint

## Why

With `Cml::ReferenceResolver` (TODO 82), we can now detect bonds
whose `atomRefs2` reference atoms that don't exist in the parent
molecule. Currently no constraint flags this — typos like
`atomRefs2="a1 a99"` (where `a99` doesn't exist) pass silently.

## Work

Add `Molecular::Constraints::ReferencesShouldResolve` as a
`DocumentConstraint`. It instantiates a `ReferenceResolver` and
reports each unresolved reference as a warning violation.

## Acceptance

- A bond referencing a missing atom triggers a warning.
- A bond referencing existing atoms passes silently.
- All existing specs pass.
