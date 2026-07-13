# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::Name.
module Chemicalml
  module Cml
    remove_const(:Name) if const_defined?(:Name, false)
    const_set(:Name, Chemicalml::Cml::Schema3::Name)
  end
end
