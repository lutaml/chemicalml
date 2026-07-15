# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Isotope
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Isotope
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :number, :string
            attribute :elementType, :string
            attribute :spinMultiplicity, :string

            attribute :ref, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "isotope"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "number", to: :number
              map_attribute "elementType", to: :elementType
              map_attribute "spinMultiplicity", to: :spinMultiplicity
              map_attribute "ref", to: :ref
            end
          end
        end
      end
    end
  end
end
