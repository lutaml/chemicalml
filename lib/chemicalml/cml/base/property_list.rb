# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module PropertyList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::PropertyList
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :properties, :property, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root "propertyList"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_element "property", to: :properties
            end
          end
        end
      end
    end
  end
end
