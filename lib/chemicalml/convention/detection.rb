# frozen_string_literal: true

module Chemicalml
  module Convention
    # Convention detection from a wire document. Reads the
    # `convention` attribute from the root element and returns the
    # QName string (e.g. "convention:molecular").
    #
    # Used by `Registry.detect_and_validate` and reusable by callers
    # that want to know which convention a document declares without
    # running validation.
    module Detection
      # Wire roles that may carry a top-level convention attribute.
      # Adding a new convention whose root is a new element type =
      # adding one role here. OCP — no existing code changes.
      CONVENTION_ROOTS = [
        Chemicalml::Cml::Role::Document,
        Chemicalml::Cml::Role::Module,
        Chemicalml::Cml::Role::Molecule,
        Chemicalml::Cml::Role::Dictionary,
        Chemicalml::Cml::Role::UnitList,
        Chemicalml::Cml::Role::UnitTypeList,
        Chemicalml::Cml::Role::Spectrum,
        Chemicalml::Cml::Role::SpectrumList,
        Chemicalml::Cml::Role::ReactionScheme,
        Chemicalml::Cml::Role::ReactionList
      ].freeze

      def self.convention_of(document)
        CONVENTION_ROOTS.each do |role|
          next unless document.is_a?(role)

          return document.convention if document.convention
        end
        nil
      end
    end
  end
end
