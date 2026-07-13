# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Document
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Document
            attribute :molecules, :molecule, collection: true
            attribute :reaction_lists, :reactionList, collection: true
            attribute :reactions, :reaction, collection: true

            xml do
            namespace Chemicalml::Cml::Namespace
              root "cml"
              map_element "molecule", to: :molecules
              map_element "reactionList", to: :reaction_lists
              map_element "reaction", to: :reactions
            end
          end
        end
      end
    end
  end
end
