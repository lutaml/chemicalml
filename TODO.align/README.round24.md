# Round 24 — Round-trip equivalence, cross-format interop, introspection

This round formalises the round-trip guarantee across all fixtures,
proves cross-format interoperability (XML → JSON → YAML → XML),
adds a convention introspection API, and exercises Schema24 with
complex content.

## Files

- [95 — Round-trip equivalence spec](95-round-trip-equivalence.md)
- [96 — Cross-format interoperability](96-cross-format-interop.md)
- [97 — Convention introspection API](97-convention-introspection.md)
- [98 — Schema24 complex round-trip](98-schema24-complex-round-trip.md)
- [99 — Final verification round 24](99-final-verification-round24.md)

## Outcomes

- **Round-trip equivalence spec** — for every one of the 20 fixtures,
  asserts that `parse(xml) → serialize → parse` produces a
  structurally-equivalent document (compared via a recursive
  element-name fingerprint). Catches future serialization drift.

- **Cross-format interoperability spec** — proves the format-agnostic
  claim end-to-end:
  - XML → JSON → XML (structural fingerprint equal)
  - XML → YAML → XML (structural fingerprint equal)
  - JSON → JSON idempotent (same output)
  - XML → JSON → YAML → XML (4-format chain, structural equal)

- **`Convention::Registry.each`** — iterates all 8 conventions
  sorted by QName. Returns an Enumerator without a block.
- **`Convention::Registry.convention_root?(role)`** — boolean check
  for whether a Role module is a convention-bearing root.

- **Schema24 complex round-trip** — exercises the now-fixed Schema24
  parser with rich content (parallel-array atoms + bonds, names,
  formulas). Proves Schema24 has feature parity with Schema3.

- **Real bug fix discovered via round 24 testing**:
  `AtomArrayMustContainAtoms` was rejecting parallel-array form
  (which has no `<atom>` children but uses `atomID` attribute).
  Fixed to accept either form.

- **515 examples, 0 failures, 3 pending** (TOML adapter pending).
  Zero forbidden patterns.

## Architectural insight

The cross-format interop spec is the most valuable safety net: any
future change to the Base modules that breaks the format-agnostic
claim (e.g. adds a method that only works in one format) is caught
immediately. The structural fingerprint comparison is format-blind,
so it catches real data loss rather than just string-equality noise.
