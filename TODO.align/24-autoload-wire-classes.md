# 24 — Autoload wire classes (revert round-2 task 12)

**Status:** complete
**Depends on:** —

## Goal

Replace the `const_set`-based wire class generation in `schema3.rb`
and `schema24.rb` with per-class files loaded via `autoload`.

## Why

Round 2 task 12 consolidated 72 per-class files into two `const_set`
loops. The user later pushed back on the same `const_set` pattern in
role modules — `const_set` is eager, not autoload. The same logic
applies here: `autoload` is required for lazy loading.

## Design

To avoid 72 nearly-identical boilerplate files, each schema gets a
`Context` module that provides `lutaml_default_register`:

```ruby
# lib/chemicalml/cml/schema3/context.rb
module Chemicalml
  module Cml
    module Schema3
      module Context
        def lutaml_default_register
          :chemicalml_schema3
        end
      end
    end
  end
end
```

Each per-class file is then minimal:

```ruby
# lib/chemicalml/cml/schema3/atom.rb
module Chemicalml
  module Cml
    module Schema3
      class Atom < Lutaml::Model::Serializable
        include Base::Atom
        include Visitable
        extend Context
      end
    end
  end
end
```

And `schema3.rb` declares autoloads:

```ruby
module Schema3
  autoload :Atom, "chemicalml/cml/schema3/atom"
  autoload :Molecule, "chemicalml/cml/schema3/molecule"
  # ...
end
```

## Deliverables

- [ ] `lib/chemicalml/cml/schema3/context.rb` — provides
      `lutaml_default_register` returning `:chemicalml_schema3`.
- [ ] `lib/chemicalml/cml/schema24/context.rb` — same for
      `:chemicalml_schema24`.
- [ ] 36 per-class files under `lib/chemicalml/cml/schema3/` (one
      per element in `Elements::ALL`).
- [ ] 35 per-class files under `lib/chemicalml/cml/schema24/` (no
      `Module` — schema 2.4 lacks it).
- [ ] `schema3.rb` / `schema24.rb` rewritten with autoloads only,
      no `const_set`.
- [ ] All specs pass.

## Acceptance

- `grep -rn 'const_set' lib/chemicalml/cml/schema3.rb
      lib/chemicalml/cml/schema24.rb` returns nothing.
- `Schema3::Atom` loads lazily (only when referenced).
- All 155+ specs still pass.
