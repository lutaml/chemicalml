# 13 — Wire XML namespace setup

**Status:** complete
**Depends on:** —

## Goal

Today, round-tripping a namespaced CML document produces inner
elements with spurious `xmlns=""` attributes:

```xml
<molecule xmlns="http://www.xml-cml.org/schema" id="m1">
  <atomArray xmlns="">           <!-- ← bug -->
    <atom id="a1" elementType="C"/>
  </atomArray>
</molecule>
```

This is because the wire classes don't declare a namespace on their
`xml do ... end` block, so the framework assumes the empty namespace.

Add `namespace Chemicalml::Cml::Namespace` to each Base module's xml
block so output preserves the CML namespace.

## Why

- Real bug — the round-trip isn't faithful.
- `canon` semantic comparison will catch this once we switch the
  fixture spec to it (task 15).

## Deliverables

- [ ] Verify `Chemicalml::Cml::Namespace` is a proper lutaml namespace
      declaration.
- [ ] Add `namespace Chemicalml::Cml::Namespace` to the `xml do` block
      in every `lib/chemicalml/cml/base/*.rb` mixin.
- [ ] Round-trip a fixture with namespace declaration and confirm no
      `xmlns=""` appears on inner elements.

## Acceptance

- A round-tripped `<cml xmlns="..."><molecule>...</molecule></cml>` is
  byte-equivalent in namespace structure to the input.
- Canon matcher specs pass on full-document round-trip.
