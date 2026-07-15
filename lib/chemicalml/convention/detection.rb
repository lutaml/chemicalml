# frozen_string_literal: true

module Chemicalml
  module Convention
    # Convention detection from a wire document. Reads the
    # `convention` attribute from the root element (Document, Module,
    # Molecule, Dictionary, UnitList, or UnitTypeList) and returns
    # the QName string (e.g. "convention:molecular").
    #
    # Used by `Registry.detect_and_validate` and reusable by callers
    # that want to know which convention a document declares without
    # running validation.
    module Detection
      CONVENTION_ROOTS = [
        Chemicalml::Cml::Role::Document,
        Chemicalml::Cml::Role::Module,
        Chemicalml::Cml::Role::Molecule,
        Chemicalml::Cml::Role::Dictionary,
        Chemicalml::Cml::Role::UnitList,
        Chemicalml::Cml::Role::UnitTypeList
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
