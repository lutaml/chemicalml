# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::Array.
module Chemicalml
  module Cml
    remove_const(:Array) if const_defined?(:Array, false)
    const_set(:Array, Chemicalml::Cml::Schema3::Array)
  end
end
