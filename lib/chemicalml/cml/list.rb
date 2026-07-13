# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::List.
module Chemicalml
  module Cml
    remove_const(:List) if const_defined?(:List, false)
    const_set(:List, Chemicalml::Cml::Schema3::List)
  end
end
