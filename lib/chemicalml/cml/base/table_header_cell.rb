# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module TableHeaderCell
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::TableHeaderCell

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :content, :string

            attribute :data_type, :string
            attribute :units, :string
            attribute :constant_to_s_i, :string
            attribute :multiplier_to_s_i, :string
            attribute :unit_type, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'tableHeaderCell'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_content to: :content
              map_attribute 'dataType', to: :data_type
              map_attribute 'units', to: :units
              map_attribute 'constantToSI', to: :constant_to_s_i
              map_attribute 'multiplierToSI', to: :multiplier_to_s_i
              map_attribute 'unitType', to: :unit_type
            end
            key_value do
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'dataType', to: :data_type
              map 'units', to: :units
              map 'constantToSI', to: :constant_to_s_i
              map 'multiplierToSI', to: :multiplier_to_s_i
              map 'unitType', to: :unit_type
            end
          end
        end
      end
    end
  end
end
