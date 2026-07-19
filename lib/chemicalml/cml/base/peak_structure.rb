# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module PeakStructure
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::PeakStructure
            include Chemicalml::Cml::Base::CommonChildren
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :peakShape, :string

            attribute :ref, :string
            attribute :peak_multiplicity, :string
            attribute :peak_structure_type, :string
            attribute :value, :string
            attribute :units, :string
            attribute :atom_refs, :string
            attribute :bond_refs, :string
            attribute :type, :string
            attribute :peak_structures, :peakStructure, collection: true

            xml do
              map_element "peakStructure", to: :peak_structures
              namespace Chemicalml::Cml::Namespace
              root "peakStructure"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "peakShape", to: :peakShape
              map_attribute "ref", to: :ref
              map_attribute "peakMultiplicity", to: :peak_multiplicity
              map_attribute "peakStructureType", to: :peak_structure_type
              map_attribute "value", to: :value
              map_attribute "units", to: :units
              map_attribute "atomRefs", to: :atom_refs
              map_attribute "bondRefs", to: :bond_refs
              map_attribute "type", to: :type
            end
            key_value do
              map "metadataList", to: :metadata_lists
              map "label", to: :labels
              map "name", to: :names
              map "description", to: :descriptions
              map "peakStructure", to: :peak_structures
              map "id", to: :id
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "peakShape", to: :peakShape
              map "ref", to: :ref
              map "peakMultiplicity", to: :peak_multiplicity
              map "peakStructureType", to: :peak_structure_type
              map "value", to: :value
              map "units", to: :units
              map "atomRefs", to: :atom_refs
              map "bondRefs", to: :bond_refs
              map "type", to: :type
            end

          end
        end
      end
    end
  end
end