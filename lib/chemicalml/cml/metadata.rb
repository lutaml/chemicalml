# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::Metadata.
module Chemicalml
  module Cml
    remove_const(:Metadata) if const_defined?(:Metadata, false)
    const_set(:Metadata, Chemicalml::Cml::Schema3::Metadata)
  end
end
