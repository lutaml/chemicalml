# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module CellParameter
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::CellParameter
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :cellType, :string
            attribute :parameterType, :string
            attribute :units, :string

            attribute :cell_parameter_type, :string
            attribute :cell_parameter_error, :string
            attribute :type, :string
            attribute :error, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "cellParameter"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "cellType", to: :cellType
              map_attribute "parameterType", to: :parameterType
              map_attribute "units", to: :units
              map_attribute "cellParameterType", to: :cell_parameter_type
              map_attribute "cellParameterError", to: :cell_parameter_error
              map_attribute "type", to: :type
              map_attribute "error", to: :error
            end
            key_value do
              map "id", to: :id
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "cellType", to: :cellType
              map "parameterType", to: :parameterType
              map "units", to: :units
              map "cellParameterType", to: :cell_parameter_type
              map "cellParameterError", to: :cell_parameter_error
              map "type", to: :type
              map "error", to: :error
            end

          end
        end
      end
    end
  end
end