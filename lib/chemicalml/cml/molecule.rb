# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::Molecule.
module Chemicalml
  module Cml
    remove_const(:Molecule) if const_defined?(:Molecule, false)
    const_set(:Molecule, Chemicalml::Cml::Schema3::Molecule)
  end
end
