<!-- Source: http://www.xml-cml.org/convention/compchem -->
<!-- Editors: Weerapong Phadungsukanan, Sam Adams, Joe Townsend, Jens Thomas -->
<!-- License: CC-BY-3.0 (http://creativecommons.org/licenses/by/3.0/) -->

# CML CompChem Convention

**This version:** http://www.xml-cml.org/convention/compchem-20110524
**Latest version:** http://www.xml-cml.org/convention/compchem
**Editors:** Weerapong Phadungsukanan, Sam Adams, Joe Townsend (University
of Cambridge); Jens Thomas (STFC Daresbury Laboratory).

## Abstract

This specification defines the requirements of the Chemical Markup Language
CompChem convention.

## Namespaces

| Prefix | Namespace URI | Description |
| --- | --- | --- |
| `cml` | `http://www.xml-cml.org/schema` | Chemical Markup Language elements |
| `convention` | `http://www.xml-cml.org/convention/` | Standard CML convention namespace |
| `compchem` | `http://www.xml-cml.org/dictionary/compchem/` | CompChem Dictionary namespace |
| `xhtml` | `http://www.w3.org/1999/xhtml` | XHTML |
| `dc` | `http://purl.org/dc/elements/1.1/` | Dublin Core Metadata Element Set, v1.1 |

## Applying the CompChem convention

The CompChem convention MUST be specified using the `convention`
attribute on a `module` element, with value `convention:compchem`. A
CompChem module MUST contain at least one `jobList` module child (e.g.
`<module dictRef="compchem:jobList" id="jobList-0000">`).

## Core concepts

- **JobList** — series of successive subtasks
- **Job** — a computational job (input + calculations + output + environment)
- **Initialization** — model parameters/inputs (REQUIRED)
- **Calculation** — computation/optimisation/iteration (OPTIONAL, nestable)
- **Finalization** — model outputs/results (OPTIONAL)
- **Environment** — host, software, runtime metadata (OPTIONAL)
- **User defined concept** — extension modules with a `dictRef`

## Structural rules

### jobList module

- MUST have `dictRef="compchem:jobList"` on a `module` element
- MUST have an `id` unique within the compchem module
- MUST contain at least one `job` module child
- SHOULD have a `title`

### job module

- MUST have `dictRef="compchem:job"` on a `module` element
- MUST have an `id` unique within the compchem module
- MUST contain exactly one `initialization` module child
- MAY contain zero or more `calculation` module children
- MAY contain no more than one `finalization` module child
- MAY contain no more than one `environment` module child
- If a `calculation` is present, a `finalization` MUST also be present

### initialization module

- MUST have `dictRef="compchem:initialization"`
- MUST NOT contain more than one `molecule` child (the molecule MUST
  specify its convention, SHOULD be molecular)
- MUST NOT contain more than one `parameterList`
- MAY contain any number of `list` elements (for complex objects like
  basis sets, DFT functionals)
- MUST contain at least one of: `molecule`, `parameterList`, or a
  user-defined module
- MUST NOT contain `property` or `propertyList` children

### calculation module

- MUST have `dictRef="compchem:calculation"`
- MUST NOT contain more than one `molecule` child
- MUST contain exactly one `initialization` module child
- MAY contain zero or more `calculation` module children
- MAY contain no more than one `finalization` module child

### finalization module

- MUST have `dictRef="compchem:finalization"`
- MUST NOT contain more than one `molecule` child
- MUST NOT contain more than one `propertyList`
- MUST contain at least one of: `molecule`, `propertyList`, or a
  user-defined module
- MUST NOT contain `parameter` or `parameterList` children

### environment module

- MUST have `dictRef="compchem:environment"`
- MUST NOT contain more than one `propertyList`
- MUST contain at least one of: `parameterList`, user-defined module
- MUST NOT contain `parameter` or `parameterList` directly (only via
  `propertyList`)

## Value containers

CompChem currently only allows `scalar`, `array`, and `matrix` value
containers.

### scalar

- MUST have `dataType` attribute: `xsd:string`, `xsd:integer`, or `xsd:double`
- MUST have `units` if dataType is `xsd:integer` or `xsd:double`
  (even if "unknown" or "dimensionless")
- MUST NOT have `units` if dataType is `xsd:string`

### array

- MUST have `size` attribute (minimum 1)
- `dataType` MUST be `xsd:integer` or `xsd:double`
- MUST have `units` (even if dimensionless)

### matrix

- MUST have `rows` and `columns` attributes (minimum 1)
- `dataType` MUST be `xsd:integer` or `xsd:double`
- MUST have `units` (even if dimensionless)

## Recommended properties/parameters

### environment module

- `hostName`, `runDate`, `program`, `programVersion`

### initialization module

- `basisSet`, `charge`, `dftFunctional`, `method`, `pointGroup`,
  `spinMultiplicity`, `task`, `title`, `wavefunctionType`

### finalization module

- `nuclearRepulsionEnergy`, `totalEnergy`, `wallTime`

## Acknowledgements

Peter Murray-Rust, Joe Townsend, Sam Adams.
