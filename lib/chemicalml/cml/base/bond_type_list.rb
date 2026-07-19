# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module BondTypeList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::BondTypeList
            include Chemicalml::Cml::Base::CommonChildren
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :bond_types, :bondType, collection: true

            attribute :ref, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "bondType", to: :bond_types
              root "bondTypeList"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "ref", to: :ref
            end
            key_value do
              map "metadataList", to: :metadata_lists
              map "label", to: :labels
              map "name", to: :names
              map "description", to: :descriptions
              map "bondType", to: :bond_types
              map "id", to: :id
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "ref", to: :ref
            end

          end
        end
      end
    end
  end
end