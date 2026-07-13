# frozen_string_literal: true

module Chemicalml
  module Convention
    # The molecular convention. Constraints are based on the rules at
    # http://www.xml-cml.org/convention/molecular (archived in
    # `reference-docs/conventions/molecular.md`).
    module Molecular
      extend Base

      autoload :Constraints, "chemicalml/convention/molecular/constraints"

      QNAME = "convention:molecular".freeze
      NAMESPACE_URI = "#{Chemicalml::Convention::CONVENTION_NAMESPACE}molecular".freeze

      def self.qname
        QNAME
      end

      def self.namespace_uri
        NAMESPACE_URI
      end

      register Constraints::AtomArrayMustContainAtoms
      register Constraints::AtomIdsUniqueWithinMolecule
      register Constraints::BondMustReferenceAtomsInSameMolecule
    end
  end
end
