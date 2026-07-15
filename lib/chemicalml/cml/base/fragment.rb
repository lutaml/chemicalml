# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Fragment
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Fragment
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :molecule, :molecule
            attribute :atom_array, :atomArray
            attribute :bond_array, :bondArray

            attribute :ref, :string
            attribute :role, :string
            attribute :count_expression, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "molecule", to: :molecule
              map_element "atomArray", to: :atom_array
              map_element "bondArray", to: :bond_array
              root "fragment"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "ref", to: :ref
              map_attribute "role", to: :role
              map_attribute "countExpression", to: :count_expression
            end
          end
        end
      end
    end
  end
end
