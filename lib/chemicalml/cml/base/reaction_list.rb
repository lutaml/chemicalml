# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module ReactionList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::ReactionList
            include Chemicalml::Cml::Base::CommonChildren

            attribute :reactions, :reaction, collection: true

            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :title, :string
            attribute :id, :string
            attribute :name, :string
            attribute :ref, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'reactionList'
              map_element 'reaction', to: :reactions
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_attribute 'title', to: :title
              map_attribute 'id', to: :id
              map_attribute 'name', to: :name
              map_attribute 'ref', to: :ref
            end
            key_value do
              map 'metadataList', to: :metadata_lists
              map 'label', to: :labels
              map 'name', to: :names
              map 'description', to: :descriptions
              map 'reaction', to: :reactions
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'title', to: :title
              map 'id', to: :id
              map 'name', to: :name
              map 'ref', to: :ref
            end
          end
        end
      end
    end
  end
end
