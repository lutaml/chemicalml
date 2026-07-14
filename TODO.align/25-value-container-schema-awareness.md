# 25 — value_container schema-awareness

**Status:** complete
**Depends on:** —

## Goal

`Chemicalml::Cml::Translator::ValueTranslations` provides
`scalar_from_canonical`, `array_from_canonical`,
`matrix_from_canonical`, `value_container_from_canonical`, etc. All
of them hardcode `Cml::Scalar` / `Cml::Array` / `Cml::Matrix` (which
are Schema3 aliases).

When `Translator.from_canonical(doc, schema: :schema24)` is called
and the document has properties with scalar values, the scalars end
up as `Schema3::Scalar` instances inside `Schema24::Property` objects
— same kind of bug we just fixed for Document → Molecule → Atom.

## Why

Consistency. The Translator's main `from_canonical` is now
schema-aware via `WireClassRegistry`. The value-container path should
be too.

## Deliverables

- [ ] `scalar_from_canonical(scalar, schema:)`,
      `array_from_canonical(array, schema:)`,
      `matrix_from_canonical(matrix, schema:)` — take schema, look
      up wire class via `WireClassRegistry`.
- [ ] `value_container_from_canonical(value, schema:)` — passes
      schema through.
- [ ] `property_from_canonical(prop, schema:)`,
      `parameter_from_canonical(param, schema:)` — passes schema to
      value_container_from_canonical.
- [ ] All callers updated.
- [ ] Spec verifying `Schema24::Property` has `Schema24::Scalar`
      children.

## Acceptance

- A round-trip canonical → Schema24 wire with a property+scalar
      produces `Schema24::Property` with a `Schema24::Scalar` value.
- All specs pass.
