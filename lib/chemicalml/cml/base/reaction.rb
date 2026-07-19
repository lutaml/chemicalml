# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Reaction
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Reaction
            include Chemicalml::Cml::Base::CommonChildren
            attribute :id, :string
            attribute :title, :string
            attribute :type, :string
            attribute :state, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :reactant_list, :reactantList
            attribute :product_list, :productList
            attribute :spectator_list, :spectatorList
            attribute :substance_lists, :substanceList, collection: true
            attribute :condition_list, :conditionList
            attribute :identifiers, :identifier, collection: true
            attribute :objects, :object, collection: true
            attribute :property_lists, :propertyList, collection: true
            attribute :maps, :map, collection: true
            attribute :mechanisms, :mechanism, collection: true
            attribute :reactive_centres, :reactiveCentre, collection: true
            attribute :transition_states, :transitionState, collection: true

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
              map_element "spectatorList", to: :spectator_list
              map_element "substanceList", to: :substance_lists
              map_element "conditionList", to: :condition_list
              map_element "identifier", to: :identifiers
              map_element "object", to: :objects
              map_element "propertyList", to: :property_lists
              map_element "map", to: :maps
              map_element "mechanism", to: :mechanisms
              map_element "reactiveCentre", to: :reactive_centres
              map_element "transitionState", to: :transition_states
              map_attribute "reactionFormat", to: :reaction_format
              map_attribute "format", to: :reaction_format
              map_attribute "ref", to: :ref
              map_attribute "reactionRole", to: :reaction_role
              map_attribute "role", to: :reaction_role
              map_attribute "reactionType", to: :reaction_type
              map_attribute "atomMap", to: :atom_map
              map_attribute "electronMap", to: :electron_map
              map_attribute "bondMap", to: :bond_map
              map_attribute "yield", to: :yield
            end
            key_value do
              map "metadataList", to: :metadata_lists
              map "label", to: :labels
              map "name", to: :names
              map "description", to: :descriptions
              map "reactantList", to: :reactant_list
              map "productList", to: :product_list
              map "spectatorList", to: :spectator_list
              map "substanceList", to: :substance_lists
              map "conditionList", to: :condition_list
              map "identifier", to: :identifiers
              map "object", to: :objects
              map "propertyList", to: :property_lists
              map "map", to: :maps
              map "mechanism", to: :mechanisms
              map "reactiveCentre", to: :reactive_centres
              map "transitionState", to: :transition_states
              map "id", to: :id
              map "title", to: :title
              map "type", to: :type
              map "state", to: :state
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "reactionFormat", to: :reaction_format
              map "format", to: :reaction_format
              map "ref", to: :ref
              map "reactionRole", to: :reaction_role
              map "role", to: :reaction_role
              map "reactionType", to: :reaction_type
              map "atomMap", to: :atom_map
              map "electronMap", to: :electron_map
              map "bondMap", to: :bond_map
              map "yield", to: :yield
            end

          end
        end
      end
    end
  end
end