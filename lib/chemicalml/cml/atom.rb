# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::Atom.
module Chemicalml
  module Cml
    remove_const(:Atom) if const_defined?(:Atom, false)
    const_set(:Atom, Chemicalml::Cml::Schema3::Atom)
  end
end
