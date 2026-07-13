# frozen_string_literal: true

module Chemicalml
  module Convention
    # The unitType-dictionary convention. Constraints based on
    # http://www.xml-cml.org/convention/unitType-dictionary (archived
    # in `reference-docs/conventions/unitType-dictionary.md`).
    module UnitTypeDictionary
      extend Base

      autoload :Constraints, "chemicalml/convention/unit_type_dictionary/constraints"

      QNAME = "convention:unitType-dictionary".freeze
      NAMESPACE_URI = "#{Chemicalml::Convention::CONVENTION_NAMESPACE}unitType-dictionary".freeze

      def self.qname
        QNAME
      end

      def self.namespace_uri
        NAMESPACE_URI
      end

      register Constraints::UnitTypeMustHaveIdAndName
    end
  end
end
