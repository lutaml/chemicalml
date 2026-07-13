# frozen_string_literal: true

require "lutaml/model"

module Chemml
  module Cml
    # CML `<atomArray>` element — container for `<atom>` children.
    class AtomArray < Lutaml::Model::Serializable
      attribute :atoms, Atom, collection: true

      xml do
        root "atomArray"
        map_element "atom", to: :atoms
      end
    end
  end
end
