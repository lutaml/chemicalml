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
            end
          end
        end
      end
    end
  end
end
