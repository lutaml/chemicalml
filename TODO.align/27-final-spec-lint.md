# 27 — Final spec + lint pass

**Status:** complete
**Depends on:** all

## Goal

Verify the round-4 changes don't regress anything and the autoload
rule is now satisfied everywhere it can be.

## Deliverables

- [ ] `bundle exec rspec spec/chemicalml/` green.
- [ ] `grep -rn 'const_set' lib/chemicalml/cml/schema3.rb
      lib/chemicalml/cml/schema24.rb` clean.
- [ ] `grep -rn 'require_relative' lib/` clean.
- [ ] `grep -rn '^require .chemicalml' lib/` clean.
- [ ] `grep -rn 'respond_to?' lib/` clean.
- [ ] `grep -rn 'instance_variable_set\|instance_variable_get' lib/`
      clean.
- [ ] `grep -rnE '[^a-zA-Z_\.]send[ ]*\(' lib/` clean.
- [ ] TODO.align/README.round4.md shows every workstream complete.

## Acceptance

All checks pass.
