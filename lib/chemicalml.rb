# frozen_string_literal: true

require 'lutaml/model'

# Chemicalml provides a Ruby object model for the Chemical Markup Language
# (CML).
#
# Top-level entry points:
#   Chemicalml::Cml::Document.from_xml(xml)  # parse CML
#   document.to_xml                          # serialize back to XML
#
# Each CML element is a Lutaml::Model::Serializable subclass with
# declared attributes and an XML mapping block. Serialization is
# framework-backed — no hand-rolled XML in this library.
module Chemicalml
  autoload :Cml, 'chemicalml/cml'
  autoload :Cli, 'chemicalml/cli'
  autoload :ContextConfiguration, 'chemicalml/context_configuration'
  autoload :Convention, 'chemicalml/convention'
  autoload :Dictionary, 'chemicalml/dictionary'
  autoload :Error, 'chemicalml/errors'
  autoload :Logger, 'chemicalml/logger'
  autoload :ParseError, 'chemicalml/errors'
  autoload :Schema, 'chemicalml/schema'
  autoload :VERSION, 'chemicalml/version'
  autoload :VersionedParser, 'chemicalml/versioned_parser'
  autoload :Dictionary, 'chemicalml/dictionary'
  autoload :Error, 'chemicalml/errors'
  autoload :ParseError, 'chemicalml/errors'
  autoload :Schema, 'chemicalml/schema'
  autoload :VERSION, 'chemicalml/version'
  autoload :VersionedParser, 'chemicalml/versioned_parser'

  module_function

  # Parse a CML XML string into a wire document.
  #
  # @param xml [String] the XML content.
  # @param schema [Symbol] one of `:schema3` (default) or `:schema24`.
  # @param namespace_exist [Boolean] whether the XML already declares
  #   the CML namespace. When false, the parser injects it.
  # @return [Chemicalml::Cml::Schema3::Document,
  #          Chemicalml::Cml::Schema24::Document,
  #          Chemicalml::Cml::Schema3::Molecule, ...] the parsed root,
  #          dispatch by detected root element.
  # @raise [ArgumentError] if `xml` is nil/empty or `schema` is unknown.
  # @raise [Chemicalml::ParseError] on malformed XML.
  #
  # @example Parse a Schema3 document
  #   doc = Chemicalml.parse("<cml xmlns='...'>...</cml>")
  # @example Parse a Schema2.4 document
  #   doc = Chemicalml.parse(xml, schema: :schema24)
  def parse(xml, schema: :schema3, namespace_exist: true)
    raise ArgumentError, 'xml must not be nil' if xml.nil?
    raise ArgumentError, 'xml must not be empty' if xml.to_s.strip.empty?

    parser_for(schema).parse(xml, namespace_exist: namespace_exist)
  end

  # Parse a CML file from disk. Convenience wrapper around `parse`
  # that handles the `File.read` boilerplate.
  #
  # @param path [String] path to the CML file.
  # @param schema [Symbol] `:schema3` (default) or `:schema24`.
  # @param namespace_exist [Boolean] forwarded to `parse`.
  # @return (see .parse)
  # @raise [ArgumentError] if the file doesn't exist or is empty.
  def parse_file(path, schema: :schema3, namespace_exist: true)
    raise ArgumentError, "file not found: #{path}" unless File.exist?(path)

    parse(File.read(path), schema: schema, namespace_exist: namespace_exist)
  end

  # Serialize a wire document back to XML.
  #
  # @param document [Lutaml::Model::Serializable] a CML wire instance.
  # @param opts [Hash] forwarded to `Lutaml::Model::Serializable#to_xml`.
  # @return [String] the serialized XML.
  def serialize(document, **)
    document.to_xml(**)
  end

  # Resolve the versioned-parser module for a schema id.
  #
  # @param schema [Symbol] `:schema3` or `:schema24`.
  # @return [Module] the matching `Schema3` or `Schema24` module.
  # @raise [ArgumentError] if `schema` is unknown.
  def parser_for(schema)
    case schema.to_sym
    when :schema3  then Chemicalml::Cml::Schema3
    when :schema24 then Chemicalml::Cml::Schema24
    else
      raise ArgumentError, "unsupported schema: #{schema.inspect} " \
                           '(supported: :schema3, :schema24)'
    end
  end

  # Auto-detect the convention from the document's root and validate.
  # Top-level convenience for `Convention.detect_and_validate`.
  #
  # @param document [Lutaml::Model::Serializable] the CML document.
  # @param logger [Chemicalml::Logger, nil] optional logger for progress.
  # @return [Chemicalml::Convention::ValidationReport] the report.
  # @raise [ArgumentError] if no convention is declared.
  def validate(document, logger: nil)
    logger&.info 'Auto-detecting convention…'
    report = Convention.detect_and_validate(document)
    logger&.info "Validation complete: #{report.size} violation(s)"
    report
  end
end
