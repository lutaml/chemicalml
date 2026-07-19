# Round 30 — unitType resolution, JSON CLI, enumeration

This round adds the unit-unitType cross-component check (parallels
dictRef resolution), CLI JSON output for machine consumers, and a
constraint-enumeration API.

## Files

- [123 — Unit unitType resolution](123-unit-unittype-resolution.md)
- [124 — CLI JSON output](124-cli-json-output.md)
- [125 — Constraint enumeration API](125-constraint-enumeration.md)
- [126 — Final verification round 30](126-final-verification-round30.md)

## Outcomes

- **`UnitUnitTypeShouldResolve`** — unit-dictionary warning when a
  `<unit>`'s `unitType` attribute doesn't resolve against the
  built-in unitType-dictionary. Cross-component check parallel to
  the molecular convention's `DictRefShouldResolve`.

- **`chemicalml validate --json file.cml`** — JSON output mode for
  the CLI. Returns `{ file:, ok:, has_warnings:, violations: [...] }`
  where each violation has `severity`, `path`, `message`, `value`.
  Useful for editor integration, CI pipelines, automated tooling.

- **`Convention::Registry.each_constraint`** — iterates every
  constraint across every convention, yielding `(convention, class)`
  pairs. Useful for documentation generation and introspection.

- **`Convention::Registry.total_constraint_count`** — sum of all
  registered constraints across all conventions (currently 90).

- Unit-dictionary convention: 9 constraints (up from 8).

- **580 examples, 0 failures, 3 pending** (TOML adapter pending).
  Zero forbidden patterns. **90 constraints across 8 conventions.**

## Architectural insight

`UnitUnitTypeShouldResolve` completes a symmetric pair with
`DictRefShouldResolve` from round 25. Both follow the same pattern:
walk the document, look up reference attributes against the
dictionary registry, warn on misses. The pattern is now established
enough that adding a new reference-resolution constraint is a
2-minute job: copy the structure, change the attribute name and the
target dictionary.

The `each_constraint` iterator makes the constraint table tractable
for documentation generation. A future round could auto-generate a
Markdown table of all 90 constraints from this single API call.
