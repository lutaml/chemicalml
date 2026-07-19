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
      register Constraints::AtomMustHaveId
      register Constraints::AtomMustHaveElementType
      register Constraints::BondMustHaveAtomRefs2
      register Constraints::BondMustHaveOrder
      register Constraints::MoleculeMustHaveId
      register Constraints::AtomCoordinatesMustBePaired
      register Constraints::PropertyMustHaveDictRef
      register Constraints::ScalarMustHaveDataType
      register Constraints::BondOrderShouldNotBeNumeric
      register Constraints::AtomIdMustMatchPattern
      register Constraints::MoleculeCountMustNotAppearOnTopLevel
      register Constraints::MoleculeAtomArrayMutuallyExclusiveWithChildren
      register Constraints::MoleculeBondArrayMutuallyExclusiveWithChildren
      register Constraints::BondStereoWedgeHashMustHaveAtomRefs2
      register Constraints::BondStereoCisTransMustHaveAtomRefs4
      register Constraints::BondStereoOtherMustHaveDictRef
      register Constraints::BondIdsUniqueWithinMolecule
      register Constraints::BondOrderOtherMustHaveDictRef
      register Constraints::AtomArrayMustBeChildOfMoleculeOrFormula
      register Constraints::BondArrayMustBeChildOfMolecule
      register Constraints::BondOrderShouldBeInEnum
      register Constraints::BondStereoShouldBeInEnum
      register Constraints::MoleculeChiralityShouldBeInEnum
      register Constraints::BondAtomRefs2ShouldBeDistinct
      register Constraints::ReferencesShouldResolve
      register Constraints::BondStereoAtomRefs4ShouldBeDistinct
      register Constraints::AtomParityAtomRefs4ShouldBeDistinct
      register Constraints::AtomElementTypeShouldBeInPeriodicTable
      register Constraints::DictRefShouldResolve
      register Constraints::MoleculeIdShouldMatchPattern
      register Constraints::BondIdShouldMatchPattern
      register Constraints::AtomParityShouldIncludeParentAtom
      register Constraints::PropertyScalarDataTypeMatchesDictionary
    end
  end
end
