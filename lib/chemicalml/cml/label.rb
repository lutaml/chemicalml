# frozen_string_literal: true

# Backward-compatible alias. New code should reference the versioned
# class directly: Chemicalml::Cml::Schema3::Label.
module Chemicalml
  module Cml
    remove_const(:Label) if const_defined?(:Label, false)
    const_set(:Label, Chemicalml::Cml::Schema3::Label)
  end
end
