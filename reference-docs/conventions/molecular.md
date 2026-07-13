<!-- Source: http://www.xml-cml.org/convention/molecular -->
<!-- Editors: Sam Adams, Joe Townsend (University of Cambridge) -->
<!-- License: CC-BY-3.0 (http://creativecommons.org/licenses/by/3.0/) -->

# CML Molecular Convention

**This version:** http://www.xml-cml.org/convention/molecular-20110828
**Latest version:** http://www.xml-cml.org/convention/molecular
**Authors:** See acknowledgments.
**Editors:** Sam Adams, Joe Townsend (University of Cambridge)

## Abstract

This specification defines the requirements of the Chemical Markup Language
Molecular convention. This document describes the concepts which are
introduced in the molecular convention, explains how to compose a document
that conforms to the molecular convention and illustrates these with
examples.

## Namespaces

| Prefix | Namespace URI | Description |
| --- | --- | --- |
| `cml` | `http://www.xml-cml.org/schema` | Chemical Markup Language elements |
| `convention` | `http://www.xml-cml.org/convention/` | Standard CML convention namespace |

## Applying the molecular convention

The molecular convention MUST be specified using the `convention`
attribute on a `molecule` element or a `cml` element. The value of the
attribute MUST be a QName that represents the molecular convention,
i.e. `convention:molecular`. If the molecular convention is specified
on a `cml` element then that element MUST have at least one child
`molecule` element that either has no convention specified or specifies
the molecular convention.

## Molecule Element

Within the molecular convention, a `molecule` is REQUIRED to be a child
of either `cml` or `molecule` elements.

A `molecule` MAY hold any combination of:

1. a string representation of a molecule (`name`, `label`, or `inline`
   attribute on `formula`)
2. the chemical composition of a substance (`concise` attribute on
   `formula`, or `atomArray`)
3. a connection table of `atom`s connected by `bond`s

### Molecule sub-rules

- `id` — REQUIRED, unique within document scope. Pattern:
  `[A-Za-z][A-Za-z0-9._-]*`
- `count` — REQUIRED on child molecules, MUST NOT appear on top-level
  molecules. Non-negative number.
- `atomArray` — at most one. Mutually exclusive with child `molecule`s.
- `bondArray` — at most one. Mutually exclusive with child `molecule`s.
- `formula` — any number
- `property` — any number
- `label` — any number
- `name` — any number
- `formalCharge` — RECOMMENDED
- `spinMultiplicity` — RECOMMENDED
- `chirality` — OPTIONAL
- `spectrum` — any number, each MUST specify its own convention

## AtomArray

MUST be a child of `molecule` or `formula`. Container for `atom`s.
MUST contain at least one child `atom`.

## BondArray

MUST be a child of `molecule`. Container for `bond`s.
MUST contain at least one child `bond`.

## Atom Element

MUST be a child of `atomArray`. MUST have `elementType` attribute.
MUST have `id` if inside an `atomArray` in a `molecule` (optional in
`formula`).

Supported attributes: `x2`/`y2` (2D display, must appear together),
`x3`/`y3`/`z3` (3D coords in Angstrom, right-handed, must appear
together), `formalCharge`, `isotopeNumber`, `spinMultiplicity`,
`count` (only inside `formula`), `atomParity` child, any number of
`label` and `property` children.

## Bond Element

MUST be a child of `bondArray`. Bonds are between exactly two `atom`s
in the same parent `molecule`.

- `atomRefs2` — REQUIRED, two distinct atom ids in same molecule
- `order` — REQUIRED. Recommended values: `S`, `D`, `T`, `Q`, `A`.
  Numeric values NOT recommended. If `other`, MUST have `dictRef`.
- `id` — RECOMMENDED, unique within eldest containing molecule
- `bondStereo` child — OPTIONAL
- `label` children — any number

## BondStereo Element

MUST be a child of `bond`. Supports cis (`C`) / trans (`T`) and
wedge (`W`) / hatch (`H`).

- If value is `W` or `H` — MUST have `atomRefs2` (the two atoms in the
  parent bond; first = sharp end, second = blunt end). MUST NOT have
  `atomRefs4`.
- If value is `C` or `T` — MUST have `atomRefs4` (four distinct atom
  ids; two MUST be the parent bond's atoms). MUST NOT have `atomRefs2`.
- If value is `other` — MUST have `dictRef`.

## Acknowledgements

Joe Townsend, Peter Murray-Rust, Alex Wade, Sam Adams.
