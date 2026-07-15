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

            attribute :reaction_format, :string
            attribute :ref, :string
            attribute :reaction_role, :string
            attribute :reaction_type, :string
            attribute :atom_map, :string
            attribute :electron_map, :string
            attribute :bond_map, :string
            attribute :yield, :string
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
              map_attribute "reactionFormat", to: :reaction_format
              map_attribute "ref", to: :ref
              map_attribute "reactionRole", to: :reaction_role
              map_attribute "reactionType", to: :reaction_type
              map_attribute "atomMap", to: :atom_map
              map_attribute "electronMap", to: :electron_map
              map_attribute "bondMap", to: :bond_map
              map_attribute "yield", to: :yield
            end
          end
        end
      end
    end
  end
end
