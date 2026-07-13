# TODO.align

Master plan for aligning the `chemicalml` gem's architecture with the
patterns established by the sibling `mml` gem
(https://github.com/plurimath/mml). Each file in this directory is one
workstream.

These tasks refactor the existing scaffolding so that schema versions,
namespaces, and round-trip validation follow the same idioms `mml` uses
for MathML 2/3/4.

| # | Workstream | Status | Depends on |
|---|---|---|---|
| 01 | [Cml::Base shared mixins](01-cml-base-mixins.md) | complete | — |
| 02 | [Real Schema3/Schema24 hierarchies](02-real-schema-hierarchies.md) | complete | 01 |
| 03 | [Configuration + lutaml_default_register](03-configuration.md) | complete | 02 |
| 04 | [Top-level parse / serialize entry points](04-parse-entry-points.md) | complete | 02, 03 |
| 05 | [Schema-aware Translator](05-schema-aware-translator.md) | complete | 02 |
| 06 | [Replace respond_to? with is_a?](06-no-respond-to.md) | complete | 02 |
| 07 | [Canon-based semantic XML comparison](07-canon-xml-comparison.md) | complete | — |
| 08 | [Expand fixtures corpus](08-expand-fixtures.md) | complete | 02 |
| 09 | [Final spec + lint pass](09-final-spec-lint.md) | complete | all |

**All workstreams complete.** 136 examples, 0 failures. Zero
`require_relative`, zero intra-library `require`, zero `respond_to?`,
zero `instance_variable_set`/`instance_variable_get`, zero private
`send` in `lib/`.
