# Round 29 — Wire introspection, README, dataType consistency

This round adds wire-class introspection, updates the README to
reflect the current API, and adds a property-dataType consistency
constraint that bridges the convention and dictionary subsystems
in a new way.

## Files

- [119 — Wire-class introspection](119-wire-introspection.md)
- [120 — Update README](120-readme-update.md)
- [121 — Property dataType consistency](121-property-datatype.md)
- [122 — Final verification round 29](122-final-verification-round29.md)

## Outcomes

- **`Cml.for_xml_name(name, schema:)`** — wire-class lookup by XML
  element name. Uses the existing `Elements::XML_TO_CLASS` reverse
  index. Returns nil for unknown names.

- **`Cml.wire_classes(schema:)`** — enumerator over all wire classes
  for a schema version. Useful for code generation and tooling.

- **README rewritten**:
  - 8 conventions + 88+ constraints documented
  - All modern API examples (`parse_file`, `validate`, `each_atom`)
  - CLI commands documented (`validate`, `inspect`, `conventions`,
    `dictionaries`, `elements`)
  - Cross-format serialisation examples
  - Custom convention registration example
  - Dictionary lookup example
  - Architectural overview (`Base::*`, `Role::*`, `Elements::ALL`)

- **`PropertyScalarDataTypeMatchesDictionary`** — molecular warning
  when a `<property>`'s `<scalar>` `dataType` doesn't match the
  `dataType` declared in the dictionary entry referenced by `dictRef`.
  This is a **three-component integration check**: convention
  constraint system queries the dictionary registry AND inspects the
  document's scalar child.

- Molecular convention: 36 constraints (up from 35).

- **574 examples, 0 failures, 3 pending**. Zero forbidden patterns.

## Architectural insight

`PropertyScalarDataTypeMatchesDictionary` is the deepest
cross-component check yet — it validates that:

1. The property's `dictRef` resolves to a real dictionary entry
   (uses `Dictionary::Registry.lookup`).
2. The entry declares a `dataType`.
3. The property's `<scalar>` child declares a `dataType`.
4. The two `dataType` values match.

If any step is missing data, the constraint silently passes (no
false positives). When all the data is present, it catches real
inconsistencies that would cause downstream type errors.

This kind of multi-step semantic validation is what mature
document-validation frameworks look like. Round 29 is the first
round where it's been possible — earlier rounds built the
primitives (dictionary registry, dictRef resolution, scalar
dataType attribute) that this constraint composes.
