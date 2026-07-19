# 67 — Final spec / lint / docs verification

## Why

After TODOs 61-66 land, the public surface area grows by ~330 element
attribute/child declarations plus a new convention. CLAUDE.md and the
spec suite need to reflect the new state.

## Work

1. Update `CLAUDE.md`:
   - List 8 conventions (molecular, compchem, dictionary, unit-dictionary,
     unitType-dictionary, spectroscopy, cascade, simpleUnit).
   - Note the parallel-array atomArray/bondArray serialisation forms.
   - Note the `CommonChildren` mixin pattern.
2. Scan the codebase for forbidden patterns:
   - `require_relative` inside `lib/`
   - `def to_h`, `def from_h`, `def to_xml`, `def from_xml`, `def to_json`, `def from_json` on model classes
   - `double(` in specs
   - `\.send(`, `instance_variable_set`, `instance_variable_get`, `respond_to?`
   - AI attribution trailers in commit history
3. Run full `bundle exec rspec` — must be green.
4. Run `bundle exec rubocop` on touched files — must be clean.
5. Add a top-level README under `TODO.align/` summarising rounds 1-17.

## Acceptance

- `bundle exec rspec` exits 0.
- `grep -rn 'require_relative' lib/` returns nothing.
- `grep -rn 'def to_h\|def from_h' lib/chemicalml/cml/` returns nothing.
- `grep -rn 'double(' spec/` returns nothing.
- CLAUDE.md convention list is current.
