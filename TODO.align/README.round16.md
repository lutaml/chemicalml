# TODO.align (round 16)

Extended constraints + release readiness.

| # | Workstream | Status |
|---|---|---|
| 56 | 5 new molecular convention constraints | complete |
| 57 | Spec coverage for new constraints | complete |
| 58 | Version bump to 0.2.0 + CHANGELOG | complete |
| 59 | CI/release workflows verified | complete |

## Added

### 5 new molecular convention constraints (13 total)

- `AtomCoordinatesMustBePaired` — x2/y2 must appear together; x3/y3/z3
  must all be present or all absent.
- `PropertyMustHaveDictRef` — property must have a dictRef attribute.
- `ScalarMustHaveDataType` — scalar must have a dataType attribute.
- `BondOrderShouldNotBeNumeric` — warns on numeric bond orders (use
  S/D/T/Q/A instead).
- `AtomIdMustMatchPattern` — warns when atom id doesn't start with a
  letter or contains invalid characters.

### Bond dictRef attribute

Added `dictRef` to `Base::Bond` — required by the molecular convention
("if order is 'other', bond should have dictRef").

### Release readiness

- Version bumped to 0.2.0.
- CHANGELOG updated with full 0.2.0 release notes.
- CI (`rake.yml`) and release (`release.yml`) workflows already
  present via Cimas. To release:
  1. Push changes to main
  2. GitHub Actions → release → Run workflow → next_version: patch
  3. The workflow bumps version, tags, builds gem, pushes to RubyGems

## Final metrics

- **208 examples, 0 failures**
- **121 CML elements**, 8 dictionaries (193+ entries)
- **17 convention constraints** across 5 conventions
- **0 forbidden patterns**
- **Version 0.2.0** ready for release
