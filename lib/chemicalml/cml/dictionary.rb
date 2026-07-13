# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::Dictionary.
module Chemicalml
  module Cml
    remove_const(:Dictionary) if const_defined?(:Dictionary, false)
    const_set(:Dictionary, Chemicalml::Cml::Schema3::Dictionary)
  end
end
