# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::Parameter.
module Chemicalml
  module Cml
    remove_const(:Parameter) if const_defined?(:Parameter, false)
    const_set(:Parameter, Chemicalml::Cml::Schema3::Parameter)
  end
end
