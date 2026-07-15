# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Alternative
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Alternative
            attribute :id, :string
            attribute :convention, :string
            attribute :alternative_type, :string
            attribute :content, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root "alternative"
              map_attribute "id", to: :id
              map_attribute "convention", to: :convention
              map_attribute "alternativeType", to: :alternative_type
              map_content to: :content
            end
          end
        end
      end
    end
  end
end
