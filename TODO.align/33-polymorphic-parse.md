# 33 — Polymorphic Chemicalml.parse

**Status:** complete
**Depends on:** 32

## Goal

`Chemicalml.parse(xml)` today only handles `<cml>`-rooted documents.
Compchem documents rooted at `<module>` silently parse as empty
Documents — the content is dropped without warning.

Detect the root element via a regex peek and dispatch to the right
parser.

## Why

Silent data loss. Today's behavior:
```
Chemicalml.parse(File.read("h2_dft.cml"))
# => #<Chemicalml::Cml::Schema3::Document molecules=[] reactions=[]>
```

The caller has no indication that all the jobList / job / init / fin
content was dropped. Should be either parsed correctly or raise an
error.

## Deliverables

- [ ] `Chemicalml.parse(xml, schema:)` peeks the root tag.
- [ ] `cml`, `molecule`, `reactionList`, `reaction` → Document parser.
- [ ] `module` → Module parser (Schema3 only — Schema 2.4 lacks it).
- [ ] Unknown root → `ArgumentError`.
- [ ] Return type matches the root: Document or Module.
- [ ] `Chemicalml.serialize(node)` remains polymorphic — already
      just calls `node.to_xml`.

## Acceptance

- `Chemicalml.parse(File.read("h2_dft.cml"))` returns a Schema3 Module
      with the jobList intact.
- `Chemicalml.parse(File.read("water.cml"))` continues to return a
      Schema3 Document.
- Unknown root raises `ArgumentError`.
