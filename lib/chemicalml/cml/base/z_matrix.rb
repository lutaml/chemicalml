# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module ZMatrix
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::ZMatrix
            include Chemicalml::Cml::Base::CommonChildren

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :content, :string
            attribute :angles, :angle, collection: true
            attribute :lengths, :length, collection: true
            attribute :torsions, :torsion, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root 'zMatrix'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_content to: :content
              map_element 'angle', to: :angles
              map_element 'length', to: :lengths
              map_element 'torsion', to: :torsions
            end
            key_value do
              map 'metadataList', to: :metadata_lists
              map 'label', to: :labels
              map 'name', to: :names
              map 'description', to: :descriptions
              map 'angle', to: :angles
              map 'length', to: :lengths
              map 'torsion', to: :torsions
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
            end
          end
        end
      end
    end
  end
end
