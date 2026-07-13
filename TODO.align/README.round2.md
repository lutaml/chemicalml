# TODO.align (round 2)

Architectural improvements identified after the round-1 alignment with
the `mml` patterns. Each file documents one focused workstream.

Round 1 (TODO.align/01–09) established the versioned class hierarchies,
configuration, and convention framework. Round 2 (TODO.align/10–17)
eliminates remaining OCP / DRY / SSOT violations.

| # | Workstream | Status | Depends on |
|---|---|---|---|
| 10 | [Role marker modules](10-role-marker-modules.md) | complete | — |
| 11 | [DRY Configuration registration](11-dry-configuration.md) | complete | — |
| 12 | [Wire class definition macro](12-wire-class-macro.md) | complete | 11 |
| 13 | [Wire XML namespace setup](13-wire-namespace.md) | complete | — |
| 14 | [Schema 2.4 correctness — drop `<module>`](14-schema24-correctness.md) | complete | 11 |
| 15 | [Canon-based fixture round-trip](15-canon-fixture-roundtrip.md) | complete | 13 |
| 16 | [Schema24 convention coverage](16-schema24-convention-coverage.md) | complete | 10 |
| 17 | [Final spec + lint pass](17-final-spec-lint.md) | complete | all |

**All workstreams complete.** 142 examples, 0 failures. Schema3 and
Schema24 configurations are 17 and 19 lines respectively. 66
boilerplate class files eliminated (33 per schema). Zero forbidden
patterns in `lib/`.
