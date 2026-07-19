# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Substance
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Substance
            include Chemicalml::Cml::Base::CommonChildren
            attribute :title, :string
            attribute :role, :string
            attribute :id, :string
            attribute :molecule, :molecule
            attribute :amounts, :amount, collection: true
            attribute :properties, :property, collection: true

            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :type, :string
            attribute :ref, :string
            attribute :count, :string
            attribute :state, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "substance"
              map_attribute "title", to: :title
              map_attribute "role", to: :role
              map_attribute "id", to: :id
              map_element "molecule", to: :molecule
              map_element "amount", to: :amounts
              map_element "property", to: :properties
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "type", to: :type
              map_attribute "ref", to: :ref
              map_attribute "count", to: :count
              map_attribute "state", to: :state
            end
            key_value do
              map "metadataList", to: :metadata_lists
              map "label", to: :labels
              map "name", to: :names
              map "description", to: :descriptions
              map "molecule", to: :molecule
              map "amount", to: :amounts
              map "property", to: :properties
              map "title", to: :title
              map "role", to: :role
              map "id", to: :id
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "type", to: :type
              map "ref", to: :ref
              map "count", to: :count
              map "state", to: :state
            end

          end
        end
      end
    end
  end
end