# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Unit
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Unit
            include Chemicalml::Cml::Base::CommonChildren

            attribute :id, :string
            attribute :title, :string
            attribute :symbol, :string
            attribute :parent_si, :string
            attribute :multiplier_to_si, :string
            attribute :constant_to_si, :string
            attribute :unit_type, :string
            attribute :definition, :string
            attribute :description, :string

            attribute :units, :string
            attribute :name, :string
            attribute :is_s_i, :string
            attribute :multiplier_to_data, :string
            attribute :power, :string
            attribute :abbreviation, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'unit'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'symbol', to: :symbol
              map_attribute 'parentSI', to: :parent_si
              map_attribute 'multiplierToSI', to: :multiplier_to_si
              map_attribute 'constantToSI', to: :constant_to_si
              map_attribute 'unitType', to: :unit_type
              map_element 'definition', to: :definition
              map_element 'description', to: :description
              map_attribute 'units', to: :units
              map_attribute 'name', to: :name
              map_attribute 'isSI', to: :is_s_i
              map_attribute 'multiplierToData', to: :multiplier_to_data
              map_attribute 'power', to: :power
              map_attribute 'abbreviation', to: :abbreviation
            end
            key_value do
              map 'metadataList', to: :metadata_lists
              map 'label', to: :labels
              map 'name', to: :names
              map 'description', to: :descriptions
              map 'definition', to: :definition
              map 'description', to: :description
              map 'id', to: :id
              map 'title', to: :title
              map 'symbol', to: :symbol
              map 'parentSI', to: :parent_si
              map 'multiplierToSI', to: :multiplier_to_si
              map 'constantToSI', to: :constant_to_si
              map 'unitType', to: :unit_type
              map 'units', to: :units
              map 'name', to: :name
              map 'isSI', to: :is_s_i
              map 'multiplierToData', to: :multiplier_to_data
              map 'power', to: :power
              map 'abbreviation', to: :abbreviation
            end
          end
        end
      end
    end
  end
end
