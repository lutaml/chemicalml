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

            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "reactionStepList", to: :reaction_step_lists
              map_element "reaction", to: :reactions
              root "reactionScheme"
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
