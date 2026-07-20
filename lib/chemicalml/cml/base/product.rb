# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Product
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Product
            include Chemicalml::Cml::Base::CommonChildren

            attribute :substance, :substance
            attribute :substance_lists, :substanceList, collection: true
            attribute :molecule, :molecule
            attribute :electrons, :electron, collection: true
            attribute :formula, :formula
            attribute :amounts, :amount, collection: true
            attribute :identifier, :identifier

            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :title, :string
            attribute :id, :string
            attribute :ref, :string
            attribute :role, :string
            attribute :count, :string
            attribute :state, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'product'
              map_element 'substance', to: :substance
              map_element 'substanceList', to: :substance_lists
              map_element 'molecule', to: :molecule
              map_element 'electron', to: :electrons
              map_element 'formula', to: :formula
              map_element 'amount', to: :amounts
              map_element 'identifier', to: :identifier
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_attribute 'title', to: :title
              map_attribute 'id', to: :id
              map_attribute 'ref', to: :ref
              map_attribute 'role', to: :role
              map_attribute 'count', to: :count
              map_attribute 'state', to: :state
            end
            key_value do
              map 'metadataList', to: :metadata_lists
              map 'label', to: :labels
              map 'name', to: :names
              map 'description', to: :descriptions
              map 'substance', to: :substance
              map 'substanceList', to: :substance_lists
              map 'molecule', to: :molecule
              map 'electron', to: :electrons
              map 'formula', to: :formula
              map 'amount', to: :amounts
              map 'identifier', to: :identifier
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'title', to: :title
              map 'id', to: :id
              map 'ref', to: :ref
              map 'role', to: :role
              map 'count', to: :count
              map 'state', to: :state
            end
          end
        end
      end
    end
  end
end
