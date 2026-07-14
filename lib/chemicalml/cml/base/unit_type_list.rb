# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module UnitTypeList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::UnitTypeList
            attribute :title, :string
            attribute :namespace, :string
            attribute :convention, :string
            attribute :description, :string
            attribute :unit_types, :unitType, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root "unitTypeList"
              map_attribute "title", to: :title
              map_attribute "namespace", to: :namespace
              map_attribute "convention", to: :convention
              map_element "description", to: :description
              map_element "unitType", to: :unit_types
            end
          end
        end
      end
    end
  end
end
