# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Metadata
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Metadata
            attribute :id, :string
            attribute :name, :string
            attribute :content, :string
            attribute :convention, :string
            attribute :title, :string

            attribute :dict_ref, :string
            attribute :metadata_type, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "metadata"
              map_attribute "id", to: :id
              map_attribute "name", to: :name
              map_attribute "content", to: :content
              map_attribute "convention", to: :convention
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "metadataType", to: :metadata_type
            end
            key_value do
              map "id", to: :id
              map "name", to: :name
              map "content", to: :content
              map "convention", to: :convention
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "metadataType", to: :metadata_type
            end

          end
        end
      end
    end
  end
end