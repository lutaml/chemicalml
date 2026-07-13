# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::Property.
module Chemicalml
  module Cml
    remove_const(:Property) if const_defined?(:Property, false)
    const_set(:Property, Chemicalml::Cml::Schema3::Property)
  end
end
