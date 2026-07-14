# TODO.align (round 7)

Cleanup pass: dead autoload removal, private method enforcement,
fixtures spec correctness, and VersionedParser root-detection
generalization.

| # | Workstream | Status | Depends on |
|---|---|---|---|
| 36 | Fix dead autoload + private + fixtures spec | complete | — |

**Issues fixed**:

1. **Dead autoload removed** — `Chemicalml::Configuration` was
   autoload-declared in `chemicalml.rb` but `lib/chemicalml/configuration.rb`
   didn't exist. Removed the autoload.

2. **Private methods enforced** — `document_to_canonical` and
   `document_from_canonical` (internal dispatch methods extracted in
   round 6) were accidentally public. Added to `private_class_method`.

3. **Fixtures spec now uses polymorphic parse** — replaced
   `Chemicalml::Cml::Document.from_xml(xml)` with
   `Chemicalml.parse(xml)` so compchem `<module>`-rooted fixtures
   are handled correctly (previously silently parsed as empty
   Documents).

4. **PENDING_ROUND_TRIP updated** — `chiral_center.cml` and
   `water_with_properties.cml` now pass semantic XML comparison
   (stereo support was added in round 5). Removed from pending list.
   Only `co2_dft_full.cml` (deeply nested `<list>`) and
   `crystal_nacl.cml` (`<crystal>` element not modeled) remain.

5. **VersionedParser root detection generalized** — replaced the
   hard-coded `DOCUMENT_ROOTS` list + `case/when` dispatch with a
   `KNOWN_ROOTS` hash mapping root element name → constant name on
   the schema module. Adding a new root type (e.g. `<spectrum>`)
   requires adding one entry — OCP. Now supports `<dictionary>`,
   `<unitList>`, `<unitTypeList>` roots in addition to `<cml>` and
   `<module>`.

**Final metrics**: 179 examples, 0 failures. Zero dead autoloads.
Zero forbidden patterns. All 15 fixtures round-trip via polymorphic
parse.
