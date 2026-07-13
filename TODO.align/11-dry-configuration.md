# 11 — DRY Configuration registration

**Status:** complete
**Depends on:** —

## Goal

`Schema3::Configuration.register_models!` and
`Schema24::Configuration.register_models!` are 99% identical — only
the parent module differs. Both list every CML element class with the
same id. This is a DRY / SSOT violation.

Extract the registration loop into `ContextConfiguration` so each
schema's Configuration is just a few lines:

```ruby
module Schema3
  module Configuration
    extend Chemicalml::ContextConfiguration

    CONTEXT_ID = :chemicalml_schema3
    REGISTERED_ELEMENTS = %i[
      atom atomArray atomParity bond bondArray bondStereo
      document formula identifier label list matrix metadata
      ...
    ].freeze

    register_element_classes!
  end
end
```

The shared `register_element_classes!` walks the list, looks up each
class on the parent module, and calls `register_model`.

## Why

Today, adding a new CML element means:

1. Creating `Base::Foo`
2. Creating `Schema3::Foo` and `Schema24::Foo`
3. **Adding `register_model Foo, id: :foo` to BOTH Configuration files**
4. Adding translator rules
5. Adding specs

Step 3 is duplicated work. After this fix, the element name goes in one
list (`REGISTERED_ELEMENTS`) and both schemas pick it up automatically.

## Deliverables

- [ ] `Chemicalml::ContextConfiguration#register_element_classes!`
      iterates `REGISTERED_ELEMENTS`, looks up each class on
      `version_parent_module`, and registers it.
- [ ] `Schema3::Configuration` and `Schema24::Configuration` reduced
      to ~10 lines each: `extend`, `CONTEXT_ID =`, `REGISTERED_ELEMENTS =`,
      `register_element_classes!`.

## Acceptance

- Both Configuration files under 20 lines.
- Adding a new element requires touching exactly ONE place
      (the `REGISTERED_ELEMENTS` array).
- All specs still pass.
