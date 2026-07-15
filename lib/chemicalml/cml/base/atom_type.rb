# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module AtomType
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::AtomType
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :elementType, :string
            attribute :ref, :string

            attribute :name, :string
            attribute :atom_ref, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "atomType"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "elementType", to: :elementType
              map_attribute "ref", to: :ref
              map_attribute "name", to: :name
              map_attribute "atomRef", to: :atom_ref
            end
          end
        end
      end
    end
  end
end
