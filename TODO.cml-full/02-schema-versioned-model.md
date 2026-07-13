# 02 — Schema-versioned wire model

**Status:** pending
**Depends on:** 01

## Goal

Support both CML schema 2.4 and schema 3 as first-class wire formats.
The two XSDs (already in `reference-docs/schemas/`) are the source of
truth for element/attribute names and content models.

## Why split the namespace

Schema 3 loosened the content model of schema 2.4 — many elements
gained optional children, some attribute types changed, and a few new
elements were added. Conflating the two into one class set:

- forces every user to pay schema-3-only validation cost,
- makes it impossible to express "this element only exists in schema 3",
- hides which version a round-trip targets.

Keeping them separate (Schema24 / Schema3 namespaces) gives users an
explicit choice and keeps each class honest about its own version.

## Deliverables

- [ ] `Chemicalml::Schema` registry: maps version symbols (`:schema24`,
      `:schema3`) to their XSD path, namespace, and the wire-class
      namespace.
- [ ] `Chemicalml::Cml::Schema3::*` — schema 3 wire classes
- [ ] `Chemicalml::Cml::Schema24::*` — schema 2.4 wire classes
- [ ] A shared mixin `Chemicalml::Cml::Common` for the elements that
      have **identical** shapes in both versions (most of them —
      schema 3 is largely a superset). The mixin carries `attribute`
      declarations and the `xml do ... end` mapping block; the
      schema-specific class includes it.
- [ ] For elements that differ between versions (e.g. `molecule`'s
      content model), each version gets its own dedicated class — no
      shared mixin.
- [ ] Update `Chemicalml::Cml::Translator` so it accepts a
      `schema:` keyword and dispatches to the right wire class set.

## Scope of classes to add

Driven by what the conventions and example fixtures need:

Common (likely shared via mixin): `atom`, `atomArray`, `bond`,
`bondArray`, `name`, `identifier`, `formula`, `property`, `parameter`,
`scalar`, `array`, `matrix`, `label`, `module`, `list`, `reaction`,
`reactantList`, `reactant`, `productList`, `product`, `reactionList`,
`substance`, `substanceList`, `spectator`, `spectatorList`,
`parameterList`, `propertyList`, `metadata`, `metadataList`,
`atomParity`, `bondStereo`, `atomSet`, `bondSet`, `torsion`, `angle`,
`length`, `zMatrix`, `crystal`, `lattice`, `latticeVector`,
`cellParameter`, `eigenvector`.

Differences to honor:

- Schema 2.4: stricter content models (e.g. `<molecule>` cannot have
  arbitrary child modules).
- Schema 3: introduced `<module>` as a generic grouping container;
  loosened `<cml>` to allow any top-level CML element.

## Acceptance

- All schema-versioned wire classes are loadable.
- Both schema XSDs round-trip the example fixtures in their respective
  `spec/fixtures/schema{24,3}/` directories.
- No `require_relative` anywhere — all loading via autoload in
  `lib/chemicalml/cml/schema3.rb`, `schema24.rb`, etc.
