# TODO.align (round 6)

Polymorphic entry points. Today compchem documents (rooted at
`<module>`) silently parsed as empty Documents — the content was
dropped without an error. The Translator also only handled Documents.

| # | Workstream | Status | Depends on |
|---|---|---|---|
| 32 | [Polymorphic Translator](32-polymorphic-translator.md) | complete | — |
| 33 | [Polymorphic Chemicalml.parse](33-polymorphic-parse.md) | complete | 32 |
| 34 | [Polymorphic API specs](34-polymorphic-specs.md) | complete | 32, 33 |
| 35 | [Final spec + lint pass](35-final-spec-lint.md) | complete | all |

**All workstreams complete.** 179 examples, 0 failures.

Compchem `<module>`-rooted documents now:
1. Parse correctly via `Chemicalml.parse(xml)` — returns a Schema3
   Module with the jobList tree intact.
2. Translate to canonical Model::Module via the public
   `Translator.to_canonical` API.
3. Round-trip back to wire via `Translator.from_canonical`.
4. Raise `ArgumentError` when attempted as Schema 2.4 (which lacks
   `<module>`).

The `Chemicalml.parse` API detects the root element via a regex peek
(no double-parse) and dispatches to the Document or Module parser.
Unknown roots raise `ArgumentError` — no more silent empty results.
