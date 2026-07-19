# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module StringArray
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::StringArray
            attribute :builtin, :string
            attribute :convention, :string
            attribute :dict_ref, :string
            attribute :id, :string
            attribute :title, :string
            attribute :min, :string
            attribute :max, :string
            attribute :size, :string
            attribute :delimiter, :string
            attribute :content, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root "stringArray"
              map_attribute "builtin", to: :builtin
              map_attribute "convention", to: :convention
              map_attribute "dictRef", to: :dict_ref
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "min", to: :min
              map_attribute "max", to: :max
              map_attribute "size", to: :size
              map_attribute "delimiter", to: :delimiter
              map_content to: :content
            end
            key_value do
              map "builtin", to: :builtin
              map "convention", to: :convention
              map "dictRef", to: :dict_ref
              map "id", to: :id
              map "title", to: :title
              map "min", to: :min
              map "max", to: :max
              map "size", to: :size
              map "delimiter", to: :delimiter
            end

          end
        end
      end
    end
  end
end