# 02 — Real Schema3 / Schema24 class hierarchies

**Status:** complete
**Depends on:** 01

## Goal

Today `Chemicalml::Cml::Schema3::Document` is just an alias for
`Chemicalml::Cml::Document` — they are literally the same class. This
means schema-version-specific behavior is impossible to add without
modifying the shared class (OCP violation).

Promote both namespaces to genuine class hierarchies. Each
schema-versioned class is a `Lutaml::Model::Serializable` subclass that
includes the corresponding `Cml::Base::*` mixin (from task 01) and may
add version-specific declarations.

## Why

The CML Schema 2.4 and Schema 3 XSDs differ in content models —
Schema 3 loosened many of Schema 2.4's restrictions and added the
generic `<module>` element. Today's aliasing hides this. Real class
hierarchies let each version evolve independently.

## Deliverables

- [ ] `lib/chemicalml/cml/schema3/` directory with one file per
      element, each `class Foo < Lutaml::Model::Serializable;
      include Base::Foo; end`
- [ ] `lib/chemicalml/cml/schema24/` directory mirroring the same set
- [ ] `lib/chemicalml/cml/schema3.rb` — namespace file with autoloads
      (replaces the current alias module)
- [ ] `lib/chemicalml/cml/schema24.rb` — same
- [ ] Backward compatibility: `Chemicalml::Cml::Atom`,
      `Cml::Molecule`, etc. at the top level become aliases for
      `Cml::Schema3::*` (so existing user code and specs still load).
      Document this in `CLAUDE.md` and `README.adoc`.

## Schema-specific deviations to honor

- Schema 2.4 has stricter content models; some elements (e.g.
  `<module>`) do not exist. `Schema24::Module` therefore does not
  exist.
- Schema 3 added `<module>` and loosened `<cml>` content; that
  behavior is the default in Schema3 wire classes.
- Future Schema 2.4-specific deviations are added in
  `Base::Schema24Only::*` modules included only by Schema24 classes
  (OCP-friendly extension point).

## Pattern

```ruby
# lib/chemicalml/cml/schema3/molecule.rb
module Chemicalml
  module Cml
    module Schema3
      class Molecule < Lutaml::Model::Serializable
        include Base::Molecule
      end
    end
  end
end
```

```ruby
# lib/chemicalml/cml/schema24/molecule.rb  (deviates: no <module> child)
module Chemicalml
  module Cml
    module Schema24
      class Molecule < Lutaml::Model::Serializable
        include Base::Molecule
        # Schema 2.4 doesn't allow child <module> elements;
        # the Base::Molecule mixin doesn't declare one, so this class
        # is already correct. If we needed to *remove* an attribute
        # the Base declares, we'd use `undef_attribute` here.
      end
    end
  end
end
```

## Acceptance

- `Chemicalml::Cml::Schema3::Atom` and `Chemicalml::Cml::Schema24::Atom`
  are different classes (different `object_id`).
- `Chemicalml::Cml::Atom` is an alias for `Chemicalml::Cml::Schema3::Atom`.
- All existing specs continue to pass.
- Round-trip through either schema works on the existing fixtures.
