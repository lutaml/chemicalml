# frozen_string_literal: true

module Chemicalml
  module Convention
    # The unit-dictionary convention. Constraints based on
    # http://www.xml-cml.org/convention/unit-dictionary (archived in
    # `reference-docs/conventions/unit-dictionary.md`).
    module UnitDictionary
      extend Base

      autoload :Constraints, "chemicalml/convention/unit_dictionary/constraints"

      QNAME = "convention:unit-dictionary".freeze
      NAMESPACE_URI = "#{Chemicalml::Convention::CONVENTION_NAMESPACE}unit-dictionary".freeze

      def self.qname
        QNAME
      end

      def self.namespace_uri
        NAMESPACE_URI
      end

      register Constraints::UnitMustHaveSymbolAndUnitType
    end
  end
end
