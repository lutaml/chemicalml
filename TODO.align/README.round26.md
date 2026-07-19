# Round 26 — XSD patterns, AtomParity parent check, canonical comparison

This round adds the canonical XSD pattern constants, semantic
parent-atom validation for atomParity, and a canonical document
comparison helper.

## Files

- [105 — XSD pattern constants](105-xsd-pattern-constants.md)
- [106 — Id/namespace pattern validation](106-id-pattern-validation.md)
- [107 — AtomParity parent atom check](107-atomparity-parent-check.md)
- [108 — Canonical document comparison](108-canonical-comparison.md)
- [109 — Final verification round 26](109-final-verification-round26.md)

## Outcomes

- **`Cml::Patterns`** — 14 frozen Regexp constants matching every XSD
  simpleType that restricts by pattern (atomIDType, idType,
  dictionaryPrefixType, namespaceType, refType, versionType,
  formulaType, etc.). Single source of truth — a future XSD edit
  that changes a pattern can be regenerated from one place.

- **`MoleculeIdShouldMatchPattern`** and **`BondIdShouldMatchPattern`**
  — molecular warnings using the new patterns. Catches ids that
  don't match the XSD-declared format.

- **`AtomParityShouldIncludeParentAtom`** — molecular DocumentConstraint
  that walks the tree and warns when `<atomParity>`'s atomRefs4
  doesn't include the parent `<atom>`'s id. Real semantic check
  that closes a CML convention rule.

- **`Cml::CanonicalComparison`** — semantic document comparison.
  `equal?` returns true if two documents have the same structural
  fingerprint. `diff` returns a hash of element_name → count_delta.
  Useful for testing and diff tools.

- **Real bugs caught during round 26**:
  - DELIMITER_PATTERN had unescaped `/` — syntax error.
  - `visit_with_parent` was using `yield` in recursion, causing
    LocalJumpError. Fixed by using explicit `&block`.
  - XSD patterns are unanchored; for validation they must be
    wrapped in `\A...\z`.

- Molecular convention: 35 constraints (up from 32).

- **543 examples, 0 failures, 3 pending** (TOML adapter pending).
  Zero forbidden patterns.

## Architectural insight

The `CanonicalComparison` helper is the abstraction the round-trip
spec (TODO 95) and Schema24 complex round-trip spec (TODO 98) both
needed. Previously each spec inlined its own fingerprint function;
now there's one canonical implementation. Classic "rule of three"
refactor — the third use is the trigger to extract.
