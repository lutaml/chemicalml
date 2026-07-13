# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::Module.
module Chemicalml
  module Cml
    remove_const(:Module) if const_defined?(:Module, false)
    const_set(:Module, Chemicalml::Cml::Schema3::Module)
  end
end
