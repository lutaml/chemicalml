# 03 — Fixtures scrape

**Status:** pending
**Depends on:** 01

## Goal

Pull every example CML document from xml-cml.org/examples/ into
`spec/fixtures/`, organized by schema version and category. These are
the canonical test corpus for round-trip and convention-conformance
specs.

## Source URLs

- http://www.xml-cml.org/examples/schema3/molecular/ — schema 3 molecular
- http://www.xml-cml.org/examples/schema3/compchem/  — schema 3 compchem
- http://www.xml-cml.org/examples/schema24/          — schema 2.4

Each landing page is an HTML index linking to per-example `.html`
viewer pages that themselves embed the raw CML. The scraper has to
walk the index, fetch each example page, and extract the CML block.

## Deliverables

- [ ] `lib/tasks/scrape_fixtures.rake` exposing
      `bundle exec rake fixtures:scrape`. Idempotent — skips files that
      already exist.
- [ ] `spec/fixtures/schema3/molecular/*.cml`
- [ ] `spec/fixtures/schema3/compchem/*.cml`
- [ ] `spec/fixtures/schema24/*.cml`
- [ ] A smoke spec `spec/chemicalml/fixtures_round_trip_spec.rb` that
      loads every `.cml` fixture, runs
      `Chemicalml::Cml::Schema3::Document.from_xml(...)`, and asserts
      `to_xml` produces a document the parser can re-read.

## Implementation notes

- Use `Net::HTTP` directly — no extra gem dependency. Honour a 1-second
  delay between requests to be polite.
- File names: derive from the example title, slugged to
  `[a-z0-9_-]+`. Preserve uniqueness with a numeric suffix if needed.
- The example index pages render titles like "minimal molecule 1" —
  slug those to `minimal_molecule_1.cml`.
- If a fetch fails (404, redirect to a different host), record the URL
  in `spec/fixtures/.scrape-log` and continue — don't abort the run.

## Acceptance

- All three fixture directories exist with the expected example count
  (molecular ~36, compchem ~5, schema24 varies).
- The round-trip smoke spec is green.
- Re-running `rake fixtures:scrape` makes no changes.
