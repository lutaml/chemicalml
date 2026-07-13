# frozen_string_literal: true

module Chemicalml
  module Convention
    module Dictionary
      module Constraints
        autoload :EntryMustHaveIdAndTerm,
                 "chemicalml/convention/dictionary/constraints/entry_must_have_id_and_term"
        autoload :EntryIdsUniqueWithinDictionary,
                 "chemicalml/convention/dictionary/constraints/entry_ids_unique_within_dictionary"
      end
    end
  end
end
