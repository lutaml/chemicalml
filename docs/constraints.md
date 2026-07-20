# Registered Convention Constraints

Auto-generated from `Chemicalml::Convention::Registry.each_constraint`.
Last regenerated: 2026-07-20T09:43:53Z.

Total constraints: **91**

## convention:cascade

- **Namespace**: `http://www.xml-cml.org/convention/cascade`
- **Constraint count**: 4

| Constraint | Applies to | Description |
|---|---|---|
| `ReactionSchemeMustHaveContent` | ReactionScheme | A `<reactionScheme>` MUST contain at least one `<reactionStepList>` or `<reaction>` child. An empty scheme carries no cascade information. |
| `ReactionStepListMustContainSteps` | ReactionStepList | A `<reactionStepList>` MUST contain at least one `<reactionStep>` child. An empty step list breaks the cascade chain. |
| `ReactionStepMustHaveReactionOrLists` | ReactionStep | A `<reactionStep>` MUST contain either a `<reaction>` child or explicit `<reactantList>` + `<productList>` children. An empty step is a dead-end in the cascade. |
| `ReactiveCentreAtomRefsShouldBePresent` | ReactiveCentre | A `<reactiveCentre>` SHOULD declare its `atomRefs` attribute. Without atom references the reactive centre is indistinguishable from a placeholder. Warning severity — |

## convention:compchem

- **Namespace**: `http://www.xml-cml.org/convention/compchem`
- **Constraint count**: 20

| Constraint | Applies to | Description |
|---|---|---|
| `CompchemModuleMustContainJobList` | _(document-wide)_ | A CompChem module MUST contain at least one jobList module child per the compchem convention. |
| `JobMustContainInitialization` | Module | A job module MUST contain exactly one initialization module child per the compchem convention. |
| `JobListModuleMustHaveId` | Module | A jobList module MUST have an `id` unique within the compchem module. |
| `JobModuleMustHaveId` | Module | A job module MUST have an `id` unique within the compchem module. |
| `JobModuleAtMostOneFinalization` | Module | A job module MUST contain at most one finalization module. |
| `JobModuleAtMostOneEnvironment` | Module | A job module MUST contain at most one environment module. |
| `CalculationRequiresFinalization` | Module | Co-constraint: if a calculation module is present inside a job, a finalization MUST also be present. |
| `InitializationAtMostOneMolecule` | Module | The initialization module MUST NOT contain more than one molecule child. |
| `InitializationAtMostOneParameterList` | Module | The initialization module MUST NOT contain more than one parameterList child. |
| `InitializationMustNotContainProperty` | Module | The initialization module MUST NOT contain property or propertyList children directly. (Properties belong in finalization.) |
| `FinalizationAtMostOneMolecule` | Module | The finalization module MUST NOT contain more than one molecule child. |
| `FinalizationAtMostOnePropertyList` | Module | The finalization module MUST NOT contain more than one propertyList child. |
| `FinalizationMustNotContainParameter` | Module | The finalization module MUST NOT contain parameter or parameterList children directly. (Parameters belong in initialization.) |
| `EnvironmentAtMostOnePropertyList` | Module | The environment module MUST NOT contain more than one propertyList child. |
| `EnvironmentMustNotContainParameter` | Module | The environment module MUST NOT contain parameter or parameterList children directly. It MAY contain a propertyList (which itself can hold parameters). |
| `ScalarUnits` | Scalar | CompChem value-container rules: `scalar` with dataType `xsd:integer` or `xsd:double` MUST have `units`; `scalar` with dataType `xsd:string` MUST NOT have `units`. |
| `ArrayRules` | Array | CompChem `array` value-container rules: MUST have `size` attribute (≥ 1); `dataType` MUST be integer or double; MUST have `units`. |
| `MatrixRules` | Matrix | CompChem `matrix` value-container rules: MUST have `rows` and `columns` attributes (each ≥ 1); `dataType` MUST be integer or double; MUST have `units`. |
| `InitializationMustHaveContent` | Module | An `initialization` module MUST contain at least one of: `molecule`, `parameterList`, or a user-defined module child. Per the compchem convention spec. |
| `FinalizationMustHaveContent` | Module | A `finalization` module MUST contain at least one of: `molecule`, `propertyList`, or a user-defined module child. Per the compchem convention spec. |

## convention:dictionary

- **Namespace**: `http://www.xml-cml.org/convention/dictionary`
- **Constraint count**: 8

| Constraint | Applies to | Description |
|---|---|---|
| `EntryMustHaveIdAndTerm` | DictionaryEntry | Every entry MUST have an `id` and a `term` attribute per the dictionary convention. |
| `EntryIdsUniqueWithinDictionary` | Dictionary | Entry ids MUST be unique within the parent dictionary per the dictionary convention. |
| `DictionaryMustHaveNamespace` | Dictionary | A `<dictionary>` element MUST have a `namespace` attribute whose value is a valid URI defining the scope within which the entry terms are unique. |
| `DictionaryNamespaceShouldEndWithSlashOrHash` | Dictionary | The `namespace` URI SHOULD end with `/` or `#` so terms can be referenced by appending them to the URI. Warning level. |
| `EntryMustContainDefinition` | DictionaryEntry | An `<entry>` MUST contain a single `definition` child element. The schema allows it as a string; this constraint enforces presence. |
| `EntryIdMustMatchPattern` | DictionaryEntry | An `<entry>` `id` MUST match `[A-Za-z][A-Za-z0-9._-]*` — start with a letter, followed by letters/digits/dot/hyphen/ underscore. Mirrors the upstream IdStartChar / IdChar BNF. |
| `EntryMustHaveUnitType` | DictionaryEntry | An `<entry>` MUST have a `unitType` attribute. Entries describing concepts that should not have units (e.g. name of a program) should reference `none` in the standard CML |
| `EntryUnitsCoConstraints` | DictionaryEntry | Co-constraint between `unitType` and `units`: - If `unitType` is `unknown`, `units` MUST NOT be present. - If `unitType` is `none`, `units` MUST be present and point |

## convention:molecular

- **Namespace**: `http://www.xml-cml.org/convention/molecular`
- **Constraint count**: 36

| Constraint | Applies to | Description |
|---|---|---|
| `AtomArrayMustContainAtoms` | Molecule | `atomArray` MUST contain at least one atom. The atoms can be in the child form (`<atom>` elements) or the parallel-array form (`atomID` attribute with whitespace-separated ids). |
| `AtomIdsUniqueWithinMolecule` | _(document-wide)_ | Atom ids MUST be unique within the eldest containing molecule per the molecular convention. |
| `BondMustReferenceAtomsInSameMolecule` | _(document-wide)_ | Bonds MUST reference atoms within the same parent molecule per the molecular convention. |
| `AtomMustHaveId` | Atom | An <atom> inside an atomArray in a molecule MUST have an id attribute. |
| `AtomMustHaveElementType` | Atom | An <atom> inside an atomArray in a molecule MUST have an elementType attribute. |
| `BondMustHaveAtomRefs2` | Bond | A <bond> MUST have an atomRefs2 attribute referencing two distinct atoms in the same molecule. |
| `BondMustHaveOrder` | Bond | A <bond> MUST have an order attribute (S/D/T/A recommended). |
| `MoleculeMustHaveId` | Molecule | A <molecule> in a molecular document MUST have an id attribute unique within document scope. |
| `AtomCoordinatesMustBePaired` | Atom | <atom> 2D coordinates (x2, y2) must appear together; 3D coordinates (x3, y3, z3) must appear together. |
| `PropertyMustHaveDictRef` | Property | A <property> MUST have a dictRef attribute that identifies the property type via a dictionary entry. |
| `ScalarMustHaveDataType` | Scalar | A <scalar> child of a <property> MUST have a dataType attribute (e.g. xsd:float, xsd:integer). |
| `BondOrderShouldNotBeNumeric` | Bond | A <bond>'s order attribute SHOULD be one of S/D/T/Q/A or 'other' (numeric values are not recommended). |
| `AtomIdMustMatchPattern` | Atom | An <atom>'s id attribute SHOULD start with a letter and contain only letters, digits, dot, hyphen, or underscore. |
| `MoleculeCountMustNotAppearOnTopLevel` | _(document-wide)_ | Molecular convention: `count` MUST NOT appear on top-level molecules (direct children of `<cml>`). It is REQUIRED on molecules nested inside another `<molecule>`. |
| `MoleculeAtomArrayMutuallyExclusiveWithChildren` | Molecule | Molecular convention: a `<molecule>` MAY hold an `atomArray` OR child `<molecule>` elements, but not both. The two are mutually exclusive ways of describing composition. |
| `MoleculeBondArrayMutuallyExclusiveWithChildren` | Molecule | Molecular convention: a `<molecule>` MAY hold a `bondArray` OR child `<molecule>` elements, but not both. |
| `BondStereoWedgeHashMustHaveAtomRefs2` | BondStereo | Molecular convention: `<bondStereo>` value W (wedge) or H (hatch) MUST have `atomRefs2` and MUST NOT have `atomRefs4`. |
| `BondStereoCisTransMustHaveAtomRefs4` | BondStereo | Molecular convention: `<bondStereo>` value C (cis) or T (trans) MUST have `atomRefs4` and MUST NOT have `atomRefs2`. |
| `BondStereoOtherMustHaveDictRef` | BondStereo | Molecular convention: `<bondStereo>` with value `other` MUST have a `dictRef` pointing to the convention that defines the stereo semantics. |
| `BondIdsUniqueWithinMolecule` | _(document-wide)_ | Molecular convention: a `<bond>` `id` MUST be unique within the eldest containing molecule. Mirrors the existing `AtomIdsUniqueWithinMolecule` constraint for bonds. |
| `BondOrderOtherMustHaveDictRef` | Bond | Molecular convention: `<bond>` with `order="other"` MUST have a `dictRef` pointing to the dictionary that defines the order semantics. The warning-level "should not be |
| `AtomArrayMustBeChildOfMoleculeOrFormula` | _(document-wide)_ | Molecular convention: `<atomArray>` MUST be a child of `<molecule>` or `<formula>`. Any other parent is invalid. Checked from the parent's perspective during the walk — |
| `BondArrayMustBeChildOfMolecule` | _(document-wide)_ | Molecular convention: `<bondArray>` MUST be a child of `<molecule>`. Any other parent is invalid. |
| `BondOrderShouldBeInEnum` | Bond | A `<bond>`'s `order` attribute SHOULD be one of the XSD orderType enum values: S/1/D/2/T/3/A/unknown/other. Warning severity — CML permits extension values via |
| `BondStereoShouldBeInEnum` | BondStereo | A `<bondStereo>`'s `value` attribute SHOULD be one of the XSD stereoType enum values: C/T/W/H/undefined/other. Warning severity. |
| `MoleculeChiralityShouldBeInEnum` | Molecule | A `<molecule>`'s `chirality` attribute SHOULD be one of the XSD chiralityType enum values: enantiomer/racemate/unknown/other. Warning severity. |
| `BondAtomRefs2ShouldBeDistinct` | Bond | A `<bond>`'s `atomRefs2` SHOULD reference two distinct atom ids. A self-bond (`a1 a1`) is chemically meaningless. Warning severity — there are edge cases in non-classical |
| `ReferencesShouldResolve` | _(document-wide)_ | Walks the document via `Cml::ReferenceResolver` and reports every bond whose `atomRefs2` references atoms that don't exist in the parent molecule. Warning severity — there are |
| `BondStereoAtomRefs4ShouldBeDistinct` | BondStereo | A `<bondStereo>` with `atomRefs4` (used by C/T stereo) SHOULD reference four distinct atom ids. Duplicate ids make the stereo descriptor meaningless. Warning severity. |
| `AtomParityAtomRefs4ShouldBeDistinct` | AtomParity | An `<atomParity>` element's `atomRefs4` attribute SHOULD reference four distinct atom ids around a chiral center. Duplicate ids make the parity descriptor meaningless. |
| `AtomElementTypeShouldBeInPeriodicTable` | Atom | An `<atom>`'s `elementType` attribute SHOULD be one of the XSD elementTypeType enum values (the periodic table plus the special "Du" dummy and "R" group placeholder). Warns |
| `DictRefShouldResolve` | Atom, Bond, Molecule, Property, Scalar, Array, Matrix, Name, Label | Walks the document and warns on any element whose `dictRef` attribute cannot be resolved against the built-in dictionaries. Catches typos like `dictRef="cml:bpingpoint"`. |
| `MoleculeIdShouldMatchPattern` | Molecule | A `<molecule>`'s `id` attribute SHOULD match the XSD moleculeIDType pattern (letter/underscore start, alphanumeric body, optional namespace prefix). Warning severity. |
| `BondIdShouldMatchPattern` | Bond | A `<bond>`'s `id` attribute SHOULD match the XSD idType pattern (letter start, alphanumeric body with dots/dashes). Warning severity. |
| `AtomParityShouldIncludeParentAtom` | _(document-wide)_ | Walks the document and warns on `<atomParity>` elements whose parent `<atom>`'s id does not appear in atomRefs4. The CML convention requires the parent atom to be one of |
| `PropertyScalarDataTypeMatchesDictionary` | Property | A `<property>` with a `dictRef` whose dictionary entry declares a `dataType` SHOULD have a child `<scalar>` whose `dataType` attribute matches. Catches inconsistencies like a property |

## convention:simpleUnit

- **Namespace**: `http://www.xml-cml.org/convention/simpleUnit`
- **Constraint count**: 3

| Constraint | Applies to | Description |
|---|---|---|
| `UnitMustHavePower` | Unit | A `<unit>` under simpleUnit MUST declare a `power` attribute (integer). Without a power the unit's exponent is undefined. |
| `UnitMustHaveSymbol` | Unit | A `<unit>` under simpleUnit MUST declare a non-empty `symbol` attribute. Without a symbol the unit cannot be rendered in formulae. |
| `RootMustBeUnitList` | _(document-wide)_ | The root of a simpleUnit document MUST be a `<unitList>` declaring `convention="convention:simpleUnit"`. Any other root shape is rejected. |

## convention:spectroscopy

- **Namespace**: `http://www.xml-cml.org/convention/spectroscopy`
- **Constraint count**: 5

| Constraint | Applies to | Description |
|---|---|---|
| `SpectrumMustHaveConvention` | Spectrum | A `<spectrum>` MUST declare its own convention attribute so consumers know how to interpret its format and peaks. Per the molecular convention: "spectrum — any number, each MUST |
| `SpectrumMustHaveFormat` | Spectrum | A `<spectrum>` MUST have a `format` attribute (e.g. "mass", "ir", "nmr", "uv") so consumers know the measurement type. |
| `SpectrumMustHaveContent` | Spectrum | A `<spectrum>` MUST contain at least one of: `<xaxis>`, `<yaxis>`, `<peakList>`. An empty spectrum carries no data. |
| `PeakListMustContainPeaks` | PeakList | A `<peakList>` MUST contain at least one `<peak>` or `<peakGroup>` child. An empty peakList carries no data. |
| `PeakShouldHaveValues` | Peak | A `<peak>` SHOULD declare at least one of `xValue` or `yValue`. A peak with neither carries no position information. Warning severity — there are edge cases |

## convention:unit-dictionary

- **Namespace**: `http://www.xml-cml.org/convention/unit-dictionary`
- **Constraint count**: 10

| Constraint | Applies to | Description |
|---|---|---|
| `UnitMustHaveSymbolAndUnitType` | Unit | Every unit MUST have `id`, `title`, `symbol`, `parentSI`, at least one of `multiplierToSI`/`constantToSI`, and `unitType` per the unit-dictionary convention. |
| `UnitMustHaveId` | Unit | A `<unit>` element MUST have an `id` attribute, unique within the unitList. |
| `UnitMustContainDefinition` | Unit | A `<unit>` element MUST contain a single `<definition>` child element with XHTML content. |
| `UnitListMustHaveNamespace` | UnitList | A `<unitList>` element MUST have a `namespace` attribute whose value is a valid URI defining the scope within which the unit ids are unique. SHOULD end with `/` or `#`. |
| `UnitListMustContainAtLeastOneUnit` | UnitList | A `<unitList>` element MUST contain one or more `<unit>` children, and MUST NOT contain any other CML-namespace child elements. |
| `UnitMustHaveTitle` | Unit | A `<unit>` element MUST have a `title` attribute (the full human-readable name of the unit). Per the unit-dictionary convention spec. |
| `UnitMustHaveParentSi` | Unit | A `<unit>` element MUST have a `parentSI` attribute — a QName referencing the SI unit it derives from. Per the unit-dictionary convention spec. |
| `UnitMustHaveMultiplierOrConstantToSi` | Unit | A `<unit>` element MUST have at least one of `multiplierToSI` or `constantToSI` — to define the conversion to the parent SI unit. Per the unit-dictionary convention spec. |
| `UnitUnitTypeShouldResolve` | Unit | A `<unit>`'s `unitType` attribute SHOULD reference a unitType that exists in a built-in unitType-dictionary. Catches typos like `unitType="unitType:lenght"` (misspelled). |
| `UnitParentSiShouldResolve` | Unit | A `<unit>`'s `parentSI` attribute SHOULD reference a unit that exists in a built-in dictionary (typically the SI dictionary). Catches typos like `parentSI="si:metr"`. |

## convention:unitType-dictionary

- **Namespace**: `http://www.xml-cml.org/convention/unitType-dictionary`
- **Constraint count**: 5

| Constraint | Applies to | Description |
|---|---|---|
| `UnitTypeMustHaveIdAndName` | UnitType | Every unitType MUST have an `id` and a `name` attribute per the unitType-dictionary convention. |
| `UnitTypeIdMustMatchPattern` | UnitType | A `<unitType>` `id` MUST match `[A-Za-z][A-Za-z0-9._-]*`. |
| `UnitTypeMustContainDefinition` | UnitType | A `<unitType>` MUST contain a single `<definition>` child with XHTML content. |
| `UnitTypeListMustHaveNamespace` | UnitTypeList | A `<unitTypeList>` MUST have a `namespace` attribute (valid URI, SHOULD end with `/` or `#`). |
| `UnitTypeListMustContainAtLeastOneUnitType` | UnitTypeList | A `<unitTypeList>` MUST contain one or more `<unitType>` children. |
