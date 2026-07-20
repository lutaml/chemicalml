# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module ReactionScheme
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::ReactionScheme
            include Chemicalml::Cml::Base::CommonChildren

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

            attribute :reaction_step_lists, :reactionStepList, collection: true
            attribute :reactions, :reaction, collection: true

            attribute :ref, :string
            attribute :reaction_role, :string
            attribute :reaction_type, :string
            attribute :state, :string
            attribute :reaction_format, :string
            attribute :type, :string
            attribute :reaction_schemes, :reactionScheme, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              map_element 'reactionStepList', to: :reaction_step_lists
              map_element 'reactionScheme', to: :reaction_schemes
              map_element 'reaction', to: :reactions
              root 'reactionScheme'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_attribute 'ref', to: :ref
              map_attribute 'reactionRole', to: :reaction_role
              map_attribute 'role', to: :reaction_role
              map_attribute 'reactionType', to: :reaction_type
              map_attribute 'type', to: :reaction_type
              map_attribute 'state', to: :state
              map_attribute 'reactionFormat', to: :reaction_format
              map_attribute 'format', to: :reaction_format
            end
            key_value do
              map 'metadataList', to: :metadata_lists
              map 'label', to: :labels
              map 'name', to: :names
              map 'description', to: :descriptions
              map 'reactionStepList', to: :reaction_step_lists
              map 'reactionScheme', to: :reaction_schemes
              map 'reaction', to: :reactions
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'ref', to: :ref
              map 'reactionRole', to: :reaction_role
              map 'role', to: :reaction_role
              map 'reactionType', to: :reaction_type
              map 'type', to: :reaction_type
              map 'state', to: :state
              map 'reactionFormat', to: :reaction_format
              map 'format', to: :reaction_format
            end
          end
        end
      end
    end
  end
end
