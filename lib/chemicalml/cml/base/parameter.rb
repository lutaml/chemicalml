# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Parameter
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Parameter
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :scalar, :scalar
            attribute :array, :array
            attribute :matrix, :matrix

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
            end
          end
        end
      end
    end
  end
end
