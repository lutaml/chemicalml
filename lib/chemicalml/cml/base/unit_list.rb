# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module UnitList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::UnitList
            attribute :title, :string
            attribute :namespace, :string
            attribute :convention, :string
            attribute :description, :string
            attribute :units, :unit, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root "unitList"
              map_attribute "title", to: :title
              map_attribute "namespace", to: :namespace
              map_attribute "convention", to: :convention
              map_element "description", to: :description
              map_element "unit", to: :units
            end
          end
        end
      end
    end
  end
end
