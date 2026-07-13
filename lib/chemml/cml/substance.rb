# frozen_string_literal: true

require "lutaml/model"

module Chemml
  module Cml
    # CML `<substance>` element. A reaction participant wrapper that
    # contains a `<molecule>` (or a reference to one via `<identifier>`
    # / SMILES / InChI). Used inside `<reactant>` and `<product>`.
    class Substance < Lutaml::Model::Serializable
      attribute :title, :string
      attribute :role, :string
      attribute :molecule, Molecule
      attribute :names, Name, collection: true
      attribute :identifiers, Identifier, collection: true

      xml do
        root "substance"
        map_attribute "title", to: :title
        map_attribute "role", to: :role
        map_element "molecule", to: :molecule
        map_element "name", to: :names
        map_element "identifier", to: :identifiers
      end
    end
  end
end
