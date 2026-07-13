# frozen_string_literal: true

require "lutaml/model"

module Chemml
  module Cml
    # CML `<product>` element. Wraps a `<substance>` on the right
    # side of a reaction arrow.
    class Product < Lutaml::Model::Serializable
      attribute :substance, Substance

      xml do
        root "product"
        map_element "substance", to: :substance
      end
    end
  end
end
