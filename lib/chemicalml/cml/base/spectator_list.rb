# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module SpectatorList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::SpectatorList
            include Chemicalml::Cml::Base::CommonChildren

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

            attribute :spectators, :spectator, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              map_element 'spectator', to: :spectators
              root 'spectatorList'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
            end
            key_value do
              map 'metadataList', to: :metadata_lists
              map 'label', to: :labels
              map 'name', to: :names
              map 'description', to: :descriptions
              map 'spectator', to: :spectators
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
            end
          end
        end
      end
    end
  end
end
