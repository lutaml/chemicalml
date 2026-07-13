# 07 — Attribution & notices

**Status:** pending
**Depends on:** —

## Goal

The CML conventions, schema, examples, and dictionaries are published
by xml-cml.org under a Creative Commons Attribution 3.0 (CC-BY-3.0)
license. The gem redistributes derived works (model classes,
dictionaries as YAML, scraped fixtures, archived convention specs).
Proper attribution is both legally required and a basic courtesy to
the people who built CML.

## Deliverables

- [ ] `NOTICES.adoc` at the repo root crediting:
      - Peter Murray-Rust, Joe Townsend, Sam Adams, and the wider
        CML community at the University of Cambridge.
      - Weerapong Phadungsukanan, Jens Thomas, Nick England,
        Daniel Lowe, Hannah Barjat, Alex Wade.
      - The xml-cml.org project and the Chemical Markup Language
        community.
  Each credit lists what they contributed (convention editors,
  dictionary authors, schema maintainers, etc.).
- [ ] A "Third-party content" section in `NOTICES.adoc` listing every
      file under `reference-docs/` and `spec/fixtures/` that derives
      from xml-cml.org, with the upstream URL and the CC-BY-3.0
      license notice.
- [ ] A short "Acknowledgements" section in `README.adoc` mirroring
      the above.
- [ ] Each archived reference doc keeps its own one-line source-and-
      license attribution at the top (added when fetched, see
      `01-reference-docs.md`).

## Acceptance

- `NOTICES.adoc` exists, names every contributor surfaced in the
  convention pages, and reproduces the CC-BY-3.0 notice.
- README.adoc has a visible acknowledgements section.
- `git ls-files reference-docs spec/fixtures | wc -l` non-zero (i.e.,
  we actually redistribute some upstream content).
