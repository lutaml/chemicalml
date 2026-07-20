# frozen_string_literal: true

module Chemicalml
  module Convention
    # The CompChem convention. Constraints based on
    # http://www.xml-cml.org/convention/compchem (archived in
    # `reference-docs/conventions/compchem.md`).
    module Compchem
      extend Base

      autoload :Constraints, 'chemicalml/convention/compchem/constraints'

      QNAME = 'convention:compchem'
      NAMESPACE_URI = "#{Chemicalml::Convention::CONVENTION_NAMESPACE}compchem".freeze

      def self.qname
        QNAME
      end

      def self.namespace_uri
        NAMESPACE_URI
      end

      register Constraints::CompchemModuleMustContainJobList
      register Constraints::JobMustContainInitialization
      register Constraints::JobListModuleMustHaveId
      register Constraints::JobModuleMustHaveId
      register Constraints::JobModuleAtMostOneFinalization
      register Constraints::JobModuleAtMostOneEnvironment
      register Constraints::CalculationRequiresFinalization
      register Constraints::InitializationAtMostOneMolecule
      register Constraints::InitializationAtMostOneParameterList
      register Constraints::InitializationMustNotContainProperty
      register Constraints::FinalizationAtMostOneMolecule
      register Constraints::FinalizationAtMostOnePropertyList
      register Constraints::FinalizationMustNotContainParameter
      register Constraints::EnvironmentAtMostOnePropertyList
      register Constraints::EnvironmentMustNotContainParameter
      register Constraints::ScalarUnits
      register Constraints::ArrayRules
      register Constraints::MatrixRules
      register Constraints::InitializationMustHaveContent
      register Constraints::FinalizationMustHaveContent
    end
  end
end
