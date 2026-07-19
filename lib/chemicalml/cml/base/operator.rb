# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Operator
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Operator
            attribute :title, :string
            attribute :id, :string
            attribute :convention, :string
            attribute :dict_ref, :string
            attribute :type, :string
            attribute :content, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root "operator"
              map_attribute "title", to: :title
              map_attribute "id", to: :id
              map_attribute "convention", to: :convention
              map_attribute "dictRef", to: :dict_ref
              map_attribute "type", to: :type
              map_content to: :content
            end
            key_value do
              map "title", to: :title
              map "id", to: :id
              map "convention", to: :convention
              map "dictRef", to: :dict_ref
              map "type", to: :type
            end

          end
        end
      end
    end
  end
end