# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::BondStereo.
module Chemicalml
  module Cml
    remove_const(:BondStereo) if const_defined?(:BondStereo, false)
    const_set(:BondStereo, Chemicalml::Cml::Schema3::BondStereo)
  end
end
