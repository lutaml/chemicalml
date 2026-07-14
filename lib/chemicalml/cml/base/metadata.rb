# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Metadata
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Metadata
            attribute :id, :string
            attribute :name, :string
            attribute :content, :string
            attribute :convention, :string
            attribute :title, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root "metadata"
              map_attribute "id", to: :id
              map_attribute "name", to: :name
              map_attribute "content", to: :content
              map_attribute "convention", to: :convention
              map_attribute "title", to: :title
            end
          end
        end
      end
    end
  end
end
