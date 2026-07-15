# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Matrix
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Matrix
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :data_type, :string
            attribute :units, :string
            attribute :rows, :string
            attribute :columns, :string
            attribute :delimiter, :string
            attribute :content, :string

            attribute :convention, :string
            attribute :matrix_type, :string
            attribute :error_value_array, :string
            attribute :error_basis, :string
            attribute :min_value_array, :string
            attribute :max_value_array, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "matrix"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "dataType", to: :data_type
              map_attribute "units", to: :units
              map_attribute "rows", to: :rows
              map_attribute "columns", to: :columns
              map_attribute "delimiter", to: :delimiter
              map_content to: :content
              map_attribute "convention", to: :convention
              map_attribute "matrixType", to: :matrix_type
              map_attribute "errorValueArray", to: :error_value_array
              map_attribute "errorBasis", to: :error_basis
              map_attribute "minValueArray", to: :min_value_array
              map_attribute "maxValueArray", to: :max_value_array
            end
          end
        end
      end
    end
  end
end
