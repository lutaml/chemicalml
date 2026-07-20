# frozen_string_literal: true

module Chemicalml
  module Convention
    # The dictionary convention. Constraints based on
    # http://www.xml-cml.org/convention/dictionary (archived in
    # `reference-docs/conventions/dictionary.md`).
    module Dictionary
      extend Base

      autoload :Constraints, 'chemicalml/convention/dictionary/constraints'

      QNAME = 'convention:dictionary'
      NAMESPACE_URI = "#{Chemicalml::Convention::CONVENTION_NAMESPACE}dictionary".freeze

      def self.qname
        QNAME
      end

      def self.namespace_uri
        NAMESPACE_URI
      end

      register Constraints::EntryMustHaveIdAndTerm
      register Constraints::EntryIdsUniqueWithinDictionary
      register Constraints::DictionaryMustHaveNamespace
      register Constraints::DictionaryNamespaceShouldEndWithSlashOrHash
      register Constraints::EntryMustContainDefinition
      register Constraints::EntryIdMustMatchPattern
      register Constraints::EntryMustHaveUnitType
      register Constraints::EntryUnitsCoConstraints
    end
  end
end
