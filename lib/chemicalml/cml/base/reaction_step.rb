# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module ReactionStep
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::ReactionStep
            include Chemicalml::Cml::Base::CommonChildren
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :reaction, :reaction
            attribute :reactant_list, :reactantList
            attribute :product_list, :productList

            attribute :ref, :string
            attribute :yield, :string
            attribute :ratio, :string
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
              map_attribute "ref", to: :ref
              map_attribute "yield", to: :yield
              map_attribute "ratio", to: :ratio
            end
            key_value do
              map "metadataList", to: :metadata_lists
              map "label", to: :labels
              map "name", to: :names
              map "description", to: :descriptions
              map "reaction", to: :reaction
              map "reactantList", to: :reactant_list
              map "productList", to: :product_list
              map "id", to: :id
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "ref", to: :ref
              map "yield", to: :yield
              map "ratio", to: :ratio
            end

          end
        end
      end
    end
  end
end