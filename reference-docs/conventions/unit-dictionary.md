<!-- Source: http://www.xml-cml.org/convention/unit-dictionary -->
<!-- Editors: Sam Adams, Joe Townsend (University of Cambridge) -->
<!-- License: CC-BY-3.0 (http://creativecommons.org/licenses/by/3.0/) -->

# CML Unit Dictionary Convention

**This version:** http://www.xml-cml.org/convention/unit-dictionary-20110303
**Latest version:** http://www.xml-cml.org/convention/unit-dictionary
**Editors:** Sam Adams, Joe Townsend (University of Cambridge)

## Abstract

This specification defines the requirements of the Chemical Markup
Language unit-dictionary convention.

## Applying the unit-dictionary convention

The unit-dictionary convention MUST be specified using the `convention`
attribute on a `unitList` element.

## UnitList Element

### Namespace

The `unitList` element MUST have a `namespace` attribute, value MUST be
a valid URI defining the scope within which the unit ids are unique.
SHOULD end with `/` or `#`.

### Title

The `unitList` element SHOULD have a `title` attribute (non-empty).

### Description

The `unitList` element SHOULD have a single `description` child element.
MUST contain XHTML child elements only.

### Units

The `unitList` element MUST contain one or more child `unit` elements,
and MUST NOT contain any other child elements from the CML namespace.

## Unit Elements

### Id

A `unit` element MUST have an `id` attribute, unique within the
unitList. Pattern: same as dictionary entry ids.

### Title

A `unit` element MUST have a `title` attribute — typically the full
name (id is the abbreviation, e.g. id=`kg`, title=`kilogram`).

### Symbol

A `unit` element MUST have a `symbol` attribute — the full symbol used
to represent this unit (e.g. `K`, `Hz`, `J`, `Bq`).

### Parent SI

A `unit` element MUST have a `parentSI` attribute — QName referencing
the parent SI unit (e.g. calorie's parentSI is joule).

### Multiplier and/or Constant to SI

A `unit` element MUST have at least one of `multiplierToSI` or
`constantToSI` (both doubles).

- `multiplierToSI` — factor to multiply by to convert to SI (applied
  before constantToSI). Unity for SI units.
- `constantToSI` — amount to add to convert to SI (applied after
  multiplierToSI). Zero for SI units.

### Unit Type

Every `unit` element MUST have a `unitType` attribute — QName
referencing the unit type (time, temperature, length, force, ...).

### Definition

A `unit` element MUST contain a single `definition` child element with
XHTML content.

### Description

A `unit` element MAY have a single `description` child element with
XHTML content.

## Acknowledgements

Peter Murray-Rust, Joe Townsend, Sam Adams, Egon Willighagen.
