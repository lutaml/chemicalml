# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Action
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Action
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :order, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root "action"
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
