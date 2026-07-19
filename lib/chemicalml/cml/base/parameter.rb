# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Parameter
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Parameter
            include Chemicalml::Cml::Base::CommonChildren
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :scalar, :scalar
            attribute :array, :array
            attribute :matrix, :matrix

            attribute :ref, :string
            attribute :value, :string
            attribute :constraint, :string
            attribute :name, :string
            attribute :role, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "parameter"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_element "scalar", to: :scalar
              map_element "array", to: :array
              map_element "matrix", to: :matrix
              map_attribute "ref", to: :ref
              map_attribute "value", to: :value
              map_attribute "constraint", to: :constraint
              map_attribute "name", to: :name
              map_attribute "role", to: :role
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
              map "value", to: :value
              map "constraint", to: :constraint
              map "name", to: :name
              map "role", to: :role
            end

          end
        end
      end
    end
  end
end