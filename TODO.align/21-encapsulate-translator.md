# 21 — Encapsulate translator internals

**Status:** complete
**Depends on:** 19, 20

## Goal

The Translator has 17 public class methods today. Only `to_canonical`
and `from_canonical` are part of the public API. Every helper
(`molecule_to_canonical`, `atom_from_canonical`, `cml_order_to_kind`,
etc.) is an implementation detail and should be private.

## Why

- Public API surface = mental load for users. They see 17 methods and
  wonder which to use.
- Internal helpers shouldn't be callable from outside — encapsulation
  violation.
- Risk: a future refactor (e.g. visitor pattern) would need to keep
  these as public for backward compat.

## Deliverables

- [ ] Add `private_class_method` for every helper method on
      `Translator`.
- [ ] Same for `ValueTranslations::ClassMethods` helpers.
- [ ] Verify no spec or external code calls the helpers directly.

## Acceptance

- `Chemicalml::Cml::Translator.public_methods(false)` returns only
  `to_canonical` and `from_canonical`.
- All specs still pass.
