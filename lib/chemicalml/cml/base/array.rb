# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Array
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Array

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :data_type, :string
            attribute :units, :string
            attribute :size, :string
            attribute :delimiter, :string
            attribute :content, :string

            attribute :convention, :string
            attribute :error_value_array, :string
            attribute :error_basis, :string
            attribute :min_value_array, :string
            attribute :max_value_array, :string
            attribute :start, :string
            attribute :end, :string
            attribute :ref, :string
            attribute :constant_to_s_i, :string
            attribute :multiplier_to_s_i, :string
            attribute :unit_type, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'array'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'dataType', to: :data_type
              map_attribute 'units', to: :units
              map_attribute 'size', to: :size
              map_attribute 'delimiter', to: :delimiter
              map_content to: :content
              map_attribute 'convention', to: :convention
              map_attribute 'errorValueArray', to: :error_value_array
              map_attribute 'errorBasis', to: :error_basis
              map_attribute 'minValueArray', to: :min_value_array
              map_attribute 'maxValueArray', to: :max_value_array
              map_attribute 'start', to: :start
              map_attribute 'end', to: :end
              map_attribute 'ref', to: :ref
              map_attribute 'constantToSI', to: :constant_to_s_i
              map_attribute 'multiplierToSI', to: :multiplier_to_s_i
              map_attribute 'unitType', to: :unit_type
            end
            key_value do
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'dataType', to: :data_type
              map 'units', to: :units
              map 'size', to: :size
              map 'delimiter', to: :delimiter
              map 'convention', to: :convention
              map 'errorValueArray', to: :error_value_array
              map 'errorBasis', to: :error_basis
              map 'minValueArray', to: :min_value_array
              map 'maxValueArray', to: :max_value_array
              map 'start', to: :start
              map 'end', to: :end
              map 'ref', to: :ref
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
