# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module String
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::String
            attribute :builtin, :string
            attribute :convention, :string
            attribute :dict_ref, :string
            attribute :id, :string
            attribute :title, :string
            attribute :content, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root "string"
              map_attribute "builtin", to: :builtin
              map_attribute "convention", to: :convention
              map_attribute "dictRef", to: :dict_ref
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_content to: :content
            end
          end
        end
      end
    end
  end
end
