# TODO.align (round 3)

Fixes for remaining correctness bugs and architectural debt identified
after the round-2 alignment.

Round 1 (01–09): versioned class hierarchies, configuration,
convention framework.
Round 2 (10–17): role markers, DRY configuration, wire namespace,
schema24 correctness, canon comparison.
Round 3 (18–23): schema-aware translator correctness, missing
translations, encapsulation, role DRY (rejected).

| # | Workstream | Status | Depends on |
|---|---|---|---|
| 18 | [WireClassRegistry](18-wire-class-registry.md) | complete | — |
| 19 | [Schema-aware translator helpers](19-schema-aware-translator.md) | complete | 18 |
| 20 | [Missing translator rules](20-missing-translator-rules.md) | complete | 19 |
| 21 | [Encapsulate translator internals](21-encapsulate-translator.md) | complete | 19, 20 |
| 22 | [DRY role modules](22-dry-role-modules.md) | rejected (autoload rule) | — |
| 23 | [Final spec + lint pass](23-final-spec-lint.md) | complete | all |

**All workstreams complete (22 rejected).** 155 examples, 0 failures.

Key correctness fix: `Translator.from_canonical(doc, schema: :schema24)`
now produces Schema24 wire classes at every nested level (Document →
Molecule → AtomArray → Atom), not Schema3. Fixed via `WireClassRegistry`
that resolves classes by `(schema, role)` pair.
