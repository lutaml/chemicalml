<!-- Source: http://www.xml-cml.org/convention/unitType-dictionary -->
<!-- Editors: Sam Adams, Joe Townsend (University of Cambridge) -->
<!-- License: CC-BY-3.0 (http://creativecommons.org/licenses/by/3.0/) -->

# CML Unit-Type Dictionary Convention

**Latest version:** http://www.xml-cml.org/convention/unitType-dictionary
**Editors:** Sam Adams, Joe Townsend (University of Cambridge)

## Abstract

This specification defines the requirements of the Chemical Markup
Language unitType-dictionary convention. Unit types abstract over
units: e.g. the units metre, angstrom and picometre are all of type
*length*; Kelvin is of type *temperature*.

## Applying the unitType-dictionary convention

The unitType-dictionary convention MUST be specified using the
`convention` attribute on a `unitTypeList` element.

## UnitTypeList Element

The `unitTypeList` element MUST have a `namespace` attribute (valid URI,
SHOULD end with `/` or `#`).

The `unitTypeList` element SHOULD have a `title` attribute (non-empty).

The `unitTypeList` element SHOULD have a single `description` child
element with XHTML content.

The `unitTypeList` element MUST contain one or more child `unitType`
elements, and MUST NOT contain any other CML-namespace child elements.

## UnitType Elements

A `unitType` element MUST have an `id` attribute unique within the
unitTypeList. Pattern: `[A-Za-z][A-Za-z0-9._-]*`.

A `unitType` element MUST have a `name` attribute — the full name of
the unit type (e.g. `length`, `temperature`, `time`).

A `unitType` element MUST contain a single `definition` child element
with XHTML content.

A `unitType` element MAY have a single `description` child element with
XHTML content.

## Acknowledgements

Peter Murray-Rust, Joe Townsend, Sam Adams, Egon Willighagen.
