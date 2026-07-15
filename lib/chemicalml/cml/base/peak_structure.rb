# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module PeakStructure
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::PeakStructure
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
            xml do
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
            end
          end
        end
      end
    end
  end
end
