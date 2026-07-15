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

            attribute :start, :string
            attribute :start_condition, :string
            attribute :duration, :string
            attribute :end, :string
            attribute :end_condition, :string
            attribute :units, :string
            attribute :count, :string
            attribute :type, :string
            attribute :action_order, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "action", to: :actions
              root "actionList"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "order", to: :order
              map_attribute "start", to: :start
              map_attribute "startCondition", to: :start_condition
              map_attribute "duration", to: :duration
              map_attribute "end", to: :end
              map_attribute "endCondition", to: :end_condition
              map_attribute "units", to: :units
              map_attribute "count", to: :count
              map_attribute "type", to: :type
              map_attribute "actionOrder", to: :action_order
            end
          end
        end
      end
    end
  end
end
