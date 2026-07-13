# 01 — Cml::Base shared mixins

**Status:** complete
**Depends on:** —

## Goal

Extract every CML element's `attribute` + `xml do ... end` declarations
into a reusable mixin under `Chemicalml::Cml::Base::*`. Each schema
version's wire class then includes the relevant Base module and adds
only its version-specific deviations.

This mirrors `mml`'s `lib/mml/base/` directory: shared declarations
live in modules, version namespaces consume them via `include`.

## Why

Without this factoring:

- Adding a new schema version means duplicating every class body.
- Schema-specific deviations touch the shared class — violates OCP.
- Constraint code can't reason about a uniform interface.

With Base mixins:

- Adding Schema5 later = new namespace that includes the same Base
  modules plus its own additions.
- Schema24-specific behavior is added in `Base::Schema24Only::*`
  modules, included only by Schema24 classes.

## Deliverables

- [ ] `lib/chemicalml/cml/base.rb` — namespace file with autoloads
- [ ] `lib/chemicalml/cml/base/atom.rb` — `Base::Atom` mixin
- [ ] `lib/chemicalml/cml/base/atom_array.rb`
- [ ] `lib/chemicalml/cml/base/bond.rb`
- [ ] `lib/chemicalml/cml/base/bond_array.rb`
- [ ] `lib/chemicalml/cml/base/document.rb`
- [ ] `lib/chemicalml/cml/base/formula.rb`
- [ ] `lib/chemicalml/cml/base/identifier.rb`
- [ ] `lib/chemicalml/cml/base/label.rb`
- [ ] `lib/chemicalml/cml/base/list.rb`
- [ ] `lib/chemicalml/cml/base/matrix.rb`
- [ ] `lib/chemicalml/cml/base/metadata.rb`
- [ ] `lib/chemicalml/cml/base/metadata_list.rb`
- [ ] `lib/chemicalml/cml/base/module.rb`
- [ ] `lib/chemicalml/cml/base/molecule.rb`
- [ ] `lib/chemicalml/cml/base/name.rb`
- [ ] `lib/chemicalml/cml/base/parameter.rb`
- [ ] `lib/chemicalml/cml/base/parameter_list.rb`
- [ ] `lib/chemicalml/cml/base/product.rb`
- [ ] `lib/chemicalml/cml/base/product_list.rb`
- [ ] `lib/chemicalml/cml/base/property.rb`
- [ ] `lib/chemicalml/cml/base/property_list.rb`
- [ ] `lib/chemicalml/cml/base/reaction.rb`
- [ ] `lib/chemicalml/cml/base/reaction_list.rb`
- [ ] `lib/chemicalml/cml/base/reactant.rb`
- [ ] `lib/chemicalml/cml/base/reactant_list.rb`
- [ ] `lib/chemicalml/cml/base/scalar.rb`
- [ ] `lib/chemicalml/cml/base/array.rb`
- [ ] `lib/chemicalml/cml/base/substance.rb`
- [ ] `lib/chemicalml/cml/base/atom_parity.rb`
- [ ] `lib/chemicalml/cml/base/bond_stereo.rb`
- [ ] `lib/chemicalml/cml/base/dictionary.rb`
- [ ] `lib/chemicalml/cml/base/dictionary_entry.rb`
- [ ] `lib/chemicalml/cml/base/unit.rb`
- [ ] `lib/chemicalml/cml/base/unit_list.rb`
- [ ] `lib/chemicalml/cml/base/unit_type.rb`
- [ ] `lib/chemicalml/cml/base/unit_type_list.rb`

## Pattern

Each Base module follows the same shape:

```ruby
# lib/chemicalml/cml/base/atom.rb
module Chemicalml
  module Cml
    module Base
      module Atom
        def self.included(klass)
          klass.class_eval do
            attribute :id, :string
            attribute :element_type, :string
            # ...

            xml do
              root "atom"
              map_attribute "id", to: :id
              map_attribute "elementType", to: :element_type
              # ...
            end
          end
        end
      end
    end
  end
end
```

The schema-versioned wire class is then a thin shell:

```ruby
# lib/chemicalml/cml/schema3/atom.rb
module Chemicalml
  module Cml
    module Schema3
      class Atom < Lutaml::Model::Serializable
        include Base::Atom
      end
    end
  end
end
```

## Acceptance

- All 36 Base mixin files exist, one per CML element.
- Existing `Chemicalml::Cml::*` classes still load (they will be
  refactored in task 02 to include the Base modules).
- No `require_relative` — Base autoloads declared in
  `lib/chemicalml/cml/base.rb`.
