# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Spectator
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Spectator
            include Chemicalml::Cml::Base::CommonChildren

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

            attribute :role, :string
            attribute :molecule, :molecule
            attribute :objects, :object, collection: true
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'spectator'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_attribute 'role', to: :role
              map_element 'molecule', to: :molecule
              map_element 'object', to: :objects
            end
            key_value do
              map 'metadataList', to: :metadata_lists
              map 'label', to: :labels
              map 'name', to: :names
              map 'description', to: :descriptions
              map 'molecule', to: :molecule
              map 'object', to: :objects
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'role', to: :role
            end
          end
        end
      end
    end
  end
end
