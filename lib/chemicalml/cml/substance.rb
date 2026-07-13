# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::Substance.
module Chemicalml
  module Cml
    remove_const(:Substance) if const_defined?(:Substance, false)
    const_set(:Substance, Chemicalml::Cml::Schema3::Substance)
  end
end
