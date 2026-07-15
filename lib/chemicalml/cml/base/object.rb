# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Object
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Object
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :type, :string

            attribute :name, :string
            attribute :count, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "object"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "type", to: :type
              map_attribute "name", to: :name
              map_attribute "count", to: :count
            end
          end
        end
      end
    end
  end
end
