# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::Scalar.
module Chemicalml
  module Cml
    remove_const(:Scalar) if const_defined?(:Scalar, false)
    const_set(:Scalar, Chemicalml::Cml::Schema3::Scalar)
  end
end
