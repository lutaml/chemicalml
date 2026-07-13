# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::Product.
module Chemicalml
  module Cml
    remove_const(:Product) if const_defined?(:Product, false)
    const_set(:Product, Chemicalml::Cml::Schema3::Product)
  end
end
