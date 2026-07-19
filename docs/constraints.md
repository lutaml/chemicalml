# Registered Convention Constraints

Auto-generated from `Chemicalml::Convention::Registry.each_constraint`.
Last regenerated: 2026-07-18T14:26:44Z.

Total constraints: **91**

## convention:cascade

- **Namespace**: `http://www.xml-cml.org/convention/cascade`
- **Constraint count**: 4

| Constraint | Applies to |
|---|---|
| `ReactionSchemeMustHaveContent` | ReactionScheme |
| `ReactionStepListMustContainSteps` | ReactionStepList |
| `ReactionStepMustHaveReactionOrLists` | ReactionStep |
| `ReactiveCentreAtomRefsShouldBePresent` | ReactiveCentre |

## convention:compchem

- **Namespace**: `http://www.xml-cml.org/convention/compchem`
- **Constraint count**: 20

| Constraint | Applies to |
|---|---|
| `CompchemModuleMustContainJobList` | _(document-wide)_ |
| `JobMustContainInitialization` | Module |
| `JobListModuleMustHaveId` | Module |
| `JobModuleMustHaveId` | Module |
| `JobModuleAtMostOneFinalization` | Module |
| `JobModuleAtMostOneEnvironment` | Module |
| `CalculationRequiresFinalization` | Module |
| `InitializationAtMostOneMolecule` | Module |
| `InitializationAtMostOneParameterList` | Module |
| `InitializationMustNotContainProperty` | Module |
| `FinalizationAtMostOneMolecule` | Module |
| `FinalizationAtMostOnePropertyList` | Module |
| `FinalizationMustNotContainParameter` | Module |
| `EnvironmentAtMostOnePropertyList` | Module |
| `EnvironmentMustNotContainParameter` | Module |
| `ScalarUnits` | Scalar |
| `ArrayRules` | Array |
| `MatrixRules` | Matrix |
| `InitializationMustHaveContent` | Module |
| `FinalizationMustHaveContent` | Module |

## convention:dictionary

- **Namespace**: `http://www.xml-cml.org/convention/dictionary`
- **Constraint count**: 8

| Constraint | Applies to |
|---|---|
| `EntryMustHaveIdAndTerm` | DictionaryEntry |
| `EntryIdsUniqueWithinDictionary` | Dictionary |
| `DictionaryMustHaveNamespace` | Dictionary |
| `DictionaryNamespaceShouldEndWithSlashOrHash` | Dictionary |
| `EntryMustContainDefinition` | DictionaryEntry |
| `EntryIdMustMatchPattern` | DictionaryEntry |
| `EntryMustHaveUnitType` | DictionaryEntry |
| `EntryUnitsCoConstraints` | DictionaryEntry |

## convention:molecular

- **Namespace**: `http://www.xml-cml.org/convention/molecular`
- **Constraint count**: 36

| Constraint | Applies to |
|---|---|
| `AtomArrayMustContainAtoms` | Molecule |
| `AtomIdsUniqueWithinMolecule` | _(document-wide)_ |
| `BondMustReferenceAtomsInSameMolecule` | _(document-wide)_ |
| `AtomMustHaveId` | Atom |
| `AtomMustHaveElementType` | Atom |
| `BondMustHaveAtomRefs2` | Bond |
| `BondMustHaveOrder` | Bond |
| `MoleculeMustHaveId` | Molecule |
| `AtomCoordinatesMustBePaired` | Atom |
| `PropertyMustHaveDictRef` | Property |
| `ScalarMustHaveDataType` | Scalar |
| `BondOrderShouldNotBeNumeric` | Bond |
| `AtomIdMustMatchPattern` | Atom |
| `MoleculeCountMustNotAppearOnTopLevel` | _(document-wide)_ |
| `MoleculeAtomArrayMutuallyExclusiveWithChildren` | Molecule |
| `MoleculeBondArrayMutuallyExclusiveWithChildren` | Molecule |
| `BondStereoWedgeHashMustHaveAtomRefs2` | BondStereo |
| `BondStereoCisTransMustHaveAtomRefs4` | BondStereo |
| `BondStereoOtherMustHaveDictRef` | BondStereo |
| `BondIdsUniqueWithinMolecule` | _(document-wide)_ |
| `BondOrderOtherMustHaveDictRef` | Bond |
| `AtomArrayMustBeChildOfMoleculeOrFormula` | _(document-wide)_ |
| `BondArrayMustBeChildOfMolecule` | _(document-wide)_ |
| `BondOrderShouldBeInEnum` | Bond |
| `BondStereoShouldBeInEnum` | BondStereo |
| `MoleculeChiralityShouldBeInEnum` | Molecule |
| `BondAtomRefs2ShouldBeDistinct` | Bond |
| `ReferencesShouldResolve` | _(document-wide)_ |
| `BondStereoAtomRefs4ShouldBeDistinct` | BondStereo |
| `AtomParityAtomRefs4ShouldBeDistinct` | AtomParity |
| `AtomElementTypeShouldBeInPeriodicTable` | Atom |
| `DictRefShouldResolve` | Atom, Bond, Molecule, Property, Scalar, Array, Matrix, Name, Label |
| `MoleculeIdShouldMatchPattern` | Molecule |
| `BondIdShouldMatchPattern` | Bond |
| `AtomParityShouldIncludeParentAtom` | _(document-wide)_ |
| `PropertyScalarDataTypeMatchesDictionary` | Property |

## convention:simpleUnit

- **Namespace**: `http://www.xml-cml.org/convention/simpleUnit`
- **Constraint count**: 3

| Constraint | Applies to |
|---|---|
| `UnitMustHavePower` | Unit |
| `UnitMustHaveSymbol` | Unit |
| `RootMustBeUnitList` | _(document-wide)_ |

## convention:spectroscopy

- **Namespace**: `http://www.xml-cml.org/convention/spectroscopy`
- **Constraint count**: 5

| Constraint | Applies to |
|---|---|
| `SpectrumMustHaveConvention` | Spectrum |
| `SpectrumMustHaveFormat` | Spectrum |
| `SpectrumMustHaveContent` | Spectrum |
| `PeakListMustContainPeaks` | PeakList |
| `PeakShouldHaveValues` | Peak |

## convention:unit-dictionary

- **Namespace**: `http://www.xml-cml.org/convention/unit-dictionary`
- **Constraint count**: 10

| Constraint | Applies to |
|---|---|
| `UnitMustHaveSymbolAndUnitType` | Unit |
| `UnitMustHaveId` | Unit |
| `UnitMustContainDefinition` | Unit |
| `UnitListMustHaveNamespace` | UnitList |
| `UnitListMustContainAtLeastOneUnit` | UnitList |
| `UnitMustHaveTitle` | Unit |
| `UnitMustHaveParentSi` | Unit |
| `UnitMustHaveMultiplierOrConstantToSi` | Unit |
| `UnitUnitTypeShouldResolve` | Unit |
| `UnitParentSiShouldResolve` | Unit |

## convention:unitType-dictionary

- **Namespace**: `http://www.xml-cml.org/convention/unitType-dictionary`
- **Constraint count**: 5

| Constraint | Applies to |
|---|---|
| `UnitTypeMustHaveIdAndName` | UnitType |
| `UnitTypeIdMustMatchPattern` | UnitType |
| `UnitTypeMustContainDefinition` | UnitType |
| `UnitTypeListMustHaveNamespace` | UnitTypeList |
| `UnitTypeListMustContainAtLeastOneUnitType` | UnitTypeList |
