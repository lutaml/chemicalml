# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::UnitType.
module Chemicalml
  module Cml
    remove_const(:UnitType) if const_defined?(:UnitType, false)
    const_set(:UnitType, Chemicalml::Cml::Schema3::UnitType)
  end
end
