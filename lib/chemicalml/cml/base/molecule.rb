# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Molecule
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Molecule
            include Chemicalml::Cml::Base::CommonChildren
            attribute :id, :string
            attribute :title, :string
            attribute :count, :string
            attribute :formal_charge, :string
            attribute :spin_multiplicity, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :chirality, :string
            attribute :formula, :string
            attribute :identifiers, :identifier, collection: true
            attribute :formulas, :formula, collection: true
            attribute :properties, :property, collection: true
            attribute :atom_array, :atomArray
            attribute :bond_array, :bondArray
            attribute :molecules, :molecule, collection: true
            attribute :crystal, :crystal
            attribute :spectra, :spectrum
            attribute :property_lists, :propertyList, collection: true
            attribute :electrons, :electron, collection: true
            attribute :angles, :angle, collection: true
            attribute :lengths, :length, collection: true
            attribute :torsions, :torsion, collection: true
            attribute :joins, :join, collection: true
            attribute :scalars, :scalar, collection: true
            attribute :arrays, :array, collection: true
            attribute :matrices, :matrix, collection: true
            attribute :lists, :list, collection: true
            attribute :symmetries, :symmetry, collection: true
            attribute :z_matrix, :zMatrix

            attribute :ref, :string
            attribute :idgen, :string
            attribute :process, :string
            attribute :symmetry_oriented, :string
            attribute :role, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "molecule"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "count", to: :count
              map_attribute "formalCharge", to: :formal_charge
              map_attribute "spinMultiplicity", to: :spin_multiplicity
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "chirality", to: :chirality
              map_attribute "formula", to: :formula
              map_element "identifier", to: :identifiers
              map_element "formula", to: :formulas
              map_element "property", to: :properties
              map_element "atomArray", to: :atom_array
              map_element "bondArray", to: :bond_array
              map_element "molecule", to: :molecules
              map_element "crystal", to: :crystal
              map_element "spectrum", to: :spectra
              map_element "propertyList", to: :property_lists
              map_element "electron", to: :electrons
              map_element "angle", to: :angles
              map_element "length", to: :lengths
              map_element "torsion", to: :torsions
              map_element "join", to: :joins
              map_element "scalar", to: :scalars
              map_element "array", to: :arrays
              map_element "matrix", to: :matrices
              map_element "list", to: :lists
              map_element "symmetry", to: :symmetries
              map_element "zMatrix", to: :z_matrix
              map_attribute "ref", to: :ref
              map_attribute "idgen", to: :idgen
              map_attribute "process", to: :process
              map_attribute "symmetryOriented", to: :symmetry_oriented
              map_attribute "role", to: :role
            end
            key_value do
              map "metadataList", to: :metadata_lists
              map "label", to: :labels
              map "name", to: :names
              map "description", to: :descriptions
              map "identifier", to: :identifiers
              map "formula", to: :formulas
              map "property", to: :properties
              map "atomArray", to: :atom_array
              map "bondArray", to: :bond_array
              map "molecule", to: :molecules
              map "crystal", to: :crystal
              map "spectrum", to: :spectra
              map "propertyList", to: :property_lists
              map "electron", to: :electrons
              map "angle", to: :angles
              map "length", to: :lengths
              map "torsion", to: :torsions
              map "join", to: :joins
              map "scalar", to: :scalars
              map "array", to: :arrays
              map "matrix", to: :matrices
              map "list", to: :lists
              map "symmetry", to: :symmetries
              map "zMatrix", to: :z_matrix
              map "id", to: :id
              map "title", to: :title
              map "count", to: :count
              map "formalCharge", to: :formal_charge
              map "spinMultiplicity", to: :spin_multiplicity
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "chirality", to: :chirality
              map "formula", to: :formula
              map "ref", to: :ref
              map "idgen", to: :idgen
              map "process", to: :process
              map "symmetryOriented", to: :symmetry_oriented
              map "role", to: :role
            end

          end
        end
      end
    end
  end
end