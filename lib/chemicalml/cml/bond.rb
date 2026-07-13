# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::Bond.
module Chemicalml
  module Cml
    remove_const(:Bond) if const_defined?(:Bond, false)
    const_set(:Bond, Chemicalml::Cml::Schema3::Bond)
  end
end
