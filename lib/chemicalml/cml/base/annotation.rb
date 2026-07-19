# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Annotation
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Annotation
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :documentation, :documentation

            xml do
              namespace Chemicalml::Cml::Namespace
              root "annotation"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_element "documentation", to: :documentation
            end
            key_value do
              map "documentation", to: :documentation
              map "id", to: :id
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
            end

          end
        end
      end
    end
  end
end