# Round 22 — Missing molecular constraints, CLI, diverse fixtures

This round closes constraints from the molecular spec that were
genuinely missing, adds a CLI utility, and broadens fixture
coverage to exercise more code paths.

## Files

- [85 — Bond atomRefs2 distinct constraint](85-bond-distinct-atoms.md)
- [86 — References-should-resolve constraint](86-references-should-resolve.md)
- [87 — CLI utility](87-cli-utility.md)
- [88 — Diverse fixtures](88-diverse-fixtures.md)
- [89 — Final verification round 22](89-final-verification-round22.md)

## Outcomes

- `BondAtomRefs2ShouldBeDistinct` — warning when `atomRefs2` references
  the same atom twice (e.g. `a1 a1`). Closes the molecular spec's
  "two distinct atom ids" rule.
- `ReferencesShouldResolve` — DocumentConstraint that uses
  `Cml::ReferenceResolver` to walk the document and report bonds
  referencing missing atoms. Catches typos like `atomRefs2="a1 a99"`
  when only a1 exists.
- `Chemicalml::Cli` + `exe/chemicalml` — CLI utility with three
  commands:
  - `chemicalml validate <file>` — auto-detect convention, print
    violations to stderr, exit non-zero on errors
  - `chemicalml conventions` — list the 8 registered conventions
  - `chemicalml dictionaries` — list the 8 built-in dictionaries
- New fixtures:
  - chiral_center_with_bond_stereo.cml (bondStereo W/H + atomParity)
  - ethanol_with_properties.cml (propertyList + formula)
  - nacl_with_lattice.cml (crystal + symmetry + matrix)
  - diels_alder.cml (reactionScheme + reactantList + productList)
- Molecular convention now registers 28 constraints (up from 26).
- **471 examples, 0 failures, 3 pending**. Zero forbidden patterns.

## Architectural notes

- The `ReferencesShouldResolve` constraint is the first
  `DocumentConstraint` (vs NodeConstraint) in the molecular
  convention. It demonstrates the convention framework's
  support for cross-cutting rules that need the whole document.
- The CLI is a thin dispatcher — adding a new subcommand = adding
  one method and one entry in `Cli::COMMANDS`. OCP.
- Existing fixtures already passed; the new ones exercise the
  recently added bondStereo / propertyList / crystal / reaction
  paths in the Base modules.
