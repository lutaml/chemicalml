# 23 — Final spec + lint pass

**Status:** complete
**Depends on:** all

## Goal

Run the full suite, audit forbidden patterns, document final state.

## Deliverables

- [ ] `bundle exec rspec spec/chemicalml/` green.
- [ ] `Chemicalml::Cml::Translator.public_methods(false)` returns only
      `to_canonical` and `from_canonical`.
- [ ] No hardcoded `Cml::Foo.new` in translator files.
- [ ] `from_canonical(schema: :schema24)` produces Schema24 children
      at every level (spec verification).
- [ ] `lib/chemicalml/cml/role/` directory removed.
- [ ] Zero `require_relative`, `respond_to?`, `instance_variable_set`/`get`,
      private `send` in lib/.
- [ ] TODO.align/README.round3.md marked complete.

## Acceptance

All checks pass.
