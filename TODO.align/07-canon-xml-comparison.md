# 07 — Canon-based semantic XML comparison

**Status:** complete
**Depends on:** —

## Goal

Replace brittle string-equality assertions in round-trip specs with
semantic XML comparison via the
[`canon`](https://github.com/plurimath/canon) gem. This is what `mml`
uses for its `be_xml_equivalent_to` matcher.

## Why

Plain string equality breaks on:

- attribute order (`<a x="1" y="2"/>` vs `<a y="2" x="1"/>`)
- whitespace differences inside tags
- namespace prefix aliases
- self-closing vs empty-tag forms

Semantic comparison treats all of these as equivalent, which is what
round-trip tests actually want to verify.

## Deliverables

- [ ] Add `gem "canon"` to the development group in `Gemfile`
- [ ] Configure `Canon::Config` in `spec/spec_helper.rb`:
      ```ruby
      Canon::Config.configure do |config|
        config.xml.match.profile = :spec_friendly
        config.xml.diff.algorithm = :semantic
      end
      ```
- [ ] Existing round-trip specs use `expect(out).to be_xml_equivalent_to(in)`
      instead of `expect(out).to eq(in)` or attribute-by-attribute
      equality.

## Acceptance

- `bundle exec rspec` is green with the new matcher.
- Round-trip specs catch real regressions (e.g. dropped attributes)
  rather than formatting noise.
