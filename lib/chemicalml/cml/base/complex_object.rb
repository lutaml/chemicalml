# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module ComplexObject
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::ComplexObject
            attribute :title, :string
            attribute :id, :string
            attribute :convention, :string
            attribute :dict_ref, :string
            attribute :content, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root "complexObject"
              map_attribute "title", to: :title
              map_attribute "id", to: :id
              map_attribute "convention", to: :convention
              map_attribute "dictRef", to: :dict_ref
              map_content to: :content
            end
            key_value do
              map "title", to: :title
              map "id", to: :id
              map "convention", to: :convention
              map "dictRef", to: :dict_ref
            end

          end
        end
      end
    end
  end
end