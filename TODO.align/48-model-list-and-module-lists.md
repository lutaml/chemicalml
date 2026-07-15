# 48 — Add Model::List and wire Module#lists

## Why

`Model::Module` has a `lists` accessor but `module_to_canonical`
hardcodes `lists: []`. There is no `Model::List` canonical class, so
wire `<list>` children of `<module>` are silently dropped.

## Fix

1. Add `Model::List` mirroring `Base::List` shape: id/title/dictRef/
   convention + scalar/array/matrix/list children.
2. Wire `module_to_canonical` to map `wire_module.lists` (drop the
   hardcoded `[]`).
3. Wire `module_from_canonical` reverse.
4. Spec round-trip.

## Acceptance

- A `<module>` containing a `<list>` child round-trips without loss.
- Full suite green.
