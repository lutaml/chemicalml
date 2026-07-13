# 01 — Reference docs

**Status:** pending
**Depends on:** —

## Goal

Pull every authoritative source document from xml-cml.org into
`reference-docs/` so the gem ships with its own canonical references.
These files are archival source — never delete or edit them.

## Deliverables

- [ ] `reference-docs/cmllite.html` — the CMLLite paper
      (https://www.xml-cml.org/schema/cmllite.html)
- [ ] `reference-docs/conventions/index.md` — the conventions landing page
      (http://www.xml-cml.org/convention/)
- [ ] `reference-docs/conventions/molecular.md`
- [ ] `reference-docs/conventions/compchem.md`
- [ ] `reference-docs/conventions/dictionary.md`
- [ ] `reference-docs/conventions/unit-dictionary.md`
- [ ] `reference-docs/conventions/unitType-dictionary.md`
- [ ] `reference-docs/dictionaries/compchem.xml` — the live CompChem
      dictionary at http://www.xml-cml.org/dictionary/compchem/
- [ ] `reference-docs/dictionaries/unit.xml` — SI/non-SI unit dictionary
- [ ] `reference-docs/dictionaries/unitType.xml` — unit-type dictionary
- [ ] A note at the top of each file pointing to its source URL and the
      CC-BY-3.0 license

## Implementation notes

Use `bundle exec rake reference:fetch` (added in
`lib/tasks/reference_fetch.rake`) — this downloads everything in one
shot, skips files that already exist, and prints a summary. Do **not**
commit generated files without reviewing them; some upstream URLs may
redirect or 404 — log those and move on, don't fail the whole task.

## Acceptance

- All listed files exist under `reference-docs/`.
- Each file starts with a one-line `<!-- Source: URL, CC-BY-3.0 -->` comment
  (or Markdown equivalent).
- `bundle exec rake reference:fetch` is idempotent.
