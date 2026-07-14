# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Unit
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Unit
            attribute :id, :string
            attribute :title, :string
            attribute :symbol, :string
            attribute :parent_si, :string
            attribute :multiplier_to_si, :string
            attribute :constant_to_si, :string
            attribute :unit_type, :string
            attribute :definition, :string
            attribute :description, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root "unit"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "symbol", to: :symbol
              map_attribute "parentSI", to: :parent_si
              map_attribute "multiplierToSI", to: :multiplier_to_si
              map_attribute "constantToSI", to: :constant_to_si
              map_attribute "unitType", to: :unit_type
              map_element "definition", to: :definition
              map_element "description", to: :description
            end
          end
        end
      end
    end
  end
end
