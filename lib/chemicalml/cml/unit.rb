# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::Unit.
module Chemicalml
  module Cml
    remove_const(:Unit) if const_defined?(:Unit, false)
    const_set(:Unit, Chemicalml::Cml::Schema3::Unit)
  end
end
