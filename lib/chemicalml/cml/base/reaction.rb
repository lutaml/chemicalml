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
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :reactant_list, :reactantList
            attribute :product_list, :productList

                        attribute :spectator_list, :spectatorList
            attribute :condition_list, :conditionList
            attribute :metadata_lists, :metadataList, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root "reaction"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "type", to: :type
              map_attribute "state", to: :state
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_element "reactantList", to: :reactant_list
              map_element "productList", to: :product_list
            end
          end
        end
      end
    end
  end
end
