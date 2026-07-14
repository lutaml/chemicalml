# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Gradient
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Gradient
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :units, :string
            attribute :content, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root "gradient"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "units", to: :units
              map_content to: :content
            end
          end
        end
      end
    end
  end
end
