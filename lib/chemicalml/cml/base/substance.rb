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

            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :type, :string
            attribute :ref, :string
            attribute :count, :string
            attribute :state, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "substance"
              map_attribute "title", to: :title
              map_attribute "role", to: :role
              map_element "molecule", to: :molecule
              map_element "name", to: :names
              map_element "identifier", to: :identifiers
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "type", to: :type
              map_attribute "ref", to: :ref
              map_attribute "count", to: :count
              map_attribute "state", to: :state
            end
          end
        end
      end
    end
  end
end
