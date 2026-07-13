# frozen_string_literal: true

require "lutaml/model"

module Chemml
  module Cml
    # CML `<bond>` element. `atom_refs2` is a space-separated pair of
    # atom IDs. `order` is one of `S` (single), `D` (double), `T`
    # (triple), `Q` (quadruple), `A` (aromatic), or a number.
    class Bond < Lutaml::Model::Serializable
      attribute :id, :string
      attribute :atom_refs2, :string
      attribute :order, :string
      attribute :title, :string

      xml do
        root "bond"
        map_attribute "id", to: :id
        map_attribute "atomRefs2", to: :atom_refs2
        map_attribute "order", to: :order
        map_attribute "title", to: :title
      end
    end
  end
end
