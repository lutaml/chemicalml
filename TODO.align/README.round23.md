# Round 23 — Convention spec completeness, YARD docs

This round closes remaining gaps between the upstream convention
specs and our implementation, and adds YARD documentation to the
public API.

## Files

- [90 — BondStereo completeness](90-bond-stereo-completeness.md)
- [91 — AtomParity atomRefs4 distinct](91-atomparity-distinct.md)
- [92 — Unit-dictionary completeness](92-unit-dictionary-completeness.md)
- [93 — YARD docs for public API](93-yard-docs.md)
- [94 — Final verification round 23](94-final-verification-round23.md)

## Outcomes

- `BondStereoAtomRefs4ShouldBeDistinct` — molecular warning when
  C/T stereo's atomRefs4 has duplicate atoms. The molecular spec
  says "four distinct atom ids" — now enforced.
- `AtomParityAtomRefs4ShouldBeDistinct` — molecular warning when
  atomParity's atomRefs4 has duplicates. Closes a real semantic gap:
  duplicate parity atoms make the chiral descriptor meaningless.
- Three new unit-dictionary constraints:
  - `UnitMustHaveTitle`
  - `UnitMustHaveParentSi`
  - `UnitMustHaveMultiplierOrConstantToSi`
- Molecular convention: 30 constraints (up from 28).
- Unit-dictionary convention: 8 constraints (up from 5).
- YARD docstrings added to:
  - `Chemicalml.parse`, `Chemicalml.serialize`, `Chemicalml.parser_for`
  - `Chemicalml::Cli.run`, `Chemicalml::Cli.run_validate`
  - `Chemicalml::Convention.validate`, `validate_report`, `detect_and_validate`, `lookup`
  - `Chemicalml::Dictionary.load`
  - `Chemicalml::Cml::ReferenceResolver#initialize`
- **471 examples, 0 failures, 3 pending**. Zero forbidden patterns.

## Architectural notes

- All new constraints are warning severity (or error where the spec
  uses MUST). The convention framework distinguishes naturally.
- YARD docstrings follow the existing pattern (concise, no novel
  terminology, examples where helpful). They will be picked up by
  `bundle exec yard doc` when the yard gem is added.
- The spec count stays the same (471) because the round-23 spec
  file replaces one existing test; new constraint tests replace the
  old "5 constraints" / "28 constraints" assertion tests.
