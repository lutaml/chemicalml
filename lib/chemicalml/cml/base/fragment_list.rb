# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module FragmentList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::FragmentList
            include Chemicalml::Cml::Base::CommonChildren

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

            attribute :fragments, :fragment, collection: true

            attribute :ref, :string
            attribute :role, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              map_element 'fragment', to: :fragments
              root 'fragmentList'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_attribute 'ref', to: :ref
              map_attribute 'role', to: :role
            end
            key_value do
              map 'metadataList', to: :metadata_lists
              map 'label', to: :labels
              map 'name', to: :names
              map 'description', to: :descriptions
              map 'fragment', to: :fragments
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'ref', to: :ref
              map 'role', to: :role
            end
          end
        end
      end
    end
  end
end
