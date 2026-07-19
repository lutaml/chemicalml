# Round 28 — Convenience API, custom conventions, compchem completion

This round adds user-facing convenience (`parse_file`, custom
convention registration), more compchem constraints from the spec,
and a comprehensive lint cleanup.

## Files

- [115 — parse_file convenience](115-parse-file.md)
- [116 — Custom convention registration](116-custom-convention.md)
- [117 — More compchem constraints](117-more-compchem-constraints.md)
- [118 — Final verification round 28](118-final-verification-round28.md)

## Outcomes

- **`Chemicalml.parse_file(path)`** — convenience wrapper around
  `parse(File.read(path))`. Raises ArgumentError for missing files.
  Eliminates the `File.read` boilerplate.

- **`Convention::Registry.register_custom(mod)`** — runtime
  registration of custom conventions. The module must `extend Base`
  and return a non-empty `qname`. Useful for domain-specific CML
  extensions (e.g., a `convention:my-lab-extensions` for a research
  group's custom vocabulary).

- **Two new compchem constraints** from the spec:
  - `InitializationMustHaveContent` — initialization module must
    contain at least one of molecule, parameterList, or user-defined
    module
  - `FinalizationMustHaveContent` — finalization module must contain
    at least one of molecule, propertyList, or user-defined module

- **Lint cleanup**: ran `rubocop -A` on all recently-touched files.
  80 offenses autocorrected (string quotes, modifier-if usage,
  parenthesised method args, etc.). Zero remaining style issues.

- **Real bug caught during round 28**: `register_custom` initially
  deadlocked because it called `load_cache` while holding the mutex.
  Fixed by separating the load step (which acquires/releases its
  own mutex) from the mutation step (direct hash access after load
  is guaranteed to have populated `@cache`).

- Compchem convention: 20 constraints (up from 18).

- **568 examples, 0 failures, 3 pending** (TOML adapter pending).
  Zero forbidden patterns. **88 constraints across 8 conventions.**

## Architectural insight

The `register_custom` deadlock is a classic Ruby mutex pitfall:
re-entering a non-reentrant `Mutex#synchronize` block from within
itself deadlocks. The fix — call `load_cache` first (which manages
its own mutex acquisition), then mutate `@cache` directly — works
because Ruby's `||=` assignment makes `@cache` non-nil after the
first load. Documented in the method comment.

This round also reinforced the value of running rubocop on each
round's output. 80 autocorrected offenses across 8 files means
style drift was creeping in — single-quote vs double-quote,
`unless` vs `if !`, etc. A small CI rule (`bundle exec rubocop`
must pass) would catch this in future.
