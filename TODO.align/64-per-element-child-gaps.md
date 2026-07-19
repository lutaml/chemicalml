# 64 — Per-element child element gaps (Schema 2.4)

## Why

XSD vs Ruby Base comparison reveals 235 missing child declarations
across ~60 Schema 2.4 elements. These are real CML elements that
real CML documents contain but our Ruby model drops silently.

The Schema 3 XSD declares `<anyCml>` (a wildcard) as a child of every
element — that is intentionally NOT modelled as a concrete child,
because doing so would defeat the type system. The Schema 2.4 gaps
below are *specific* named children, not wildcards.

## Largest clusters

| Element | Missing children |
|---|---|
| molecule | angle, arg, array, crystal, electron, join, length, list, matrix, metadataList, propertyList, scalar, symmetry, torsion, zMatrix |
| reaction | conditionList, identifier, label, map, mechanism, metadataList, name, object, propertyList, reactiveCentre, spectatorList, substanceList, transitionState |
| reactant, product | amount, electron, formula, identifier, label, metadataList, molecule, name, substanceList |
| atom | array, atomType, electron, label, matrix, name, particle, scalar, vector3 |
| atomType, bondType | array, atom/bond, label, matrix, molecule, property, scalar |
| join | angle, arg, label, length, metadataList, molecule, torsion |
| peak, peakGroup | atom, bond, metadataList, molecule, peakStructure/peakGroup |
| spectrum | metadataList, parameterList, sample, spectrumData, substanceList |
| reactiveCentre | atomSet, atomTypeList, bondSet, bondTypeList, description |
| parameter | expression, gradient, property |
| property | metadataList, name |
| parameterList, productList, reactantList, reactionStepList | metadataList, name, *(selfRef)* |
| moleculeList | list, metadataList, moleculeList |
| sample | metadataList, molecule, substance, substanceList |
| spectator | label, metadataList, molecule, object |
| substance | amount, metadataList, property |
| substanceList | amount, metadataList, propertyList |
| lattice | matrix, scalar, symmetry |
| gradient | array, matrix, property, scalar |
| table | arrayList, tableRowList |
| transitionState | molecule, propertyList |
| unit | annotation, metadata, metadataList, unit, unitType |
| unitType | annotation, dimension |
| zMatrix | angle, length, torsion |
| symmetry | matrix, transform3 |
| eigen | array, matrix |
| xaxis, yaxis | array |
| metadataList | metadataList |
| crystal | cellParameter |
| formula | formula |
| dictionary | annotation, unitList |
| dictionary entry | alternative, annotation, enumeration, metadataList, relatedEntry |
| map | link |
| mechanism | description, label, name |
| peakStructure | metadataList, peakStructure |
| reactionList | metadataList, reactionScheme |
| reactionScheme | identifier, label, metadataList, name, reactionScheme |
| reactionStep | label, metadataList, name, reactionScheme |
| potentialForm | arg, expression, parameter |
| trow | tcell |
| peakList | metadataList |
| atomTypeList, bondTypeList, basisSet | metadataList, name |
| conditionList | list, metadataList, name |
| propertyList | metadataList, name, observation, propertyList |
| spectrumList | list, metadataList, spectrumList |

## Strategy

After TODO 63 (CommonChildren mixin) closes, ~80% of the
`metadataList`/`label`/`name`/`description` gaps are absorbed by
adding one `include CommonChildren` line. The remaining ~150 gaps are
element-specific and require individual declarations.

## Work

1. Apply CommonChildren where the XSD permits.
2. For each remaining gap, add the specific `attribute` + `map_element` declarations.
3. Add at least one spec per touched element covering a round-trip
   with the new child.

## Acceptance

- XSD vs Ruby child comparison reports only `<anyCml>` Schema3 wildcard gaps (intentionally unmodelled).
- Specs green.
