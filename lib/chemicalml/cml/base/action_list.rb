# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module ActionList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::ActionList
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :order, :string

                        attribute :actions, :action, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "action", to: :actions
              root "actionList"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "order", to: :order
            end
          end
        end
      end
    end
  end
end
