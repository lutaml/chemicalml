# 04 — Convention framework

**Status:** pending
**Depends on:** 02

## Goal

Model the five conventions CML publishes, plus a generic
constraint-evaluation framework so adding a new rule is a registration,
not an edit.

## Conventions

Each is identified by its namespace URI and the QName used in the
`convention=` attribute:

| Convention        | QName                     | Namespace URI                                     |
|-------------------|---------------------------|---------------------------------------------------|
| Molecular         | `convention:molecular`    | http://www.xml-cml.org/convention/molecular       |
| CompChem          | `convention:compchem`     | http://www.xml-cml.org/convention/compchem        |
| Dictionary        | `convention:dictionary`   | http://www.xml-cml.org/convention/dictionary      |
| Unit dictionary   | `convention:unit-dictionary` | http://www.xml-cml.org/convention/unit-dictionary |
| UnitType dictionary | `convention:unitType-dictionary` | http://www.xml-cml.org/convention/unitType-dictionary |

## Deliverables

- [ ] `Chemicalml::Convention::Base` — abstract base. Carries the
      namespace URI, a human-readable name, and a registry of
      constraint classes.
- [ ] `Chemicalml::Convention::Registry` — maps QName → convention
      instance. `Convention::Registry.lookup("convention:molecular")`
      returns the convention.
- [ ] `Chemicalml::Convention::Constraint` — abstract base for a single
      rule. Each constraint implements `check(node, context)` returning
      either `nil` (pass) or a `Violation` instance.
- [ ] `Chemicalml::Convention::Violation` — value object with `path`,
      `message`, `severity` (`:error` / `:warning`).
- [ ] `Chemicalml::Convention::Molecular` — preloads every constraint
      listed in the molecular convention spec (atom ids unique, bond
      refs in scope, etc.).
- [ ] `Chemicalml::Convention::Compchem` — constraints around the
      `module` / `jobList` / `job` / `initialization` / `calculation`
      / `finalization` / `environment` structure.
- [ ] `Chemicalml::Convention::Dictionary`, `UnitDictionary`,
      `UnitTypeDictionary` — dictionary-element constraints (entry id
      uniqueness, required `term`, etc.).
- [ ] `Chemicalml::Convention.validate(document, qname:)` — runs every
      constraint for the named convention and returns the violation
      list.

## Design constraints (non-negotiable)

- New constraint = **register a class**, never edit a switch statement.
  The molecular convention's constraints live in
  `lib/chemicalml/convention/molecular/constraints/`, one class per
  file, registered in `lib/chemicalml/convention/molecular.rb`.
- The framework never knows about specific constraints — it only
  iterates whatever the convention registered.
- Constraints may walk the tree using `Node#accept(visitor)` from the
  canonical model — they don't have to re-implement traversal.

## Acceptance

- All five conventions are registered and return non-empty
  constraint sets.
- A molecular-convention-invalid document (e.g. duplicate atom ids)
  produces at least one `Violation` with `severity: :error`.
- Specs cover at least one positive and one negative case per
  convention.
