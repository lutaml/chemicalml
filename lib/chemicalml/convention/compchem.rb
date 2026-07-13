# frozen_string_literal: true

module Chemicalml
  module Convention
    # The CompChem convention. Constraints based on
    # http://www.xml-cml.org/convention/compchem (archived in
    # `reference-docs/conventions/compchem.md`).
    module Compchem
      extend Base

      autoload :Constraints, "chemicalml/convention/compchem/constraints"

      QNAME = "convention:compchem".freeze
      NAMESPACE_URI = "#{Chemicalml::Convention::CONVENTION_NAMESPACE}compchem".freeze

      def self.qname
        QNAME
      end

      def self.namespace_uri
        NAMESPACE_URI
      end

      register Constraints::CompchemModuleMustContainJobList
      register Constraints::JobMustContainInitialization
    end
  end
end
