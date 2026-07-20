# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module ProductList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::ProductList
            include Chemicalml::Cml::Base::CommonChildren

            attribute :products, :product, collection: true

            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :title, :string
            attribute :id, :string
            attribute :ref, :string
            attribute :role, :string
            attribute :count, :string
            attribute :product_lists, :productList, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root 'productList'
              map_element 'product', to: :products
              map_element 'productList', to: :product_lists
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_attribute 'title', to: :title
              map_attribute 'id', to: :id
              map_attribute 'ref', to: :ref
              map_attribute 'role', to: :role
              map_attribute 'count', to: :count
            end
            key_value do
              map 'metadataList', to: :metadata_lists
              map 'label', to: :labels
              map 'name', to: :names
              map 'description', to: :descriptions
              map 'product', to: :products
              map 'productList', to: :product_lists
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'title', to: :title
              map 'id', to: :id
              map 'ref', to: :ref
              map 'role', to: :role
              map 'count', to: :count
            end
          end
        end
      end
    end
  end
end
