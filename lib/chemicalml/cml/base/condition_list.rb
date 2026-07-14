# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module ConditionList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::ConditionList
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :scalars, :scalar, collection: true
            attribute :metadata, :metadata

            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "scalar", to: :scalars
              map_element "metadata", to: :metadata
              root "conditionList"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
            end
          end
        end
      end
    end
  end
end
