# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module PeakGroup
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::PeakGroup
            include Chemicalml::Cml::Base::CommonChildren
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :peaks, :peak, collection: true

            attribute :ref, :string
            attribute :peak_height, :string
            attribute :peak_multiplicity, :string
            attribute :peak_shape, :string
            attribute :integral, :string
            attribute :peak_units, :string
            attribute :x_min, :string
            attribute :x_max, :string
            attribute :x_value, :string
            attribute :x_width, :string
            attribute :x_units, :string
            attribute :y_min, :string
            attribute :y_max, :string
            attribute :y_value, :string
            attribute :y_width, :string
            attribute :y_units, :string
            attribute :atom_refs, :string
            attribute :bond_refs, :string
            attribute :molecule_refs, :string
            attribute :peak_groups, :peakGroup, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "peak", to: :peaks
              map_element "peakGroup", to: :peak_groups
              root "peakGroup"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "ref", to: :ref
              map_attribute "peakHeight", to: :peak_height
              map_attribute "peakMultiplicity", to: :peak_multiplicity
              map_attribute "peakShape", to: :peak_shape
              map_attribute "integral", to: :integral
              map_attribute "peakUnits", to: :peak_units
              map_attribute "xMin", to: :x_min
              map_attribute "xMax", to: :x_max
              map_attribute "xValue", to: :x_value
              map_attribute "xWidth", to: :x_width
              map_attribute "xUnits", to: :x_units
              map_attribute "yMin", to: :y_min
              map_attribute "yMax", to: :y_max
              map_attribute "yValue", to: :y_value
              map_attribute "yWidth", to: :y_width
              map_attribute "yUnits", to: :y_units
              map_attribute "atomRefs", to: :atom_refs
              map_attribute "bondRefs", to: :bond_refs
              map_attribute "moleculeRefs", to: :molecule_refs
            end
            key_value do
              map "metadataList", to: :metadata_lists
              map "label", to: :labels
              map "name", to: :names
              map "description", to: :descriptions
              map "peak", to: :peaks
              map "peakGroup", to: :peak_groups
              map "id", to: :id
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "ref", to: :ref
              map "peakHeight", to: :peak_height
              map "peakMultiplicity", to: :peak_multiplicity
              map "peakShape", to: :peak_shape
              map "integral", to: :integral
              map "peakUnits", to: :peak_units
              map "xMin", to: :x_min
              map "xMax", to: :x_max
              map "xValue", to: :x_value
              map "xWidth", to: :x_width
              map "xUnits", to: :x_units
              map "yMin", to: :y_min
              map "yMax", to: :y_max
              map "yValue", to: :y_value
              map "yWidth", to: :y_width
              map "yUnits", to: :y_units
              map "atomRefs", to: :atom_refs
              map "bondRefs", to: :bond_refs
              map "moleculeRefs", to: :molecule_refs
            end

          end
        end
      end
    end
  end
end