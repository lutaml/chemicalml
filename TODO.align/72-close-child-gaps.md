# 72 — Close remaining Schema24 child gaps

## Why

After TODO 64 closed the bulk of Schema24 child gaps via
`CommonChildren`, ~140 element-specific children remain unmodelled.
These are concrete child declarations the XSD permits and real CML
documents use.

## Work

Add element-specific children to each Base module below. For each,
add a round-trip spec covering at least one new child.

| Element | Children to add |
|---|---|
| reactiveCentre | atomSet, atomTypeList, bondSet, bondTypeList |
| sample | molecule, substance, substanceList |
| spectator | molecule, object |
| transitionState | molecule, propertyList |
| substance | amount, property |
| substanceList | amount, propertyList |
| lattice | matrix, scalar, symmetry |
| table | arrayList, tableRowList |
| trow | tcell |
| unit | metadata, unitType (annotation via CommonChildren) |
| unitType | dimension (annotation via CommonChildren) |
| dictionary | unitList (annotation via CommonChildren) |
| dictionaryEntry | alternative, enumeration, relatedEntry |
| gradient | array, matrix, property, scalar |
| eigen | array, matrix |
| xaxis, yaxis | array |
| zMatrix | angle, length, torsion |
| symmetry | matrix, transform3 |
| map | link |
| join | angle, length, torsion, molecule, arg |
| fragment | fragmentList, join |
| fragmentList | join |
| formula | formula (self-ref) |
| parameter | expression, gradient, property |
| potential | arg |
| atomicBasisFunction | gradient |
| isotope | abundance |
| atomType | atom, molecule, scalar, array, matrix, property |
| bondType | bond, molecule, scalar, array, matrix, property |
| arg | atom, atomType, expression, scalar, array, matrix |
| expression | operator, parameter |
| potentialForm | arg, expression, parameter |
| annotation | appinfo |
| enumeration | annotation |
| metadataList | metadataList (self-ref) |
| moleculeList | list, moleculeList (self-ref) |
| parameterList | parameterList (self-ref) |
| productList | productList (self-ref) |
| reactantList | reactantList (self-ref) |
| reactionList | reactionScheme |
| reactionScheme | identifier, reactionScheme (self-ref) |
| reactionStep | reactionScheme |
| peakGroup | atom, bond, molecule, peakGroup (self-ref) |
| peakStructure | peakStructure (self-ref) |
| spectrumList | list, spectrumList (self-ref) |

## Acceptance

- Static XSD child gap analysis (accounting for CommonChildren) reports < 20 remaining gaps.
- All new child declarations have at least one round-trip spec.
