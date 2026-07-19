# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Peak
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Peak
            include Chemicalml::Cml::Base::CommonChildren
            attribute :atoms, :atom, collection: true
            attribute :bonds, :bond, collection: true
            attribute :molecules, :molecule, collection: true
            attribute :peak_structures, :peakStructure, collection: true
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :xValue, :string
            attribute :xUnits, :string
            attribute :xMultiplier, :string
            attribute :yValue, :string
            attribute :yUnits, :string
            attribute :yMultiplicity, :string

            attribute :ref, :string
            attribute :peak_height, :string
            attribute :peak_multiplicity, :string
            attribute :peak_shape, :string
            attribute :integral, :string
            attribute :peak_units, :string
            attribute :x_min, :string
            attribute :x_max, :string
            attribute :x_width, :string
            attribute :y_min, :string
            attribute :y_max, :string
            attribute :y_width, :string
            attribute :atom_refs, :string
            attribute :bond_refs, :string
            attribute :molecule_refs, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "peak"
              map_element "atom", to: :atoms
              map_element "bond", to: :bonds
              map_element "molecule", to: :molecules
              map_element "peakStructure", to: :peak_structures
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "xValue", to: :xValue
              map_attribute "xUnits", to: :xUnits
              map_attribute "xMultiplier", to: :xMultiplier
              map_attribute "yValue", to: :yValue
              map_attribute "yUnits", to: :yUnits
              map_attribute "yMultiplicity", to: :yMultiplicity
              map_attribute "ref", to: :ref
              map_attribute "peakHeight", to: :peak_height
              map_attribute "peakMultiplicity", to: :peak_multiplicity
              map_attribute "peakShape", to: :peak_shape
              map_attribute "integral", to: :integral
              map_attribute "peakUnits", to: :peak_units
              map_attribute "xMin", to: :x_min
              map_attribute "xMax", to: :x_max
              map_attribute "xWidth", to: :x_width
              map_attribute "yMin", to: :y_min
              map_attribute "yMax", to: :y_max
              map_attribute "yWidth", to: :y_width
              map_attribute "atomRefs", to: :atom_refs
              map_attribute "bondRefs", to: :bond_refs
              map_attribute "moleculeRefs", to: :molecule_refs
            end
            key_value do
              map "metadataList", to: :metadata_lists
              map "label", to: :labels
              map "name", to: :names
              map "description", to: :descriptions
              map "atom", to: :atoms
              map "bond", to: :bonds
              map "molecule", to: :molecules
              map "peakStructure", to: :peak_structures
              map "id", to: :id
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "xValue", to: :xValue
              map "xUnits", to: :xUnits
              map "xMultiplier", to: :xMultiplier
              map "yValue", to: :yValue
              map "yUnits", to: :yUnits
              map "yMultiplicity", to: :yMultiplicity
              map "ref", to: :ref
              map "peakHeight", to: :peak_height
              map "peakMultiplicity", to: :peak_multiplicity
              map "peakShape", to: :peak_shape
              map "integral", to: :integral
              map "peakUnits", to: :peak_units
              map "xMin", to: :x_min
              map "xMax", to: :x_max
              map "xWidth", to: :x_width
              map "yMin", to: :y_min
              map "yMax", to: :y_max
              map "yWidth", to: :y_width
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