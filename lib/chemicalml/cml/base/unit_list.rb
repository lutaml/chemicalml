# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module UnitList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::UnitList
            include Chemicalml::Cml::Base::CommonChildren

            attribute :title, :string
            attribute :namespace, :string
            attribute :convention, :string
            attribute :description, :string
            attribute :units, :unit, collection: true

            attribute :id, :string
            attribute :dict_ref, :string
            attribute :si_namespace, :string
            attribute :dictionary_prefix, :string
            attribute :href, :string
            attribute :unit_list_type, :string
            attribute :type, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'unitList'
              map_attribute 'title', to: :title
              map_attribute 'namespace', to: :namespace
              map_attribute 'convention', to: :convention
              map_element 'description', to: :description
              map_element 'unit', to: :units
              map_attribute 'id', to: :id
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'siNamespace', to: :si_namespace
              map_attribute 'dictionaryPrefix', to: :dictionary_prefix
              map_attribute 'href', to: :href
              map_attribute 'unitListType', to: :unit_list_type
              map_attribute 'type', to: :type
            end
            key_value do
              map 'metadataList', to: :metadata_lists
              map 'label', to: :labels
              map 'name', to: :names
              map 'description', to: :descriptions
              map 'description', to: :description
              map 'unit', to: :units
              map 'title', to: :title
              map 'namespace', to: :namespace
              map 'convention', to: :convention
              map 'id', to: :id
              map 'dictRef', to: :dict_ref
              map 'siNamespace', to: :si_namespace
              map 'dictionaryPrefix', to: :dictionary_prefix
              map 'href', to: :href
              map 'unitListType', to: :unit_list_type
              map 'type', to: :type
            end
          end
        end
      end
    end
  end
end
