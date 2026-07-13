# frozen_string_literal: true

require "lutaml/model"

module ChemicalML
  module Cml
    # CML `<molecule>` element. Contains an `<atomArray>`, an
    # optional `<bondArray>`, optional `<name>` and `<identifier>`
    # children, and may itself contain nested `<molecule>` elements
    # for group/sub-structure representation.
    class Molecule < Lutaml::Model::Serializable
      attribute :id, :string
      attribute :title, :string
      attribute :count, :string
      attribute :formal_charge, :string
      attribute :spin_multiplicity, :string
      attribute :names, Name, collection: true
      attribute :identifiers, Identifier, collection: true
      attribute :atom_array, AtomArray
      attribute :bond_array, BondArray
      attribute :molecules, Molecule, collection: true

      xml do
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
