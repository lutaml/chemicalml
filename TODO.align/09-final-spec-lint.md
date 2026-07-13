# 09 — Final spec + lint pass

**Status:** complete
**Depends on:** all

## Goal

Run the full suite, fix any regressions, run rubocop, document any
remaining gaps in this file.

## Deliverables

- [ ] `bundle exec rspec` green
- [ ] `bundle exec rubocop` clean (or only pre-existing offenses,
      documented)
- [ ] `grep -rn 'require_relative' lib/` returns nothing (except the
      gemspec line which is legitimate)
- [ ] `grep -rn 'respond_to?' lib/` returns nothing
- [ ] `grep -rn 'instance_variable_set\|instance_variable_get' lib/`
      returns nothing
- [ ] `grep -rn '\.send(' lib/` reviewed — no private-method bypasses
- [ ] This file updated with final status

## Acceptance

- All four grep checks return clean.
- Full spec suite green.
- The TODO.align index (`README.md`) shows every workstream as
  `complete`.
