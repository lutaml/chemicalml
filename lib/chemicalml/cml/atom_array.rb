# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::AtomArray.
module Chemicalml
  module Cml
    remove_const(:AtomArray) if const_defined?(:AtomArray, false)
    const_set(:AtomArray, Chemicalml::Cml::Schema3::AtomArray)
  end
end
