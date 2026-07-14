# TODO.align (round 4)

Final round of autoload-rule conformance. The user's pushback on the
role-module `const_set` DRY-up applies equally to the schema3.rb and
schema24.rb wire-class generation — both used `const_set` (eager),
violating the autoload (lazy) principle.

| # | Workstream | Status | Depends on |
|---|---|---|---|
| 24 | [Autoload wire classes (revert round-2 task 12)](24-autoload-wire-classes.md) | complete | — |
| 25 | [value_container schema-awareness](25-value-container-schema-awareness.md) | complete | — |
| 26 | [Remove dead wire_class_macro.rb](26-remove-dead-code.md) | complete | — |
| 27 | [Final spec + lint pass](27-final-spec-lint.md) | complete | all |

**All workstreams complete.** 161 examples, 0 failures. Wire classes
now load lazily via autoload (verified: `Schema3.autoload?(:Atom)`
returns `"chemicalml/cml/schema3/atom"` before reference, nil after).
The const_set-based generation in schema3.rb / schema24.rb is gone.
