# 05 — Dictionary layer

**Status:** pending
**Depends on:** 04

## Goal

Model the CML dictionary convention and ship built-in dictionaries as
YAML, with a typed entry schema. Dictionaries must be queryable by id
and by QName prefix.

## YAML entry schema

Each entry is one YAML document under the dictionary's namespace:

```yaml
---
namespace: http://www.xml-cml.org/dictionary/compchem/
prefix: compchem
title: Computational Chemistry Dictionary
description: |
  Terms used by the CompChem convention.
entries:
  - id: jobList
    term: Job List
    definition: |
      A list of sequential computational jobs.
    description: |
      <p>A jobList...</p>     # xhtml content as a string
    data_type: xsd:string     # optional; QName
    unit_type: unitType:none  # required; QName
    units: unit:none          # optional; QName
    enum:
      kind: open              # open | closed
      values: []              # populated only when kind: closed
    links:
      - rel: seeAlso
        href: http://example.org/foo
    source_code: |
      <code>...</code>        # optional xhtml/code block
```

The dictionary itself is the file; the schema is one entry per
record under `entries:`.

## Deliverables

- [ ] `Chemicalml::Dictionary` — top-level model: `namespace`,
      `prefix`, `title`, `description`, `entries` (collection).
      Built on `Lutaml::Model::Serializable` with YAML mapping.
- [ ] `Chemicalml::Dictionary::Entry` — typed model with all the
      fields above. `enum` is itself a small model with `kind:` and
      `values:`.
- [ ] `Chemicalml::Dictionary::Link` — `rel`, `href`, optional `title`.
- [ ] `Chemicalml::Dictionary::Registry` — loads every `.yaml` under
      `data/dictionaries/`, indexes by both `prefix:` and `namespace:`.
      `Registry.lookup("compchem:totalEnergy")` returns the entry.
- [ ] Built-in YAML files under `data/dictionaries/`:
      `compchem.yaml`, `unit.yaml`, `unit_type.yaml`, `cml.yaml`
      (core CML terms referenced from the dictionaries page).
- [ ] `Chemicalml::Dictionary.load(name)` — convenience loader.

## Design constraints

- Entries are loaded from YAML, never hand-coded in Ruby.
- The model classes do NOT serialize back to YAML by hand — they
  use lutaml-model's YAML adapter via `yaml do ... end` mapping blocks.
- No `require_relative` in any of these files.

## Acceptance

- `Chemicalml::Dictionary.load("compchem")` returns a populated
  `Dictionary` with at least the entries cited in the compchem
  convention (`jobList`, `job`, `initialization`, `calculation`,
  `finalization`, `environment`, `totalEnergy`, etc.).
- The registry resolves QNames of the form `prefix:id` correctly.
- Round-trip: load YAML → model → re-serialize to YAML → reload → equal.
