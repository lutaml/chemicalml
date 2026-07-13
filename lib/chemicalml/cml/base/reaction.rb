# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Reaction
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Reaction
            attribute :id, :string
            attribute :title, :string
            attribute :type, :string
            attribute :state, :string
            attribute :reactant_list, :reactantList
            attribute :product_list, :productList

            xml do
            namespace Chemicalml::Cml::Namespace
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
    end
  end
end
