# Changelog

All notable changes to Chemicalml are documented here.
This project follows [Semantic Versioning](https://semver.org/).

## [0.2.0] - 2026-07-14

### Added

- Full CML Schema 3 element coverage (121 elements).
- Dual schema support: Schema 2.4 and Schema 3 wire classes with
  real class hierarchies, shared declarations via `Base::*` mixins,
  and `Role::*` type marker modules.
- `Chemicalml.parse(xml, schema:)` polymorphic entry point with
  auto-detection of root element (any of the 121 CML elements).
- `Chemicalml::Cml::Translator` with schema-aware translation:
  `to_canonical` / `from_canonical` handle both Schema3 and
  Schema24 wire classes at every nesting level via
  `WireClassRegistry`.
- Convention framework: 5 built-in conventions (molecular, compchem,
  dictionary, unit-dictionary, unitType-dictionary) with 17
  registered constraint classes.
- Dictionary model: 8 built-in YAML dictionaries (compchem, cml,
  cml_name, cml_formula, cif, unit_si, unit_non_si, unit_type)
  with 193+ entries.
- Atom coordinate support: 2D (x2/y2), 3D (x3/y3/z3), and
  fractional (xFract/yFract/zFract) coordinates round-trip through
  canonical.
- Stereo support: `AtomParity` and `BondStereo` round-trip through
  canonical Model.
- Compchem module support: `<module>`-rooted documents parse and
  round-trip through canonical.
- Property/Formula/Label as children of Molecule — no more silent
  data loss on `<property>` inside `<molecule>`.
- `Visitable` mixin: uniform interface for constraint walker
  (`wire_children`, `node_id`, `element_name`).
- Canon-based semantic XML comparison in specs.
- Attribution: NOTICES.adoc credits xml-cml.org editors and
  CC-BY-3.0 license for upstream content.

### Changed

- Namespace renamed from `ChemicalML` to `Chemicalml`.
- Wire classes load lazily via `autoload` — every file, every
  constant.
- Serialization goes through `lutaml-model` only — no hand-rolled
  XML.
- Schema 2.4 correctly lacks `<module>` (schema 3 only).

## [0.1.0] - 2026-07-13

### Added

- Initial gem scaffold: autoload tree, version, errors.
- CML namespace declaration.
- CML model classes for the core element set.
- Round-trip specs.

[Unreleased]: https://github.com/lutaml/chemicalml/commits/main
[0.2.0]: https://github.com/lutaml/chemicalml/releases/tag/v0.2.0
[0.1.0]: https://github.com/lutaml/chemicalml/releases/tag/v0.1.0
