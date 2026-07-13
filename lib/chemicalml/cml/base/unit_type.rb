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

            xml do
            namespace Chemicalml::Cml::Namespace
              root "unitType"
              map_attribute "id", to: :id
              map_attribute "name", to: :name
              map_element "definition", to: :definition
              map_element "description", to: :description
            end
          end
        end
      end
    end
  end
end
