# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module ReactionStep
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::ReactionStep
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :reaction, :reaction
            attribute :reactant_list, :reactantList
            attribute :product_list, :productList

            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "reaction", to: :reaction
              map_element "reactantList", to: :reactant_list
              map_element "productList", to: :product_list
              root "reactionStep"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
            end
          end
        end
      end
    end
  end
end
