# 58 — Remaining Model classes for full element coverage

## Why

Several wire elements still lack canonical Models, breaking the "all
adapters speak canonical" invariant for these element types.

## New Model classes (25)

- **Documentation**: Definition, Description, Documentation, Link
- **Chemistry**: Symmetry (pointGroup/spaceGroup), System
  (atomArray/molecules), Stmml
- **Containers**: ArrayList, ConditionList, SubstanceList
- **Sets**: AtomSet, BondSet
- **Typing**: AtomType, AtomTypeList, BondType, BondTypeList
- **Mechanism**: Mechanism, MechanismComponent, Join
- **Other**: Object, Observation, PeakStructure, Potential,
  PotentialForm, PotentialList

## Acceptance

- 25 new Model classes.
- Per-class spec (lightweight — just instantiation + value_attributes).
- Full suite green.
