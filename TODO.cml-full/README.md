# TODO.cml-full

Master plan for the full CML implementation of the `chemicalml` gem.

Each file in this directory is one workstream. Numbering is the
suggested implementation order; later tasks depend on earlier ones
where noted.

| # | Workstream | Status | Depends on |
|---|---|---|---|
| 01 | [Reference docs](01-reference-docs.md) — fetch & archive cmllite, conventions, dictionaries | pending | — |
| 02 | [Schema-versioned wire model](02-schema-versioned-model.md) — split Cml into Schema3 / Schema24 | pending | 01 |
| 03 | [Fixtures scrape](03-fixtures-scrape.md) — pull all example CML into `spec/fixtures/` | pending | 01 |
| 04 | [Convention framework](04-convention-framework.md) — registry + 5 conventions | pending | 02 |
| 05 | [Dictionary layer](05-dictionary-layer.md) — model + YAML store + entries | pending | 04 |
| 06 | [Extend canonical model + translator](06-extend-canonical-translator.md) — formula/property/parameter/scalar/array/matrix/module/label | pending | 02, 05 |
| 07 | [Attribution & notices](07-attribution-notices.md) — credit xml-cml.org, CC-BY-3.0 | pending | — |
| 08 | [Autoload-only loading](08-autoload-only.md) — remove all `require_relative` from lib/ | pending | — |
| 09 | [Spec coverage](09-spec-coverage.md) — every public method, every fixture round-trip | pending | 02, 04, 05, 06 |

When picking up work, claim the lowest-numbered pending task and update
its status line. Mark the workstream complete in this index once all
sub-items are done.
