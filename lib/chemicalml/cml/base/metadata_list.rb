# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module MetadataList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::MetadataList
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :metadata, :metadata, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root "metadataList"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_element "metadata", to: :metadata
            end
          end
        end
      end
    end
  end
end
