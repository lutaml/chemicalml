# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Crystal
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Crystal
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :scalars, :scalar, collection: true
            attribute :lattice, :lattice
            attribute :symmetry, :symmetry

            attribute :z, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "scalar", to: :scalars
              map_element "lattice", to: :lattice
              map_element "symmetry", to: :symmetry
              root "crystal"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "z", to: :z
            end
          end
        end
      end
    end
  end
end
