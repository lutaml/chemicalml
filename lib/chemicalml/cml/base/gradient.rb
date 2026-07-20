# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Gradient
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Gradient
            include Chemicalml::Cml::Base::CommonChildren

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :units, :string
            attribute :content, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root 'gradient'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_attribute 'units', to: :units
              map_content to: :content
            end
            key_value do
              map 'metadataList', to: :metadata_lists
              map 'label', to: :labels
              map 'name', to: :names
              map 'description', to: :descriptions
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'units', to: :units
            end
          end
        end
      end
    end
  end
end
