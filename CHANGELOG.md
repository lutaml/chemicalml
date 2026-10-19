# Changelog

All notable changes to Chemicalml are documented here.
This project follows [Semantic Versioning](https://semver.org/).

## [0.4.1] - 2026-10-20

### Fixed
- Ruby 4.0 support: `logger` left Ruby's default gems in 4.0, so
  the bare `require 'logger'` in `Chemicalml::Logger` raised
  LoadError for every Ruby 4 consumer of the published 0.4.0 gem.
  Declared explicitly (`~> 1.6`). Also un-reds main CI: the TODO 138
  wall-clock budgets are CI-gated (development-time tripwires), and
  the two dead cimas workflows that could never pass
  (`performance.yml`, `opal.yml` — rake tasks never defined) are
  removed.

## [Unreleased]

### Added
- Rich-text dictionary content: `<definition>` and `<description>`
  now carry their `<xhtml:p>` paragraphs instead of flattening them
  into strings. `Xhtml::P` is a wire class owning the XHTML
  namespace (lutaml-model assigns one namespace per model class);
  `DictionaryEntry`/`Dictionary` type definition/description to the
  structured classes, the entry-must-contain-definition constraint
  reads both shapes (plain string or structured), and the two
  dictionary fixtures graduate from PENDING_SEMANTIC to full
  semantic round-trip comparison (closes #19).

### Fixed
- Container child declarations that round-tripping silently dropped:
  `<cml>`/`<module>` now carry `reactionScheme` and `spectrum`
  children, `<dictionary>` carries dictionary-level `<definition>`,
  `<unitType>` carries `<dimension>`, `<molecule>` carries the
  `concise` formula attribute, `<peak>` carries the `<atomRefs>`
  child-element form (the attribute form was already mapped), and
  `<xaxis>`/`<yaxis>` carry CML's `multipler` attribute. Every
  schema3 fixture now round-trips semantically except the two
  dictionary fixtures whose xhtml-namespaced mixed content needs a
  rich-content model (lutaml/chemicalml#19, marked PENDING_SEMANTIC
  with the structural re-parse check still running).

### Changed
- `lutaml-model` pin aligned to the pessimistic house convention
  (`~> 0.8`). The full suite passes against the current stack
  (lutaml-model 0.8.114, moxml 0.5.146, leptris 1.9.372, canon
  with processing-instruction tree-diff support - lutaml/canon#271).

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
