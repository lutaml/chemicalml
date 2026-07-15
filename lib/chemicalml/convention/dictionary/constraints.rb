# frozen_string_literal: true

module Chemicalml
  module Convention
    module Dictionary
      module Constraints
        autoload :EntryMustHaveIdAndTerm,
                 "chemicalml/convention/dictionary/constraints/entry_must_have_id_and_term"
        autoload :EntryIdsUniqueWithinDictionary,
                 "chemicalml/convention/dictionary/constraints/entry_ids_unique_within_dictionary"
        autoload :DictionaryMustHaveNamespace,
                 "chemicalml/convention/dictionary/constraints/dictionary_must_have_namespace"
        autoload :DictionaryNamespaceShouldEndWithSlashOrHash,
                 "chemicalml/convention/dictionary/constraints/dictionary_namespace_should_end_with_slash_or_hash"
        autoload :EntryMustContainDefinition,
                 "chemicalml/convention/dictionary/constraints/entry_must_contain_definition"
        autoload :EntryIdMustMatchPattern,
                 "chemicalml/convention/dictionary/constraints/entry_id_must_match_pattern"
        autoload :EntryMustHaveUnitType,
                 "chemicalml/convention/dictionary/constraints/entry_must_have_unit_type"
        autoload :EntryUnitsCoConstraints,
                 "chemicalml/convention/dictionary/constraints/entry_units_co_constraints"
      end
    end
  end
end
