# 54 — Document VersionedParser namespace shim

## Why

`lib/chemicalml/versioned_parser.rb` uses regex for two pre-processing
steps before delegating to `lutaml-model`:

1. `root_element_of(xml)` — peeks the XML for the root element local
   name so the parser can dispatch to the right wire class.
2. `inject_namespace(xml, uri, root)` — when the caller passes
   `namespace_exist: false`, injects `xmlns="..."` into the root
   start tag.

Both are pre-processing shims. The actual parse goes through
`Lutaml::Model::Serializable.from_xml` (line 45). Neither function
serializes, deserializes, or constructs XML nodes — they're string
pre-processing for input normalization.

The user asked to confirm this. The answer:

- All actual XML parsing and serialization goes through lutaml-model.
- 242 wire classes extend `Lutaml::Model::Serializable`.
- Zero `def to_xml`/`from_xml`/`to_h`/`from_h` on any model class.
- Zero Nokogiri/REXML references in `lib/`.
- The two regex helpers in `versioned_parser.rb` are pre-processing
  for input normalization, not serialization. They are explicitly
  documented as such.

## Action

- Add a clear comment block at the top of `versioned_parser.rb`
  explaining the boundary.
- No code change.

## Acceptance

- Comment added.
- Full suite green.
