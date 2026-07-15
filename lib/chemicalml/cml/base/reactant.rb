# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Reactant
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Reactant
            attribute :substance, :substance

            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :title, :string
            attribute :id, :string
            attribute :ref, :string
            attribute :role, :string
            attribute :count, :string
            attribute :state, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "reactant"
              map_element "substance", to: :substance
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "title", to: :title
              map_attribute "id", to: :id
              map_attribute "ref", to: :ref
              map_attribute "role", to: :role
              map_attribute "count", to: :count
              map_attribute "state", to: :state
            end
          end
        end
      end
    end
  end
end
