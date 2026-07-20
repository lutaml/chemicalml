# frozen_string_literal: true

module Chemicalml
  module Convention
    # The unit-dictionary convention. Constraints based on
    # http://www.xml-cml.org/convention/unit-dictionary (archived in
    # `reference-docs/conventions/unit-dictionary.md`).
    module UnitDictionary
      extend Base

      autoload :Constraints, 'chemicalml/convention/unit_dictionary/constraints'

      QNAME = 'convention:unit-dictionary'
      NAMESPACE_URI = "#{Chemicalml::Convention::CONVENTION_NAMESPACE}unit-dictionary".freeze

      def self.qname
        QNAME
      end

      def self.namespace_uri
        NAMESPACE_URI
      end

      register Constraints::UnitMustHaveSymbolAndUnitType
      register Constraints::UnitMustHaveId
      register Constraints::UnitMustContainDefinition
      register Constraints::UnitListMustHaveNamespace
      register Constraints::UnitListMustContainAtLeastOneUnit
      register Constraints::UnitMustHaveTitle
      register Constraints::UnitMustHaveParentSi
      register Constraints::UnitMustHaveMultiplierOrConstantToSi
      register Constraints::UnitUnitTypeShouldResolve
      register Constraints::UnitParentSiShouldResolve
    end
  end
end
