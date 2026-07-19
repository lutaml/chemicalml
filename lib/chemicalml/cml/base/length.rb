# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Length
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Length
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :atomRefs2, :string
            attribute :units, :string

            attribute :error_value, :string
            attribute :error_basis, :string
            attribute :min, :string
            attribute :max, :string
            attribute :ref, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "length"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "atomRefs2", to: :atomRefs2
              map_attribute "units", to: :units
              map_attribute "errorValue", to: :error_value
              map_attribute "errorBasis", to: :error_basis
              map_attribute "min", to: :min
              map_attribute "max", to: :max
              map_attribute "ref", to: :ref
            end
            key_value do
              map "id", to: :id
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "atomRefs2", to: :atomRefs2
              map "units", to: :units
              map "errorValue", to: :error_value
              map "errorBasis", to: :error_basis
              map "min", to: :min
              map "max", to: :max
              map "ref", to: :ref
            end

          end
        end
      end
    end
  end
end