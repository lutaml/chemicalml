# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module ReactionList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::ReactionList
            attribute :reactions, :reaction, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root "reactionList"
              map_element "reaction", to: :reactions
            end
          end
        end
      end
    end
  end
end
