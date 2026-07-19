# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Isotope
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Isotope
            include Chemicalml::Cml::Base::CommonChildren
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :number, :string
            attribute :elementType, :string
            attribute :spinMultiplicity, :string
            attribute :spin, :string

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
              map_attribute "spin", to: :spin
              map_attribute "ref", to: :ref
            end
            key_value do
              map "metadataList", to: :metadata_lists
              map "label", to: :labels
              map "name", to: :names
              map "description", to: :descriptions
              map "id", to: :id
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "number", to: :number
              map "elementType", to: :elementType
              map "spinMultiplicity", to: :spinMultiplicity
              map "spin", to: :spin
              map "ref", to: :ref
            end

          end
        end
      end
    end
  end
end