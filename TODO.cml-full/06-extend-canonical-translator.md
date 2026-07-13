# 06 — Extend canonical model + translator

**Status:** pending
**Depends on:** 02, 05

## Goal

The canonical `Chemicalml::Model` and the `Cml::Translator` currently
cover the molecule / atom / bond / reaction subset. The full CML
conventions need formula, property, parameter, scalar/array/matrix,
module (the compchem container), label, and metadata. Bring both up to
speed together so round-trip coverage matches the example fixtures.

## Deliverables

### Canonical model additions (`Chemicalml::Model::*`)

- [ ] `Formula` — `concise`, `inline`, optional `atom_array`, `count`
- [ ] `Property` — wraps a single value container, has `dict_ref`, `title`
- [ ] `Parameter` — same shape as Property but used for inputs
- [ ] `Scalar` — `value`, `data_type`, `units`
- [ ] `Array` — `values` (split string), `data_type`, `units`, `size`
- [ ] `Matrix` — `values`, `rows`, `columns`, `data_type`, `units`
- [ ] `Label` — `value`, `dict_ref`
- [ ] `Module` — generic grouping container, `dict_ref`, `role`, ordered children
- [ ] `Metadata` — `name`, `content`, `convention`
- [ ] `PropertyList`, `ParameterList`, `MetadataList` — collection wrappers

### CML wire additions (`Chemicalml::Cml::*` or per-schema)

- [ ] Same set as above, one lutaml-model class each, with the right
      XML element name and attribute names from the XSDs.

### Translator updates

- [ ] Add a translation rule for every new model class. Each rule is a
      pair of methods on `Translator` following the existing
      `*_to_canonical` / `*_from_canonical` pattern.
- [ ] Where the wire name differs from the Ruby name, the CML class's
      `xml do ... end` block carries the rename (e.g.
      `map_attribute "elementType", to: :element_type`). The translator
      doesn't do key-swapping.
- [ ] Add a `value_attributes` implementation for every new canonical
      class so equality and visitor traversal work.

## Design constraints

- One concern per file (MECE). Adding `Scalar` =
  `model/scalar.rb` + `cml/scalar.rb` (or per-schema) + translator
  rule + spec. Don't bundle several elements into one file.
- The translator is the only class that imports both namespaces.
- No `def to_h` / `def from_h` / `def to_xml` / `def from_xml` on any
  model or wire class.

## Acceptance

- Every example fixture round-trips through
  `Document.from_xml(...).to_xml` and re-parses to an equal document.
- New model classes have specs covering construction, equality, and
  translator round-trip.
