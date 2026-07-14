# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module ProductList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::ProductList
            attribute :products, :product, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root "productList"
              map_element "product", to: :products
            end
          end
        end
      end
    end
  end
end
