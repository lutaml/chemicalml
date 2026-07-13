# 06 — Replace respond_to? with is_a?

**Status:** complete
**Depends on:** 02

## Goal

The user's global rule forbids `respond_to?` for type checking. Today
the convention constraint walker uses `respond_to?` heavily to ask
heterogeneous wire nodes whether they expose a particular attribute.
Replace every occurrence with `is_a?` checks against the concrete wire
classes (or a marker module that those classes include).

## Why

`respond_to?` is duck-typing that hides type errors until runtime. The
right pattern is either:

- Use `is_a?(SpecificClass)` when the constraint genuinely only applies
  to one class.
- Introduce a marker module (e.g. `Cml::HasAtomArray`) that the
  relevant classes include, then check `node.is_a?(HasAtomArray)`. This
  is OCP-friendly — new classes opt in by including the marker, not by
  editing a switch.

## Deliverables

- [ ] Introduce `Chemicalml::Cml::Visitable` mixin included by every
      wire class. Provides a uniform `accept_constraint(visitor)`
      interface that delegates to `visitor.visit_<class_short_name>`.
- [ ] Add marker modules where duck-typing is currently used:
      `Cml::HasAtomArray`, `Cml::HasBondArray`, `Cml::HasEntries`,
      `Cml::HasUnits`, etc. — included by the relevant wire classes.
- [ ] Rewrite `Convention::Constraint#wire_children` to walk via
      `is_a?` checks against marker modules, not `respond_to?`.
- [ ] Audit `grep -rn 'respond_to?' lib/` — should return zero hits
      outside spec_helper boilerplate.

## Acceptance

- `grep -rn 'respond_to?' lib/` returns nothing.
- All convention specs still pass.
- Constraint walker behavior unchanged (still detects the same
  violations on the same fixtures).
