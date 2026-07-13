# 08 — Autoload-only loading

**Status:** pending
**Depends on:** —

## Goal

The user's global rule (and CLAUDE.md) forbid `require_relative` and
intra-library `require` inside `lib/`. The current codebase still uses
them. Migrate every occurrence to Ruby `autoload` declared in the
immediate parent namespace's file.

## Files to fix

The following files use `require_relative` or intra-library `require`
for code that lives inside this gem:

- `lib/chemicalml/model/document.rb`
- `lib/chemicalml/model/reaction.rb`
- `lib/chemicalml/model/reaction_list.rb`
- `lib/chemicalml/model/reactant.rb`
- `lib/chemicalml/model/reactant_list.rb`
- `lib/chemicalml/model/product.rb`
- `lib/chemicalml/model/product_list.rb`
- `lib/chemicalml/cml/translator.rb` (imports both Model and Cml — this
  one is legitimate because Translator is the *adapter* between the two
  namespaces; verify it still works via autoload, then drop the explicit
  requires).
- `chemicalml.gemspec` (`require_relative "lib/chemicalml/version"`) —
  this is the *only* legitimate use; gemspecs run before the gem is
  loaded, so they cannot use autoload. Leave this one alone.

## Deliverables

- [ ] Audit `lib/` for every `require_relative` and every `require`
      whose target is a file inside `lib/chemicalml/`.
- [ ] Replace each with an `autoload` declaration in the immediate
      parent namespace's file. If the parent namespace file doesn't
      exist, create it.
- [ ] Confirm the spec suite still passes (`bundle exec rspec`).
- [ ] Add a RuboCop `Style/RequireRelative`-style guard to
      `.rubocop.yml` (or a custom cop) so this can't regress.

## Acceptance

- `grep -rn 'require_relative' lib/` returns only the gemspec line.
- `grep -rn "^require ['\"]chemicalml/" lib/` returns nothing.
- Full spec suite green.
