# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Molecule
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Molecule
            attribute :id, :string
            attribute :title, :string
            attribute :count, :string
            attribute :formal_charge, :string
            attribute :spin_multiplicity, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :chirality, :string
            attribute :names, :name, collection: true
            attribute :identifiers, :identifier, collection: true
            attribute :formulas, :formula, collection: true
            attribute :properties, :property, collection: true
            attribute :labels, :label, collection: true
            attribute :atom_array, :atomArray
            attribute :bond_array, :bondArray
            attribute :molecules, :molecule, collection: true

                        attribute :crystal, :crystal
            attribute :spectra, :spectrum
            attribute :property_lists, :propertyList, collection: true

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
              map_element "name", to: :names
              map_element "identifier", to: :identifiers
              map_element "formula", to: :formulas
              map_element "property", to: :properties
              map_element "label", to: :labels
              map_element "atomArray", to: :atom_array
              map_element "bondArray", to: :bond_array
              map_element "molecule", to: :molecules
              map_attribute "ref", to: :ref
              map_attribute "idgen", to: :idgen
              map_attribute "process", to: :process
              map_attribute "symmetryOriented", to: :symmetry_oriented
              map_attribute "role", to: :role
            end
          end
        end
      end
    end
  end
end
