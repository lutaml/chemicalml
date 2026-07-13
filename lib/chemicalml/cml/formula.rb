# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::Formula.
module Chemicalml
  module Cml
    remove_const(:Formula) if const_defined?(:Formula, false)
    const_set(:Formula, Chemicalml::Cml::Schema3::Formula)
  end
end
