# frozen_string_literal: true

module Chemicalml
  # Schema version registry. Maps version symbols (e.g. `:schema3`,
  # `:schema24`) to their canonical metadata: XSD path, default XML
  # namespace, and the Ruby sub-namespace that holds the wire classes.
  #
  # The two XSDs are source-of-truth archival files under
  # `reference-docs/schemas/`. They are never modified or regenerated
  # from code.
  module Schema
    autoload :Definition, "chemicalml/schema/definition"
    autoload :Registry,   "chemicalml/schema/registry"

    CML_XML_NAMESPACE = "http://www.xml-cml.org/schema"

    # Built-in versions registered at load time. Adding a new CML schema
    # version = appending an entry here and creating the matching
    # `Chemicalml::Cml::SchemaXxx` namespace. No existing code changes.
    BUILTIN = {
      schema24: Definition.new(
        version: :schema24,
        xsd_path: "reference-docs/schemas/schema24/schema.xsd",
        xml_namespace: CML_XML_NAMESPACE,
        ruby_namespace: "Chemicalml::Cml::Schema24"
      ),
      schema3: Definition.new(
        version: :schema3,
        xsd_path: "reference-docs/schemas/schema3/schema.xsd",
        xml_namespace: CML_XML_NAMESPACE,
        ruby_namespace: "Chemicalml::Cml::Schema3"
      )
    }.freeze
  end
end
