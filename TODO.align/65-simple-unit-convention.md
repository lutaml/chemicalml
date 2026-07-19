# 65 — SimpleUnit convention

## Why

`reference-docs/conventions/index.md` lists six CML conventions.
We implement five + two added later (spectroscopy, cascade). The
sixth "official" one is `simpleUnit`, used as the worked example in
the CMLLite paper. Without it, the convention set is incomplete
relative to the upstream CML spec.

## Source

`reference-docs/schemas/schema3/schema.xsd` — does not define
convention rules; the rules come from the CMLLite paper. The
namespace is `http://www.xml-cml.org/convention/simpleUnit`.

The paper's simpleUnit example constraints:

- A `<unit>` under simpleUnit MUST have a `power` attribute (integer).
- A `<unit>` under simpleUnit MUST have a `symbol` attribute (non-empty string).
- The root must be a `<unitList>` declaring `convention='convention:simpleUnit'`.

## Work

1. `lib/chemicalml/convention/simple_unit.rb` — main module (QNAME =
   `convention:simpleUnit`, NAMESPACE_URI ends in `/simpleUnit`).
2. `lib/chemicalml/convention/simple_unit/constraints.rb` — autoload registry.
3. Three constraint files:
   - `unit_must_have_power.rb` — applies_to Role::Unit
   - `unit_must_have_symbol.rb` — applies_to Role::Unit
   - `root_must_be_unit_list.rb` — DocumentConstraint
4. Register in `Convention::Registry.load_cache`.
5. Add `autoload :SimpleUnit` to `lib/chemicalml/convention.rb`.
6. Specs at `spec/chemicalml/convention/simple_unit_spec.rb`.

## Acceptance

- `Chemicalml::Convention.lookup("convention:simpleUnit")` returns the module.
- Specs cover all three constraints (positive + negative cases).
- Full suite green.
