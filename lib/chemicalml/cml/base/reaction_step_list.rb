# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module ReactionStepList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::ReactionStepList
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :reaction_steps, :reactionStep, collection: true

            attribute :ref, :string
            attribute :reaction_step_list_type, :string
            attribute :reaction_format, :string
            attribute :type, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "reactionStep", to: :reaction_steps
              root "reactionStepList"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "ref", to: :ref
              map_attribute "reactionStepListType", to: :reaction_step_list_type
              map_attribute "reactionFormat", to: :reaction_format
              map_attribute "type", to: :type
            end
          end
        end
      end
    end
  end
end
