# frozen_string_literal: true

require "lutaml/model"

# Chemicalml provides a Ruby object model for the Chemical Markup Language
# (CML).
#
# Top-level entry points:
#   Chemicalml::Cml::Document.from_xml(xml)  # parse CML
#   document.to_xml                       # serialize back to XML
#
# Each CML element is a Lutaml::Model::Serializable subclass with
# declared attributes and an XML mapping block. Serialization is
# framework-backed — no hand-rolled XML in this library.
module Chemicalml
  autoload :Cml, "chemicalml/cml"
  autoload :Configuration, "chemicalml/configuration"
  autoload :ContextConfiguration, "chemicalml/context_configuration"
  autoload :Convention, "chemicalml/convention"
  autoload :Dictionary, "chemicalml/dictionary"
  autoload :Error, "chemicalml/errors"
  autoload :Model, "chemicalml/model"
  autoload :ParseError, "chemicalml/errors"
  autoload :Schema, "chemicalml/schema"
  autoload :VERSION, "chemicalml/version"
  autoload :VersionedParser, "chemicalml/versioned_parser"

  module_function

  def parse(xml, schema: :schema3, namespace_exist: true)
    parser_for(schema).parse(xml, namespace_exist: namespace_exist)
  end

  def serialize(document, **opts)
    document.to_xml(**opts)
  end

  def parser_for(schema)
    case schema.to_sym
    when :schema3  then Chemicalml::Cml::Schema3
    when :schema24 then Chemicalml::Cml::Schema24
    else
      raise ArgumentError, "unsupported schema: #{schema.inspect} " \
                           "(supported: :schema3, :schema24)"
    end
  end
end
