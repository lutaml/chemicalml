# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module List
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::List
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :scalars, :scalar, collection: true
            attribute :arrays, :array, collection: true
            attribute :matrices, :matrix, collection: true
            attribute :lists, :list, collection: true

            attribute :type, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "list"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_element "scalar", to: :scalars
              map_element "array", to: :arrays
              map_element "matrix", to: :matrices
              map_element "list", to: :lists
              map_attribute "type", to: :type
            end
          end
        end
      end
    end
  end
end
