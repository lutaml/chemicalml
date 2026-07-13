# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::AtomParity.
module Chemicalml
  module Cml
    remove_const(:AtomParity) if const_defined?(:AtomParity, false)
    const_set(:AtomParity, Chemicalml::Cml::Schema3::AtomParity)
  end
end
