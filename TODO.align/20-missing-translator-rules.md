# 20 — Missing translator rules

**Status:** complete
**Depends on:** 19

## Goal

The Translator today handles: Document, Molecule, AtomArray,
Atom, BondArray, Bond, Name, Identifier, Reaction, ReactionList,
ReactantList, Reactant, ProductList, Product, Substance, plus
value containers (Scalar, Array, Matrix, Property, Parameter),
Label, Metadata, Formula via the ValueTranslations module.

Missing: **Module** (compchem), **PropertyList**, **ParameterList**,
**MetadataList**, **AtomParity**, **BondStereo**, **Dictionary**,
**DictionaryEntry**, **Unit**, **UnitList**, **UnitType**,
**UnitTypeList**, **List**.

Add canonical ↔ wire rules for each so compchem modules and
dictionaries can round-trip through canonical.

## Why

- Compchem modules can't be translated today — the wire class exists
  but no canonical mapping does.
- Dictionary / Unit / UnitType wire classes have no canonical
  counterpart. They could reuse `Chemicalml::Dictionary::Model` etc.
  but the Translator doesn't connect them.

## Deliverables

- [ ] `module_to_canonical` / `module_from_canonical` — handles
      nested modules, parameter_lists, property_lists,
      metadata_lists, molecules, lists.
- [ ] `property_list_to_canonical` / `property_list_from_canonical`.
- [ ] `parameter_list_to_canonical` / `parameter_list_from_canonical`.
- [ ] `metadata_list_to_canonical` / `metadata_list_from_canonical`.
- [ ] Specs covering each new rule.

## Acceptance

- Round-trip a compchem module fixture through canonical → wire →
  canonical yields equal model.
- Specs green.
