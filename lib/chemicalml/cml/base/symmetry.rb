# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Symmetry
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Symmetry
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :pointGroup, :string
            attribute :spaceGroup, :string

            attribute :irreducible_representation, :string
            attribute :number, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "symmetry"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "pointGroup", to: :pointGroup
              map_attribute "spaceGroup", to: :spaceGroup
              map_attribute "irreducibleRepresentation", to: :irreducible_representation
              map_attribute "number", to: :number
            end
          end
        end
      end
    end
  end
end
