# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module SpectatorList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::SpectatorList
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :spectators, :spectator, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "spectator", to: :spectators
              root "spectatorList"
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
