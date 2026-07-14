# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Substance
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Substance
            attribute :title, :string
            attribute :role, :string
            attribute :molecule, :molecule
            attribute :names, :name, collection: true
            attribute :identifiers, :identifier, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root "substance"
              map_attribute "title", to: :title
              map_attribute "role", to: :role
              map_element "molecule", to: :molecule
              map_element "name", to: :names
              map_element "identifier", to: :identifiers
            end
          end
        end
      end
    end
  end
end
