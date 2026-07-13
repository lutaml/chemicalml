# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::PropertyList.
module Chemicalml
  module Cml
    remove_const(:PropertyList) if const_defined?(:PropertyList, false)
    const_set(:PropertyList, Chemicalml::Cml::Schema3::PropertyList)
  end
end
