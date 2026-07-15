# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module ReactionScheme
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::ReactionScheme
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
            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "reactionStepList", to: :reaction_step_lists
              map_element "reaction", to: :reactions
              root "reactionScheme"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "ref", to: :ref
              map_attribute "reactionRole", to: :reaction_role
              map_attribute "reactionType", to: :reaction_type
              map_attribute "state", to: :state
              map_attribute "reactionFormat", to: :reaction_format
            end
          end
        end
      end
    end
  end
end
