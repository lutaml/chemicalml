# TODO.align (round 12)

Full CML schema coverage — parent-child wiring + remaining
dictionaries + universal root parsing.

| # | Workstream | Status |
|---|---|---|
| 42 | Wire parent-child relationships for 33 container elements | complete |
| 43 | Add cml, cml_name, cml_formula, cif dictionaries | complete |
| 44 | Universal root parsing (any element can be root) | complete |
| 45 | Full coverage spec (121 elements + 8 dictionaries) | complete |

## What was added

### Parent-child relationships (33 containers wired)

Every CML container element now declares its valid child elements.
Previously, parsing `<crystal><scalar>5.64</scalar></crystal>`
would silently drop the `<scalar>` child. Now it's preserved.

Wired containers include:
Molecule (crystal, spectrum, propertyList), Crystal (scalar,
lattice, symmetry), Lattice (latticeVector), Spectrum (xaxis,
yaxis, peakList, conditionList), PeakList (peak, peakGroup),
Reaction (spectatorList, conditionList, metadataList),
ReactionScheme, ReactionStepList, ReactionStep, ConditionList,
FragmentList, Fragment, IsotopeList, BandList, KpointList,
PotentialList, Table, TableContent, TableHeader, TableRow,
TableRowList, SpectatorList, MoleculeList, SubstanceList,
ActionList, AtomTypeList, BondTypeList, Mechanism, SpectrumList,
SpectrumData, BasisSet, System.

### Remaining dictionaries (4 added)

- **cml.yaml** (23 entries) — fundamental chemistry concepts
  (molmass, bp, mp, density, refractiveIndex, solubility,
  vaporPressure, flashPoint, autoignitionTemp, pH, viscosity,
  surfaceTension, dipoleMoment, polarizability, heatOfFormation,
  entropy, freeEnergy, ionizationEnergy, electronAffinity,
  electronegativity, bondEnergy, bondLength, bondAngle)
- **cml_name.yaml** (10 entries) — naming conventions (IUPAC,
  trivial, CAS, InChI, InChIKey, SMILES, PubChem, ChemSpider,
  DrugBank, ChEBI)
- **cml_formula.yaml** (7 entries) — formula conventions
  (empirical, molecular, structural, condensed, Hill, SMILES,
  LaTeX)
- **cif.yaml** (19 entries) — crystallography (cell lengths,
  cell angles, cell volume, Z, crystal system, space group,
  fractional coordinates, occupancy, B factor, radiation
  wavelength, resolution)

### Universal root parsing

The `KNOWN_ROOTS` hash is now a fallback, not the primary lookup.
`Chemicalml.parse(xml)` first checks KNOWN_ROOTS, then falls back
to `Elements::ALL` — making ANY CML element parseable as a root.
Adding a new element to `Elements::ALL` automatically makes it
parseable as a standalone document. OCP — no parse code changes
needed.

### Total dictionary count: 8

compchem (51), cml (23), cml_name (10), cml_formula (7), cif (19),
unit_si (25), unit_non_si (13), unit_type (35) = 183 total entries.

## Final metrics

- 188 examples, 0 failures
- 121 CML elements (full XSD coverage)
- 8 dictionaries (183 total entries)
- 33 container elements with child relationships wired
- Universal root parsing
- 0 forbidden patterns
