# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::Reactant.
module Chemicalml
  module Cml
    remove_const(:Reactant) if const_defined?(:Reactant, false)
    const_set(:Reactant, Chemicalml::Cml::Schema3::Reactant)
  end
end
