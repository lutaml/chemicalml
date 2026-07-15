# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module ReactionList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::ReactionList
            attribute :reactions, :reaction, collection: true

            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :title, :string
            attribute :id, :string
            attribute :name, :string
            attribute :ref, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "reactionList"
              map_element "reaction", to: :reactions
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "title", to: :title
              map_attribute "id", to: :id
              map_attribute "name", to: :name
              map_attribute "ref", to: :ref
            end
          end
        end
      end
    end
  end
end
