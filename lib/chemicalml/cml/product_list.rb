# frozen_string_literal: true

require "lutaml/model"

module ChemicalML
  module Cml
    # CML `<productList>` element. Container for `<product>` children.
    class ProductList < Lutaml::Model::Serializable
      attribute :products, Product, collection: true

      xml do
        root "productList"
        map_element "product", to: :products
      end
    end
  end
end
