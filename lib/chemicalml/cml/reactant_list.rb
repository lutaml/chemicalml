# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::ReactantList.
module Chemicalml
  module Cml
    remove_const(:ReactantList) if const_defined?(:ReactantList, false)
    const_set(:ReactantList, Chemicalml::Cml::Schema3::ReactantList)
  end
end
