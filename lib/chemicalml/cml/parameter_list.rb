# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::ParameterList.
module Chemicalml
  module Cml
    remove_const(:ParameterList) if const_defined?(:ParameterList, false)
    const_set(:ParameterList, Chemicalml::Cml::Schema3::ParameterList)
  end
end
