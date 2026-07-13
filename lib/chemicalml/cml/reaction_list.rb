# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::ReactionList.
module Chemicalml
  module Cml
    remove_const(:ReactionList) if const_defined?(:ReactionList, false)
    const_set(:ReactionList, Chemicalml::Cml::Schema3::ReactionList)
  end
end
