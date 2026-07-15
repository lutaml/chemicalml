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
          end
        end
      end
    end
  end
end
