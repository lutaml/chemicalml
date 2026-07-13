# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::Identifier.
module Chemicalml
  module Cml
    remove_const(:Identifier) if const_defined?(:Identifier, false)
    const_set(:Identifier, Chemicalml::Cml::Schema3::Identifier)
  end
end
