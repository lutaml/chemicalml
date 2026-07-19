# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module System
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::System
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :atom_array, :atomArray
            attribute :molecules, :molecule, collection: true

            attribute :dimensionality, :string
            attribute :periodicity, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "atomArray", to: :atom_array
              map_element "molecule", to: :molecules
              root "system"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "dimensionality", to: :dimensionality
              map_attribute "periodicity", to: :periodicity
            end
            key_value do
              map "atomArray", to: :atom_array
              map "molecule", to: :molecules
              map "id", to: :id
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "dimensionality", to: :dimensionality
              map "periodicity", to: :periodicity
            end

          end
        end
      end
    end
  end
end