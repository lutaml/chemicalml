# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module ReactiveCentre
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::ReactiveCentre
            include Chemicalml::Cml::Base::CommonChildren
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :atomRefs, :string
            attribute :atom_sets, :atomSet, collection: true
            attribute :atom_type_lists, :atomTypeList, collection: true
            attribute :bond_sets, :bondSet, collection: true
            attribute :bond_type_lists, :bondTypeList, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root "reactiveCentre"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "atomRefs", to: :atomRefs
              map_element "atomSet", to: :atom_sets
              map_element "atomTypeList", to: :atom_type_lists
              map_element "bondSet", to: :bond_sets
              map_element "bondTypeList", to: :bond_type_lists
            end
            key_value do
              map "metadataList", to: :metadata_lists
              map "label", to: :labels
              map "name", to: :names
              map "description", to: :descriptions
              map "atomSet", to: :atom_sets
              map "atomTypeList", to: :atom_type_lists
              map "bondSet", to: :bond_sets
              map "bondTypeList", to: :bond_type_lists
              map "id", to: :id
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "atomRefs", to: :atomRefs
            end

          end
        end
      end
    end
  end
end