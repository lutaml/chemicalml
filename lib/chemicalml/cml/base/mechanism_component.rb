# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module MechanismComponent
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::MechanismComponent
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :role, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root "mechanismComponent"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "role", to: :role
            end
            key_value do
              map "id", to: :id
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "role", to: :role
            end

          end
        end
      end
    end
  end
end