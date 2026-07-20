# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Yaxis
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Yaxis
            include Chemicalml::Cml::Base::CommonChildren

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :units, :string
            attribute :multiplier, :string

            attribute :ref, :string
            attribute :multiplier_to_data, :string
            attribute :constant_to_data, :string
            attribute :arrays, :array, collection: true
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'yaxis'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_attribute 'units', to: :units
              map_attribute 'multiplier', to: :multiplier
              map_attribute 'ref', to: :ref
              map_attribute 'multiplierToData', to: :multiplier_to_data
              map_attribute 'constantToData', to: :constant_to_data
              map_element 'array', to: :arrays
            end
            key_value do
              map 'metadataList', to: :metadata_lists
              map 'label', to: :labels
              map 'name', to: :names
              map 'description', to: :descriptions
              map 'array', to: :arrays
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'units', to: :units
              map 'multiplier', to: :multiplier
              map 'ref', to: :ref
              map 'multiplierToData', to: :multiplier_to_data
              map 'constantToData', to: :constant_to_data
            end
          end
        end
      end
    end
  end
end
