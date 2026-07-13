# frozen_string_literal: true

require "chemicalml/model/product"

module ChemicalML
  module Model
    class ProductList < Node
      attr_accessor :products

      def initialize(products: [])
        @products = products
      end

      def children
        products
      end

      def value_attributes
        { products: products }
      end
    end
  end
end
