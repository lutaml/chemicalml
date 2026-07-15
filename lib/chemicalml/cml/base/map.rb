# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Map
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Map
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

            attribute :ref, :string
            attribute :from_type, :string
            attribute :to_type, :string
            attribute :from_context, :string
            attribute :to_context, :string
            attribute :role, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "map"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "ref", to: :ref
              map_attribute "fromType", to: :from_type
              map_attribute "toType", to: :to_type
              map_attribute "fromContext", to: :from_context
              map_attribute "toContext", to: :to_context
              map_attribute "role", to: :role
            end
          end
        end
      end
    end
  end
end
