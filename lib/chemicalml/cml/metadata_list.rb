# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::MetadataList.
module Chemicalml
  module Cml
    remove_const(:MetadataList) if const_defined?(:MetadataList, false)
    const_set(:MetadataList, Chemicalml::Cml::Schema3::MetadataList)
  end
end
