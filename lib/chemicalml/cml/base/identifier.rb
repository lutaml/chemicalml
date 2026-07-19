# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Identifier
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Identifier
            attribute :value, :string
            attribute :convention, :string
            attribute :dict_ref, :string

            attribute :version, :string
            attribute :title, :string
            attribute :id, :string
            attribute :tautomeric, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "identifier"
              map_attribute "value", to: :value
              map_attribute "convention", to: :convention
              map_attribute "dictRef", to: :dict_ref
              map_attribute "version", to: :version
              map_attribute "title", to: :title
              map_attribute "id", to: :id
              map_attribute "tautomeric", to: :tautomeric
            end
            key_value do
              map "value", to: :value
              map "convention", to: :convention
              map "dictRef", to: :dict_ref
              map "version", to: :version
              map "title", to: :title
              map "id", to: :id
              map "tautomeric", to: :tautomeric
            end

          end
        end
      end
    end
  end
end