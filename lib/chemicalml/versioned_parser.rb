# frozen_string_literal: true

module Chemicalml
  # Shared parse entrypoint for versioned schema modules. Each schema
  # module (`Cml::Schema3`, `Cml::Schema24`) extends this.
  #
  # Polymorphic: detects the XML root element and dispatches to the
  # right wire class's `from_xml`. Supported roots include `<cml>`
  # (Document), `<module>` (compchem Module), `<dictionary>`,
  # `<unitList>`, `<unitTypeList>`, and the legacy standalone roots
  # `<molecule>`, `<reaction>`, `<reactionList>`.
  #
  # ---
  #
  # XML processing boundary (read me):
  #
  # The gem uses `lutaml-model` for ALL XML parsing and serialization
  # — 242 wire classes extend `Lutaml::Model::Serializable`, and no
  # `lib/` file defines `to_xml`/`from_xml`/`to_h`/`from_h` on a
  # model class. Zero Nokogiri/REXML references in `lib/`.
  #
  # This file has TWO pre-processing helpers — `root_element_of` and
  # `inject_namespace` — that operate on the XML *string* before
  # `Lutaml::Model::Serializable.from_xml` is called. They are NOT
  # serialization: they don't construct XML nodes, don't traverse
  # trees, don't map attributes to model fields. They are input
  # normalization so callers can pass namespace-less XML or rely on
  # the parser to dispatch by root element name. The actual parse
  # happens on the `const_get(class_name).from_xml(...)` call below.
  module VersionedParser
    # Maps root element name → constant name on the schema module.
    # Adding a new root type = adding one entry here. OCP — no
    # existing code changes.
    KNOWN_ROOTS = {
      "cml"          => :Document,
      "molecule"     => :Molecule,
      "reaction"     => :Reaction,
      "reactionList" => :ReactionList,
      "module"       => :Module,
      "dictionary"   => :Dictionary,
      "unitList"     => :UnitList,
      "unitTypeList" => :UnitTypeList,
    }.freeze

    def parse(xml, namespace_exist: true)
      configuration.ensure_registered!
      root = root_element_of(xml)

      # Resolve the wire class for this root element via O(1) hash
      # lookup. KNOWN_ROOTS provides explicit overrides; the reverse
      # index of Elements::ALL covers everything else.
      class_name = KNOWN_ROOTS[root] || Chemicalml::Cml::Elements::XML_TO_CLASS[root]
      unless class_name
        raise ArgumentError,
              "unsupported CML root element <#{root}>"
      end
      unless const_defined?(class_name, false)
        raise ArgumentError,
              "#{name} does not define #{class_name} " \
              "(not all root elements exist in every schema version)"
      end

      const_get(class_name).from_xml(
        xml_input(xml, namespace_exist, root),
        register: configuration.context_id
      )
    end

    def document_class
      const_get(:Document)
    end

    def configuration
      const_get(:Configuration)
    end

    private

    # Peek the XML string for the first element name. Skips the XML
    # declaration (`<?xml ?>`) and any comments / processing
    # instructions. Returns the local name (no namespace prefix).
    def root_element_of(xml)
      match = xml.match(/<([a-zA-Z][\w.-]*)(?::[a-zA-Z][\w.-]*)?/)
      return match[1] if match

      raise ArgumentError, "could not detect root element in XML"
    end

    def xml_input(xml, namespace_exist, root)
      return xml if namespace_exist

      namespace_uri = Chemicalml::Cml::Namespace.uri
      inject_namespace(xml, namespace_uri, root)
    end

    def inject_namespace(xml_string, namespace_uri, root)
      xml_string.sub(/<#{root}([\s>])/) do
        "<#{root} xmlns=\"#{namespace_uri}\"#{Regexp.last_match(1)}"
      end
    end
  end
end
