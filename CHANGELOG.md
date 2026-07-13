# Changelog

All notable changes to ChemML are documented here.
This project follows [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added
- Initial gem scaffold: autoload tree, version, errors.
- CML namespace declaration (`Chemml::Cml::Namespace`) for the CML
  default XML namespace.
- CML model classes for the core CML element set:
  `Document`, `Molecule`, `AtomArray`, `Atom`, `BondArray`, `Bond`,
  `Reaction`, `ReactantList`, `Reactant`, `ProductList`, `Product`,
  `ReactionList`, `Name`, `Identifier`.
- AsciiChem extension namespace (`Chemml::Ext::Namespace`) for
  attributes CML doesn't natively cover (lone pairs, radical
  electrons, stereochemistry).
- Round-trip specs covering canonical CML fragments.

[Unreleased]: https://github.com/lutaml/chemml/commits/main
