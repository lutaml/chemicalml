# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Peak
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Peak
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :xValue, :string
            attribute :xUnits, :string
            attribute :xMultiplier, :string
            attribute :yValue, :string
            attribute :yUnits, :string
            attribute :yMultiplicity, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root "peak"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "xValue", to: :xValue
              map_attribute "xUnits", to: :xUnits
              map_attribute "xMultiplier", to: :xMultiplier
              map_attribute "yValue", to: :yValue
              map_attribute "yUnits", to: :yUnits
              map_attribute "yMultiplicity", to: :yMultiplicity
            end
          end
        end
      end
    end
  end
end
