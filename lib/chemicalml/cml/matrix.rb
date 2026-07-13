# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::Matrix.
module Chemicalml
  module Cml
    remove_const(:Matrix) if const_defined?(:Matrix, false)
    const_set(:Matrix, Chemicalml::Cml::Schema3::Matrix)
  end
end
