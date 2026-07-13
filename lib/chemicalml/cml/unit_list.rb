# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::UnitList.
module Chemicalml
  module Cml
    remove_const(:UnitList) if const_defined?(:UnitList, false)
    const_set(:UnitList, Chemicalml::Cml::Schema3::UnitList)
  end
end
