# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module UnitType
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::UnitType
            attribute :id, :string
            attribute :name, :string
            attribute :definition, :string
            attribute :description, :string

            attribute :title, :string
            attribute :parent_s_i, :string
            attribute :abbreviation, :string
            attribute :preserve, :string
            attribute :symbol, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "unitType"
              map_attribute "id", to: :id
              map_attribute "name", to: :name
              map_element "definition", to: :definition
              map_element "description", to: :description
              map_attribute "title", to: :title
              map_attribute "parentSI", to: :parent_s_i
              map_attribute "abbreviation", to: :abbreviation
              map_attribute "preserve", to: :preserve
              map_attribute "symbol", to: :symbol
            end
          end
        end
      end
    end
  end
end
