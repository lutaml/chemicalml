# 45 — Documentation cleanup and final spec verification

## Why

Stale comments and docs rot fast. After TODOs 36–44 land, sweep the
codebase for outdated references and run the full suite end-to-end.

## Updates

- `lib/chemicalml/cml.rb`: comment says "All 36 aliases load from a
  single file" — actually 121 now.
- `CLAUDE.md`: refresh any counts (121 elements, ~45 constraints,
  14 model classes added, etc.).
- `CLAUDE.md`: note Schema24-only legacy elements not modeled.
- Verify `bundle exec rspec` is fully green.
- Verify `bundle exec rubocop` is clean (or autocorrect what's
  safe).

## Acceptance

- All counts in docs match the actual codebase.
- Full rspec suite passes.
- Rubocop reports no new offenses.
