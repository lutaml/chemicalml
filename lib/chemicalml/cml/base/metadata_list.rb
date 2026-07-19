# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module MetadataList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::MetadataList
            include Chemicalml::Cml::Base::CommonChildren
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :metadata, :metadata, collection: true

            attribute :convention, :string
            attribute :name, :string
            attribute :role, :string
            attribute :metadata_lists_inner, :metadataList, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root "metadataList"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_element "metadata", to: :metadata
              map_element "metadataList", to: :metadata_lists_inner
              map_attribute "convention", to: :convention
              map_attribute "name", to: :name
              map_attribute "role", to: :role
            end
            key_value do
              map "metadataList", to: :metadata_lists
              map "label", to: :labels
              map "name", to: :names
              map "description", to: :descriptions
              map "metadata", to: :metadata
              map "metadataList", to: :metadata_lists_inner
              map "id", to: :id
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "name", to: :name
              map "role", to: :role
            end

          end
        end
      end
    end
  end
end