# frozen_string_literal: true

require "lutaml/model"

module ChemicalML
  module Cml
    # CML `<reactantList>` element. Container for `<reactant>` children.
    class ReactantList < Lutaml::Model::Serializable
      attribute :reactants, Reactant, collection: true

      xml do
        root "reactantList"
        map_element "reactant", to: :reactants
      end
    end
  end
end
