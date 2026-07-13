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
            attribute :names, :name, collection: true
            attribute :identifiers, :identifier, collection: true
            attribute :atom_array, :atomArray
            attribute :bond_array, :bondArray
            attribute :molecules, :molecule, collection: true

            xml do
            namespace Chemicalml::Cml::Namespace
              root "molecule"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "count", to: :count
              map_attribute "formalCharge", to: :formal_charge
              map_attribute "spinMultiplicity", to: :spin_multiplicity
              map_element "name", to: :names
              map_element "identifier", to: :identifiers
              map_element "atomArray", to: :atom_array
              map_element "bondArray", to: :bond_array
              map_element "molecule", to: :molecules
            end
          end
        end
      end
    end
  end
end
