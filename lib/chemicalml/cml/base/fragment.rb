# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Fragment
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Fragment
            include Chemicalml::Cml::Base::CommonChildren

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
              map_element 'molecule', to: :molecule
              map_element 'atomArray', to: :atom_array
              map_element 'bondArray', to: :bond_array
              root 'fragment'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_attribute 'ref', to: :ref
              map_attribute 'role', to: :role
              map_attribute 'countExpression', to: :count_expression
            end
            key_value do
              map 'metadataList', to: :metadata_lists
              map 'label', to: :labels
              map 'name', to: :names
              map 'description', to: :descriptions
              map 'molecule', to: :molecule
              map 'atomArray', to: :atom_array
              map 'bondArray', to: :bond_array
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'ref', to: :ref
              map 'role', to: :role
              map 'countExpression', to: :count_expression
            end
          end
        end
      end
    end
  end
end
