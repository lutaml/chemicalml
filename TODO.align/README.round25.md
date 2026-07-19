# Round 25 — Semantic validation, periodic table, dictRef resolution

This round adds three real semantic checks (element type, dictRef
resolution, summary rendering) that go beyond structural validation.

## Files

- [100 — Periodic table constant](100-periodic-table.md)
- [101 — Element type validation constraint](101-element-type-validation.md)
- [102 — DictRef resolution constraint](102-dictref-resolution.md)
- [103 — ValidationReport summary](103-validation-report-summary.md)
- [104 — Final verification round 25](104-final-verification-round25.md)

## Outcomes

- **`Cml::Enums::ELEMENT_TYPE_VALUES`** — 120-element frozen Set
  matching XSD elementTypeType exactly. Includes the periodic table
  plus "Du" (dummy) and "R" (group placeholder). Single source of
  truth for valid element symbols.

- **`AtomElementTypeShouldBeInPeriodicTable`** — molecular warning
  when `atom.elementType` isn't a recognised periodic table symbol.
  Catches typos like "Carb", "Xx", "X" — previously silently
  accepted.

- **`DictRefShouldResolve`** — molecular warning when an element's
  `dictRef` attribute doesn't resolve against the built-in
  dictionaries via `Chemicalml::Dictionary::Registry.lookup`. Catches
  typos like `dictRef="cml:bpingpoint"`. This is a real
  cross-component integration: the convention constraint system
  querying the dictionary registry.

- **`ValidationReport#summary`** — human-readable multi-line summary.
  Used by the CLI; useful for one-shot scripts. Format:
  ```
  Errors: 2, Warnings: 1

  Errors:
    ERROR path/a: message (value="X")
    ...

  Warnings:
    WARN  path/b: message
    ...
  ```

- **Real bug caught by new constraint**: existing test
  `extended_constraints_spec.rb` was using `dictRef="cml:energy"`
  which isn't in the cml dictionary. The new DictRefShouldResolve
  constraint flagged it. Fixed the test to use the real `cml:bp`
  entry — and incidentally validated that the constraint works.

- Molecular convention: 32 constraints (up from 30).

- **528 examples, 0 failures, 3 pending** (TOML adapter pending).
  Zero forbidden patterns.

## Architectural insight

The DictRefShouldResolve constraint is the first to bridge two
previously-separate subsystems (convention constraints and
dictionary registry). It validates the cross-component contract:
"a dictRef must point at a real term". This is the kind of
whole-system semantic check that's only possible when both halves
are mature — round 25 is the first round where it became worth
writing.
