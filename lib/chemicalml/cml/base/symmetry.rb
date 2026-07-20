# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Symmetry
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Symmetry
            include Chemicalml::Cml::Base::CommonChildren

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :pointGroup, :string
            attribute :spaceGroup, :string

            attribute :irreducible_representation, :string
            attribute :number, :string
            attribute :matrices, :matrix, collection: true
            attribute :transform3s, :transform3, collection: true
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'symmetry'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_attribute 'pointGroup', to: :pointGroup
              map_attribute 'spaceGroup', to: :spaceGroup
              map_attribute 'irreducibleRepresentation', to: :irreducible_representation
              map_attribute 'number', to: :number
              map_element 'matrix', to: :matrices
              map_element 'transform3', to: :transform3s
            end
            key_value do
              map 'metadataList', to: :metadata_lists
              map 'label', to: :labels
              map 'name', to: :names
              map 'description', to: :descriptions
              map 'matrix', to: :matrices
              map 'transform3', to: :transform3s
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'pointGroup', to: :pointGroup
              map 'spaceGroup', to: :spaceGroup
              map 'irreducibleRepresentation', to: :irreducible_representation
              map 'number', to: :number
            end
          end
        end
      end
    end
  end
end
