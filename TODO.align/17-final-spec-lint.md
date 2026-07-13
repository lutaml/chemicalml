# 17 — Final spec + lint pass

**Status:** complete
**Depends on:** all

## Goal

Run the full suite, audit forbidden patterns, document final state.

## Deliverables

- [ ] `bundle exec rspec spec/chemicalml/` green.
- [ ] `grep -rn 'require_relative' lib/` clean.
- [ ] `grep -rn '^require .chemicalml' lib/` clean.
- [ ] `grep -rn 'respond_to?' lib/` clean.
- [ ] `grep -rn 'instance_variable_set\|instance_variable_get' lib/`
      clean.
- [ ] `grep -rn '[^a-zA-Z_\.]send[ ]*(' lib/` clean.
- [ ] `grep -rn 'is_a?(Chemicalml::Cml::Schema' lib/chemicalml/convention/`
      clean.
- [ ] Both `Schema3::Configuration` and `Schema24::Configuration` are
      under 20 lines.
- [ ] `TODO.align/README.round2.md` index shows every workstream
      `complete`.

## Acceptance

All of the above verified.
