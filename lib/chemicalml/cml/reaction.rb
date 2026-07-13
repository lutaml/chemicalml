# frozen_string_literal: true

require "lutaml/model"

module ChemicalML
  module Cml
    # CML `<reaction>` element. Contains a `<reactantList>`, a
    # `<productList>`, and (optionally) a `<spectatorList>` and
    # reaction-condition metadata.
    #
    # The `title` attribute is the conventional place for the
    # reaction arrow kind (e.g. "equilibrium", "forward") when
    # CML doesn't otherwise express it.
    class Reaction < Lutaml::Model::Serializable
      attribute :id, :string
      attribute :title, :string
      attribute :type, :string
      attribute :state, :string
      attribute :reactant_list, ReactantList
      attribute :product_list, ProductList

      xml do
        root "reaction"
        map_attribute "id", to: :id
        map_attribute "title", to: :title
        map_attribute "type", to: :type
        map_attribute "state", to: :state
        map_element "reactantList", to: :reactant_list
        map_element "productList", to: :product_list
      end
    end
  end
end
