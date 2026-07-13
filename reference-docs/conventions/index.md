<!-- Source: http://www.xml-cml.org/convention/ -->
<!-- License: CC-BY-3.0 (http://creativecommons.org/licenses/by/3.0/) -->

# CML Conventions

Different domains of chemistry think about chemistry differently; often this
means a very tight specification of rules in *your* area of expertise and
very little if any applied to the rest. The loosening of the CML content
model in Schema 3 allows users to combine the elements and attributes as
they need to represent data. However, users still need to be able to
specify a set of rules (constraints) which model their particular domain.
This can be likened to thinking of the elements and attributes of CML as
representing the allowed vocabulary and the set of rules as a grammar
specifying how these words are allowed to be put together. The entire set
of constraints which the CML should conform to is called a `convention`.

## Implemented Conventions

The list of currently supported conventions is given below:

Molecular Convention
:   namespace: `http://www.xml-cml.org/convention/molecular`

CompChem Convention
:   namespace: `http://www.xml-cml.org/convention/compchem`

Dictionary Convention
:   namespace: `http://www.xml-cml.org/convention/dictionary`

Unit Dictionary Convention
:   namespace: `http://www.xml-cml.org/convention/unit-dictionary`

Unit-Type Dictionary Convention
:   namespace: `http://www.xml-cml.org/convention/unitType-dictionary`

There is also a *toy* convention `simpleUnit` which is used as a very
simple example in the CMLLite paper. The namespace of the convention is
`http://www.xml-cml.org/convention/simpleUnit`.

The `dictionary` convention is currently in the most finished state and
acts as a template for how conventions will be described in future.

Constraints are defined by using XSL Transformations (XSLT). These allow
users to put more specific constraints and co-constraints on the allowed
structure of the CML documents than using only schemas. The output is
based on the ISO Schematron standard XML report language SVRL
(Schematron Validation Report Language) to indicate errors and warnings
in the document.

Examples of constraints implemented in the `molecular` convention are:

- an `atomArray` must have at least one `atom` child
- the value of an `atom`'s `id` must be unique within the eldest
  containing molecule
- a `bond` element must have an `atomRefs2` attribute
- a `bond` must be between `atom`s within the same molecule
