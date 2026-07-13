# 10 — Role marker modules

**Status:** complete
**Depends on:** —

## Goal

Every constraint currently does:

```ruby
def molecule?(node)
  node.is_a?(Chemicalml::Cml::Schema3::Molecule) ||
    node.is_a?(Chemicalml::Cml::Schema24::Molecule)
end
```

This is an OCP violation: adding `Schema5` later means editing every
constraint. Replace with a single marker module per role:

```ruby
def molecule?(node)
  node.is_a?(Chemicalml::Cml::Role::Molecule)
end
```

Both `Schema3::Molecule` and `Schema24::Molecule` (and any future
version) include `Cml::Role::Molecule`. Constraints never change when
new schema versions are added.

## Why

Type checks against concrete classes couple constraints to the set of
supported schema versions. Marker modules decouple them: the constraint
asks "is this a molecule?" not "is this one of the known molecule
classes?".

## Deliverables

- [ ] `lib/chemicalml/cml/role.rb` — namespace file with autoloads
- [ ] One module per CML element role under `lib/chemicalml/cml/role/`:
      `molecule.rb`, `atom.rb`, `atom_array.rb`, `bond.rb`,
      `bond_array.rb`, `module.rb`, `dictionary.rb`,
      `dictionary_entry.rb`, `unit.rb`, `unit_type.rb`, etc.
- [ ] Each `Base::*` module's `included` hook adds `include
      Chemicalml::Cml::Role::Foo` to the including class.
- [ ] Every constraint file uses `is_a?(Cml::Role::Foo)` instead of
      `is_a?(Schema3::Foo) || is_a?(Schema24::Foo)`.

## Acceptance

- `grep -rn 'Schema3.*||.*Schema24' lib/` returns nothing.
- `grep -rn 'is_a?(Chemicalml::Cml::Schema' lib/chemicalml/convention/`
      returns nothing.
- All convention specs pass.
