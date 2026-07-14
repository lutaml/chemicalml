# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Module
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Module
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :molecules, :molecule, collection: true
            attribute :modules, :module, collection: true
            attribute :parameter_lists, :parameterList, collection: true
            attribute :property_lists, :propertyList, collection: true
            attribute :metadata_lists, :metadataList, collection: true
            attribute :lists, :list, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root "module"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_element "molecule", to: :molecules
              map_element "module", to: :modules
              map_element "parameterList", to: :parameter_lists
              map_element "propertyList", to: :property_lists
              map_element "metadataList", to: :metadata_lists
              map_element "list", to: :lists
            end
          end
        end
      end
    end
  end
end
