# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Eigen
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Eigen
            include Chemicalml::Cml::Base::CommonChildren

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :units, :string
            attribute :type, :string
            attribute :content, :string

            attribute :eigen_orientation, :string
            attribute :orientation, :string
            attribute :arrays, :array, collection: true
            attribute :matrices, :matrix, collection: true
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'eigen'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_attribute 'units', to: :units
              map_attribute 'type', to: :type
              map_content to: :content
              map_attribute 'eigenOrientation', to: :eigen_orientation
              map_attribute 'orientation', to: :orientation
              map_element 'array', to: :arrays
              map_element 'matrix', to: :matrices
            end
            key_value do
              map 'metadataList', to: :metadata_lists
              map 'label', to: :labels
              map 'name', to: :names
              map 'description', to: :descriptions
              map 'array', to: :arrays
              map 'matrix', to: :matrices
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'units', to: :units
              map 'type', to: :type
              map 'eigenOrientation', to: :eigen_orientation
              map 'orientation', to: :orientation
            end
          end
        end
      end
    end
  end
end
