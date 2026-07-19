# Round 31 — CLI tooling, parentSI resolution

This round completes the CLI tooling suite (constraints + enums
commands) and adds the parentSI resolution constraint, completing
the cross-component check symmetry.

## Files

- [127 — CLI constraints command](127-cli-constraints.md)
- [128 — CLI enums command](128-cli-enums.md)
- [129 — ParentSI resolution](129-parentsi-resolution.md)
- [130 — Final verification round 31](130-final-verification-round31.md)

## Outcomes

- **`chemicalml constraints`** — new CLI command listing all 91
  constraints grouped by convention. Each line shows the constraint
  class name and its declared `applies_to` roles.

- **`chemicalml enums`** — new CLI command listing every
  `Cml::Enums` constant with its allowed values. Useful for users
  who want to know what enum values an attribute accepts.

- **`UnitParentSiShouldResolve`** — unit-dictionary warning when a
  `<unit>`'s `parentSI` doesn't resolve against built-in
  dictionaries. Completes the cross-component check symmetry:
  - dictRef resolution (molecular)
  - unitType resolution (unit-dictionary)
  - parentSI resolution (unit-dictionary)

- **Real bug caught during round 31**: existing fixture
  `convention_spec.rb:226` used `parent_si: "siUnits:s"` which
  doesn't resolve (correct prefix is `si`, not `siUnits`). Fixed.

- Unit-dictionary convention: 10 constraints (up from 9).

- **583 examples, 0 failures, 3 pending**. Zero forbidden patterns.
  **91 constraints across 8 conventions.**

## Architectural insight

The cross-component check pattern (walk document → look up reference
attribute against registry → warn on miss) is now fully
established across three constraint pairs:

| Convention | Attribute | Lookup target |
|---|---|---|
| molecular | `dictRef` | dictionary registry |
| unit-dictionary | `unitType` | unitType-dictionary registry |
| unit-dictionary | `parentSI` | unit dictionary registry |

Adding a fourth is mechanical: copy the structure, change the
attribute name and lookup target. The pattern's clarity is its own
form of documentation.
