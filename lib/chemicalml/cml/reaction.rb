# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::Reaction.
module Chemicalml
  module Cml
    remove_const(:Reaction) if const_defined?(:Reaction, false)
    const_set(:Reaction, Chemicalml::Cml::Schema3::Reaction)
  end
end
