# 31 — Final spec + lint pass

**Status:** complete
**Depends on:** all

## Goal

Verify the stereo additions don't regress anything.

## Deliverables

- [ ] `bundle exec rspec spec/chemicalml/` green.
- [ ] Round-trip of chiral_center.cml and ethene_with_bond_stereo.cml
      preserves the stereo elements.
- [ ] Zero forbidden patterns in lib/.
- [ ] TODO.align/README.round5.md marked complete.

## Acceptance

All checks pass.
