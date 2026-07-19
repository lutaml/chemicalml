# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Property
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Property
            include Chemicalml::Cml::Base::CommonChildren
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :scalar, :scalar
            attribute :array, :array
            attribute :matrix, :matrix

            attribute :ref, :string
            attribute :role, :string
            attribute :state, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "property"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_element "scalar", to: :scalar
              map_element "array", to: :array
              map_element "matrix", to: :matrix
              map_attribute "ref", to: :ref
              map_attribute "role", to: :role
              map_attribute "state", to: :state
            end
            key_value do
              map "metadataList", to: :metadata_lists
              map "label", to: :labels
              map "name", to: :names
              map "description", to: :descriptions
              map "scalar", to: :scalar
              map "array", to: :array
              map "matrix", to: :matrix
              map "id", to: :id
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "ref", to: :ref
              map "role", to: :role
              map "state", to: :state
            end

          end
        end
      end
    end
  end
end