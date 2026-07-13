<!-- Source: http://www.xml-cml.org/convention/dictionary -->
<!-- Editors: Sam Adams, Joe Townsend (University of Cambridge) -->
<!-- License: CC-BY-3.0 (http://creativecommons.org/licenses/by/3.0/) -->

# CML Dictionary Convention

**This version:** http://www.xml-cml.org/convention/dictionary-20110525
**Latest version:** http://www.xml-cml.org/convention/dictionary
**Editors:** Sam Adams, Joe Townsend (University of Cambridge)

## Abstract

This specification defines the requirements of the Chemical Markup Language
dictionary convention.

## Namespaces

| Prefix | Namespace URI | Description |
| --- | --- | --- |
| `cml` | `http://www.xml-cml.org/schema` | Chemical Markup Language elements |
| `convention` | `http://www.xml-cml.org/convention/` | Standard CML convention namespace |
| `xhtml` | `http://www.w3.org/1999/xhtml` | XHTML |

## Applying the dictionary convention

The dictionary convention MUST be specified using the `convention`
attribute on either a `cml` or a `dictionary` element. If specified on a
`cml` element, that element MUST contain a single child `dictionary`
element in the CML namespace.

## Dictionary Element

### Namespace

The `dictionary` element MUST have a `namespace` attribute, the value of
which MUST be a valid URI defining the scope within which the entry terms
are unique. The namespace URI SHOULD end with `/` or `#` so terms can be
referenced by appending them to the URI.

### Prefix

The `dictionary` element SHOULD have a `dictionaryPrefix` attribute
specifying the default prefix. MUST be a valid XML QName prefix, SHOULD
be unique within the CML domain.

### Title

The `dictionary` element SHOULD have a `title` attribute for
human-readability.

### Description

The `dictionary` element SHOULD have a single `description` child
element. MUST contain one or more child elements in the XHTML namespace.
MUST NOT contain any non-XHTML child elements.

### Entries

The `dictionary` element MUST contain one or more child `entry` elements,
and MUST NOT contain any other child elements from the CML namespace.

## Entry Elements

### Id

An `entry` element MUST have an `id` attribute, the value of which MUST
be unique within the scope of the dictionary. MUST start with a letter,
MUST only contain letters, numbers, dot, hyphen or underscore.

| | | |
| --- | --- | --- |
| `IdStartChar` | ::= | `[A-Z] \| [a-z]` |
| `IdChar` | ::= | `IdStartChar \| [0-9] \| "." \| "-" \| "_"` |
| `Id` | ::= | `IdStartChar (IdChar)*` |

### Term

An `entry` element MUST have a `term` attribute, the value of which
provides a unique nounal phrase linguistically identifying the subject
of the entry.

### Definition

An `entry` element MUST contain a single `definition` child element. MUST
contain one or more child elements in the XHTML namespace. MUST NOT
contain any non-XHTML child elements.

### Description

An `entry` element MAY have a single `description` child element providing
further information: examples, human-readable semantics, hyperlinks. MUST
contain XHTML child elements only.

### Data type

When applicable, an `entry` SHOULD have `dataType` attribute, value is a
QName referencing the data type of the value. Common types:
`xsd:string`, `xsd:double`, `xsd:integer`, `xsd:boolean`.

### Unit type

An `entry` MUST have a `unitType` attribute, value is a QName referencing
the unit type (e.g. temperature). An entry describing a concept that
should not have units (e.g. name of a program) should have unitType
`none` in the standard CML unitType dictionary.

### Default units

When applicable, an `entry` SHOULD have a `units` attribute, value is a
QName referencing the default units (e.g. Kelvin).

If `unitType` is `unknown`, the `units` attribute MUST NOT be present.
If `unitType` is `none`, the `units` attribute MUST be present and must
point to `http://www.xml-cml.org/unit/si#none`.

## Acknowledgements

Peter Murray-Rust, Joe Townsend, Nick England, Weerapong Phadungsukanan,
Daniel Lowe, Sam Adams, Hannah Barjat.
