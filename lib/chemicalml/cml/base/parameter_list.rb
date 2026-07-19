# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module ParameterList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::ParameterList
            include Chemicalml::Cml::Base::CommonChildren
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :parameters, :parameter, collection: true

            attribute :convention, :string
            attribute :ref, :string
            attribute :role, :string
            attribute :parameter_lists, :parameterList, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root "parameterList"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_element "parameter", to: :parameters
              map_element "parameterList", to: :parameter_lists
              map_attribute "convention", to: :convention
              map_attribute "ref", to: :ref
              map_attribute "role", to: :role
            end
            key_value do
              map "metadataList", to: :metadata_lists
              map "label", to: :labels
              map "name", to: :names
              map "description", to: :descriptions
              map "parameter", to: :parameters
              map "parameterList", to: :parameter_lists
              map "id", to: :id
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "ref", to: :ref
              map "role", to: :role
            end

          end
        end
      end
    end
  end
end