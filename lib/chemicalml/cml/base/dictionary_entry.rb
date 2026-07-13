# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module DictionaryEntry
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::DictionaryEntry
            attribute :id, :string
            attribute :term, :string
            attribute :data_type, :string
            attribute :unit_type, :string
            attribute :units, :string
            attribute :definition, :string
            attribute :description, :string

            xml do
            namespace Chemicalml::Cml::Namespace
              root "entry"
              map_attribute "id", to: :id
              map_attribute "term", to: :term
              map_attribute "dataType", to: :data_type
              map_attribute "unitType", to: :unit_type
              map_attribute "units", to: :units
              map_element "definition", to: :definition
              map_element "description", to: :description
            end
          end
        end
      end
    end
  end
end
