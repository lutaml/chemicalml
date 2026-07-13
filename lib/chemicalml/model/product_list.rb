# frozen_string_literal: true

module Chemicalml
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
