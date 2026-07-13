# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::Document.
module Chemicalml
  module Cml
    remove_const(:Document) if const_defined?(:Document, false)
    const_set(:Document, Chemicalml::Cml::Schema3::Document)
  end
end
