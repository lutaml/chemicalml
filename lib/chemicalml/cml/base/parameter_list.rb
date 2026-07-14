# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module ParameterList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::ParameterList
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :parameters, :parameter, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root "parameterList"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_element "parameter", to: :parameters
            end
          end
        end
      end
    end
  end
end
