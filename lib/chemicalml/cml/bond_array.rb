# frozen_string_literal: true

require "lutaml/model"

module ChemicalML
  module Cml
    # CML `<bondArray>` element — container for `<bond>` children.
    class BondArray < Lutaml::Model::Serializable
      attribute :bonds, Bond, collection: true

      xml do
        root "bondArray"
        map_element "bond", to: :bonds
      end
    end
  end
end
