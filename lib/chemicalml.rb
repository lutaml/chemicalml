# frozen_string_literal: true

require "lutaml/model"

# ChemicalML provides a Ruby object model for the Chemical Markup Language
# (CML).
#
# Top-level entry points:
#   ChemicalML::Cml::Document.from_xml(xml)  # parse CML
#   document.to_xml                       # serialize back to XML
#
# Each CML element is a Lutaml::Model::Serializable subclass with
# declared attributes and an XML mapping block. Serialization is
# framework-backed — no hand-rolled XML in this library.
module ChemicalML
  autoload :Cml, "chemicalml/cml"
  autoload :Error, "chemicalml/errors"
  autoload :Model, "chemicalml/model"
  autoload :ParseError, "chemicalml/errors"
  autoload :VERSION, "chemicalml/version"
end
