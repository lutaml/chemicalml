# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::DictionaryEntry.
module Chemicalml
  module Cml
    remove_const(:DictionaryEntry) if const_defined?(:DictionaryEntry, false)
    const_set(:DictionaryEntry, Chemicalml::Cml::Schema3::DictionaryEntry)
  end
end
