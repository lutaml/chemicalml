# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::UnitTypeList.
module Chemicalml
  module Cml
    remove_const(:UnitTypeList) if const_defined?(:UnitTypeList, false)
    const_set(:UnitTypeList, Chemicalml::Cml::Schema3::UnitTypeList)
  end
end
