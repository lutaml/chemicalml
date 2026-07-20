# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Trow
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Trow
            include Chemicalml::Cml::Base::CommonChildren

            attribute :data_type, :string
            attribute :title, :string
            attribute :id, :string
            attribute :convention, :string
            attribute :dict_ref, :string
            attribute :content, :string
            attribute :tcells, :tcell, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root 'trow'
              map_attribute 'dataType', to: :data_type
              map_attribute 'title', to: :title
              map_attribute 'id', to: :id
              map_attribute 'convention', to: :convention
              map_attribute 'dictRef', to: :dict_ref
              map_content to: :content
              map_element 'tcell', to: :tcells
            end
            key_value do
              map 'metadataList', to: :metadata_lists
              map 'label', to: :labels
              map 'name', to: :names
              map 'description', to: :descriptions
              map 'tcell', to: :tcells
              map 'dataType', to: :data_type
              map 'title', to: :title
              map 'id', to: :id
              map 'convention', to: :convention
              map 'dictRef', to: :dict_ref
            end
          end
        end
      end
    end
  end
end
