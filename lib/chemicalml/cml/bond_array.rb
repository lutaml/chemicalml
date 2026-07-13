# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::BondArray.
module Chemicalml
  module Cml
    remove_const(:BondArray) if const_defined?(:BondArray, false)
    const_set(:BondArray, Chemicalml::Cml::Schema3::BondArray)
  end
end
