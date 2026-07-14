# TODO.align (round 11)

Full CML schema coverage: every element from the XSD now has wire
classes across Base, Role, Schema3, Schema24, and the Cml alias
namespace.

| # | Workstream | Status |
|---|---|---|
| 41 | Full CML element coverage (all 121 XSD elements) | complete |
| 42 | Final spec + lint pass | complete |

## What was added

85 new CML elements, each with 4 generated files (Base mixin, Role
module, Schema3 class, Schema24 class) + autoload declarations +
Elements::ALL entry. The gem now covers every element defined in the
CML Schema 3 XSD.

### New element categories

- **Geometry**: crystal, lattice, latticeVector, cellParameter,
  zMatrix, line3, plane3, point3, sphere3, transform3, vector3,
  angle, length, torsion
- **Spectroscopy**: spectrum, spectrumData, spectrumList, peak,
  peakGroup, peakList, peakStructure, xaxis, yaxis
- **Reactions**: reactionScheme, reactionStep, reactionStepList,
  reactiveCentre, transitionState, mechanism, mechanismComponent,
  spectator, spectatorList, moleculeList, substanceList
- **Electronic structure**: electron, atomicBasisFunction, eigen,
  gradient, band, bandList, basisSet, kpoint, kpointList
- **Sets / types**: atomSet, atomType, atomTypeList, bondSet,
  bondType, bondTypeList
- **Containers**: conditionList, fragment, fragmentList, region,
  sample, system, potential, potentialForm, potentialList
- **Documentation**: definition, description, documentation, dimension
- **Tables**: table, tableCell, tableContent, tableHeader,
  tableHeaderCell, tableRow, tableRowList
- **Misc**: abundance, action, actionList, amount, anyCml, arrayList,
  isotope, isotopeList, join, link, map, object, observation,
  particle, stmml, symmetry

### Metrics

- Elements::ALL: 121 entries (up from 36)
- Base mixins: 121
- Role modules: 121
- Schema3 classes: 121
- Schema24 classes: 120 (Module is schema3-only)
- 179 specs, 0 failures
- 0 forbidden patterns
