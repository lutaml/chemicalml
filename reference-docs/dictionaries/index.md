<!-- Source: http://www.xml-cml.org/dictionary/ -->
<!-- License: CC-BY-3.0 (http://creativecommons.org/licenses/by/3.0/) -->

# CML Dictionaries

Dictionaries allow CML to be *understood* by machines. Much of physical
science is managed through the dictionary mechanism. We find terms and
units relating to an aspect of science (such as heat of formation,
melting point, point group) and create entries for these items in a
dictionary.

The entries can consist of just a unique id (within the dictionary's
namespace) and some human-understandable definition, but we strongly
encourage more information: units, upper/lower bounds, data type.

Different programs sometimes produce data with the same label but a
different interpretation; does `density` mean electron density or
physical density? Each computational chemistry code has its own
dictionary; the community can then group concepts into a higher-level
common dictionary (the compchem dictionary).

## Implemented Dictionaries

### Common Concepts

- **Fundamental Chemistry Concepts** — namespace:
  `http://www.xml-cml.org/dictionary/cml/`
- **Chemical Naming Conventions** — namespace:
  `http://www.xml-cml.org/dictionary/cml/name/`
- **Chemical Formula Conventions** — namespace:
  `http://www.xml-cml.org/dictionary/cml/formula/`

### Crystallography

- **CIF Core Definitions** — namespace:
  `http://www.xml-cml.org/dictionary/cif/`

### Computational Chemistry

- **Computational Chemistry — Core Concepts** — namespace:
  `http://www.xml-cml.org/dictionary/compchem/`

## Unit Dictionaries

### Units

- **SI Units** — namespace: `http://www.xml-cml.org/unit/si/`
- **Non-SI Units** — namespace: `http://www.xml-cml.org/unit/nonSi/`

### Unit Types

- **Unit Types** — namespace: `http://www.xml-cml.org/unit/unitType/`
