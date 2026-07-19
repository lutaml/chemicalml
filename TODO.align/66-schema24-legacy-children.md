# 66 — Schema24-only legacy element children

## Why

Schema 2.4 declares 17 elements absent from Schema 3 (TODO 52 modelled
them). Of those, several have non-trivial child models that were
skipped during initial modelling. XSD vs Ruby comparison shows:

| Element | Missing children |
|---|---|
| annotation | appinfo |
| arg | array, atom, atomType, expression, matrix, scalar |
| atomType | array, atom, label, matrix, molecule, property, scalar |
| bondType | array, bond, label, matrix, molecule, property, scalar |
| expression | operator, parameter |
| enumeration | annotation |
| potentialForm | arg, expression, parameter |

These are real Schema 2.4 features; the rest of the legacy set
(`float`, `integer`, `string`, `tcell`, `trow`, etc.) are scalar
leaves without children.

## Work

1. Update each Schema24-only `Base::*` module to declare the missing
   children + matching `map_element`.
2. Add a spec per touched element.

## Acceptance

- XSD vs Ruby child comparison reports 0 Schema24-only-legacy gaps.
- Specs green.
