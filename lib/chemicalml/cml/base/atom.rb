# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Atom
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Atom
            include Chemicalml::Cml::Base::CommonChildren
            attribute :id, :string
            attribute :element_type, :string
            attribute :count, :string
            attribute :formal_charge, :string
            attribute :hydrogen_count, :string
            attribute :isotope, :string
            attribute :isotope_number, :string
            attribute :spin_multiplicity, :string
            attribute :title, :string
            attribute :x2, :string
            attribute :y2, :string
            attribute :x3, :string
            attribute :y3, :string
            attribute :z3, :string
            attribute :xFract, :string
            attribute :yFract, :string
            attribute :zFract, :string
            attribute :atom_parity, :atomParity
            attribute :atom_type, :atomType
            attribute :electrons, :electron, collection: true
            attribute :particles, :particle, collection: true
            attribute :arrays, :array, collection: true
            attribute :matrices, :matrix, collection: true
            attribute :scalars, :scalar, collection: true
            attribute :vectors3, :vector3, collection: true

            attribute :convention, :string
            attribute :dict_ref, :string
            attribute :ref, :string
            attribute :isotope_ref, :string
            attribute :isotope_list_ref, :string
            attribute :occupancy, :string
            attribute :role, :string
            attribute :space_group_multiplicity, :string
            attribute :point_group_multiplicity, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "atom"
              map_attribute "id", to: :id
              map_attribute "elementType", to: :element_type
              map_attribute "count", to: :count
              map_attribute "formalCharge", to: :formal_charge
              map_attribute "hydrogenCount", to: :hydrogen_count
              map_attribute "isotope", to: :isotope
              map_attribute "isotopeNumber", to: :isotope_number
              map_attribute "spinMultiplicity", to: :spin_multiplicity
              map_attribute "title", to: :title
              map_attribute "x2", to: :x2
              map_attribute "y2", to: :y2
              map_attribute "x3", to: :x3
              map_attribute "y3", to: :y3
              map_attribute "z3", to: :z3
              map_attribute "xFract", to: :xFract
              map_attribute "yFract", to: :yFract
              map_attribute "zFract", to: :zFract
              map_element "atomParity", to: :atom_parity
              map_element "atomType", to: :atom_type
              map_element "electron", to: :electrons
              map_element "particle", to: :particles
              map_element "array", to: :arrays
              map_element "matrix", to: :matrices
              map_element "scalar", to: :scalars
              map_element "vector3", to: :vectors3
              map_attribute "convention", to: :convention
              map_attribute "dictRef", to: :dict_ref
              map_attribute "ref", to: :ref
              map_attribute "isotopeRef", to: :isotope_ref
              map_attribute "isotopeListRef", to: :isotope_list_ref
              map_attribute "occupancy", to: :occupancy
              map_attribute "role", to: :role
              map_attribute "spaceGroupMultiplicity", to: :space_group_multiplicity
              map_attribute "pointGroupMultiplicity", to: :point_group_multiplicity
            end
            key_value do
              map "metadataList", to: :metadata_lists
              map "label", to: :labels
              map "name", to: :names
              map "description", to: :descriptions
              map "atomParity", to: :atom_parity
              map "atomType", to: :atom_type
              map "electron", to: :electrons
              map "particle", to: :particles
              map "array", to: :arrays
              map "matrix", to: :matrices
              map "scalar", to: :scalars
              map "vector3", to: :vectors3
              map "id", to: :id
              map "elementType", to: :element_type
              map "count", to: :count
              map "formalCharge", to: :formal_charge
              map "hydrogenCount", to: :hydrogen_count
              map "isotope", to: :isotope
              map "isotopeNumber", to: :isotope_number
              map "spinMultiplicity", to: :spin_multiplicity
              map "title", to: :title
              map "x2", to: :x2
              map "y2", to: :y2
              map "x3", to: :x3
              map "y3", to: :y3
              map "z3", to: :z3
              map "xFract", to: :xFract
              map "yFract", to: :yFract
              map "zFract", to: :zFract
              map "convention", to: :convention
              map "dictRef", to: :dict_ref
              map "ref", to: :ref
              map "isotopeRef", to: :isotope_ref
              map "isotopeListRef", to: :isotope_list_ref
              map "occupancy", to: :occupancy
              map "role", to: :role
              map "spaceGroupMultiplicity", to: :space_group_multiplicity
              map "pointGroupMultiplicity", to: :point_group_multiplicity
            end

          end
        end
      end
    end
  end
end