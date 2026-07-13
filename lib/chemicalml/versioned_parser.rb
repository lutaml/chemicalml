# frozen_string_literal: true

module Chemicalml
  # Shared parse entrypoint for versioned schema modules. Each schema
  # module (`Cml::Schema3`, `Cml::Schema24`) extends this; it provides
  # `.parse(xml)` that ensures the schema's wire classes are
  # registered with `Lutaml::Model::GlobalContext`, then delegates to
  # `Document.from_xml(xml, register: context_id)`.
  #
  # Mirrors `Mml::VersionedParser`.
  module VersionedParser
    def parse(xml, namespace_exist: true)
      configuration.ensure_registered!
      document_class.from_xml(
        xml_input(xml, namespace_exist),
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

    def xml_input(xml, namespace_exist)
      return xml if namespace_exist

      namespace_uri = Chemicalml::Cml::Namespace.uri
      inject_namespace(xml, namespace_uri)
    end

    def inject_namespace(xml_string, namespace_uri)
      xml_string.sub(/<cml([\s>])/) do
        "<cml xmlns=\"#{namespace_uri}\"#{Regexp.last_match(1)}"
      end
    end
  end
end
