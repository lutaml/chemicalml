# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::ProductList.
module Chemicalml
  module Cml
    remove_const(:ProductList) if const_defined?(:ProductList, false)
    const_set(:ProductList, Chemicalml::Cml::Schema3::ProductList)
  end
end
